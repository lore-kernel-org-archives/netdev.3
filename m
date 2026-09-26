Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCB363C46;
	Sat, 26 Sep 2026 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390089; cv=none; b=hoEcQ98oonqAPlCmORt4sqW1T61qCiG55sIL7RAUtJrOJgpAYorSLd66Iv6gzdVV/U6lYybRCpbTyrVKNcyP5zkYTTusBG9+LPYZpDxe1OG6bs/pyokqlOcp5sFP6hsJybX9e4JajR5bNVQydkpu4aflY3WrIKFG3mZCeD/cQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390089; c=relaxed/simple;
	bh=RaYLRydu5lMgR0GkswAni68LAN46uAJEDW4pzOBE26c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmDjxULY972VxEOrl1QC3iz3NXPMbYjrmq001kYULe7eG4ZE6vG3hoiYfaS3GHpWbIjDHzedNRNaqS0WzG1m8aLizOyvTr3P7pgxBgYzfXMKDo2HWv23N8yE/PBI/vRg11LXLLa3wVWSEbfiKa4dxATHuZzjwiWhFm4o5nUMJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGaql79n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGaql79n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5961F000FF;
	Sat, 26 Sep 2026 02:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390086;
	bh=Sp6WkFToFKi/fV8Bp8bQRI4216jIrc4eAGxBYS13rwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGaql79nT3f6K1oAkminEVcRO3+W01Zr4H5QLntuRrbI4bhamhjJwYSQes99Iwcs1
	 AupxSsF8NwsDvdN1YjyFt2F4V73TW5nhRp4VFKg/TP0nuxEyL48tWYcDRkIiCoEelM
	 LhKWz2lpbN2IQ3iutWo4WkBzDzBuuwnMC6hym48LPXr2EQcDRgEPbvGm1X9ZsbF9JQ
	 jCc9blh8ZnGW2VszGcJiB8LCepixmHFQnr9LcG98rzqFIumvX8oVGhmRjkAswYhDXD
	 uDaUZ63z0b0nBeiTkzlOZIsBxkW5OsXaCdwVazKYrvy+ToYZ4K7jkw+22coFw4Fizl
	 01t8XXqmnEbXA==
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
Subject: Re: [PATCH v10 06/14] dpll: sit9531x: implement input pin state on a DPLL
Date: Fri, 25 Sep 2026 19:34:45 -0700
Message-ID: <20260926023445.1567707-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-7-arouhi@sitime.com>
References: <20260921201108.42676-7-arouhi@sitime.com>
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
dpll: sit9531x: implement input pin state on a DPLL

This patch adds state_on_dpll_get/set for SiT9531x input pins. Whether a
source is in a PLL's hardware priority table decides between DISCONNECTED
and SELECTABLE, and the reference the PLL has selected is reported as
CONNECTED. Setting the state rewrites the priority table under forced
holdover, and a per-input DPLL claim mask decides when the shared input
receiver is powered on or off.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 6f19dab89beeb..84c1f86e6d4cf 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -206,6 +206,94 @@ static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,

[ ... ]

> +int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)
> +{

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, force_reg, &val);
> +	if (!rc)
> +		rc = sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));
> +
> +	ret = sit9531x_read_u8(sitdev, state_reg, &val);
> +	if (!ret)
> +		ret = sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	if (rc)
> +		return rc;
> +
> +	ref->enabled = false;

[Severity: Low]
Suppose the force write succeeds but the state read or write fails. Can
the receiver then be disabled while ref->enabled still reads true?

After an earlier disable/enable cycle the state bit is already clear. So
after this partial failure the device holds force=1/state=0.

A SELECTABLE request that arrives before the next poll then runs this
code in sit9531x_dpll_input_pin_state_on_dpll_set():

    if (!ref->enabled) {
        rc = sit9531x_input_enable(sitdev, dpin->id);
        ...
    }

It skips the enable, adds the source to the table or finds it there, and
returns success while the receiver stays off.

The poll refreshes ref->enabled later, but nothing re-applies the enable.

[ ... ]

