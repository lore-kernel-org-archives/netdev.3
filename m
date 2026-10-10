Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650804B4863;
	Sat, 10 Oct 2026 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660425; cv=none; b=hVPeuWJAFncsR5ZVXhLbu7PQQ8ai/mHH8sz6NkmEgnllI9pc5G2gF+U3GVCfxjWJN7ecfNLGbWABYeRUZXDz74adYcZgO7JF+Rc/3W4Ljeg6Dj+m4ENvsgU6FfwunQQAwVOykpMyCxBVQMxH2ZTFOfKoXB9dR26/olC6WC7n1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660425; c=relaxed/simple;
	bh=xPHXgH3r21MkUjGGERR026voIHZOJ/6i/bSecPPpvbI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y24eFFx0otHoJvN76r5t3claNBE59XJsRn0AGie5krU27qNxa772CS6/fcMAeTEWkGt2hjXD4wMvFzT4R5WFPo7TXfnO50LNGaie2Vdk82FzoU/w8cpx8KqKLQ0NR6lX2153a/UHsfdAmfiooSvzb/vy5deC72CqJonP5LpDmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwsDhsu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwsDhsu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2931F000FF;
	Sat, 10 Oct 2026 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660424;
	bh=QUd79049jHb2W9eQDGzEUyWVTVbILBqdpd8sMahX28k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GwsDhsu+08lg7xqY5A9VXYZvpMoKKCL/FHyL0SB0q/S+4E60WNeAHGko1c5Qb1MwU
	 0byZ6mDp3WD7vMqKuDNujN4qTd6WJCnVa+2qPgaXhB6iXI9uVDRdtpzBliEeg1QLdU
	 I5slKMk72zXl+bjwwkK/3pl9BWUtLg65q5P4kJGpUm/uFluLGFWgodSHeQYvHeYAl0
	 raZD6MbfEDZSbn22jXeInJu/kfuiB3riP2Nb/OZdZeoxn1sLro2SLI/Bw2kdDE9h6z
	 1Q0tjldgS6dPSDBFyFzos7jMtLm1/imDxwHkUFokNqCivbPSIYFKWVBpfhd6NiIlaQ
	 8Xih2KRA3VIKg==
Subject: Re: [PATCH net v4 4/5] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 19:27:02 +0000
Message-ID: <179166042288.434549.8898926010926233618@kernel.org>
In-Reply-To: <20261009192556.272263-5-ivecera@redhat.com>
References: <20261009192556.272263-5-ivecera@redhat.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, zl3073x_dpll_output_pin_frequency_set()
  rejects an N-pin frequency that the driver itself advertises as…

Pre-existing issues:
- [Low] The three NL_SET_ERR_MSG_FMT() diagnostics this patch adds to
  zl3073x_dpll_output_pin_frequency_set() never reach userspace.

--

dpll: zl3073x: reject inexact frequencies for N-divided outputs

This patch changes zl3073x_dpll_output_pin_frequency_set() for N-divided
outputs. The esync_n_period computation now uses a 64-bit product, and the
request is rejected when the resulting period is below 2, does not fit
into 32 bits, or the division leaves a remainder.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 8bac680394d76..6d9a6d21d30b7 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -1033,17 +1029,31 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		/* For 50/50 duty cycle the divisor is equal to width */
>  		out.width = out.div;
>  	} else {
> -		/* We are going to change frequency of N-pin but if
> -		 * the requested freq is greater or equal than freq of P-pin
> -		 * in the output pair we cannot compute divisor for the N-pin.
> -		 * In this case indicate a failure.
> -		 *
> -		 * Update divisor for N-pin
> +		/* The N-pin frequency has to divide the P-pin frequency and
> +		 * be at most half of it.
>  		 */
> -		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
> -		if (!out.esync_n_period)
> -			return -EINVAL;
> +		n_period = frequency * out.div;
> +		n_period = div64_u64_rem(synth_freq, n_period, &rem);
> +	}
> +	if (n_period < 2) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "OUT%uN freq must be at most half of OUT%uP freq",
> +				   out_id, out_id);

[Severity: Low]
This isn't a bug introduced by this patch, but will userspace ever see
these three new extack messages?

The only caller, dpll_pin_freq_set() in drivers/dpll/dpll_netlink.c,
always writes its own message when the driver callback fails:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
    ...
	ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
				 dpll, dpll_priv(dpll), freq, extack);
	if (ret) {
		NL_SET_ERR_MSG_FMT(extack,
				   "frequency set failed for dpll_id:%u",
				   dpll->id);
		return ret;
	}
    ...
}

NL_SET_ERR_MSG_FMT() unconditionally replaces extack->_msg, so the
"OUT%uN freq must ..." strings from zl3073x get replaced by the generic
core message. ice_dpll_pin_freq_set() loses its messages the same way.

Would it make sense to switch the core to NL_SET_ERR_MSG_WEAK(), or to
keep a message the driver has already set?

> +		return -EINVAL;
> +	}
> +	if (n_period > U32_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "OUT%uN freq is too low for OUT%uP freq",
> +				   out_id, out_id);
> +		return -EINVAL;
> +	}
> +	if (rem != 0) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "OUT%uN freq must divide OUT%uP freq",
> +				   out_id, out_id);
> +		return -EINVAL;

[Severity: Medium]
Can this reject an N-pin frequency that the driver itself lists as
supported?

The hardware N-pin frequency is synth_freq / (div * esync_n_period), and
that does not have to be a whole number of Hz. The getter rounds it down:

drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
    ...
	freq = zl3073x_synth_freq_get(synth) / out->div;

	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
		freq /= out->esync_n_period;
    ...
}

zl3073x_pin_props_get() then adds this rounded value to freq_supported.
Unlike the firmware-listed frequencies, it does not go through
zl3073x_pin_check_freq():

	if (curr_freq) {
		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(curr_freq);

		ranges[j++] = freq;
	}

For example, take a 600 MHz synth with div=60 and esync_n_period=7. The
real N-pin frequency is 1428571.43 Hz, and it is advertised as 1428571 Hz.

Say userspace moves the N-pin to another supported value, such as a
firmware-listed 1 MHz, and then tries to set it back to 1428571 Hz.
dpll_pin_is_freq_supported() accepts the value, and then this function
computes:

    n_period = 1428571 * 60 = 85714260
    div64_u64_rem(600000000, 85714260, &rem) -> 7, rem = 180

The new rem != 0 check returns -EINVAL here. The old truncating division
gave n_period = 7, which restored the original hardware setting.

The comment in zl3073x_pin_props_get() says a frequency that "cannot be
set ... is not offered", which suggests the current frequency added there
is expected to be settable. Should the advertised current frequency be
skipped or checked for inexact N-divided outputs, or should the setter
accept the truncated value?

> +		return -EINVAL;
>  	}
> +	out.esync_n_period = n_period;
>  
>  	/* For 50/50 duty cycle the divisor is equal to width */
>  	out.esync_n_width = out.esync_n_period;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009192556.272263-1-ivecera%40redhat.com
