Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC33D5C12;
	Tue, 29 Sep 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714119; cv=none; b=UHFjgkhbnYCLHq7cWU+QtJiMfcknU0OQqiwebTqi6Uy4V+q5ivptTxag2jTkrm8DOjpEEyPO98mRaTO2h0W8FvDgZ+JKwrSkBdZUiAYBZi/Wioy2C8tO6Bfa3T8xRvCkh5342wCPAKg2xQldnbrQXFKaQdUVCAu0PFMtVha/6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714119; c=relaxed/simple;
	bh=CUqaJXDy2QfPDrkGp0umCK+dNYCOZXkbGMi9/iX5yKs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeNOb9sR6IssT2hcL6Y7nOBqpvEv/EV72lPWEAAFLlFyQ3cehg3F+8w5kB0I/5Nke/Q2xvIGOIqD9qzKRmlrpAwhY5J4rPIrEkRRa7Ns2WeovbEPCsddpaZFAq7Bhzg8f+j5ce5nrc9gBVjqk6EVAnfQP83vSO3r8szPVzGe8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9HLO9Ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9HLO9Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEDA1F00893;
	Tue, 29 Sep 2026 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714112;
	bh=RtGGIM991W7X5mLyc9AtdbL/YfYpRTShyUbnEN8B9tA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L9HLO9IcKL0GDSTnHub5/0MAmyle703g4tddauW/qNym901OZw1F56ebPkGjSrx68
	 OdATFfXaAtXcdKR28fup7AsWNpsFJWNsyKUyTY64IepORVUqvOJs+2WYH5OMk4vUu9
	 0QzllrqIMv/jbU1mvNbaDwkl9fqrPseG0CYqEjYXBAX4q9eP3j3pBIIOMon4GZbrS2
	 Ado8gNuO6U6oekT/OTWvr+Jch4d61d6HvfEdnP1WYmi9jHf4hB3XeWJphZd8XlA96P
	 NDHn2hQCpcRtyyhgfXF07L45GemhzwxQivE300v6OgLdujXYl6uuD6f/v++HUEhI+V
	 0RkkbtN3UBmKA==
Subject: Re: [PATCH net-next v23 9/9] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 20:35:10 +0000
Message-ID: <179071411075.434549.3074183061900202807@kernel.org>
In-Reply-To: <20260925182435.21207-10-ansuelsmth@gmail.com>
References: <20260925182435.21207-10-ansuelsmth@gmail.com>
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

Critical: 0 · High: 3 · Medium: 6 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The AN8855 port_enable/port_disable callbacks never write the
  hardware port matrix.
- [High] On AN8855, the shared VLAN read-modify-write path reads back
  from the write-data register instead of the read register.
- [High] net: dsa: NULL deref in mt7530_lib_fdb_read() due to mismatched
  field check
- [Medium] The jumbo frame length encoding is wrong for AN8855.
- [Medium] an8855_set_mac_eee() rejects any tx_lpi_timer > 0xFFF (4095
  us).
- [Medium] The link-local trap fields for AN8855 point at the wrong bits.
- [Medium] an8855_pcs_config() updates AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
  which the header defines as a PLL_CTRL_4 field (GENMASK(4,3)), but…
- [Medium] SGMII without in-band negotiation always forces the PCS to
  1000 Mb/s.
- [Medium] The new AN8855 driver adds private `ethtool -S` strings for
  counters that already have standard uAPIs.
- [Low] The COMPILE_TEST dependency lets NET_DSA_AN8855 be built with
  MFD_AIROHA_AN8855=n, but neither NET_DSA_AN8855 nor NET_DSA_MT7530_LIB…
- [Low] an8855_phylink_mac_link_up() ignores the return value of
  regmap_read(AN8855_PMCR_P(port), &reg).
- [Low] In an8855_phylink_mac_enable_tx_lpi(),
  priv->tx_lpi_timer_ports[port] is written only when a non-zero timer…
- [Low] an8855_port_fdb_dump() declares `u32 rsp` without initialising it
  and uses FIELD_GET(AN8855_ATC_HIT, rsp) after mt7530_lib_fdb_cmd()…
- [Low] an8855_pcs_config() does not restore the bits that belong to
  other modes, so the programmed PCS state depends on earlier…
