Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F025A5142;
	Thu, 17 Sep 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657341; cv=none; b=ABlFolkabc8bNVg75+fdE+ZEWE7Y7Br4OWTU9YX6kSVyk93pFGPv8I4W1pMqPN7hRLwOI2ON4DFuLQhJxCXze8U3fLxW0THj91+YDNARTtd+XJCyoCCbB4HOI44gqhgKIrUxlouxzP6PV5emKO3xAzrovjCinI33uRBZfTwDVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657341; c=relaxed/simple;
	bh=g26jDFJlcQqereo1ayDKu9nZGE8emxnvuH4MTxQ5UJg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GIdY4AJmm0ZHU+TA2FW/2A3ujIsTdCWu66NzVFlIsB4utPGWYwZx14UJx8ZAMifdZrm2Alx1yhHqcsgRMRd3PlkFrkPJhuOgPZK+zJGHxkOoQL/msMffysW8hbbou47eDikS3on3hNYo5O8hx70aDFlpC5AtE9qKQSt0PLTQj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbEFcl3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbEFcl3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87D91F008A3;
	Thu, 17 Sep 2026 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657317;
	bh=5o8T74nam9GpZCxQpwzEFP5okCof7TIgs57qaKDJl2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NbEFcl3vn63FUToSM8R7ZRQlASTk2W3F3UeR6BBQme9TyI5ERR5Z+l0HS12cnHeOR
	 vmL/mtky5iuUDuqQRbWip+w8pWIkYyzIsMNQ75DpY4DkuLoQljn+PSRoyRzehUSO0y
	 0ZgI6wXI0V74H1iP3TRaAy1VBfUjyMukVI/d+wNYxadYLp+Xp8DuZ4Lfpr/tvAUXky
	 9539hgeMeMtSgwRRMj8mx+S+3PSBDLBzuWJYq5mr4TVUkISAuDc9BXXFWaaTAWhGPw
	 BUJhyNmKttQPaLFaysj6y9kylePfrKRM1S9PZOREKg6BFxfMiKvq6gaF4ZPFKWstHs
	 uqY91JJJqUbdw==
Subject: Re: [PATCH net-next v9 11/15] dpll: sit9531x: add support to get and
 set esync on pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:56 +0000
Message-ID: <178965731642.22033.5267525168717933577@kernel.org>
In-Reply-To: <20260915000015.80480-12-arouhi@sitime.com>
References: <20260915000015.80480-12-arouhi@sitime.com>
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

Critical: 0 · High: 2 · Medium: 5 · Low: 0

- [High] Enabling Embedded SYNC replaces the output pin's base frequency
  with a hard-coded 10 MHz carrier and caches it as the pin's current…
- [High] The esync enable path saves the pre-esync carrier best-effort
  and never verifies it, and the disable path then skips the restore…
- [Medium] SIT9531X_ESYNC_PULSE_DEFAULT (decimal 50) is written verbatim
  into the per-output PROG0 byte, which the same patch's register map…
- [Medium] sit9531x_dpll_output_pin_esync_get() reports only the software
  cache dpin->esync_freq (and derives esync->pulse from it) and never…
- [Medium] On the esync-disable error path, when
  sit9531x_output_freq_set() fails *after* it has already reprogrammed…
- [Medium] The esync enable rollback discards both cleanup results, so a
  failed rollback leaves the hardware in embedded-sync state while…
- [Medium] sit9531x_output_esync_program() writes the output's Hi-Z
  (mute) registers inside the programming sequence and then re-reads the…

--

dpll: sit9531x: add support to get and set esync on pins

This adds esync_get and esync_set to the sit9531x output pin ops, using the
existing divider programming plus a new per-output PROG0 pulse-control
write.  Enabling embedded sync reprograms the output divider and the pulse
generator in one programming sequence; disabling it clears the pulse
control and restores a saved rate.  Only outputs whose firmware node has
esync-control accept the operations.

A few questions about the new paths below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 8d857f1a0c890..46179a9e13c32 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1654,6 +1654,103 @@ int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
>  	return rc;
>  }
>  

[ ... ]

