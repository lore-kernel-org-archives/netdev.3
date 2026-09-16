Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E9495AC6;
	Wed, 16 Sep 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576223; cv=none; b=cgeKr4TsYTe1xW+lfOjeKcP5mjStB0VNKuOAvwS0vv9lrIq1bbS2SqjxyuyQE71Jv36x2P1irPBs/RXGJNtY+yWWC94YtXiKM0oJIcm10C/uZ69HBdP7CyszrMrDjccwmy6Ug7xVx5nCucq1pjbgZ21a7sHB8alncu3Vm2C6QFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576223; c=relaxed/simple;
	bh=o8VHx0YAqBN4jNc8JhfmyDexBT3x/xI02TkIqgIOij0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9zm0cNKvjTHs76v2e4Ta471w3sSs9Vd0zsKzjhYDuFGTOjGMuOKkw+ta7hR5PoAnGhTIX5VZNTGxSYuTiDKXr0ML2dr/PTcyY+umEk2y0u6Cqh7KxKHiEDpIUuSKXLPIVTQPkV0GTDM0E/PdT493a2KncT2ZStWleBtSBzYLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLMcoOZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLMcoOZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDB21F000FF;
	Wed, 16 Sep 2026 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576217;
	bh=kVGpQlOadGMfwK2nMDyDOYYUuFM1cvFEnDAAqEdcMR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JLMcoOZraPtFSTMj6g2ss8lomfc0GWb3DpM6qcskVg/UmQ11r0YRP9U3PtXzO0YYf
	 zHxi5v0pPyrwkO9wxT16i8XZn0lJ3TWocqEh4Y2RuZ18zybjsG8zxMu++hyvuW31NQ
	 KmiQXz4P2HIwe/+JzAKctqDNq/8ciPTBUAqOjkjkyhG4Zzl8aSN3xQ7vBmyT29OCq1
	 LRTA9DV0wmw85TLuCpNJ4hsgp/s1qIA2t5RMPGGEKR3mCjA94Gp94ZVLYH+0obvKTr
	 DzOHTOvNDuRLpCuqMmY8hwQx8fnjaT/c3UObCLEoHO2qj0b11o5hgw8wxdtEr5ngMA
	 11MUVOl+pjqbA==
