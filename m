Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F06156661;
	Thu, 10 Sep 2026 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017673; cv=none; b=PFouMa0IBoDndmufxHp5QJ0B2YJfFVyPu7CLABmXREwAYlXItgb4adkLF05M6fatHSB3loz6Z8iQ9obuaCEYFMwP6YJ5s0S9iKKdxYM+3UiQT5P0AJL7+6cgI8havUAa+YAPtfYgQW35IQA28Ed9X4SLws33i5o1Cn5fDmmYVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017673; c=relaxed/simple;
	bh=VXN6MCx5an8S/Hg/iPw2QnElFLT2TutrQMu6Nt6xTxg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwDl2e02JjLFPzvf7i65TqxkV3wMc7LRce1/hE1gh32xPhbewoEKlHRvTmXdPkWzelfIi1/OWL6/ItqxUeMCvFnB0T35LtUsKH7E3zKkyv8ochCWxSlrdgLpVcg068JSbxwkVTnxNsdNG/xxkkjYnx7E3CIeHhKUru+egixS7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVymel3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVymel3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880071F000FF;
	Thu, 10 Sep 2026 05:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017671;
	bh=q4vZY3jUqrBDRsnql+7YW8P5EEgz09DuHJ4suadpLpY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cVymel3yByEtG33+vC6/Bs4gAr5QEXGid44RwaNiEoZb0wvKkxUJQQKabGgo1Eocp
	 KMz6AIbAvUxzcl+DfAUBR8H8bwID0R7+BaMGKEVEBQgScUiv7cRRnrfzCO4YQmlZHY
	 kd1vC/pCEBCEZU4fPj1KP19WxyYASDn+j1DJP4CFvHSd9UsvDnGMMf+Uv0XhlWUxo6
	 t+PKLi8dhnnz4m25SpZ7MWZQ9jkfOqEAK/wFERLcdGyCwj/TWr1N1EBmDf/pmpEbWd
	 N/PXg7tyiAuHwJ60UBGIqjidU4ZXefFQUGO0KI6Trrff4sJkT90YiKn6pw5UH6GWTz
	 +jyhiK2BAEENw==
Subject: Re: [PATCH net-next v2 1/4] net: phy: microchip_t1s: fix collision
 detection on PLCA status change
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Thu, 10 Sep 2026 05:21:10 +0000
Message-ID: <178901767002.219967.14737435173055374203@kernel.org>
In-Reply-To: <20260907052007.391972-2-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-2-parthiban.veerasooran@microchip.com>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 2

- [High] lan86xx_config_intr() (drivers/net/phy/microchip_t1s.c) read-
  clears the latched status register LAN86XX_REG_STS1 *before* unmasking…
- [Medium] lan86xx_plca_set_cfg() uses `if (phydev->irq != PHY_POLL)
  return 0;` as the predicate for 'the interrupt handler will keep CDEN…
- [Medium] In the PHY_POLL branch retained by this patch,
  lan86xx_plca_set_cfg() tests `if (plca_cfg->enabled)` on a tri-state…
- [Low] Reported concern (validated as RESOLVED later in this series,
  retained for the consolidation stage): 'For the LAN865X Rev.B0/B1…
- [Low] Reported concern (validated as RESOLVED later in this series,
  retained for the consolidation stage): 'LAN867X Rev.D0 uses…

--

net: phy: microchip_t1s: fix collision detection on PLCA status change

This adds lan86xx_config_intr() and lan86xx_handle_interrupt() to the
microchip_t1s driver so that the PLCA Status Changed (PSTC) interrupt drives
the collision detector enable bit in COL_DET_CTRL0.  The static CDEN write in
lan86xx_plca_set_cfg() is now only performed when phydev->irq is PHY_POLL.
The new handlers are wired to LAN867X Rev.B1/C1/C2 and the LAN865X Rev.B0/B1
internal PHY.

A few questions on the changelog and on the new code below.

> Wire these handlers to all supported PHY variants: LAN867X Rev.B1, C1,
> C2 and LAN865X Rev.B0/B1.

[Severity: Low]

LAN867X Rev.D0 also uses lan86xx_plca_set_cfg() as its .set_plca_cfg, but the
Rev.D0 entry does not get .config_intr/.handle_interrupt here.  Is "all
supported PHY variants" accurate for this patch?

