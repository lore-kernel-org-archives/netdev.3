Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5D54488E;
	Tue,  8 Sep 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871521; cv=none; b=ZBumGChAcf289EzKFJ/QpO4ErOounFYPp73TL282yGlrVnueWLWKRP35cjEp0hnQ7e2xXutnSRBNmtjI61TKGmrRzu5wvBe6nLhNgUpLFzAz+Q86IEEEYCs8mH2AKaXf6dBO6M3bgYMRasl5n/S/l5jlkc3fZ9VrXZuOMkIaRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871521; c=relaxed/simple;
	bh=fo0CYPtdAHBYrzJGdTMPb16TIFbwam5b3NyAhn/O7tM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLig6DeTwgCNEmGQr11TLKSX6UcwfMddoWYjueAoRj/oiRPp6a65rE6YlyJESAkvOmSYY5M/Rb9/8TpGibS1IEOenT1VXj+Wrgpo8PlpEIcwPJRIrpXYHle+IoUI+ZdgYYVbiWrINHXcf6K0B6WZbALQSXLib9vDhAmb5PA/538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxZpqWkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxZpqWkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14FC1F00A3D;
	Tue,  8 Sep 2026 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871518;
	bh=/I1IR7Tb8vg5vCZlc/SMEY2pxZXONAuf9ZZ4tTFhf/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FxZpqWkjwhC4LfAQ4M9YY6aoGgOrKm0MhVg6DCwLidnhHxZwq3eamv0DfNHKsL61q
	 kEj67p27RzqoL1Ye8QA+CLdcyifaxdSs3AZQCQyXTXL4asyEduSd0HgHm+p5mbODg0
	 nmE5bYseELl4k+Add2RpmXZ4g2OKoCdFRag6r+rN6Zb4I+8Z11lL9nrGvolxp3as6m
	 Xopem92Dneqb1LY+AsfmrRqnRrrI4Ou3u0PVLxsOVUgmDzfEgKbtbGH/5ylD/FzsY6
	 fqgor+hNGfA2AiB4GnDkhpSmZ9KfZgoOQmOjv4CM1CWvjtJ26+NZyqj9VyQrJTvkj1
	 Ym0LHXODwOuzw==
Subject: Re: [PATCH net-next v8 07/15] dpll: sit9531x: add support to get and
 set priority on input pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:17 +0000
Message-ID: <178887151730.219967.5781480771166965281@kernel.org>
In-Reply-To: <20260902214030.20955-8-arouhi@sitime.com>
References: <20260902214030.20955-8-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 4

- [Medium] sit9531x_input_prio_get()
  (drivers/dpll/sit9531x/core.c:456-457) returns success with *prio =…
- [Medium] Setting one input pin's priority silently renumbers other
  pins' priorities without notifying them.
- [Medium] A demotion request through the newly wired .prio_set can be a
  complete no-op at the register level while the callback reports…
- [Medium] sit9531x_input_prio_get() decides presence purely by comparing
  each of the 11 nibbles against the input's hardware source code ('if…
- [Low] The kernel-doc added by this patch for sit9531x_input_prio_get()
  states "Scans the PLL's 12-slot priority table on Page 1"…
- [Low] With .prio_set/.prio_get exposed, a userspace-configured priority
  is volatile and the field meant to preserve it is dead code.
- [Low] sit9531x_input_prio_get() issues one I2C read per slot (11 reads)
  although the slots are nibble-packed two per register…
- [Low] The 'dpin->dir != DPLL_PIN_DIRECTION_INPUT' guard in
  sit9531x_dpll_input_pin_prio_set() (dpll.c:467-470) is unreachable…

--

dpll: sit9531x: add support to get and set priority on input pins

This adds .prio_get and .prio_set to the sit9531x input pin ops.  The
getter scans the per-PLL priority table over I2C and reports the slot the
input occupies, and the setter moves the input to the requested slot via
sit9531x_input_prio_set().

