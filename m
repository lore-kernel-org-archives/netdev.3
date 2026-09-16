Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294349EC43;
	Wed, 16 Sep 2026 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559012; cv=none; b=PjtX8zcma0gkYA/zqkc/7MpmInhg3R1aQhIns3PNXqJe2VM3QFPExwwGXunw7WL/xMm4E1Gpf394kF5ox3J/UXTLjNdXtfqOJRrDAaS6+D8IoujEOYxCSXvuIDQftNirDVNqNF8sFhvYV86lgp2NNJhFhRpgkh+YUS/A7bGUYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559012; c=relaxed/simple;
	bh=do7oQl2hIsQYK5/ikqMgimDgmurZYLG06zV7edz9NB8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/JDeeZ++BPG7EATIpZpYC2G5ojfrX+3V+1ONi+s/sOYLXlcrWrsvqili2172yMTnuoj70C/qjqFoiHK+WMUCfhdLbLJkKZESuEyWK10p26Tm1cPJwLfzdGmoSt5MeV7s5C7aE0b+qV/0o9KtXQ7WiSB42xoDEaBNOqhnUNianQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8GJixEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8GJixEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D961F1F00893;
	Wed, 16 Sep 2026 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789558995;
	bh=Hzx7GDBRPSHk9/GuSJnHmwpMGBpCMYrRJlHwFtWsqpw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J8GJixEbISPEAbdvOC0pPRuFfc2T45fWW9l3tESewGiFEb4URAFD6SS01Oq/vbk6j
	 Z4IMlI62ubpXdvvNtKvP9ATo819VbCQJ60OOy/AbpduOTGuOFnXXen8vJE9TstyXFJ
	 XL/yeksUfVDoEKV+YtqyQhpm74yM5G+ARkqPS1h+AGtEGVejpUACFVWb7xx3H72jvU
	 RyaazJgJ9H1tckCb0D0AD+hKEfu6dDImnKXavnns9NVhH3H/O7M+uU1K+n79zCNG4E
	 42xCH+DpgG3j4oe35RmHx2AEtcpPmgGRcp8F7tgm7L5plJ6gI/lEv5Ft4u7S1L48yM
	 uaZUJd/+49QdQ==
Subject: Re: [PATCH v4 2/2] net: pcs: rzn1-miic: Verify port number from dtb
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 11:43:14 +0000
Message-ID: <178955899447.22033.5754427139793967412@kernel.org>
In-Reply-To:
 <20260914-rzn1-miic-fix-array-v4-2-069112feec86@reliablecontrols.com>
References:
 <20260914-rzn1-miic-fix-array-v4-2-069112feec86@reliablecontrols.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

