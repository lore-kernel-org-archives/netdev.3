Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9272BE03C;
	Mon,  5 Oct 2026 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162608; cv=none; b=oSlEs7SrzZJEh3px4Mguv57Gn0cDDSaGkJA7qJ8eO+7E8zJmM67CFuVBC8s54R82t07qdmSrN1OPB6gciBdgwK3G4Q9KO857vfM1HkmyP/y3SrT1cLLOpF8khzmXveAsumiUlcC0eztVpnkDXT3IV154zG0dyFehwX8YbYIa7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162608; c=relaxed/simple;
	bh=aK9VvywEoHqNP4/GGwEzejuhawEFTmn9qWVu+Rf2FIQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL4PKFmwWwQOYkjFQ1J25FH4QXzkDnpksBbBDU0aOgm1PYB3/hKhZA1t8zReUGMIPCDp7xMS4GeRmcwKfbJhthbp9y2WVmMvhx1YDpXGehIassrLPumiSeF1M+0HklUNjiGfr3L/Ybbq/r9zY6vcNAF3I2vEhBldYlYaGmO16/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgATx3AX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgATx3AX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CB21F000FF;
	Mon,  5 Oct 2026 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162602;
	bh=H7I7yWFl5Njjf8tAhjDcfPrxJe3x0Kl4322c7WZQClU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VgATx3AXsIKiWtHepjb+7BSzOfE5f8Qp5tRLLvpKHI7Q4IA6BMaj0ZvoyXkI90Rf2
	 t3oXiA8XvlaMBaG+jE73t1FVxk5fZAk1mY6+aQ50wea42JjSqRP2t31d2KQp14V3Ai
	 qPTgRNY7XC8LE/MomawYueV/G20cWBAZS12wcvh/y/CyiJwAbDUoRDIdg+cqMARZUw
	 6EvNA4/q0pJ7DOnxxqMAZ4kZZraP3VPB7z8VnZQnpRxaYAjWi9GUW7tdTvH8tPlUDK
	 JrIyoymA/A5/tLUiab16t6642YCXdvaGRbORhtMcdFCY3bryClkjD3WMGVHOvOCnjz
	 7yWCexRb0NVdw==
Subject: Re: [PATCH net-next v11 07/13] dpll: sit9531x: implement input pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:00 +0000
Message-ID: <179116260093.434549.16690142118388089479@kernel.org>
In-Reply-To: <20260930233714.87679-8-arouhi@sitime.com>
References: <20260930233714.87679-8-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 8 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The driver's highest-priority automatic selection only takes
  effect when the table is written.
- [Medium] Even when a table write gives sit9531x_prio_activesel_pick()
  the chance to move to the highest-priority healthy source, it keeps a…
- [Medium] In sit9531x_prio_table_commit(), whether forced holdover is
  kept or released depends on `empty =…
- [Medium] If the table write and latch succeed but all
  SIT9531X_HO_CLEAR_TRIES attempts to clear HO_FORCE fail,…
- [Medium] sit9531x_input_prio_set() writes chan->cfg_prio[input_idx] and
  cfg_known before calling sit9531x_prio_table_apply(), and does not…
- [Medium] sit9531x_prio_table_commit() forces holdover on every table
  write, and keeps it forced indefinitely when the table becomes empty…
- [Medium] In sit9531x_dpll_input_pin_state_on_dpll_set() SELECTABLE, a
  powered-down receiver is enabled with sit9531x_input_enable() and…
- [Medium] In sit9531x_prio_table_commit(), a failed
  sit9531x_input_mon_fetch() only triggers a ratelimited warning…
- [Low] sit9531x_prio_table_commit() sets the PLL's HO_CTRL force-
  holdover bit (PLL page reg 0x6F, bit 4) with sit9531x_update_pll_u8()…
- [Low] Concern: this patch adds operstate_on_dpll_get for input pins,
  but sit9531x_dpll_changes_check() compares only state_on_dpll_get…
- [Low] When a table commit fails and the read-back in
  sit9531x_prio_table_commit() (`else if…
- [Low] sit9531x_prio_table_commit() sets HO_FORCE through
  sit9531x_update_pll_u8(), a regmap_update_bits() read-modify-write,…
