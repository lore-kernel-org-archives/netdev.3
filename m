Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0304316905;
	Thu,  1 Oct 2026 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829946; cv=none; b=rn/nXo3t1x0GncEK4irNiKVm5sCA2siBHE3ntlcWQ6NamaNn+78L6ENFcAnlOVaO5NcsO7cE7Eu3VtX7HCdI59LWsrET7ZXYwp67M6GPZnMuGygFgwYfa04XJqVaJz2p+djSwGR/nyGMuV6ZSfd5RmzS+P5slsCyl05F4tGxiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829946; c=relaxed/simple;
	bh=xzlJmBZMCgRewTdna8Iqm3hSHbEoZorMa/5oFVYqMGw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csJO/hNOMijAlcVRRezX603giUh5SgTVZQOyKG/0skx+IwF4zQ/dd3sSNd9mkdY0wuAl7vE+cDwQNyi6MfoXtvnkGurKbtinDORBENOa4H3xn9PEkJuCdAn3OJwEViHE04SuQV9x0IwugBEPMvir+m6ihFzp5+JoLa3sdvyWe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6G3Ft4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6G3Ft4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740631F000FF;
	Thu,  1 Oct 2026 04:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829942;
	bh=79TsK9dY3fGdmIe6KeQfTAtgITha4aHe5TEAVmS517M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H6G3Ft4l2huoXGCaM05XS8J77j4QL3pH6DwdtQU0+rd2je5FuvvRAn/mGkYbWtmsR
	 WMqG4cw09dehd6HoUUT2ZChVx6TbGXkDqDSor8hmUZMmVjSyeFloXALGVMjhllHS3y
	 JjCx+xRKbHMxLKJvID1LyTOBGh+cVjoGjPteJE6uj4dk+t4UTrJxmmc/sRsXjQojwJ
	 H9hL8HF2NqBmwuKEPUTH2bBESa6f+TDaUd1r7J3CQh9DgtxcRFNhIFkXHPF8Jz4e1/
	 9SqmKV6BByuGtUgKIpDxw89TFClKUUxcgPys8JsMoJUUwh/m6eOu3HwWHPh9K/Utg3
	 iL5ZA4s705tlA==
Subject: Re: [PATCH net-next v24 10/10] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Thu, 01 Oct 2026 04:45:39 +0000
Message-ID: <179082993999.434549.10251161612952735193@kernel.org>
In-Reply-To: <20260928194511.41878-11-ansuelsmth@gmail.com>
References: <20260928194511.41878-11-ansuelsmth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 7 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the AN8855 driver, the shared VLAN read-modify-write path
  reads the VLAN write-data register (AN8855_VAWD0) back, not the read-…
- [High] an8855_port_enable() sets ports[port].enable and turns on PMCR
  TX/RX, but it never writes the cached forwarding matrix…
- [Medium] mt7530_lib_port_change_mtu() writes DIV_ROUND_UP(length, 1024)
  into MT7530_GMACCR_MAX_RX_JUMBO.
- [Medium] an8855_set_mac_eee() rejects any tx_lpi_timer > 0xFFF (4095
  us).
- [Medium] The new an8855_mib table exposes, as private ethtool -S
  strings, counters that already have standard uAPI homes, and the…
- [Medium] an8855_setup() clears the AN8855_UNIPMF (IP unknown-multicast
  flood) bit for every user port, and nothing sets it again.
- [Medium] an8855_pcs_config() updates AN8855_PLL_CTRL_2 with
  AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, a field an8855.h defines in…
- [Medium] SGMII without in-band negotiation is always forced to 1000
  Mb/s in the PCS.
- [Medium] an8855_port_fdb_dump() declares 'u32 rsp;' without
  initialising it and passes it to mt7530_lib_fdb_cmd().
- [Low] NET_DSA_AN8855 can be enabled with COMPILE_TEST and
  CONFIG_REGMAP=n.
- [Low] an8855_pcs_config() changes several mode-specific SerDes/PCS bits
  in one direction only.
