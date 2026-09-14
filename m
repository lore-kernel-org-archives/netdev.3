Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482833A1CEA;
	Mon, 14 Sep 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419577; cv=none; b=BRC/h2k4CJ+bfXSBtnbXN94R1Y9CAapptK1ciBqT4poirM5J59PEu5FUNN+ICnAT5uIx7uomF3VS2TBJZB15PleZ5lRp2p3Ah+s3/6bH77tpW5rCvl9ueFQ87/mCy2mDJ3++nf1Fm5LixMifUsSLI7b7vS0uTma27PUDUzQht70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419577; c=relaxed/simple;
	bh=ub2+Hm7NQoFfUGhn6xa753QOFttvV9gSxDIjg6K22yw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuAY96NymDhXDJoDjoYMt20bQ4lGDF84F5v+tcapDQdpZmoE8wsDmvKVuk19ojGZ0vtaZuDxrODcnwsioq+OzT9+9Bg9M3fyt4bqzjlfC0x/coi9JesZ4dTxHoP1ud/lyyGQ5tfrPylE01VbkNs8uA1gASqJCzXd+8p+ukHhQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3FzvsI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3FzvsI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7350F1F000FF;
	Mon, 14 Sep 2026 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789419575;
	bh=pkkLWKr1D8KWgFHCKH+kgMuajHVOlrAuKOwzqdqLDNc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H3FzvsI7F0pTD37gbT750WQa7XRagij5r1buklT7T+xpoMAhS6EsuzL1e8ZWCYx0N
	 PpFJm3uJ9+HSUeR2bW2owo/vdVx4ogTdTCpqSAgjTSJFZlK5kNeFzupT54y4DEbBjW
	 PmlTUMBalZp06IdZCBhPgKmkhp+5e4YshRQdKzfS1vS/Y0ylX/SpWYH86hNDFEkFln
	 iT4Nw+CqCt+TuSSFeppcgr6zVzG7xyEZrLHdWlbB/zXyZ2hPzIXmzNC2ZZxFHrIgSa
	 1IfZ6LpI5n8tO2bd47+BfRflnzwdP1tXgyVQTTJmZoMKAU5J2+pSENQd6Rb7eThfsd
	 UNH++eCrUSJvQ==
Subject: Re: [PATCH net-next] net: phy: marvell: undo WoL setup when
 Wake-on-LAN is disabled
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 20:59:35 +0000
Message-ID: <178941957502.22033.16832742571502760649@kernel.org>
In-Reply-To: <20260913205751.81163-1-rosenp@gmail.com>
References: <20260913205751.81163-1-rosenp@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] The new 'undo' block in m88e1318_set_wol()
  (drivers/net/phy/marvell.c:2094-2103) unconditionally rewrites the…
- [Low] The patch presents itself as a fix for released behaviour
  (CSIER.WOL_EIE left set and LED[2] left muxed as INTn after a full…

--

net: phy: marvell: undo WoL setup when Wake-on-LAN is disabled

When all WoL options are cleared, m88e1318_set_wol() now clears
CSIER.WOL_EIE on the copper page and rewrites the LED[2]/INTn pin control
bits in page 3 register 0x12 (MII_88E1318S_PHY_LED_TCR), setting
INTn_ENABLE and INT_ACTIVE_LOW when phy_interrupt_is_valid() is true and
clearing them otherwise.  FORCE_INT is always cleared.

Two questions below, one about the LED_TCR rewrite and one about missing
provenance metadata.

[Severity: Low]

>     Fully disabling Wake-on-LAN on the 88E1318S/88E1510 used to leave
>     the WoL interrupt enable bit (CSIER.WOL_EIE) set and LED[2]
>     configured as the INTn pin. A magic packet arriving after "wol d"
>     would still assert INTn, and a later "wol g" re-enabled WoL from a
>     dirty register state.

This describes a defect in released behaviour, but there is no Fixes: tag.

The leftover state comes from the original 88E1318S WoL support, commit
3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN"), which
added m88e1318_set_wol() with the CSIER.WOL_EIE and LED[2]-as-INTn setup
and no matching teardown in the disable branch.  m88e1318_set_wol() is the
.set_wol callback for both the 88E1318S and the 88E1510 entries.

Would it make sense to add:

  Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")

or, if no backport is wanted, to state in the changelog that the residual
register state is cosmetic?

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..6f7c190880f2e 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -2074,6 +2074,35 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  			goto error;
>  	}
>  
> +	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
> +		/* Fully disabled: undo the WoL interrupt setup done above,
> +		 * so a later re-enable starts from a clean state.
> +		 */
> +		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +		if (err < 0)
> +			goto error;
> +
> +		err = __phy_clear_bits(phydev, MII_88E1318S_PHY_CSIER,
> +				       MII_88E1318S_PHY_CSIER_WOL_EIE);
> +		if (err < 0)
> +			goto error;
> +
> +		err = marvell_write_page(phydev, MII_MARVELL_LED_PAGE);
> +		if (err < 0)
> +			goto error;
> +
> +		err = __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
> +				   MII_88E1318S_PHY_LED_TCR_FORCE_INT |
> +				   MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
> +				   MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW,
> +				   phy_interrupt_is_valid(phydev) ?
> +					MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
> +					MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW :
> +					0);
> +		if (err < 0)
> +			goto error;
> +	}

