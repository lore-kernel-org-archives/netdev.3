Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144E3469FC;
	Sat, 26 Sep 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390096; cv=none; b=mKcV1HM0bFUUd3OqLrmdP1ugUDR7Zmf3xp4IC9uulSeeE1cNivEWPy59SXRwPuGL5t5/fn/iJK3NRomRnB/z7uda7ig0W3nR5CgTcS6eUq1EkIxmFvTwYC9BH1oM98cATmd5P5x/hFZ3EnZkUlpfPiBWrWCOJft87Vsuw46fryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390096; c=relaxed/simple;
	bh=UNVKywENbmjiLt76estWQYmCFW9m4Sg9jG4kjyzqrJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcDSOmGX4IdukdCLBHqGoOlfTXF6gleCfnWDSRVUCey9FXWhXoGMwR3uoSAG5wVPuGP1hXHFIBUTO8xloTaLmFqST8njec2jD/5r2zlWX3Epq+fSlSYoz4eXgVu9kgVTcU23czLSBkx4sIns1mSgg6B8aIeoSRXoJr5BySNflzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdWrnwhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdWrnwhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC66F1F00893;
	Sat, 26 Sep 2026 02:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390089;
	bh=wAhi364z7RfgNDZ3WLTol0mDPV349bJsQC0QRTOaOKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdWrnwhEDFu7g5XroFCug37jWRX+qJbh3vgtpVScLds7CS8nNCkyg7oVgV3oAQ7MO
	 lA/mPbZAiV8m5UWUA62qkuZJfu934yLAestg9xpizLyylpRRF0dERGsK28It2jN14A
	 AYoB0KhnP7+YtkbIDbN807VS04J7p5rjnEbk2fhZSzR9UMHWr7hfXmqos613XBv0If
	 8/ClW19i/sooS0rKk9PcrwlVPxNZMHb0fhEUeReqaoukDZWxfuG7uS/0KvuT5OO1XF
	 O2u2i/YShWpgQx3QFClz8g8xVfqPKh25ni/6u43oLkGZobBh+d0NGzVg564fgdu4eF
	 a7KrGR1IWFkxw==
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
Subject: Re: [PATCH v10 08/14] dpll: sit9531x: add support to get and set frequency on pins
Date: Fri, 25 Sep 2026 19:34:48 -0700
Message-ID: <20260926023448.1567817-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-9-arouhi@sitime.com>
References: <20260921201108.42676-9-arouhi@sitime.com>
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
dpll: sit9531x: add support to get and set frequency on pins

This commit adds frequency_get for input and XO pins, which reports the
rate described in firmware. It also adds frequency_get and frequency_set
for output pins, where the rate is Fvco / DIVO and Fvco comes from the
PLL's DIVN registers and the crystal rate. A set writes a new DIVO inside
the output-system programming state and then does a per-PLL phase flush.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index ac184c93258cb..0687ad6de861c 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -418,6 +418,127 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,

[ ... ]

> +static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
> +{
> +	int rc, rc2 = 0, rc3;
> +	u8 attempt;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +			       SIT9531X_UPDATE_NVM);
> +
> +	/*
> +	 * Issue the loop lock even if the update failed.  Callers reach
> +	 * this function through a goto so that the chip never stays in
> +	 * the PRG_CMD state with its loops open; returning early here
> +	 * would defeat that and leave the outputs unlocked until the
> +	 * next successful commit.
> +	 */

[Severity: Low]
This isn't a bug, but this comment says callers reach this function
through a goto. The only caller added here, sit9531x_output_freq_set(),
calls it directly after sit9531x_output_divo_write().

The kernel-doc of sit9531x_dpll_input_pin_frequency_get() has a similar
problem:

 * returns cached frequency from DT or last set.

Neither sit9531x_dpll_input_pin_ops nor sit9531x_dpll_xo_pin_ops has a
.frequency_set, and ref[].freq is only written in prop.c at probe. So
there is never a "last set" value. That is still true at the end of the
series.

Could both comments be updated?

[ ... ]

> +	rc3 = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +				SIT9531X_DEBUG_LOCK_VAL);
> +
> +	if (rc)
> +		return rc;
> +
> +	return rc2 ? rc2 : rc3;
> +}