Subject: Re: [PATCH net-next v7 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 16 Sep 2026 16:30:16 +0000
Message-ID: <178957621656.22033.2764355653365288140@kernel.org>
In-Reply-To: <20260914103009.3007019-7-kyle.switch@motor-comm.com>
References: <20260914103009.3007019-7-kyle.switch@motor-comm.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider:

Critical: 1 · High: 3 · Medium: 3 · Low: 4

- [Critical] YT922x PCS callbacks recover their private structure from an
  uninitialized `pp->index`.
- [High] Four of the six YT922x serdes-mode constants are encoded into
  the wrong register field.
- [High] `yt922x_sds_phyaddr_get()` (chip.c:4901-4918) accepts an `enum
  yt922x_phy_reg_space` argument and its own comment says "sds phyaddr…
- [High] `yt922x_dsa_setup()` (chip.c:5507) takes `priv->reg_lock` at
  chip.c:5530 and calls `yt922x_chip_setup()` (chip.c:5463) with the…
- [Medium] The driver advertises `PHY_INTERFACE_MODE_100BASEX` for YT922x
  external ports (in `yt922x_dsa_phylink_get_caps()` at chip.c:5317 and…
- [Medium] `yt922x_pcs_config()` (chip.c:5217) ignores `neg_mode`,
  `advertising` and `permit_pause_to_mac`.
- [Medium] The driver adds the OF compatible "motorcomm,yt9224" to
  `yt921x_of_match[]` (chip.c:5695) but no device-tree binding documents…
- [Low] The commit message states the YT922X series "includes YT9224 and
  YT9228", but only YT9224 is implemented: a single `yt921x_infos` entry…
- [Low] `NET_DSA_YT921X` keeps the prompt "Motorcomm YT9215 ethernet
  switch chip support" and YT9215-only help text while the same patch…
- [Low] `yt922x_chip_setup_dsa()` writes a hardcoded `GENMASK(9, 0)` (10
  port bits) to `YT922X_FILTER_UNK_UCAST` at chip.c:5440, while the two…
- [Low] `yt922x_pcs_config()` commits the new serdes mode to
  `YT922X_PORT_SDSn` (chip.c:~5262) and then runs the ~40-write…

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This adds a YT922x variant to the Motorcomm DSA driver: a new yt92xx_series
entry with its own dsa_switch_ops and phylink_mac_ops, a YT9224 chip info
entry, a large block of YT922x register definitions, and a per-port embedded
phylink PCS for the serdes ports. It also registers the motorcomm,yt9224 OF
compatible and selects the YT922x tagger.

A few questions on the commit message and the new code below.

>     Add support for Motorcomm YT922X, which is series of
>     ethernet switches developed by Motorcomm Electronic
>     Technology, includes YT9224 and YT9228.
>     
>     This patch adds basic support for a working DSA switch.

[Severity: Low]
Is YT9228 actually supported here?  Only YT9224 appears in the code: one
yt921x_infos entry for YT9224_MAJOR (0x9004), one motorcomm,yt9224
compatible, and yt92xx_series_lookup() matching only YT9224_MAJOR.  A grep
of the tree finds no YT9228 identifier, so a YT9228 would be rejected in
yt921x_chip_detect() with "Unexpected chipid" or by
yt92xx_series_lookup() returning NULL.

Could the second sentence also state what "basic" covers?
yt922x_dsa_switch_ops provides only get_tag_protocol, phylink_get_caps,
port_setup and setup, and yt922x_port_setup() sets YT922X_PORT_LEARN_DIS on
every port, so bridging, VLAN, FDB and statistics are not available.

> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
> index 79cdd79a1fd25..f690de4c7a7c5 100644
> --- a/drivers/net/dsa/motorcomm/Kconfig
> +++ b/drivers/net/dsa/motorcomm/Kconfig
> @@ -2,6 +2,7 @@
>  config NET_DSA_YT921X
>  	tristate "Motorcomm YT9215 ethernet switch chip support"
>  	select NET_DSA_TAG_YT921X
> +	select NET_DSA_TAG_YT922X
>  	select NET_IEEE8021Q_HELPERS if DCB
>  	help
>  	  This enables support for the Motorcomm YT9215 ethernet switch

[Severity: Low]
Should the prompt and help text mention YT922x too?  The same patch makes
this symbol bind motorcomm,yt9224, select NET_DSA_TAG_YT922X and set
MODULE_DESCRIPTION("Driver for Motorcomm YT921x and YT922x Switch"), but
the only user-visible description still says YT9215 only.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 3f56d60da8eab..d8218f9f93aa9 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -38,6 +38,9 @@ struct yt921x_mib_desc {
>  #define MIB_DESC(_size, _offset, _name) \
>  	{_size, _offset, _name}
>  
> +#define pcs_to_yt921x_port(_pcs) container_of((_pcs), struct yt921x_port, pcs)
> +#define yt921x_port_to_priv(pp) \
> +	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
>  /* Must agree with yt921x_mib

[Severity: Critical]
yt921x_port_to_priv() recovers priv by subtracting
offsetof(struct yt921x_priv, ports[pp->index]), so it is only correct when
pp->index equals the slot the yt921x_port actually occupies.

Where is pp->index assigned on the YT922x path?  The only assignment in the
driver is in yt921x_dsa_setup():

	pp->index = i;
	INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);

yt922x_dsa_setup() has no equivalent loop, and priv is zero-allocated, so
every priv->ports[i].index stays 0 on YT922x.

yt922x_pcs_setup() then installs pp->pcs.ops for each bit of
info->external_mask, which for YT9224 is BIT(0) | BIT(8), and
yt922x_phylink_mac_select_pcs() returns &priv->ports[dp->index].pcs.  So
phylink calls the PCS ops with pp == &priv->ports[8] while pp->index == 0,
and yt921x_port_to_priv() yields (char *)priv + 8 * sizeof(struct
yt921x_port) instead of priv.

Does that mean yt922x_pcs_get_state() runs
mutex_lock(&priv->reg_lock) on bytes that are really part of
priv->ports[] (MIB counters and a delayed_work), and then calls
priv->reg_ops->read() through a function pointer loaded from that same
memory?

A second effect of the uninitialised index: int port = pp->index is 0 for
port 8 in all three PCS callbacks, so the

	if (port != 0 && port != 8)
		return -EINVAL;

check in yt922x_pcs_config() passes with the wrong port and port 0's serdes
registers are programmed.

> @@ -112,6 +115,9 @@ struct yt921x_info {
>  #define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
>  #define YT921X_PORT_MASK_EXT0		BIT(8)
>  #define YT921X_PORT_MASK_EXT1		BIT(9)
> +#define YT922X_PORT_MASK_INTm_n(m, n)	GENMASK((n), (m))
> +#define YT922X_PORT_MASK_EXT0		BIT(0)
> +#define YT922X_PORT_MASK_EXT1		BIT(8)
>  
>  static const struct yt921x_info yt921x_infos[] = {
>  	{
> @@ -149,9 +155,17 @@ static const struct yt921x_info yt921x_infos[] = {
>  		YT921X_PORT_MASK_INT0_n(8),
>  		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
>  	},
> +	{
> +		"YT9224", YT9224_MAJOR, 0, 0,
> +		YT922X_PORT_MASK_INTm_n(4, 7),
> +		YT922X_PORT_MASK_EXT0 | YT922X_PORT_MASK_EXT1,
> +	},
>  	{}
>  };

[ ... ]

> @@ -4694,18 +4731,847 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

> +static int yt922x_sds_phyaddr_get(int port,
> +				  enum yt922x_phy_reg_type reg_type,
> +				  enum yt922x_phy_reg_space reg_space)
> +{
> +	int res = port;
> +
> +	/*
> +	 * sds phyaddr mapping depend on reg_type and reg_space
> +	 */
> +	if (!yt922x_port_is_internal_sds(port))
> +		return -EOPNOTSUPP;
> +	if (reg_type == YT922X_PHY_REG_TYPE_COMMON_EXT) {
> +		res = YT922X_COMMON_EXT_PHYADDR;
> +		return res;
> +	}
> +
> +	return res;
> +}

[Severity: High]
The comment says the mapping depends on reg_type and reg_space, but
reg_space is never read: for every reg_type other than
YT922X_PHY_REG_TYPE_COMMON_EXT the function returns port.  Do the SGMII and
USXGMII register spaces then alias to the same internal MDIO address?

The closing soft reset in yt922x_sds_init() looks like it becomes
self-cancelling:

	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
				      YT922X_PHY_REG_SPACE_SGMII);
	...
	data &= ~(1 << 15);
	res = yt921x_intif_write(priv, addr, 0x0, data);
	...
	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
				      YT922X_PHY_REG_SPACE_USXGMII);
	...
	data |= 1 << 15;
	res = yt921x_intif_write(priv, addr, 0x0, data);

