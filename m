Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50EA2EEE96;
	Mon, 21 Sep 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033817; cv=none; b=CAZs1R5Qi5YmMpldJI9mt3z+Qc5KgvI+Tc1gVzO0JeSnRyXPmH1N8PaFH6R/r6MjiBbvCyu9+jAQ+tK4VSWUqUfZYyyy/njwLzwoJicjBnMtPUUj+jTGSdesVQpkL+MusI2L/M7hXJ7p3cv4+6kCZBGzi632JDzcoSCLmy2ehdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033817; c=relaxed/simple;
	bh=eVhLx5JcvytTWSse/SAhTACOe5zIdY7AHSl1kR7oBK0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNXTS1VbrKAn6V0PZX9srTaf20HcM3x/eObvogG0L/Q5+WVj81czYG+wPCzY2QinTR8WWD9Bpj2G1uconFmbiFhBh5f/UI88VYdn48MhXessPZ+xUf9yTtpdz+/lGNlutFveWx1lyjPwNWagf7HS9ySjkZV5sb4AF9wG5wxmt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPc+A1HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPc+A1HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01861F000FF;
	Mon, 21 Sep 2026 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033815;
	bh=iHBmFehPZ8zT7cRUD7Ckua8yxikfhCJCyZDOyMY5qWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aPc+A1HSvO8hGjDQElPpYUvpxG5gIDf0tAEP7ZlOCBea1+XPXk52J7HCZu5L+KCy/
	 60xaBDZ7Rd4kambCzY2tS+SGTmnH1FhCq7i3/heOSXYHi4TCvS16SWYRLgVN4VX7Xr
	 IO5+Cr1wyg57FWpDfLPiIle8Vnh1Biys92XEJYOtGQrq4cBAGyWCH8hId11TU97Jyi
	 18m4MC6ivL9l9+hewkFcGfJadTYPozLQOsWRl3v3bOt0qp8YldRsTdhASSjn35qg3M
	 hsBp2bs1oj+rVWkx5tc4OM78h5XyDES5VkNFhyw2dYhPDauybanXGbmbdQ+IAj6+n0
	 OhQ5tqc7PWdJg==
Subject: Re: [PATCH net] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 23:36:54 +0000
Message-ID: <179003381438.2160803.9735513848623011985@kernel.org>
In-Reply-To: <20260917220136.97017-1-rosenp@gmail.com>
References: <20260917220136.97017-1-rosenp@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] m88e1318_config_intr() deliberately keeps
  MII_88E1318S_PHY_CSIER_WOL_EIE set when phydev->interrupts ==…
