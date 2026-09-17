Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D2484896;
	Thu, 17 Sep 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657320; cv=none; b=AAYkuksxgxV2lKt3DMwn3RGaIa/u+376ZbWnA1athcvirxZ0BzJ0R61WHhzkSR6jKDE5VX4KW8YYG52FmwTSRnjXClmonnIlESgbN3eG0SzKUQB4V5XJ2B3Qt8hoRisy2EsE/lLfbWINmIk7R3P9BF93m9KLdLY82sFlrWVpNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657320; c=relaxed/simple;
	bh=pkIp2gWsjmcdX+xbNoG1bAuSnOqurq9yHfBZKsEXwLg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQmU6KtAoMxZQGdJU3q6b5eAnecIEXKFQTWkrYBHqbCLkfq8wSzJ2oA+6ZOr354HY66TlvW1o0DRmsGm7YvJiTGcHR8twTu2ZLcL+PbkDBQBKAJr8O4vj8O/J5M1AVWdVGgQkFHogftECClqaxoWNCIRbtQ6Mqh/zXT9TZ+afcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKig7GNa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKig7GNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B61F00893;
	Thu, 17 Sep 2026 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657303;
	bh=KtOTgB5/Il5NLwQsZVShDZ3k0NEhXYXcx62arKV8Ac4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RKig7GNaMT5gAJNpwmDRAy0iRE5Jr6iHdtn0vLLPPFyhetglMTfKnVBWoOQIjiGsy
	 655QicqUJFIOmYd1Kvr/x3euWznMX/5JKNgenGaiBO/QnCmbKDu5QUCHJHHBn/pT4s
	 NyH3RXu9pbvGYLv+sbbvB+kTwlv650H5EgPhEXcuSbIS4cP0y0+lFpbAGBkTNJkTHT
	 GDkH4wpE5sSH988sMWjTFqn+LxADTbPF6a+TYgiJLtUGUTJUhsSBoBIDFhBM3BOs5K
	 0G2nSKoTh8VGGb4QLzr2uPF5re7Bl8Og5ll7GDvYTe+NUtv2iXANb1XUExMr30ctWA
	 UCWZ7k7ReWguA==
Subject: Re: [PATCH net-next v9 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:42 +0000
Message-ID: <178965730225.22033.7543711523992590033@kernel.org>
In-Reply-To: <20260915000015.80480-3-arouhi@sitime.com>
References: <20260915000015.80480-3-arouhi@sitime.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The binding asserts fixed hardware counts (four PLLs PLLA..PLLD,
  8 individually selectable inputs, 8 outputs on SiT95317 / 12 on…

--

dt-bindings: dpll: add SiTime SiT95316 clock generator

Adds a YAML binding for the SiTime SiT9531x family (SiT95316/SiT95317)
of I2C-controlled clock generators described as DPLL providers, with
four PLLs, up to eight inputs and up to twelve outputs.  Also adds a
MAINTAINERS entry for the new binding.

> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> new file mode 100644
> index 0000000000000..e71ee3611a830
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> @@ -0,0 +1,181 @@

[ ... ]

> +  Both parts have 4 differential input pairs whose lanes can also be
> +  driven independently as single-ended references, so 8 inputs are
> +  individually selectable.  SiT95317 drives 8 outputs, SiT95316
> +  drives 12.

[ ... ]

> +  sitime,pll-fvco:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 4
> +    maxItems: 4

[ ... ]

> +  sitime,output-pll-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 8
> +    maxItems: 12

[ ... ]

> +allOf:
> +  - $ref: /schemas/dpll/dpll-device.yaml#
> +  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the
> +  # output-pll-map length to the variant so a SiT95317 node cannot
> +  # describe more outputs than the part has.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sitime,sit95317
> +    then:
> +      properties:
> +        sitime,output-pll-map:
> +          maxItems: 8
> +  # SiT95316 has 12 outputs.  When the map is supplied it must describe
> +  # all of them, otherwise the trailing outputs are left ambiguous.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sitime,sit95316
> +    then:
> +      properties:
> +        sitime,output-pll-map:
> +          minItems: 12

[Severity: Low]
This isn't a bug in the strict sense, but the per-variant bounds here only
constrain the vendor properties, while the properties inherited from
dpll-device.yaml that describe the same hardware stay unbounded.  Was that
intentional?

The description states 4 PLLs, 8 selectable inputs, and 8 outputs
(SiT95317) or 12 outputs (SiT95316).  sitime,pll-fvco is pinned to exactly
4 entries and sitime,output-pll-map is bounded per variant, but
dpll-types in dpll-device.yaml has no length constraint:

  dpll-types:
    description: List of DPLL channel types, one per DPLL instance.
    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
    items:
      enum: [pps, eec]

so a node for this 4-PLL part can list five or more channel types and still
pass dt_binding_check.  Would adding dpll-types with maxItems: 4 here make
that match the hardware?

Similarly, pin subnodes come from dpll-pin.yaml, which deliberately leaves
the hardware index open:

  reg:
    description: Hardware index of the DPLL pin.
    maxItems: 1

With no per-variant maximum, input-pins/pin@9 validates cleanly even though
only 8 inputs are individually selectable, and a SiT95317 node can declare
output-pins/pin@8 while the same DTS is limited to an 8-entry
sitime,output-pll-map, i.e. the two descriptions can silently disagree.
Since sit9531x_prop_pin_fwnode_get() in drivers/dpll/sit9531x/prop.c looks
up the child whose reg matches a driver-generated hardware index, an
out-of-range pin node is silently ignored rather than rejected, so a
mistyped index gives no diagnostic.  Would per-variant reg maxima on the
input-pins and output-pins children be worth adding alongside the
output-pll-map constraints?

For context, the already merged microchip,zl30731.yaml (5 channels, 10
inputs, 20 outputs) is unbounded in the same way, so this looks like
existing looseness in the dpll bindings rather than something specific to
this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
