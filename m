Received: from mail-pz2-f11.google.com (mail-pz2-f11.google.com [74.125.228.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339F372EDD
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726218; cv=none; b=fyAoE0epkKZ42xGqyyYT+61YdfQ/fkOrch/cglgM7vtAvFfZlkXeRsSSmnyAvUPLRM2Maxgrxusf/yw2XM44HrPzGQj4eoiKymeutX+yCHZz4OAlReN/LyjEQjVZKkbU1ZeP+nPrBUd79wPgF/Q3qhTFKEQs+2c2Qub1nYHYcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726218; c=relaxed/simple;
	bh=LB82x3yHLj0ZIv0pFS8v5a6vWrCM6Uf8WifwAO3062g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf8ah+Rk+/spb8UGObiRD7mkx/ZNI2PznGxG5ty9usG+ptJxPpYAXHQB1LxyTHpofr+SjnEu+K/nRGA0O1mFhVbMr+uvB10ChiZqf9pH+U9GMT1dNmpuY8zCmUoIeKvoUDStgovZoOo/qcSDcg3aF+ZnOOEk+1NRMQGtT/3aofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDnyXgJq; arc=none smtp.client-ip=74.125.228.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDnyXgJq"
Received: by mail-pz2-f11.google.com with SMTP id 41be03b00d2f7-cc1c2963c92so564721a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790726216; x=1791331016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OcFkbs9xpmy2vQRevUtdwcwZCN5ptsnh27WzDR0lOrE=;
        b=aDnyXgJqqMo1gVKEJ3nHn/7Z9oJ32NsW8uPQA4i0PKofIpd/nBjU204LXSoGeRjYX6
         dtghZf2a+p3p/K8uerw2IsPBtTTqWdyD5WJjPUaQJ+roA5Q+D4/gFG9zB7uNQCkZNvDX
         J7liuHIVDvcmDEyVODVCvQzuPF8vXfVJC1Id8VTAQd2TK9zwHrMeeiob0EXx8oRBwG7U
         V9Ni3cgGBF4efJjrKgg6K8t2tAenZNbZ3tv1FVgxIwS3uafjqAo77NYzSCQ100LSxTuc
         0g2S02AMapT2+XUL4QagE/ydvTVqBxKLUipjGJqjgNsdtZmTMjbCp6T2EoIsL9srxYVQ
         J8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790726216; x=1791331016;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OcFkbs9xpmy2vQRevUtdwcwZCN5ptsnh27WzDR0lOrE=;
        b=XL6/Q9Cd98xsULsegt1vJKxNgyohO8qLc1eWEnqFStpBGMZwLBCkicCr8rhZZ+UK9k
         OV2DK2ViznWuWmLhYxK4nAK2m3mXPIx9kZuXPbOdeeN1Uxd5nmqZnqF+inhoeqqjot+x
         J+nBBNXkLQPva44+1gDXUyuFrBCc7+jk8ijy1v3DjxBRXSRgqjR7b/MDm0soPLfnMxSG
         gV7jfW5qLrP850NDIgR2IzOJoA4JqFPA1XvrIFxvhW0q6v33H5dHLdtsrjWqzTMFeCkg
         pEPeBuulSHf7PMoGLj2ROjOG0oaxXBht5GkYahtWEKLLirJRc3iudiStZl0dI9UALnV+
         /qJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZpdjnO/TkWji3Htvq4utefwe2qphn7EC3KJd+bZVa63MIarGDPBsbXfyRIWF9IZT7p3UzqT4=@vger.kernel.org
X-Gm-Message-State: AFuF++mciU8NtZTn5s6p1NsYM6TJjoNsxw7g3ensWid3zReAujidt42z
	XJkGXpQIPQp//ZxYMnqtZl96JgqBGRAuCE+tNC3oBZ5+MFSFLMHwptgw
X-Gm-Gg: AYBFou1RiT3X0b/s6Y7Kh3ZyPZ2yNcMus85VFUZdnZNm2U+nzgkUI2TvqPsOMva5AiO
	vYYG9kqiaHDU4GTtOe7FVzFXTjGLtpljvgKR/6zqYKr4U5+oe9avfzncaMVWmUi75K+0g31Ersd
	XSaV7d/TxklSvYTOfeExwd7h5x7qIoF0CPN70ZwXQuIkWAS7taGmUE8iWKwNLJPKUjNskELfHJ4
	GIcU8XS1wAiVQZw5wOOnPXr62pi/kz0yWtp6Nf1P214A0wVt13ML8/NE+xBtHeJK5K86Q8aQjZl
	44lpqbaZp2AG2zYrNUSe88zURCQar48v/8Eq5wnqitdZrD0AjWcqBYmjsUF5PYyo9F85XtN6Uve
	71aiExmgy5o61Wc5AkQut8PgYd4hd0kxVWhaTTxMqbTKC6PwAKvyp6+hGyCoc691K7zBW88kBsm
	EBWzhnbSakrz2MIldUFoUMYZYMZtusrm3gJf5jFWdReTIncmmtwIi7DgC8VBm7hfNS
X-Received: by 2002:a05:6a00:1143:b0:881:6fb7:bf14 with SMTP id d2e1a72fcca58-886c4ba52abmr580798b3a.38.1790726216214;
        Tue, 29 Sep 2026 16:56:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8868b411873sm539888b3a.17.2026.09.29.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:56:55 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:56:52 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, razor@blackwall.org, 
	dw@davidwei.uk
Subject: Re: [PATCH net-next] net: only give queue leasing devices a separate
 instance lock class
Message-ID: <arxPfqA6wIF58Mg_@devvm7509.cco0.facebook.com>
References: <20260929191543.3295633-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929191543.3295633-1-kuba@kernel.org>

On 09/29, Jakub Kicinski wrote:
> Commit b6f74dff6d26 ("net: use two lockdep classes for the netdev
> instance lock") put every device without a parent in the virtual class.
> It also restricted the locking order for the virtual class, because
> queue leasing has hard requirements on the exact order.
> 
> This bites us back on bond, which is "virtual" and needs to be taken
> before taking the locks of the lowers. NIPA hit the following on the
> new test I recently posted for XDP+bond:
> 
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   python3/18635 is trying to acquire lock:
>   ff11000120b8ce30 (&dev->lock){+.+.}-{4:4}, at:
>   netdev_put_lock+0x2d/0x1a0
> 
>   but task is already holding lock:
>   ff110001ef77ae30 (&netdev_virt_instance_lock_key){+.+.}-{4:4}, at:
>   netdev_put_lock+0x2d/0x1a0
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #1 (&netdev_virt_instance_lock_key){+.+.}-{4:4}:
>          __mutex_lock+0x1ae/0x1f10
>          xdp_set_features_flag+0x2b/0x50
>          bond_xdp_set_features+0x1eb/0x360
>          bond_netdev_event+0x13f/0x300
>          notifier_call_chain+0xae/0x300
>          call_netdevice_notifiers+0x70/0xa0
>          bnxt_xdp_set+0x2f6/0x620
>          netif_xdp_propagate+0x503/0xc60
>          dev_xdp_propagate+0xa1/0x230
>          bond_xdp_set+0x234/0x700
>          dev_xdp_install+0x592/0xd70
>          dev_xdp_attach+0x355/0xf50
>          dev_change_xdp_fd+0x176/0x210
>          do_setlink.isra.0+0x220d/0x2b20
>          rtnl_newlink+0x9f1/0x11b0
> 
>   -> #0 (&dev->lock){+.+.}-{4:4}:
>          __mutex_lock+0x1ae/0x1f10
>          netdev_put_lock+0x2d/0x1a0
>          netdev_nl_queue_create_doit+0x801/0x1a70
>          genl_family_rcv_msg_doit+0x206/0x300
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&netdev_virt_instance_lock_key);
>                                  lock(&dev->lock);
>                                  lock(&netdev_virt_instance_lock_key);
>     lock(&dev->lock);
> 
> Let's narrow down the "virtual" class to only the devices which
> can actually create a queue. More LoC and complexity, but that
> is what we actually care about here. The rest needs to nest
> under rtnl_lock, which bond does (famous last words?)
> 
> Take the instance locks in two passes, first the netkits then
> the rest (matching the queue leasing order).
> An alternative would be to make sure the close list is sorted
> correctly from the start (queue head/tail appropriately in
> unregister_netdevice_queue()). I think it works but feels
> a little more fragile. Happy to change, tho.
> 
> netdev_can_create_queue() will now be used on paths where we
> genuinely handle non-netkit, so we can't always set the extack.
> Unfortunately, the (recently) added tracepoint in extack fires
> even when extack is NULL.
> 
> Fixes: b6f74dff6d26 ("net: use two lockdep classes for the netdev instance lock")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: razor@blackwall.org
> CC: dw@davidwei.uk
> ---
>  net/core/dev.c           | 48 ++++++++++++++++++++++------------------
>  net/core/netdev_queues.c | 31 ++++++++++++++------------
>  2 files changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a8eb382f40ca..f225906f7b6f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -575,7 +575,7 @@ static int netdev_lock_cmp_fn(const struct lockdep_map *a,
>  	if (a == b)
>  		return 0;
>  
> -	/* @a and @b must be of same class - both virtual or physical.
> +	/* @a and @b are of same lock class.
>  	 * cmp_fn won't be called for devices of different classes.
>  	 *
>  	 * For the same class only allow nesting under the protection
> @@ -589,12 +589,13 @@ static int netdev_lock_cmp_fn(const struct lockdep_map *a,
>   * queues from, see netdev_nl_queue_create_doit(). Keep the two kinds
>   * in separate classes so the dependency graph enforces the order;
>   * netdev_lock_cmp_fn() then only has to rule on same-class nesting.
> + * Other virtual devices stay in the default class.
>   */
>  void netdev_set_instance_lock_class(struct net_device *dev)
>  {
>  	static struct lock_class_key netdev_virt_instance_lock_key;
>  
> -	if (dev->dev.parent)
> +	if (!netdev_can_create_queue(dev, NULL))
>  		return;
>  
>  	lockdep_set_class(&dev->lock, &netdev_virt_instance_lock_key);
> @@ -12465,19 +12466,31 @@ static void netif_close_many_and_unlock(struct list_head *close_head)
>  	}
>  }
>  
> -static void netif_close_many_and_unlock_cond(struct list_head *close_head)
> +/* Handle one class of ops-locked devices. Since close requires the lock
> + * we need to be careful about which classes we allow to nest.
> + */
> +static void netdev_lock_ops_close_many(struct list_head *head,
> +				       struct list_head *close_head,
> +				       bool leasing)
>  {
> -#ifdef CONFIG_LOCKDEP
> -	/* We can only track up to MAX_LOCK_DEPTH locks per task.
> -	 *
> -	 * Reserve half the available slots for additional locks possibly
> -	 * taken by notifiers and (soft)irqs.
> -	 */
> -	unsigned int limit = MAX_LOCK_DEPTH / 2;
> +	struct net_device *dev;
>  
> -	if (lockdep_depth(current) > limit)
> -		netif_close_many_and_unlock(close_head);
> +	list_for_each_entry(dev, head, unreg_list) {
> +		if (!(dev->flags & IFF_UP) || !netdev_need_ops_lock(dev) ||
> +		    netdev_can_create_queue(dev, NULL) != leasing)
> +			continue;
> +		list_add_tail(&dev->close_list, close_head);
> +		netdev_lock(dev);
> +
> +#ifdef CONFIG_LOCKDEP
> +		/* We can only track up to MAX_LOCK_DEPTH locks per task.
> +		 * Reserve half the available slots for additional locks
> +		 * possibly taken by notifiers and (soft)irqs.
> +		 */
> +		if (lockdep_depth(current) > MAX_LOCK_DEPTH / 2)
> +			netif_close_many_and_unlock(close_head);
>  #endif
> +	}
>  }
>  
>  bool unregister_netdevice_queued(const struct net_device *dev)
> @@ -12517,15 +12530,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
>  	}
>  
>  	/* If device is running, close it first. Start with ops locked... */
> -	list_for_each_entry(dev, head, unreg_list) {
> -		if (!(dev->flags & IFF_UP))
> -			continue;
> -		if (netdev_need_ops_lock(dev)) {
> -			list_add_tail(&dev->close_list, &close_head);
> -			netdev_lock(dev);
> -		}
> -		netif_close_many_and_unlock_cond(&close_head);
> -	}

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Don't know if it's gonna help anyone, but if you happen to respin,
maybe add a comment here along the lines of
/* see netdev_set_instance_lock_class kdoc on why queue leasing first */

Although the hole is so deep now, not sure it's worth it :-D

> +	netdev_lock_ops_close_many(head, &close_head, true); /* queue leasing */
> +	netdev_lock_ops_close_many(head, &close_head, false); /* the rest */
