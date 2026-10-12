Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4788443E54;
	Mon, 12 Oct 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804284; cv=none; b=rEp+gZZe9RLMJ3nHPnH8wTls08UJBQztY75GIi2fb0LJk6hI4Dm6xKHCMaAg0GpeqIHmbEnSA/wptwsqqXU7zwN6OggdnypgACdLuE71ztyollcsupV6fDy5gSbRiiLn7m8YsVSdLpyaUu27rRlOQAYy2PTxhkxG83loKFHYvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804284; c=relaxed/simple;
	bh=Ig6i+pdIH3dX1EeMcXwkWdDKyp8fwdFQeFBb7c+PVzI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IY258RvAU0lPQjoMcbBadNWywH1K0LfmNxATm3Ed1yc8aeehY7q65WZqPUwAv50rYQ74ImBxC0b2kFmehWdZHEu70IVOa0JMQpal+2Ip/mqZI0z+KkD3ceCuHA5LuSetMfUpPyuvRW6ebnPeTbLR1FphjY3QRxQCATx+grgDa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOKKPLAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOKKPLAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD51F0089B;
	Mon, 12 Oct 2026 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804282;
	bh=05xQWmf9pYCL4ffCmDQJObsV6VP8iSkZQv44PVRuhSM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jOKKPLAPlC0zPr+ld1iEZgIL0nnN7yFcSn/xk6pTG72TdCDGBrKkAa54gHe5rSfnT
	 HjMhT6/oRwsk+XWmOHmkJ2nBlHxoBk917dXxuXoZ3/+wb3O5yFzPbkwdxBOd/+RcYF
	 To5fj5p0HyQISbvjpLK3Y8GyK06Yfik7+7MiyB97NAplrcRPScrsST0oXz3hZc7Mb9
	 D3FvrkMfk8vt/pXmNLKH2dXdNgNs+/5sDqKFgj3zFGYWv8DcOw/k0vpxG9B6Doiv9j
	 Mo1ARKfeMhxyw7Ua205/ZvymNOsw4O6dCGJnAsHxgrD5CoXu4o5rMwtXpm6ESz9a4l
	 fXVi2TFlIoX7g==
Subject: Re: [PATCH net-next v14 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 12 Oct 2026 11:24:40 +0000
Message-ID: <179180428064.434549.5154143843172991562@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-4-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-4-3d2a72661213@microchip.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In lan9645x_phylink_mac_link_up()
  (drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c),…
- [Low] lan_rd(), lan_wr() and lan_rmw() in lan9645x_main.h discard
  regmap errors.
- [Low] On RGMII ports, the MAC delay handling ignores phy-mode.
- [Low] Nothing in the tree can bind this driver.

--

net: dsa: lan9645x: add basic dsa driver for LAN9645X

This commit adds a basic DSA driver for the Microchip LAN9645x switch.
It covers switch init, named regmaps obtained from a parent device,
NPI/CPU/front port setup and phylink MAC configuration. Only the internal
CuPHY ports 0-4 and the RGMII ports 7-8 are wired up. The SerDes modes
and the MFD parent are left for later series.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> new file mode 100644
> index 0000000000000..c7de3836e6967
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -0,0 +1,456 @@

[ ... ]

> +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> +{
> +	u32 val = 0;
> +	int err;
> +
> +	/* The parent must reset the whole chip before instantiating its
> +	 * children, so the switch core is disabled when we get here. The
> +	 * sequence below must not run more than once: initializing the
> +	 * memories on a running core corrupts pointers inside the queue
> +	 * system, which eventually fills up and stops passing traffic. If the
> +	 * core is already enabled the chip was not reset, so skip it.
> +	 */
> +	if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
> +		return 0;

[Severity: Low]
What happens here if the regmap_read() under lan_rd() fails? In
lan9645x_main.h, lan_rd() only warns and then returns the value it was
initialised with:

    u32 addr, val = 0;
    ...
    WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val));

    return val;

A failed read would look like CORE_ENA=0. The CORE_ENA=0 / RAM_INIT
sequence would then run on a core that may already be enabled. The comment
above says that corrupts pointers inside the queue system. The parent is
expected to be SPI based, like ocelot-spi, so bus errors can happen.

The RAM_INIT write can't be checked either. lan_wr() returns void, and the
self-clearing bit already reads back as 0 if the write was lost.

The same thing happens in two other places:

  - lan9645x_set_feat_dis() turns a failed GCB_FEAT_DISABLE read into
    num_port_dis = 0. That skips the SKU port limit check in
    lan9645x_setup().

  - lan9645x_port_set_maxlen() always returns 0. dsa_user_change_mtu()
    therefore raises dev->mtu even when the DEV_MAC_MAXLEN_CFG write
    failed.

Could lan_rd(), lan_wr() and lan_rmw() pass the regmap error back, at least
on these paths?

> +
> +	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
> +	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);

[ ... ]

