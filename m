Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6835F60A;
	Thu,  1 Oct 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857262; cv=none; b=dZppWiftBd2jsEmQghwr/e79sv1NK17aaJ57UCWeDLhEAI0+AThKEzwhqBnFY/0oSOQdmQCXH+GRf9PhDn3trNijkz8Jkt8XoU4c89MjoRE70a/RtTMTdjSjPCgjrewBP4qJEZzILiwH0UU6jq1iXmAGj3dEiBt6V6HhMP9WynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857262; c=relaxed/simple;
	bh=Q7jzvmO3u3jfv/qIC2dCDpMmEzLO/rCpNK6IdLXWJkM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqDqiJ0uwJhJ0CXfRe9RPITQpYZP15EqkCOjIboRZcQtga4aeUpuHwuKHsBJI3hZbR3aLYvMx9+YfvnO93a8ksMLYTZZjSZRMBgOxp1GsCaMK6cDrvlcCw9r7HAWtSAgnl8pNnTjr+Fl5vrYp+CI96zFzaYNJqx7PVrgUj40SSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeJjcL0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeJjcL0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5E1F000FF;
	Thu,  1 Oct 2026 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790857261;
	bh=MVTra0NODk2ukfHSv4EropBInomf+hUpsPIFCCjdQNY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eeJjcL0Eh3wbg0QsYh8LPr+52zDsk8iXP0lCLkCvWFynD4wJ06ep3YWFIJkjBeQL8
	 Wa1qXCX2emzQZu8t+PmG7txasXUi+DbMlgLoF/vDod8SAs2ePR4GReIp4trYAr/vtt
	 XiN1yyQRyJ4pazZ8zA/ZyFq6kiNdeGB/0KAgY7fyQB8K4WRMMYrYt6XSa78GCfYQUk
	 s5/kwbbaJfLmLdQcqgFMWRe9BeF0+nZRVWhRz60wcmkxv87p1qnYZBwes/EdQOdO1j
	 i/jvuQ8b0oCbWQh7EEKD2zxSEoBZMk7i9ri1lEbwmqdBpg1HkEHykkoKmD9ONYSC3E
	 kRFRtqYudl06w==
Subject:
 Re: [PATCH net-next v2 1/3] net: pcs: rzn1-miic: Fix port numbering on RZ/T2H
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 12:20:59 +0000
Message-ID: <179085725981.434549.8679017357220612418@kernel.org>
In-Reply-To:
 <20260928-miic-validate-dtb-v2-1-1ee3d33748e9@reliablecontrols.com>
References:
 <20260928-miic-validate-dtb-v2-1-1ee3d33748e9@reliablecontrols.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `miic_port_max` means two different things in
  drivers/net/pcs/pcs-rzn1-miic.c: - `miic_create()` (line 485) treats…

Pre-existing issues:
- [Medium] In `miic_parse_dt()` (drivers/net/pcs/pcs-rzn1-miic.c), the
  child node's DT "reg" value is used unchecked in two places: - It…

--

net: pcs: rzn1-miic: Fix port numbering on RZ/T2H

This commit changes miic_port_max in rzt2h_miic_of_data from 4 to 3. The
RZ/T2H ports are documented as 0 to 3.

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index cb74861e823c8..df70309c2d970 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -838,7 +838,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
>  	.index_to_string = rzt2h_index_to_string,
>  	.index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
>  	.miic_port_start = 0,
> -	.miic_port_max = 4,
> +	.miic_port_max = 3,

[Severity: Medium]
Does this leave converter 3 out of miic_init_hw() on RZ/T2H?

This file uses miic_port_max in two ways. miic_create() treats it as the
highest valid port, inclusive:

drivers/net/pcs/pcs-rzn1-miic.c:miic_create() {
    ...
	if (port > of_data->miic_port_max || port < of_data->miic_port_start) {
    ...
}

miic_init_hw() treats it as a converter count, exclusive:

drivers/net/pcs/pcs-rzn1-miic.c:miic_init_hw() {
    ...
	for (port = 0; port < miic->of_data->miic_port_max; port++) {
		miic_converter_enable(miic, port, 0);
    ...
}

With miic_port_max = 3 and miic_port_start = 0, the loop now covers only
ports 0 to 2. miic_converter_enable() changes only the CONVRST bit for the
port it is given. So CONVRST bit 3 (MIIC_CONVRST_PHYIF_RST(3)) is no longer
cleared at probe.

CONV3 then stays in whatever reset state the bootloader left it in while
MODCTRL is reprogrammed.

A later patch in this series, "net: pcs: rzn1-miic: Fix miic register
initialization loop", changes the loop bound to
miic_port_max - miic_port_start + 1. After that change both uses agree
again.

This patch has a Fixes: tag, so it could be backported on its own. Could
the two patches be squashed or reordered, so that neither bisect nor stable
ever sees this in-between state?

>  	.sw_mode_mask = GENMASK(2, 0),
>  	.reset_ids = rzt2h_reset_ids,
>  	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),

[Severity: Medium]
This isn't a bug introduced by this patch, but can miic_parse_dt() write
past the end of dt_val[]?

The DT "reg" value of each converter child is used as an index with no
bounds check:

drivers/net/pcs/pcs-rzn1-miic.c:miic_parse_dt() {
    ...
	dt_val = kmalloc_objs(*dt_val, miic->of_data->conf_conv_count);
    ...
		/* Adjust for 0 based index */
		dt_val[port + !miic->of_data->miic_port_start] = conf;
    ...
		miic_configure_phy_link(miic, conf, port, active_low);
    ...
}

On RZ/T2H conf_conv_count is 5. A child with reg >= 4 therefore writes at
index 5 or higher.

The same port value also reaches BIT(port + shift) in
miic_configure_phy_link(). A large value there would be an undefined shift.

The "renesas,miic-input" value is not range checked either. When no match
table entry matches, miic_dump_conf() uses it as
of_data->conf_to_string[conf[i]].

A later patch in this series, "net: pcs: rzn1-miic: Validate dtb
configuration values", adds port and conf range checks before the dt_val[]
write. That covers the converter child path.

The top-level "renesas,miic-switch-portin" value still looks unchecked
after that patch:

	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
		dt_val[0] = conf;

Could an out-of-range value there still reach conf_to_string[conf[0]] in
miic_dump_conf()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-miic-validate-dtb-v2-0-1ee3d33748e9%40reliablecontrols.com