> @@ -390,6 +573,107 @@ static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				      const u8 *srcs)
> +{
> +	u8 val, slot, attempt, written = 0;
> +	int rc = 0, prg_rc, ho_rc = 0;
> +	u16 reg;
> +
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,
> +				    BIT(SIT9531X_PLL_HO_FORCE_BIT),
> +				    BIT(SIT9531X_PLL_HO_FORCE_BIT));
> +	if (rc)
> +		return rc;
> +
> +	usleep_range(10000, 12000);

[Severity: Medium]
Does the holdover force bit take effect without a PLL-page small-change
update?

Elsewhere in the driver, PLL-page control writes are followed by
SIT9531X_PLL_REG_SMALL_UPDATE. For example, sit9531x_dpll_mode_set()
does:

    rc = sit9531x_write_pll_u8(sitdev, sitdpll->id,
                               SIT9531X_PLL_REG_SMALL_UPDATE,
                               SIT9531X_SMALL_UPDATE_CMD);

sit9531x_output_phase_flush() latches PHFL_CTRL the same way. regs.h also
says that every page carries its own copy of the directive register.

If HO_CTRL follows the same rule, the PLL would never enter forced
holdover while the table is inconsistent.

The release further down can also fail (the ho_rc path). In that case,
could force=1 stay staged and then be latched by an unrelated PLL-page
update, such as mode_set() or a phase flush?

Nothing reads HO_FREEZE to confirm that holdover was entered, so the
10-12 ms sleep is also an assumption. All of this depends on the HO_CTRL
latch behaviour in the datasheet, which I couldn't confirm here.

> +
> +	/*
> +	 * Two slots share a register, and this writes every slot, so both
> +	 * nibbles are known for every register but the last -- build those
> +	 * bytes outright.  Reading first would raise the question of what a
> +	 * read returns between the write and the latch, and the answer does
> +	 * not matter if nothing is read.
> +	 */
> +	for (slot = 0; slot + 1 < SIT9531X_PRIO_MAX_SLOTS; slot += 2) {
> +		reg = sit9531x_prio_reg(pll_idx, slot);
> +
> +		val = sit9531x_prio_slot_set(0, slot, srcs[slot]);
> +		val = sit9531x_prio_slot_set(val, slot + 1, srcs[slot + 1]);
> +
> +		rc = sit9531x_write_u8(sitdev, reg, val);
> +		if (rc)
> +			goto commit;

[Severity: Medium]
If one of these writes fails partway through, the goto commit path still
latches through sit9531x_prio_prg_commit() and releases holdover. Does
that leave the PLL selecting from a table that mixes new and old register
pairs, with the original never restored?

For example, once prio_set is wired up, moving source 3 to slot 0 of
[0,1,2,3,...] builds [3,0,1,2,...]. If the second register write fails,
the device keeps [3,0,2,3,...] and source 1 is no longer in the table.

At this commit, sit9531x_prio_mask_build() also returns early when
written < SIT9531X_PRIO_MAX_SLOTS. chan->prio_mask therefore still
describes the table from before the request.

The rollback checks in sit9531x_dpll_input_pin_state_on_dpll_set() go
through sit9531x_input_prio_present(). With a stale mask, could they
make the wrong decision?

On SELECTABLE, the setter could turn off a receiver it has just enabled,
for an input that the latched table now lists. On DISCONNECTED, it could
keep the claim and leave a receiver powered with no owner.

The next commit, "dpll: sit9531x: add support to get and set priority on
input pins", refreshes the mask per slot, which fixes the stale-mask
rollback. However, its restore block sits after
written = SIT9531X_PRIO_MAX_SLOTS, where rc is always 0, and every failure
path jumps past it with goto commit. The mixed table is still latched at
the end of the series.

There is also a separate case: every slot is written but the
SMALL_UPDATE latch write fails. Then written == SIT9531X_PRIO_MAX_SLOTS,
and the requested mask is published even though the device may still be
selecting from the old table.

[ ... ]

> +commit:
> +	/*
> +	 * Latch unconditionally: slots written before a failed write are in
> +	 * the table regardless, so the latch keeps hardware and the cache
> +	 * refresh below consistent with what was actually written.
> +	 */
> +	prg_rc = sit9531x_prio_prg_commit(sitdev);
> +	if (prg_rc && !rc)
> +		rc = prg_rc;
> +
> +	/*
> +	 * Refresh the cache from the table just written, so a get that
> +	 * follows a set does not have to wait for the next poll -- but only
> +	 * for the slots that reached the device.  Describing a table that
> +	 * does not exist would make the membership test answer for writes
> +	 * that failed, and that test is what decides whether a failed
> +	 * request gets rolled back.
> +	 */
> +	sit9531x_prio_mask_build(sitdev, pll_idx, srcs, written);

[Severity: Medium]
The v10 notes say:

    Priority table coherence: a table that was written only in part is put
    back rather than latched; the mask describes what reached the device
    rather than what was asked for;

Does the code match that? Every failure above jumps here and latches
unconditionally. Nothing saves the original table or writes it back.

This comment promises a refresh "only for the slots that reached the
device". At this commit, however, sit9531x_prio_mask_build() does:

    if (written < SIT9531X_PRIO_MAX_SLOTS)
        return;

So after a partial write, the mask keeps describing the table from before
the request, not the table that was latched.

The next commit in the series refreshes the mask per slot and adds an
if (rc && written) restore block. That block is placed after
written = SIT9531X_PRIO_MAX_SLOTS, where rc is 0, and every failure path
jumps past it.

Could the notes and comments be changed to match the code, or the restore
be made reachable?

[ ... ]

> @@ -414,6 +698,242 @@ static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +/*
> + * sit9531x_input_prio_set - move an input to a priority slot

[ ... ]

> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, -EINVAL if the source is not in the table,
> + * <0 on error
> + */

[Severity: Low]
This isn't a bug, but the Return: line doesn't list -ERANGE. The function
returns it here:

    if (prio > n)
        return -ERANGE;

The prio_set callback added later in the series handles -ERANGE as its
own case.

-EINVAL is also returned for a bad pll_idx or prio, not only when the
source is missing from the table.

[ ... ]

> @@ -893,6 +1414,41 @@ static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)

