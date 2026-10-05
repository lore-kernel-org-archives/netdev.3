Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96643283CB5;
	Mon,  5 Oct 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162609; cv=none; b=YrSZGAh+r6/aPAlegCCdw9iUQehT5n/mByxQ+PiAPF6zsBuqhYZKf/MZRFAxOgKAp1rOeqIeRX9Iz6it/G/Lb/bHW7ScmruirjaNX0nKay9B3lXukQLVIYQcjdBwm/J0WW8FC86VQBGlF5xf5uizPkQk5XkR9ym5XQdzUYUFY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162609; c=relaxed/simple;
	bh=70onvcnNV/5nrTvwBAqz/w18VzrduVrPrYtcGTaP54I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RrH1/pTctm0HxZ7SPLS9U0MYI3BTDsPoMaIm+TbsUEl6iYjx8zAa2D78Ns4+k599LWoY16eQE8BRFxNz3KEaaoL4WRGIR9XTf2GmFBkQQKe3FbzT3SEPgrTmVe7WdDVA1Ytog5zMkFAvgkasVW3dnNRNEXzk3Q+QxW/3CbSokkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH1czFMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH1czFMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0F91F00899;
	Mon,  5 Oct 2026 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162606;
	bh=CJA6TdIKXNMccsHi8dnQTMsna7TTCAw6I9SWKP4Xy/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EH1czFMS5kLbG8hxsY/ubZMmsCb22H16qVS7PDaSAhpi4y25GvvUc8xgMe5alH9yG
	 qQhMmksARMvtPP4eGxuLRnZNFcnNNFh3C9YHFMqEtZf0r3RPfoqoX18YgpjG8U7P7v
	 9AC5sUrMCcbXBRkt4N4w0zMbJGr+0GTNmUiqKfL9/7lavNDxmS1kdzwxXUigg1WREm
	 qM2WY9Sb2vub2wNfIxNmxeaPGKEXNNNJncAdbcGbZXDXBpsKOcFa23cGS5OzhW87ZD
	 EzCN5EHrsJKZkHMXPOZorj9UuUoLXwvfifUHXX09IWMOkY5he3l6fYyN8WLjp98qB9
	 QPQBF+xxWl9Sw==
Subject: Re: [PATCH net-next v11 09/13] dpll: sit9531x: add support to get and
 set frequency on pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:05 +0000
Message-ID: <179116260535.434549.287018391203993508@kernel.org>
In-Reply-To: <20260930233714.87679-10-arouhi@sitime.com>
References: <20260930233714.87679-10-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_dpll_input_pin_frequency_get() always returns
  `ref->freq` and succeeds.
- [Medium] The new input frequency_get reports sitdev->ref[index].freq.
- [Medium] Elsewhere in this patch (prg_enter, divo_write rollback) the
  driver assumes that an I2C write which reports an error 'may still…
- [Medium] sit9531x_prg_abort() runs when the PRG_CMD_STATE write in
  sit9531x_prg_enter() reports an error.
- [Medium] sit9531x_get_fvco() detects that Fref*DIVN lies outside the
  PLL's VCO band.
- [Low] The sit9531x_prg_commit() comment justifies its LOOP_LOCK retry
  loop with 'retry as the priority table does with its own latch'.

--

dpll: sit9531x: add support to get and set frequency on pins

This adds frequency_get for the input and XO pins, which reports the rate
from the firmware description. It also adds frequency_get and
frequency_set for the output pins, computed as Fvco / DIVO. An output rate
change writes DIVO inside the output-system programming state, commits it
with an NVM update and a loop lock, and then fires a per-PLL phase flush.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index f6c76cc78456d..3254d119b9398 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -488,6 +488,139 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,

[ ... ]

> +static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)
> +{
> +	u8 attempt;
> +	int rc = -EIO;
> +
> +	for (attempt = 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {
> +		rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +				       SIT9531X_LOOP_LOCK);
> +		if (!rc)
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +	if (rc)
> +		dev_err(sitdev->dev,
> +			"output loops left unlocked after a failed entry: %d\n",
> +			rc);
> +
> +	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +			  SIT9531X_DEBUG_LOCK_VAL);
> +}

