Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479A391E4B;
	Tue, 22 Sep 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089712; cv=none; b=MIBndUIyglbDGzOlLyesJFDrFRYitbnCCRaYOi8BJnLoUuyJutRd19Sgnc6yumeuL1hY1UUXQ4yUgw5HwRTb7paFgmZQWWxOkZrT8guZnfIZI0Mdqa1Z2aO1vMOJA1UM5fQPSt+O4FYCM78Dv9432o7jKvXNdTe+c5oa34LiV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089712; c=relaxed/simple;
	bh=j1+MHVvPwq6k8THNclxHmfc8nYhXDJ5txqHasrT2To0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tByitVJYpSBy1zKZmTCLD/bE/UxT+gr4SSBPi3Y4nLrSPq8n3cobWUXasLX815EtjJdRtmpOzppm7ng1YqzfO9mYG4ksOiFprWO1grzJdF1owMYbYV+Kua3px36M/uqkJgEMgF+V7MbhuENa4Z9V2TDsIJ+0tnpzrauVpZ5hpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmObI7xK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmObI7xK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1D71F000FF;
	Tue, 22 Sep 2026 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089707;
	bh=QzOv9wy4Ubnp4r/CpZrVhQzXMyMMiKAU1g8xFldYWpY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FmObI7xKL3NzW06vSlCuc9VZBx/xwztTf0MjEVVpPpO3t6wMwcQMMwdLp8dN9xdeX
	 PR8buPRD1mVPsFsYb1iJKgJO5+4O06Ry8oXcOzdigU0jVSEK0oW5HlGlcAgm0ebOma
	 1ey0Fn/FuoChcEQ0rKm5w09eHttxlVo2RGln7eiO2zkjO1osaGw66ca3fSco9ZIRYR
	 RLkgPfy+kH5WHARQ1aL4hn2eyIPOTpmpqJC/AxK3zNPQ8Ayp1J+5G0X0qjJQhSLo1c
	 ZifwAnRJyVoHg0e9tzCpMtnxUtz9LjxXcfCKVa5oP5Mb8OVH7bIwi4tD5XtCMYq9qK
	 MZZsKj0enzIYg==
Subject: Re: [PATCH net-next v3 1/4] net: phy: microchip_t1s: fix collision
 detection on PLCA status change
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Tue, 22 Sep 2026 15:08:26 +0000
Message-ID: <179008970611.2160803.1075386282086280507@kernel.org>
In-Reply-To: <20260918143302.76909-2-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-2-parthiban.veerasooran@microchip.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The failure the commit message sets out to fix — an autonomous
  (BEACON-driven) PLCA offline transition leaving CDEN cleared so…
