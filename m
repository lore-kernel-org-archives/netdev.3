Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB363B6BE3;
	Thu, 17 Sep 2026 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680288; cv=none; b=lfr3Stzi4N+3ogXFqp8N9ZkytwGIoT2RR23rYkZGXCE7uCfgxHcfDJGzpC+lLPgKaVrrbP+hhrHFi/JJ8v6eAkvoltCWVEk1Wf+0td4A1j7sxHPF5w4j5/9EaSYuIH9PZhrlYYVNCvtB9wj38Lg2cEnkVUPulscz9FkMsLhX+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680288; c=relaxed/simple;
	bh=TNwhmIBxQcNYfQT7JGuM9tGSuG3us0izjxrDU379qlA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TUJC8ui8qPHJytUrlSbxdMx2xk25xm76Sk+b1OxCtrB/4e+5bFwC+nZIkJkMmczwgKH8aMdA6b6fBPQ4MV+OlZomAVqle1J6KxZ06e2S/dd24XYj7sdBCCaDENQZaaTjcTzw+klLZLJN7P/KgAfMBOz7euaua9Ms0Y4/pbCojKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnu2KiXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnu2KiXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B801F000FF;
	Thu, 17 Sep 2026 21:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680287;
	bh=qRh5+HX2LICNC5Xn2ZadXM5nijMZ4VnuqEMdBJ68CVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lnu2KiXua+aKRtNhRtIb4bgCA+pKS9yknbq8Vh43z2GpwM16jxq/oJkdB4W1wtyVb
	 0JyFd7yIskNolH1502kmSCBa4qjmc7+emsu8VeOgDRQMJIoRYb43Yd1HCxadszwWx4
	 mcgYNmcrT9SPvsxtAFapOeMGXQWjGiemtu+580cIm4YpRZ6pAZcg8qLyHa6hWUMrQ0
	 J/NvT3N0EQi8Mz5xwqvcA1FeWbCqPwTmH5Tpd0F/ykCsMm3K37cvPq4LLa3jxc+7nu
	 cuZWFtvrfucmFEHqP6j5FxuiH+ZIvFMztSY23xwpo/H5hX9ihxy3DoOKqgLLCANBcT
	 MxWOxNi/tT46A==
Subject: Re: [PATCHv2 net] net: phy: marvell: undo WoL setup when Wake-on-LAN
 is disabled
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 21:24:46 +0000
Message-ID: <178968028619.22033.8310581527936458694@kernel.org>
In-Reply-To: <20260914212409.74539-1-rosenp@gmail.com>
References: <20260914212409.74539-1-rosenp@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

- [Medium] The new arm/disarm pairing for the LED[2]/INTn pin mux keeps
  its bookkeeping (priv->wol_led_armed, priv->wol_led_tcr) in devm-…
- [Low] The comment added at drivers/net/phy/marvell.c:2097-2103 makes
  three statements the adjacent code does not implement.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it directly
  undermines the register-state guarantee the patch adds and should be…

--

net: phy: marvell: undo WoL setup when Wake-on-LAN is disabled

When all WoL options are cleared, m88e1318_set_wol() now clears
CSIER.WOL_EIE on the copper page and restores the LED[2]/INTn pin mux to
the value that was read when WoL was first armed. The saved value and an
"armed" flag are kept in struct marvell_priv.

A few questions about the new save/restore mechanism below.

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..64862f12eb42f 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -354,6 +354,8 @@ struct marvell_priv {
>  	u32 step;
>  	s8 pair;
>  	u8 vct_phase;
> +	u16 wol_led_tcr;
> +	bool wol_led_armed;
>  };
>  
>  static int marvell_read_page(struct phy_device *phydev)

[ ... ]

> @@ -2000,6 +2003,22 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  		if (err < 0)
>  			goto error;
>  
> +		/* Remember the LED[2]/INTn mux before forcing the pin to
> +		 * INTn, so it can be restored when WoL is disabled again.
> +		 * Only save it once, or a re-enable would overwrite the
> +		 * value read before WoL was first armed.
> +		 */
> +		if (!priv->wol_led_armed) {
> +			err = __phy_read(phydev, MII_88E1318S_PHY_LED_TCR);
> +			if (err < 0)
> +				goto error;
> +
> +			priv->wol_led_tcr = err &
> +				(MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
> +				 MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
> +			priv->wol_led_armed = true;
> +		}

[Severity: Medium]
Can the saved mux value survive an unbind while WoL is still armed?

priv is devm-allocated in marvell_probe():

	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
	if (!priv)
		return -ENOMEM;

	phydev->priv = priv;

marvell.c has no .remove callback in any of its phy_driver entries, and
m88e1318_set_wol() is only reachable from phy_ethtool_set_wol(), never
from detach or unbind with wolopts == 0.

So for the sequence "ethtool -s eth0 wol g", then unbind the PHY driver
(sysfs unbind or module unload), then bind again:

  - CSIER.WOL_EIE stays set and LED[2] stays muxed to INTn in hardware
  - priv, and with it wol_led_tcr / wol_led_armed, is freed
  - the fresh priv from devm_kzalloc() has wol_led_armed == false

The next "wol g" then snapshots the already-forced
INTn_ENABLE | INT_ACTIVE_LOW value as the pristine one, and the following
"wol d" restores exactly the forced value, so the pin can no longer be
returned to its LED function.

Should the saved state be re-derived from hardware, or the WoL setup
disarmed at driver teardown, so the arm/disarm pairing is balanced over the
device lifetime?

Also, priv->wol_led_armed = true is set before the __phy_modify() below
that actually forces the pin. If that MDIO write fails, the flag stays
latched true and the if (!priv->wol_led_armed) guard above prevents the
snapshot from ever being refreshed. Is that intentional?

>  
>  		/* Setup LED[2] as interrupt pin (active low) */
>  		err = __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
>  				   MII_88E1318S_PHY_LED_TCR_FORCE_INT,

[ ... ]

> @@ -2074,6 +2093,41 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  			goto error;
>  	}
>  
> +	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
> +		/* Fully disabled: undo the WoL interrupt setup done above,
> +		 * so a later re-enable starts from a clean state. The
> +		 * LED[2]/INTn pin mux is only touched when it was forced
> +		 * to INTn here, and is restored to the value read at
> +		 * arming time; PHYs serving the MAC interrupt, straps, or
> +		 * marvell,reg-init values are left alone.
> +		 */