Both lookups return the same addr, so bit 15 is cleared and then set on one
register and the USXGMII PCS is never touched.  The same aliasing makes
yt922x_pcs_get_state() read YT922X_PCS_LINK_CTRL/MII_LPA from the SGMII
address in the USXGMII case, and makes yt922x_pcs_an_restart() perform the
identical BMCR read-modify-write twice.

Two smaller points in the same area:

	if (addr < 0)
		return res;

res is 0 at both of these sites in yt922x_sds_init(), so a failed address
lookup reports success while silently skipping the soft reset.  Should
these return addr?

And yt922x_pcs_get_state() and yt922x_pcs_an_restart() pass addr straight
to yt921x_intif_read() without checking for the -EOPNOTSUPP that
yt922x_sds_phyaddr_get() returns for non-serdes ports.

[ ... ]

> +static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				 struct phylink_link_state *state)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	int port = pp->index;
> +	int res = 0;
> +	u16 data;
> +	int addr;
> +	u16 lp;
> +
> +	mutex_lock(&priv->reg_lock);
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		addr = yt922x_sds_phyaddr_get
> +			(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
> +			 YT922X_PHY_REG_SPACE_SGMII);
> +		res = yt921x_intif_read(priv, addr, MII_BMSR, &data);
> +		if (res)
> +			goto err;
> +		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
> +		if (res)
> +			goto err;
> +		phylink_mii_c22_pcs_decode_state(state, neg_mode, data, lp);
> +		break;

