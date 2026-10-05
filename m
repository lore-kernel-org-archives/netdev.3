Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B82931C3;
	Mon,  5 Oct 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162611; cv=none; b=Pra9m0TjfxqVCvr6LHM/JL0LsZnGaml+iER4swCYQr82LAoLVLGUwWcsMJZNq8hFbJcQjC6E9PSC72rMoHl6rhFscL+Xjl7M88l4OOw6hOuMtLRe50q7QQnkivycWgETUoKgTNLfpgayFRe1yfFICYc5Fg9tEP/s0xIf0iVSFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162611; c=relaxed/simple;
	bh=KG81GEkuiimvmbv1kT7ZRfCF715YCa/8GQxmpoIdGMI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZrSYPk5HvZaP5vgtNuDRUsNTc2lPtQJQOQT7/w2TUzlGF68zbX73j3wPf8wmGwTTaoX+K3QjVvlLnEL0hqDJsPUSrQbRDRRG9szCxJGRrmWdIWPapk2BtL9ay2FtzdVTR0MF0TCX2h7F+ztqlLR9gqyMj+8clmvWwE8YPF5eMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgsLselm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgsLselm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B086D1F0089B;
	Mon,  5 Oct 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162609;
	bh=wsc8Q36lXhW263OckMuURIkD4HTXSNY+q91CBmbz3D8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hgsLselmegzAlLplSnQyPVthdBrqZ1RoH/Gc236pD9zY2nKFzleeG8cCiIb5nP7Uh
	 bKeVwHtlPiODaT8fQKmR9JZPhWh2tnAxuyGTkTmUP0qyr3o+Z6Mohm98BBAUpbLrJb
	 nMJlgOVNSWnICvjpkztw5J4uav3A5C5MJ3ie1n1vfZ30Bn756c9evhPoxYj0d8wgng
	 mbUGv76kVqS/tcw3TzH5gA/K049Cqm618MWm8fqvyxCCP3+gKgR9paveGP1DzP5m0O
	 1QC9Oqv3/Ez7poidHBx1wTJx3RVo3CwtowyvjyC+niPLrgP+FWL+joyCPGZiu+QVks
	 CsWKXjc0yyPYQ==
Subject: Re: [PATCH net-next v11 12/13] dpll: sit9531x: add support to get
 phase offset on the connected input pin
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 01:10:08 +0000
Message-ID: <179116260823.434549.634351809975661119@kernel.org>
In-Reply-To: <20260930233714.87679-13-arouhi@sitime.com>
References: <20260930233714.87679-13-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_phase_offset_read() (core.c:2957) computes
  mul_u64_u64_div_u64(|tdc|, 1e12, fvco) with no limit on the quotient,…
- [Medium] sit9531x_dpll_input_pin_phase_offset_get() (dpll.c:681-684)
  decides whether the PLL drives an output, which the TDC needs, by…
- [Medium] The live checks in sit9531x_dpll_input_pin_phase_offset_get()
  (dpll.c:693 and 698) are meant to stop a TDC sample being credited to…
- [Low] In drivers/dpll/sit9531x/dpll.c,
  sit9531x_dpll_input_pin_phase_offset_get() sets *phase_offset = 0 in…
- [Low] sit9531x_phase_offset_read() in drivers/dpll/sit9531x/core.c
  (line 2957) converts the TDC code to whole picoseconds with integer…

--

dpll: sit9531x: add support to get phase offset on the connected input pin

This adds a phase_offset_get callback for sit9531x input pins. It reads
the on-chip TDC through the PLL debug window and converts the code to
picoseconds using the VCO rate. Only the input a PLL currently has
selected reports a measurement, and other pins report zero.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index d2719ff24249f..45baa703aa45b 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2760,6 +2760,235 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)

[ ... ]

