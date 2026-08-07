Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782B342523;
	Fri,  7 Aug 2026 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088751; cv=none; b=JRvGTw0Bk4PP3tQFzr4QLJlAi6Reby0UztKs0C5aRZ2L8jLWQ6BMEnjkjlv5mZy8tcVskFpYSNte2492QZ5i3HqRPBeW1ym7FtfZXbnSHzVvboFMVfi5qErKNKd1stElD58hH3vxLKmlDMKnwehisQ/AxiUJfxk+i2XgnYpd9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088751; c=relaxed/simple;
	bh=Gxl1BZH5Exsx4eUL//tsb/OXoRSD1Yd4nqgAgcUJ93s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPcZXFgq87mjiALFvrq5HJ3B+Yd5ICx/gYOWvQU1VQKg0AFfMLOg5YyGEJF2ebZvTHYdG7hQVi9cWGKCmojHfcwoBK7rau2HW3RvSBM8hNmCDiKqwZC8CuwJVlGtoBK6FVDEsB1C4Q58YSNnhHXq/EUiIATlQPrEyHgT0KrQmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRubqS+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRubqS+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9F91F000E9;
	Fri,  7 Aug 2026 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786088749;
	bh=WzXYo+jFevyhCjMdFBNaEEElrXR7xJ2Klpd0GVgkVB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GRubqS+3bVkDh76RdNgOjCmMbdBkdBI/z/BK69ImrHmOwRK7vySXqhGt9l2Kuk2si
	 aj7z34BYfoKweAR49YVV92uEVcQ1/wlHGn5k+j2z1nYXYl9C7F/Pvk78Rj2AAqmw1N
	 eP7qLKw3cNSnuw6VKglMhV9F31FlVtx5t0Er19lWr7kjTGPdUELs1P59N0wMDwxz4T
	 Kg1Rg/AaH0byNrSUxq319c+fgoi2VSMkvdilAWHNX1e+4S1l+D6IaLASGYUYXWknDk
	 15uBh7gY2kds+1AyEwyH9JNoc/FnK3Q9xXfJOwZRolm/J0s6NI8URSVNukihFE126d
	 AaEzrZo97z/og==
Date: Fri, 7 Aug 2026 09:45:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"cjubran@nvidia.com" <cjubran@nvidia.com>, 
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Message-ID: <20260807-opalescent-raspberry-newt-4792ba@quoll>
References: <20260806232439.27551-1-arouhi@sitime.com>
 <20260806232439.27551-4-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806232439.27551-4-arouhi@sitime.com>

On Thu, Aug 06, 2026 at 11:24:44PM +0000, Ali Rouhi wrote:
> Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
> clock generators. These devices provide low-jitter clock outputs
> commonly used in telecom, networking, and data center timing
> applications.
> 
> The driver exposes all inputs and outputs through the Linux DPLL
> subsystem, supporting:
>  - Lock status monitoring via register polling or optional INTRB IRQ
>  - Input priority management for automatic reference switchover
>  - Per-output frequency readback from hardware state
>  - DCO (digitally controlled oscillator) frequency adjustment
>  - Phase offset measurement via TDC (time-to-digital converter)
>  - Phase adjustment for fine output alignment
>  - Embedded sync (esync) pulse control
>  - SYSREF/SYNCB/Pulser output mode control
>  - Optional reset-gpios for hardware reset
> 
> The driver reads all configuration from the device's on-chip NVM
> at probe time -- no firmware loading is required.
> 
> Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]

I can see that. Looks like a lot of AI slop coding style, not really
acceptable for mainline.

...

