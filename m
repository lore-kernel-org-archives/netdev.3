Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1B545DBA;
	Tue,  8 Sep 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871530; cv=none; b=RMmWSK2jMyf4pKP9HgLUDUdvW5ORpP0PQHaoPT32QzGUE8Y2Q3ATWfwYPOZ3m0nluRkRZ8Zsqy21ByI5yQ0K74mDvZ4m7V/xC7Nw8p6MNUt9bY5ZSBg5CBpXuIdSKz1ACxH7WszCibTB/vMCO0zE0NbxK0+0X5Eaj6uDqKi611s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871530; c=relaxed/simple;
	bh=btbAnW7XEqDU3rjY/DIUfd95J9aNMhneMrIssc+dwoo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B18Sn1t4grZpdWHxQNy3ydyKWBXAFYODEXju1SVYuTR/aJg2zLXc2ThJTpP1J65aA7Yiox/xANruFkjI54Ti6xAZ+5lRnw4PYtZWD+zRCiWapPtCWGjxajj7Pj36pNIsNMDP+yxWb4Q8PNDigFcOe4ZXzROv8+E0BiF1aqSUnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWV7C6jn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWV7C6jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5561F00A3D;
	Tue,  8 Sep 2026 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871528;
	bh=04EVxR5ZHLejSpxL9okl2sx0iBZM//I6epK7VnSXHAU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MWV7C6jnIpDFmp+aUZHgz+3MZcL3gzJTBxyiE42g5ts/QOVcf+h2URuEMuORkQE0l
	 0/V9K9UUlU7xPmBZgCIID2nyauymUgIK2PlqVKRh9gx9C0dYvoXA/6CC15DkmBp3UF
	 too0Wc3YPFUjrmBxj/pgNhVkhsociENiyL54V65mGGRpe1BT/q+hiQF66cF7HHJhAi
	 n7s71Sc6epOEHV7KZcVLn80Ovpt57w9VSxlU2pEoacISCH2G7fTsR59/LUyLwTPTwq
	 iwBJU9QqXUKXXRFI0FGcquXNfal7ZxSRwqxKXuxmKfF5yyRMmOG8AWdoXcMgg/YYt0
	 KzdvpYjq/uDmg==
Subject: Re: [PATCH net-next v8 12/15] dpll: sit9531x: add support to get
 phase offset on the connected input pin
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:26 +0000
Message-ID: <178887152665.219967.3620325573196534009@kernel.org>
In-Reply-To: <20260902214030.20955-13-arouhi@sitime.com>
References: <20260902214030.20955-13-arouhi@sitime.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 4 · Low: 3

- [Medium] The TDC sample width is described three mutually inconsistent
  ways by artifacts this patch adds.
- [Medium] The callback's own comment states a hardware precondition it
  neither creates nor checks: "the TDC compares against a signal the PLL…
- [Medium] A transient I2C/regmap failure is converted into a fabricated,
  successful phase-offset measurement of 0.
- [Medium] The callback decides which pin owns the TDC sample from the
  software cache `sitdev->chan[sitdpll->id].selected_ref`, but takes a…
