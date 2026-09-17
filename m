Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FF59D611;
	Thu, 17 Sep 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657333; cv=none; b=ufemPTb2gF9FQ2tcumaDHfi6C0Ug5/E1hYFVeyduwzxyDE5L9GkFgpcZL0jpiETnjEjTSBK6D8OlrSlP/p/PWf1u+CNhYH2uCNx9tGgP70TxhkUbZPxsDHosTtN1Riv+Tk1RHdtkt2dSx99UZUk5CUCqMeT5cPbVV4ZEC2Jr8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657333; c=relaxed/simple;
	bh=ChNHbrcGA4RYIezDkiMahFVx1TtlpKVLPLSuaIqM7wI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqAqEALkUB6RL2B2bxahBLZFTavzFsBiAPtDa8Iwy/auKv89ZW915BgxboE4XK9j4WHDUk9Pj3CU04L7Ex+cKY73kHm2m4diD+tjiM9sK+ABdequFeGqmcmPtxE2EuyE1w9ty/XM+jsA1T0O19npwnK8X9/HC2eR8ekh4Kl8EqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ44bOWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ44bOWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FAA1F0089A;
	Thu, 17 Sep 2026 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657307;
	bh=L0lTsz3jV48Pg+7s5ZVkqvhTPtRtfdILq80x9N623bw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SZ44bOWcL9Ma13W2bT++UARvb66LJs2njv75BhrTLW7tlkSwnurZtvFKRL+Z0aIeC
	 HAt2tbAm3E/ILnsZsk6PqHRjIgA9+XsqzuUYcVGjTUpAxsj9uAmLtYBUuYeF/TS2vI
	 HcjXnPYG338oz5tODy7yfeHZtuMnUTvj8Q3D4W959dusJxSud7O4gYm4MpGC8xoWVb
	 rvdFtZGdgmOiGcYPWVDJmFPIHIsXrBYs0ufXk6ad9m6+205w2x6YuxWX3uRw6W/gMk
	 CQGI9lb1ohPYsCQNpUsfxaF2ufAkg1Z3o4MwDH2bretayIrrQ8LCi+yS2X/6zxaH2W
	 VZVo3Kr57uryA==
Subject:
 Re: [PATCH net-next v9 05/15] dpll: sit9531x: register DPLL devices and pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:46 +0000
Message-ID: <178965730656.22033.15511357462595143548@kernel.org>
In-Reply-To: <20260915000015.80480-6-arouhi@sitime.com>
References: <20260915000015.80480-6-arouhi@sitime.com>
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

- [Medium] Commit message claims pins are registered that the code cannot
  register.
