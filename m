Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E0306D3F;
	Mon,  3 Aug 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771450; cv=none; b=UKMRdbPl8ttw62BQ3NNtejXLNVf0kVOz5BZJLoA9/7AN3RL+mBczAT9rW33wYGVJaHzLD5dGSz2Wl3SGpmh1QHUtcW70YkXxPEuIWQavEm6U8UeUJMeXuFgGQgxsiWIjWHkoyLdtNoziY8TuvxtqlPbBSVuEbywTX81zsA88P2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771450; c=relaxed/simple;
	bh=LZrSE2PN024uA2UcijIaogZJZK2bOeqBNiLqx3yz+kA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbyHSeN/JYYfLxD9MKuv+9TDOXsjfrTmAjcABhEheuFzsrxu0i2RRQpQgcOSzvzKXAKw/+aoazdV+n2cFVebFiGIMSJ8u4M6itxz8oEDVP8AxT8JR9fQYqM8P4iQzJpTyHEzeyNEMHvYkP6RckhOS2wvdXx0DzzzyuK4vCYitKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d13k/nMY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tqxU8rLP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d13k/nMY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tqxU8rLP"
Message-ID: <723a256eb9d5aa64e7037f98eabeeb99257f03f2.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785771447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tL4fRz/EBUxL1gXqJ/ZWGHPI53NDoMq1GoW/7FU3J6E=;
	b=d13k/nMYCRN8X7w4FQpY+VVtpcHZJUkpc3ky/kwV2VPe7Y/xKCllbDnHLv8Wxh/6tlC9qS
	Pb9zXSB7FtwcU8kQaags8oOSTGxNJ9meZ7Gv/0obhuu5riHyuV+RElf3o0HGI+5zB1ASG0
	7bCmI6R6FGuMTqSaf085pTGU+hJzu/ggKfqNzSiQQeRxEbFu4DvkTdC+ecyUsBR9Q7Q3Uy
	RpOQRunnU3ofEJMq0edXiWItfJEVsA1BPOjWH1Odt6EBOUrYlliBToN/C6MwvOOFOmA4Qb
	19zcCOYXnzNg0t4dOafDy5J9g1iyLU9x2mkkFOnHK9dNlArx4SvYRw0Lw+l+5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785771447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tL4fRz/EBUxL1gXqJ/ZWGHPI53NDoMq1GoW/7FU3J6E=;
	b=tqxU8rLPXOBZ+04ZUjv3pt9t69h1ZpKYsSesu+mYpNTc1OI/No27NogylZZbNs959yBQNT
	AYt/dE1kQbB9ybAQ==
Subject: Re: [PATCH 3/4] net: dsa: Add support for SoC-e SDSA tags
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 17:37:26 +0200
In-Reply-To: <df7e7e04-80fc-4b80-9afd-0e9bc14a759f@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-3-be569dae1b20@linutronix.de>
	 <df7e7e04-80fc-4b80-9afd-0e9bc14a759f@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 19:22 +0200, Andrew Lunn wrote:
> > @@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
> > =C2=A0	  Say Y or M if you want to enable support for tagging frames fo=
r the
> > =C2=A0	  Marvell switches which use EtherType DSA headers.
> > =C2=A0
> > +config NET_DSA_TAG_SDSA
> > +	tristate "Tag driver for SoC-e switches using EtherType SDSA headers"
> > +	help
> > +	  Say Y or M if you want to enable support for tagging frames for the
> > +	  SoC-e switches.
> > +
>=20
> These entries are sorted, so it probably should be between
> NET_DSA_TAG_RZN1_A5PSW and NET_DSA_TAG_LAN9303.

I will insert it as suggested. To better understand, what is the sort order=
?
To me, it seems like there's also a good spot between
NET_DSA_TAG_LAN9303 and NET_DSA_TAG_SJA1105.

>=20
> > @@ -23,6 +23,7 @@ dsa_core-y +=3D \
> > =C2=A0obj-$(CONFIG_NET_DSA_TAG_AR9331) +=3D tag_ar9331.o
> > =C2=A0obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) +=3D tag_brcm.o
> > =C2=A0obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) +=3D tag_dsa.o
> > +obj-$(CONFIG_NET_DSA_TAG_SDSA) +=3D tag_sdsa.o
> > =C2=A0obj-$(CONFIG_NET_DSA_TAG_GSWIP) +=3D tag_gswip.o
>=20
> Also sorted, and this is the wrong spot.

Oh yes, I'll place it between tag_rzn1_a5psw and tag_sja1105.

>=20
> > +#define SDSA_HLEN	8
> > +
> > +#define SDSA_NAME	"sdsa"
>=20
> Does SDSA mean anything? Or have you taken net/dsa/tag_dsa.c, and just
> changed edsa to sdsa?

The "S" stands for Soc-e. I don't have any preferences and just took it
from the original code.

>=20
> > +static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_devic=
e *dev)
> > +{
> > +	struct dsa_port *dp =3D dsa_user_to_port(dev);
> > +	u8 *sdsa_header;
> > +
> > +	if (skb_cow_head(skb, SDSA_HLEN) < 0)
> > +		return NULL;
> > +
> > +	skb_push(skb, SDSA_HLEN);
> > +	dsa_alloc_etype_header(skb, SDSA_HLEN);
> > +
> > +	/* Construct the FROM_CPU DSA tag. */
>=20
> Is FROM_CPU a concept for this device? Are there other types of tag?

Yes, the documentation describes two types of tagging headers for frames fr=
om
the switch to the CPU and from the CPU to the switch. The tags differ in so=
me
bits.

>=20
> > +	sdsa_header =3D dsa_etype_header_pos_tx(skb);
> > +	sdsa_header[0] =3D (ETH_P_SDSA >> 8) & 0xff;
> > +	sdsa_header[1] =3D ETH_P_SDSA & 0xff;
> > +	sdsa_header[2] =3D 0x00; /* reserved */
> > +	sdsa_header[3] =3D 0x00; /* reserved */
> > +	sdsa_header[4] =3D FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, 1) |
> > +			 FIELD_PREP(SDSA_TAG_PORT_HI_MASK, dp->index >> 5);
> > +	sdsa_header[5] =3D FIELD_PREP(SDSA_TAG_PORT_MASK, dp->index);
> > +	sdsa_header[6] =3D 0x00; /* VLAN not supported */
> > +	sdsa_header[7] =3D 0x00; /* VLAN not supported */
> > +
> > +	return skb;
> > +}
> > +
> > +static struct sk_buff *sdsa_rcv(struct sk_buff *skb, struct net_device=
 *dev)
> > +{
> > +	u8 *sdsa_header;
> > +	int source_port;
> > +	u8 frame_type;
> > +
> > +	if (unlikely(!pskb_may_pull(skb, SDSA_HLEN)))
> > +		return NULL;
> > +
> > +	sdsa_header =3D dsa_etype_header_pos_rx(skb);
> > +
> > +	/* Check that the frame type is TO_CPU. */
> > +	frame_type =3D FIELD_GET(SDSA_TAG_FRAME_TYPE_MASK, sdsa_header[4]);
> > +	if (frame_type !=3D 0)
>=20
> #define for TO_CPU?

I will add definitions for both TO_CPU and FROM_CPU.

>=20
> 	Andrew

Thanks,
Vasilij

