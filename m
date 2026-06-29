Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7C38BF70;
	Mon, 29 Jun 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713433; cv=none; b=GVqrwftx7xcV4j/wN4+D8uedHJZOnh8k8fdzQTnCFP8N0IPX0iUmiPMMA2WdY+6ONlUbhBa3/sdgSr5esdvyA9oQx4IJ5IcUnjMEBM7UPzKgIyntk15pxU3AQvIytWq/hN4o9mRb37kn+8NYG9aAWmQnsPWL3VEYOPZEcu1kJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713433; c=relaxed/simple;
	bh=VPJi2cIQuJDpUIwWLkxykQlnvqeYMQtlGJ5MDCi4lBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQ2pHWZHtebWh7oWa3NNDcoZofqXJIdkzo4YaJ64YF7DcjCIuzFkDERzalWtg6Jm4tViC+H1hM4O5nHE+Nb0V++sc3y2NaiznVhjpk+Jyv+G6AzzfcL7DgaBwnGr5PU8oTgW3MRXxhS236qkTOlHgz23W2DJ1irAQJZAltyVhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=J7/2etm/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="J7/2etm/"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T69X2M03467453, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782713374;
	bh=sumE0omfIVlbme3PjHU0vlrYuXma32um34dZdLjaBiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=J7/2etm/B0ihDMdSQYo7kAVMs1Bt6+Kj6w0PSVZC/yAn+721aZZIv9b15xWYLKzXs
	 fm/erpehJLACYd78rRXgN75hUj6iwRuccpBe2PVjrZRY8G0sikdPGCFx8JV01V7neC
	 v6CTqU7WB8egCY85bIE3LhYlYEpOQox4YFWk79WiO6HDUIbUU9JGcV7MSryQasyeA7
	 lSEudtEPLuOAbLL2d4l5MY8uzaDOvpMTh1NNQOaWh+67IwHuKhKa3MCh/J7EjKEtWA
	 xcdaWfUoFYC11Yg6jwavIuqumtEUnj4DCto8+KH1jK5q7ovj5bvJzeXpuauuAvMDlu
	 CGZaBKcX38ZcQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T69X2M03467453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:09:34 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:09:33 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:09:33 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 2/7] r8169: create a virtual interrupt for linkchg
Date: Mon, 29 Jun 2026 14:09:26 +0800
Message-ID: <20260629060931.1006-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260629060931.1006-1-javen_xu@realsil.com.cn>
References: <20260629060931.1006-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Create a virtual interrupt for linkchg. To support phylink, we should
try to decouple most of tp->phydev, so we add virtual interrupt for mac
interrupt to inform the change of link status.
generic_handle_domain_irq() will help us to call phylib.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - new file

Changes in v3:
 - if irq_create_mapping fail, return -EINVAL
---
 drivers/net/ethernet/realtek/r8169_main.c | 51 +++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 43bc1456bf04..ee33f01af6df 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -21,6 +21,8 @@
 #include <linux/in.h>
 #include <linux/io.h>
 #include <linux/ip.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/tcp.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
@@ -775,6 +777,7 @@ struct rtl8169_private {
 	struct r8169_led_classdev *leds;
 
 	u32 ocp_base;
+	struct irq_domain *phy_irq_domain;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -4870,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	}
 
 	if (status & LinkChg)
-		phy_mac_interrupt(tp->phydev);
+		generic_handle_domain_irq(tp->phy_irq_domain, 0);
 
 	rtl_irq_disable(tp);
 	napi_schedule(&tp->napi);
@@ -5424,11 +5427,39 @@ static int r8169_mdio_write_reg_c45(struct mii_bus *mii_bus, int addr,
 	return 0;
 }
 
+static int rtl_phy_irq_map(struct irq_domain *d, unsigned int irq,
+			   irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, d->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rtl_phy_irq_domain_ops = {
+	.map = rtl_phy_irq_map,
+};
+
+static void rtl_phy_irq_cleanup(void *data)
+{
+	struct rtl8169_private *tp = data;
+	int virq;
+
+	if (tp->phy_irq_domain) {
+		virq = irq_find_mapping(tp->phy_irq_domain, 0);
+		if (virq)
+			irq_dispose_mapping(virq);
+
+		irq_domain_remove(tp->phy_irq_domain);
+		tp->phy_irq_domain = NULL;
+	}
+}
+
 static int r8169_mdio_register(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
 	struct mii_bus *new_bus;
-	int ret;
+	int ret, virq;
 
 	/* On some boards with this chip version the BIOS is buggy and misses
 	 * to reset the PHY page selector. This results in the PHY ID read
@@ -5446,7 +5477,6 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->name = "r8169";
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
-	new_bus->irq[0] = PHY_MAC_INTERRUPT;
 	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
@@ -5459,6 +5489,21 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		new_bus->write_c45 = r8169_mdio_write_reg_c45;
 	}
 
+	tp->phy_irq_domain = irq_domain_add_linear(NULL, 1,
+						   &rtl_phy_irq_domain_ops, tp);
+	if (!tp->phy_irq_domain)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(&pdev->dev, rtl_phy_irq_cleanup, tp);
+	if (ret)
+		return ret;
+
+	virq = irq_create_mapping(tp->phy_irq_domain, 0);
+	if (!virq)
+		return -EINVAL;
+
+	new_bus->irq[0] = virq;
+
 	ret = devm_mdiobus_register(&pdev->dev, new_bus);
 	if (ret)
 		return ret;
-- 
2.43.0