- [Medium] sit9531x_dpll_mode_set() can never be invoked through the DPLL
  netlink API, so the hardware transition it implements (clearing PLL…
- [Medium] Changes to the exported lock-status error are never notified.
- [Medium] sit9531x_irq_thread_fn() returns IRQ_NONE when the I2C write
  that acknowledges the chip's write-1-to-clear notification latches…
- [Low] core.h declares 16 driver-internal functions that no translation
  unit defines at this commit (sit9531x_input_disable/enable,…
- [Low] The in-tree binding
  Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml documents…
- [Low] The commit message states the kthread worker "polls the
  interesting registers twice a second into a per-input, per-output and…
- [Low] The rewritten descriptive comments for struct sit9531x_dev and
  struct sit9531x_out drop entries for fields that still exist and omit…

--

dpll: sit9531x: register DPLL devices and pins

This adds a DPLL registration layer to the SiT9531x driver: each of the
four on-chip PLLs becomes a DPLL device, a kthread worker polls status
registers twice a second into a cache that the callbacks answer from, and
an optional INTRB interrupt kicks that same tick.  A clock_id is derived
from the variant, the I2C adapter number and the client address.

A few questions below, mostly about the changelog and about paths that
cannot be reached at this commit.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index b0920f76362a1..6dfb1b31d4913 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -145,122 +159,1597 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	return regmap_update_bits(sitdev->regmap, reg, mask, val);
>  }
>  

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

[Severity: Low]
Is out_pll_map_valid ever true at this commit?  Nothing in
drivers/dpll/sit9531x/ reads "sitime,output-pll-map" or "sitime,pll-fvco"
yet, so this branch is dead code and pll_fvco[] stays zero.

A board written to the properties documented in
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml is therefore
ignored, while struct sit9531x_dev describes both fields as coming from DT.

The parser does land later in the series, in the patch that lets the device
tree override the two board facts, so this looks like the consumer and the
SIT9531X_OUT_PLL_UNMAPPED define arriving one patch ahead of their producer.

[ ... ]

> +static void sit9531x_dev_periodic_work(struct kthread_work *work)
> +{
> +	struct sit9531x_dev *sitdev = container_of(work, struct sit9531x_dev,
> +						   work.work);
> +	struct sit9531x_dpll *sitdpll;
> +	int rc;
> +

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	sit9531x_dev_ref_states_update(sitdev);
> +	sit9531x_dev_chan_states_update(sitdev);
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	list_for_each_entry(sitdpll, &sitdev->dplls, list)
> +		sit9531x_dpll_changes_check(sitdpll);

[Severity: Low]
The changelog says the worker "polls the interesting registers twice a
second into a per-input, per-output and per-PLL cache".  Where does the
per-output part happen?

sit9531x_dev_periodic_work() calls only sit9531x_dev_ref_states_update()
and sit9531x_dev_chan_states_update().  out[] is filled once by
sit9531x_dev_state_fetch() during probe and never refreshed, so
out->enabled, out->cmos and out->routed keep their probe-time values.

By the end of the series this looks intentional -- the output pin state
getter reads through on a state_stale flag, with a comment saying there is
no poll of output state to correct it -- so perhaps only the changelog
sentence needs adjusting.

[ ... ]

> +static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)
> +{
> +	struct sit9531x_dev *sitdev = data;
> +	int rc;
> +

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_clear_notifications(sitdev);
> +	mutex_unlock(&sitdev->multiop_lock);
> +	if (rc) {
> +		dev_warn_ratelimited(sitdev->dev,
> +				     "IRQ: failed to clear notifications: %d\n",
> +				     rc);
> +		/*
> +		 * The latch was not acknowledged, so with IRQF_ONESHOT the
> +		 * still-asserted line would re-enter this handler back to
> +		 * back forever.  Report the interrupt as unhandled so the
> +		 * spurious-IRQ detector can engage if the bus stays broken.
> +		 */
> +		return IRQ_NONE;
> +	}

[Severity: Medium]
Can this loop without bound?  With a level-triggered INTRB and IRQF_ONESHOT
the line is unmasked when the threaded handler returns, whatever it returns.

If sit9531x_clear_notifications() keeps failing (bus NAK, arbitration loss,
adapter error) the write-1-to-clear latch stays set, INTRB stays asserted,
and sit9531x_irq_thread_fn() is re-entered back to back.  Each pass takes
sitdev->multiop_lock and issues failing paged I2C transfers from a
SCHED_FIFO thread, contending the lock with the poll worker and with every
netlink callback.

The comment names the spurious-IRQ detector as the bound, but
note_interrupt() only disables a line after roughly 100000 interrupts with
nearly all of them unhandled, and it resets irqs_unhandled once more than
HZ/10 has passed since the last unhandled one.  With multi-millisecond I2C
timeouts per pass, is that threshold reachable?

Would disable_irq_nosync() on this path, or masking the interrupt at the
device, be a firmer stop?  The code is unchanged at the end of the series.

[ ... ]

> +static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll,
> +					     enum dpll_pin_direction dir,
> +					     u8 index)
> +{
> +	/*
> +	 * Only the XO pin has a complete pin-op table in this patch.
> +	 * Other pin classes are registered once their state callbacks
> +	 * land in the following patches.
> +	 */
> +	if (dir != DPLL_PIN_DIRECTION_INPUT)
> +		return false;
> +
> +	return index == SIT9531X_MAX_INPUTS;
> +}

[Severity: Medium]
The changelog opens with:

  "Register each of the four on-chip PLLs as a DPLL device and the clocks
   around them as pins: the inputs, the crystal, and the outputs the loaded
   configuration routes to a PLL."

Does that match this filter?  Every output returns false, and for inputs
only index == SIT9531X_MAX_INPUTS is accepted, i.e. the crystal pin alone,
so userspace sees four DPLL devices each carrying exactly one pin.

The two new ops tables in dpll.c supply only .direction_get:

	static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
		.direction_get		= sit9531x_dpll_input_pin_direction_get,
	};

