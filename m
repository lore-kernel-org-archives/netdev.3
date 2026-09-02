Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF13B19BA
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378233; cv=none; b=kFCl+Qq/ehwiSIRNMuQ0jwG4RvL+OKBxI/5bhcVNQ2Dv233pMInGeIToPKtQv9tZ4hs4X8jwRHUpkS8wPBaYk4Wr9ZKzhqfhG7ReKV2pFD39LtdZ20pt0SmxzzKSR1flvqPG56fGR1Ck6dlWWk6koF0EhtgNbykRg1iv/TG5FDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378233; c=relaxed/simple;
	bh=z9ApUZl4fkj3LpyyRfK1d2BUmDbSu2Ov7LfnnyjD2OM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZ93Isr2mgQcCig58zrFctOpVKHya2ZW4fdwg0snQVnyGBU3FXQcBzlbRsbkHShkrv3xus3Tajlz+VhbS/h0lSAe0w6vo8U9TJmIU1UW+OtHJjQWu2Taky5Iy226+XHM0nxokS5aoH5Q9S/QamYcyrlLtu3XyjX9JWY4zrjpMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jao6HQOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jao6HQOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFB31F000E9;
	Wed,  2 Sep 2026 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788378226;
	bh=+vCh84D/9kPl/D06OTw5EDlP6cf17RH9TIt8F8Lfy14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jao6HQOzm5QgANrpWRJtkemTbsLHMDtrV1P+9fcbIynjeT4ZckvZ6qbz9ycNFXvd9
	 Tsq35yynxlIewSCYTDnrIGR63zi8wFQ0hnIBs7R0k4JLp8Jr3H2aBrspwMp8kCSEqx
	 MzGnvR+VphBjRSwQEO+0L3nrboIrJhtV3LJmM5gF44mMWVDmsv9hrYqhBk+kPxu+lM
	 H4zmFdFOWQSOHV+mxwIHZpUgXnmOri+7Z/Cps+nNK+lq6rlOYeI5wTllpFhvYVYDQY
	 Y/f/TQGnR5SoORPBLUTeqhPx19gDVQ/KNXslorL6PbBnKjp89PPFBmy6zBGuf8XkBn
	 KjmbQuH4+SC2A==
Subject: Re: [net-next,v2,2/3] netdev: avoid skipping objects on race with
 device disappearance
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel@iogearbox.net, razor@blackwall.org, bobbyeshleman@meta.com,
 sdf@fomichev.me, joe@dama.to
