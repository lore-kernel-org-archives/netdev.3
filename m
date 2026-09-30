Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817642BC5E;
	Wed, 30 Sep 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751446; cv=none; b=ltaiAwu5Yp+ghcYr7Uc7XZR2JS+KT5ADzOZ4QI6eh04SBmxWOvuIA1y8FBHbtd7oFpzBU+u2V4qiohPrtwOxKiWBBD4WNjj2yypBCdNLqECq7rSx0WU5xIzvQhrcHU5VuTxKy00nK9v1A5NLwUBVOEppYYObQ41Qin8zuIe3mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751446; c=relaxed/simple;
	bh=cW0L/6U2wH5lOghWo51egtWhftW0U/R+FHkZsU1b/mk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZe9pwjVffkabYUqobd+l1wT9EuCDNl7S1CK+pVpuYCpC3tSyWsKI8g6JyOxLnWqfOQ9RSvXg3qQtTMK4NMJDTBJVb7s/K16C1M5V59gRda+UOOmGB46b1xjPR/h30O4btga1v0PBcUCjfHjM/z/SDYEAMow9qbOrXwIX7AQlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM8obWgB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM8obWgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6B1F000FF;
	Wed, 30 Sep 2026 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751432;
	bh=ArBKFQmDc8fyjYvPJN8X5MyVX8kcqQY3wOHZcaDNFIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cM8obWgBRTfbBwv0abh1VryOFFKuWcRWLG5pUtHvAfm6RLlsT5zGZ2Yzm4JuAVG4m
	 oMQ4Y1b3IizjzAc6BicKCAb+4lDmbICKKpnJid5HnBAwMWpAyWde5d4NJ2dl5EX4lW
	 79fe4NmeYnTu9VmwQM86454jlSCL0G5RLPrD9NegIE6g3/LHi9c0A2YUHfaEuTaV+p
	 8pWYbP0iRA7cfz6+TZlCft8Ud7BNQBoHlxTknb/Vjo4EF8aJKtyprT8hVlxNVkvhSU
	 uvnTKF5BmVW99LoWKPx6x+gymtB0jbhGn9LGTVGYwoDHDxrBG63hN27GMmmb8IZzNQ
	 rCog4FwXcfrVQ==
Subject: Re: [PATCH net-next 1/6] dpll: zl3073x: notify sibling pin when
 shared output config changes
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, kuba@kernel.org, jiri@resnulli.us,
 min.li@microchip.com, pabeni@redhat.com, poros@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 06:57:11 +0000
Message-ID: <179075143120.434549.1576015918203645155@kernel.org>
In-Reply-To: <20260928185552.1103515-2-ivecera@redhat.com>
References: <20260928185552.1103515-2-ivecera@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds zl3073x_dpll_output_pin_sibling_get()
  (drivers/dpll/zl3073x/dpll.c:146).
- [Medium] The commit says it closes the case where the sibling pin's
  frequency changes without a notification.
- [Low] The commit message presents the missing sibling notification as a
  user-visible defect: userspace listening on the sibling pin "is never…

--

dpll: zl3073x: notify sibling pin when shared output config changes

This patch adds zl3073x_dpll_output_pin_sibling_get(), which finds the
other pin of a P/N output pair. The esync, frequency and phase adjust
setters use it to send a pin change notification for the sibling after
the shared output registers are written, and they now use explicit
mutex_lock()/mutex_unlock() so the notification goes out after
zldpll->lock is dropped.

> Changing one of these settings through one pin's dpll_pin therefore
> also changes the other (sibling) pin's effective configuration, but
> only the pin the change was requested on gets a dpll_pin_change_ntf()
> notification - userspace listening on the sibling pin is never told
> its frequency, esync configuration or phase adjustment changed.

[Severity: Low]
This describes a user-visible defect, but the trailers only have
Tested-by: and Signed-off-by:.

The dpll core only calls __dpll_pin_change_ntf() for the pin in the
request (for example in dpll_pin_freq_set()). The sibling has not been
notified since the output setters were added.

Should this carry Fixes: tags such as these?

Fixes: 634ca2cb06d2 ("dpll: zl3073x: Add support to get/set esync on pins")
Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index f2e137475b40..2c6de4dab8b4 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -132,6 +132,30 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>  	return NULL;
>  }
>  
> +/**
> + * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
> + * @pin: output pin whose sibling is sought
> + *
> + * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
> + * single HW output. Looks up the other pin of the pair, if it is
> + * registered as a dpll_pin on this DPLL.
> + *
> + * Return: pointer to sibling pin, or NULL if it is not registered
> + */
> +static struct zl3073x_dpll_pin *
> +zl3073x_dpll_output_pin_sibling_get(struct zl3073x_dpll_pin *pin)
> +{
> +	struct zl3073x_dpll_pin *sibling;
> +
> +	list_for_each_entry(sibling, &pin->dpll->pins, list) {
> +		if (!zl3073x_dpll_is_input_pin(sibling) &&
> +		    sibling->id == (pin->id ^ 1))
> +			return sibling;
> +	}
> +
> +	return NULL;
> +}
> +

[ ... ]

> @@ -934,27 +962,44 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,

[ ... ]

