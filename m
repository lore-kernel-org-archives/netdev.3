Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319485437C0;
	Tue,  8 Sep 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871515; cv=none; b=ZBg/jKimFbzQyP9lAlzRpLDPwKYuiOhHTJvk1gs/5YKCdRAY1INqjJnwielAFBRtJ+eutS/9bJ01U7b7Mbi5lt0cp1g6P/7aCrhXF4aMmneUYnl98zVTxXZ9wlvTBbecYnriDiVJHCXOBj0+TuXFGho5UxNI46xb7G29T3Q4X1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871515; c=relaxed/simple;
	bh=vRHDi7OrFlQYFgyGbm4vfWzWbKWOYqKZcdy+VlyBVAs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L90J+bwiuzvcVexaMnkPjdg/K6zyDTQBmzpj89qek6AEXotzfn/a388R2luGN+Rr+hav6q93dU8DhCn1a46FNXXpTS4nk/57opRlCgx/fMh28qt15cFty4i3fFfePaQnjKmy0qI8ToTAlYCdDVEQ0XBWk1q5rn/lbdJqjgTIPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghu2xji+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghu2xji+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B561F00A3A;
	Tue,  8 Sep 2026 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871513;
	bh=IDIPQY1429RFnkc43b9zqw1ZjeK/iuI9FP4iAquXEG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ghu2xji+rdl0UHAV3RVEp/SK2A2EAmYniMtYo8ZpWkotOOj7rHBa6JxFnRZue2OlH
	 mAkCH4BFAuxjUlSW1tbq3PwFMwEcqSsQSdQj0ZtkF8TOh1lfLrt47ZnhgRjfplV9te
	 IUczIE2iwq43uKpymMa/BEUVQA81jRPGH9wTzBot/wRfFO8KWfjUyuxSMP+scxBjUf
	 46f3pkW56VEHkV5dhOfuyR0xY+CvFjMlXXMD6UghNLZAuPLxMk7X1dldg1m3t58z+0
	 vsfT5lfD2NTAOpryXWaSgu8i3VVb6+IIsxrIJV6F7sTRddrvIanxxCKa027zR1a3Nr
	 ococHPZRn3JQg==
