Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327B5437C9;
	Tue,  8 Sep 2026 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871517; cv=none; b=H4UmEw2yXfoEpObfVqjk2CyKqon+UIjsFdBfKv2zU8Zri90niyTRGDlCzsbycBztwLxK9wJl4zgK2CydHrZ/0nSSVibrRQ9zygVud+9UD1CbdFqJOnV249SaTlOjbBMFX49H5gJiqNTXJdHLFAu09f6yh7wPiSYIAUvfIt4fAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871517; c=relaxed/simple;
	bh=MUJae5y5sYgSHnNuIwh8epBBrBt5woS43J900oX47mA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4dazMgw1+6UNH7U6PBgYCEXbNySpwapWqEjUL+HGVOWUr1nHddS0OIJ7ttyNPsVkaek4K4k6lWONXqxCHap4n2PFf4idg8Zuv59/nGht0kNxWyhNz9h5JqbBj9qv3LlDjDO3e2/0a8NMPV1wqTLZe+3m5QsGGSN5BBgXcqTmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo6yWpmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo6yWpmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E891F00A3D;
	Tue,  8 Sep 2026 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871515;
	bh=W8+HlFqKsqoklxq3X/7PivX7X245lowuKXuqs8lTV3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Eo6yWpmIkn+LRkykDK/BqZZkc2vf43Yqb7cDEmnbEy2+1HeKFNrvehcHKeexkTDST
	 n9lR1HjjUlvRWVPSrxPLTcmYFjf5Jci5fEoWe4wzm90oFIfRQ0+K6LWqjT7eH1MM4y
	 kyp7b47+/UIJgiV9ygV+X3iwTBsP3F/FyE3RUPMQyUwRXRRKbrcDv8592BUclcpjLT
	 XEqIoutsiN/tiT8EvlfOEq6ppPCG9dZxanlFxstbNZewPc6mj7nedAxkDGoX49MgEc
	 ljf+p8xuwW8hmEhImS/61Zl3CWf4mlnoPDGE+3D3am6s0jv4EBbm8PufVwTXBA1jFY
	 rty2DJmPGYpNQ==
Subject:
 Re: [PATCH net-next v8 05/15] dpll: sit9531x: register DPLL devices and pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:14 +0000
Message-ID: <178887151400.219967.903139931205963081@kernel.org>
In-Reply-To: <20260902214030.20955-6-arouhi@sitime.com>
References: <20260902214030.20955-6-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 6 · Low: 2

- [High] At this commit every pin ops table except the XO one is rejected
  by the DPLL core: `sit9531x_dpll_input_pin_ops` and…
- [High] Blind overwrite in priority table causes tracking mismatch and
  input receiver power leak.
