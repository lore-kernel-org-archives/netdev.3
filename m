Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857E3DDB18;
	Mon, 19 Oct 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402856; cv=none; b=duFAIiGYhIfTT160vVbasx442gaEie2JVDKFSkmmruqUhO4eYAlMpil5cQ9ZipF6151NgOdVXBySmOcZ3v9M34WbSR7opo944EvcGulvcJg4+N/ckZ0zQIfRL2UcCgFoO+w+s9b8fuLj3LKWVq3MJb4H4lx3XCalxYt0wk4QT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402856; c=relaxed/simple;
	bh=bYMhRnn3Ys7bVTRjDrIXGn9ao7cKT1MrN9XZppj0Rys=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTLCI+/FOgJe94AJtjNBw1oNFfwkNfw2nuBDRnNbKbQVT08Fa+V+S9dfRvOmyYt+0ojkLtI7hEZF7kN1ADspb29NSXWd5l9Q2A7zMHWoczA5H4KwqeeC78HyBW19pYZBDmGBzyQl5GwwyKeoackCYeOMcpZDaqI6w/xYRvRJ948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayTCBYW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayTCBYW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA951F000C4;
	Mon, 19 Oct 2026 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402854;
	bh=j9L674EJ7rCVTR0pk+yaIZVnIOzbjN/HtbEw2/wdYc8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ayTCBYW/v3onPRM2I7TAQ/fXMI3U0UrtqkvWUsRFMO6X1gVspWoVlZ6r4AyxFksPa
	 7qSuQpGqlY4swFCou8SCtVOCrSL2PF4QS44mQ8KANFiXyx+Pn3WZNMMCa3jepqD7pG
	 OszX+0gUUkLkKYLisfPNLAItFim1vfIbQVaTKPzBPv6N75ryOfkuTtPHSbA37N7Rgf
	 +6DzIhXbC/wOXHhSsV9L+5p8gTMjhLsgF5N61h9aYdfmo4gTenGo0mU0lXlU7WGKE5
	 gK3peJReESA//rFjEJuz3vSkYmadL417V7+wKPYLkfXYLZNDjQvM1l5GKqY/piOS0/
	 4x3gFFq52Z43Q==
Subject: Re: [PATCH net v4 1/3] xfrm: run the receive callback before dropping
 the skb->dev reference
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 09:40:53 +0000
Message-ID: <179240285359.3135.15828109727773891242@kernel.org>
In-Reply-To: <20261018090638.55686-2-q.h.hack.winter@gmail.com>
References: <20261018090638.55686-2-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes the async drop path in xfrm_input()
  (net/xfrm/xfrm_input.c) run xfrm_rcv_cb() before the async…

--

xfrm: run the receive callback before dropping the skb->dev reference

This patch reorders the drop label in xfrm_input() so that xfrm_rcv_cb()
runs before the async dev_put(dev). It also makes the early drop for an
invalid state let the drop label release the reference. The goal is to
keep callbacks such as xfrmi_rcv_cb() from touching skb->dev after its
reference has been dropped.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 5ed87d51392a5..94de4f698c331 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c

[ ... ]

> @@ -779,9 +779,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  drop_unlock:
>  	spin_unlock(&x->lock);
>  drop:
> +	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
>  	if (async)
>  		dev_put(dev);
> -	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
>  	kfree_skb(skb);
>  	return 0;
>  }

[Severity: High]
The commit message says the drop path now drops the reference "like the
success path does". Is that true for the tunnel-mode (decaps) success
path in xfrm_input()? That branch still drops the async reference before
handing the skb to GRO:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
	if (decaps) {
		...
		if (async)
			dev_put(dev);
		gro_cells_receive(&gro_cells, skb);
		rcu_read_unlock();
		return 0;
	}
    ...
}

gro_cells_receive() reads skb->dev right away:

net/core/gro_cells.c:gro_cells_receive() {
	struct net_device *dev = skb->dev;
	...
	if (unlikely(!(dev->flags & IFF_UP)))
		goto drop;
	...
	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
	...
drop:
	dev_core_stats_rx_dropped_inc(dev);
    ...
}

For a plain tunnel-mode SA where no xfrmi or vti callback rewrote
skb->dev, skb->dev is still the local dev. The async reference is the
only thing pinning that device while the crypto request is pending.

During unregister, netdev_wait_allrefs_any() returns as soon as
netdev_refcnt_read(dev) == 1. netdev_run_todo() then calls
netdev_do_free_pcpu_stats(), priv_destructor and free_netdev() without
waiting for another RCU grace period. The rcu_read_lock() held in
xfrm_input() therefore does not protect the device after the dev_put().

Can this sequence free the netdev while gro_cells_receive() is still
using it?

esp_input() returns -EINPROGRESS with dev_hold(dev) taken
  underlay device is deleted, unregister waits for refs
crypto completes
  xfrm_input_resume()->xfrm_input(skb, nexthdr, 0, -1), async = 1
    resume_decapped sets decaps = 1
    xfrm_rcv_cb() succeeds, skb->dev == dev
    dev_put(dev)                 <- last outside reference dropped
      waiter sees refcnt == 1, frees dev
    gro_cells_receive()          <- dereferences skb->dev

On the IFF_UP-cleared branch, dev_core_stats_rx_dropped_inc() also
writes through the freed dev->core_stats pointer.

The decaps ordering comes from the same commit named in the Fixes tag,
1c428b038400. The rest of this series does not change it either: in the
final tree the async dev_put(dev) still comes before
xfrm_input_take_tunnel_dev() and gro_cells_receive(). The transport and
xfrm_gro branch already drops dev after transport_finish() and
gro_cells_receive().

Should this patch also move the decaps dev_put(dev) after
gro_cells_receive(), and should the commit message be updated so it
doesn't say the drop path matches all of the success paths?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018090638.55686-1-q.h.hack.winter%40gmail.com
