Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6C4503FA;
	Sat, 10 Oct 2026 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633348; cv=none; b=sEa0OGeHL3bzcDJOLZc+8UEBhe4uK1bxtRxHBZ1p1LKBFd0iBhS/+LlKtQB0kaCKpiE0qfE9XJO9fMIQGnFr66iN5AHmz5aRPEw6la6ej8zuGObcpmhzrhwZ9n/iBoci6DkxQYubhpspEjb4ALN5+Anbps6VekBNC3sX9YgnWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633348; c=relaxed/simple;
	bh=r0+KHNIlqNgg8B3pea4NWK/IcPmZQ3AsUMjeOZ9SUk8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9JC3bjzYtY5qyPHkeym1ZyQIjQxxq+dptmR4z0iO/ccnvqWZ+YqaHGl92SUhAKVbtQ+DH6al0/QQMOL12/hrWs2rfikis5SE80wOZLltfMO63gDLeUEkabIw2sBVmfQbPDCXKixLvkSMlkC2Ki/tUbA9Yi4eaMqvmMj7NenSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSqM923W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSqM923W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CF01F000FF;
	Sat, 10 Oct 2026 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633346;
	bh=bgBe07elzDeNeK+/7zmzLtY0h4tsRLImHcaJsOOOl1A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PSqM923W8C9ZeyyMoaf941MaHShkVgnawqZQkds5inc3fRaw186SaIJSvm1BRfvEH
	 5vXRAZ1lBm41qHVuWC/iyq4lz1B+Rmn0kBmxSX+PAjr6Z8oelRHaRbsqQ5lzVCjkSW
	 WNhJ7b/b2oE2TVgZGOdAZPZMnWjUjeVA1yQDRE0gTIC0noQOMEuFcLCdTanWbKtk37
	 KSB00HCq6IyqYa6CwLGxYTLymYMB2swRaC7650eVHuSfb8mP5oHliQh1eFg9ONWQlL
	 HM33YKbFd3pXk9Cv04pZuktpU6p4bJ/eYZMpKUWXqZXeq5g0DOcAYvCM0QflmrWzDZ
	 8RJk8Qoc26IUQ==
Subject: Re: [PATCH net-next v4 3/6] net: xilinx: axienet: Add 10G/25G (XXV)
 ethernet support
From: netdev-bot+sashiko@kernel.org
To: suraj.gupta2@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 11:55:44 +0000
Message-ID: <179163334454.434549.6060647558462905074@kernel.org>
In-Reply-To: <20261006110550.1990213-4-suraj.gupta2@amd.com>
References: <20261006110550.1990213-4-suraj.gupta2@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 2 (1) · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Under the new xlnx,xxv-ethernet binding, the interface cannot be
  opened.
- [High] The new early return in axienet_open() leads to a double free /
  use-after-free after a failed resume.
- [High] The XXV RX path takes frame lengths from a source the XXV
  hardware does not write.
- [High] The XXV MAC's receive max-packet-length register is never
  programmed to match the RX buffer size.
- [Medium] Pause is advertised and reported for XXV but never applied to
  the hardware.
- [Medium] The GT reset-done timeout is only 1 ms, and this patch makes
  missing it fatal to ndo_open.
- [Low] A real fix for an existing 1G bug is bundled into this feature
  patch without a Fixes: tag.
- [Low] axienet_xxv_poll_link_ready()'s kernel-doc says missing PCS block
  lock is expected with an unplugged cable and must not fail bring-up,…
- [Low] The jumbo-frame flag and the MTU range disagree for XXV.
- [Low] The kernel-doc for axienet_device_reset() is now wrong for XXV.

Pre-existing issues:
- [Medium] axienet_dma_rx_cb() passes `rx_len = app_metadata[LEN_APP] &
  0xFFFF` straight to skb_put().

--

net: xilinx: axienet: Add 10G/25G (XXV) ethernet support