- [Medium] The binding
  Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml (added…
- [Medium] The commit message enumerates the registered pins as "the
  inputs, the crystal, and the outputs the loaded configuration routes…
- [Medium] sit9531x_derive_clock_id() (drivers/dpll/sit9531x/core.c)
  builds the DPLL clock_id from only the SiTime OUI, the variant id and…
- [Medium] sit9531x_irq_thread_fn() (drivers/dpll/sit9531x/core.c) acks a
  fixed set of eight W1C notification registers via…
- [Medium] The driver installs a self-requeuing 2 Hz kthread-worker
  poller (sit9531x_dev_periodic_work(), SIT9531X_STATUS_POLL_MS = 500)…
- [Medium] sit9531x_input_mode_fetch() (drivers/dpll/sit9531x/core.c)
  collapses the two independent CLKINx_INPUT_MODE enable bits into one…
- [Low] drivers/dpll/sit9531x/dpll.c carries a "Pin-state contract"
  comment specifying a get/set state machine over "the five pin ops…
- [Low] sit9531x_dpll_mode_set() (drivers/dpll/sit9531x/dpll.c) clears
  SIT9531X_PLL_STATUS_OUTER_DIS in PLL page reg 0x31 and then issues the…

--

dpll: sit9531x: register DPLL devices and pins

This patch registers the four on-chip PLLs as DPLL devices, registers the
inputs, the crystal and the routed outputs as pins, and adds a 2 Hz
kthread-worker poller (plus an optional INTRB threaded IRQ) that caches
the chip state the lock-status, mode and direction callbacks answer from.

A few questions below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index f355b08aebca..1394ea1077d9 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -153,76 +167,1487 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +static int sit9531x_input_mode_fetch(struct sit9531x_dev *sitdev, u8 pair)
> +{
> +	enum sit9531x_signal_mode sig_mode;
> +	u8 mode;
> +	int rc;
> +
> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_IN_MODE(pair), &mode);
>  	if (rc)
> -		return dev_err_probe(sitdev->dev, rc,
> -				     "Failed to initialize mutex\n");
> +		return rc;
> +
> +	if (mode & (SIT9531X_IN_MODE_SE_P_EN | SIT9531X_IN_MODE_SE_N_EN))
> +		sig_mode = SIT9531X_MODE_SE;
> +	else
> +		sig_mode = SIT9531X_MODE_DE;
> +
> +	sitdev->ref[pair * 2].sig_mode = sig_mode;
> +	sitdev->ref[pair * 2 + 1].sig_mode = sig_mode;

[Severity: Medium]
The register carries two independent bits, SE_P_EN and SE_N_EN, but this
folds them into one pair-wide value and writes it to both lanes.  What
happens on a profile that enables only one of the two single-ended lanes?

sit9531x_input_pin_is_registrable() only rejects the N lane of a
differential pair:

	if (sit9531x_input_is_n(index) &&
	    sitdev->ref[index].sig_mode == SIT9531X_MODE_DE)
		return false;

	return true;

so with a single SE_P_EN set, the N lane is classified SE too and gets its
own DPLL pin.  sit9531x_ref_state_fetch() then derives ref->enabled purely
from the force/state override:

	ref->enabled = !((force & BIT(pair)) && !(state & BIT(pair)));

and reports that lane as enabled.  Does this publish a pin for a lane whose
receiver the loaded configuration never enabled, which the later prio/state
setters can then add to a PLL's priority table?

[ ... ]

> +	/*
> +	 * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps
> +	 * (0x27/0x28) do not unambiguously express output->PLL routing on
> +	 * every config (overlaps, and some outputs routed outside that
> +	 * path).  When the board supplies an explicit map, trust it.
> +	 */
> +	if (sitdev->out_pll_map_valid) {
> +		u8 m = sitdev->out_pll_map[index];
> +
> +		if (m < SIT9531X_NUM_PLLS) {
> +			out->pll_idx = m;
> +			out->routed = true;
> +			out->enabled = !muted;
> +		} else {
> +			out->pll_idx = 0;
> +			out->routed = false;
> +			out->enabled = false;
> +		}
> +		return 0;
> +	}

[Severity: Medium]
Can this branch ever run at this commit?  Nothing in the driver reads
"sitime,output-pll-map" or "sitime,pll-fvco" yet - prop.c parses only reg,
label, connection-type, esync-control, supported-frequencies-hz and
dpll-types - and sitdev is zero-allocated, so out_pll_map_valid stays
false.

The binding added earlier in this series already documents both
properties, including:

  sitime,output-pll-map:
    ...
    The value 255 (0xff) marks an output as unmapped and prevents the
    driver from registering it as a DPLL pin.

so a board written against the merged binding is silently ignored here and
falls back to the OUT_MAP bitmaps that the comment above says cannot
unambiguously express the routing.  SIT9531X_OUT_PLL_UNMAPPED and
intsync_src are likewise unused at this point.

The last patch of the series adds sit9531x_parse_board_config() with the
device_property_read_*() calls for both properties, so the gap closes
inside the series; would it be better to keep the binding and these fields
in the same patch as the parser?

[ ... ]

> +	/* Run twice a second */
> +	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,
> +				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));
> +}

[Severity: Medium]
What stops this tick when the parent I2C adapter suspends?