A few questions below about the value reported for inputs absent from the
table, about the interaction with the tail-backfill done by
sit9531x_input_prio_remove(), and about a couple of comments.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index f42c41d8a42e..e706f6942f65 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -414,6 +414,49 @@ static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_input_prio_get - read an input's priority slot for a PLL
> + * @input_idx:	input source in hardware encoding (see
> + *		sit9531x_input_hw_src())
> + * @prio:	output slot position (0 = highest); set to
> + *		SIT9531X_PRIO_MAX_SLOTS when the source is not in the table
> + *
> + * Scans the PLL's 12-slot priority table on Page 1 and returns the
                        ^^^^^^^

[Severity: Low]
This isn't a bug, but should this say 11-slot?  regs.h has:

  /*
   * 11 priority slots, CLK_SPARE0SEL_PLL through CLK_SPARE10SEL_PLL.
   * The twelfth nibble of the block is not a slot: it is
   * CLK_ACTIVESEL_PLL, see SIT9531X_PRIO_ACTIVESEL_OFF below.
   */
  #define SIT9531X_PRIO_MAX_SLOTS		11
  /* Number of source encodings (0-11), unrelated to the slot count */
  #define SIT9531X_PRIO_NUM_SRC		12

and the block comment already in core.c above sit9531x_prio_reg() says "The
SiT9531x has an 11-slot priority table per PLL on Page 1."  The loop in the
function itself stops at SIT9531X_PRIO_MAX_SLOTS, so 12 looks like the source
encoding count rather than the slot count, and a later reader could conclude
that slot 11 exists and is programmable when that nibble is
CLK_ACTIVESEL_PLL.

> + * highest-priority (lowest-numbered) slot that references the source.
> + * This reads the value the chip actually holds rather than a cached
> + * default, so pin-get reflects the real hardware priority.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 *prio)
> +{
> +	u8 val, slot, src;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> +		rc = sit9531x_read_u8(sitdev,
> +				      sit9531x_prio_reg(pll_idx, slot), &val);
> +		if (rc)
> +			return rc;

[Severity: Low]
Could this loop read each register only once?  The slots are nibble-packed two
per register:

  static u16 sit9531x_prio_reg(u8 pll_idx, u8 slot)
  {
	return SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,
			    SIT9531X_PRIO_BASE_REG +
			    SIT9531X_PRIO_REGS_PER_PLL * pll_idx +
			    slot / SIT9531X_PRIO_SLOTS_PER_REG);
  }

so slots 0 and 1 map to the same register, 2 and 3 to the next, and so on,
giving 11 reads where 6 would do.  The regmap is created with .cache_type =
REGCACHE_NONE, so each of those is a real bus transfer plus page-selector
traffic, all under multiop_lock, which the 500 ms monitor kthread also takes.

sit9531x_prio_table_read() already exists and returns the whole table in one
pass; would using it here (or reusing the table the poll worker already reads
before sit9531x_prio_mask_build() discards the slot numbers) be simpler?

> +
> +		src = sit9531x_prio_slot_get(val, slot);
> +
> +		if (src == input_idx) {
> +			*prio = slot;
> +			return 0;
> +		}

[Severity: Medium]
Can a nibble that was never programmed be mistaken for IN0P here?  regs.h
documents the encoding as:

   *   0=IN0P, 1=IN1P, 2=IN2P, 3=IN3P, 4=IN4P,
   *   5=OCXO, 6=INTSYNC,
   *   7=IN0N, 8=IN1N, 9=IN2N, 10=IN3N, 11=IN4N

There is no reserved "slot unused" value, and sit9531x_input_hw_src(0)
returns 0 for IN0P, so a slot left at 0 by the efuse/blob configuration
compares equal to IN0P.  In that case IN0 is reported as occupying the first
such slot (often slot 0, the highest priority) on every PLL even if it was
never added, the "not in the table" path below can never be taken for that
input, and the -EINVAL guard in sit9531x_input_prio_set() would let the table
be rearranged around an entry that is not really there.

I could not find code that initialises the priority block to a known state at
probe, so whether unprogrammed slots really read 0 depends on the device
configuration.  Is that guaranteed not to happen, or should a match be
qualified against sources the driver knows it programmed?

