Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F153FD22;
	Tue,  8 Sep 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871519; cv=none; b=pHpfj8UCUFeK/b2cRMqqRus7XgWC0vwNf2l/KDQwQp3IbfAM8tbtLg3GT933//yZfh96UmJr2O0cemYz9+o6luBoqd5RlJEH9yv/sR180Ykdzh+8phbXlidVSNmCAkZnGAI0Z4XVXtiPR9nFJSWPAz1Kv9Imp6XNSWB6HqHtTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871519; c=relaxed/simple;
	bh=VhZm60h2TXnwyxU84qCW6qUoF+jsKU+PL4RBZwLojUY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NU4uhTsz5oAFHz57wDP6yYVJU/i450Pcxce+UmAESl3STMDYzjLKJIRCNvnH2YVmJhEn7lnPri4MCBV21QjXuHbD9vwCryZM/2Q7rLh0YmhtUcrOXmrJ+jx69Vv9bumFJLvWBNFXTcUrO/qJWP9RotUk2BdXn+UUaYHdf2qKVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alLoI0xR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alLoI0xR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA31F00A3A;
	Tue,  8 Sep 2026 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871517;
	bh=Ei1sK4UeU5GVvfYPgf8HAAixuFZLz7KvOmyZb96W1FA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=alLoI0xR7+8qHZSzMlkX2K26P2wvLBZGIp14L1nn1FKjxr1dhbp8DddlUY6wajo9D
	 KJCCyiZ8L0oYpfCItFUkpSk/ZLVdbrPvo+kcshvgJstbrOwI7YCjDoe8U+tqy2709t
	 rffEBpxRE7DQoWwY87KipA40W2H017EqlPdV3zA3ffwEfAKppaY8nD8z4IGxe0jsrD
	 Ay25k3SFIeLVVZnlhaLiTa1gBkP713x6kHLK251IlmYleEkONh0IpioQcBz6lGYYEV
	 bTJLULRT/Toxh9MElKnZdC2KDGvI1auQIVPY/f7eGsTiJ08+8E/tSPE3kzVAZ97NDl
	 FUaOEi45Jz5kg==
Subject: Re: [PATCH net-next v8 06/15] dpll: sit9531x: implement input pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:15 +0000
Message-ID: <178887151547.219967.15430227040039289728@kernel.org>
In-Reply-To: <20260902214030.20955-7-arouhi@sitime.com>
References: <20260902214030.20955-7-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 3 (1)

- [High] At this commit the INTSYNC destination pin (dpin->id ==
  SIT9531X_INTSYNC_PIN_ID == SIT9531X_MAX_INPUTS + 1 == 9) is dispatched…
- [Medium] sit9531x_input_prio_add() unconditionally writes the requested
  source into srcs[SIT9531X_PRIO_MAX_SLOTS - 1] (slot 10) after…
