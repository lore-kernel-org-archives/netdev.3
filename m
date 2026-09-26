Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBA31D367
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790386606; cv=none; b=mHme+STFadv42VrsdHPqXKmP0JZhHc7vaBJtwOYvm3VGQzchpWuujNwcmdsMPwer2MQAKOCa9jNAQku4ikKVqu24GfzAzPZAO4+Jd2D1XXlvnSixgepi4wYuZU39CyR4KhikIB5RhHIrOjk3i+UIMylJaCjSe9EtK2dwGcWx9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790386606; c=relaxed/simple;
	bh=QqKrD9Uq42OS0UXjsdDoaCZBhquCZvUyyM0OtU9osQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YutQ4kH1K2U1sBnSMHIflMRtncBzH/8D5JsSjUwB9wFwIjorF+v9tE1V0H8zGPZ/HUdQ0sSvbQSjrdpn3m4FzBPjIvu8WHacj+tPngqHlX7ibqfxDz0fqAaA2sxyx935/biCGv7J8s3nXUH+bhsQr8Gu8XsnCaTOWs1X7Z1oNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDRM3w3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDRM3w3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F2F1F000FF;
	Sat, 26 Sep 2026 01:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790386604;
	bh=R0s8YzloE72hdBVusREgE7EXBhzeXd7mIoR3aeZn82o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LDRM3w3F/Kyv3wYsBCM4qoDZTqyc9T/6OrVC6QIveXhZDdJfSyTw/mfxppssdVCYj
	 vLECfTJGZfDk7MKVU0+iXc6EKa3KR1QVfQrNcVGSnYv+FaBrozvjXLcHo5Cv97bMt2
	 SILMPubQ33/MUntOmr0BCRsZDVDRnoPsYt5cYXw5g5AXNslcadsdM/tnpUqNgEaPdm
	 DOz5+007x/WAQ6dhkKEY3NxHLpWGRt0FQsHdBsmHAHaCS21QtdGS927qsImAJoP85d
	 HcQzgwt6+niA9Q4Vds4kvfpm6wJZdJXPLOFUvRP9VZXXSHk6T2rrtLbUMfxqxSN5yA
	 YEmcjLdfKf4MA==
Date: Fri, 25 Sep 2026 18:36:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com, sdf.kernel@gmail.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 1/2] net: use a single lockdep class for the
 netdev instance lock
Message-ID: <20260925183643.4f7d9eb8@kernel.org>
In-Reply-To: <20260923223545.3815583-1-kuba@kernel.org>
References: <20260923223545.3815583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 15:35:44 -0700 Jakub Kicinski wrote:
>  	(dev)->qdisc_tx_busylock = &qdisc_tx_busylock_key;	\
>  	lockdep_set_class(&(dev)->addr_list_lock,		\
>  			  &dev_addr_list_lock_key);		\
> -	lockdep_set_class(&(dev)->lock,				\
> -			  &dev_instance_lock_key);		\
> -	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);	\
>  	for (i = 0; i < (dev)->num_tx_queues; i++)		\
>  		lockdep_set_class(&(dev)->_tx[i]._xmit_lock,	\
>  				  &qdisc_xmit_lock_key);	\
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c67900354fa6..bca7b267f937 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -568,6 +568,22 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
>  }
>  #endif
>  
> +#ifdef CONFIG_PROVE_LOCKING
> +static int netdev_lock_cmp_fn(const struct lockdep_map *a,
> +			      const struct lockdep_map *b)
> +{
> +	if (a == b)
> +		return 0;
> +
> +	/* Allow locking multiple devices only under rtnl_lock,
> +	 * the exact order doesn't matter.
> +	 * Note that upper devices don't lock their ops, so nesting
> +	 * mostly happens in batched device removal for now.
> +	 */
> +	return lockdep_rtnl_is_held() ? -1 : 1;
> +}
> +#endif

ugh, clashiko points out this is weakening the condition more than
I thought. Apparently lockdep_rtnl_is_held() is always UNKNOWN (-1)
when called from inside lockdep code ;( So this lockdep_rtnl_is_held()
is always true, and we would never fire a lockdep warning on instance
locks.

I need to switch to non-lockdep rtnl_is_held(), I think, and we either
bring back the classes for virt devices (but one class for all) or
we explicitly handle the virt->phys order that queue leasing needs.
Coding it up now, let me see which one is less ugly.
