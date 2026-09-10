Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AD38F248;
	Thu, 10 Sep 2026 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017676; cv=none; b=YiBrj3HJ8fOflNyFHOawyWLzWzDUTXXgqyPXFdGotM4IFs9x+RKFTcPx1qc9QrK5UqVZdjTAuZDvdQqHPh6PZ6AtZy5MQDGE6QsGgc9W87crJIqk6UJzltfKV7UVWWut7hEClLWpwnZKyz1rKl7D1WADI4+iAk3SO3LGlW70D+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017676; c=relaxed/simple;
	bh=xcS7oRpqzWG4H/8b9sL5O9Suo99XlwFxxQ/w+kpj0VE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAxGMmAa865iSZymByNkRCgAy8ksz7XTEnadjvEnHFcA+nYVPqrdBU83fIMSYrFQ7Yp8Hdzbfc7bHnFXCIN1YTQUAIDgtQJgyVJEhIViO9/fifTQnuXiRA9+tpXP3nLYsxAR/oGypEeIsGYxVqTo74Gr2GPpjPDSzi+YHzO3rGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuA2A/xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuA2A/xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124D91F000FF;
	Thu, 10 Sep 2026 05:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017674;
	bh=hFqYwCPLTTlByTeHp3SIaslC4ALHq3hamT272/Gjg3o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DuA2A/xwsGkiR5nMktfjcdgIjAprw/cnFGc7QIvfCWZhSZ7MeNmLgwEYO4+ETCfWp
	 FvnhKOEZ+0dIJRfUQCzZUpoK/+WrjGQ850FdqDdhkC7YjyCPCu1hJYr+yWXBZJGUuG
	 2G6JhyifFy9Az1ljWG2F3J1cTEF48I05hAAf9rlFkFIz4gEefpzF17emTkOoUQML9N
	 f4h5DH5bVh84f35rCKSWeZGfTLO5E4TjnYpvyHatzZqBgqF2cE+K2moBhpRDbE9z/i
	 5NBFHGOw/lAHzWqn3EUot9wC7HV6Tn8QA8M9n5hscPAuobKkwOmOge2nx8QaSVBRXf
	 Rjk7Pi4WNHw4A==
Subject: Re: [PATCH net-next v2 4/4] net: phy: microchip_t1s: fix collision
 detection for LAN867X Rev.D0
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Thu, 10 Sep 2026 05:21:13 +0000
Message-ID: <178901767362.219967.11790790034412188029@kernel.org>
In-Reply-To: <20260907052007.391972-5-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-5-parthiban.veerasooran@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 1

- [High] The new CCMFC-based collision gating for LAN867X Rev.D0 does not
  own the CDCTL0.CDEN master enable it depends on.
- [Medium] lan867x_revd0_handle_interrupt()
  (drivers/net/phy/microchip_t1s.c:646) passes the live PLCA operational…
- [Medium] lan86xx_plca_set_cfg()
  (drivers/net/phy/microchip_t1s.c:456-491) treats the documented "don't…
- [Medium] For Rev.D0 the link-status-selection register
  (LAN867X_REG_LINK_STATUS_CTRL, 0x0012) is now kept in sync with the…
- [Low] The comment justifying the new CCMFC programming in
  lan867x_revd0_config_init() (drivers/net/phy/microchip_t1s.c:509)…

--

net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0

This programs the new CCMFC field of CDCTL0 on LAN867X Rev.D0 so the
hardware gates collision forwarding from PLCA_Status, adds
lan867x_revd0_handle_interrupt() for the LNKSTSC and PSTC events, and
unmasks both events for Rev.D0 in lan86xx_config_intr().

A few questions on the CDEN ownership, the value passed to
lan867x_revd0_link_active_selection(), and the event masking follow inline.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index afb7e52594e71..c3a738c7425bf 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c

[ ... ]

> @@ -40,6 +41,9 @@
>  #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
>  #define COL_DET_ENABLE			BIT(15)
>  #define COL_DET_DISABLE			0x0000
> +#define COL_DET_CTRL0_CCMFC_MASK	GENMASK(10, 9)
> +/* OA default: collisions gated by PLCA_Status in hardware */
> +#define COL_DET_CTRL0_CCMFC_OA_DEFAULT	BIT(9)

[ ... ]

> @@ -502,6 +506,18 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	/* AN1760: configure CCMFC to OA default so that the hardware
> +	 * automatically gates collision forwarding to the MAC based on
> +	 * PLCA_Status. Collisions are neither counted nor forwarded when
> +	 * PLCA_Status = OK, eliminating the need for software-driven CDEN
> +	 * toggling in the interrupt handler. CDEN remains enabled.
> +	 */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> +			     COL_DET_CTRL0_CCMFC_MASK,
> +			     COL_DET_CTRL0_CCMFC_OA_DEFAULT);
> +	if (ret)
> +		return ret;

