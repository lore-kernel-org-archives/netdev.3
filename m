Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9D283CAF;
	Mon,  5 Oct 2026 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162609; cv=none; b=EZjc6NWoIhI4+ZfUeQDDN2b3onHs8hqjKIY36GHCt1eL5UIiNukFnJDcT0HIkMlgKQSgNynuxZ2VvOGZUTrU5KS0zmMAWFYp+TKOX16pdz2XhmezbB6swZZT7zzD3c0EBiGebuftjFqjmQBNVYvzQyJ/kaFnkXaSIrhH/OR2Yf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162609; c=relaxed/simple;
	bh=vI2ta7csZ/Et15XF+9adaR1S/Ug/o+LRlRkt3dNyym4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQNrg1aih+89dyo8bQtGn636GYRKI0mvz+E6uN/sjjd4QGVRwiUghMbl7CIcACG/sYrNTo+7PyJtWCbL8jYf4AOOgNpFiEud7hPU1bBfboVNoSPYVxdNTJFl6EvEdYozUDnou3AxwmmZgG6Ygt1yo7c7BMHBl9XTdKJErI1nunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6tJUZCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6tJUZCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05081F00898;
	Mon,  5 Oct 2026 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162603;
	bh=rg7fga+zqCUFN+I0/3261w7hLADy16MvjxCMeAtluz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y6tJUZCPbGtT4HzqJA0ywP0o6UscDsItCRgrrqUQZkPvrd9Vtx/i5yAd0B3AChzsG
	 BHUejxLItsRhWNrOKQJ/v3KwUYlSPyx7lXCs+NqKzDXts+WPKWkDDmS4kUL6RIWghJ
	 pxs6G7SQGxaPEQag9OtVSCbj4ZDrDXd+IsIgG/g60r5fwmullNZLZInR4VTwOSQyk7
	 ErEQcWo5kTq2X0KobgWYN22OUGjfUbSOsCyB7phf0qIlOQvXX5snCm0UhbtRsB1Yll
	 Q0c3HJ5pB0KSp5fN7zZ9rWVUkRpliVXz/t+EXs4PUUDY+3DkwiJRSGuAs4+/JG/JZs
	 0qs0+8L3YzByQ==
Subject: Re: [PATCH net-next v11 08/13] dpll: sit9531x: add support to get and
 set priority on input pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:02 +0000
