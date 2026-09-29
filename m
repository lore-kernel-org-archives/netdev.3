Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8651AFFF;
	Tue, 29 Sep 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686791; cv=none; b=hxTqF07vwM9SK6W8ZvEmvwe450ZlYpZaKtfrNA5EG0Pa/pxkBRYW8iRbPQYWXW3/r0eL3V3QvUQ/ZvW4SKpWC0k/gI3eawSwwRZT43P5cWObikqXCedmEIfzI1w2OIDPsPApOMjZFRhf1vLJy7VYRLe31orG3pvOlBg+P7jyZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686791; c=relaxed/simple;
	bh=6Co9etOdIYKgteWOWjrPodwliHYJzcEyx728NzbxKt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTJYG3kBEPSrIMOQmTRkV5CkctJrxtdaWnTcTcEFB6chiXJCvyTCtmTUK8CB0uc3fkgZgSNYh+Z/OBRP6KEa4Ioc07S30dFxsf+p0FBIHLEY1clAMX/qNcKyBqm6AuDvyvcc+EIBvT10FwAlCP7jdWYllDAUfQ92ciOZiV9+blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pD1oSG2n; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pD1oSG2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790686789; x=1822222789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Co9etOdIYKgteWOWjrPodwliHYJzcEyx728NzbxKt4=;
  b=pD1oSG2nA5nTnX9EZjqFLwjToBAervXfgAYhydkhikHqR/TQcSTM9GNI
   /ITLdSyW9gBbJ5wTtfTU7W103622OdtxYctfEJFg3h8d6+ZI5ZPhzFcy3
   1YoUIHpsGKMdHWkgCPuI8ufcwGnfUg/1pKuY7krwge5TVc8JEoFxHiGSc
   jKmLcm8NnvZtuZgbh7Crr5d4MX1fzhiAeI96uXyWVlCliBc3oAinc/ZpB
   dDyD0FupjU58XqI29BApK8tgC1bEYNLRmh+66hEAxSHMjQSYwP/KQhc68
   66bDhh7hJdRBdLZqd0VPZD4fhlnqsCVLRPABTkxBBcfGl9aqkP6Pzvldt
   g==;
X-CSE-ConnectionGUID: /82tH26/Q4C45h1U7lsXpw==
X-CSE-MsgGUID: LBom3/5zSlijkOvzbYqCLw==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="74502195"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2026 05:59:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 29 Sep 2026 05:59:47 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 05:59:43 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 2/4] net: ethernet: oa_tc6: deliver the PHY interrupt to phylib
Date: Tue, 29 Sep 2026 18:29:26 +0530
Message-ID: <20260929125928.611784-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The OA TC6 standard defines PHY interrupt delivery via the SPI status
register as optional. The PHY has no dedicated interrupt line in that
case; its interrupt is signalled through the MAC-PHY SPI interface, but
phy_mac_interrupt() can't make the PHY driver read and acknowledge its
own status registers. Expose it to phylib instead as a nested virtual
IRQ, gated by a new OA_TC6_PHY_INT quirk flag for drivers that route
PHY interrupts in-band.

When set, a nested virtual IRQ is created in oa_tc6_mdiobus_register()
before mdiobus_register(), and all mii_bus->irq[] entries are populated
with it so phy_device_create() picks it up regardless of MDIO address.
Teardown is integrated into oa_tc6_mdiobus_unregister().

A custom irq_chip (oa_tc6_phy_irq_chip) implements mask/unmask via
irq_bus_lock/irq_bus_sync_unlock, writing the mask bit to hardware over
SPI. The interrupt starts masked (hardware reset default) and is only
unmasked when phylib requests it, so disabling the nested IRQ actually
masks the hardware source too, preventing interrupt storms.

