Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34214848A0;
	Thu, 17 Sep 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657330; cv=none; b=stenFAreFX1qn4TDRPWnwiofFnmuBuS3wYbWdUx98R65d6VAtDT+fWCAgfDAvVKSihBP5547CYVEHBOsza9w8GMxZes0AoSw14SM8w8NZlq+1yA1nWCOyn4w3U6wgI7MILl23wn+CLRA8o+Cpd4pQdQXUvBRfiTrdy2bW0StVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657330; c=relaxed/simple;
	bh=szKRSp7Wmqxf16pwld4biogTaYwVo2XCafPYCW5pZoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DK/D/s8V4tSmM1P7MFpRYVL8Z8+vfN+iBGhklk0iFRwk3mKwcOrLS7We/fglzDwZa/OIBjfPY4iN2KRE1l0YoLPlf5ASEEle2CpxBwP1XmF1/64NqSfre0si35yBsTOoUb2zhq16EXFdBgItrd/BN2KQ2DUkCkRTacM9SX5WrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GchF5Gzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GchF5Gzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4371F0089C;
	Thu, 17 Sep 2026 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657309;
	bh=5QnIb8XXqMFEOzKGfGoOueakHIpn6sxv6Dyp9T2Gp3o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GchF5Gzgcr2lX5eBL9DOb8I/y/M/glVb+Zgc5Q3SjNlGo5ASXI9USoLsRw/3y9/CA
	 8Mp892smoOV3bGCHJITlDeEBU4D+JWti8+wBDdIT3Iq0YPHoufU5YpgyT1xsAIPX9c
	 1tjL/pPKR3AT4XDbwrlrJ9CCLPXJjBb/ZK/By3x/CUJFCBs0zpTN02njJY6Yv7Gqcz
	 qTBK0hHZWYDMKl6sXt0ViaXQhs6iN8gaVcNKGc0mSqlw6tmryQykfbWjf7yTIvlXwf
	 y+ylTJ8JrHID1xIDohL7u9Bw0J5M3nRUYEPEk0pgf0VfgFpY5yOn1h7G/KQWH4ZQuc
	 3mtlA/68q6e6g==
Subject: Re: [PATCH net-next v9 06/15] dpll: sit9531x: implement input pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:48 +0000
Message-ID: <178965730805.22033.5181387968510384943@kernel.org>
In-Reply-To: <20260915000015.80480-7-arouhi@sitime.com>
References: <20260915000015.80480-7-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 · Low: 4

- [High] sit9531x_prio_table_commit() publishes the *intended* table into
  the shared chan->prio_mask cache even when the slot writes failed…
- [Medium] Inconsistent source-code canonicalization between the
  producers of the cached hardware state and the new pin-facing…
- [Medium] The SELECTABLE branch of
  sit9531x_dpll_input_pin_state_on_dpll_set() keys the shared-receiver…
- [Medium] sit9531x_input_prio_set() locates only the *first* occurrence
  of the requested source and then shifts the intervening entries, so…
- [Medium] On a mid-sequence read or write failure,
  sit9531x_prio_table_commit() jumps to `commit:` and unconditionally…
- [Low] sit9531x_dpll_pin_is_registrable()'s rewritten kernel-doc claims
  "For output pins: the pin is registrable if this DPLL is routed to it,…
- [Low] prop.c advertises DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE for
  every physical input pin, but sit9531x_dpll_input_pin_ops — the ops…
- [Low] sit9531x_input_disable()'s comment claims that attempting both
  register operations means "a half-programmed override is not left…
- [Low] sit9531x_input_prio_add() only ever overwrites a slot whose
  canonical source is *duplicated* (`if (seen[src_canon] > 1)`), and…

--

dpll: sit9531x: implement input pin state on a DPLL

This adds state_on_dpll_get/set for input pins, backed by new helpers that
read, rewrite and latch a PLL's priority table under forced holdover, plus
force/state register helpers that gate the shared input receiver.  Input
pins other than the crystal now become registrable.

