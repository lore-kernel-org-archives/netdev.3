Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049049B5AD
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273514; cv=none; b=lv2Z2HNoiIvsw7VysJVtnXpHR6+i7dVjpmYPHBfnQ2Xx52J8FQppssOB0pGobv9g2/+mpSvU1zMbzFU8dmu7Kf5gslOCAre7E8hEB17/+66JTMr2l8fNWlLOotU/JKvS5mwCOLfUY64ykVxeJXa/tskmZKgmld4AICfdo0CNo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273514; c=relaxed/simple;
	bh=uMvwiJ2vGvLSarj2tPtabJYc8vXyJO60vaYNtaecOWY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdYmKv1hUD9boZ8H+5sYQVrnNvi+IIjWNU9qVLt1uooGV24dkEJll/fdvYwCUcYWHagrX0sa7qNzJhNbLUWzBbfvE2qJ7KU54neCXo0R7X7WgSfWoaJED7/+EYJmAL+ESoWO9F4qgCJpMdw2cmXcb8uj50aHf2k+W/f2av4Qy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSOBfaIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSOBfaIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9E41F00893;
	Thu, 24 Sep 2026 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273513;
	bh=lnFDhOaS8gbA2NgDQhM+Xl85QHGQ3Zz2bg5RgZHcY6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aSOBfaIe6qzVuLA0V/Z6P8TE7swJ+QGRlyv6UGUtg+QKIzvs+p30gPKAh0OX39TRF
	 OJskKNf5mecgAlwRi017EQpp/uuaSULGu3fOXuTiQ4AboDgXcOSclXyLYD2mWB4h2A
	 zhI5ogSYZXc3W16S9vDVjq4pmf8xdECOugB6imPUBrg4PqYjJsCwa9olNVZoOqVFZt
	 aZj4Bex90OTH5RWa9lPxtoftzWKixYsbN5yAV86SH67QhMLerHjjNlnJhkdg6qcuJb
	 uJzAm3ithi+ZicwPMT4IR1NA9JGUxyvkoN11vDr/mcmgFiHFYpAIQ3r16snkdz45Jo
	 y8tgk/uUnVMSA==
Subject: Re: [PATCH v6 2/2] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
From: netdev-bot+sashiko@kernel.org
To: nwhitehorn@pa.msu.edu
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch,
 kuba@kernel.org, pabeni@redhat.com
