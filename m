Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FB525A9E;
	Thu, 17 Sep 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657315; cv=none; b=pvTlwakjqY1oUGF2i79umxIus6mlQHOXIoXY9cjCDG/Hrg6zIPUr0MmjfTx9kDH9I5qqcNbD15KvuKQTvzkkOxH7ZS4hQ7etP3UbWpeBlbEXkTuYfyoxpUdvacL8vC64i+oVH0Wz/A2n1itkXyC5NiTP35S+Zwi0d5Q+1hzMFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657315; c=relaxed/simple;
	bh=+OiCBvrJA9gRwJuUaICIeeU8P1wfeW/0WqjyxQzuzZU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EaRIZuNjCJV64N8K/xXyzNtxYkUZLH3ASsw6oFj7stPWzUDbi9Qy76OdXDwIjvmGT4biQ7+8ZsOKPCBioqlFxj41hzuiXdeMQS80a0dvsDgBExPOMtd9TUMAqaLP5V4eBfdTkescYBl8CNtqnpdO3QaTdxlGYru4wB5SWwBIJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKTyCnJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKTyCnJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB9B1F00899;
	Thu, 17 Sep 2026 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657306;
	bh=Um/coKLi4YGjUQX46t8ujiy0FaOTz8WedD1gSWujK3M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iKTyCnJPbhToDd5rtZHru2HK+yl99YkC22vNZgCqwkvxOciYhHwRdU0TQzDnMv0GN
	 02l+1XXMWxSlqZ/5KJZZ/hCrQrjUEE8Nq17YyKG3yl16kkVMQM80C3f6ZXcHPWHpxK
	 u/ZALP4Fc0NOfaoh29JQvGI0exbdUfeMp5sjNq9yL0ZWvQTOOKkImq7G/jbzAJXJDa
	 ZpWPQoeuPiZQ4Vn7jbNJF2smNjN3VUd8KKfLMCkpGCzGAhHMeMa9GJMkao1DtnUSc+
	 T3elnBQDf6FEzF6tKuPbBg4eNZZYxc/6Vtqa2phXJF5HlekPihGcUPNe0CzhkFaKYy
	 flPpVkFhxPWFQ==
