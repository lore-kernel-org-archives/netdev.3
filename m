Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5F3B9D98;
	Sun, 11 Oct 2026 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744114; cv=none; b=UNCmXINh5YUkicMCdGOIaE5hk3YRIODfzbtc7mpCz5CmW7RTNhoO4cvNkme7haS0p2VG1nVUUxcTURNOHroOXpExqFGsBJNYNRR7Umq6qcgYvPfHtyezZ/FOr6wG3sgWaqw62qHz8FNfre378C0C5wed+3YH8W2QGv99aPqlNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744114; c=relaxed/simple;
	bh=iY7SMJ461J5a0HbSPspsgidRLbSNAtJAZYh4OOrj0FE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSR7jcAA/B8JID4Jr8ZeHzJC3FN3gZx8/0124ZuAFimc5KlS5YfUhK+ROpLmQo0jH4JWSTLhv1LiYO0EDVlDqPDM78lWUmb+vKb+0I/1IPA00bGqtkvUyBHcNmJVwK3zWcdz1G8E63oEohpbHLkKCPhkloZRZBToGzthBEaUMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kharT071; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kharT071"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41251F0089B;
	Sun, 11 Oct 2026 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791744112;
	bh=jlysSDOvX4H1NLHGTcF+nWbYZRbxbFvSP4RI18s01i4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kharT071spnlSCOMZbefMoYIob16njWJ2ugwVf8UWFJ8Yji74jpD4MT0XofruIT5j
	 Z7Rn5V3pYCfLL0TA1KBGo8Fxd+U63ziBXdkvCiPMYiyD5z/JJqfZ3oUCsDoUB4Nif1
	 xn5Wiqcyx77hd7f1RjX5B5Fa+rIQtpf0IoMH/s1a92ds4OitcJ2WRoIXn42Y0MAs6r
	 tJtg+rWz2F7qYH7/W5T7yTkNW+Wh8KrJlMjhqy+qhub/BD8WknvfoCH+wIOrQNcfAp
	 4MjpDrITqysdFp2Mkgi73jQ/cZYMPNu8nOhZCgCb/Im7QjgD5k7Ze20C7F8ya4n6hy
	 3IFUfoymrkc9Q==
Subject: Re: [PATCH net v4] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 18:41:51 +0000
Message-ID: <179174411147.434549.2654980027036919923@kernel.org>
In-Reply-To: <20261007182112.821061-1-rosenp@gmail.com>
References: <20261007182112.821061-1-rosenp@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch applies 88E1318S/88E1510 bit-7 semantics to every
  Marvell PHY that shares…
- [Medium] marvell_config_intr() with phydev->interrupts ==
  PHY_INTERRUPT_DISABLED no longer clears WOL_EIE (reg 0x12 bit 7), so…

--

net: phy: marvell: keep WOL_EIE across interrupt reconfiguration

This commit switches marvell_config_intr() to phy_modify(), so bit 7
(WOL_EIE) of the interrupt enable register survives interrupt
reconfiguration and only m88e1318_set_wol() changes it. It also makes
m88e1318_set_wol() clear the bit when WoL is disabled, and extends the
shared marvell_handle_interrupt() to claim WoL events.

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..5f9a43a4a0634 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -55,6 +55,12 @@
>  #define MII_M1011_IMASK			0x12
>  #define MII_M1011_IMASK_INIT		0x6400
>  #define MII_M1011_IMASK_CLEAR		0x0000
> +#define MII_M1011_IMASK_WOL		BIT(7)
> +/* Bits updated by config_intr. The WoL interrupt enable is owned by
> + * set_wol, so the config_intr call from phy_init_hw() on resume does not
> + * silently disarm Wake-on-LAN.
> + */
> +#define MII_M1011_IMASK_CONFIG_MASK	(U16_MAX & ~MII_M1011_IMASK_WOL)

[ ... ]

