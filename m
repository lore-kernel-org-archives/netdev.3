Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911274BA1E8;
	Sat, 10 Oct 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660426; cv=none; b=F/XJo3KXJxncGz5pw5piKn+Kpdv/pMukMiCCRI0SWOKYSmeaFwXxU051wSJrawwYpIj2WPPxmQMA/HZ9L2op+tg/XcMnV3MDR2wk0tHm6Z/WQXyI2WX7db34sOzDe+5hXI+cpokXV1zvwsjsKyA8vHotMtAoFduyFgsLj+zOluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660426; c=relaxed/simple;
	bh=ZkWrqGWRTb87Ac1zWHjRr8z5mtZuXoIh9A/MZl3WbbI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZY9RZuxGXaqoaVmq7MURyOQLQZVVoO6PiOvuHVFXL0WQMivmC4nY1uZE74EiOHCK5wfoMobz3VdeWZF01KXF+DdmkihNBzY7tOFgoGiDqD4Cmtdm2JU65KSLcdJ4FQEBpHK/cen2XvjnFrodRUFdJeZPKPmsOTqCjkLsjjgosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4YCbxdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4YCbxdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99381F00893;
	Sat, 10 Oct 2026 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660425;
	bh=Vgut01B5vKZSJ0LsBBmaDnGkJN/c+aWHi8dv5KipzKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T4YCbxdBbKr0RNklDCMN0apiRAM1c/o+jJDhM4Mx4XADzbUQaex0RzdWXlyYQ+7qb
	 Vuw/dQe4d57U29e43El8MSv1oaaxvTB7dFPD4g/9eulR/b6U5xAtSptuinQNGiafC1
	 oWQChEgBe/OssHeJ86aeWD3rpafHmTZIabdvVOlMbijslAby6zMsVsxmXSV0TX7i3F
	 5TWCXzNtbmlsmgcJqsUZaSq6GSpp04CTuob9+11lbY2B9XeUFvll4HoiIigprseIf0
	 sVUlhjMkgpzEe567e0cwE2GxLa9lMXunREsq9eFVXQCOLjAYwf/muTnWRlwDgoVHQP
	 +fvbLaAQPwOvQ==
Subject: Re: [PATCH net v4 5/5] dpll: zl3073x: notify sibling pin when shared
 output config changes
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 19:27:04 +0000
Message-ID: <179166042422.434549.15231909137129079099@kernel.org>
In-Reply-To: <20261009192556.272263-6-ivecera@redhat.com>
References: <20261009192556.272263-6-ivecera@redhat.com>
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

- [Low] Pins that are on the list but not registered get passed to
  __dpll_pin_change_ntf(), and the new NCO comment is wrong.

--

dpll: zl3073x: notify sibling pin when shared output config changes

This patch adds zl3073x_dpll_output_pin_sibling_get(). It sends a change
notification for the sibling P/N pin from frequency_set(), esync_set() and
phase_adjust_set() after zldpll->lock is dropped. Pins are now added to
zldpll->pins before dpll_pin_register() and removed after
dpll_pin_unregister(), so a registered sibling can always be found.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 6d9a6d21d30b7..1d61fe5fe5862 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -132,11 +134,42 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>  	return NULL;
>  }
>  
> +/**
> + * zl3073x_dpll_output_pin_sibling_get - get the other pin of an output pair
> + * @pin: output pin whose sibling is sought
> + *
> + * Output pin ids are allocated in P/N pairs (P even, N odd) that share a
> + * single HW output. Looks up the other pin of the pair in the pin list
> + * of this DPLL. A pin is on the list from just before its registration
> + * until just after its unregistration, so a registered sibling is always
> + * found, but the returned pin may also be one that is not (yet or any
> + * longer) registered.
> + *
> + * Return: pointer to sibling pin, or NULL if it is not on the pin list
> + */

[ ... ]

> @@ -937,9 +974,24 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>  
>  	/* Enable 1PPS eSync for this pin frequency */
>  	zl3073x_out_esync_enable(&out, synth_freq / out.div);
> -
> +commit:
>  	/* Commit output configuration */
> -	return zl3073x_out_state_set(zldev, out_id, &out);
> +	rc = zl3073x_out_state_set(zldev, out_id, &out);
> +	if (rc)
> +		goto unlock;
> +
> +	/* The clock type, esync period and esync width are all shared by
> +	 * both pins of the output pair, so the sibling pin's esync
> +	 * configuration changes too and userspace has to be notified.
> +	 */
> +	sibling = zl3073x_dpll_output_pin_sibling_get(pin);
> +unlock:
> +	mutex_unlock(&zldpll->lock);
> +
> +	if (!rc && sibling)
> +		__dpll_pin_change_ntf(sibling->dpll_pin);

[Severity: Low]

The kernel-doc for __dpll_pin_change_ntf() in drivers/dpll/dpll_netlink.c
says its argument is "@pin: registered pin pointer". The kernel-doc for
zl3073x_dpll_output_pin_sibling_get() above says the returned pin "may
also be one that is not (yet or any longer) registered".

Should the sibling's registration state be checked before it is passed to
__dpll_pin_change_ntf() here? The same question applies to the matching
calls in zl3073x_dpll_output_pin_frequency_set() and
zl3073x_dpll_output_pin_phase_adjust_set().

__dpll_pin_change_ntf() runs the notifier chain before the
dpll_pin_available() check in dpll_pin_event_send():

int __dpll_pin_change_ntf(struct dpll_pin *pin)
{
	lockdep_assert_held(&dpll_lock);
	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
}

This means a notifier subscriber can get DPLL_PIN_CHANGED for a pin
before it got DPLL_PIN_CREATED, or after it got DPLL_PIN_DELETED.

It looks like this can happen during probe:

- zl3073x_dpll_device_register() runs before zl3073x_dpll_pins_register().
- The P pin (even id) is registered before its N sibling.
- A userspace PIN_SET on the registered P pin holds dpll_lock.
- That PIN_SET can find N on the list after list_add(), while
  dpll_pin_register(N) is still waiting for dpll_lock.

list_add() now runs before dpll_pin_register() for every pin type. So the
existing callers of zl3073x_dpll_nco_pin_get() and
zl3073x_dpll_pin_get_by_ref() can also get a pin that is not registered
yet and pass it to __dpll_pin_change_ntf(). Before this patch, that could
only happen during teardown, between dpll_pin_unregister() and list_del().

As the commit message says, no netlink message is sent for such pins, and
ice_dpll_pin_notify() ignores DPLL_PIN_CHANGED. So nothing visibly breaks
today.

Would a per-pin registered flag be cleaner? It could be set and cleared
under zldpll->lock around dpll_pin_register() and dpll_pin_unregister(),
and checked before notifying. Another option is to relax the core
kernel-doc and have dpll_pin_notify() check registration.

Separately, the new comment in zl3073x_dpll_nco_pin_register() says:

	/* Add the pin to the list before registering it with the DPLL core so
	 * that the list reflects the DPLL registration state.
	 */

Is this accurate? With the early list_add(), the list holds every
registered pin and also pins that are not registered yet.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009192556.272263-1-ivecera%40redhat.com
