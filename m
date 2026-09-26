Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9736A34F;
	Sat, 26 Sep 2026 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390086; cv=none; b=bvukjFszeZqW1QMDuQUCBGzxW5+PI4Zcm5/dhXvlk+lI0GSplrCewmCIKgU7wf3zbLlSGL0VEDDL0vIZ5CRvHNsZTlQrvPqboSa/uZodckH6fWx0U1w8OPNZ7WtBkisF5QbD1W89pMDIhSvx6ySTiAYCSVyYwoKIlkyZYO9UHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390086; c=relaxed/simple;
	bh=80wzf8N/KMa0xkAEbQQ6a7eqmK8OFgB5JqN2WG0bpLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl7qoIoquhAmmI8KRgXBilp4M8VftO2rWQ7vD6gWDpZ2kXRLx5dVMe0ro0fMuz/jTbyjoBCcWKkIF6uNC8EDxFhrub0thPs8q/9rW7PtJSKkPM/gLKqe+e8gSTjHqyeLKvRsEPM6QF17MQXUPtf/Pny+WiL1VQf+adeXRwrwfRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4ZckQ0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4ZckQ0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A091F000FF;
	Sat, 26 Sep 2026 02:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390084;
	bh=vBgkYpA5BlgzSJAnhC3nNWOVKf2sspu+6zyj519CvRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4ZckQ0MosNlmhHcFH1TC3nomLYc52KN7ICs7sgljfsub3thRofuAxYZA2nSzbEPu
	 uzKVw7t7MzetJhIZHBS3NEwHKurDb6DBeTwcimM8+n5zBZAuR2zhoks7rwlbeJILKS
	 yQJGC9plTqSoeX9wBDwaBR9DDIzspLkNGqFI9narxixtFfOP88MDS8N8ABIISDMjbf
	 5Zq9rYTqNpK5XH+/8dXfTmHTEwHPSD5TfIuQhGjOLw2LIgxsDHGV+vroIqMc2R2blq
	 6bxqGYvVIDeAABoZmVuTx05vfahDvMYTj+FIaCngbxTWD2Pj/yA4vpDSe/sAAkeobF
	 B0qVobF6YEuIg==
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
Subject: Re: [PATCH v10 04/14] dpll: sit9531x: read DPLL types and pin properties from system firmware
Date: Fri, 25 Sep 2026 19:34:42 -0700
Message-ID: <20260926023442.1567603-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-5-arouhi@sitime.com>
References: <20260921201108.42676-5-arouhi@sitime.com>
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
dpll: sit9531x: read DPLL types and pin properties from system firmware

This commit adds prop.c, which reads the DPLL type for each channel and
the properties for each pin from the firmware node. The pin properties
are the package label, board label, type, capabilities and supported
frequencies, with defaults when the node does not describe them. It also
adds the input and output state structures to core.h, plus helpers that
map a logical input index to a pair and a lane.

> Two of the advertised properties are worth naming.  Outputs get a
> phase-adjust window of one millisecond either way, which is wider than
> the dynamic range but costs nothing and is what keeps the subsystem from
> refusing every request; the granularity is one picosecond, because the
> achievable delays are whole VCO cycles plus thirty-picosecond steps and
> so form no uniform lattice for the core to check against.

[Severity: Low]
Is this paragraph describing code that is in this patch? At this commit,
nothing under drivers/dpll/sit9531x/ sets dpll_props.phase_range or
dpll_props.phase_gran. The output branch of sit9531x_pin_props_get()
sets only type, capabilities and curr_freq.

The phase window, and a comment giving the same reasons, arrive later in
"dpll: sit9531x: add support to adjust output phase". The v10 notes say
the window was moved to that patch, but this paragraph was left here.
Could it move to that patch's commit message?

A smaller mismatch of the same kind is the INTSYNC "re-prioritised"
comment in sit9531x_pin_props_get(), noted further down.

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 76a2632f0ce4a..230b21b9e2381 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h

[ ... ]