Subject: Re: [PATCH net-next v9 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:45 +0000
Message-ID: <178965730512.22033.11703081345956900673@kernel.org>
In-Reply-To: <20260915000015.80480-5-arouhi@sitime.com>
References: <20260915000015.80480-5-arouhi@sitime.com>
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

- [Medium] In `sit9531x_pin_props_get()` (drivers/dpll/sit9531x/prop.c,
  output branch) every output pin is advertised to the DPLL core with…
- [Medium] `sit9531x_pin_props_get()` (drivers/dpll/sit9531x/prop.c)
  reinterprets the first entry of the DT property `supported-…
- [Medium] `sit9531x_prop_pin_package_label_set()` builds the DPLL
  package label for outputs as `snprintf(..., "OUT%u", id)` from the…
- [Low] In `sit9531x_pin_props_get()` the firmware frequency is held in
  `u64 curr_freq` (assigned `curr_freq = freqs[0]` straight from…

--

dpll: sit9531x: read DPLL types and pin properties from system firmware

This patch adds prop.c, which builds the per-pin dpll_pin_properties
(package label, type, capabilities, supported frequencies) and the per-channel
DPLL type from the firmware node, with defaults when the node is absent.  It
also adds the per-input and per-output runtime state arrays to struct
sit9531x_dev.

A few questions about the property parsing below.

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 76a2632f0ce4a..230b21b9e2381 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h

[ ... ]

> @@ -41,6 +51,39 @@ struct sit9531x_chip_info {
>  	const u8	*clkout_map;
>  };
>  
> +/*
> + * struct sit9531x_ref - input reference state
> + * @freq:		configured frequency in Hz
> + * @label:		board label from DT or default
> + * @sig_mode:		signal mode of the pair this lane belongs to
> + *			(detected from CLKINx_INPUT_MODE at probe)
> + */
> +struct sit9531x_ref {
> +	u32				freq;
> +	const char			*label;
> +	enum sit9531x_signal_mode	sig_mode;
> +};
> +
> +/*
> + * struct sit9531x_out - output state
> + * @freq:		configured frequency in Hz
> + * @label:		board label from DT or default
> + */
> +struct sit9531x_out {
> +	u32		freq;
> +	const char	*label;
> +};
> +

[ ... ]

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> new file mode 100644
> index 0000000000000..c9642b702c4ab
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -0,0 +1,437 @@

[ ... ]

> +	if (dir == DPLL_PIN_DIRECTION_INPUT)
> +		sit9531x_input_pin_label(sitdev, props, id);
> +	else
> +		snprintf(props->package_label, sizeof(props->package_label),
> +			 "OUT%u", id);

[Severity: Medium]
Should the output label go through sitdev->info->clkout_map[] rather than the
logical index?

drivers/dpll/sit9531x/core.c has a non-identity map for one variant:

    static const u8 clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11};

and core.h documents it as "@clkout_map: per-output slot mapping (output
index -> physical slot)", with sit9531x_output_divo_write() using it for the
actual register access.  On SiT95317 that makes logical index 1 program
physical slot 3, but userspace is shown DPLL_A_PIN_PACKAGE_LABEL "OUT1", and
"OUT10"/"OUT11" are never emitted even though those chip pins exist.

The same logical index is used as the firmware lookup key in
sit9531x_prop_pin_fwnode_get():

    if (fwnode_property_read_u32(pin_node, "reg", &reg))
            continue;

    if (id == reg)
            break;

while Documentation/devicetree/bindings/dpll/dpll-pin.yaml describes reg as
"Hardware index of the DPLL pin".  A board DT written against the binding
(pin@3, pin@7, pin@b) then matches nothing, and pin@1 has its label,
connection-type, esync-control and frequency list applied to physical slot 3.

Should prop.c translate through clkout_map, or should the sitime binding
state that reg is a logical, variant-dependent index?

[ ... ]

> +	} else {
> +		/*
> +		 * A synthesized clock output is an external connection with
> +		 * no more specific meaning; a board that knows better says
> +		 * so through the pin's connection-type property below.
> +		 */
> +		props->dpll_props.type = DPLL_PIN_TYPE_EXT;
> +		props->dpll_props.capabilities =
> +			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> +		curr_freq = sitdev->out[index].freq;
> +
> +		/*
> +		 * Allow phase-adjust over a +/-1 ms window.  The subsystem
> +		 * rejects pin_set(phase-adjust, X) when X falls outside
> +		 * [min, max], so leaving these at 0 silently blocks every
> +		 * netlink call.  1 ms is well beyond the DCO dynamic range
> +		 * but costs nothing.  Only outputs get a range: input pins
> +		 * have no .phase_adjust_set, and advertising one there would
> +		 * promise userspace something every set would refuse.
> +		 */
> +		props->dpll_props.phase_range.min = -1000000000; /* -1 ms in ps */
> +		props->dpll_props.phase_range.max =  1000000000; /* +1 ms in ps */
> +		/*
> +		 * The fine step is 30 ps, but requests are accepted at 1 ps
> +		 * resolution and rounded to the nearest achievable delay, so
> +		 * advertise the request granularity, not the hardware step.
> +		 */
> +		props->dpll_props.phase_gran = 1;
> +	}

[Severity: Medium]
Can these advertised values mislead userspace, given they are uAPI once
released?

dpll_pin_phase_adj_set() in drivers/dpll/dpll_netlink.c validates a request
only against the driver-supplied range and granularity:

    if (phase_adj > pin->prop.phase_range.max ||
        phase_adj < pin->prop.phase_range.min) {

So every integer-picosecond request up to 1 ms is accepted, and
sit9531x_output_phase_adjust_set() then folds an offset larger than one
output period back into a single period and rounds to the 30 ps step.  A
request of 500000 ps on a 1 GHz output is applied as a few hundred ps and
phase_adjust_get() reports that different value back.

Documentation/netlink/specs/dpll.yaml describes
DPLL_A_PIN_PHASE_ADJUST_GRAN as "The value of phase adjustment must be a
multiple of this granularity", so is phase_gran = 1 the right thing to
publish when the real step is 30 ps?

Related, further down in the same function:

    if (dir == DPLL_PIN_DIRECTION_OUTPUT && num_freqs == 0) {
            ranges[j].min = 1;
            ranges[j].max = 1000000000ULL; /* 1 GHz */

For an output whose firmware node lists no supported-frequencies-hz this
claims 1 Hz to 1 GHz and effectively disables the core-side frequency_set
validation, so the advertised capability follows DT completeness rather than
the silicon.  For comparison, zl3073x derives phase_gran from the synth rate
and filters DT frequencies through zl3073x_pin_check_freq().  The commit
message does not mention either the phase-adjust window or this fallback
range; could it describe them?

[ ... ]

> +	/*
> +	 * Seed the runtime ref->freq / out->freq with the first DT-listed
> +	 * supported frequency so the netlink frequency_get callback reports
> +	 * a sane initial value before any pin_set occurs.  DT lists the
> +	 * physically-wired reference frequency for each input pin and the
> +	 * default output frequency for each output pin.
> +	 */
> +	if (num_freqs > 0) {
> +		if (dir != DPLL_PIN_DIRECTION_INPUT ||
> +		    index != SIT9531X_MAX_INPUTS)
> +			curr_freq = freqs[0];
> +	}

[Severity: Medium]
Is element 0 of supported-frequencies-hz allowed to mean "current
frequency"?

Documentation/devicetree/bindings/dpll/dpll-pin.yaml defines the property as:

    supported-frequencies-hz:
        description: List of supported frequencies for this pin, expressed in Hz.

with no special meaning for the first entry.  The other consumer of the same
binding, drivers/dpll/zl3073x/prop.c, reads curr_freq from the hardware and
uses the DT list only to build freq_supported:

    /* Start with current frequency at index 0 */
    ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);

For a board that legitimately lists several supported frequencies, this
invents a current rate.  The cached value is then reported verbatim by
sit9531x_dpll_input_pin_frequency_get() and used as the output period in
sit9531x_output_phase_adjust_set() ("freq = sitdev->out[out_idx].freq;"), so
a seeded rate that differs from what the chip is generating yields a wrong
programmed delay.

> +skip_fwnode_props:

[ ... ]

> +	/*
> +	 * Publish the seeded rate only once the pin is certain to be built.
> +	 * The allocation above is the last thing that can fail, and a call
> +	 * that reports failure must not leave the device's cached rate
> +	 * changed behind it.
> +	 */
> +	if (curr_freq) {
> +		if (dir == DPLL_PIN_DIRECTION_INPUT)
> +			sitdev->ref[index].freq = curr_freq;
> +		else
> +			sitdev->out[index].freq = curr_freq;
> +	}

[Severity: Low]
Does this truncate curr_freq?

curr_freq is a u64 taken straight from fwnode_property_read_u64_array() and
published at full width through DPLL_PIN_FREQUENCY(), but sit9531x_ref.freq
and sit9531x_out.freq are u32 in core.h.  A firmware entry of 2^32 Hz or more
is stored truncated while the advertised freq_supported entry keeps the full
value, so the cached rate matches nothing in the advertised set; an exact
multiple of 2^32 caches as 0, which also affects the period used by
sit9531x_output_phase_adjust_set().

zl3073x_pin_props_get() runs every DT entry through
zl3073x_pin_check_freq(); would a similar bound check fit here?

> +
> +	j = 0;

[ ... ]

> +	if (dir == DPLL_PIN_DIRECTION_OUTPUT && num_freqs == 0) {
> +		ranges[j].min = 1;
> +		ranges[j].max = 1000000000ULL; /* 1 GHz */
> +		j++;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