[Severity: Low]
This isn't a bug in the register programming, but does this comment match
what the code does?

"only touched when it was forced to INTn here": priv->wol_led_armed is set
unconditionally in the arm block, not only when the pin actually had to be
switched. On a PHY where m88e1318_config_init() already selected the INTn
function:

	if (phy_interrupt_is_valid(phydev)) {
		int err = phy_modify_paged(
			phydev, MII_MARVELL_LED_PAGE,
			MII_88E1318S_PHY_LED_TCR,
			MII_88E1318S_PHY_LED_TCR_FORCE_INT,
			MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
			MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);

the disable path still writes LED_TCR. The written value happens to match
what config_init programmed, so only the comment seems off.

"restored to the value read at arming time" and "marvell,reg-init values
are left alone" do not hold for MII_88E1318S_PHY_LED_TCR_FORCE_INT, see
the restore below.

> +		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +		if (err < 0)
> +			goto error;
> +
> +		err = __phy_clear_bits(phydev, MII_88E1318S_PHY_CSIER,
> +				       MII_88E1318S_PHY_CSIER_WOL_EIE);
> +		if (err < 0)
> +			goto error;

[Severity: High]
This isn't a bug introduced by this patch, but it seems to defeat the
register-state guarantee the patch is adding, so perhaps it needs to be
resolved together with it.

Copper page register 0x12 has two names in this driver, MII_M1011_IMASK
and MII_88E1318S_PHY_CSIER, and no single owner. m88e1318_set_wol()
touches only BIT(7) with a read-modify-write, while
marvell_config_intr() rewrites the whole register:

	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
		...
		err = phy_write(phydev, MII_M1011_IMASK,
				MII_M1011_IMASK_INIT);
	} else {
		err = phy_write(phydev, MII_M1011_IMASK,
				MII_M1011_IMASK_CLEAR);

Neither MII_M1011_IMASK_INIT (0x6400) nor MII_M1011_IMASK_CLEAR (0x0000)
contains MII_88E1318S_PHY_CSIER_WOL_EIE.

On an interrupt-driven 88E1510 (for example behind mvneta, .config_intr =
marvell_config_intr), can this drop WoL arming behind the user's back?

  ethtool -s eth0 wol g
    m88e1318_set_wol()        /* sets CSIER.WOL_EIE, forces LED[2] */

  ip link set eth0 down
    mvneta_stop()
      mvneta_mdio_remove()
        phylink_disconnect_phy()
          phy_disconnect()
            phy_free_interrupt()
              phy_disable_interrupts()
                phy_config_interrupt(PHY_INTERRUPT_DISABLED)
                  marvell_config_intr()   /* writes 0x0000 to reg 0x12 */

After that, the WOL page magic packet matcher is still enabled and
m88e1318_get_wol() still reports WAKE_MAGIC, but WOL_EIE is gone, so a
matched magic packet is no longer routed to INTn/LED[2] and the board does
not wake.

Two consequences for this patch: the new clear of WOL_EIE here is a no-op
on those PHYs, so the "clean state" the comment promises only holds for
polled and MAC-interrupt PHYs. And marvell_handle_interrupt() masks
MII_M1011_IEVENT with MII_M1011_IMASK_INIT:

	if (!(irq_status & MII_M1011_IMASK_INIT))
		return IRQ_NONE;

so a WoL event bit outside 0x6400 is never claimed anyway.

Would it make sense for marvell_config_intr() to preserve WOL_EIE with a
read-modify-write, the same way this patch preserves the LED_TCR bits it
does not own, or for set_wol to not depend on that bit?

> +
> +		if (!priv->wol_led_armed)
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
> +				   priv->wol_led_tcr);

[Severity: Low]
Continuing the comment question above: the write mask here includes
MII_88E1318S_PHY_LED_TCR_FORCE_INT, but the snapshot taken in the arm path
deliberately excludes it:

	priv->wol_led_tcr = err &
		(MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
		 MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);

So FORCE_INT is driven to 0 unconditionally rather than to "the value read
at arming time". The arm path already cleared FORCE_INT before this patch,
and the commit message explains why FORCE_INT is not re-set, so the
register content does not look newly damaged; it is the comment's
guarantee about that bit, and about straps and marvell,reg-init being left
alone, that appears inaccurate.

Could the comment be reworded to say which LED_TCR bits the WoL path
actually owns?

> +		if (err < 0)
> +			goto error;
> +
> +		priv->wol_led_armed = false;
> +	}
> +
>  error:
>  	return phy_restore_page(phydev, oldpage, err);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914212409.74539-1-rosenp%40gmail.com