> +int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       s64 *phase_ps)
> +{

[ ... ]

> +	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +	if (rc) {
> +		if (rc == -ENODATA)
> +			dev_dbg(sitdev->dev,
> +				"PLL%c: Fvco unknown, skip TDC\n",
> +				'A' + pll_idx);
> +		return rc;
> +	}

[ ... ]

> +	/*
> +	 * phase_diff (seconds) = tdc_code / fvco
> +	 * phase_diff (ps) = tdc_code * 1e12 / fvco
> +	 *
> +	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing
> +	 * by whole MHz instead would lose up to ~40 ppm of scale on a
> +	 * fractional-DIVN Fvco.
> +	 */
> +	mag_ps = mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,
> +				     1000000000000ULL, fvco);
> +	*phase_ps = tdc_signed < 0 ? -(s64)mag_ps : (s64)mag_ps;

[Severity: Medium]
What limits the size of the quotient here?

tdc_raw comes from DBG_DATA_4..0 and can be as large as 2^35 - 1. The
only requirement on fvco is that it is non-zero. For an out-of-band
rate, sit9531x_get_fvco() warns once and still returns success:

	if (*fvco < fvco_min || *fvco > fvco_max)
		dev_warn_once(sitdev->dev, ...);

	return 0;

Also, sit9531x_divn_static() accepts int_part = 0 with any |NUM| < DEN,
so DIVN can be far below 1.

With a 48 MHz XO and DIVN below about 4e-5, fvco falls under about
1.86 kHz. At that point |tdc| * 1e12 / fvco no longer fits in u64.

On x86_64, mul_u64_u64_div_u64() is an inline mulq/divq. Its comment in
arch/x86/include/asm/div64.h says it "Will generate an #DE when the
result doesn't fit u64". Could a DPLL_CMD_PIN_GET or a pin notification
then oops with a divide error?

Less extreme rates also give wrong values. Below about 3.7 kHz, the
(s64) cast flips the sign. Below about 3.7 MHz, this line in
sit9531x_dpll_input_pin_phase_offset_get() overflows s64:

	offset *= DPLL_PHASE_OFFSET_DIVIDER;

This needs DIVN registers that read as a tiny fraction on a PLL that also
reports lock, so it may not happen in practice. Still,
sit9531x_divn_static() already guards the same x86 case for the NUM/DEN
pair ("a divide-error exception on x86, not a value a caller could
reject").

Should the TDC conversion get a similar bound, for example by rejecting
an fvco outside the VCO band? Later patches in the series don't appear to
change this code.

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 8a5e3a1decd06..6bf4efd3c6334 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -605,6 +605,135 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,

[ ... ]

> +static int
> +sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,
> +					 void *pin_priv,
> +					 const struct dpll_device *dpll,
> +					 void *dpll_priv, s64 *phase_offset,
> +					 struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	for (i = 0; i < sitdev->info->num_outputs; i++)
> +		if (sitdev->out[i].routed && sitdev->out[i].enabled &&
> +		    sitdev->out[i].pll_idx == sitdpll->id)
> +			drives = true;

[Severity: Medium]
Should this loop check sitdev->out[i].state_stale?

When the sit9531x_output_forced_hiz() readback fails after the commit,
sit9531x_output_enable() and sit9531x_output_disable() set state_stale
and keep the old enabled value. The Hi-Z writes may still have taken
effect:

		/*
		 * The writes may well have landed; what failed is the proof.
		 * Mark the cached state for a read-through rather than
		 * reporting the value it had before this call.
		 */
		sitdev->out[index].state_stale = true;

sit9531x_dpll_output_pin_state_on_dpll_get() handles this by calling
sit9531x_output_state_refresh() first, because output state is never
polled.

Say a disable of this PLL's last enabled output takes effect but its
readback fails. Then drives stays true, and a sample that the callback
comment calls not meaningful gets published.

In the matching enable case, drives stays false and real readings are
reported as 0. Since nothing polls output state, either case lasts until
something else refreshes that output.

Could stale outputs be refreshed here too, the way the output pin getter
does it?

> +
> +	if (!drives ||
> +	    !sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		*phase_offset = 0;
> +		return 0;
> +	}
> +
> +	rc = sit9531x_chan_selected_ref_read(sitdev, sitdpll->id,
> +					     &selected);
> +	if (!rc && selected == dpin->id) {
> +		rc = sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);
> +		if (!rc)
> +			rc = sit9531x_chan_selected_ref_read(sitdev,
> +							     sitdpll->id,
> +							     &selected);
> +		if (!rc && selected != dpin->id)
> +			rc = -ENODATA;
> +	} else if (!rc) {
> +		rc = -ENODATA;
> +	}