This patch adds support for the Xilinx XXV 10G/25G Ethernet IP to the
axienet driver. The XXV-specific code lives in new xilinx_axienet_xxv.c/.h
files and is described through an axienet_10g25g_config with callbacks. It
also propagates axienet_device_reset() failures from axienet_open().

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 5af48d5cbed3b..c09f88b552fce 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1710,6 +1710,10 @@ static int axienet_open(struct net_device *ndev)
>  	axienet_lock_mii(lp);
>  	ret = axienet_device_reset(ndev);
>  	axienet_unlock_mii(lp);
> +	if (ret) {
> +		dev_err(lp->dev, "axienet_device_reset() failed: %d\n", ret);
> +		return ret;
> +	}

[Severity: Low]
This isn't a bug in the new code, but this check also fixes an existing
problem on the 1G path. Before this patch, phylink_fwnode_phy_connect()
overwrote the ret from axienet_device_reset() before anything checked it.

On the 1G legacy DMA path, axienet_device_reset() can already fail. That
happens when __axienet_device_reset() times out or when
axienet_dma_bd_init() cannot allocate descriptors:

axienet_device_reset() {
    ...
	ret = __axienet_device_reset(lp);
	if (ret)
		return ret;

	ret = axienet_dma_bd_init(ndev);
    ...
}

In those cases open continued into phylink_start() and
axienet_init_legacy_dma(). The core had not been reset, or there were no BD
rings.

The commit message only says this "matters for XXV". Could this go to net as
a separate fix with a Fixes: tag, so stable picks it up?

[Severity: High]
Can this early return lead to a double free after a failed resume?

axienet_suspend() calls axienet_stop(). In dmaengine mode, the only mode XXV
supports, that frees the skb rings and releases the DMA channels. It does not
clear the pointers:

axienet_stop() {
    ...
	for (i = 0; i < TX_BD_NUM_MAX; i++)
		kfree(lp->tx_skb_ring[i]);
	kfree(lp->tx_skb_ring);
    ...
	dma_release_channel(lp->rx_chan);
	dma_release_channel(lp->tx_chan);
    ...
}

axienet_resume() then ignores what axienet_open() returns:

axienet_resume() {
    ...
	rtnl_lock();
	axienet_open(ndev);
	rtnl_unlock();

	netif_device_attach(ndev);
    ...
}

Suppose axienet_xxv_mac_init() returns -ETIMEDOUT from the GT reset-done
poll. axienet_open() now returns before axienet_init_dmaengine() runs, but
the netdev is still netif_running().

The next ndo_stop can come from ifdown, from dev_close() in
axienet_shutdown(), or from unregister_netdev() in axienet_remove(). It would
run axienet_stop() again. That calls dmaengine_terminate_sync() on the
released channels and kfree()s the already freed tx_skb_ring/rx_skb_ring
arrays and their entries. It then calls dma_release_channel() a second time.

Before this patch the reset error was overwritten and open always
re-allocated, so stop stayed balanced. Resume ignoring the open error
predates this patch, but this early return is what makes the problem
reachable.

