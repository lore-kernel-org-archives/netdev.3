Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE653FD38;
	Tue,  8 Sep 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871526; cv=none; b=UeqFIHsQGGLXlIhsz9GPgcNSlsOY4XL8ZpYe24Mt/LF0dAo2hbHd3HEr0MxPOg7wgguQwj748xPLVwPLCmyAVx1kI35uaS21OW7x3bjTMFkck0cQPX7x1hC4VExA1oRV098aI/ml5NF0BNOzpr7iLrdpnEs9ilN1yZCteiCY5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871526; c=relaxed/simple;
	bh=o9//Zvowba5ACwSaJ0qqjcRyePOgiU+gUT9aDjQq65A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMRP7H/lAtylDjhBgNbmKzCBqQlBbZtlIJEZJtUG7THX9uV4Zklc+Qzq4kub8kzuUCjEt+yCL13sAVkKUXJl5DHmTq+vQPOPwBEpGjaYhJY79eIbN75/pu7JfVTaxanyhH0UVzozV2m3Qznouu7M4QkZbKWexGzcQXOxvZDprDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/+pkSk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/+pkSk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0491F00A3D;
	Tue,  8 Sep 2026 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871522;
	bh=EDt+w+jiSPPn6CedZQOGjUlvMXhfu48L07YuXdL4N6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X/+pkSk2thbQ5fFX8EpbrLfV1kQ9i/b983fh86r1Nyut1/fyzx5uu7yXs7/emIhGr
	 KXejV2V0kdgcUiBs+hzG4uzdCFy3Y1ap34BBvxfIVRq4+Ax+evQvv3AfxGUMK233GE
	 Wr4n0DcjyyYTTAD/rr0p+/w1J0q/l47Pz386BDyrhJPeAXCwNf1d4Q0BzxWmzxibEn
	 8oOkfHvxWWT19+KvuEmyBfb1dq3kjoi5v3fcpFo7mKlMtaWjDctUPHWrpgtfIybQef
	 OEjTBHIHGuoFcg16XkEMy6YX5LEc1LDtliD7lmi9Sm6tpqiUnUIojKWE9cxxxHvOKV
	 Lc1exQ3b9TIHg==
Subject: Re: [PATCH net-next v8 11/15] dpll: sit9531x: add support to get and
 set esync on pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:21 +0000
Message-ID: <178887152134.219967.16181634650893462486@kernel.org>
In-Reply-To: <20260902214030.20955-12-arouhi@sitime.com>
References: <20260902214030.20955-12-arouhi@sitime.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 3 · Low: 2

- [High] Embedded-sync frequency is implemented as the output's carrier
  frequency.
- [High] sit9531x_dpll_output_pin_esync_set() is asymmetric and destroys
  the only record of the pin's previous rate.
- [Medium] sit9531x_dpll_output_pin_esync_get() reports esync state from
  an unsynchronized software cache: it returns dpin->esync_freq and a…
- [Medium] The uAPI duty-cycle percentage constant is written verbatim
  into a hardware register field.
- [Medium] The esync enable path chains three independently committed
  hardware transactions with no rollback: sit9531x_output_freq_set()…
- [Low] sit9531x_dpll_output_pin_esync_get() reports esync->pulse = 50
  unconditionally, including when it reports esync->freq == 0 (embedded…
- [Low] The new PROG0 write is wrapped in its own
  prg_enter()/prg_commit() window even though PROG0 lives in the same…

--

dpll: sit9531x: add support to get and set esync on pins

This adds esync_get and esync_set callbacks to the sit9531x output pin ops
and a new core helper that programs the per-output ODRn_PROG0 pulse control
byte.  Only outputs flagged as esync-control accept the operations, the
rest return -EOPNOTSUPP.

No Link: tags are present in the commit header.

A few questions below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index be033d7cfe7c..c93578f3b750 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1535,6 +1535,57 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte
> + * @out_idx:	logical output index (translated to chip slot internally)
> + * @pulse_ctrl:	8-bit PULSE_CTRL value (PROG0)
> + *
> + * Writes ODRn_PROG0 on the output page (Page 3 for slots 0..5,
> + * Page 4 for slots 6..11) at offset 0x1B + 16 * (slot % 6).
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
> +				   u8 out_idx, u8 pulse_ctrl)
> +{
> +	const struct sit9531x_chip_info *info = sitdev->info;
> +	u8 slot, page, reg;
> +	int rc, ret;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (out_idx >= info->num_outputs)
> +		return -EINVAL;
> +
> +	slot = info->clkout_map[out_idx];
> +	page = (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
> +		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
> +	reg = SIT9531X_OUT_PROG0_BASE +
> +	      SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);
> +
> +	/*
> +	 * PROG0 lives in the output system, so like the DIVO and
> +	 * PRG_RST_DELAY writes it only takes effect inside the PRG_CMD
> +	 * programming state committed to the NVM shadow.
> +	 */
> +	rc = sit9531x_prg_enter(sitdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, reg), pulse_ctrl);