- [Medium] For a differentially configured input pair only the P-lane pin
  is registered (sit9531x_input_pin_is_registrable() returns false for…
- [Medium] sit9531x_prio_table_commit() has no error containment.
- [Low] Three comments added by this patch attribute behaviour to
  sit9531x_input_prio_set() that it does not have.
- [Low] The two-step pin-state transitions in
  sit9531x_dpll_input_pin_state_on_dpll_set() are not unwound when the…
- [Low] The two new exported helpers sit9531x_input_disable() and
  sit9531x_input_enable() perform read-modify-write sequences on…

Pre-existing issues:
- [Low] The pin-state contract comment above the ops tables
  (dpll.c:209-255) says 'The five pin ops tables below' and prescribes…

--

dpll: sit9531x: implement input pin state on a DPLL

This adds state_on_dpll_get/set for input pins, mapping "connected" onto
membership of a PLL's priority table, and adds core helpers to read, add,
remove and reorder table entries plus enable/disable of the physical input
receiver.

A few questions below on the new paths.

>     The pins fall into three roles and only the first answers this question,
>     so the contract for all of them is written above the operations rather
>     than left to be inferred: inputs and the inter-PLL sync destination take
>     part in selection; an output and the sync source are driven by the PLL and
>     report whether they carry a signal; the crystal is fixed and always
>     connected, since a PLL cannot be told to stop using it.

[Severity: Low]
This isn't a bug introduced by this patch, but the contract comment the
message refers to is unchanged context in this diff, and it describes more
than exists here.  The comment says "The five pin ops tables below", while
at this commit only three exist (input, xo, output).  It also prescribes
DRIVE-role get/set rules, but sit9531x_dpll_output_pin_ops carries only
.direction_get, and it attributes priority ops to the INTSYNC destination
pin while no table has .prio_get/.prio_set yet.

Those pieces do arrive later in the series (the output state patch and the
inter-PLL sync pin-pair patch), so the mismatch is transient.  Could the
commit message avoid crediting this patch with a comment block it does not
add?

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 1394ea1077d9..f42c41d8a42e 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -184,6 +184,73 @@ static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,
>  	}
>  }
>  
> +/*
> + * sit9531x_input_disable - disable an input reference
> + * @index:	logical input index (0-N)
> + *
> + * Sets the force mask bit and clears the state bit for the given
> + * input, effectively disabling it.  Register selection depends on
> + * the pair's signal mode (SE/DE) and the lane (P/N); the bit within
> + * each register addresses the input pair.
> + */
> +int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)
> +{
> +	struct sit9531x_ref *ref = &sitdev->ref[index];
> +	unsigned int force_reg, state_reg;
> +	u8 pair = sit9531x_input_pair(index);

[Severity: High]
Can this index sitdev->ref[] out of bounds when called for the INTSYNC
destination pin?

At this commit sit9531x_dpll_pin_ops_get() sends every input pin that is not
the XO pin to sit9531x_dpll_input_pin_ops:

	if (!sit9531x_dpll_is_input_pin(pin))
		return &sit9531x_dpll_output_pin_ops;
	if (sit9531x_dpll_is_xo_pin(pin))
		return &sit9531x_dpll_xo_pin_ops;
	return &sit9531x_dpll_input_pin_ops;

and sit9531x_pin_props_get() advertises DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE
for it, so a netlink DPLL_CMD_PIN_SET reaches the new setter with
dpin->id == SIT9531X_INTSYNC_PIN_ID, which is SIT9531X_MAX_INPUTS + 1.

ref[] is declared as:

	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */

so ref[SIT9531X_INTSYNC_PIN_ID] is one element past the end and aliases
sitdev->out[0].  sit9531x_input_disable()/enable() have no index check, so
they read sitdev->ref[index].sig_mode through sit9531x_input_get_regs() from
that aliased memory and then write ref->enabled there.

Additionally, sit9531x_input_pair(SIT9531X_INTSYNC_PIN_ID) is 4, so the
force/state write asserts BIT(4) of registers documented in regs.h as:

	/* One bit per input PAIR (bit 0 = CLKIN0, ..., bit 3 = CLKIN3) */

Would an explicit index check in both helpers, and a separate ops table for
the INTSYNC destination, be preferable?  The later patch "dpll: sit9531x:
model the inter-PLL sync net as a pair of pins" adds
sit9531x_dpll_intsync_dst_pin_ops and routes the destination pin there, so
this is gone at the end of the series; the concern is only that this commit
is reachable on its own.

[Severity: Low]
These two helpers are non-static and declared in core.h, they do
read-modify-write on registers shared by all four input pairs, and they write
sitdev->ref[index].enabled which the poll worker also writes in
sit9531x_input_state_fetch().  They neither take nor assert
sitdev->multiop_lock, and the kernel-doc does not state a locking contract.

Every other multi-step helper in the file does assert it, for example
sit9531x_output_disable()/enable(), sit9531x_input_prio_set/add/remove and
sit9531x_intsync_enable()/disable():

	lockdep_assert_held(&sitdev->multiop_lock);

The single caller here does hold the lock, so nothing races today.  Would
adding the assertion plus a "caller must hold sitdev->multiop_lock" line keep
a future caller from clobbering another pair's bits without lockdep noticing?

> +	u8 val;
> +	int rc;
> +
> +	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);
> +
> +	rc = sit9531x_read_u8(sitdev, force_reg, &val);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));
> +	if (rc)
> +		return rc;
> +
> +	rc = sit9531x_read_u8(sitdev, state_reg, &val);
> +	if (rc)
> +		return rc;