and dpll_pin_register() in drivers/dpll/dpll_core.c refuses a table without
a state getter:

	if (WARN_ON(!ops) ||
	    WARN_ON(!ops->state_on_dpll_get) ||
	    WARN_ON(!ops->direction_get) ...
		return -EINVAL;

so the input and output pins the paragraph describes could not be registered
even if the filter allowed them.

sit9531x_dpll_register()'s own comment says it registers "all input and
output pins that are connected to this PLL", and sit9531x_dpll_changes_check()
skips the one pin class that is registered, so no pin-change notification
can fire here either.  Could the first paragraph say that only the crystal
pin is registered at this step?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 230b21b9e2381..5ead3811e14b4 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h

[ ... ]

> @@ -64,37 +77,97 @@ enum sit9531x_signal_mode {

[ ... ]

>  /*
>   * struct sit9531x_out - output state
> - * @freq:		configured frequency in Hz
> + * @enabled:		output is driving, i.e. not forced into Hi-Z
> + * @cmos:		output is wired single-ended; the Hi-Z pair that
> + *			speaks for it is the SE one, not the differential
> + * @routed:		output is mapped to @pll_idx by the initial
> + *			configuration; an unrouted output has no DPLL pin
> + * @pll_idx:		PLL driving this output (0-3)
>   * @label:		board label from DT or default
>   */
>  struct sit9531x_out {
> -	u32		freq;
> +	u64		freq;
> +	bool		enabled;
> +	bool		cmos;
> +	bool		routed;
> +	u8		pll_idx;
>  	const char	*label;
>  };

[ ... ]

>  /*
>   * struct sit9531x_dev - SiT9531x device instance
> - * @dev:		parent device
> - * @client:		I2C client
> - * @regmap:		paged register map
>   * @info:		detected chip variant info
> - * @multiop_lock:	serializes multi-register sequences
> + * @multiop_lock:	mutex for multi-register atomic operations
>   * @ref:		array of input reference states
>   * @out:		array of output states
> + * @chan:		array of per-PLL channel states
>   * @xtal_freq:		crystal oscillator frequency in Hz

[Severity: Low]
These rewritten comment blocks drop entries for members that are still
present, and miss a new one.

struct sit9531x_dev loses @dev, @client and @regmap while all three members
remain, and the newly added "struct list_head dplls;" is not documented.
struct sit9531x_out loses @freq while the (widened to u64) freq member
remains.

Both blocks open with "/*" rather than "/**", so kernel-doc will not report
this, and the drift is still there at the end of the series.

> @@ -107,11 +180,107 @@ struct sit9531x_dev {

[ ... ]

> +/* ---- Input enable/disable ---- */
> +int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);
> +int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);
> +
> +/* ---- Input priority ---- */
> +int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 prio);

[ ... ]

> +/* ---- Phase offset (TDC readback) ---- */
> +int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo);
> +int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       s64 *phase_ps);

[Severity: Low]
Sixteen of the prototypes added here have no definition in the tree at this
commit: sit9531x_input_disable/enable, the four prio helpers,
sit9531x_output_disable/enable, sit9531x_output_freq_set/get,
sit9531x_output_phase_adjust_set, sit9531x_intsync_enable/disable,
sit9531x_output_pulse_ctrl_set, sit9531x_pll_ffo_ppt and
sit9531x_phase_offset_read.

core.c also refers to them: sit9531x_output_forced_hiz()'s comment says
"mirroring what sit9531x_output_disable() programs", and
sit9531x_ref_state_fetch() says "until something called
sit9531x_input_enable()".

All of them are defined by the end of the series, so nothing fails to link;
would declaring each in the patch that defines it be tidier?

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> new file mode 100644
> index 0000000000000..b4984335e6bfc
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -0,0 +1,444 @@

[ ... ]

> +static int
> +sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
> +		       enum dpll_mode *mode, struct netlink_ext_ack *extack)
> +{
> +	*mode = DPLL_MODE_AUTOMATIC;
> +
> +	return 0;
> +}

[Severity: Medium]
Can sit9531x_dpll_mode_set() ever be reached?  mode_get always reports
AUTOMATIC, whatever the cached chan->mode free-run state says, and
dpll_mode_set() in drivers/dpll/dpll_netlink.c does:

	ret = ops->mode_get(...);
	...
	if (mode == old_mode)
		return 0;

so an AUTOMATIC request returns before ops->mode_set, and every other value
is rejected with -EINVAL because supported_modes_get() advertises only
AUTOMATIC.

That leaves the clearing of PLL page reg 0x31[5], and its careful
restore-on-latch-failure path, unreachable, so a PLL left free-running by
the loaded configuration or by the vendor tool cannot be put back into
priority-based selection through the only interface the driver exposes.
mode_get is unchanged at the end of the series -- should it report the
free-run state so the setter becomes reachable?

[ ... ]

> +void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)
> +{
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	enum dpll_lock_status lock_status;
> +	struct sit9531x_dpll_pin *pin;
> +	int rc;
> +
> +	rc = sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,
> +					   &lock_status, NULL, NULL);
> +	if (rc) {
> +		dev_err(sitdev->dev, "Failed to get DPLL%u lock status: %d\n",
> +			sitdpll->id, rc);
> +		return;
> +	}
> +
> +	/* If lock status changed, notify DPLL core */
> +	if (sitdpll->lock_status != lock_status) {
> +		sitdpll->lock_status = lock_status;
> +		dpll_device_change_ntf(sitdpll->dpll_dev);
> +	}

[Severity: Medium]
This passes NULL for status_error and compares only the primary status
against sitdpll->lock_status.

chan->inner_lol is refreshed independently by sit9531x_chan_state_fetch(),
and sit9531x_dpll_lock_status_get() turns it into
DPLL_LOCK_STATUS_ERROR_UNDEFINED.  The core exports that value:

	if (status_error &&
	    (status == DPLL_LOCK_STATUS_UNLOCKED ||
	     status == DPLL_LOCK_STATUS_HOLDOVER) &&
	    nla_put_u32(msg, DPLL_A_LOCK_STATUS_ERROR, status_error))

So when inner loss of lock appears or clears while the primary status stays
UNLOCKED or HOLDOVER, what calls dpll_device_change_ntf()?  Subscribers
would keep the stale error until an unrelated status change or an explicit
GET.  This is unchanged at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