- [Low] The new kernel-doc for sit9531x_dpll_input_pin_phase_offset_get()
  justifies its entire design decision (report the closed-loop residual,…
- [Low] struct sit9531x_dpll_pin::phase_offset is declared `s64
  phase_offset; /* picoseconds */` (drivers/dpll/sit9531x/dpll.h:35),…
- [Low] sit9531x_phase_offset_read() documents the conversion as
  `phase_diff (ps) = tdc_code * 1e12 / fvco` but implements `fvco_mhz =…

--

dpll: sit9531x: add support to get phase offset on the connected input pin

This adds sit9531x_phase_offset_read() to sample the on-chip
time-to-digital converter through the PLL debug window and convert the
code to picoseconds, and wires it up as the input pin
.phase_offset_get callback.  Pins that are not the PLL's selected
reference report zero.

A few questions on the readback and on what gets reported to userspace.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index c93578f3b750..f552a9c73796 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1586,6 +1586,131 @@ int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_phase_offset_read - read phase difference via TDC
> + * @phase_ps:	output phase difference in picoseconds
> + *
> + * Reads the Time-to-Digital Converter (TDC) 40-bit code from the
> + * PLL page registers, then converts to picoseconds using the VCO
> + * frequency: phase_diff = tdc_code / fvco.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */

[ ... ]

> +	tdc_raw = 0;
> +
> +	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +				  SIT9531X_PLL_REG_DBG_DATA_4, &v);
> +	if (rc)
> +		return rc;
> +	sign = !!(v & BIT(SIT9531X_TDC_SIGN_BIT));
> +	tdc_raw = (u64)(v & 0x07) << 32;

[Severity: Medium]
How wide is the TDC sample meant to be?  Three places in this patch
disagree.

The kernel-doc above says "Reads the Time-to-Digital Converter (TDC)
40-bit code".

regs.h annotates the top byte as nine bits in an eight bit register:

	#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [39:32] + sign */

And the code keeps three bits of that register and takes bit 3 as the
sign (SIT9531X_TDC_SIGN_BIT == 3):

	sign = !!(v & BIT(SIT9531X_TDC_SIGN_BIT));
	tdc_raw = (u64)(v & 0x07) << 32;

That assembles code[34:0], not code[39:0].  If the register annotation is
the correct one, are magnitude bits [39:35] dropped here with no range
check, so a large sample is scaled and published as an arbitrary
DPLL_A_PIN_PHASE_OFFSET value instead of an error?

The 0x07 is also the only unnamed field mask in a header that names every
other field, which hides the width at the call site.  Could it get a
define next to SIT9531X_TDC_SIGN_BIT?

[ ... ]

> +	/*
> +	 * Get VCO frequency for conversion.  Fvco==0 means DIVN is not
> +	 * programmed (PLL unused on this board) -- skip silently rather
> +	 * than spamming the log on every poll cycle.
> +	 */
> +	fvco = sit9531x_get_fvco(sitdev, pll_idx);
> +	if (!fvco) {
> +		dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",
> +			'A' + pll_idx);
> +		return -ENODEV;
> +	}

[Severity: Medium]
Is "Fvco==0 means DIVN is not programmed" the only case?  sit9531x_get_fvco()
also returns 0 on any register read failure:

	rc = sit9531x_divn_static(sitdev, pll_idx, &divn);
	if (rc || divn <= 0)
		return 0;

	doubler = sit9531x_is_xo_doubler_enabled(sitdev);
	if (doubler < 0)
		return 0;

So a single I2C NAK or timeout inside sit9531x_divn_static() ends up here
as -ENODEV, and the caller turns that into a successful measurement:

	if (rc == -ENODEV) {
		dpin->phase_offset = 0;
		*phase_offset = 0;
		return 0;
	}

Does that make a bus error indistinguishable from "the loop residual is
exactly 0 ps" on DPLL_A_PIN_PHASE_OFFSET?  The framework averages
successive samples, so every failing poll would pull the average toward
zero.

Note also the asymmetry within this same function: the identical bus
failure during the trigger and data reads is returned as an error, while
the one inside sit9531x_get_fvco() becomes a reported value.  Would
distinguishing "no DIVN programmed" from "read failed" (for example by
having sit9531x_get_fvco() return an errno separately from the value) keep
those two paths consistent?

> +
> +	/*
> +	 * phase_diff (seconds) = tdc_code / fvco
> +	 * phase_diff (ps) = tdc_code * 1e12 / fvco
> +	 *
> +	 * To avoid 64-bit overflow:
> +	 *   phase_ps = tdc_code * 1e6 / (fvco / 1e6)
> +	 */
> +	fvco_mhz = div64_u64(fvco, 1000000ULL);
> +	if (!fvco_mhz)
> +		return -EIO;
> +
> +	*phase_ps = div64_s64(tdc_signed * 1000000LL, (s64)fvco_mhz);

[Severity: Low]
The comment states the conversion as tdc_code * 1e12 / fvco, but the code
truncates the denominator to whole MHz first.

sit9531x_get_fvco() returns Hz derived from a fractional DIVN:

	return mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);

so a sub-MHz remainder is normal, and 2949120000 Hz becomes 2949 MHz here,
about 40 ppm of scale error on every reported magnitude.

Is the overflow concern real?  mul_u64_u64_div_u64() is already used twice
in this file (sit9531x_get_fvco() and sit9531x_pll_ffo_ppt()) and would
keep the exact Hz denominator:

	*phase_ps = mul_u64_u64_div_u64(abs(tdc_signed), 1000000000000ULL, fvco);

> +
> +	return 0;
> +}
> +
>  /*
>   * sit9531x_ref_state_fetch - read input reference status from hardware
>   * @index:	logical input index
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 76d7d7d21d3d..f813126077e1 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -528,6 +528,105 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference

[ ... ]

> + * needs the digital loop filter held (and, on the 1PPS PLL, the automatic
> + * phase- and frequency-lock helpers held off), which leaves the PLL
> + * undisciplined until it is released.  A netlink read must not do that,
> + * so the open-loop measurement lives behind a debugfs operation that owns
> + * the freeze and restores it; it is not this callback.

[Severity: Low]
Where is that debugfs operation?  Searching the driver directory at the tip
of the series, the only match for debugfs under drivers/dpll/sit9531x/ is
this comment line itself, and the directory contains only Kconfig, Makefile,
core.c/h, dpll.c/h, prop.c/h and regs.h.

Since this sentence is the justification for reporting the closed-loop
residual rather than the vendor's open-loop quantity, could it either point
at code that exists or be reworded so the rationale can be checked?

> + *
> + * Precondition, which this callback cannot create: the TDC compares
> + * against a signal the PLL drives, so a PLL driving no output with its
> + * zero-delay buffer off has nothing to measure.  SiTime confirms this is
> + * a property of the hardware rather than of their measurement script.
> + * The script satisfies it by mapping a spare output and restarting the
> + * PLL -- side effects that do not belong in a getter, so a reading taken
> + * in that state is simply not meaningful.

[Severity: Medium]
If a reading taken in that state "is simply not meaningful", what stops it
from being reported as a measurement?

The callback only checks selected_ref and then reads unconditionally, and
sit9531x_phase_offset_read() returns 0 regardless of whether the PLL drives
any output, so whatever the debug window hands back is scaled and published
as DPLL_A_PIN_PHASE_OFFSET with no extack warning.

regs.h already defines SIT9531X_PLL_REG_ZDB0/ZDB1 with
SIT9531X_PLL_ZDB_EN_BIT and SIT9531X_PLL_REG_OUT_MAP_HI/LO.  Could the
getter test those and report zero (as it does for non-selected pins) when
the precondition does not hold?

The commit message does not mention the limitation at all; it says the
small value "is the measurement, not an artefact of it".  Could the
restriction be described there as well, so it is visible to anyone reading
git history?

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	/*
> +	 * The on-chip TDC is a per-PLL resource that always measures the
> +	 * phase difference between the VCO and the PLL's currently
> +	 * selected reference; it cannot be pointed at an arbitrary input.
> +	 * For any input that is not the active reference there is no
> +	 * meaningful per-pin phase offset, so report 0 instead of the
> +	 * active reference's value.
> +	 */
> +	if (sitdev->chan[sitdpll->id].selected_ref != dpin->id) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		dpin->phase_offset = 0;
> +		*phase_offset = 0;
> +		return 0;
> +	}
> +
> +	rc = sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Medium]
Can the pin the sample is attributed to differ from the pin the TDC
actually measured?

The ownership test uses the software cache chan[].selected_ref, whose only
writer is sit9531x_chan_state_fetch() running from the periodic monitor
work / threaded IRQ:

	chan->selected_ref =
		sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK);

The sample itself is live and always taken against whatever reference the
PLL has selected at read time.  multiop_lock serialises access to the cache
but does not stop the chip from switching reference on its own (LOS on the
active input, revertive switchback).

In the window between such a switch and the next cache refresh, would a
dpll pin get on the previously selected pin pass the
selected_ref == dpin->id test and publish the new reference's phase as the
old pin's DPLL_A_PIN_PHASE_OFFSET, while the pin that is genuinely selected
fails the test and reports exactly 0?

Would reading the active-select register inside this same multiop_lock
section, as sit9531x_chan_state_fetch() does, close that window?

> +
> +	/*
> +	 * -ENODEV means the PLL has no programmed DIVN (unused on this
> +	 * board); report phase_offset = 0 so a full pin-get dump does not
> +	 * fail just because one DPLL is dormant.
> +	 */
> +	if (rc == -ENODEV) {
> +		dpin->phase_offset = 0;
> +		*phase_offset = 0;
> +		return 0;
> +	}
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "TDC phase readback failed");
> +		return rc;
> +	}
> +
> +	/*
> +	 * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIVIDER
> +	 * picoseconds: the integer part of the attribute is the value divided
> +	 * by the divider, the remainder is the fraction.  The TDC resolves one
> +	 * VCO period (hundreds of picoseconds), so the fractional digits are
> +	 * always zero here, but the magnitude still has to be scaled or every
> +	 * reading would be reported a thousand times too small.
> +	 */
> +	offset *= DPLL_PHASE_OFFSET_DIVIDER;
> +
> +	dpin->phase_offset = offset;

[Severity: Low]
The value cached here is in ABI units (1/1000 ps), but the field it is
stored in is documented as picoseconds:

	s32				phase_adjust;	/* picoseconds */
	s64				phase_offset;	/* picoseconds */

The sibling phase_adjust really does hold picoseconds, since
DPLL_A_PIN_PHASE_ADJUST has no divider, so the two identical unit comments
now differ by a factor of 1000.  Nothing reads dpin->phase_offset today,
but would it be worth either caching the unscaled value or fixing the
comment to say 1/DPLL_PHASE_OFFSET_DIVIDER picoseconds?

> +	*phase_offset = offset;
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index 251c98dc7cbe..aa60be243e6d 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -256,6 +256,42 @@

[ ... ]

> +#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */
> +#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [39:32] + sign */
> +#define SIT9531X_PLL_REG_DBG_DATA_5		0xBA  /* [47:40] */

[ ... ]

> +/* Read code of the TDC phase tap, and the sign bit of its sample */
> +#define SIT9531X_DBG_READ_CODE_TDC		69
> +#define SIT9531X_TDC_SIGN_BIT		3

These are the defines referenced in the sample-width question above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