[Severity: Medium]
Should this path also wait out the settling time after the loop lock?

sit9531x_prg_commit() follows the same LOOP_LOCK write with msleep(100).
The commit message calls that wait "a property of the hardware rather
than a conservative guess". It also says that skipping it "would let the
next request program a part that has not settled".

This abort runs when the PRG_CMD_STATE write in sit9531x_prg_enter()
reported an error. By the comment in sit9531x_prg_enter(), that write may
still have reached the part. sit9531x_output_freq_set() then returns
straight away:

	rc = sit9531x_prg_enter(sitdev);
	if (rc)
		return rc;

The caller then drops multiop_lock. The next frequency, phase-adjust or
priority request can then start programming while the output loops are
still re-locking.

The abort path also never issues SIT9531X_UPDATE_NVM. Is LOOP_LOCK on its
own a valid way to leave PRG_CMD on this part?

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
> +	 * Issue the loop lock even if the update failed: every caller
> +	 * commits whatever happened after the entry so that the chip never
> +	 * stays in the PRG_CMD state with its loops open, and returning
> +	 * early here would defeat that.
> +	 *
> +	 * Re-lock the loops.  Leaving them open is worse than any other
> +	 * failure this function can report, and nothing else closes them,
> +	 * so retry as the priority table does with its own latch.
> +	 */

[Severity: Low]
This isn't a bug, but is this comment accurate? The priority table's
latch is sit9531x_prio_prg_commit(), which writes once and does not
retry:

	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
			       SIT9531X_SMALL_UPDATE_CMD);
	if (rc)
		return rc;

The only retry in sit9531x_prio_table_commit() is the loop that releases
the forced holdover, bounded by SIT9531X_HO_CLEAR_TRIES.

[ ... ]

> @@ -1265,6 +1403,646 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,

[ ... ]

> +static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			     u64 *fvco)
> +{

[ ... ]

> +	/*
> +	 * A rate outside the band the PLL's VCO runs in usually means
> +	 * Fref * DIVN is not what this PLL runs at -- a PLL fed from another
> +	 * PLL rather than from the XO, for one.  The rate derived from the
> +	 * registers is still the only estimate there is, so it is used as
> +	 * it is: substituting the band edge would program dividers against
> +	 * a rate nothing supports and report the result as exact.  Say so
> +	 * once.
> +	 */
> +	if (*fvco < fvco_min || *fvco > fvco_max)
> +		dev_warn_once(sitdev->dev,
> +			      "PLL%c: Fref * DIVN = %llu Hz is outside its VCO band\n",
> +			      'A' + pll_idx, *fvco);
> +
> +	return 0;
> +}

[Severity: Medium]
Can this make frequency_set report success for a rate the output is not
running at?

When Fref * DIVN is out of band, the comment says it is probably not what
the PLL runs at, but the function still returns 0.
sit9531x_output_divo_calc() then computes DIVO from that value, and its
exactness check passes against the wrong Fvco:

	if (div64_u64(fvco, divo) != frequency) {

The divider is committed, so the output runs at the real Fvco / N, while
out[].freq caches the requested rate. sit9531x_output_freq_get() divides
the same wrong Fvco, so userspace reads back the requested rate and no
error appears anywhere.

Using the out-of-band estimate also reports the result as exact, which is
the outcome the comment rejects for the band edge. Would it be safer to
refuse the set in this case?

Also, dev_warn_once() fires once per call site, not once per device or
PLL. After the first warning, other devices and PLLs are silent.

[ ... ]

> +static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{

[ ... ]

> +	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +		if (i == pll_idx || !(armed_mask & BIT(i)))
> +			continue;
> +		rc = sit9531x_update_pll_u8(sitdev, i,
> +					    SIT9531X_PLL_REG_PHFL_CTRL,
> +					    SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);
> +		if (rc)
> +			goto unpark;
> +		/* Cleared, if not latched yet: put back either way. */
> +		parked |= BIT(i);
> +		rc = sit9531x_pll_small_update(sitdev, i);
> +		if (rc)
> +			goto unpark;
> +	}
> +
> +	/* Arm the on-demand phase-flush on the PLL page. */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_PHFL_CTRL,
> +				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,
> +				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);
> +	if (rc)
> +		goto unpark;

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);
> +	if (rc)
> +		goto disarm;
> +
> +	orig = ctrl & ~SIT9531X_DIVO_PHASE_TRIG;
> +	ctrl = orig | SIT9531X_DIVO_PHASE_SEL_REG;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);
> +	if (rc)
> +		goto disarm;