A few questions about the new code below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 6dfb1b31d4913..25418485e9757 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -185,6 +185,93 @@ static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,
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
> + *
> + * Both writes are attempted even when the first fails, and the first
> + * error is returned: the force and state bits only mean something
> + * together, so a half-programmed override is not left behind on a
> + * transient bus error.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
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

[Severity: Low]
Does the comment above match what the code does?  The claim is that "a
half-programmed override is not left behind on a transient bus error", but
these are two independent read-modify-writes with no rollback and no
verification.

If the force_reg write succeeds and the state_reg access then fails, the
force bit is set while the old state bit remains; when that bit reads 1 the
override forces the receiver on rather than off.  If the force_reg access
fails and the state_reg write succeeds, the inverse partial update stays in
the device.  Returning the first error restores neither register.

Would it be more accurate to say that both operations are attempted and the
first error reported, without promising that no partial override remains?

[ ... ]

> @@ -347,6 +434,92 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)
>  	return val >> SIT9531X_PRIO_HI_SHIFT;
>  }
>  
[ ... ]
> +static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)
> +{
> +	int rc;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
> +			       SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		return rc;
> +
> +	usleep_range(1000, 2000);
> +
> +	return 0;
> +}
> +
> +/*
> + * Fold a source code to the lane a DPLL pin actually represents.
> + *
> + * Differential input pairs expose only the P lane as a DPLL pin.  A
> + * priority table entry encoded as an N lane for such a pair must map to
> + * the P-lane source for pin-facing operations (membership, priority slots,
> + * add/remove/set lookups), matching sit9531x_ref_pll_mask_fetch().
> + */
> +static u8 sit9531x_prio_src_canon(const struct sit9531x_dev *sitdev, u8 src)
> +{
> +	u8 index = sit9531x_hw_src_input(src);
> +
> +	if (index >= sitdev->info->num_inputs)
> +		return src;
> +
> +	if (sit9531x_input_is_n(index) &&
> +	    sitdev->ref[index].sig_mode == SIT9531X_MODE_DE)
> +		return sit9531x_input_hw_src(index - 1);
> +
> +	return src;
> +}
> +
> +/*
> + * sit9531x_input_prio_present - is a source listed in a PLL's priority table
> + * @input_idx:	input source in hardware encoding (see
> + *		sit9531x_input_hw_src())
> + *
> + * Answers from the membership mask that every table write and every poll
> + * refreshes, which is what the pin state getters test.  The priority slot
> + * cannot answer this: a source that is not in the table reports the lowest
> + * slot, so the slot value alone does not separate absent from last.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				 u8 input_idx)
> +{
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return false;
> +
> +	input_idx = sit9531x_prio_src_canon(sitdev, input_idx);
> +	if (input_idx >= SIT9531X_PRIO_NUM_SRC)
> +		return false;
> +
> +	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));
> +}
> +
>  /*
>   * Rebuild a PLL's membership mask from the source codes of its priority
>   * table.  The mask is what the pin state getters test, so it is refreshed
> @@ -365,6 +538,90 @@ static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	sitdev->chan[pll_idx].prio_mask = mask;
>  }
>  
> +/* Attempts to release a forced holdover before reporting it stuck. */
> +#define SIT9531X_HO_CLEAR_TRIES		3
> +
[ ... ]
> +static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_idx,
> +				      const u8 *srcs)
> +{
[ ... ]
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
> +	/*
> +	 * Latch unconditionally: slots written before a failed write are in
> +	 * the table regardless, so the latch keeps hardware and the mask
> +	 * rebuild below consistent with what was actually written.
> +	 */
> +	prg_rc = sit9531x_prio_prg_commit(sitdev);
> +	if (prg_rc && !rc)
> +		rc = prg_rc;

[Severity: Medium]
On a failed slot read or write, this jumps to commit: and issues the
small-change update directive anyway, then clears HO_FORCE below.  Does that
latch a table that is a mix of old and new slots into the running reference
selection loop?

The sequence on an I2C error after the first slot was written is:

	sit9531x_write_u8(slot N) fails
	goto commit
	sit9531x_prio_prg_commit()   /* SIT9531X_SMALL_UPDATE_CMD */
	... HO_FORCE cleared ...

so the loop resumes on a priority order that is neither the previous one nor
the requested one.

The old nibble is read into val only to be overwritten, so nothing is kept
for a restore, even though every caller still holds the pre-write table
(orig_srcs in sit9531x_input_prio_set(), the freshly read srcs[] in
sit9531x_input_prio_add() and sit9531x_input_prio_remove()).  Could the
saved nibbles be written back on failure, the way
sit9531x_output_divo_write() keeps old_bytes[] and rolls back?

> +
> +	/*
> +	 * Refresh the mask from the table just written so a get that follows
> +	 * a set does not have to wait for the next poll.  Slots written
> +	 * before a failed write are in the table too, so this is closer to
> +	 * the truth than the pre-write mask either way, and the poll read-back
> +	 * corrects whatever a partial write left behind.
> +	 */
> +	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);

