Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCF474274;
	Wed,  7 Oct 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364211; cv=none; b=lInw33oZmFbCJ8iCRwSe416m1tU32XwO+0NVwCpXV/1rmXADc8BPMeDqgZvNEuzRuP6sI+uck/HUISi0FxsXengYZ2zvXBDiMO+zY4nE3QFFI9Twm2wapxwV9o0XW314aDX9G8D+4WVEf4LjY5LiyM4oHHL4qiRGHMjCbpjVEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364211; c=relaxed/simple;
	bh=1tw8yNKQNweugtba9SBKF2puJZZdgWDrKHMVJJiYo1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9jdhlRAk/HLjoBoLH40NxgAWOs57EoRCM2034IcHMpNybGYF7oUlV4gm15r+gIEF3VfinRfFRV6YKpmOaHD/9JnWlHh5hZGrBYTkz37V97MLddMTjRtaqv3xNjvd1u/Djm+93kzxSPq92+37NDqw8BP184ibgZrUjedYINPqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHmOYuHx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBBDQQZ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHmOYuHx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBBDQQZ0"
Message-ID: <8c482f036ff01600c7da3babdffc9b4060bf4bd7.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791364164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE1IE0ynHEERkW0sUrw61L0EkAcNq6Y+2enk8xxDYdg=;
	b=JHmOYuHxiMkjtEu/RvtZldjcICe1P5CpQeeJw4QNnoqDt+2I9gqkCu1Y5DVWkz8E3ZNwwU
	0EWCGbQz/VG5ezeboe8w8LdiTnU4IA1rrClMADQNuVXbudTNYAuJ2Ciyaq1akp28H0LQQb
	V2VuMEtFoaE0J7Hh2DB4pqGdgxUkA6ybGcMH8x4JWAN+uMfONdJgfGf7oz+ozvITNNzwyO
	0ZET8RIRXq3T6zhiv0Ih5LRAtXMxAkMd9d4Pm6RfBfpFr08yciY9HdkfJigtFd4z58ODY8
	FVFTadFcbLBS2z0klwI7YL5BYKN1j3dsV43HR5fXBJViFAP9p+dJZEIv/BxAcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791364164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE1IE0ynHEERkW0sUrw61L0EkAcNq6Y+2enk8xxDYdg=;
	b=UBBDQQZ0ILjs0DK9lvXDiz/WJipTcF1AbG5trMh5xscfCUCmcyW1Bfj5lHkPWS/BljQ7LW
	o0wf5dMhuwY3NKBA==