[ ... ]

> +static void sit9531x_ref_pll_mask_rebuild(struct sit9531x_dev *sitdev)
> +{
> +	u8 pll_idx, src, index;
> +
> +	for (index = 0; index < sitdev->info->num_inputs; index++)
> +		sitdev->ref[index].pll_mask = 0;
> +
> +	for (pll_idx = 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {
> +		u16 mask = sitdev->chan[pll_idx].prio_mask;
> +
> +		for (src = 0; src < SIT9531X_PRIO_NUM_SRC; src++) {
> +			if (!(mask & BIT(src)))
> +				continue;
> +
> +			index = sit9531x_hw_src_input(src);
> +			if (index < sitdev->info->num_inputs)
> +				sitdev->ref[index].pll_mask |= BIT(pll_idx);

[Severity: Medium]
What happens here for a differentially configured pair whose table entry
uses the N-lane code (7-10)?

sit9531x_prio_src_canon() and sit9531x_ref_pll_mask_fetch() both fold N
onto P. At this commit, though, sit9531x_prio_mask_build() sets BIT(src)
on the raw code, and this rebuild maps that code through
sit9531x_hw_src_input() to the odd N-lane index.

The claim then lands on ref[N] instead of ref[P]. Could a disconnect on
another DPLL then find ref[P].pll_mask at zero and power down a shared
receiver that this PLL is still using?

The same raw mask makes the P pin report DISCONNECTED. A SELECTABLE
request then does nothing, because sit9531x_input_prio_add() finds the
canonicalised entry and returns 0.

The next commit, "dpll: sit9531x: add support to get and set priority on
input pins", builds prio_mask from canonical codes. That fixes the mask,
membership and refcount parts.

The selected_ref part is still unfolded at the end of the series.
sit9531x_chan_state_fetch() stores:

    chan->selected_ref =
        sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);

sit9531x_dpll_selection_state_get() compares that value with the P-lane
pin id. A DE pair selected through its N code can therefore never report
CONNECTED. I couldn't confirm from the datasheet whether ACTIVESEL reports
N codes for a DE pair.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 63c72bba51bfe..4437c95f578f8 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -286,6 +286,45 @@ const struct dpll_device_ops sit9531x_dpll_device_ops = {
>   * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.
>   */
>  
> +/*
> + * Report a selection-role pin's state on this DPLL.  @pin_id is a logical
> + * input index, SIT9531X_INTSYNC_PIN_ID for the INTSYNC destination.
> + *
> + * CONNECTED means the device has selected this pin, not that the loop
> + * has settled on it: how well it is tracking is what lock status answers,
> + * and a PLL following a reference it has not locked to yet is still
> + * following that reference and no other.

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
> +	active_input = !chan->mode && chan->selected_ref == pin_id;

[Severity: Medium]
The commit message says the contract "is written above the operations
rather than left to be inferred". The contract block above, which this
patch leaves unchanged, still says:

    L  chan->locked && !chan->inner_lol     (only meaningful when A)
    ...
    CONNECTED     A && L && S && M
    SELECTABLE    M && !(A && L && S)

This getter never reads chan->locked or chan->inner_lol. A reference
that is selected but not locked therefore reports CONNECTED, where the
contract says SELECTABLE. Which behaviour is intended?

Later in the series, the FFO getter says "selected_ref alone is not
enough (free-run, LOL, holdover), so use the same CONNECTED criterion"
and gates on this function. It would then publish FFO for a PLL that has
lost lock.

The same block also says pll_mask "drifts, because .prio_set writes the
table without touching it". This patch, however, adds
sit9531x_ref_pll_mask_rebuild(), which re-derives pll_mask on every poll,
and no .prio_set exists at this commit. Both texts are unchanged at the
end of the series.

[Severity: Medium]
Separately, should CONNECTED also take chan->active and chan->ho_freeze
into account?

sit9531x_chan_state_fetch() fetches both. It also notes that on a PLL
the configuration leaves unused, the status bits stay at their defaults,
and it gates locked on active for that reason.

A default ACTIVESEL of 0 decodes to IN0P. Could IN0 then report
CONNECTED on an inactive PLL?

During holdover, the pin would also report CONNECTED while the loop is
not tracking any input. That includes the forced holdover that
sit9531x_prio_table_commit() applies on every table write.

I couldn't confirm from the datasheet what ACTIVESEL reads on an inactive
PLL.

> +
> +	if (!(chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id))))
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +	else if (active_input)
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_SELECTABLE;
> +}

[Severity: Medium]
Does reporting hardware selection through DPLL_A_PIN_STATE match the
documented semantics? Documentation/driver-api/dpll.rst says:

    Pin state (DPLL_A_PIN_STATE) reflects the administrative intent set
    by the user.

It also says that pin operational state (DPLL_A_PIN_OPERSTATE) reflects
what the hardware is actually doing with the pin.

The setter refuses CONNECTED. Yet whenever selected_ref == pin_id, this
getter reports a pin the user set to SELECTABLE as CONNECTED, without
any user action.

sit9531x_dpll_input_pin_ops also has no .operstate_on_dpll_get.
include/linux/dpll.h provides that callback, and zl3073x implements it to
report ACTIVE/STANDBY.

Would it fit the uAPI better to keep state administrative and report the
selection through operstate?

[ ... ]

> @@ -414,6 +698,242 @@ static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_input_prio_set - move an input to a priority slot
> + * @input_idx:	input source in hardware encoding (0-11, see
> + *		sit9531x_input_hw_src())
> + * @prio:	priority slot position (0 = highest)
> + *
> + * Reads the PLL's table, takes the source out of wherever it sits and
> + * reinserts it at @prio, shifting the entries in between.  The rest keep
> + * their relative order: a priority change asks about one input, so the
> + * fallbacks configured behind it have to survive it.
> + *
> + * The table is what makes a source eligible for this PLL, so this only
> + * ever reorders sources already in it.  A source that is absent is
> + * disconnected on this PLL, and inserting it here would make it a
> + * selection candidate again behind the caller's back; that is a connect,
> + * and it belongs to the pin's state setter.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, -EINVAL if the source is not in the table,
> + * <0 on error
> + */
> +int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 prio)
> +{
> +	u8 orig_srcs[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 rest[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 slot, n = 0;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +	input_idx = sit9531x_prio_src_canon(sitdev, input_idx);
> +	if (input_idx >= SIT9531X_PRIO_NUM_SRC)
> +		return -EINVAL;
> +	if (prio >= SIT9531X_PRIO_MAX_SLOTS)
> +		return -EINVAL;
> +
> +	rc = sit9531x_prio_table_read(sitdev, pll_idx, srcs);
> +	if (rc)
> +		return rc;
> +
> +	memcpy(orig_srcs, srcs, sizeof(srcs));
> +
> +	/*
> +	 * Take every copy of the source out first.  A disconnect backfills
> +	 * the slots it frees with the lowest-priority source still listed,
> +	 * so the same source appearing more than once is an ordinary state
> +	 * of the table, and shifting from its first copy alone can leave
> +	 * another copy ahead of the slot the request named -- a priority
> +	 * the request did not ask for and the getter would then report.
> +	 */
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)
> +		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) != input_idx)
> +			rest[n++] = srcs[slot];
> +
> +	if (n == SIT9531X_PRIO_MAX_SLOTS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Once the copies are collapsed the source can only sit behind the
> +	 * other sources the table lists, because the slots past the last of
> +	 * them repeat it.  A slot beyond that is a priority the table cannot
> +	 * express, and placing the source at the nearest one it can would
> +	 * report success for a priority nobody asked for.
> +	 */
> +	if (prio > n)
> +		return -ERANGE;
> +
> +	for (slot = 0; slot < prio; slot++)
> +		srcs[slot] = rest[slot];
> +
> +	srcs[prio] = input_idx;
> +
> +	for (slot = prio + 1; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)
> +		srcs[slot] = (slot - 1 < n) ? rest[slot - 1] : srcs[slot - 1];
> +	if (!memcmp(srcs, orig_srcs, sizeof(srcs)))
> +		return 0;
> +
> +	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);
> +}
> +
> +/*
> + * sit9531x_input_prio_remove - drop an input from a PLL's priority table
> + * @input_idx:	input source in hardware encoding
> + *
> + * Rewrites the priority table with the source removed: the remaining
> + * sources are compacted toward the highest-priority slots and the freed
> + * tail slots are backfilled with the lowest-priority remaining source.
> + * This makes a disconnected input ineligible for automatic reference
> + * selection, not just gated at the input buffer.
> + *
> + * Removing a source that is absent is what the caller asked for already,
> + * so it succeeds without touching the table.  Removing the last one fills
> + * every slot with the code for the pair this part does not have, which
> + * leaves the device with nothing to select and no reference to fall back
> + * on -- which is what a request to disconnect the last input means.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       u8 input_idx)
> +{
> +	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 kept[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 slot, count = 0;
> +	bool found = false;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +	input_idx = sit9531x_prio_src_canon(sitdev, input_idx);
> +
> +	rc = sit9531x_prio_table_read(sitdev, pll_idx, srcs);
> +	if (rc)
> +		return rc;
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> +		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) == input_idx)
> +			found = true;
> +		else
> +			kept[count++] = srcs[slot];
> +	}
> +
> +	if (!found)
> +		return 0;
> +
> +	if (count == 0) {
> +		/*
> +		 * Nothing is left to compact toward, so every slot gets the
> +		 * code that names no reference.  The device is then left
> +		 * with no source to select, which is what disconnecting the
> +		 * last input asks for; lock status follows the loop on its
> +		 * own from there.
> +		 */
> +		memset(kept, SIT9531X_PRIO_SRC_NONE, sizeof(kept));
> +	} else {
> +		/* Backfill freed tail slots with the lowest-priority src */
> +		while (count < SIT9531X_PRIO_MAX_SLOTS) {
> +			kept[count] = kept[count - 1];
> +			count++;
> +		}
> +	}
> +
> +	return sit9531x_prio_table_commit(sitdev, pll_idx, kept);
> +}
> +
> +/*
> + * sit9531x_input_prio_add - make an input eligible in a PLL's table
> + * @input_idx:	input source in hardware encoding
> + *
> + * Ensures the source appears in the priority table so it can be picked
> + * by automatic reference selection again after a disconnect.  If the
> + * source is already listed the table is left untouched; otherwise it
> + * replaces a duplicate at the tail.  A table that contains only unique
> + * sources cannot accept a new one without evicting another, so that
> + * case fails with -ENOSPC.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx)
> +{
> +	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
> +	u8 seen[SIT9531X_PRIO_NUM_SRC] = { 0 };
> +	u8 replace = SIT9531X_PRIO_MAX_SLOTS;
> +	u8 slot, src, src_canon;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +	input_idx = sit9531x_prio_src_canon(sitdev, input_idx);
> +	if (input_idx >= SIT9531X_PRIO_NUM_SRC)
> +		return -EINVAL;
> +
> +	rc = sit9531x_prio_table_read(sitdev, pll_idx, srcs);
> +	if (rc)
> +		return rc;
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)
> +		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) == input_idx)
> +			return 0;
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> +		src = srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;
> +		src_canon = sit9531x_prio_src_canon(sitdev, src);
> +		if (!sit9531x_prio_src_usable(src))
> +			continue;
> +
> +		seen[src_canon]++;
> +	}
> +
> +	/*
> +	 * A slot whose code names no usable source -- a reserved value, or
> +	 * one past the inputs this variant has -- is free space, and taking
> +	 * it costs nothing.  Prefer it over displacing a real reference.
> +	 */
> +	for (slot = SIT9531X_PRIO_MAX_SLOTS; slot-- > 0;) {
> +		src = srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;
> +		if (!sit9531x_prio_src_usable(src)) {
> +			replace = slot;
> +			break;
> +		}
> +	}
> +
> +	/* Otherwise take the last slot holding a source listed twice. */
> +	for (slot = SIT9531X_PRIO_MAX_SLOTS;
> +	     replace == SIT9531X_PRIO_MAX_SLOTS && slot-- > 0;) {
> +		src = srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;
> +		src_canon = sit9531x_prio_src_canon(sitdev, src);
> +		if (!sit9531x_prio_src_usable(src))
> +			continue;
> +
> +		if (seen[src_canon] > 1) {
> +			replace = slot;
> +			break;
> +		}
> +	}
> +
> +	if (replace == SIT9531X_PRIO_MAX_SLOTS)
> +		return -ENOSPC;
> +
> +	srcs[replace] = input_idx;
> +
> +	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);
> +}
> +
>  /* XO doubler register */
>  #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)
>  #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 = enabled */

[Severity: Low]
When the table has more than one free slot, does this search place new
inputs in the reverse of the order they were connected?

The loop walks down from the last slot, so it always takes the
highest-index free slot. After sit9531x_input_prio_remove() has emptied
the table, every slot holds SIT9531X_PRIO_SRC_NONE. Suppose IN0 and
then IN2 are set to SELECTABLE on that DPLL:

- IN0 lands in the last slot.
- IN2 lands in the slot before it, so IN2 now outranks IN0.

Each input connected afterwards goes ahead of every input connected
before it, until the free slots run out. The same happens when the
loaded configuration leaves several slots holding codes that
sit9531x_prio_src_usable() rejects.

The SELECTABLE path in sit9531x_dpll_input_pin_state_on_dpll_set()
does not report where the input landed. The user only sees the order
the PLL will select in by reading the priorities back. The priority
setter added in the next patch can reorder them, but the default order
is still the opposite of what one would expect.

Was this ordering intended? Two alternatives:

- Scan upward from slot 0 for free space.
- Place the new source directly behind the last usable entry.

Either would keep the order in which inputs were connected. The
kernel-doc above only says the source replaces a duplicate at the
tail. It does not describe the free-slot case, or which free slot is
preferred.