sit9531x_i2c_driver sets only .name, .of_match_table and .probe, so there
are no dev_pm_ops, and kthread workers are not freezable.  The 500 ms tick
re-arms itself unconditionally here, and sitdev->irq is never disabled, so
paged I2C traffic keeps being issued across suspend.  i2c_transfer() fails
those transfers:

drivers/i2c/i2c-core-base.c:i2c_transfer() {
	...
	ret = __i2c_check_suspended(adap);
	if (ret)
		return ret;
	...
}

Can a tick that lands mid-suspend tear a paged sequence between the
page-selector write and the register access, leaving the cached lock
status, LOS/OOF and routing state out of step with the chip?  The driver
still has no .pm member at the end of the series.

> +static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)
> +{
> +	struct sit9531x_dev *sitdev = data;
> +	int rc;
> +
> +	/*
> +	 * Acknowledge the chip's notification latches from the threaded
> +	 * handler itself.  With IRQF_ONESHOT the line is unmasked on
> +	 * return, so deferring the W1C clear to the async kworker would
> +	 * let a still-asserted INTRB re-fire immediately (interrupt storm).
> +	 * Clear here, then kick the poll worker to read state and run
> +	 * changes_check.
> +	 */
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_clear_notifications(sitdev);
> +	mutex_unlock(&sitdev->multiop_lock);
> +	if (rc)
> +		dev_warn_ratelimited(sitdev->dev,
> +				     "IRQ: failed to clear notifications: %d\n",
> +				     rc);
> +
> +	kthread_mod_delayed_work(sitdev->kworker, &sitdev->work, 0);
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
When the acknowledge write itself fails, this still returns IRQ_HANDLED.
With IRQF_ONESHOT and a NULL primary handler the line is unmasked on
return, so a persistently failing I2C ack leaves INTRB asserted and the
threaded handler re-enters back to back, each pass taking multiop_lock and
issuing eight I2C writes plus a worker kick.  genirq's spurious detector
never engages because the return value says handled.

The same shape applies if the asserting latch is outside the acked set:
sit9531x_clear_notifications() covers page 0 regs 0x07/0x0B/0x93/0x9E and
page 6 regs 0x03/0x07/0x93/0x97, but not the sticky EEPROM notify byte at
page 0 reg 0x97 that sit9531x_eeprom_state_report() reads and never
clears.  Is the driver relying on an interrupt-enable/mask state it never
programs before devm_request_threaded_irq()?

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_EEPROM_NOTIF, &notif);
> +	if (rc)
> +		return;
> +
> +	/*
> +	 * A clean load leaves the read-done bit set and every defect bit
> +	 * clear.  A zero calculated CRC means nothing was read at all.
> +	 */
> +	if (rec_crc != cal_crc || !cal_crc)
> +		dev_warn(sitdev->dev,
> +			 "EEPROM CRC mismatch: stored %08x, computed %08x\n",
> +			 rec_crc, cal_crc);

[Severity: Medium]
The comment a few lines above this function says boards in this family may
have their configuration pushed over I2C rather than held in an EEPROM,
and that "there the CRC pair means nothing".  On such a board both
registers read 0, so the !cal_crc test fires on every probe and logs:

  EEPROM CRC mismatch: stored 00000000, computed 00000000

Should the zero-CRC case be treated as "no EEPROM" instead of a warning?
This probe-time reporting is also not mentioned in the changelog.

[ ... ]