Subject: Re: [PATCH net-next v3 4/8] net: dsa: Add tag handling for SoC-e
 switches
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch,  olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch,  hkallweit1@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Wed, 07 Oct 2026 11:09:23 +0200
In-Reply-To: <179051210768.2160803.1929188838067459585@kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-4-ddebafcb9ba7@linutronix.de>
	 <179051210768.2160803.1929188838067459585@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 12:28 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] sdsa_xmit() writes the SDSA header at offset 12 (skb_push +
>   dsa_alloc_etype_header).
> - [Low] Whether sdsa_xmit() puts the VLAN in the SDSA header on transmit
>   depends on the conduit, and in-band 802.1Q tags are never handled.
>=20
> --
>=20
> net: dsa: Add tag handling for SoC-e switches
>=20
> This adds a DSA tagging driver for SoC-e switches. The driver uses an
> 8-byte SDSA header with EtherType 0xdcdc, placed after the source MAC
> address. It builds FROM_CPU frames on transmit and parses TO_CPU frames
> on receive, and maps the optional 802.1Q TCI in the header to and from
> skb VLAN hwaccel metadata.
>=20
> > diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
> > new file mode 100644
> > index 0000000000000..8cc3fa357be42
> > --- /dev/null
> > +++ b/net/dsa/tag_sdsa.c
> > @@ -0,0 +1,158 @@
>=20
> [ ... ]
>=20
> > +static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_devic=
e *dev)
> > +{
> > +	struct dsa_port *dp =3D dsa_user_to_port(dev);
> > +	struct sdsa_tag *tag;
> > +	u16 vlan_tci;
> > +
> > +	BUILD_BUG_ON(sizeof(*tag) !=3D SDSA_HLEN);
> > +
> > +	skb_push(skb, SDSA_HLEN);
> > +	dsa_alloc_etype_header(skb, SDSA_HLEN);
> > +
> > +	tag =3D dsa_etype_header_pos_tx(skb);
> > +	tag->ethertype =3D cpu_to_be16(ETH_P_SDSA);
> > +	tag->reserved =3D 0;
> > +	tag->frame_type_port_hi =3D
> > +		FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, SDSA_FRAME_TYPE_FROM_CPU) |
> > +		FIELD_PREP(SDSA_TAG_PORT_HI_MASK,
> > +			   dp->index >> SDSA_TAG_PORT_HI_SHIFT);
> > +	tag->port_lo =3D FIELD_PREP(SDSA_TAG_PORT_LO_MASK, dp->index);
> > +	/* SDSA carries no TPID, so only encode 802.1Q C-tags. */
> > +	if (skb_vlan_tag_present(skb) &&
> > +	    skb->vlan_proto =3D=3D htons(ETH_P_8021Q)) {
>=20
> [Severity: Low]
> The commit message says "Encode accelerated VLAN metadata into the header
> on transmit". Is the wire format meant to depend on which conduit is
> used?
>=20
> This branch only runs if the skb still has a hwaccel C-tag when it reache=
s
> the tagger. The user port gets its features from the conduit:
>=20
> net/dsa/user.c:dsa_user_setup_tagger() {
>     ...
> 	user->features =3D conduit->vlan_features | NETIF_F_HW_TC;
>     ...
> }
>=20
> If the conduit's vlan_features do not include NETIF_F_HW_VLAN_CTAG_TX,
> validate_xmit_vlan() on the user netdev moves the tag in-band before
> dsa_user_xmit() runs:
>=20
> net/core/dev.c:validate_xmit_vlan() {
>     ...
> 	if (skb_vlan_tag_present(skb) &&
> 	    !vlan_hw_offload_capable(features, skb->vlan_proto))
> 		skb =3D __vlan_hwaccel_push_inside(skb);
>     ...
> }
>=20
> In that case the frame goes out with the VLAN-info bit clear, followed by
> an in-band 0x8100 tag. This seems to apply to macb (Cadence GEM) on
> ZynqMP, which has no HW_VLAN features. It also applies to most other
> conduits, for example mlx4, nfp, bnxt, otx2, wangxun, and mtk_eth_soc,
> which masks out CTAG_TX explicitly.
>=20
> With stmmac (dma_cap.vlins) or bcmsysport, whose vlan_features do include
> CTAG_TX, the same frame goes out with the TCI in the SDSA header instead.
>=20
> Should sdsa_xmit() also handle in-band 802.1Q tags, so that the format is
> the same on every conduit? Or could the commit message describe this
> behaviour?

I will clarify the existing behaviour in the commit message.
Accelerated 802.1Q metadata is encoded in SDSA, while in-band VLAN
headers remain after SDSA.
The manual does not specify whether both representations are equivalent
in all cases, so I will leave the handling unchanged rather than
introduce unverified normalization for all conduits.

>=20
> > +		vlan_tci =3D skb_vlan_tag_get(skb);
> > +		__vlan_hwaccel_clear_tag(skb);
> > +		tag->frame_type_port_hi |=3D SDSA_TAG_VLAN_BIT;
> > +		tag->vlan =3D cpu_to_be16(vlan_tci);
> > +	} else {
> > +		tag->vlan =3D 0;
> > +	}
>=20
> [Severity: Medium]
> What happens to an accelerated tag whose vlan_proto is not ETH_P_8021Q?
> One example is an 802.1ad S-tag from an 802.1ad upper or from tc vlan
> push.
>=20
> Such a tag takes the else branch and stays in skb->vlan_all, but the SDSA
> header is already at offset 12. When the skb is then sent on the conduit,
> the S-tag can be inserted at ETH_HLEN, in front of the 0xDCDC EtherType.
> The insertion is done either by the conduit hardware
> (NETIF_F_HW_VLAN_STAG_TX) or by:
>=20
> validate_xmit_vlan()
>   __vlan_hwaccel_push_inside()
>     __vlan_insert_tag()
>=20
> The switch would then see 0x88a8 where it expects the SDSA header, and
> would not recognise the FROM_CPU destination port. Depending on the
> hardware, the frame could be dropped, or it could be forwarded like
> ordinary CPU-port ingress.
>=20
> For this to happen, the user netdev needs NETIF_F_HW_VLAN_STAG_TX, which
> it can only get through conduit->vlan_features. No in-tree conduit seems
> to set that today, but nothing in the tagger rules it out.
>=20
> Other taggers guard against this case. ks8995_xmit() in
> net/dsa/tag_ks8995.c does:
>=20
> 	if (unlikely(skb_vlan_tag_present(skb))) {
> 		skb =3D __vlan_hwaccel_push_inside(skb);
>=20
> so that the conduit cannot insert the tag outside the special tag.
> tag_sja1105.c does something similar.
>=20
> Could any leftover hwaccel tag be pushed in-band with
> __vlan_hwaccel_push_inside() before the SDSA header is inserted, with the
> NULL return handled?

This was already mentioned by kernel bot. I will fix it for the next
version.

>=20
> [ ... ]
>=20