Dispatch is deferred to a workqueue rather than run synchronously from
the threaded IRQ: phy_interrupt() takes phydev->lock and PHY
handle_interrupt() issues synchronous SPI transfers, either of which
would otherwise stall the single thread pumping every TX/RX data chunk.
PHYINT is level triggered and stays asserted until acked, so a no-op
reschedule on an already-pending work item can't lose or duplicate an
event.

Select IRQ_DOMAIN in Kconfig for the irq_domain APIs used here.

Prerequisite for "net: phy: microchip_t1s: fix collision detection on
PLCA status change" (Fixes: 78341049fbcd) to fully cover the LAN865X
internal PHY.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/Kconfig  |   1 +
 drivers/net/ethernet/oa_tc6.c | 227 ++++++++++++++++++++++++++++++++++
 include/linux/oa_tc6.h        |   3 +
 3 files changed, 231 insertions(+)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index c2b0161d0bec..9b102a91c36a 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -151,6 +151,7 @@ config OA_TC6
 	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
 	depends on SPI
 	select PHYLIB
+	select IRQ_DOMAIN
 	help
 	  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
 	  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 364027c39fa4..74fe65b76359 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -10,6 +10,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
@@ -72,6 +74,11 @@ struct oa_tc6 {
 	struct phy_device *phydev;
 	struct mii_bus *mdiobus;
 	struct spi_device *spi;
+	struct mutex phy_irq_lock; /* Serialises irq_bus_lock/sync_unlock */
+	bool phy_irq_masked; /* Shadow of OA_TC6_INT_MASK0_PHY_INT_MASK */
+	struct irq_domain *phy_irq_domain;
+	int phy_virq;
+	struct work_struct phy_irq_work;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
 	spinlock_t tx_skb_lock; /* Protects tx skb handling */
 	void *spi_ctrl_tx_buf;
@@ -531,6 +538,178 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 }
 EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
