Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C44EBAE2;
	Thu, 15 Oct 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092331; cv=none; b=TW1GzRSCsbMbA4tPoFeq/+oOkWWlLOFYaWf3WeCHTc5g03ckwf61U60qd6jr+P2wjoXtSqVHaVNvK/13RNWKYJv3BEnaP5SumNF2lvriSK3zb9O2UCTyzGtEenWec29fOrxFEPJyB37cXPx2eqPMbeNKmZ1jWXMZzt3Gf+05YUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092331; c=relaxed/simple;
	bh=/aDY3QvLbw7FPeyVbaZ96dHdAV8CciGipjzLko3iKMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNOvIu/qZTZrgFEoSQO3Qy0F/6yjw0xsUBef4IpjOIF6zVYmFy8GHJpMjA2FB8L9XUXT+K7K3YJ6KK5X1QMyXqJwRy79Usk4/KOdFY5+LD/cQiyVJHQtfczn7CgbzPZSojW9x0RP0nnhaN4+azRFM4s4o8Vwj9AWZX89ez5O5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flf7EuEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flf7EuEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA001F000C4;
	Thu, 15 Oct 2026 19:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092329;
	bh=5q3n8w8RnVYCDNZKQP3BeaNF8Rao1383kmsL5LXStQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Flf7EuEfYgvY4keiTrAp+xNx3tUwEpqFEwDW6GAPGyZ6cBbZINgy/tfoFbMw6sNh1
	 Xa0ANkL0yNPDfZXsxbm4H0Wib5fcDkzue7cTUmSFDSi64SxxXt+YGna2jRQZ9y8yIX
	 Sxt8twxiuPtgUp3AdXcegOr1rwh/zC0neNCyAY8bYW+JHGNAYgE1BDosVNiDJeAPg8
	 Svm8rAeNgEcAdqE2wlodlqiILF4pSRkvC1y43UV7/f84kOAttQS9AOzYpqD32aWpwg
	 wtgA/KF1nV8P0KY3eVjezfeFKGAUITtTlOeM6AvoF9puo1Z3qTTXRtjHqDmQTHWE8R
	 cT0bSSyJzgeHA==
Date: Thu, 15 Oct 2026 14:25:27 -0500
From: Rob Herring <robh@kernel.org>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Roland =?iso-8859-1?Q?Kov=E1cs?= <roland.kovacs@est.tech>,
	David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
Message-ID: <20261015192527.GC5059-robh@kernel.org>
References: <20260927212929.593366-1-kyle.swenson@est.tech>
 <20260927212929.593366-2-kyle.swenson@est.tech>
 <20261007210454.GA281943-robh@kernel.org>
 <asnpHkvHsFy2dX-9@est-xps15>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asnpHkvHsFy2dX-9@est-xps15>

On Sat, Oct 10, 2026 at 07:30:50AM +0000, Kyle Swenson wrote:
> Hello Rob,
> 
> On Wed, Oct 07, 2026 at 04:04:54PM -0500, Rob Herring wrote:
> > On Sun, Sep 27, 2026 at 09:29:48PM +0000, Kyle Swenson wrote:
> > > Add the LTC4266 Power Sourcing Equipment controller device tree bindings
> > > documentation.
> > > 
> > > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > > ---
> > >  .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
> > >  1 file changed, 180 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > > new file mode 100644
> > > index 000000000000..e11c9d601eee
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > > @@ -0,0 +1,180 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Linear Technology LTC4266 Power Sourcing Equipment controller
> > > +
> > > +maintainers:
> > > +  - Kyle Swenson <kyle.swenson@est.tech>
> > > +
> > > +allOf:
> > > +  - $ref: pse-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - lltc,ltc4266
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  channels:
> > > +    type: object
> > > +    additionalProperties: false
> > > +    description:
> > > +      Defines the 4 physical delivery channels on the controller that can be
> > > +      referenced by PSE PIs through their "pairsets" property. The actual port
> > > +      matrix mapping is created when PSE PIs reference these channels in their
> > > +      pairsets.
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      '^channel@[0-3]$':
> > > +        type: object
> > > +        additionalProperties: false
> > > +
> > > +        properties:
> > > +          reg:
> > > +            maxItems: 1
> > > +
> > > +          sense-resistor-micro-ohms:
> > > +            description: Sense resistor connected to the channel's MOSFET, used
> > > +              for current measurement and for overcurrent detection. The I_CUT
> > > +              and I_LIM register encodings depend on which value is fitted, so
> > > +              a wrong value programs the wrong thresholds.
> > > +            enum: [250000, 500000]
> > > +
> > > +        required:
> > > +          - reg
> > > +          - sense-resistor-micro-ohms
> > > +
> > > +    required:
> > > +      - '#address-cells'
> > > +      - '#size-cells'
> > > +
> > > +  pse-pis:
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      '^pse-pi@[0-3]$':
> > > +        type: object
> > > +        additionalProperties: true
> > 
> > This cannot be true. That allows adding any property.
> > 
> 
> So my intent with the additionalProperties: true was to avoid
> replicating the entire pse-pis node from pse-controller.yaml.
> Conceptually, my goal was to inherit everything from the
> pse-controller.yaml binding, except limit the maxItems to 1 (since the
> LTC4266 only supports power over a single PI).

pse-controller.yaml doesn't have the constraint there either. It is fine 
if the constraint is there. However, that means custom properties are not 
allowed in pse-pi nodes. Maybe that's fine and is certainly easier for 
the schema. If you do forsee a need for device specific properties in 
this node, then you need a $ref in this node with all the common 
properties. IOW, similar to how the graph schema is structured.


> > > +        properties:
> > > +          pairsets:
> > > +            description: The LTC4266 delivers power to a PI over a single
> > > +              pairset, driven by one of the controller's four channels. There
> > > +              is no 4-pair mode spreading a PI over two channels, so exactly
> > > +              one channel phandle is expected.
> > > +            maxItems: 1
> > > +          pairset-names:
> > > +            maxItems: 1
> > 
> > An empty node is valid? Needs 'required'.
> 
> I thought the 'required' comes from the pse-controller.yaml binding.
> If I adjust the example dts in the binding with something like

Indeed. My mistake.

> 
>            pse_pi2: pse-pi@2 {
> -            reg = <2>;
> -            #pse-cells = <0>;
> -            pairset-names = "alternative-a";
> -            pairsets = <&phys2>;
> -            polarity-supported = "MDI";
> -            vpwr-supply = <&vreg_pse>;

If instead, you add 'foo-bar' property, you won't see any failure. 
That's the 1st issue.

Rob