- [Low] The rollback in sit9531x_prio_table_commit() covers only
  registers whose writes succeeded: `written = slot + 2` advances after…

--

dpll: sit9531x: implement input pin state on a DPLL

This commit adds state_on_dpll_get/set and operstate_on_dpll_get for
sit9531x input pins. SELECTABLE and DISCONNECTED map to membership in each
PLL's hardware priority table. A table rewrite forces the PLL into
holdover, writes every slot, picks the active selection from the clock
monitor state, latches, and releases holdover again.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index bf6817b9d5656..231e2d71dd6fb 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -433,26 +526,537 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)

[ ... ]

> +static u8 sit9531x_prio_activesel_pick(struct sit9531x_dev *sitdev,
> +				       const u8 *old, const u8 *srcs, u8 cur)
> +{
> +	u8 top, i;
> +
> +	top = sit9531x_prio_top_live(sitdev, srcs);
> +	if (top != SIT9531X_PRIO_SRC_NONE &&
> +	    top != sit9531x_prio_top_live(sitdev, old))
> +		return top;
> +
> +	/*
> +	 * The table is built from canonical codes, so compare in the same
> +	 * terms: a differential pair selected through its N-lane code is the
> +	 * P-lane entry.
> +	 */
> +	cur = sit9531x_prio_src_canon(sitdev, cur & SIT9531X_PRIO_NIBBLE_MASK);
> +
> +	if (sit9531x_prio_src_usable(cur) &&
> +	    sit9531x_prio_src_live(sitdev, cur))
> +		for (i = 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)
> +			if (srcs[i] == cur)
> +				return cur;

[Severity: Medium]
Can this keep a PLL on a lower-priority source while a higher-priority
one is healthy?

Take a table of A, B, C where A and B are live. CLK_ACTIVESEL names B
because an earlier pick ran while A had LOS. Disconnecting C builds A, B.

sit9531x_prio_top_live() returns A for both the old and the new table, so
the early return is skipped. cur is B, which is usable, live and listed,
so B is written again.

sit9531x_dpll_mode_get() always reports DPLL_MODE_AUTOMATIC. The uAPI
defines that as the highest priority input pin being auto selected by the
dpll. The commit message describes this keep-in-place policy, but it also
says the driver follows the highest-priority valid input. How do the two
fit together?

> +
> +	if (top != SIT9531X_PRIO_SRC_NONE)
> +		return top;
> +
> +	return srcs[0];
> +}

[Severity: Medium]
Is the active selection ever looked at again once a higher-priority input
recovers?

The comment above this function says the PLL leaves the source named by
CLK_ACTIVESEL only when that source loses signal. If a table write
happens while the top-priority member has LOS, the pick chooses a
lower-priority live member.

When the preferred input comes back, sit9531x_dev_periodic_work() only
refreshes caches through sit9531x_dev_ref_states_update() and
sit9531x_dev_chan_states_update(). sit9531x_prio_activesel_pick() is
called only from sit9531x_prio_table_commit().

Doesn't that leave the PLL on the lower-priority input indefinitely,
while sit9531x_dpll_mode_get() reports DPLL_MODE_AUTOMATIC? The commit
message says the selection goes to "the highest-priority valid input,
which is how the DPLL interface defines automatic mode".

> +
> +static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				      const u8 *srcs)
> +{

[ ... ]

> +	empty = !sit9531x_prio_src_usable(srcs[0]);

[Severity: Medium]
Should empty come from the table the device ends up holding, not from the
requested one?

Start with a PLL whose last input was disconnected. The empty table was
written, and the "if (empty && !rc) return 0;" exit kept HO_FORCE set.
The ACTIVESEL nibble still names the old source.

A later SELECTABLE request goes through
sit9531x_input_prio_add()->sit9531x_prio_table_apply()->
sit9531x_prio_table_commit() with a non-empty table, so empty is false.

Suppose the first slot write fails, so written stays 0. Or a later write
fails and the rollback restores the empty table. Either way the read-back
rebuilds prio_mask from a table that is still empty.

The release loop then clears HO_FORCE. Wouldn't the device be left with
an empty table, no forced holdover, and an ACTIVESEL naming the
disconnected source? The comment further down says the PLL then keeps
following that source "for as long as it has signal", while every pin
reads DISCONNECTED.

The mirror case looks similar. An empty request whose latch fails ends up
with rc != 0, so it also falls through to the release loop.

> +
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,
> +				    BIT(SIT9531X_PLL_HO_FORCE_BIT),
> +				    BIT(SIT9531X_PLL_HO_FORCE_BIT));
> +	if (rc)
> +		return rc;