- [Low] The last RMON histogram bucket is {1519, AN8855_MAX_MTU}, and
  AN8855_MAX_MTU is an L3 MTU (15360 - ETH_HLEN - ETH_FCS_LEN -…

--

net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver

This adds a DSA driver for the switch inside the Airoha AN8855 chip. It
is built on the shared mt7530-lib helpers and has an in-driver PCS for
SGMII and 2500BASE-X on port 5. mt7530-lib gains optional AN8855
regmap fields (ATWD type/valid, ATRD ARP, PVID, extra MIB counters) and
a new mt7530_port_set_pvid() helper.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index f13ac7e772002..1753578c8e037 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -24,6 +24,16 @@ config NET_DSA_LOOP
>  	  This enables support for a fake mock-up switch chip which
>  	  exercises the DSA APIs.
>  
> +config NET_DSA_AN8855
> +	tristate "Airoha AN8855 Ethernet switch support"
> +	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
> +	depends on NET_DSA
> +	select NET_DSA_MT7530_LIB
> +	select NET_DSA_TAG_AIROHA

[Severity: Low]
With COMPILE_TEST this symbol can be enabled while MFD_AIROHA_AN8855=n.
Neither NET_DSA_AN8855 nor NET_DSA_MT7530_LIB selects REGMAP, which is a
hidden symbol.

In include/linux/regmap.h, struct reg_field, REG_FIELD(), REG_FIELD_ID()
and devm_regmap_field_alloc() are only declared under #ifdef
CONFIG_REGMAP. mt7530-lib.h embeds the struct by value:

struct mt7530_reg_field {
	unsigned int id;
	const struct reg_field field;
};

Would a COMPILE_TEST randconfig with no other REGMAP selector fail to
build here? Should this select REGMAP?

> diff --git a/drivers/net/dsa/an8855.c b/drivers/net/dsa/an8855.c
> new file mode 100644
> index 0000000000000..428d7dd85dd80
> --- /dev/null
> +++ b/drivers/net/dsa/an8855.c
> @@ -0,0 +1,1740 @@

[ ... ]

> +static const struct mt7530_reg_field an8855_fields[] = {

[ ... ]

> +	{ MT7530_BPDU_EG_TAG, REG_FIELD(AN8855_BPC, 9, 11) },
> +	{ MT7530_BPDU_PORT_FW, REG_FIELD(AN8855_BPC, 0, 2) },
> +	{ MT7530_PAE_BPDU_FR, REG_FIELD(AN8855_PAC, 28, 28) },
> +	{ MT7530_PAE_EG_TAG, REG_FIELD(AN8855_PAC, 25, 27) },
> +	{ MT7530_PAE_PORT_FW, REG_FIELD(AN8855_PAC, 16, 18) },

[Severity: Medium]
Are these the intended PAC bits? an8855.h names bit 28, bits 27:25 and
bits 18:16 of AN8855_PAC as AN8855_TAG_PAE_BPDU_FR, AN8855_TAG_PAE_EG_TAG
and AN8855_TAG_PAE_PORT_FW. The plain PAE fields are defined elsewhere:

#define   AN8855_PAE_BPDU_FR		BIT(12)
#define   AN8855_PAE_EG_TAG		GENMASK(11, 9)
...
#define   AN8855_PAE_PORT_FW		GENMASK(2, 0)

mt7530_lib_trap_frames() never programs those fields. This looks like
the MT7530 layout carried over, since on MT7530 the PAE fields sit in
the upper half of BPC.

AN8855_BPC also has an AN8855_BPDU_BPDU_FR bit (BIT(12)), but no lib
field maps to it. So real BPDUs (01:80:C2:00:00:00) are never marked as
"regarded as BPDU", and the lib comment says only such frames bypass the
spanning-tree port state.

Depending on the AN8855 reset defaults, could EAPOL frames fail to reach
the CPU? Could BPDUs received on blocking or listening ports be dropped?

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
mt7530_hw_vlan_update() fetches an entry with RD_VID, then reads the
result through MT7530_VAWD_PORT_MEM:

	/* Fetch entry */
	mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);

	regmap_field_read(priv->fields[MT7530_VAWD_PORT_MEM], &val);
	entry->old_members = val;

Here every VAWD_* field points at AN8855_VAWD0, which is the write-data
register. an8855.h defines a separate read register, and no field maps
to it:

/* Same register field of VAWD0 */
#define AN8855_VARD0			0x10200618

If RD_VID results land in VARD0, the same way the ATU uses separate
ATWD/ATRD registers, several values would come from whatever was last
written to VAWD0:

  - old_members
  - the VLAN_VALID check in mt7530_hw_vlan_del()
  - the ETAG bits kept by regmap_field_update_bits()

mt7530_lib_setup_vlan0() leaves VAWD0 with all ports in PORT_MEM and
EG_CON set. Would every VLAN added through an8855_port_vlan_add() then
get all ports as members and inherit EG_CON? Would
an8855_port_vlan_del() ever actually remove a port?

Should the fetched entry be read from AN8855_VARD0 instead?

[ ... ]

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
Some of these private ethtool -S strings already have standard uAPIs:

  - "RxCrcErr" matches ethtool_eth_mac_stats FrameCheckSequenceErrors
    and rtnl_link_stats64 rx_crc_errors.
  - "TxCollision" matches rtnl_link_stats64 collisions.

The driver implements get_eth_mac_stats through
mt7530_lib_get_eth_mac_stats(), but that helper never fills
FrameCheckSequenceErrors. The standard counter reads 0, and the value
only shows up in the private list.

Could these be reported through the standard interfaces instead?

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
rsp is not initialised. mt7530_lib_fdb_cmd() ignores the result of its
final read and returns success:

	if (rsp)
		regmap_field_read(priv->fields[__MT7530_ATC], rsp);

	return 0;

regmap_field_read() does not write *val on error. If that MDIO read
fails after a successful busy poll, is uninitialised stack data used as
the bank bitmap here? That could produce bogus dump entries or end the
dump early.

[ ... ]

> +static int an8855_port_change_mtu(struct dsa_switch *ds, int port,
> +				  int new_mtu)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +
> +	return mt7530_lib_port_change_mtu(&priv->lib_priv, port, new_mtu);
> +}
> +
> +static int an8855_port_max_mtu(struct dsa_switch *ds, int port)
> +{
> +	return AN8855_MAX_MTU;
> +}