Rev.D0 is covered by a later patch in the series ("net: phy: microchip_t1s:
fix collision detection for LAN867X Rev.D0"), which wires
lan867x_revd0_handle_interrupt() and programs CCMFC in
lan867x_revd0_config_init() so that collision forwarding is gated by
PLCA_Status in hardware.  Rev.D0 keeps its pre-patch behaviour at this commit,
so this is only about the changelog wording for the intermediate state.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 73c23d311d72a..afb7e52594e71 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c

[ ... ]

> @@ -458,6 +466,16 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  	if (ret)
>  		return ret;
>  
> +	/* PHYs with routed interrupts handle CDEN dynamically via the interrupt
> +	 * handler, so skip the static write. PHYs running with PHY_POLL have no
> +	 * interrupt handler, so apply the static CDEN write as a baseline on
> +	 * every ethtool PLCA reconfiguration. The limitation is that autonomous
> +	 * PLCA mode transitions between ethtool reconfigurations are not
> +	 * tracked on such boards.
> +	 */
> +	if (phydev->irq != PHY_POLL)
> +		return 0;
> +

[Severity: Medium]

Is phydev->irq != PHY_POLL the right predicate for "the interrupt handler
will keep CDEN up to date"?  phylib has a second non-interrupt sentinel:

include/linux/phy.h:
    static inline bool phy_interrupt_is_valid(struct phy_device *phydev)
    {
        return phydev->irq != PHY_POLL && phydev->irq != PHY_MAC_INTERRUPT;
    }

For phydev->irq == PHY_MAC_INTERRUPT phylib never calls
phy_request_interrupt(), so lan86xx_config_intr() is never called with
PHY_INTERRUPT_ENABLED and lan86xx_handle_interrupt() is never dispatched.
phy_mac_interrupt() only calls phy_trigger_machine().  phy_probe() also only
downgrades irq to PHY_POLL when phy_interrupt_is_valid() is true, so the
PHY_MAC_INTERRUPT value survives.

MAC drivers do set this sentinel on whatever PHY is attached, for example
tsnep_phy_open() in drivers/net/ethernet/engleder/tsnep_main.c does:

    adapter->phydev->irq = PHY_MAC_INTERRUPT;

On such a board, does anything write COL_DET_CTRL0 at all after this change,
given that the static write is skipped and the handler never runs?  Would
phy_interrupt_is_valid(phydev), or a test on phydev->interrupts, express the
intent more accurately here?

>  	if (plca_cfg->enabled)
>  		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
>  				      LAN86XX_REG_COL_DET_CTRL0,

[Severity: Medium]

This truthiness test isn't introduced by this patch, but the patch keeps this
path as the documented baseline for PHY_POLL boards, so it seems worth
raising: plca_cfg->enabled is tri-state, not boolean.

ethnl_set_plca() in net/ethtool/plca.c does memset(&plca_cfg, 0xff,
sizeof(plca_cfg)), and plca_update_sint() returns early when the netlink
attribute is absent, so an omitted enable attribute reaches the driver as -1.
genphy_c45_plca_set_cfg() only clears PLCA_EN for enabled == 0 and only sets
it for enabled > 0, so -1 leaves the PLCA mode untouched.

For a request such as:

    ethtool --set-plca-cfg <dev> node-id 5

on a PHY_POLL board, enabled is -1, which is truthy, so COL_DET_DISABLE is
written even though PLCA was left off.  Does that not leave collision
detection disabled while the PHY keeps running CSMA/CD, with no interrupt
handler to correct it?  Should the test be plca_cfg->enabled > 0?

> @@ -506,6 +524,77 @@ static int lan86xx_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int lan86xx_config_intr(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* Read to clear any pending status before enabling. */
> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* A mask bit of 0 enables the corresponding interrupt. */
> +		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
> +					  LAN86XX_REG_IMSK1,
> +					  LAN86XX_STS1_PLCA_STS_CHANGED);
> +	}

[Severity: High]