- [Low] an8855_rmon_ranges gives the top RMON histogram bucket as { 1519,
  AN8855_MAX_MTU }.

--

net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver

This patch adds a DSA driver for the switch inside the Airoha AN8855. It
reuses the shared mt7530-lib helpers through a per-chip regmap_field
table, and it extends the lib with several AN8855-specific fields. It
also adds a PCS for the SGMII/2500base-X CPU port and EEE support.

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
Can this fail to build with COMPILE_TEST=y, MFD_AIROHA_AN8855=n and
CONFIG_REGMAP=n?

REGMAP is only guaranteed through the select REGMAP in
MFD_AIROHA_AN8855. Neither NET_DSA_MT7530_LIB nor NET_DSA selects it.

In include/linux/regmap.h, struct reg_field and devm_regmap_field_alloc()
only exist under CONFIG_REGMAP, and there are no stubs for them.
struct mt7530_reg_field and an8855_setup_lib_priv() use both.

Is a select REGMAP needed on NET_DSA_AN8855 or NET_DSA_MT7530_LIB?

> diff --git a/drivers/net/dsa/mediatek/an8855.c b/drivers/net/dsa/mediatek/an8855.c
> new file mode 100644
> index 0000000000000..b4b02b7cb6eb8
> --- /dev/null
> +++ b/drivers/net/dsa/mediatek/an8855.c
> @@ -0,0 +1,1741 @@

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
> +	{ __MT7530_VAWD2, REG_FIELD(AN8855_VAWD1, 0, 31) },

[Severity: High]
On AN8855, do the VLAN read-modify-write paths in mt7530-lib.c read
back the correct register?

After the VTCR read command, mt7530_hw_vlan_update() reads the entry
through the VAWD fields:

mt7530_hw_vlan_update() {
    ...
    mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);

    regmap_field_read(priv->fields[MT7530_VAWD_PORT_MEM], &val);
    entry->old_members = val;
    ...
}

mt7530_hw_vlan_del() also checks:

    regmap_field_read(priv->fields[MT7530_VAWD_VLAN_VALID], &val);
    if (!val) {

In this table all of those fields map to AN8855_VAWD0, which is the
write-data register. an8855.h defines a read-data register, but nothing
uses it:

/* Same register field of VAWD0 */
#define AN8855_VARD0			0x10200618

If the hardware puts the read result in VARD0, the fetched entry is
whatever was last written to VAWD0. For example, an8855_setup() ends
with mt7530_lib_setup_vlan0(), which leaves PORT_MEM set to all members
and VALID=1. The first bridge VLAN add would then read old_members as
all ports.

Could this make ports members of VIDs they were never added to, or carry
ETAG bits from one VID to another?

Could it also let mt7530_hw_vlan_del() see a stale VALID=0, after which
WR_VID writes stale data over a live VLAN?

> +static const struct mt7530_mib_desc an8855_mib[] = {
> +	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),
> +	MIB_DESC(MT7530_MIB_TX_CRC_ERR, -1, "TxCrcErr"),
> +	MIB_DESC(MT7530_MIB_TX_COLLISION, -1, "TxCollision"),

[ ... ]

> +	MIB_DESC(MT7530_MIB_RX_DROP, -1, "RxDrop"),
> +	MIB_DESC(MT7530_MIB_RX_FILTERING, -1, "RxFiltering"),
> +	MIB_DESC(MT7530_MIB_RX_CRC_ERR, -1, "RxCrcErr"),

[Severity: Medium]
Should some of these counters go through the standard interfaces rather
than ethtool -S?

RxCrcErr matches the eth-mac FrameCheckSequenceErrors counter and
rtnl_link_stats64.rx_crc_errors. TxCollision matches collisions, and
RxDrop/TxDrop match rx_dropped/tx_dropped.

mt7530_lib_get_eth_mac_stats() never fills FrameCheckSequenceErrors.
an8855_switch_ops also has no .get_stats64, while mt7530.c implements
mt7530_get_stats64() from the same MIB.

[ ... ]

> +static int an8855_port_fdb_dump(struct dsa_switch *ds, int port,
> +				dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	int banks, count = 0;
> +	u32 rsp;
> +	int ret;
> +	int i;

[ ... ]

> +	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_START,
> +				 AN8855_FDB_MAT_MAC_PORT, &rsp);
> +	if (ret < 0)
> +		goto exit;
> +
> +	do {
> +		/* From response get the number of banks to read, exit if 0 */
> +		banks = FIELD_GET(AN8855_ATC_HIT, rsp);

[Severity: Medium]
Can rsp be used uninitialized here?

mt7530_lib_fdb_cmd() ignores the result of its final read and returns 0
anyway:

    if (rsp)
        regmap_field_read(priv->fields[__MT7530_ATC], rsp);

    return 0;

regmap_field_read() leaves *val untouched when it fails. If that read
fails after FDB_START, FIELD_GET() runs on an uninitialized stack value.
After FDB_NEXT it would run on a stale value.

Should rsp be initialized, or should mt7530_lib_fdb_cmd() return the read
error?

[ ... ]

> +static int an8855_port_max_mtu(struct dsa_switch *ds, int port)
> +{
> +	return AN8855_MAX_MTU;
> +}

[Severity: Medium]
Does mt7530_lib_port_change_mtu() program a valid jumbo value on AN8855?

It writes the MT7530 linear encoding:

    regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_JUMBO],
                       DIV_ROUND_UP(length, 1024));

