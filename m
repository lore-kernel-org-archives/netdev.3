Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3D34CCE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487934; cv=none; b=P1xNXFdKuIF/RMfC49PT+eoK06jA1jT+XiRatVSFTBOfw4EPZGC8UtN5XjoRWgH6DLnKFfvvfzmrm+Awe7QiHxL1UPO2Hoa2VCmmIr6PKk+SaBpIlV3Gf4UiuFA2O5xIMUQaAzKRLzvdAoVKwgfOfNjQKriBk7aLAH28cCC+J9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487934; c=relaxed/simple;
	bh=vyLTdAHIOB1B4NfqcHghy+3y7/0cyViBQpiXm4m0Fe0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bg8V2DrLrCGyLqVHaXEfLe2VMExhAaBns9hidx82OVo7cS04WQlnmBsvEp5LW2ZPTv8OIMhrMA3CIcJF91HyDJjJD1P5d679KIw9HAbUl5bZ9rV2PhHhDylB7Jzad80XjIRhw4WFZhejMbCnZSj1oSmMzTOJ22xcmueW4wJlxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbSLrXB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbSLrXB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351781F000FF;
	Thu,  8 Oct 2026 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487932;
	bh=hTscVRVmU6th6PkcJY8KfYQNcOHiBHKwkZizpRKHKu8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KbSLrXB5pdsM2pLd2eBVLJjHw6r44j/ryzkbJg++ikfnQFqbwNT0rNaAbvXnEl45O
	 0HkgVBqKPXOvp+9KpjO0HR96yMvViIDC4Ecko003jfdlmLtyyuLmw9zl914a80x8Qy
	 nEioCfcrUZJDRAZ7tq4vco22tTbdH8OKCjZuXL53lY9B9kJ46YDHt5a8PHMBr4XFnw
	 GClFuOGAh+Tw4woTxHDxhheH95PtEaMlrETRU1OGGfZLh+AsQNrXob6/8Zn3q4JqjH
	 QwmDuxHfd09zbQmaHTQeeU5GEWtup7MI8YEYFnb9HNWlhexEvD6O+PpuyuHPCsyeNJ
	 wpZ3QOa4EGlrA==
Subject:
 Re: [PATCH net] vlan: do not insert the vlan header in vlan_dev_hard_header()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, sairon@users.noreply.github.com,
 hitchin999@users.noreply.github.com, stefan@agner.ch, hkallweit1@gmail.com
Date: Thu, 08 Oct 2026 19:32:11 +0000
Message-ID: <179148793175.434549.15605670907509784817@kernel.org>
In-Reply-To: <20261007073027.459868-1-edumazet@kernel.org>
References: <20261007073027.459868-1-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Stacked VLANs of the same protocol lose their outer tag when
  reorder_hdr=off.
- [Low] On non-offload real devices, the patch removes the transmit-side
  meaning of reorder_hdr=off.

--

vlan: do not insert the vlan header in vlan_dev_hard_header()

This removes the in-band 802.1Q push that vlan_dev_hard_header() did for
reorder_hdr=off. Tagging is left to vlan_dev_hard_start_xmit(), which sets
the hwaccel tag, and to validate_xmit_vlan(), which inserts the tag in
software when the device can't. The goal is to fix NETDEV WATCHDOG stalls
on r8169 that started after commit 447cbe95ebb9.

Closes: https://github.com/home-assistant/operating-system/issues/5019
Closes: https://lore.kernel.org/netdev/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/

> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index c949c6a829456..c3db1ac23e6a8 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c

[ ... ]