- [Medium] lan86xx_plca_set_cfg() silently changes the interpretation of
  plca_cfg->enabled from a plain truthiness test (`if…
- [Medium] The LAN867X Rev.B1 driver entry gains .config_intr =
  lan86xx_config_intr and .handle_interrupt = lan86xx_handle_interrupt…
- [Medium] In lan86xx_config_intr() the CDEN re-sync is performed BEFORE
  unmasking PSTCM, contradicting the commit message, which states that…
- [Medium] lan86xx_config_intr() performs a multi-register read-modify
  sequence (read-to-clear STS1 -> read live PLCA status -> write CDEN in…

--

net: phy: microchip_t1s: fix collision detection on PLCA status change

This adds .config_intr and .handle_interrupt callbacks to the microchip_t1s
driver so that the PLCA Status Changed (PSTC) interrupt toggles CDEN in
COL_DET_CTRL0, instead of only adjusting collision detection on explicit
ethtool PLCA writes.  The callbacks are wired to LAN867X Rev.B1, C1, C2 and
LAN865X Rev.B0/B1.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 73c23d311d72..3333e4801aae 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c

[ ... ]

> @@ -458,14 +466,29 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  	if (ret)
>  		return ret;
>  
> -	if (plca_cfg->enabled)
> +	/* phylib dispatches handle_interrupt() only for PHYs with a real IRQ
> +	 * number (phy_interrupt_is_valid()). For PHY_POLL and PHY_MAC_INTERRUPT
> +	 * handle_interrupt() is never called, so apply the static CDEN write
> +	 * here as a baseline on every ethtool PLCA reconfiguration. The
> +	 * limitation is that autonomous PLCA mode transitions between ethtool
> +	 * reconfigurations are not tracked on such boards.
> +	 */
> +	if (phy_interrupt_is_valid(phydev))
> +		return 0;

[Severity: High]
Does this early return leave the failure described in the changelog reachable
on boards where the PHY interrupt is not routed?

The commit message says the problem is that "When PLCA went offline,
collision detection stayed disabled, leaving CSMA/CD running unprotected".
For phydev->irq == PHY_POLL or PHY_MAC_INTERRUPT, phy_interrupt_is_valid()
is false:

include/linux/phy.h:phy_interrupt_is_valid() {
	return phydev->irq != PHY_POLL && phydev->irq != PHY_MAC_INTERRUPT;
}

so phylib never dispatches lan86xx_handle_interrupt(), and the only remaining
CDEN write in lan86xx_plca_set_cfg() is derived from the administratively
requested plca_cfg->enabled, never from live PST.  Nothing in the polled path
re-reads PLCA status either — lan86xx_read_status() runs every poll interval
and contains no CDEN logic:

	phydev->link = 1;
	phydev->duplex = DUPLEX_HALF;

That covers all LAN867X Rev.B1/C1/C2 boards whose device tree does not
describe a PHY interrupt, and at this commit every LAN865X as well.  Would
re-syncing CDEN from genphy_c45_plca_get_status() in lan86xx_read_status()
cover the polled case too?

> +
> +	if (plca_cfg->enabled > 0)
>  		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
>  				      LAN86XX_REG_COL_DET_CTRL0,
>  				      COL_DET_CTRL0_ENABLE_BIT_MASK,
>  				      COL_DET_DISABLE);
>  
> -	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> -			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
> +	if (plca_cfg->enabled == 0)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      LAN86XX_REG_COL_DET_CTRL0,
> +				      COL_DET_CTRL0_ENABLE_BIT_MASK,
> +				      COL_DET_ENABLE);
> +
> +	return 0;
>  }

[Severity: Medium]
Is this change from "if (plca_cfg->enabled)" to a three-way test a second,
independent fix that the changelog does not mention?

ethnl_set_plca() prefills the request and only overwrites the attributes
actually present:

net/ethtool/plca.c:ethnl_set_plca() {
	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
	plca_update_sint(&plca_cfg.enabled, tb, ETHTOOL_A_PLCA_ENABLED, &mod);
	...
}

so a partial write such as "ethtool --set-plca-cfg <dev> node-id 3" arrives
with enabled == -1, which genphy_c45_plca_set_cfg() documents as "not to be
changed":

drivers/net/phy/phy-c45.c
 * @plca_cfg: structure containing the PLCA configuration. Fields set to -1 are
 * not to be changed.

The old truthiness test treated -1 as enabled and wrote COL_DET_DISABLE even
though PLCA enablement was untouched.  The new "> 0" / "== 0" split honours
the -1 contract, which looks like a user-visible fix in its own right.

Since the patch carries a Fixes: tag and is a stable candidate, could the
changelog call this out separately from the PSTC interrupt work, so it is
clear which part helps boards without a routed PHY IRQ?

> @@ -506,6 +529,111 @@ static int lan86xx_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  

[ ... ]

> +static int lan86xx_config_intr(struct phy_device *phydev)
> +{
> +	struct phy_plca_status plca_st;
> +	int ret;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* Read to clear any pending status before enabling. */
> +		ret = lan86xx_read_clear_sts1(phydev);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* STS1 may have cleared a PSTC event that occurred while the
> +		 * interrupt was masked, so synchronize CDEN with the current
> +		 * PLCA state before enabling PSTC.
> +		 */
> +		ret = genphy_c45_plca_get_status(phydev, &plca_st);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				     LAN86XX_REG_COL_DET_CTRL0,
> +				     COL_DET_CTRL0_ENABLE_BIT_MASK,
> +				     plca_st.pst ? COL_DET_DISABLE :
> +				     COL_DET_ENABLE);
> +		if (ret)
> +			return ret;
> +
> +		return lan86xx_set_intr_mask(phydev,
> +					     LAN86XX_STS1_PLCA_STS_CHANGED,
> +					     true);
> +	}

[Severity: Medium]
Does the implemented ordering here match the commit message?

The changelog states:

    CDEN is re-synced against current PLCA status right after unmasking
    PSTCM, since a transition during the masked window is otherwise
    silently dropped by the STS1 read-to-clear.

The code does the opposite order in lan86xx_config_intr():

	lan86xx_read_clear_sts1()		/* drops pending PSTC */
	genphy_c45_plca_get_status()		/* sample */
	phy_modify_mmd(COL_DET_CTRL0, ...)	/* act on the sample */
	lan86xx_set_intr_mask(..., true)	/* only now unmask PSTCM */

Under the hardware model the commit message describes, a PLCA transition
occurring between the status sample and the unmask is neither reflected in the
CDEN value just written nor delivered as an interrupt, so CDEN would stay
stale until the next autonomous PLCA transition.  Should the re-sync be moved
after lan86xx_set_intr_mask(), or should the changelog be corrected to match
the code?

[Severity: Medium]
Can lan86xx_config_intr() race with lan86xx_handle_interrupt() over
COL_DET_CTRL0 and the read-to-clear STS1 latch?

lan86xx_handle_interrupt() runs with phydev->lock held:

drivers/net/phy/phy.c:phy_interrupt() {
	mutex_lock(&phydev->lock);
	ret = phydev->drv->handle_interrupt(phydev);
	mutex_unlock(&phydev->lock);
}

but lan86xx_config_intr() is reached via phy_config_interrupt() from
phy_request_interrupt(), phy_free_interrupt() and phy_init_hw(), none of which
hold that mutex.  phy_request_interrupt() also registers the handler before
enabling:

drivers/net/phy/phy.c:phy_request_interrupt() {
	err = request_threaded_irq(phydev->irq, NULL, phy_interrupt,
				   IRQF_ONESHOT | IRQF_SHARED,
				   phydev_name(phydev), phydev);
	...
		if (phy_enable_interrupts(phydev)) {
}

and phy_free_interrupt() calls phy_disable_interrupts() while PSTCM is still
unmasked and the handler is still registered.

So an interleaving like this looks possible:

CPU0 lan86xx_config_intr()		CPU1 lan86xx_handle_interrupt()
  lan86xx_read_clear_sts1()
  plca_get_status() -> pst = 0
					  lan86xx_read_clear_sts1() -> PSTC
					  plca_get_status() -> pst = 1
					  phy_modify_mmd(CDEN = DISABLE)
  phy_modify_mmd(CDEN = ENABLE)
  lan86xx_set_intr_mask(..., true)

phy_modify_mmd() only serializes the individual register read-modify-write on
the MDIO bus, so the status-read-then-CDEN-write pair is not atomic.  Since
the PSTC latch was already consumed, would CDEN stay wrong until the next
autonomous PLCA transition?

> +
> +	ret = lan86xx_set_intr_mask(phydev, LAN86XX_STS1_PLCA_STS_CHANGED,
> +				    false);
> +	if (ret)
> +		return ret;
> +
> +	/* Read to clear any pending status after disabling. */
> +	ret = lan86xx_read_clear_sts1(phydev);
> +	return ret < 0 ? ret : 0;
> +}
> +

[ ... ]

>  static struct phy_driver microchip_t1s_driver[] = {
>  	{
>  		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
> @@ -513,6 +641,8 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
>  		.config_init        = lan867x_revb1_config_init,
>  		.read_status        = lan86xx_read_status,
> +		.config_intr        = lan86xx_config_intr,
> +		.handle_interrupt   = lan86xx_handle_interrupt,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
>  		.set_plca_cfg	    = genphy_c45_plca_set_cfg,

[Severity: Medium]
Is the Rev.B1 entry intentional?  It gains the two CDEN-managing callbacks
but keeps .set_plca_cfg = genphy_c45_plca_set_cfg, while the Rev.C1/C2 and
LAN865X entries use lan86xx_plca_set_cfg.

Two consequences follow from that combination.

First, the new comment in lan86xx_plca_set_cfg() about applying "the static
CDEN write here as a baseline" for PHY_POLL and PHY_MAC_INTERRUPT boards is
unreachable for Rev.B1, since genphy_c45_plca_set_cfg() never touches
COL_DET_CTRL0.  A Rev.B1 board on PHY_POLL therefore gets no CDEN management
at all, while a Rev.B1 board with a routed IRQ gets PLCA-tracked CDEN.

Second, Rev.B1's mandatory AN1699 init table programs COL_DET_CTRL0 with
CDEN set:

	0xC000, 0x801C, 0x033F, 0x0404,   /* values, 0x0087 = 0x801C */
	0xF800, 0x801C, 0x1FFF, 0xFFFF,   /* masks,  mask 0x801C */

lan86xx_handle_interrupt() has no per-revision guard, so it clears that bit
whenever PLCA is operational.  Commit 78341049fbcd converted only Rev.C1/C2
and LAN865X to lan86xx_plca_set_cfg and deliberately left Rev.B1 out.  Should
Rev.B1 either also use lan86xx_plca_set_cfg, or not be wired to the new
callbacks?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918143302.76909-1-parthiban.veerasooran%40microchip.com