an8855.h documents a non-linear encoding for this field:

#define   AN8855_MAX_RX_JUMBO_9K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x9)
#define   AN8855_MAX_RX_JUMBO_12K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xa)
#define   AN8855_MAX_RX_JUMBO_15K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xb)
#define   AN8855_MAX_RX_JUMBO_16K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xc)

At AN8855_MAX_MTU, length is 15338 + 14 + 4 + 4 = 15360, so 0xf gets
written, and that value is not defined.

More generally, frame lengths from 12289 to 15360 give 0xd-0xf. Lengths
from 9217 to 12288 give 0xa-0xc, which the hardware would read as
12K/15K/16K.

[ ... ]

> +static const struct ethtool_rmon_hist_range an8855_rmon_ranges[] = {

[ ... ]

> +	{ 1024, 1518 },
> +	{ 1519, AN8855_MAX_MTU },
> +	{}
> +};

[Severity: Low]
Should the top bucket's upper bound be a frame length?

The other buckets are frame lengths in octets. AN8855_MAX_MTU (15338) is
an L3 MTU, while the PKT_SZ_1519_TO_MAX counter counts frames up to
15360 bytes.

[ ... ]

> +static int an8855_port_enable(struct dsa_switch *ds, int port,
> +			      struct phy_device *phy)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	int ret;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	priv->ports[port].enable = true;
> +	ret = regmap_set_bits(priv->regmap, AN8855_PMCR_P(port),
> +			      AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
> +	mutex_unlock(&priv->reg_mutex);
> +
> +	return ret;
> +}

[Severity: High]
Should this also write the cached port matrix to hardware?

mt7530_update_port_member() skips the hardware write for disabled ports:

    if (priv->ports[port].enable)
        regmap_fields_write(priv->fields[MT7530_PCR_MATRIX],
                            port, port_bitmap);

mt7530_port_enable() in mt7530.c then applies it when the port comes up:

    regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
                       PCR_MATRIX(priv->ports[port].pm));

an8855_setup() calls an8855_port_disable() for every user port, so every
port starts with enable=false.

If a port joins a bridge, or is marked isolated, while it is down, does
that matrix ever reach AN8855_PORTMATRIX_P(port)?

If not, bridged ports would not forward to each other in hardware, and an
isolated port would still reach its peers.

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
Is the 0xFFF limit from MT7530 right for AN8855?

