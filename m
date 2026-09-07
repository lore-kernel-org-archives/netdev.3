Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28C4EE84E;
	Mon,  7 Sep 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789692; cv=none; b=mkvY8cFERXOv7uaa6iunBlxKZBsJvCHsXUTRvz7+9GvEsH3V0pXyoF68nKRLstExCvPFAxZcyEMsk/T6wAFJtmJPhXAp3DEzXd0oRiGItOr4fZJ7SxbYCGV+8Ze9ttrSZErah3WWVt6pOfqu1SbjhhgucM5vSJfwlvYKlXyT36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789692; c=relaxed/simple;
	bh=/vECnPjWxz4Am2FXUZH/BO5GH/fidy0eNYtHKdj0ayo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJ0FwNE3OdEL+qx99OQayxOkA88bpQ3pNtPX7UFuB7kErBB+OXg+wL4ffDujJnKXcdU+q1R+gtVQqjaO9LqgxUqahDRvAy0hatE5x9kycXzVkWVYTZw7VO0IJoAlqugd0p9zdPz+r2L8MOxJcHIpln3Y9lrgVT7XcBa/9TKvsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sm1WYfMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRSIr7eo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sm1WYfMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRSIr7eo"
Message-ID: <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788789687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bb91qdtQU0N5E11l6jfWxHxhaB6paVoj8BCJfLQFEs=;
	b=sm1WYfMQ0uhWCREdKJ5XwD8aTS9mdvGiLwqgIoAcLvskYFxSSkxcNcmvS5nE/Xh4L+Hvht
	8BdB7Rzk83ai3lL8tuUvP03kCB1cP4k7a5Fu/NKX1vIbNJvsNEkJfawRnAGs8w5vJeRriI
	02Z6bgEHBLYy1I2hQfHq53y0Ymkvkc2CZo7927thHHiBp+CCoCXzWPITSbAfafVM28KK8w
	zY0Dx/iltpww836xvZBBMTiddbhZAXkUyONhOj0Df0nJizlBEe2koOkRljDHh/yQtt/ZJ+
	lmBc20h9uBPXYBZZ7mldQ2c8+gHcXaPrvpmFqrXW8WQ7NG/RgWnNSgusWSSykA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788789687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bb91qdtQU0N5E11l6jfWxHxhaB6paVoj8BCJfLQFEs=;
	b=DRSIr7eoYFpI3/aOat3YDAKGZFyJHVh0FLfkxh3bj56gm3nMcswcW1t6pWeX1ccYDUdbvu
	fkGfrEVZ4iR6foAA==
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Mon, 07 Sep 2026 16:01:26 +0200
In-Reply-To: <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
References: 
	<20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
	 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
	 <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-07 at 11:21 +0200, Krzysztof Kozlowski wrote:
> On Thu, Sep 03, 2026 at 08:10:59PM +0200, Vasilij Strassheim wrote:
> > Add a binding for SoC-e FPGA-based Ethernet switch IP cores.
> >=20
> > The compatible identifies a register layout characterized by the core
> > and feature identification registers at the encoded offsets. The
> > concrete synthesis-time configuration is then autodetected from these
> > registers.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  .../devicetree/bindings/net/dsa/soce,swip.yaml     | 161 +++++++++++++=
++++++++
> >  1 file changed, 161 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b=
/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> > new file mode 100644
> > index 000000000000..508e444e10da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> > @@ -0,0 +1,161 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/soce,swip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoC-e ethernet switch IP core for FPGAs
> > +
> > +maintainers:
> > +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> > +
> > +description:
> > +  SoC-e Ethernet switch IP cores are FPGA-based switches whose feature=
s
> > +  and number of ports are selected at synthesis time. Ports can connec=
t
> > +  to CPUs, external PHYs, FPGA logic, or other switch cores. The
> > +  integrated MDIO controller provides multiple independently selectabl=
e
> > +  external outputs.
> > +
> > +$ref: dsa.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: soce,swip-00-04-0c-10
> > +    description:
> > +      Register layout with the core version register at offset 0x00 an=
d
> > +      feature identification registers at offsets 0x04, 0x0c, and 0x10=
.
> > +      Switch instances using this register layout are autodetected fro=
m
> > +      these registers and use this compatible regardless of their
> > +      synthesis-time feature and port configuration.
>=20
> There is no traceable and documented version or model name?
>=20

tl;dr
There are too many, but they are not specific enough. I think it is not
useful to use this information to define a specific compatible. Using a
set of known registers, the driver can check the active features and
capabilities and adapt accordingly, regardless of marketing names.

SoC-e shows different variants of their IP cores on their website:
https://soc-e.com/soctek-ip-cores/
SocTek is product line that covers different types of IP cores. Ethernet
switches, Timing controllers, and SpaceWire.
For Ethernet switches, there are different variants listed like Managed
Ethernet Switch (MES), Managed Redundant Switch (MRS) and some others.
Most of the variants are build of other variants e.g. MRS =3D MES+HPS
Think of it as name of a base collection of IP functionality. On top of
it you can license additional features. This do not result in a
different name. If you start with MES and buy HPS later on, you may or
may not end up with MRS.
Additionally, the actual switch is synthesized in FPGA, so the final
implementation can vary even if the same IP core is used e.g. port
number, deactivated features, etc.
This is used to bring down product costs: You can buy the same hardware,
really the same hardware - here a PLC - with a different bitstream.
Depending on the enabled features you have to pay more money for it.


> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mdios:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      External MDIO buses provided by the integrated MDIO controller.
> > +      Each child bus selects one controller output.
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +      '#size-cells':
> > +        const: 0
> > +
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
> > +
> > +        required:
> > +          - reg
> > +
> > +    required:
> > +      - '#address-cells'
> > +      - '#size-cells'
> > +
> > +patternProperties:
> > +  '^(ethernet-)?ports$':
>=20
> ethernet-ports
>=20
> > +    patternProperties:
> > +      '^(ethernet-)?port@[0-9a-f]+$':
>=20
> ethernet-port
>=20

Is there a reason for such a restriction?
The pattern intentionally follows the generic DSA binding in dsa.yaml,
which permits both ports/port@N and ethernet-ports/ethernet-port@N. The
device-specific pattern is needed here to apply the SoC-e port
constraints to both accepted node naming variants.

> > +        $ref: dsa-port.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          reg:
> > +            maximum: 30
> > +            description:
> > +              Switch port index. Supported switch configurations have
> > +              up to 31 ports, numbered from 0 through 30.

Thanks,
Vasilij
