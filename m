Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74B55C32A;
	Tue,  8 Sep 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891342; cv=none; b=RhCTBsWVPudt+6NCNEvpYk0LZRpZrPy0Cs6ap6TW4m9mqhGmrLq7ci2nxjSvwOzsqk4bjnAECu6J9IM0UlliI4jGTSLuNiD4Kdfxj9wqqUWCPuMC/VygIB/d2ZT2NEtsjGKjexcEWNOo2xSpoH43X68Rz6ail52RhibRFzGVxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891342; c=relaxed/simple;
	bh=wdb03glKPyb/dr+KcDdfARO7bioMtiZgmpmg3JqWMto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaJAAz4bC3PXE/3amfzJQjv7m+QmzuXrJJ1o1y/7yn4QYYKsP5Gc7PVnlkju1mA2DvPG37oSk3N6aoP6SONyWmaFAC15lD8mAi582w2fjR40x2ZK8WnpuIBEHIbv/JjRnAEOE90QZVKQftjouL2ZJTYHpD5/cTgT/lbms1jw9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJQZ5O1w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nJzp8fxt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJQZ5O1w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nJzp8fxt"
Message-ID: <041e2884bc1aa1725a86efd413e2e3301b54d91d.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788891336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HYGRSrp9GkL+9fhg5mRSMA8T5IY/BCdjbdlI5jBoOs=;
	b=LJQZ5O1wL62MGWK4RRDBDLHk/rFz87LbPK2LXz7fN6sRoN9CW5FlyV8Oao+IbcA/Jp7/7i
	j8ioETAZ5KeE5hiQNMJ2ctUEeTlHkIJjjPTWOgZHw47vVNOrpLMnKmr5Hpk5amw9Y9cu7n
	J380SPzWLvbf941v+HxZRo+MGpyxCXEsy8upB0bYtO9LA6yexPU89ZlXe6jFpH4GompgOd
	pA1OMJGp7Cxci+8OIQUs+3eSBsglmrAY9A8qIP729eWwnjPj9KjqhnNKVlFwE78R5OI4p/
	ghXdEzYsXm2yC1B0PUtdQoKthX9nBg6LzUPRsMaOowfZI9EyiyyP3kcDNhsuUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788891336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HYGRSrp9GkL+9fhg5mRSMA8T5IY/BCdjbdlI5jBoOs=;
	b=nJzp8fxtYV0YI56GT5rOlQD2lIDMDIouVwiyxijv8e4TsllrmhaXbs9x+q2kUsYlz0E2MW
	fC9Sh1mvYfH4pIDg==
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
Date: Tue, 08 Sep 2026 20:15:35 +0200
In-Reply-To: <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
	 <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-07 at 21:04 +0200, Andrew Lunn wrote:
> > +    patternProperties:
> > +      '^mdio@[0-9a-f]+$':
> > +        $ref: /schemas/net/mdio.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          reg:
> > +            maximum: 30
> > +            description:
> > +              MDIO controller output index, which must be lower than t=
he
> > +              number of implemented switch ports.
>=20
> Is there a relationship between an MDIO bus and a port?

Yes, there is a one-to-one relationship for this IP. The MDIO bus
selector corresponds to the switch port index.

>=20
> I'm just wondering if the MDIO bus should be a property of the
> port. There are switch which have an MDIO bus per port.
>=20

I see this model in the new NETC switch binding. I will move the
optional mdio node below the corresponding ethernet-port@N and derive
the selector from the port's reg.

> > +patternProperties:
> > +  '^(ethernet-)?ports$':
> > +    patternProperties:
> > +      '^(ethernet-)?port@[0-9a-f]+$':
> > +        $ref: dsa-port.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          reg:
> > +            maximum: 30
> > +            description:
> > +              Switch port index. Supported switch configurations have
> > +              up to 31 ports, numbered from 0 through 30.
>=20
> 30 seems odd. Is 31 something special?=20
>=20

The hardware stores the port count directly in a 5-bit field, so 31 is
the maximum representable count. Therefore, valid zero-based port
indices range from 0 to 30. The switch documentation is unclear about
the encoding, but I tested a three-port configuration and the field
contained 3.

> > +examples:
> > +  - |
> > +    ethernet-switch@80020000 {
> > +        compatible =3D "soce,swip-00-04-0c-10";
> > +        reg =3D <0x80020000 0x10000>;
> > +
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +                label =3D "lan0";
>=20
> label is another thing in DSA which is today not best practice. I
> would drop this.

I have no problem removing the label from example. I'll have to
adjust it anyway for the new MDIO bus and port relationship.

>=20
> 	Andrew

Thanks,
Vasilij