[Severity: Medium]
Do these two live reads catch the case they are meant to catch?

Both reads only look at CLK_ACTIVESEL_PLL, through
sit9531x_chan_selected_ref_read(). Lock, outer loop, holdover freeze and
LOS all come from the poll cache checked in
sit9531x_dpll_selection_active(), and that cache can be up to one poll
period old.

The comment in sit9531x_dpll_selection_active() says CLK_ACTIVESEL does
not show the device's own fallback away from a lane with no signal:

	/*
	 * A selection naming a lane without signal is not what the PLL runs
	 * on: the device has fallen back to another listed source on its
	 * own, and this driver does not read which.  ...
	 */

Suppose the selected input loses signal after the last poll, or the PLL
loses lock or enters holdover. Wouldn't both reads still return dpin->id?
If so, the residual against another source, or the holdover drift, would
be published as this pin's phase offset.

The callback comment says the live read exists because "a cache up to a
poll period old could attribute a live measurement to the pin that used
to be selected". Should lock, holdover and LOS for this pin also be read
live around the sample? Later patches in the series don't appear to
change this code.

> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	/*
> +	 * -ENODATA means no reading: the PLL has no known VCO rate, or the
> +	 * selection moved off this pin around the sample.  Report 0 so a
> +	 * full pin-get dump does not fail over it.  Every other errno,
> +	 * -ENODEV from a vanished adapter included, is a failure.
> +	 */
> +	if (rc == -ENODATA) {
> +		*phase_offset = 0;
> +		return 0;
> +	}

[Severity: Low]
The commit message says:

    Only the input a PLL has actually selected has a phase offset against it.
    For any other pin there is nothing to measure and zero is reported,
    because the core abandons an entire pin dump on an error from any one pin.

Here and in the early return above, the selected pin can also report 0:

  - sit9531x_dpll_selection_active() sees the PLL unlocked, with the
    outer loop off, or frozen
  - no routed and enabled output belongs to this PLL
  - sit9531x_get_fvco() returns -ENODATA
  - the selection changes during the sample

The stated reason holds. dpll_msg_add_phase_offset() returns any callback
error directly, and only dpll_msg_add_ffo() treats -ENODATA as "omit".
zl3073x also reports 0 when the DPLL is not locked to the reference, and
the callback comments here list each case.

Could the commit message also say that the connected pin reads 0 when no
sample was taken? That way a 0 on that pin isn't taken as a measured
value.

[ ... ]

> +	/*
> +	 * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIVIDER
> +	 * picoseconds: the integer part of the attribute is the value divided
> +	 * by the divider, the remainder is the fraction.  The TDC resolves one
> +	 * VCO period (hundreds of picoseconds), so the fractional digits are
> +	 * always zero here, but the magnitude still has to be scaled or every
> +	 * reading would be reported a thousand times too small.
> +	 */
> +	offset *= DPLL_PHASE_OFFSET_DIVIDER;

[Severity: Low]
Is the reason given in this comment accurate? One TDC code is
1e12 / fvco ps, which is usually not a whole number. A 4.9152 GHz VCO
gives about 203.45 ps per code, and a fractional-DIVN Fvco is usually
not a round value either.

The fractional digits are always zero because sit9531x_phase_offset_read()
truncates to whole picoseconds before this multiply:

	mag_ps = mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,
				     1000000000000ULL, fvco);

Documentation/driver-api/dpll.rst defines a 3-digit fractional part for
this value. Could the conversion compute |tdc| * 1e15 / fvco, with an
overflow bound, so the fraction is kept? If not, could the comment be
corrected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930233714.87679-1-arouhi%40sitime.com
