Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465787;
	b=wOod/k8OkARTFd1zvCFWSgDGNux8wVUEkrtxKD/myusxHvltQCOA8oEu/72rlgCJXGh1
	 FjzL2w/LjxTbG1k2rBuhZNjz3Cdv86oU5sJwJOVk52QTxkofsG62NuEeHdPvNPuGsCwbL
	 9wS8sDiLUqyN1GebbJ6k85ot7cXR3wC8aepxzhYIn0qK2FdpxsTMbOXOH87H5+TtdEUIO
	 ka4MDjc82iizq1DNizKm4tfSZXGqQUfmXXP03Ljv/m3BE/85wDRcjX2MI9YIeOZUtmjUZ
	 3jlWs4GvLcyGO7S7sBLAI6nL+jOMoAeyUax5f1WugAtDk75h3TjB0ZBRDQKkumYqiBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465787;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tnlku/yMuiROAdMyn0IBo9oeL5ZIvOKbKBZuqknfa3Q=;
	b=xWeKb+033Hm4xYbG1vK3QWoGTFKhKhFzSK/0eYi/yeKTxWaAMk7MBSrHSclTnZVbPzvG
	 7mXI6vI8dEJ4LaoApmr1hLqJT0vl+ohTNS+1ogndM9ci4c5ET3fUDWhZsb1XYliKHHjtC
	 6wP9T7+25Cn2yrhI4FB+vLBSfOt+J8S3jW9v9vaTrtPkc77kQ2wwolDrOwnNKoqyfV7W+
	 /snfauPg6gvIuheMoG/e1VT0EAmCeeqHX7RlzeAJC1kDjVpSHRUeN2+LD6zCNLtpspKaG
	 KMOs7eXoNGbeY57fScVcnwHSHd+xqT9mLq0JyXFKLghvl4lN8O8WdadSKULHHb3bxtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uii1DMvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44060A5BE5;
	Tue, 20 Oct 2026 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uii1DMvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861CD1F000C9;
	Tue, 20 Oct 2026 03:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465786;
	bh=tnlku/yMuiROAdMyn0IBo9oeL5ZIvOKbKBZuqknfa3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uii1DMvyyr0SUQEQmXbaagjXwy5DAArYcHbkBt3935cqGKXM4AjGcBXjnr2eb5CMc
	 dsrk9aWQ/EhGUl8zaOGNfccpkoDzC2NMsKdDd32wF5iR0JzlyICWzd/HF2Mnq4Yf9q
	 Anm3KW+iL9F0aXzo+FclwummpGkdHqkG/XCFgbQOKPuMxoh34wRaOoc/wuiggv+gC4
	 EHTElAlNG9ydwIb9zqExGXCTIOSrjlP6lM9Rhg1KZUgvkZ8vfCGr/Ef/xXWEn7nRtb
	 Z9N5B/ax+DkLr1TMC3tJEezgrxBvh4/tMQtP4/5TrxqGgWpmh9Hr385g5ULGFhSBph
	 S6am+X0gI+IZQ==
