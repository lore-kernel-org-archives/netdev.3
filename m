Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6643F8AE;
	Thu, 17 Sep 2026 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678208; cv=none; b=AvnAvDwziFAtqNorBM3gmOb2s13KMeMg2ze3dCY9AI4EMW/6w1uwOvTM/5h75v7r9+El8bQm4bR0gdEbAQM3VD2wHdLQsaKKua5PZP+tTnevWQKgPXoEsAB0GB+y5HsV/ODM4+FPxuU5uZKEJs0sbMtOPfk8xbvUvGLD5YXokzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678208; c=relaxed/simple;
	bh=uc8JDM3qKolxO+LAFNsDubYVvMVlCYNV/6ya19CDU00=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5ql+xYgERj35KB/uxbIETEyVoa8WrYJpEN6bK9AbmaTv8LESYFVc2BN+x6zW9aOK8u/aZPIOtOTKP4R4u1KU+8R2QZax92246g14lfL2/SJn5D1QL9mtk/UCyLib9r5acNl2NHnQUV4CGtceS+D5SCFdte3B+LAoBUcXaK1jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqsiABRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqsiABRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303411F0089F;
	Thu, 17 Sep 2026 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678204;
	bh=TMEeyMI4B51uEPXzMPkveZiZhFcfdN65YEovR0F0x/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EqsiABRcUFWwl6qUwlZONnOtDJpcLG0GO9muY45cZg8EWw6zVy+f3qf0HVBSKrz0x
	 5f4XRDKooLygTs/ImLIpzK6cvAi5KOqtqYOyM7/65rF6VFNSKvweU9oACFgdUWuVGb
	 PPEKWdBMsQNKuTeEvBkP34fYLfyAWmEYb8ksZ6L2G7SKF+P7O4ZjsIUpHQMTWoFnlj
	 BVbUN8HSo2rJBQwjXN74xKxi9G7/WpK1adBfbhuiEw/9TV6Ie1ZDjjJEgzodpy3Fan
	 f3m2scap/WtZyWmqvtOhrmrcy0eSClZ54NSZYRATg6Ohr3feWteyvy6aaYM0P3wu6N
	 LpDUSGAFxo7+g==
Subject:
 Re: [PATCH v2 net-next 7/7] net: dsa: mediatek: support EN751221 switch
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 17 Sep 2026 20:50:02 +0000
Message-ID: <178967820271.22033.8178601854215098997@kernel.org>
In-Reply-To: <20260915174643.253660-8-cjd@cjdns.fr>
References: <20260915174643.253660-8-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 14 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 10 · Low: 3