> +	}
> +
> +	*prio = SIT9531X_PRIO_MAX_SLOTS;
> +	return 0;
> +}

[Severity: Medium]
Is priority 11 a value userspace can be handed?  This returns success with
*prio = SIT9531X_PRIO_MAX_SLOTS, and sit9531x_dpll_input_pin_prio_get()
forwards it unchanged:

	dpin->prio = slot;
	*prio = slot;
	return 0;

The core has no "no value" convention on that path; dpll_msg_add_pin_prio()
calls ops->prio_get and, on success, does:

	if (nla_put_u32(msg, DPLL_A_PIN_PRIO, prio))
		return -EMSGSIZE;

So every input not present in the PLL table is reported as DPLL_A_PIN_PRIO
11, while the setter added in the same patch rejects exactly that value:

	if (prio >= SIT9531X_PRIO_MAX_SLOTS) {
		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");
		return -EINVAL;
	}

A dump/modify/restore round trip of a disconnected input then fails with
EINVAL.  Since this is a new driver the value becomes uAPI once released.

The commit message says:

  "An input absent from the table has no priority to report, and the core is
  told so rather than handed a made-up number."

Does the code match that?  As written the core is handed 11, which is
out of range for this driver.

> +
>  /*
>   * Rebuild a PLL's membership mask from the source codes of its priority
>   * table.  The mask is what the pin state getters test, so it is refreshed
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 29088707a3e6..67b9fbba9f2e 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -417,10 +417,90 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_dpll_input_pin_prio_get - read input pin priority
> + *
> + * reads the PLL's priority table on Page 1 (via
> + * sit9531x_input_prio_get()) and returns the slot the input
> + * occupies, so pin-get reports the real hardware priority rather
> + * than a software default.
> + */
> +static int
> +sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll, void *dpll_priv,
> +				 u32 *prio, struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	u8 slot;
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_input_prio_get(sitdev, sitdpll->id,
> +				     sit9531x_input_hw_src(dpin->id), &slot);
> +	mutex_unlock(&sitdev->multiop_lock);
> +	if (rc)
> +		return rc;
> +
> +	dpin->prio = slot;

[Severity: Low]
Is anything reading dpin->prio?  It is written here and again at the end of
sit9531x_dpll_input_pin_prio_set(), and I could not find a read of it
anywhere in the driver, at this commit or at the end of the series.  Writing
driver state from a getter is also a side effect in an otherwise read-only
op, and the value stored can be the out-of-range 11 discussed above.

Related to that: a configured priority does not survive a disconnect and
reconnect.  DPLL_PIN_STATE_DISCONNECTED goes through
sit9531x_input_prio_remove(), which compacts the table, and
DPLL_PIN_STATE_SELECTABLE goes through sit9531x_input_prio_add(), which
always lands the source in the last slot:

	srcs[SIT9531X_PRIO_MAX_SLOTS - 1] = input_idx;

with its kernel-doc stating "The original priority is not restored".  So a
pin configured with prio 0 comes back as prio 10.  Meanwhile the natural
order of operations (set priority, then connect) is refused, since
sit9531x_input_prio_set() returns -EINVAL for a source absent from the table
and the callback answers "Pin is not a reference of this DPLL; connect it
first".  Would using dpin->prio to re-apply the priority on reconnect close
that, or should the field be dropped?

> +	*prio = slot;
> +	return 0;
> +}
> +
> +/*
> + * sit9531x_dpll_input_pin_prio_set - set input pin priority
> + *
> + * writes input priority table on Page 1 via
> + * core.c sit9531x_input_prio_set().  Forces holdover during update.
> + */
> +static int
> +sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll, void *dpll_priv,
> +				 u32 prio, struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	int rc;
> +
> +	if (dpin->dir != DPLL_PIN_DIRECTION_INPUT) {
> +		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");
> +		return -EINVAL;
> +	}

