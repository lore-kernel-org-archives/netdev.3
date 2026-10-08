Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC494E73A4;
	Thu,  8 Oct 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473507; cv=none; b=r1zfqoalbIO9hYAfZYPUVlq71nShgMMJ4y9gdDAvGmf8dM4a5bsARavvuN4sNFt881jMnepZyQDF0ccqxRrHvrFI4ltqaQcHru3VehSh90cg7LwLNT28njkhPONHbzxq7By6kwQdj2Oa0fbEI6Y6r0x7kZ/37iUMj110oGuNMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473507; c=relaxed/simple;
	bh=jDH5s6UK7sCe0QaYUrl6cP3J/9H/VXWTV7euB8UqE2k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcO32x/dPKqEltoVQFzm8HC+9IyDIvwyNq+smnOIyF0P82Be30Wrh3kypOTc0Cy69uXgD3e+IrArU6WnG95pNlG2zC1RnZfoKsQ5YSOd9MNGjBkBUwYb7mqtGJqSXqUdJVqcSpp/Zh2wghHIuj4nIy1Q3n650Fld1TUlVY6bqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfncSyRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfncSyRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989511F00898;
	Thu,  8 Oct 2026 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473506;
	bh=jMB7zgmiitN7L/EjhTpwo0HXq/xVNdDVYk0RppFAIZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nfncSyRUN4TzTx7xtiCUvwZ4ImalRkMXuXGK26pFqoHSjlfBlX1S2v4Sd6MACPCh0
	 Q1tp/m7egoYIqnNDsO7BZaOmEZ6JzZXth9ip7Zd987ztRBT63bOiJYcxJ6Dqdfv+d6
	 vxJLrd+2US5dRzjcBs1+WttBX0onp+Ll2kPX5DsBWzilScZlQyDEg5aHvh4LmlUyE2
	 FC51P/7iYk2osAH7ynfyig2J0d67nD3czWwC8Byc6B5YwwolTroQKiF24ss2e6FRfZ
	 nKDYnWPhKNItcufgnQtmi9/r3jWDRhnlDPqFIaLiG4826jWMWY3Bmy80YIren07C9x
	 0FdPlBE5Zxvtg==
Subject: Re: [PATCH net v3 4/4] dpll: zl3073x: notify sibling pin when shared
 output config changes
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 15:31:45 +0000
Message-ID: <179147350520.434549.16772916744710272674@kernel.org>
In-Reply-To: <20261006153116.347497-5-ivecera@redhat.com>
References: <20261006153116.347497-5-ivecera@redhat.com>
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

- [Low] The commit message describes the old teardown incorrectly.
- [Low] The documentation for zl3073x_dpll_output_pin_sibling_get() does
  not match its code, and the commit message's safety claim is only…

--

dpll: zl3073x: notify sibling pin when shared output config changes

The P and N pins of a zl3073x output share the divisor, clock type,
esync and phase compensation registers. This patch adds a sibling
lookup helper and sends a change notification to the sibling pin from
frequency_set(), esync_set() and phase_adjust_set(). It also changes
the order of list_add()/list_del() on zldpll->pins relative to DPLL
pin registration, and does both under zldpll->lock.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 65107b4cc4f82..9c678acc3e777 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -132,11 +134,39 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
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
> +	lockdep_assert_held(&pin->dpll->lock);
> +
> +	list_for_each_entry(sibling, &pin->dpll->pins, list) {
> +		if (!zl3073x_dpll_is_input_pin(sibling) &&
> +		    sibling->id == (pin->id ^ 1))
> +			return sibling;
> +	}
> +
> +	return NULL;
> +}

[Severity: Low]
Does this kernel-doc match what the helper does? It says NULL is
returned when the sibling is not registered. The loop only checks list
membership, direction and id.

This patch makes zl3073x_dpll_pin_register() and
zl3073x_dpll_nco_pin_register() add the pin to zldpll->pins before
dpll_pin_register(). It also makes zl3073x_dpll_pin_unregister()
remove the pin only after dpll_pin_unregister(). During those windows
the helper can return a pin that is not registered.

esync_set(), frequency_set() and phase_adjust_set() then pass that pin
directly to __dpll_pin_change_ntf(), whose kernel-doc says:

 * @pin: registered pin pointer

The window looks reachable. zl3073x_dpll_register() registers the DPLL
device before its pins, so a PIN_SET on the P pin can run while the N
pin's dpll_pin_register() waits on dpll_lock. On teardown, the N pin is
unregistered while the P pin is still available.

The commit message also says:

  A pin that is transiently on the list while
  not registered is harmless: __dpll_pin_change_ntf() is a no-op for a
  pin that is not available

Is that accurate? Only dpll_pin_event_send() checks
dpll_pin_available(). dpll_pin_notify() runs first and calls the
in-kernel notifier chain without any check:

__dpll_pin_change_ntf()
    dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
        call_dpll_notifiers(action, &info);
    return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);

So an in-kernel DPLL_PIN_CHANGED event can be sent for a pin that is
not registered. Nothing in the tree seems to be affected today: the
only in-tree notifier, ice_dpll_pin_notify(), ignores actions other
than CREATED and DELETED.

Should the kernel-doc and the commit message be corrected? The other
option is to check that the sibling is actually registered before it
is notified.

[ ... ]

> @@ -1784,6 +1874,13 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
>  	/* Unregister the pin */
>  	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
>  
> +	/* Remove the pin from the list only after it has been unregistered so
> +	 * that a still-registered pin is always findable as a sibling.
> +	 */
> +	mutex_lock(&zldpll->lock);
> +	list_del(&pin->list);
> +	mutex_unlock(&zldpll->lock);
> +
>  	dpll_pin_put(pin->dpll_pin, &pin->tracker);
>  	pin->dpll_pin = NULL;
>  
> @@ -1803,9 +1900,11 @@ zl3073x_dpll_pins_unregister(struct zl3073x_dpll *zldpll)
>  {
>  	struct zl3073x_dpll_pin *pin, *next;
>  
> +	/* Unregister each pin before removing it from the list so that a
> +	 * still-registered pin is always findable as a sibling.
> +	 */
>  	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
>  		zl3073x_dpll_pin_unregister(pin);
> -		list_del(&pin->list);
>  		zl3073x_dpll_pin_free(pin);
>  	}
>  }

[Severity: Low]
The commit message says:

  and teardown detached the whole list before unregistering any
  pin, so a sibling that is registered - and thus reachable by a PIN_SET
  on the other pin - could be missing from the list and never notified.

Does this describe the old teardown correctly? Before this patch,
zl3073x_dpll_pins_unregister() already unregistered each pin before
removing it from the list:

	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
		zl3073x_dpll_pin_unregister(pin);
		list_del(&pin->list);
		zl3073x_dpll_pin_free(pin);
	}

drivers/dpll/zl3073x/ has no list_splice() or similar call on this
list. A pin that was still registered therefore stayed on zldpll->pins
during teardown.

The list and the registration state only got out of step at
registration time, because dpll_pin_register() ran before list_add().
On the teardown side, this hunk mainly moves list_del() under
zldpll->lock, which the new lockdep-asserted lookup needs.

Could the commit message describe what the teardown change actually
does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006153116.347497-1-ivecera%40redhat.com