[Severity: High]
This publishes the intended table into chan->prio_mask even when the slot
writes failed.  Does that make the membership re-check in the pin state
setter tautological?

The DISCONNECTED path in sit9531x_dpll_input_pin_state_on_dpll_set() does:

	rc = sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);
	if (rc && sit9531x_input_prio_present(sitdev, sitdpll->id,
					      hw_src))
		break;
	ref->pll_mask &= ~pll_bit;

but sit9531x_input_prio_present() only tests the mask this function just
overwrote with the requested image, so it reports the source absent no
matter what the chip's table now holds, and ref->pll_mask loses this DPLL.

The poll worker's sit9531x_chan_state_fetch() later re-reads the real table
into chan->prio_mask, so the getter goes back to reporting the input
SELECTABLE on that PLL, but ref->pll_mask is not re-derived:
sit9531x_ref_pll_mask_fetch() has one caller, sit9531x_dev_state_fetch(),
which runs once at probe.

Can the refcount then reach zero while a PLL still lists the input?

	PLL A disconnect, slot write fails -> ref->pll_mask loses bit A
	  (chip table may still list the source)
	PLL B disconnect succeeds -> ref->pll_mask == 0
	  -> sit9531x_input_disable(IN0)

which would force off a shared receiver that PLL A still lists and may be
locked to.  The commit message says "the poll read-back corrects whatever a
partial write left behind"; that holds for chan->prio_mask, but does anything
correct ref->pll_mask?

Would it work better to have sit9531x_prio_table_commit() rebuild the mask
from a read-back of the table it just wrote, and to re-derive ref->pll_mask
from the tables of all PLLs in the poll path?

