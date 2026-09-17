Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB045D182
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638970; cv=none; b=TY9Ps48faBG6/I1fki0a2rYks3gaWUhW6MjvdAjVVAEy9qPD7ywE6ZvogEAHDwLDb/osEWKffsQHUKiayXkExv6e8rU2lDmuNJD4/G8B4To0doIqmCVNdvQ2rMrmbHGhVPVFM739xHJoZ9uLexNZ5sNPEqGb1qDmTTt2QMt7uFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638970; c=relaxed/simple;
	bh=E0gDaNKBp/QpVdGPBH3q0Mcn3vBgtp2MxiJhRDcKw/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojBk2BXdmkO9fBzEjms47gERSk092sZoaD4LOPto5dLhDLoX5CwoTmycTNXi1/UJjfuNYJSIFzGtwd7ZLfvoCzpiEBaBKc6bAoz4zcu3tb+DdNtxG+UgTMkU7n8Z0UEW/ogBMeIUl1sgzeNljVelPbgOZD9Uhza2Zi8OlOjecYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vc2ain+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc2ain+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789638952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5UbXnm5mXzyvFuRwrWE9rE40MOY3Phh4TEL38fRFww=;
	b=Vc2ain+8bc91kehpEAS+2uVoGpNtWmw2NkLZwnefyYm14SZL6OaYxr1PmdVB+g7EhQ6aKP
	kTYb4RsxobX8NLJcDYXBIOP+5sfmPHpWSdPrmk0G2shMS3IkY3ilNvH/Qh7r2oOf12pU+c
	PS5gMcIvvwNJlf8N1I72PcO6gjJ/kSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-VAZGBbhAMdas7eUvSAsOSA-1; Thu,
 17 Sep 2026 05:55:48 -0400
X-MC-Unique: VAZGBbhAMdas7eUvSAsOSA-1
X-Mimecast-MFC-AGG-ID: VAZGBbhAMdas7eUvSAsOSA_1789638946
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7C441828ACB;
	Thu, 17 Sep 2026 09:55:46 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E308519AC044;
	Thu, 17 Sep 2026 09:55:42 +0000 (UTC)
Message-ID: <bde28182-fab2-4ae1-b5f8-d425c2d0aeee@redhat.com>
Date: Thu, 17 Sep 2026 11:55:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 10/15] dpll: sit9531x: add support to adjust
 output phase
To: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260915000015.80480-1-arouhi@sitime.com>
 <20260915000015.80480-11-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260915000015.80480-11-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 9/15/26 2:00 AM, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Shift an output in time against the others driven by the same PLL.  The