Subject: Re: [PATCH net-next v8 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:12 +0000
Message-ID: <178887151271.219967.11606732852756839857@kernel.org>
In-Reply-To: <20260902214030.20955-5-arouhi@sitime.com>
References: <20260902214030.20955-5-arouhi@sitime.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 5

- [Medium] sit9531x_pin_props_get() fabricates the pin's advertised
  frequency capability set instead of deriving it from firmware: after…
- [Low] Concern (largely INVALID at the end of the series): the per-pin
  'hardware state' (sitdev->ref[].freq / sitdev->out[].freq and the…
- [Low] sit9531x_pin_props_get() accepts two 'connection-type' spellings
  that the device-tree binding forbids: it compares the property against…
- [Low] Concern (verified as practically unreachable): supported-
  frequencies-hz is a 64-bit DT property and dpll_pin_frequency.min/max…
- [Low] The XO (crystal) input pin has two conflicting sources of truth
  for its frequency.
- [Low] sit9531x_pin_props_get() ignores the return value of
  fwnode_property_read_u64_array() for "supported-frequencies-hz": it…

--

dpll: sit9531x: read DPLL types and pin properties from system firmware

This patch adds drivers/dpll/sit9531x/prop.c, which builds the per-pin
dpll_pin_properties (package label, type, capabilities, supported
frequency list) and the per-channel dpll_type from the firmware node,
falling back to defaults when the node does not describe them.  A few
questions below about the frequency list and the connection-type parsing.

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> new file mode 100644
> index 000000000000..94f3da716297
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -0,0 +1,406 @@

[ ... ]

> +	} else if (dir == DPLL_PIN_DIRECTION_INPUT &&
> +		   index == SIT9531X_MAX_INPUTS) {
> +		/* The XO reference is fixed: no state or priority control. */
> +		props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
> +		props->dpll_props.capabilities = 0;
> +		sitdev->ref[index].freq = sitdev->xtal_freq;
> +		curr_freq = sitdev->xtal_freq;

[Severity: Low]
Does the XO pin end up with two sources of truth for its frequency here?

The branch seeds sitdev->ref[SIT9531X_MAX_INPUTS].freq from
sitdev->xtal_freq (the clk_get_rate() value read at probe), but unlike the
two INTSYNC pins the XO index is not excluded from the firmware-node path
further down in sit9531x_pin_props_get().

dpll-device.yaml allows an input-pins child for this index:

    patternProperties:
      "^pin@[0-9a-f]+$":
        $ref: /schemas/dpll/dpll-pin.yaml

so a schema-valid DT can supply supported-frequencies-hz for pin 8, and the
seeding block later overwrites ref[8].freq (and curr_freq) with freqs[0].
>From then on sit9531x_dpll_input_pin_frequency_get() reports one crystal
rate to userspace while all the divider and VCO math keeps using
sitdev->xtal_freq.

Would it be simpler to skip the frequency-seeding path for index
SIT9531X_MAX_INPUTS the same way both INTSYNC pins already are?

[ ... ]

> +	/* Look for "connection-type" property -> pin type enum */
> +	if (!fwnode_property_read_string(props->fwnode, "connection-type",
> +					 &type)) {
> +		if (!strcmp(type, "ext"))
> +			props->dpll_props.type = DPLL_PIN_TYPE_EXT;
> +		else if (!strcmp(type, "gnss"))
> +			props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
> +		else if (!strcmp(type, "int") ||
> +			 !strcmp(type, "int-oscillator"))
> +			props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
> +		else if (!strcmp(type, "synce") ||
> +			 !strcmp(type, "synce-eth-port"))
> +			props->dpll_props.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;

[Severity: Low]
Can the "int-oscillator" and "synce-eth-port" comparisons ever match?

Documentation/devicetree/bindings/dpll/dpll-pin.yaml restricts the property
to a closed set:

  connection-type:
    description: Connection type of the pin
    $ref: /schemas/types.yaml#/definitions/string
    enum: [ext, gnss, int, mux, synce]

and sitime,sit95316.yaml inherits that pin schema through dpll-device.yaml.
A DT using either alias fails dt_binding_check/dtbs_check, so those two
comparisons look like dead code for any schema-valid DT.  Should they just
be dropped, or should the binding gain the aliases?

> +	num_freqs = fwnode_property_count_u64(props->fwnode,
> +					      "supported-frequencies-hz");
> +	if (num_freqs <= 0) {
> +		num_freqs = 0;
> +		goto skip_fwnode_props;
> +	}
> +
> +	freqs = kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);
> +	if (!freqs) {
> +		rc = -ENOMEM;
> +		goto err_alloc_freqs;
> +	}
> +
> +	fwnode_property_read_u64_array(props->fwnode,
> +				       "supported-frequencies-hz",
> +				       freqs, num_freqs);

[Severity: Low]
Should the return value of fwnode_property_read_u64_array() be checked
before freqs[] is consumed?

For device tree the element count and the array read parse the same
property length and cannot disagree.  For an ACPI-described device (this
driver can still be instantiated through PRP0001, which matches on
of_match_table and takes properties from _DSD), acpi_data_prop_read()
returns the package element count without type-checking each element, while
acpi_copy_property_array_uint() fails with -EPROTO on the first
non-integer element.

Since the failure is discarded, the remaining kcalloc zeros are then used
as data: ref[index].freq / out[index].freq and curr_freq get freqs[0], and
every entry including the zeros is published as a supported range.

> +	/*
> +	 * Seed the runtime ref->freq / out->freq with the first DT-listed
> +	 * supported frequency so the netlink frequency_get callback reports
> +	 * a sane initial value before any pin_set occurs.  DT lists the
> +	 * physically-wired reference frequency for each input pin and the
> +	 * default output frequency for each output pin.
> +	 */
> +	if (num_freqs > 0) {
> +		if (dir == DPLL_PIN_DIRECTION_INPUT)
> +			sitdev->ref[index].freq = (u32)freqs[0];
> +		else
> +			sitdev->out[index].freq = (u32)freqs[0];
> +		curr_freq = (u32)freqs[0];
> +	}
> +
> +skip_fwnode_props:

[ ... ]

> +	/* Allocate frequency ranges list -- DT discrete entries + current
> +	 * freq + one catch-all wide range so the subsystem never pre-
> +	 * rejects a frequency_set call.  The chip's real admissible set
> +	 * is bounded by VCO / divider math in sit9531x_output_freq_set().
> +	 */
> +	ranges = kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);
> +	if (!ranges) {
> +		rc = -ENOMEM;
> +		goto err_alloc_ranges;
> +	}
> +
> +	/* Current freq as first entry */
> +	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
> +	j = 1;

[ ... ]

> +	/* Always append a wide catch-all range */
> +	ranges[j].min = 1;
> +	ranges[j].max = 1000000000ULL; /* 1 GHz */
> +	j++;
> +
> +	props->dpll_props.freq_supported = ranges;
> +	props->dpll_props.freq_supported_num = j;

[Severity: Medium]
Does the appended catch-all range make the firmware-declared frequency list
meaningless, and does it publish a capability set the driver cannot honour?

The core treats every advertised range as genuinely supported, both when
validating a set and when exporting the list to userspace:

drivers/dpll/dpll_netlink.c:dpll_pin_is_freq_supported() {
	for (fs = 0; fs < pin->prop.freq_supported_num; fs++)
		if (freq >= pin->prop.freq_supported[fs].min &&
		    freq <= pin->prop.freq_supported[fs].max)
			return true;
	return false;
}

and it is the only generic pre-validation of a userspace request:

drivers/dpll/dpll_netlink.c:dpll_pin_freq_set() {
	if (!dpll_pin_is_freq_supported(pin, freq)) {
		NL_SET_ERR_MSG_ATTR(extack, a, "frequency is not supported by the device");
		return -EINVAL;
	}

With {1, 1000000000} counted in freq_supported_num for every non-INTSYNC
pin, the DT-listed entries never constrain anything, and the same range is
attached to the XO pin whose capabilities are deliberately 0 and to every
input pin, which has no .frequency_set at all.

The array is also copied into the pin by dpll_pin_prop_dup() and exported
through DPLL_A_PIN_FREQUENCY_SUPPORTED, so 1 Hz..1 GHz becomes what
userspace is told this device supports.

Separately, ranges[0] is always DPLL_PIN_FREQUENCY(curr_freq), and
curr_freq stays 0 for any pin with no firmware node or no
supported-frequencies-hz list (both permitted by dpll-device.yaml and
dpll-pin.yaml), so those pins advertise 0 Hz as a supported frequency.

The commit message says:

  "which frequencies a board actually presents on a given input, and
  whether an output's embedded sync is wired to be controllable, are
  board facts -- so they come from the firmware node"

Is that consistent with the catch-all range, which overrides the board
facts for every pin?

For reference, Documentation/devicetree/bindings/dpll/dpll-pin.yaml
describes the property as the pin's supported set:

  supported-frequencies-hz:
    description: List of supported frequencies for this pin, expressed in Hz.

Would it work to advertise only the firmware-listed entries (plus the
current frequency) and let sit9531x_output_freq_set() reject the rest with
-EINVAL, rather than widening the advertised set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
