Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40E368D4C;
	Sat, 26 Sep 2026 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390098; cv=none; b=SwpyOX7yxeQHULORlHJxJaOfc/Mquk1l/3SF/mZ/c++DkABAk3pYGb/mOubs8ChLunhv0n7mwSYBBcq932mfsuE6Gvp2GxRFwYt+fPfEgLMC/TzynuE0dJyDcoZWB+YK3eUFUDfFIqaVqLzHgslVWYBT6qqwHUjHQUwcLM7qaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390098; c=relaxed/simple;
	bh=iWGKzT5zQU3JGkmF9EA5JIa8bB0X7j5AglXQNP1d4OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7DMH/et81dlxsvOORqFZbhFAmGVvDgJr84MVDbSpVlsid69xPzjUH2JXoFfLhMCjJfKEV6s2v8XlQleOIzJIxY/UnI2NsqAE7xT4obrApruxhee/dHN9OKWRSFIZdvwzBXqK+zWtyZSIy7TBEZ9RdO/qC3DhL4I15wkGl8azmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxIEADgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxIEADgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD88A1F0089B;
	Sat, 26 Sep 2026 02:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390094;
	bh=HJNbG8pCxkTLHXUJlvxxl60JeysRyXvzYq40N4gtCes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxIEADgzlqv+dd7nVybQlENEPamKpJYbZ58kNetaodJStfAJP/JmXsUiSFg/USoXo
	 4SFy9FbuMrsiE+BgPej1vy1YTUj1tove53m6yJpdqvNvh8i4Re/nH2vEWWjFieJ77U
	 +dsvH6uWJdj2AA0+M1Tw4visn3kdAq+htXxRjadZJA5ZO8JcJqWunJ9XQKNG82Cmnw
	 WzzlaJdcBuQoBlgSIQ3O8iQyRJJqxnDgiV6d71auQHw7SFJ2oVupm0Bjv5FNtGNnif
	 esEFpslqTj78ukQbKm7DDxRsLLpRzV9LBMTa/86d+6wQgGslUawLlfMwK7pR5PZZeF
	 8sCrsa0tdKjeg==
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
Subject: Re: [PATCH v10 12/14] dpll: sit9531x: add support to get fractional frequency offset
Date: Fri, 25 Sep 2026 19:34:53 -0700
Message-ID: <20260926023453.1568118-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-13-arouhi@sitime.com>
References: <20260921201108.42676-13-arouhi@sitime.com>
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
dpll: sit9531x: add support to get fractional frequency offset

This patch adds an ffo_get callback for sit9531x input pins. The offset
is computed from the ratio between the running DIVN, which is sampled
through the debug window, and the configured DIVN read from the
registers. A new helper, sit9531x_dbg_sample(), does the unlock, tap
select, triple latch and readout of the debug window.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 8f6f8ffc8dc13..1cb691f040194 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1396,6 +1396,93 @@ static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)

[ ... ]

> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_DBG_WRITE_CODE,
> +				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,
> +				    low_freq_clk ?
> +				    SIT9531X_DBG_LOW_FREQ_CLK_BIT : 0);
> +	if (rc)
> +		goto relock;
> +
> +	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
> +				   SIT9531X_PLL_REG_DBG_READ_CODE, read_code);
> +	if (rc)
> +		goto relock;

[Severity: Low]
Should sit9531x_dbg_sample() restore DBG_WRITE_CODE and DBG_READ_CODE
before it re-locks, the way sit9531x_phase_offset_read() does?