[Severity: Medium]
Is any conversion needed between the value passed in as pulse_ctrl and the
hardware field?  The only caller passes SIT9531X_ESYNC_PULSE_DEFAULT, which
is decimal 50, and the same constant is handed to userspace as esync->pulse
in sit9531x_dpll_output_pin_esync_get().  The uAPI unit for that attribute
is percent:

Documentation/netlink/specs/dpll.yaml
        name: esync-pulse
        type: u32
        doc: |
          A ratio of high to low state of a SYNC signal pulse embedded
          into base clock frequency. Value is in percents.

The new regs.h comment in this patch describes the same register as a pulse
count byte for SYSREF / SYNCB modes and defines no field masks, so it looks
like one constant is being used both as a uAPI percentage and as a raw
register value.  Which of the two is it?

Separately, this is an unmasked full-byte write with no read-modify-write.
The neighbouring PROG6 programming in sit9531x_output_phase_adjust_set()
does preserve the upper bits:

	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */
	rc = sit9531x_read_u8(sitdev, SIT9531X_REG(page, base), &prog6_val);
	...
	prog6_val &= SIT9531X_OUT_PRG_OPSTG_MASK;

Can writing all eight bits of ODRn_PROG0 clear other fields in that byte
that the initial config blob programmed?

> +
> +	/*
> +	 * Always leave the PRG_CMD state via prg_commit(), even if the write
> +	 * failed, so the output loops are re-locked rather than stranded
> +	 * unlocked; keep the first error.
> +	 */
> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	return rc;
> +}

[Severity: Low]
This isn't a bug, but the comment above states PROG0 shares the PRG_CMD
programming state with the DIVO and PRG_RST_DELAY writes, so could this
byte be written inside the window sit9531x_output_freq_set() already opens?

As written, one call to sit9531x_dpll_output_pin_esync_set() runs three
separate windows:

  sit9531x_output_freq_set()        -> prg_enter()/prg_commit()
  sit9531x_output_pulse_ctrl_set()  -> prg_enter()/prg_commit()
  sit9531x_output_enable()          -> prg_enter()/prg_commit()

and sit9531x_prg_commit() issues UPDATE_NVM, then LOOP_LOCK, then an
unconditional msleep(100), so that is roughly 300 ms of multiop_lock hold
time plus three unlock/relock cycles of the output loops on a live output.

