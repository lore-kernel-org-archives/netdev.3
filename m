Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C253AEF4E;
	Thu, 10 Sep 2026 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017675; cv=none; b=GEXzpXWfjxDzhSDx3ytWiOCRkNfuPkWrK+mRTkIcLRR2QGQKwImTAXHe+dWBNCS9adbpQ/1s12/YB2sDHRD4/8CFEGJRsDu+iO9hNQpkkTp6VVTqm/0PPytbq+LARg2TD+hv6FReehCXBDmSqTgQfX7uVnqwI9+pEZ3ksulfAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017675; c=relaxed/simple;
	bh=qo3oQwnarchgPdxpGAFXeUnZ0O+algQPHl60G14fT8c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gf+WgHYolUoI1Sq5ClmySmLDgGcC6am6XFw5DJL+7CaQgVKESoWDYxw38+yt3U2yXL36KtQebQBeqAFqAkCzm75x9xMc5ng/RiPg9CxBBFDXmt4RKJkLHxa9O3sk5qP/VPTjjV5ZYkq7Z+WZX45YhBlImz4L/wOk9oE5zz7vKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPjbWJaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPjbWJaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CDF1F00898;
	Thu, 10 Sep 2026 05:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017673;
	bh=AglIGlIWj6rcbiZO6kWYmfisptQWaVtEA7jJ0FFZuGM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gPjbWJaWJsikVr4Zky0EyE2AuKw4quZvTVpFukm3wOml/5luN8yvomsmRxMSjvbpd
	 4YnAETnaCfbdDxlELWxCuwuNTL/8ONmdJNcgslstnykcVqx/EEY+s2cxDH7NaCLDzV
	 3H10+/BE41HdgHQ47hvrVlcYDgT8Z7g5lmFs2y2IJMGGYlgGAa1de4vphJqUIc/ZOG
	 IY+xxOeGPiDBQZFvbqiATd01aTteWpnBcldAH2LBmX+nCWK7Ss246l+np5HPGZd9ts
	 9wBOKwhrE2iVOSaqh05ZXrflrCE8ZL8Ii4oD0a5qI1TInRf6W7x8ILADFzjGJYif7g
	 j8N9UIU88i6Tg==
Subject: Re: [PATCH net-next v2 3/4] microchip: lan865x: enable PHY interrupt
 via virtual IRQ
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Thu, 10 Sep 2026 05:21:12 +0000
Message-ID: <178901767241.219967.3774142098536150677@kernel.org>
In-Reply-To: <20260907052007.391972-4-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-4-parthiban.veerasooran@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 4 · Low: 0

- [High] Asymmetric interrupt enable/acknowledge in the OA TC6 framework:
  oa_tc6_unmask_interrupts() (drivers/net/ethernet/oa_tc6.c, formerly…
- [High] Interrupt livelock when the nested PHY handler cannot
  acknowledge the source.
- [Medium] Undisclosed behavioural change: by passing OA_TC6_PHY_INT,
  lan865x_probe() gives the LAN865X internal PHY a valid phydev->irq…
- [Medium] This patch is a mandatory part of the collision-detection bug
  fix for LAN865X, but it carries neither a Fixes: tag nor any statement…
- [Medium] lan86xx_plca_set_cfg() uses `if (phydev->irq != PHY_POLL)
  return 0;` to decide that 'PHYs with routed interrupts handle CDEN…
- [Medium] Enabling OA_TC6_PHY_INT makes the LAN865x SPI data engine
  dispatch the PHY interrupt synchronously from inside the RX-chunk-…

Pre-existing issues:
- [High] lan865x_remove() calls cancel_work_sync(&priv->multicast_work)
  *before* unregister_netdev().

--

microchip: lan865x: enable PHY interrupt via virtual IRQ

This passes the new OA_TC6_PHY_INT quirk flag to oa_tc6_init() so that the
LAN865X internal PHY gets a virtual IRQ from the OA TC6 framework and phylib
can run the PHY driver's config_intr/handle_interrupt callbacks instead of
polling.

A few questions about the consequences of turning this on, mostly about the
interaction with the two preceding patches in the series.

> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 26a2761332a5a..043a3dc3f9657 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -332,6 +332,7 @@ static const struct net_device_ops lan865x_netdev_ops = {
>  
>  static int lan865x_probe(struct spi_device *spi)
>  {
> +	struct oa_tc6_quirks tc6_quirks = {};
>  	struct net_device *netdev;
>  	struct lan865x_priv *priv;
>  	int ret;
> @@ -346,7 +347,8 @@ static int lan865x_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, priv);
>  	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
>  
> -	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
> +	tc6_quirks.quirk_flags = OA_TC6_PHY_INT;
> +	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);

[Severity: Medium]
Does setting OA_TC6_PHY_INT here silently remove the deterministic
COL_DET_CTRL0 write for LAN865x?

With this quirk, oa_tc6_mdiobus_register() fills every mii_bus->irq[] entry
with tc6->phy_virq, so phydev->irq for the internal PHY is no longer
PHY_POLL, and lan86xx_plca_set_cfg() now takes the new early return added by
the preceding PHY patch:

drivers/net/phy/microchip_t1s.c:lan86xx_plca_set_cfg() {
	...
	if (phydev->irq != PHY_POLL)
		return 0;
	...
}

After that, the only writer of CDEN for this device is
lan86xx_handle_interrupt(), and only when the read-to-clear STS1 read
observes LAN86XX_STS1_PLCA_STS_CHANGED:

	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
		ret = genphy_c45_plca_get_status(phydev, &plca_st);

Two things follow from that. First, an administrative
"ethtool --set-plca-cfg ... enable off" performed while the PLCA status is
unchanged produces no PST edge, so nothing reprograms CDEN. Second,
lan86xx_config_intr() reads STS1 to clear pending status before unmasking
PSTCM, so a transition latched before that point is consumed without ever
being applied to CDEN, and it never evaluates the live PLCA status:

		/* Read to clear any pending status before enabling. */
		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);

