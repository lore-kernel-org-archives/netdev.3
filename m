Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AD372ED3;
	Mon, 12 Oct 2026 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785630; cv=none; b=B8coQog6DjzuvN5rgdnLTI+Ox1gV7tsQFHGebB/AWrpGv55pPjALG+6llPBnkkDMk3W/jJhamEBUEwsHMZukaZTi4J2FJxnxCNWoc1Awm3ddsk6Fqp+20Y69kd15WY56GoIfMGaidPoeLFuSr8beQqEUtJIz0phi5HMI1mWbQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785630; c=relaxed/simple;
	bh=7qe/oMFAjxvnzgGB1LEOLqIGgi45y/Ru8/g98w+qZeA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkUkJ/gss5v+HsKaRQriTbkaCxDJ3K4OF6shJITfD23PrYmFI48RVoPQ+Rt0j2CBBWgjLYuLi7019NbZRJGALbtPxMi9JMFnKSOrgN8mTI46OJT0IC/v07fpjVyAVTwX74kZfghjGp4FrrvKGjb3xGarvYTKGe0d5Z6/lDwVTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN55UUXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN55UUXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A01F0089B;
	Mon, 12 Oct 2026 06:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791785624;
	bh=NQ8S5oIVCDketnjFMvQ3+EF1PElNgh+zSOwezSwWsRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UN55UUXr+BUYBJOw2Ok1v05ifAkvXUzMejfNGQfw6UTXabzwbhkAh6OnbRCvpv+9q
	 dBv9UPETahSDQ4w16okt5rV3atM5unPWYNxofreTORY9OUGHK3Lq6FHXIGCdrRxzLP
	 v9GbtNR0hZ5PT06sgFXQXv5IqRsH9PFIlTAl0B1OWEWDgbkx7a2ykoe60UIHqASRyW
	 66zVVz+t/TwulwPoX+KSLVyX01Qta6u4txn/r94L5+Tr7WSWGOWJxn/L1IQZpmU/m0
	 y+8oJxrW5HPvk6OcrAdbwmY7S7yfGZJUsz47xU0xZRUCqtjlW1dijchE/9rs6UF7p6
	 fY9P31aTYRkyw==
Subject: Re: [PATCH net v5 3/5] dpll: zl3073x: reject output frequencies with
 too small divisor
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 06:13:43 +0000
Message-ID: <179178562335.434549.16077864729187599251@kernel.org>
In-Reply-To: <20261011061211.448373-4-ivecera@redhat.com>
References: <20261011061211.448373-4-ivecera@redhat.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The current output frequency skips the new minimum-divisor
  rule.
- [Medium] The commit message says that for N-divided outputs the min-
  divisor check is 'necessary but not sufficient, the rest is checked by…

Pre-existing issues:
- [Medium] eSync can be enabled on an output whose divisor is 1.

--

dpll: zl3073x: reject output frequencies with too small divisor

This adds a minimum output divisor check to zl3073x_pin_check_freq().
Firmware-provided output frequencies must now give a divisor of at least
2, or at least 4 for the N-pin of an N-divided output. Frequencies that
fail the check are dropped from the supported list.

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index 768e5424de2d2..4e006ed5950ad 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c

[ ... ]

> @@ -41,18 +42,38 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,

[ ... ]

>  		/* Check the frequency divides synth frequency */
> -		if (synth_freq % (u32)freq)
> +		div = div_u64_rem(synth_freq, freq, &rem);
> +		if (rem)
> +			goto err_inv_freq;
> +
> +		/* The driver requires an output divisor of at least 2 -
> +		 * below that the hardware bypasses the divider and ignores
> +		 * the pulse width and eSync registers the driver programs.
> +		 * For the N-pin of an N-divided output the effective divisor
> +		 * also includes the N divider (>= 2), so the minimum is 4.
> +		 * For N-divided outputs this is only a necessary condition -
> +		 * whether the frequency can be set also depends on the output
> +		 * divisor shared by both pins, which is checked when the
> +		 * frequency is set.
> +		 */
> +		out = zl3073x_out_state_get(zldev, out_id);
> +		if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> +			min_div = 4;
> +		else
> +			min_div = 2;
> +		if (div < min_div)
>  			goto err_inv_freq;
>  	}

[Severity: Medium]
Can the current output frequency get past this new minimum divisor check?

zl3073x_pin_props_get() puts curr_freq at index 0 of freq_supported
without calling zl3073x_pin_check_freq(). It also skips any firmware
entry equal to curr_freq, so that value is never validated either:

