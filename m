Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE388359A9B;
	Sat, 26 Sep 2026 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390097; cv=none; b=PsbaukrL26b5A1noIoDZa46FbYRScTfqFr9GlCApvnWShvN0yFWLwobmm1hQu3Ivjen7jaAz6V89mezlvtZwGcY6tAfbkcsmvZkIg50/Fa8eDE00NQFQpsmQ7sk9ZQvbXIVuy8Scf/KSy1WvMsM8I75vIGaRgauQicNhefZ6YSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390097; c=relaxed/simple;
	bh=rCyy7IYMnZaL5awKc1ilJM4E1oljEzh5ycw3dA206jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CywnSq0uc8vJN2MOqn5ql7LaeBGl5OTbWxzATD0vZi1/wU8dWabh/GXUBvz6Dwe682YMujqaidlLLtpve2stl4+4ictQWheQImbbB21w2DSb+gncsoA7a3DQpmq9HrssztMFma2AcdIzMRrT+yHBn3P0YnltewuxcVQpJffR9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Quicnqyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Quicnqyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A3B1F00898;
	Sat, 26 Sep 2026 02:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390095;
	bh=UCNawWQ9X/ITFcrHMgBgIf+lCUhFU5q8jyAxodrPYX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QuicnqypfwVMSKQIOj+fSyWMdmZZpoQEBdFekz4PvSn3p+E7WV3EwY+K/Y31tU2UM
	 GS+aHz8Wp9Ig+T1cmr0n76bJF9a3sARX98sQgGT07aD2qRiefErvaOKFFP4YsV5T5x
	 WtFiN6pcpNEzRM7+lbm8gzRbKJikFBnSxHGB5JdiDLEioN2x0WPkROdg0qcCOSgmSw
	 s2t8Qbvt05485iAH73X2KyweS78vWnG5hwKYGQAjbkDN8y6c5OUu4IR0olR86oDQJX
	 nscyLjSTg0+QNwh9NsOChulaiIVKzhulx8BXcLmSegNth6IXWWdGGGQW7KP2yZh+zC
	 55hHhtgx7gUxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 13/14] dpll: sit9531x: model the inter-PLL sync net as a pair of pins
Date: Fri, 25 Sep 2026 19:34:54 -0700
Message-ID: <20260926023454.1568195-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-14-arouhi@sitime.com>
References: <20260921201108.42676-14-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: sit9531x: model the inter-PLL sync net as a pair of pins

This patch models the device's internal inter-PLL sync (INTSYNC) net as
two DPLL pins: an output pin on the source PLL and an input pin on each
destination PLL. It adds sit9531x_intsync_enable(),
sit9531x_intsync_disable() and sit9531x_intsync_src_detect() in core.c,
and dpll.c gets the pin ops that use them.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 1cb691f040194..e8d47999f1a97 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2264,9 +2264,9 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
>   * block at base = 0x15 + 16 * (slot % 6); the slot is the physical
>   * output position from clkout_map[], not the logical output index.
>   *
> - * The chip only supports unsigned positive delay.  A negative phase
> - * adjustment (advance) is wrapped to (T_out - |phase|) modulo one
> - * output period, which is identical for a periodic signal.
> + * The chip only supports unsigned positive delay.  Requests are folded
> + * modulo one output period: positive delays wrap naturally and a negative
> + * phase adjustment (advance) is rendered as (T_out - |phase|).
>   */

[Severity: Low]
This isn't a bug, but this comment rewrite for
sit9531x_output_phase_adjust_set() has nothing to do with INTSYNC, and
neither the commit message nor the v10 notes mention it. Would it fit
better in "dpll: sit9531x: add support to adjust output phase", or in its
own patch?

[ ... ]

> @@ -2531,6 +2531,278 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)

[ ... ]

