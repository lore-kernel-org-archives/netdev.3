Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0E5AA66F;
	Thu, 17 Sep 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657359; cv=none; b=gAVWEfyfmFlvZwUIzmRvltEjBrMjJVkKDB7cC2U5DbWZzfavKmf10u60Ncw7jUmVI+7ZAuF5qFQMBiGyQQFqHIXQ/0o45sKVvCbvL3/Yvlb+77vBc77nu84luQYY+4U5cXsBhfyOWyY6RzFwnqj3UjeqEbvbGaKffA8BqUPpju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657359; c=relaxed/simple;
	bh=D4UV4jtkrbeudSFJf50Yj968Ng6RK3L/H77z9dKW5KI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlcLdXTLP0bdJ5E5cnJu54fmpQSDg14DpaUBz46Qe31WTev4fGUO5Yo2uRdispxHqA7WgSMxeFH/NWhJ8z+eg0zBb0baEsWULrnFOiaMonsqoVLk+ueRW1Tj0nsa6ocbOzkPwtIa4VFPn8m8xoz8CRxuetAo7G2ZK2gBfM4VKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egGN8BF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egGN8BF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C4F1F000FF;
	Thu, 17 Sep 2026 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657322;
	bh=siVLCPf9p0DYKKUBIgL95NVPIdDHjBjG/65Rszfi3fE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=egGN8BF//xBV45NlsnJyRMixpLIjN2ER99xRVRv1lY0Sld0sj8SfcbtNfMVfB6Ebq
	 431oGqXWb1GM5QmzIkQ2APjwKMunnd0T3V69Ejq+inup7j2c3ADpT0/IgNPrqcAzqL
	 DUUiXrDteL4E/6lK/B90e0ex6vqie8weKs7Wrt0iasoDroWkQeCvY2gW7cYAfNScZ3
	 URlvvdYNYLhPrBu2IiTV+ptO3u/xyEnOdD08DyltLGQyUR3hQApUDFbZJePKStVhSe
	 yJIObowHrv/1150FoD3av1cEZoU+vrbT20GKhuAuGVn9Y8e2SfIx6nRYqeg/jIBzfk
	 rWvcYfeATkyOQ==
Subject: Re: [PATCH net-next v9 15/15] dpll: sit9531x: allow the device tree
 to override two board facts
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:02:00 +0000
Message-ID: <178965732099.22033.18013891704186374305@kernel.org>
In-Reply-To: <20260915000015.80480-16-arouhi@sitime.com>
References: <20260915000015.80480-16-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)

