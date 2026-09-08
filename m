Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC04545D94;
	Tue,  8 Sep 2026 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871528; cv=none; b=BOtttXOj2XwbBMXUXtn3o56q0VKLbN0r+YXDAXdJ42sRhHb48tnNu9Vbr8gBSuTjTZMUbxTQNkccySs2avlUiTZFjd8mL1yCwjMkZ/p1RI8+TNtHX4A/FyRWXqWMd/I6U0o6ohtN4tolaFP7l0fq0RU57XP2qR7t1hvHf989q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871528; c=relaxed/simple;
	bh=An/XIdmw6JHUUq4YI9ZNZK5e9ExB7SWPxxzD+APHOi0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRSub+ih0/nePBBLpJc9dtihkhcwNXTBDEPA2/NecH+2ArHaxhZukkryRugF+G/JLMjEzkDw7SZ6BQFZdibTFac7Z9gs1HK0pi2tGqu6PwHE8zrPzsn1ouyh1xaVORpQrA8Q1h7qqLGUsdBK5e9Lb1Cbl+ylIttmqG+vyAa0zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5C51F00A3E;
	Tue,  8 Sep 2026 12:45:25 +0000 (UTC)
Subject: Re: [PATCH net-next v8 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:24 +0000
Message-ID: <178887152468.219967.5120035728263161680@kernel.org>
In-Reply-To: <20260902214030.20955-14-arouhi@sitime.com>
References: <20260902214030.20955-14-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] sit9531x_dpll_input_pin_ffo_get()
  (drivers/dpll/sit9531x/dpll.c:547) gates the new fractional-frequency-…
- [Medium] sit9531x_dpll_input_pin_ffo_get()
  (drivers/dpll/sit9531x/dpll.c:547) gates the measurement on the…
- [Low] The patch adds a stale documentation block headed
  'sit9531x_dpll_input_pin_phase_offset_get - read phase offset ...…

--

dpll: sit9531x: add support to get fractional frequency offset

This adds a fractional frequency offset getter for input pins, derived
from the difference between the DIVN the digital loop is running (read
through the latched debug window) and the DIVN in the configuration
registers.  The result is reported in parts per trillion through the
DPLL netlink pin attribute.

A few questions below about the gating of the new measurement and about
one of the added comment blocks.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index f552a9c73796..bd251ab60eee 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -998,6 +1053,102 @@ static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +/**
> + * sit9531x_pll_ffo_ppt - fractional frequency offset of a PLL's reference
> + * @sitdev:	device pointer
> + * @pll_idx:	PLL index (0-3)
> + * @ffo:	result in parts per trillion
> + *
> + * A locked PLL commands whatever DIVN keeps its VCO tracking the
> + * reference.  How far that sits from the configured DIVN is how far the
> + * reference sits from the local oscillator, which is the fractional
> + * frequency offset the DPLL ABI reports for the pin feeding the device.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, -ENODATA when DIVN is not programmed, <0 on
> + * error.
> + */
> +int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo)
> +{
> +	s64 configured, running, delta;
> +	u64 magnitude;
> +	int rc;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +
> +	rc = sit9531x_divn_static(sitdev, pll_idx, &configured);
> +	if (rc)
> +		return rc;
> +	if (configured <= 0)
> +		return -ENODATA;

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index f813126077e1..1a14255e89a8 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -528,6 +528,52 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_dpll_input_pin_phase_offset_get - read phase offset
> + *
> + * reads the TDC (Time-to-Digital Converter) hardware
> + * to measure the phase difference in picoseconds via
> + * sit9531x_phase_offset_read().
> + */

[Severity: Low]
This isn't a bug, but is this comment block a leftover?  It names
sit9531x_dpll_input_pin_phase_offset_get() and describes a TDC
picosecond reader, while the function that follows it is
sit9531x_dpll_input_pin_ffo_get(), which returns parts per trillion from
a DIVN ratio and never calls sit9531x_phase_offset_read().

sit9531x_dpll_input_pin_phase_offset_get() sits further down in the same
file and already carries its own, differently worded block starting with
"phase offset of a reference", so the file now has two doc blocks for
that one function.

On a related note, core.h (added by an earlier commit in the series)
files the new prototype under the phase-offset heading:

	/* ---- Phase offset (TDC readback) ---- */
	int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitdev, u8 pll_idx, s64 *ffo);
	int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
				       s64 *phase_ps);