- [High] This patch makes the core_write()/core_rmw() MMD indirect-access
  path reachable for an MMIO-attached switch (ID_EN751221 gets…
- [Medium] en751221_trgmii_pair_setup() passes the wrong default_taps
  array to each en751221_trgmii_calibrate_direction() call.
- [Medium] On the EN751221 on-die switch the TRGMII cascade is port 5,
  but mt7530_mac_config() dispatches port 5 to mt7530_setup_port5()…
- [Medium] The MDIO of_match table now claims the compatible string
  "econet,en751221" for the multi-chip-module MT7530, but that exact…
- [Medium] mt7530_setup_irq() writes TOP_SIG_CTRL_NORMAL ("This register
  must be set for MT7530 to properly fire interrupts") only for…
- [Medium] en751221_trgmii_pair_setup() overwrites MT753X_PMCR_P() with
  hardcoded full-register values (mcr_down, then mcr_up) on both the…
- [Medium] The new TRGMII reset and training sequence ignores every
  regmap return value, including accesses to the external switch which…
- [Medium] en751221_trgmii_pair_setup() reaches into a different DSA
  switch instance (the on-die switch's mt7530_priv, obtained from the…
- [Medium] Connecting the MCM switch through the on-die switch's MDIO
  child bus nests two mt7530_priv::reg_mutex instances of the same lock…
- [Medium] For the on-die switch (ID_EN751221) the only place the TRGMII
  transmit clock/DDS is programmed is mt7530_setup_port6(), reached from…
- [Medium] net: dsa: mt7530: immediate PMSR read may cause spurious
  calibration failure
- [Low] The patch adds register/field definitions that no code uses
  (TOP_SIG_CTRL_B0 with comment "Undocumented", and PMCR_IFG_XMIT_96 /…
- [Low] The in-tree binding text for the EN751221 on-die switch says "3x
  10/100 PHYs and 1x gigabit PHY", while the new…
- [Low] For `econet,en751221-switch` the binding applies the generic
  `builtin-dsa-port` definition, which only constrains ports carrying…

--

net: dsa: mediatek: support EN751221 switch

This adds two new mt753x IDs for the EcoNet EN751221: the on-die MT7530
(memory mapped) and an optional second MT7530 attached as an MCM module over
MDIO.  It also adds a TRGMII RX tap calibration routine that is run over the
inter-switch link when it comes up.

> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index 24ef54f3db2a6..2fd987ff85107 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -139,6 +139,7 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
>  }
>  
>  static const struct of_device_id mt7530_of_match[] = {
> +	{ .compatible = "econet,en751221", .data = &mt753x_table[ID_EN751221_EXT], },

[Severity: Medium]
Is it intentional to reuse the SoC root node compatible string for the MCM
switch?  "econet,en751221" is already defined as the root node compatible:

Documentation/devicetree/bindings/mips/econet.yaml
  $nodename:
    const: '/'

  compatible:
    oneOf:
      - description: Boards with EcoNet EN751221 family SoC
        items:
          - enum:
              - smartfiber,xp8421-b
          - const: econet,en751221

and arch/mips/boot/dts/econet/en751221.dtsi already uses it there:

  / {
        compatible = "econet,en751221";

With the same string also declared in mediatek,mt7530.yaml as "Multi-chip
module MT7530 in EN751221 SoC", one string now names two different device
classes.

Since dt-schema derives select from the compatible const/enum values, won't
both schemas now select on it, so the switch node gets validated against
mips/econet.yaml (failing $nodename and the two item compatible list) and
every EN751221 board root node gets validated against mediatek,mt7530.yaml?

Every other MCM/on-die variant in these tables uses a device specific
string.  Would something like econet,en751221-mcm-switch work here, in both
the driver and the binding?

> 	{ .compatible = "mediatek,mt7621", .data = &mt753x_table[ID_MT7621], },
>  	{ .compatible = "mediatek,mt7530", .data = &mt753x_table[ID_MT7530], },
>  	{ .compatible = "mediatek,mt7531", .data = &mt753x_table[ID_MT7531], },
> diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
> index f387190a95391..b77e3cb655aa9 100644
> --- a/drivers/net/dsa/mt7530-mmio.c
> +++ b/drivers/net/dsa/mt7530-mmio.c
> @@ -12,6 +12,7 @@
>  static const struct of_device_id mt7988_of_match[] = {
>  	{ .compatible = "airoha,an7583-switch", .data = &mt753x_table[ID_AN7583], },
>  	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
> +	{ .compatible = "econet,en751221-switch", .data = &mt753x_table[ID_EN751221], },

[Severity: Low]
For this compatible the binding applies $defs/builtin-dsa-port, which only
constrains ports that carry ethernet:

  builtin-dsa-port:
    patternProperties:
      "^(ethernet-)?ports$":
        patternProperties:
          "^(ethernet-)?port@[0-6]$":
            if:
              required: [ ethernet ]
            then:
              properties:
                phy-mode:
                  const: internal

Ports carrying link are left unconstrained, while en751221_mac_port_get_caps()
advertises PHY_INTERFACE_MODE_TRGMII on port 5 only and INTERNAL everywhere
else.

Doesn't that let a DSA link on a port other than 5, a link on port 5 with a
non-trgmii phy-mode, or a CPU port at reg = 5 with phy-mode = internal pass
dt_binding_check and then get rejected by phylink at runtime?

The sibling $defs/mt7530-passthrough-dsa-port used for the MCM side does
constrain its link port to reg 6 and phy-mode trgmii - should the built-in
side get an equivalent constraint?

>  	{ .compatible = "econet,en7528-switch", .data = &mt753x_table[ID_EN7528], },
>  	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
>  	{ /* sentinel */ }
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index fe93be1ece7d7..4f43454083b95 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -49,6 +49,9 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
>  static int
>  mt753x_ctrl_phy_addr(struct mt7530_priv *priv)
>  {
> +	if (priv->id == ID_EN751221)
> +		return 12;
> +

[Severity: Low]
This isn't a bug, but could the bare 12 get a comment or a #define?  Every
other ID derives the control PHY address from the MDIO device address, and
all core_write()/core_rmw() PLL programming for the on-die switch depends on
this value, yet the commit message doesn't mention it.

In the same spirit, en751221_trgmii_pair_setup() programs hardware with raw
literals rather than the register names this header otherwise uses:

	/* SOC: Undocumented */
	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++)
		regmap_write(ondie->regmap,  (0x7a14 + channel * 8),
			     0x3227700);

That address range overlaps the MT7530_TRGMII_RD() block - can it be
expressed with a named macro?

Finally, TOP_SIG_CTRL_B0, PMCR_IFG_XMIT_96 and PMCR_IFG_XMIT_RAND are added
but never referenced anywhere in the tree (only PMCR_IFG_XMIT_64 is used).
Was a register write hunk dropped when the patch was prepared?

>  	if (WARN_ON_ONCE(!priv->mdiodev))
>  		return 0;
>  
> @@ -344,12 +347,19 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
>  	regmap_read(priv->regmap, MT753X_MTRAP, &xtal);
>  	xtal &= MT7530_XTAL_MASK;
>  
> +	/* EN751221 on-die does not report clock speed in MTRAP */
> +	if (priv->id == ID_EN751221)
> +		xtal = MT7530_XTAL_25MHZ;
> +
>  	if (xtal == MT7530_XTAL_25MHZ)
>  		ssc_delta = 0x57;
>  	else
>  		ssc_delta = 0x87;
>  
> -	if (priv->id == ID_MT7621) {
> +	if (priv->id == ID_EN751221_EXT || priv->id == ID_EN751221) {
> +		/* PLL frequency: 362.5Mhz */
> +		ncpo1 = 0x1d00;

[Severity: Medium]
For the on-die switch, is this the only place the TRGMII clock and DDS get
programmed, and is it ordered against the tap calibration?

mt753x_phylink_mac_config() calls mac_port_config only for ports 5 and 6, and
mt7530_mac_config() sends port 6 here.  mt7530_setup_port6() starts with:

	/* Disable the MT7530 TRGMII clocks */
	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);

and then rewrites CORE_PLL_GROUP2/4/5/6/7/10/11 for any interface that is not
PHY_INTERFACE_MODE_RGMII, including the INTERNAL CPU link that
en751221_mac_port_get_caps() declares for port 6.

The calibration itself is triggered from the other switch's mac_link_up, and
each dsa_port has its own phylink instance and resolve work, so the two are
unordered.  Can a later port 6 mac_config (conduit down/up, resume,
renegotiation) gate the clock off and relock the DDS underneath an already
calibrated live link?  A fixed DSA link gets no further mac_link_up, so is
there anything that re-runs the calibration afterwards?

>  	} else if (priv->id == ID_MT7621) {
>  		/* PLL frequency: 125MHz: 1.0GBit */
>  		if (xtal == MT7530_XTAL_40MHZ)
>  			ncpo1 = 0x0640;
> @@ -466,6 +476,251 @@ mt7531_pll_setup(struct mt7530_priv *priv)
>  	usleep_range(25, 35);
>  }
>  
> +static bool
> +en751221_trgmii_cal_ok(struct mt7530_priv *rx, u32 reg)
> +{
> +	u32 val = 0;
> +
> +	regmap_read(rx->regmap, reg, &val);
> +	regmap_write(rx->regmap, reg, val | EDGE_CHK);
> +	regmap_write(rx->regmap, reg, val & ~EDGE_CHK);
> +	regmap_read(rx->regmap, reg, &val);

[Severity: Medium]
What happens here if the first regmap_read() fails?  For the MCM switch these
accesses go over MDIO (mt7530_regmap_read()/mt7530_regmap_write() in
mt7530-mdio.c), where transactions can genuinely fail.

val stays 0 and the two writes are full register writes, so the whole
MT7530_TRGMII_RD(x) register for that lane is zeroed - clearing BSLIP_EN and
RD_TAP - and the pass/fail verdict is computed from a value that never came
from hardware.

The rest of the sequence has the same property: a failed TX_RST/RX_RST
deassert can leave a block in reset, a failed final

	regmap_clear_bits(tx->regmap, MT7530_TRGMII_TXCTRL, TRAIN_TXEN);

can leave the transmitter emitting training patterns, and a failed saved-tap
read yields a fallback tap of 0, yet en751221_trgmii_pair_setup() still ends
with an unconditional "TRGMII inter-switch link initialized".  Should these
return values be checked and propagated?

> +
> +	return FIELD_GET(RD_VALUE_MASK, val) == TGMII_TD_PAT &&
> +	       !FIELD_GET(RD_ERR_MASK, val);
> +}
> +
> +static void
> +en751221_trgmii_calibrate_direction(struct mt7530_priv *tx,
> +				    struct mt7530_priv *rx,
> +				    u8 *default_taps)
> +{

[ ... ]

> +		if (best_tap > -1) {
> +			regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
> +					   RD_TAP(best_tap));
> +
> +			log[best_tap] = 'X';
> +
> +			dev_info(rx->dev,
> +				 "TRGMII lane %d: %s tap %d old %d\n",
> +				 channel, log, best_tap, default_taps[channel]);
> +		} else {
> +			regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
> +					   RD_TAP(default_taps[channel]));
> +
> +			dev_warn(rx->dev,
> +				 "TRGMII lane %d: %s calibration failed, preserving tap %u\n",
> +				 channel, log, default_taps[channel]);
> +		}

[ ... ]

> +static void
> +en751221_set_tx_drive(struct mt7530_priv *priv, u8 drvp, u8 drvn, u8 clk_drvp,
> +		      u8 clk_drvn)
> +{

[ ... ]

> +static void
> +en751221_trgmii_pair_setup(struct mt7530_priv *ext, int ext_port,
> +			   struct mt7530_priv *ondie, int ondie_port)
> +{
> +	u8 default_taps_ondie[NUM_TRGMII_CTRL];
> +	u8 default_taps_ext[NUM_TRGMII_CTRL];
> +	u32 mcr_down, mcr_up;
> +	int channel;
> +	int reg_val;
> +
> +	/* BOTH: Put interfaces in a downed state */
> +	mcr_down = PMCR_IFG_XMIT(PMCR_IFG_XMIT_64) | PMCR_MAC_MODE |
> +		   MT7530_FORCE_MODE | PMCR_MAC_RX_EN | PMCR_BACKOFF_EN |
> +		   PMCR_BACKPR_EN | PMCR_FORCE_SPEED_1000 | PMCR_FORCE_FDX;
> +	regmap_write(ondie->regmap,  MT753X_PMCR_P(ondie_port), mcr_down);
> +	regmap_write(ext->regmap, MT753X_PMCR_P(ext_port), mcr_down);
> +	usleep_range(5000, 6000);
> +

[ ... ]

> +	/* BOTH: Ports up */
> +	mcr_up = mcr_down | PMCR_MAC_TX_EN | PMCR_FORCE_LNK;
> +	regmap_write(ondie->regmap, MT753X_PMCR_P(ondie_port), mcr_up);
> +	regmap_write(ext->regmap, MT753X_PMCR_P(ext_port), mcr_up);

[Severity: Medium]
These are full register writes rather than regmap_update_bits(), and this
function runs from the tail of mt753x_phylink_mac_link_up().  Does that
discard the PMCR bits phylink just programmed?

mt753x_phylink_mac_link_up() builds:

	if (duplex == DUPLEX_FULL) {
		mcr |= PMCR_FORCE_FDX;
		if (tx_pause)
			mcr |= PMCR_FORCE_TX_FC_EN;
		if (rx_pause)
			mcr |= PMCR_FORCE_RX_FC_EN;
	}

	regmap_set_bits(priv->regmap, MT753X_PMCR_P(dp->index), mcr);

and then calls into here, where mcr_down/mcr_up contain no flow control bits,
no PMCR_FORCE_EEE1G/PMCR_FORCE_EEE100 and no PMCR_EXT_PHY.  Nothing appears
to re-apply them afterwards, and the peer switch's port is force programmed
behind its own phylink instance's back.  Should this use regmap_update_bits()
with an explicit mask, or re-apply the phylink derived value?

> +
> +	/* MCM: Set Ext->SoC TX delay to 0 */
> +	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++)
> +		regmap_clear_bits(ext->regmap, EN7530_TRGMII_TD_CTRL(channel),
> +				  TGMII_TD_TAP_MASK);
> +

[ ... ]

> +	/* BOTH: Collect and then zero every RX TAP */
> +	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++) {
> +		reg_val = 0;
> +		regmap_read(ext->regmap, MT7530_TRGMII_RD(channel), &reg_val);
> +		default_taps_ext[channel] = FIELD_GET(RD_TAP_MASK, reg_val);
> +		regmap_clear_bits(ext->regmap, MT7530_TRGMII_RD(channel),
> +				  RD_TAP_MASK);
> +
> +		reg_val = 0;
> +		regmap_read(ondie->regmap, MT7530_TRGMII_RD(channel), &reg_val);
> +		default_taps_ondie[channel] = FIELD_GET(RD_TAP_MASK, reg_val);
> +		regmap_clear_bits(ondie->regmap, MT7530_TRGMII_RD(channel),
> +				  RD_TAP_MASK);
> +	}
> +
> +	en751221_trgmii_calibrate_direction(ondie, ext, default_taps_ondie);
> +	en751221_trgmii_calibrate_direction(ext, ondie, default_taps_ext);

[Severity: Medium]
Are the two default_taps arrays swapped here?

The loop above stores each switch's own saved taps into its own array:
default_taps_ext[] comes from ext->regmap, default_taps_ondie[] from
ondie->regmap.

In the calls, the second argument is rx:

  en751221_trgmii_calibrate_direction(ondie, ext, default_taps_ondie);
      rx = ext, taps = ondie's
  en751221_trgmii_calibrate_direction(ext, ondie, default_taps_ext);
      rx = ondie, taps = ext's

and the callee only ever writes the array into rx:

	regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
			   RD_TAP(default_taps[channel]));

So when a lane finds no passing tap, doesn't the receiver's RD_TAP get
programmed with the peer chip's saved value, and doesn't the dev_warn() report
a tap that was never in that register?  The values are not the same on both
sides - mt7530_setup() programs RD_TAP(16) on the MDIO attached switch while
the on-die switch keeps its reset/bootloader value.

> +
> +	dev_info(ondie->dev, "TRGMII inter-switch link initialized\n");
> +}
> +
> +static void
> +mt7530_cal_interswitch_trgmii(struct dsa_port *dp)
> +{

[ ... ]

> +		peer = peer_ds->priv;
> +
> +		if (peer->id != ID_EN751221)
> +			continue;
> +
> +		en751221_trgmii_pair_setup(priv, dp->index, peer,
> +					   peer_dp->index);

[Severity: Medium]
What serializes this against the peer switch's own driver paths?

en751221_trgmii_pair_setup() performs a long sleeping sequence on the peer
instance - full PMCR overwrites, TX/RX resets, drive strength changes,
RCK/RTT and per-lane RD_TAP read-modify-writes, plus core PLL access - but
neither ondie->reg_mutex nor rtnl is held.  It runs from the ext switch's
phylink resolve worker, which holds only that phylink instance's state_mutex.

Meanwhile the on-die switch has its own per-port phylink workers, which can
run concurrently:

mt753x_phylink_mac_link_down()
    regmap_clear_bits(priv->regmap, MT753X_PMCR_P(dp->index), mcr);

mt7530_mac_config() -> mt7530_setup_port6()
    core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);

Can a concurrent link event on the on-die switch clobber the PMCR bits this
sequence is writing, or gate the TRGMII clock off in the middle of the tap
sweep so every lane "fails" and falls back to the default tap?

> +	}
> +}
> +
>  static void
>  mt7530_mib_reset(struct dsa_switch *ds)
>  {
> @@ -1408,7 +1663,8 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
>  
>  	mutex_unlock(&priv->reg_mutex);
>  
> -	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
> +	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
> +	    priv->id != ID_EN751221 && priv->id != ID_EN751221_EXT)
>  		return 0;

[Severity: Medium]
Does the new MCM-behind-on-die topology nest two reg_mutex instances of the
same lock class?

mt7530_port_enable() takes mutex_lock(&priv->reg_mutex) and issues regmap
accesses while holding it.  For the MCM switch those accesses go through the
on-die switch's MDIO child bus, whose read/write ops are the on-die
info->phy_read_c22/phy_write_c22, i.e. mt7531_ind_c22_phy_read() and
mt7531_ind_c22_phy_write(), and those take mutex_lock(&priv->reg_mutex) on the
on-die priv.

Both mutexes are initialised at the same mutex_init(&priv->reg_mutex) site in
mt7530_probe_common(), so they share one lock class and both acquisitions use
the default subclass.  Won't lockdep report possible recursive locking on
every boot of a board with the MCM present, and disable further validation for
the rest of the boot?  Would a mutex_lock_nested() annotation or separate lock
classes be appropriate?

>  
>  	if (port == 5)
> @@ -2980,6 +3243,44 @@ static void en7528_mac_port_get_caps(struct dsa_switch *ds, int port,
>  	}
>  }
>  
> +static void en751221_mac_port_get_caps(struct dsa_switch *ds, int port,
> +				       struct phylink_config *config)
> +{
> +	switch (port) {
> +	/* EN751221 ports 0..3 are connected to the integrated FE PHYs. */
> +	case 0 ... 3:

[Severity: Low]
This advertises four 10/100 ports and the commit message says "4 FE ports and
1 GE port", but the binding text added by the preceding series patch says:

  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
  gigabit PHY.

That binding patch's own changelog says "ports 0..3 are 10/100 only", so is
the description text in
Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml the part that
needs fixing?  As it stands a DT author cannot tell whether port@3 is valid.

> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +
> +		config->mac_capabilities |= MAC_10 | MAC_100;
> +		break;
> +
> +	/* Port 4 is connected to the standalone EN7512/EN7521 GPHY. */
> +	case 4:
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +
> +		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
> +		break;
> +
> +	/* Port 5 is the 1 Gbit/s TRGMII cascade to the external MT7530. */
> +	case 5:
> +		__set_bit(PHY_INTERFACE_MODE_TRGMII,
> +			  config->supported_interfaces);

[Severity: Medium]
Port 5 is declared TRGMII here and port 6 INTERNAL, but mt7530_mac_config()
dispatches by fixed port number:

	if (port == 5)
		mt7530_setup_port5(priv->ds, interface);
	else if (port == 6)
		mt7530_setup_port6(priv->ds, interface);

mt7530_setup_port5() contains no TRGMII or PLL handling, only MTRAP muxing and
RGMII pad/delay programming, and mt7530_setup_port6() only returns early for
PHY_INTERFACE_MODE_RGMII.

So for this variant, doesn't the INTERNAL CPU link on port 6 fall into the
TRGMII branch - setting MT7530_P6ECR to P6_INTF_MODE(1) and reprogramming the
DDS with the new xtal override and ncpo1 = 0x1d00 - while the port that
actually reports TRGMII never reaches any TRGMII specific setup?  If the
fallthrough is what the hardware wants, could that be spelled out in a
comment?

> +
> +		config->mac_capabilities |= MAC_1000FD;
> +		break;
> +
> +	/* Port 6 is the 1 Gbit/s CPU link to GDM1. */
> +	case 6:
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +
> +		config->mac_capabilities |= MAC_1000FD;
> +		break;
> +	}
> +}
> +
>  static void
>  mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
>  		  phy_interface_t interface)
> @@ -3129,6 +3430,9 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
>  	}
>  
>  	regmap_set_bits(priv->regmap, MT753X_PMCR_P(dp->index), mcr);
> +
> +	if (interface == PHY_INTERFACE_MODE_TRGMII)
> +		mt7530_cal_interswitch_trgmii(dp);
>  }
>  
> @@ -3670,6 +3975,28 @@ const struct mt753x_info mt753x_table[] = {
>  		.phy_write_c45 = mt7531_ind_c45_phy_write,
>  		.mac_port_get_caps = en7528_mac_port_get_caps,
>  	},
> +	[ID_EN751221] = {
> +		.id = ID_EN751221,
> +		.pcs_ops = &mt7530_pcs_ops,
> +		.sw_setup = mt7988_setup,
> +		.phy_read_c22 = mt7531_ind_c22_phy_read,
> +		.phy_write_c22 = mt7531_ind_c22_phy_write,
> +		.phy_read_c45 = mt7531_ind_c45_phy_read,
> +		.phy_write_c45 = mt7531_ind_c45_phy_write,
> +		.mac_port_get_caps = en751221_mac_port_get_caps,
> +		.mac_port_config = mt7530_mac_config,

[Severity: Medium]
Is this PMSR read guaranteed to observe the link state that was
just forced a few instructions earlier?

mt753x_phylink_mac_link_up() does

	regmap_set_bits(priv->regmap, MT753X_PMCR_P(dp->index), mcr);

with mcr containing PMCR_FORCE_LNK, and then calls straight into
mt7530_cal_interswitch_trgmii(), which reads MT7530_PMSR_P(dp->index)
and bails out unless PMSR_LINK is set. There is no delay and no
regmap_read_poll_timeout() between the write and the read, so if the
MAC needs any propagation time before the forced link shows up in the
status register, the check fails and the whole calibration is skipped
silently - no message is emitted on this path, unlike the dev_info()
at the end of en751221_trgmii_pair_setup().

Since this is a fixed DSA link that gets no further mac_link_up, a
single early read would leave the inter-switch TRGMII running on
whatever taps the bootloader left behind for the rest of the boot,
which is exactly the failure mode this patch is meant to avoid.

What does the hardware actually guarantee here? If PMSR is expected to
reflect the forced link immediately, could that be stated in a comment?
Otherwise, would a regmap_read_poll_timeout() on PMSR_LINK (with a
dev_warn() on timeout so the skip is visible) be more robust? And is
the PMSR check even needed - the caller is already in mac_link_up for
a TRGMII interface, so what additional condition is it trying to
rule out?

[Severity: High]
This is the first memory mapped ID to set .mac_port_config, which makes the
indirect MMD core access path reachable for a switch where priv->bus is NULL:

mt753x_phylink_mac_config() -> mt7530_mac_config() -> mt7530_setup_port6()
    -> core_clear()/core_write()/core_set() -> core_rmw()

Is the MDIO bus lock held on that path?  mt7530_mutex_lock() is:

	if (priv->bus)
		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);

