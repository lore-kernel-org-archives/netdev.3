Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A166364E98;
	Sat, 10 Oct 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649169; cv=none; b=MHIFuhvFRfVNZiGSk+GN9PoOyxdD9ok2Ikh1dpS25TC10DSDdRwopngDih8DImc6Tx8cqgOY0GtDJ/Lm64dH+YJbPg5jDHE5OWGRKtzicH424VxRIkThUqyAYYbV+55+KrtwCiPkXXnIjkNSP20Bc75sLck0voCveRDWVMJStU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649169; c=relaxed/simple;
	bh=5dQF9Pg1WkopPvZa6TTt9kGfaie6o9jvjL936ttECE4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwKRelGJAmJsoODWscEmFuV+XRFthId5mXF2H2w5HAHuL1S8ONo7R1mUNbCrhhUkSn7T6ECWH2BS2x2AydGYTYdZkHCBAhcvvRmaRzMNzF+0pi5gECwMp0Jyjjz1U77GtpQgYAz/po6WbXyJdzcxIEqxogAAz+KXNKBzzOx34oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH7mjCDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH7mjCDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BF61F0089D;
	Sat, 10 Oct 2026 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649168;
	bh=dbIOY9a/wWkwz/NK2C4IYvBJE7FMl1IFTNljoJY28G0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UH7mjCDcfyApAxZ0S5f45SRGQRnIf+fjrLEw17SQpyzn/cfcSwq/O/SKwwNkOsGtI
	 t2pv8kfGN6tqjgZxjVtlbFtZAAhGoKBEc2mSt/Jg8jGZcPwf1EGwCFGvANQgTdtAVM
	 xxO9N1VTaBmWHJOu5+lxEU+l1ZUfI9lP3erstawVADWx2hklIQGXMtfxYVxFzmK8lo
	 3/px0Kly8YZJo5wBKZJVR0lF9iTxQhn+TTf3wIW63QKa89r/NXCYOHzBfrZ0wU8kXO
	 kk5RnunGDxujzbkeVa+KnbCG6QZl01OmunEjWs19fiaiK+CRNSeQqhepo1Qa+aS0hD
	 vOduonNCo0BhA==
Subject: Re: [PATCH net-next v25 10/10] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Sat, 10 Oct 2026 16:19:25 +0000
Message-ID: <179164916590.434549.17520347329639701930@kernel.org>
In-Reply-To: <20261009161102.38961-11-ansuelsmth@gmail.com>
References: <20261009161102.38961-11-ansuelsmth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 15 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 9 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] an8855_port_enable() writes 0 to the port matrix instead of the
  value it just computed.
- [High] On AN8855 the shared VLAN code reads table entries back from the
  write-data register.
- [Medium] The patch makes the MT7530_ATC_INVALID check in
  mt7530_lib_fdb_cmd() optional and gives AN8855 no replacement.
- [Medium] an8855_port_change_mtu() calls mt7530_lib_port_change_mtu()
  directly.
- [Medium] an8855_set_mac_eee() rejects `tx_lpi_timer > 0xFFF`, a limit
  copied from MT7530's 12-bit LPI_THRESH field.
- [Medium] The SGMII 'PCS Init' block in an8855_pcs_config() is dead
  code.
- [Medium] an8855_port_fdb_dump() calls usleep_range(1000, 1500) for
  every valid bank entry while it walks up to AN8855_NUM_FDB_RECORDS…
- [Medium] In an8855_pcs_config(), the 'PLL - SDM' step applies
  AN8855_RG_DA_QP_PLL_SDM_HREN_INTF to AN8855_PLL_CTRL_2, but the header…