> +/*
> + * sit9531x_irq_thread_fn - threaded IRQ handler for the chip's INTRB line
> + *
> + * Triggered when the chip asserts INTRB (and only when DT wires up the
> + * client interrupt; absent property == handler never installed).  The
> + * action mirrors a periodic-work tick: queue an immediate run so status
> + * registers are read and DPLL changes_check fires without waiting for
> + * the next poll deadline.  Polling continues to run as a fallback.
> + */
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
> +
> +/* ====================================================================
> + * Device lifecycle -- start / stop / dpll_init / dpll_fini
> + * ====================================================================
> + */
> +
> +/**
> + * sit9531x_dev_start - start normal operation
> + * @sitdev:	device pointer
> + *
> + * Fetches initial hardware state, registers all DPLL devices and
> + * their pins, and starts the periodic monitoring thread.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int sit9531x_dev_start(struct sit9531x_dev *sitdev)
> +{
> +	struct sit9531x_dpll *sitdpll;
> +	int rc;
> +
> +	/* Fetch device state */
> +	rc = sit9531x_dev_state_fetch(sitdev);
> +	if (rc)
> +		return rc;
> +
> +	/* Register all DPLLs */
> +	list_for_each_entry(sitdpll, &sitdev->dplls, list) {
> +		rc = sit9531x_dpll_register(sitdpll);
> +		if (rc) {
> +			dev_err_probe(sitdev->dev, rc,
> +				      "Failed to register DPLL%u\n",
> +				      sitdpll->id);
> +			return rc;
> +		}
> +	}
> +
> +	/* Start monitoring */
> +	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);
> +
> +	return 0;
> +}
> +
> +/**
> + * sit9531x_dev_stop - stop normal operation
> + * @sitdev:	device pointer
> + *
> + * Cancels the monitoring thread and unregisters all DPLL devices
> + * and their pins.
> + */
> +void sit9531x_dev_stop(struct sit9531x_dev *sitdev)
> +{
> +	struct sit9531x_dpll *sitdpll;
> +
> +	/* Stop monitoring */
> +	kthread_cancel_delayed_work_sync(&sitdev->work);
> +
> +	/* Unregister all DPLLs */
> +	list_for_each_entry(sitdpll, &sitdev->dplls, list) {
> +		if (sitdpll->dpll_dev)
> +			sit9531x_dpll_unregister(sitdpll);
> +	}
> +}
> +
> +static void sit9531x_dev_dpll_fini(void *ptr)
> +{
> +	struct sit9531x_dpll *sitdpll, *next;
> +	struct sit9531x_dev *sitdev = ptr;
> +
> +	/* Stop monitoring and unregister DPLLs */
> +	sit9531x_dev_stop(sitdev);

sit9531x_dev_dpll_fini() this is called from sit9531x_devm_dpll_init()
before device was started. Very confusing code. I find this driver
difficult to read. It's over complicated, too many comments, multiple
helper functions, 10-steps of init from probe and then turns out that
this init is not even correct.

> +
> +	/* Destroy monitoring thread */
> +	if (sitdev->kworker) {

How is this possible? This is called from error path, so either this was
set or not. Why are you calling function with unknown state of your
driver?

> +		kthread_destroy_worker(sitdev->kworker);
> +		sitdev->kworker = NULL;
> +	}
> +
> +	/* Free all DPLLs */
> +	list_for_each_entry_safe(sitdpll, next, &sitdev->dplls, list) {
> +		list_del(&sitdpll->list);
> +		sit9531x_dpll_free(sitdpll);
> +	}
> +}
> +
> +/*
> + * sit9531x_devm_dpll_init - allocate DPLLs and start the device
> + * @sitdev:	device pointer
> + *
> + * Allocates one DPLL per PLL channel, creates the monitoring thread,
> + * starts normal operation, and registers a devres cleanup action.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int sit9531x_devm_dpll_init(struct sit9531x_dev *sitdev)
> +{
> +	struct kthread_worker *kworker;
> +	struct sit9531x_dpll *sitdpll;
> +	unsigned int i;
> +	int rc;
> +
> +	INIT_LIST_HEAD(&sitdev->dplls);
> +
> +	/*
> +	 * Initialize the monitoring work before anything that can fail into
> +	 * the error path: sit9531x_dev_dpll_fini() -> sit9531x_dev_stop()
> +	 * calls kthread_cancel_delayed_work_sync(&sitdev->work)
> +	 * unconditionally, which must not run on an uninitialized work.
> +	 */
> +	kthread_init_delayed_work(&sitdev->work, sit9531x_dev_periodic_work);
> +
> +	/* Allocate all DPLLs */
> +	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +		sitdpll = sit9531x_dpll_alloc(sitdev, i);
> +		if (IS_ERR(sitdpll)) {
> +			dev_err_probe(sitdev->dev, PTR_ERR(sitdpll),
> +				      "Failed to alloc DPLL%u\n", i);
> +			rc = PTR_ERR(sitdpll);

Syntax is rc = dev_err_probe()

> +			goto error;
> +		}
> +
> +		list_add_tail(&sitdpll->list, &sitdev->dplls);
> +	}
> +
> +	/* Start the monitoring thread worker */
> +	kworker = kthread_run_worker(0, "sit9531x-%s",
> +				     dev_name(sitdev->dev));
> +	if (IS_ERR(kworker)) {
> +		rc = PTR_ERR(kworker);
> +		goto error;
> +	}
> +	sitdev->kworker = kworker;
> +
> +	/* Start normal operation */
> +	rc = sit9531x_dev_start(sitdev);
> +	if (rc) {
> +		dev_err_probe(sitdev->dev, rc, "Failed to start device\n");
> +		goto error;
> +	}
> +
> +	/* Add devres action to release DPLL related resources */
> +	return devm_add_action_or_reset(sitdev->dev, sit9531x_dev_dpll_fini,
> +					sitdev);
> +
> +error:
> +	sit9531x_dev_dpll_fini(sitdev);
> +
> +	return rc;
> +}
> +
> +/* ====================================================================
> + * Chip identification
> + * ====================================================================
> + */
> +
> +/*
> + * sit9531x_read_variant_id - read chip variant ID byte from hardware
> + * @sitdev:	device pointer
> + * @id:		output variant ID byte
> + *
> + * Reads the single-byte variant identification register from Page 0
> + * reg 0x02 (95317 = 0x17, 95316 = 0x31).  Reg 0x03 holds a separate
> + * revision byte and is intentionally not consumed here.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)
> +{
> +	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);
> +}
> +
> +/*
> + * sit9531x_match_variant - match variant ID against known variants
> + * @id:	variant ID byte
> + *
> + * Return: pointer to chip_info on match, NULL on unknown ID
> + */
> +static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {
> +		if (sit9531x_chip_ids[i].id == id)
> +			return &sit9531x_chip_ids[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * sit9531x_derive_clock_id - build EUI-64 clock identifier
> + * @sitdev:	device pointer
> + *
> + * Generates a deterministic 64-bit identifier from the SiTime OUI,
> + * the chip ID, and the I2C address.  This provides a stable clock_id
> + * across reboots.
> + *
> + * Return: 64-bit clock identifier
> + */
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
> +
> +/* ====================================================================
> + * Probe entry point
> + * ====================================================================
> + */
> +
> +/**
> + * sit9531x_dev_probe - initialize SiT9531x device
> + * @sitdev:	pointer to device structure (caller-allocated)
> + *
> + * Common initialization: read chip ID, match variant, generate
> + * clock_id, initialize synchronization mutex, and register DPLL
> + * channels.  Called from the I2C probe function.
> + *
> + * Return: 0 on success, <0 on error

There is little point in describing standard functions. Redundant
comments are not helping.

> + */
> +int sit9531x_dev_probe(struct sit9531x_dev *sitdev)
> +{
> +	struct clk *xtal_clk;
> +	u8 variant_id;
> +	int rc;
> +
> +	/*
> +	 * Read the external reference (XO) feeding the chip's XIN/XO_CLK
> +	 * input.  Required: Fvco computation does
> +	 * Fvco = Fref * (DIVN + frac/2^32) with Fref = xtal_freq << doubler,
> +	 * so without a populated xtal_freq every freq_set/phase_adjust path
> +	 * dividing by Fvco fails with -EIO.  The rate normally comes from a
> +	 * "clocks" phandle (clock-names = "xtal").  As a fallback, when the
> +	 * firmware does not yet expose the XO through the clock framework,
> +	 * take the rate from a "clock-frequency" device property instead.
> +	 */
> +	xtal_clk = devm_clk_get_optional_enabled(sitdev->dev, "xtal");
> +	if (IS_ERR(xtal_clk))
> +		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),
> +				     "Failed to get xtal clock\n");
> +	sitdev->xtal_freq = xtal_clk ? clk_get_rate(xtal_clk) : 0;

The entire comparison is pointless.

> +	if (!sitdev->xtal_freq) {
> +		u32 freq;
> +
> +		if (!device_property_read_u32(sitdev->dev, "clock-frequency",
> +					      &freq))
> +			sitdev->xtal_freq = freq;
> +	}
> +	if (!sitdev->xtal_freq)
> +		return dev_err_probe(sitdev->dev, -EINVAL,
> +				     "no xtal rate: provide clocks=<&xo> + clock-names=\"xtal\", or a clock-frequency property\n");
> +	dev_info(sitdev->dev, "xtal_freq=%u Hz\n", sitdev->xtal_freq);

Drop, driver should be silent on success.

> +
> +	/*
> +	 * Optional DT-described reset line.  Requested in the deasserted
> +	 * state so any prior chip programming is not torn down by the
> +	 * request itself.  The driver deliberately never pulses reset at
> +	 * runtime: the chip configuration (filter coefficients, output
> +	 * routing, priority tables) is loaded from efuse or an NVM blob
> +	 * before probe, and a hardware reset would discard it.  The line
> +	 * is held deasserted only to guarantee the chip is out of reset
> +	 * for I2C.  Absent DT property == descriptor stays NULL, no
> +	 * behaviour change.
> +	 *
> +	 * Must run before the first I2C access: if the board wires reset
> +	 * and starts with the line asserted, the chip is held in reset and
> +	 * variant-ID reads return -EIO/-ETIMEDOUT.
> +	 */
> +	sitdev->reset_gpio = devm_gpiod_get_optional(sitdev->dev, "reset",
> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(sitdev->reset_gpio))
> +		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),
> +				     "Failed to request reset gpio\n");
> +	if (sitdev->reset_gpio) {
> +		dev_info(sitdev->dev, "reset-gpios: present (held deasserted)\n");

Drop

> +		/*
> +		 * If the board powered up with RESETB asserted, requesting
> +		 * the line deasserted above just released the chip.  Wait for
> +		 * its internal boot to complete before the first I2C access so
> +		 * sit9531x_read_variant_id() below does not race chip
> +		 * readiness and return -EIO/-ETIMEDOUT.
> +		 */
> +		fsleep(10000);
> +	}
> +
> +	/*
> +	 * Optional board-config overrides for fixed (efuse/blob) routing
> +	 * that the chip registers do not expose unambiguously.  Absent
> +	 * properties leave pll_fvco[] zeroed (derive from DIVN) and
> +	 * out_pll_map_valid false (use the OUT_MAP registers).
> +	 */
> +	device_property_read_u64_array(sitdev->dev, "sitime,pll-fvco",
> +				       sitdev->pll_fvco, SIT9531X_NUM_PLLS);
> +
> +	if (device_property_present(sitdev->dev, "sitime,output-pll-map")) {
> +		u32 map[SIT9531X_MAX_OUTPUTS];
> +		int n, i;
> +
> +		/*
> +		 * Accept any 1..MAX_OUTPUTS length so the 8-output SiT95317
> +		 * can supply an 8-entry map instead of being forced to pad to
> +		 * 12.  Variant detection has not run yet; entries beyond the
> +		 * detected num_outputs are simply never indexed.
> +		 *
> +		 * Default every entry to "unmapped" first: when a shorter map
> +		 * is supplied for a variant with more outputs, the trailing
> +		 * entries must not read back as 0 (== PLLA) and falsely mark
> +		 * unrouted outputs as active in sit9531x_out_state_fetch().
> +		 */
> +		memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,
> +		       sizeof(sitdev->out_pll_map));
> +
> +		n = device_property_count_u32(sitdev->dev,
> +					      "sitime,output-pll-map");
> +		if (n > 0 && n <= SIT9531X_MAX_OUTPUTS &&
> +		    !device_property_read_u32_array(sitdev->dev,
> +						    "sitime,output-pll-map",
> +						    map, n)) {
> +			for (i = 0; i < n; i++)
> +				sitdev->out_pll_map[i] = map[i];
> +			sitdev->out_pll_map_valid = true;
> +		}
> +	}
> +
> +	/* Read variant ID byte */
> +	rc = sit9531x_read_variant_id(sitdev, &variant_id);
> +	if (rc)
> +		return rc;
> +
> +	/* Detect chip variant */
> +	sitdev->info = sit9531x_match_variant(variant_id);