[Severity: High]

Can this de-mux an INTn pin that is still in use on PHY_MAC_INTERRUPT
devices?

phy_interrupt_is_valid() in include/linux/phy.h is false for both PHY_POLL
and PHY_MAC_INTERRUPT:

  static inline bool phy_interrupt_is_valid(struct phy_device *phydev)
  {
	  return phydev->irq != PHY_POLL && phydev->irq != PHY_MAC_INTERRUPT;
  }

For PHY_MAC_INTERRUPT the PHY does drive its interrupt output, it is just
serviced by the MAC driver rather than by phylib.  In that case this
__phy_modify() clears INTn_ENABLE (the LED[2] pin mux) and INT_ACTIVE_LOW
(the polarity), so the pin stops being the interrupt output.

Does anything put those bits back afterwards?  m88e1318_config_init(),
which the 88E1510 reaches through m88e1510_config_init(), programs them
only in the interrupt-valid case:

  static int m88e1318_config_init(struct phy_device *phydev)
  {
	  if (phy_interrupt_is_valid(phydev)) {
		  int err = phy_modify_paged(
			  phydev, MII_MARVELL_LED_PAGE,
			  MII_88E1318S_PHY_LED_TCR,
			  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
			  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
			  MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
  ...

And PHY_MAC_INTERRUPT is not polled either, since marvell.c defines no
.update_stats and phy_polling_mode() then only returns true for PHY_POLL.
So link state changes would be neither interrupt-delivered nor polled
until the next config_init or hardware reset.

The block also runs for calls that never armed WoL at all, for example a
plain "ethtool -s ethX wol d" on a fresh interface, or a MAC driver
passing wolopts == 0 on shutdown or resume:

  ethtool_set_wol() -> MAC .set_wol -> phy_ethtool_set_wol() ->
  m88e1318_set_wol(wolopts == 0)

so the pin function can be changed on a device where this driver never
touched LED_TCR.  The same applies to a LED_TCR value set by strap or
bootloader, or by the DT "marvell,reg-init" property, which
marvell_of_reg_init() applies as arbitrary <page reg mask value> tuples and
can legitimately target page 3 register 0x12.

Related to that, the changelog says the patch will "restore LED[2] to its
prior use", but the enable path only does:

  /* Setup LED[2] as interrupt pin (active low) */
  err = __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
		     MII_88E1318S_PHY_LED_TCR_FORCE_INT,
		     MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
		     MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);

with no read of the previous value, so the undo path writes an assumed
value rather than the prior one.

Would it work to read and save the INTn_ENABLE/INT_ACTIVE_LOW bits when
WoL is armed and write those saved bits back here, or alternatively to
restrict the undo to the bits this driver itself set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913205751.81163-1-rosenp%40gmail.com
