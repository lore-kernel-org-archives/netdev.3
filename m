Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596307;
	b=W84tTn2GzDw842WBCb+8h+7EZA5uYZeBBafkNmWzJka+ohPkFJTpFfIYdFhf/9WgIbaS
	 jxRpzY8qY7ueJ58KtKRXtl7gLq04N4LZDC7bsSrSQ5Irbd3nhG/DygYWrEZ7fYKbmRb+K
	 jPgVyI0GaqaQmZoyYjGI+W/adZtjBrrgscBBCbe2sR3xBz34Z9FGpztXGJ+HAkwdBrbKR
	 ggfeSEjTsxa4WExUg6KEeHQ9JrPPNKbAf/+SV7/G+TLTvWF9MmAuq1705QEgO3gOT67YV
	 3O+P56sURtpeJvJGGPiewqnNRpiDF4GFYK/bfgWw58qEU0xI0HlmyHd+0+Gd+2/ndkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596307;
	h=DMARC-Filter:Message-ID:DKIM-Signature:DKIM-Signature:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lEeskuJPkdiI8gE2TYZrxOjdiP0LZZey/2Bh096XvUk=;
	b=Ic/u5TAUfed0xmSi3K3Bzsi3IhsZ3Mc6JmzbexayKRXhI3AtLLGZ0dyFZW/6xzXLO0TN
	 ZQnoM51mdBkNR6KRL41Kw9bRVTCmwtIXSs4zF4sb5NP4camMAEheqsbZR9vH3mLJoPus9
	 Tfo0PntJmUp4OaN8BD3M8qU6mV/+L6/PyHNfDpRVuBbosY+HxIDkgdfJ8lYmpmPtWEEl9
	 R0jZ4M1JqIRCzZX1/vLjZDaguFWRTvi1FiY/02rBjBk9yaDrymLF1sHZut2/Cqoo/csKU
	 Mmb3BlVJHxkrXqmIlzMosWtuoiDKX/gTHC3daaBjQpfEJV/7tj17PQsxCqRxDoSt+9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Nsa5LHdz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="+/Q+661T";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D16071069;
	Fri, 13 Nov 2026 18:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 379D16071069
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Nsa5LHdz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+/Q+661T
Message-ID: <5a6183e3480a0d910e275acf591e2db8700da827.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794596304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEeskuJPkdiI8gE2TYZrxOjdiP0LZZey/2Bh096XvUk=;
	b=Nsa5LHdz+ZYikhtmHbjxEddO/69fFul88+8iEoKxSL3lTvhRV1XLziHTU3MeQJ3m85tJeb
	2Kd2ZM3rvEnfGugLwHF3OZt+vfXsl3gaBBE7aGESxEYk2fh/Xs6aWabHfnXb6qozVC3Ijc
	btF/VsGDwPDS7lJzT0J1HHBG6C4hnnDf2PUHntndrG6ju0R13uLb6VnDbkxPpQoCOpILUq
	uFekou8wbBekyhInQWdA9plgpMznKFC8iTfKdW8K1FaXLC6BZ0lKADdgf/QHcvjbhXAF/S
	s89ezdujqXDPsv8Za0myV9KOVA+64E+v3yvyI2gKyWq6ddU7nkBrP3KWiT17UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794596304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEeskuJPkdiI8gE2TYZrxOjdiP0LZZey/2Bh096XvUk=;
	b=+/Q+661TL+IzyNJ7cFVuJ+g+Wd94X6upSp9cBnHdlJnTfdeNxCSPFyYNSd6A5eAhlhLKSm
	HqZhgCH0i26RAqBw==
Subject: Re: [PATCH net-next v4 4/8] dt-bindings: mfd: Add SoC-e SWIP parent
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, Lee
 Jones <lee@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  netdev@vger.kernel.org, mfd@lists.linux.dev,
 Martin Kaistra <martin.kaistra@linutronix.de>, Benedikt Spranger
 <b.spranger@linutronix.de>
Date: Fri, 13 Nov 2026 19:58:21 +0100
In-Reply-To: <20261110192118.GA1412882-robh@kernel.org>
References: 
	<20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
	 <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
	 <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
	 <f5c7c9901aca84f0b814e5b6c153db84af826dd7.camel@linutronix.de>
	 <cc35b2127b04772f05948ac51c8faa5ef07da0b0.camel@linutronix.de>
	 <20261110192118.GA1412882-robh@kernel.org>
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