So devices are fully detectable, thus compatible. Express the
compatibility in the binding and drop redundant OF device id table
entry.

> +	if (!sitdev->info)
> +		return dev_err_probe(sitdev->dev, -ENODEV,
> +				     "Unknown variant ID: 0x%02x\n", variant_id);
> +
> +	dev_info(sitdev->dev, "VariantID(0x%02X), %s (%u in, %u out)\n",
> +		 variant_id, sitdev->info->name,
> +		 sitdev->info->num_inputs, sitdev->info->num_outputs);
> +
> +	/* Generate deterministic clock ID */
> +	sitdev->clock_id = sit9531x_derive_clock_id(sitdev);
> +
> +	/* No PLL sources inter-PLL synchronization until requested */
> +	sitdev->intsync_src = -1;
> +
> +	/* Initialize mutex for multi-register atomic operations */
> +	rc = devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);
> +	if (rc)
> +		return dev_err_probe(sitdev->dev, rc,
> +				     "Failed to initialize mutex\n");
> +
> +	/*
> +	 * Register DPLL channels and create the kworker first.  The IRQ
> +	 * handler dereferences sitdev->kworker via
> +	 * kthread_mod_delayed_work(), so it must be live before any
> +	 * INTRB assertion can land on the request_threaded_irq path.
> +	 */
> +	rc = sit9531x_devm_dpll_init(sitdev);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Optional INTRB IRQ from DT.  The I2C subsystem populates
> +	 * client->irq from the node's "interrupts"/"interrupts-extended"
> +	 * property; if no IRQ is wired client->irq is 0 and we keep
> +	 * relying on the periodic poll.
> +	 */
> +	sitdev->irq = sitdev->client ? sitdev->client->irq : 0;
> +	if (sitdev->irq > 0) {
> +		rc = devm_request_threaded_irq(sitdev->dev, sitdev->irq,
> +					       NULL, sit9531x_irq_thread_fn,
> +					       IRQF_ONESHOT,
> +					       dev_name(sitdev->dev), sitdev);
> +		if (rc)
> +			return dev_err_probe(sitdev->dev, rc,
> +					     "Failed to request IRQ %d\n",
> +					     sitdev->irq);
> +		dev_info(sitdev->dev,
> +			 "INTRB IRQ %d wired (threaded handler kicks periodic poll)\n",
> +			 sitdev->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +/* ====================================================================
> + * I2C driver
> + * ====================================================================
> + */

That's not even Linux coding style comment... Please clean up driver
from non-Linux comments.

> +
> +static int sit9531x_i2c_probe(struct i2c_client *client)
> +{
> +	struct sit9531x_dev *sitdev;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &sit9531x_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	sitdev = devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);
> +	if (!sitdev)
> +		return -ENOMEM;
> +
> +	sitdev->dev = &client->dev;
> +	sitdev->client = client;
> +	sitdev->regmap = regmap;
> +	i2c_set_clientdata(client, sitdev);
> +
> +	return sit9531x_dev_probe(sitdev);
> +}
> +
> +static const struct i2c_device_id sit9531x_i2c_id[] = {
> +	{ "sit95317" },
> +	{ "sit95316" },

Why reversed order?

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sit9531x_i2c_id);
> +
> +static const struct of_device_id sit9531x_of_match[] = {
> +	{ .compatible = "sitime,sit95317" },

So this one is not neede., express the compatibility.

> +	{ .compatible = "sitime,sit95316" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sit9531x_of_match);
> +
> +static struct i2c_driver sit9531x_i2c_driver = {
> +	.driver = {
> +		.name		= "sit9531x",
> +		.of_match_table	= sit9531x_of_match,
> +	},
> +	.probe		= sit9531x_i2c_probe,
> +	.id_table	= sit9531x_i2c_id,
> +};
> +module_i2c_driver(sit9531x_i2c_driver);
> +


...

> +/* ====================================================================
> + * Pin allocation, registration, and cleanup
> + * ====================================================================
> + */
> +
> +static const struct dpll_pin_ops *
> +sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)
> +{
> +	if (!sit9531x_dpll_is_input_pin(pin)) {
> +		if (sit9531x_dpll_is_intsync_src_pin(pin))
> +			return &sit9531x_dpll_intsync_src_pin_ops;
> +		return &sit9531x_dpll_output_pin_ops;
> +	}
> +	if (sit9531x_dpll_is_intsync_pin(pin))
> +		return &sit9531x_dpll_intsync_dst_pin_ops;
> +	if (sit9531x_dpll_is_xo_pin(pin))
> +		return &sit9531x_dpll_xo_pin_ops;
> +	return &sit9531x_dpll_input_pin_ops;
> +}
> +
> +/*
> + * sit9531x_dpll_pin_alloc - allocate a DPLL pin
> + * @sitdpll:	DPLL device this pin belongs to
> + * @dir:	pin direction
> + * @id:		hardware pin index
> + *
> + * Return: pointer to allocated pin on success, error pointer on error
> + */
> +static struct sit9531x_dpll_pin *
> +sit9531x_dpll_pin_alloc(struct sit9531x_dpll *sitdpll,
> +			enum dpll_pin_direction dir, u8 id)
> +{
> +	struct sit9531x_dpll_pin *pin;
> +
> +	pin = kzalloc_obj(*pin, GFP_KERNEL);
> +	if (!pin)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pin->dpll = sitdpll;
> +	pin->dir = dir;
> +	pin->id = id;
> +
> +	return pin;
> +}
> +
> +/*
> + * sit9531x_dpll_pin_free - deallocate a DPLL pin
> + * @pin:	pin to free
> + */
> +static void sit9531x_dpll_pin_free(struct sit9531x_dpll_pin *pin)
> +{
> +	WARN(pin->dpll_pin, "DPLL pin is still registered\n");
> +	kfree(pin);
> +}
> +
> +/*
> + * sit9531x_dpll_pin_register - register a DPLL pin with the subsystem
> + * @pin:	pin to register
> + * @index:	absolute pin index for clock_id namespace
> + *
> + * Gets pin properties from firmware, creates or gets a dpll_pin,
> + * and registers it with the parent DPLL device.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int sit9531x_dpll_pin_register(struct sit9531x_dpll_pin *pin,
> +				      u32 index)
> +{
> +	struct sit9531x_dpll *sitdpll = pin->dpll;
> +	struct sit9531x_pin_props *props;
> +	const struct dpll_pin_ops *ops;
> +	int rc;
> +
> +	/* Get pin properties from firmware nodes */
> +	props = sit9531x_pin_props_get(sitdpll->dev, pin->dir, pin->id);
> +	if (IS_ERR(props))
> +		return PTR_ERR(props);
> +
> +	/* Save package label and firmware node */
> +	strscpy(pin->label, props->package_label, sizeof(pin->label));
> +	pin->fwnode = fwnode_handle_get(props->fwnode);
> +	pin->esync_control = props->esync_control;
> +
> +	/* Create or get existing DPLL pin */
> +	pin->dpll_pin = dpll_pin_get(sitdpll->dev->clock_id, index,
> +				     THIS_MODULE, &props->dpll_props,
> +				     &pin->tracker);
> +	if (IS_ERR(pin->dpll_pin)) {
> +		rc = PTR_ERR(pin->dpll_pin);
> +		goto err_pin_get;
> +	}
> +	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
> +
> +	ops = sit9531x_dpll_pin_ops_get(pin);
> +
> +	/* Register the pin */
> +	rc = dpll_pin_register(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);
> +	if (rc)
> +		goto err_register;
> +
> +	/* Free pin properties */
> +	sit9531x_pin_props_put(props);

This is all probe code, so it should be immediately before the probe()
functions, not in other units.

> +
> +	return 0;
> +
> +err_register:
> +	dpll_pin_put(pin->dpll_pin, &pin->tracker);
> +err_pin_get:
> +	/*
> +	 * On the dpll_pin_get() failure path pin->dpll_pin holds an ERR_PTR;
> +	 * clear it so the caller's sit9531x_dpll_pin_free() does not mistake
> +	 * it for a still-registered pin and emit a spurious WARN().
> +	 */
> +	pin->dpll_pin = NULL;
> +	fwnode_handle_put(pin->fwnode);
> +	pin->fwnode = NULL;
> +	sit9531x_pin_props_put(props);
> +
> +	return rc;
> +}
> +
> +/*
> + * sit9531x_dpll_pin_unregister - unregister a DPLL pin

Can sit9531x_dpll_pin_unregister() do anything than unregister a DPLL
pin? How useful are such comments?

Best regards,
Krzysztof