an8855_phylink_get_caps() reports the default timer from the 18-bit
AN8855_LPI_TXIDLE_THD_MASK field, in 2us units:

    config->lpi_timer_default = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) *
                                AN8855_TX_LPI_UNIT;

That comes to about 60000us, and phylink reports it via get_eee.

ethtool set-eee does a get-modify-set. dsa_user_set_eee() therefore
passes the unchanged 60000us timer to set_mac_eee(), and the request is
aborted with -EINVAL.

Wouldn't that make "ethtool --set-eee lanX eee off" fail unless tx-timer
is also lowered to 4095 or less?

an8855_phylink_mac_enable_tx_lpi() accepts timers up to the full 18-bit
field and clamps them.

[ ... ]

> +		/* Disable Unknown Multicast Forward on user ports */
> +		ret = regmap_clear_bits(priv->regmap, AN8855_UNMF, BIT(dp->index));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_clear_bits(priv->regmap, AN8855_UNIPMF, BIT(dp->index));
> +		if (ret)
> +			return ret;

[Severity: Medium]
What sets a user port's AN8855_UNIPMF bit again after this?

an8855_port_pre_bridge_flags() accepts BR_MCAST_FLOOD, but
mt7530_lib_port_bridge_flags() only updates the UNMF mask:

    if (flags.mask & BR_MCAST_FLOOD)
        regmap_field_update_bits(priv->fields[MT7530_UNM_FFP],

With this, is unknown IP multicast still not flooded between bridged user
ports when mcast_flood is on, which is the bridge default?

[ ... ]

> +	/* PLL - SDM */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, 0x0));
> +	if (ret)
> +		return ret;

[Severity: Medium]
Should this register be AN8855_PLL_CTRL_4?

an8855.h defines the field under PLL_CTRL_4:

#define AN8855_PLL_CTRL_4		0x1022e410
#define   AN8855_RG_DA_QP_PLL_SDM_HREN_INTF GENMASK(4, 3)

In PLL_CTRL_2, bits 4:2 hold AN8855_RG_DA_QP_PLL_BPA_INTF, which the
"PLL - LPF" step just set to 0x5.

Clearing bits 4:3 here changes BPA to 0x1, and SDM_HREN in PLL_CTRL_4 is
never written.

[ ... ]

> +		} else {
> +			ret = regmap_update_bits(priv->regmap, AN8855_RG_AN_SGMII_MODE_FORCE,
> +						 AN8855_RG_FORCE_CUR_SGMII_MODE |
> +						 AN8855_RG_FORCE_CUR_SGMII_SEL,
> +						 AN8855_RG_FORCE_CUR_SGMII_SEL);
> +			if (ret)
> +				return ret;

[Severity: Low]
Several mode-specific bits in an8855_pcs_config() only ever change in
one direction.

These are only set: FORCE_TXC_SEL, FORCE_SPD_MODE_P0,
FORCE_CUR_SGMII_SEL, P0_MII_MODE, P0_RA_AN_EN and FORCE_AN_DONE.

These are only cleared: SGMII_MODE/SGMII_AN_EN, P0_DIS_MII_MODE and
P0_MII_RA_*.

For example, FORCE_SPD_MODE_P0 is set for forced SGMII but never cleared
for in-band SGMII.

Could moving between in-band SGMII, forced SGMII and 2500base-X, or
starting from a PCS the bootloader configured, leave a mix of register
state from two modes?

[ ... ]

> +	/* Force Speed with fixed-link or 2500base-x as doesn't support aneg */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_2500;
> +		else
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_1000;

[Severity: Medium]
Does SGMII without in-band negotiation work at 10/100?

an8855_phylink_get_caps() advertises MAC_10 | MAC_100 along with SGMII
on port 5, but this code always forces the PCS to 1000.

an8855_phylink_mac_link_up() only updates PMCR, and an8855_pcs_ops has
no .pcs_link_up to program the resolved speed into the PCS.

With a 10/100 fixed-link, or an out-of-band PHY that resolves to 10/100,
would the PCS stay at 1000 while the MAC runs at the lower speed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
