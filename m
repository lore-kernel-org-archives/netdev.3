Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238610;
	b=gdhtVcwfzuiNo26/UMqiO8d4aWx4iWpoh5u2EODLcbqqf+jWtfDL2yQEzXdd8OutVAui
	 tRqFeQWVXXpRJFT9EIt4f/WjgjzP0OJf1QRo/DjjcIqKcNHWHEIFhf9nIZHhE2EMnGC5v
	 yMowVeLnWUVO+lS/N86NfbelXfNUDEeAbJsAGFFs859X74Sc/TmKHon87aCa+kC3z4iNQ
	 BkZ8hVLu40gqMWYfCNdb+QKKxgubYJqhQiNQo2+b5aERkTUGDX14/s0nSgGDBwqn2FBHt
	 2k4GNvmU2F+1K74RXKxOIjDWJcAtgG8iwQaKOgptsyzoJIyEJFSP0zl9T2sGpIlERKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238610;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sZZBpevcS9exsrSP43oxzD9Zj4JnPGWquROSBgpnzbg=;
	b=OPKkOA2FTzWbKdflaD1grNZD4YYW9eXrj2fUM+LPqr0LG/rBhIQu7uEQEQwQ5WKeEB/V
	 I3eWDdP9DNz2sxOZ8jvp01qyCoDm/z05ECDlEuytTjep7YMCCTz+eji8Ylt/17Ty7aTUa
	 M0SJrVj+MLX9JrCjeY2xZRg0AQDlrqGhYziaAQ4TjwoAqFA0mpzpIZpTsBbriVThyl6AL
	 DlUkVmjWqKmHfARGxiAoq2Wy2BiZBwICzHM8JW1i/Yo9XjgyJtLzY7Mj4U2R0J5YxDIyT
	 mf+fRECQx5PKRzor6+TTq1TS9j5nGFQffPAbFOGa+nmFBhSMy9RVoYwzgsUrl2BgShA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i2PpjwMG;
	arc=none smtp.remote-ip=95.215.58.41
Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8C606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i2PpjwMG
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wiwG9ToSHOr3fU9gexOdX6gsXe0wZeBMdWaLYbFvjxg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793238607; v=1; x=1793843407;
 b=i2PpjwMGANasD+VZYAYK94V7QCR7LRDLjAV2Q8SKpZP4qIOWs2Xm1vqSoUrz00vSqZXeL7k5
 bd/qb0C0CgD4IlH3+sifllXvYcsiuunjastTA/x4zVk6YP+HbVv7DB9nupQxCe7ouDUvB8HTizO
 re3P07ox+QfrAw4CWcd8HRM4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f4dc8f7a90c5f8c2;
	Thu, 29 Oct 2026 01:50:07 +0000
X-Mizu-Trace-ID: f4dc8f7a90c5f8c2
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 09:49:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Message-ID: <auKmQjdgtgZTTbmJ@fedora>
References: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028104758.299129-1-timur.stukan.linux@gmail.com>

