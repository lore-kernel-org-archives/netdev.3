Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEA370D56;
	Mon, 12 Oct 2026 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785624; cv=none; b=pI/LUXiHwNN7kEQ3BoMpjaZO7YshB84Zgu9V7rWsLwfRze42LTkRrjWpaUOzDV0unLU3Gc4UtzeW7iRMr7FqzrotoSgzgfkLOPnNiAEfLgVOJqbAizfZm8MD0ZzE6ITKhUvFD1S7FlwQVMUiERvh6TsLZktiYOmNc1cuBNk9Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785624; c=relaxed/simple;
	bh=qxB0z/GTLPAyspa9D+V8dp41dspIGxmagwOohP538Hs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQNyvEi4Wtn00JlSx2XVKemHCDgRdeNvPsoEbyZYEb2cgZnoXpEHd/s2hmlvU81eg/FgCGtvsRs9wUkWYA11UVrF2MLmlITxrM/iJb7PXPyBASRLHZkgP0c5YgsAS3P7OKnSHhxvORyXFMcF6Ekp9lL50z7cnR+8gAofBjN61bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bej7PlfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bej7PlfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830551F0089C;
	Mon, 12 Oct 2026 06:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791785623;
	bh=dgI/3vR5QRvYRu5GVrXuV0MOaRfGLjsPuRsgh+fkEZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bej7PlfQ/D0unUPrVd3hDyzew2Y9t3T4HwfNLUdvpeMomyzXFf3C9g7d9FifEYNDF
	 wynXO0Zo6w82g3K/9s1mEebsw9qYMUI782o3HQxM5SXpvHDIQHS1w1tU2wyh2TpSn8
	 bzqes0hRXBXKyliX0G+xXV2CueuqOemIsYSHneaseagSw02yJN6RPIjuezOOd0GLhV
	 S6GVZ5IqjhyuHskAPkMFwJjTyMwq6LyKxLtUPDk+6cPjZITsYwGa04mVUdOPE3yiL0
	 FgfRkRsU/BHmijI2apU3VSHhqgAo3jQiETnHjSX6ewwFf42vs64fAIo/fbpPA8TqD1
	 GWWK7Ayqu4/cQ==
Subject: Re: [PATCH net v5 2/5] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 06:13:42 +0000
Message-ID: <179178562205.434549.16391656740065795175@kernel.org>
In-Reply-To: <20261011061211.448373-3-ivecera@redhat.com>
References: <20261011061211.448373-3-ivecera@redhat.com>
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

- [Low] Concern: zl3073x_pin_props_get() always lists the current
  (truncated) frequency as supported.

Pre-existing issues:
- [Low] Concern: userspace never sees the three new extack messages added
  in `zl3073x_dpll_output_pin_frequency_set()` ("must be at most half",…

--

dpll: zl3073x: reject inexact frequencies for N-divided outputs

This commit tightens zl3073x_dpll_output_pin_frequency_set() for
N-divided outputs. It computes esync_n_period in 64 bits and requires it
to be at least 2 and to fit into 32 bits. It also rejects any request
whose division leaves a remainder, and reports each failure case through
extack.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index f2e137475b40f..7a617d9bd6712 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -1031,17 +1027,31 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		/* For 50/50 duty cycle the divisor is equal to width */
>  		out.width = out.div;
>  	} else {

[ ... ]

> +		n_period = frequency * out.div;
> +		n_period = div64_u64_rem(synth_freq, n_period, &rem);
> +	}
> +	if (n_period < 2) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "OUT%uN freq must be at most half of OUT%uP freq",
> +				   out_id, out_id);
> +		return -EINVAL;
> +	}

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
will userspace ever see this message, or the two added below it?

When ops->frequency_set() fails, the DPLL core overwrites the driver's
extack text:

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

NL_SET_ERR_MSG_FMT() always writes into extack->_msg_buf and resets
_msg. The "must be at most half", "is too low" and "must divide" messages
are therefore replaced by the generic text, and they can only be seen
through the netlink_extack tracepoint. The -EINVAL return is still
correct.

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
>  	}

[Severity: Low]
Can this check reject a frequency that zl3073x_pin_props_get() lists as
supported?

zl3073x_pin_props_get() always puts the current frequency into the
supported list. For an N-pin, that value comes from a truncating
division:

drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
    ...
	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
		freq /= out->esync_n_period;
    ...
}

Also, zl3073x_out_state_fetch() only refuses esync_n_period == 0, so a
boot config with esync_n_period == 1 is accepted.

A request for the current value never reaches the driver, because
dpll_pin_freq_set() returns early when freq == old_freq. If the pin is
first moved to another frequency, though, a later request for the
advertised boot value can fail.

Take a 600 MHz synth, div=60 and a boot esync_n_period of 7. The N-pin
is advertised as 1428571 Hz. After N is moved to 1 MHz, a request for
1428571 gives rem=180 and returns -EINVAL.

In the same way, a P-pin frequency that would bring back
esync_n_period == 1 now fails the n_period < 2 check. According to the
series commit "dpll: zl3073x: reject output frequencies with too small
divisor", that state gave no N-pin output.

This looks consistent with the goal of rejecting inexact N frequencies.
A later comment in prop.c in this series also says the supported list
for N-divided outputs is only a necessary condition. The old code
already rejected some advertised values, such as N-pin frequencies at or
above the P-pin frequency.

Is it intended that a user cannot go back to an inexact boot-time N-pin
setting by asking for its advertised value?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011061211.448373-1-ivecera%40redhat.com
