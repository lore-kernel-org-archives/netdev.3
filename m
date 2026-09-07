Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4122E3F0;
	Mon,  7 Sep 2026 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758498; cv=none; b=AVSxqGsHM3wELuncTxOs5jKMEC5mgmQuAd/x4ggrk+IplHqaTq1+xj275zlUh7E9hrBVn+s+uYhiPinJUJ7pzYJ65YXNcYUyZ5zhMPvQDJh1GO+spEMTn+6u5gO+nfzhjMb8cmBd2rrtTPj06jk/+sC/c+Ammb8l7h2TR9N2up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758498; c=relaxed/simple;
	bh=/2eonf+NFxJd+qFoAumMEbvPdiSaVWHOEdsfIlG2auE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djlo17JUrjrFInI5VCHVnZ/XVI+BjDLj/qA3/qCc9Zg1jTeGhGRha2GAKwPevbzG1lAkKLrwSiXxGOR8Lm8YwPJ9Z+VMQCAlFWm6f6VRORsOrUmhR/2EifXpRqr8HLQ3dW73LT/A+S/xAhH8665JrA3JYw2L4Gb0JP2k9Lq75hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BvTsxnEw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BvTsxnEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788758487; x=1820294487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2eonf+NFxJd+qFoAumMEbvPdiSaVWHOEdsfIlG2auE=;
  b=BvTsxnEwrIkCocveR1hL+gtaWOJ972gC3vorwYv6EdhrN8U2gZP9jgAe
   Po7arnGDNVrWQwKLVwILzEiqXPeiBAVdhicZsnChWqjKWM+tYL+XdKc7P
   kwvtviLiGTKm59y26v6BzLvARnijRTJEKWNh2f+O5gXOwfSuvZKFtm6fC
   KVXfiJhbB9zhb0g7uRMpTc1NDJvT2SXNBejL+J8G8XH8cedpgx2keLwdk
   gINaGbteRetFeCLJWQ4lDEFcDvnZ2PTZ2PubuKXZtlhX6uYZXhUsk8rj7
   j9YbEsjiFuh9fg+pcdIy5p0kfiI7l2x4cAKK3O7lLm0e3R2s5XskCXRoJ
   w==;
X-CSE-ConnectionGUID: Dg0aeh7fTReGUKalcBsrUg==
X-CSE-MsgGUID: Oo3yLfQ/RUSKPjfq7bigNA==
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="63542725"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2026 22:20:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 6 Sep 2026 22:20:23 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 6 Sep 2026 22:20:19 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 2/4] net: ethernet: oa_tc6: deliver the PHY interrupt to phylib
Date: Mon, 7 Sep 2026 10:50:04 +0530
Message-ID: <20260907052007.391972-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The OA TC6 standard defines PHY interrupt delivery via the SPI status
register as optional. When implemented, the PHY has no dedicated interrupt
line; its interrupt is signalled through the MAC-PHY SPI interface.
phy_mac_interrupt() only triggers a link-status re-read and cannot make
the PHY driver read and acknowledge its interrupt source registers, so
expose the PHY interrupt to phylib as a nested virtual IRQ instead.

Introduce the OA_TC6_PHY_INT quirk flag so drivers can opt in when the
PHY interrupt is routed in-band.

When OA_TC6_PHY_INT is set, use dummy_irq_chip as the irqchip and map
a virtual IRQ inside oa_tc6_mdiobus_register() before mdiobus_register()
is called. Populate all mii_bus->irq[] entries with the virtual IRQ so
phy_device_create() picks it up regardless of the PHY's MDIO address,
keeping mii_bus->irq[] and phydev->irq consistent. The corresponding
teardown is integrated into oa_tc6_mdiobus_unregister().

Unmask PHYINT in INT_MASK0, and when it is seen in the extended status,
dispatch handle_nested_irq() synchronously from the sleepable threaded
IRQ. PHYINT is level triggered, so acking the PHY source there clears it
before the next data chunk, avoiding a storm.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 76 +++++++++++++++++++++++++++++++++--
 include/linux/oa_tc6.h        |  3 ++
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 6fcc5f561d56..00b0176c1fe7 100644
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
@@ -70,6 +72,8 @@ struct oa_tc6 {
 	struct phy_device *phydev;
 	struct mii_bus *mdiobus;
 	struct spi_device *spi;
+	struct irq_domain *phy_irq_domain;
+	int phy_virq;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
 	spinlock_t tx_skb_lock; /* Protects tx skb handling */
 	void *spi_ctrl_tx_buf;
@@ -528,6 +532,44 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 }
 EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
+static int oa_tc6_phy_irq_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
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
+	tc6->phy_irq_domain =
+		irq_domain_create_linear(NULL, 1,
+					 &oa_tc6_phy_irq_domain_ops, tc6);
+	if (!tc6->phy_irq_domain)
+		return -ENOMEM;
+
+	tc6->phy_virq = irq_create_mapping(tc6->phy_irq_domain, 0);
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
@@ -559,9 +601,25 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
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
@@ -572,6 +630,8 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
 {
 	mdiobus_unregister(tc6->mdiobus);
+	if (tc6->quirk_flags & OA_TC6_PHY_INT)
+		oa_tc6_phy_irq_teardown(tc6);
 	mdiobus_free(tc6->mdiobus);
 }
 
@@ -661,7 +721,7 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
 }
 
-static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
+static int oa_tc6_unmask_interrupts(struct oa_tc6 *tc6)
 {
 	u32 regval;
 	int ret;
@@ -670,7 +730,8 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
-	regval &= ~(OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
+	regval &= ~(OA_TC6_INT_MASK0_PHY_INT_MASK |
+		    OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
 		    OA_TC6_INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
 		    OA_TC6_INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
 		    OA_TC6_INT_MASK0_HEADER_ERR_MASK);
@@ -810,6 +871,15 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 		return ret;
 	}
 
+	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so
+	 * the PHY driver reads and acknowledges its status. PHYINT is level
+	 * triggered, so doing this synchronously here (in the sleepable
+	 * threaded IRQ) clears the source before the next data chunk.
+	 */
+	if ((tc6->quirk_flags & OA_TC6_PHY_INT) &&
+	    FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
+		handle_nested_irq(tc6->phy_virq);
+
 	if (FIELD_GET(OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
 		oa_tc6_look_for_new_frame(tc6);
 		net_err_ratelimited("%s: Receive buffer overflow error\n",
@@ -1518,7 +1588,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 		return NULL;
 	}
 
-	ret = oa_tc6_unmask_macphy_error_interrupts(tc6);
+	ret = oa_tc6_unmask_interrupts(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
 			"MAC-PHY error interrupts unmask failed: %d\n", ret);
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