and for an MMIO probed switch priv->bus is NULL, so it is a no-op, while
core_rmw() falls back to the child bus:

	struct mii_bus *bus = priv->bus;
	...
	if (!bus)
		bus = priv->child_bus;
	...
	ret = bus->write(bus, ctl_phy, MII_MMD_CTRL, MDIO_MMD_VEND2);

The four transaction "select MMD devad, select MMD register, select function,
read/write data" sequence is then issued on priv->child_bus without holding
child_bus->mdio_lock, which every other user of that bus takes - phylib via
mdiobus_read()/mdiobus_write(), and the MCM MT7530's regmap, whose lock is
bus->mdio_lock.

Can a concurrent transaction on that child bus interleave inside the MMD
select/data sequence, so a core PLL value lands in whatever register the other
user selected, or the read-modify-write picks up a foreign value?

> +	},
> +	[ID_EN751221_EXT] = {
> +		.id = ID_EN751221_EXT,
> +		.pcs_ops = &mt7530_pcs_ops,
> +		.sw_setup = mt7530_setup,
> +		.phy_read_c22 = mt7530_phy_read_c22,
> +		.phy_write_c22 = mt7530_phy_write_c22,
> +		.phy_read_c45 = mt7530_phy_read_c45,
> +		.phy_write_c45 = mt7530_phy_write_c45,
> +		.mac_port_get_caps = mt7530_mac_port_get_caps,
> +		.mac_port_config = mt7530_mac_config,
> +	},
>  };
>  EXPORT_SYMBOL_GPL(mt753x_table);
>  
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index c86bc4bca29b9..1a4329749c0f1 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -356,6 +358,9 @@ enum mt7530_vlan_port_acc_frm {
>  #define MT753X_PMCR_P(x)		(0x3000 + ((x) * 0x100))
>  #define  PMCR_IFG_XMIT_MASK		GENMASK(19, 18)
>  #define  PMCR_IFG_XMIT(x)		FIELD_PREP(PMCR_IFG_XMIT_MASK, x)
> +#define    PMCR_IFG_XMIT_96		0
> +#define    PMCR_IFG_XMIT_RAND		1
> +#define    PMCR_IFG_XMIT_64		2
>  #define  PMCR_EXT_PHY			BIT(17)
>  #define  PMCR_MAC_MODE			BIT(16)
>  #define  MT7530_FORCE_MODE		BIT(15)
> @@ -601,6 +607,8 @@ enum mt7531_xtal_fsel {
>  /* Register for TOP signal control */
>  #define MT7530_TOP_SIG_CTRL		0x7808
>  #define  TOP_SIG_CTRL_NORMAL		(BIT(17) | BIT(16))
> +/* Undocumented */
> +#define  TOP_SIG_CTRL_B0		BIT(0)

[Severity: Medium]
This new bit has no user, and the .c side of the same register was not
touched.  Should ID_EN751221_EXT be added to the condition in
mt7530_setup_irq()?

	/* This register must be set for MT7530 to properly fire interrupts */
	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
		regmap_set_bits(priv->regmap, MT7530_TOP_SIG_CTRL,
				TOP_SIG_CTRL_NORMAL);

ID_EN751221_EXT is an MT7530 die probed through the MDIO driver and uses
mt7530_setup(), and this patch extends three other "ID_MT7530 || ID_MT7621"
predicates (mt7530_port_enable, mt7530_port_disable,
mt753x_conduit_state_change) with the new IDs but not this one.

If the MCM switch node declares interrupt-controller, the irq chip and domain
are registered while the register that enables interrupt generation is never
set - would that leave PHY/link interrupts undelivered?

>  
>  #define MT7531_TOP_SIG_SR		0x780c
>  #define  PAD_DUAL_SGMII_EN		BIT(1)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915174643.253660-1-cjd%40cjdns.fr
