Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2C3DB64A;
	Tue, 29 Sep 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695666; cv=none; b=I5tXYgFKsDIFXa84XyoD+5RBq8645N/VXIIfmUo9Lz5o2hRq9+HNq3u4E5i+WU75fLP59FNwuTmNUY774bRN4JIeS6358lhn/MwqW14qflrZAGjkqOLWCQdd3l3f2mw55QikXXScSHhl586Xf2DmEEf2ut3JGFK4I/TMYteP+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695666; c=relaxed/simple;
	bh=sAEpbqN+3poWHbya/BmEJrQtJipnQHhZl5UAqUKwn4I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8HZUa/6cJoEh86l6+Z/pvAXZpAGwmIVt2xkbR+dLwt3/DcjqNK+oDnvBSkDY4tn+yDPyUvsAIbmYBUYr6G47Hnu8MGWzKxXDR66YTtVWia+3E5VOoqlRKJgiH1kpnBVhglHLm8wz2YSGKbCvX6g1827It274hc1RaALanGKLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAudfDhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAudfDhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48B81F000FF;
	Tue, 29 Sep 2026 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695660;
	bh=QYOjcvwm8IvLdqo31Ia+V27XLsn8fLfzlUhQM59Ycfk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EAudfDhL9HsiBNE5axjIHAY0jXYy6iS2xRl14nrrOp8V+gw4SXlD+6Blf9Yc4SK7D
	 nxA1h6rtM6pZWG08X6OIh+0aKZM2sVdSgHY9v8eboUJfwn6/vBZvFzctQCT7Ti3r9Z
	 xocq8+KUAWhmTHyRglxf7HZmzReJPBIwMw1aJypv12m1ns4UeQM0lC3UGnxovTOfw1
	 MVF7BEJkz0WpcVoulLD3qy20gjg3oIfain3d4H9xuN4XUBJbUf16Snh1Lbx55vm7z9
	 g+1y8CQTFpPizPeSu5g/mNVmv5e79OGotxwWXhIc6iAi7cvbT7ohdcqUWITHyRyNAc
	 0y9d2HtGxpm7w==
Subject: Re: [PATCH net-next 1/2] net: pcs: rzn1-miic: Make usage of
 miic_port_max consistent
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 15:27:39 +0000
Message-ID: <179069565933.434549.5780027645108841461@kernel.org>
In-Reply-To:
 <20260925-miic-validate-dtb-v1-1-3a6db9bb75ec@reliablecontrols.com>
References:
 <20260925-miic-validate-dtb-v1-1-3a6db9bb75ec@reliablecontrols.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes this patch as a consistency cleanup
  ("Make usage of miic_port_max consistent").

Pre-existing issues:
- [Medium] In the reviewed commit, miic_parse_dt() reads the per-
  converter DT "reg" into `int port` and never checks it against the…

--

net: pcs: rzn1-miic: Make usage of miic_port_max consistent

This patch makes miic_port_max always mean a port count rather than the
last port number. It adds a MIIC_PORT_END() helper for the last valid port
and uses it for the range check in miic_create(). The per-SoC values now
come from the index_to_string tables.

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
> index cb74861e823c8..62daaf76e0525 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -59,6 +59,8 @@
>  
>  #define MIIC_MAX_NUM_RSTS		2
>  
> +#define MIIC_PORT_END(x) ((x)->miic_port_start + (x)->miic_port_max - 1)
> +
>  /**
>   * struct modctrl_match - Matching table entry for  convctrl configuration
>   *			  See section 8.2.1 of manual.

[ ... ]

> @@ -482,7 +484,7 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
>  
>  	miic = platform_get_drvdata(pdev);
>  	of_data = miic->of_data;
> -	if (port > of_data->miic_port_max || port < of_data->miic_port_start) {
> +	if (port > MIIC_PORT_END(of_data) || port < of_data->miic_port_start) {
>  		put_device(&pdev->dev);
>  		return ERR_PTR(-EINVAL);
>  	}

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Now that
MIIC_PORT_END() exists, should miic_parse_dt() use it as well?

miic_parse_dt() reads each converter's reg into int port and uses it with
no range check:

drivers/net/pcs/pcs-rzn1-miic.c:miic_parse_dt() {
    ...
	for_each_available_child_of_node(np, conv) {
		if (of_property_read_u32(conv, "reg", &port))
			continue;
		...
		/* Adjust for 0 based index */
		dt_val[port + !miic->of_data->miic_port_start] = conf;
		...
		miic_configure_phy_link(miic, conf, port, active_low);
	}
    ...
}

dt_val is allocated with conf_conv_count entries (6 on RZ/N1, 5 on
RZ/T2H). On RZ/T2H, reg = 4 writes dt_val[5], one byte past the end of the
allocation. Larger or negative reg values write further out of bounds.

miic_configure_phy_link() also builds BIT(port + shift) from the same
unchecked value, and the result is written to MIIC_PHY_LINK.

The miic_probe()->miic_parse_dt() path runs before miic_create() sees the
port, so the new check here does not cover it. Only a malformed DT can
reach this, since the binding restricts reg per SoC.

A later patch in this series, "net: pcs: rzn1-miic: Validate dtb
configuration values", appears to add a port < miic_port_start ||
port > MIIC_PORT_END() check to miic_parse_dt() and fail probe with
-EINVAL. That would resolve this.

[ ... ]

> @@ -838,7 +840,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
>  	.index_to_string = rzt2h_index_to_string,
>  	.index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
>  	.miic_port_start = 0,
> -	.miic_port_max = 4,
> +	.miic_port_max = ARRAY_SIZE(rzt2h_index_to_string) - 1,
>  	.sw_mode_mask = GENMASK(2, 0),
>  	.reset_ids = rzt2h_reset_ids,
>  	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),

[Severity: Low]
The subject describes this as a consistency cleanup:

  net: pcs: rzn1-miic: Make usage of miic_port_max consistent

Isn't this really a functional fix that only affects RZ/T2H and RZ/N2H?

The value here is still 4, but its meaning has changed. Before this patch,
miic_init_hw() already used it as a count:

	for (port = 0; port < miic->of_data->miic_port_max; port++) {

miic_create(), on the other hand, used it as the last valid port:

	if (port > of_data->miic_port_max || port < of_data->miic_port_start) {

So on RZ/T2H, a PCS node with reg = 4 was accepted, even though
rzt2h_index_to_string only lists CONV0..CONV3. That produced
miic_port->port = 4. The phylink ops then wrote MIIC_CONVCTRL(4) and
toggled bit 4 of CONVRST for a converter that does not exist.

After this patch, MIIC_PORT_END() is 0 + 4 - 1 = 3 on RZ/T2H, so
miic_create() now rejects reg = 4 with -EINVAL.

Nothing changes on RZ/N1. ARRAY_SIZE(index_to_string) - 1 is still 5, and
MIIC_PORT_END() is 1 + 5 - 1 = 5.

Could the commit message name the affected SoC, describe this change in
behaviour, and note that RZ/N1 is unaffected?

Should it also carry a Fixes: tag? The mismatch appears to come from
08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support"). That commit
added .miic_port_max = 4, while the check from c112520de041 ("net: pcs:
rzn1-miic: move port range handling into SoC data") treated the value as
the last port.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-miic-validate-dtb-v1-0-3a6db9bb75ec%40reliablecontrols.com
