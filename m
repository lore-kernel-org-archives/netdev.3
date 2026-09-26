Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316136F8EF;
	Sat, 26 Sep 2026 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390101; cv=none; b=gW1nG8B3YORsobfiHWWDbeE0mwAelWZRSBjn1wUnOq752mQG2xAyg+etxjfarWQp2h+0H0WE88lXZq+MU2x8lAcY/0qsfgNRbAwN+bEpQYET3uBCMKTcdI+XlgqCT6jWzRHBMIh6XhpCVG06IpXI4HYae0iV3e4gTyA/sGP7ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390101; c=relaxed/simple;
	bh=nBtSJwB60628F1rshHK3VxI9jXZbvhPgSd47DFRpOXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxu/4YAXorxiJNZodwJFlMUyWRkzYDIN4LhI7OvFURXUF+bFEIhSJIirKorQ7wdWMbqT8V6L6D/bOj2xvR3M/eL39l5cU45xSmESGMH1kFpIrCaYPk0LjbX/C6/iC3Fi56nxPwcole0OEZLz2a3hxwVm/0ywuqw4yVRi2AUJdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri92z3In; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri92z3In"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95861F0089A;
	Sat, 26 Sep 2026 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390093;
	bh=+1+ptnfXpAtBeBNWfraAbfOKXm2NLnbq/EN2aiYlMjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ri92z3InlNgNn3iZu0hsxW3obzJINmj9D+EYp1HdIDbJwe1edl6xvozU8Ys0lNp4w
	 r6TxX2KZ3u6wvy9q/3AqcOPGh1kJUqh5j1bmixEkE768lmJuYzD7qRp/kl2cPcAI4z
	 9RQpKdEOVvc40O/Zq7UdIzYAkbPAZ7+/eUjhgQE9Ub3rXatq9IzVcETfrM/RobNhpF
	 fxKWZniY8v7mS3A5r093o3WE5y9T5cwRF9cWN3iH48MyBnImqeva+1HF96JNLp9V1Y
	 VjyBVF5ZCOOoGEiMRwJTu3MNpAJ9/szvaCfZnQlzu6wYfx2RDmWebs8X5j/OJTWOPJ
	 DcjQpSXKPNoDw==
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
Subject: Re: [PATCH v10 11/14] dpll: sit9531x: add support to get phase offset on the connected input pin
Date: Fri, 25 Sep 2026 19:34:52 -0700
Message-ID: <20260926023452.1568058-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-12-arouhi@sitime.com>
References: <20260921201108.42676-12-arouhi@sitime.com>
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
dpll: sit9531x: add support to get phase offset on the connected input pin

This adds a phase_offset_get callback for sit9531x input pins. It reads the
on-chip TDC through the per-PLL debug window and converts the code to
picoseconds using the VCO frequency. Only the input the PLL has selected
gets a measurement; other pins and dormant PLLs report zero.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index c8c3cd6a64baf..8f6f8ffc8dc13 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2314,6 +2314,221 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)

[ ... ]