> +int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)
> +{

[ ... ]

> +	for (pll = 0; pll < SIT9531X_NUM_PLLS; pll++) {
> +		ext_page = SIT9531X_PLL_EXT_PAGE(pll);
> +
> +		for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +			u16 reg;
> +			u8 val;
> +
> +			reg = SIT9531X_REG(ext_page, intsync_config[i].offset);
> +
> +			rc = sit9531x_read_u8(sitdev, reg, &val);
> +			if (rc)
> +				return rc;
> +			if (val != intsync_config[i].en_val)
> +				break;
> +		}

[Severity: Medium]
Do these EXT page reads return the real register contents while the debug
window is locked?

sit9531x_intsync_enable() and sit9531x_intsync_disable() both write
SIT9531X_PLL_DEBUG_UNLOCK before they touch these offsets.
sit9531x_phase_offset_read() also unlocks before it reads:

	/* Unlock the debug page so the TDC registers are accessible. */

A locked read might return 0 or the lock value, or one of these bytes
might carry status bits. In any of those cases the exact en_val match
here never succeeds.

In sit9531x_dpll_intsync_src_state_on_dpll_set(), a successful enable
first records sitdev->intsync_src = sitdpll->id. The detect call that
follows would then overwrite it with -1.

The SYNCOUT pin would then read DISCONNECTED while the net is driven. The
"INTSYNC is already sourced by another PLL" check would also stop
blocking a second PLL.

The same applies at probe in sit9531x_dev_state_fetch(). A source that
the loaded configuration already set up would not be recognised.

[ ... ]

> +int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	/* Small update on source PLL */
> +	rc = sit9531x_write_pll_u8(sitdev, src_pll_idx,
> +				   SIT9531X_PLL_REG_SMALL_UPDATE,
> +				   SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		goto relock_err;
> +
> +	rc = 0;
> +	goto relock;
> +
> +relock_err:
> +	sit9531x_intsync_debug_lock(sitdev, ext_page);
> +	goto err_disable;
> +
> +relock:
> +	/*
> +	 * Close the EXT page debug window the sequence opened.  Nothing
> +	 * else writes the key back, so leaving it open would keep the block
> +	 * unlocked for as long as the device runs.
> +	 */
> +	lock_rc = sit9531x_intsync_debug_lock(sitdev, ext_page);
> +	if (lock_rc && !rc)
> +		rc = lock_rc;
> +
> +	return rc;

[Severity: Medium]
What happens if only this last sit9531x_intsync_debug_lock() fails?

By this point the global bit is set, the EXT page holds en_val and the
source PLL small update has been applied, so the net is being driven.
The function still returns lock_rc. Unlike the relock_err paths, it does
no rollback.

The caller then skips recording the owner:

	if (!rc && state == DPLL_PIN_STATE_CONNECTED)
		sitdev->intsync_src = sitdpll->id;

dpll_pin_state_set() then returns the error to userspace and sends no
change notification, even though the enable took effect.

Only the following sit9531x_intsync_src_detect() can record the owner.
If that read also fails, intsync_src stays -1 while the net is driven,
and another PLL can get past the -EBUSY check.

[ ... ]

> +int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
> +			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));
> +	if (rc)
> +		return rc;
> +
> +	/* Small update on Page 0 */
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
> +			       SIT9531X_SMALL_UPDATE_CMD);
> +	usleep_range(1000, 2000);
> +	if (rc)
> +		return rc;
> +
> +	/* Unlock debug on EXT page */
> +	rc = sit9531x_write_u8(sitdev,
> +			       SIT9531X_REG(ext_page,
> +					    SIT9531X_PLL_REG_DEBUG),
> +			       SIT9531X_PLL_DEBUG_UNLOCK);
> +	if (rc)
> +		goto relock;
> +
> +	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(ext_page,
> +						    intsync_config[i].offset),
> +				       intsync_config[i].dis_val);
> +		if (rc)
> +			goto restore_global;
> +	}
> +
> +	/* Small update on source PLL */
> +	rc = sit9531x_write_pll_u8(sitdev, src_pll_idx,
> +				   SIT9531X_PLL_REG_SMALL_UPDATE,
> +				   SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		goto relock;
> +
> +	rc = 0;
> +
> +restore_global:
> +	/*
> +	 * The global enable was cleared first, so a failure here leaves the
> +	 * EXT page still holding the enable pattern with nothing pointing
> +	 * at it: the source detector keys on the global bit, would report
> +	 * the net as unowned, and a retry of the disable would then
> +	 * short-circuit.  Put the bit back so the state stays one the
> +	 * driver can describe and the request can be repeated.
> +	 */
> +	if (!sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val))
> +		sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
> +				  val | BIT(SIT9531X_INTSYNC_EN_BIT));

[Severity: High]
Is a goto relock missing after rc = 0 here?

sit9531x_intsync_enable() has:

	rc = 0;
	goto relock;

In sit9531x_intsync_disable(), though, the success path falls straight
into restore_global. That code reads SIT9531X_REG_INTSYNC_GLOBAL and
writes SIT9531X_INTSYNC_EN_BIT back. Every successful disable therefore
ends with the global enable set again while the EXT page holds the
disable pattern.

No page-0 small update follows this write, so the next unrelated one
latches it. One example is the SIT9531X_REG_GLOBAL_UPDATE write that
sit9531x_prio_prg_commit() does on every priority table change.

The rollback in sit9531x_intsync_enable() goes through the same path:

	rollback_rc = sit9531x_intsync_disable(sitdev, src_pll_idx);

A failed enable therefore also leaves the global bit asserted. The
err_disable comment says the rollback is there to prevent exactly that.

This also doesn't match the kernel-doc ("Clears INTSYNC global bit") or
the commit message, which says setting the source pin "gives it up".

After the disable, sit9531x_intsync_src_detect() finds the enable bit set
but no matching PLL, and reports -1. Userspace sees DISCONNECTED while
the hardware global enable stays on.

> +
> +relock:
> +	/* Close the EXT page debug window the sequence opened. */
> +	lock_rc = sit9531x_intsync_debug_lock(sitdev, ext_page);
> +	if (lock_rc && !rc)
> +		rc = lock_rc;
> +
> +	return rc;
> +}