[Severity: Low]
Can this branch ever be taken?  sit9531x_dpll_pin_ops_get() only installs
sit9531x_dpll_input_pin_ops for pins that are inputs:

	if (!sit9531x_dpll_is_input_pin(pin))
		return &sit9531x_dpll_output_pin_ops;
	if (sit9531x_dpll_is_xo_pin(pin))
		return &sit9531x_dpll_xo_pin_ops;
	return &sit9531x_dpll_input_pin_ops;

and sit9531x_dpll_is_input_pin() is just pin->dir == DPLL_PIN_DIRECTION_INPUT.
There is no .direction_set in any of the driver's ops tables, so dir cannot
change after registration.  The getter added in the same patch has no such
check, which makes the pair inconsistent too.

> +
> +	if (prio >= SIT9531X_PRIO_MAX_SLOTS) {
> +		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_input_prio_set(sitdev, sitdpll->id,
> +				     sit9531x_input_hw_src(dpin->id),
> +				     (u8)prio);
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
Can a demotion request through this path end up a no-op that still reports
success?

sit9531x_input_prio_remove() deliberately duplicates the last kept source
into the freed tail slots, since the 4-bit encoding has no empty value:

	/* Backfill freed tail slots with the lowest-priority remaining src */
	while (count < SIT9531X_PRIO_MAX_SLOTS) {
		kept[count] = kept[count - 1];
		count++;
	}

So a table like [A,B,C,C,C,C,C,C,C,C,C] is a normal state.  If userspace now
asks to move C to slot 6, sit9531x_input_prio_set() picks the first match:

	for (from = 0; from < SIT9531X_PRIO_MAX_SLOTS; from++)
		if (srcs[from] == input_idx)
			break;
	...
		for (slot = from; slot < prio; slot++)
			srcs[slot] = srcs[slot + 1];

	srcs[prio] = input_idx;

from is 2, and the shift copies C over C, so the committed array is identical
to what the chip already holds.  sit9531x_prio_table_commit() still forces the
PLL into holdover:

	rc = sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,
				    BIT(SIT9531X_PLL_HO_FORCE_BIT),
				    BIT(SIT9531X_PLL_HO_FORCE_BIT));
	...
	usleep_range(10000, 12000);

rewrites the same nibbles, releases holdover and returns 0.  The effective
priority stays 2 because the device picks the lowest occupied slot, so a set
followed by a get disagree, and the PLL took a holdover excursion for a write
that changed nothing.

[Severity: Medium]
Should the other affected pins get a change notification here?

sit9531x_input_prio_set() shifts every entry between the old and the new slot:

	if (from > prio) {
		/* Moving up: push the entries in between down one slot. */
		for (slot = from; slot > prio; slot--)
			srcs[slot] = srcs[slot - 1];
	} else {
		for (slot = from; slot < prio; slot++)
			srcs[slot] = srcs[slot + 1];
	}

The slot number is what .prio_get reports as DPLL_A_PIN_PRIO, so several other
pins change priority as a side effect of one request.

The core only notifies the pin named in the request, in dpll_pin_prio_set():

	__dpll_pin_change_ntf(pin);

and the driver's periodic sit9531x_dpll_changes_check() only compares the
result of state_on_dpll_get() against pin->pin_state, never priority.  Does a
userspace cache of the other pins' priorities then stay stale indefinitely
with no DPLL_CMD_PIN_CHANGE_NTF?

> +
> +	if (rc == -EINVAL) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Pin is not a reference of this DPLL; connect it first");
> +		return rc;
> +	}
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "Failed to set input priority");
> +		return rc;
> +	}
> +
> +	dpin->prio = (u8)prio;
> +
> +	return 0;
> +}
> +
>  static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	.direction_get		= sit9531x_dpll_input_pin_direction_get,
>  	.state_on_dpll_get	= sit9531x_dpll_input_pin_state_on_dpll_get,
>  	.state_on_dpll_set	= sit9531x_dpll_input_pin_state_on_dpll_set,
> +	.prio_get		= sit9531x_dpll_input_pin_prio_get,
> +	.prio_set		= sit9531x_dpll_input_pin_prio_set,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