[Severity: High]
Who owns CDEN for Rev.D0 after this change?  This write only touches
GENMASK(10, 9) of CDCTL0, and 0x0087 is not present in
lan867x_revd0_fixup_regs[], so bit 15 is never programmed by
lan867x_revd0_config_init().  The comment states "CDEN remains enabled",
but that is the reset default rather than something the driver
establishes.

The driver can also clear it.  The Rev.D0 entry still uses
.set_plca_cfg = lan86xx_plca_set_cfg, and that function only returns
early for interrupt-driven PHYs:

	if (phydev->irq != PHY_POLL)
		return 0;

	if (plca_cfg->enabled)
		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
				      LAN86XX_REG_COL_DET_CTRL0,
				      COL_DET_CTRL0_ENABLE_BIT_MASK,
				      COL_DET_DISABLE);

So on a Rev.D0 board without a routed PHY interrupt (phydev->irq ==
PHY_POLL), an "ethtool --set-plca-cfg <dev> enable 1" turns the collision
detector off entirely.  With CDEN cleared, can CCMFC still count or
forward collisions when PLCA_Status goes not-OK?

Is there any path that restores bit 15 afterwards?
lan867x_revd0_config_init() writes only bits 10:9, the Rev.D0 phy_driver
entry has no .soft_reset so phy_init_hw() performs no reset of the vendor
register, and lan867x_revd0_handle_interrupt() deliberately never touches
CDEN.

Would it make sense to program CDEN explicitly next to CCMFC here, and to
exclude Rev.D0 from the static CDEN write in lan86xx_plca_set_cfg()?

[Severity: Low]
Should this comment cite AN1699 rather than AN1760?  Elsewhere in this
file AN1760 denotes the LAN8650/1 configuration note (see the comment
above lan865x_revb_fixup_registers[] and the AN1760 reference in
lan865x_revb_indirect_read()), while the Rev.D0 register data in this very
function is attributed to AN1699 Revision G (DS60001699G) above
lan867x_revd0_fixup_regs[].

The changelog also gives no document or revision for the CCMFC field
position (CDCTL0 bits 10:9) or for the "OA default value (0x1)" and the
CDEN reset-default claim, so the field layout cannot be cross-checked
against the reference given here.

>  	/* Initially the PHY will be in CSMA/CD mode by default. So it is
>  	 * required to set the link always active as it doesn't support
>  	 * autoneg.
> @@ -526,8 +542,12 @@ static int lan86xx_read_status(struct phy_device *phydev)
>  
>  static int lan86xx_config_intr(struct phy_device *phydev)
>  {
> +	u16 mask = LAN86XX_STS1_PLCA_STS_CHANGED;
>  	int ret;
>  
> +	if (phydev->phy_id == PHY_ID_LAN867X_REVD0)
> +		mask |= LAN86XX_STS1_LINK_STS_CHANGED;
> +
>  	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
>  		/* Read to clear any pending status before enabling. */
>  		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
> @@ -536,12 +556,11 @@ static int lan86xx_config_intr(struct phy_device *phydev)
>  
>  		/* A mask bit of 0 enables the corresponding interrupt. */
>  		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
> -					  LAN86XX_REG_IMSK1,
> -					  LAN86XX_STS1_PLCA_STS_CHANGED);
> +					  LAN86XX_REG_IMSK1, mask);

[Severity: Medium]
Can a PLCA status transition be lost here for Rev.D0?  The read-to-clear
of LAN86XX_REG_STS1 discards any latched PSTC before unmasking, and
nothing samples the current PLCA status afterwards.

For Rev.D0 the PSTC branch of lan867x_revd0_handle_interrupt() is now the
only writer of LAN867X_REG_LINK_STATUS_CTRL from the live status, so a
dropped edge leaves that register stale until the next transition, which
may never occur on an idle segment.

The phy_init_hw() path looks deterministic:

drivers/net/phy/phy_device.c:phy_init_hw() {
	...
	if (phydev->drv->config_init) {
		ret = phydev->drv->config_init(phydev);
	...
	if (phydev->drv->config_intr) {
		ret = phydev->drv->config_intr(phydev);
	...
}

lan867x_revd0_config_init() unconditionally ends with

	return lan867x_revd0_link_active_selection(phydev, false);

and the Rev.D0 entry has no .soft_reset, so the PLCA enable bit in MMD 31
survives while config_intr's read-to-clear drops the pending PSTC.  Does a
PHY that is PLCA-enabled with PLCA_Status OK then keep the forced-active
selection instead of the plca_status source across resume
(mdio_bus_phy_resume() -> phy_init_hw()) or PHY attach?

The reverse case looks reachable too: selection left at
LINK_STATUS_CONFIG_PLCA_STATUS while pst dropped to 0 during the masked
window, with no further edge to correct it.

>  	}
>  
>  	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_IMSK1,
> -			       LAN86XX_STS1_PLCA_STS_CHANGED);
> +			       mask);
>  	if (ret)
>  		return ret;
>  
> @@ -595,6 +614,47 @@ static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
>  	return ret_irq;
>  }
>  
> +static irqreturn_t lan867x_revd0_handle_interrupt(struct phy_device *phydev)
> +{
> +	struct phy_plca_status plca_st;
> +	irqreturn_t ret_irq = IRQ_NONE;
> +	int sts1, ret;
> +
> +	/* Reading the status register clears the latched event bits. */
> +	sts1 = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
> +	if (sts1 < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	if (sts1 & LAN86XX_STS1_LINK_STS_CHANGED) {
> +		phy_trigger_machine(phydev);
> +		ret_irq = IRQ_HANDLED;
> +	}
> +
> +	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
> +		ret = genphy_c45_plca_get_status(phydev, &plca_st);
> +		if (ret < 0) {
> +			phy_error(phydev);
> +			return IRQ_NONE;
> +		}
> +
> +		/* Collision detection is handled autonomously by the hardware
> +		 * via CCMFC. Only the link status selection needs to be updated
> +		 * on each PLCA status transition.
> +		 */
> +		ret = lan867x_revd0_link_active_selection(phydev, plca_st.pst);

[Severity: Medium]
Is plca_st.pst the right value to feed into this argument?  The parameter
is a mode selector:

static int lan867x_revd0_link_active_selection(struct phy_device *phydev,
					       bool plca_enabled)

and the other two callers pass a configuration value:
lan867x_revd0_config_init() passes false, and lan86xx_plca_set_cfg()
passes plca_cfg->enabled.

pst is a status bit, not the enable state:

drivers/net/phy/phy-c45.c:genphy_c45_plca_get_status() {
	...
	plca_st->pst = !!(ret & MDIO_OATC14_PLCA_PST);
	...
}

include/linux/phy.h documents it as "The PLCA status as reported by the
PST bit in the PLCA STATUS register(31.CA03), indicating BEACON activity."

So while PLCA stays enabled but PLCA_Status goes not-OK, this call takes
the else branch and writes

	value = FIELD_PREP(LINK_STATUS_CONFIGURATION,
			   LINK_STATUS_CONFIG_SEMAPHORE) |
		FIELD_PREP(LINK_STATUS_SEMAPHORE,
			   LINK_STATUS_SEMAPHORE_SET);

which forces the link active and discards the
LINK_STATUS_CONFIG_PLCA_STATUS selection that lan86xx_plca_set_cfg()
programmed from the user's plca_cfg->enabled.  Since the register is only
switched back to the plca_status source while pst == 1, can a
plca_status-derived link-down ever be observed?  The Rev.D0 entry has no
.read_status override, so genphy_read_status() reads exactly this hardware
link status.

The ordering inside the handler makes the loss concrete when both bits are
latched in one invocation: the LNKSTSC branch only queues work
(phy_trigger_machine() -> phy_queue_state_machine(phydev, 0)), and the
forced-active write happens after it, so the queued state machine sees
link up.

Should the selection be driven from the configured PLCA enable state
instead, with the state machine left to report the PLCA-derived link
status?

> +		if (ret < 0) {
> +			phy_error(phydev);
> +			return IRQ_NONE;
> +		}
> +
> +		ret_irq = IRQ_HANDLED;
> +	}
> +
> +	return ret_irq;
> +}
> +
>  static struct phy_driver microchip_t1s_driver[] = {

[ ... ]

> @@ -637,6 +697,8 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.name               = "LAN867X Rev.D0",
>  		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
>  		.config_init        = lan867x_revd0_config_init,
> +		.config_intr        = lan86xx_config_intr,
> +		.handle_interrupt   = lan867x_revd0_handle_interrupt,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
>  		.set_plca_cfg	    = lan86xx_plca_set_cfg,

[Severity: Medium]
Keeping the shared lan86xx_plca_set_cfg() for Rev.D0 also keeps the
plca_cfg->enabled == -1 case, which that function treats as "enabled".

net/ethtool/plca.c:ethnl_set_plca() {
	...
	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
	plca_update_sint(&plca_cfg.enabled, tb, ETHTOOL_A_PLCA_ENABLED, &mod);
	...
}

include/linux/phy.h describes the field as "-1 = not available / don't
set. 0 = disabled, anything else = enabled", and
genphy_c45_plca_set_cfg() honours that by testing "enabled == 0" and
"enabled > 0".

lan86xx_plca_set_cfg() instead does

	if (phydev->phy_id == PHY_ID_LAN867X_REVD0) {
		ret = lan867x_revd0_link_active_selection(phydev,
							  plca_cfg->enabled);
	...
	if (plca_cfg->enabled)
		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
				      LAN86XX_REG_COL_DET_CTRL0,
				      COL_DET_CTRL0_ENABLE_BIT_MASK,
				      COL_DET_DISABLE);

so does "ethtool --set-plca-cfg <dev> node-id 5" (which leaves enabled at
-1) select LINK_STATUS_CONFIG_PLCA_STATUS on Rev.D0 even with PLCA
disabled, and clear CDEN on PHY_POLL boards?  Should the -1 "don't set"
case be handled here as well while touching this path?

>  		.get_plca_status    = genphy_c45_plca_get_status,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907052007.391972-1-parthiban.veerasooran%40microchip.com