> +
> +	/*
> +	 * Release the forced holdover.  Nothing else in the driver clears
> +	 * this bit, so a PLL left with it set reports holdover until the
> +	 * next table write on the same PLL happens to clear it, which may
> +	 * never come.  Retry before giving up, and say so if it stays set.
> +	 */
[ ... ]
> @@ -389,6 +646,208 @@ static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_idx,
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
[ ... ]
> + */
> +int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 prio)
> +{
[ ... ]
> +	for (from = 0; from < SIT9531X_PRIO_MAX_SLOTS; from++)
> +		if (sit9531x_prio_src_canon(sitdev, srcs[from]) == input_idx)
> +			break;
> +
> +	if (from == SIT9531X_PRIO_MAX_SLOTS)
> +		return -EINVAL;
> +
> +	if (from == prio)
> +		return 0;
> +
> +	if (from > prio) {
> +		/* Moving up: push the entries in between down one slot. */
> +		for (slot = from; slot > prio; slot--)
> +			srcs[slot] = srcs[slot - 1];
> +	} else {
> +		for (slot = from; slot < prio; slot++)
> +			srcs[slot] = srcs[slot + 1];
> +	}
> +
> +	srcs[prio] = input_idx;
> +	if (!memcmp(srcs, orig_srcs, sizeof(srcs)))
> +		return 0;

[Severity: Medium]
Only the first occurrence of the source is located, so what happens when the
table holds the same source more than once?

With [A,B,C,C,C,...] and a request to put C at slot 4, from is 2, the shift
copies C over C, and the result is identical to orig_srcs, so the memcmp
shortcut returns 0 without any register write.

With [A,B,C,D,C] and a request for slot 4, the result is [A,B,D,C,C], which
leaves C effectively at slot 3.

Duplicates are a normal state here because sit9531x_input_prio_remove()
backfills the freed tail slots with the lowest-priority remaining source
(kept[count] = kept[count - 1]), so a disconnect on a PLL creates them.

A later read via sit9531x_input_prio_get() reports the first occurrence from
chan->prio_last[], so it would contradict the value that was just accepted
with a 0 return.  Should the last occurrence be used when moving a source
down, or duplicates be collapsed before the shift?

This helper has no caller in this patch; the following commit "dpll: sit9531x:
add support to get and set priority on input pins" wires it to .prio_set, and
the logic is unchanged at the end of the series.

> +
> +	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);
> +}
> +
[ ... ]
> +int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       u8 input_idx)
> +{
[ ... ]
> +	/* Backfill freed tail slots with the lowest-priority remaining src */
> +	while (count < SIT9531X_PRIO_MAX_SLOTS) {
> +		kept[count] = kept[count - 1];
> +		count++;
> +	}
> +
> +	return sit9531x_prio_table_commit(sitdev, pll_idx, kept);
> +}
> +
[ ... ]
> +int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx)
> +{
[ ... ]
> +	for (slot = SIT9531X_PRIO_MAX_SLOTS; slot-- > 0;) {
> +		src = srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;
> +		src_canon = sit9531x_prio_src_canon(sitdev, src);
> +		if (src_canon >= SIT9531X_PRIO_NUM_SRC)
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

[Severity: Low]
Only a slot whose canonical source is duplicated is ever chosen as the
insertion point.  Does that refuse a request when a slot names nothing
usable?

A nibble of 0xC-0xF is skipped by the src_canon >= SIT9531X_PRIO_NUM_SRC
test, and a reserved code such as 4 or 11 appearing once has seen[] == 1, so
neither is replaced and the function returns -ENOSPC even though that slot
holds no valid reference.  sit9531x_prio_table_read() returns whatever the
loaded configuration put in the nibbles, and the rest of the driver already
treats out-of-range codes as possible (SIT9531X_REF_INVALID in
sit9531x_hw_src_input()).

Should a slot whose code decodes to no valid source be preferred over
returning -ENOSPC?

[ ... ]

> @@ -1323,15 +1806,15 @@ static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll,
>  					     enum dpll_pin_direction dir,
>  					     u8 index)
>  {
> -	/*
> -	 * Only the XO pin has a complete pin-op table in this patch.
> -	 * Other pin classes are registered once their state callbacks
> -	 * land in the following patches.
> -	 */
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
>  	if (dir != DPLL_PIN_DIRECTION_INPUT)
>  		return false;

[Severity: Low]
The rewritten kernel-doc above says "For output pins: the pin is registrable
if this DPLL is routed to it, whether or not it is currently driving", but
the first statement of the body still rejects every non-input direction, and
sit9531x_dpll_output_pin_ops in dpll.c carries only .direction_get at this
commit.  The output branch shows up later in the series, in "dpll: sit9531x:
implement output pin state on a DPLL".

Could the output sentence be deferred to that patch, keeping the note that
other pin classes are registered once their state callbacks land?  The same
applies to the output and sync-source roles described in the commit message,
which this patch does not implement.

>  
> -	return index == SIT9531X_MAX_INPUTS;
> +	if (index == SIT9531X_MAX_INPUTS)
> +		return true;
> +
> +	return sit9531x_input_pin_is_registrable(sitdev, index);
>  }
>  
>  /*
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index b4984335e6bfc..ab9aa7db1839c 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -288,6 +288,41 @@ const struct dpll_device_ops sit9531x_dpll_device_ops = {
>   * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.
>   */
>  
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
> +	else if (active_input)
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_SELECTABLE;
> +}

[Severity: Medium]
Both tests here assume a canonicalization that the producers of the cached
state do not perform.  Can a differential pair listed by its N code report
the wrong state?

sit9531x_prio_mask_build() sets the mask from the raw nibble:

	mask |= BIT(srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK);