On Tue, 2026-11-10 at 13:21 -0600, Rob Herring wrote:
> On Tue, Nov 10, 2026 at 05:10:15PM +0100, Vasilij Strassheim wrote:
> > On Fri, 2026-11-06 at 22:51 +0100, Vasilij Strassheim wrote:
> > > On Fri, 2026-11-06 at 12:13 +0100, Krzysztof Kozlowski wrote:
> > > > On Thu, Nov 05, 2026 at 03:16:48PM +0100, Vasilij Strassheim wrote:
> > > > > Add a binding for the SoC-e SWIP multifunction FPGA IP core.
> > > > >=20
> > > > > Describe the shared MMIO address space and address translation fo=
r
> > > > > the required Ethernet switch child and the optional integrated MD=
IO
> > > > > controller and MMIO-controlled MDIO multiplexer.
> > > > >=20
> > > > > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > > > > ---
> > > > >  .../devicetree/bindings/mfd/soce,swip.yaml         | 137 +++++++=
++++++++++++++
> > > > >  1 file changed, 137 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/mfd/soce,swip.yaml=
 b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..625be299e262
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> > > > > @@ -0,0 +1,137 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mfd/soce,swip.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: SoC-e SWIP multifunction Ethernet switch FPGA IP core
> > > > > +
> > > > > +maintainers:
> > > > > +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> > > > > +
> > > > > +description:
> > > > > +  SoC-e Switch IP (SWIP) cores integrate Ethernet switching logi=
c, an
> > > > > +  MDIO controller, and an MDIO bus multiplexer in one memory-map=
ped device.
> > > > > +  The MDIO bus multiplexer is wired to the integrated MDIO contr=
oller.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: soce,swip
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  '#address-cells':
> > > > > +    const: 1
> > > > > +
> > > > > +  '#size-cells':
> > > > > +    const: 1
> > > > > +
> > > > > +  ranges: true
> > > > > +
> > > > > +  mdio@204:
> > > > > +    $ref: /schemas/net/soce,swip-mdio.yaml#
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > > +  mdio-mux@202:
> > > > > +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> > > > > +    unevaluatedProperties: false
>=20
> Given the MDIO bus and mux registers are adjacent, I don't know that=20
> putting the mux into its own node and driver really buys you anything.=
=20
> Can't your MDIO driver handle the muxing directly? mdio-mux-mmioreg was=
=20
> created for when you have mux registers in some completely unrelated=20
> block.
>=20

What it buys me is less custom code to maintain for bus selection and
selector-value validation.

The MDIO controller and mux were combined in a previous version.
Following Andrew's suggestion [1], I moved the controller into its own
driver and stacked mdio-mux-mmioreg on top of it.
Sure, the selector is part of the same MDIO control register. But the
generic driver already provides the masked register update and
selector-value checks. My preference is to keep the current approach
to reuse existing code, even if it requires some integration and
documentation efforts.

I don't mind changing to a combined MDIO controller and mux, as done
in mdio-mux-bcm6368.c, while still using the generic MDIO mux core.

Could we agree on the preferred approach so that the binding and
driver changes stay aligned?

> > > > > +
> > > > > +  ethernet-switch:
> > > >=20
> > > > Why are you mixing children with and without bus addresses? This is
> > > > discouraged and shows that device is not correctly represented, e.g=
. if
> > > > the ethernet-switch does not have resources, then THIS device is th=
e
> > > > ethernet switch.
> > > >=20
> > >=20
> > > There is no hardware reason for leaving the switch child unaddressed.
> > > Just an error that occurred while converting the binding to the MFD
> > > model.
> > > I will describe the switch function as an ethernet-switch@0 child nod=
e
> > > with a reg property for it's register resources, like the ocelot MFD
> > > binding.
> >=20
> > It looks like I need a different name for the MFD parent to avoid a
> > naming collision with the ethernet-switch@0 child. I checked other
> > bindings but could not find a suitable example.
> >=20
> > I would appreciate any suggestions for a suitable name for the parent
> > node representing the FPGA IP core. It mainly acts as a container for
> > its child devices. I am considering "bus", "ip-core" or "shell".
>=20
> Krzysztof's point was combine the child and parent nodes into the=20
> parent. This is not really an MFD. Almost every ethernet MAC has an MDIO=
=20
> controller in it and none of those bindings are MFDs.

The suggestion to consider an MFD also came from Andrew in an earlier
discussion [2]. Since this FPGA design contains several functional
blocks, I liked the approach of grouping them under a common parent.

The IP core can also include an I2C master for accessing external
devices as a synthesis option. It also supports synchronization with
external PPS and 10 MHz reference signals. I had future Linux support
for these functions in mind. Ocelot is another switch described as an
MFD, with additional functions such as GPIO and pin control.

I am open to either approach. Could we agree on the preferred hardware
model before I update the binding and driver?

I can also provide more information if any hardware details are still
unclear.

>=20
> Rob

Thanks,
Vasilij