drivers/dpll/zl3073x/prop.c:zl3073x_pin_props_get() {
    ...
	j = 0;
	if (curr_freq) {
		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);

		ranges[j++] = freq;
	}
    ...
	for (i = 0; i < num_freqs; i++) {
		...
		if (freqs[i] == curr_freq)
			continue;
		if (zl3073x_pin_check_freq(zldev, dir, index, freqs[i])) {
    ...
}

zl3073x_out_state_fetch() only rejects a zero divisor. An output can
therefore come up from the flash configuration with div == 1, and then
curr_freq == synth_freq stays in the supported list.

dpll_pin_freq_set() only checks that the frequency is in
freq_supported. zl3073x_dpll_output_pin_frequency_set() puts no lower
bound on new_div:

	new_div = synth_freq / (u32)frequency;

	/* Check signal format */
	if (!zl3073x_out_is_ndiv(&out)) {
		...
		out.div = new_div;

		/* For 50/50 duty cycle the divisor is equal to width */
		out.width = new_div;

The N-div P-pin branch also does out.div = new_div after checking only
n_period.

A user can move the output away from its boot frequency and then set it
back. The driver then programs divisor 1 again. The commit message says
the hardware then ignores the pulse width and eSync registers. In N-div
mode those registers also hold the N-pin's N divider.

At the end of the series, a frequency_set with eSync enabled calls
zl3073x_out_esync_enable() with div == 1, which writes
esync_n_width = 0.

The previous patch in the series ("dpll: zl3073x: do not offer 0 Hz as
a supported pin frequency") already filters curr_freq for 0 Hz. Should
curr_freq also go through the divisor check? Alternatively, should
zl3073x_dpll_output_pin_frequency_set() reject new_div < 2? Later
patches in the series don't seem to add either check.

[Severity: Medium]
The commit message says:

  For N-divided outputs this is necessary but not sufficient, the rest
  is checked by the frequency set callback.

Does the frequency set callback actually check the out.div >= 2 part?
The N-pin branch of zl3073x_dpll_output_pin_frequency_set() uses
whatever out.div is currently programmed:

	} else {
		/* The N-pin frequency has to divide the P-pin frequency and
		 * be at most half of it.
		 */
		n_period = frequency * out.div;
		n_period = div64_u64_rem(synth_freq, n_period, &rem);
	}

After that it only rejects n_period < 2, n_period > U32_MAX and a
non-zero remainder before committing out.esync_n_period.

The check added here only looks at the total divisor
synth_freq / freq >= 4. That can't tell out.div = 2, N = 2 apart from
out.div = 1, N = 4.

An N-div output can end up with out.div == 1 in two ways:

  - the boot configuration, since zl3073x_out_state_fetch() only
    rejects 0
  - restoring a P-pin frequency equal to synth_freq through the
    unvalidated curr_freq entry

In that case the N-pin set succeeds, and
zl3073x_dev_output_pin_freq_get() reports synth_freq / N.

The hardware ignores the N divider register at divisor 1. Wouldn't the
reported N-pin frequency then differ from what the pin actually
produces? This looks like a variant of the "no output on an
oscilloscope" case in the commit message. It still seems to be present
at the end of the series.

[Severity: Medium]
This isn't a bug introduced by this patch, but the eSync callbacks seem
to reach the same divisor 1 case.

zl3073x_dpll_output_pin_esync_get() advertises eSync ranges whenever
the output is not N-div, esync_control is set and out_freq > 1:

	out_freq = synth_freq / out->div;

	if (!pin->esync_control || out_freq <= 1)
		return -EOPNOTSUPP;

With out->div == 1, out_freq == synth_freq, so this check passes.
zl3073x_dpll_output_pin_esync_set() then sets the clock type to ESYNC
and commits without checking out.div >= 2:

	out.esync_n_period = synth_freq / (u32)freq / out.div;
	...
	out.esync_n_width = out.div / 2;

For div == 1 this writes esync_n_width = 0.

This commit says the hardware ignores the eSync registers at divisor 1.
Would the driver then report eSync as enabled with a given frequency
and pulse, while the device outputs a plain clock?

At the end of the series, zl3073x_out_esync_enable() uses the same
div / 2 width computation. frequency_set re-enables eSync for any
carrier other than 1 Hz, including when div == 1.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011061211.448373-1-ivecera%40redhat.com
