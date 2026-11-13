Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596864;
	b=s28pIPN1HXE59oZD0ibB6EMQqO6cDR4K5skA7NMh+c99KVQV/uOzCkgYkmyi9WXvTdwH
	 gBVhi/Nh+XaVGWCsUYBnfsqdj2Ov+xLg/XkYOrMzkMP3p51lhSVkKnKHNt65/IwUvM/8o
	 FBJN8s/WE7F7gjOxr3B/kFMVZ3drfjMP7mFe0cwdOhmn7qmJY7COzKF0pWWoY96gO7KpW
	 tauKJ3Zf1jD+/vL0d0V+XQQX4Fh62WPLf1HC71w0HgampUzw1G9sw17oqhl5vvV8bgw+w
	 QXQ7QpUINqhFrezo9MLHPfs7p9Dr8mxFXQKdKmzwVmmpBu44/F179oTMH2O1ORcaEww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596864;
	h=DMARC-Filter:Message-ID:DKIM-Signature:DKIM-Signature:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HUWxRSNQt/U1xRTYDTiSTmQlq8PC+DwLe0ilelIqGno=;
	b=EXaDixNTww0+yCw6p30cEQMAJZnQhpPTy06YTZUl4ReP3krn2Vc3kYbZeqeBMbWWiyre
	 Z8RpY158ie/PCdkE8DiZzTIGyioWoGtOqo1V3IxP2p1W9/GvYfgbqd1z1/eDRLl+sk3Pv
	 97uwf0fJmz1/dhNDJHi8dhW5wG+AmeQW/0wFvXT8zsUZeALsR82coqQozYlY41pk/PaLm
	 GWqUlYljTvVHOakdBhRYsrym027j8AJitDKjwAD2pZF8sNbKFYHw5kws+HYSkiuWWacfn
	 lpG5U8156X4PCWL8J7+XW+dXhQvEBcYUPhD5H6b6FxFtpNdJ6Iz0PTK9SWkmaaI4eUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=WYY41mQK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VWpC1hAE;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6087606A32E;
	Fri, 13 Nov 2026 19:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6087606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=WYY41mQK;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VWpC1hAE
Message-ID: <fe5b70739f9263e651562f6ed295b05e53f59704.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794596862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUWxRSNQt/U1xRTYDTiSTmQlq8PC+DwLe0ilelIqGno=;
	b=WYY41mQK698YIIT7dHjzOuGnuiulRvHQvF8ybAKAT6Edkrsecfky9I0j2UclWLMsCkFS2G
	dqQXSYFv3OAmBN6ysOLvObOka/o4KrJDzj/R1U7dVGWuS61zGFkfEXjZay2IkMLRy+unFX
	98Zdh9U3lQSr9BeKN/IrQFNvDIsa9xcchjPN6/Qkg34i7+a7CaHkOkwFGRN9su4RiCx9rG
	snuI3vprqG+2UPNqSHJO4tqrv7TSHlBPZlN+CUPExY+8xx9oW1p6hBGdsgG3e7a4awjChG
	v/0A+Z7euBpW6GClwy/sIs+Q0m0uZcPqDehRxtM/L3W8xhMrhPymqC0OGv+h7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794596862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUWxRSNQt/U1xRTYDTiSTmQlq8PC+DwLe0ilelIqGno=;
	b=VWpC1hAEBti0QIMScZND8VCicAOhC9dLpzAYpryeEac6v6pvfVqQYoSoWn9ZTRM9xjLcoW
	tclGxiPB+xfCSqDA==
Subject: Re: [PATCH net-next v4 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch function
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
Date: Fri, 13 Nov 2026 20:07:41 +0100
In-Reply-To: <20261112-unselfish-congenial-waxbill-c7f9e3@quoll>
References: 
	<20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
	 <20261105-devel-vstrassheim-soce-dsa-ml-v4-3-02f3cde2afa1@linutronix.de>
	 <20261112-unselfish-congenial-waxbill-c7f9e3@quoll>
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

On Thu, 2026-11-12 at 11:33 +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 05, 2026 at 03:16:47PM +0100, Vasilij Strassheim wrote:
> > Add a binding for the Ethernet switch function integrated into SoC-e
> > SWIP cores.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  .../bindings/net/dsa/soce,swip-switch.yaml         | 96 ++++++++++++++=
++++++++
> >  1 file changed, 96 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip-switch=
.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml
> > new file mode 100644
> > index 000000000000..daac779c466d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/soce,swip-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoC-e SWIP FPGA Ethernet switch function
> > +
> > +maintainers:
> > +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> > +
> > +description:
> > +  Ethernet switch function of the SoC-e Switch IP (SWIP) FPGA core. Th=
e port
> > +  count and presence of VLAN and STP register blocks depend on the FPG=
A
> > +  synthesis configuration.
> > +
> > +$ref: dsa.yaml#/$defs/ethernet-ports
> > +
> > +properties:
> > +  compatible:
> > +    const: soce,swip-switch-00-04-0c-10
> > +    description:
> > +      This compatible identifies the register layout; its suffix gives
> > +      the offsets of the core version and feature identification
> > +      registers (0x00, 0x04, 0x0c, and 0x10). Port counts and optional
> > +      features depend on the FPGA synthesis configuration and are
> > +      detected at runtime using this register layout.
> > +
> > +  reg: false
> > +
> > +  reg-names: false
>=20
> I don't get why do you need these two above?

They are redundant here. I will remove/fix them as part of the binding
update once we have agreed on whether to keep the MFD model.

>=20
> > +
> > +  ethernet-ports:
> > +    type: object
> > +    patternProperties:
> > +      '^ethernet-port@[0-9a-f]+$':
> > +        type: object
> > +
> > +        properties:
> > +          reg:
> > +            maximum: 30
> > +            description: Switch port index, from 0 through 30.
> > +
> > +          phy-mode:
> > +            enum:
> > +              - mii
> > +              - gmii
> > +              - rmii
> > +              - rgmii
> > +              - rgmii-id
> > +              - rgmii-rxid
> > +              - rgmii-txid
> > +
> > +        required:
> > +          - reg
> > +          - phy-mode
>=20
> Best regards,
> Krzysztof
>=20

Thanks,
Vasilij

pw-bot: changes-requested