> @@ -393,11 +394,13 @@ static int marvell_config_intr(struct phy_device *phydev)
>  		if (err)
>  			return err;
>  
> -		err = phy_write(phydev, MII_M1011_IMASK,
> -				MII_M1011_IMASK_INIT);
> +		err = phy_modify(phydev, MII_M1011_IMASK,
> +				 MII_M1011_IMASK_CONFIG_MASK,
> +				 MII_M1011_IMASK_INIT);
>  	} else {
> -		err = phy_write(phydev, MII_M1011_IMASK,
> -				MII_M1011_IMASK_CLEAR);
> +		err = phy_modify(phydev, MII_M1011_IMASK,
> +				 MII_M1011_IMASK_CONFIG_MASK,
> +				 MII_M1011_IMASK_CLEAR);

[Severity: Medium]
The disable branch now keeps bit 7. Does phy_disable_interrupts() still
quiet the PHY when WoL is armed?

phy_free_interrupt() expects the PHY to be quiet before it removes the
handler:

drivers/net/phy/phy.c:phy_free_interrupt() {
	...
	phy_disable_interrupts(phydev);
	free_irq(phydev->irq, phydev);
	...
}

Consider an 88E1318S or 88E1510 that uses a PHY IRQ:

ethtool -s ethX wol g
  m88e1318_set_wol()
    sets MII_M1011_IMASK_WOL, routes LED[2] as active-low INTn

interface stopped, MAC driver calls phy_disconnect()
  phy_free_interrupt()
    marvell_config_intr()   /* bit 7 stays enabled */
    free_irq()

The PHY stays powered here, because phy_suspend() returns -EBUSY when
WoL is enabled.

A later magic packet or link-up event then latches IEVENT bit 7. The
comment in m88e1318_set_wol() says INTn stays asserted until IEVENT is
read, and after free_irq() nothing reads it.

phy_request_interrupt() requests the IRQ with IRQF_ONESHOT | IRQF_SHARED.
If that level-triggered line is shared with another device, such as a
sibling PHY, could this cause an interrupt storm until the spurious IRQ
detector disables the line for every device on it?

The same applies to phy_probe(), which calls phy_disable_interrupts()
before any handler is registered. That call used to write 0x0000 to
MII_M1011_IMASK, which cleared a WOL_EIE left by a previous boot or
kexec. Now the bit stays set.

After this patch, the new block in m88e1318_set_wol() is the only code
that clears the bit, and it only runs on an explicit wol d. Should the
teardown and probe paths still clear MII_M1011_IMASK_WOL?

>  		if (err)
>  			return err;
>  
> @@ -417,7 +420,7 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
>  		return IRQ_NONE;
>  	}
>  
> -	if (!(irq_status & MII_M1011_IMASK_INIT))
> +	if (!(irq_status & (MII_M1011_IMASK_INIT | MII_M1011_IMASK_WOL)))
>  		return IRQ_NONE;

[Severity: Medium]
The commit message says:

  The interrupt register layout is the same across the PHYs this driver
  handles, so extend the shared handler to also claim a WoL event instead
  of adding a per-PHY one.

Is this true for bit 7?

About 21 entries in marvell_drivers[] use marvell_config_intr() and
marvell_handle_interrupt(). These include 88E1101, 88E1111, 88E1118,
88E1121R, 88E1145, 88E1240, 88E1540, 88E3016 and the 88E6xxx families.
Only the 88E1318S and 88E1510 entries have .set_wol = m88e1318_set_wol.

The in-tree Yukon definitions for 88E1111-class PHYs use bit 7 of this
register for a FIFO error, not a WoL event:

drivers/net/ethernet/marvell/skge.h:
	PHY_M_IS_FIFO_ERROR	= 1<<7, /* FIFO Overflow/Underrun Error */

sky2.h has the same definition.

On the PHYs without set_wol, two things change.

First, MII_M1011_IMASK_CONFIG_MASK leaves bit 7 out of every config_intr
write. A bit 7 enable left by firmware, a bootloader or a previous
kernel is never cleared, even by config_intr() with
PHY_INTERRUPT_DISABLED.

Second, the handler now returns IRQ_HANDLED and calls
phy_trigger_machine() whenever IEVENT bit 7 is set. This happens even on
models where the driver never enabled that source.

Could the bit 7 handling be limited to the PHYs that support WoL, for
example with separate config_intr/handle_interrupt callbacks for the
88E1318S and 88E1510? If the shared change is intended, could the commit
message say that PHYs without WoL change behaviour too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007182112.821061-1-rosenp%40gmail.com
