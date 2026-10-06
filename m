Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400483D5660;
	Tue,  6 Oct 2026 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274093; cv=none; b=hxO+VumJkaQfSrX0DNYNw1DZ2qWNB61bdY8KNjTSMcFtHZGKm+Ll7FW39Q/RvhsjGScSUotvIvuNVS3KzGdSswxfqOBxi+1oYlnSOHjzJY5VNiBXSsd6BKBIT+R6c6NlJtoIolxaNQRjjAEHxOWerNRkf4gfNp68p4YmDKqIWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274093; c=relaxed/simple;
	bh=KL+ksE717BzOD3HiQ9kCEBd5VUChWDpBakRcR0b5QK8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwX7bFwHVW6tov+Zylmrxsge07L2ySQu+WgR0tdlwpFi2MzQG/btNVNIsQ5RW5HEIgK3jUoVHttS9XmaXWJ7kTWPAHVadpyLzDb1gKntskyx1YWGY8lPhphKMYJ2nwAZS70pwGwizwQptd5DJnzABUfpbdRpslAwL6t6iEqVPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffg2RizN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffg2RizN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37E81F000FF;
	Tue,  6 Oct 2026 08:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274087;
	bh=rf+KYZfX+C1WzYDI9/dDsEfB7cn7nqNtrsUIGOCN1AA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ffg2RizNiRPuY1/964slkns4u/mhcsts2kVJ1jmiKw3FNb0JQ395U56NmFLmnhvTn
	 idrqZuSsjdf766bJjUNgAasoteyyAuila8t/RYHIsN7TepXRuQiGDCKmmgIX+Xk6Df
	 mymb4JaPVTKUIaOR+YFh4RZ365OXGCZWBRlbnZekBhAWl/C5M9zKUZlHjgrl+KV2N8
	 WCjjIjJ7Pwkaj4UIBK+sutVpf4vsykL2xwEkXqP8G24v5TmfaRWN4v11Cmr6KuJfa+
	 KGWnokZNWV7pWEs/fQ8y5BnCgU+OIl0QNhQv0ugUo9RG2u8zpADjbhnewPgXKj2wkb
	 WZnWHlhChLZiw==
Subject: Re: [PATCH net v2 2/2] dpll: zl3073x: notify sibling pin when shared
 output config changes
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 08:08:06 +0000
Message-ID: <179127408644.434549.11543498613900347079@kernel.org>
In-Reply-To: <20261002074520.30048-3-ivecera@redhat.com>
References: <20261002074520.30048-3-ivecera@redhat.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In zl3073x_dpll_output_pin_frequency_set()
  (drivers/dpll/zl3073x/dpll.c), the N-div case is excluded from the new…
- [Medium] Pins are on zldpll->pins only for part of the time they are
  registered with the DPLL core, so the new sibling lookup can miss a…

--

dpll: zl3073x: notify sibling pin when shared output config changes

This commit adds zl3073x_dpll_output_pin_sibling_get(). The output pin
frequency, esync and phase adjust setters use it to send a change
notification for the other pin of a P/N output pair. The setters move from
guard(mutex) to explicit lock/unlock so the notification is sent after
zldpll->lock is dropped, and all accesses to zldpll->pins are now
serialized with zldpll->lock.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 19456fbeeea84..b60d3280574ad 100644
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
Can the N-pin's frequency still change on this path without a
notification?

In N-div mode, zl3073x_dev_output_pin_freq_get() computes the N-pin
frequency from both the shared divisor and esync_n_period:

	freq = zl3073x_synth_freq_get(synth) / out->div;

	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
		freq /= out->esync_n_period;

When the P-pin frequency is set, the esync_n_period rescale above
truncates whenever old_period * old_div is not a multiple of new_div.

For example, take a 1 GHz synth with div = 10 (P = 100 MHz) and period = 4
(N = 25 MHz). Setting P to 40 MHz gives new_div = 25 and period = 40 / 25 =
1, so N becomes 40 MHz. Both frequencies pass zl3073x_pin_check_freq()
because they divide the synth frequency.

zl3073x_out_state_set() then commits the new DIV and ESYNC_PERIOD values.
However, sibling is only assigned in the non-N-div branch, so it is still
NULL at the tail of the function:

	if (!rc && sibling)
		__dpll_pin_change_ntf(sibling->dpll_pin);

No notification is sent for the N-pin, even though it is registered in
N-div mode.

The truncation itself predates this patch. The missing notification,
though, is the case this patch sets out to fix. The commit message says:

    share a single HW output and, outside N-pin divide mode, share the
    output's divisor, ...

and:

    ... to notify the sibling pin, if it is registered, whenever the
    shared HW state actually changes.

Is that accurate, given that the divisor is also part of the N-pin
frequency in N-div mode?

Should this branch either notify the N-pin when its effective frequency
changes, or reject a rescale that is not exact?

[ ... ]

> @@ -1954,7 +2049,9 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>  			goto error;
>  		}
>  
> +		mutex_lock(&zldpll->lock);
>  		list_add(&pin->list, &zldpll->pins);
> +		mutex_unlock(&zldpll->lock);
>  	}

[Severity: Medium]
Can zl3073x_dpll_output_pin_sibling_get() miss a sibling that is already
registered with the DPLL core?

zl3073x_dpll_pin_register()->dpll_pin_register() publishes the pin. It
takes and drops dpll_lock and sends PIN_CREATE before the pin is added to
zldpll->pins here. P (even id) is registered before N (odd id), so this
window exists:

CPU1 (probe)
zl3073x_dpll_pins_register()
  zl3073x_dpll_pin_register(N)
    dpll_pin_register()
      N is now visible, PIN_CREATE sent

CPU2 (netlink PIN_SET on P, dpll_lock held)
zl3073x_dpll_output_pin_phase_adjust_set()
  zl3073x_out_state_set()
  zl3073x_dpll_output_pin_sibling_get()
    N is not on zldpll->pins yet, returns NULL

CPU1
  list_add(&pin->list, &zldpll->pins);

At that point userspace still has the CREATE values for N, but the shared
div, esync or phase_comp has already changed, and no change notification
is sent for N.

Teardown has the opposite window. zl3073x_dpll_pins_unregister() empties
the list before any dpll_pin_unregister() call:

	mutex_lock(&zldpll->lock);
	list_splice_init(&zldpll->pins, &pin_list);
	mutex_unlock(&zldpll->lock);

A PIN_SET on a P-pin that is still registered therefore also skips an
N-pin that is still registered. A DELETE notification follows in that
case.

This cannot cause a use-after-free. The sibling is freed only after
dpll_pin_unregister(), which needs dpll_lock, and the PIN_SET path holds
dpll_lock.

However, list membership does not match DPLL registration state, so the
notification this patch adds can still be lost. Should the lookup be tied
to registration state instead of list membership?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002074520.30048-1-ivecera%40redhat.com