> +/*
> + * sit9531x_phase_offset_read - read phase difference via TDC
> + * @phase_ps:	output phase difference in picoseconds
> + *
> + * Reads the Time-to-Digital Converter (TDC) signed 35-bit code from the
> + * PLL page registers, then converts to picoseconds using the VCO
> + * frequency: phase_diff = tdc_code / fvco.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			       s64 *phase_ps)
> +{

[Severity: Low]
This isn't a bug, but is "signed 35-bit code" accurate? The decode below
builds a 35-bit magnitude from DBG_DATA_4[2:0] through DBG_DATA_0. The sign
comes from a separate bit in DATA_4, so the field is 36-bit sign-magnitude:

	sign = !!(v & BIT(SIT9531X_TDC_SIGN_BIT));
	tdc_raw = (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;

regs.h also describes DATA_4 as "[34:32] + sign".

This header also opens with /* rather than /**. It doesn't document
@sitdev, @pll_idx or a Return: section, while
sit9531x_chan_selected_ref_read() just above it does.

[ ... ]

> +	/*
> +	 * Remember the tap selection so it can be put back.  The key
> +	 * register is re-locked below, but the mux is not part of the key:
> +	 * leaving it parked on the TDC with a slow sampling clock selected
> +	 * is a state change the caller did not ask for, and the next reader
> +	 * of a different tap would have to know to undo it.
> +	 */
> +	if (!sit9531x_read_pll_u8(sitdev, pll_idx,
> +				  SIT9531X_PLL_REG_DBG_WRITE_CODE,
> +				  &old_write_code) &&
> +	    !sit9531x_read_pll_u8(sitdev, pll_idx,
> +				  SIT9531X_PLL_REG_DBG_READ_CODE,
> +				  &old_read_code))
> +		have_old = true;
> +
> +	/*
> +	 * Select the debug clock for taps below 200 kHz, then point the
> +	 * readback at the TDC.  Only the one bit is touched: writing the
> +	 * modifier register whole would clear the fields belonging to
> +	 * other taps.
> +	 */
> +	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +				    SIT9531X_PLL_REG_DBG_WRITE_CODE,
> +				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,
> +				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);
> +	if (rc)
> +		goto relock;
> +	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
> +				   SIT9531X_PLL_REG_DBG_READ_CODE,
> +				   SIT9531X_DBG_READ_CODE_TDC);
> +	if (rc)
> +		goto relock;

[Severity: Medium]
What happens if either snapshot read fails? have_old stays false, but the
sequence continues. SIT9531X_DBG_LOW_FREQ_CLK_BIT is still set in WRITE_CODE,
and SIT9531X_DBG_READ_CODE_TDC is still written to READ_CODE.

The restore at the relock label below is then skipped because have_old is
false. The PLL is left with the mux parked on the TDC and the slow sampling
clock selected, which is the state the comment above says must not be left
behind.

The next successful call then snapshots this modified state and restores to
it, so the change is never undone.

Separately, the two restore sit9531x_write_pll_u8() calls at relock ignore
their return values. A failed restore still lets the function return 0.

The v10 notes say "Restored the debug tap selection the read changes".
Should a failed snapshot abort before the tap is modified? Should restore
errors be folded into rc?

In this series, sit9531x_dbg_sample() reprograms both registers itself, so
no in-driver reader currently sees the wrong tap.

[ ... ]

> +	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +	if (rc) {
> +		if (rc == -ENODATA)
> +			dev_dbg(sitdev->dev,
> +				"PLL%c: Fvco unknown, skip TDC\n",
> +				'A' + pll_idx);
> +		goto relock;
> +	}

[ ... ]

> +relock:
> +	if (have_old) {
> +		sit9531x_write_pll_u8(sitdev, pll_idx,
> +				      SIT9531X_PLL_REG_DBG_READ_CODE,
> +				      old_read_code);
> +		sit9531x_write_pll_u8(sitdev, pll_idx,
> +				      SIT9531X_PLL_REG_DBG_WRITE_CODE,
> +				      old_write_code);
> +	}
> +

[ ... ]

> +	lock_rc = sit9531x_write_pll_u8(sitdev, pll_idx,
> +					SIT9531X_PLL_REG_DEBUG,
> +					SIT9531X_PLL_DEBUG_LOCK);
> +	if (lock_rc && !rc)
> +		rc = lock_rc;
> +
> +	return rc;
> +}

[Severity: Medium]
On a dormant PLL, can a bus error still reach user space as a valid zero
reading?

sit9531x_get_fvco() runs only after the debug window has been unlocked, the
tap reprogrammed, the trigger read and DATA_4..DATA_0 read. When it returns
-ENODATA, the code jumps to relock with rc == -ENODATA.

The restore writes there ignore their errors. A failed lock write is also
dropped, because rc is already nonzero when this runs:

	if (lock_rc && !rc)
		rc = lock_rc;

The function returns -ENODATA. sit9531x_dpll_input_pin_phase_offset_get()
then turns that into success:

	if (rc == -ENODATA) {
		*phase_offset = 0;
		return 0;
	}

The PLL debug key can stay unlocked, and the tap may stay parked on the TDC,
while user space sees a successful 0.