so for a DE pair listed as 7+pair the mask carries the N bit, while the
membership test above uses sit9531x_input_hw_src(pin_id) for the registered P
pin, and sit9531x_input_prio_present() folds N to P through
sit9531x_prio_src_canon().  The pin would read DISCONNECTED while
sit9531x_input_prio_add() (which does canonicalize) finds the source already
listed and returns 0, so a SELECTABLE request succeeds with the reported
state never following.  This half is addressed in the next patch, "dpll:
sit9531x: add support to get and set priority on input pins", where
prio_mask_build() gains src_canon = sit9531x_prio_src_canon(...).

The selected_ref half looks unaddressed through the end of the series:
sit9531x_chan_state_fetch() stores

	chan->selected_ref =
		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);

which for an N-coded selection of a DE pair yields the odd lane index, and no
pin is registered for that index (sit9531x_input_pin_is_registrable() skips
it).  Does that make chan->selected_ref == pin_id unreachable for the
registered P pin, so a locked differential reference reports SELECTABLE
instead of CONNECTED?  The same comparison also gates the FFO and
phase-offset reporting later in the series.  Should selected_ref be folded
with sit9531x_prio_src_canon() at decode time?

> +
>  static int
>  sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
>  				      void *pin_priv,
> @@ -300,8 +335,144 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
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
[ ... ]
> +	case DPLL_PIN_STATE_SELECTABLE:
> +		if (!(ref->pll_mask & pll_bit)) {
> +			rc = sit9531x_input_enable(sitdev, dpin->id);
> +			if (rc)
> +				break;
> +		}
> +		rc = sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);
> +		if (rc && !sit9531x_input_prio_present(sitdev, sitdpll->id,
> +						       hw_src)) {
> +			if (!(ref->pll_mask & pll_bit) && !ref->pll_mask)
> +				sit9531x_input_disable(sitdev, dpin->id);
> +			break;
> +		}

[Severity: Medium]
The enable and the undo are both keyed on ref->pll_mask rather than on the
receiver's actual state in ref->enabled.  Are these two cases handled?

First, when this DPLL already holds the claim but the receiver is forced off,
sit9531x_input_enable() is skipped and sit9531x_input_prio_add() finds the
source already listed and returns 0, so the request reports success while the
input stays gated and the PLL can never select it.  That combination is
reachable straight after probe: sit9531x_ref_pll_mask_fetch() seeds pll_mask
from priority-table membership only, while sit9531x_ref_state_fetch() derives
the receiver state separately with

	ref->enabled = !((force & BIT(pair)) && !(state & BIT(pair)));

Second, when this DPLL holds no claim, ref->pll_mask is empty and the
receiver was already enabled by the loaded configuration, a failing
prio_add() calls sit9531x_input_disable() and turns off an input this request
never enabled, for every DPLL.

Should the enable and the undo consult ref->enabled and only undo what this
call actually changed?

> +		/*
> +		 * Claim the input for this DPLL only once it is both enabled
> +		 * and present in the priority table.  Setting the mask before
> +		 * prio_add would leak the claim if prio_add failed, keeping the
> +		 * shared input receiver powered even after every DPLL released
> +		 * it.
> +		 */
> +		ref->pll_mask |= pll_bit;
> +		break;
[ ... ]
> +	return rc;
> +}
> +
>  static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_input_pin_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_input_pin_state_on_dpll_set,
>  };

[Severity: Low]
This is the ops table for the input pins that this patch first registers, and
it has no .prio_get/.prio_set, while sit9531x_pin_props_get() advertises

	props->dpll_props.capabilities =
			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

for every physical input pin.  At this commit
dpll_msg_add_pin_prio() therefore never emits DPLL_A_PIN_PRIO for those pins,
and dpll_pin_prio_set() returns -EOPNOTSUPP after passing the capability
check.  In the same vein, sit9531x_input_prio_set() added in core.c has no
caller, and sit9531x_input_prio_get() is declared in core.h without a
definition at this revision.

The following patch, "dpll: sit9531x: add support to get and set priority on
input pins", adds both callbacks and the missing definition.  Would it be
better to register the pins and advertise PRIORITY_CAN_CHANGE in the same
patch that provides the callbacks?

>  
>  /*

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