[Severity: Medium]
Can a 100BASE-X link ever be reported up through this path?
phylink_mii_c22_pcs_decode_state() in drivers/net/phy/phylink.c has cases
only for 1000BASE-X, 2500BASE-X, SGMII/PSGMII/QSGMII and QUSGMII:

	default:
		state->link = false;
		break;

100BASE-X is advertised as supported by yt922x_dsa_phylink_get_caps() and
yt922x_pcs_setup(), and yt922x_phylink_mac_select_pcs() returns this PCS
for it, so the mode looks reachable but always decodes as link down.

[ ... ]

> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	int res, port;
> +	u16 data;
> +	u16 ctrl;
> +	int addr;

[Severity: Medium]
neg_mode, advertising and permit_pause_to_mac appear only in the parameter
list; the body only rewrites the serdes mode field and runs
yt922x_sds_init().  Should this callback enable or disable in-band
negotiation according to neg_mode and program the local advertisement for
the Base-X modes?

As written, yt922x_pcs_get_state() hands neg_mode to
phylink_mii_c22_pcs_decode_state(), so the read path assumes a negotiation
setup that the write path never applied.

> +	port = pp->index;
> +	if (port != 0 && port != 8)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->reg_lock);
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		ctrl = YT92XX_SERDES_MODE_SGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_100BASEX:
> +		ctrl = YT92XX_SERDES_MODE_100BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		ctrl = YT92XX_SERDES_MODE_1000BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ctrl = YT92XX_SERDES_MODE_2500BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		ctrl = YT92XX_SERDES_MODE_USXGMII;
> +		break;
> +	default:
> +		res = -EINVAL;
> +		goto err;
> +	}
> +	addr = yt922x_sds_phyaddr_get
> +		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
> +		 YT922X_PHY_REG_SPACE_SGMII);
> +	if (addr < 0) {
> +		res = addr;
> +		goto err;
> +	}
> +
> +	res = yt921x_intif_ext_read(priv, addr, YT922X_PORT_SDSn, &data);
> +	if (res)
> +		goto err;
> +	data &= ~YT922X_SERDES_MODE_M;
> +	data |= ctrl;
> +	res = yt921x_intif_ext_write(priv, addr, YT922X_PORT_SDSn, data);
> +	if (res)
> +		goto err;
> +	/* SERDES init and interface configuration */
> +	res = yt922x_sds_init(priv, port, interface);
> +	if (res)
> +		goto err;
> +	mutex_unlock(&priv->reg_lock);

[Severity: Low]
The new mode is committed to YT922X_PORT_SDSn before the roughly forty
writes of yt922x_sds_init() run.  If one of those indirect MDIO
transactions fails, the error path only unlocks and returns, leaving the
new mode selected with a mix of old and new CDR/PLL/VCO/eye/CTLE settings
and no closing PCS reset.  Is a rollback wanted here, or is the intent to
rely on the next successful pcs_config?  The YT921x paths such as
yt921x_port_up() have the same shape today.

[ ... ]

