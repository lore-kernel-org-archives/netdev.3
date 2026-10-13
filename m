Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992903B892D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885735; cv=none; b=BmUveW6wC729mV1Erg05hV5Zhgs2R21uytQGgw5RK5+qpwa7nMZJf8Chm6e/petqARRw0b7sgO3f2f1wFPBBI2covuNupBdnbsyNxs2eB9kDMD2svWgX86GXw8flDUOggkUDOuxLyxrJHF/NgBjikO2lLKMrKQMJAUd3s4lnZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885735; c=relaxed/simple;
	bh=7lTd1oAUrS5SwOED/Fuu8Ie9D785+dcFp8G5m3mmf4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6Wz84ApK9atDUqI3/tnfnj+UoiBEcksBhguAKWSY3B0CDZ827ai1EbHs8V4+FzzJqnXg/j2rzt5llEEa2YVaAbFkJd+wMtssU8imwwOfj9TNvRoDtMrEzR5prYgxaY2+qbwJUg65vw7NwNNLZPYdDPnz5IZEmoxsmVxyZ7dmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4O3+B+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4O3+B+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791885732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkZEUG83rOyNhEtN3y5WDfO091gbVPHLi8EBmYraIwY=;
	b=b4O3+B+AWNmfJbtjVROS/KcPNM/dlTb93bRWvfpXlBKJc2p1g7nG4CPTtJh4cP7UC6Gk8Z
	b8L1vxuA3rT3sBHH+mrF94Qp3SixpqpWKmDV1E78voHgO58CZXNro+aV0djyBAXd9VDPoz
	ru0/oCRS6k7sv4/5gV1zWlLXrdCDwaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-6SyeDFIUN2mKYxnKPpja0w-1; Tue,
 13 Oct 2026 10:02:08 +0000
X-MC-Unique: 6SyeDFIUN2mKYxnKPpja0w-1
X-Mimecast-MFC-AGG-ID: 6SyeDFIUN2mKYxnKPpja0w_1791885726
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28003195FDD7;
	Tue, 13 Oct 2026 10:02:06 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79225195608C;
	Tue, 13 Oct 2026 10:02:02 +0000 (UTC)
Message-ID: <96179bac-03aa-472a-bffc-51a5252a2089@redhat.com>
Date: Tue, 13 Oct 2026 12:02:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 10/12] dpll: sit9531x: add support to adjust
 output phase
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
 <20261009183151.78497-11-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-11-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Shift an output in time against the others driven by the same PLL.  The
