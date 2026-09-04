Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FC415F22
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502328; cv=none; b=sNtnFWtD3AMKqYTa2jZQk6OI16nNg4+TtsLyNaPd/al0YF4uWxmjtOTByeQxPBFD8Z6YXElfFI2TeOiO8pgXI7hFhokqapIwnqWtYspNF9ztFNCFl3SF8Kk4fxHu1oXc7FpfnJXwqie3lgYg2zQhElg0WlRM+UdtxyBcA94mKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502328; c=relaxed/simple;
	bh=eJJBMjs+18V7g33OiX+ub6t4LMHZY2pve7uURsandAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgBe8anqKaQntBjgSlnRoOykPSFKGa3zzged65wA5++bBxWR6J+resTLrSB6g13xckrv7gx6K6dKgHPtkDN+slnjACGdLfVwKdnxyC3Abw/eXVPPCjIG3OjJg8bthzZ5wyfbjb3h59pwmIcyyTcj5M0ksHg/H4UhAVCieeKhNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uAhn3jr4; arc=none smtp.client-ip=91.218.175.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uAhn3jr4"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eJJBMjs+18V7g33OiX+ub6t4LMHZY2pve7uURsandAs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788502323; v=1; x=1789107123;
 b=uAhn3jr4rDsoFitmwH8z5VvZyV4aoJalWQIXlFu4BXjROT68mR/Wjl+9ngyqGdQxMR8706Of
 jog2pv/U+nsL6JW+cGExq5Jul/gGALsu+HpE5ssk0T8mP6XiaJPUHsrp7CXeyO33X693QEXpCya
 ABVv9JuFx5xmNrc3p52XdMyw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 429cc04ee579e250;
	Fri, 04 Sep 2026 06:12:03 +0000
X-Mizu-Trace-ID: 429cc04ee579e250
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 14:11:57 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: David Dai <zdai@linux.ibm.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pradeeps@linux.ibm.com
Subject: Re: [PATCH 1/1] bonding: crypto offload enabled, non-offload slave
 failover, rekey failed
Message-ID: <apphLbjfmRYknVNh@fedora>
References: <20260903220123.475685-1-zdai@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903220123.475685-1-zdai@linux.ibm.com>

On Thu, Sep 03, 2026 at 05:01:23PM -0500, David Dai wrote:
> Create a bonding device (i.e. bond0) in active-backup mode, 2 slaves.
> Active slave: offload capable interface (i.e. eth1), primary interface.
> Backup slave: non-offload capable interface(i.e. eth2).
> Configure strongswan service swantl.conf child SA "hw_offload = crypto"
> Start strongswan service
> IPSec Crytpo Offload is enabled on top of bond0. i.e. 
> ip xfrm state |grep offload
>         crypto offload parameters: dev bond0 dir out mode crypto
> 	crypto offload parameters: dev bond0 dir in mode crypto
> 
> Active slave eth1 takes adavantage of IPSec Crypto Offload capability. 
> 
> If active slave eth1 is down for any reason (i.e. eth1 link down):
> ip link set down dev eth1
> non-offload capable interface eth2 failover to becomes active slave. 
> The existing SAs can continue use software IPsec after failover.
> Traffic still keeps going properly.
> 
> However if eth1 link had not recovered yet, strongswan service does
> new child SA rekey, or uses swanctl command to do new child SA rekey, 
> it will fail because active slave eth2 doesn't support crypto offload.
> In bond_ipsec_add_sa routine, it returns -EINVAL now, which is 
> treated as fatal error by xfrm_dev_state_add routine in kernel xfrm.
> 
> To make the non-offload active slave survive the child SA rekey, need 
> to make bond_ipsec_add_sa routine returns -EOPNOTSUPP instead when 
> active slave doesn't support IPsec Crypto offload, the xfrm will 
> gracefully fallback to create new SA using Software IPsec. 
> Network traffic can keep going.
> 
> After offload capable interface eth1 link is up, becomes active slave,
> next time strongswan child SA rekey will create a new SA which enables
> crypto offload again.
> 
> This way, network traffic is never interrupted, always keeps going.
> 
> Signed-off-by: David Dai <zdai@linux.ibm.com>
> Tested-by: David Dai <zdai@linux.ibm.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index ef9eb0c53c66..79fc892dab07 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
>  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>  	    netif_is_bond_master(real_dev)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
> -		err = -EINVAL;
> +		err = -EOPNOTSUPP;
>  		goto out;
>  	}
>  
> -- 
> 2.55.0
> 

The patch looks good to me. I am just not sure whether we should shorten
the description. Let's wait for others' opinions.

Thanks
Hangbin