Can a PLCA status change be lost across the masked window here?  The enable
path reads STS1, which clears the latched PSTC event, and only then unmasks
PSTCM.  Nothing in the patch programs COL_DET_CTRL0 from the current
PLCA_STATUS value, so CDEN on an interrupt-capable PHY is driven purely by
PSTC edges once lan86xx_plca_set_cfg() returns early.

Sequence for LAN867X Rev.C1/C2 with a routed IRQ, on any MAC that connects
the PHY at ndo_open:

ifup     phy_request_interrupt() -> lan86xx_config_intr(enable)

ethtool  lan86xx_plca_set_cfg() sets PLCA_EN and returns early without
         touching CDEN; beacon present, PST 0->1 -> PSTC ->
         lan86xx_handle_interrupt() writes CDEN=0

ifdown   phy_disconnect() -> phy_free_interrupt() ->
         phy_disable_interrupts() -> lan86xx_config_intr(disable)
         masks PSTCM and read-clears STS1; PLCA_EN stays set in hardware
         since the driver has no .suspend

         coordinator stops beaconing, PST 1->0 latches PSTC under the mask

ifup     phy_init_hw() -> lan867x_revc_config_init(), which does not write
         0x0087, so CDEN stays 0; then lan86xx_config_intr(enable) reads
         STS1 and discards the pending PSTC before unmasking

Does the bus then run CSMA/CD with the collision detector disabled until some
future beacon both appears and disappears again?  That is the state the
changelog describes as the bug being fixed, and since lan86xx_plca_set_cfg()
no longer writes CDEN on such boards, is there any way for an administrator
to repair it by re-running ethtool?

lan865x_revb_config_init() also never writes 0x0087, so the same applies to
the LAN865X internal PHY.

Would sampling genphy_c45_plca_get_status() and programming CDEN from it when
interrupts are enabled, and in set_plca_cfg regardless of irq mode, close the
window rather than relying on edges only?

> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_IMSK1,
> +			       LAN86XX_STS1_PLCA_STS_CHANGED);
> +	if (ret)
> +		return ret;
> +
> +	/* Read to clear any pending status after disabling. */
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
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
> +	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
> +		ret = genphy_c45_plca_get_status(phydev, &plca_st);
> +		if (ret < 0) {
> +			phy_error(phydev);
> +			return IRQ_NONE;
> +		}
> +
> +		/* AN1760/AN1699: disable collision detection in PLCA mode to
> +		 * improve signal quality; re-enable it in CSMA/CD mode.
> +		 *
> +		 * https://www.microchip.com/en-us/application-notes/an1760
> +		 * https://www.microchip.com/en-us/application-notes/an1699
> +		 */
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				     LAN86XX_REG_COL_DET_CTRL0,
> +				     COL_DET_CTRL0_ENABLE_BIT_MASK,
> +				     plca_st.pst ? COL_DET_DISABLE :
> +				     COL_DET_ENABLE);
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

[ ... ]

> @@ -556,6 +651,8 @@ static struct phy_driver microchip_t1s_driver[] = {
>  		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
>  		.config_init        = lan865x_revb_config_init,
>  		.read_status        = lan86xx_read_status,
> +		.config_intr        = lan86xx_config_intr,
> +		.handle_interrupt   = lan86xx_handle_interrupt,

[Severity: Low]

At this commit oa_tc6 leaves phydev->irq as PHY_POLL for the LAN865X internal
PHY, so the changelog sentence "LAN865X is excluded from the static write
because its interrupt is always routed via the MAC-PHY SPI driver and the
interrupt handler always runs" does not hold yet.

The gap is closed inside the same series: "net: ethernet: oa_tc6: deliver the
PHY interrupt to phylib" adds an irq_domain, populates every mii_bus->irq[]
entry with the virtual IRQ before mdiobus_register(), and dispatches
handle_nested_irq(tc6->phy_virq) from the threaded IRQ when PHYINT is seen;
"microchip: lan865x: enable PHY interrupt via virtual IRQ" enables that path
for LAN8650/1.  Behaviour of LAN865X at this commit alone is unchanged,
because irq == PHY_POLL keeps the static CDEN write.

Could the changelog be reworded so that it does not assert a property that
only becomes true two patches later, in case this patch is backported on its
own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907052007.391972-1-parthiban.veerasooran%40microchip.com