[Severity: Low]
The force override is asserted before its state bit is cleared, and an error
in between returns with no attempt to undo it.  Does that leave the receiver
under a half-programmed override, forced to whatever the stale state bit
says, with ref->enabled not updated and the source already removed from the
PLL's table by the caller?

The output helpers in this file always finish the sequence and keep the first
error:

	ret = sit9531x_prg_commit(sitdev);
	if (ret && !rc)
		rc = ret;

Would the same shape work here?  The matching gap on the SELECTABLE side is
noted further down in dpll.c.

> +	rc = sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));
> +	if (rc)
> +		return rc;
> +
> +	ref->enabled = false;
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -328,6 +432,67 @@ static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	sitdev->chan[pll_idx].prio_mask = mask;
>  }
>  
> +/*
> + * sit9531x_prio_table_commit - write a full priority table for a PLL
> + * @srcs:	array of SIT9531X_PRIO_MAX_SLOTS source codes, slot 0 first
> + *
> + * Programs all priority slots (nibble-packed, two per register) for
> + * the PLL using the same holdover / small-update sequence as
> + * sit9531x_input_prio_set().  Caller must hold sitdev->multiop_lock.
> + */

[Severity: Low]
This isn't a bug, but the reference is circular.
sit9531x_input_prio_set() contains no HO_CTRL force/clear, no settle delay
and no SIT9531X_SMALL_UPDATE_CMD write; it reads the table, shifts the
entries and calls this function.  The holdover and latch sequence exists only
here.

The same applies to the "Latch unconditionally, as in
sit9531x_input_prio_set()" comment below and to the "(matching
sit9531x_input_prio_set())" note in sit9531x_input_prio_remove(): prio_set is
a pure permutation of existing entries and never backfills tail slots.  All
three comments are still there at the end of the series.

> +static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				      const u8 *srcs)
> +{
> +	u8 val, slot;
> +	int rc, prg_rc, ho_rc;
> +	u16 reg;
> +
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,
> +				    BIT(SIT9531X_PLL_HO_FORCE_BIT),
> +				    BIT(SIT9531X_PLL_HO_FORCE_BIT));
> +	if (rc)
> +		return rc;
> +
> +	usleep_range(10000, 12000);
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> +		reg = sit9531x_prio_reg(pll_idx, slot);
> +
> +		rc = sit9531x_read_u8(sitdev, reg, &val);
> +		if (rc)
> +			goto commit;
> +
> +		val = sit9531x_prio_slot_set(val, slot, srcs[slot]);
> +
> +		rc = sit9531x_write_u8(sitdev, reg, val);
> +		if (rc)
> +			goto commit;
> +	}
> +
> +commit:
> +	/* Latch unconditionally, as in sit9531x_input_prio_set(). */
> +	prg_rc = sit9531x_prio_prg_commit(sitdev);
> +	if (prg_rc && !rc)
> +		rc = prg_rc;
> +
> +	/*
> +	 * Refresh the mask from the table just written so a get that follows
> +	 * a set does not have to wait for the next poll.  Slots written
> +	 * before a failed write are in the table too, so this is closer to
> +	 * the truth than the pre-write mask either way, and the poll read-back
> +	 * corrects whatever a partial write left behind.
> +	 */
> +	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);

[Severity: Medium]
Is the unconditional mask refresh correct on the error paths?

If the very first sit9531x_read_u8() in the loop fails, no register was
modified at all, yet the code still falls into the commit label, issues the
small-change latch, and then records the fully intended srcs[] in
chan->prio_mask.  The same happens when sit9531x_prio_prg_commit() itself
fails.

