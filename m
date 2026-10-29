Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282951;
	b=FglTfyDbIxLmb71wSfa02zcYmt3TUXtplzzJnO8EaAOQyc9QE3pMoe1BIASvKgCRBtXa
	 o++c26le0ewX/v0NkXZ9MqIP2M4JwS1eJYkqqrrOTTAbkLzglxw8jleCilThDkuL7i2fx
	 EcORkmdyvwXjvORelcnQIoy7kZkX14pO5CTQJkFCYdZsvJD2LtYmx42xm7X5s3TLeVj6W
	 hx9JWE7OJEqioHybdXiWlCMmTc0Rrioj6wktxgrif27Q0qFrAELaRu5x86xwfo+Wc399I
	 svakcjtx3tfhvSi7guh0uDbCbgCmPw2cHZuPHtMkNRQoXLsCzhlgG4xclFCaC/7pQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282951;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ubd3Ga831NUXqcpt+jZKp5rTrR12SuA0oDofbMeQqiE=;
	b=tsbQm0gydVmb62E6zrHMHe9jXsJVmJZrmuPq/ZLm9tayBctHE26HAWhl4f9mWWziC3YO
	 kzFWXBMupmXpnS7hf/uAVJKaqCgOwwK48+oSXPqlyNmRRLF+yw3MOxaAfnLE3tjj/9jdK
	 YSFDHKrbbgEmE+ndi8XwYbNZ0EGPQiuQgy30oqC1/BTCmheD66GbLO1RKSbkc2qh8aPAo
	 cwk+LabypWO9ge0vZmu2lzXJC76egnGdDHfOEbrVNnjyrox1zy37/L32TXhhv3DDx3RqW
	 hzu+F5gV4uwNeXpzNyW32TYfg44UI6obnt15Peo12Yx/PhkbvrISvtivatuJFaVA2nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyymJSJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E5606A321;
	Thu, 29 Oct 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyymJSJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF5F1F01828;
	Thu, 29 Oct 2026 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793282950;
	bh=Ubd3Ga831NUXqcpt+jZKp5rTrR12SuA0oDofbMeQqiE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kyymJSJfMEaIE0i1S2EHZCMBOFhBL9nfBTTLlhXCfM6Ltw8hLPzEIpukjwexVw9Ik
	 10fPc+qsVFt0eVndbxaAiz86KAtYcfaTh5/wbwp/OxA4eB8fbpxUmMFkzb4v2ouP18
	 8Er+8LbTUL8QiRq9V3M9ZGlYMamTGLS8l4L7HIqlChh4LxBosI7jKvH4inbJezMIBa
	 AWWw09F4Pm6wlbA8MSYAdCo3qYYJzjJzStTNpVC6l5BqZJUVovL5ecOSOqdAkA9x7J
	 lDdljxgV8eSyCgEkWdr/Pdnbyg9DxPDWEUUcByn8MCIRBqZhebcb683Y/nq2NUn6aZ
	 8pEasA9TI9QMA==
Subject: Re: [PATCH net v7 2/3] xfrm: set the address family before the early
 invalid-state drop
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 14:09:09 +0000
Message-ID: <179328294937.3134.2288184405522355478@kernel.org>
In-Reply-To: <20261027105031.19928-3-q.h.hack.winter@gmail.com>
References: <20261027105031.19928-3-q.h.hack.winter@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This commit taken by itself: moving `family = x->props.family`
  above the `x->km.state != XFRM_STATE_VALID` check in xfrm_input()…

--

xfrm: set the address family before the early invalid-state drop

This patch moves the family assignment in xfrm_input() above the check
for a state that is no longer valid. As a result, the early drop path
calls xfrm_rcv_cb() with a real address family instead of AF_UNSPEC. The
commit message describes this as a prerequisite for releasing the tunnel
device reference on that drop path in the next patch.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index cfd5cea033127..ab391258a5028 100644
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
On its own, can this commit expose a use-after-free on the vti and vti6
tunnel devices?

When an async-resumed skb (encap_type == -1) fails this check, it jumps
to the drop label in xfrm_input():

drop:
	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
	if (async)
		dev_put(dev);
	kfree_skb(skb);

Before this patch, family was still AF_UNSPEC at this point. That made
xfrm_input_get_afinfo() return NULL, so no callback ran. Now
xfrm4_rcv_cb() or xfrm6_rcv_cb() runs, and that reaches vti_rcv_cb() or
vti6_rcv_cb() with err == -1:

net/ipv4/ip_vti.c:vti_rcv_cb() {
	struct ip_tunnel *tunnel = XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4;
	...
	dev = tunnel->dev;

	if (err) {
		DEV_STATS_INC(dev, rx_errors);
		DEV_STATS_INC(dev, rx_dropped);
	...
}

vti_input() stores the tunnel pointer in skb->cb without taking a
reference. vti6_input_proto() does the same for IPv6, after
rcu_read_unlock().

During async crypto, xfrm_input() calls dev_hold() only on skb->dev. On
the vti proto path that is the underlay device, not the vti net_device.

A state that becomes invalid while crypto is pending is the teardown
case: an SA delete or flush, often together with tunnel deletion or
netns teardown. If the vti device has already been unregistered and
freed by then (vti6_dev_uninit() unlinks the tunnel and drops its
reference without waiting for in-flight crypto), then the
DEV_STATS_INC() calls would write into freed memory.

The same unreferenced dereference already exists on the async success
and drop_unlock paths. So this patch widens an existing problem rather
than creating a new one.

The last patch of this series, "xfrm: hold the tunnel device reference
across the input path", adds dev_hold() on the tunnel device in
vti_input(), vti6_input_proto() and xfrm6_rcv_spi(). It then releases
that reference after xfrm_rcv_cb() on the drop path, which appears to
fix this.

Both patches are Cc: stable. Would it make sense to reorder the series,
or fold the two patches together? That would avoid an intermediate
state that bisect could land on, or that a stable backport taking only
this patch would pick up.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027105031.19928-1-q.h.hack.winter%40gmail.com