> @@ -41,6 +51,39 @@ struct sit9531x_chip_info {
>  	const u8	*clkout_map;
>  };
>  
[ ... ]
> +/*
> + * struct sit9531x_ref - input reference state
> + * @freq:		configured frequency in Hz
> + * @label:		board label from DT or default
> + * @sig_mode:		signal mode of the pair this lane belongs to
> + *			(detected from CLKINx_INPUT_MODE at probe)
> + */
> +struct sit9531x_ref {
> +	u32				freq;

[Severity: Low]
Can this u32 truncate the u64 curr_freq that sit9531x_pin_props_get()
stores here and in sit9531x_out::freq? A rate of 2^32 Hz or more would
be cached truncated, while the full value is advertised in
freq_supported.

This can't be reached in any tree state. The next patch, "dpll:
sit9531x: register DPLL devices and pins", adds the first caller and
widens both fields to u64 in the same change. Could they simply be u64
from this patch?

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

[Severity: Low]
Is anything meant to write sit9531x_ref::label and sit9531x_out::label?
Both are documented as "board label from DT or default", but nothing in
the driver assigns them, either here or at the end of the series.

The DT label goes into props->dpll_props.board_label in
sit9531x_pin_props_get(). The package label goes into
props->package_label. Could these fields be dropped, or their
documentation corrected?

sig_mode is also never set at this commit, so the differential "IN%u"
branch of sit9531x_input_pin_label() cannot be reached yet. That part is
fixed by sit9531x_input_mode_fetch() in "dpll: sit9531x: register DPLL
devices and pins", which runs before any pin reaches this code.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
> new file mode 100644
> index 0000000000000..1a09bd168163d
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/prop.c
> @@ -0,0 +1,430 @@

[ ... ]

> +static int
> +sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,
> +			     struct sit9531x_pin_props *props,
> +			     enum dpll_pin_direction dir, u8 id)
> +{
> +	struct fwnode_handle *pins_node, *pin_node;
> +	const char *node_name;
> +
> +	if (dir == DPLL_PIN_DIRECTION_INPUT) {
> +		node_name = "input-pins";
> +	} else {
> +		node_name = "output-pins";
> +		if (id < sitdev->info->num_outputs)
> +			id = sitdev->info->clkout_map[id];
> +	}

[ ... ]

> +	/* Enumerate child pin nodes and find the requested one */
> +	fwnode_for_each_child_node(pins_node, pin_node) {
> +		u32 reg;
> +
> +		if (fwnode_property_read_u32(pin_node, "reg", &reg))
> +			continue;
> +
> +		if (id == reg)
> +			break;
> +	}

[Severity: Medium]
How is a DT author expected to number reg in these nodes? Two different
numberings are used here. Neither dpll-pin.yaml nor sitime,sit95316.yaml
defines either one.

For inputs, reg is compared directly with the interleaved lane index:
2k is INkP and 2k+1 is INkN. The binding only says there are "4
differential input pairs whose lanes can also be driven independently as
single-ended references, so 8 inputs are individually selectable".

A differential pair k is registered only as index 2k, because
sit9531x_input_pin_is_registrable() skips the N lane. Say a board
describes differential IN1 with reg = <1>. Would its label,
connection-type and supported-frequencies-hz be applied to IN0N when
pair 0 is single-ended? And would the node be silently ignored when
pair 0 is differential?

The input pin@1 in the binding example ("clkin1", synce) only works if
pair 0 is strapped single-ended.

For outputs, the logical index goes through clkout_map[] first. On
SiT95317 that means reg has to be one of 0, 3, 4, 5, 7, 8, 9 or 11.

In the same device node, sitime,output-pll-map is indexed by logical
output number. The binding describes it as "for each output 0..11" and
caps it at 8 items for SiT95317. sit9531x_parse_board_config() stores it
by logical index:

drivers/dpll/sit9531x/core.c:sit9531x_parse_board_config() {
    ...
	for (i = 0; i < n; i++)
		sitdev->out_pll_map[i] = map[i];
    ...
}

So on SiT95317, output-pll-map entry 1 refers to the pad labelled OUT3,
but output-pins reg = <1> refers to a slot that is not bonded out. A
node written like the output pin@1 in the binding example would match
nothing. That output would then silently get the 1 Hz to 1 GHz fallback
range instead of the board's list.

Could the binding document both numberings? Could the driver also warn
when a pin node's reg matches no registered pin?

[ ... ]

> +	if (dir == DPLL_PIN_DIRECTION_INPUT &&
> +	    index == SIT9531X_INTSYNC_PIN_ID) {
> +		/*
> +		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a
> +		 * reference, so it can be connected and re-prioritised.
> +		 */
> +		props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
> +		props->dpll_props.capabilities =
> +			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

[Severity: Low]
The comment says this pin can be re-prioritised, but the mask only has
DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE. The physical input branch below
uses the same mask. With this mask, wouldn't the DPLL core reject every
priority change on these pins?

Nothing is registered at this commit and there are no prio ops yet.
"dpll: sit9531x: add support to get and set priority on input pins" adds
DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE to both the INTSYNC
destination pin and the physical inputs, so the series fixes this
later. Could the comment and the capability land in the same patch?

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

[Severity: Low]
For output pins, this replaces curr_freq, taken from
sitdev->out[index].freq, with the first supported-frequencies-hz entry.
That value is then cached back into sitdev->out[index].freq further
down. Doesn't that contradict the v10 note "Took an output's current
rate from its divider instead of the first entry of the list of rates
the board supports"?

No output pin ever reaches this code while it behaves this way:

- sit9531x_pin_props_get() has no caller at this commit.
- The next patch registers only inputs and XO.
- "dpll: sit9531x: add support to get and set frequency on pins" limits
  the seeding to inputs and reads outputs back through
  sit9531x_output_freq_get(), before any output pin is registered.

For inputs, taking the first entry as the wired rate is intentional,
according to that later patch. The convention is not written down in
dpll-pin.yaml, though. Should the binding mention it?

[ ... ]