- [High] The new parse-time band check in sit9531x_parse_board_config()
  (drivers/dpll/sit9531x/core.c:3912-3921, via sit9531x_fvco_in_band()…
- [Medium] sit9531x_parse_board_config()
  (drivers/dpll/sit9531x/core.c:3934-3964) pre-fills out_pll_map[] with…
- [Low] sit9531x_parse_board_config() reads `sitime,pll-fvco` with a
  fixed count (device_property_read_u64_array(..., SIT9531X_NUM_PLLS) at…

Pre-existing issues:
- [Low] The kernel-doc-style header of sit9531x_get_fvco()
  (drivers/dpll/sit9531x/core.c:1488-1500) describes the function as…

--

dpll: sit9531x: allow the device tree to override two board facts

This adds sit9531x_parse_board_config(), which lets a board state its
per-PLL VCO frequency via sitime,pll-fvco and its output-to-PLL routing
via sitime,output-pll-map, both optional, plus a per-PLL band check on
the supplied Fvco values.  The parser is called from sit9531x_dev_probe()
just after the reset GPIO is taken.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index b15859890caa7..51f7d8a4ea445 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -3862,6 +3862,108 @@ static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
>  	return clkid;
>  }
>  
> +/*
> + * Does an Fvco fall in the band the given PLL runs in?
> + *
> + * The two bands are disjoint, and which one applies is fixed per PLL, so a
> + * single envelope from the bottom of the low band to the top of the high
> + * one would accept both the ~1 GHz gap between them and a rate belonging to
> + * the other PLL's band.
> + */
> +static bool sit9531x_fvco_in_band(u8 pll_idx, u64 fvco)
> +{
> +	if (pll_idx == 1 || pll_idx == 3)
> +		return fvco >= SIT9531X_FVCO_HIGHBAND_MIN &&
> +		       fvco <= SIT9531X_FVCO_HIGHBAND_MAX;
> +
> +	return fvco >= SIT9531X_FVCO_LOWBAND_MIN &&
> +	       fvco <= SIT9531X_FVCO_LOWBAND_MAX;
> +}
> +
> +/*
> + * Board-config overrides for fixed efuse/blob routing the chip registers do
> + * not describe unambiguously.  Absent properties leave pll_fvco[] zeroed
> + * (derive from DIVN) and out_pll_map_valid false (use the OUT_MAP registers).
> + */
> +static void sit9531x_parse_board_config(struct sit9531x_dev *sitdev)
> +{
> +	u32 map[SIT9531X_MAX_OUTPUTS];
> +	int n, i, rc;
> +
> +	if (device_property_present(sitdev->dev, "sitime,pll-fvco")) {
> +		rc = device_property_read_u64_array(sitdev->dev,
> +						    "sitime,pll-fvco",
> +						    sitdev->pll_fvco,
> +						    SIT9531X_NUM_PLLS);

[Severity: Low]

Is an oversized sitime,pll-fvco silently truncated here?  This is a
fixed-count read and only the return value is checked, so for
device-tree firmware it reaches of_property_read_u64_array() with
sz_min = 4 and sz_max = 0, and of_find_property_value_of_size() only
rejects a too-long property when max is non-zero:

	if (max && prop->length > max)
		return ERR_PTR(-EOVERFLOW);

A property with five or more cells then returns success, the first four
are applied and the surplus is dropped without a diagnostic.  A short
array is correctly rejected with -EOVERFLOW, so only the long case goes
unreported.  Would device_property_count_u64() plus a count check be
more consistent with the map path below, which does validate the count,
and with the comment that mentions guarding against a wrong cell count?

[Severity: Low]

This isn't a bug introduced by this patch, but once pll_fvco[] can be
populated from DT, the header of sit9531x_get_fvco() no longer describes
what the function does.  It says:

 * Fvco = Fref * DIVN, where DIVN comes from sit9531x_divn_static() and
 * Fref = xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref
 * target programmed by the NVM blob and is authoritative in both
 * free-run and sync modes.

while the first branch of the body returns the override without reading
DIVN at all:

	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx]) {
		*fvco = sitdev->pll_fvco[pll_idx];
		return 0;
	}

Both the header and that branch predate this commit, which only adds the
parser that fills pll_fvco[].  Could the header mention the override
while the surrounding comments are being touched anyway?

> +		if (rc) {
> +			dev_warn(sitdev->dev,
> +				 "invalid sitime,pll-fvco (%d), ignoring\n",
> +				 rc);
> +			memset(sitdev->pll_fvco, 0, sizeof(sitdev->pll_fvco));
> +		}
> +
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
> +	}

[Severity: High]

Does this check reject the value in the binding's own example?
sit9531x_fvco_in_band() fixes PLLA and PLLC to the low band, whose top
is SIT9531X_FVCO_LOWBAND_MAX (5898240000), and
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml has:

            sitime,pll-fvco = /bits/ 64 <6900000000 0 0 0>;

Index 0 is PLLA, so f = 6900000000 fails sit9531x_fvco_in_band(0, f) and
this loop sets pll_fvco[0] = 0 after only a dev_warn.  A device tree
copied from the documentation then gets the register-derived path
instead of the override.

Zeroing the entry does not mean "ignore the property" in the consumers,
it means "derive from DIVN".  sit9531x_get_fvco() falls through to
sit9531x_divn_static() and returns -ENODATA when DIVN is unprogrammed,
and sit9531x_output_divo_calc() turns that into -ENODEV:

	rc = sit9531x_get_fvco(sitdev, pll_idx, &fvco);
	if (rc)
		return rc == -ENODATA ? -ENODEV : rc;
	if (!sitdev->pll_fvco[pll_idx]) {
		if (fvco < fvco_min)
			fvco = fvco_min;
		else if (fvco > fvco_max)
			fvco = fvco_max;
	}

So for the documented example the free-run case the commit message
describes either fails with -ENODEV or falls back to a DIVN-derived rate
clamped to at most 5.89824 GHz, and DIVO is then computed from
5.89824e9 rather than 6.9e9 (roughly 17 percent off) while the write is
reported as success.

The two consumer comments added earlier in the series state the opposite
intent.  sit9531x_get_fvco() says:

	 * DT board-config override: some configs (e.g. an INTSYNC PLL)
	 * run a VCO that Fref*DIVN does not reproduce.  When the board
	 * supplies the measured VCO, use it verbatim.

and sit9531x_output_divo_calc() says the override is the source of truth
"e.g. a chip variant that runs out of the documented band" and therefore
skips the band clamp in that case, which after this patch can never
happen.

