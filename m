Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBC315D5D;
	Sat,  3 Oct 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034569; cv=none; b=b8hIyBtBw//JzzKO9WR5OzYvSicGlM7phnR6tCT2ePyxIZziwdbDbTLK5A8MHFRa4yPo531qcvmGCmqikRGQW3sR/KJRWZArQF4MkwaG3o6/Px/wTbHT367seuuR4c89vm7fBz9ecI8XMbCCgSUbyV5NyMndOC9vOAGPRkBoCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034569; c=relaxed/simple;
	bh=AS2wXpDXUk3CxI6oO+Zx/S7EIzf/YdtGdPYWhMqvDP0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rEMxB5s9sA1R5rEgrJEtU/sl9pu89HM8gxhwIizsPMbm+DKXYY9V3LF4OpSPLF85Ln7pdkXUf0DY78xYgZpB9OPdqNNtMTfDzkqCTYFKI0hEKziwprO0JW6DPEUMoMADNAwnlOey6TQ0icxkCC5di1wvNmByE7b4XFfwJPTGF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNABgP4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNABgP4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142181F0089C;
	Sat,  3 Oct 2026 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791034566;
	bh=5N04o3FgDdHlFpQIGY4i+MqaBqH3v/HvzYdfB2IUXc4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fNABgP4iIu+wDrmY+QLXbrVK7gPF5M3Nq0zW+khZLREmqH+XLLyBvNIr7VF0CnvWJ
	 tWogPBUl6QAQJ928iSA3J1Ozqc946f/jkOME4FvIJo5RIWN2nD5R34uOHNcCanDMl7
	 Zo670XNnsqZHREDCRcdnb9KyvIVkQZEtTzuozrugjJzcbt51mRjmWEeBs2e8OJ67EH
	 HFQ07xDUwGFsSfOCzNXmJRCbn/80oyiWF1SiCDUm73gh5EH8tCqRLqm8ADBwD9LNy/
	 GtEJtP9IMGyYHM2C5I22TcQVV4eoADT4Hg7BYBb2xHWD3cFz9MOvUjZZhq8eZwtkAv
	 ZXKDa343AFY4Q==
Subject: Re: [PATCH net-next v4 4/4] net: phy: microchip_t1s: fix collision
 detection for LAN867X Rev.D0
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Sat, 03 Oct 2026 13:36:05 +0000
Message-ID: <179103456563.434549.3604641648907923968@kernel.org>
In-Reply-To: <20260929125928.611784-5-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-5-parthiban.veerasooran@microchip.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On LAN867X Rev.D0 the driver never actually enables CDEN
  (collision detection, COL_DET_CTRL0 bit 15), although the design…
- [Medium] lan867x_revd0_config_intr() and
  lan867x_revd0_handle_interrupt() choose the Rev.D0 link-status source…
- [Low] In steady state, the PLCA_STS_CHANGED branch of
  lan867x_revd0_handle_interrupt() changes nothing.
- [Low] lan867x_revd0_config_intr() reads priv->plca_enabled and does a
  read-then-write of PRSCTL1 and LINK_STATUS_CTRL without taking…

Pre-existing issues:
- [Medium] In polling mode (no PHY IRQ), the Rev.D0 link-status selection
  is not resynced after phy_init_hw().

--

net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0

This commit configures CCMFC in COL_DET_CTRL0 on LAN867X Rev.D0 so that
collision forwarding is gated by PLCA_Status in hardware. It also stops
software CDEN toggling on Rev.D0. It adds Rev.D0 specific config_intr and
handle_interrupt callbacks that re-evaluate the link status selection
(forcing the semaphore source when CSMA/CD fallback is enabled), and sets
PHY_POLL_CABLE_TEST for Rev.D0.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 5ce0304bf0952..d667f57aa4a8f 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c

[ ... ]