Is there anything that establishes the CDEN baseline for this part?
lan865x_revb_fixup_registers[] does not contain 0x0087, unlike the LAN867X
Rev.B1 AN1699 list which writes 0x0087 with mask 0x801C. If the correctness
now relies on the reset default of COL_DET_CTRL0 bit 15 and on the PHY
latching PSTC for every relevant change, could the changelog mention that,
since it currently reads only as "enable interrupt mode"?

[Severity: Medium]
Should this patch carry the same Fixes: tag as the PHY change, or at least
state the dependency?

The only commit in the series with a Fixes: tag is "net: phy: microchip_t1s:
fix collision detection on PLCA status change" (135306e057ab, Fixes:
78341049fbcd), and its changelog says:

	LAN865X is excluded from the static write because its interrupt is
	always routed via the MAC-PHY SPI driver and the interrupt handler
	always runs.

Is that statement true before this patch is applied? Without OA_TC6_PHY_INT
the framework never populates mii_bus->irq[], mdiobus_alloc_size()
initialises every entry to PHY_POLL, phy_request_interrupt() is never called,
and lan86xx_handle_interrupt() never runs.

A stable selection that follows the Fixes: tag would then take the PHY commit
alone and leave LAN865x with neither the static write nor the interrupt path.

[Severity: High]
While looking at the framework side this patch opts into: is the PHYINT
unmask in the preceding oa_tc6 patch missing the OA_TC6_PHY_INT gate?

oa_tc6_unmask_interrupts() clears the mask for every MAC-PHY, unconditionally
from oa_tc6_init():

