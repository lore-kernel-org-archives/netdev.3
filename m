Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706D3BFADE;
	Tue, 29 Sep 2026 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721424; cv=none; b=JaNbRdHq1PAnMkzmqsZeCUU2Z9YD4UTL5BiVpndyBXxR57Pph3RHH/MTdGCJ4fxzf5H3bDg9dZ8tRlPiXPx7DXMRVTmT+RQWMj9hVVHP6d6J0KVeVtCSjp2QZwwicQxhvTD/abNXZDBi+NQGjkcyvYU7aFamNyUCiGmOqZtZfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721424; c=relaxed/simple;
	bh=0/bUjykIrp72QLvJHNFdHMLZHU8wdgAhaRLlMxZ2wvU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uB+eQvo/tN1lv84ZadOmChlYxPejgJBez8qLPXzODYso98ACKg3RDoEgrP5cfrWBgVs+htsffIdJuoHsPnMf2ycR746WH5bdLMhyCLtnLzBI958xUbLjsHwZ7EEiAcFQDAuIFB+XRQAZul0fd0B0aCIgtF+lhUkKQqthYBmI3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1Fv4mH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1Fv4mH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7291F000FF;
	Tue, 29 Sep 2026 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721423;
	bh=fyajHbBwa3PbgcDWFEbuxluxVFd5ikA4w22SdqV8tQY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C1Fv4mH5KynA8vEBVfanTp6yKFVR3yx22yCvMc26gWobso96oz85HpRu4GyEFpDBu
	 hRAZU2cWsUBsmwft2Q5uAd0Pvim6pMFFlozjRRKrUWYELMZrxCdBXU7puuCrC+B755
	 mXrs47kEHcZ+Lh6ThL4xSr+yqEmiyYmV2mRXi8X6VhEy0rSWdWOT1CQiE1Q5RLN+yh
	 9AcxUUpB0lB70bWcsCRngJvieR6ESHwKuEvbl5njkjVi6tG2srHGWRC5lCpqPkXAbh
	 MJnHGPg1sLgngG6/f/2GO3v3y9b2ivlMMStkBibR99p7tWU7IKImCwRGK1+KdliYUm
	 K/XV5fffBGzcQ==
Subject: Re: [PATCH net-next] dt-bindings: net: Convert hisilicon,hns-mdio to
 DT schema
From: netdev-bot+sashiko@kernel.org
To: robh@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 22:37:02 +0000
Message-ID: <179072142212.434549.1306076815346983081@kernel.org>
In-Reply-To: <20260925215911.2950356-1-robh@kernel.org>
References: <20260925215911.2950356-1-robh@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the new
  Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml, two of…
- [Low] The new schema lists 'subctrl-vbase' but doesn't make it
  required; the required list is only compatible, reg, #address-cells…

--

dt-bindings: net: Convert hisilicon,hns-mdio to DT schema

This converts the hisilicon,hns-mdio text binding to DT schema format.
It also adds the subctrl-vbase property. The driver and the hip06/hip07
device trees already use that property.

> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
> new file mode 100644
> index 0000000000000..b8350794650d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
> @@ -0,0 +1,59 @@

[ ... ]

> +  subctrl-vbase:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: syscon phandle
> +          - description: MDIO clock enable register offset
> +          - description: MDIO reset request register offset
> +          - description: MDIO reset done register offset
> +          - description: MDIO reset deassert register offset

[Severity: Medium]
Do the last two argument cell descriptions match how the driver reads
them?

hns_mdio_probe() in drivers/net/ethernet/hisilicon/hns_mdio.c reads the
last two cells as status registers. It gets the disable and deassert
offsets by adding 4 to the first two cells:

drivers/net/ethernet/hisilicon/hns_mdio.c:hns_mdio_probe() {
    ...
	mdio_dev->sc_reg.mdio_clk_en =
		(u16)reg_args.args[0];
	mdio_dev->sc_reg.mdio_clk_dis =
		(u16)reg_args.args[0] + 4;
	mdio_dev->sc_reg.mdio_reset_req =
		(u16)reg_args.args[1];
	mdio_dev->sc_reg.mdio_reset_dreq =
		(u16)reg_args.args[1] + 4;
	mdio_dev->sc_reg.mdio_clk_st =
		(u16)reg_args.args[2];
	mdio_dev->sc_reg.mdio_reset_st =
		(u16)reg_args.args[3];
    ...
}

hns_mdio_reset() then polls mdio_clk_st and mdio_reset_st after it
writes the enable/disable and request/deassert registers.

The in-tree users agree with the driver. hip06.dtsi and hip07.dtsi have:

    subctrl-vbase = <&peri_c_subctrl 0x338 0xa38 0x531c 0x5a1c>;

These values are MDIO_SC_CLK_EN, MDIO_SC_RESET_REQ, MDIO_SC_CLK_ST and
MDIO_SC_RESET_ST. MDIO_SC_RESET_DREQ (0xa3c) is RESET_REQ + 4, not a
cell.

Suppose a new DT follows this schema and puts the reset deassert offset
in the last cell. Then hns_mdio_reset() would poll the wrong register and
time out, and the MDIO bus would fail to register.

Should the last two cells be described as the MDIO clock status and
MDIO reset status register offsets? It could also help to say that the
clock disable and reset deassert registers sit at +4 from the first two
offsets.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'

[Severity: Low]
Should subctrl-vbase be added to the required list?

On DT systems the driver does not seem to work without it. In
hns_mdio_probe(), if of_parse_phandle_with_fixed_args() fails to find
subctrl-vbase, the driver only warns. It leaves subctrl_vbase as NULL
and still calls of_mdiobus_register(). The bus reset callback then
fails:

hns_mdio_probe()
  of_mdiobus_register()
    __mdiobus_register()
      bus->reset() == hns_mdio_reset()

drivers/net/ethernet/hisilicon/hns_mdio.c:hns_mdio_reset() {
    ...
	if (dev_of_node(bus->parent)) {
		if (!mdio_dev->subctrl_vbase) {
			dev_err(&bus->dev, "mdio sys ctl reg has not mapped\n");
			return -ENODEV;
		}
    ...
}

__mdiobus_register() then fails with that error.

So a node without subctrl-vbase passes dt_binding_check, but the bus
can never come up. The example in this schema is one such node.

Both in-tree users, hip06.dtsi and hip07.dtsi, already set the property.
Making it required would not break any existing DTs.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925215911.2950356-1-robh%40kernel.org
