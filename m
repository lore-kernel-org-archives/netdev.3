Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0E20B80B;
	Mon,  5 Oct 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187649; cv=none; b=EhCzlXbvxSuzxe/xmvjnfgADUsjjRtUvOVeU9o+fzN3XZcm+lfc5SmXjlKRDZhBYBIUmouv8lzucYfsVOInG++GVs/3ibUF3XAeVMukiYos6hLUggP70VlwCqV50YKcKAWe6g8wsWlv+SInkTLUit8vo5dGOJYIIH/WrVpv0J4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187649; c=relaxed/simple;
	bh=8+7e7uNLPvU6SHl/oRrAX8IgB5f+bJlgww7hhwtaT78=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oU20smsypE2Qd6nzargf2QUgP2QSS3NfOqREN62oZWV3pY6FPDGBDNQVtCsWP2tlsBxkUrl00TAPzB3qQ9JHWb3OBRF+qupwxjb/VH3/hMRWdhs+WDqpJXYbrIzGV1sMtiJFLWhTV7ntKC/Ie6srUSq7ry9SBNPUoEmVyDo0yvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUqYmkMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUqYmkMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466461F000FF;
	Mon,  5 Oct 2026 08:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187647;
	bh=4RkWsmpYQqm2Q/pQJ2uicnshft+IrFWhDI4NXfbAtWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DUqYmkMXFr7v94h/XCG/Gd5FKy7Qma5zTsmm7/gdaNreO+8TO0eDpZ/beUpgLfGhQ
	 JKvpcXG1PsbMoWtFzxVVGdgppBhHaGIGxhEBqhbFGYV4O8PFc0wLd+A5DMnpzWFQ6x
	 7QiWQsC/o8ftq4S3J9++dpQ+85lvVZTo0d+1tJ86amhCIzvYoX73i95Ti0eClptPHi
	 6ZCocaAs8HyZ5nBz0IZFSZ/Vl5UL4Y8lnRJXQKq/VfWz6NIusi+GwG8y7folHjRO0g
	 RDuoDh4GRJJGkRmOWewpySGpk1WRaGyP8J4p8einWJeHqRPXr4WcNCQlKdNXuuaWUi
	 W2ibuRZkcH1HA==
Subject: Re: [PATCH net 2/2] dpll: zl3073x: notify sibling pin when shared
 output config changes
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 08:07:26 +0000
Message-ID: <179118764686.434549.7323327609139711994@kernel.org>
In-Reply-To: <20261001080648.1424172-3-ivecera@redhat.com>
References: <20261001080648.1424172-3-ivecera@redhat.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In N-div signal formats, setting the P-pin frequency can change
  the N-pin frequency without notifying the N-pin.
- [Low] The commit message overstates the locking change.

--

dpll: zl3073x: notify sibling pin when shared output config changes

This patch adds zl3073x_dpll_output_pin_sibling_get(). Frequency, esync
and phase adjust set callbacks use it to notify the other pin of an
output pair when shared output state changes. It also takes zldpll->lock
around the registration and unregistration changes to zldpll->pins.

> The sibling lookup walks the zldpll->pins list, so serialize all
> accesses to that list with zldpll->lock: take it around list_add() and
> list_del() in the pin (un)registration paths and assert it is held in
> the list walkers.

[Severity: Low]
Is this description accurate? After this patch, several walkers of
zldpll->pins still don't follow it.

zl3073x_dpll_changes_check() walks the list again after dropping the lock:

unlock:
	mutex_unlock(&zldpll->lock);
	...
	list_for_each_entry(pin, &zldpll->pins, list) {
		...
			dpll_pin_change_ntf(pin->dpll_pin);
	}

zl3073x_dpll_ref_sync_pairs_register() walks the list without the lock
and without an assertion. zl3073x_dpll_ptp_adjtime_phase_step() has no
lockdep_assert_held(), although its caller zl3073x_dpll_ptp_adjtime()
does hold the lock.

Also, zl3073x_dpll_pins_unregister() takes the lock around
list_splice_init(), not list_del(). list_del() runs outside the lock on
the spliced private list.

I don't see a live race here. The monitor work is only queued after
zl3073x_dpll_register() in zl3073x_dev_start(). It is cancelled
synchronously in zl3073x_dev_stop() before unregistration.
zl3073x_dpll_ref_sync_pairs_register() runs in the registration thread.

Could the message be narrowed to the lookup helpers? Alternatively, the
remaining walkers could take the lock, with assertions added where the
lock is already held.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 9eec27331fe3d..d71471d64aec4 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -1001,7 +1053,16 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		}
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
> @@ -1013,8 +1074,10 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>  		 * Update divisor for N-pin to keep N-pin frequency.
>  		 */
>  		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> -		if (!out.esync_n_period)
> -			return -EINVAL;
> +		if (!out.esync_n_period) {
> +			rc = -EINVAL;
> +			goto unlock;
> +		}
>  
>  		/* Update the output divisor */
>  		out.div = new_div;

[Severity: High]
In N-div mode, can setting the P-pin frequency change the N-pin
frequency without any notification for the N-pin?

This branch rewrites out.div, which the N-pin shares. It also recomputes
esync_n_period with truncating division, and only a zero result is
rejected. zl3073x_dev_output_pin_freq_get() reports the N-pin frequency
as:

	freq = zl3073x_synth_freq_get(synth) / out->div;

	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
		freq /= out->esync_n_period;

So if old_div * old_period is not a multiple of new_div, the N-pin
output changes.

For example, take a 600 MHz synth with div=60 and period=10, so P is
10 MHz and N is 1 MHz. Setting P to 2.5 MHz gives new_div=240 and
period = 600 / 240 = 2, so N becomes 1.25 MHz.

zl3073x_pin_check_freq() only checks that the requested frequency
divides the synth frequency, so this request is accepted.
zl3073x_out_state_set() then commits the new values to hardware.

The sibling is only looked up in the !zl3073x_out_is_ndiv() branch.
This path therefore reaches the unlock label with sibling == NULL, and
dpll_pin_freq_set() in the core only notifies the requested pin.

The commit message excludes N-div mode on the assumption that the N-pin
frequency is kept, but the arithmetic doesn't guarantee that.

Would it work to compare the sibling's effective frequency before and
after the commit and notify on change? Another option is to reject P
frequencies that can't keep the N frequency exact.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001080648.1424172-1-ivecera%40redhat.com
