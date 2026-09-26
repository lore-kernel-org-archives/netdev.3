Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAB36B931;
	Sat, 26 Sep 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390099; cv=none; b=WLi6D5MlNhiAlI5a0FWbMxn5Fz1Myyaya+C2lIM1dsoJ2UWIqdUCG0Q7lsKXSELLYPo0ArubBP/w7JHsdTsmE85VLg+FkUgqQmnolUqBiayur1E0MdnMWJqa9RfY1fNlj8GhnmPj7ExeqCDiduUFluK6k9qUnpJW76zOPVR0h1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390099; c=relaxed/simple;
	bh=RDIs9mOAtjjo6Fq/zvcEuPMAF2E8NbDtpK8b4Uwxd4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWzOJUC/2IRWSrUmgvS//l7iLrAKdVrDgm776JZEgSVFycVXcw2oeU3tjJ+2rdS58PHX4aewBjTfusDiz+ZhVK9YfC6oc9bphehz1m4lxO543q5owKsdkFTMCa3M9KIIq+djwsAMic7lrRyA5liomokeAtUvDN21GUir0GWJyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnDRHkg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnDRHkg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EFE1F000FF;
	Sat, 26 Sep 2026 02:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390097;
	bh=+e4TT4WCC7++SWov5Bps2rbw23YLvuoGncvYHtPeWeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DnDRHkg0LQi0nJHk+s20daO2qVBcWKsQmp57NOSx0u9TdlzWkI8D+5EVH8eQwCh5G
	 Z7sLxLeN1R/4ERwF+4VzQIOXn8jHRFzYL5aFMftOWO3lDaflcary57AZfEFMjs+VSB
	 fot7a0xeYVmKFbU7syGwXWC76bn4lLr0+q0h2yN2oKCVGwoSwrxEVPk8xX927y5ytM
	 fsa7WUkzCzE/beyq7z/12MsyaMnN3gs1t0lOp3oD9p+P9Jxj43pFyZp9XJN1Q/Bb27
	 nmnaX/WgFDw75wRqcKfqS4GD+moW+BWoxRDBP1bmTWIBhMHqiuSeeJqEd2MNoxPR6R
	 mQM7I1siPauSQ==
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
Subject: Re: [PATCH v10 14/14] dpll: sit9531x: allow the device tree to override two board facts
Date: Fri, 25 Sep 2026 19:34:55 -0700
Message-ID: <20260926023455.1568256-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-15-arouhi@sitime.com>
References: <20260921201108.42676-15-arouhi@sitime.com>
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
dpll: sit9531x: allow the device tree to override two board facts

This patch adds two optional device tree overrides to the sit9531x driver.
"sitime,pll-fvco" replaces the VCO frequency derived from DIVN for each
PLL. "sitime,output-pll-map" replaces the output-to-PLL routing that is
normally read from the OUT_MAP registers.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index e8d47999f1a97..5316e6bcb338c 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -3238,6 +3241,27 @@ static int sit9531x_out_state_fetch(struct sit9531x_dev *sitdev, u8 index)
>  
>  	sitdev->out[index].state_stale = false;
>  
> +	/*
> +	 * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps
> +	 * (0x27/0x28) do not unambiguously express output->PLL routing on
> +	 * every config (overlaps, and some outputs routed outside that
> +	 * path).  When the board supplies an explicit map, trust it.
> +	 */
> +	if (sitdev->out_pll_map_valid) {
> +		u8 m = sitdev->out_pll_map[index];

[Severity: Medium]
Which index namespace is out_pll_map[] meant to use?

Here the map is indexed by the driver's packed logical output index. The
register path further down in the same function uses the physical slot:

	slot = sitdev->info->clkout_map[index];

The other firmware-facing output code also uses the physical slot.
sit9531x_prop_pin_fwnode_get() in prop.c translates before it matches
output-pins/pin@reg:

	id = sitdev->info->clkout_map[id];

sit9531x_prop_pin_label_init() also names package labels by slot:

	"OUT%u", sitdev->info->clkout_map[id]);

On SiT95317 the mapping is not contiguous:

	static const u8 clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11};

So map entry 1 describes OUT3 and entry 4 describes OUT7. Seven of the
eight positions don't match OUTn numbering.

The binding text for sitime,output-pll-map only says "for each output
0..11". It doesn't say that SiT95317 entries are packed logical indices.