sit9531x_phase_offset_read() saves both registers and puts them back:

    if (have_old) {
        sit9531x_write_pll_u8(sitdev, pll_idx,
                              SIT9531X_PLL_REG_DBG_READ_CODE,
                              old_read_code);

Its comment says that "leaving it parked ... is a state change the caller
did not ask for, and the next reader of a different tap would have to
know to undo it".

After each FFO read through sit9531x_divn_runtime(), DBG_READ_CODE stays
at 0x56 (SIT9531X_DBG_READ_CODE_DIVN_DEN) and
SIT9531X_DBG_LOW_FREQ_CLK_BIT stays cleared. Inside the driver this has
no effect today, because sit9531x_phase_offset_read() sets both
registers before it samples.

The comment below also says the triple latch is done "as
sit9531x_phase_offset_read() already did". However,
sit9531x_phase_offset_read() still open-codes the same
unlock/select/trigger/read/relock sequence instead of calling this
helper. That gives the driver two implementations of one debug-window
protocol, with opposite rules about leftover mux state.

Could both paths share sit9531x_dbg_sample() with one policy?

[ ... ]

> @@ -1477,6 +1564,136 @@ static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,

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

[Severity: Medium]
Is this the quantity the uAPI defines for DPLL_FFO_PIN_DEVICE?

Since Fvco = Fxo * DIVN, (running - configured) / configured is how far
the DPLL output sits from its nominal frequency, measured against the
local XO.

Documentation/netlink/specs/dpll.yaml describes
fractional-frequency-offset-ppt like this:

    the pin-parent-device nest it represents the frequency
    offset between the pin and its parent DPLL device.
    For pins of type PIN_TYPE_INT_NCO this represents
    the DPLL's current output frequency offset from its
    nominal frequency.

zl3073x follows this split. For input pins it reads dpll_df_offset with
ZL_DPLL_DF_READ_REF_OFST set. Commit 54e65df8cf18a7 describes that
value as "the actual frequency difference between the DPLL and its
active input". The master-clock-relative value (ref_ofst=0) is used
only for the NCO pin.

The value computed here looks like the master-clock-relative one. On a
locked loop, zl3073x reports close to zero on the input pin, but
sit9531x would report the offset of the reference from the XO, which
can be many ppm.

sit9531x_dpll_input_pin_ops publishes this value as
BIT(DPLL_FFO_PIN_DEVICE). Would userspace reading the pin-parent-device
FFO then get different physical quantities from the two drivers?

The commit message makes the same claim:

    the difference between the divider the loop is running and the
    divider the configuration asked for is exactly the offset of the
    reference.

[ ... ]

> +	rc = sit9531x_divn_static(sitdev, pll_idx, &configured);
> +	if (rc)
> +		return rc;
> +	/*
> +	 * Scaling by a divider far below one whole cycle overflows the
> +	 * 64-bit product and comes back as ~0, which would be reported
> +	 * as a plausible offset.  A DIVN that small is not a running
> +	 * loop, so treat it as no measurement.
> +	 */
> +	if (configured < SIT9531X_DIVN_SCALE)
> +		return -ENODATA;
> +
> +	rc = sit9531x_divn_runtime(sitdev, pll_idx, &running);
> +	if (rc)
> +		return rc;
> +
> +	delta = running - configured;
> +	magnitude = mul_u64_u64_div_u64(abs(delta), SIT9531X_PPT_PER_UNIT,
> +					(u64)configured);

[Severity: Medium]
Can a negative configured DIVN get past this guard?

configured is s64 and SIT9531X_DIVN_SCALE is 1000000000000ULL, so the
comparison is done as unsigned. A negative configured then compares as
a value close to 2^64.

sit9531x_divn_static() only rejects |fracn| >= fracd. If DIVN_INT reads
0 and DIVN_NUM is negative, sit9531x_divn_fixed() returns a negative
value. For example, INT=0, NUM=-5 and a raw DEN of 10 give a configured
value of about -4.5e11.

That value passes the guard. (u64)configured is then about
2^64 - 4.5e11, so mul_u64_u64_div_u64() returns a small ppt value that
looks plausible. The kernel-doc instead promises -ENODATA for "a
configured divider below one whole unit".

This register state probably only shows up with misprogrammed registers
or bad bus reads. Was a signed comparison, e.g. against
(s64)SIT9531X_DIVN_SCALE, intended here?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 5f7c2d01562c9..fcdd19e0bd3b0 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -638,6 +638,50 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	/*
> +	 * Publish FFO only for the input the DPLL is actively tracking.
> +	 * selected_ref alone is not enough (free-run, LOL, holdover), so use
> +	 * the same CONNECTED criterion as the generic selection-state logic.
> +	 */

[Severity: Medium]
Does the CONNECTED test actually exclude LOL and holdover?

sit9531x_dpll_selection_state_get() computes:

    active_input = !chan->mode && chan->selected_ref == pin_id;

Apart from that it only checks prio_mask. It never reads chan->locked,
chan->inner_lol or chan->ho_freeze, so free-run is the only case it
filters out.

The pin-state contract comment in dpll.c defines CONNECTED as
A && L && S && M, with L = chan->locked && !chan->inner_lol. The code
does not implement L.

The running DIVN is not settled in these cases:

  - the loop is still acquiring lock (chan->mode == 0, !chan->locked)
  - the loop has lost lock
  - the PLL is in holdover, if ACTIVESEL still reports the last
    reference

The kernel-doc of sit9531x_pll_ffo_ppt() assumes "A locked PLL".

Could this report an FFO for a reference the loop is not tracking, with
nothing to show that the value is invalid?

> +	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);
> +	if (state != DPLL_PIN_STATE_CONNECTED) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		return -ENODATA;
> +	}

[Severity: Medium]
Can this report the measurement on the wrong pin after the device
switches reference by itself?

The CONNECTED state comes from the cached chan->selected_ref. The
monitor refreshes that only every SIT9531X_STATUS_POLL_MS (500 ms).

The sibling sit9531x_dpll_input_pin_phase_offset_get() reads the live
selection first for this reason:

    rc = sit9531x_chan_selected_ref_read(sitdev, sitdpll->id,
                                         &selected);
    ...
    if (state != DPLL_PIN_STATE_CONNECTED || selected != dpin->id) {

The kernel-doc of sit9531x_chan_selected_ref_read() says the cache is
"close enough for reporting pin state but not for attributing a
measurement".

Take a failover where the higher-priority input hits LOS. Until the next
poll, a pin-get on the old pin still sees CONNECTED. At that point
sit9531x_pll_ffo_ppt() samples a running DIVN that already tracks the
new reference.

The function's own comment says it avoids "reporting the active
reference's figure against the wrong pin". Should ffo_get also call
sit9531x_chan_selected_ref_read() and require selected == dpin->id?

[ ... ]