+static int oa_tc6_phy_irq_unmask_hw(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	mutex_lock(&tc6->phy_irq_lock);
+
+	if (READ_ONCE(tc6->phy_irq_masked)) {
+		ret = 0;
+		goto unlock;
+	}
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
+	if (ret)
+		goto unlock;
+
+	regval &= ~OA_TC6_INT_MASK0_PHY_INT_MASK;
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+
+unlock:
+	mutex_unlock(&tc6->phy_irq_lock);
+
+	return ret;
+}
+
+static void oa_tc6_phy_irq_work(struct work_struct *work)
+{
+	struct oa_tc6 *tc6 = container_of(work, struct oa_tc6, phy_irq_work);
+	int ret;
+
+	/* Dispatched off the SPI chunk-processing thread so that
+	 * phy_interrupt() taking phydev->lock and issuing synchronous SPI
+	 * control transfers from PHY handle_interrupt() cannot stall the single
+	 * thread pumping TX/RX data chunks.
+	 */
+	handle_nested_irq(tc6->phy_virq);
+
+	ret = oa_tc6_phy_irq_unmask_hw(tc6);
+	if (ret)
+		dev_err(&tc6->spi->dev, "Failed to unmask PHY interrupt: %d\n",
+			ret);
+}
+
+static int oa_tc6_phy_irq_mask_hw(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	mutex_lock(&tc6->phy_irq_lock);
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
+	if (ret)
+		goto unlock;
+
+	regval |= OA_TC6_INT_MASK0_PHY_INT_MASK;
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+
+unlock:
+	mutex_unlock(&tc6->phy_irq_lock);
+
+	return ret;
+}
+
+static void oa_tc6_phy_irq_mask(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+
+	WRITE_ONCE(tc6->phy_irq_masked, true);
+}
+
+static void oa_tc6_phy_irq_unmask(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+
+	WRITE_ONCE(tc6->phy_irq_masked, false);
+}
+
+static void oa_tc6_phy_irq_disable(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+
+	WRITE_ONCE(tc6->phy_irq_masked, true);
+}
+
+static void oa_tc6_phy_irq_bus_lock(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+
+	mutex_lock(&tc6->phy_irq_lock);
+}
+
+static void oa_tc6_phy_irq_bus_sync_unlock(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "Failed to read INT_MASK0: %d\n", ret);
+		goto unlock;
+	}
+
+	if (READ_ONCE(tc6->phy_irq_masked))
+		regval |= OA_TC6_INT_MASK0_PHY_INT_MASK;
+	else
+		regval &= ~OA_TC6_INT_MASK0_PHY_INT_MASK;
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "Failed to write INT_MASK0: %d\n", ret);
+		/* Note: on SPI failure, mask state is undefined until next
+		 * sync. This follows genirq's regmap_irq_sync_unlock() pattern
+		 * since the callback returns void and has nowhere to propagate
+		 * errors.
+		 */
+	}
+
+unlock:
+	mutex_unlock(&tc6->phy_irq_lock);
+}
+
+static struct irq_chip oa_tc6_phy_irq_chip = {
+	.name                   = "oa_tc6_phy",
+	.irq_mask               = oa_tc6_phy_irq_mask,
+	.irq_unmask             = oa_tc6_phy_irq_unmask,
+	.irq_disable            = oa_tc6_phy_irq_disable,
+	.irq_bus_lock           = oa_tc6_phy_irq_bus_lock,
+	.irq_bus_sync_unlock    = oa_tc6_phy_irq_bus_sync_unlock,
+};
+
+static int oa_tc6_phy_irq_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_chip_and_handler(irq, &oa_tc6_phy_irq_chip, handle_simple_irq);
+	irq_set_nested_thread(irq, true);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops oa_tc6_phy_irq_domain_ops = {
+	.map = oa_tc6_phy_irq_map,
+};
+
+static int oa_tc6_phy_irq_setup(struct oa_tc6 *tc6)
+{
+	INIT_WORK(&tc6->phy_irq_work, oa_tc6_phy_irq_work);
+
+	tc6->phy_irq_domain =
+		irq_domain_create_linear(NULL, 1,
+					 &oa_tc6_phy_irq_domain_ops, tc6);
+	if (!tc6->phy_irq_domain)
+		return -ENOMEM;
+
+	tc6->phy_virq = irq_create_mapping(tc6->phy_irq_domain, 0);
+	WRITE_ONCE(tc6->phy_irq_masked, true);
+	if (!tc6->phy_virq) {
+		irq_domain_remove(tc6->phy_irq_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void oa_tc6_phy_irq_teardown(struct oa_tc6 *tc6)
+{
+	irq_dispose_mapping(tc6->phy_virq);
+	irq_domain_remove(tc6->phy_irq_domain);
+}
+
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
 	int ret;
@@ -562,9 +741,25 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 	snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
 		 dev_name(&tc6->spi->dev));
 
+	if (tc6->quirk_flags & OA_TC6_PHY_INT) {
+		ret = oa_tc6_phy_irq_setup(tc6);
+		if (ret) {
+			mdiobus_free(tc6->mdiobus);
+			return ret;
+		}
+		/* Populate all irq[] entries before registration so
+		 * phy_device_create() picks up the virtual IRQ regardless of
+		 * the PHY's MDIO address.
+		 */
+		for (int i = 0; i < PHY_MAX_ADDR; i++)
+			tc6->mdiobus->irq[i] = tc6->phy_virq;
+	}
+
 	ret = mdiobus_register(tc6->mdiobus);
 	if (ret) {
 		netdev_err(tc6->netdev, "Could not register MDIO bus\n");
+		if (tc6->quirk_flags & OA_TC6_PHY_INT)
+			oa_tc6_phy_irq_teardown(tc6);
 		mdiobus_free(tc6->mdiobus);
 		return ret;
 	}
@@ -575,6 +770,8 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
 {
 	mdiobus_unregister(tc6->mdiobus);
+	if (tc6->quirk_flags & OA_TC6_PHY_INT)
+		oa_tc6_phy_irq_teardown(tc6);
 	mdiobus_free(tc6->mdiobus);
 }
 
@@ -624,6 +821,7 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
 		return;
 
+	cancel_work_sync(&tc6->phy_irq_work);
 	phy_disconnect(tc6->phydev);
 	oa_tc6_mdiobus_unregister(tc6);
 }
@@ -780,7 +978,12 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 	netif_tx_disable(tc6->netdev);
 	oa_tc6_drop_tx_skb(tc6, skb);
 	oa_tc6_free_ongoing_skbs(tc6);
+	/* Serialize INT_MASK0 write with phylib's mask/unmask to prevent
+	 * read-modify-write races in oa_tc6_phy_irq_bus_sync_unlock().
+	 */
+	mutex_lock(&tc6->phy_irq_lock);
 	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+	mutex_unlock(&tc6->phy_irq_lock);
 	oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
 	oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
 	dev_err(&tc6->spi->dev, "Device interrupt disabled to avoid interrupt storm");
@@ -813,6 +1016,29 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 		return ret;
 	}
 