> device has a coarse delay counted in VCO cycles and a three-bit fine field
> in fixed thirty-picosecond steps, so a requested offset is split between
> the two and what the core reads back is what the registers hold rather
> than what was asked for.  The divider spends two VCO cycles acting on a
> programmed delay before it releases the output, so the registers hold the
> request plus those two cycles and the read-back takes them off again.
> 
> The window advertised to the core is one millisecond either way: the
> device holds a delay anywhere within the output period, so on a slow
> output the bound is the signed 32-bit picosecond attribute rather than
> the hardware, and a round figure below it costs nothing and is what
> keeps the subsystem from refusing every request; the granularity is one
> picosecond, because the achievable delays are whole VCO cycles plus
> thirty-picosecond steps and so form no uniform lattice for the core to
> check against.
> 
> Delay only ever advances, so an offset larger than one output period is
> folded back into a single period -- for a periodic signal that is the
> same phase.  The fold is counted in VCO cycles, since the period is
> exactly the divider's count of them, and the quantizer takes whichever
> of the neighbouring whole cycles with the fine steps lands nearest.  An
> advance is held as the complementary delay and reads back as an advance
> only where the period exceeds the advertised window; elsewhere the two
> describe the same edge and the delay form is reported.  A delay the
> loaded configuration left beyond the window is reported clamped and is
> not carried into a later rate change.  A rate change on an output with a
> programmed delay re-times it inside the rate change's own programming
> window, so there is one sequence and one flush, and a flush that failed
> after the delay was committed is retried by the next request.  The write
> takes effect in the programming state, which is left with the loops
> re-locked even when a write inside it failed.
> 
> The device has no per-output phase flush, so realigning the adjusted
> output restarts the divider phase of every output that PLL drives.  On a
> part where outputs are deliberately skewed against each other that is a
> visible edge jump on the others, and there is no register that would let
> the driver avoid it.  A PLL the loaded profile builds without the
> phase-flush feature has no flush to fire; realigning its outputs
> restarts the whole PLL, so a phase adjust or a rate change on such a PLL
> is a loss of lock as well as an edge jump on its other outputs.
> 
> Suggested-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/core.c | 662 +++++++++++++++++++++++++++++++++--
>   drivers/dpll/sit9531x/core.h |  22 ++
>   drivers/dpll/sit9531x/dpll.c |  80 +++++
>   drivers/dpll/sit9531x/prop.c |  22 ++
>   drivers/dpll/sit9531x/regs.h |  37 ++
>   5 files changed, 798 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 19aeabd3cd4f..8a8872b18d2c 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2264,11 +2264,422 @@ static int sit9531x_output_divo_read(struct sit9531x_dev *sitdev, u8 out_idx,
>          return *divo ? 0 : -ENODATA;
>   }
> 
> +/*
> + * Phase adjust (PRG_RST_DELAY register-based).
> + *
> + * The chip exposes a per-output 34-bit coarse delay measured in VCO
> + * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The
> + * five bytes PROG6..PROG2 hold the field across registers:
> + *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)
> + *                    [4:2] PRG_RST_FINE_DELAY
> + *                    [1:0] PRG_RST_DELAY[33:32]
> + *   base + 1  PROG5  PRG_RST_DELAY[31:24]
> + *   base + 2  PROG4  PRG_RST_DELAY[23:16]
> + *   base + 3  PROG3  PRG_RST_DELAY[15:8]
> + *   base + 4  PROG2  PRG_RST_DELAY[7:0]
> + *
> + * Slots 0-5 live on Page 3, slots 6-11 on Page 4, with each slot's
> + * block at base = 0x15 + 16 * (slot % 6); the slot is the physical
> + * output position from clkout_map[], not the logical output index.
> + *
> + * The chip only supports unsigned positive delay.  Requests are folded
> + * modulo one output period: positive delays wrap naturally and a negative
> + * phase adjustment (advance) is rendered as (T_out - |phase|).
> + */
> +
> +/*
> + * Register of byte @i (PROG6 first) of an output's PRG_RST_DELAY block.
> + *
> + * The logical output index maps to the chip's physical output slot.  On
> + * SiT95317 the eight logical outputs land on chip slots {0, 3, 4, 5, 7,
> + * 8, 9, 11}; on SiT95316 the map is identity.  Page and base address the
> + * slot, not the logical index.
> + */
> +static unsigned int sit9531x_output_prg_reg(struct sit9531x_dev *sitdev,
> +                                           u8 out_idx, u8 i)
> +{
> +       u8 slot = sitdev->info->clkout_map[out_idx];
> +       u8 page = (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
> +                 SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
> +       u8 base = SIT9531X_OUT_PRG_DELAY_BASE +
> +                 SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);
> +
> +       return SIT9531X_REG(page, base + i);
> +}
> +
> +/* Read the PRG_RST_DELAY bytes of an output, PROG6 first. */
> +static int sit9531x_output_phase_bytes_read(struct sit9531x_dev *sitdev,
> +                                           u8 out_idx, u8 *bytes)
> +{
> +       int rc;
> +       u8 i;
> +
> +       for (i = 0; i < SIT9531X_OUT_PRG_BYTES; i++) {
> +               rc = sit9531x_read_u8(sitdev,
> +                                     sit9531x_output_prg_reg(sitdev, out_idx, i),
> +                                     &bytes[i]);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Encode a quantized delay into the register bytes.  @old_bytes supplies
> + * the PROG6 bits that are not the delay's, which are preserved.
> + *
> + * The register value carries the divider's own settling time: the
> + * quantizer works in the delay the caller asked for, the register wants
> + * that plus the two VCO cycles the divider spends acting on it, and a
> + * request of zero still waits those two.  Only the register value carries
> + * them; @coarse stays the requested delay, which is what gets cached.
> + */
> +static void sit9531x_output_phase_bytes_build(const u8 *old_bytes, u64 coarse,
> +                                             u8 fine, u8 *new_bytes)
> +{
> +       u64 prg_coarse = coarse + SIT9531X_OUT_PRG_DIVO_CYCLES;
> +
> +       /* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */
> +       new_bytes[0] = old_bytes[0] & SIT9531X_OUT_PRG_OPSTG_MASK;
> +       new_bytes[0] |= (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &
> +                       SIT9531X_OUT_PRG_FINE_MASK;
> +       new_bytes[0] |= (u8)((prg_coarse >> 32) &
> +                            SIT9531X_OUT_PRG_COARSE_HI_MASK);
> +       new_bytes[1] = (u8)((prg_coarse >> 24) & 0xFF);
> +       new_bytes[2] = (u8)((prg_coarse >> 16) & 0xFF);
> +       new_bytes[3] = (u8)((prg_coarse >> 8) & 0xFF);
> +       new_bytes[4] = (u8)(prg_coarse & 0xFF);
> +}
> +
> +/*
> + * Write an output's delay bytes.  The caller must already be in the
> + * programming state.  On a failure every byte is put back, the one whose
> + * write reported the error included, since it may have reached the part.
> + */
> +static int sit9531x_output_phase_bytes_write(struct sit9531x_dev *sitdev,
> +                                            u8 out_idx, const u8 *new_bytes,
> +                                            const u8 *old_bytes)
> +{
> +       int rc, ret, rb_rc = 0;
> +       u8 i;
> +
> +       for (i = 0; i < SIT9531X_OUT_PRG_BYTES; i++) {
> +               rc = sit9531x_write_u8(sitdev,
> +                                      sit9531x_output_prg_reg(sitdev, out_idx, i),
> +                                      new_bytes[i]);
> +               if (rc)
> +                       goto rollback;
> +       }
> +
> +       return 0;
> +
> +rollback:
> +       for (i = 0; i < SIT9531X_OUT_PRG_BYTES; i++) {
> +               ret = sit9531x_write_u8(sitdev,
> +                                       sit9531x_output_prg_reg(sitdev, out_idx, i),
> +                                       old_bytes[i]);
> +               if (ret && !rb_rc)
> +                       rb_rc = ret;
> +       }
> +       if (rb_rc) {
> +               dev_err(sitdev->dev,
> +                       "out%u: phase-adjust rollback failed (%d), the delay registers are part old and part new\n",
> +                       out_idx, rb_rc);
> +               if (!rc)
> +                       rc = rb_rc;
> +       }
> +
> +       return rc;
> +}
> +
> +/*
> + * Error of realizing @abs_ps as @cycles whole VCO cycles plus the fine
> + * steps that come nearest, which are returned through @fine.
> + */
> +static u64 sit9531x_output_phase_quant_err(u64 abs_ps, u64 fvco, u64 cycles,
> +                                          u8 *fine)
> +{
> +       u64 cycles_ps, steps = 0;
> +
> +       cycles_ps = mul_u64_u64_div_u64(cycles, 1000000000000ULL, fvco);
> +       if (abs_ps > cycles_ps)
> +               steps = div64_u64(abs_ps - cycles_ps +
> +                                 SIT9531X_OUT_PRG_FINE_STEP_PS / 2,
> +                                 SIT9531X_OUT_PRG_FINE_STEP_PS);
> +       *fine = min_t(u64, steps, SIT9531X_OUT_PRG_FINE_MAX);
> +
> +       return abs_diff(abs_ps, cycles_ps +
> +                       (u64)*fine * SIT9531X_OUT_PRG_FINE_STEP_PS);
> +}
> +
> +/*
> + * Quantize a phase request: fold @phase_ps into one output period and
> + * split it into whole VCO cycles (@coarse_out, without the divider's
> + * settling cycles) and fine steps (@fine_out).  @phase_adj gets the delay
> + * the two realize, in the request's sign and bounded to the advertised
> + * range, which is what the cache holds.  Pure arithmetic against @fvco
> + * and the divider @divo the output runs on, so a caller can encode
> + * before it enters the programming state.
> + */
> +static int sit9531x_output_phase_encode(u64 fvco, u64 divo, s32 phase_ps,
> +                                       u64 *coarse_out, u8 *fine_out,
> +                                       s32 *phase_adj)
> +{
> +       u64 abs_ps, cycles, frac_ps, coarse = 0, coarse_ps, t_out_ps;
> +       s64 phase_norm_ps = 0;
> +       u8 fine = 0;
> +
> +       t_out_ps = mul_u64_u64_div_u64(divo, 1000000000000ULL, fvco);
> +       if (!t_out_ps)
> +               return -EINVAL;
> +

I think you can do this here:

if (!phase_ps) {
	*coarse_out = 0;
	*fine_out = 0;
	*phase_adj = 0;
	return 0;
}

and saves CPU cycles consumed by divisions below.

> +       /*
> +        * Convert to unsigned absolute delay.  Both signs are folded
> +        * modulo one period: positive delays wrap naturally, negative
> +        * delays are rendered as T_out - |phase|.  abs() is safe here
> +        * because the core rejects anything outside the advertised phase
> +        * range, which is +/-1 ms.
> +        *
> +        * The period is exactly DIVO VCO cycles, whereas in picoseconds it
> +        * is a fraction more often than not: 7812.5 ps at 128 MHz from a
> +        * 5.12 GHz VCO, and a fold on the truncated 7812 drops the half
> +        * picosecond once per period folded away, so 100 us -- 12800
> +        * periods exactly -- would come out as 6400 ps rather than nothing.
> +        * Fold the whole VCO cycles of the request modulo DIVO instead, and
> +        * carry the sub-cycle part across as it is.  div64_u64_rem() rather
> +        * than the % operator: a 64-bit modulo has no compiler helper on
> +        * 32-bit targets and leaves the module with an undefined __umoddi3.
> +        */
> +       abs_ps = abs(phase_ps);
> +       cycles = mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);
> +       frac_ps = abs_ps - mul_u64_u64_div_u64(cycles, 1000000000000ULL, fvco);
> +       div64_u64_rem(cycles, divo, &cycles);
> +       abs_ps = mul_u64_u64_div_u64(cycles, 1000000000000ULL, fvco) + frac_ps;
> +       /*
> +        * The truncations above can put a request within a picosecond of a
> +        * whole period a picosecond past it; that is the same edge as none.
> +        */
> +       if (abs_ps >= t_out_ps)
> +               abs_ps = 0;
> +       phase_norm_ps = phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;
> +       abs_ps = (phase_ps < 0 && abs_ps) ? t_out_ps - abs_ps : abs_ps;
> +
> +       if (abs_ps) {
> +               u64 floor_cycles, err, alt_err;
> +               u8 alt_fine;
> +
> +               /*
> +                * coarse_cycles = abs_ps * Fvco / 1e12 ps/s.
> +                * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches
> +                * one second of 1 PPS wrap-around.
> +                */
> +               floor_cycles = mul_u64_u64_div_u64(abs_ps, fvco,
> +                                                  1000000000000ULL);
> +
> +               /*
> +                * Fine = round((abs_ps - coarse * vco_period_ps) / 30 ps).
> +                * The fine field spans 210 ps, more than one VCO cycle in
> +                * every band, so the cycle count that floors the request is
> +                * not always the nearest encoding: one cycle more can land
> +                * closer than any fine code when the remainder sits just
> +                * under a cycle, and one cycle fewer with a larger fine code
> +                * can land closer or exact -- 210 ps at 5 GHz is seven fine
> +                * steps, not a cycle and a ten picosecond remainder.  Take
> +                * the nearest of the three, the floor on a tie.
> +                */
> +               coarse = floor_cycles;
> +               err = sit9531x_output_phase_quant_err(abs_ps, fvco, coarse,
> +                                                     &fine);
> +               alt_err = sit9531x_output_phase_quant_err(abs_ps, fvco,
> +                                                         floor_cycles + 1,
> +                                                         &alt_fine);
> +               if (alt_err < err) {
> +                       coarse = floor_cycles + 1;
> +                       fine = alt_fine;
> +                       err = alt_err;
> +               }
> +               if (floor_cycles) {
> +                       alt_err = sit9531x_output_phase_quant_err(abs_ps, fvco,
> +                                                                 floor_cycles - 1,
> +                                                                 &alt_fine);
> +                       if (alt_err < err) {
> +                               coarse = floor_cycles - 1;
> +                               fine = alt_fine;
> +                       }
> +               }
> +
> +               /*
> +                * A delay that quantizes to a whole output period or beyond
> +                * is the same edge as no delay at all; program none, so the
> +                * registers hold no residual past the period and the cache
> +                * below describes exactly what they realize.
> +                */
> +               coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +               if (coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS >=
> +                   t_out_ps) {
> +                       coarse = 0;
> +                       fine = 0;
> +               }
> +
> +               if (coarse + SIT9531X_OUT_PRG_DIVO_CYCLES >=
> +                   (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))
> +                       return -ERANGE;
> +       }
> +
> +       coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +       abs_ps = coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;
> +       /*
> +        * Quantization can also land a few picoseconds past the end of the
> +        * advertised range, which the getter must not report.  Bound both
> +        * signs to the range; the positive one is also what keeps the cast
> +        * to the s32 the ABI carries safe.
> +        */
> +       if (phase_norm_ps < 0)
> +               *phase_adj = abs_ps ?
> +                            -(s32)min_t(u64, t_out_ps - abs_ps,
> +                                         SIT9531X_OUT_PHASE_ADJ_MAX_PS) : 0;
> +       else
> +               *phase_adj = (s32)min_t(u64, abs_ps,
> +                                        SIT9531X_OUT_PHASE_ADJ_MAX_PS);
> +
> +       *coarse_out = coarse;
> +       *fine_out = fine;
> +
> +       return 0;
> +}
Thanks,
Ivan

