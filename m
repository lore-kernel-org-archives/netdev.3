Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097133749EB;
	Wed, 30 Sep 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788600; cv=none; b=Pr3Cnk30TYt0htQduTZxokvZBLzEzkqLCjT9otPHQmIN25N+tAjxGKOFgIrPTdfKhcd2znn7rjIsvplW1MX7p4MFj7/guoY8PH86ayev/70c0PNynbBbAYTE50PYJfpNjqHMpRcEPmFNJMLLdEiVmsz9USsDuV+U1whnAjfeRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788600; c=relaxed/simple;
	bh=JLo+iv+3ZbYstDiMfseiwntsoZxaR3qczTVkIStRu0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFiRkgPmXWAG+VUp56bQ1/JahbFefF2O4UTNkf2V0ReaA45wuTrEkqqx6X3T/SCX0HLQS/MGBtjh4lp9iexIcZ/V74nccTVo+h2S8NLsmFxqqeGMfcuz9z9EhaRJ6CqIVEQBq4rJx/4TuZy/2e6IHfBdg8ILT4h4UbHPyPo5JXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULb93avJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o56QJTV+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULb93avJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o56QJTV+"
Message-ID: <155175624ec0e08a24bf6d5aa131ddd3b67cf005.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790788596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLWBx49x24eJ/WBj9sS9rnyLnt8D+1BPBBblQQe6xKg=;
	b=ULb93avJkBkdu/pUbJCPv9ExTHhDfOBurnZrAq0qFRP5OWTkBFqsYLioXT2E7O+a6Zr/nP
	vtgANrrcJRS92a6mX+ruXCBE0P9fpIiN/bw4gatU4mNLXb7ZNQdR1YTA84RQYJXPFbBkMp
	DEoUkvGD7PXKQQL0TwJ80wnoJVbp8rlumKjLdroX7lPgoqhgXhXTrXbvdJZdJWli1vfYyZ
	X0VRChBHTT/OnlXNjPglZxU0+OlESlKUK1q2xLnyH6un6fd/VW1/s2i3CPJiAa8olCNM3f
	jNSAu0tqXWmuPEh6Vgh9dKlesx7rWGrWh8vIo6+SSPw/CIkWbDjs+kuC5gNIHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790788596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLWBx49x24eJ/WBj9sS9rnyLnt8D+1BPBBblQQe6xKg=;
	b=o56QJTV+irplu6ofyocVA0xCZSpgUYdJoaZpRNzdSJ0MRtffPPRHUNuYcWzCew0BwkDzAZ
	DzDbHIgI+43r8ZDw==
Subject: Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Wed, 30 Sep 2026 19:16:35 +0200
In-Reply-To: <88bd3f83-ce29-4424-b536-e2ab05b8b822@lunn.ch>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
	 <88bd3f83-ce29-4424-b536-e2ab05b8b822@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-26 at 01:05 +0200, Andrew Lunn wrote:
> > +  mdio@204:
> > +    $ref: /schemas/net/soce,swip-mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description:
> > +      Integrated MDIO controller bus on the master side of the mux.
> > +
> > +  mdio-mux@202:
> > +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> > +    unevaluatedProperties: false
>=20
> > +        mdio_parent: mdio@204 {
> > +            compatible =3D "soce,swip-mdio-23-02";
> > +            reg =3D <0x204 0xc>, <0x200 0x4>;
> > +            reg-names =3D "data", "control";
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +        };
> > +
> > +        mdio-mux@202 {
> > +            compatible =3D "mdio-mux-mmioreg", "mdio-mux";
> > +            reg =3D <0x202 0x2>;
>=20
> So these two overlap? That is pretty unusual, so might be worth a comment=
 somewhere.

No, they don't. I accidentally included the entire register in the
documentation. However, this register can be split, since only 2 bytes
are used.
I will fix this in both bindings and their examples:
"reg =3D <0x204 0xc>, <0x200 0x2>;"

>=20
> 	Andrew

Thanks,
Vasilij
