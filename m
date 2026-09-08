Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04B156661;
	Tue,  8 Sep 2026 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871536; cv=none; b=DaSEu13zT9HJE90dx+oR2idDS4aow2UMdi4GLDfkOOVtnFErq88lgYIkPPvAFbT4mwA5be8ndQAjQIqYgKBRYPW22A6ECmQdzbj0wURhxipQa6J9PJ2PCAZNf0WryAq/MwagoinNpObSpI8aSg2wSq9HrEB01Q25npvzgdg4Oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871536; c=relaxed/simple;
	bh=6l7qd8nv0Mb1mC+hWYPI+BnhlS+jn0bTOqlQ6Q4C2vo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1MfIR/5ptabKW05N9hcCkf0XHiVdi1UWqx/Amm6ZkQqGHnGxBdDDppoBPG048HWMaS83+7UGb8INdef5cQvmOZ31luoYRzB29ReaSqRnc6+9KaD35CBgZi3d9aRz1EOYqfAd3uY3JPoKcq8BaloflMmG1/RUj/PjubKv/mzVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A81F00A3E;
	Tue,  8 Sep 2026 12:45:33 +0000 (UTC)
Subject: Re: [PATCH net-next v8 15/15] dpll: sit9531x: allow the device tree
 to override two board facts
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:31 +0000
Message-ID: <178887153173.219967.10560676348042858719@kernel.org>
In-Reply-To: <20260902214030.20955-16-arouhi@sitime.com>
References: <20260902214030.20955-16-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] sit9531x_parse_board_config()
  (drivers/dpll/sit9531x/core.c:3193-3195) copies the DT array…
- [Medium] Every failure path in the new sit9531x_parse_board_config()
  (drivers/dpll/sit9531x/core.c:3166-3196) is silent, so a board that…
- [Medium] The new parser accepts "sitime,pll-fvco" values with no
  plausibility check (drivers/dpll/sit9531x/core.c:3171-3172),…
- [Low] The commit message's justification for the new "sitime,pll-fvco"
  DT property does not match the code it activates.

--

dpll: sit9531x: allow the device tree to override two board facts

The patch adds sit9531x_parse_board_config(), which reads two optional
vendor properties at probe time: "sitime,pll-fvco" (per-PLL VCO frequency)
and "sitime,output-pll-map" (per-output source PLL).  Absent both
properties the driver keeps deriving Fvco from DIVN and reading the routing
from the OUT_MAP registers.

A few questions below, one about the changelog and three about the new
parser.

> dpll: sit9531x: allow the device tree to override two board facts
>
>     The VCO frequency is derived from the feedback divider, which is exact
>     while the loop runs but not while a PLL sits in free-run with a divider
>     the configuration never programmed; a board that knows its own VCO can
>     state it.

[Severity: Low]
Is the free-run rationale here consistent with the code the property feeds?

The kernel-doc above sit9531x_get_fvco() says the opposite about free-run:

  * Fvco = Fref * DIVN, where DIVN comes from sit9531x_divn_static() and
  * Fref = xtal_freq << doubler.  DIVN is the
  * steady-state Fvco/Fref target programmed by the NVM blob and is
  * authoritative in both free-run and sync modes; ...

The override's own comment in sit9531x_get_fvco() and the binding text name
INTSYNC, not free-run, as the case where the derivation does not reproduce
the VCO:

	/*
	 * DT board-config override: some configs (e.g. an INTSYNC PLL)
	 * run a VCO that Fref*DIVN does not reproduce.  When the board
	 * supplies the measured VCO, use it verbatim.
	 */

Could the changelog name the configuration where Fref*DIVN actually fails?

The changelog also says "Absent the properties the driver behaves exactly as
before", which is accurate, but it does not mention that when the property
is present sit9531x_output_freq_set() stops clamping Fvco to the per-PLL
band:

	} else if (!sitdev->pll_fvco[pll_idx]) {
		if (fvco < fvco_min)
			fvco = fvco_min;
		else if (fvco > fvco_max)
			fvco = fvco_max;
	}

Should that clamp bypass be called out, given this adds a permanent
vendor-specific DT ABI?

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index c3d7c4851549..d75ac02047b5 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -3158,6 +3158,43 @@ static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
>  	return clkid;
>  }
>  
> +/*
> + * Board-config overrides for fixed efuse/blob routing the chip registers do
> + * not describe unambiguously.  Absent properties leave pll_fvco[] zeroed
> + * (derive from DIVN) and out_pll_map_valid false (use the OUT_MAP registers).
> + */
> +static void sit9531x_parse_board_config(struct sit9531x_dev *sitdev)
> +{
> +	u32 map[SIT9531X_MAX_OUTPUTS];
> +	int n, i;
> +
> +	device_property_read_u64_array(sitdev->dev, "sitime,pll-fvco",
> +				       sitdev->pll_fvco, SIT9531X_NUM_PLLS);

[Severity: Medium]
Should the return value of this read be checked?

device_property_read_u64_array() requires exactly SIT9531X_NUM_PLLS
elements, so a property with 1..3 entries returns -EOVERFLOW and writes
nothing.  pll_fvco[] then stays zero and sit9531x_get_fvco() silently falls
back to the derivation:

	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx])
		return sitdev->pll_fvco[pll_idx];

