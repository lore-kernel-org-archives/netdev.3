Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7A48CD4F;
	Mon, 19 Oct 2026 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402857; cv=none; b=Ov1b3XJgwinzqseVjK86lRVYZMeDtunEumOIhBMhRRcqMormLbjiyBKFLUUYAR7xNnmVaWVfzheAdfFfHFdebPCNFJqSBQtuxZD28JbhEtUCTKFZjNnIHGyMgiWCjC2iUC5/v9+FsvZbAFsahLNIx/Bp7hSeaDy7NktJe6qxRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402857; c=relaxed/simple;
	bh=FtCizW/WrNS6oe6ON5o/6RjRWHHBSLtceaVmnNS6tgA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fdOIalzbTnb3EDTTIrbfZQN41n+vRpKskBWN3ccyVfxfC6kGjppphku0qPB9ziw5KlD56W8/l5lpQIn7pJbo7xD8JkSC4atv0U40LQ8Xue6uYN7OzQBSaMl4DE4NDF5Mln4HhNg3EiCicDF/0boT9sbczi/QdFTbpHBh0RZM0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhcndjcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhcndjcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB91F000C5;
	Mon, 19 Oct 2026 09:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402856;
	bh=ZLbg9JOLqVlmYrggtiRH1+YtQkxHYmmJmuak1MFhZvQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hhcndjcplBXBc6p+AyfoLM5/IYK2krgRchBvMbeQGOPEgq169VR1megbk5kcNbUSs
	 /Mvuu98M0tNv02fyYqX1eQ6gBcr4GTRdabhBc9g5TfOwy8d8BnUwigq4km+hkH+Be0
	 xdsRe7Jaa8X/viaA9CVyIJnwCtWPstOcp9CtwRPkJrfI4exfTj/626DTYcb6DJfaU4
	 IuGn8NABhws40AJhnt+eKGIOqe5IUMoITsARWqHpwUctkqlesVmlhu8fQdMe9YXpPC
	 OZLzM5NVNqSsM7cnY8QItOV7NhrgK1Xkx9daIrCpCZXDVQSvTPymgDFG4yMuXFGcJi
	 VURdh8GSsJoog==
Subject: Re: [PATCH net v4 2/3] xfrm: set the address family before the early
 invalid-state drop
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 09:40:54 +0000
Message-ID: <179240285486.3135.14507012674076727535@kernel.org>
In-Reply-To: <20261018090638.55686-3-q.h.hack.winter@gmail.com>
References: <20261018090638.55686-3-q.h.hack.winter@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Taken alone, this patch exposes a tunnel pointer with no
  reference held to a new drop path.

--

xfrm: set the address family before the early invalid-state drop

This patch moves the family = x->props.family assignment in xfrm_input()
so it runs before the km.state != XFRM_STATE_VALID check. The early
invalid-state drop then calls xfrm_rcv_cb() with a real family, so the
per-family receive callback runs on that path too. The patch is tagged for
stable, and a later patch in the series needs it to release the tunnel
device reference.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 94de4f698c331..517369ba9efea 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -487,6 +487,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  				      encap_type == UDP_ENCAP_ESPINUDP))) {
>  		x = xfrm_input_state(skb);
>  		xfrm_proto = x->type ? x->type->proto : nexthdr;
> +		family = x->props.family;
>  
>  		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
>  			if (x->km.state == XFRM_STATE_ACQ)

[Severity: Medium]

With family set here, the early invalid-state drop now calls xfrm_rcv_cb()
with AF_INET or AF_INET6 instead of AF_UNSPEC:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
			...
			if (encap_type == -1)
				async = 1;
			goto drop;
		}
    ...
drop:
	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
	if (async)
		dev_put(dev);
	kfree_skb(skb);
    ...
}

Before this patch, xfrm_input_get_afinfo() found no afinfo for AF_UNSPEC,
so no handler ran on this path. Now vti_rcv_cb() and vti6_rcv_cb() run
here, and both write to the tunnel netdev stats when err is set:

net/ipv4/ip_vti.c:vti_rcv_cb() {
    ...
	dev = tunnel->dev;

	if (err) {
		DEV_STATS_INC(dev, rx_errors);
		DEV_STATS_INC(dev, rx_dropped);
    ...
}

At this commit, the tunnel pointer in XFRM_TUNNEL_SKB_CB(skb) is stored
without taking a reference. vti_input() saves tunnel.ip4 directly.
vti6_input_proto() saves tunnel.ip6 after it has already called
rcu_read_unlock():

net/ipv6/ip6_vti.c:vti6_input_proto() {
    ...
		rcu_read_unlock();

		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
    ...
}

The only device xfrm_input() pins across async crypto is the local dev,
which is skb->dev at entry. For vti_input_proto() (update_skb_dev=false)
and for vti6_input_proto(), that is the lower device, not the vti netdev.

Can this become a use-after-free write on the vti/vti6 net_device? One
possible sequence:

  async crypto (e.g. cryptd) is in flight
  the SA is deleted and km.state becomes XFRM_STATE_DEAD
  the vti/vti6 netdev is unregistered and freed
  crypto completes:
    xfrm_input_resume()
      xfrm_input(..., -1)
        goto drop
          xfrm_rcv_cb()
            vti_rcv_cb() / vti6_rcv_cb()
              DEV_STATS_INC(tunnel->dev, ...)

The async success path and drop_unlock already use the same unreferenced
pointer before this patch. The new path is the one most closely tied to SA
and tunnel teardown.

The last patch in this series, "xfrm: hold the tunnel device reference
across the input path", seems to fix this. It adds dev_hold() in
vti_input() and vti6_input_proto(), and adds a dev_put() after
xfrm_rcv_cb() on the drop label. Its commit message says it depends on
this patch.

This commit has a Fixes: tag and Cc: stable. Should the series be
reordered so the reference is taken first? The alternative is to make sure
the follow-up is always backported together with this one.

Otherwise, a bisect that stops at this commit, or a stable tree that takes
only this patch, would get the new drop path without the reference.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018090638.55686-1-q.h.hack.winter%40gmail.com
