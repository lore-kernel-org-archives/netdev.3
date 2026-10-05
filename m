Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E403299A82;
	Mon,  5 Oct 2026 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162600; cv=none; b=oziCqrwTLk1r6vDvC3ded28xb/qclgH+DhU7Mnw0gsACsHYrtDvaGfqGx+lBMba3k+UMVROcylmbt8RJ6lvlEAeQWT0arMhDmXm8GwTScZYuR8wajmolEV6MDgz0FF0xrkbGtzpB6ly1H6pFMO8UdtQFg+gD1e7Y7/PQ1KrKHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162600; c=relaxed/simple;
	bh=s+3MdA1RgB7qURNUCNOGL+cAy2KJZC+3VBf7PnBxaWo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAyLXg2Pbppvwbt+70qmozORPeX2qCYI7+rIc0fwt+llJXxJmP81d2wo3bmDo05wD/4s5f97w3l6rv21XtAeyjVOsqwvjKp4tGGsjYCbE47YF9TR0tl87hHUFTsLrf0PAZmCo+y6CuLw+foJXmn8+tSpdlTVUHe24v5ohV8I2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYG1uDHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYG1uDHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349AE1F000FF;
	Mon,  5 Oct 2026 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162598;
	bh=YYeY3RfW17fBRvxGl0rJWionAP3CUstiUM7U4rPVhR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BYG1uDHtEinjjBUAdWAyGhpSjJGlwS4TmLRlc4G8i841ZNUY/hzb4gxYZDhpPa0p9
	 WciAso9VN8S1GZwAcAk7P0AWpeJ+7eDWK6TgZjfYzg3z5RyItCUBNOULm824I8SHr1
	 Icm6ClQ4U7Kd7H6rKqnTV0zTyA7gHzISuMISo4Qa0KeNgSReVjnnpBNPCI2RqZs/8H
	 x+KBw24TBdCHDddrCamcbe9wB+pKcz6s0ZYwODcXKy4SpSaa7lvRbZb+7iiflK55VQ
	 F9Mfn3Y9Fpu5ftomS6ZDBxvIjWrBshvDgLuyIkinS+XqjawYRAtsAX7OVKV7vHrEz+
	 V9Y83Lm0eu6yw==
Subject: Re: [PATCH net-next v11 05/13] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:09:57 +0000
Message-ID: <179116259780.434549.13866707323299859257@kernel.org>
In-Reply-To: <20260930233714.87679-6-arouhi@sitime.com>
References: <20260930233714.87679-6-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_pin_props_get() in drivers/dpll/sit9531x/prop.c takes
  the first entry of an input pin's "supported-frequencies-hz" as the…

--

dpll: sit9531x: read DPLL types and pin properties from system firmware

This commit adds prop.c to the sit9531x driver. It builds DPLL pin
properties (package and board labels, pin type, capabilities and supported
frequencies) from the input-pins/output-pins firmware nodes, and uses
defaults when a node is missing. It also reads per-channel DPLL types from a
"dpll-types" property, and adds input/output state arrays and pair/lane
helpers to core.h.

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> new file mode 100644
> index 0000000000000..3635ea497e415
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -0,0 +1,427 @@

[ ... ]

> +struct sit9531x_pin_props *
> +sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
> +		       enum dpll_pin_direction dir, u8 index)
> +{

[ ... ]

> +	/*
> +	 * Seed an input's runtime ref->freq with the first DT-listed
> +	 * supported frequency: for an input the board lists the rate that is
> +	 * physically wired to it first.  An output's current rate is what its
> +	 * divider produces, not an entry of the list it may be set to.
> +	 */
> +	if (num_freqs > 0 && dir == DPLL_PIN_DIRECTION_INPUT &&
> +	    index != SIT9531X_MAX_INPUTS)
> +		curr_freq = freqs[0];

[Severity: Medium]
Do the bindings define an order for supported-frequencies-hz?

The generic binding in dpll-pin.yaml describes it only as "List of
supported frequencies for this pin, expressed in Hz.". The input-pins
section of sitime,sit95316.yaml documents the reg numbering, but it says
nothing about the first entry being the rate wired to the input. The commit
message doesn't mention this rule either. It only appears in the comment
above.

The value picked here is then cached further down in
sit9531x_pin_props_get():

    if (dir == DPLL_PIN_DIRECTION_INPUT)
        sitdev->ref[index].freq = curr_freq;

and it is listed first in freq_supported. Later in the series, "dpll:
sit9531x: add support to get and set frequency on pins" makes
sit9531x_dpll_input_pin_frequency_get() report it directly:

    ref = sit9531x_ref_state_get(sitdpll->dev, dpin->id);
    *frequency = ref->freq;

Input pins have no frequency setter that could correct it. That commit's
message says only that the rate is "reported from the firmware
description".

Suppose a board DT lists an input's frequencies in some other order, for
example ascending. It would pass dt_binding_check, but the driver would
report an input frequency over DPLL netlink that the board does not
present.

Since this ordering would become de facto DT ABI once boards ship, could the
binding document it? Two other options: carry the wired rate in a separate
property, or stop inferring the current rate from its position in the list.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