Subject: Re: [PATCH net-next v14 06/12] dpll: sit9531x: implement input pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:45 +0000
Message-ID: <179246578508.3135.11298872832545978282@kernel.org>
In-Reply-To: <20261016005823.13690-7-arouhi@sitime.com>
References: <20261016005823.13690-7-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 8 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_prio_table_commit() decides whether an existing
  forced holdover belongs to someone else with `ho_foreign = (val &…
- [Medium] Qualification failure is ignored both when choosing a source
  and when reporting ACTIVE.
- [Medium] After a failed commit, sit9531x_prio_table_commit() decides at
  `release:` whether to keep or release the hold by reading…
- [Medium] sit9531x_input_prio_set() rolls cfg_prio/cfg_known back on any
  error from sit9531x_prio_table_apply(), including the case where the…
- [Medium] When sit9531x_prio_table_commit() cannot release its own
  forced holdover, it sets chan->ho_release_pending, and only the poll…
- [Medium] ref->pll_mask alone decides when a shared input receiver is
  forced off, and it counts only the four PLLs' priority tables…
- [Medium] sit9531x_prio_src_live() treats the inter-PLL sync net (code
  6) as always having signal: hw_src_input() yields…
- [Medium] On a failed table write, sit9531x_prio_table_commit() rolls
  back and then latches unconditionally.
- [Low] operstate_on_dpll_get reports a value the device changes on its
  own, but at this commit sit9531x_dpll_changes_check() polls only…
- [Low] sit9531x_chan_routed_ref_read() writes the unlock key
  (SIT9531X_PLL_DEBUG_UNLOCK) to PLL-page 0xBD and returns immediately…

--

dpll: sit9531x: implement input pin state on a DPLL

This adds state_on_dpll_get/set and operstate_on_dpll_get for the sit9531x
input pins.  An input's state comes from whether it is in each PLL's
priority table.  The table is rewritten under a forced holdover with a
newly chosen active selection.  Operstate comes from the routed source on
the debug status bus and from each lane's clock monitor.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 78a7a1def2137..1aad598930d72 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -433,26 +527,595 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)

[ ... ]

> +static bool sit9531x_prio_src_live(const struct sit9531x_dev *sitdev, u8 src)
> +{
> +	u8 index = sit9531x_hw_src_input(src);
> +
> +	if (index >= sitdev->info->num_inputs)
> +		return true;

[Severity: Medium]
Does this treat the inter-PLL sync net as always having signal?  For
SIT9531X_PRIO_SRC_INTSYNC, sit9531x_hw_src_input() returns
SIT9531X_INTSYNC_PIN_ID.  That is >= num_inputs, so this returns true.

The net only carries a clock while another PLL drives it
(sitdev->intsync_src).  INTSYNC can end up listed above live inputs while
no PLL drives it, for example after a prio_set gives it priority 0, or
when a profile ranks it first.  In that case sit9531x_prio_top_live()
returns it, and sit9531x_prio_activesel_pick() writes it into
CLK_ACTIVESEL.

The comment on sit9531x_prio_activesel_pick() says a selection naming a
dead source sends the PLL to it and it unlocks.  Could that happen here
once the hold is released?

Later in the series, the dpll.c side treats an undriven net as NO_SIGNAL
(sit9531x_dpll_selection_no_signal()), but this picker does not.

> +
> +	return !sitdev->ref[index].los;
> +}

[ ... ]

> +static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				      const u8 *srcs)
> +{

[ ... ]

> +	rc = sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,
> +				  &val);
> +	if (rc)
> +		return rc;
> +
> +	ho_foreign = (val & BIT(SIT9531X_PLL_HO_FORCE_BIT)) &&
> +		     chan->prio_mask && !chan->ho_release_pending;

[Severity: Medium]
Can this tell a hold the driver set from one it did not?  Any forced hold
found while the cached table is empty is treated as the driver's own.
Nothing records whether the driver actually set it.

Path 1: the loaded profile leaves a PLL with an empty table and HO_CTRL
bit 4 set.  Probe gives prio_mask == 0, and a user sets an input
SELECTABLE.  ho_foreign is false, prio_mask becomes non-zero, and the
release loop clears a force bit the driver never set.

Path 2: a tool forces holdover while the table lists sources, and the
user removes the last source.  ho_foreign is true, but the
if (!chan->prio_mask) branch after release: returns before ho_foreign is
checked, and nothing remembers that the hold was foreign.  On the next
add, prio_mask == 0 makes ho_foreign false and the hold is lifted.

The commit message says:

    A holdover the driver
    did not force -- set by the loaded configuration or by a tool -- is left
    in place by such a write; only the hold the driver itself set for an
    empty table is released.

To make that hold, would the driver need an explicit flag that records
when it owns the hold?

[ ... ]

> +rollback:
> +	if (rc && written) {

[ ... ]

> +		for (slot = 0; slot < written; slot += 2) {
> +			const u8 *prev = &chan->prio_srcs[slot];
> +			u8 old;
> +
> +			if (slot + 1 < SIT9531X_PRIO_MAX_SLOTS) {
> +				old = sit9531x_prio_slot_set(0, slot, prev[0]);
> +				old = sit9531x_prio_slot_set(old, slot + 1,
> +							     prev[1]);
> +			} else {
> +				old = last_old;
> +			}

[Severity: Medium]
Can this rollback move a PLL off a healthy fallback?  Say the PLL has
failed over from A to B and A is still in LOS.  The selection nibble in
last_old then still names A.

If the last register is in the rollback range, it is restored to
last_old.  On an earlier failure, such as sit9531x_input_mon_fetch()
failing, it is never touched.  Either way, the unconditional
sit9531x_prio_prg_commit() below latches a selection that names the dead
A.

The comment on sit9531x_prio_activesel_pick() says that in this
situation "the next table write sends the PLL back to it and it
unlocks".  Once the hold is released, would a failed request then unlock
a PLL that was locked to B, instead of leaving the device as the request
found it?

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

[Severity: Medium]
What happens if this read-back also fails?  prio_mask then still holds
the table from before the write.  The release: block below uses that
stale mask to decide whether to keep or release the hold.

Case A, adding the first source to an empty table: the force write and
every slot write succeed, then sit9531x_prio_prg_commit() fails and so
does the read-back.  prio_mask stays 0, so the if (!chan->prio_mask)
branch keeps the hold and clears ho_release_pending.

The next poll reads the table, which now lists the source, and prio_mask
becomes non-zero.  sit9531x_ho_release_retry() does nothing because
pending is false.  A retried SELECTABLE returns 0 early in
sit9531x_input_prio_add():

	if (chan->prio_mask & BIT(input_idx))
		return 0;

so the PLL stays in forced holdover while the pin reports SELECTABLE.

Case B, removing the last source with the latch and the read-back both
failing: the old non-empty prio_mask stays.  The hold is then released
over an empty hardware table, and the PLL follows the source the
selection nibble still names while every pin reports DISCONNECTED.

Should the mask be marked unknown here, so that the release decision and
the pending flag do not depend on it?

> +
> +release:

[ ... ]

> +	if (!chan->prio_mask) {
> +		dev_dbg(sitdev->dev,
> +			"PLL%c: no source listed, holdover kept\n",
> +			'A' + pll_idx);
> +		chan->ho_release_pending = false;
> +		return rc;
> +	}

[ ... ]

> @@ -479,6 +1142,155 @@ static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 prio)
> +{

[ ... ]

> +	rc = sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);
> +	if (rc) {
> +		chan->cfg_prio[input_idx] = old_prio;
> +		chan->cfg_known = old_known;
> +	}

[Severity: Medium]
Does this roll back a priority the device actually accepted?  Suppose
sit9531x_prio_table_commit() writes and latches the table, and only the
holdover release fails after SIT9531X_HO_CLEAR_TRIES attempts.  By then
the commit has already run:

	if (!rc) {
		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);
		memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));

and it then returns ho_rc.  The restore here puts the old cfg_prio back
while the hardware holds the new order.

The table matches seen_srcs, so the poll never reseeds.  prio_get (wired
up in the next patch) then reports the old value, and the next rebuild
for any other reason writes the old order back.

The next patch's commit message says "A priority the table write refused
is not kept", but in this case the device accepted it.

[ ... ]

> @@ -661,6 +1474,73 @@ static int sit9531x_pll_is_active(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +static int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev,
> +					 u8 pll_idx, u8 *ref)
> +{
> +	int rc, lock_rc;
> +	u8 v, i;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	rc = sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,
> +				   SIT9531X_PLL_DEBUG_UNLOCK);
> +	if (rc)
> +		return rc;

[Severity: Low]
Should this path also go through relock:?  Elsewhere in this patch, a
write that reports an error is assumed to possibly have reached the part.
The failed force write still goes to release, and slot writes are counted
before they are issued.

If the unlock key landed despite the error, the debug page stays open.
The comment at relock: says that leaves it "open to a stray write".

The poll relocks it only by calling this function again, and it does
that only while the PLL is tracking.  Could a PLL that becomes unlocked,
frozen or free-running keep its debug page unlocked indefinitely?

[ ... ]

> @@ -976,6 +1871,71 @@ static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)

[ ... ]

> +static void sit9531x_ho_release_retry(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{
> +	struct sit9531x_chan *chan = &sitdev->chan[pll_idx];
> +
> +	if (!chan->ho_release_pending)
> +		return;

[Severity: Medium]
Is the owed release lost on unbind?  The poll is the only place an owed
release is retried, and sit9531x_dev_stop() only cancels the worker and
unregisters the DPLLs:

static void sit9531x_dev_stop(struct sit9531x_dev *sitdev)
{
	...
	kthread_cancel_delayed_work_sync(&sitdev->work);
	...
}

so the force bit can outlive the driver instance.

On rebind, ho_release_pending starts false and the table read gives a
non-zero prio_mask.  So in sit9531x_prio_table_commit():

	ho_foreign = (val & BIT(SIT9531X_PLL_HO_FORCE_BIT)) &&
		     chan->prio_mask && !chan->ho_release_pending;

is true, and every later table write leaves the hold in place.  Would the
PLL then stay in forced holdover until a power cycle or a manual register
write?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index e88fa4e29bdf3..4c7cae4ce93ec 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -241,6 +266,124 @@ const struct dpll_device_ops sit9531x_dpll_device_ops = {

[ ... ]

> +static void
> +sit9531x_dpll_selection_operstate_get(struct sit9531x_dev *sitdev,
> +				      const struct sit9531x_dpll *sitdpll,
> +				      u8 pin_id,
> +				      enum dpll_pin_operstate *operstate)
> +{
> +	const struct sit9531x_ref *ref;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (sit9531x_dpll_selection_active(sitdev, sitdpll, pin_id)) {
> +		*operstate = DPLL_PIN_OPERSTATE_ACTIVE;
> +		return;
> +	}
> +
> +	if (pin_id < sitdev->info->num_inputs) {
> +		ref = sit9531x_ref_state_get(sitdev, pin_id);
> +		if (ref->los) {
> +			*operstate = DPLL_PIN_OPERSTATE_NO_SIGNAL;
> +			return;
> +		}
> +		if (ref->qual_fail) {
> +			*operstate = DPLL_PIN_OPERSTATE_QUAL_FAILED;
> +			return;
> +		}
> +	}

[Severity: Medium]
Should a failed qualification rule out ACTIVE here?
sit9531x_dpll_selection_active() does not check ref->qual_fail.  So when
the PLL is routed to and locked on a drifting lane, this returns ACTIVE
before it reaches the qual_fail branch.

include/uapi/linux/dpll.h defines:

 * @DPLL_PIN_OPERSTATE_ACTIVE: pin is qualified and actively used by the DPLL
 * @DPLL_PIN_OPERSTATE_QUAL_FAILED: pin signal failed qualification (e.g.
 *   frequency or phase monitor)

There is a related question on the selection side.
sit9531x_prio_src_live() only tests !sitdev->ref[index].los, so
sit9531x_prio_top_live() and sit9531x_prio_activesel_pick() can pick a
drifting input over a qualified lower-priority one.  One example is
removing the current source from a table [cur, drifted, healthy].  Is it
known whether the device itself rejects drifted sources?

[ ... ]

> @@ -253,8 +396,163 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +	switch (state) {
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		rc = sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);

[ ... ]

> +		ref->pll_mask &= ~pll_bit;
> +		/*
> +		 * The receiver is shared, so the last DPLL to let go turns it
> +		 * off.  That has to happen even when the table rewrite
> +		 * reported an error, or the input stays powered with nothing
> +		 * tracking it; the first error is the one returned.
> +		 */
> +		if (!ref->pll_mask) {
> +			int off_rc = sit9531x_input_disable(sitdev, dpin->id);

[Severity: Medium]
Can this cut the reference of a PLL in manual active select?
ref->pll_mask counts only priority tables, both here and in
sit9531x_ref_pll_mask_rebuild():

	u16 mask = sitdev->chan[pll_idx].prio_mask;

A profile can put a PLL in manual active select (PLL_CONFIG1F bit 6).
The PLL then follows CLK_ACTIVESEL, or the manual input select when
MISCINNER bit 5 is set, rather than its table.
sit9531x_manual_sel_report() only warns about this.

Suppose such a PLL runs on INx and its table does not list INx.
Disconnecting INx from the last PLL whose table lists it drops pll_mask
to 0.  sit9531x_input_disable() then sets the force bit and clears the
state bit for a receiver that the manual-select PLL is still locked to.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