- [High] Incomplete fix — the new bounds check in miic_parse_dt()
  (drivers/net/pcs/pcs-rzn1-miic.c:696-702) uses `port >…
- [Medium] The commit message ("Add check to make sure port number is in
  range before writing to dt_val array") never states the pre-patch…

Pre-existing issues:
- [High] `renesas,miic-input` (`conf`) is stored into `dt_val[]` at
  drivers/net/pcs/pcs-rzn1-miic.c:708 (and `renesas,miic-switch-portin`…
- [Medium] `miic_port_max` is documented as "Maximum MIIC supported"
  (drivers/net/pcs/pcs-rzn1-miic.c:225) but is consumed with two…

--

net: pcs: rzn1-miic: Verify port number from dtb

This adds a range check on the converter child node "reg" value in
miic_parse_dt() before it is used as an index into the dt_val array, and
returns -EINVAL after releasing the node reference and freeing dt_val.

> net: pcs: rzn1-miic: Verify port number from dtb
>
>     Add check to make sure port number is in range before writing
>     to dt_val array

[Severity: Medium]
Could the changelog say what happens today without the check?  In the
parent commit, miic_parse_dt() takes "reg" straight from the device tree
and uses it as an index:

drivers/net/pcs/pcs-rzn1-miic.c:miic_parse_dt() {
	for_each_available_child_of_node(np, conv) {
		if (of_property_read_u32(conv, "reg", &port))
			continue;
		...
		dt_val[port + !miic->of_data->miic_port_start] = conf;
}

so an out-of-range reg is a slab out-of-bounds write during probe.  Should
this carry a Fixes: tag pointing at the commit that introduced the
unvalidated indexing (7dc54d3b8d9100, later widened by f39e968dc168a7 /
61f1139a476569) so stable can pick it up?  The preceding patch in this
series ("net: pcs: rzn1-miic: Fix config array initialization") does have
one.

It may also be worth mentioning the behaviour change: probe now fails and
the whole MII converter becomes unavailable for device trees that
previously probed with a bogus reg.

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index cb74861e823c8..1bd95ddf9400a 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -693,6 +693,14 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>  		if (of_property_read_u32(conv, "reg", &port))
>  			continue;
>  
> +		if (port < miic->of_data->miic_port_start ||
> +		    port > miic->of_data->miic_port_max) {

[Severity: High]
Is the upper bound off by one for the RZ/T2H variant?  The comparison is
inclusive, but miic_port_max is used as a converter count elsewhere:

rzt2h_miic_of_data = {
	.conf_conv_count = 5,
	.miic_port_start = 0,
	.miic_port_max = 4,
};

miic_init_hw() treats it as an exclusive count:

	for (port = 0; port < miic->of_data->miic_port_max; port++)

So for compatible "renesas,r9a09g077-miic" a child with reg = <4> passes
the new test, and the store a few lines below becomes dt_val[5] on a
5-byte buffer:

	dt_val = kmalloc_objs(*dt_val, miic->of_data->conf_conv_count);
	...
	/* Adjust for 0 based index */
	dt_val[port + !miic->of_data->miic_port_start] = conf;

Does that still overflow dt_val[] by one byte with the DT-supplied
renesas,miic-input value?  The binding's non-rzn1 branch restricts
converter reg to "enum: [0, 1, 2, 3]", and
include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h documents only
Port 0..Port 3, so reg = <4> looks like exactly the malformed input this
patch is meant to reject.

Would an index-derived predicate work better, e.g.

	if (port < miic->of_data->miic_port_start ||
	    port + !miic->of_data->miic_port_start >= miic->of_data->conf_conv_count)

RZ/N1 (miic_port_start = 1, miic_port_max = 5, conf_conv_count = 6) is
unaffected, which is probably why this is not visible on the common
platform.

There is a second effect of accepting port 4: miic_configure_phy_link()
does

	mask = BIT(port + shift);

and with an ETHSW input (shift 0) port 4 sets BIT(4), which is in the
ESC/EtherCAT nibble [7:4] of MIIC_PHY_LINK that miic_probe() later
programs via miic_reg_rmw(miic, MIIC_PHY_LINK, ...).  Can that clobber
EtherCAT port 0 link polarity?

[Severity: Medium]
This isn't a bug introduced by this patch, but miic_port_max now has three
consumers with two conflicting meanings.  The kernel-doc for struct
miic_of_data says "Maximum MIIC supported", miic_init_hw() uses it as an
exclusive count (port < miic_port_max), miic_create() uses it as an
inclusive maximum reg value:

	if (port > of_data->miic_port_max || port < of_data->miic_port_start)

and this patch adds a third site with the inclusive reading.  On
r9a09g077 the inclusive reading lets miic_create() hand out a PCS for
converter 4, which does not exist (rzt2h_index_to_string[] lists only
SWITCH_PORTIN and CONV0..CONV3), after which miic_config() /
miic_converter_enable() program MIIC_CONVCTRL(4) and MIIC_CONVRST bit 4.
Could the field be documented and used consistently, so that fixing one
site does not break the others?

> +			dev_err(miic->dev, "Port number out of range: %d\n", port);
> +			of_node_put(conv);
> +			kfree(dt_val);
> +			return -EINVAL;
> +		}
> +
>  		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
>  			continue;
>  

[Severity: High]
This is a pre-existing issue, but since this block is now the validation
point for the child node, would it make sense to bound conf here too?
renesas,miic-input is stored without any range check against
conf_to_string_count, and with a silent u32 to s8 truncation:

	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
		dt_val[0] = conf;
	...
		dt_val[port + !miic->of_data->miic_port_start] = conf;

On a match failure, miic_match_dt_conf() -> miic_dump_conf() uses the
stored value as an index and then prints the result:

	if (conf[i] != MIIC_MODCTRL_CONF_NONE)
		conf_name = of_data->conf_to_string[conf[i]];
	...
	dev_err(miic->dev, "%s: %s\n", of_data->index_to_string[i], conf_name);

With renesas,miic-input = <100> nothing in modctrl_match_table[] matches,
so miic_dump_conf() reads past the 14-entry conf_to_string[] (9-entry
rzt2h_conf_to_string[]) and hands the resulting word to %s.  Can that
oops or leak kernel memory into dmesg?

Also, conf = 255 truncates to -1, which equals MIIC_MODCTRL_CONF_NONE, so
miic_modctrl_match() treats the entry as a wildcard instead of rejecting
it.  Is that intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-rzn1-miic-fix-array-v4-0-069112feec86%40reliablecontrols.com
