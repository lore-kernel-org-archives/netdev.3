Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCB1D63E4
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555864; cv=none; b=QlS+w18MXl0G19uZQ1pWiZHTLad+b6fYmtzOeO1o8Kwdvl9uRp1u+ph4jPn+c6rRK7Ku6rg8cb6VnR6IoEfeD31czJMJoaLXGW/CJGoE2wKog9PsHwYGLKtut+/2I/U1uu1DaNjaY1RD3Hd+5hkYrX9ZjVCUcemqcgP3n814+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555864; c=relaxed/simple;
	bh=22234UwCrQDKWzSyIlzAANv2pvj+mKhbip/k/ysyHjg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/q6oAqRdbzAI360cv3Z8U11eqWZ4LoSlFpxXWc6+jaJVZwtDIrujFW7P78cbr1Ha06uI6HRpaO709udRw7/diORjdRinw6ehpgbvt1D6QYmTkRVVr057do1x/W8IffiAe0OR/ZF1+fJ6UmePtQBgAz4amfeZidEp++wgpswCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uSRjA9LQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uSRjA9LQ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A0E60207BE;
	Mon, 24 Aug 2026 09:17:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z9yXcf9Jgbaq; Mon, 24 Aug 2026 09:17:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A0A9F206D2;
	Mon, 24 Aug 2026 09:17:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A0A9F206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787555857;
	bh=1Q3LZwngKCyj7sRt7FJw+9fWPzm6tGFDiCscvI5EXik=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=uSRjA9LQNITsbhFZE6rgo8Muy0sENy8AbL3nuz3VK7wROa5cOp5DCpp94CWh/Zjbf
	 nC9P0wjUbyuOg6eH/SZ77V+dVbXQlAN9vIvUFR9/AFi1KqdA097XLMtJbhO6LEnTjz
	 NpHa/ZDyVmMRk/7bHp97sLHz8Wwwv4dRLAS4/UKeMBJ8EDt2reo3/m0RKi/tFXT9/F
	 VMbYZD5k4Wsx6+cctNqaX3O839S/2EyaV8oHnVpOKmaCIIDGTnu5CnYy2DjBh5oJVr
	 ZiQQIIakKRRr4DHf0AQ6XryItUG44BO29MqITt/P2ZoX4jpv8NYu3UaQFWvdbRdnEa
	 D+s05gPdSQVUA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 09:17:37 +0200
Received: (nullmailer pid 794627 invoked by uid 1000);
	Mon, 24 Aug 2026 07:17:36 -0000
Date: Mon, 24 Aug 2026 09:17:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hu EnZe <paulinsider@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <corvus@tencent.com>, <slamhu@tencent.com>
Subject: Re: [PATCH net v3] xfrm: hold state while flushing device GC list
Message-ID: <aovwEHzXvAPHZpc2@secunet.com>
References: <20260816084642.76154-1-paulinsider@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260816084642.76154-1-paulinsider@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Sun, Aug 16, 2026 at 04:46:34PM +0800, Hu EnZe wrote:
> From: Hu EnZe <slamhu@tencent.com>
> 
> The device GC list does not hold a reference to the states it
> contains. During netdevice teardown, xfrm_dev_state_flush() drops
> xfrm_state_dev_gc_lock before calling xfrm_dev_state_free(), so the
> regular GC worker can concurrently destroy and free the entire
> xfrm_state. Subsequent access through the stale pointer can corrupt
> memory and cause a kernel panic.
> 
> Pin live states with xfrm_state_hold_rcu() while holding the device GC
> lock, and skip states whose reference count has already reached zero.
> Drop the acquired reference after the device state cleanup completes.
> Also use hlist_del_init() when removing dev_gclist so the node is
> marked as unhashed after removal.
> 
> Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: Codex:GPT-5.6-Sol
> Signed-off-by: Hu EnZe <slamhu@tencent.com>
> ---
> v3:
>   - fix the outer email From name from "paulinsider" to "Hu EnZe"
>   - no code changes
> 
> v2: https://lore.kernel.org/netdev/20260809081151.56774-1-paulinsider@gmail.com/
>   - rebase onto the latest ipsec tree
>   - use Hu EnZe <slamhu@tencent.com> for authorship and Signed-off-by
>   - add the Assisted-by trailer for Codex
>   - clarify the netdevice teardown trigger in the commit message
>   - no code changes
> 
> v1: https://lore.kernel.org/netdev/20260801041340.92117-1-paulinsider@gmail.com/
> 
>  net/xfrm/xfrm_state.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 36a4f6793ede..01138d3d1067 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -785,7 +785,7 @@ void xfrm_dev_state_free(struct xfrm_state *x)
>  	if (dev && dev->xfrmdev_ops) {
>  		spin_lock_bh(&xfrm_state_dev_gc_lock);
>  		if (!hlist_unhashed(&x->dev_gclist))
> -			hlist_del(&x->dev_gclist);
> +			hlist_del_init(&x->dev_gclist);
>  		spin_unlock_bh(&xfrm_state_dev_gc_lock);
>  
>  		if (dev->xfrmdev_ops->xdo_dev_state_free)
> @@ -1006,8 +1006,13 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
>  		xso = &x->xso;
>  
>  		if (xso->dev == dev) {
> +			/* The device GC list does not hold a reference to x. */
> +			if (!xfrm_state_hold_rcu(x))
> +				continue;

Can we avoid that additional refcount somehow?

>  			spin_unlock_bh(&xfrm_state_dev_gc_lock);
>  			xfrm_dev_state_free(x);

Maybe opencode the list removal here and create a
__xfrm_dev_state_free() function that does the rest.

> +			xfrm_state_put(x);
>  			spin_lock_bh(&xfrm_state_dev_gc_lock);
>  			goto restart_gc;
>  		}
> 
> base-commit: c12cbf56320fb633484ee0ca1fb7d68d6b64b213
> -- 
> 2.55.0