Date: Thu, 24 Sep 2026 18:11:52 +0000
Message-ID: <179027351221.2160803.15261191351666946231@kernel.org>
In-Reply-To: <20260922151429.23272-3-nwhitehorn@pa.msu.edu>
References: <20260922151429.23272-3-nwhitehorn@pa.msu.edu>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete feature enablement: PHY_INTERFACE_MODE_1000BASEX is
  now announced to phylink and programmed into the MAC (NCFGR.PCSSEL in…
- [Low] Checkpatch/netdev style violations in the new code, plus a
  redundant local-variable idiom.

--

net: macb: add support for 1000BASE-X autonegotiation to PCS

The patch decouples PCS enablement from the SGMII mode selection so the
gigabit PCS can also be used in 1000BASE-X mode, and announces
PHY_INTERFACE_MODE_1000BASEX to phylink when MACB_CAPS_PCS is present.
It also adds an autonegotiation restart implementation and makes
pcs_config() return 1 when the advertisement was changed.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d48ad5b587d09..3c18e43fca069 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -583,7 +583,12 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  
>  static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>  {
> -	/* Not supported */
> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	u32 old, new;
> +
> +	old = gem_readl(bp, PCSCNTRL);
> +	new = old | BMCR_ANRESTART;
> +	gem_writel(bp, PCSCNTRL, new);
>  }
>  
>  static int macb_pcs_config(struct phylink_pcs *pcs,
> @@ -594,11 +599,16 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
>  {
>  	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
>  	u32 old, new;
> +	int ret = 0;
>  
>  	old = gem_readl(bp, PCSANADV);
>  	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
> -	if (new != -EINVAL && old != new)
> +	if (new != -EINVAL && old != new) {
> +		/* pcs_config() is supposed to return 1 if AN advertisement
> +		 * has changed */

[Severity: Low]
This isn't a bug, but a few style points that netdev's checkpatch run will
likely flag:

The new block comment in macb_pcs_config() closes on the text line, and
checkpatch wants the trailing */ on a line of its own:

	/* pcs_config() is supposed to return 1 if AN advertisement
	 * has changed
	 */

The continuation lines of the two new conditions, in
macb_mac_select_pcs() and in macb_mii_probe(), are indented with tabs
rather than aligned to the open parenthesis (checkpatch
PARENTHESIS_ALIGNMENT), which makes the continuation look like a
statement body:

	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
			interface == PHY_INTERFACE_MODE_SGMII)

In macb_pcs_an_restart(), the old/new pair mirrors the conditional-write
idiom used by macb_pcs_config() but there is no old != new comparison,
so the split reads as though a comparison was dropped.  Could this just
be written as a single read-modify-write?

> +		ret = 1;
>  		gem_writel(bp, PCSANADV, new);
> +	}
>  
>  	/* Disable AN if it's not to be used, enable otherwise.
>  	 * Must be written after PCSSEL is set in NCFGR which is done in
> @@ -612,7 +622,7 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
>  	if (old != new)
>  		gem_writel(bp, PCSCNTRL, new);
>  
> -	return 0;
> +	return ret;
>  }

[ ... ]

> @@ -957,7 +969,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
>  
>  	if (interface == PHY_INTERFACE_MODE_10GBASER)
>  		return &bp->phylink_usx_pcs;
> -	else if (interface == PHY_INTERFACE_MODE_SGMII)
> +	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> +			interface == PHY_INTERFACE_MODE_SGMII)
>  		return &bp->phylink_sgmii_pcs;
>  	else
>  		return NULL;
> @@ -1032,7 +1045,8 @@ static int macb_mii_probe(struct net_device *netdev)
>  	bp->phylink_config.type = PHYLINK_NETDEV;
>  	bp->phylink_config.mac_managed_pm = true;
>  
> -	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> +	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
> +			bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
>  		bp->phylink_config.poll_fixed_state = true;
>  		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
>  		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
> @@ -1061,9 +1075,12 @@ static int macb_mii_probe(struct net_device *netdev)
>  			  bp->phylink_config.supported_interfaces);
>  		phy_interface_set_rgmii(bp->phylink_config.supported_interfaces);
>  
> -		if (bp->caps & MACB_CAPS_PCS)
> +		if (bp->caps & MACB_CAPS_PCS) {
> +			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +				  bp->phylink_config.supported_interfaces);
>  			__set_bit(PHY_INTERFACE_MODE_SGMII,
>  				  bp->phylink_config.supported_interfaces);
> +		}

[Severity: Medium]
1000BASE-X is now announced purely on the runtime-detected MACB_CAPS_PCS
bit, so it becomes selectable on the zynqmp/versal/mpfs/pic64hpsc
configs, all of which use .init = init_reset_optional.

init_reset_optional() still gates the entire serial transceiver bring-up
on the SGMII mode only:

drivers/net/ethernet/cadence/macb_main.c:init_reset_optional() {
	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
		/* Ensure PHY device used in SGMII mode is ready */
		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
		...
		ret = phy_init(bp->phy);
		...
		ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_FIXED, 0);
		...
		ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_SGMII_MODE, 1);
	}
}

With phy-mode = "1000base-x", that block is skipped, so bp->phy stays
NULL (netdev priv is zero allocated), phy_init() never runs and the
firmware calls that route the GEM onto the serial/PCS path are never
issued.

macb_open() then does:

drivers/net/ethernet/cadence/macb_main.c:macb_open() {
	err = phy_set_mode_ext(bp->phy, PHY_MODE_ETHERNET, bp->phy_interface);
	if (err)
		goto reset_hw;

	err = phy_power_on(bp->phy);
	if (err)
		goto reset_hw;
}

Both are NULL tolerant and return 0, so probe and open succeed while the
PS-GTR lane is left unconfigured and unpowered (xpsgtr_phy_init() is what
enables the lane reference clock and runs xpsgtr_phy_init_sgmii()).

Does this mean the SFP use case named in the commit message ("This
enables direct attachment of the PCS to e.g. an SFP") silently never
links on those platforms, with no diagnostic?  Should
init_reset_optional() take the same path for
PHY_INTERFACE_MODE_1000BASEX?

Separately, macb_open() passes the device tree bp->phy_interface to
phy_set_mode_ext() rather than the interface phylink resolved.  Now that
the same PCS can run as either SGMII or 1000BASE-X, can the transceiver
submode end up differing from the mode programmed into the MAC PCS?

>  
>  		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
>  			__set_bit(PHY_INTERFACE_MODE_10GBASER,
> @@ -4911,7 +4928,9 @@ static int macb_init_dflt(struct platform_device *pdev)
>  	/* Set MII management clock divider */
>  	val = macb_mdc_clk_div(bp);
>  	val |= macb_dbw(bp);
> -	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
> +	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
> +		val |= GEM_BIT(PCSSEL);
> +	else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
>  		val |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>  	macb_writel(bp, NCFGR, val);
>  

This is the counterpart site: the MAC side PCS is enabled for 1000BASE-X
on exactly the platforms whose transceiver init above was left SGMII only.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922151429.23272-1-nwhitehorn%40pa.msu.edu