[Severity: Medium]
Does the jumbo size encoding match AN8855? For lengths above 1552,
mt7530_lib_port_change_mtu() uses a linear 1 KiB encoding:

		regmap_field_write(priv->fields[MT7530_GMACCR_MAX_RX_JUMBO],
				   DIV_ROUND_UP(length, 1024));

an8855.h documents a non-linear encoding:

#define   AN8855_MAX_RX_JUMBO_9K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0x9)
#define   AN8855_MAX_RX_JUMBO_12K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xa)
#define   AN8855_MAX_RX_JUMBO_15K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xb)
#define   AN8855_MAX_RX_JUMBO_16K	FIELD_PREP_CONST(AN8855_MAX_RX_JUMBO, 0xc)

This gives three problems:

  - With AN8855_MAX_MTU = 15338, the length is 15338 + 14 + 4 + 4 =
    15360, which programs 0xf. That value is not defined.
  - Lengths from 9217 to 12288 program 0xa..0xc. The hardware reads
    those as 12K/15K/16K, not 10K/11K/12K.
  - Anything above 12288 programs one of the undefined values
    0xd..0xf.

Does AN8855 need its own translation here?

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
This isn't a bug, but AN8855_MAX_MTU is an L3 MTU while the other bounds
are frame lengths. The last bucket's reported upper bound ends up about
22 bytes below the largest frame the counter can count. mt7530.c and
rzn1_a5psw.c use the same convention.

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
> +
> +static void an8855_port_disable(struct dsa_switch *ds, int port)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	int ret;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	priv->ports[port].enable = false;
> +	ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
> +				AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
> +	mutex_unlock(&priv->reg_mutex);
> +	if (ret)
> +		dev_err(priv->ds->dev, "failed to disable port: %d\n", ret);
> +}

[Severity: High]
mt7530_update_port_member() only writes the port matrix to hardware for
ports that are currently enabled:

	p->pm = port_bitmap;
	if (priv->ports[port].enable)
		regmap_fields_write(priv->fields[MT7530_PCR_MATRIX],
				    port, port_bitmap);

The same check applies to other_p->enable. The helper relies on
port_enable to write ports[port].pm and on port_disable to clear the
matrix, which is what mt7530_port_enable() and mt7530_port_disable() do.
an8855_port_enable() and an8855_port_disable() only toggle the enable
flag and PMCR TX/RX_EN.

