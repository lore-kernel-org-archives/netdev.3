Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239370;
	b=gxMsC3rxEIiulXnRS+Y07a5Y7g5gup2L6oQ3XueEWDhrVNMobmELE1drPF8GdB5y5NnZ
	 0qEqiAAhtO/xUXk2qTtVbs2db2AFdxrmEub9i3rq7TKmVkEGgMnDORYeZ6d1oVkGVCwJG
	 mHJ64oF5b47dZYdZByEJkMtnGe5vPTrGeY9iTmj/evSG2in0SuwKpPvnV/BnwM+285Z7H
	 QJ2zFWN+MLbCUPCrTehpes+z3Y9+aBNAcH6cNcHeHbUVZ4OWEw1O1Te21PKQTTI0q+8Zs
	 e9ELTrHogVoX9R3mdte85k+dMsLnyzSOFbsJfz99L0V99Ih2CXS/lEQ0P8AaL4A1cbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239370;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tmgA/zzSqwAj+KhU/5eMn9wiP0QhHj5jnCg6dxwSyVA=;
	b=b8qBstzm0N19d2meOHnsjtBelmUhBjfUlmqwDt9Qrsb8WcFF7mHNAZHbCFz7xmLiIbLE
	 c53A8MT0N53Y1gcsXox9TMoCqsydDq6H110dZl+IzTH4iTa+5chVc93wavhSWLefV2duA
	 362OYoFTo7R+ADfNgMU2EMKKTfdxYtCUYIktezi3kVetiOYMPZDQ9YmZ+TkEi3hlQ7VHx
	 b0Z8IwK+Nix2kZVIxowcRckc4C2BgYN7GguNDT77VLtmM/ZFG0Q2cSeDUd3KiVjxmWE1o
	 YYBS9U2yNiVPR8jpu3vkYs4EG4G1wbj+1GOa/sPVLhyq1Xk8ObZnwe2sySfjuYZWWIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cejqZiFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76260A2613;
	Thu, 29 Oct 2026 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cejqZiFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1D91F031E3;
	Thu, 29 Oct 2026 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239369;
	bh=tmgA/zzSqwAj+KhU/5eMn9wiP0QhHj5jnCg6dxwSyVA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cejqZiFgygriIirPsdJjVvLSyLwEDdw4EYWqjzH/AYjTi32L1hUXPR9gIV1mBjNZD
	 GNITtlR3Il1IAzpkXlRnA1acrLwPXhHHbPdghrrYapFmC1WtKCSoh2f7vWol7zWzL+
	 Uu4e9roWHy6B/Lbuzbo5PRHzMHzGWP/c87Qy4mpPEgJdgc98sOLEd/68Ph5W3cQ36/
	 0buUA3OExNfGkGiMeMre7pI/PZBjOGkuOfxSd45UqViYym9iDvoSHVMxNUGCZsyjLM
	 E4cQYJ1bKzPqiVz/naeHvCnD7pMkcw7lgCE6SS3k1hacjYGLafGosglz47LQ/3XDwa
	 C2E40XQRuC16g==
Subject: Re: [PATCH v3 7/7] net: dsa: mediatek: support EN751221 switch
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
Date: Thu, 29 Oct 2026 02:02:47 +0000
Message-ID: <179323936770.3134.5820916344803363362@kernel.org>
In-Reply-To: <20261028011317.1557238-8-cjd@cjdns.fr>
References: <20261028011317.1557238-8-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The MCM (external) MT7530 is matched in mt7530-mdio.c with
  compatible "econet,en751221" (ID_EN751221_EXT).
- [High] net: dsa: mt7530: missing MT7530_CHG_TRAP when modifying
  MT753X_MTRAP on ID_EN751221
- [Medium] mt7530_setup_irq() still sets TOP_SIG_CTRL_NORMAL only for
  ID_MT7530/ID_MT7621.