> @@ -49,47 +53,14 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
>  				unsigned int len)
>  {
>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -	struct vlan_hdr *vhdr;
> -	unsigned int vhdrlen = 0;
> -	u16 vlan_tci = 0;
> -	int rc;
> -
> -	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
> -		unsigned int hlen = READ_ONCE(dev->hard_header_len) +
> -				    READ_ONCE(dev->needed_headroom);
> -
> -		if (skb_cow_head(skb, hlen) < 0)
> -			return -ENOMEM;
> -		vhdr = skb_push(skb, VLAN_HLEN);

[Severity: High]
With this push gone, can stacked VLANs of the same protocol drop their
outer tag when reorder_hdr=off? Take eth0.200.100 on top of eth0.200, both
802.1Q with reorder_hdr=off. The same applies to 802.1ad over 802.1ad.

Here is the transmit path after this patch:

eth0.200.100: vlan_dev_hard_header()
  dev_hard_header() -> eth_header() writes the payload ethertype (0x0800)

eth0.200.100: vlan_dev_hard_start_xmit()
  0x0800 != vlan_proto, so __vlan_hwaccel_put_tag(skb, 0x8100, 100)
  dev_queue_xmit() on eth0.200

eth0.200: __dev_queue_xmit()->validate_xmit_skb()->validate_xmit_vlan()
  __vlan_hwaccel_push_inside() puts tag 100 in-band

VLAN devices never advertise NETIF_F_HW_VLAN_CTAG_TX or STAG_TX.
vlan_dev_init() leaves them out of hw_features, and vlan_dev_fix_features()
only intersects. So the core always inserts the tag in software here.

Then in vlan_dev_hard_start_xmit() for eth0.200:

	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
	    veth->h_vlan_proto != vlan->vlan_proto) {

REORDER_HDR is clear and h_vlan_proto is now 0x8100, so eth0.200 treats
the upper device's tag as its own. It never adds tag 200, and eth0 sends a
frame tagged only with VLAN 100.

Before this patch, both hard_header calls pushed their tags, so the wire
carried 8100/200 8100/100.

The commit message says:

  "Frames sent on the wire are unchanged for real devices without
  HW VLAN TX offload."

Isn't the lower VLAN device itself a real device without HW VLAN TX
offload in this setup? The result also doesn't depend on what eth0
supports.

Could this also bring back the r8169 stall for stacked setups? Before,
eth0 received a double-tagged frame, and vlan_features_check() masks
csum/TSO for multi-tagged frames. Now eth0 gets a frame with a single
in-band tag, so csum/TSO stay enabled through vlan_features.

A smaller variant seems to exist with AF_PACKET SOCK_DGRAM and protocol ==
vlan_proto on a single reorder_hdr=off VLAN. Before, the device's own tag
was pushed in front of the frame. Now the same h_vlan_proto test skips it.

The new comment above vlan_dev_hard_header() says that
vlan_dev_hard_start_xmit() sets the hwaccel tag. That only happens when the
outer ethertype differs from vlan_proto. The h_vlan_proto test was the
counterpart of the in-band insertion removed here. Does the lower VLAN need
some way to still tag frames whose in-band header came from an upper VLAN's
hwaccel push?

> -
> -		vlan_tci = vlan->vlan_id;
> -		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
> -		vhdr->h_vlan_TCI = htons(vlan_tci);
> -

[ ... ]

> -		skb->protocol = vlan->vlan_proto;

[Severity: Low]
This isn't about the wire format, but removing this also changes what
observers on the VLAN device itself see when reorder_hdr=off. ip-link(8)
says that with reorder_hdr off, the VLAN header is inserted immediately.

Before, the tagged frame with skb->protocol = vlan_proto was visible on the
VLAN device to egress tc/clsact, netfilter egress, an attached qdisc and
packet taps (for example tcpdump -i eth0.100).

Now the tag only exists as hwaccel metadata, set later inside
vlan_dev_hard_start_xmit(). Those observers see an untagged frame with
skb->protocol set to the payload protocol. A filter such as "protocol
802.1q" on the VLAN device would stop matching.

Should the commit message mention this user-visible change? It currently
only covers frames on the wire.

> -		type = ntohs(vlan->vlan_proto);
> -		vhdrlen = VLAN_HLEN;
> -	}
> +	struct net_device *real_dev = vlan->real_dev;
>  
>  	/* Before delegating work to the lower layer, enter our MAC-address */
>  	if (saddr == NULL)
>  		saddr = dev->dev_addr;
>  
>  	/* Now make the underlying real hard header */
> -	dev = vlan->real_dev;
> -	rc = dev_hard_header(skb, dev, type, daddr, saddr, len + vhdrlen);
> -	if (rc > 0)
> -		rc += vhdrlen;
> -	return rc;
> +	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007073027.459868-1-edumazet%40kernel.org