Suppose a board author numbers the map by OUTn, as pin@reg and the labels
suggest. Could the routing then be applied to the wrong outputs without
any warning?

An 8- or 12-entry map like that passes the value checks in
sit9531x_parse_board_config(). It also passes the length check in
sit9531x_dev_probe(), because the count is not less than num_outputs.

The misrouted out->pll_idx then picks the wrong PLL's Fvco in
sit9531x_get_fvco(). That affects the frequency get, frequency set and
phase adjust paths. The low and high VCO bands are disjoint, so the error
would be large. A 255 entry in the wrong position would also unregister
the wrong pin.

This binding is new in this series, so should the indexing be settled
before DTs ship with it? The map could be indexed by physical slot like
pin@reg, or the binding could document the SiT95317 packing explicitly.

> +
> +		if (m < SIT9531X_NUM_PLLS) {
> +			out->pll_idx = m;
> +			out->routed = true;
> +			out->enabled = !muted;
> +		} else {
> +			out->pll_idx = 0;
> +			out->routed = false;
> +			out->enabled = false;
> +		}
> +		return 0;
> +	}

[Severity: Low]
This isn't a bug, but the header comment of sit9531x_out_state_fetch() is
now stale. It still says:

 * Reads the output PLL association from the PLL page output map
 * registers into out->routed / out->pll_idx, ...

With out_pll_map_valid set, pll_idx and routed come from the DT map and
the OUT_MAP_LO/HI registers are never read. The comment for
sit9531x_get_fvco() was updated for its override path in this patch.
Could this one be updated too?

> +
>  	/*
>  	 * The OUT_MAP_LO/HI bitmaps are indexed by the physical slot the
>  	 * output occupies on the chip, not by the driver's logical output

[ ... ]

> +		/*
> +		 * The override is used verbatim by the divider math, so an
> +		 * implausible value (units typo, wrong cell count worked
> +		 * around with zeros) must not silently misprogram DIVO.
> +		 * Anything outside both VCO bands is dropped with a warning
> +		 * rather than trusted.
> +		 */
> +		for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +			u64 f = sitdev->pll_fvco[i];
> +
> +			if (f && !sit9531x_fvco_in_band(i, f)) {
> +				dev_warn(sitdev->dev,
> +					 "PLL%c Fvco override %llu Hz is outside the band that PLL runs in, ignoring\n",
> +					 'A' + i, f);
> +				sitdev->pll_fvco[i] = 0;
> +			}
> +		}

[Severity: Low]
Should the binding describe the per-PLL range enforced here?

The binding declares sitime,pll-fvco as a 4-item uint64-array. It has no
per-item minimum or maximum and no documented range, and says only that 0
keeps the register-derived value.

This loop zeroes any non-zero entry that fails sit9531x_fvco_in_band().
That check requires 6.875 to 7.8125 GHz for PLLB/PLLD and 4.9152 to
5.89824 GHz for PLLA/PLLC.

A DT can pass dt_binding_check and still have its override dropped at
probe. Examples are a PLLA value in the high band, or a value in the gap
between the bands. The driver then falls back to the DIVN derivation that
the override was meant to replace.

The binding example of 6875000000 for PLLB sits exactly on
SIT9531X_FVCO_HIGHBAND_MIN. It is accepted only because the check is
inclusive.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -224,6 +224,7 @@ struct sit9531x_dev {
>  	u64			pll_fvco[SIT9531X_NUM_PLLS];
>  	u8			out_pll_map[SIT9531X_MAX_OUTPUTS];
>  	bool			out_pll_map_valid;
> +	u8			out_pll_map_count;
>  
>  	/* Inter-PLL synchronization state */
>  	s8			intsync_src;

[Severity: Low]
This isn't a bug, but the kernel-doc block above struct sit9531x_dev
wasn't updated for the new out_pll_map_count member. Running
scripts/kernel-doc over core.h will warn about the missing
@out_pll_map_count description.

A short description would also help the reader. The name alone doesn't
say what the member counts.

sit9531x_parse_board_config() fills it with the raw length of the
sitime,output-pll-map property. That happens before the variant is
known. The value only means something while out_pll_map_valid is set.
sit9531x_dev_probe() then compares it against info->num_outputs to
decide whether to drop the map.

Could a one-line @out_pll_map_count entry be added that says this?