Would a separate heading for the frequency-offset helper be clearer?

> +/*
> + * sit9531x_dpll_input_pin_ffo_get - read the input's frequency offset
> + *
> + * The offset is derived from how far the PLL's running DIVN sits from
> + * its configured one, which only says something about the reference the
> + * PLL is actually tracking.  For every other input there is no
> + * measurement, and -ENODATA leaves the attribute out rather than
> + * reporting the active reference's figure against the wrong pin.
> + */
> +static int
> +sit9531x_dpll_input_pin_ffo_get(const struct dpll_pin *pin, void *pin_priv,
> +				const struct dpll_device *dpll, void *dpll_priv,
> +				struct dpll_ffo_param *ffo,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	int rc;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	/*
> +	 * The periodic worker updates selected_ref under the same lock, so
> +	 * test it here rather than before taking it: otherwise the
> +	 * reference can change in between and the measurement gets
> +	 * attributed to the wrong pin.
> +	 */

[Severity: Medium]
Does multiop_lock really give the guarantee described here?  The lock
serializes this read against the worker's update of the cached value,
but the entity that switches the reference is the device, which takes no
software lock.

chan->selected_ref is written only from the poll worker:

drivers/dpll/sit9531x/core.c:sit9531x_chan_state_fetch() {
	...
	chan->selected_ref =
		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);
	...
}

and that worker runs every 500 ms:

drivers/dpll/sit9531x/core.c:sit9531x_dev_periodic_work() {
	...
	/* Run twice a second */
	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,
				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));
}

So if the chip switches from IN0 to IN1 on its own, for up to one poll
period a DPLL_CMD_PIN_GET on IN0 passes the gate and the running-DIVN
sample, which now tracks IN1, is reported as IN0's offset, while IN1
returns -ENODATA and gets no attribute at all.

Would re-reading CLK_ACTIVESEL_PLL inside the same multiop_lock section
as the DIVN sampling close that window?  This still reads the same way
later in the series, so it does not look like a follow-up fixes it.

> +	if (sitdev->chan[sitdpll->id].selected_ref != dpin->id) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		return -ENODATA;
> +	}
> +
> +	rc = sit9531x_pll_ffo_ppt(sitdev, sitdpll->id, &ffo->ffo);

[Severity: Medium]
Should this gate also require the outer loop to be closed and locked?

selected_ref is derived from the input-select nibble alone, with no
regard for chan->mode, chan->locked, chan->inner_lol or chan->ho_freeze,
so a matching id does not imply the PLL is tracking that input.  The
driver's own definition of an active reference is stricter:

drivers/dpll/sit9531x/dpll.c:sit9531x_dpll_selection_state_get() {
	...
	active_input = !chan->mode && chan->locked && !chan->inner_lol &&
		       chan->selected_ref == pin_id;
	...
}

With only the selected_ref test, a free-running PLL (chan->mode == 1),
an unlocked one, or one in holdover (chan->ho_freeze) still reaches
sit9531x_pll_ffo_ppt(), which returns a value as soon as the configured
DIVN is non-zero:

	rc = sit9531x_divn_static(sitdev, pll_idx, &configured);
	if (rc)
		return rc;
	if (configured <= 0)
		return -ENODATA;

	rc = sit9531x_divn_runtime(sitdev, pll_idx, &running);
	...
	delta = running - configured;

In free-run that difference is not a reference offset at all, and in
holdover it is the frozen last correction, yet both are published
through DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET.

The comment above says the value "only says something about the
reference the PLL is actually tracking" - could the code enforce that
claim?  zl3073x_dpll_input_pin_ffo_get() returns -ENODATA unless
pin->operstate == DPLL_PIN_OPERSTATE_ACTIVE, and dpll_netlink.c already
treats -ENODATA as "omit the attribute", so the same shape is available
here.  This also appears unchanged later in the series.

> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	return rc;
> +}
> +

[ ... ]

> @@ -641,6 +687,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
>  	 * rather than a port rate.
>  	 */
>  	.supported_ffo		= BIT(DPLL_FFO_PIN_DEVICE),
> +	.ffo_get		= sit9531x_dpll_input_pin_ffo_get,
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
