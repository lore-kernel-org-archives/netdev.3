Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9353A963C;
	Wed,  9 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979588; cv=none; b=B9jG3Q9Z/otimYPOXh87otCtCiesewzE0vXHqKFYvGix3KIq4sMGUODlS4h4mSmvaVzZAqkJn5pcK/oktNCF2beO8MP+EUr6UkUgt/cNLU0VJga7CkhMK5qSX/gkDMeyePOcucNIjHSFKvtgbkKvr131PPffs5+0GwCcv2s/TeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979588; c=relaxed/simple;
	bh=iJbs1N2MKFuWsFisIHEaieRsU0Klf8pyXda23pTtHvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhNeeb8UwVBsNrpEqybRVKN7svTau3gbCK4XGo38HXaORDVZj1raNtdwj4GiOrygW3WGt12o7rhkNTlHf14EP8DO9093RnOCm6o2cyHtFTJJ99aTQxTDvN/xsyEMtwLNkBh4de68X5fZ5lSggu1QCUFY4sc4Di3ZbyLorZ0vJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tUVPDsPT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=opwomPvL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tUVPDsPT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="opwomPvL"
Message-ID: <20612d5a45783ed49927fb1075c7ea1f3293f514.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788979582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8u5DhZXIQ2/zLoxcV37DCftyaGluMdXSI9mmpu+Y3o=;
	b=tUVPDsPT+ZHCHqQTz2pJ7gaKciykMXfdxEPvUyC9pDN2fQhHqkAVgaSkohmI8uIYgqHnla
	4TMkznIzP40q95FvRam9dwEefn2/X9N5EDSkZT9rwFLn4acX6KcwMOJq/pMciLtFsR441B
	0VtzNG/nASO0YEh66F8PBW6C/QKea17GlpMNnbyoygUyfEIwqbBRb4EVtTl0Vr5r5Ybh3y
	N2bMaC+1SjgZUOl5wylZx5hVj7Aja2QD+AFi7WAY4W/k6eDpbxQT1Z/N/OFAkwzl1qQGyw
	lcuSiboyzzkHxv7LOGXg9aT9uRvrVrZcOsiIsU3Jy+xRSv9nzENanMvDFKQMcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788979582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8u5DhZXIQ2/zLoxcV37DCftyaGluMdXSI9mmpu+Y3o=;
	b=opwomPvLlmjZPPPsRN9MK2VUgkgrGnK6QLHa+zZsyc7ziv4f1Qq2vuvicuUUybw0D7z7y4
	rgcDXHE7wIFqC9Ag==
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 09 Sep 2026 20:46:20 +0200
In-Reply-To: <df6dc527-8b4a-4775-828a-2633369277cd@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
	 <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
	 <041e2884bc1aa1725a86efd413e2e3301b54d91d.camel@linutronix.de>
	 <df6dc527-8b4a-4775-828a-2633369277cd@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 21:10 +0200, Andrew Lunn wrote:
> On Tue, Sep 08, 2026 at 08:15:35PM +0200, Vasilij Strassheim wrote:
> > On Mon, 2026-09-07 at 21:04 +0200, Andrew Lunn wrote:
> > > > +    patternProperties:
> > > > +      '^mdio@[0-9a-f]+$':
> > > > +        $ref: /schemas/net/mdio.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            maximum: 30
> > > > +            description:
> > > > +              MDIO controller output index, which must be lower th=
an the
> > > > +              number of implemented switch ports.
> > >=20
> > > Is there a relationship between an MDIO bus and a port?
> >=20
> > Yes, there is a one-to-one relationship for this IP. The MDIO bus
> > selector corresponds to the switch port index.
> >=20
> > >=20
> > > I'm just wondering if the MDIO bus should be a property of the
> > > port. There are switch which have an MDIO bus per port.
> > >=20
> >=20
> > I see this model in the new NETC switch binding. I will move the
> > optional mdio node below the corresponding ethernet-port@N and derive
> > the selector from the port's reg.
>=20
> Since this is an FPGA, i assume there are no internal PHYs. Mixed mode
> is not something FPGAs do. There are sometime "interesting"
> relationships between port number and address on the MDIO bus. But
> without internal PHYs you don't need to worry about this.
>=20

Correct, the FPGA IP has no internal PHYs. Each port is associated with
a dedicated external MDIO bus.

> > > > +patternProperties:
> > > > +  '^(ethernet-)?ports$':
> > > > +    patternProperties:
> > > > +      '^(ethernet-)?port@[0-9a-f]+$':
> > > > +        $ref: dsa-port.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            maximum: 30
> > > > +            description:
> > > > +              Switch port index. Supported switch configurations h=
ave
> > > > +              up to 31 ports, numbered from 0 through 30.
> > >=20
> > > 30 seems odd. Is 31 something special?=20
> > >=20
> >=20
> > The hardware stores the port count directly in a 5-bit field, so 31 is
> > the maximum representable count. Therefore, valid zero-based port
> > indices range from 0 to 30. The switch documentation is unclear about
> > the encoding, but I tested a three-port configuration and the field
> > contained 3.
>=20
> So in theory, a 0 port switch is possible!

In theory, yes, but I prefer to treat it as invalid until it can be
tested.

>=20
>    Andrew

Thanks,
Vasilij