> @@ -542,7 +574,7 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  	 * (not -1, which means "don't change").
>  	 */
>  	if (phydev->phy_id == PHY_ID_LAN867X_REVD0 && plca_cfg->enabled != -1) {
> -		ret = lan867x_revd0_link_active_selection(phydev,
> +		ret = lan867x_revd0_update_link_selection(phydev,
>  							  plca_cfg->enabled);
>  		if (ret)
>  			return ret;
> @@ -555,6 +587,12 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  	if (plca_cfg->enabled != -1)
>  		priv->plca_enabled = plca_cfg->enabled;
>  

[Severity: Low]
Can the Rev.D0 link selection end up based on the old enable state here?
lan86xx_plca_set_cfg() writes the selection from plca_cfg->enabled above.
It updates priv->plca_enabled only here and does not recompute afterwards.

lan867x_revd0_config_intr() reads priv->plca_enabled and then does the
PRSCTL1 read and the LINK_STATUS_CTRL write without taking phydev->lock
or priv->cden_lock. The sibling lan86xx_config_intr() does take cden_lock
for its resync. The commit that added it notes that config_intr() is not
guaranteed to run under phydev->lock.

If lan867x_revd0_config_intr() runs between those two steps, it would
write a selection based on the old cached value. Nothing would correct
that until the next PSTC event. The unlocked read of priv->plca_enabled
is also a data race.

I couldn't find a concrete caller for this PHY that runs phy_init_hw()
at the same time as an ethtool PLCA set. Some MAC drivers do call
phy_init_hw() from their own work or reset paths, though.

> +	/* LAN867X Rev.D0 uses CCMFC for autonomous collision detection
> +	 * gating; CDEN remains enabled and does not require software toggling.
> +	 */
> +	if (phydev->phy_id == PHY_ID_LAN867X_REVD0)
> +		return 0;
> +

[ ... ]

> @@ -582,6 +620,20 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	/* AN1699: Configure CCMFC (Collision Counting and MAC Forwarding
> +	 * Control) to OA default (0x1) so that the hardware autonomously gates
> +	 * collision forwarding to the MAC based on the live PLCA_Status:
> +	 * collisions are neither counted nor forwarded when PLCA_Status is OK,
> +	 * and are counted/forwarded when not OK. This eliminates the need for
> +	 * software-driven CDEN toggling. CDEN defaults to enabled on Rev.D0
> +	 * and remains enabled.
> +	 */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> +			     COL_DET_CTRL0_CCMFC_MASK,
> +			     COL_DET_CTRL0_CCMFC_OA_DEFAULT);

[Severity: Medium]
This call only changes bits 10:9 of COL_DET_CTRL0, so bit 15 (CDEN)
keeps whatever value the PHY already has. Does anything on Rev.D0
actually set CDEN?

The comment added above lan86xx_plca_set_cfg() says:

  CDEN remains permanently enabled in config_init()

However, this phy_modify_mmd() does not write COL_DET_ENABLE, and
lan867x_revd0_fixup_regs[] has no entry for 0x0087. Rev.D0 also has no
.soft_reset, so phy_init_hw() does not reset the PHY back to its
defaults before config_init() runs.

Before this patch, lan86xx_plca_set_cfg() cleared CDEN on Rev.D0
whenever PLCA was enabled. It did this through lan86xx_update_cden(),
and through a direct COL_DET_DISABLE write since commit 78341049fbcd.
With the new early return in lan86xx_plca_set_cfg():

	if (phydev->phy_id == PHY_ID_LAN867X_REVD0)
		return 0;

no Rev.D0 path writes CDEN any more.

Suppose the PHY comes up with CDEN=0 and is not power cycled. Two
examples are a warm reboot or kexec from an older kernel after
"ethtool --set-plca-cfg ... enable on", and a bootloader that followed
the older AN1699 advice. Would CDEN then stay disabled for good?

CCMFC only controls whether detected collisions are counted and
forwarded. In that case, CSMA/CD operation (PLCA disabled, or the
autonomous fallback) would run with no collision detection.

Could COL_DET_CTRL0_ENABLE_BIT_MASK and COL_DET_ENABLE be added to this
phy_modify_mmd() call?

[ ... ]

> @@ -712,6 +764,76 @@ static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
>  	return ret_irq;
>  }
>  
> +static int lan867x_revd0_config_intr(struct phy_device *phydev)
> +{
> +	u16 mask = LAN86XX_STS1_PLCA_STS_CHANGED |
> +		   LAN86XX_STS1_LINK_STS_CHANGED;
> +	struct lan86xx_priv *priv = phydev->priv;
> +	int sts1, ret;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* Read to clear any pending status before enabling. */
> +		sts1 = lan86xx_read_clear_sts1(phydev);
> +		if (sts1 < 0)
> +			return sts1;
> +
> +		/* STS1 may have cleared a pending PSTC while masked, and a
> +		 * missed PSTC leaves no trace to key off, so unconditionally
> +		 * resync the link-status-selection source from the current
> +		 * PLCA enable state and fallback configuration.
> +		 */
> +		ret = lan867x_revd0_update_link_selection(phydev,
> +							  priv->plca_enabled);

[Severity: Medium]
Can priv->plca_enabled be stale at this point? Only
lan86xx_plca_set_cfg() writes it, and the PHY can be hardware reset
while the driver stays bound.

For example, phy_detach() asserts the reset GPIO with
phy_device_reset(phydev, 1). A MAC that connects the PHY in ndo_open and
disconnects it in ndo_stop therefore resets it on every ifdown/ifup.
Losing power across suspend has the same effect.

Suppose PLCA was enabled with ethtool, so priv->plca_enabled == 1. The
next attach then does:

phy_attach_direct()
  phy_init_hw()
    lan867x_revd0_config_init()
      lan867x_revd0_link_active_selection(phydev, false)  /* SEMAPHORE */
...
phy_request_interrupt()
  phy_enable_interrupts()
    phy_config_interrupt()
      lan867x_revd0_config_intr()
        lan867x_revd0_update_link_selection(phydev, 1)    /* PLCA_STATUS */

If PRSCTL1 fallback reads 0, this selects LINK_STATUS_CONFIG_PLCA_STATUS
while PLCA_EN is 0 in hardware. Would the BMSR link then stay down until
userspace runs ethtool --set-plca-cfg again? The PSTC branch in
lan867x_revd0_handle_interrupt() uses the same cached value, so it would
not recover this either.

Before this patch, Rev.D0 had no config_intr. The SEMAPHORE selection
from config_init() stayed in place and the link came up.

Would reading the PLCA_EN bit from MDIO_OATC14_PLCA_CTRL0 here, or
resyncing priv->plca_enabled from hardware in config_init(), avoid this?

> +		if (ret < 0)
> +			return ret;
> +
> +		return lan86xx_set_intr_mask(phydev, mask, true);
> +	}
> +
> +	ret = lan86xx_set_intr_mask(phydev, mask, false);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
The resync above only runs in the PHY_INTERRUPT_ENABLED branch.