[Severity: Low]
Suppose UPDATE_NVM and LOOP_LOCK both succeed and only the final
SIT9531X_REG_OUTSYS_DEBUG write fails. This returns rc3, but the new
divider is already committed.

sit9531x_output_freq_set() then returns early:

	ret = sit9531x_prg_commit(sitdev);
	if (ret && !rc)
		rc = ret;
	if (rc)
		return rc;

That skips the phase flush and the out[].freq update. At the end of the
series it also skips the phase-adjust re-time.

On an identical retry, dpll_pin_freq_set() calls frequency_get first. It
reads the new rate back from hardware, sees freq == old_freq, and returns
0 without calling the setter. Does that mean the skipped flush never runs?

sit9531x_output_freq_set() already downgrades a failed flush to a warning
for this reason ("the core asks for the current rate first and would drop
an identical retry"). Should a failure of only the debug-key write be
handled the same way?

[ ... ]

> @@ -1026,6 +1152,561 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)
> +{
> +	s64 whole = (s64)int_part * SIT9531X_DIVN_SCALE;
> +	u64 frac;
> +
> +	if (!fracd)
> +		return whole;
> +
> +	frac = mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);

[ ... ]

> +	fref = (u64)sitdev->xtal_freq << doubler;
> +
> +	*fvco = mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);

[Severity: Medium]
Can this double truncation leave fvco 1 Hz low?

sit9531x_divn_fixed() floors the fraction, and this multiply floors it
again. Take fref = 48 MHz and DIVN = 104 + 1/6 (NUM 1, DEN raw 5). The true
VCO is exactly 5,000,000,000 Hz, but the code computes:

  frac = 166,666,666,666
  divn = 104,166,666,666,666
  fvco = floor(4,999,999,999.999968) = 4,999,999,999

That is inside the low band, so the clamp below does not apply.

For a 10 MHz request, sit9531x_output_divo_calc() computes divo = 500.
Then this check:

	if (div64_u64(fvco, divo) != frequency) {

compares 9,999,999 with 10,000,000 and returns -EINVAL, even though
DIVO = 500 gives exactly 10 MHz.

sit9531x_output_freq_get() would also report and cache 9,999,999 Hz, and
prop.c advertises that as the current rate. Meanwhile a DT-listed 10 MHz
passes the core's supported-frequency check and then fails in the set.

This applies whenever the DIVN denominator has prime factors other than 2
and 5. It is unchanged at the end of the series, and only a DT pll-fvco
override avoids it.

> +	if (*fvco < fvco_min)
> +		*fvco = fvco_min;
> +	else if (*fvco > fvco_max)
> +		*fvco = fvco_max;
> +
> +	return 0;
> +}

[Severity: Medium]
When the register-derived Fvco falls outside the band, this returns
success with a band-edge value the VCO is not running at. Doesn't that
defeat the exactness check in sit9531x_output_divo_calc()?

For example, take a high-band PLL (B or D) whose Fref * DIVN is 5.0 GHz.
The clamp raises fvco to 6.875 GHz. A 12.5 MHz request gives DIVO = 550,
and this check passes because it compares against the same clamped value:

	if (div64_u64(fvco, divo) != frequency) {

sit9531x_output_freq_set() commits the divider and returns 0. The output
actually runs at about 5.0e9 / 550, roughly 9.09 MHz.

The clamp is in the shared accessor, so sit9531x_output_freq_get() reports
12.5 MHz as well. Userspace has no way to see the mismatch.

The comment in sit9531x_output_divo_calc() says "programming a divider
from a guessed rate would put the output far from what was asked for while
reporting success". That seems to be what happens in this case.

The final patch in the series adds sit9531x_fvco_in_band(), but only uses
it to validate the DT override. This clamp is still there at the end of
the series.

[ ... ]

> +static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{
> +	u8 ctrl, orig;
> +	int rc, ret;
> +
> +	/* Arm the on-demand phase-flush on the PLL page. */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_PHFL_CTRL,
> +				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,
> +				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);
> +	if (rc)
> +		return rc;

[ ... ]

> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,
> +			       ctrl | SIT9531X_DIVO_PHASE_TRIG);