chan->prio_mask is exactly what the new
sit9531x_dpll_selection_state_get() consults:

	if (!(chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id))))
		*state = DPLL_PIN_STATE_DISCONNECTED;

so userspace is told about membership the hardware never adopted, until the
next successful poll, or indefinitely if the bus keeps failing.

Separately, a mid-loop failure latches a half-rewritten table (new compacted
prefix, stale tail that may still hold the source being removed) and then
releases forced holdover, so the PLL re-selects from a table nobody intended,
with no restore of the original.  Would refreshing the mask only after a
fully successful, latched sequence be safer?

> +
> +	ho_rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				       SIT9531X_PLL_REG_HO_CTRL,
> +				       BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);
> +	if (ho_rc && !rc)
> +		rc = ho_rc;
> +
> +	return rc;
> +}
> +

[ ... ]

> @@ -352,6 +517,171 @@ static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	return 0;
>  }
>  

[ ... ]

> +/*
> + * sit9531x_input_prio_add - make an input eligible in a PLL's table
> + * @input_idx:	input source in hardware encoding
> + *
> + * Ensures the source appears in the priority table so it can be picked
> + * by automatic reference selection again after a disconnect.  If the
> + * source is already listed the table is left untouched; otherwise it is
> + * placed in the lowest-priority slot.  The original priority is not
> + * restored -- use sit9531x_input_prio_set() to reassign it.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx)
> +{
> +	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 slot;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +
> +	rc = sit9531x_prio_table_read(sitdev, pll_idx, srcs);
> +	if (rc)
> +		return rc;
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)
> +		if (srcs[slot] == input_idx)
> +			return 0;
> +
> +	srcs[SIT9531X_PRIO_MAX_SLOTS - 1] = input_idx;

[Severity: Medium]
Does this silently evict whatever already occupied the last slot?

The 4-bit slot encoding documented in regs.h has no "empty" value:

 *   0=IN0P, 1=IN1P, 2=IN2P, 3=IN3P, 4=IN4P,
 *   5=OCXO, 6=INTSYNC,
 *   7=IN0N, 8=IN1N, 9=IN2N, 10=IN3N, 11=IN4N

so if the lowest-priority slot holds a distinct configured last-resort source
(the OCXO, code 5, for instance) it is overwritten here and 0 is returned as
success.  That input then disappears from this PLL's selection table, and its
state_on_dpll_get() flips to DISCONNECTED although userspace never asked.

Because sit9531x_dpll_input_pin_state_on_dpll_set() only updates the
ref->pll_mask of the pin the request named, and pll_mask is otherwise seeded
only once at probe by sit9531x_ref_pll_mask_fetch(), the evicted input keeps
this PLL's bit set forever, so the shared receiver is never released.

sit9531x_input_prio_remove() below establishes a "duplicated tail slot"
convention for freed slots.  Could prio_add() look for such a duplicated
slot, or return -ENOSPC when the table is genuinely full, instead of
clobbering slot SIT9531X_PRIO_MAX_SLOTS - 1?  This is unchanged at the end of
the series.

> +
> +	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);
> +}
> +

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 821370ddeab0..29088707a3e6 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -255,6 +255,41 @@ const struct dpll_device_ops sit9531x_dpll_device_ops = {

[ ... ]

> +static void
> +sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,
> +				  const struct sit9531x_dpll *sitdpll,
> +				  u8 pin_id, enum dpll_pin_state *state)
> +{
> +	const struct sit9531x_chan *chan;
> +	bool active_input;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	chan = sit9531x_chan_state_get(sitdev, sitdpll->id);
> +	active_input = !chan->mode && chan->locked && !chan->inner_lol &&
> +		       chan->selected_ref == pin_id;
> +
> +	if (!(chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id))))
> +		*state = DPLL_PIN_STATE_DISCONNECTED;

[Severity: Medium]
For a differentially configured pair, only the P-lane pin is registered
(sit9531x_input_pin_is_registrable() returns false for the N lane of a DE
pair), so sit9531x_input_hw_src(pin_id) here always yields the P code.
Should the N-lane code be folded onto the P lane, the way the probe path
already does?

drivers/dpll/sit9531x/core.c:sit9531x_ref_pll_mask_fetch() {
	...
			if (sit9531x_input_is_n(index) &&
			    sitdev->ref[index].sig_mode == SIT9531X_MODE_DE)
				index--;
	...
}

sit9531x_prio_mask_build() records the raw source code with no folding:

	mask |= BIT(srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK);

so if a PLL's table lists such a pair under SIT9531X_PRIO_SRC_N_BASE + pair,
the test above misses it and the pin reads back DISCONNECTED.
chan->selected_ref is derived as pair * 2 + 1 by sit9531x_hw_src_input(), so
CONNECTED can never be reported for that pin either.

The setter has the mirror problem: sit9531x_input_prio_remove() with the P
code does not find the N-coded entry, takes the "!found -> return 0" path,
and the caller then clears ref->pll_mask and calls sit9531x_input_disable().
Does that gate off the receiver while the source is still an eligible table
entry for the PLL, and report success to userspace?  A SELECTABLE set
conversely adds the P code next to the existing N code, listing the same
physical pair twice.  This is also unchanged at the end of the series.

> +	else if (active_input)
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_SELECTABLE;
> +}
> +

[ ... ]

> @@ -267,8 +302,125 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
>  	return 0;
>  }
>  

[ ... ]

> +static int
> +sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,
> +					  void *pin_priv,
> +					  const struct dpll_device *dpll,
> +					  void *dpll_priv,
> +					  enum dpll_pin_state state,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	struct sit9531x_ref *ref = &sitdev->ref[dpin->id];
> +	u8 hw_src = sit9531x_input_hw_src(dpin->id);
                   ^^^^
This is the entry point for the ref[] indexing question raised above on
sit9531x_input_disable(): dpin->id can be SIT9531X_INTSYNC_PIN_ID here.

> +	u8 pll_bit = BIT(sitdpll->id);
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	switch (state) {
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		rc = sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);
> +		if (rc)
> +			break;
> +		ref->pll_mask &= ~pll_bit;
> +		if (ref->pll_mask)
> +			rc = 0;	/* another DPLL still uses this input */
> +		else
> +			rc = sit9531x_input_disable(sitdev, dpin->id);
> +		break;