> +int sit9531x_output_esync_program(struct sit9531x_dev *sitdev, u8 out_idx,
> +				  u8 pll_idx, u64 carrier, u8 pulse_ctrl)
> +{
> +	const struct sit9531x_chip_info *info = sitdev->info;
> +	u64 fvco, divo;
> +	bool muted;
> +	int rc, ret;
> +	u8 slot;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	rc = sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, carrier,
> +				       &fvco, &divo);
> +	if (rc)
> +		return rc;
> +
> +	slot = info->clkout_map[out_idx];
> +
> +	rc = sit9531x_prg_enter(sitdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = sit9531x_output_divo_write(sitdev, out_idx, divo);
> +	if (!rc)
> +		rc = sit9531x_output_pulse_write(sitdev, out_idx, pulse_ctrl);
> +	/*
> +	 * Keep the mute the user asked for.  Embedded sync changes what the
> +	 * output carries, not whether it is driven, so an output muted
> +	 * through pin-state stays muted.
> +	 */
> +	if (!rc)
> +		rc = sit9531x_output_hiz_write(sitdev, slot,
> +					       !sitdev->out[out_idx].enabled);
> +
> +	ret = sit9531x_prg_commit(sitdev);
> +	if (ret && !rc)
> +		rc = ret;
> +
> +	if (!sit9531x_output_forced_hiz(sitdev, out_idx, &muted))
> +		sitdev->out[out_idx].enabled = !muted;

[Severity: Medium]
Should this readback failure mark the cached mute state stale?  The other
Hi-Z writers in the driver, sit9531x_output_disable() and
sit9531x_output_enable(), do:

	state_rc = sit9531x_output_forced_hiz(sitdev, index, &muted);
	if (!state_rc) {
		sitdev->out[index].enabled = !muted;
		sitdev->out[index].state_stale = false;
	} else {
		sitdev->out[index].state_stale = true;
		if (!rc)
			rc = state_rc;
	}

core.h documents state_stale as "the cached mute state could not be
confirmed against hardware and has to be read back before it is reported",
and sit9531x_dpll_output_pin_state_on_dpll_get() only reads through when
that flag is set.  Here the error is dropped, so an unconfirmed value is
reported as authoritative.

The same cached bit is also the input to the Hi-Z write a few lines above:

	rc = sit9531x_output_hiz_write(sitdev, slot,
				       !sitdev->out[out_idx].enabled);

so can an unconfirmed cache change the drive state of an output as a side
effect of an embedded-sync request?

> +
> +	if (rc)
> +		return rc;
> +
> +	rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +	if (rc)
> +		return rc;
> +
> +	sitdev->out[out_idx].freq = div64_u64(fvco, divo);
> +
> +	/*
> +	 * The delay registers count VCO cycles against the output period in
> +	 * force when they were written, so the carrier change re-times a
> +	 * phase adjust the same way a frequency set does.
> +	 */
> +	if (sitdev->out[out_idx].phase_adj)
> +		return sit9531x_output_phase_adjust_set(sitdev, out_idx,
> +							sitdev->out[out_idx].phase_adj);
> +
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 78034b7f089cc..0cad081eb5995 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -22,9 +22,21 @@
>  #include "prop.h"
>  #include "regs.h"
>  
> -#define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL
> +#define SIT9531X_ESYNC_FREQ_1HZ	DPLL_PIN_FREQUENCY_1_HZ
> +#define SIT9531X_ESYNC_FREQ_10MHZ	DPLL_PIN_FREQUENCY_10_MHZ
>  #define SIT9531X_ESYNC_PULSE_DEFAULT	50
>  
> +static const struct dpll_pin_frequency sit9531x_esync_ranges[] = {
> +	DPLL_PIN_FREQUENCY(0),
> +	DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_1HZ),
> +};
> +

[ ... ]

> @@ -726,6 +738,12 @@ sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
>  	actual_pll = sitdev->out[dpin->id].pll_idx;
>  
>  	mutex_lock(&sitdev->multiop_lock);
> +	if (dpin->esync_freq) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		NL_SET_ERR_MSG(extack,
> +			       "Disable embedded sync on this pin before changing frequency");
> +		return -EBUSY;
> +	}
>  	rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
>  				      frequency);
>  	mutex_unlock(&sitdev->multiop_lock);

[ ... ]

> @@ -869,6 +887,138 @@ sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,
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
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
> +	if (!sit9531x_dpll_esync_pin_supported(dpin))
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	esync->range = sit9531x_esync_ranges;
> +	esync->range_num = ARRAY_SIZE(sit9531x_esync_ranges);
> +	esync->freq = dpin->esync_freq;

[Severity: Medium]
This getter reports only the software cache and never reads PROG0 back,
while the sibling sit9531x_dpll_output_pin_frequency_get() does consult the
device through sit9531x_output_freq_get().

dpin->esync_freq starts at 0 (the pin struct is zeroed at allocation and
registration only copies esync_control), so on a device whose NVM already
has the marker programmed the pin reports DPLL_A_PIN_ESYNC_FREQUENCY as 0.

