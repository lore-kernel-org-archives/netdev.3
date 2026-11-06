Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001870;
	b=GKgkulfcLi9F/vobR6hkuE5gyNTNO0m3sdRKA6Cw4p7SWuP5a6LSC3PZL4SreohXBY3R
	 5gUEBiwcO4GPgPUvzBl3ytPoQa8ok8KlOufUVulxagqZVCzgNlJJGeGvNn6EaGuhLhsjF
	 0af4smTlbHe8CzvyUx9ILcNPUi7lqVKjnnWsZKA2W+g1Nb0pmAlqPrVcz0k0HmAa8AroH
	 sWjthHa3WB6Ih1WVVvimVhqPm7/lpSPD9McEIO2vD2YH4W2Xg8a49uavSyiOjckGJwg64
	 R4thmDAnCmbESIyZ6REBCQTS5M5X4+ZHFNewjwtMrKUjRKswJtaV/MtVxLPrQkWYmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001870;
	h=DMARC-Filter:Message-ID:DKIM-Signature:DKIM-Signature:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Hrybu1qjS55wOR2ZvJDKFOTX4UO4y9/yg/EAiu9mOeQ=;
	b=A9s/7mndhOwyB3FlOdWAQHcozUUoMmuQxrqn7QDGKT7fQFt0CP8kd+yorknOtHzuj1jK
	 XOYP3maxyMC0kkMCcigKSrOzn5cZP9v1oFgfFg2WBrMZgcXDwG3uOtXJdJlXrTuSf6DCk
	 cgu7pilPf9Hdn55//anFfPz20ua842lZtF9AzahrwZO/hyXm0CO7ZJlfjCBnS3OafxpX3
	 6dT7upWGyWO1PzITnoB27zqRF9ag2W/trDAxD1FOeWxB+p5XxGmaAKhvHMlQwMA+UxHFG
	 47T4dQTDSlIvVk4T9SxyhJm7jamW23q5WXHuzFAZhJhL5CDW85rcbSbficvGc4dQ78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Qr+zythi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=57L2AJeo;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771DA606A32F;
	Fri,  6 Nov 2026 21:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771DA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Qr+zythi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=57L2AJeo
Message-ID: <f5c7c9901aca84f0b814e5b6c153db84af826dd7.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794001867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hrybu1qjS55wOR2ZvJDKFOTX4UO4y9/yg/EAiu9mOeQ=;
	b=Qr+zythi7fd/WCMR/wC1lIwE26rtLXt2OGzMpWM7UzIMevSXxu0wb7MdigNzhn5jlurEQP
	eKImHUsS0sH9Yoz3/1yMKgzB+uT0Fa3tsUp040h6x8bGtwwk/MJZL3d2I2n94v9Y+0tn50
	XxfbSlqtzfCpltoqdh6xJWCUHQmKS3jqCH15dLCL8geld7+0GF9Cv2XtA/whES2lhOtFa0
	Rdez2AbnhPofdvz2K5MM+uDPfsv+7vZ0xpxU89RTJkJ8wtClYlAuWI/vOWTh/ylrgxcTDC
	2wwn60Jbhr282GJjbcWc+Bd5ISTMmn/dmZpANyjXbVuW7i71W86opPwMAH2qRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794001867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hrybu1qjS55wOR2ZvJDKFOTX4UO4y9/yg/EAiu9mOeQ=;
	b=57L2AJeoNrxbbDcFsBAzZ/DFjdkvyDKP3GnGuqadUE36FX+Fv2BzCEN4iw/VSR8EzIzB2O
	K3q3DWu42nW1QqDQ==
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
Date: Fri, 06 Nov 2026 22:51:04 +0100
In-Reply-To: <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
References: 
	<20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
	 <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
	 <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
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

On Fri, 2026-11-06 at 12:13 +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 05, 2026 at 03:16:48PM +0100, Vasilij Strassheim wrote:
> > Add a binding for the SoC-e SWIP multifunction FPGA IP core.
> >=20
> > Describe the shared MMIO address space and address translation for
> > the required Ethernet switch child and the optional integrated MDIO
> > controller and MMIO-controlled MDIO multiplexer.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  .../devicetree/bindings/mfd/soce,swip.yaml         | 137 +++++++++++++=
++++++++
> >  1 file changed, 137 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/soce,swip.yaml b/Doc=
umentation/devicetree/bindings/mfd/soce,swip.yaml
> > new file mode 100644
> > index 000000000000..625be299e262
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/soce,swip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoC-e SWIP multifunction Ethernet switch FPGA IP core
> > +
> > +maintainers:
> > +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> > +
> > +description:
> > +  SoC-e Switch IP (SWIP) cores integrate Ethernet switching logic, an
> > +  MDIO controller, and an MDIO bus multiplexer in one memory-mapped de=
vice.
> > +  The MDIO bus multiplexer is wired to the integrated MDIO controller.
> > +
> > +properties:
> > +  compatible:
> > +    const: soce,swip
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  ranges: true
> > +
> > +  mdio@204:
> > +    $ref: /schemas/net/soce,swip-mdio.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  mdio-mux@202:
> > +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  ethernet-switch:
>=20
> Why are you mixing children with and without bus addresses? This is
> discouraged and shows that device is not correctly represented, e.g. if
> the ethernet-switch does not have resources, then THIS device is the
> ethernet switch.
>=20

There is no hardware reason for leaving the switch child unaddressed.
Just an error that occurred while converting the binding to the MFD
model.
I will describe the switch function as an ethernet-switch@0 child node
with a reg property for it's register resources, like the ocelot MFD
binding.

> > +    $ref: /schemas/net/dsa/soce,swip-switch.yaml#
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - ranges
> > +  - ethernet-switch
> > +
> > +dependentRequired:
> > +  mdio-mux@202:
> > +    - mdio@204
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ethernet-switch@80020000 {
> > +        compatible =3D "soce,swip";
> > +        reg =3D <0x80020000 0x10000>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0x80020000 0x10000>;
> > +
> > +        mdio_parent: mdio@204 {
> > +            compatible =3D "soce,swip-mdio";
> > +            reg =3D <0x204 0xc>, <0x200 0x2>;
> > +            reg-names =3D "data", "control";
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +        };
> > +
> > +        mdio-mux@202 {
>=20
> Nodes are ordered by unit address.

I will fix that.
Sashiko mentioned scripts/dtc/dt-check-style to find this. I wasn't
aware of this before and will use it more often in the future
additionally to dt_binding_check.

>=20
> Best regards,
> Krzysztof
>=20

Thanks,
Vasilij

