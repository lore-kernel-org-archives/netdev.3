Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E82372ED3;
	Mon, 12 Oct 2026 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785623; cv=none; b=ZvXuDKwgBkSXcGL9zn6XAxSCUbhRtPojYVOhUPQZ+spPy9KszT3Ag/yqN5RWNvsmPvA/9JFprSkzeAwfI9TM7R1FAt1XjHq5la6+UIOvqyFzEhMcG6yujENm06VsdIvCyobTustZsxxgkuOqI6wOQ1Mw/IXdZyh9DF3R2ADlQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785623; c=relaxed/simple;
	bh=pUebxavi3GTJsGCTRBshPlzSF1j2yFjEGVXkNrUK6PA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=En4zhb5JtptB396rA6X5ifpHAVFA57ZKhp//h6Hw7EEQO0YkMEtmuMVJADcFRvJ/5G/Fe/J9i7kgXPaU4BMVmBbwHdum5Bvq5Ro1tKgGfFIrOoKFkwBBN2D6O760R7FWhiWUjZR8aXJd431DiXJQlpAAJzloFUqTHeeUnZWafWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH3Mcc5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH3Mcc5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569FD1F0089B;
	Mon, 12 Oct 2026 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791785621;
	bh=alRgOjLj1/K1qImhAWPGLc6sPZdHk1ZvcfJrMk5kI8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mH3Mcc5zMsFRpE7UGIJRC2LW3EipxcAZ9jNQEV/dvjgLV9PcHFzr9rmHo/HNGB594
	 +pYhcTUxmvf52hBJ4psZmDtXTUTS0hvUitHXNH7fRLdymuDrq32Ze+W/JZ6xA1gIEE
	 xfwvd+JfZRfu1LiVW7XFM3n0kqZb9bIqQcEnB1e+HlPTUV1ye1EepqTmln1wFy6r/e
	 54DFOBFZAagUzx8lY+gqYPMbBxW5jf0W89znMCsgr2edD4G72PQw6AzIFHVcaZ6arQ
	 FQgJCfrJXauwcq9/Gv3AjpntBl2azRn96u9O1YHNrXUCfeL6lfZM+c+YeFxV/e8ObE
	 7ptcHw+QwT53g==
Subject: Re: [PATCH net v5 1/5] dpll: zl3073x: do not offer 0 Hz as a
 supported pin frequency
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 06:13:40 +0000
Message-ID: <179178562093.434549.11224993829134202451@kernel.org>
In-Reply-To: <20261011061211.448373-2-ivecera@redhat.com>
References: <20261011061211.448373-2-ivecera@redhat.com>
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

- [Low] The patch fixes two separate 0 Hz bugs, but its only Fixes: tag
  names 85a9aaac4a38 ("dpll: zl3073x: Include current frequency in…

Pre-existing issues:
- [Medium] zl3073x_pin_props_get() still adds the probe-time current
  frequency at index 0 after only a zero check (prop.c line 302).

--

dpll: zl3073x: do not offer 0 Hz as a supported pin frequency

This patch stops zl3073x_pin_props_get() from adding a 0 Hz current
frequency to the supported list. It also makes zl3073x_pin_check_freq()
reject 0 Hz firmware node entries. If the resulting list is empty, it is
not published.

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978e..768e5424de2d2 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -30,7 +30,7 @@ static bool
>  zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>  		       u8 id, u64 freq)
>  {
> -	if (freq > U32_MAX)
> +	if (!freq || freq > U32_MAX)
>  		goto err_inv_freq;

[Severity: Low]

The commit message also says that a 0 Hz firmware node entry is divided by
in zl3073x_pin_check_freq() at probe time. Does the Fixes: tag cover that
part of the fix?

Before this patch, zl3073x_pin_check_freq() had:

	if (freq > U32_MAX)
		goto err_inv_freq;
	...
		if (synth_freq % (u32)freq)
			goto err_inv_freq;

Both checks came from a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin
properties from system firmware"), not from 85a9aaac4a38. On input pins,
zl3073x_ref_freq_factorize(0) also succeeds, so 0 Hz was accepted there too.

Would it make sense to add this tag as well?

Fixes: a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin properties from system firmware")

Without it, stable trees that have a99a9f0ebdaa but not 85a9aaac4a38 might
not pick this up.

The later patch in this series, "dpll: zl3073x: reject output frequencies
with too small divisor", carries Fixes: a99a9f0ebdaa. It still divides by
freq via div_u64_rem(), so it seems to depend on the !freq guard added here.

>  
>  	if (dir == DPLL_PIN_DIRECTION_INPUT) {
> @@ -295,13 +295,20 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>  		goto err_alloc_ranges;
>  	}
>  
> -	/* Start with current frequency at index 0 */
> -	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
> +	/* Start with current frequency at index 0. A sub-Hz frequency is
> +	 * read back as 0 Hz and cannot be set, so it is not offered.
> +	 */
> +	j = 0;
> +	if (curr_freq) {
> +		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);
> +
> +		ranges[j++] = freq;
> +	}

[Severity: Medium]

This is a pre-existing issue and was not introduced by this patch. The new
comment says a frequency that cannot be set is not offered, but only 0 Hz
is filtered here. Should curr_freq also go through
zl3073x_pin_check_freq(), as the firmware node entries do?

curr_freq comes from truncating divisions:

  - outputs: synth_freq / out->div, then / esync_n_period for N-pins
  - inputs: mul_u64_u32_div(base * mult, M, N)

So a non-zero curr_freq can still be a value that the set callbacks cannot
program.

For output pins, zl3073x_dpll_output_pin_frequency_set() does:

	new_div = synth_freq / (u32)frequency;

The non-N-div path has no remainder or minimum divisor check. Take a 1 GHz
synth with a probe-time divisor of 300000. curr_freq is 3333, and selecting
it later gives new_div = 300030, not 300000.

If the probe-time divisor was 1, a user can switch away and then pick the
still-advertised curr_freq again. That puts the output back into divider
bypass. The later patch in this series says the hardware ignores the width
and eSync registers in that mode.

For input pins, zl3073x_dpll_input_pin_frequency_set() ignores the result
of the factorization:

	/* Update frequency */
	zl3073x_ref_freq_set(&ref, frequency);

	/* Commit reference state */
	return zl3073x_ref_state_set(zldev, ref_id, &ref);

Suppose curr_freq came from an M/N ratio that has no base * mult
factorization, such as a truncated 161132812 Hz. zl3073x_ref_freq_set()
fails and ref stays unchanged. zl3073x_ref_state_set() then finds nothing
to write and returns 0, so the request reports success while the reference
keeps its previous frequency.

The unconditional curr_freq entry comes from 85a9aaac4a38. The ignored
zl3073x_ref_freq_set() return value is older.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011061211.448373-1-ivecera%40redhat.com
