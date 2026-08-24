Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90B39478B;
	Mon, 24 Aug 2026 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557259; cv=none; b=CIqFvfZn0AXL5O7nMobO566g0oGqXLDVh9OPEhY3PmeNsZsuYShUAp8y8R6iXzDG56GGsKfQPVjXadAkXddQBQ1+tsaZQifROLbqliS8r016asVm6+0u/uHvtV2etG4hiSVHrWb/+uqV6ojcwydsZh1LKhGF/Ddg/lxAA6Vqc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557259; c=relaxed/simple;
	bh=4DiRGhi1TvzZV4W80SJkA3lMNoPMv/R0URzocXvKmOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHp+pmzPIAgz8alWc9NeMDRspzsySoIbB8IsZC0FtowgJNHIdGTwVEOuVrrcuRsK1R7PpKyynJ+H6DXwg93l1nUKBmHggGzdd/u8R1eDCeBdhQvOWM8fsMYFpLLUwAXYfPAHyIXoN8YfbDF+wp8JSWsWa8sme3fsXCDyJ4sxLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eiAHhoc6; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eiAHhoc6"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B1C3820610;
	Mon, 24 Aug 2026 09:40:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPCLM2ERTEF3; Mon, 24 Aug 2026 09:40:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 10FA8201E5;
	Mon, 24 Aug 2026 09:40:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 10FA8201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787557254;
	bh=ruNVAXXWd9MD4JqF23rWLe4mX+5aUsyMcFGU/yx8xEQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=eiAHhoc6jslKlmeYZxMq+Sg7J5yz/V6Lgtwju8yxz4AnS2jD5v5EHX5XNyd9TwFaL
	 uaFSJj9LfjXEU+e1gyLEVeeITJsze8OEMCjEPiA4MrZKOhtpi7Bc38VZ7LgGavbkY+
	 tv364Gzvi7s6/qU1MTlQHQYz9X3AFUaJWY7JZ/Z2jgpbbRwnOvKH7uDyeU8b0RfojR
	 zAwZ+e7wV2yvW1qk+AZ7Qfvmoyuy2NLxp98UnWWf8zpGFTaWQsKreUDHFnSr5bPrw1
	 qJx1pS3QkWEhBhKWjKuRmcRoliHZ5zgEypLE1cedfzYX5xpUJwg1iBiKukiMKIDbg9
	 RZuDrm6ysMW5g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 09:40:53 +0200
Received: (nullmailer pid 815868 invoked by uid 1000);
	Mon, 24 Aug 2026 07:40:52 -0000
Date: Mon, 24 Aug 2026 09:40:52 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<AutonomousCodeSecurity@microsoft.com>, <xmei5@asu.edu>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net] xfrm: hold net_device reference under RCU in bundle
 creation
Message-ID: <aov1hEK0BjxGe4xg@secunet.com>
References: <20260820200245.44312-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820200245.44312-1-blbllhy@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Aug 20, 2026 at 04:02:45PM -0400, Cen Zhang (Microsoft) wrote:
> xfrm_bundle_create() and xfrm_create_dummy_bundle() read dst->dev into
> a local pointer without taking a device reference, then pass it to
> xfrm_fill_dst().  A concurrent RTM_DELLINK replaces dst->dev via
> dst_dev_put() and frees the old net_device, causing a use-after-free
> when xfrm6_fill_dst() later dereferences the stale dev pointer.
> 
>   BUG: KASAN: slab-use-after-free in xfrm6_fill_dst+0x82c/0x860
>   (net/ipv6/xfrm6_policy.c:86 netdev_hold())
>   Read of size 8 at addr ffff8880142fe588 by task exploit/153
>   Call Trace:
>    xfrm6_fill_dst+0x82c/0x860
>    xfrm_resolve_and_create_bundle+0x21d4/0x2bd0
>    xfrm_lookup_with_ifid+0x485/0x1640
>    ip6_dst_lookup_flow+0x19b/0x1e0
>    udpv6_sendmsg+0x1443/0x2dd0
> 
> Fix by reading dst->dev under rcu_read_lock() via dst_dev_rcu() and
> taking dev_hold() before leaving the RCU critical section.  To properly
> release the reference, add dev_put() on both the success and error
> paths, and initialize dev to NULL to prevent dev_put() on an
> uninitialized pointer when put_states falls through to free_dst before
> dev is assigned.
> 
> Fixes: 25ee3286dcbc ("[IPSEC]: Merge common code into xfrm_bundle_create")
> Fixes: a0073fe18e71 ("xfrm: Add a state resolution packet queue")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/xfrm/xfrm_policy.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 932a313b9460..13585ff24aba 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2668,7 +2668,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  	const struct xfrm_mode *inner_mode;
>  	struct net *net = xp_net(policy);
>  	unsigned long now = jiffies;
> -	struct net_device *dev;
> +	struct net_device *dev = NULL;
>  	struct xfrm_dst *xdst_prev = NULL;
>  	struct xfrm_dst *xdst0 = NULL;
>  	int i = 0;
> @@ -2770,7 +2770,11 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  	xdst0->path = dst;
>  
>  	err = -ENODEV;
> -	dev = dst->dev;
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);
> +	if (dev)
> +		dev_hold(dev);
> +	rcu_read_unlock();

Can't we move the rcu_read_unlock() to the end of the function and
avoid the additional refcount?

>  	if (!dev)
>  		goto free_dst;
>  
> @@ -2789,6 +2793,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  		trailer_len -= xdst_prev->u.dst.xfrm->props.trailer_len;
>  	}
>  
> +	dev_put(dev);
>  	return &xdst0->u.dst;
>  
>  put_states:
> @@ -2798,6 +2803,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
>  	if (xdst0)
>  		dst_release_immediate(&xdst0->u.dst);
>  
> +	if (dev)
> +		dev_put(dev);
>  	return ERR_PTR(err);
>  }
>  
> @@ -3058,11 +3065,16 @@ static struct xfrm_dst *xfrm_create_dummy_bundle(struct net *net,
>  	xfrm_init_path((struct xfrm_dst *)dst1, dst, 0);
>  
>  	err = -ENODEV;
> -	dev = dst->dev;
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(dst);
> +	if (dev)
> +		dev_hold(dev);
> +	rcu_read_unlock();

Same here.