[ ... ]

> +	case DPLL_PIN_STATE_SELECTABLE:
> +		rc = sit9531x_input_enable(sitdev, dpin->id);
> +		if (rc)
> +			break;
> +		rc = sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);
> +		if (rc)
> +			break;

[Severity: Low]
When sit9531x_input_prio_add() fails here, the receiver has already been
enabled and ref->pll_mask is left at zero.  Is that an enable with no
matching claim, so nothing will ever pair it with a
sit9531x_input_disable()?  Would calling sit9531x_input_disable() on this
error path keep the enable and the claim in step?

> +		/*
> +		 * Claim the input for this DPLL only once it is both enabled
> +		 * and present in the priority table.  Setting the mask before
> +		 * prio_add would leak the claim if prio_add failed, keeping the
> +		 * shared input receiver powered even after every DPLL released
> +		 * it.
> +		 */
> +		ref->pll_mask |= pll_bit;
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&sitdev->multiop_lock);

[ ... ]

> +	return rc;
> +}
> +
>  static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_input_pin_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_input_pin_state_on_dpll_set,

[ ... ]

> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index 705176c35ddd..dd027142b370 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -132,6 +132,10 @@
>  #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)
>  #define SIT9531X_SMALL_UPDATE_CMD		0x02
>  
> +/* PLL holdover control (PLL page offset) */
> +#define SIT9531X_PLL_REG_HO_CTRL		0x6F
> +#define SIT9531X_PLL_HO_FORCE_BIT		4
> +
>  /* One bit per input PAIR (bit 0 = CLKIN0, ..., bit 3 = CLKIN3) */
>  #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)
>  #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