> +static int yt922x_chip_setup_dsa(struct yt921x_priv *priv)
> +{
> +	unsigned long cpu_ports_mask;
> +	u32 ctrl;
> +	int port;
> +	int res;
> +
> +	/* cpu port set */
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_cpu_port_set(priv);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		return res;

[Severity: High]
Can this deadlock the probing thread?  yt922x_dsa_setup() already holds
priv->reg_lock across the call:

	mutex_lock(&priv->reg_lock);
	res = yt922x_chip_setup(priv);
	mutex_unlock(&priv->reg_lock);

and yt922x_chip_setup() calls yt922x_chip_setup_dsa() directly, so this
mutex_lock() re-acquires a mutex the same task already owns.  struct mutex
is not recursive, so this looks like it hangs on the first YT9224 probe
inside dsa_register_switch(), with lockdep reporting possible recursive
locking.

The register accesses further down in this function need the outer lock
anyway (yt921x_reg_read()/yt921x_reg_write() contain
lockdep_assert_held_once(&priv->reg_lock)), so removing this inner
lock/unlock pair rather than moving the outer one seems to be what is
wanted.

> +
> +	ctrl = GENMASK(9, 0);
> +	res = yt921x_reg_write(priv, YT922X_FILTER_UNK_UCAST, ctrl);
> +	if (res)
> +		return res;
> +
> +	ctrl = 0;
> +	for (int i = 0; i < priv->series->max_ports; i++)
> +		ctrl |= YT922X_ACT_UNK_ACTn_TRAP(i);

[Severity: Low]
The loops here size their masks with priv->series->max_ports, which is
YT922X_PORT_NUM == 9, but GENMASK(9, 0) covers ten port bits.  The YT921x
equivalent writes GENMASK(10, 0) with YT921X_PORT_NUM == 11, i.e. exactly
max_ports bits.  Is bit 9 intentional here, or should this be derived from
YT922X_PORT_NUM?

[ ... ]

> +static int yt922x_dsa_setup(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_chip_reset(priv);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		return res;
> +
> +	/* Register the internal mdio bus. */
> +	child = of_get_child_by_name(np, "mdio");
> +	if (child) {
> +		res = yt921x_mbus_int_init(priv, child);
> +		of_node_put(child);
> +		if (res)
> +			return res;
> +	}
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_chip_setup(priv);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		return res;
> +
> +	/* switch sds pcs setup */
> +	yt922x_pcs_setup(ds);
> +
> +	return 0;
> +}

[ ... ]

> @@ -4824,6 +5692,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  static const struct of_device_id yt921x_of_match[] = {
>  	{ .compatible = "motorcomm,yt9215", },
> +	{ .compatible = "motorcomm,yt9224", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, yt921x_of_match);

[Severity: Medium]
Is a binding update missing for this compatible?
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml still has:

  compatible:
    const: motorcomm,yt9215

so a DTS using motorcomm,yt9224 fails dtbs_check with "'motorcomm,yt9224'
is not one of ['motorcomm,yt9215']".

The same binding also describes the port map as internal GbE PHYs on Port
0-7 with the GMACs on Port 8-9, which does not match the new YT9224 entry
(internal_mask GENMASK(7, 4), external_mask BIT(0) | BIT(8),
YT922X_PORT_NUM 9).  Should the mdio/port description be extended for
YT922x as well?

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index c446aea449ed5..3a8ce801aabdc 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h

[ ... ]

> @@ -861,6 +863,102 @@ enum yt921x_fdb_entry_status {

[ ... ]

> +#define YT922X_PORT_SDSn	0x400
> +#define  YT922X_SERDES_MODE_M		GENMASK(6, 4)
> +#define   YT922X_SERDES_MODE(x)			FIELD_PREP(YT922X_SERDES_MODE_M, (x))
> +#define YT92XX_SERDES_MODE_SGMII	YT922X_SERDES_MODE(0)
> +#define YT92XX_SERDES_MODE_REVSGMII	YT921X_SERDES_MODE(1)
> +#define YT92XX_SERDES_MODE_1000BASEX	YT921X_SERDES_MODE(2)
> +#define YT92XX_SERDES_MODE_100BASEX	YT921X_SERDES_MODE(3)
> +#define YT92XX_SERDES_MODE_2500BASEX	YT921X_SERDES_MODE(4)
> +#define YT92XX_SERDES_MODE_USXGMII	YT922X_SERDES_MODE(6)

[Severity: High]
Should the four middle constants use YT922X_SERDES_MODE() rather than
YT921X_SERDES_MODE()?  YT921X_SERDES_MODE(x) is
FIELD_PREP(GENMASK(9, 7), x), while the YT922x field is GENMASK(6, 4).

yt922x_pcs_config() does:

	data &= ~YT922X_SERDES_MODE_M;
	data |= ctrl;

so for 100BASE-X, 1000BASE-X and 2500BASE-X the mode field in bits 6:4 is
cleared to 0, which is SGMII, and the value ends up in bits 9:7 of
YT922X_PORT_SDSn instead.  Only SGMII (value 0) and USXGMII use the YT922x
constructor.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914103009.3007019-1-kyle.switch%40motor-comm.com