Message-ID: <179116260241.434549.7401028968217040174@kernel.org>
In-Reply-To: <20260930233714.87679-9-arouhi@sitime.com>
References: <20260930233714.87679-9-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_input_prio_set() (core.c:1175-1181) stores the
  requested priority with `chan->cfg_prio[input_idx] = prio;…
- [Medium] The first monitoring pass can silently absorb a real
  operational-state or priority change on an input pin.
- [Medium] sit9531x_prio_src_live() (core.c:614-622) checks only
  `!sitdev->ref[index].los`.
- [Low] The kernel-doc of sit9531x_dpll_input_pin_prio_set()
  (dpll.c:542-546) says "The other pins keep their priorities, so only…

--

dpll: sit9531x: add support to get and set priority on input pins

This patch adds prio_get and prio_set callbacks for the sit9531x input
pins. Each input keeps a priority per PLL, and the Page 1 priority table
is rebuilt from those priorities. The poll now watches priority and
operational state as well as state, and sends pin notifications after
multiop_lock is dropped.

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index f961b7af28fed..ebbf7f5a3394e 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> +/*
> + * sit9531x_dpll_input_pin_prio_set - set input pin priority
> + *
> + * Records the priority and, for a pin in this PLL's table, rewrites the
> + * Page 1 table in priority order (sit9531x_input_prio_set()).  The other
> + * pins keep their priorities, so only the named pin changes and the core
> + * notifies it.  A pin that is not in the table keeps the priority for when
> + * it is connected.
> + */

[Severity: Low]
Is the claim that "only the named pin changes" accurate when the reorder
moves the active reference? The commit message says the same thing:

  Setting one input's priority leaves every other input's
  as it was, so only the named pin changes and the core's own notification
  covers it.

sit9531x_prio_table_commit() calls sit9531x_prio_activesel_pick(). When
the new order puts another live source first, that function writes the
other source into the selection nibble:

	if (top != SIT9531X_PRIO_SRC_NONE &&
	    top != sit9531x_prio_top_live(sitdev, old))
		return top;

When that happens, the previously active pin's operstate goes from ACTIVE
to STANDBY, and the new top pin's goes the other way.

chan->selected_ref is only refreshed by sit9531x_chan_state_fetch() in the
poll. As a result, the notification that dpll_pin_prio_set() sends right
away for the named pin carries the old operstate. The sibling pins, and
the corrected operstate, are only notified by the next poll, up to
SIT9531X_STATUS_POLL_MS later.

> +static int
> +sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll,
> +				 void *dpll_priv, u32 prio,
> +				 struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_input_prio_set(sitdev, sitdpll->id,
> +				     sit9531x_input_hw_src(dpin->id),
> +				     (u8)prio);
> +	if (!rc)
> +		dpin->prio = prio;
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
If the table write fails, does the driver keep the rejected priority
anyway? sit9531x_input_prio_set() commits the new value before calling
the step that can fail:

drivers/dpll/sit9531x/core.c:sit9531x_input_prio_set() {
    ...
	chan->cfg_prio[input_idx] = prio;
	chan->cfg_known |= BIT(input_idx);

	if (!(chan->prio_mask & BIT(input_idx)))
		return 0;

	return sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);
}

Nothing restores cfg_prio if sit9531x_prio_table_commit() fails. It can
fail on the HO_FORCE update, a slot write, the latch, or the holdover
release.

On the failure path, sit9531x_prio_table_commit() reads the table back
and refreshes seen_srcs from it:

	} else if (!sit9531x_prio_table_read(sitdev, pll_idx, now)) {
		sit9531x_prio_mask_build(sitdev, pll_idx, now);
		memcpy(chan->seen_srcs, now, sizeof(chan->seen_srcs));
		chan->seen_valid = true;
	}

This means the check in sit9531x_chan_state_fetch() never re-seeds from
the hardware:

	if (!chan->seen_valid ||
	    memcmp(srcs, chan->seen_srcs, sizeof(chan->seen_srcs)))
		sit9531x_prio_cfg_seed(sitdev, pll_idx, srcs);

Meanwhile dpin->prio keeps the old value, and netlink gets an error. Can
this lead to the following?

  - prio_get reports a priority that the device rejected.
  - The next poll sees cfg_prio != pin->prio and sends
    dpll_pin_change_ntf() for a priority the device never took.
  - The next rebuild for any other reason, for example a state change on
    a sibling input of the same PLL, sorts by the stale cfg_prio in
    sit9531x_prio_table_build() and writes the rejected order.
    sit9531x_prio_activesel_pick() could then move the PLL to a different
    reference long after the failed request.

This code is unchanged at the end of the series.

[Severity: Medium]
With prio_set now available to userspace, can a reorder steer the PLL
onto an input whose monitor has disqualified it? sit9531x_prio_src_live()
only looks at LOS:

drivers/dpll/sit9531x/core.c:sit9531x_prio_src_live() {
    ...
	return !sitdev->ref[index].los;
}

It ignores ref->qual_fail. sit9531x_input_mon_fetch() sets qual_fail on
fine or coarse frequency drift, and
sit9531x_dpll_selection_operstate_get() reports that same condition as
DPLL_PIN_OPERSTATE_QUAL_FAILED.

Suppose prio_set moves a qualification-failed input ahead of a healthy
one. sit9531x_prio_table_commit() then does this:

		sel = sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,
						   srcs, sel);
		val = sit9531x_prio_slot_set(val, slot + 1, sel);

The drifting input counts as the top live source, so it is written into
the active-selection nibble. The comment on activesel_pick says the PLL
leaves the named source only when that source loses its signal. That
seems to contradict the commit message, which says "it takes the first
slot of its priority table whose signal is qualified".

The helper comes from the previous patch in the series, but this patch
exposes the reorder that triggers it. It is unchanged at the end of the
series.

[ ... ]

> @@ -625,39 +707,67 @@ void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)

[ ... ]

> +		if (sit9531x_input_prio_get(sitdev, sitdpll->id,
> +					    sit9531x_input_hw_src(id), &prio))
> +			prio = pin->prio;
> +
> +		changed = pin->seen &&
> +			  (state != pin->pin_state ||
> +			   operstate != pin->operstate || prio != pin->prio);

[Severity: Medium]
Can the first poll pass silently absorb a real operstate or priority
change? The probe ordering looks like this:

sit9531x_dev_start()
    sit9531x_dev_state_fetch()        <- fills ref[]/chan[] caches
    register DPLLs and pins           <- create ntfs and GETs use the caches
    kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);

sit9531x_dev_periodic_work()
    fetch state again
    sit9531x_dpll_changes_check()     <- every pin still has seen == false

The pins come from kzalloc_obj() in sit9531x_dpll_pin_alloc(), so
pin->seen is false on this first pass. Whatever differs, changed is false,
and the new values become the baseline.

An input might lose signal between the initial fetch and the first tick,
or the table might be rewritten and re-seeded in that window. Userspace
would then keep the snapshot from registration, with no notification
until some other change happens.

This patch adds operstate and prio to the comparison, so those attributes
now share the gap. The cache is already valid at registration, so could
the baseline be taken there instead?

> +		if (changed)
> +			dev_dbg(sitdev->dev,
> +				"%s: state %u->%u operstate %u->%u prio %u->%u\n",
> +				pin->label, pin->pin_state, state,
> +				pin->operstate, operstate, pin->prio, prio);
>  
> -		/*
> -		 * The first pass only takes the baseline: the pin was
> -		 * registered with this state, so nothing has changed yet.
> -		 */
> -		changed = pin->seen && state != pin->pin_state;
>  		pin->pin_state = state;
> +		pin->operstate = operstate;
> +		pin->prio = prio;
>  		pin->seen = true;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
