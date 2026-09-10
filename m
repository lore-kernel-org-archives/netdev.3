Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356323C2798;
	Thu, 10 Sep 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077671; cv=none; b=XjKAW4/Dt3hX7cFNcdmRmGJS0ou/R2MCSciJuV0mvttUKqp5XZETiNOt9PqhGy4PB3z8AkF9hNY9oCGpu+HZQ+Q3Iv5NLxzWWoZkP9PSD4c0E3w1/h6mXbABhd4BOQvoUXWRoyt77EL2P23kn6tTid6TDaAfGCHluOCZnM67Dso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077671; c=relaxed/simple;
	bh=NJL8zzbxAhxhlei/7Z6QEPX5Y/NAguljg3HD+ajEJck=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzcPRAkSS4Jh42VGXGVtrjKGoVJjh4aUppU+O2RzhErSU66AhqWFWDhnICY1ItzgR138eb6MbtNhNngo7jcaRy8Z2wJrWoYOUAIj2Yx6eSxHJj5MSuvyd7V8/mB9Ak7Du3w1tx2EZP4UB1vEUwaYW4REXUEGIchvrFgxmKiLKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFnW1ARS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFnW1ARS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73BE1F000FF;
	Thu, 10 Sep 2026 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077665;
	bh=HNjq5xHWtE/e6PR352/5hMq3DaOoOS3NAvFZhTCBijM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GFnW1ARSnaLKYJA41JWi3YZ7ZO+QlyddWRZ1qc5lumGeQUg8SSUTZEodQZ4qrcrKq
	 In1fy5a/ubg1LxgtX9azootn3+GtyQj/ABQa+uH4vQPn7byevc1TtXzIeA2SHO1YXi
	 Za2i1pW4DDCJaS9BYJstIjDij9RAt/vf/yOudjH4/3N4oOLmlLM4aZD9gIyZbV4nO/
	 GJQh8H5JQK248dFhDeE3t148ZVKfO2pd+tz38AtCzd1ncHycn3cSSLFnifvrYdzIWO
	 djYUfd3QU9KjOZndKxkd9PU3dtFzTKULi/elsvKoddJV9+MLSbpvpYM1Uub4MBK3gO
	 0+/l3xZ8C7I8A==
Subject: Re: [PATCH] net: dsa: tag_rtl8_4: push VLAN tag into payload before
 DSA CPU tag
From: netdev-bot+sashiko@kernel.org
To: singh.amitesh@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net
Date: Thu, 10 Sep 2026 22:01:04 +0000
Message-ID: <178907766425.219967.7235108817827251025@kernel.org>
In-Reply-To: <20260908040041.124640-1-singh.amitesh@gmail.com>
References: <20260908040041.124640-1-singh.amitesh@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] Headroom accounting mismatch in net/dsa/tag_rtl8_4.c:
  rtl8_4_tag_xmit() now consumes VLAN_HLEN (4) bytes of headroom via…
- [Medium] Incomplete fix: the defect described in the commit message is
  not specific to tag_rtl8_4.
