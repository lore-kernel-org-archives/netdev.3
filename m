Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327019;
	b=P8VXeAUgGT89SpLhXYuFPqJKr6kxWlseA4JGxRPCKS2uY/hLB3E/Iimt2dIk8veTf4HG
	 0qlaKt2eQQBYwLqvFfoT+pthn6vNm5M61tM8rQWKakzV4oWcCO7C2VBDxdVdasCuzmeMZ
	 Tqk09namrkgEuVek+DvR9eEKWhVqUvSDT2RkypgKaIkqrxNyMSa1aKwUZY0UBbWTZJkAI
	 UY0W/w3IWPJzf2jUObDKgnhNYE4HADJJfpYwveMhdpXNRxKQDIRSkC2oa0NXGeIwEiLm4
	 YCLAziWIaMICuequ0b9edSxCvKVmJyx/wjB1KF5JvwVG66CTKffBuJ6iWnfAn2hU7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327019;
	h=DMARC-Filter:Message-ID:DKIM-Signature:DKIM-Signature:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FRuAqnYyFGI3EP5jhxTkn/d3PhY5cH92FYdb7x+TtB8=;
	b=12bKK1L9h0pdy4h5JhaiQ7l+ODHn8f3lYwQqTGGqdViv6XX5zWoa2Ly5ifjsxUMgc2BA
	 1CFZb3jnz61Vh9zphMPUX//9uQdy1R2czwGhrOFgWovgHyjkY7qn8zgh8JaPRibEwljyX
	 +hYLE5MYXCQQk6GE8xUrzEr2oZIv9Xbk0ABuoTPKDU9kEzn5XgLTdCw2KC0fA+U7Bg4hm
	 o9iz5+MIDZhvj5+NQ477i5TIL5PqnaeIdYX9oxtFvMLlkwD8aI+lyuC+gqEV0sOwlDQ6M
	 spBmgjyqLoQ5zONoOO1j78TqY3aLARjEm9DYAjUxJ1xenwMxnOpDNJvJRnfSHK55FhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DcKWCGdo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mf2+VrQB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9560A381A;
	Tue, 10 Nov 2026 16:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F9560A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DcKWCGdo;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mf2+VrQB
Message-ID: <cc35b2127b04772f05948ac51c8faa5ef07da0b0.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRuAqnYyFGI3EP5jhxTkn/d3PhY5cH92FYdb7x+TtB8=;
	b=DcKWCGdoLsr5BypGSISy+81kuWGKqGX7oDJRmI88rB9xcHk3G2T1QSetSuTvCMysdAIIUW
	s3oV6gZX0mluQvH8+U6jrSepGWnLx6a4vgHJ7NUPD2xfZvXVvP9S8c8cHpqndIvt87nNrB
	/bZCvpSrTfSu5mW7JYKzihkMoZrlwf7lRaJs1bcUUFeDjOF5W6Ys23rRnCKPWQsjTi4iCp
	qqNd+vPmcD6kt+LQVbZMFXwBwMEJNUez7PRzn+dyfKue7B+9TNSdKxFWhIfAeEeL4yFRyS
	HmVS0n98Mpp2FOGnPJAv7egbI+FepAYa27pSizTX8RsAkpUcoKtGN9ILkZlWRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRuAqnYyFGI3EP5jhxTkn/d3PhY5cH92FYdb7x+TtB8=;
	b=mf2+VrQBVLH2r3NQRUxdCKuIej6hKePUGi7N6mN0ogRC2orCIZ38tqM1XNF+uqyZWQFS/C
	47ioVG+ovAxlh+Dw==
Subject: Re: [PATCH net-next v4 4/8] dt-bindings: mfd: Add SoC-e SWIP parent
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Eric
 Dumazet <edumazet@kernel.org>, Lee Jones <lee@kernel.org>,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, mfd@lists.linux.dev,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 10 Nov 2026 17:10:15 +0100
In-Reply-To: <f5c7c9901aca84f0b814e5b6c153db84af826dd7.camel@linutronix.de>
References: 
	<20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
	 <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
	 <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
	 <f5c7c9901aca84f0b814e5b6c153db84af826dd7.camel@linutronix.de>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-06 at 22:51 +0100, Vasilij Strassheim wrote:
> On Fri, 2026-11-06 at 12:13 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Nov 05, 2026 at 03:16:48PM +0100, Vasilij Strassheim wrote:
> > > Add a binding for the SoC-e SWIP multifunction FPGA IP core.
> > >=20
> > > Describe the shared MMIO address space and address translation for
> > > the required Ethernet switch child and the optional integrated MDIO
> > > controller and MMIO-controlled MDIO multiplexer.
> > >=20
> > > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > > ---
> > >  .../devicetree/bindings/mfd/soce,swip.yaml         | 137 +++++++++++=
++++++++++
> > >  1 file changed, 137 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/soce,swip.yaml b/D=
ocumentation/devicetree/bindings/mfd/soce,swip.yaml
> > > new file mode 100644
> > > index 000000000000..625be299e262
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> > > @@ -0,0 +1,137 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/soce,swip.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SoC-e SWIP multifunction Ethernet switch FPGA IP core
> > > +
> > > +maintainers:
> > > +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> > > +
> > > +description:
> > > +  SoC-e Switch IP (SWIP) cores integrate Ethernet switching logic, a=
n
> > > +  MDIO controller, and an MDIO bus multiplexer in one memory-mapped =
device.
> > > +  The MDIO bus multiplexer is wired to the integrated MDIO controlle=
r.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: soce,swip
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 1
> > > +
> > > +  ranges: true
> > > +
> > > +  mdio@204:
> > > +    $ref: /schemas/net/soce,swip-mdio.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > > +  mdio-mux@202:
> > > +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > > +  ethernet-switch:
> >=20
> > Why are you mixing children with and without bus addresses? This is
> > discouraged and shows that device is not correctly represented, e.g. if
> > the ethernet-switch does not have resources, then THIS device is the
> > ethernet switch.
> >=20
>=20
> There is no hardware reason for leaving the switch child unaddressed.
> Just an error that occurred while converting the binding to the MFD
> model.
> I will describe the switch function as an ethernet-switch@0 child node
> with a reg property for it's register resources, like the ocelot MFD
> binding.

It looks like I need a different name for the MFD parent to avoid a
naming collision with the ethernet-switch@0 child. I checked other
bindings but could not find a suitable example.

I would appreciate any suggestions for a suitable name for the parent
node representing the FPGA IP core. It mainly acts as a container for
its child devices. I am considering "bus", "ip-core" or "shell".

> > > +    $ref: /schemas/net/dsa/soce,swip-switch.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#address-cells'
> > > +  - '#size-cells'
> > > +  - ranges
> > > +  - ethernet-switch
> > > +
> > > +dependentRequired:
> > > +  mdio-mux@202:
> > > +    - mdio@204
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    ethernet-switch@80020000 {
> > > +        compatible =3D "soce,swip";
> > > +        reg =3D <0x80020000 0x10000>;
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <1>;
> > > +        ranges =3D <0x0 0x80020000 0x10000>;
> > > +
> > > +        mdio_parent: mdio@204 {
> > > +            compatible =3D "soce,swip-mdio";
> > > +            reg =3D <0x204 0xc>, <0x200 0x2>;
> > > +            reg-names =3D "data", "control";
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +        };
> > > +
> > > +        mdio-mux@202 {
>=20