Can that marker then be cleared?  The disable branch short-circuits on the
same cache:

		if (!dpin->esync_freq) {
			mutex_unlock(&sitdev->multiop_lock);
			return 0;
		}

and dpll_pin_esync_set() in dpll_netlink.c drops the request before it
reaches the driver:

	if (freq == esync.freq)
		return 0;

The new -EBUSY interlock in sit9531x_dpll_output_pin_frequency_set() keys
off the same uninitialized value, so it would not cover a DIVO change while
a marker the driver did not program itself is active.  Would seeding the
cache from PROG0 during probe address both?

> +	/*
> +	 * The hardware PROG0 byte is programmed with the same literal that the
> +	 * ABI reports as pulse percent for the supported 1 Hz mode. When esync
> +	 * is disabled, report pulse as zero to avoid implying an active marker.
> +	 */
> +	esync->pulse = dpin->esync_freq ? SIT9531X_ESYNC_PULSE_DEFAULT : 0;

[Severity: Medium]
Is one literal valid as both the register value and the ABI percentage?
The register comment added by this patch in regs.h says:

 * Per-output pulse-count control byte used in SYSREF / SYNCB modes.

while Documentation/netlink/specs/dpll.yaml defines esync-pulse as "A ratio
of high to low state of a SYNC signal pulse embedded into base clock
frequency.  Value is in percents."

SIT9531X_ESYNC_PULSE_DEFAULT is handed to sit9531x_output_pulse_write() as
the raw PROG0 byte and returned here as the percentage, with no conversion
either way.

With the 10 MHz carrier this code programs and a 1 Hz marker, half a period
would be 5000000 carrier cycles, which does not fit an 8-bit field, so the
commit message claim:

  "The pulse width is fixed at half the period, which is what the device
   produces"

does not seem expressible in a pulse-count register.  Should the percentage
be converted to a pulse count on set and back on get?

> +	mutex_unlock(&sitdev->multiop_lock);
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
> +	if (!freq) {
> +		u64 prev_freq = dpin->esync_prev_freq;
> +		u8 pulse = SIT9531X_ESYNC_PULSE_DEFAULT;
> +
> +		if (!dpin->esync_freq) {
> +			mutex_unlock(&sitdev->multiop_lock);
> +			return 0;
> +		}
> +		rc = sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, 0);
> +		if (!rc && prev_freq)
> +			rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll, prev_freq);
> +		if (rc)
> +			sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, pulse);
> +		if (!rc)
> +			dpin->esync_freq = 0;

[Severity: Medium]
Can this rollback leave the reported state disagreeing with the hardware?

sit9531x_output_freq_set() can return an error after it has already
committed the new divider: the sit9531x_output_phase_flush() step and the
trailing sit9531x_output_phase_adjust_set() both run after
sit9531x_prg_commit().  In that case the code above re-writes the marker and
leaves dpin->esync_freq at 1 Hz, so the pin advertises esync active while
the carrier is already back on the user's rate with only a stale marker.

Getting back in sync afterwards looks awkward: frequency_set is refused by
the new -EBUSY guard, and a repeated esync = 1 Hz request is discarded by
dpll_pin_esync_set() because it equals the cached value, so only repeating
the disable helps.

> +		mutex_unlock(&sitdev->multiop_lock);
> +		if (rc)
> +			NL_SET_ERR_MSG(extack,
> +				       "Failed to turn embedded sync off on this output");
> +		return rc;
> +	}
> +
> +	if (freq != SIT9531X_ESYNC_FREQ_1HZ) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		NL_SET_ERR_MSG(extack,
> +			       "Only 1 Hz embedded-sync frequency is supported");
> +		return -EINVAL;
> +	}
> +
> +	if (dpin->esync_freq == SIT9531X_ESYNC_FREQ_1HZ) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		return 0;
> +	}
> +
> +	if (!dpin->esync_freq) {
> +		/*
> +		 * Remember the carrier to restore.  The cached rate is zero
> +		 * for an output whose firmware node lists no frequency and
> +		 * which has never been set, so read the divider rather than
> +		 * leave the output parked on the esync carrier at disable.
> +		 */
> +		dpin->esync_prev_freq = sitdev->out[dpin->id].freq;
> +		if (!dpin->esync_prev_freq)
> +			sit9531x_output_freq_get(sitdev, dpin->id,
> +						 &dpin->esync_prev_freq);
> +	}

[Severity: High]
The return value of sit9531x_output_freq_get() is dropped here.  Can
esync_prev_freq stay 0 in exactly the case the comment says it must not?