- [Medium] Commit message misdescribes the trigger path.
- [Medium] After this patch no code in drivers/net/phy/marvell.c can ever
  clear MII_88E1318S_PHY_CSIER_WOL_EIE (BIT(7) of copper page register…

--

net: phy: marvell: keep WOL_EIE across interrupt reconfiguration

Copper page register 0x12 on the 88E1318S/88E1510 is both the interrupt
mask and the CSIER register holding the WoL interrupt enable bit, so the
patch gives those two PHYs a dedicated config_intr that preserves
MII_88E1318S_PHY_CSIER_WOL_EIE with a read-modify-write, plus a matching
handle_interrupt. Other Marvell PHYs keep marvell_config_intr() and
marvell_handle_interrupt().

A few questions below, first about the changelog and then about the new
disable path.

> On the 88E1318S/88E1510, copper page register 0x12 is both the
> MII_M1011_IMASK interrupt mask used by marvell_config_intr() and the
> CSIER register in which m88e1318_set_wol() arms the WoL interrupt
> (MII_88E1318S_PHY_CSIER_WOL_EIE). marvell_config_intr() rewrote the
> whole register, so any interrupt reconfiguration (for example the
> phy_disable_interrupts() on link down behind mvneta) silently cleared
> WOL_EIE

[Severity: Medium]
Is "the phy_disable_interrupts() on link down behind mvneta" accurate?
phy_disable_interrupts() has only two callers:

drivers/net/phy/phy_device.c:phy_probe()
drivers/net/phy/phy.c:phy_free_interrupt()

	void phy_free_interrupt(struct phy_device *phydev)
	{
		phy_disable_interrupts(phydev);
		free_irq(phydev->irq, phydev);
	}

and for mvneta the only route into phy_free_interrupt() is
mvneta_stop() -> mvneta_mdio_remove() -> phylink_disconnect_phy() ->
phy_disconnect().  Link state changes go through the phylink resolve /
mac_link_down path and do not call config_intr at all.

So is the reproducer ifdown/ifup (and probe) rather than a link flap?
Note also that the enable side, phy_request_interrupt() ->
phy_enable_interrupts(), rewrites the same register, which the changelog
does not mention.

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..0897cfcd6ab70 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -425,6 +425,68 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * On the 88E1318S/88E1510, copper page register 0x12 serves two
> + * masters: it is the MII_M1011_IMASK interrupt mask for the generic
> + * Marvell interrupt handling, and m88e1318_set_wol() sets the WoL
> + * interrupt enable bit (MII_88E1318S_PHY_CSIER_WOL_EIE) in it. The
> + * interrupt routines below therefore preserve that bit, so reconfiguring
> + * the PHY interrupts cannot disarm Wake-on-LAN behind the user's back.
> + */

[Severity: Medium]
Same framing question here as in the changelog: since this callback only
runs from phy_probe(), phy_request_interrupt() and phy_free_interrupt(),
would it be clearer to say the bit is preserved across probe, ifup and
ifdown instead of "reconfiguring the PHY interrupts"?

> +static int m88e1318_config_intr(struct phy_device *phydev)
> +{
> +	int val, err;
> +
> +	val = phy_read(phydev, MII_88E1318S_PHY_CSIER);
> +	if (val < 0)
> +		return val;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		err = marvell_ack_interrupt(phydev);
> +		if (err < 0)
> +			return err;
> +
> +		err = phy_write(phydev, MII_88E1318S_PHY_CSIER,
> +				MII_M1011_IMASK_INIT |
> +				(val & MII_88E1318S_PHY_CSIER_WOL_EIE));
> +	} else {
> +		/* Disable the PHY interrupts, but keep WOL_EIE set so an
> +		 * armed magic packet still asserts INTn while the
> +		 * interface is down or the machine is suspended.
> +		 */
> +		err = phy_write(phydev, MII_88E1318S_PHY_CSIER,
> +				val & MII_88E1318S_PHY_CSIER_WOL_EIE);

[Severity: High]
Is it safe to leave WOL_EIE armed in the PHY_INTERRUPT_DISABLED branch,
given what phylib does right after calling it?

	void phy_free_interrupt(struct phy_device *phydev)
	{
		phy_disable_interrupts(phydev);
		free_irq(phydev->irq, phydev);
	}

After ifdown the WoL matcher is still enabled (m88e1318_set_wol() only
clears MAGIC_PACKET_MATCH_ENABLE when the user disables WoL), so a magic
packet can assert INTn once the handler is gone.  The existing comment in
m88e1318_set_wol() says that assertion is latched:

	/* If WOL event happened once, the LED[2] interrupt pin
	 * will not be cleared unless we reading the interrupt status
	 * register.

and reading MII_M1011_IEVENT is exactly what only the freed handler does.

Since phy_request_interrupt() asks for the line with

	request_threaded_irq(phydev->irq, NULL, phy_interrupt,
			     IRQF_ONESHOT | IRQF_SHARED,
			     phydev_name(phydev), phydev);

can a shared level-triggered line end up permanently asserted here, with
the co-user's handler returning IRQ_NONE until genirq's "nobody cared"
logic disables the line for that other device too?

Related question about the probe side: phy_probe() also calls
phy_disable_interrupts() before any IRQ has been requested, so this branch
now carries over a WOL_EIE left set by the bootloader or a previous module
load.  Was that intended?

Since WoL across suspend goes through phy_suspend()/drv->suspend rather
than config_intr, could the bit be preserved only where the WoL arming
needs it, instead of in the generic interrupt-disable callback?

[Severity: Medium]
With both branches writing back "val & MII_88E1318S_PHY_CSIER_WOL_EIE", is
there anything left in marvell.c that can clear bit 7 of copper register
0x12?

m88e1318_set_wol() only ever sets it, inside the wolopts branch:

	err = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
			     MII_88E1318S_PHY_CSIER_WOL_EIE);

and the WoL-disable branches touch only MII_88E1318S_PHY_WOL_CTRL on the
WoL page.  The unconditional write in marvell_config_intr():

	err = phy_write(phydev, MII_M1011_IMASK,
			MII_M1011_IMASK_CLEAR);

was the only path that returned bit 7 to zero, and these two PHYs no
longer use it.

So after a single "ethtool -s ethX wol g" does WOL_EIE stay set for the
lifetime of the PHY, including after "ethtool -s ethX wol d"?
m88e1318_get_wol() derives wolopts from the WoL-page WOL_CTRL bits only:

	ret = phy_read_paged(phydev, MII_MARVELL_WOL_PAGE,
			     MII_88E1318S_PHY_WOL_CTRL);

so userspace would report wol=d while CSIER bit 7 remains armed.  Should
m88e1318_set_wol()'s disable path clear WOL_EIE so the preservation in
config_intr has a matching clear?

> +		if (err < 0)
> +			return err;
> +
> +		err = marvell_ack_interrupt(phydev);
> +	}
> +
> +	return err;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917220136.97017-1-rosenp%40gmail.com
