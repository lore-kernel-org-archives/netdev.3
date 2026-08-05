Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF204570FF;
	Wed,  5 Aug 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932926; cv=none; b=S0pwVvnIZuwEqF6x1URNeFvUoN6I2Ufja9gzmYDxmVgM1BjA7wU+oSazzdafzD5fOtKHEl8SDsCx6KMya7WfTMKVXx3gCruXwpxAdfCrqR60IrapI50b9/yOji3SgCiMGqfNRgLCRQOOVs0vgWpnvkln0Tuxd/BbrrUk90Q8N1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932926; c=relaxed/simple;
	bh=SRktwtXgb3YSXW0K+R9Wmo9up/n4pu6tIXj5BCqaKbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NERKd+/EJEx/yByliasqEWTYcnWkbwES5ci3mgrSeGG+li5s2mEwEm6PLhq7AVfyi+tCeZhSMHsCJS/kAytWLuo3Rg3v2UFt9wQdUjagjbIX8cxR1KOycSLfXDGOqz6fF8GxMUx3iCZoJsCDSBfd+fuO2B+z5JEfJ2xr0wAqxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSqwCE9N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHX0isOW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSqwCE9N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHX0isOW"
Message-ID: <65d78f24c081ee21ab64ba4160629b85a30527ff.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785932923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDnHUZ8OIWAMi/Q1xd1jN+X6uQh2K/tLoMklY5H9Nj8=;
	b=NSqwCE9NzRifaa8r/gf/dS1/HdqpxdLsd0WXjnvZ28rMeIocLq7S1/LYlvNZ03RSaPthKI
	LKW1Hk6iZUBWKOQcMbU8hKRC9ZH2ccNVIWhgY5q7fDZEM6UBHyte3jBSX13deGcPV9B2sF
	PcAW20h4F9fwB3wApS5bb3XY1qtlJl+CspEEv/nd/5sjI43+ChhRi3Vshu6fW8Sm2onIbL
	lq5p8IAYOEtTfoVLO5DGCLfzz6YSmu3WIWGrA9fba8QLXs2tfO6QYKTvSbyg0jq2AZk9Ef
	aZU07F75glh0Ixnn1OFzrxRIALQ2/2zpl6NU2Gi+u8K+a8wK/ujj8lie+gm4Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785932923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDnHUZ8OIWAMi/Q1xd1jN+X6uQh2K/tLoMklY5H9Nj8=;
	b=wHX0isOWk5C88dgFxZ2GJnzYEwvvq8JMxWhkfLsuc7JD8QWWAVL2f/LKOsvt7f6sb8S4b/
	QwU4XsSIqoHA/qAg==
Subject: Re: [PATCH 0/4] net: dsa: Add SoC-e DSA driver
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
Date: Wed, 05 Aug 2026 14:28:41 +0200
In-Reply-To: <a79b951c-9635-412e-8103-0e40fe49bc48@lunn.ch>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <50e4f195-f810-470b-b05a-97f622e6efc4@lunn.ch>
	 <8a5ec5c7d76d634293bd8c78a078d536ed516c08.camel@linutronix.de>
	 <a79b951c-9635-412e-8103-0e40fe49bc48@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 18:32 +0200, Andrew Lunn wrote:
> On Mon, Aug 03, 2026 at 05:22:35PM +0200, Vasilij Strassheim wrote:
> > On Wed, 2026-07-29 at 18:56 +0200, Andrew Lunn wrote:
> > > On Wed, Jul 29, 2026 at 06:36:53PM +0200, Vasilij Strassheim wrote:
> > > > Add initial support for the DSA driver for SoC-e FPGA-based (IP cor=
e)
> > > > Ethernet switches.
> > >=20
> > > Let me start with a dumb question. Is this a true soft core switch,
> > > which is synthesised and running in the FPGA? Or is it hardware at th=
e
> > > edge of the FPGA SoC?
> >=20
> > I should have made that clearer right away. This is a true soft-core
> > switch that is synthesized and runs in AMD FPGAs.
>=20
> Only AMD FPGAs? Or you have only used it with AMD FPGS?

That's what the documentation says. However the webpage says:=20
	AMD/Xilinx and Microchip supported. Other vendors to be
	supported in the future.
I don't know any more details than that.

>=20
> > I have a version in which both the MAC and the switch are synthesized
> > in FPGA, and two hardware PHYs are connected to the switch. The switch
> > provides an MDIO bus for the PHYs.
> >=20
> > >=20
> > > If it is synthesised, do we have to deal with different synthesis
> > > options? Are there registers which indicate what these options are?
> >=20
> > While setting up the switch, users will need to explore various
> > synthesis options. Once it's up and running, it should be possible to
> > load a preconfigured bitstream into the FPGA without having to deal wit=
h
> > these options in the DSA driver. The device Tree should then match the
> > configuration.
>=20
> This is where we often run into issues. The driver sometimes makes
> assumptions about how the device has been synthesised. Somebody
> synthesise it differently, it breaks, and the driver has to be changed
> without breaking backwards compatibility.
>=20
> If the hardware actually enumerates itself, tells us how it has been
> configured for synthesis, and the driver looks at these registers, you
> tend to have less assumptions and so less issues later.
>=20
> This is also one area what DT is not so great. You are not actually
> describing hardware. Clearly, it is not software, but it is malleable,
> jellyware. The less you put in DT, the more you get from the jellywere
> itself, the better.
>=20

Yes, that makes sense. With this v1, I had to work around a few
non-technical limitations. I will try to resolve these and come up with
a new version where as much as necessary is read out from the jellyware.

With further adjustments, the dt-bindings should then contain only the
bare essentials. Not more that any other DSA driver would need.

> 	Andrew

Thanks,
Vasilij