Should the band check warn but keep the board value, or should the
binding example, the per-index schema constraints and those two consumer
comments be corrected in the same patch?  As it stands the case the
property exists for is the one case that is dropped.

> +
> +	if (!device_property_present(sitdev->dev, "sitime,output-pll-map"))
> +		return;
> +
> +	/*
> +	 * Any 1..MAX_OUTPUTS length is accepted so the 8-output SiT95317 need
> +	 * not pad to 12; variant detection has not run yet and entries past
> +	 * the detected num_outputs are never indexed.  Trailing entries of a
> +	 * short map must read as unmapped rather than 0 (== PLLA), which
> +	 * would mark unrouted outputs active in sit9531x_out_state_fetch().
> +	 */
> +	memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,
> +	       sizeof(sitdev->out_pll_map));
> +
> +	n = device_property_count_u32(sitdev->dev, "sitime,output-pll-map");
> +	if (n <= 0 || n > SIT9531X_MAX_OUTPUTS ||
> +	    device_property_read_u32_array(sitdev->dev, "sitime,output-pll-map",
> +					   map, n)) {
> +		dev_warn(sitdev->dev,
> +			 "invalid sitime,output-pll-map, ignoring\n");
> +		return;
> +	}

[Severity: Medium]

Can a map shorter than the part's output count silently remove DPLL
output pins?  The only length test is n <= 0 || n > SIT9531X_MAX_OUTPUTS,
and out_pll_map_valid is then set unconditionally, so entries from n to
num_outputs - 1 stay at 0xFF and are trusted as real routing
information.

sit9531x_out_state_fetch() takes the unmapped branch and returns before
the OUT_MAP_LO/HI scan that would have found the routing:

	if (sitdev->out_pll_map_valid) {
		u8 m = sitdev->out_pll_map[index];

		if (m < SIT9531X_NUM_PLLS) { ... } else {
			out->pll_idx = 0;
			out->routed = false;
			out->enabled = false;
		}
		return 0;
	}

and sit9531x_dpll_pin_is_registrable() then refuses the pin:

	return sitdev->out[index].pll_idx == sitdpll->id &&
	       sitdev->out[index].routed;

So an accidentally truncated map (8, or even 1, entry on the 12-output
SiT95316) drops those pins with no diagnostic, while a bad per-entry
value below is rejected loudly.

The binding also states a different contract for the same property.
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml declares
minItems: 8 / maxItems: 12, then maxItems: 8 for sitime,sit95317 and
minItems: 12 for sitime,sit95316, i.e. an exact length per variant,
while the comment above says any 1..MAX_OUTPUTS length is accepted.  In
the other direction a 12-entry map on a SiT95317 is accepted and entries
8..11 are ignored without comment.

Would it work to move the sit9531x_parse_board_config() call after
sit9531x_match_variant() and require n == info->num_outputs (or warn),
so the per-variant length the binding specifies can actually be checked?

> +
> +	/*
> +	 * The binding allows only 0-3 and 255 per entry.  A stray value
> +	 * would silently unroute an output (m >= SIT9531X_NUM_PLLS reads
> +	 * as unmapped in sit9531x_out_state_fetch()), so reject the whole
> +	 * property loudly instead.
> +	 */
> +	for (i = 0; i < n; i++) {
> +		if (map[i] >= SIT9531X_NUM_PLLS &&
> +		    map[i] != SIT9531X_OUT_PLL_UNMAPPED) {
> +			dev_warn(sitdev->dev,
> +				 "sitime,output-pll-map entry %d is %u (must be 0-3 or 255), ignoring map\n",
> +				 i, map[i]);
> +			return;
> +		}
> +	}
> +
> +	for (i = 0; i < n; i++)
> +		sitdev->out_pll_map[i] = map[i];
> +	sitdev->out_pll_map_valid = true;
> +}
> +
>  int sit9531x_dev_probe(struct sit9531x_dev *sitdev)
>  {
>  	struct clk *xtal_clk;
> @@ -3906,6 +4008,8 @@ int sit9531x_dev_probe(struct sit9531x_dev *sitdev)
>  	if (sitdev->reset_gpio)
>  		fsleep(10000);	/* internal boot after release */
>  
> +	sit9531x_parse_board_config(sitdev);
> +
>  	rc = sit9531x_read_variant_id(sitdev, &variant_id);
>  	if (rc)
>  		return rc;

Nothing between this call and sit9531x_match_variant() appears to consume
the parsed data, so is there a reason the parse cannot run after
sitdev->info is known?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