[Severity: Medium]
Elsewhere in this patch, in sit9531x_prg_enter() and in the
sit9531x_output_divo_write() rollback, a write that reports an error is
assumed to have possibly reached the part. Do the error paths here need
the same handling?

If this selector write fails but lands, goto disarm skips the restore of
orig. The chip-wide phase-trigger source then stays on the in-register
source. That is the hijacked trigger state the comment after the pulse
says must be avoided.

In the parking loop, parked |= BIT(i) is set only after
sit9531x_update_pll_u8() succeeds. If the clear on a sibling PLL fails but
lands, the unpark loop never re-arms that PLL.

If arming pll_idx fails, goto unpark skips disarm. An enable bit that
landed then stays staged on a PLL the profile left disarmed, and the next
small update on that PLL latches it.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index ebbf7f5a3394e..a576d918e68db 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -350,6 +350,29 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +static int
> +sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,
> +				      void *pin_priv,
> +				      const struct dpll_device *dpll,
> +				      void *dpll_priv, u64 *frequency,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	const struct sit9531x_ref *ref;
> +
> +	ref = sit9531x_ref_state_get(sitdpll->dev, dpin->id);
> +	*frequency = ref->freq;
> +
> +	return 0;
> +}

[Severity: Medium]
What does this report for an input that has no firmware node, or a node
without supported-frequencies-hz?

sitdev->ref[index].freq is only set in sit9531x_pin_props_get(). It comes
from freqs[0] when the node lists frequencies, or from xtal_freq for the
XO. Nothing else writes it.

sit9531x_input_pin_is_registrable() checks only the index and the DE
pairing, so inputs without frequency data are still registered.

For those pins ref->freq stays 0. Every pin-get, dump and notification
now reports a frequency of 0 Hz with no supported-frequency entries.
Before this patch the attribute was simply absent.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> index 934db566c0020..42f3e53b6def2 100644
> --- a/drivers/dpll/sit9531x/prop.c
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -295,15 +295,35 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
>  	}
>  
>  	/*
> -	 * Seed an input's runtime ref->freq with the first DT-listed
> -	 * supported frequency: for an input the board lists the rate that is
> -	 * physically wired to it first.  An output's current rate is what its
> -	 * divider produces, not an entry of the list it may be set to.
> +	 * Seed the runtime ref->freq with the first DT-listed supported
> +	 * frequency: an input's rate is a board fact, so firmware is the
> +	 * source.  An output is left to the read-back below, which knows
> +	 * what the divider is actually doing.
>  	 */
>  	if (num_freqs > 0 && dir == DPLL_PIN_DIRECTION_INPUT &&
>  	    index != SIT9531X_MAX_INPUTS)
>  		curr_freq = freqs[0];

[Severity: Medium]
With the new input frequency_get, userspace now sees this first entry as
the current input rate. Does the binding give the first entry that
meaning?

Documentation/devicetree/bindings/dpll/dpll-pin.yaml only says:

    List of supported frequencies for this pin, expressed in Hz.

The SiTime binding does not give the first entry that meaning either.

A conformant DT can list several rates for a pin that may run at any of
them, such as <10000 10000000> in the zl30731 example. This driver would
then report 10000 Hz whatever rate the input is actually driven at.

Inputs have no frequency_set, so userspace cannot correct the reported
value.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
