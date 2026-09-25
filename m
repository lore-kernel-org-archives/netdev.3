Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA1443E56;
	Fri, 25 Sep 2026 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340405; cv=none; b=XBeZrOc0p1uKpS4dkezkDgMyMPG3AcgN7w3UkW5TBiSzDDOHjGLi6nsDIKFVGAzscJGOP39NK6L8PcxkXfohors00l8hgaQgGuMgPTrb8cMdGaaUf15wYoWwW0Xp+srsJQFUTIWYEdJnUtqAVYJk6OmThHkFxbOJL0/tQ/HAIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340405; c=relaxed/simple;
	bh=xt9jpLiwPOdPKGTMCvuyRPEudCPvIhQx+fsOUK0ILB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayhWcyHgAJIGdlNnV105qidb3y2yqcP4DoJUsc0yYP6jsASu8PSecoKpKgQ4sOLgVqIIfzXu21BRmRMyjZsjeQRl0/iyyT2lTgoJ5U4KQYggF7tmlEAU3e3QTDZT++2UX02kQH2uC8u6udKSk0h8NPEy5KFJ3DXLa2/iQkH4hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ydp7MEfN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzsiUczE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ydp7MEfN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzsiUczE"
Message-ID: <e7e56030f307e9837ef7375953fe06ca6c01b2ca.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790340401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tW4NRRfzn/Y38qXoWB2bb+XlWNEz6Lz8yXDZ44Xr0o4=;
	b=Ydp7MEfNAcdty/RgMOhOKfdwBbOuQRf45mgNSHLxeOZsHuD+SDN/i9V2mbzJA1lliG3jfw
	0JgWYEY7aka8Azfzh4PXvbcjQylWgMcmfvsp9FQkoBZVkpht3BE0FS8ZHalFBCcDFiVg1t
	ErmW5ZghVrv/s/NuaUfnTW6IYx2qhl0EaOZarBV4+NL0wxKgOAJfFaqfapWAVddZQchwOW
	gOn8I9qKWF9JJKDw0DYkJGWFsufWi1LbtdRo9d7x0lEAQkuIdO7htGB1DLw3WIebUBqgBl
	EUtjgo5V/ybSZbS2oRTgpKqVKfNQnu2xn2W7HrW3QTTMHeXJiE0xkqu1ElN7uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790340401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tW4NRRfzn/Y38qXoWB2bb+XlWNEz6Lz8yXDZ44Xr0o4=;
	b=mzsiUczEIHqu4DGerIM/OtjmQ7Yfxs3TJ4xncb34mrLv5Zujx1tYJRbwJrNupsohAH8qeq
	m+ar3E82f+CuP9Dw==
Subject: Re: [PATCH net-next v3 4/8] net: dsa: Add tag handling for SoC-e
 switches
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Fri, 25 Sep 2026 14:46:40 +0200
In-Reply-To: <20260924104003.A49F31F000FF@smtp.kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-4-ddebafcb9ba7@linutronix.de>
	 <20260924104003.A49F31F000FF@smtp.kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 10:40 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] net: dsa: tag_sdsa: unsupported VLAN tags left in hwaccel metada=
ta
> --
>=20
> commit c9312ab6752036eeab3076e94713c79223982016
> Author: Vasilij Strassheim <v.strassheim@linutronix.de>
>=20
> net: dsa: Add tag handling for SoC-e switches
>=20
> This commit adds a DSA tag driver for SoC-e switches, which use an 8-byte
> SDSA header carrying frame direction, port, and VLAN metadata. The header
> is inserted between the source MAC address and the original EtherType on
> transmit and receive.
>=20
> > diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
> > new file mode 100644
> > index 0000000000000..8cc3fa357be42
> > --- /dev/null
> > +++ b/net/dsa/tag_sdsa.c
>=20
> [ ... ]
>=20
> > +static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_devic=
e *dev)
> > +{
> > +	struct dsa_port *dp =3D dsa_user_to_port(dev);
> > +	struct sdsa_tag *tag;
> > +	u16 vlan_tci;
>=20
> [ ... ]
>=20
> > +	/* SDSA carries no TPID, so only encode 802.1Q C-tags. */
> > +	if (skb_vlan_tag_present(skb) &&
> > +	    skb->vlan_proto =3D=3D htons(ETH_P_8021Q)) {
> > +		vlan_tci =3D skb_vlan_tag_get(skb);
> > +		__vlan_hwaccel_clear_tag(skb);
> > +		tag->frame_type_port_hi |=3D SDSA_TAG_VLAN_BIT;
> > +		tag->vlan =3D cpu_to_be16(vlan_tci);
> > +	} else {
> > +		tag->vlan =3D 0;
> > +	}
>=20
> [Severity: High]
> Does this else branch leave unsupported VLAN tags (like 802.1ad) in the=
=20
> skb's hardware accelerated metadata?
>=20
> If a user configures an unsupported VLAN protocol on a DSA user port, the=
=20
> skb will still have skb_vlan_tag_present(skb) set when reaching sdsa_xmit=
().
> Because this branch does not clear the tag via __vlan_hwaccel_clear_tag(s=
kb),
> the conduit driver's MAC hardware might subsequently insert the remaining=
=20
> VLAN tag at the MAC boundary.
>=20
> Could this insertion displace the 8-byte SDSA header just pushed, causing=
=20
> the switch hardware to receive unrecognized frames and drop them?
>=20

That's right, I missed it. I will fix it in a similar way to tag_ks8995.

> > +
> > +	return skb;
> > +}
>=20

