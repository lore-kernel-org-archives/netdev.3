Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131B53ED12;
	Tue,  8 Sep 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871514; cv=none; b=uvoA0XJXxCfD027FSorPoNeyOHH41PWv67IUEG+9/hEC+qxqPoIPXHkGJAFLHpUN67laijIeFxgdeRLL9H7PlL6IAK7OT6hLWgWnv0KXeafZ6xzNJVawGmKbfkYig1A/PsM8rk3Ety1Be5g8Xmq8n5ivLdV4XLlSYSJIK//UkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871514; c=relaxed/simple;
	bh=qg1plquA/M8Ep3+XJ2amnCoXXie9lZd40uU/xVdyCbY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjH/vU7CsudilDhRr/uMRwWQvQXZMqPN6uyRZinTgFrfquHg05KBWegF3tYMe6fVxhiwoxt+18IIesv3kfReQhiFzbsxHypKrhCrNYOnUpmZLIB/NYJgIY21IM3rnVZgZVeZTRB888CKpS0771zgmzAIB02e9TcX3b0mXDnOrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZAQEavk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZAQEavk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01BD1F00A3D;
	Tue,  8 Sep 2026 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871512;
	bh=GDo4O8+B6vl62BXA4gTkCy9xHd3LZSyL63ObpvTH1I8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PZAQEavkkUAhWDoKYXKraPIL/+1H2TKRk2u/04hH0H05k1BnAXlKAwkH/QwjQTwi9
	 v20QKaEFlgAlbJGyPhSz9OKw3nZaAsRc+ZP5ZJaT9diaAYHgsexhIPT9jl9EX9s7Sb
	 fw8jM+xUYDoUdbm69EZRhWXWpfuaKIT8NLAhF58WrvBrWlbXiIyizefLa/OrSV5y8X
	 wFGL4bjf5MpiH5N098WcRgUUuEHVJcE6QrRsY1wsGvV2KaFkJIjumtvz1+E/Q9NYtV
	 s8GPd6pS7IDuJAyD1kweGtD2cEdkvUxV1kAKH5BFBrVLM8TzyRwyuJAXKywsydjKJx
	 /8zbw2La/3vnw==
Subject: Re: [PATCH net-next v8 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:11 +0000
Message-ID: <178887151142.219967.9831378889406001382@kernel.org>
In-Reply-To: <20260902214030.20955-3-arouhi@sitime.com>
References: <20260902214030.20955-3-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] New DT property `sitime,pll-fvco`
  (Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml:51) omits…
- [Low] Concern (assessed invalid): the MAINTAINERS section "SITIME
  SIT9531X DPLL DRIVER" added at MAINTAINERS:25160 lists only the…
- [Low] Concern (assessed invalid): the schema does not bound DPLL
  channel count (`dpll-types` has no maxItems: 4) nor per-variant…

--

dt-bindings: dpll: add SiTime SiT95316 clock generator

Adds a new DT binding for the SiTime SiT95316/SiT95317 I2C clock
generators, described as a DPLL provider with four PLLs, eight
selectable inputs and up to twelve outputs, plus two vendor properties
(sitime,pll-fvco and sitime,output-pll-map).  Also adds a MAINTAINERS
entry for the new binding.

> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> new file mode 100644
> index 000000000000..b3cf9d5a8267
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> @@ -0,0 +1,171 @@

[ ... ]

> +  sitime,pll-fvco:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 4
> +    maxItems: 4
> +    description:
> +      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  Neither
> +      standard frequency suffix fits.  The VCO bands are 4915.2 MHz to
> +      5898.24 MHz and 6875 MHz to 7812.5 MHz, so every valid value
> +      exceeds the 32 bits "-hz" allows, and the band edges are not
> +      whole megahertz either, so "-mhz" cannot express them.  Hence a
> +      plain uint64-array.  Override where the standard

[Severity: Medium]
Is the statement that "every valid value exceeds the 32 bits "-hz" allows"
correct?  A "-hz" property can carry 64-bit values, so the stated reason for
dropping the unit suffix does not seem to hold.

The peer binding in the same directory does exactly that:

Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
            supported-frequencies-hz = /bits/ 64 <10000 10000000>;

And this very file does it too, in its own examples:

                    supported-frequencies-hz = /bits/ 64 <156250000>;

Documentation/devicetree/bindings/opp/opp-v2-base.yaml also documents this
explicitly:

      opp-hz:
        description:
          Frequency in Hz, expressed as a 64-bit big-endian integer.

Since the values are already in Hz, could the property be named
sitime,pll-fvco-hz while keeping

    $ref: /schemas/types.yaml#/definitions/uint64-array

and the 32-bit rationale dropped from the description?  Once merged, the
suffix-less spelling becomes DT ABI and cannot be renamed later.

> +      Fvco = Fref * DIVN derivation does not match the running VCO --
> +      for example a PLL operating in INTSYNC mode.  A value of 0 keeps
> +      the register-derived computation for that PLL.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
