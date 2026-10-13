Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03111395AE2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884616; cv=none; b=tl+gySikoxiOwRPkNB8FCBITTmWMr1S4Z0/vEajnDAIlPwJMIv5Q3xT62x/nY08VLaPSol2n8fNnXOX7EV++bgoXwzGJpeyi22waRXbTMDuGEmWsGT5328QJduzwuw1N5AxeiyM7e7eQCSsR1HHi2UF8IEJAUvksUOGVK2Ur0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884616; c=relaxed/simple;
	bh=ub7ZEpUHtvYeivW9fAgWQWL5129JUSXbMjMSp7ZqxAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC6JEkBSmEL9IkG3iVKGYfJhGHnWAlxmMVziiYLzEwyrJLLoMMyOF5CveH+EMCKmCdd81VtYhLSNGn9KjvLklTxTdmlX84FXkIDIlkHK2pDua1Yn+NZ7jmh6y4BgG7P3yVNRO3y5sfp0ToWYDkGrlCGuf5zNrRGfVxuf9iTDg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYSYw1gL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYSYw1gL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791884611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWiVHxFHjNnvrrK45qJZI900Y5vgE9ig6RZT1mO8pnA=;
	b=SYSYw1gLcAmsdmtpX+ohfyGnctkm6C6rxwQJ6tJlxCKIlQjSN7IASU1xBOtDI05MXczOWi
	iC7/s4c6g9Kb906SvFWuY4XE4KKimUSf6LZorwDs33ONVOQTiVu/jzTusWq34CFrlfO1ec
	Z+Ce+gf8cAfSvy/1dEWakg1+uozIGHo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-ohotS8U1Mlu7bUIO817IqA-1; Tue,
 13 Oct 2026 09:43:28 +0000
X-MC-Unique: ohotS8U1Mlu7bUIO817IqA-1
X-Mimecast-MFC-AGG-ID: ohotS8U1Mlu7bUIO817IqA_1791884606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC951955D74;
	Tue, 13 Oct 2026 09:43:26 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DB441800352;
	Tue, 13 Oct 2026 09:43:22 +0000 (UTC)