[Severity: Low]
Can this early return leave HO_FORCE asserted?

sit9531x_update_pll_u8() is a regmap_update_bits() read-modify-write, so
an error does not prove the bit stayed clear. Later in the series,
sit9531x_output_divo_write() assumes that a write which reported an error
may still have reached the part.

Every other error path in this function goes through the release loop.
This one returns without trying to clear the bit. The callers then see
unchanged membership through sit9531x_input_prio_present() and treat the
request as having had no effect.

Should this path also try to clear the bit before returning?

> +
> +	usleep_range(10000, 12000);

[ ... ]

> +	for (slot = 0; slot + 1 < SIT9531X_PRIO_MAX_SLOTS; slot += 2) {
> +		reg = sit9531x_prio_reg(pll_idx, slot);
> +
> +		val = sit9531x_prio_slot_set(0, slot, srcs[slot]);
> +		val = sit9531x_prio_slot_set(val, slot + 1, srcs[slot + 1]);
> +
> +		rc = sit9531x_write_u8(sitdev, reg, val);
> +		if (rc)
> +			goto rollback;
> +
> +		written = slot + 2;
> +	}

[ ... ]

> +	reg = sit9531x_prio_reg(pll_idx, slot);
> +
> +	rc = sit9531x_read_u8(sitdev, reg, &val);
> +	if (rc)
> +		goto rollback;
> +
> +	val = sit9531x_prio_slot_set(val, slot, srcs[slot]);
> +
> +	if (!empty) {
> +		u8 sel = sit9531x_prio_slot_get(val, slot + 1);
> +
> +		if (sit9531x_input_mon_fetch(sitdev))
> +			dev_warn_ratelimited(sitdev->dev,
> +					     "PLL%c: input monitor not read; choosing the selection without it\n",
> +					     'A' + pll_idx);
> +		sel = sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,
> +						   srcs, sel);
> +		val = sit9531x_prio_slot_set(val, slot + 1, sel);
> +	}

[Severity: Medium]
Is it safe to go ahead with the pick when sit9531x_input_mon_fetch()
fails?

If a register read fails, sit9531x_input_mon_fetch() returns before it
updates any ref->los. The pick then runs on values from the last poll,
which can be up to SIT9531X_STATUS_POLL_MS (500 ms) old. The comment
above says the pick "needs the signal state now, not as of the last
poll".

Say A was live at the last poll and has since lost signal. The device has
fallen back to B, but the nibble still names A. With the monitor read
failing, A still looks live, so cur = A is kept and written, and the
latch succeeds.

The comment in sit9531x_prio_activesel_pick() says such a write sends the
PLL back to the dead source and it unlocks. Wouldn't that happen here,
with the request reported as a success?

> +
> +	rc = sit9531x_write_u8(sitdev, reg, val);
> +	if (rc)
> +		goto rollback;
> +
> +	written = SIT9531X_PRIO_MAX_SLOTS;
> +
> +rollback:
> +	if (rc && written) {

[ ... ]

> +		for (slot = 0; slot < written; slot += 2) {
> +			u8 old;
> +
> +			old = sit9531x_prio_slot_set(0, slot,
> +						     chan->prio_srcs[slot]);
> +			old = sit9531x_prio_slot_set(old, slot + 1,
> +						     chan->prio_srcs[slot + 1]);
> +			if (sit9531x_write_u8(sitdev,
> +					      sit9531x_prio_reg(pll_idx, slot),
> +					      old))
> +				break;
> +
> +			restored = slot + 2;
> +		}
> +		written = restored;
> +	}
> +