- [Medium] For SGMII without in-band negotiation, an8855_pcs_config()
  always forces the PCS to 1000 Mb/s (AN8855_RG_LINK_MODE_P0_SPEED_1000…
- [Medium] The new driver adds `ethtool -S` strings for counters that
  already have standard uAPIs.
- [Medium] net: dsa: an8855: missing mtu_enforcement_ingress flag allows
  MTU violation
- [Low] NET_DSA_AN8855 is declared with `depends on MFD_AIROHA_AN8855 ||
  COMPILE_TEST` and does not select REGMAP.
- [Low] The last RMON histogram bucket in an8855_rmon_ranges is { 1519,
  AN8855_MAX_MTU }.
- [Low] an8855_phylink_mac_link_up() initialises `u32 reg = 0`, ignores
  the return value of `regmap_read(priv->regmap, AN8855_PMCR_P(port),…
- [Low] an8855_port_fdb_dump() declares `u32 rsp;` without initialising
  it and passes &rsp to mt7530_lib_fdb_cmd().

--

net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver

This adds a DSA driver for the Airoha AN8855 5-port gigabit switch. It is
built on the shared mt7530-lib helpers and has an SGMII/2500BASE-X PCS for
the CPU port. mt7530-lib gains optional AN8855-specific regmap fields, and
its ATC/VTCR invalid checks become optional.

> diff --git a/drivers/net/dsa/mediatek/Kconfig b/drivers/net/dsa/mediatek/Kconfig
> index 7b48300dca0c5..2799e78a86517 100644
> --- a/drivers/net/dsa/mediatek/Kconfig
> +++ b/drivers/net/dsa/mediatek/Kconfig
> @@ -1,4 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config NET_DSA_AN8855
> +	tristate "Airoha AN8855 Ethernet switch support"
> +	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
> +	depends on NET_DSA
> +	select NET_DSA_MT7530_LIB
> +	select NET_DSA_TAG_AIROHA

[Severity: Low]
Can REGMAP end up disabled with COMPILE_TEST=y and MFD_AIROHA_AN8855=n?
NET_DSA_MT7530_LIB is a bare tristate, and REGMAP normally comes in
because MFD_AIROHA_AN8855 selects it.

struct reg_field, REG_FIELD() and devm_regmap_field_alloc() are declared
only under CONFIG_REGMAP in include/linux/regmap.h, with no stubs. In
that configuration an8855.c and mt7530-lib.c would fail to build.

Should this also select REGMAP?

> diff --git a/drivers/net/dsa/mediatek/an8855.c b/drivers/net/dsa/mediatek/an8855.c
> new file mode 100644
> index 0000000000000..22171cd885c70
> --- /dev/null
> +++ b/drivers/net/dsa/mediatek/an8855.c
> @@ -0,0 +1,1765 @@

[ ... ]

> +	{ MT7530_VAWD_IVL_MAC, REG_FIELD(AN8855_VAWD0, 5, 5) },
> +	{ MT7530_VAWD_EG_CON, REG_FIELD(AN8855_VAWD0, 11, 11) },
> +	{ MT7530_VAWD_VTAG_EN, REG_FIELD(AN8855_VAWD0, 10, 10) },
> +	{ MT7530_VAWD_PORT_MEM, REG_FIELD(AN8855_VAWD0, 26, 31) },
> +	{ MT7530_VAWD_FID, REG_FIELD(AN8855_VAWD0, 1, 4) },
> +	{ MT7530_VAWD_VLAN_VALID, REG_FIELD(AN8855_VAWD0, 0, 0) },
> +	{ __MT7530_VAWD1, REG_FIELD(AN8855_VAWD0, 0, 31) },
> +
> +	{ MT7530_VAWD_ETAG, REG_FIELD(AN8855_VAWD0, 12, 23) },

[Severity: High]
After a VTCR read command, the shared VLAN code reads the entry back
through these fields:

- mt7530_hw_vlan_update() reads MT7530_VAWD_PORT_MEM for old_members.
- mt7530_hw_vlan_del() checks MT7530_VAWD_VLAN_VALID.
- mt7530_hw_vlan_add() does a read-modify-write of MT7530_VAWD_ETAG.

All of these map to AN8855_VAWD0, which is the write-data register.
an8855.h also defines a read-data register that nothing maps:

/* Same register field of VAWD0 */
#define AN8855_VARD0			0x10200618

If MT7530_VTCR_RD_VID returns its result in VARD0, does the VLAN code
read back whatever was last written to VAWD0 instead?

For example, mt7530_lib_setup_vlan0() leaves PORT_MEM =
MT7530_ALL_MEMBERS in VAWD0. A following bridge vlan add for another VID
could then start from all members. Could deletes also take the
invalid-entry path, or clear the wrong members?

> +static const struct mt7530_mib_desc an8855_mib[] = {
> +	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),
> +	MIB_DESC(MT7530_MIB_TX_CRC_ERR, -1, "TxCrcErr"),
> +	MIB_DESC(MT7530_MIB_TX_COLLISION, -1, "TxCollision"),
> +	MIB_DESC(AN8855_MIB_TX_OVERSIZE_DROP, -1, "TxOversizeDrop"),
> +	MIB_DESC(AN8855_MIB_TX_BAD_PKT_BYTES_LOW,
> +		 AN8855_MIB_TX_BAD_PKT_BYTES_HIGH, "TxBadPktBytes"),
> +	MIB_DESC(MT7530_MIB_RX_DROP, -1, "RxDrop"),
> +	MIB_DESC(MT7530_MIB_RX_FILTERING, -1, "RxFiltering"),
> +	MIB_DESC(MT7530_MIB_RX_CRC_ERR, -1, "RxCrcErr"),

[Severity: Medium]
Several of these ethtool -S strings duplicate counters that already have
standard interfaces:

- "RxCrcErr" is FrameCheckSequenceErrors in ethtool_eth_mac_stats and
  rx_crc_errors in rtnl_link_stats64.
- "TxCollision" is collisions.
- "RxDrop" and "TxDrop" are rx_dropped and tx_dropped.

an8855_switch_ops also has no .get_stats64. mt7530.c fills
rtnl_link_stats64 from the same field IDs in mt7530_get_stats64(). In
addition, mt7530_lib_get_eth_mac_stats() does not fill
FrameCheckSequenceErrors.

Could these be reported through the standard interfaces rather than as
driver-private strings?

[ ... ]

> +static int an8855_port_fdb_dump(struct dsa_switch *ds, int port,
> +				dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	int banks, count = 0;
> +	u32 rsp;
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&priv->reg_mutex);
> +
> +	/* Load search port */
> +	ret = regmap_write(priv->regmap, AN8855_ATWD2,
> +			   FIELD_PREP(AN8855_ATWD2_PORT, BIT(port)));
> +	if (ret)
> +		goto exit;
> +	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_START,
> +				 AN8855_FDB_MAT_MAC_PORT, &rsp);
> +	if (ret < 0)
> +		goto exit;
> +
> +	do {
> +		/* From response get the number of banks to read, exit if 0 */
> +		banks = FIELD_GET(AN8855_ATC_HIT, rsp);

[Severity: Low]
rsp is not initialised, and mt7530_lib_fdb_cmd() ignores the return value
of the response read:

	if (rsp)
		regmap_field_read(priv->fields[__MT7530_ATC], rsp);

	return 0;

On a read error regmap_field_read() returns without writing *val. If that
read fails after a successful BUSY poll, does this FIELD_GET() work on an
indeterminate value?

> +		if (!banks)
> +			break;
> +
> +		/* Each banks have 4 entry */
> +		for (i = 0; i < 4; i++) {
> +			struct mt7530_fdb _fdb = {  };
> +
> +			count++;
> +
> +			/* Check if bank is present */
> +			if (!(banks & BIT(i)))
> +				continue;
> +
> +			/* Select bank entry index */
> +			ret = regmap_write(priv->regmap, AN8855_ATRDS,
> +					   FIELD_PREP(AN8855_ATRD_SEL, i));
> +			if (ret)
> +				break;
> +			/* wait 1ms for the bank entry to be filled */
> +			usleep_range(1000, 1500);
> +			mt7530_lib_fdb_read(&priv->lib_priv, &_fdb);

[Severity: Medium]
This sleeps once per valid entry while walking up to
AN8855_NUM_FDB_RECORDS (2048) slots. Each MT7530_FDB_NEXT can also poll
ATC_BUSY for up to 20ms.

All of this runs under priv->reg_mutex and rtnl_lock, because the
PF_BRIDGE RTM_GETNEIGH dumpit (rtnl_fdb_dump) is not registered as
unlocked.

The dump needs no CAP_NET_ADMIN, and learning on bridged ports can fill
the table. Could one unprivileged bridge fdb show hold rtnl for seconds?
The walk also restarts from the beginning on every netlink continuation,
so the delay would repeat each time.

Is the per-entry 1ms sleep needed? The MT7530 dump does not have one.

[ ... ]

> +static int an8855_port_change_mtu(struct dsa_switch *ds, int port,
> +				  int new_mtu)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	return mt7530_lib_port_change_mtu(&priv->lib_priv, port, new_mtu);
> +}

[Severity: Medium]
For jumbo frames, mt7530_lib_port_change_mtu() writes a linear KiB count:

		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_JUMBO],
				   DIV_ROUND_UP(length, 1024));

The AN8855_MAX_RX_JUMBO_* defines in an8855.h describe a non-linear
encoding: 0x0-0x2 = 2K, 0x3-0x9 = 3K-9K, 0xa = 12K, 0xb = 15K,
0xc = 16K. AN8855_MAX_MTU allows frame lengths up to 15360.

With that encoding, frame lengths of 9217-12288 bytes would be written as
0xa-0xc (12K/15K/16K). Lengths of 12289-15360 bytes would be written as
0xd-0xf, which are not defined. Is that intended? None of the
AN8855_MAX_RX_JUMBO_* macros seem to be used.

[ ... ]

> +static const struct ethtool_rmon_hist_range an8855_rmon_ranges[] = {
> +	{ 0, 64 },
> +	{ 65, 127 },
> +	{ 128, 255 },
> +	{ 256, 511 },
> +	{ 512, 1023 },
> +	{ 1024, 1518 },
> +	{ 1519, AN8855_MAX_MTU },
> +	{}
> +};

[Severity: Low]
AN8855_MAX_MTU is an L3 MTU: 15360 - ETH_HLEN - ETH_FCS_LEN -
MTK_TAG_LEN = 15338. ethtool_rmon_hist_range bounds are frame lengths.
Should the upper bound be the maximum frame length (15360) instead?

[ ... ]

> +static int an8855_port_enable(struct dsa_switch *ds, int port,
> +			      struct phy_device *phy)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct an8855_priv *priv = ds->priv;
> +	int ret;
> +
> +	mutex_lock(&priv->reg_mutex);
> +
> +	/* Allow the user port gets connected to the cpu port and also
> +	 * restore the port matrix if the port is the member of a certain
> +	 * bridge.
> +	 */
> +	if (dsa_port_is_user(dp)) {
> +		struct dsa_port *cpu_dp = dp->cpu_dp;
> +
> +		priv->ports[port].pm |= BIT(cpu_dp->index);
> +	}
> +	priv->ports[port].enable = true;
> +	ret = regmap_fields_write(priv->lib_priv.fields[MT7530_PCR_MATRIX],
> +				  port, 0);

[Severity: High]
Should this write priv->ports[port].pm instead of 0? The pm value
computed just above is never used, so the port matrix is empty once the
port is enabled.

an8855_setup() sets AN8855_PORTMATRIX_P(user) to BIT(AN8855_CPU_PORT).
dsa_user_open()->dsa_port_enable_rt()->an8855_port_enable() then
overwrites it with 0.

Would a standalone user port then be unable to forward to the CPU port
until a bridge join or leave calls mt7530_update_port_member()?

The same would happen in two other cases:

- The CPU port's dsa_user_ports() matrix would be cleared when DSA
  enables the CPU port.
- A port that was bridged before it came up would lose its membership,
  because mt7530_update_port_member() skips the write for disabled ports.

For comparison, mt7530_port_enable() writes
PCR_MATRIX(priv->ports[port].pm) at this point.

[ ... ]

> +static int an8855_set_mac_eee(struct dsa_switch *ds, int port,
> +			      struct ethtool_keee *e)
> +{
> +	if (e->tx_lpi_timer > 0xFFF)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: Medium]
Should an8855_setup() also set ds->mtu_enforcement_ingress?

mt7530_lib_port_change_mtu() returns early for every port except the
CPU port, because GMACCR is a single global RX length limit. It relies
on DSA setting the CPU port MTU to the largest user port MTU, and
programs that value into the switch.

The per-port MTUs are therefore never enforced in hardware. Take two
user ports in the same bridge with different MTUs. The port with the
smaller MTU still accepts frames up to the largest configured MTU, so
its own setting is silently ignored on ingress.

ds->mtu_enforcement_ingress exists for switches that only have a
global MRU. With it set, DSA normalizes the MTU of all bridged ports
when one of them changes, so the global limit matches what every
bridged port is configured for. The MT7530 setup path sets it for this
reason.

This could be set next to assisted_learning_on_cpu_port. Or is there
something on AN8855 that enforces the per-port MTU that I am missing?

[Severity: Medium]
The 0xFFF limit matches MT7530's 12-bit LPI threshold. On AN8855 the
timer field is AN8855_LPI_TXIDLE_THD_MASK, GENMASK(31, 14), in 2us units,
and an8855_phylink_mac_enable_tx_lpi() already clamps the value to it.

an8855_phylink_get_caps() takes lpi_timer_default from CKGCR. Its comment
gives the default as 60ms, which is about 60000us.

The resulting call sequence is:

- phylink reports that default through get_eee.
- ethnl_set_eee() keeps it unless the user passes tx-timer.
- dsa_user_set_eee() then calls set_mac_eee() with it.

Would any ethtool --set-eee on a user port, including eee off, fail with
-EINVAL unless it also passes tx-timer <= 4095?

[ ... ]

> +static void an8855_phylink_mac_link_up(struct phylink_config *config,
> +				       struct phy_device *phydev, unsigned int mode,
> +				       phy_interface_t interface, int speed,
> +				       int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct an8855_priv *priv = dp->ds->priv;
> +	int port = dp->index;
> +	u32 reg = 0;
> +
> +	mutex_lock(&priv->reg_mutex);
> +
> +	regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);

[Severity: Low]
If this read fails, reg stays 0 and the later regmap_write() rebuilds
PMCR from zero. Would that clear MAC_MODE, IFG_XMIT, BACKOFF/BACKPR and
the EEE force bits set by mac_config and mac_enable_tx_lpi?

Should the read error be checked before the register is written back?

[ ... ]

> +static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{

[ ... ]

> +	/* PLL - SDM */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, 0x0));

[Severity: Medium]
Is AN8855_PLL_CTRL_2 the right register here? an8855.h defines this field
in AN8855_PLL_CTRL_4:

#define AN8855_PLL_CTRL_4		0x1022e410
#define   AN8855_RG_DA_QP_PLL_SDM_HREN_INTF GENMASK(4, 3)

In AN8855_PLL_CTRL_2, bits 4:2 are AN8855_RG_DA_QP_PLL_BPA_INTF, and the
earlier "PLL - LPF" step set that field to 0x5. Clearing bits 4:3 here
would change BPA to 0x1 and leave the real SDM_HREN field untouched.

[ ... ]

> +	/* PCS Init */
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
> +					AN8855_RG_SGMII_MODE | AN8855_RG_SGMII_AN_EN);

[Severity: Medium]
Can this branch ever run? For SGMII, phylink_pcs_neg_mode() returns
either PHYLINK_PCS_NEG_INBAND_ENABLED or PHYLINK_PCS_NEG_OUTBAND.
INBAND_DISABLED only comes from the Base-X without a PHY case.

For SGMII fixed-link or PHY-managed links, SGMII_MODE and SGMII_AN_EN
would then stay at their reset or previous value. The other branches in
this function test neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED and set up
forced mode, so the PCS would end up configured inconsistently.

Should this condition also test neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED?

[ ... ]

> +	/* Force Speed with fixed-link or 2500base-x as doesn't support aneg */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_2500;
> +		else
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_1000;

[Severity: Medium]
For SGMII without in-band negotiation, this always forces the PCS to
1000.

an8855_phylink_get_caps() advertises MAC_10 | MAC_100 for port 5, and
an8855_phylink_mac_link_up() programs PMCR for 10 or 100. an8855_pcs_ops
has no .pcs_link_up to update the forced rate afterwards.

Would a 10/100 out-of-band SGMII link on port 5 run with the MAC and the
PCS at different rates?

[ ... ]

> diff --git a/drivers/net/dsa/mediatek/mt7530-lib.c b/drivers/net/dsa/mediatek/mt7530-lib.c
> index 098dd45d3ee9f..4325768033325 100644
> --- a/drivers/net/dsa/mediatek/mt7530-lib.c
> +++ b/drivers/net/dsa/mediatek/mt7530-lib.c
> @@ -423,9 +423,11 @@ int mt7530_lib_fdb_cmd(struct mt7530_lib_priv *priv, enum mt7530_fdb_cmd cmd,
>  		return ret;
>  	}
>  
> -	regmap_field_read(priv->fields[MT7530_ATC_INVALID], &val);
> -	if (cmd == MT7530_FDB_READ && val)
> -		return -EINVAL;
> +	if (priv->fields[MT7530_ATC_INVALID]) {
> +		regmap_field_read(priv->fields[MT7530_ATC_INVALID], &val);
> +		if (cmd == MT7530_FDB_READ && val)
> +			return -EINVAL;
> +	}

[Severity: Medium]
an8855_fields[] has no MT7530_ATC_INVALID entry. On AN8855 an
MT7530_FDB_READ therefore returns 0 even when the lookup misses.

mt7530_lib_port_mdb_add() and mt7530_lib_port_mdb_del() treat 0 as
"entry exists":

	if (!mt7530_lib_fdb_cmd(priv, MT7530_FDB_READ,
				ATC_MAT_MACTAB, NULL)) {
		regmap_field_read(priv->fields[MT7530_ATRD_PORT_MAP],
				  &val);
		port_mask = val;
	}

On a miss, could they merge whatever AN8855_ATRD3 still holds, for
example data left by the last an8855_port_fdb_dump()? That could program
a new group with ports that never joined it, or make mdb_del write a
STATIC_ENT for a group that does not exist.

The READ path also does not select the hit bank through AN8855_ATRDS, as
the fdb dump does.

AN8855 reports hits through AN8855_ATC_HIT. Should this check use that on
AN8855 instead?

The MT7530_VTCR_INVALID check in mt7530_vlan_cmd() was made optional in
the same way.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009161102.38961-1-ansuelsmth%40gmail.com