> +	/* Commit output configuration */
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +	if (rc)
> +		goto unlock;
> +
> +	/* The clock type, esync period and esync width are all shared by
> +	 * both pins of the output pair, so the sibling pin's esync
> +	 * configuration changes too and userspace has to be notified.
>  	 */
> -	out.esync_n_width = out.div / 2;
> +	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
>  
> -	/* Commit output configuration */
> -	return zl3073x_out_state_set(zldev, out_id, &out);
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (sibling)
> +		__dpll_pin_change_ntf(sibling->dpll_pin);

[Severity: High]
Can sibling->dpll_pin be NULL, or the sibling already freed, by the time
it is dereferenced here?

zl3073x_dpll_output_pin_sibling_get() returns any output pin on
zldpll->pins with the matching id. It does not check that
sibling->dpll_pin is still set. The lookup runs under zldpll->lock, but
the dereference happens after mutex_unlock().

The teardown path does not take zldpll->lock:

drivers/dpll/zl3073x/dpll.c:zl3073x_dpll_pins_unregister() {
	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
		zl3073x_dpll_pin_unregister(pin);
		list_del(&pin->list);
		zl3073x_dpll_pin_free(pin);
	}
}

zl3073x_dpll_pin_unregister() ends with:

	dpll_pin_put(pin->dpll_pin, &pin->tracker);
	pin->dpll_pin = NULL;

and dpll_pin_put() has already dropped dpll_lock at that point.

zl3073x_dpll_pins_register() uses list_add(), so the N pin (2k+1) sits
before its P pin (2k) on the list. That means N is torn down while P is
still registered and reachable over netlink.

One possible interleaving:

CPU1 (devlink reload, flash_prepare or unbind)
zl3073x_dev_stop()
  zl3073x_dpll_unregister()
    zl3073x_dpll_pins_unregister()
      dpll_pin_put(N)          /* dpll_lock released */

CPU0 (DPLL_CMD_PIN_SET on P, dpll_lock held)
dpll_pin_freq_set()
  zl3073x_dpll_output_pin_frequency_set(P)
    mutex_lock(&zldpll->lock)
    sibling = zl3073x_dpll_output_pin_sibling_get(P)  /* finds N */
    mutex_unlock(&zldpll->lock)

CPU1
      N->dpll_pin = NULL
      list_del(&N->list)
      zl3073x_dpll_pin_free(N)

CPU0
    __dpll_pin_change_ntf(sibling->dpll_pin)

In that case, would __dpll_pin_change_ntf() get NULL and oops on
pin->id and pin->clock_id in dpll_pin_notify()? Or would CPU0 read the
freed zl3073x_dpll_pin?

The list walk in zl3073x_dpll_output_pin_sibling_get() can also run
while list_del() is in progress, because the writer never takes
zldpll->lock.

zl3073x_dpll_output_pin_frequency_set() and
zl3073x_dpll_output_pin_phase_adjust_set() have the same pattern.

The later patch "dpll: zl3073x: add PTP periodic output support" also
calls zl3073x_dpll_output_pin_sibling_get() from
zl3073x_dpll_ptp_enable() without holding zldpll->lock at all.

[ ... ]

> @@ -1010,7 +1058,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		out.width = new_div;
>  
>  		/* Commit output configuration */
> -		return zl3073x_out_state_set(zldev, out_id, &out);
> +		rc = zl3073x_out_state_set(zldev, out_id, &out);
> +		if (rc)
> +			goto unlock;
> +
> +		/* The other pin's frequency changed too - it has to be
> +		 * notified about the change.
> +		 */
> +		sibling = zl3073x_dpll_output_pin_sibling_get(pin);
> +
> +		goto unlock;
>  	}
>  
>  	if (zl3073x_dpll_is_p_pin(pin)) {
> @@ -1022,8 +1079,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		 * Update divisor for N-pin to keep N-pin frequency.
>  		 */
>  		out.esync_n_period = (out.esync_n_period * out.div) / new_div;

[Severity: Medium]
Does the N pin also need a notification on this path?

In the N-div formats OUTPUT_DIV is still shared. The N-pin frequency is
computed from both values:

drivers/dpll/zl3073x/core.h:zl3073x_dev_output_pin_freq_get() {
	...
	freq = zl3073x_synth_freq_get(synth) / out->div;

	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
		freq /= out->esync_n_period;
	...
}

The rescale above truncates and only rejects 0. zl3073x_pin_check_freq()
only requires the new P frequency to divide the synth frequency.

For example, take a 500 MHz synth with P = 10 MHz (div 50) and
N = 2 MHz (period 5). Setting P to 25 MHz gives new_div 20 and period
250 / 20 = 12. N then becomes 500M / (20 * 12), about 2.083 MHz.

This path reaches the unlock label with sibling still NULL, so the N
pin gets no DPLL_CMD_PIN_CHANGE_NTF. The commit message says the sibling
is notified "whenever the shared HW state actually changes". Should this
case be covered too?

The later commit "dpll: zl3073x: factor out output pin frequency helper"
does not change this. The truncation moves into
zl3073x_dpll_output_pin_freq_set(), and frequency_set still calls
zl3073x_dpll_output_pin_sibling_get() only when
!zl3073x_out_is_ndiv(&out).

> -		if (!out.esync_n_period)
> -			return -EINVAL;
> +		if (!out.esync_n_period) {
> +			rc = -EINVAL;
> +			goto unlock;
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928185552.1103515-1-ivecera%40redhat.com
