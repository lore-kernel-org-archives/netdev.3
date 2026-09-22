Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5F50B406;
	Tue, 22 Sep 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089713; cv=none; b=ecziwKLWMejSrpNvGJv0M9t7x4FwzsJh4a7u8GrVVrJ92pyHni6fuBHvq4vLBta3R7QbLvUd741kGGdvZryEnkXWd+dQ7Yw7AjGenD3gYthXaK1bKMfAmPpdi9Hq6MFooMWwygAIx0WnSEdI/0tyzukjjVx0qsnXfFykL2+A6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089713; c=relaxed/simple;
	bh=w+xvLgp2+JUP+Fu6aFfy1MQsFKcTvVTVkb+gntdDMws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZkozIK2F2pWQaoigaYdA9k+8UDBVjLqH+u1fDZ9klLmYVhBE0k2HdJ6utvlsbkIxHHNZdyS1Do2MQGPou3kIejRH5B0BXW9btmuf0mvHersvIMqSv1t044CAd38qgUniM6LMfsNZ5HEAy/y3uis3cC498WFWzN3L5u4JqfmLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLuM3K6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLuM3K6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85B11F00898;
	Tue, 22 Sep 2026 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089709;
	bh=eWmLq4fU3v6mBggr7PLLZTneC/1FPEfuxir1l3TQXMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VLuM3K6l4TTgsxXk7/5dRXOaNOyrhgJE9QzljWn0w/0kJoarkQP4twB1ncFL5K3+f
	 G8Ng6jOobZtlO3PuwcLIGNTnz3WUOQK+yIl7hEpIpqtjZBgfj/LPWs+Z1ybHCqihOv
	 1nnsBM+NESyDoSJM6D5Wh9bAaz9CKaN/GD5lMue/mEu8fSEAuyavAd9MyyU4KIYCCh
	 ELOCKpHPKVQxa5MxTF5jhZ94npgZ0O8PXYngwhK/O5JiZgPSST3S6qam1FGMDLz3DC
	 lFlc4FknBBaT0D9DZVqbNTAenC+yP2798ZERqGVbhZBSsdExpY/oqAYLDxoDRUDZlk
	 JKrG+MMsjtRJw==
Subject: Re: [PATCH net-next v3 3/4] microchip: lan865x: enable PHY interrupt
 via virtual IRQ
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Tue, 22 Sep 2026 15:08:28 +0000
Message-ID: <179008970849.2160803.3591849994245456823@kernel.org>
In-Reply-To: <20260918143302.76909-4-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-4-parthiban.veerasooran@microchip.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message's final paragraph is factually wrong about how
  collision detection is initialized: "lan865x_revb_fixup_registers[]…
- [Low] Reported concern: enabling OA_TC6_PHY_INT routes PHY IRQ
  mask/unmask through oa_tc6_phy_irq_mask()/unmask()…

Pre-existing issues:
- [High] lan865x_remove()
  (drivers/net/ethernet/microchip/lan865x/lan865x.c:420) calls…

--

microchip: lan865x: enable PHY interrupt via virtual IRQ

This passes the OA_TC6_PHY_INT quirk flag to oa_tc6_init() so the LAN865X
internal PHY interrupt, delivered as STATUS0.PHYINT, is exposed to phylib
as a virtual IRQ.  That lets phylib run the PHY driver's config_intr and
handle_interrupt callbacks instead of polling.

A few questions below, one about the commit message and two about the
code paths this flag now activates.

> lan865x_revb_fixup_registers[] does not program COL_DET_CTRL0
> (0x0087), so CDEN correctness relies on that bit's hardware reset
> default together with lan86xx_handle_interrupt() tracking every
> subsequent PLCA transition via the PSTC interrupt this patch enables.

