Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9949D587;
	Fri, 18 Sep 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742004; cv=none; b=ZzIwUwPqbPNS7tzdqDQuGNpJmwuV9P38cMjA5szEp9dST2+k5U+eI9qakdFy1NRSh011UmOxh7NkVA9YqDO1m5CDfpJkX4NRgAc87BEGK31yxj9r4ro6pcwR089tNfZ7CrpyB4hKp9auCPZb7Mljy8NINGUkW8mmhvbLLzGi29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742004; c=relaxed/simple;
	bh=kOMyXulWsJvv7WEbdxT53eYJ3BjsEMEi5erNBhvQZZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klL7k8itVQ6c+hUsexCpufNYSOTNsz3ZeUEJq18TifGrjxvHFHjc04M03ftCG5ILfIKPXQM/ymXXQuCvo2x9IBloky3nfiSFysKtHxg63/6/drVC65KZt2jnYKrZ2TIEEd2/6+fEgl6wWEycGzrzly3oJjE6tlCZYAj6jukIIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VwjhgDDF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VwjhgDDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789742001; x=1821278001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOMyXulWsJvv7WEbdxT53eYJ3BjsEMEi5erNBhvQZZ0=;
  b=VwjhgDDF5Jph9lKkYFQWpKmybyZ4TXfbWLMj5szzurvbwHc3w6uZN5pZ
   tbsm45GQDX6HGEo3mhZiIARbvc9FupZG48F9vXX7xZIQGSmbrRRIOiwZv
   sCEBUd9OccpaF+aEirvGf1WJ/cVcx7XYffpaPepxGxmF5ju3ltbZOLaHB
   m+OmkCWyI4m7bw35YhWXl5f8wbnUtjUWlE02mL5q83JpMtHkHSaUDc449
   hpu2DkbQK5EavKbDOCLSyiIAZJip7aozr1oCNlrKcSPo7KCuQefoMm4Bx
   uPbX1CRLilY5Ls4S41ptWfd2RhHbPctzb0V7C9BVh3xJbiT0P4XFk84+k
   A==;
X-CSE-ConnectionGUID: dz8rexjhRT22p0eHFAuehw==
X-CSE-MsgGUID: fBg8lOWqSem32f1AslMIfg==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="63811296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:33:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 18 Sep 2026 07:33:19 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 07:33:15 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 2/4] net: ethernet: oa_tc6: deliver the PHY interrupt to phylib
Date: Fri, 18 Sep 2026 20:03:00 +0530
Message-ID: <20260918143302.76909-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
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
 drivers/net/ethernet/oa_tc6.c | 145 ++++++++++++++++++++++++++++++++++
 include/linux/oa_tc6.h        |   3 +
 3 files changed, 149 insertions(+)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 8581ccba1505..ea2161232a17 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -150,6 +150,7 @@ config OA_TC6
 	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
 	depends on SPI
 	select PHYLIB
+	select IRQ_DOMAIN
 	help
 	  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
 	  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 6fcc5f561d56..b4a95155e924 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -8,6 +8,8 @@
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
@@ -70,6 +72,11 @@ struct oa_tc6 {
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
@@ -528,6 +535,114 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 }
 EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
+static void oa_tc6_phy_irq_work(struct work_struct *work)
+{
+	struct oa_tc6 *tc6 = container_of(work, struct oa_tc6, phy_irq_work);
+
+	/* Dispatched off the SPI chunk-processing thread so that
+	 * phy_interrupt() taking phydev->lock and issuing synchronous SPI
+	 * control transfers from PHY handle_interrupt() cannot stall the single
+	 * thread pumping TX/RX data chunks.
+	 */
+	handle_nested_irq(tc6->phy_virq);
+}
+
+static void oa_tc6_phy_irq_mask(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+
+	tc6->phy_irq_masked = true;
+}
+
+static void oa_tc6_phy_irq_unmask(struct irq_data *irqd)
+{
+	struct oa_tc6 *tc6 = irq_data_get_irq_chip_data(irqd);
+
+	tc6->phy_irq_masked = false;
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
+	if (tc6->phy_irq_masked)
+		regval |= OA_TC6_INT_MASK0_PHY_INT_MASK;
+	else
+		regval &= ~OA_TC6_INT_MASK0_PHY_INT_MASK;
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+	if (ret)
+		dev_err(&tc6->spi->dev, "Failed to write INT_MASK0: %d\n", ret);
+
+unlock:
+	mutex_unlock(&tc6->phy_irq_lock);
+}
+
+static struct irq_chip oa_tc6_phy_irq_chip = {
+	.name                   = "oa_tc6_phy",
+	.irq_mask               = oa_tc6_phy_irq_mask,
+	.irq_unmask             = oa_tc6_phy_irq_unmask,
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
+	tc6->phy_irq_masked = true;
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
+	cancel_work_sync(&tc6->phy_irq_work);
+	irq_dispose_mapping(tc6->phy_virq);
+	irq_domain_remove(tc6->phy_irq_domain);
+}
+
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
 	int ret;
@@ -559,9 +674,25 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
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
@@ -572,6 +703,8 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
 {
 	mdiobus_unregister(tc6->mdiobus);
+	if (tc6->quirk_flags & OA_TC6_PHY_INT)
+		oa_tc6_phy_irq_teardown(tc6);
 	mdiobus_free(tc6->mdiobus);
 }
 
@@ -810,6 +943,17 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 		return ret;
 	}
 
+	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so
+	 * the PHY driver reads and acknowledges its status. This is deferred
+	 * to a workqueue rather than dispatched synchronously here, since
+	 * phy_interrupt() takes phydev->lock and PHY handle_interrupt() issues
+	 * synchronous SPI control transfers, which would otherwise block this
+	 * thread.
+	 */
+	if ((tc6->quirk_flags & OA_TC6_PHY_INT) &&
+	    FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
+		schedule_work(&tc6->phy_irq_work);
+
 	if (FIELD_GET(OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
 		oa_tc6_look_for_new_frame(tc6);
 		net_err_ratelimited("%s: Receive buffer overflow error\n",
@@ -1468,6 +1612,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
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

