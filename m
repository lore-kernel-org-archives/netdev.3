Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338482;
	b=cw+jYCPruWiszXt21PiiYJLuZhi4lBdFN/DR+J0zr4m6rVia6yRYJ2rbk9guauK4qCvO
	 26NtY3NS8F6KXMvinOMf0zTXtDeE+v8d+bu3+FhAag9dWkAIrYBFnTD+5gSb463AybHxp
	 OmWKLAx1i8JUsxCkLOyhsdPJTZ2EjnzVUqAwss93q8HixpHbatc2aN99TN50493pisicR
	 AvkptwRRJFp3RrYJVB3xygXtde2caukPg+Yy/BTWAd71NRXFVg0GF9pqOMYevIivE9xDY
	 dda9tWZ5XUr6HbDyFwSNt1OBJ6t5RaVlwSaA2D3J49fyumzfvons3UIV8BRihYBoNIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338482;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ipzqKLT3bXDi2K7TgqyUFEqF9jz2ws5uKIrfihQAYNk=;
	b=N/zkhXHf+CL/gC6NjBuG9FJcoq7oRmvtJPHYV2JJFKtAOk2Qu3BEGo9mdUW4oujt94xg
	 ofnMbgIX2Js2aw/4a81PllrWNADzJomhmWNFId7F/6tkfJHKc5GO2x+BMaETyFWX9+pJ8
	 48DfbTppwxSFQ2fjvW/rF+ba9oDZA8/sYjUYb1jRaCjPtVOFg5qSnFB7YT1+bfrZJ7U7x
	 oKCZBSQ8IR808rznNQiULkFg6Q+iQal3OcLYYb9kmHGDjDhKWWPwNFViF7nqO3rYeVd7R
	 eeQgd7iMjpu5Q8r2DIVKz5Gv0/2U8dipqxKKy7k+LvT34+JM10K0wmOzz1UXaXs2Gzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4asWOrs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D4606A321;
	Tue, 10 Nov 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4asWOrs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE2B1F0089F;
	Tue, 10 Nov 2026 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338482;
	bh=ipzqKLT3bXDi2K7TgqyUFEqF9jz2ws5uKIrfihQAYNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O4asWOrs71kDKItINGDb69h2cMmmBPIkNpLScXxYL4gTaOpKcEQ/NOh7yWfQs2rPE
	 Cxe7qVk8qEbQ7lfNgVKV0XvK8C2+I4BCEBvN9XW0Sl/LAOlEF/oIi8MKfj0sMWKqpr
	 SSHU+stYcG0oZsMYltgD/62bMY/tBDvLFNbG8TGi6IhCItvCezXvbNdrR4fEuWB+d/
	 6Sar5gZwF0wUpqSFHhyEeh338JDAGrGYyQbaGfMw2to73AnPqYLdaabSI7+fkv5BO2
	 DGYTmgRTV7qehodBAIrxZUdBR+zXvRfVUSozs52LLuK00P+l8utTtqSaIsRBEMowYu
	 CLPhjgoKZWF6A==
Date: Tue, 10 Nov 2026 13:21:18 -0600
From: Rob Herring <robh@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, mfd@lists.linux.dev,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v4 4/8] dt-bindings: mfd: Add SoC-e SWIP parent
Message-ID: <20261110192118.GA1412882-robh@kernel.org>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
 <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
 <20261106-judicious-penguin-of-enhancement-b28c8b@quoll>
 <f5c7c9901aca84f0b814e5b6c153db84af826dd7.camel@linutronix.de>
 <cc35b2127b04772f05948ac51c8faa5ef07da0b0.camel@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc35b2127b04772f05948ac51c8faa5ef07da0b0.camel@linutronix.de>

On Tue, Nov 10, 2026 at 05:10:15PM +0100, Vasilij Strassheim wrote:
> On Fri, 2026-11-06 at 22:51 +0100, Vasilij Strassheim wrote:
> > On Fri, 2026-11-06 at 12:13 +0100, Krzysztof Kozlowski wrote:
> > > On Thu, Nov 05, 2026 at 03:16:48PM +0100, Vasilij Strassheim wrote:
> > > > Add a binding for the SoC-e SWIP multifunction FPGA IP core.
> > > > 
> > > > Describe the shared MMIO address space and address translation for
> > > > the required Ethernet switch child and the optional integrated MDIO
> > > > controller and MMIO-controlled MDIO multiplexer.
> > > > 
> > > > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > > > ---
> > > >  .../devicetree/bindings/mfd/soce,swip.yaml         | 137 +++++++++++++++++++++
> > > >  1 file changed, 137 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mfd/soce,swip.yaml b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> > > > new file mode 100644
> > > > index 000000000000..625be299e262
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
> > > > @@ -0,0 +1,137 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mfd/soce,swip.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: SoC-e SWIP multifunction Ethernet switch FPGA IP core
> > > > +
> > > > +maintainers:
> > > > +  - Vasilij Strassheim <v.strassheim@linutronix.de>
> > > > +
> > > > +description:
> > > > +  SoC-e Switch IP (SWIP) cores integrate Ethernet switching logic, an
> > > > +  MDIO controller, and an MDIO bus multiplexer in one memory-mapped device.
> > > > +  The MDIO bus multiplexer is wired to the integrated MDIO controller.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: soce,swip
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  '#address-cells':
> > > > +    const: 1
> > > > +
> > > > +  '#size-cells':
> > > > +    const: 1
> > > > +
> > > > +  ranges: true
> > > > +
> > > > +  mdio@204:
> > > > +    $ref: /schemas/net/soce,swip-mdio.yaml#
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +  mdio-mux@202:
> > > > +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> > > > +    unevaluatedProperties: false

Given the MDIO bus and mux registers are adjacent, I don't know that 
putting the mux into its own node and driver really buys you anything. 
Can't your MDIO driver handle the muxing directly? mdio-mux-mmioreg was 
created for when you have mux registers in some completely unrelated 
block.

> > > > +
> > > > +  ethernet-switch:
> > > 
> > > Why are you mixing children with and without bus addresses? This is
> > > discouraged and shows that device is not correctly represented, e.g. if
> > > the ethernet-switch does not have resources, then THIS device is the
> > > ethernet switch.
> > > 
> > 
> > There is no hardware reason for leaving the switch child unaddressed.
> > Just an error that occurred while converting the binding to the MFD
> > model.
> > I will describe the switch function as an ethernet-switch@0 child node
> > with a reg property for it's register resources, like the ocelot MFD
> > binding.
> 
> It looks like I need a different name for the MFD parent to avoid a
> naming collision with the ethernet-switch@0 child. I checked other
> bindings but could not find a suitable example.
> 
> I would appreciate any suggestions for a suitable name for the parent
> node representing the FPGA IP core. It mainly acts as a container for
> its child devices. I am considering "bus", "ip-core" or "shell".

Krzysztof's point was combine the child and parent nodes into the 
parent. This is not really an MFD. Almost every ethernet MAC has an MDIO 
controller in it and none of those bindings are MFDs.

Rob