[Severity: Low]
Is the reliance on the reset default accurate here?  Once this patch makes
the PHY IRQ valid, phy_request_interrupt() calls phy_enable_interrupts(),
which reaches lan86xx_config_intr() in drivers/net/phy/microchip_t1s.c,
and that callback programs COL_DET_CTRL0 from the live PLCA status before
unmasking PSTC:

drivers/net/phy/microchip_t1s.c:lan86xx_config_intr() {
	...
	ret = genphy_c45_plca_get_status(phydev, &plca_st);
	...
	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
			     LAN86XX_REG_COL_DET_CTRL0,
			     COL_DET_CTRL0_ENABLE_BIT_MASK,
			     plca_st.pst ? COL_DET_DISABLE : COL_DET_ENABLE);
	...
}

Would it be more precise to say CDEN is explicitly synchronized by
config_intr when interrupts are enabled, and then tracked by
lan86xx_handle_interrupt() on each PSTC event?  As written the paragraph
may leave readers thinking the absence of 0x0087 from the fixup table is
an open gap.

> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 26a2761332a5..043a3dc3f965 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c

[ ... ]

> @@ -346,7 +347,8 @@ static int lan865x_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, priv);
>  	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
>  
> -	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
> +	tc6_quirks.quirk_flags = OA_TC6_PHY_INT;
> +	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);

[Severity: Low]
Setting OA_TC6_PHY_INT routes the PHY mask/unmask through the virtual
irq_chip in drivers/net/ethernet/oa_tc6.c.  oa_tc6_phy_irq_unmask() sets
tc6->phy_irq_masked = false immediately, and the actual INT_MASK0
read-modify-write happens later in oa_tc6_phy_irq_bus_sync_unlock(),
where a failure is only logged:

drivers/net/ethernet/oa_tc6.c:oa_tc6_phy_irq_bus_sync_unlock() {
	...
	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
	if (ret)
		dev_err(&tc6->spi->dev, "Failed to write INT_MASK0: %d\n", ret);
	...
}

If a transient SPI control transfer failure hits just that access, can
STATUS0.PHYINT stay masked in hardware while the software shadow says
unmasked, so later autonomous PLCA transitions never reach
lan86xx_handle_interrupt() and CDEN goes stale?

For context, irq_bus_sync_unlock() returns void so there is no way to
propagate the error to the IRQ core, and regmap_irq_sync_unlock() logs and
continues in the same way, so this may simply be the accepted behaviour
for slow-bus irq_chips.  Also, if the config_intr sequence itself fails,
phy_request_interrupt() falls back to PHY_POLL and the static CDEN write
in lan86xx_plca_set_cfg() is used again.  Is a retry or a warning on the
shadow/hardware divergence worth it here, or is log-and-continue fine?

>  	if (!priv->tc6) {
>  		ret = -ENODEV;
>  		goto free_netdev;

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the probe
and teardown paths in this file: lan865x_remove() cancels the multicast
work before unregistering the netdev:

drivers/net/ethernet/microchip/lan865x/lan865x.c:lan865x_remove() {
	cancel_work_sync(&priv->multicast_work);
	unregister_netdev(priv->netdev);
	oa_tc6_exit(priv->tc6);
	free_netdev(priv->netdev);
}

ndo_set_rx_mode for this driver does nothing but re-queue that work:

static void lan865x_set_multicast_list(struct net_device *netdev)
{
	struct lan865x_priv *priv = netdev_priv(netdev);

	schedule_work(&priv->multicast_work);
}

Can an rx-mode change (allmulti/promisc change, multicast join) that
already holds rtnl_lock re-queue the work after cancel_work_sync() and
before unregister_netdev() takes rtnl?  There is no second cancel or flush
afterwards, so lan865x_multicast_work_handler() would either issue
oa_tc6_write_register() after oa_tc6_exit(), or still be queued when
free_netdev() frees the netdev private area that priv->multicast_work
lives in.

Would moving unregister_netdev() ahead of cancel_work_sync() close that
window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918143302.76909-1-parthiban.veerasooran%40microchip.com
