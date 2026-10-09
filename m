Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE493F1062;
	Fri,  9 Oct 2026 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525147; cv=none; b=dyKvVT6lrs7U5Jr5SmvcXF+5Mdk4is5YgRGiNFcsVbE7S1QcnfnJtpqcO7kXd8deyD08CXTtlxzehIINgVdS+iIbbrwcEjlVvNaErK06nkAG2dgt5tgn2GHs1phUqjWNoUZuUsTVCnAmO4nkdo6uJK1WxAff/u5z4nFC1WYXBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525147; c=relaxed/simple;
	bh=FOvH8w4C9wvY4okS7M3MXG/xmU9mgKI/kDapv4ZTltw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6gbAEuID1ibHoK8LL1eW2OdXdm862rKKyjHFZ9ZMdrri1VLHt/FwE53uzL7hlNuxT79UiUSPY22DrF3T2mb4tW6xnx2c8U+aBzc5otKmgpD5/e3EWkrnl0+sSbtrpUSic/aju7NqYFZQdRO7CdvPWuTVTel6gM70OwOHfDvUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXYu2lB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXYu2lB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BA11F000FF;
	Fri,  9 Oct 2026 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791525145;
	bh=/7dg6dToZwdakbPOV94KUonfQlPDX7kUrfbPFVUg5GY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OXYu2lB73Iq2XVmnFtMMVSekthwGDH1CaEefXVwE8oGTgF0+O82lz6rjShb7DR+a1
	 iKTFh5aMR4Cwy5MyucR6q737BVbJ1BzOfpYjdIxFsthWvskhKh6kMUSEfpnKRJHYqW
	 uvP1whvcvoLQo5dtbCm5mhxKI4xJFqEAwSv2LS9zyGk/8dMP9EbCyFsLM4TLganYt5
	 QKB3e8FlzYefFIDBld/R2iMDXo8Og/5OQJ7U/jzq6mTBlhCrFNZcLRhzpbQ1JUuATq
	 7oK5IueH9TbgzqZRhx5FPaoyh746VhhtSw7yo8knqHmjq/ewshlzD3t7Jwjm6FnFVj
	 ABfmBlLrTEFeg==
Subject: Re: [PATCH v3] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 05:52:24 +0000
Message-ID: <179152514441.434549.4140686458634721887@kernel.org>
In-Reply-To: <20261005225028.465866-1-rosenp@gmail.com>
References: <20261005225028.465866-1-rosenp@gmail.com>
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

- [Medium] The commit message says the interrupt register layout is the
  same across all PHYs this driver handles.
