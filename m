Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFB473C83;
	Sat, 10 Oct 2026 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633345; cv=none; b=UNMAxvAj8iVopkkGgLogo+HyEwBBK5TgCHxumISkL55pH21O8gLhFYczdqAMAb+Ush/ij83U9KIfWCv03TcV/eYsgpubq2o0YVx7Rjov3VlFH0ybXXYHYKdTu6s/It/zBO2E9jI8IgAiwkvgye6j15XbemBeJ1irnxqLxBbe908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633345; c=relaxed/simple;
	bh=EcZRSdNzvzUi+ARcNuTnGTCw043mfSaxaqpNdAQJF1g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=El2v8u/61qWdLefrWJ4NFqUKXtaaEY+bzlLoPzoJl/nBR9whxI4o9y9o+humNO/kbDRNJVbsB9KJ7qHvMz8h2cydV+DPhp8DYk48xsAXB7905S9j1J31xed04Dgg4QKxyW1MwnZnkX93kU7L5iF0gDwUc8gXjF2uW8mpUiS/HZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSyPFaJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSyPFaJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795F1F00893;
	Sat, 10 Oct 2026 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633344;
	bh=6IEhsyXQw8cKBngAZiQPre+TiL5xy9FDcO3H+YI16BQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bSyPFaJ25YKU/UmHqECSs2WgNX4tEJFP6YW6kOAsOP2bo4bPVYLTBQT4RvMjmbm3q
	 N5RJa0kIfih8kIMUFPEbTx6fpctMJ7QBdUyjiUWmVku5KUAr0jedWJVF96ygj+3Uk1
	 8LdANv+DCRO6c1kIcsudWaFnIGSkjDMRnu8UIWlnOl2ni1UzinxvVfklBxjF4Nsgv3
	 0iMjsOrn9E+10H4bFYy8xhqgPZgkq3Ul1+pNhrZ6xyxjpSebosEuq0PH0pstNDXFjX
	 gkJEUBv7bdfaSMn8YRW9Midsrh2PAt2BpzWNbMIwf1wdFZ0HULb4ysp2ZaUE8vt1Wk
	 joW0SmXkvlyaA==
Subject: Re: [PATCH net-next v4 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
From: netdev-bot+sashiko@kernel.org
To: suraj.gupta2@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 11:55:42 +0000
Message-ID: <179163334293.434549.14718764476813490489@kernel.org>
In-Reply-To: <20261006110550.1990213-3-suraj.gupta2@amd.com>
References: <20261006110550.1990213-3-suraj.gupta2@amd.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The XXV binding never says how link management works, so a node
  that passes the schema, including both examples in the binding, cannot…
- [Medium] The binding has no way to describe the XXV transceiver (GT)
  reference clock.
- [Low] The new XXV binding's `dma-names` schema only checks a per-item
  pattern (`^[tr]x_chan([0-9]|1[0-5])$`) and a count of 2 to 32.

--

dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet

This adds a new DT binding schema for the Xilinx XXV 10G/25G Ethernet IP.
The IP has an in-core PCS/PMA and uses an external AXI DMA or MCDMA. The
binding covers the 10gbase-r/25gbase-r phy-modes, the rx_core/drp/s_axi
clocks and the dmas/dma-names properties.

> diff --git a/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
> new file mode 100644
> index 0000000000000..cf31ab677a4bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
> @@ -0,0 +1,110 @@

[ ... ]

> +description:
> +  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet MAC with an
> +  in-core PCS/PMA driving a high-speed serial transceiver. It supports the
> +  10GBASE-R and 25GBASE-R line rates, with 25G operation following the 25G
> +  Ethernet Consortium specification. Because the PCS/PMA is integrated into
> +  the IP, the subsystem has no MDIO bus master and is not managed through an
> +  external MDIO PHY; link state is read from the MAC's own status registers.

[Severity: High]
The binding says there is no external MDIO PHY. It does not require or
show managed = "in-band-status" or a fixed-link node, though. Neither
example has phy-handle, fixed-link or managed.

The XXV support added later in this series sets only mac_capabilities and
supported_interfaces in axienet_xxv_phylink_set_capabilities(). It does
not set phylink_config.default_an_inband, so cfg_link_an_mode stays at
MLO_AN_PHY.

On open this gives:

axienet_open()
  phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0)
    fwnode_get_phy_node() fails, since there is no phy-handle
    if (pl->cfg_link_an_mode == MLO_AN_PHY)
        return -ENODEV;

A node that matches this binding, including either example, would then
fail ndo_open with "phylink_of_phy_connect() failed". Is that expected?

Also, phylink_pcs_poll_start() only polls the internal PCS when
cfg_link_an_mode == MLO_AN_INBAND.

Should the binding require managed: const: in-band-status? The other
option is for the XXV phylink_set_caps to set default_an_inband = true.
Either way, could the binding document the chosen mode?

> +  Any SFP module management (e.g. I2C) is handled by separate IP outside this
> +  binding. Its payload is moved by an external AXI DMA (or multichannel DMA)
> +  controller referenced through the "dmas" property.

[ ... ]

> +  clocks:
> +    items:
> +      - description: RX AXI4-Stream clock.
> +      - description: GT DRP clock.
> +      - description: AXI4-Lite register clock.
> +
> +  clock-names:
> +    items:
> +      - const: rx_core
> +      - const: drp
> +      - const: s_axi

[Severity: Medium]
How would a DT describe the transceiver (GT) reference clock here? The
description says the in-core PCS/PMA drives a high-speed serial
transceiver, and that transceiver has its own reference clock input.

The clocks/clock-names list is fixed at three entries, and
unevaluatedProperties is false. A DT that also lists the GT refclk would
fail validation. xlnx,axi-ethernet.yaml already documents mgt_clk for its
optional internal PCS/PMA PHY.

Later in the series, axienet_10g25g_clk_init() claims only s_axi, rx_core
and drp. axienet_xxv_poll_link_ready() then fails open when GT reset-done
times out:

    netdev_err(ndev, "XXV MAC GT reset not complete! Cross-check the MAC ref clock configuration\n");

On boards where a Linux-managed, gateable clock provider supplies the GT
refclk, nothing claims that clock. Unused clock cleanup could then gate
it. This depends on the board.

Could an optional trailing clock (minItems: 3) be added now?
writing-bindings.rst asks for complete bindings even when the driver does
not use every feature.

[ ... ]

> +  dma-names:
> +    items:
> +      pattern: "^[tr]x_chan([0-9]|1[0-5])$"
> +    description:
> +      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel and
> +      "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel.
> +    minItems: 2
> +    maxItems: 32

[Severity: Low]
This checks the name pattern and the count. It does not require
"tx_chan0" and "rx_chan0", or even one TX and one RX entry. Both of these
pass dt_binding_check:

    dma-names = "tx_chan1", "rx_chan1";
    dma-names = "tx_chan0", "tx_chan1";

The driver requests fixed names, though:

axienet_probe()
    tx_chan = dma_request_chan(lp->dev, "tx_chan0");
    if (IS_ERR(tx_chan))
        return dev_err_probe(lp->dev, PTR_ERR(tx_chan), "No Ethernet DMA (TX) channel found\n");

axienet_init_dmaengine()
    lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
    ...
    lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");

Since dmas is required, XXV always takes this path. Could contains
constraints for "tx_chan0" and "rx_chan0" be added? Another option is to
fix the leading entries with items/additionalItems.

The pattern came from xlnx,axi-ethernet.yaml, but this patch creates a
new binding with it.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006110550.1990213-1-suraj.gupta2%40amd.com