Take this sequence:

  ip link set lan1 master br0    (lan1 still down)
  ip link set lan1 up

Doesn't AN8855_PORTMATRIX_P(port) keep the BIT(AN8855_CPU_PORT) value
from an8855_setup()? Then the hardware never forwards lan1 frames to its
bridge siblings, and the software bridge won't either because
offload_fwd_mark is set.

The reverse case is a bridged port that goes down, leaves the bridge,
and comes back up standalone. Does its matrix still list the old bridge
members, so traffic leaks between the standalone port and the bridge?

Should these callbacks write priv->ports[port].pm to
AN8855_PORTMATRIX_P(port) on enable and clear it on disable, as mt7530
does?

> +static int an8855_set_mac_eee(struct dsa_switch *ds, int port,
> +			      struct ethtool_keee *e)
> +{
> +	if (e->tx_lpi_timer > 0xFFF)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: Medium]
This limit matches mt753x_set_mac_eee(), but it rejects this driver's
own default. an8855_phylink_get_caps() sets:

	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
	config->lpi_timer_default = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) *
				    AN8855_TX_LPI_UNIT;

That is roughly 60000us, and phylink reports it through get_eee.
ethnl_set_eee() starts from the get_eee values and only changes the
attributes the user passes. dsa_user_set_eee() returns the
set_mac_eee() error before it calls phylink_ethtool_set_eee().

So will something like "ethtool --set-eee lan1 eee off" fail with
-EINVAL unless a small tx-timer is also given?

an8855_phylink_mac_enable_tx_lpi() already clamps to the 18-bit
AN8855_LPI_TXIDLE_THD_MASK field. Is the 0xFFF check needed at all?

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
The regmap_read() return value is ignored here. If the read fails, reg
stays 0, and the later regmap_write(priv->regmap, AN8855_PMCR_P(port),
reg) overwrites the whole register. That write would clear:

  - MAC_MODE, IFG_XMIT, BACKOFF_EN and BACKPR_EN, set in
    an8855_phylink_mac_config()
  - the FORCE_EEE bits, set in an8855_phylink_mac_enable_tx_lpi()

Should the read error be checked, or regmap_update_bits() used instead?

[ ... ]

