Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B43B0586
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949826; cv=none; b=rdejfB5wSHCLu5GDJkE6CtC0VTOs8x6lgE2Y3fs6Klyo3sGNdm2cNVY7CXCED0Nk3U37glJsdz+EKnQ3DHG5Yc+eXQzinWSqdxH2X6TfX8zrMw2u3ObrNNTWazfB2Ktx1RQjFZUgm4rFg47Nl3tQ1Db7Mx9cvWLRc5qhw32/D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949826; c=relaxed/simple;
	bh=b8WHkNKtP8nsh142rlqWqm/iqonSquTlT6328QxAZhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKCrk/fpu1pg3Zlyq6qJ/lRQRS7OC/T1n4DDOrtxFa592lSyN8CrXkfduXqbK4Qr65H+1mQAJdRaY/3VsgZLEwcn7/IyctdmlVWORv9OCY0/CvfxJ2TeRqH2zEpKWmnexIg4MMTQ44XXQoJCGtqLewM/k8FgGw0Z1uCeYuPHToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/awu14Z; arc=none smtp.client-ip=95.215.58.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/awu14Z"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b8WHkNKtP8nsh142rlqWqm/iqonSquTlT6328QxAZhQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786949822; v=1; x=1787554622;
 b=o/awu14ZqrMAb+tnLRBti4wpG+kFfwANCB30qp3C75+4VFiPAAJCYojmMNYGlZ10Z4O8qp/u
 YsC3sp3VapzNffLFondAR8wV18uqsK1b0pb5BRExVnRSAdB5z70dp/ysUKtKCQceZYwl2O+ZqFs
 BkDJxVHPY8dB09RtSWQQU3MY=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.150)
	by smtp.migadu.com with ESMTPS id 0bb39fdd5650f227;
	Mon, 17 Aug 2026 06:56:52 +0000
X-Migadu-Flow: FLOW_OUT
Date: Mon, 17 Aug 2026 14:56:39 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aoKwp6gTtSrnzR2n@fedora>
References: <20260814-bond_overflow-v2-1-d3fe588ad167@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-bond_overflow-v2-1-d3fe588ad167@kylinos.cn>

Hi Jay,
On Fri, Aug 14, 2026 at 01:39:23PM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The TLB fields tx_bytes, load_history, load, and unbalanced_load are
> all u32, which can overflow when sustained throughput exceeds ~3.2
> Gbit/s over the 10-second rebalance interval. On modern high-speed
> NICs under heavy load this is easily reached, causing the gap
> calculation in compute_gap() to wrap and produce incorrect slave
> selection.
> 
> Widen these fields to s64 so the load arithmetic stays correct.
> This also lets compute_gap() naturally return negative values when a
> slave is oversubscribed, which the existing max-gap selection already
> handles.
> 
> Additionally, the NIC speed is left-shifted before being cast to s64.
> For speeds >= 4 Gbit/s (slave->speed >= 4096), the u32 shift
> (4096 << 20 = 0x100000000) overflows before the cast takes effect.
> Cast slave->speed to s64 before shifting so the arithmetic is
> performed in 64 bits throughout.
> 
> Also cast SPEED_UNKNOWN to 0; otherwise, it would be the largest speed
> after the shift.
> 
> Detected by AI code review.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
> Changes in v2:
> - update comment description, including AI-detected info.
> - fix tx_bytes/load type detected by sashiko
> - cast SPEED_UNKNOWN to 0 before shift, detected by sashiko
> - Link to v1: https://lore.kernel.org/r/20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn
> ---
>  drivers/net/bonding/bond_alb.c | 12 ++++++++++--
>  include/net/bond_alb.h         |  8 ++++----
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 839f7482dc18..052ab6beb661 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -6,6 +6,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
>  #include <linux/pkt_sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -160,8 +161,15 @@ static void tlb_deinitialize(struct bonding *bond)
>  
>  static long long compute_gap(struct slave *slave)
>  {
> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> +	s64 speed;
> +
> +	if (slave->speed == SPEED_UNKNOWN)
> +		speed = 0;
> +	else
> +		speed = (s64)slave->speed;
> +
> +	return (speed << 20) - /* Mbit/s -> bit/s */
> +	       (SLAVE_TLB_INFO(slave).load << 3); /* Byte/s -> bit/s */
>  }
>  
>  static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
> diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
> index e5945427f38d..4933a855a438 100644
> --- a/include/net/bond_alb.h
> +++ b/include/net/bond_alb.h
> @@ -57,12 +57,12 @@ struct tlb_client_info {
>  				 * packets to a Client that the Hash function
>  				 * gave this entry index.
>  				 */
> -	u32 tx_bytes;		/* Each Client accumulates the BytesTx that
> +	s64 tx_bytes;		/* Each Client accumulates the BytesTx that
>  				 * were transmitted to it, and after each
>  				 * CallBack the LoadHistory is divided
>  				 * by the balance interval
>  				 */
> -	u32 load_history;	/* This field contains the amount of Bytes
> +	s64 load_history;	/* This field contains the amount of Bytes
>  				 * that were transmitted to this client by
>  				 * the server on the previous balance
>  				 * interval in Bps.
> @@ -118,14 +118,14 @@ struct tlb_slave_info {
>  			 * are the entries that were assigned to use this
>  			 * slave for transmit.
>  			 */
> -	u32 load;	/* Each slave sums the loadHistory of all clients
> +	s64 load;	/* Each slave sums the loadHistory of all clients
>  			 * assigned to it
>  			 */
>  };
>  
>  struct alb_bond_info {
>  	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
> -	u32			unbalanced_load;
> +	s64			unbalanced_load;
>  	atomic_t		tx_rebalance_counter;
>  	int			lp_counter;
>  	/* -------- rlb parameters -------- */

Sashiko reported that on a 32-bit system, these s64 numbers' read/write
operations and division will tear. We need to use div_s64() for divisions
and may also need to convert the number to atomic64_t for read/write operations.

Do you know how bonding support works on a 32-bit system? Should we handle it?

Thanks
Hangbin