[Severity: Medium]
Does this error handling cover every partial failure that the v10 notes
describe ("a disable that fails part way leaves the state describable so
the request can be repeated")?

If the page-0 small update fails, the function returns directly. If the
EXT debug unlock fails, it jumps to relock. Both paths skip
restore_global, which leaves the global bit clear while the EXT page
still holds the full en_val pattern.

If a dis_val write fails part way through intsync_config[], the earlier
entries already hold dis_val. restore_global puts the global bit back,
but no PLL fully matches in sit9531x_intsync_src_detect() any more, and
no small update is issued.

If the source PLL small update fails, the function jumps to relock. The
global bit is clear and the disable pattern is staged but not applied.

In each case sit9531x_dpll_intsync_src_state_on_dpll_set() skips the
ownership update. It still calls sit9531x_intsync_src_detect(), though,
and that sets intsync_src to -1, either here:

	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {
		sitdev->intsync_src = -1;
		return 0;
	}

or because no PLL fully matches.

A retried DISCONNECTED then hits:

	if (sitdev->intsync_src != sitdpll->id)
		break;

It returns 0 without touching the hardware, so the leftover EXT page
configuration is never cleaned up.

With the cache at -1, a CONNECTED on another PLL gets past the -EBUSY
check. sit9531x_intsync_enable() on that PLL sets and applies the global
bit, which also reactivates the first PLL's leftover configuration.

Could that leave two PLLs configured to drive the net?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index fcdd19e0bd3b0..856c9bdf33d45 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -843,8 +857,234 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +static int
> +sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,

[ ... ]

> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		if (sitdev->intsync_src != sitdpll->id)
> +			break;
> +		rc = sit9531x_intsync_disable(sitdev, sitdpll->id);
> +		break;

[ ... ]

> +	if (!rc && state == DPLL_PIN_STATE_CONNECTED)
> +		sitdev->intsync_src = sitdpll->id;
> +	else if (!rc && state == DPLL_PIN_STATE_DISCONNECTED)
> +		sitdev->intsync_src = -1;
> +
> +	if (state == DPLL_PIN_STATE_CONNECTED ||
> +	    state == DPLL_PIN_STATE_DISCONNECTED)
> +		detect_rc = sit9531x_intsync_src_detect(sitdev);

[Severity: Medium]
Can a DISCONNECTED request on a PLL that doesn't own the net wipe the
real owner from the cache?

dpll_pin_state_set() passes the request straight to the driver and does
not filter out requests for the state the pin is already in. Say
intsync_src is PLL B and the request is for PLL A. The DISCONNECTED case
breaks out with rc == 0, and then this runs:

	else if (!rc && state == DPLL_PIN_STATE_DISCONNECTED)
		sitdev->intsync_src = -1;

That happens even though A never owned the net.

Only the following sit9531x_intsync_src_detect() can put B back. If one
of its reads fails, it returns before writing intsync_src, and the caller
only warns. The cache then stays -1 while B drives the net.

A later CONNECTED on PLL C would then get past the -EBUSY check and
enable C as a second source.

Should the cache only change when this PLL actually changed state?

[ ... ]

> +static int
> +sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,

[ ... ]

> +	switch (state) {
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		rc = sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);
> +		break;

[Severity: Low]
Should this path notify the sibling input pins whose priorities change?

sit9531x_input_prio_remove() compacts the remaining entries toward the
head of the table (kept[count++]), so every reference listed after
INTSYNC moves up one slot. dpll_pin_state_set() only notifies the
INTSYNC pin itself.

sit9531x_dpll_input_pin_prio_set() walks sitdpll->pins and calls
__dpll_pin_change_ntf() for each sibling whose slot moved. Nothing here
does that, so subscribers keep stale priorities for the siblings.

The existing DISCONNECTED path for physical inputs seems to have the
same gap, and this new setter copies it.

[ ... ]

> +static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops = {
> +	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_intsync_dst_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_intsync_dst_state_on_dpll_set,
> +	.prio_get		= sit9531x_dpll_input_pin_prio_get,
> +	.prio_set		= sit9531x_dpll_input_pin_prio_set,
> +};

[Severity: High]
This isn't a bug introduced by this patch, but reusing
sit9531x_dpll_input_pin_prio_set() here extends a pre-existing race with
teardown to the new pin.

sit9531x_dpll_pins_unregister() does this without holding dpll_lock or
multiop_lock around the list_del() and kfree():

	list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {
		sit9531x_dpll_pin_unregister(pin);
		list_del(&pin->list);
		kfree(pin);
	}

Once dpll_pin_unregister() has returned for one pin, a netlink prio_set
on a pin that is still registered can run
sit9531x_dpll_input_pin_prio_set(). That function walks the same list:

	list_for_each_entry(sibling, &sitdpll->pins, list) {

It reads and writes sibling->dir, id and prio as it goes.

The check below only avoids notifying through a NULL dpll_pin:

	if (sibling == dpin || !sibling->dpll_pin)
		continue;

Could the walk reach a pin that the teardown thread has just freed, or
follow LIST_POISON links?

This patch adds both INTSYNC pins to each sitdpll->pins list and gives
the destination pin this prio_set callback.

[ ... ]
