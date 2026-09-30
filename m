Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444413F23BD;
	Wed, 30 Sep 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751450; cv=none; b=KH7Tt4/lCcYPIi1Bik1+Cus0jnLe57D78WHYYSFOkOUFenqOU2M0WyMhoTxIM47IPwlZM98YYoftHq9yFEmtd9kErsKzuRHmQcLkEPzZpGrdgHiIUvEDNPgwHYgZVBNA8d9l3M8eYNmf1hfMYeC5o3JR+KRTjq0Elg+AmjkX+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751450; c=relaxed/simple;
	bh=fwOA9O0nFOrTpLNu/nIONUOla+wYp6+n4xzzxWFJnLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcLcHdkShO0gae1XtI8cF1FKjM2QOSK7xBUPafeZr0ezR4I6PYqb2SfsC68aUf4ppjT5Dh+j2bK5hIe68BgjCQOqV/QECWt1hASzSx/S5MkQdeRZ5ZYS6/UiV3GumkodtOeO9lO7qZtu58A9VLxDviRKvHT/SD6G+BQnTChKX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxRhnZud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxRhnZud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EB81F00899;
	Wed, 30 Sep 2026 06:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751435;
	bh=sKPnM5ngy/nY17foSViZ3cY5JvpMOHtKxOPc+AYY5gc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UxRhnZudiMsTMAMSFH1w2Bv7CjwxnWclMlJibohe4NDahCrPhNY0r0aDYHx9leVmf
	 +UdDr3dht96GA6pNCYnNYsxzAxL19y9kUAi+3gxMjWFj32qCwA0XUYVTEtbVKLFcwP
	 k5QPHqpwnpa8L+BrHoTd/zzdSbqh4mgJkk/2Wmw/n915r3X+er5t65/O5tdKjqN80b
	 tudiqdOokkRVfQvGxRXBo1W37JZF/hcYnohD6PBgErzr5dAPs/aAac1wHDgMvwXBsi
	 3o7Zhp4zvgVtnkO/hM5kioNVbde5hVu8d8Q+kpDuYNp3tSmEZDjjWcdM+Kx6TAD+WL
	 2RQkkdMK95aRQ==
Subject: Re: [PATCH net-next 5/6] dpll: zl3073x: factor out output pin
 frequency helper
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org, jiri@resnulli.us,
 min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 06:57:14 +0000
Message-ID: <179075143473.434549.6645482932885266924@kernel.org>
In-Reply-To: <20260928185552.1103515-6-ivecera@redhat.com>
References: <20260928185552.1103515-6-ivecera@redhat.com>
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

- [Low] The kernel-doc of the new helper
  zl3073x_dpll_output_pin_freq_set() in drivers/dpll/zl3073x/dpll.c says…