sit9531x_dpll_selection_state_get() doesn't check chan->active. A dormant PLL
with a populated priority table can therefore pass the gate in the caller.

The v10 notes say "Gave the dormant-PLL case its own errno, so a bus error is
not reported as a valid zero reading."

Would it close this gap to check Fvco before opening the debug window, and
to fold lock and restore errors into rc whatever its previous value?

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index af1089f192b6f..5f7c2d01562c9 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -638,6 +638,123 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>  	return 0;
>  }
>  
> +/*
> + * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference
> + *

[ ... ]

> + * Precondition, which this callback cannot create: the TDC compares
> + * against a signal the PLL drives, so a PLL driving no output with its
> + * zero-delay buffer off has nothing to measure.  SiTime confirms this is
> + * a property of the hardware rather than of their measurement script.
> + * The script satisfies it by mapping a spare output and restarting the
> + * PLL -- side effects that do not belong in a getter, so a reading taken
> + * in that state is simply not meaningful.

[Severity: Medium]
If a reading in this state is not meaningful, what stops it from being
published?

Before sit9531x_phase_offset_read() runs, the only checks are the cached
CONNECTED state, the live ACTIVESEL match and the -ENODATA dormant-DIVN
case.

Take a PLL with a programmed DIVN and a selected reference but no routed or
enabled output. The TDC is still sampled. The value is scaled by
DPLL_PHASE_OFFSET_DIVIDER and returned as a valid DPLL_A_PIN_PHASE_OFFSET.
User space can't tell it apart from a real measurement.

The driver already tracks output routing in struct sit9531x_out (routed,
pll_idx, enabled). sit9531x_out_state_fetch() fills these from the OUT_MAP
registers and the Hi-Z force bits. From the code it isn't clear whether a
Hi-Z output counts as driving for the TDC, and ZDB state isn't tracked. The
no-routed-output case does look detectable, though.

Could the callback report 0 when the PLL drives no output, as it does for
the dormant-DIVN case?

The commit message doesn't mention this limitation, and it describes the
value as "the measurement".

[ ... ]

> +	/*
> +	 * Which pin the sample belongs to is read from the device rather
> +	 * than taken from the monitor's cache: the device selects its own
> +	 * reference, so a cache up to a poll period old could attribute a
> +	 * live measurement to the pin that used to be selected.
> +	 */
> +	rc = sit9531x_chan_selected_ref_read(sitdev, sitdpll->id,
> +					     &selected);

[ ... ]

> +	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, &state);
> +	if (state != DPLL_PIN_STATE_CONNECTED || selected != dpin->id) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		*phase_offset = 0;
> +		return 0;
> +	}

[Severity: Low]
Does this match the comment above it? The gate still needs
sit9531x_dpll_selection_state_get() to return CONNECTED, and that result
comes from the cached chan->selected_ref and chan->mode:

	active_input = !chan->mode && chan->selected_ref == pin_id;

So the live ACTIVESEL read can only veto a sample. It doesn't decide which
pin gets it.

Suppose the device switches from IN0 to IN1 on its own. IN0 reports 0
because the live value no longer matches. IN1 also reports 0 because the
cache still says SELECTABLE. This lasts until the next
sit9531x_dev_periodic_work() poll refreshes the cache.

No wrong value is published. However, this comment and the
sit9531x_chan_selected_ref_read() kernel-doc ("close enough for reporting
pin state but not for attributing a measurement") both describe live-only
attribution.

Could the comments be updated to say that both the cached state and the live
read are required?

> +
> +	rc = sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: Low]
Can the device fail over between the ACTIVESEL read above and the TDC latch?

Before the three SIT9531X_PLL_REG_DBG_TRIGGER reads latch the sample,
sit9531x_phase_offset_read() does several I2C transactions: the unlock, two
snapshot reads, the write-code update and the read-code write.
multiop_lock serialises the driver's accesses, but not the device's own
reference selection.

If the device switches reference in that window, the TDC samples against
the new reference. The result is then published as the old pin's phase
offset. This is the case the v10 change targets, now limited to a few
milliseconds.

Would re-reading ACTIVESEL after the latch, and reporting 0 on a mismatch,
close this?

[ ... ]
