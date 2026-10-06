Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E43D2FFB;
	Tue,  6 Oct 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274091; cv=none; b=pOThti9yjL38oDyeZJJBjo9PystpoBJ4jY0qJZcRlNkCPBIzNKRhsr5bG5fsw1CUPi0SlQqNHMxHumYYuzNyReRu5oXiFXFKP5JnMS5hGQOmFZNhbZpm906tT+0Vire1WXjy+yrm340pXw8uBDsgL4POitGsI/sYiiDX5A8n0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274091; c=relaxed/simple;
	bh=LpvFkHGJlvbUHZD54dIgPDPKNQWMJ64D6NoUOTKJH7Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYIlVGiIzsUI6y6qfUVQJGuTNASFZo5eHncBD+5aupNUreGH929+IR/zVB3TnrrewyqO4Pqj+Jbg0kkGRSWJz9G1sqGati6vlRmpAjnL+L5TpwmTZqAxMpRIlhpZoP2H+nNpsQIQ4sPhMC+Zdy3Qi2HPvU6U9Y+uKQwOrqsA9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEN1MUxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEN1MUxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B6B1F00898;
	Tue,  6 Oct 2026 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274086;
	bh=XUXVQSlK7xL4Ijyfaa8742Akw7yIa0BJyP7XFobuWKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PEN1MUxpfPC7WHDSVZZlXd8n2UTN9qB8yJ/n8byPD23pfgWBL7ufFcd1IM6biaQOA
	 dLVDUCGy+Fms+GkSuT+iGIcqGRrbjPffZAQCjOLvS7+m/XqP58uLR0R+C6OEbokZ7o
	 j2I7H915TK0a9A0wOXjgadyyL55YE0LTmWQV3LxU38PMCm4ScnhTQWjB3ERYvivkpC
	 IbzB1j7QQYcg01q9Ldl08v+q+m8+fS3N13kCtCh/CqTw5x5qb718FywK8UjPeY2cLl
	 s+VbloMrz5j1s4mFsANkBS5daO2WPv/Gv6gav5Ms7XimQS3U6WbmJUe9d5hTRiAMlg
	 x6UIBojoPoC+Q==
Subject: Re: [PATCH net v2 1/2] dpll: zl3073x: make embedded sync follow the
 output carrier frequency
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 08:08:05 +0000
Message-ID: <179127408522.434549.10860667170628048867@kernel.org>
In-Reply-To: <20261002074520.30048-2-ivecera@redhat.com>
References: <20261002074520.30048-2-ivecera@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] zl3073x_dpll_output_pin_esync_get()
  (drivers/dpll/zl3073x/dpll.c, lines 881-887) now reports esync->freq =…
- [Low] When the requested output frequency equals the synthesizer
  frequency, new_div is 1.

--

dpll: zl3073x: make embedded sync follow the output carrier frequency

This patch moves the output pin eSync handling into new
zl3073x_out_esync_{is_enabled,enable,disable}() helpers in out.h and uses
them from esync_get() and esync_set(). It also makes
zl3073x_dpll_output_pin_frequency_set() recompute the eSync period and
width after the divider changes, and disables eSync when the new frequency
is 1 Hz.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index f2e137475b40f..19456fbeeea84 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -864,38 +864,28 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,

[ ... ]

>  	esync->range = esync_freq_ranges;
>  	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>  
> -	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
> -		/* No need to read esync data if it is not enabled */
> +	if (zl3073x_out_esync_is_enabled(out)) {
> +		esync->freq = 1;
> +		esync->pulse = 25;
> +	} else {
>  		esync->freq = 0;
>  		esync->pulse = 0;
> -
> -		return 0;
>  	}
>  
> -	/* Compute esync frequency */
> -	esync->freq = out_freq / out->esync_n_period;
> -
> -	/* By comparing the esync_pulse_width to the half of the pulse width
> -	 * the esync pulse percentage can be determined.
> -	 * Note that half pulse width is in units of half synth cycles, which
> -	 * is why it reduces down to be output_div.
> -	 */
> -	esync->pulse = (50 * out->esync_n_width) / out->div;
> -
>  	return 0;
>  }

[Severity: Medium]
The commit message calls this factoring the eSync handling into helpers.
However, zl3073x_dpll_output_pin_esync_get() now reports freq = 1 and
pulse = 25 based only on the clock type. It no longer computes them from
esync_n_period, esync_n_width and div. Is this change in the reported
values intended?

zl3073x_out_state_fetch() reads the period and width from the device
as-is, and only rejects a zero period:

drivers/dpll/zl3073x/out.c:zl3073x_out_state_fetch() {
    ...
	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
			      &out->esync_n_period);
    ...
	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH,
			      &out->esync_n_width);
    ...
}

The device could be running a non-1 Hz eSync, either from its flash
configuration or from a stale period left by an older kernel (probe does
not reset the chip). Would that now be reported as 1 Hz?

The pulse value looks affected too. zl3073x_out_esync_enable() sets
esync_n_width = out->div / 2, so an odd divider such as div = 5 gives 20%.
The old getter reported 20 here, and this one reports 25. With div = 1 the
width is 0, which is also reported as 25.

The frequency case is harder to recover from because the core skips the
driver when the requested value equals what esync_get() returns:

drivers/dpll/dpll_netlink.c:dpll_pin_esync_set() {
    ...
	if (freq == esync.freq)
		return 0;
    ...
}

Suppose the hardware eSync on an output is not 1 Hz and a user requests
1 Hz. Would the request succeed without reprogramming anything?

For comparison, zl3073x_dpll_input_pin_esync_get() still checks the
hardware divider before it reports 1 Hz:

	esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;

Should the output pin getter keep deriving the values from the cached
register state in the same way?

[ ... ]

> @@ -1009,6 +984,22 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		/* For 50/50 duty cycle the divisor is equal to width */
>  		out.width = new_div;
>  
> +		/* The embedded sync period and width are computed relative to
> +		 * the output carrier so they have to be adjusted to follow the
> +		 * new frequency.
> +		 */
> +		if (zl3073x_out_esync_is_enabled(&out)) {
> +			if (frequency == 1) {
> +				/* Disable eSync if the new frequency is 1 Hz */
> +				zl3073x_out_esync_disable(&out);
> +			} else {
> +				/* Update esync period and width according to
> +				 * the new frequency.
> +				 */
> +				zl3073x_out_esync_enable(&out, synth_freq / out.div);

[Severity: Low]
What happens here when the requested frequency equals the synth frequency?
In that case new_div is 1, and zl3073x_out_esync_enable() sets:

	out->esync_n_width = out->div / 2;

That gives a width of 0 while the ESYNC clock type stays set.
zl3073x_out_state_set() then writes 0 to ZL_REG_OUTPUT_ESYNC_WIDTH, and
esync_get() still reports freq = 1 and pulse = 25.

The 1 Hz case disables eSync. Should a divider that cannot hold a non-zero
25% width also be rejected, or have eSync disabled?

zl3073x_dpll_output_pin_esync_set() already had the same div / 2
arithmetic. This patch adds a new path that reaches it automatically on a
frequency change.

> +			}
> +		}
> +
>  		/* Commit output configuration */
>  		return zl3073x_out_state_set(zldev, out_id, &out);
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002074520.30048-1-ivecera%40redhat.com