- [Low] The patch fixes a user-visible data-path bug (VLAN-tagged traffic
  through an RTL8365MB leaks raw 0x8899 CPU tags to the peer port,…
- [Low] The new comment in rtl8_4_tag_xmit()
  (net/dsa/tag_rtl8_4.c:133-136) states the conduit NIC "will insert the…

--

net: dsa: tag_rtl8_4: push VLAN tag into payload before DSA CPU tag

This adds a __vlan_hwaccel_push_inside() call to rtl8_4_tag_xmit() so that
a hardware-accelerated VLAN tag is moved into the skb payload before the
8-byte RTL8_4 CPU tag is prepended. The stated goal is to keep the conduit
NIC from inserting the 802.1Q header at the CPU tag offset.

A few questions below.

> net: dsa: tag_rtl8_4: push VLAN tag into payload before DSA CPU tag

[Severity: Low]
Should this carry a Fixes: tag and name the target tree?  It changes
data-path behaviour for VLAN traffic through an RTL8365MB, and git blame
attributes rtl8_4_tag_xmit() and the rest of the tagger to:

  1521d5adfc2b ("net: dsa: tag_rtl8_4: add realtek 8 byte protocol 4 tag")

so that looks like the anchor stable tooling would want.

[Severity: Medium]
Is the problem really specific to tag_rtl8_4?  The user port inherits the
conduit's VLAN features unconditionally in dsa_user_setup_tagger():

  user->features = conduit->vlan_features | NETIF_F_HW_TC;

and nothing in net/dsa clears NETIF_F_HW_VLAN_CTAG_TX, so
validate_xmit_vlan() leaves the tag in hwaccel form:

  if (skb_vlan_tag_present(skb) &&
      !vlan_hw_offload_capable(features, skb->vlan_proto))
          skb = __vlan_hwaccel_push_inside(skb);

The conduit then inserts the 802.1Q header at offset 12, which is exactly
where every dsa_alloc_etype_header() based CPU tag lives.

That includes the sibling Realtek tagger, rtl4a_tag_xmit(), which still
does:

  skb_push(skb, RTL4_A_HDR_LEN);

  dsa_alloc_etype_header(skb, RTL4_A_HDR_LEN);

with no push-inside, plus tag_brcm.c, tag_dsa.c, tag_lan9303.c,
tag_mt7628.c, tag_mtk.c, tag_qca.c, tag_netc.c and friends.

Was a core-side fix considered instead, for example not inheriting
NETIF_F_HW_VLAN_CTAG_TX for etype-position tag protocols, or doing the
push once in dsa_user_xmit()?  Could the changelog say why the per-tagger
variant was chosen?

> diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
> index 4da3beebef75e..bc11ddc4e1784 100644
> --- a/net/dsa/tag_rtl8_4.c
> +++ b/net/dsa/tag_rtl8_4.c
> @@ -128,6 +128,19 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
>  static struct sk_buff *rtl8_4_tag_xmit(struct sk_buff *skb,
>  				       struct net_device *dev)
>  {
> +	/* If the skb has a hardware-accelerated VLAN tag (skb->vlan_tci set),
> +	 * push it into the payload before prepending the DSA CPU tag.
> +	 * Otherwise the upstream NIC (e.g. imx-dwmac with tx-vlan-offload
> +	 * fixed:on) will insert the 802.1Q header *after* the CPU tag,
> +	 * producing [8100 VID][8899 CPU tag] on the wire instead of the
> +	 * correct [8899 CPU tag][8100 VID].
> +	 */

[Severity: Low]
The prose and the diagram in this comment disagree.  It says the NIC
inserts the 802.1Q header "*after* the CPU tag", but the next line shows
the result as [8100 VID][8899 CPU tag], i.e. the 802.1Q header ends up
before the tag.  The file header documents the same thing:

 *  +--------+--------+------------+------+-----
 *  | MAC DA | MAC SA | 8 byte tag | Type | ...
 *  +--------+--------+------------+------+-----

Should this read "before the CPU tag"?

> +	if (skb_vlan_tag_present(skb)) {
> +		skb = __vlan_hwaccel_push_inside(skb);
> +		if (!skb)
> +			return NULL;
> +	}
> +
>  	skb_push(skb, RTL8_4_TAG_LEN);

[Severity: High]
Does this need .needed_headroom bumped by VLAN_HLEN as well?  The tagger
still declares only:

net/dsa/tag_rtl8_4.c:rtl8_4_netdev_ops = {
	...
	.needed_headroom = RTL8_4_TAG_LEN,
};

The only headroom guarantee before the tagger runs comes from
dsa_user_xmit() -> skb_ensure_writable_head_tail(), which tops up to
exactly dev->needed_headroom and no more:

net/core/skbuff.c:skb_ensure_writable_head_tail() {
	...
	needed_headroom = max_t(int, needed_headroom - skb_headroom(skb), 0);
	...
	return pskb_expand_head(skb, needed_headroom, needed_tailroom, GFP_ATOMIC);
}

For a plain NIC conduit that is 8 bytes.  __vlan_hwaccel_push_inside()
then goes through __vlan_insert_inner_tag(), which only asks for an
absolute VLAN_HLEN of headroom before consuming it:

include/linux/if_vlan.h:__vlan_insert_inner_tag() {
	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
		return -ENOMEM;

	skb_push(skb, VLAN_HLEN);
	...
}

With 8 bytes of headroom present, skb_cow_head(skb, 4) does not expand
anything, so 4 bytes are left when control reaches
skb_push(skb, RTL8_4_TAG_LEN).  Can that drive skb->data below skb->head
and hit skb_under_panic() -> BUG()?

The sja1105 tagger doing the same push declares:

net/dsa/tag_sja1105.c:sja1110_netdev_ops = {
	...
	.needed_headroom = SJA1110_HEADER_LEN + VLAN_HLEN,
};

Would .needed_headroom = RTL8_4_TAG_LEN + VLAN_HLEN, or an explicit
skb_cow_head(skb, RTL8_4_TAG_LEN) before the CPU-tag push, be the right
thing here?

There is a second effect: dsa_tag_protocol_overhead() is derived from
needed_headroom + needed_tailroom, so the conduit MTU is sized 4 bytes
short for full-size VLAN frames, and when the cow does fire it adds a
pskb_expand_head() per VLAN packet in the transmit path plus a newly
reachable allocation-failure drop.

>  
>  	dsa_alloc_etype_header(skb, RTL8_4_TAG_LEN);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908040041.124640-1-singh.amitesh%40gmail.com