[Severity: Medium]
SIT9531X_REG_GPIO_FUNC_CTRL1 is SIT9531X_REG(0x00, 0x65), a chip-global
Page 0 register. Which PLLs respond to this pulse depends on each PLL's
own PHFL_CTRL bit 7.

This function arms that bit only for pll_idx. It never checks or disarms
it on the other three PLLs.

If the loaded profile left on-demand phase flush enabled on another PLL,
would a frequency set on one DPLL also step the phase of outputs that
belong to other DPLLs, with no notification?

That is wider than what the commit message describes:

  The phase flush that follows a divider write realigns every output fed by
  that PLL, not only the one that changed.

[ ... ]

> +disarm:

[ ... ]

> +	ret = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				     SIT9531X_PLL_REG_PHFL_CTRL,
> +				     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);
> +	if (!ret)
> +		ret = sit9531x_write_pll_u8(sitdev, pll_idx,
> +					    SIT9531X_PLL_REG_SMALL_UPDATE,
> +					    SIT9531X_SMALL_UPDATE_CMD);

[Severity: Medium]
The arm step at the top of this function sets
SIT9531X_PLL_PHFL_ON_DEMAND_EN with regmap_update_bits() without saving the
previous value. This path always clears it and latches the change with
SIT9531X_SMALL_UPDATE_CMD.

Suppose the loaded NVM profile had on-demand phase flush enabled on this
PLL, for example on a board that realigns outputs from a GPIO trigger.
Would the first output frequency set on that PLL turn it off for good, so
that later GPIO-triggered flushes silently do nothing?

This function already saves and restores GPIO_FUNC_CTRL1 through orig.
Should PHFL_CTRL be saved and restored the same way?

[ ... ]

> +	for (j = 0; j < 5; j++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(page, base_reg - j),
> +				       divo_bytes[j]);
> +		if (rc)
> +			goto rollback;
> +		written++;
> +	}
> +
> +	return 0;
> +
> +rollback:
> +	for (j = 0; j < written; j++) {

[Severity: Medium]
written is only incremented after a successful write, so the byte whose
write reported failure is never restored here.

sit9531x_prg_enter() notes that "a transfer that reported an error may
still have reached the part". If that byte did land,
sit9531x_output_freq_set() still calls sit9531x_prg_commit()
unconditionally, and that issues UPDATE_NVM and LOOP_LOCK.

Can that commit a 34-bit divider that is part old and part new? The output
would then run at neither the old rate nor the requested one, while the
set returns an error and out[].freq keeps the old value.

The comment above this function says "so the output keeps the divider it
had rather than a mixture of the two". Should the rollback also restore
old_bytes[written]?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 56a8213dee077..9f0678ddfe0ee 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -691,8 +715,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_output_freq_get(sitdev, dpin->id, frequency);
> +	if (rc == -ENODEV)
> +		*frequency = sit9531x_out_state_get(sitdev, dpin->id)->freq;
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	return rc == -ENODEV ? 0 : rc;
> +}

[Severity: Medium]
Is -ENODEV reliable as the "not resolvable" sentinel here?

sit9531x_output_freq_get() returns -ENODEV itself when divo is zero, and
here:

	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
	if (rc)
		return rc == -ENODATA ? -ENODEV : rc;

It also passes register access errors from sit9531x_read_u8(),
sit9531x_divn_static() and sit9531x_is_xo_doubler_enabled() through
unchanged.

The driver says elsewhere that the I2C layer returns -ENODEV for an
adapter that has gone away. The comment in
sit9531x_dpll_input_pin_phase_offset_get() reads: "Every other errno,
-ENODEV from a vanished adapter included, is a failure."

In that case a bus -ENODEV is reported here as a successful read of the
cached rate. That contradicts the comment above this function, "so
transport/register errors still surface".

It also affects frequency set, because the core reads the old rate first:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
    ...
	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
				 dpll_priv(dpll), &old_freq, extack);
    ...
	if (freq == old_freq)
		return 0;
    ...
}

If the stale cached value equals the requested rate, the set reports
success without touching the hardware. This is still present at the end
of the series.

Could sit9531x_output_freq_get() use an errno for the unresolvable case
that a bus error cannot also produce?

[ ... ]