> +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
> +{
> +	const char *resource_name;
> +	struct regmap *tgt_map;
> +
> +	for (int i = 0; i < NUM_TARGETS; i++) {
> +		resource_name = lan9645x_resource_names[i];
> +		if (!resource_name)
> +			continue;
> +
> +		tgt_map = dev_get_regmap(lan9645x->dev->parent, resource_name);
> +		if (IS_ERR_OR_NULL(tgt_map)) {
> +			dev_err(lan9645x->dev, "Failed to get regmap=%s\n",
> +				resource_name);
> +			return -ENODEV;
> +		}

[Severity: Low]
Does anything in the tree provide these regmaps?
lan9645x_request_target_regmaps() needs all 17 named regmaps from
dev->parent ("gcb", "qs", ..., "dev0" to "dev8", "qsys", "ana"). If any is
missing it returns -ENODEV. Nothing under drivers/mfd refers to lan9645x
or lan96455.

The commit message says:

    The MFD driver will come in a later series, because there are
    requirements on the number of child devices before a driver qualifies as
    a MFD device.

Until that lands, the driver cannot probe on any in-tree configuration.
Two things can't be tested in-tree:

  - the regmap naming contract with the parent

  - the assumption in lan9645x_reset_switch() that the parent has already
    reset the chip

The ocelot_ext driver cited as precedent was merged together with its
drivers/mfd/ocelot-spi.c parent.

Could the parent driver be merged in the same series?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> new file mode 100644
> index 0000000000000..b57beee8329f9
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> @@ -0,0 +1,371 @@

[ ... ]

> +static void lan9645x_rgmii_dll_config(struct lan9645x_port *p)
> +{
> +	u32 rx_idx, tx_idx;
> +
> +	/* DLL register layout:
> +	 * (N*2):   RGMII_N_RX
> +	 * (N*2)+1: RGMII_N_TX
> +	 */
> +	rx_idx = RGMII_IDX(p->chip_port) * 2;
> +	tx_idx = RGMII_IDX(p->chip_port) * 2 + 1;
> +
> +	/* Enable DLL in RGMII clock paths, deassert DLL reset, and start the
> +	 * delay tune FSM.
> +	 */
> +	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> +		HSIO_DLL_CFG_DLL_RST_SET(0) |
> +		HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
> +		HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),

[Severity: Low]
Should the MAC delay here depend on the RGMII phy-mode?
lan9645x_rgmii_dll_config() enables the RX/TX DLL delays based only on the
rx-/tx-internal-delay-ps values parsed by lan9645x_parse_mac_delay().
dsa_port_phylink_create() passes the DT phy-mode unchanged to phylink and
the PHY.

The binding (microchip,lan96455s-switch.yaml) allows 2000 ps for all four
RGMII modes, including rgmii-id. Take port 7 or 8 with an external PHY,
phy-mode = "rgmii-id" and rx/tx-internal-delay-ps = <2000>. Both the MAC
and the PHY would add 2ns.

ethernet-controller.yaml says:

    When the MAC implements the delay, it must
    ensure that the PHY does not also implement the same delay. So it
    must modify the phy-mode it passes to the PHY, removing the delay it
    has added. Failure to remove the delay will result in a
    non-functioning link.

It also says:

    A value of 2000ps, i.e 2ns, and a phy-mode
    of 'rgmii' will not be accepted by Reviewers.

Should the driver reject this combination, or remove the MAC-added delay
from the phy-mode it passes to the PHY?

[ ... ]

> +	if (lan9645x_port_is_cuphy(lan9645x, port, interface)) {
> +		lan_rmw(CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA_SET(gtx_clk),
> +			CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA, lan9645x,
> +			CHIP_TOP_CUPHY_PORT_CFG(p->chip_port));
> +	}
> +
> +	lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(1),
> +		SYS_PAUSE_CFG_PAUSE_ENA,
> +		lan9645x, SYS_PAUSE_CFG(p->chip_port));
> +
> +	/* Flow control */
> +	lan_rmw(SYS_MAC_FC_CFG_FC_LINK_SPEED_SET(fc_spd) |
> +		SYS_MAC_FC_CFG_FC_LATENCY_CFG_SET(0x7) |
> +		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA_SET(1) |
> +		SYS_MAC_FC_CFG_PAUSE_VAL_CFG_SET(0xffff) |
> +		SYS_MAC_FC_CFG_RX_FC_ENA_SET(rx_pause ? 1 : 0) |
> +		SYS_MAC_FC_CFG_TX_FC_ENA_SET(tx_pause ? 1 : 0),

[Severity: Medium]
Can this turn on PAUSE frame transmission on the NPI port? On link up,
lan9645x_phylink_mac_link_up() sets PAUSE_ENA to 1 on every port.
TX_FC_ENA follows tx_pause, with no exception for lan9645x->npi.
lan9645x_npi_port_init() doesn't disable pause on the NPI port either.

The NPI port has the long prefix extraction header enabled:

lan9645x_npi_port_init()
    lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LONG) |
    ...

A PAUSE frame sent on the NPI port would get the prefix and IFH like any
other extracted frame, so the conduit would not recognise it as PAUSE. The
port would run in lossless mode while the link partner never honours the
pause.

The DT example in the lan9645x binding gives the NPI port a fixed-link
with pause. MAC_SYM_PAUSE is advertised, so phylink resolves
tx_pause = rx_pause = true for the documented example.

mscc/ocelot uses the same NPI model and had this problem. It was fixed by
commit 33cb0ff30cff ("net: mscc: ocelot: don't let phylink re-enable TX
PAUSE on the NPI port"). That commit measured CPU termination throughput
at 271 Mbit/s before the fix and 926 Mbit/s after.

felix_npi_port_init() clears SYS_PAUSE_CFG_PAUSE_ENA on the NPI port, and
ocelot_phylink_mac_link_up() does:

    /* Don't attempt to send PAUSE frames on the NPI port, it's broken */
    if (port != ocelot->npi)
        ocelot_fields_write(ocelot, port, SYS_PAUSE_CFG_PAUSE_ENA,
                            tx_pause);

This also seems to still be the case at the end of the series.

Should PAUSE_ENA and TX_FC_ENA stay at 0 for lan9645x->npi? And should
PAUSE_ENA follow tx_pause on the other ports?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
