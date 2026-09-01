Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE403F9270;
	Tue,  1 Sep 2026 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268209; cv=none; b=tfw/ig0/XhKtCo9kfL55XWkZivoCkouVvFOtFK9Edvl6jzw1rtwbgEqf9+GB0JMqmbgFp254+2lMbg8DyuvUI3Wem4DUMpyq2lukk33ImP60kD4izA3vlD+bdRUo2igvT7c52kLrdoFwvZaRlV7IzwXMau2fYMo1Fs9n4ALFv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268209; c=relaxed/simple;
	bh=OKIkiopZvOHFEvaWwxTiwhtsNUzsLjSZHyd2DVtAsds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggkGvXQ0HFSbodc57N6BO54l2hVF/oWX5XUYDNj5v/wF+vk0iXNX/dZ+480A257PDPDmh6jx+uuU/AeSyOS8y2XkIdGYsKvfEzm221J4wChFsTYRRSIA0ZgyD1KgvjNec+RgESRz5FTnekFLb5Ww4AjMEoobzfUChiUow5MZslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fxb7V6Qe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fxb7V6Qe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788268208; x=1819804208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OKIkiopZvOHFEvaWwxTiwhtsNUzsLjSZHyd2DVtAsds=;
  b=fxb7V6QeGVSCQu/iUJgTdWYl9DgYTlNtUnTtU0EryM+rzbzYWkYcSuQO
   d6uYXWHyc5ldScLQl+xHoHvlseL2L1JAgwdU7CtbE8gurrf7MfJH2PTZO
   IQBuJegiDmX5EwZximrd7fPW2lmNBvvmhTKIJA8V9Vq9HATN7hfn7vvXg
   npv660eT3k/3i0hHLZNyRkqyE5NrtcMNflPigCZrW0J0D63OtNsqzZ15q
   Yoqy0h5Z6fzMPpXFq2Cke5SKKY1XEAK+y2cwdUL7ErxnTaOZ/sTceFoi0
   pq7Z/jl1ThKEzkhnuYfYIjj6IrkoOM5HuJIvKfoSU/DKuRYqysMvxOY68
   w==;
X-CSE-ConnectionGUID: PUp3sK2hTQCey08ae6w4jw==
X-CSE-MsgGUID: 9cGnNzD6QzG6uX2SmqNVRQ==
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="62987013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2026 06:10:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 1 Sep 2026 06:10:06 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 1 Sep 2026 06:10:02 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY interrupt to phylib
Date: Tue, 1 Sep 2026 18:39:47 +0530
Message-ID: <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The integrated PHY has no dedicated interrupt line; its interrupt is
delivered in-band as the PHYINT bit in STATUS0, which raises the MAC-PHY
SPI interrupt via the extended status. phy_mac_interrupt() only triggers
a link-status re-read and cannot make the PHY driver read and acknowledge
its interrupt source registers, so expose the PHY interrupt to phylib as a
nested virtual IRQ instead.

Use dummy_irq_chip as the irqchip, map a virtual IRQ and assign it to
phydev->irq before phy_connect_direct() so phylib enters interrupt mode
and uses the PHY driver's config_intr/handle_interrupt. Unmask PHYINT in
INT_MASK0, and when it is seen in the extended status, dispatch
handle_nested_irq() synchronously from the sleepable threaded IRQ. PHYINT
is level triggered, so acking the PHY source there clears it before the
next data chunk, avoiding a storm.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 69 +++++++++++++++++++++++++++++++++--
 include/linux/oa_tc6.h        |  2 +
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 417c15d1ff42..6c93a61d8d2d 100644
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
@@ -575,6 +579,44 @@ static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
 	mdiobus_free(tc6->mdiobus);
 }
 
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
 static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 {
 	int ret;
@@ -600,6 +642,16 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 		return -ENODEV;
 	}
 
+	ret = oa_tc6_phy_irq_setup(tc6);
+	if (ret) {
+		oa_tc6_mdiobus_unregister(tc6);
+		return ret;
+	}
+
+	/* Deliver the PHY interrupt through the nested virtual IRQ. Set before
+	 * phy_connect_direct() so phylib enters interrupt mode.
+	 */
+	tc6->phydev->irq = tc6->phy_virq;
 	tc6->phydev->is_internal = true;
 	ret = phy_connect_direct(tc6->netdev, tc6->phydev,
 				 &oa_tc6_handle_link_change,
@@ -607,6 +659,7 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 	if (ret) {
 		netdev_err(tc6->netdev, "Can't attach PHY to %s\n",
 			   tc6->mdiobus->id);
+		oa_tc6_phy_irq_teardown(tc6);
 		oa_tc6_mdiobus_unregister(tc6);
 		return ret;
 	}
@@ -622,6 +675,7 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 		return;
 
 	phy_disconnect(tc6->phydev);
+	oa_tc6_phy_irq_teardown(tc6);
 	oa_tc6_mdiobus_unregister(tc6);
 }
 
@@ -661,7 +715,7 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
 }
 
-static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
+static int oa_tc6_unmask_interrupts(struct oa_tc6 *tc6)
 {
 	u32 regval;
 	int ret;
@@ -670,7 +724,8 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
-	regval &= ~(OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
+	regval &= ~(OA_TC6_INT_MASK0_PHY_INT_MASK |
+		    OA_TC6_INT_MASK0_TX_PROTOCOL_ERR_MASK |
 		    OA_TC6_INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
 		    OA_TC6_INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
 		    OA_TC6_INT_MASK0_HEADER_ERR_MASK);
@@ -763,6 +818,14 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
 		return ret;
 	}
 
+	/* Dispatch the PHY interrupt to phylib via the nested virtual IRQ so
+	 * the PHY driver reads and acknowledges its status. PHYINT is level
+	 * triggered, so doing this synchronously here (in the sleepable
+	 * threaded IRQ) clears the source before the next data chunk.
+	 */
+	if (FIELD_GET(OA_TC6_STATUS0_PHY_INT, value))
+		handle_nested_irq(tc6->phy_virq);
+
 	if (FIELD_GET(OA_TC6_STATUS0_RX_BUFFER_OVERFLOW_ERROR, value)) {
 		tc6->rx_buf_overflow = true;
 		oa_tc6_cleanup_ongoing_rx_skb(tc6);
@@ -1400,7 +1463,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 		return NULL;
 	}
 
-	ret = oa_tc6_unmask_macphy_error_interrupts(tc6);
+	ret = oa_tc6_unmask_interrupts(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
 			"MAC-PHY error interrupts unmask failed: %d\n", ret);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 27f652d4920b..c470ddddc77f 100644
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
-- 
2.43.0