Pre-existing issues:
- [High] A user with CAP_NET_ADMIN can trigger a divide-by-zero oops in
  zl3073x_dpll_output_pin_freq_set() (drivers/dpll/zl3073x/dpll.c:1058,…
- [Medium] (Baseline: preexisting, medium; not reported as a finding of
  this patch.) In the N-div P-pin branch of…
- [Medium] (Baseline: preexisting, medium; not reported as a finding of
  this patch.) In zl3073x_dpll_output_pin_freq_set(), the P-pin rescale…
- [Low] (Baseline: not confirmed as a new issue.) The concern says
  zl3073x_dpll_output_pin_freq_set() does not validate its input, which…

--

dpll: zl3073x: factor out output pin frequency helper

This commit moves the divisor and N-division computation out of
zl3073x_dpll_output_pin_frequency_set() into a new helper,
zl3073x_dpll_output_pin_freq_set(). The helper updates a struct
zl3073x_out but does not write it to hardware, so the upcoming PTP
periodic output code can reuse it. No functional change is intended.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index fcf91aba2988..0a36a2acf15b 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -1032,96 +1032,109 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,

[ ... ]

> +zl3073x_dpll_output_pin_freq_set(struct zl3073x_dpll_pin *pin,
> +				 struct zl3073x_out *out, u64 frequency)
>  {

[ ... ]

> +	synth = zl3073x_out_synth_get(out);
> +	synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
>  	new_div = synth_freq / (u32)frequency;

[Severity: High]
This isn't a bug introduced by this patch, but can frequency be 0 here?
The old zl3073x_dpll_output_pin_frequency_set() had the same division.

zl3073x_pin_props_get() always puts the current frequency in slot 0 of
the supported list:

    ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);

curr_freq comes from zl3073x_dev_output_pin_freq_get(), which returns 0
for an output running below 1 Hz. Two examples:

  - an N-div N-pin with synth 1 GHz, div 10 and esync_n_period 2e8
  - a P-pin with div > synth_freq

zl3073x_out_state_fetch() only rejects a zero div and a zero
esync_n_period, so both setups are accepted.

Suppose the pin is first moved to another advertised frequency (for
example 1 Hz, or through a rescale caused by the sibling P-pin). A later
DPLL_CMD_PIN_SET with frequency 0 then passes
dpll_pin_is_freq_supported() through the {0, 0} range.

It also skips the "freq == old_freq" shortcut in dpll_pin_freq_set(),
because old_freq is no longer 0:

dpll_nl_pin_set_doit()
  dpll_pin_freq_set()
    zl3073x_dpll_output_pin_frequency_set()
      zl3073x_dpll_output_pin_freq_set()
        new_div = synth_freq / (u32)frequency;

On x86 this looks like a divide error oops, raised while zldpll->lock
and the dpll core lock are held.

Would it make sense to return -EINVAL from the helper for !frequency
(and for new_div == 0)? That would also match the new kernel-doc.
Another option is for zl3073x_pin_props_get() to skip a zero curr_freq.

[Severity: Low]
This is a pre-existing issue, but what happens here if the synth reports
a frequency of 0?

zl3073x_synth_state_fetch() only validates freq_n, so a synth_freq of 0
read from the device gives new_div == 0. In that case div = 0 is
committed, and zl3073x_dev_output_pin_freq_get() later divides by
out->div. This case looks speculative, and the netlink path could
already reach it before this patch.

The upcoming PTP caller does not seem to add a new path into this
division. zl3073x_dpll_perout_enable(), added later in the series by
"dpll: zl3073x: add PTP periodic output support", rejects everything
except a 1 second period and passes a constant:

    rc = zl3073x_dpll_output_pin_freq_set(pin, &out, 1);

So the only remaining gap between the helper's "-EINVAL if the
frequency cannot be represented" contract and its behaviour is the
frequency 0 case above and this synth_freq 0 case.

[ ... ]

>  	if (zl3073x_dpll_is_p_pin(pin)) {
> -		/* We are going to change output frequency for P-pin but
> -		 * if the requested frequency is less than current N-pin
> -		 * frequency then indicate a failure as we are not able
> -		 * to compute N-pin divisor to keep its frequency unchanged.
> -		 *
> -		 * Update divisor for N-pin to keep N-pin frequency.
> +		/* Changing the P-pin frequency, rescale the N-pin divisor to
> +		 * keep the N-pin frequency unchanged. Fail if the requested
> +		 * frequency is too low to represent the current N-pin one.
>  		 */
> -		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> -		if (!out.esync_n_period) {
> -			rc = -EINVAL;
> -			goto unlock;
> -		}
> +		out->esync_n_period = out->esync_n_period * out->div / new_div;
> +		if (!out->esync_n_period)
> +			return -EINVAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but does this rescale really
keep the N-pin frequency unchanged? The division truncates, and only a
zero result is rejected.

For example, synth 1 GHz, div 100 and esync_n_period 2 give P = 10 MHz
and N = 5 MHz. Setting P to 8 MHz passes zl3073x_pin_check_freq(). That
gives new_div = 125 and esync_n_period = 200 / 125 = 1, so N becomes
8 MHz while the helper returns 0.

zl3073x_dpll_output_pin_frequency_set() only looks up the sibling for
non N-divided formats:

    if (!zl3073x_out_is_ndiv(&out))
        sibling = zl3073x_dpll_output_pin_sibling_get(pin);

So no change notification is sent for the N-pin even though its
frequency changed.

The old code had the same (out.esync_n_period * out.div) / new_div
rescale. The earlier commit "dpll: zl3073x: notify sibling pin when
shared output config changes" limited the notification to non N-divided
formats.

Could the helper return -EINVAL when the rescale is not exact?

[Severity: Medium]
This is also a pre-existing issue, but can out->esync_n_period *
out->div overflow here? Both are u32, so the product is computed in 32
bits before the division by new_div.

If div * period exceeds 2^32 (an N-pin below about 0.23 Hz on a 1 GHz
synth), the product wraps:

  - div 8, period 536870912 and a new P of 62.5 MHz (new_div 16): the
    product wraps to exactly 0, so a representable setup is rejected
    with -EINVAL.
  - period 600000000: the wrapped product is 505032704, which gives
    period 31564544. The N-pin then runs at about 1.98 Hz instead of
    about 0.208 Hz.

Would something like div_u64((u64)out->esync_n_period * out->div,
new_div), with a range check on the result, be safer?

[ ... ]

>  	} else {
> -		/* We are going to change frequency of N-pin but if
> -		 * the requested freq is greater or equal than freq of P-pin
> -		 * in the output pair we cannot compute divisor for the N-pin.
> -		 * In this case indicate a failure.
> -		 *
> -		 * Update divisor for N-pin
> +		/* Changing the N-pin frequency. Fail if the requested
> +		 * frequency is higher than or does not divide the P-pin one.
>  		 */
> -		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
> -		if (!out.esync_n_period) {
> -			rc = -EINVAL;
> -			goto unlock;
> -		}
> +		out->esync_n_period = div64_u64(synth_freq,
> +						frequency * out->div);
> +		if (!out->esync_n_period)
> +			return -EINVAL;
>  	}

[Severity: Low]
Is the new comment accurate? It says the helper fails when the requested
frequency "does not divide the P-pin one". However, div64_u64() truncates
and only a zero quotient is rejected.

The new kernel-doc makes a similar promise:

    Return: 0 on success, -EINVAL if the frequency cannot be represented

For example, take synth 1 GHz and div 100 (P = 10 MHz):

  - A request for N = 4 MHz passes zl3073x_pin_check_freq(), because
    1e9 % 4e6 == 0.
  - esync_n_period becomes 1e9 / 4e8 = 2 (2.5 truncated), and the
    helper returns 0.
  - zl3073x_dev_output_pin_freq_get() then reports N = 5 MHz.

The non N-divided branch also returns 0 without checking new_div.

The truncation itself was already there. What this patch adds is the
comment and kernel-doc that don't match it.

Should there be a remainder check here, such as returning -EINVAL when
synth_freq % (frequency * out->div) is nonzero? Or should the comment
and kernel-doc be reworded to match the current behaviour?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928185552.1103515-1-ivecera%40redhat.com