drivers/net/ethernet/oa_tc6.c:oa_tc6_unmask_interrupts() {
	regval &= ~(OA_TC6_INT_MASK0_PHY_INT_MASK |
		    OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
	...
}

but the only code that services and acknowledges it is quirk-gated:

drivers/net/ethernet/oa_tc6.c:oa_tc6_process_extended_status() {
	...
	if ((tc6->quirk_flags & OA_TC6_PHY_INT) &&
	    FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
		handle_nested_irq(tc6->phy_virq);
	...
}

drivers/net/ethernet/adi/adin1140.c:adin1140_probe() passes only
OA_TC6_BROKEN_PHY, so on that device PHYINT is armed while tc6->phy_virq is 0
and no path can read or ack the PHY's interrupt status. Since STATUS0.PHYINT
is a level reflection (the new comment says the STATUS0 write-back does not
clear it) and the host IRQ is requested as level-low with ONESHOT:

	ret = devm_request_threaded_irq(&tc6->spi->dev, tc6->spi->irq,
					oa_tc6_macphy_isr,
					oa_tc6_macphy_threaded_irq,
					IRQF_TRIGGER_LOW | IRQF_ONESHOT,

wouldn't an asserted PHYINT on a non-opt-in device loop forever? The hard ISR
sets tc6->int_flag, oa_tc6_macphy_threaded_irq() spins in
while (tc6->int_flag || ...), oa_tc6_try_spi_transfer() clears int_flag, the
thread returns and ONESHOT unmasks a still-low line. Should the unmask be
gated on OA_TC6_PHY_INT too?

[Severity: Medium]
Related to the branch this patch activates: should lan86xx_plca_set_cfg() use
phy_interrupt_is_valid() rather than comparing against PHY_POLL only?

include/linux/phy.h:phy_interrupt_is_valid() {
	return phydev->irq != PHY_POLL && phydev->irq != PHY_MAC_INTERRUPT;
}

For PHY_MAC_INTERRUPT phylib never calls phy_request_interrupt(), so
.config_intr/.handle_interrupt are never invoked. A LAN867x on a bus that
assigns PHY_MAC_INTERRUPT, for example:

drivers/net/mdio/mdio-moxart.c:moxart_mdio_probe() {
	for (i = 0; i < PHY_MAX_ADDR; i++)
		bus->irq[i] = PHY_MAC_INTERRUPT;
}

would then skip the static COL_DET_CTRL0 write and never get the handler, so
CDEN is never programmed at all. The comment above the new early return says
"PHYs with routed interrupts handle CDEN dynamically via the interrupt
handler", which does not hold for that phylib mode.

[Severity: High]
Can the nested dispatch enabled here livelock when phylib has the virq
disabled?

handle_nested_irq() only sets IRQS_PENDING when !action or
irqd_irq_disabled(&desc->irq_data), and phylib disables this virq on its own
during system suspend:

drivers/net/phy/phy_device.c:mdio_bus_phy_suspend() {
	if (phy_interrupt_is_valid(phydev)) {
		phydev->irq_suspended = 1;
		synchronize_irq(phydev->irq);
	}
}

drivers/net/phy/phy.c:phy_interrupt() {
	if (IS_ENABLED(CONFIG_PM_SLEEP) && phydev->irq_suspended) {
		...
		phydev->irq_rerun = 1;
		disable_irq_nosync(irq);
		return IRQ_HANDLED;
	}
}

Neither oa_tc6 nor lan865x sets mac_managed_pm, so this branch is reachable
for this phydev. The PHY is never read, its latched status is not cleared,
and with dummy_irq_chip the mask is a no-op, so STATUS0.PHYINT stays
asserted. The level-low ONESHOT MAC IRQ then re-fires after each return of:

drivers/net/ethernet/oa_tc6.c:oa_tc6_macphy_threaded_irq() {
	while (tc6->int_flag ||
	       (tc6->waiting_tx_skb && tc6->tx_credits)) {
		ret = oa_tc6_try_spi_transfer(tc6);
	...
}

Is there anything that bounds this, or that masks
OA_TC6_INT_MASK0_PHY_INT_MASK as a fallback when the nested handler cannot
ack? The same no-ack outcome seems possible for any PHYINT source not
represented in STS1, since lan86xx_handle_interrupt() reads only STS1 and
otherwise returns IRQ_NONE, which also feeds note_interrupt() on the nested
virq. If an SPI transfer fails during such a storm, oa_tc6_disable_traffic()
is reached and the interface stays dead.

[Severity: High]
This isn't a bug introduced by this patch, but while the teardown path is in
scope: lan865x_remove() cancels the multicast work before unregistering the
netdev.

drivers/net/ethernet/microchip/lan865x/lan865x.c:lan865x_remove() {
	cancel_work_sync(&priv->multicast_work);
	unregister_netdev(priv->netdev);
	oa_tc6_exit(priv->tc6);
	free_netdev(priv->netdev);
}

.ndo_set_rx_mode is still installed and callable in that window, and
lan865x_remove() does not hold rtnl:

static void lan865x_set_multicast_list(struct net_device *netdev)
{
	struct lan865x_priv *priv = netdev_priv(netdev);

	schedule_work(&priv->multicast_work);
}

Nothing cancels or flushes the work again, so can the handler run after
oa_tc6_exit() and free_netdev(), dereferencing freed netdev_priv memory?

	if (priv->netdev->flags & IFF_PROMISC) {
	...
	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval);

An "ip link set eth0 promisc on" or a multicast join reaching
dev_mc_add() -> __dev_set_rx_mode() during unbind would be enough to re-arm
it. Would unregister_netdev() first, then cancel_work_sync(), close this?
This patch also widens what the stale work can touch, since oa_tc6_exit() now
performs irq_dispose_mapping()/irq_domain_remove() as well.

[Severity: Medium]
Does dispatching the PHY interrupt from inside the chunk-processing loop
couple the data path to phydev->lock?

The call chain enabled by this quirk is
oa_tc6_macphy_threaded_irq() -> oa_tc6_try_spi_transfer() ->
oa_tc6_process_spi_data_rx_buf() -> oa_tc6_process_rx_chunk_footer() ->
oa_tc6_process_extended_status() -> handle_nested_irq(tc6->phy_virq), and
handle_nested_irq() calls the thread_fn directly:

drivers/net/phy/phy.c:phy_interrupt() {
	...
	mutex_lock(&phydev->lock);
	ret = phydev->drv->handle_interrupt(phydev);
	...
}

lan86xx_handle_interrupt() then issues several phy_read_mmd()/phy_modify_mmd()
calls, each taking the MDIO bus mutex and tc6->spi_ctrl_lock and doing a
synchronous SPI control transfer. So the single thread that performs all
TX/RX chunk transfers, running at RT priority with the MAC-PHY line masked by
IRQF_ONESHOT, now blocks on a sleeping mutex held by unrelated,
user-triggerable phylib contexts (ethtool PLCA get/set,
phy_do_ioctl_running() -> phy_start_aneg(), phy_start/phy_stop, phy_init_hw()
on resume, the state machine work).

	while (tc6->int_flag ||
	       (tc6->waiting_tx_skb && tc6->tx_credits)) {

Mutexes give no priority inheritance, so a normal-priority holder stalls the
pump while RX chunks accumulate in the MAC-PHY RX buffer, which shows up as
OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR and lost frames. Would deferring the
phylib dispatch out of the chunk-processing loop, for example after the
transfer loop or from a dedicated worker, keep the data path independent of
phydev->lock?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907052007.391972-1-parthiban.veerasooran%40microchip.com
