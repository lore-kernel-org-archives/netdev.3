Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462586341;
	Mon,  5 Oct 2026 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162597; cv=none; b=dd1ncO7xdtJDlmcbivZLsbUphzRkOBl8VRTPO5lzKDNcVYYwe2w7ja6UhCOU77kWQk6jIsiHHEFCJaoJvtEs0mizV2PySP8on2Nbb0egoaIVRWoSDRwSZB4qTMYSamcUiYYoZodrkiRhNgpo7dRxb5z0AMuR1YDY8kuViTAygQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162597; c=relaxed/simple;
	bh=rDvQAVZdl8BWx8TbdLbVvUy9QrE6q7fVysdpKJbIo+0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4I9wjQXAi9012F84/kRMHIcN/nRf6SSUA+TxqcFNVSqkUA3nD6IwIjGRJavVdgFcwaMDLR4EOtOgxGiHmzHGNxiVvW9GWl0WsQgDIYb9DbdCid8OBi9TPHm+y3ZRT81Zn1IOtylhKjxctBcc30GWSMms4K6VKju37la1IcLKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSEXRdud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSEXRdud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5031F000FF;
	Mon,  5 Oct 2026 01:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162596;
	bh=6u5KYzXTOeeCRUqycfQUGWuiaxYWlFLFuer9wSTJdRE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZSEXRdudc+tO/a8nuwPBfN/PV3l8Sf4xqe+Fc1VRRpSGdrkNv5ZhPd6/haVMqZG1T
	 zumpbIIhrtd1/1vEjVq3RGL7KD9OUaz1TkK+xBJqnCkbnOHPfg2+840aO9nXjcB8MS
	 mJ4nMnFDY944EJi2l4CEVef+SHStPJg4UehgDNkgrFGqWbutfxT7+rlniwoxZTcxUw
	 sVA5o9g+WyNWQXqKHq+lwjAXNFQ2W1ttaUW1+nrshwUi2BH0MW3ZklBgkuhr3leAXt
	 huq+7C5BY1nyAFi17Ok67tG4E+ffDnX8zt/Fb00zoy6rfBGwyQ4v28zP07z/nRTHan
	 vtVLsacnvUapw==
Subject: Re: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime SiT95316
 clock generator
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:09:54 +0000
Message-ID: <179116259487.434549.6833952261033036380@kernel.org>
In-Reply-To: <20260930233714.87679-4-arouhi@sitime.com>
References: <20260930233714.87679-4-arouhi@sitime.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
  defines no power-supply properties (for example a core VDD supply and…

--

dt-bindings: dpll: add SiTime SiT95316 clock generator

This adds a devicetree binding for the SiTime SiT95316/SiT95317 clock
generators. They are I2C-controlled DPLL providers with four PLLs, up to
eight inputs and up to twelve outputs. The XO is described either as a
clock or as a clock-frequency property.

> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> new file mode 100644
> index 0000000000000..997b410e8f526
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - sitime,sit95316
> +      - sitime,sit95317
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: xtal
> +
> +  clock-frequency:
> +    description:
> +      XO rate in Hz feeding XIN/XO_CLK, for firmware that describes the
> +      oscillator as a property rather than as a clock provider, such as
> +      ACPI.  Use either this or "clocks", not both.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the chip's active-low reset pin (RESETB).
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt from the chip's active-low INTRB output.  Asserted when
> +      the device detects a status change such as lock acquisition or loss.
> +
> +  dpll-types:
> +    maxItems: 4
> +
> +  input-pins:

[Severity: Low]
This isn't a bug, but should the binding describe the chip's power
supplies here? For example a core VDD supply and the per-bank VDDO
output supplies.

The schema ends with:

    unevaluatedProperties: false

With that, a board that adds a *-supply property to the dpll node fails
dt_binding_check. A board that powers the part from switchable regulators
then has no valid way to describe those rails. Without them, a driver
cannot make sure the rails are on before it releases RESETB and starts
I2C access during probe.

Documentation/devicetree/bindings/writing-bindings.rst says:

    DO attempt to make bindings complete even if a driver doesn't
    support some features.

The supply names were not checked against the SiTime datasheet. Any
supply properties added should use the chip's actual VDD/VDDO pin
names.

The existing microchip,zl30731.yaml DPLL binding also leaves out
supplies, so there is precedent for this in the subsystem. Optional
supply properties could also be added later without breaking existing
DTs.

[ ... ]

> +unevaluatedProperties: false

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