Message-ID: <0051c3dd-6abd-4ff1-a125-7cace9fac6fb@redhat.com>
Date: Tue, 13 Oct 2026 11:43:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/12] dpll: sit9531x: add support to get and
 set frequency on pins
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-9-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-9-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Both directions in one patch, since they share everything that matters.
> 
> An input's frequency is what the board presents, so it is reported from
> the firmware description rather than read back: the chip has no divider on
> an input whose rate it merely qualifies.  An input the firmware gives no
> rate for has no frequency attribute at all rather than a zero, because
> the core abandons the whole pin dump on an error from one pin.
> 
> An output's frequency is the VCO divided by that output's divider, so it
> is computed from the divider read back from the chip and set by writing
> a new one.  The VCO in turn comes from the feedback divider, which is
> why the crystal rate is needed at probe.  That rate is trusted only
> inside the band the PLL's VCO runs in: below the low band the divider is
> not programmed and the PLL reports no data, and a request against a rate
> outside the band is refused rather than programmed, since a divider
> computed from a rate the output is not at would be reported as success.
> A divider write only takes effect inside the programming state, and that
> state has to be left with the output loops re-locked whatever happened
> in between, so the exit runs even when a write in the middle failed and
> the first error is the one returned.
> 
> Programming a divider costs about a hundred milliseconds under the device
> lock: a dozen or so register transactions, then the settling time the part
> requires after the loop-lock command, which is a property of the hardware
> rather than a conservative guess.  The DPLL core holds its own lock across
> the whole callback, so a frequency set on this device delays netlink
> traffic for every DPLL in the system for that long.  Splitting the wait
> out would need the ops to complete asynchronously, which the interface
> does not offer; issuing the commit without waiting would let the next
> request program a part that has not settled.  A rate change is a
> configuration action, not something a running system does per packet, so
> the cost is paid where it is visible rather than hidden behind a
> completion the caller cannot wait for.
> 
> The phase flush that follows a divider write realigns every output fed by
> that PLL, not only the one that changed.  The flush is a per-PLL function
> in the device and there is no per-output equivalent, so an output whose
> rate is set while its siblings are running will step their phase too.
> 
> The flush's own error paths restore what they changed: a failed source
> select puts the original source back, a sibling is marked parked before
> it is cleared so a failure cannot leave it unparked, and a failed arm
> disarms rather than unparks.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/core.c | 805 +++++++++++++++++++++++++++++++++++
>   drivers/dpll/sit9531x/core.h |   7 +
>   drivers/dpll/sit9531x/dpll.c | 120 ++++++
>   drivers/dpll/sit9531x/prop.c |  29 +-
>   drivers/dpll/sit9531x/regs.h |  21 +
>   5 files changed, 978 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 79520640dfc8..ea15830b0efa 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -488,6 +488,140 @@ static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,
>                                          muted);
>   }
> 
> +/* Attempts to re-lock the output loops before reporting them open. */
> +#define SIT9531X_LOOP_LOCK_TRIES       3
> +
> +/*
> + * sit9531x_prg_abort - leave the programming state without committing
> + *
> + * Entering the state is two writes, and the second can fail with the debug
> + * block already unlocked and the part possibly already in PRG_CMD.  There
> + * is nothing to commit in that case, but the loops still have to be closed
> + * and the debug key put back, which is otherwise only done by
> + * sit9531x_prg_commit().
> + */
> +static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)
> +{
> +       u8 attempt;
> +       int rc = -EIO;
> +
> +       for (attempt = 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {
> +               rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +                                      SIT9531X_LOOP_LOCK);
> +               if (!rc)
> +                       break;
> +               usleep_range(1000, 2000);
> +       }
> +       if (rc)
> +               dev_err(sitdev->dev,
> +                       "output loops left unlocked after a failed entry: %d\n",
> +                       rc);
> +
> +       sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +                         SIT9531X_DEBUG_LOCK_VAL);
> +}
> +
> +/*
> + * Enter the output-system programming state: unlock the debug
> + * registers on Page 3 and issue the PRG_CMD state command.  Register
> + * writes that reconfigure the output system only take effect when
> + * they are made inside this state.
> + */
> +static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
> +{
> +       int rc;
> +
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +                              SIT9531X_DEBUG_UNLOCK_VAL);
> +       if (rc)
> +               return rc;
> +
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +                              SIT9531X_PRG_CMD_STATE);
> +       if (rc) {
> +               /*
> +                * The debug block is unlocked at this point, and a transfer
> +                * that reported an error may still have reached the part --
> +                * which would leave the device in PRG_CMD with its output
> +                * loops open.  Callers skip the commit when the entry
> +                * fails, so close both here.
> +                */
> +               sit9531x_prg_abort(sitdev);
> +               return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Commit a programming sequence started by sit9531x_prg_enter():
> + * update the NVM shadow and re-lock the loops.  The sleep gives the
> + * hardware its required settling time after the loop-lock command;
> + * it is intentional despite the caller holding multiop_lock, as the
> + * whole NVM + lock sequence must be atomic.
> + */
> +static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
> +{
> +       int rc, rc2 = 0, rc3;
> +       u8 attempt;
> +
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +                              SIT9531X_UPDATE_NVM);
> +
> +       /*
> +        * Issue the loop lock even if the update failed: every caller
> +        * commits whatever happened after the entry so that the chip never
> +        * stays in the PRG_CMD state with its loops open, and returning
> +        * early here would defeat that.
> +        *
> +        * Re-lock the loops.  Leaving them open is worse than any other
> +        * failure this function can report, and nothing else closes them,
> +        * so retry, as the priority commit retries the release of its
> +        * forced holdover.
> +        */
> +       for (attempt = 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {
> +               rc2 = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +                                       SIT9531X_LOOP_LOCK);
> +               if (!rc2)
> +                       break;
> +               usleep_range(1000, 2000);
> +       }
> +       if (rc2)
> +               dev_err(sitdev->dev,
> +                       "output loops left unlocked after programming: %d\n",
> +                       rc2);
> +
> +       msleep(100);
> +
> +       /*
> +        * Put the output-system debug block back the way the device powers
> +        * up.  Its key register unlocks every debug register while it holds
> +        * the unlock value, and each programming sequence writes that value
> +        * itself, so nothing needs it left unlocked in between.
> +        */
> +       rc3 = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +                               SIT9531X_DEBUG_LOCK_VAL);
> +
> +       if (rc)
> +               return rc;
> +       if (rc2)
> +               return rc2;
> +
> +       /*
> +        * The programming is committed and the loops are locked by now;
> +        * only the debug key stayed open, and the next sequence writes it
> +        * again.  Failing here would make the caller skip what follows a
> +        * change that did take effect -- and the core drops an identical
> +        * retry, so it would never run.
> +        */
> +       if (rc3)
> +               dev_warn(sitdev->dev,
> +                        "output debug block left unlocked after programming: %d\n",
> +                        rc3);
> +
> +       return 0;
> +}
> +
>   /*
>    * Input priority selection
>    *
> @@ -1329,6 +1463,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
>                                           chan->prio_mask | BIT(input_idx));
>   }
> 
> +/* Per-slot DIVO base register offsets (6 slots per page) */
> +static const u8 clkout_odr_divn_base[] = {
> +       0x14, 0x24, 0x34, 0x44, 0x54, 0x64
> +};
> +
>   /* XO doubler register */
>   #define SIT9531X_REG_XO2_GENERIC               SIT9531X_REG(0x00, 0x2D)
>   #define SIT9531X_XO_DOUBLER_ENB_BIT            7   /* inverted: 0 = enabled */
> @@ -1342,6 +1481,672 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
>   /* The output divider is a 34-bit field */
>   #define SIT9531X_DIVO_MAX                      GENMASK_ULL(33, 0)
> 
> +/*
> + * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active
> + *
> + * Register 0x2D bit 7 is active-low: 0 = doubler enabled, 1 = disabled.
> + *
> + * Return: 1 if enabled, 0 if disabled, <0 on error
> + */
> +static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)
> +{
> +       u8 val;
> +       int rc;
> +
> +       rc = sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);
> +       if (rc)
> +               return rc;
> +
> +       return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;
> +}
> +
> +/*
> + * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with
> + * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN
> + * well inside s64 while resolving far below the parts-per-trillion the
> + * frequency offset is reported in.
> + */
> +static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)
> +{
> +       s64 whole = (s64)int_part * SIT9531X_DIVN_SCALE;
> +       u64 frac;
> +
> +       if (!fracd)
> +               return whole;
> +
> +       frac = mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);
> +
> +       return fracn < 0 ? whole - (s64)frac : whole + (s64)frac;
> +}
> +
> +/*
> + * sit9531x_divn_static - read the configured DIVN of a PLL
> + * @sitdev:    device pointer
> + * @pll_idx:   PLL index (0-3)
> + * @divn:      result, fixed point as per sit9531x_divn_fixed()
> + *
> + * Reads PLL page regs 0x30 (integer part), 0x32-0x35 (numerator) and
> + * 0x38-0x3B (denominator).  The numerator is a two's complement 32-bit
> + * value, so DIVN can sit below the integer part, and the denominator
> + * register holds the divisor minus one.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,
> +                               s64 *divn)
> +{
> +       u32 int_part, fracn_raw = 0, fracd_raw = 0;
> +       u64 fracd;
> +       s64 fracn;
> +       int rc, i;
> +       u8 v;
> +
> +       rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +                                 SIT9531X_PLL_REG_DIVN_INT, &v);
> +       if (rc)
> +               return rc;
> +       int_part = v;
> +
> +       for (i = 3; i >= 0; i--) {
> +               rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +                                         SIT9531X_PLL_REG_DIVN_NUM + i, &v);
> +               if (rc)
> +                       return rc;
> +               fracn_raw = (fracn_raw << 8) | v;
> +       }
> +
> +       for (i = 3; i >= 0; i--) {
> +               rc = sit9531x_read_pll_u8(sitdev, pll_idx,
> +                                         SIT9531X_PLL_REG_DIVN_DEN + i, &v);
> +               if (rc)
> +                       return rc;
> +               fracd_raw = (fracd_raw << 8) | v;
> +       }
> +
> +       /*
> +        * NUM/DEN is the fractional part of DIVN, so |NUM| is below DEN by
> +        * construction.  A pair that says otherwise did not come from a
> +        * programmed divider, and handing it on would divide by a
> +        * denominator small enough for the quotient to leave u64 -- which
> +        * is a divide-error exception on x86, not a value a caller could
> +        * reject.
> +        */
> +       fracn = (s32)fracn_raw;
> +       fracd = (u64)fracd_raw + 1;
> +       if ((u64)abs(fracn) >= fracd)
> +               return -ENODATA;
> +
> +       *divn = sit9531x_divn_fixed(int_part, fracn, fracd);
> +
> +       return 0;
> +}
> +
> +/* PLLB and PLLD run their VCO in the high band, PLLA and PLLC in the low. */
> +static bool sit9531x_fvco_in_band(u8 pll_idx, u64 fvco)
> +{
> +       if (pll_idx == 1 || pll_idx == 3)
> +               return fvco >= SIT9531X_FVCO_HIGHBAND_MIN &&
> +                      fvco <= SIT9531X_FVCO_HIGHBAND_MAX;
> +       return fvco >= SIT9531X_FVCO_LOWBAND_MIN &&
> +              fvco <= SIT9531X_FVCO_LOWBAND_MAX;
> +}
> +
> +/*
> + * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers
> + *
> + * Fvco = Fref * DIVN, where DIVN comes from sit9531x_divn_static() and
> + * Fref = xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref
> + * target programmed by the NVM blob and is authoritative in both
> + * free-run and sync modes.
> + *
> + * Return: 0 with *fvco set on success, -ENODATA when DIVN is not
> + * programmed (dormant PLL), or the register access error.  A bus
> + * failure is never folded into the -ENODATA case, so callers can fail
> + * a request instead of acting on a guessed rate.
> + */
> +static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,
> +                            u64 *fvco)
> +{
> +       int doubler, rc;
> +       u64 fref;
> +       s64 divn;
> +
> +       rc = sit9531x_divn_static(sitdev, pll_idx, &divn);
> +       if (rc)
> +               return rc;
> +       if (divn <= 0)
> +               return -ENODATA;
> +
> +       doubler = sit9531x_is_xo_doubler_enabled(sitdev);
> +       if (doubler < 0)
> +               return doubler;
> +
> +       fref = (u64)sitdev->xtal_freq << doubler;
> +
> +       /*
> +        * Round to the nearest hertz: DIVN is carried in fixed point, so a
> +        * fraction such as 1/6 is already floored once, and flooring the
> +        * product again reads an exact 5 GHz VCO as 4999999999 Hz -- which
> +        * then refuses every rate the VCO divides exactly.
> +        */
> +       *fvco = mul_u64_u64_div_u64(2 * fref, (u64)divn, SIT9531X_DIVN_SCALE);
> +       *fvco = (*fvco + 1) / 2;
> +
> +       /*
> +        * No VCO of this family runs below the low band, so a product under
> +        * it is not a rate: a DIVN of a cycle or less, say, which the check
> +        * above lets through and which a profile that never programmed the
> +        * divider can leave behind.  Callers scale 34-bit register fields by
> +        * 1e12 / Fvco or more, and for a rate far enough below the band that
> +        * quotient leaves u64 -- a divide-error exception on x86, not a
> +        * value they could reject.  Report the unprogrammed divider instead.
> +        */
> +       if (*fvco < SIT9531X_FVCO_LOWBAND_MIN)
> +               return -ENODATA;
> +
> +       /*
> +        * A rate outside the band the PLL's VCO runs in usually means
> +        * Fref * DIVN is not what this PLL runs at -- a PLL fed from another
> +        * PLL rather than from the XO, for one.  The rate derived from the
> +        * registers is still the only estimate there is, so a read reports
> +        * what it derives; a set refuses to program a divider against it
> +        * (sit9531x_output_divo_calc()), since substituting the band edge
> +        * would program against a rate nothing supports and report the
> +        * result as exact.  Say so once per PLL.
> +        */
> +       if (!sit9531x_fvco_in_band(pll_idx, *fvco) &&
> +           !(sitdev->fvco_band_warned & BIT(pll_idx))) {
> +               sitdev->fvco_band_warned |= BIT(pll_idx);
> +               dev_warn(sitdev->dev,
> +                        "PLL%c: Fref * DIVN = %llu Hz is outside its VCO band\n",
> +                        'A' + pll_idx, *fvco);
> +       }
> +
> +       return 0;
> +}
> +
> +/* Latch a change to a PLL page with a small update. */
> +static int sit9531x_pll_small_update(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{
> +       return sit9531x_write_pll_u8(sitdev, pll_idx,
> +                                    SIT9531X_PLL_REG_SMALL_UPDATE,
> +                                    SIT9531X_SMALL_UPDATE_CMD);
> +}
> +
> +/*
> + * sit9531x_output_phase_flush - flush the output phase of a PLL
> + *
> + * Fires the chip's on-demand phase-flush (PHFL) so every output divider
> + * of @pll_idx restarts aligned to the PLL phase.  Without it a rewritten
> + * DIVO keeps counting from an arbitrary point and the output edge lands
> + * with a persistent offset against the tracked reference (only a power
> + * cycle realigned it).
> + *
> + * The sequence mirrors the documented procedure: arm the on-demand PHFL and
> + * latch it with the PLL-page small-change update, then select the
> + * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger
> + * register is touched read-modify-write so the unrelated OEb bits are
> + * preserved.
> + *
> + * A PLL the loaded configuration builds without the phase-flush feature
> + * (PLL page 0x47 bit 7 clear) has nothing to fire; it is restarted
> + * instead, which restarts its output dividers from the PLL phase.  That
> + * is what SiTime's Dely_program_output.py does for such a PLL.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll_idx)
> +{
> +       u8 ctrl, orig, phfl, armed_mask = 0, parked = 0, i;
> +       int rc, ret;
> +
> +       rc = sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_CONFIG47,
> +                                 &phfl);
> +       if (rc)
> +               return rc;
> +       if (!(phfl & SIT9531X_PLL_CONFIG47_PHFL_EN))
> +               return sit9531x_write_pll_u8(sitdev, pll_idx,
> +                                            SIT9531X_PLL_REG_DIRECTIVES,
> +                                            SIT9531X_PLL_DIRECTIVE_RESTART);
> +
> +       /*
> +        * The trigger below is chip-global: every PLL whose on-demand flush
> +        * is armed answers it.  Note which ones the loaded profile arms --
> +        * this one so its setting can be put back, the others so they can
> +        * be parked for the pulse and do not realign outputs nobody asked
> +        * to move.
> +        */
> +       for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +               rc = sit9531x_read_pll_u8(sitdev, i, SIT9531X_PLL_REG_PHFL_CTRL,
> +                                         &phfl);
> +               if (rc)
> +                       return rc;
> +               if (phfl & SIT9531X_PLL_PHFL_ON_DEMAND_EN)
> +                       armed_mask |= BIT(i);
> +       }
> +
> +       for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +               if (i == pll_idx || !(armed_mask & BIT(i)))
> +                       continue;
> +               /*
> +                * A clear whose write reported an error may still have
> +                * landed, latched or not: put it back either way.
> +                */
> +               parked |= BIT(i);
> +               rc = sit9531x_update_pll_u8(sitdev, i,
> +                                           SIT9531X_PLL_REG_PHFL_CTRL,
> +                                           SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);
> +               if (rc)
> +                       goto unpark;
> +               rc = sit9531x_pll_small_update(sitdev, i);
> +               if (rc)
> +                       goto unpark;
> +       }
> +
> +       /*
> +        * Arm the on-demand phase-flush on the PLL page.  An arm whose write
> +        * failed may have landed too, so it goes through the disarm below.
> +        */
> +       rc = sit9531x_update_pll_u8(sitdev, pll_idx,
> +                                   SIT9531X_PLL_REG_PHFL_CTRL,
> +                                   SIT9531X_PLL_PHFL_ON_DEMAND_EN,
> +                                   SIT9531X_PLL_PHFL_ON_DEMAND_EN);
> +       if (rc)
> +               goto disarm;
> +
> +       /*
> +        * Latch it with the PLL small-change update.  Written whole, like
> +        * every other issue of this directive: the register is a command
> +        * register, and a read-modify-write skips the write entirely when
> +        * the bit still reads back set from the previous command.
> +        */
> +       rc = sit9531x_pll_small_update(sitdev, pll_idx);
> +       if (rc)
> +               goto disarm;
> +
> +       /*
> +        * Select the in-register phase trigger, preserving the OEb bits.
> +        * Remember the original register value (with the trigger de-asserted)
> +        * so the trigger-source select can be restored once the pulse has
> +        * fired.
> +        */
> +       rc = sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);
> +       if (rc)
> +               goto disarm;
> +
> +       orig = ctrl & ~SIT9531X_DIVO_PHASE_TRIG;
> +       ctrl = orig | SIT9531X_DIVO_PHASE_SEL_REG;
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);
> +       if (rc)
> +               goto restore;
> +
> +       /*
> +        * Pulse the phase trigger.  No explicit delay is needed between the
> +        * set and clear writes: each I2C transaction takes far longer than
> +        * any minimum pulse width.
> +        */
> +       rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,
> +                              ctrl | SIT9531X_DIVO_PHASE_TRIG);
> +
> +restore:
> +       /*
> +        * Restore the original trigger-source select.  The pulse above has
> +        * already latched the flush, so a one-shot flush must not leave the
> +        * phase trigger permanently pinned to the in-register source.  This
> +        * runs even when the pulse write failed, and when the select write
> +        * itself reported a failure, since the transfer may have reached
> +        * the part all the same; otherwise a failed flush would keep a
> +        * hardware trigger source hijacked.  The restore error is only
> +        * surfaced when it would not mask the earlier failure.
> +        */
> +       ret = sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);
> +       if (ret && !rc)
> +               rc = ret;
> +
> +disarm:
> +       /*
> +        * Put the on-demand flush enable back as the profile had it.  One the
> +        * profile left clear must not stay armed: a later assertion of the
> +        * restored trigger source would re-flush every output divider of this
> +        * PLL.  One the profile armed -- a board realigning from a GPIO, say
> +        * -- must not be switched off by an unrelated rate change.
> +        */
> +       if (!(armed_mask & BIT(pll_idx))) {
> +               ret = sit9531x_update_pll_u8(sitdev, pll_idx,
> +                                            SIT9531X_PLL_REG_PHFL_CTRL,
> +                                            SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);
> +               if (!ret)
> +                       ret = sit9531x_pll_small_update(sitdev, pll_idx);
> +               if (ret && !rc)
> +                       rc = ret;
> +       }
> +
> +unpark:
> +       for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +               if (!(parked & BIT(i)))
> +                       continue;
> +               ret = sit9531x_update_pll_u8(sitdev, i,
> +                                            SIT9531X_PLL_REG_PHFL_CTRL,
> +                                            SIT9531X_PLL_PHFL_ON_DEMAND_EN,
> +                                            SIT9531X_PLL_PHFL_ON_DEMAND_EN);
> +               if (!ret)
> +                       ret = sit9531x_pll_small_update(sitdev, i);
> +               if (ret && !rc)
> +                       rc = ret;
> +       }
> +
> +       return rc;
> +}
> +
> +/*
> + * sit9531x_output_divo_calc - work out an output's divider and its VCO
> + *
> + * Separated from the write so a caller that programs more than the
> + * divider in one sequence can compute the value before it enters the
> + * programming state.
> + */
> +static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_idx,
> +                                    u8 pll_idx, u64 frequency, u64 *fvco_out,
> +                                    u64 *divo_out)
> +{
> +       const struct sit9531x_chip_info *info = sitdev->info;
> +       u64 fvco, divo;
> +       int rc;
> +
> +       if (out_idx >= info->num_outputs || pll_idx >= SIT9531X_NUM_PLLS)
> +               return -EINVAL;
> +
> +       if (!frequency)
> +               return -EINVAL;
> +
> +       /*
> +        * The core validates the request against the supported ranges with
> +        * the value narrowed to u32 but hands the full u64 down, so a value
> +        * like U32_MAX + 1 Hz validates as 1 Hz.  Reject anything that does
> +        * not fit the narrowed width the validation actually covered.
> +        */
> +       if (frequency > U32_MAX)
> +               return -EINVAL;
> +
> +       /*
> +        * sit9531x_get_fvco() returns the register-derived rate, so a
> +        * frequency get and a frequency set divide the same number.  A VCO
> +        * that cannot be read fails the request: programming a divider from a
> +        * guessed rate would put the output far from what was asked for
> +        * while reporting success.
> +        */
> +       rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +       if (rc)
> +               return rc == -ENODATA ? -ENODEV : rc;
> +
> +       /*
> +        * Fref * DIVN outside the VCO band is not what the PLL runs at, and
> +        * sit9531x_get_fvco() has said so.  A divider computed against it
> +        * would put the output at some other rate while the exactness check
> +        * below passes and the read-back, dividing the same number, confirms
> +        * the request.  Refuse the set instead.
> +        */
> +       if (!sit9531x_fvco_in_band(pll_idx, fvco)) {
> +               dev_dbg(sitdev->dev,
> +                       "out%u: PLL%c Fvco %llu Hz is outside its VCO band, rate not settable\n",
> +                       out_idx, 'A' + pll_idx, fvco);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Round to nearest rather than down: flooring picks the worse of the
> +        * two adjacent dividers whenever the remainder is above half the
> +        * request.
> +        */
> +       divo = div64_u64(fvco + frequency / 2, frequency);
> +       if (!divo)
> +               return -EINVAL;
> +
> +       /* DIVO is a 34-bit field; refuse a wider divider rather than truncate it. */
> +       if (divo > SIT9531X_DIVO_MAX)
> +               return -EINVAL;
> +
> +       /*
> +        * The output divider is an integer divider of the VCO, so the only
> +        * rates the part can make are Fvco/N.  An output pin that lists no
> +        * supported frequencies advertises a continuous range, because the
> +        * divisors cannot be enumerated ahead of a known Fvco, so a request
> +        * for a rate between two of them arrives here.  Refuse it: running
> +        * the output at the nearest divider instead and reporting success
> +        * would leave the pin several percent off what was asked for with
> +        * nothing saying so.
> +        */
> +       if (div64_u64(fvco, divo) != frequency) {
> +               dev_dbg(sitdev->dev,
> +                       "out%u: %llu Hz is not Fvco/N (Fvco=%llu, nearest %llu Hz)\n",
> +                       out_idx, frequency, fvco, div64_u64(fvco, divo));
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(sitdev->dev,
> +               "out%u: Fvco=%llu freq=%llu DIVO=%llu (effective %llu Hz)\n",
> +               out_idx, fvco, frequency, divo, div64_u64(fvco, divo));
> +
> +       *fvco_out = fvco;
> +       *divo_out = divo;
> +
> +       return 0;
> +}
> +
> +/*
> + * sit9531x_output_divo_write - write the five DIVO bytes of an output
> + *
> + * The caller must already be in the programming state.  Bytes written
> + * before a failure are put back, so the output keeps the divider it had
> + * rather than a mixture of the two.
> + */
> +static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_idx,
> +                                     u64 divo)
> +{
> +       const struct sit9531x_chip_info *info = sitdev->info;
> +       u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;
> +       int rc, j, rb_rc;
> +       u8 written = 0;
> +
> +       /* Map output index to physical slot */
> +       slot = info->clkout_map[out_idx];
> +
> +       /* Determine page and per-page slot register */
> +       if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)
> +               page = SIT9531X_PAGE_OUTSYS1;
> +       else
> +               page = SIT9531X_PAGE_OUTSYS0;
> +       base_reg = clkout_odr_divn_base[slot % 6];
> +
> +       divo_bytes[0] = (divo >>  0) & 0xFF;
> +       divo_bytes[1] = (divo >>  8) & 0xFF;
> +       divo_bytes[2] = (divo >> 16) & 0xFF;
> +       divo_bytes[3] = (divo >> 24) & 0xFF;
> +       divo_bytes[4] = (divo >> 32) & 0x03;  /* only bits [1:0] */
> +
> +       for (j = 0; j < 5; j++) {
> +               rc = sit9531x_read_u8(sitdev,
> +                                     SIT9531X_REG(page, base_reg - j),
> +                                     &old_bytes[j]);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       msb_old = old_bytes[4];
> +       divo_bytes[4] |= msb_old & 0xFC;
> +
> +       for (j = 0; j < 5; j++) {
> +               rc = sit9531x_write_u8(sitdev,
> +                                      SIT9531X_REG(page, base_reg - j),
> +                                      divo_bytes[j]);
> +               if (rc)
> +                       goto rollback;
> +               written++;
> +       }
> +
> +       return 0;
> +
> +rollback:
> +       /*
> +        * The byte whose write reported the error may still have reached
> +        * the part, so it is put back along with the ones that did.
> +        */
> +       for (j = 0; j <= written && j < 5; j++) {
> +               rb_rc = sit9531x_write_u8(sitdev,
> +                                         SIT9531X_REG(page, base_reg - j),
> +                                         old_bytes[j]);
> +               if (rb_rc) {
> +                       dev_err(sitdev->dev,
> +                               "out%u: DIVO rollback failed (%d), the divider is part old and part new\n",
> +                               out_idx, rb_rc);
> +                       if (!rc)
> +                               rc = rb_rc;
> +               }
> +       }
> +
> +       return rc;
> +}
> +
> +/*
> + * Read an output's divider back from the device.
> + *
> + * Return: 0 with *divo set, -ENODATA when the divider is not programmed,
> + * or the register access error
> + */
> +static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_idx,
> +                                    u64 *divo)
> +{
> +       u8 slot, page, base_reg, v;
> +       int rc, j;
> +
> +       slot = sitdev->info->clkout_map[out_idx];
> +       if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)
> +               page = SIT9531X_PAGE_OUTSYS1;
> +       else
> +               page = SIT9531X_PAGE_OUTSYS0;
> +       base_reg = clkout_odr_divn_base[slot % 6];
> +
> +       *divo = 0;
> +       for (j = 4; j >= 0; j--) {
> +               rc = sit9531x_read_u8(sitdev,
> +                                     SIT9531X_REG(page, base_reg - j), &v);
> +               if (rc)
> +                       return rc;
> +               if (j == 4)
> +                       v &= 0x03;
> +               *divo = (*divo << 8) | v;
> +       }
> +
> +       return *divo ? 0 : -ENODATA;
> +}
> +
> +int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
> +                            u8 pll_idx, u64 frequency)
> +{
> +       u64 fvco, divo;
> +       int rc, ret;
> +
> +       lockdep_assert_held(&sitdev->multiop_lock);
> +
> +       rc = sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, frequency,
> +                                      &fvco, &divo);
> +       if (rc)
> +               return rc;
> +
> +       rc = sit9531x_prg_enter(sitdev);
> +       if (rc)
> +               return rc;
> +
> +       rc = sit9531x_output_divo_write(sitdev, out_idx, divo);
> +       /*
> +        * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip
> +        * leaves the PRG_CMD state with the output loops re-locked, even when a
> +        * write above failed; keep the first error to return.  It also carries
> +        * the required post-lock settling sleep.
> +        */
> +       ret = sit9531x_prg_commit(sitdev);
> +       if (ret && !rc)
> +               rc = ret;
> +       if (rc)
> +               return rc;
> +
> +       /*
> +        * Step 5: flush the PLL's output phase so the new DIVO starts
> +        * aligned instead of keeping the arbitrary phase the divider
> +        * happened to be at.
> +        */
> +       /*
> +        * The divider is committed by this point, so the part is already
> +        * running at the new rate.  A flush that fails leaves the output
> +        * divider on its old phase, which is a realignment that did not
> +        * happen rather than a rate that did not change -- and reporting a
> +        * failure would be doubly wrong, because the core asks for the
> +        * current rate first and would drop an identical retry.
> +        */
> +       rc = sit9531x_output_phase_flush(sitdev, pll_idx);
> +       if (rc) {
> +               dev_warn(sitdev->dev,
> +                        "out%u: rate changed but the divider phase was not realigned (%d)\n",
> +                        out_idx, rc);
> +               rc = 0;
> +       }
> +
> +       sitdev->out[out_idx].freq = div64_u64(fvco, divo);
> +
> +       return 0;
> +}
> +
> +/*
> + * sit9531x_output_freq_get - read output clock frequency from hardware
> + * @out_idx:   output index (0-N for this chip variant)
> + * @frequency: output frequency in Hz
> + *
> + * Reads the 34-bit DIVO divider back from the output system registers
> + * and computes the live output frequency as Fvco / DIVO.  This stays
> + * correct even when the divider was reprogrammed behind the driver's
> + * back (e.g. by a direct-I2C userspace tool), where the cached value
> + * would be stale.
> + *
> + * The cached output state is refreshed with the computed value.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + *
> + * Return: 0 on success, -ENODATA when the output divider or VCO rate
> + *        is not resolvable, <0 on register access error.  -ENODATA and not
> + *        -ENODEV, which the I2C layer returns for an adapter that is gone
> + *        and which must not read as "no rate to report".
> + */
> +int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
> +                            u64 *frequency)
> +{
> +       const struct sit9531x_chip_info *info = sitdev->info;
> +       u64 fvco, divo;
> +       u8 pll_idx;
> +       int rc;
> +
> +       lockdep_assert_held(&sitdev->multiop_lock);
> +
> +       if (out_idx >= info->num_outputs)
> +               return -EINVAL;
> +
> +       pll_idx = sitdev->out[out_idx].pll_idx;
> +       if (pll_idx >= SIT9531X_NUM_PLLS || !sitdev->out[out_idx].routed)
> +               return -ENODATA;
> +
> +       rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +       if (rc)
> +               return rc;
> +
> +       rc = sit9531x_output_divo_read(sitdev, out_idx, &divo);
> +       if (rc)
> +               return rc;
> +
> +       *frequency = div64_u64(fvco, divo);
> +       sitdev->out[out_idx].freq = *frequency;
> +
> +       return 0;
> +}
> +
>   /*
>    * Phase adjust (PRG_RST_DELAY register-based).
>    *
> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index fa1197bfc81c..006a7fee76ab 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -192,6 +192,8 @@ struct sit9531x_chan {
>    *                     synchronization (INTSYNC), or -1 when disabled
>    * @irq_ack_fails:     consecutive failures to acknowledge the
>    *                     notification latches from the interrupt handler
> + * @fvco_band_warned:  bit per PLL whose Fref * DIVN has been reported as
> + *                     outside its VCO band; written under @multiop_lock
>    */
>   struct sit9531x_dev {
>          struct device                   *dev;
> @@ -203,6 +205,7 @@ struct sit9531x_dev {
> 
>          /* Hardware state */
>          u8                      irq_ack_fails;
> +       u8                      fvco_band_warned;
>          struct sit9531x_ref     ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */
>          struct sit9531x_out     out[SIT9531X_MAX_OUTPUTS];
>          struct sit9531x_chan    chan[SIT9531X_NUM_PLLS];
> @@ -265,6 +268,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
>   /* ---- Output enable/disable (Hi-Z control) ---- */
> 
>   /* ---- Output frequency ---- */
> +int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
> +                            u8 pll_idx, u64 frequency);
> +int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
> +                            u64 *frequency);
> 
>   /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */
> 
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 0400444d91a5..aa021b374c45 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -411,6 +411,32 @@ sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
>          return 0;
>   }
> 
> +/*
> + * sit9531x_dpll_input_pin_frequency_get - read input pin frequency
> + *
> + * Returns the rate the board wired to the input, the first entry of its
> + * supported-frequencies-hz; an input has no frequency setter.  An input
> + * the firmware lists no rate for is registered without this callback
> + * (sit9531x_dpll_pin_ops_get()), so its attribute is absent rather than
> + * zero.
> + */
> +static int
> +sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,
> +                                     void *pin_priv,
> +                                     const struct dpll_device *dpll,
> +                                     void *dpll_priv, u64 *frequency,
> +                                     struct netlink_ext_ack *extack)
> +{
> +       struct sit9531x_dpll_pin *dpin = pin_priv;
> +       struct sit9531x_dpll *sitdpll = dpll_priv;
> +       const struct sit9531x_ref *ref;
> +
> +       ref = sit9531x_ref_state_get(sitdpll->dev, dpin->id);
> +       *frequency = ref->freq;
> +
> +       return 0;
> +}
> +
>   /*
>    * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state
>    *
> @@ -644,6 +670,23 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>   }
> 
>   static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
> +       .direction_get          = sit9531x_dpll_input_pin_direction_get,
> +       .frequency_get          = sit9531x_dpll_input_pin_frequency_get,
> +       .state_on_dpll_get      = sit9531x_dpll_input_pin_state_on_dpll_get,
> +       .state_on_dpll_set      = sit9531x_dpll_input_pin_state_on_dpll_set,
> +       .operstate_on_dpll_get  = sit9531x_dpll_input_pin_operstate_on_dpll_get,
> +       .prio_get               = sit9531x_dpll_input_pin_prio_get,
> +       .prio_set               = sit9531x_dpll_input_pin_prio_set,
> +};
> +
> +/*
> + * The same without frequency_get, for an input whose firmware node lists
> + * no supported-frequencies-hz (or that has no node at all): there is no
> + * rate to report, and the core fails a whole pin dump on an error from
> + * any one callback, so the attribute is left out rather than reported
> + * as 0 Hz.
> + */
> +static const struct dpll_pin_ops sit9531x_dpll_input_pin_norate_ops = {
>          .direction_get          = sit9531x_dpll_input_pin_direction_get,
>          .state_on_dpll_get      = sit9531x_dpll_input_pin_state_on_dpll_get,
>          .state_on_dpll_set      = sit9531x_dpll_input_pin_state_on_dpll_set,
> @@ -704,6 +747,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpll_pin *pin,
> 
>   static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops = {
>          .direction_get          = sit9531x_dpll_input_pin_direction_get,
> +       .frequency_get          = sit9531x_dpll_input_pin_frequency_get,
>          .state_on_dpll_get      = sit9531x_dpll_xo_pin_state_on_dpll_get,
>   };
> 
> @@ -719,8 +763,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
>          return 0;
>   }
> 
> +/*
> + * sit9531x_dpll_output_pin_frequency_get - read output pin frequency
> + *
> + * Reads the DIVO divider back from the chip and computes the live
> + * frequency as Fvco / DIVO.  Falls back to the cached value only when
> + * the output is not resolvable through the divider chain (e.g. not
> + * mapped to a PLL), so transport/register errors still surface.
> + */
> +static int
> +sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,
> +                                      void *pin_priv,
> +                                      const struct dpll_device *dpll,
> +                                      void *dpll_priv, u64 *frequency,
> +                                      struct netlink_ext_ack *extack)
> +{
> +       struct sit9531x_dpll_pin *dpin = pin_priv;
> +       struct sit9531x_dpll *sitdpll = dpll_priv;
> +       struct sit9531x_dev *sitdev = sitdpll->dev;
> +       int rc;
> +
> +       mutex_lock(&sitdev->multiop_lock);
> +       rc = sit9531x_output_freq_get(sitdev, dpin->id, frequency);
> +       if (rc == -ENODATA)
> +               *frequency = sit9531x_out_state_get(sitdev, dpin->id)->freq;
> +       mutex_unlock(&sitdev->multiop_lock);
> +
> +       return rc == -ENODATA ? 0 : rc;
> +}
> +
> +/*
> + * sit9531x_dpll_output_pin_frequency_set - set output pin frequency
> + *
> + * computes DIVO = Fvco / frequency and writes the
> + * 34-bit output divider to the output system registers via
> + * sit9531x_output_freq_set().
> + */
> +static int
> +sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
> +                                      void *pin_priv,
> +                                      const struct dpll_device *dpll,
> +                                      void *dpll_priv, u64 frequency,
> +                                      struct netlink_ext_ack *extack)
> +{
> +       struct sit9531x_dpll_pin *dpin = pin_priv;
> +       struct sit9531x_dpll *sitdpll = dpll_priv;
> +       struct sit9531x_dev *sitdev = sitdpll->dev;
> +       u8 actual_pll;
> +       int rc;
> +
> +       /*
> +        * Read the PLL that drives this output from its OUT_MAP state
> +        * (populated by out_state_fetch from the chip's OUT_MAP registers).
> +        * That is the index the output register programming below is keyed
> +        * by; the output is registered under the DPLL matching this PLL.
> +        */
> +       actual_pll = sitdev->out[dpin->id].pll_idx;
> +
> +       mutex_lock(&sitdev->multiop_lock);
> +       rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
> +                                     frequency);
> +       mutex_unlock(&sitdev->multiop_lock);
> +
> +       if (rc)
> +               NL_SET_ERR_MSG(extack, "Output frequency set failed");
> +
> +       return rc;
> +}
> +
>   static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>          .direction_get          = sit9531x_dpll_output_pin_direction_get,
> +       .frequency_get          = sit9531x_dpll_output_pin_frequency_get,
> +       .frequency_set          = sit9531x_dpll_output_pin_frequency_set,
>   };
> 
>   const struct dpll_pin_ops *
> @@ -730,6 +844,12 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)
>                  return &sit9531x_dpll_output_pin_ops;
>          if (sit9531x_dpll_is_xo_pin(pin))
>                  return &sit9531x_dpll_xo_pin_ops;
> +       /*
> +        * Seeded from the firmware node before the pin is registered and
> +        * never written afterwards, so register and unregister agree.
> +        */
> +       if (!sit9531x_ref_state_get(pin->dpll->dev, pin->id)->freq)
> +               return &sit9531x_dpll_input_pin_norate_ops;
>          return &sit9531x_dpll_input_pin_ops;
>   }
> 
> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> index 934db566c002..8270b8ee91be 100644
> --- a/drivers/dpll/sit9531x/prop.c
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -295,15 +295,36 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
>          }
> 
>          /*
> -        * Seed an input's runtime ref->freq with the first DT-listed
> -        * supported frequency: for an input the board lists the rate that is
> -        * physically wired to it first.  An output's current rate is what its
> -        * divider produces, not an entry of the list it may be set to.
> +        * Seed the runtime ref->freq with the first DT-listed supported
> +        * frequency: an input's rate is a board fact the device cannot be
> +        * asked for, so firmware is the only source.  An output is left to
> +        * the read-back below, which knows what the divider is actually
> +        * doing.
>           */
>          if (num_freqs > 0 && dir == DPLL_PIN_DIRECTION_INPUT &&
>              index != SIT9531X_MAX_INPUTS)
>                  curr_freq = freqs[0];
> 
> +       /*
> +        * An output's current rate is the one its divider produces, so read
> +        * it rather than assume the first entry of a list of the rates the
> +        * board supports is the one in force.  A rate taken from firmware
> +        * that the part is not running would be reported as current and,
> +        * worse, used as the output period the phase adjust quantizes
> +        * against.  An output the configuration does not route has no rate
> +        * to read, which is not an error.
> +        */
> +       if (dir == DPLL_PIN_DIRECTION_OUTPUT &&
> +           index < sitdev->info->num_outputs) {
> +               u64 hw_freq;
> +
> +               mutex_lock(&sitdev->multiop_lock);
> +               rc = sit9531x_output_freq_get(sitdev, index, &hw_freq);
> +               mutex_unlock(&sitdev->multiop_lock);
> +               if (!rc)
> +                       curr_freq = hw_freq;
> +       }
> +
>   skip_fwnode_props:

This read-back sits before the skip_fwnode_props label, so an output with
no firmware node, or with a node that has no supported-frequencies-hz.

For such an output curr_freq stays at the zero-initialized
sitdev->out[index].freq, so the current rate is neither cached nor listed
ahead of the 1 Hz to 1 GHz fallback range.  Was the read-back meant to
cover outputs without a firmware frequency list as well?

Thanks,
Ivan

