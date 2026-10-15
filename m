Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70754147A;
	Thu, 15 Oct 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074609; cv=none; b=Vd555irXNkUjZ3lhngYq0Gs30qLKXbceU+gN6VW0yBipBWbDcYnef+8m56buMTXA6mCeHvytpNIJokXFsN1PUnD0grbkliE5bT5FHrDM17wRwQjGKtTKPYsXFtI3dziHhmxdS/UUnRHcmZuVehsQIDZ0miIpGy2aCYKgJBsI094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074609; c=relaxed/simple;
	bh=lq8RYLtftn0YhOXhEbW5g1tapV0Qbr0ZcmUwb/mGbbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNk1ufEIhLfRPoW08DtO83XaLpOIm2aT6RhYxnE2p8CilRSS9Cclfy+ifg9Afl7dr4LLk4bX476Iny/mWP8qtOHuzUoz7OOc4A8gTesXW6kIh4xC8W9T+DuQKU1Z2QbTCWWq/VazNx8qMhGQcv97FLj+qxCsDuD2GZ24w0p7HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2554A42375;
	Thu, 15 Oct 2026 16:30:04 +0200 (CEST)
Date: Thu, 15 Oct 2026 16:30:02 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] seg6: skip the route refcount in
 seg6local IPv6 lookups
Message-ID: <atDhp1tk31K4RAKS@luna.proxmox.com>
References: <20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com>
 <20261010-seg6-lookup-noref-v2-1-51c09dd98197@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261010-seg6-lookup-noref-v2-1-51c09dd98197@gmail.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1792074603492

Hi Yuya,

> [snip]
> @@ -372,17 +374,41 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  		rt = net->ipv6.ip6_blk_hole_entry;
>  		dst = &rt->dst;
>  		dst_hold(dst);
> +		flags &= ~RT6_LOOKUP_F_DST_NOREF;
>  	}
>  
>  	skb_dst_drop(skb);
> -	skb_dst_set(skb, dst);
> +	if ((flags & RT6_LOOKUP_F_DST_NOREF) && !dst->rt_uncached_list)
> +		skb_dst_set_noref(skb, dst);
> +	else
> +		skb_dst_set(skb, dst);
>  	return dst->error;
>  }
>  
> +static int seg6_lookup_nexthop_noref(struct sk_buff *skb,
> +				     struct in6_addr *nhaddr, u32 tbl_id)
> +{
> +	return seg6_lookup_any_nexthop_noref(skb, nhaddr, tbl_id, false, 0);
> +}
> +
>  int seg6_lookup_nexthop(struct sk_buff *skb,
>  			struct in6_addr *nhaddr, u32 tbl_id)
>  {
> -	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false, 0);
> +	int err;
> +
> +	rcu_read_lock();
> +	err = seg6_lookup_nexthop_noref(skb, nhaddr, tbl_id);
> +	if (!skb_dst_force(skb)) {
> +		struct dst_entry *dst;
> +
> +		dst = &dev_net(skb->dev)->ipv6.ip6_blk_hole_entry->dst;

I think we should use ip6_null_entry instead of ip6_blk_hole_entry here.
Previously this path (failure to acquire the dst ref) was reached through
ip6_pol_route() and ip6_hold_safe(), which uses ip6_null_entry and returns
-ENETUNREACH as an error.
After this patch, the error is triggered here and we use ip6_blk_hole_entry,
which returns -EINVAL.

What do you think?

> +		dst_hold(dst);
> +		skb_dst_set(skb, dst);
> +		err = dst->error;
> +	}
> +	rcu_read_unlock();
> +
> +	return err;
>  }
>  
>  static __u8 seg6_flv_lcblock_octects(const struct seg6_flavors_info *finfo)
> [snip]

Thanks,
Gabriel