> +	if (timer) {
> +		int i;
> +
> +		/* Save requested timer and search the highest one */
> +		mutex_lock(&priv->reg_mutex);
> +		priv->tx_lpi_timer_ports[dp->index] = timer;
> +		for (i = 0; i < AN8855_NUM_PORTS; i++) {
> +			if (!priv->ports[i].enable)
> +				continue;
> +
> +			if (i == dp->index)
> +				continue;
> +
> +			if (timer < priv->tx_lpi_timer_ports[i])
> +				timer = priv->tx_lpi_timer_ports[i];
> +		}

[Severity: Low]
tx_lpi_timer_ports[] is only written when a non-zero timer is
requested. It is not reset in the timer == 0 branch or in
an8855_phylink_mac_disable_tx_lpi().

A port that has since disabled LPI, or switched to immediate LPI, still
counts in this maximum. Can the shared AN8855_CKGCR threshold therefore
stay higher than any active port asked for?

[ ... ]

> +	/* PLL - SDM */
> +	ret = regmap_update_bits(priv->regmap, AN8855_PLL_CTRL_2,
> +				 AN8855_RG_DA_QP_PLL_SDM_HREN_INTF,
> +				 FIELD_PREP(AN8855_RG_DA_QP_PLL_SDM_HREN_INTF, 0x0));
> +	if (ret)
> +		return ret;

[Severity: Medium]
Should this write go to AN8855_PLL_CTRL_4? The header defines this field
under PLL_CTRL_4:

#define AN8855_PLL_CTRL_4		0x1022e410
#define   AN8855_RG_DA_QP_PLL_SDM_HREN_INTF GENMASK(4, 3)

In PLL_CTRL_2, bits 4:3 belong to AN8855_RG_DA_QP_PLL_BPA_INTF
(GENMASK(4, 2)). The "PLL - LPF" step just above sets that field to
0x5, and this update turns it into 0x1. The PLL_CTRL_4 SDM_HREN bits
are never written.

The other PLL_CTRL_4 fields in an8855_pcs_config() (ICOLP_EN and
SSC_DIR_DLY) are written to PLL_CTRL_4.

[ ... ]

> +	/* PCS Init */
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_clear_bits(priv->regmap, AN8855_QP_DIG_MODE_CTRL_0,
> +					AN8855_RG_SGMII_MODE | AN8855_RG_SGMII_AN_EN);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_clear_bits(priv->regmap, AN8855_RG_HSGMII_PCS_CTROL_1,
> +				AN8855_RG_TBI_10B_MODE);
> +	if (ret)
> +		return ret;
> +
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		/* Set AN Ability - Interrupt */
> +		ret = regmap_set_bits(priv->regmap, AN8855_SGMII_REG_AN_FORCE_CL37,
> +				      AN8855_RG_FORCE_AN_DONE);
> +		if (ret)
> +			return ret;

[Severity: Low]
Several bits in an8855_pcs_config() are set or cleared in only one
branch, and nothing restores them when the mode changes:

  - The SGMII in-band path sets RG_FORCE_AN_DONE and RG_P0_RA_AN_EN.
    It never clears FORCE_TXC_SEL or FORCE_SPD_MODE_P0.
  - The in-band path never sets RG_SGMII_MODE or RG_SGMII_AN_EN again
    after the block above has cleared them.
  - RG_P0_MII_MODE is set on the SGMII path and is not cleared on the
    2500BASE-X path.

If phylink reconfigures port 5 to another mode, or the bootloader left
a different setup, could these stale bits keep the link from coming up
or select the wrong rate adaptation?

[ ... ]

> +	/* Force Speed with fixed-link or 2500base-x as doesn't support aneg */
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_2500;
> +		else
> +			val = AN8855_RG_LINK_MODE_P0_SPEED_1000;

[Severity: Medium]
SGMII without in-band negotiation is always forced to 1000 here, and
an8855_pcs_ops has no .pcs_link_up to program the resolved speed.

an8855_phylink_get_caps() still advertises MAC_10 | MAC_100, and
an8855_phylink_mac_link_up() forces the MAC to 10 or 100. Take port 5
with phy-mode sgmii and a fixed-link of speed = <100>. Would the PCS
stay at 1000 while the MAC runs at 100?

The header defines AN8855_RG_LINK_MODE_P0_SPEED_100 and _10, but they
are never used.

Should there be a pcs_link_up callback that programs the speed?

[ ... ]

> diff --git a/drivers/net/dsa/mt7530-lib.c b/drivers/net/dsa/mt7530-lib.c
> --- a/drivers/net/dsa/mt7530-lib.c
> +++ b/drivers/net/dsa/mt7530-lib.c
> @@ -483,8 +497,14 @@ void mt7530_lib_fdb_read(struct mt7530_lib_priv *priv, struct mt7530_fdb *fdb)
>  	fdb->mac[1] = val;
>  	regmap_field_read(priv->fields[MT7530_ATRD_MAC_BYTE_0], &val);
>  	fdb->mac[0] = val;
> -	regmap_field_read(priv->fields[MT7530_ATRD_ENT_STATUS], &val);
> -	fdb->noarp = val == STATIC_ENT;
> +	if (priv->fields[MT7530_ATWD_ENT_STATUS]) {
> +		regmap_field_read(priv->fields[MT7530_ATRD_ENT_STATUS], &val);
> +		fdb->noarp = val == STATIC_ENT;
> +	}
> +	if (priv->fields[AN8855_ATRD_ARP]) {
> +		regmap_field_read(priv->fields[AN8855_ATRD_ARP], &val);
> +		fdb->noarp = !!val;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(mt7530_lib_fdb_read);
>  

[Severity: High]
The guard here tests the write-data field MT7530_ATWD_ENT_STATUS,
but the read goes through MT7530_ATRD_ENT_STATUS.
regmap_field_read() dereferences field->regmap without checking the
field pointer. A mt7530-lib user that fills in the ATWD entry but
leaves out the ATRD one would oops here on every FDB dump that
reaches mt7530_lib_fdb_read().

With the users in this series, both fields appear to be populated
together for mt7530 and both are absent for an8855, so nothing
crashes today. The check is still protecting the wrong pointer.

The reverse case also goes wrong. A switch that provides only the
ATRD status field would silently skip it and never report noarp
from it.

Should this test priv->fields[MT7530_ATRD_ENT_STATUS] instead, so
the check matches the field that is actually read?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182435.21207-1-ansuelsmth%40gmail.com
