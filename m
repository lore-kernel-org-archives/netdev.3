Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACD484883;
	Thu,  8 Oct 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453015; cv=none; b=dGT3gWrVWLjAeUT39VxNj8T5oL9WkzbYxLHxQcxNylj+eAKJg2PTVmCAKiAq0l6kmIZFUK4qg7hT56JszghOZGjnKYPQ2mzLtgl9BtI96qugosjBf8wrbwA8RGpgm5N7RFxferztZr337KjDPVGqIYjrvcnKHBe7xd9sUf24XEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453015; c=relaxed/simple;
	bh=weeyI+U/YPol1iP2qAwQITPUDIdQbfMYarxc3t+6YMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgH0R+SCy1J/CtDBAI+F7WhBwedmFfSyHcFmfPTCiqOCgxNgYYPHrRn3sA9alQ9x5w0WHBfKNmgWlOSn3MHy1TYGRpQzzrBa57jN3T0f3SyKsjTXWUMc5OMRz0v7CHtqc/M6Rg+3VLwh3k4BPQQQ5CfbuYv5oBrLosS4T42W7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pt7fEFK5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN3VNVJj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pt7fEFK5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN3VNVJj"
Message-ID: <35b4bc5dcd6a6340e98361570d304fedb099ae86.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791453011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko2mDoLtJha0Y2zjgpnISDGHYPySL+44YDXgqu0NN/g=;
	b=pt7fEFK5gShPCrHARjhafhmT8R22KQNOg5RxhHv3cMFFmUlZOOaQqsFGRtaMmAL76ALr4a
	kIvN+VlOq+etg9mLP4lQYs66NL9mNRJadWYn+R5W8T/045i7iw43BVAFJ///Y6k/sKNT/U
	vHgUK2ULFYaNPHSj189G0VZ09Ug/TuDIMGjbHe9TjA7iLr71MjGtJu9SWSFcrIL27XWpVF
	yol4ZiXSW1wloeAAbsLHOoMeHLjPueFtuDPdJzTdQ1E4HHcx9yj1FZ1xOS0tCE0KOXt+5u
	69S4wII0a1+NeKlHCht8W9ZOTdjFs4cya29hB7ruJALhQmKEleUezsGrrAGE7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791453011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko2mDoLtJha0Y2zjgpnISDGHYPySL+44YDXgqu0NN/g=;
	b=LN3VNVJjLsScd/fVUptjuUhNOkM4O3nEr2LGUIRoc5cy7g5E4IsCpthRXbWcFuSlXLqWlG
	tUiOARBFnYyuZpAg==
Subject: Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,  Heiner
 Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  netdev@vger.kernel.org, Martin Kaistra
 <martin.kaistra@linutronix.de>,  Benedikt Spranger
 <b.spranger@linutronix.de>
Date: Thu, 08 Oct 2026 11:50:10 +0200
In-Reply-To: <20261007205457.GA244932-robh@kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
	 <20261007205457.GA244932-robh@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-10-07 at 15:54 -0500, Rob Herring wrote:
> On Wed, Sep 23, 2026 at 12:39:30PM +0200, Vasilij Strassheim wrote:
> > Add a binding for SoC-e FPGA-based Ethernet switch IP cores.
> >=20
> > The compatible identifies a register layout characterized by the core
> > and feature identification registers at the encoded offsets. The
> > concrete synthesis-time configuration is then autodetected from these
> > registers.
> >=20
> > Describe the Ethernet ports and the optional integrated MDIO controller
> > with its generic MMIO mux and child buses.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  .../devicetree/bindings/net/dsa/soce,swip.yaml     | 162 +++++++++++++=
++++++++
> >  1 file changed, 162 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b=
/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> > new file mode 100644
> > index 000000000000..d614fb2a29d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> > @@ -0,0 +1,162 @@
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
> > +  to CPUs, external PHYs, FPGA logic, or other switch cores. An integr=
ated
> > +  MDIO controller accesses the per-port external buses through a mux.
> > +
> > +$ref: dsa.yaml#
>=20
> Doesn't look like you use any DSA properties. Can you use=20
> ethernet-switch.yaml instead. Also, if you don't have any custom=20
> properties, you need to ref "dsa.yaml#/$defs/ethernet-ports" instead.

Yes, I will use dsa.yaml#/$defs/ethernet-ports.
This will also make the local dsa-port.yaml reference and
unevaluatedProperties: false redundant, so I will fix this as well.

>=20
> > +
> > +properties:
> > +  compatible:
> > +    const: soce,swip-00-04-0c-10
> > +    description:
> > +      Register layout with the core version register at offset 0x00 an=
d
> > +      feature identification registers at offsets 0x04, 0x0c, and 0x10=
.
>=20
> Do you expect these to change? Kind of an odd compatible, but okay...

No, I don't expect them to change. But since this is FPGA IP which is
easy to be changed, I would not rely on them either.
Anyway, I haven't found a better solution yet. MV88E6xxx has a similar
approach. More generic compatible is not a viable option.


Thanks,
Vasilij