- [Medium] In the PHY_INTERRUPT_DISABLED branch, marvell_config_intr()
  now calls phy_modify(phydev, MII_M1011_IMASK,…

--

net: phy: marvell: keep WOL_EIE across interrupt reconfiguration

This patch makes marvell_config_intr() use phy_modify() with a mask that
leaves WOL_EIE alone. With that, the config_intr call from phy_init_hw() on
resume no longer disarms Wake-on-LAN on the 88E1318S and 88E1510. When WoL
is disabled, m88e1318_set_wol() now clears WOL_EIE itself, and the shared
marvell_handle_interrupt() also claims WoL events.

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..56650182bf3e4 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -55,6 +55,11 @@
>  #define MII_M1011_IMASK			0x12
>  #define MII_M1011_IMASK_INIT		0x6400
>  #define MII_M1011_IMASK_CLEAR		0x0000
> +/* Bits updated by config_intr. The WoL interrupt enable is owned by
> + * set_wol, so the config_intr call from phy_init_hw() on resume does not
> + * silently disarm Wake-on-LAN.
> + */
> +#define MII_M1011_IMASK_CONFIG_MASK	(U16_MAX & ~MII_88E1318S_PHY_CSIER_WOL_EIE)
>  
>  #define MII_M1011_PHY_SCR			0x10
>  #define MII_M1011_PHY_SCR_DOWNSHIFT_EN		BIT(11)
> @@ -393,11 +398,13 @@ static int marvell_config_intr(struct phy_device *phydev)
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
When interrupts are disabled, this branch no longer clears WOL_EIE. Does it
still meet the config_intr contract in include/linux/phy.h?

  @config_intr: Enables or disables interrupts.
  It should also clear any pending interrupts prior to enabling the
  IRQs and after disabling them.

The commit message only covers the resume path through phy_init_hw().
Teardown also reaches this branch:

phy_disconnect()
  phy_free_interrupt()
    phy_disable_interrupts()
      marvell_config_intr()   /* WOL_EIE is kept */
    free_irq()

Take an 88E1318S or 88E1510 in interrupt mode with WoL armed by
m88e1318_set_wol(). WOL_EIE stays set, and LED[2] is still routed as INTn
through MII_88E1318S_PHY_LED_TCR_INTn_ENABLE. Nothing undoes either one on
teardown.

Suppose a magic packet (WAKE_MAGIC) or a link-up event (WAKE_PHY) arrives
after ifdown. Can the PHY then assert the active-low INTn after its handler
has been freed? Nothing would be left to read MII_M1011_IEVENT and release
the pin.

phy_request_interrupt() requests the line with IRQF_ONESHOT | IRQF_SHARED.
If another device shares the line, could the IRQ core end up disabling the
line for that device as unhandled?

Before this patch, the disabled branch wrote 0x0000, which cleared WOL_EIE.
Would it work to keep WOL_EIE only across the resume reconfiguration, or to
track the WoL state and re-apply it after config_intr, and still clear it
in the disable path?

>  		if (err)
>  			return err;
>  
> @@ -417,7 +424,8 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
>  		return IRQ_NONE;
>  	}
>  
> -	if (!(irq_status & MII_M1011_IMASK_INIT))
> +	if (!(irq_status & (MII_M1011_IMASK_INIT |
> +			    MII_88E1318S_PHY_CSIER_WOL_EIE)))
>  		return IRQ_NONE;
>  
>  	phy_trigger_machine(phydev);

[Severity: Medium]
The commit message says:

  The interrupt register layout is the same across the PHYs this driver
  handles, so extend the shared handler to also claim a WoL event instead
  of adding a per-PHY one.

Does that hold for bit 7? drivers/net/ethernet/marvell/skge.h describes the
same registers (PHY_MARV_INT_MASK = 0x12, PHY_MARV_INT_STAT = 0x13), but
there bit 7 is a FIFO error:

  PHY_M_IS_FIFO_ERROR	= 1<<7, /* FIFO Overflow/Underrun Error */

skge's default interrupt mask also enables this bit.

About 20 entries in marvell_drivers[] share marvell_config_intr() and
marvell_handle_interrupt(): 88E1101, 88E1112, 88E1111, 88E1111 (Finisar),
88E1118, 88E1121R, 88E1145, 88E1149R, 88E1240, 88E1116R, 88E1540/1545,
88E3016, 88E1340S, 88E1548P and the 88E6xxx switch PHYs. Of these, only
88E1318S and 88E1510 have .set_wol.

On the other PHYs, MII_M1011_IMASK_CONFIG_MASK means config_intr never
clears bit 7 of register 0x12. If a bootloader or a marvell,reg-init entry
left it set, does it stay armed even after phylib asks config_intr to
disable interrupts (polling mode, phy_probe(), phy_free_interrupt())?
Nothing else in the driver manages bit 7 on these PHYs.

marvell_handle_interrupt() now also returns IRQ_HANDLED and triggers the
state machine for IEVENT bit 7 on all of these PHYs. On the older parts,
that bit is a FIFO over/underrun event the driver never enabled. Since
phylib requests the IRQ with IRQF_SHARED, could this also hide spurious
interrupt detection?

Would it be better to limit the bit 7 handling to the 88E1318S and 88E1510?
That could be their own config_intr/handle_interrupt callbacks, or a
per-driver mask.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005225028.465866-1-rosenp%40gmail.com