Hi Timur,
On Wed, Oct 28, 2026 at 12:47:57PM +0200, Timur Stukan wrote:
> In bond_miimon_commit(), when a slave is proposed as BOND_LINK_UP but
> bond_update_speed_duplex() fails in bonding mode that needs speed/duplex
> (802.3ad, tlb, alb), the slave is set to BOND_LINK_DOWN directly. This
> bypasses bond_set_slave_link_state(), bond_miimon_link_change() and
> failover.
> 
> This is fine for slave that coming from BOND_LINK_BACK, which was never
> brought up and is not in use. But since commit 1899bb325149 ("bonding:
> fix state transition issue in link monitoring") the commit phase also
> handles BOND_LINK_FAIL -> BOND_LINK_UP which means a slave that is still
> in use and may be curr_active_slave.
> 
> If the link recovers within downdelay and goes down again before the
> commit phase reads speed/duplex, the slave is silently marked down while
> remaining the active slave in worst cases. In alb/tlb the bond MAC stays
> on the dead port, no failover happens and TLB/RLB state is not cleaned,
> so the bond stops passing traffic until that link comes back even though
> other slaves are up. A non-active slave is affected too, in alb, RLB
> clients assigned to it are not reassigned and become unreachable.
> 
> Reproduced in tlb and alb mode with miimon=100 and downdelay=10000 by
> flapping a slave within downdelay and dropping it again before commit
> (a longer delay was added between inspect and commit to make window
> wider and easier to test):
>   bond0: (slave enp0s3): link status down for interface, disabling it in 10000 ms
>   bond0: (slave enp0s3): link status up again after 3400 ms
>   bond0: (slave enp0s3): failed to get link speed/duplex
> 
> procfs then shows the active slave with "MII Status: down" and "Link
> Failure Count: 0", and all traffic is lost.
> 
> Fix this by not committing UP proposals in bond_mii_monitor(): UP is
> already committed by bond_miimon_commit() once speed/duplex are valid, so
> leaving it there means slave->link still holds the previous state at
> that point. When speed/duplex update fails for a slave coming from
> BOND_LINK_FAIL, take it through the regular down path, including
> failover. Slaves coming from BACK/DOWN keep the current behaviour.
> The down path is moved into bond_miimon_slave_down() so both callers share it.
> 
> After the fix:
>   bond0: (slave enp0s3): failed to get link speed/duplex
>   bond0: (slave enp0s3): link status definitely down, disabling slave
>   bond0: (slave enp0s4): making interface the new active one
> 
> Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
> Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
> ---
> 
> Notes:
>     Changes in v2:
>     - Drop link_prev_state. Instead, don't commit UP proposals in
>       bond_mii_monitor() and let bond_miimon_commit() commit them after the
>       speed/duplex check, so no extra state is needed (Jay)
>     - v1: https://lore.kernel.org/netdev/20261022103821.89552-1-timur.stukan.linux@gmail.com/
>     
>     Sashiko pointed out on v1 that the 802.3ad netdev notifier can set
>     BOND_LINK_FAIL on a slave that is already down, which then goes through
>     the full down path again. That is pre-existing and reproducible on an
>     unpatched net tree:
>     
>       ip link add bond0 type bond mode 802.3ad miimon 100 lacp_rate 1
>       ip link set enp0s3 down
>       ip link set enp0s4 down
>       ip link set enp0s3 master bond0
>       ip link set enp0s4 master bond0
>       ip link set enp0s3 up
>       ip link set enp0s4 up
>       ip link set bond0 up
>       (wait for LACP to settle)
>       ip link set enp0s3 down
>       ip link set enp0s3 up
>     
>     "link status definitely down" is logged twice and enp0s3 ends up with
>     "Link Failure Count: 2" instead of 1. I will send a separate fix for it.
> 
>  drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8..9bafcddbb453 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2779,6 +2779,27 @@ static void bond_miimon_link_change(struct bonding *bond,
>  	}
>  }
>  
> +static bool bond_miimon_slave_down(struct bonding *bond,
> +				   struct slave *slave)
> +{
> +	if (slave->link_failure_count < UINT_MAX)
> +		slave->link_failure_count++;
> +
> +	bond_set_slave_link_state(slave, BOND_LINK_DOWN,
> +				  BOND_SLAVE_NOTIFY_NOW);
> +
> +	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
> +	    BOND_MODE(bond) == BOND_MODE_8023AD)
> +		bond_set_slave_inactive_flags(slave,
> +					      BOND_SLAVE_NOTIFY_NOW);
> +
> +	slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
> +
> +	bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
> +
> +	return slave == rcu_access_pointer(bond->curr_active_slave);
> +}
> +
>  static void bond_miimon_commit(struct bonding *bond)
>  {
>  	struct slave *slave, *primary, *active;
> @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
>  			err = bond_update_speed_duplex(slave);
>  			netdev_unlock_ops(slave->dev);
>  			if (err && bond_needs_speed_duplex(bond)) {
> -				slave->link = BOND_LINK_DOWN;
>  				if (net_ratelimit())
>  					slave_warn(bond->dev, slave->dev,
>  						   "failed to get link speed/duplex\n");
> +				/* Coming from FAIL, the slave is still in
> +				 * use and may be curr_active_slave, so take
> +				 * it through the full down path. Coming from
> +				 * DOWN/BACK, it was never brought up, so just
> +				 * revert it to DOWN.
> +				 */
> +				if (slave->link == BOND_LINK_FAIL) {
> +					if (bond_miimon_slave_down(bond, slave))
> +						do_failover = true;
> +					continue;
> +				}
> +				slave->link = BOND_LINK_DOWN;
>  				continue;
>  			}
>  			bond_set_slave_link_state(slave, BOND_LINK_UP,
> @@ -2839,24 +2871,8 @@ static void bond_miimon_commit(struct bonding *bond)
>  			continue;
>  
>  		case BOND_LINK_DOWN:
> -			if (slave->link_failure_count < UINT_MAX)
> -				slave->link_failure_count++;
> -
> -			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
> -						  BOND_SLAVE_NOTIFY_NOW);
> -
> -			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
> -			    BOND_MODE(bond) == BOND_MODE_8023AD)
> -				bond_set_slave_inactive_flags(slave,
> -							      BOND_SLAVE_NOTIFY_NOW);
> -
> -			slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
> -
> -			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
> -
> -			if (slave == rcu_access_pointer(bond->curr_active_slave))
> +			if (bond_miimon_slave_down(bond, slave))
>  				do_failover = true;
> -
>  			continue;
>  
>  		case BOND_LINK_FAIL:
> @@ -2919,6 +2935,12 @@ static void bond_mii_monitor(struct work_struct *work)
>  
>  		if (commit) {
>  			bond_for_each_slave(bond, slave, iter) {
> +				/* UP state is committed by bond_miimon_commit()
> +				 * after the speed and duplex check, so that it
> +				 * can still see the previous link state.
> +				 */
> +				if (slave->link_new_state == BOND_LINK_UP)
> +					continue;
>  				bond_commit_link_state(slave,
>  						       BOND_SLAVE_NOTIFY_LATER);
>  			}
> -- 
> 2.43.0
> 

This version looks good to me. Thanks!

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
