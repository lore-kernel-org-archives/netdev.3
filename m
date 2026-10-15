Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652A53ED04;
	Thu, 15 Oct 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092640; cv=none; b=FWFGlcBdVRnT0FUKHLhIU0ReV7lUtjUkBx00DbTAUSYoVG6HxsmVg4yNDa2w5w+Kf7XOayKvE+mLm9eNL/euk4D6Xvtcc8OsheHi5HOIDpV5joZP0ls4uuJnWPr9O0Q7fuHFFL2in1lGZ/w2SUbBOgHPvGu80Uqn/h0bTeZbgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092640; c=relaxed/simple;
	bh=H98HpDUW+hAIVIU3VQKuIbZih8WmEreljadpm51yq2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtHguoRfzJWPIeM1v7+R3EBxFuAgKDn6QOZdN88rSUmitA3szvAfs72w1auJrXk9PLZbZN2NQTB8eaZzbJoPZLHf0dmWhRf/JydW/FkjK8Vz4Rc1IuwhtyGECP4Q3bK7g8NY3sKrK+A7J4v93UY1HmPp4EAgWPCdvo49Q7esOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXNNOahq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXNNOahq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AFA1F000C6;
	Thu, 15 Oct 2026 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092638;
	bh=ZuKHJXsKbCvkFzenoJmPSBw47riyFBoZNnA7AhR3Xak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AXNNOahqhsaTOmVsB4yo/zzfnYf37WojO5oyFjiNhO49fB6YG1AfOyqEDHyQkTFkV
	 /UIeqeoIHJsML7pmiDid9n9cv6rUlBaW4qtA5FN3KIqHCkVZFicQ/mpVpgjG1nLfqx
	 N8myBfUOxv6NTs76PbumMjPnB/CNPodWiPVtF63eIg489d3rov6heeLJUU2ZobSe0y
	 eddzHiy6q6CWOsJo0bcGzL3m4GJOTdIgGUmTgXqzNNo7AT57YSbLc9Qyr3GggXIsNf
	 NTdFIrG9129X7ukGvdU5lydAJO133F7A97t+v+5g3BTYk7671Qmg1HVDtHFj4UGo8i
	 seyPHqOHeCjJg==
Date: Thu, 15 Oct 2026 14:30:36 -0500
From: Rob Herring <robh@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Kyle Swenson <kyle.swenson@est.tech>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
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
Message-ID: <20261015193036.GD5059-robh@kernel.org>
References: <20260927212929.593366-1-kyle.swenson@est.tech>
 <20260927212929.593366-2-kyle.swenson@est.tech>
 <20261007210454.GA281943-robh@kernel.org>
 <asnpHkvHsFy2dX-9@est-xps15>
 <92efb7e8-e69d-49aa-9cf7-9dc8fc0ead99@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92efb7e8-e69d-49aa-9cf7-9dc8fc0ead99@bootlin.com>

On Tue, Oct 13, 2026 at 04:57:29PM +0200, Kory Maincent wrote:
> 
> 
> On 10/10/26 09:30, Kyle Swenson wrote:
> > Hello Rob,
> > 
> > On Wed, Oct 07, 2026 at 04:04:54PM -0500, Rob Herring wrote:
> > > On Sun, Sep 27, 2026 at 09:29:48PM +0000, Kyle Swenson wrote:
> > > > Add the LTC4266 Power Sourcing Equipment controller device tree bindings
> > > > documentation.
> > > > 
> > > > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > > > ---
> > > >   .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
> > > >   1 file changed, 180 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > > > new file mode 100644
> > > > index 000000000000..e11c9d601eee
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > > > @@ -0,0 +1,180 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Linear Technology LTC4266 Power Sourcing Equipment controller
> > > > +
> > > > +maintainers:
> > > > +  - Kyle Swenson <kyle.swenson@est.tech>
> > > > +
> > > > +allOf:
> > > > +  - $ref: pse-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - lltc,ltc4266
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  channels:
> > > > +    type: object
> > > > +    additionalProperties: false
> > > > +    description:
> > > > +      Defines the 4 physical delivery channels on the controller that can be
> > > > +      referenced by PSE PIs through their "pairsets" property. The actual port
> > > > +      matrix mapping is created when PSE PIs reference these channels in their
> > > > +      pairsets.
> > > > +
> > > > +    properties:
> > > > +      '#address-cells':
> > > > +        const: 1
> > > > +
> > > > +      '#size-cells':
> > > > +        const: 0
> > > > +
> > > > +    patternProperties:
> > > > +      '^channel@[0-3]$':
> > > > +        type: object
> > > > +        additionalProperties: false
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            maxItems: 1
> > > > +
> > > > +          sense-resistor-micro-ohms:
> > > > +            description: Sense resistor connected to the channel's MOSFET, used
> > > > +              for current measurement and for overcurrent detection. The I_CUT
> > > > +              and I_LIM register encodings depend on which value is fitted, so
> > > > +              a wrong value programs the wrong thresholds.
> > > > +            enum: [250000, 500000]
> > > > +
> > > > +        required:
> > > > +          - reg
> > > > +          - sense-resistor-micro-ohms
> > > > +
> > > > +    required:
> > > > +      - '#address-cells'
> > > > +      - '#size-cells'
> > > > +
> > > > +  pse-pis:
> > > > +    type: object
> > > > +    additionalProperties: false
> > > > +
> > > > +    properties:
> > > > +      '#address-cells':
> > > > +        const: 1
> > > > +
> > > > +      '#size-cells':
> > > > +        const: 0
> > > > +
> > > > +    patternProperties:
> > > > +      '^pse-pi@[0-3]$':
> > > > +        type: object
> > > > +        additionalProperties: true
> > > 
> > > This cannot be true. That allows adding any property.
> > > 
> > 
> > So my intent with the additionalProperties: true was to avoid
> > replicating the entire pse-pis node from pse-controller.yaml.
> > Conceptually, my goal was to inherit everything from the
> > pse-controller.yaml binding, except limit the maxItems to 1 (since the
> > LTC4266 only supports power over a single PI).
> > 
> > Is there a better way to express this?
> 
> I think you can do something like this:
>      patternProperties:
> 
>        '^pse-pi@[0-3]$':
> 
>          type: object
> 
>          $ref:
> pse-controller.yaml#/properties/pse-pis/patternProperties/^pse-pi@[0-9a-f]+$
> 
>          unevaluatedProperties: false

Yes, if you want/need to allow custom properties, like this is what I 
meant.

However, it is hit or miss if a $ref to a regex works. Instead, 
pse-controller.yaml would need a $defs section that the pattern and this 
schema can reference. Multiple levels of nodes and allowing them to be 
extended gets messy.

Rob