Date: Wed, 02 Sep 2026 19:43:45 +0000
Message-ID: <178837822544.3394541.8986948577168153795@kernel.org>
In-Reply-To: <20260831164159.1124679-3-kuba@kernel.org>
References: <20260831164159.1124679-3-kuba@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] Incomplete fix across the netdev generic-netlink family:
  netdev_nl_page_pool_get_dump() in net/core/page_pool_user.c (backing…
- [Medium] The new continuation logic identifies the resumed device only
  by its numeric ifindex (ctx->ifindex != start_ifindex).
- [Low] Commit message / provenance: the patch fixes a real user-visible
  dump-correctness bug (a netdev-genl dump can silently omit…

--

netdev: avoid skipping objects on race with device disappearance

The dumpit handlers for napi-get, queue-get and qstats-get now snapshot
ctx->ifindex before iterating and only clear the sub-object cursor
(ctx->napi_id, ctx->rxq_idx, ctx->txq_idx) when the iterator has moved
to a different ifindex, instead of clearing it after each device.  The
unconditional reset at the end of netdev_nl_stats_by_queue() is dropped.

No Link: tags in the commit header.

[Severity: Low]

The commit message says:

    If the currently dumped device disappears while we were mid-dump
    we will get the next device without resetting the sub-object ID.

Since the effect of that is a dump that silently omits the NAPIs, queues
or per-queue stats rows of the device following the one that went away,
should this carry a Fixes: tag for the commits that introduced the
per-device cursor reset in netdev_nl_napi_get_dumpit(),
netdev_nl_queue_get_dumpit() and netdev_nl_qstats_get_dumpit()?

The message does state "This is quite unlikely, it was reported by an AI
tool not a real user. Let's fix it for better dump consistency.", so if
skipping stable is intentional then this is only a question about making
the provenance explicit.

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 04dcd7fc614e1..e427bab4c4d2e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -312,11 +312,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  			err = -ENODEV;
>  		}
>  	} else {
> +		unsigned long start_ifindex = ctx->ifindex;
> +
>  		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
> +			if (ctx->ifindex != start_ifindex)
> +				ctx->napi_id = 0;

[Severity: Medium]

Is the numeric ifindex enough to establish that the resumed device is
the same object we stopped inside?

Between two dumpit invocations the per-device lock taken by
for_each_netdev_lock_scoped() is dropped by the __free() cleanup in
net/core/dev.h, and nothing pins the device or its index.  A different
device can take over the same index in that window, because a requested
non-zero index is accepted directly in dev_index_reserve():

net/core/dev.c:dev_index_reserve() {
	...
	if (!ifindex)
		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
	else
		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
	...
}

and rtnl_newlink_create() then assigns it:

net/core/rtnetlink.c:rtnl_newlink_create() {
	...
	dev->ifindex = ifm->ifi_index;
	...
}

A device moved in from another netns can also keep its index.  In that
case ctx->ifindex == start_ifindex, the reset is skipped, and the old
device's cursor is applied to the replacement device:

net/core/netdev-genl.c:netdev_nl_napi_dump_one() {
	...
		if (ctx->napi_id && napi->napi_id >= ctx->napi_id)
			continue;
	...
}

A freshly created device gets higher napi ids, so would every NAPI of
the replacement device be filtered out here?  The same applies to the
queue-get and qstats-get hunks below, where the stale ctx->rxq_idx /
ctx->txq_idx would cause the replacement device's low-numbered queues to
never be reported.

Would keying the reset on something other than the raw ifindex, or
invalidating the sub-cursor whenever object identity cannot be proven
(for example a dump generation counter plus NLM_F_DUMP_INTR), close this
remaining case?

>  			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
>  			if (err < 0)
>  				break;
> -			ctx->napi_id = 0;
>  		}
>  	}
>  
> @@ -636,13 +639,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  			err = -ENODEV;
>  		}
>  	} else {
> +		unsigned long start_ifindex = ctx->ifindex;
> +
>  		for_each_netdev_lock_ops_compat_scoped(net, netdev,
>  						       ctx->ifindex) {
> +			if (ctx->ifindex != start_ifindex) {
> +				ctx->rxq_idx = 0;
> +				ctx->txq_idx = 0;
> +			}
>  			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
>  			if (err < 0)
>  				break;
> -			ctx->rxq_idx = 0;
> -			ctx->txq_idx = 0;
>  		}
>  	}
>  

[ ... ]

> @@ -936,7 +942,13 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  		return err;
>  	}
>  
> +	start_ifindex = ctx->ifindex;
> +
>  	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
> +		if (ctx->ifindex != start_ifindex) {
> +			ctx->rxq_idx = 0;
> +			ctx->txq_idx = 0;
> +		}
>  		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
>  						    info, ctx);
>  		if (err < 0)

[Severity: Medium]

Should netdev_nl_page_pool_get_dump() in net/core/page_pool_user.c get
the same treatment?  It backs page-pool-get and page-pool-stats-get in
the same netdev family and still uses the idiom this patch replaces:

net/core/page_pool_user.c:netdev_nl_page_pool_get_dump() {
	...
	for_each_netdev_dump(net, netdev, state->ifindex) {
		...
		hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
			if (state->pp_id && state->pp_id < pool->user.id)
				continue;

			state->pp_id = pool->user.id;
			err = fill(skb, pool, info);
			if (err)
				goto out;
		}

		state->pp_id = 0;
	}
out:
	...
}

The "state->pp_id = 0" is bypassed by the goto out taken when fill()
returns -EMSGSIZE, which is the normal dump continuation path.  If the
device is unregistered before the next recvmsg(), for_each_netdev_dump()
lands on the following device while state->pp_id still holds the
previous device's page-pool id.

Since ids come from xa_alloc_cyclic() in page_pool_list():

net/core/page_pool_user.c:page_pool_list() {
	...
	err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
			      &id_alloc_next, GFP_KERNEL);
	...
}

they grow monotonically, so would the "state->pp_id < pool->user.id"
test then silently skip every page pool of the new device?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831164159.1124679-1-kuba%40kernel.org