> device has a coarse delay counted in VCO cycles and a three-bit fine field
> in fixed thirty-picosecond steps, so a requested offset is split between
> the two and what the core reads back is what the registers hold rather
> than what was asked for.
> 
> Delay only ever advances, so an offset larger than one output period is
> folded back into a single period -- for a periodic signal that is the same
> phase.  The write takes effect in the programming state, which is left
> with the loops re-locked even when a write inside it failed.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/core.c | 212 ++++++++++++++++++++++++++++++++++-
>   drivers/dpll/sit9531x/core.h |   4 +
>   drivers/dpll/sit9531x/dpll.c |  56 +++++++++
>   drivers/dpll/sit9531x/regs.h |  27 +++++
>   4 files changed, 298 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index bba42fe302a3..8d857f1a0c89 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1641,7 +1641,17 @@ int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
> 
>          sitdev->out[out_idx].freq = div64_u64(fvco, divo);
> 
> -       return 0;
> +       /*
> +        * The programmed reset delay counts VCO cycles against the output
> +        * period in force when it was written, so a rate change silently
> +        * re-times a previously requested phase adjust.  Re-encode the
> +        * cached picosecond request against the new rate.
> +        */
> +       if (sitdev->out[out_idx].phase_adj)
> +               rc = sit9531x_output_phase_adjust_set(sitdev, out_idx,
> +                                                     sitdev->out[out_idx].phase_adj);
> +
> +       return rc;
>   }
> 
>   /*
> @@ -1731,6 +1741,206 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
>    * output period, which is identical for a periodic signal.
>    */
> 
> +int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
> +                                    u8 out_idx, s32 phase_ps)
> +{
> +       const struct sit9531x_chip_info *info = sitdev->info;
> +       u64 abs_ps, fvco, coarse, coarse_ps, rem_ps, t_out_ps;
> +       s64 phase_norm_ps = 0;
> +       u8 page, base, prog6_val, fine = 0;
> +       u8 old_bytes[5], new_bytes[5], i;
> +       u8 pll_idx, slot;
> +       u64 freq;
> +       int rc, ret, rb_rc;
> +
> +       lockdep_assert_held(&sitdev->multiop_lock);
> +
> +       if (out_idx >= info->num_outputs)
> +               return -EINVAL;
> +
> +       pll_idx = sitdev->out[out_idx].pll_idx;
> +       if (pll_idx >= SIT9531X_NUM_PLLS)
> +               return -EINVAL;
> +
> +       freq = sitdev->out[out_idx].freq;
> +       if (!freq) {
> +               /*
> +                * The cache is only seeded by a DT frequency list or an
> +                * earlier get/set; a board without supported-frequencies-hz
> +                * would otherwise get -EINVAL on every phase request forever.
> +                * Read the effective rate back from the divider chain.
> +                */
> +               rc = sit9531x_output_freq_get(sitdev, out_idx, &freq);
> +               if (rc)
> +                       return rc;
> +               if (!freq)
> +                       return -EINVAL;
> +       }
> +
> +       rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
> +       if (rc)
> +               return rc == -ENODATA ? -ENODEV : rc;
> +
> +       t_out_ps = div64_u64(1000000000000ULL, freq);
> +       if (!t_out_ps)
> +               return -EINVAL;
> +
> +       /*
> +        * Convert to unsigned absolute delay.  Both signs are folded modulo one
> +        * period: positive delays wrap naturally, negative delays are rendered as
> +        * T_out - |phase|.
> +        */
> +       if (phase_ps == 0) {
> +               abs_ps = 0;
> +       } else if (phase_ps > 0) {
> +               abs_ps = (u64)phase_ps;
> +               div64_u64_rem(abs_ps, t_out_ps, &abs_ps);
> +               phase_norm_ps = abs_ps;
> +       } else {
> +               u64 advance = (u64)(-(s64)phase_ps);
> +
> +               /*
> +                * div64_u64_rem() rather than the % operator: a 64-bit
> +                * modulo has no compiler helper on 32-bit targets and
> +                * leaves the module with an undefined __umoddi3.
> +                */
> +               div64_u64_rem(advance, t_out_ps, &advance);
> +               phase_norm_ps = -(s64)advance;
> +               abs_ps = (advance == 0) ? 0 : (t_out_ps - advance);
> +       }

This if-else branches could be reduced to:

<snip>
         abs_ps = abs(phase_ps); /* Safe. INT_MIN is not possible here*/

         div64_u64_rem(abs_ps, t_out_ps, &abs_ps);

         phase_norm_ps = phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;
         abs_ps = phase_ps < 0 && abs_ps ? t_out_ps - abs_ps : abs_ps;
</snip>

> +
> +       /*
> +        * coarse_cycles = abs_ps * Fvco / 1e12 ps/s.
> +        * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches
> +        * one second of 1 PPS wrap-around.
> +        */
> +       coarse = mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);
> +       if (coarse >= (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))
> +               return -ERANGE;
> +
> +       /* Fine delay = round((abs_ps - coarse * vco_period_ps) / 30 ps) */
> +       coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
> +       rem_ps = (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;
> +       if (rem_ps) {
> +               u64 steps;
> +
> +               steps = div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,
> +                                 SIT9531X_OUT_PRG_FINE_STEP_PS);
> +               if (steps > SIT9531X_OUT_PRG_FINE_MAX)
> +                       steps = SIT9531X_OUT_PRG_FINE_MAX;
> +               fine = (u8)steps;
> +       }

Also this whole block can be skipped (and set coarse to 0) in case of
abs_ps == 0 to avoid expensive divisions.

Thanks,
Ivan