> +static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll,
> +					     enum dpll_pin_direction dir,
> +					     u8 index)
> +{
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
> +	if (dir == DPLL_PIN_DIRECTION_INPUT) {
> +		/* The internal INTSYNC and XO pins are always registrable */
> +		if (index == SIT9531X_INTSYNC_PIN_ID ||
> +		    index == SIT9531X_MAX_INPUTS)
> +			return true;
> +
> +		return sit9531x_input_pin_is_registrable(sitdev, index);
> +	}
> +
> +	/* The internal INTSYNC source pin is always registrable */
> +	if (index == SIT9531X_INTSYNC_OUT_PIN_ID)
> +		return true;

[Severity: Medium]
The changelog describes the registered pins as "the inputs, the crystal,
and the outputs the loaded configuration routes to a PLL" and adds "An
output routed to no PLL gets no pin".

Two more pins are registered here on all four DPLLs: the INTSYNC
destination input (SIT9531X_INTSYNC_PIN_ID) and the INTSYNC source output
(SIT9531X_INTSYNC_OUT_PIN_ID), both before any routing test.  The INTSYNC
source is an output with no PLL routing at all, and prop.c gives both
labels and DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE.  Could the changelog
mention these two pins, since they are visible over netlink?

[ ... ]

> +static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
> +{
> +	u64 clkid;
> +
> +	clkid  = SIT9531X_OUI << 24;
> +	clkid |= (u64)sitdev->info->id << 8;
> +	clkid |= (u64)sitdev->client->addr;
> +
> +	return clkid;
> +}

[Severity: Medium]
This identifier is built from the OUI, the variant id and the 7-bit I2C
address only, with nothing identifying the adapter.  Do two same-variant
parts at the same address on different I2C busses (or behind a mux) end up
sharing a clock_id?

The core reuses existing objects on a match:

drivers/dpll/dpll_core.c:dpll_device_get() {
	...
	if (dpll->clock_id == clock_id &&
	    dpll->device_idx == device_idx &&
	    dpll->module == module) {
		__dpll_device_hold(dpll, tracker);
	...
}

and dpll_pin_get() matches on (clock_id, pin_idx, module) in the same way,
so the second chip's four DPLLs and its pins would be folded onto the
first chip's, with the first chip's priv serving netlink requests for
both.  sit9531x_derive_clock_id() is unchanged at the end of the series.

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 230b21b9e238..d4159c7ddaf5 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h

[ ... ]

> @@ -107,11 +178,107 @@ struct sit9531x_dev {

[ ... ]

> +/* ---- Input priority ---- */
> +int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 prio);
> +int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 *prio);
> +int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       u8 input_idx);
> +int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx);

[Severity: High]
The comment above sit9531x_ref_pll_mask_fetch() in this patch states
the invariant this layer rests on: an input is counted for a PLL
exactly when it appears in that PLL's Page-1 priority table, and that
is "exactly the condition the connect and disconnect callbacks
maintain".  sit9531x_input_prio_add(), declared here and defined in
core.c, does not hold up its end of that.

After failing to find the source already in the table it writes it
into srcs[SIT9531X_PRIO_MAX_SLOTS - 1] unconditionally and commits,
without looking at what that slot held.  When the table already
carries eleven distinct sources, the source sitting in slot 10 is
silently ejected from the hardware table while its
sitdev->ref[].pll_mask bit for this PLL stays set, since only the
DISCONNECTED arm of sit9531x_dpll_input_pin_state_on_dpll_set() ever
clears it.

Two things then drift apart.  The refcount that decides when the
shared receiver may be powered down no longer matches the table, so
the ejected input's receiver can never reach a zero mask and stays
powered for the lifetime of the device even after every DPLL has
released it.  And the state getter, which by the contract comment in
dpll.c derives membership M from the hardware priority table, starts
reporting DISCONNECTED for a pin the driver still believes this DPLL
claims - a reference userspace asked for and was told it got, removed
by an unrelated later request with no error returned to either
caller.

The reachable path is a plain sequence of netlink pin-state writes:
eleven distinct sources set to DPLL_PIN_STATE_SELECTABLE on one DPLL,
then a twelfth.

What should the twelfth request do?  Returning -ENOSPC and leaving
the table alone looks like the honest answer, and it keeps pll_mask
and the table in step by construction.  If displacing an entry is
really wanted, then the displaced source's pll_mask bit has to be
dropped and its receiver released on the same path, and the pin whose
membership just changed needs a dpll_pin_change_ntf().  Which of the
two did you intend?

