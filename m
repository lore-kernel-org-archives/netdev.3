Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67236E467;
	Mon, 12 Oct 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785631; cv=none; b=gEudBsSL7GoKfst1280a762vMqlCfVunIZZB09EKHzMd3RQnrKLBixCZID+29dOADuiW0DJu61F1K5RT7ONkL7MPQWuobIo7dtDkBSWq3VrTNXlYURO9UNFOXN3ZmFL3CMFRHmIw40jcxpCA7XgqEeGsdamAv5OUsbxI445hfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785631; c=relaxed/simple;
	bh=jaNhmT/A3UR/G0Qrd1GYCMT6nbxbQ7UTmQbiEviL8Cg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJ5yP2b3PF8/ZHExZdw1Bp0bq6tPhd0SsWXl6BsKbvf1AUk09qqe7mRUD0NwMlkwMEcB29Vj7V5nl0IviTfemkcGAO16mBgJ02ERGCwB9opbbp8l57gVU9c9yYxF1FMYCSNowdk6Ysd3intMIFzhFOaMmzi+JLmxkHM89y/SmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+KzYl7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+KzYl7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F921F0089C;
	Mon, 12 Oct 2026 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791785625;
	bh=Mvj0U8Nl8l83AOKHgGrnxg0TO7XSBrqcj1D3KHshkVE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U+KzYl7ulOwO9tOJOL5ncMtqzoz2J1M/+trVE/OCXSRitY80TgsWY09O0qOAn49QM
	 a3qYQW41c36ErxGRvOVXZK35fvolgCM5uMDn7yf1K2CBwvNw0gazokhbDU5Zrj5WUS
	 poGTg5id88smCOscITPpDbG7zyeJP0IjERl07Ws46y3zjQY4Uv/ycrg9R55RbarZEJ
	 anxi5LTieuQ/7OB0OSIaygBFkyk5s0fv/tzxsWAbyPNkHtY9SLKmjkGwuc94x+YQYF
	 RahgLqtpEVouznuri3mJ860cyN1YqTXysU7DIZmf+p52kMj8C18sqL3EUqxg7iFTpj
	 Ejdpj6+ISgsow==
Subject: Re: [PATCH net v5 5/5] dpll: zl3073x: notify sibling pin when shared
 output config changes
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, min.li@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 06:13:44 +0000
Message-ID: <179178562457.434549.16379323333856475098@kernel.org>
In-Reply-To: <20261011061211.448373-6-ivecera@redhat.com>
References: <20261011061211.448373-6-ivecera@redhat.com>
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

- [Low] The patch passes pins that may not be registered to
  __dpll_pin_change_ntf(), whose kernel-doc requires a "registered pin…

--

dpll: zl3073x: notify sibling pin when shared output config changes

This commit adds zl3073x_dpll_output_pin_sibling_get(). The output
frequency, esync and phase adjust set callbacks now use it to send a
change notification for the other pin of the P/N pair. So that the
sibling can always be found, pins are added to zldpll->pins before
dpll_pin_register() and removed only after dpll_pin_unregister().

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 6d9a6d21d30b7..1cdadb8e46fb2 100644
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
Is it ok to pass a sibling that may not be registered to
__dpll_pin_change_ntf()? The kernel-doc for that function asks for a
registered pin:

drivers/dpll/dpll_netlink.c:
/**
 * __dpll_pin_change_ntf - notify that the pin has been changed
 * @pin: registered pin pointer
 ...
int __dpll_pin_change_ntf(struct dpll_pin *pin)
{
	lockdep_assert_held(&dpll_lock);
	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
}

dpll_pin_event_send() checks dpll_pin_available(), so no netlink message
is sent. But dpll_pin_notify() runs before that check, so the in-kernel
notifier chain still gets DPLL_PIN_CHANGED for the unregistered pin.

This window looks reachable during probe. zl3073x_dpll_register()
registers the dpll device before its pins, and pins are registered in
index order. That means P is already registered when N is list_add()ed
in zl3073x_dpll_pin_register():

    mutex_lock(&zldpll->lock);
    list_add(&pin->list, &zldpll->pins);
    mutex_unlock(&zldpll->lock);

    /* Register the pin */
    rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin, ops, pin);

Suppose a DPLL_CMD_PIN_SET on P holds dpll_lock from dpll_pin_pre_doit().
N's dpll_pin_register() then waits on dpll_lock. Meanwhile P's callback
finds N on the list and sends DPLL_PIN_CHANGED for N before N's
DPLL_PIN_CREATED.

Teardown is the mirror case. list_add() inserts at the head, so N is
unregistered before P. N also stays on the list until after
dpll_pin_unregister() returns in zl3073x_dpll_pin_unregister(). A
PIN_SET on P during that window would send CHANGED for N after its
DPLL_PIN_DELETED.

zl3073x_dpll_output_pin_frequency_set() and
zl3073x_dpll_output_pin_phase_adjust_set() have the same issue.

zl3073x_dpll_nco_pin_register() now also adds the NCO pin to the list
before dpll_pin_register(). Because of that, the existing callers that
notify the result of zl3073x_dpll_nco_pin_get() (the input pin
state_on_dpll_set and mode_set paths) hit the same window.

As the commit message notes, nothing breaks in-tree today, because
ice_dpll_pin_notify() ignores every action except DPLL_PIN_CREATED and
DPLL_PIN_DELETED.

Would it be better to skip the notification when the sibling is not
registered? Alternatively, the __dpll_pin_change_ntf() kernel-doc and
dpll_pin_notify() could be updated to accept unregistered pins
explicitly.

> +
> +	return rc;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011061211.448373-1-ivecera%40redhat.com