+	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so
+	 * the PHY driver reads and acknowledges its status. This is deferred
+	 * to a workqueue rather than dispatched synchronously here, since
+	 * phy_interrupt() takes phydev->lock and PHY handle_interrupt() issues
+	 * synchronous SPI control transfers, which would otherwise block this
+	 * thread.
+	 *
+	 * Mask the hardware interrupt immediately to avoid wasting SPI cycles
+	 * on redundant STATUS0 reads until the worker runs and phylib acks it.
+	 * PHYINT is level triggered and stays asserted until acked, so every
+	 * RX chunk footer would re-read STATUS0 until the worker schedules.
+	 * Gate on phy_virq (the actual resource) rather than just the flag to
+	 * be self-consistent if OA_TC6_BROKEN_PHY skips initialization.
+	 */
+	if (tc6->phy_virq && FIELD_GET(OA_TC6_STATUS0_PHY_INT, value)) {
+		ret = oa_tc6_phy_irq_mask_hw(tc6);
+		if (ret)
+			dev_err(&tc6->spi->dev,
+				"Failed to mask PHY interrupt: %d\n", ret);
+		else
+			schedule_work(&tc6->phy_irq_work);
+	}
+
 	if (FIELD_GET(OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
 		oa_tc6_look_for_new_frame(tc6);
 		net_err_ratelimited("%s: Receive buffer overflow error\n",
@@ -1471,6 +1697,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	tc6->spi = spi;
 	tc6->netdev = netdev;
 	SET_NETDEV_DEV(netdev, &spi->dev);
+	mutex_init(&tc6->phy_irq_lock);
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
 
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 27f652d4920b..1c8cc263c5e5 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -30,6 +30,7 @@
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
+#define OA_TC6_STATUS0_PHY_INT			BIT(7)
 #define OA_TC6_STATUS0_RESETC			BIT(6)	/* Reset Complete */
 #define OA_TC6_STATUS0_HEADER_ERROR		BIT(5)
 #define OA_TC6_STATUS0_LOSS_OF_FRAME_ERROR	BIT(4)
@@ -43,6 +44,7 @@
 
 /* Interrupt Mask Register #0 */
 #define OA_TC6_REG_INT_MASK0				0x000C
+#define OA_TC6_INT_MASK0_PHY_INT_MASK			BIT(7)
 #define OA_TC6_INT_MASK0_HEADER_ERR_MASK		BIT(5)
 #define OA_TC6_INT_MASK0_LOSS_OF_FRAME_ERR_MASK		BIT(4)
 #define OA_TC6_INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
@@ -68,6 +70,7 @@ struct oa_tc6;
 
 enum oa_tc6_quirk_flag {
 	OA_TC6_BROKEN_PHY = BIT(0),
+	OA_TC6_PHY_INT    = BIT(1),
 };
 
 struct oa_tc6_quirks {
-- 
2.43.0

