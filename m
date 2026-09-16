Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB014BD108;
	Wed, 16 Sep 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559012; cv=none; b=BAqLmInZiuvf6rY1FACXS74/5+9AuPXcPvxotQtEpGHxqJntgk1c76Olm1pR37b2XwLCH0TP8NGQwpACh5ic3sOzX8f7YxZljx/SY3AZ3lh7q4jCnKTu4G4pKPpnGukXE9udVhKNZRmMMySLy+/hAGINipxnrV9AFPD1GmWFcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559012; c=relaxed/simple;
	bh=goppTDHzWaqosN/1Y+/NEdVF1fbVuJ4qxiiCvPvpA5Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iN44HysxQQWfA/ejXATp/epjpKpTH0MWwfV95d4yEvzHZt0+3J/mMG+Sg9QrclGXlcR7J+zA2tTPtAOkyW3vYearjI3VARjj1R3ZAdiWAJV4xvKAFoePZ96AGkBduhAlY04ZQZ/W/iKBMK35n3rmBN23hTgBbsJ6ia1nxxRRubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXtGdBVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXtGdBVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C741F000FF;
	Wed, 16 Sep 2026 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789558994;
	bh=cpTUrOF05Dcy1Bk2KAYOIW3v5WZK34oP8mQ9ZpYwf3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jXtGdBVYViMXZx0efLs39QetMVB182/hwnwQoOEpr/FmlYyMa9eEjJkqeG1CHn0/W
	 EBPeKSVsA26oHySGGsVqPfM7yce2TokzlWOWaYC6xe5WVYWiNSEA2rlgOwFSUAWtp+
	 PZjbjCG1gg70mJgZhju5RkL8wbzFvj96vsAh8YosIv4uCAEjo4sQbfryJksJGMqx7/
	 cc5MUe/E1jfbzTtp890pdLGNb06yzp+UAxfvDEtfcEb9NW/PUxd366RlPy7xgFY1Ry
	 0nJwlai3ya16/Onz2HC+Vt1bSkl1F5vIcp2kZYCtqk+osLXAOCtLIQRbnaXnXDnwXE
	 KewRDn8pgj74Q==
Subject:
 Re: [PATCH v4 1/2] net: pcs: rzn1-miic: Fix config array initialization
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 11:43:13 +0000
Message-ID: <178955899323.22033.2372714834297554596@kernel.org>
In-Reply-To:
 <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
References:
 <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

- [High] One-byte heap out-of-bounds write in miic_parse_dt() on the
  RZ/T2H (renesas,r9a09g077-miic) variant, which the series' own port-…

Pre-existing issues:
- [High] Unbounded array index / wild pointer dereference in
  miic_dump_conf() (drivers/net/pcs/pcs-rzn1-miic.c:566-580).

--

net: pcs: rzn1-miic: Fix config array initialization

This corrects the memset() in miic_parse_dt() so that the whole
kmalloc_objs() allocated dt_val array is initialized to
MIIC_MODCTRL_CONF_NONE, instead of just the first byte. While looking at
the surrounding code a couple of questions came up about how dt_val is
indexed and later printed.

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index 2b72fa98ddf13..cb74861e823c8 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -683,7 +683,8 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>  	if (!dt_val)
>  		return -ENOMEM;
>  
> -	memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> +	memset(dt_val, MIIC_MODCTRL_CONF_NONE,
> +	       sizeof(*dt_val) * miic->of_data->conf_conv_count);
>  
>  	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
>  		dt_val[0] = conf;

[Severity: High]
Now that the size of this buffer is spelled out as conf_conv_count bytes,
can the index used a few lines further down in miic_parse_dt() run one
past the end on the RZ/T2H variant?

	for_each_available_child_of_node(np, conv) {
		if (of_property_read_u32(conv, "reg", &port))
			continue;
		...
		/* Adjust for 0 based index */
		dt_val[port + !miic->of_data->miic_port_start] = conf;

For rzt2h_miic_of_data the relevant fields are:

	.conf_conv_count = 5,
	.miic_port_start = 0,
	.miic_port_max = 4,

With miic_port_start == 0 the index is port + 1, so a child node with
reg = <4> and a renesas,miic-input property writes dt_val[5] in a 5 byte
allocation. The companion patch "net: pcs: rzn1-miic: Verify port number
from dtb" bounds port by miic_port_max, but since miic_port_max is 4 for
RZ/T2H the reg = <4> case still passes the check and still writes one byte
past the allocation.

Is miic_port_max = 4 intended here? The hardware description elsewhere in
the driver only covers four converters:

	static const char * const rzt2h_index_to_string[] = {
		"SWITCH_PORTIN",
		"CONV0",
		"CONV1",
		"CONV2",
		"CONV3",
	};

and the binding restricts reg to enum: [0, 1, 2, 3] for the r9a09g077
compatibles. Would bounding the computed index by conf_conv_count (or
setting miic_port_max = 3 for RZ/T2H) be more appropriate?

On RZ/N1 the same expression stays in range because miic_port_start == 1
makes the index equal to port, with a maximum of 5 in a 6 entry array.

[Severity: High]
This isn't a bug introduced by this patch, but since the same dt_val array
is involved: the values stored here are used directly as a string table
index in miic_dump_conf(), without any range check.

miic_parse_dt() stores the raw u32 DT properties into the s8 array:

	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
		dt_val[0] = conf;
	...
		dt_val[port + !miic->of_data->miic_port_start] = conf;

and when no MODCTRL entry matches, miic_match_dt_conf() unconditionally
dumps them:

	dev_err(miic->dev, "Failed to apply requested configuration\n");
	miic_dump_conf(miic, dt_val);

miic_dump_conf() then does:

	for (i = 0; i < of_data->conf_conv_count; i++) {
		if (conf[i] != MIIC_MODCTRL_CONF_NONE)
			conf_name = of_data->conf_to_string[conf[i]];
		...
		dev_err(miic->dev, "%s: %s\n",
			of_data->index_to_string[i], conf_name);

conf_to_string has 14 valid indices (0..MIIC_HSR_PORTB) and
rzt2h_conf_to_string has 9 (0..ETHSS_ETHSW_PORT2). A DT value outside
those ranges never matches a table row, so it always reaches this path,
and a value above 127 is truncated to a negative s8. Can this read a
pointer sized word from outside the string table and then dereference it
in the %s conversion?

struct miic_of_data already carries the bound, but it does not appear to be
read anywhere:

	u8 conf_to_string_count;
	...
	u8 index_to_string_count;

Would it make sense to validate conf[i] against conf_to_string_count
before the lookup, or to reject out of range renesas,miic-input and
renesas,miic-switch-portin values in miic_parse_dt()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-rzn1-miic-fix-array-v4-0-069112feec86%40reliablecontrols.com