sit9531x_output_freq_get() assigns *frequency only on its success path:

	if (!divo)
		return -ENODEV;

	*frequency = div64_u64(fvco, divo);

It also returns -ENODEV for an out-of-range pll_idx or unresolvable Fvco,
and propagates any I2C error from the five DIVO byte reads.  In all of those
cases esync_prev_freq keeps its prior value of 0 and the enable still goes
on to commit the esync carrier.

The disable path then skips the restore and reports success anyway:

		rc = sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, 0);
		if (!rc && prev_freq)
			rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll, prev_freq);
		...
		if (!rc)
			dpin->esync_freq = 0;

With prev_freq == 0 the divider stays on the esync carrier, the marker is
switched off, esync_freq is cleared and 0 is returned to userspace, so the
output is left running at a rate nobody asked for and nothing reports it.
The enable-failure rollback below carries the same condition.

sit9531x_output_phase_adjust_set() checks the return value of the same
helper.  Should this call check it too, and should a failed save refuse the
enable instead of continuing?

> +
> +	/*
> +	 * Carrier, marker and enable go into the device in one programming
> +	 * sequence.  Without the pulse generator (PROG0 PULSE_CTRL) the
> +	 * output would carry 10 MHz and no marker at all;
> +	 * SIT9531X_ESYNC_PULSE_DEFAULT is the duty esync_get advertises for
> +	 * the 1 Hz embedded-sync signal.
> +	 */
> +	rc = sit9531x_output_esync_program(sitdev, dpin->id, actual_pll,
> +					   SIT9531X_ESYNC_FREQ_10MHZ,
> +					   SIT9531X_ESYNC_PULSE_DEFAULT);

[Severity: High]
Enabling embedded sync here programs a fixed 10 MHz carrier instead of
adding a marker to the rate the pin is already running.  Is that the
intent?

The commit message says:

  "so enabling it sets the output to 1 Hz and disabling it restores the
   requested rate."

but the carrier passed in is SIT9531X_ESYNC_FREQ_10MHZ, so neither 1 Hz nor
the rate the user configured ends up in DIVO.

sit9531x_output_esync_program() also records that carrier as the pin rate:

	sitdev->out[out_idx].freq = div64_u64(fvco, divo);

and sit9531x_dpll_output_pin_frequency_get() reads DIVO back from the
device, so after an esync enable the pin reports 10 MHz.  The esync-control
example in Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
advertises only:

	esync-control;
	supported-frequencies-hz = /bits/ 64 <156250000>;

so the same pin would then report a current frequency that is not in its own
DPLL_A_PIN_FREQUENCY_SUPPORTED set and that frequency_set would reject.

Documentation/driver-api/dpll.rst describes Embedded SYNC as a SYNC signal
embedded into the pin's base frequency, with the capability "always related
to a given base frequency".  Would it be better to offer esync only when the
base frequency already matches what the device needs, rather than
reprogramming the base frequency as part of the esync request?

> +	if (rc) {
> +		sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, 0);
> +		if (dpin->esync_prev_freq)
> +			sit9531x_output_freq_set(sitdev, dpin->id,
> +						 actual_pll,
> +						 dpin->esync_prev_freq);
> +	}

[Severity: Medium]
Both cleanup calls have their return values discarded, and esync_freq stays
0 either way.

sit9531x_output_esync_program() can fail after the divider and PROG0 have
already been committed, since sit9531x_output_phase_flush() and
sit9531x_output_phase_adjust_set() run after sit9531x_prg_commit().  If the
two compensating writes then also fail, can the device keep the marker
enabled and the 10 MHz carrier while the driver reports esync disabled?

In that state a later esync = 0 request is dropped by dpll_pin_esync_set()
as already satisfied, so the marker cannot be cleared through the ABI.
Should a failed rollback be propagated, or the cached state marked as
unconfirmed?

> +
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Failed to program embedded sync on this output");
> +		return rc;
> +	}
> +
> +	dpin->esync_freq = SIT9531X_ESYNC_FREQ_1HZ;
> +
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> index f40762f06403b..9d515e109feb5 100644
> --- a/drivers/dpll/sit9531x/regs.h
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -230,6 +230,13 @@
>  #define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */
>  #define SIT9531X_OUT_PRG_COARSE_BITS		34
>  
> +/*
> + * Per-output pulse-count control byte used in SYSREF / SYNCB modes.
> + * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page
> + * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.
> + */
> +#define SIT9531X_OUT_PROG0_BASE		0x1B
> +

Thanks for the patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
