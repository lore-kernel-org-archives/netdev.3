Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E8438E5C5;
	Wed,  7 Oct 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407096; cv=none; b=P+4HqmU/FytMbyQJYQAxMmu77L7j71si7Cr825t+VDfeyj0WXCdI0THHE0gxvO1dt12bsXa+cCEu65ZN8ienm7viFO25JocZKvwzqKfsO8GGHWQJCBbRjw76jiXBXWV86/d+7qZ7FneiA2q2xvUILxBQA1t5xLd4w1PbFrVneS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407096; c=relaxed/simple;
	bh=Ngbr0/e+6lR9ACtFSwhQ8C3hUvupgaSrFeL3IPBKRuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taJt2/xnRSesJbnQ+9zeMxH4W9DKWGlPeSFxOxAcByfd1p7Cvho9h321dJmTEKcRVYH5ltx/uShFo8mhnRYDJAwso91TQvkw8vfbu+rQGU1Fh17165uPUDDi9kpP0Xc+Jn5StDp8n8mgTtkFqYQlOt3TspQDHH/CTvBoP8fICh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMOnkCXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMOnkCXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5141F000FF;
	Wed,  7 Oct 2026 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407095;
	bh=HTCAZdYlFLqyhq9/HWTd2FhXBlVeS9NujKKqPevSK8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IMOnkCXmCWYqPahlvJ15fWPbVRBgTDXS73VZTW3FojXbwLJ7ozSXfIH19GW5moikL
	 Nl4G0vZfcRyjftsIA5FoS9RvNLDQIBFX0ZTU0CQ389PmNAQ9kz3H2jEYumnHaP+r/5
	 4Qzo0g31c5pyyDlBNCxM8byOuz7fPnJFmeOqb4ubUykcW8OjDiCiBMn03I7t56IuL8
	 iot6cat47ID36kSRFT5qcK3Uk2IUcs5cXv4x/8jND+bpXdozQDKZqxeYyqOk2xTFhY
	 aqKG1sb4MBW/DrmCguX9DEUHi7ylsmEXDsAntHjnhxEw2vatu81JD6Ay+Z+uhsyHGz
	 kNqyxjRrSze5Q==
Date: Wed, 7 Oct 2026 16:04:54 -0500
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
Message-ID: <20261007210454.GA281943-robh@kernel.org>
References: <20260927212929.593366-1-kyle.swenson@est.tech>
 <20260927212929.593366-2-kyle.swenson@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927212929.593366-2-kyle.swenson@est.tech>

On Sun, Sep 27, 2026 at 09:29:48PM +0000, Kyle Swenson wrote:
> Add the LTC4266 Power Sourcing Equipment controller device tree bindings
> documentation.
> 
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> new file mode 100644
> index 000000000000..e11c9d601eee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology LTC4266 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kyle Swenson <kyle.swenson@est.tech>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc4266
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  channels:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Defines the 4 physical delivery channels on the controller that can be
> +      referenced by PSE PIs through their "pairsets" property. The actual port
> +      matrix mapping is created when PSE PIs reference these channels in their
> +      pairsets.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^channel@[0-3]$':
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          sense-resistor-micro-ohms:
> +            description: Sense resistor connected to the channel's MOSFET, used
> +              for current measurement and for overcurrent detection. The I_CUT
> +              and I_LIM register encodings depend on which value is fitted, so
> +              a wrong value programs the wrong thresholds.
> +            enum: [250000, 500000]
> +
> +        required:
> +          - reg
> +          - sense-resistor-micro-ohms
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +  pse-pis:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^pse-pi@[0-3]$':
> +        type: object
> +        additionalProperties: true

This cannot be true. That allows adding any property.

> +        properties:
> +          pairsets:
> +            description: The LTC4266 delivers power to a PI over a single
> +              pairset, driven by one of the controller's four channels. There
> +              is no 4-pair mode spreading a PI over two channels, so exactly
> +              one channel phandle is expected.
> +            maxItems: 1
> +          pairset-names:
> +            maxItems: 1

An empty node is valid? Needs 'required'.

Rob