[Severity: Low]
This isn't a bug, but roughly fifteen functions declared in this hunk have
no definition anywhere in the module at this commit, among them
sit9531x_input_prio_set/get/add/remove, sit9531x_output_freq_set/get,
sit9531x_output_phase_adjust_set, sit9531x_intsync_enable/disable,
sit9531x_output_pulse_ctrl_set, sit9531x_pll_ffo_ppt and
sit9531x_phase_offset_read.

dpll.h also adds fields nothing reads yet (prio, phase_adjust,
phase_offset, esync_freq), and dpll.c adds SIT9531X_ESYNC_FREQ_10MHZ and
SIT9531X_ESYNC_PULSE_DEFAULT unused.  They all gain definitions and users
in later patches of the series; could the declarations move to the patches
that define them?

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> new file mode 100644
> index 000000000000..821370ddeab0
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -0,0 +1,417 @@

[ ... ]

> +	/* Trigger small update to apply without full NVM cycle */
> +	rc = sit9531x_write_pll_u8(sitdev, sitdpll->id,
> +				   SIT9531X_PLL_REG_SMALL_UPDATE,
> +				   SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "Failed to trigger small update");
> +		goto unlock;
> +	}

[Severity: Low]
If the small-update write fails here, the OUTER_DIS bit cleared by the
preceding sit9531x_update_pll_u8() is neither committed nor restored.
Reg 0x31 then reads "outer loop enabled" while the loop is still
free-running, and the next poll picks that up:

sit9531x_chan_state_fetch() {
	...
	chan->mode = !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);
	...
}

after which sit9531x_dpll_lock_status_get() takes its chan->mode == 0
branch and reports LOCKED or UNLOCKED from an outer loss-of-lock bit that
means nothing for a disabled outer loop.  Should this path put the bit
back?

[ ... ]

> +static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
> +	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	/*
> +	 * The measurement compares the PLL's running feedback divider with
> +	 * its configured one, so it describes the device's own reference
> +	 * rather than a port rate.
> +	 */
> +	.supported_ffo		= BIT(DPLL_FFO_PIN_DEVICE),
> +};

[Severity: High]
Does probe succeed with this table?  It has no .state_on_dpll_get, and it
sets .supported_ffo without an .ffo_get, both of which the core rejects:

drivers/dpll/dpll_core.c:dpll_pin_register() {
	...
	if (WARN_ON(!ops) ||
	    WARN_ON(!ops->state_on_dpll_get) ||
	    WARN_ON(!ops->direction_get) ||
	    WARN_ON(ops->supported_ffo && !ops->ffo_get) || ...)
		return -EINVAL;
	...
}

sit9531x_dpll_output_pin_ops below has the same gap for
.state_on_dpll_get, so only the XO table passes.  The first registrable
pin is logical input 0, so the chain

  sit9531x_dev_probe() -> sit9531x_devm_dpll_init() ->
  sit9531x_dev_start() -> sit9531x_dpll_register() ->
  sit9531x_dpll_pins_register() -> sit9531x_dpll_pin_register() ->
  dpll_pin_register()

returns -EINVAL with a WARN backtrace, sit9531x_dev_start() takes its
err_unregister path and probe fails on every board (a panic with
panic_on_warn set).

The later patches in this series ("implement input pin state on a DPLL",
"implement output pin state on a DPLL", "model the inter-PLL sync net as a
pair of pins" and "add support to get fractional frequency offset") fill
in .state_on_dpll_get for all five tables and add .ffo_get, so the final
tree is fine; the intermediate commits are what fail to probe.  Could the
callbacks land in the same patch that registers the pins?

[ ... ]

> +		ops = sit9531x_dpll_pin_ops_get(pin);
> +		rc = ops->state_on_dpll_get(pin->dpll_pin, pin,
> +					    sitdpll->dpll_dev, sitdpll,
> +					    &state, NULL);

[Severity: High]
Same missing callback here: state_on_dpll_get is an optional pin op, and
sit9531x_dpll_pin_ops_get() returns sit9531x_dpll_input_pin_ops for every
non-XO input pin, where the member is NULL.  The XO pin is the only one
skipped by the test above it, so would this call dereference NULL if a pin
ever reached this loop?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