In polling mode, phy_init_hw() calls lan867x_revd0_config_init(), which
always forces the SEMAPHORE source. It then calls
lan867x_revd0_config_intr(), which takes this disable branch and never
calls lan867x_revd0_update_link_selection().

If the PHY was not reset (resume without power loss, or re-attach
without a reset GPIO), PLCA_EN and priv->plca_enabled both remain 1.
With fallback disabled, is the link then forced up instead of following
PLCA_Status until ethtool --set-plca-cfg runs again?

config_init() has forced SEMAPHORE on every re-init since commit
07f5765f26c3. This patch adds the resync only for interrupt mode.

[ ... ]

> +static irqreturn_t lan867x_revd0_handle_interrupt(struct phy_device *phydev)
> +{

[ ... ]

> +	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
> +		/* Re-evaluate the link-status selection when PLCA status
> +		 * changes. A resulting link-status change raises
> +		 * LINK_STS_CHANGED, which triggers the PHY state machine.
> +		 */
> +		ret = lan867x_revd0_update_link_selection(phydev,
> +							  priv->plca_enabled);

[Severity: Low]
Can this call ever change LINK_STATUS_CTRL in steady state?
lan867x_revd0_update_link_selection() only looks at PRSCTL1 bit 10
(through lan86xx_fallback_to_csmacd()) and the cached
priv->plca_enabled. It never reads PLCA_STATUS.

This driver only reads PRSCTL1 and never writes it. priv->plca_enabled
only changes in lan86xx_plca_set_cfg(), which has already written the
selection for the new value. So each BEACON gain or loss seems to cost a
PRSCTL1 read plus a rewrite of the same LINK_STATUS_CTRL value.

The comment says a resulting link-status change raises
LINK_STS_CHANGED. When the selection is PLCA_STATUS, though, the hardware
already changes the link and raises LINK_STS_CHANGED on its own.

The commit message also says:

  The PSTC interrupt handler for Rev.D0 therefore only needs to update
  the link status selection on each PLCA transition.

Does Rev.D0 need LAN86XX_STS1_PLCA_STS_CHANGED unmasked at all? If it
does, could the commit message and this comment be updated to say what
the branch actually does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929125928.611784-1-parthiban.veerasooran%40microchip.com