A board that states its VCO incorrectly is therefore indistinguishable from
a board that states nothing, with nothing in dmesg.  Would a dev_warn() (or
dev_err_probe()) on a non-zero return be preferable?

[Severity: Medium]
Can an out-of-range Fvco here silently misprogram DIVO?

The value is stored without any plausibility check, sit9531x_get_fvco()
returns it verbatim, and sit9531x_output_freq_set() skips the band clamp
for it, so fvco is no longer bounded by SIT9531X_FVCO_HIGHBAND_MAX.  DIVO
is then only checked for zero:

	divo = div64_u64(fvco, frequency);
	if (!divo)
		return -EINVAL;

but it is packed into a 34-bit field with the upper bits masked away:

	divo_bytes[4] = (divo >> 32) & 0x03;  /* only bits [1:0] */

Before this patch fvco was always clamped to <= 7.8125 GHz, so divo stayed
below 2^34 for any frequency >= 1 Hz and the mask could not lose anything.
With an unclamped DT Fvco (say a units typo giving 69 GHz) and a low output
rate reachable through the esync path, divo >= 2^34 is truncated, written,
and committed by sit9531x_prg_commit() with a phase flush, while
sitdev->out[out_idx].freq is cached from the untruncated divo and the call
returns success.

Would bounding the DT Fvco (and adding minimum/maximum to the schema, which
currently states the bands only in prose), or rejecting divo >= BIT_ULL(34)
instead of truncating, close that?

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
> +					   map, n))
> +		return;

Related to the previous comment on silent failures: all three rejection
cases here return with out_pll_map_valid still false and no diagnostic, so
sit9531x_out_state_fetch() goes back to the OUT_MAP registers the board just
declared wrong.

Since the parse runs before sit9531x_read_variant_id() and
sit9531x_match_variant(), n also cannot be compared against
info->num_outputs.  A 12-output SiT95316 node carrying only 8 entries is
accepted, outputs 8..11 stay SIT9531X_OUT_PLL_UNMAPPED, and four DPLL pins
never appear to userspace even though the binding's minItems: 12
conditional forbids that DT.  Would moving the parse after variant
detection let the length be validated?

> +
> +	for (i = 0; i < n; i++)
> +		sitdev->out_pll_map[i] = map[i];
> +	sitdev->out_pll_map_valid = true;
> +}

[Severity: Medium]
Should the element values be validated before they are narrowed into the u8
out_pll_map[]?

The binding states the values exhaustively:

    items:
      enum: [0, 1, 2, 3, 255]

and the kernel-doc of struct sit9531x_dev repeats it:

 * @out_pll_map:	optional per-output source PLL (0-3, 0xff =
 *			unmapped) from DT "sitime,output-pll-map"

Neither is enforced at runtime, and out_pll_map_valid is set
unconditionally.  Two results follow in sit9531x_out_state_fetch():

	if (sitdev->out_pll_map_valid) {
		u8 m = sitdev->out_pll_map[index];

		if (m < SIT9531X_NUM_PLLS) {
			out->pll_idx = m;
			out->routed = true;
			out->enabled = !muted;
		} else {
			out->pll_idx = 0;
			out->routed = false;
			out->enabled = false;
		}
		return 0;
	}

An entry in 4..254 becomes "unmapped", so an output that is not muted loses
its DPLL pin and userspace can no longer see, mute or retune a clock that is
actively driving.

An entry >= 0x100 whose low byte is 0..3 (0x100, say) truncates to a
valid-looking index, passes m < SIT9531X_NUM_PLLS, and marks the output
routed on a PLL that does not drive it.  That index is then the driver's
only routing model: it picks the VCO band in sit9531x_output_freq_set()

	if (pll_idx == 1 || pll_idx == 3) {
		/* PLLB, PLLD: high band */
		fvco_min = SIT9531X_FVCO_HIGHBAND_MIN;

and selects the PLL passed to sit9531x_output_phase_flush(), which disturbs
every output of that unrelated PLL.

Isn't that the same failure the 0xFF pre-fill comment above says it
prevents ("would mark unrouted outputs active in
sit9531x_out_state_fetch()")?  Would rejecting, or storing as
SIT9531X_OUT_PLL_UNMAPPED with a warning, any entry that is neither
< SIT9531X_NUM_PLLS nor SIT9531X_OUT_PLL_UNMAPPED cover both cases?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