[ ... ]

> +	prg_rc = sit9531x_prio_prg_commit(sitdev);
> +	if (prg_rc && !rc)
> +		rc = prg_rc;

[Severity: Low]
Does the rollback skip the register whose write failed?

written only advances after a successful write, and the restore loop runs
while slot < written. The register that returned the error is never
restored, even though its write may have reached the device. The latch
then runs unconditionally.

If the last register fails, written is 10. That register holds slot 10
and the CLK_ACTIVESEL nibble. Slots 0-9 are restored, but a possibly
changed slot 10 and selection are latched. sit9531x_prio_table_read()
does not read ACTIVESEL, so the read-back would not catch it.

Later in the series, sit9531x_output_divo_write() restores "the byte
whose write reported the error" (j <= written). Should this sequence do
the same?

> +
> +	/*
> +	 * Refresh the cache so a get that follows a set does not have to

[ ... ]

> +	if (!rc) {
> +		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);
> +		memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));
> +		chan->seen_valid = true;
> +	} else if (!sit9531x_prio_table_read(sitdev, pll_idx, now)) {
> +		sit9531x_prio_mask_build(sitdev, pll_idx, now);
> +		memcpy(chan->seen_srcs, now, sizeof(chan->seen_srcs));
> +		chan->seen_valid = true;
> +	}

[Severity: Low]
What happens to seen_srcs when the commit and this read-back both fail?

chan->seen_srcs then keeps the old table, while the device may hold a
partly written or partly restored one. On the next poll,
sit9531x_chan_state_fetch() sees the mismatch:

	if (!chan->seen_valid ||
	    memcmp(srcs, chan->seen_srcs, sizeof(chan->seen_srcs)))
		sit9531x_prio_cfg_seed(sitdev, pll_idx, srcs);

sit9531x_prio_cfg_seed() then sets cfg_prio[src] = slot for every listed
source.

Doesn't that overwrite priorities set through sit9531x_input_prio_set()
with slot positions from a table nobody asked for? The reseed check
cannot tell a failed write by the driver apart from an outside rewrite.

> +
> +	/*
> +	 * A table that names no source keeps the PLL in the holdover forced

[ ... ]

> +	if (empty && !rc) {
> +		dev_dbg(sitdev->dev,
> +			"PLL%c: no source listed, holdover kept\n",
> +			'A' + pll_idx);
> +		return 0;
> +	}

[Severity: Medium]
Should chan->ho_valid be checked before holdover is kept forced here?

For DPLL_LOCK_STATUS_HOLDOVER, the uAPI in include/uapi/linux/dpll.h says
holdover forced by disconnecting all the pins is "possible only when dpll
lock-state was already DPLL_LOCK_STATUS_LOCKED_HO_ACQ". Otherwise "the
dpll's lock-state shall remain DPLL_LOCK_STATUS_UNLOCKED".

Here, disconnecting the last input still forces holdover on a PLL that
has not acquired holdover memory. sit9531x_dpll_lock_status_get() then
reports DPLL_LOCK_STATUS_HOLDOVER from chan->ho_freeze, whatever
ho_valid says.

Doesn't that keep the device on a holdover estimate it never marked
valid, while userspace is told it is in holdover?

> +
> +	/*
> +	 * Release the forced holdover.  Apart from an empty table, nothing

[ ... ]

> +	for (attempt = 0; attempt < SIT9531X_HO_CLEAR_TRIES; attempt++) {
> +		ho_rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +					       SIT9531X_PLL_REG_HO_CTRL,
> +					       BIT(SIT9531X_PLL_HO_FORCE_BIT),
> +					       0);
> +		if (!ho_rc)
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +	if (ho_rc) {
> +		dev_err(sitdev->dev, "PLL%c left in forced holdover: %d\n",
> +			'A' + pll_idx, ho_rc);
> +		if (!rc)
> +			rc = ho_rc;
> +	}
> +
> +	return rc;
>  }

[Severity: Medium]
What happens if the table write and latch succeed, but all
SIT9531X_HO_CLEAR_TRIES attempts here fail?

rc was still 0 at that point, so sit9531x_prio_mask_build() has already
recorded the new membership, and the function returns ho_rc. In the
SELECTABLE handler sit9531x_input_prio_present() is now true, so the
claim is taken and the error is returned to userspace.

If the same SELECTABLE request is retried after the bus recovers,
sit9531x_input_prio_add() returns early:

	if (chan->prio_mask & BIT(input_idx))
		return 0;

Retrying DISCONNECTED short-circuits the same way, and so does setting an
equal priority (the memcmp() in sit9531x_prio_table_apply()).

Doesn't the retry then report success while the PLL stays in forced
holdover? The poll does not retry the release either, so the PLL seems to
stay there until some unrelated table edit runs the full sequence again.

[Severity: Low]
Is the old value of HO_FORCE meant to be thrown away?

The bit is set at the top of sit9531x_prio_table_commit() without saving
its previous value, and it is cleared here unconditionally. Say the
loaded profile or an external tool left a PLL in forced holdover. Any
SELECTABLE or DISCONNECTED change on that PLL, or a later priority set,
would then quietly release it and let it lock to a reference.

The commit message describes the sequence as "forcing the PLL into
holdover, waiting for it to take, writing every slot and releasing
holdover again". It does not say that an existing forced holdover is
lost.

[ ... ]

> @@ -479,6 +1083,137 @@ static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 prio)
> +{

[ ... ]

> +	chan = &sitdev->chan[pll_idx];
> +	chan->cfg_prio[input_idx] = prio;
> +	chan->cfg_known |= BIT(input_idx);
> +
> +	if (!(chan->prio_mask & BIT(input_idx)))
> +		return 0;
> +
> +	return sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);
> +}

[Severity: Medium]
Should cfg_prio[] and cfg_known be restored when
sit9531x_prio_table_apply() fails?

For example, if the first HO_FORCE update in sit9531x_prio_table_commit()
fails, no table register is written, but the new priority stays recorded.

Later in the series ("dpll: sit9531x: add support to get and set priority
on input pins") this is wired to netlink. On failure,
sit9531x_dpll_input_pin_prio_set() returns the error and leaves
dpin->prio alone, but sit9531x_input_prio_get() now reports the new
value. The poll sees a changed priority and sends a notification for a
priority that was refused.

The next unrelated add or remove also rebuilds the table with the
refused priority. That can change the preferred source as a side effect.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 924386aec4d88..f961b7af28fed 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -231,8 +350,163 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +	case DPLL_PIN_STATE_SELECTABLE:

[ ... ]

> +		if (!ref->enabled) {
> +			rc = sit9531x_input_enable(sitdev, dpin->id);
> +			if (rc)
> +				break;
> +			enabled_here = true;
> +		}
> +		rc = sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);

[Severity: Medium]
Has the clock monitor had time to qualify a newly enabled input by the
time the selection is picked?

When the receiver was off, sit9531x_input_enable() powers it up and
sit9531x_input_prio_add() runs right away. The commit only samples the
monitors with sit9531x_input_mon_fetch() after the 10-12 ms holdover
sleep, and sit9531x_prio_activesel_pick() decides from ref->los.

A low-rate reference such as 1 PPS cannot be qualified in that window. So
the lane still shows LOSS, and the pick skips it even if it is now the
highest-priority member.

The device only leaves its selection on LOS, and no poll path rewrites
CLK_ACTIVESEL. Wouldn't the PLL stay on the lower-priority source after
the new input qualifies?

[ ... ]

>  static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_input_pin_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_input_pin_state_on_dpll_set,
> +	.operstate_on_dpll_get	= sit9531x_dpll_input_pin_operstate_on_dpll_get,
>  };

[Severity: Low]
Now that operstate_on_dpll_get is added, does anything send a
dpll_pin_change_ntf() when the operstate changes?

At this commit sit9531x_dpll_changes_check() compares only the pin state:

	changed = pin->seen && state != pin->pin_state;

So LOS, qual-fail and active-reference changes are not notified.

The next patch in the series, "dpll: sit9531x: add support to get and
set priority on input pins", adds the operstate comparison to
sit9531x_dpll_changes_check(). The gap seems to exist only at this
commit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