>  /*
>   * sit9531x_ref_state_fetch - read input reference status from hardware
>   * @index:	logical input index
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index c07fb2256510..76d7d7d21d3d 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -25,6 +25,17 @@
>  #define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL
>  #define SIT9531X_ESYNC_PULSE_DEFAULT	50
>  
> +static const struct dpll_pin_frequency sit9531x_esync_ranges[] = {
> +	DPLL_PIN_FREQUENCY(0),
> +	DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_10MHZ),
> +};

[Severity: High]
Is the embedded sync frequency here the marker rate or the carrier rate?

The dpll uAPI describes DPLL_A_PIN_ESYNC_FREQUENCY as a signal embedded
into the pin's separately configured base clock:

Documentation/netlink/specs/dpll.yaml
        name: esync-frequency
        type: u64
        doc: |
          Frequency of Embedded SYNC signal. If provided, the pin is configured
          with a SYNC signal embedded into its base clock frequency.

This range advertises 0 and 10 MHz as the acceptable esync frequencies, and
sit9531x_dpll_output_pin_esync_set() then feeds the accepted 10 MHz into
sit9531x_output_freq_set(), which programs the DIVO output divider, i.e.
the base clock of the pad.  A 1 PPS esync request is rejected with -EINVAL.

For comparison, ice_dpll_output_esync_get() treats 10 MHz as the required
base frequency and reports the marker rate separately:

	if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_ABILITY) ||
	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ)
		return -EOPNOTSUPP;
	...
		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;

The driver's own binding example also pairs esync-control with a base rate
that esync_set would overwrite:

Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
    pin@0 {
        reg = <0>;
        label = "clkout0";
        esync-control;
        supported-frequencies-hz = /bits/ 64 <156250000>;
    };

Enabling esync on that pin changes the pad from 156.25 MHz to 10 MHz.  Is
that intended?

The changelog says:

  "On this device that is the same divider programming as a frequency
  change plus the per-output pulse control, so enabling it sets the output
  to 1 Hz and disabling it restores the requested rate."

That does not seem to match the code: the only accepted non-zero value is
10 MHz, not 1 Hz, and the freq == 0 path only calls
sit9531x_output_disable() rather than restoring a rate.  Could the
changelog be adjusted to describe what the code does?

> +
> +static inline bool
> +sit9531x_dpll_esync_pin_supported(const struct sit9531x_dpll_pin *dpin)
> +{
> +	return dpin->esync_control;
> +}
> +
>  static inline bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_pin *pin)
>  {
>  	return pin->dir == DPLL_PIN_DIRECTION_INPUT;
> @@ -785,6 +796,92 @@ sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,
>  	return 0;
>  }
>  
> +static int
> +sit9531x_dpll_output_pin_esync_get(const struct dpll_pin *pin,
> +				   void *pin_priv,
> +				   const struct dpll_device *dpll,
> +				   void *dpll_priv,
> +				   struct dpll_pin_esync *esync,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +
> +	if (!sit9531x_dpll_esync_pin_supported(dpin))
> +		return -EOPNOTSUPP;
> +
> +	esync->range = sit9531x_esync_ranges;
> +	esync->range_num = ARRAY_SIZE(sit9531x_esync_ranges);
> +	esync->pulse = SIT9531X_ESYNC_PULSE_DEFAULT;
> +	esync->freq = dpin->esync_freq;

[Severity: Medium]
Can dpin->esync_freq go stale here?  Unlike
sit9531x_dpll_output_pin_frequency_get(), this getter does no DIVO or
PROG0 readback, and dpin->esync_freq is written only by esync_set().

Two writers of the same divider leave it inconsistent:

  sit9531x_dpll_output_pin_frequency_set()
     -> sit9531x_output_freq_set(sitdev, dpin->id, actual_pll, frequency)

  sit9531x_dpll_output_pin_state_on_dpll_set(DISCONNECTED)
     -> sit9531x_output_disable(sitdev, dpin->id)

Neither clears dpin->esync_freq, so after pin_set(esync-frequency=10000000)
followed by pin_set(frequency=25000000) a pin dump still advertises an
embedded sync configuration the device is no longer producing.  Note that
dpll_pin_set_from_nlattr() handles DPLL_A_PIN_FREQUENCY and
DPLL_A_PIN_ESYNC_FREQUENCY independently in message order, so both can
arrive in one request.

Userspace also cannot repair the stale value, because dpll_pin_esync_set()
consults the getter first:

drivers/dpll/dpll_netlink.c:dpll_pin_esync_set() {
	...
	if (freq == esync.freq)
		return 0;
	...
}

so a repeat request for the cached value is acked without the driver
callback running.

Also, sit9531x_dpll_pin_register() copies only the capability flag:

	pin->esync_control = props->esync_control;

so an output that the efuse/NVM blob already programmed for esync reads
back as disabled.  Should the getter read the hardware instead?

[Severity: Low]
Should esync->pulse be reported as 0 when esync->freq is 0?  As written a
pin dump on a never-configured esync-control output reports
DPLL_A_PIN_ESYNC_FREQUENCY = 0 together with DPLL_A_PIN_ESYNC_PULSE = 50,
i.e. a 50 percent pulse ratio for a signal that is not present.  Both
ice_dpll_output_esync_get() and zl3073x_dpll_output_pin_esync_get() zero
both fields in the disabled case:

	} else {
		esync->freq = 0;
		esync->pulse = 0;
	}

> +
> +	return 0;
> +}
> +
> +static int
> +sit9531x_dpll_output_pin_esync_set(const struct dpll_pin *pin,
> +				   void *pin_priv,
> +				   const struct dpll_device *dpll,
> +				   void *dpll_priv,
> +				   u64 freq,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	u8 actual_pll;
> +	int rc;
> +
> +	if (!sit9531x_dpll_esync_pin_supported(dpin)) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Embedded sync not enabled for this pin");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	actual_pll = sitdev->out[dpin->id].pll_idx;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	/*
> +	 * This output is a dedicated embedded-sync pin.
> +	 * Treat freq=0 as a request to disable the entire output.
> +	 */
> +	if (!freq) {
> +		rc = sit9531x_output_disable(sitdev, dpin->id);
> +		if (!rc)
> +			dpin->esync_freq = 0;
> +		mutex_unlock(&sitdev->multiop_lock);
> +		return rc;
> +	}