- [Medium] en751221_trgmii_pair_setup() passes each switch's saved RX
  taps to the calibration of the other switch's receiver.
- [Medium] mt753x_phylink_mac_link_up() sets the resolved bits (including
  PMCR_FORCE_TX_FC_EN / PMCR_FORCE_RX_FC_EN when tx_pause/rx_pause are…
- [Medium] This commit makes core_write()/core_rmw() reachable on the
  MMIO on-die EN751221 switch.
- [Medium] This patch enables the topology described in commit "net: dsa:
  mediatek: support MDIO switch downstream of MMIO switch": an MDIO…
- [Low] The patch adds `TOP_SIG_CTRL_B0` (commented 'Undocumented') to
  mt7530.h, but nothing in drivers/net/dsa/ uses it.
- [Low] Concern: on the on-die EN751221 the TRGMII cascade is port 5, but
  the TRGMII PLL/clock is programmed only from port 6's mac_config…
- [Low] The binding description (from commit "dt-bindings: net: dsa:
  mediatek,mt7530: add econet,en751221" in this series) says "EcoNet…
- [Low] en751221_trgmii_pair_setup() runs from the MCM's port-6 phylink
  resolve work.
- [Low] en751221_trgmii_cal_ok() reads the RD register, writes
  val|EDGE_CHK, immediately writes val&~EDGE_CHK, and only then reads…
- [Low] Concern: in en751221_trgmii_pair_setup(), RX_RST has no explicit
  hold time (unlike TX_RST's usleep_range(5000, 6000)), so the pulse…

--

net: dsa: mediatek: support EN751221 switch

This adds support for two switches. The first is the EcoNet EN751221
on-die MT7530 (MMIO). The second is the optional MCM MT7530 (MDIO), which
sits on the on-die switch's child MDIO bus. It also adds a calibration
routine for the TRGMII link between port 5 of the on-die switch and port 6
of the MCM switch, which mt753x_phylink_mac_link_up() triggers.

> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index 0be107dc6759a..03ef6a9f2084e 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -139,6 +139,7 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
>  }
>  
>  static const struct of_device_id mt7530_of_match[] = {
> +	{ .compatible = "econet,en751221", .data = &mt753x_table[ID_EN751221_EXT], },

[Severity: High]
Should this compatible be "econet,en751221-gswitch"?

The binding patch earlier in this series ("dt-bindings: net: dsa:
mediatek,mt7530: add econet,en751221") documents the MCM switch as:

    const: econet,en751221-gswitch

It also attaches mt7530-passthrough-dsa-port and the required
mediatek,mcm property to that string. "econet,en751221" is already the SoC
root compatible in arch/mips/boot/dts/econet/en751221.dtsi and in
Documentation/devicetree/bindings/mips/econet.yaml.

With a DT that follows the binding, the MCM switch never binds. The
on-die switch's port 5 has a link to the MCM, so the DSA tree never
completes. Neither switch is set up, and mt7530_cal_interswitch_trgmii()
never runs.

A DT that uses the driver's string instead puts the SoC top-level
compatible on a switch node, which fails dtbs_check.

The on-die side uses "econet,en751221-switch" in both mt7530-mmio.c and
the peer check in mt7530_cal_interswitch_trgmii().

[Severity: Medium]
With an MDIO MT7530 on the child MDIO bus of the MMIO on-die switch, can
lockdep report recursive locking on reg_mutex?

On the MCM, register accesses made under reg_mutex also take the on-die
switch's reg_mutex:

mt7530_port_enable()                        /* MCM */
    mutex_lock(&priv->reg_mutex);
    regmap_update_bits()
        mt7530_mdio_regmap_lock()           /* child_bus->mdio_lock */
        mt7530_regmap_write()
            bus->write() == mt753x_phy_write_c22()
                mt7531_ind_c22_phy_write()  /* on-die */
                    mutex_lock(&priv->reg_mutex);

Both reg_mutex instances come from the single mutex_init() in
mt7530_probe_common(), so they share one lockdep class. The downstream
switch has no mutex_lock_nested() or separate lock_class_key.

These are distinct instances, so this is not a real deadlock. With
CONFIG_PROVE_LOCKING, though, would the first such access during tree
setup trigger a "possible recursive locking detected" splat and turn
lockdep off for the rest of the boot?

[ ... ]

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index dbe3887097dbc..c44f2084b1730 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -49,6 +49,9 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
>  static int
>  mt753x_ctrl_phy_addr(struct mt7530_priv *priv)
>  {
> +	if (priv->id == ID_EN751221)
> +		return 12;
> +

[Severity: Medium]
This makes core_write() and core_rmw() reachable on the MMIO on-die
switch. ID_EN751221 sets .mac_port_config = mt7530_mac_config, so port 6
goes through mt7530_mac_config()->mt7530_setup_port6()->core_clear(),
core_write() and core_set().

On this switch priv->bus is NULL, so core_rmw() falls back to child_bus.
The lock helper only does something when priv->bus is set:

static void
mt7530_mutex_lock(struct mt7530_priv *priv)
{
	if (priv->bus)
		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
}

As a result, the MMD sequence on child_bus address 12 (MII_MMD_CTRL,
MII_MMD_DATA, MII_MMD_CTRL | NOINCR, MII_MMD_DATA) runs through direct
bus->write() and bus->read() calls without child_bus->mdio_lock. Each op
takes the on-die reg_mutex, but the transaction as a whole is not atomic.

Could a concurrent phylib or PHY driver access to address 12 change the
MMD devad or address between steps, so the PLL write lands in the wrong
register? The MDIO-attached variant holds bus->mdio_lock for the whole
sequence.

The child_bus fallback came from "net: dsa: mediatek: support PLL setup
on MMIO MT7530" earlier in this series. This patch is the first to make
it reachable.

> @@ -347,12 +350,19 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
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

[Severity: Low]
This isn't a bug, but on the on-die EN751221 the TRGMII cascade is port
5, while the TRGMII PLL is programmed only from port 6's mac_config. Port
6 is PHY_INTERFACE_MODE_INTERNAL, and it also gets P6_INTF_MODE(1) here.

This works today for two reasons. dsa_tree_setup_ports() sets up the
on-die ports before the MCM, and phylink never does a major reconfig of
this fixed-link CPU port.

If port 6 were reconfigured later, would the TRGMII clock be gated and
reprogrammed without recalibrating the port 5 link? Would it be clearer
to tie the PLL setup to port 5?

[ ... ]

> @@ -469,6 +479,251 @@ mt7531_pll_setup(struct mt7530_priv *priv)
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

[Severity: Low]
Does the hardware keep RD_VALUE and RD_ERR latched after EDGE_CHK is
cleared?

EDGE_CHK is set and cleared back to back, and the result is read only
after it is deasserted. en751221_trgmii_calibrate_direction() also calls
this right after changing RD_TAP, with no settle time. When the receiver
is the MMIO on-die switch, EDGE_CHK stays asserted for only a few bus
cycles.

If the results are not latched, the pass/fail map would show bus timing
rather than the data eye, and the chosen taps could be wrong.

> +
> +	return FIELD_GET(RD_VALUE_MASK, val) == TGMII_TD_PAT &&
> +	       !FIELD_GET(RD_ERR_MASK, val);
> +}

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

[Severity: Low]
Is anything serializing this against the on-die switch's own phylink
instance for port 5?

This runs from the MCM's port 6 phylink resolve work. It reprograms the
on-die MT753X_PMCR_P(ondie_port) and TRGMII block in several steps: down,
reset (with 5ms sleeps), up, then train.

The on-die port 5 mt753x_phylink_mac_link_up() writes the same PMCR
register from a separate resolve work item, under a different
pl->state_mutex. That work is queued earlier, but nothing guarantees it
has run before this sequence starts.

If it is delayed, its regmap_set_bits() of PMCR_MAC_TX_EN |
PMCR_FORCE_LNK could land inside the TX/RX reset window. On-die teardown
through mt753x_phylink_mac_link_down() is also not serialized against a
calibration in progress.

> +	usleep_range(5000, 6000);
> +
> +	/* BOTH: Reset TX */
> +	regmap_set_bits(ext->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
> +	regmap_set_bits(ondie->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
> +	usleep_range(5000, 6000);
> +	regmap_clear_bits(ext->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
> +	regmap_clear_bits(ondie->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
> +
> +	/* BOTH: Reset RX controllers down */
> +	regmap_set_bits(ext->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
> +	regmap_set_bits(ondie->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
> +
> +	/* BOTH: Set TX drive strength, MCM uses more */
> +	en751221_set_tx_drive(ondie, 8, 8, 7, 7);
> +	en751221_set_tx_drive(ext, 11, 11, 15, 15);
> +
> +	/* BOTH: Reset RX controllers up */
> +	regmap_clear_bits(ext->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
> +	regmap_clear_bits(ondie->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);

[Severity: Low]
This isn't a bug, but RX_RST has no explicit hold time here, unlike
TX_RST. The pulse width depends on how long the en751221_set_tx_drive()
writes in between take.

The MCM writes go over MDIO through the on-die indirect accessor, so the
pulse is long in practice. Would an explicit delay be more robust in case
this ordering changes?

> +
> +	/* BOTH: Ports up */
> +	mcr_up = mcr_down | PMCR_MAC_TX_EN | PMCR_FORCE_LNK;
> +	regmap_write(ondie->regmap, MT753X_PMCR_P(ondie_port), mcr_up);
> +	regmap_write(ext->regmap, MT753X_PMCR_P(ext_port), mcr_up);

[Severity: Medium]
Does this drop the flow control settings that phylink just programmed?

When tx_pause or rx_pause is set, mt753x_phylink_mac_link_up() sets
PMCR_FORCE_TX_FC_EN and PMCR_FORCE_RX_FC_EN with regmap_set_bits(). It
then calls mt7530_cal_interswitch_trgmii().

The full regmap_write() calls of mcr_down and mcr_up here replace PMCR on
both the MCM port and the on-die port, and mcr_up never includes the FC
bits.

Any pause configuration phylink resolved, such as a fixed-link with
pause, would be cleared on both ends. The on-die port's PMCR, which its
own phylink programmed, is overwritten too, so the hardware state no
longer matches what phylink reported.

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
Are the default tap arrays swapped here?

default_taps_ext[] is read from ext->regmap and default_taps_ondie[] from
ondie->regmap. But the first call passes ext as rx with
default_taps_ondie, and the second passes ondie as rx with
default_taps_ext.

The fallback in en751221_trgmii_calibrate_direction() writes default_taps
into the rx switch:

		} else {
			regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
					   RD_TAP(default_taps[channel]));

When a lane fails calibration, the MCM receiver would get the on-die
switch's original tap, and the reverse, instead of keeping its own.

The two sets can differ: mt7530_setup() programs RD_TAP(16) on the MCM,
but mt7988_setup() does not set RD_TAP on the on-die switch. The "old %d"
value in the success message would also come from the wrong switch.

Should these be:

	en751221_trgmii_calibrate_direction(ondie, ext, default_taps_ext);
	en751221_trgmii_calibrate_direction(ext, ondie, default_taps_ondie);

[ ... ]

> @@ -3023,6 +3286,44 @@ static void en7528_mac_port_get_caps(struct dsa_switch *ds, int port,
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
This isn't a bug, but the binding description added in "dt-bindings: net:
dsa: mediatek,mt7530: add econet,en751221" says:

  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
  gigabit PHY.

This function, this commit message ("4 FE ports and 1 GE port") and the
binding commit message ("ports 0..3 are 10/100 only") all describe four FE
ports. Should the binding text say 4x 10/100 PHYs?

[ ... ]

> @@ -3428,7 +3732,8 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
>  	 * interface is up. NOTE: "CPU port" can also mean an upstream DSA link.
>  	 */
>  	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
> -	    priv->id != ID_EN7528)
> +	    priv->id != ID_EN7528 && priv->id != ID_EN751221 &&
> +	    priv->id != ID_EN751221_EXT)
>  		return;

[Severity: High]
Does the on-die switch ever get MT7530_CHG_TRAP set?

On MT7530, values written to MT753X_MTRAP only override the hardware
straps in MT753X_TRAP while MT7530_CHG_TRAP is set. The driver relies
on mt7530_setup() setting it once during setup. After that,
mt7530_port_enable(), mt7530_port_disable() and mt7530_setup_port5()
update MTRAP without setting it again.

ID_EN751221 uses mt7988_setup() as its sw_setup. That resets the switch
through priv->rstc and then calls mt7531_setup_common(). Neither of them
touches MT753X_MTRAP.

This patch still sends ID_EN751221 down the MTRAP paths:

  - It adds ID_EN751221 to the MT7530_P5_DIS and MT7530_P6_DIS handling
    in mt7530_port_enable() and mt7530_port_disable().
  - Through .mac_port_config = mt7530_mac_config, port 5 reaches
    mt7530_setup_port5(), which writes MT7530_P5_MAC_SEL into MTRAP.

Without MT7530_CHG_TRAP, would those updates be silently ignored? Ports
5 and 6 would then stay at whatever the straps select. Port 5 is the
TRGMII cascade to the MCM, so if the straps disagree, the inter-switch
link would not come up. The same would apply to any other MTRAP bits the
series programs on the on-die switch, such as MT7530_LOOP_DET_DISABLE
for passthrough mode.

This may work on the tested boards because the EN751221 straps already
match, or because the on-die block does not gate MTRAP writes on
CHG_TRAP. If so, could that be stated in a comment? Otherwise, should
the EN751221 setup path set MT7530_CHG_TRAP the way mt7530_setup() does?

[Severity: Medium]
The MT7530-family ID lists here and in mt7530_port_enable() and
mt7530_port_disable() were extended. mt7530_setup_irq() still has only
the old IDs:

	/* This register must be set for MT7530 to properly fire interrupts */
	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
		regmap_set_bits(priv->regmap, MT7530_TOP_SIG_CTRL,
				TOP_SIG_CTRL_NORMAL);

ID_EN751221_EXT is an MCM MT7530 that uses mt7530_setup(), like the
MT7621 MCM. If the MCM DT node has interrupt-controller, the IRQ chip is
registered without TOP_SIG_CTRL being set.

Would switch and PHY interrupts then never fire, leaving phylib waiting
for link changes on the MCM user ports?

The unused TOP_SIG_CTRL_B0 define added for this register suggests some
TOP_SIG_CTRL handling may have been dropped.

[ ... ]

> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index c86bc4bca29b9..1a4329749c0f1 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h

[ ... ]

> @@ -601,6 +607,8 @@ enum mt7531_xtal_fsel {
>  /* Register for TOP signal control */
>  #define MT7530_TOP_SIG_CTRL		0x7808
>  #define  TOP_SIG_CTRL_NORMAL		(BIT(17) | BIT(16))
> +/* Undocumented */
> +#define  TOP_SIG_CTRL_B0		BIT(0)

[Severity: Low]
This isn't a bug, but nothing in drivers/net/dsa/ uses TOP_SIG_CTRL_B0.
Is it a leftover, or is some MT7530_TOP_SIG_CTRL programming for
EN751221 missing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028011317.1557238-1-cjd%40cjdns.fr