>  
>  	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
>  	if (ret) {

[ ... ]

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
> new file mode 100644
> index 0000000000000..9f7efab84f827
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
> @@ -0,0 +1,323 @@

[ ... ]

> +/* Option table for setting up XXV Ethernet hardware options */
> +static struct axienet_option xxvenet_options[] = {
> +	{ /* Turn on FCS stripping on receive packets */
> +		.opt = XAE_OPTION_FCS_STRIP,
> +		.reg = XXV_RCW1_OFFSET,
> +		.m_or = XXV_RCW1_FCS_MASK,
> +	}, { /* Turn on FCS insertion on transmit packets */
> +		.opt = XAE_OPTION_FCS_INSERT,
> +		.reg = XXV_TC_OFFSET,
> +		.m_or = XXV_TC_FCS_MASK,
> +	}, { /* Enable transmitter */
> +		.opt = XAE_OPTION_TXEN,
> +		.reg = XXV_TC_OFFSET,
> +		.m_or = XXV_TC_TX_MASK,
> +	}, { /* Enable receiver */
> +		.opt = XAE_OPTION_RXEN,
> +		.reg = XXV_RCW1_OFFSET,
> +		.m_or = XXV_RCW1_RX_MASK,
> +	},
> +	{}
> +};

[Severity: Medium]
Is the pause configuration ever applied to the XXV MAC?

axienet_probe() sets MAC_SYM_PAUSE | MAC_ASYM_PAUSE in
lp->phylink_config.mac_capabilities for every MAC type.
axienet_xxv_phylink_set_capabilities() only adds speed bits, so XXV
advertises both pause modes.

axienet_10g25g_config has no .mac_link_up. axienet_mac_link_up() therefore
silently drops the resolved tx_pause/rx_pause:

	if (lp->axienet_config->mac_link_up)
		lp->axienet_config->mac_link_up(ndev, speed, tx_pause, rx_pause);

This table also has no XAE_OPTION_FLOW_CONTROL entry. The
XXV_CONFIG_TX_FLOW_CTRL1_OFFSET and XXV_CONFIG_RX_FLOW_CTRL1/2_OFFSET
registers are only read for ethtool -d and never written.

As a result, phylink and ethtool -a/-A report and accept pause settings while
the MAC stays at its reset default. Should XXV program the flow control
registers from a mac_link_up callback, or stop advertising pause?

[ ... ]

> +/**
> + * axienet_xxv_gt_reset - Pulse the XXV GT reset line
> + * @lp: Pointer to the axienet_local structure
> + */
> +static void axienet_xxv_gt_reset(struct axienet_local *lp)
> +{
> +	u32 val;
> +
> +	/* Reset GT */
> +	val = axienet_ior(lp, XXV_GT_RESET_OFFSET);
> +	val |= XXV_GT_RESET_MASK;
> +	axienet_iow(lp, XXV_GT_RESET_OFFSET, val);
> +	/* Allow 1 ms for the GT reset to settle (see timeout note above) */
> +	usleep_range(1000, 2000);
> +	val = axienet_ior(lp, XXV_GT_RESET_OFFSET);
> +	val &= ~XXV_GT_RESET_MASK;
> +	axienet_iow(lp, XXV_GT_RESET_OFFSET, val);
> +}

[Severity: Low]
The kernel-doc for axienet_device_reset() in xilinx_axienet_main.c still
says:

 * Ethernet core. No separate hardware reset is done for the Axi Ethernet
 * core.

For XXV, that function now calls config->gt_reset() first, and this pulses
XXV_GT_RESET_MASK. XXV is dmaengine-only, so the DMA reset and BD init
described there never happen. The function now also returns mac_init()
failures such as the GT reset-done timeout.

Could the comment be updated to match?

[ ... ]

> +static int axienet_xxv_poll_link_ready(struct net_device *ndev)
> +{
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	u32 val;
> +	int ret;
> +
> +	/* Confirm XXV Ethernet is up: on IP v3.2+, wait for GT
> +	 * reset-done before further register access, then poll until
> +	 * RX PCS block lock is asserted.
> +	 */
> +	if (axienet_xxv_ip_has_gtwiz_status(lp->xxv_ip_version)) {
> +		ret = readl_poll_timeout(lp->regs + XXV_STAT_GTWIZ_OFFSET,
> +					 val,
> +					 (val & XXV_GTWIZ_RESET_DONE) == XXV_GTWIZ_RESET_DONE,
> +					 XXV_LINK_POLL_INTERVAL_US,
> +					 DELAY_OF_ONE_MILLISEC);

[Severity: Medium]
Is 1 ms long enough for GT reset-done?

axienet_xxv_gt_reset() releases ctl_gt_reset_all after 1-2 ms, and the GT
reset sequence only starts at that release. This poll then gives the GT
wizard DELAY_OF_ONE_MILLISEC to assert both TX and RX reset-done.

GT reset-done covers PLL re-lock and the RX reset sequence. With no signal
present, the CDR lock wait in that sequence can run until its internal
timeout. The comment at the top of the file says the bound is empirical and
that PG210 does not specify it.

With the new check in axienet_open(), a timeout here now fails ndo_open.
Could an unplugged cable push this past 1 ms and fail bring-up? The
kernel-doc above says an unplugged cable must not do that.

> +		if (ret) {
> +			netdev_err(ndev, "XXV MAC GT reset not complete! Cross-check the MAC ref clock configuration\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = readl_poll_timeout(lp->regs + XXV_STATRX_BLKLCK_OFFSET,
> +				 val, (val & XXV_RX_BLKLCK_MASK),
> +				 XXV_LINK_POLL_INTERVAL_US,
> +				 DELAY_OF_ONE_MILLISEC);
> +	if (ret)
> +		netdev_err(ndev, "XXV MAC block lock not complete! Cross-check the MAC ref clock configuration\n");
> +
> +	return 0;
> +}

[Severity: Low]
The kernel-doc says a missing block lock is expected with an unplugged
cable, and the function returns 0 in that case. Should this be logged below
netdev_err()?

As written, every ip link set up on a port with no link partner logs an
error that points at the ref clock configuration.

> +
> +/**
> + * axienet_xxv_mac_init - XXV MAC-specific bring-up after the DMA reset
> + * @ndev: Pointer to the net_device structure
> + *
> + * Return: 0 on success or a negative error number otherwise.
> + */
> +static int axienet_xxv_mac_init(struct net_device *ndev)
> +{
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = axienet_xxv_poll_link_ready(ndev);
> +	if (ret)
> +		return ret;
> +
> +	lp->options |= XAE_OPTION_FCS_STRIP;
> +	lp->options |= XAE_OPTION_FCS_INSERT;
> +
> +	return 0;
> +}

[Severity: High]
Should the XXV RX max packet length be programmed here?

XXV_JUM_OFFSET (CONFIGURATION_RX_MTU, ctl_rx_max_packet_len) appears only in
the ethtool -d table and is never written. Its reset default is 9600 bytes.

At the default MTU, axienet_device_reset() sets lp->max_frm_size to
XAE_MAX_VLAN_FRAME_SIZE (1522). axienet_rx_submit_desc() maps each RX buffer
at exactly that size.

If a link partner sends frames of 1523 to 9600 bytes, the MAC accepts them
and splits each one across several S2MM descriptors. axienet_dma_rx_cb()
treats every completion as a whole frame. Would these fragmented frames be
passed up the stack?

Changing the MTU never updates the MAC either, so the software and hardware
frame limits can be out of sync in both directions. On 1G the MAC drops
frames above its configured limit, so this does not happen there.

> +
> +static void axienet_xxv_phylink_set_capabilities(struct axienet_local *lp,
> +						 struct phylink_config *cfg)
> +{
> +	u32 core_speed;
> +
> +	core_speed = axienet_ior(lp, XXV_STAT_CORE_SPEED_OFFSET);
> +	/* Bit[1:0]: 00=25G, 01=10G, 10=runtime-switchable 25G,
> +	 * 11=runtime-switchable 10G. Bit 0 is the active rate. Advertise
> +	 * only that rate.
> +	 */
> +	if (core_speed & XXV_STAT_CORE_SPEED_10G_MASK) {
> +		cfg->mac_capabilities |= MAC_10000FD;
> +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> +			  cfg->supported_interfaces);
> +	} else {
> +		cfg->mac_capabilities |= MAC_25000FD;
> +		__set_bit(PHY_INTERFACE_MODE_25GBASER,
> +			  cfg->supported_interfaces);
> +	}
> +}

[Severity: High]
Can the XXV interface be opened with a device tree that follows the new
binding?

The xlnx,xxv-ethernet binding comes from "dt-bindings: net:
xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet". It requires neither
phy-handle nor managed = "in-band-status", and neither of its examples has
them.

Nothing sets lp->phylink_config.default_an_inband for XXV. At the end of the
series there is no default_an_inband anywhere in drivers/net/ethernet/xilinx/.
phylink_parse_mode() therefore leaves cfg_link_an_mode as MLO_AN_PHY.

axienet_open() then calls phylink_fwnode_phy_connect(), which does:

	phy_fwnode = fwnode_get_phy_node(fwnode);
	if (IS_ERR(phy_fwnode)) {
		if (pl->cfg_link_an_mode == MLO_AN_PHY)
			return -ENODEV;
		return 0;
	}

axienet_open() passes that -ENODEV back to the caller, so the interface never
comes up. Should this function set cfg->default_an_inband = true, or should
the binding require managed = "in-band-status"?

[ ... ]

> +const struct axienet_config axienet_10g25g_config = {
> +	.sw_padding = true,
> +	.internal_pcs = true,
> +	.regs_n = XXV_REGS_N,
> +	.clk_init = axienet_10g25g_clk_init,
> +	.setoptions = axienet_xxv_setoptions,
> +	.probe_init = axienet_xxv_probe_init,
> +	.gt_reset = axienet_xxv_gt_reset,
> +	.mac_init = axienet_xxv_mac_init,
> +	.get_regs = axienet_xxv_get_regs,
> +	.phylink_set_caps = axienet_xxv_phylink_set_capabilities,
> +	.pcs_ops = &axienet_xxv_pcs_ops,
> +};

[Severity: Low]
This leaves .jumbo false, which the kernel-doc defines as "MAC supports jumbo
frames" being false. axienet_probe() still sets ndev->max_mtu = XAE_JUMBO_MTU
for every MAC. axienet_change_mtu() only checks against lp->rxmem:

	if ((new_mtu + VLAN_ETH_HLEN + XAE_TRL_SIZE) > lp->rxmem)
		return -EINVAL;

So ip link set mtu 9000 is accepted on XXV. For XXV, is the .jumbo flag
wrong, or the max_mtu? xxvenet_options also has no XAE_OPTION_JUMBO entry,
and XXV_JUM_OFFSET is never written.

[Severity: High]
Where does XXV get the RX frame length from?

.non_dmaengine is left false, so every XXV RX completion goes through
axienet_dma_rx_cb(). That callback reads the length from AXI DMA APP word 4:

	/* TODO: Derive app word index programmatically */
	rx_len = (app_metadata[LEN_APP] & 0xFFFF);

On the 1G AXI Ethernet, the MAC's RX status stream writes that word. PG210
describes the XXV IP with only AXI4-Stream data interfaces and no status
stream.

xilinx_dma only attaches metadata_ops when the DMA node has
xlnx,axistream-connected:

	if (chan->xdev->has_axistream_connected)
		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;

Without that property, dmaengine_desc_get_metadata_ptr() fails and every
received frame is counted as rx_dropped. With it, app4 holds stale or zero BD
contents. Zero-length skbs or wrong lengths would then reach eth_type_trans()
and skb_put().

The real byte count is in the BD status length field, which xilinx_dma
reports as the residue. Does XXV need its own MAC-specific RX length source?

[Severity: Medium]
This is a pre-existing issue, but XXV now goes through the same callback.
axienet_dma_rx_cb() passes the metadata length straight to skb_put():

	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
	skb_put(skb, rx_len);

The callback does not check the dmaengine result or residue. rx_len is not
bounded by lp->max_frm_size or skb_tailroom() either. Could a length larger
than the posted buffer hit skb_over_panic()? The 1G dmaengine path already
had this problem.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006110550.1990213-1-suraj.gupta2%40amd.com