[Severity: High]
Where is the pin's previous output rate saved so this path can restore it?

The enable path below calls sit9531x_output_freq_set(), which reprograms
DIVO and also replaces the cached rate:

drivers/dpll/sit9531x/core.c:sit9531x_output_freq_set() {
	...
	sitdev->out[out_idx].freq = (u32)div64_u64(fvco, divo);
}

and sit9531x_output_disable() touches only the Hi-Z bits:

	/* Take control (MASK=1) and mute (STATE=0) on both DIFF and SE */

Neither struct sit9531x_dpll_pin nor struct sit9531x_out holds the
pre-esync frequency or the previous PROG0 byte, and
sit9531x_output_pulse_ctrl_set() never reads PROG0 back, so after an
enable/disable cycle the rate userspace originally configured appears to be
gone from both hardware and driver state.

Does a following pin_set(state=connected) then un-mute the pad at 10 MHz
with the esync pulse still armed?

drivers/dpll/sit9531x/dpll.c:sit9531x_dpll_output_pin_state_on_dpll_set() {
	case DPLL_PIN_STATE_CONNECTED:
		rc = sit9531x_output_enable(sitdev, dpin->id);
	...
}

while sit9531x_dpll_output_pin_esync_get() reports esync->freq == 0.

> +
> +	if (freq != SIT9531X_ESYNC_FREQ_10MHZ) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		NL_SET_ERR_MSG(extack,
> +			       "Only 10 MHz esync frequency is supported");
> +		return -EINVAL;
> +	}
> +
> +	rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
> +				      SIT9531X_ESYNC_FREQ_10MHZ);
> +	/*
> +	 * Program the pulse generator (PROG0 PULSE_CTRL) so the embedded-sync
> +	 * pulse is actually emitted; without it the output carries the clock
> +	 * but no esync marker.  SIT9531X_ESYNC_PULSE_DEFAULT is the same duty
> +	 * the esync_get callback advertises.
> +	 */
> +	if (!rc)
> +		rc = sit9531x_output_pulse_ctrl_set(sitdev, dpin->id,
> +						    SIT9531X_ESYNC_PULSE_DEFAULT);
> +	if (!rc)
> +		rc = sit9531x_output_enable(sitdev, dpin->id);
> +
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (!rc)
> +		dpin->esync_freq = SIT9531X_ESYNC_FREQ_10MHZ;
> +
> +	return rc;
> +}

[Severity: Medium]
What happens if the second or third step here fails?

Each of the three calls commits independently: sit9531x_output_freq_set()
writes DIVO and runs prg_commit() with UPDATE_NVM plus LOOP_LOCK, and
sit9531x_output_pulse_ctrl_set() opens its own PRG_CMD window, so this is
not one transaction.  If sit9531x_output_pulse_ctrl_set() or
sit9531x_output_enable() returns an I2C or regmap error, the divider change
stays committed and nothing is unwound.

Since dpin->esync_freq is only assigned when all three steps return 0, the
driver then reports esync as disabled on a pin whose carrier has already
been changed to 10 MHz.  Is that state recoverable through this attribute?
dpll_pin_esync_set() short-circuits on the cached value:

	if (freq == esync.freq)
		return 0;

so a follow-up request for freq == 0 matches the stale cached 0 and never
reaches the driver.

There is also a window between the frequency commit and the PROG0 commit
where an already-enabled output emits the new rate with no marker.

>  static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {

[ ... ]

> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index 91d33abd15c3..251c98dc7cbe 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -215,6 +215,13 @@
>  #define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */
>  #define SIT9531X_OUT_PRG_COARSE_BITS		34
>  
> +/*
> + * Per-output pulse-count control byte used in SYSREF / SYNCB modes.
> + * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page
> + * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.
> + */
> +#define SIT9531X_OUT_PROG0_BASE		0x1B

The comment says this byte applies in SYSREF / SYNCB modes.  The new esync
path does not select either mode, so does the write take effect at all in
the mode the output is left in?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
