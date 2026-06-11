Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307453BCD0D;
	Thu, 11 Jun 2026 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171071; cv=none; b=QnY42V6erFcXS+grdrXNSEVA+3stw4qVN+zBC9qvDfc+blD8LuDzxZiwoRJdcTX1odKPYskcSSCtrVhpyKCFesC4rrEJADCrNU6y1iKjD8vpnMt61LhBFeWtRdKvwTYrnf0q79NvNBnHOogrmtZPcb9cCpWAU9LWfvaveMRjojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171071; c=relaxed/simple;
	bh=OA1h+kHIqypaGWGaWoKnHPPo9S/tm73MZ9D4xvQ/P60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubHf4vLbMZG4uXv7JW9+apQb1uzg2nJ6xt0ERfxA5GKHlMUQQcIVOB3yDiaJaG+ep543+Wj+mBu564tzXP29MiZoM1UbNtlSWQHrZnmm4RcMWERW5xcy5RhNCYbQwdLUuLqri1PUBUwqww3DZgQTSQ2x5x59noP2iD8ryYJg3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=cV+ByHY4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="cV+ByHY4"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B9hlr971836008, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781171027;
	bh=W5FdeEA/cErku+lkJXPhKzCIVXDSt7rDM7KIayosdkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cV+ByHY4yF39hYkgh9/Bbrru6PNK9nqfkOgJIM4CIgY+dDEfOkJE2/wmILTgWDmjm
	 cHn/JDSfFsf4NbOxd+5HzWuUPmQTB6LvSryQonikMPm00ejGPJN5j550Izj2ofVO1T
	 ToFUH1KR9eGXPTQGgufp2yjwjPsfubwMpTAFHVQIksiNtaXEhg39V1zb3MI5uLford
	 6RwJf969D0+wWKGMynbOF6boBWmMwCaIz4J2/2HW2Ui5RuTFLfJWDLr6YSjd/chpTj
	 r5Yo1lpwVS7fMpF2/Vv90saKvt6ePiTIfqvalW5zvjTcShURHBfuWTJWUKG/oADWDx
	 o5QKfvLI+jENA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B9hlr971836008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 17:43:47 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 17:43:47 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 17:43:47 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 2/6] r8169: create a virtual interrupt for linkchg
Date: Thu, 11 Jun 2026 17:43:41 +0800
Message-ID: <20260611094345.880-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260611094345.880-1-javen_xu@realsil.com.cn>
References: <20260611094345.880-1-javen_xu@realsil.com.cn>
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
---
 drivers/net/ethernet/realtek/r8169_main.c | 51 +++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c60710f9bd21..560f987437b6 100644
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
@@ -4869,7 +4872,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	}
 
 	if (status & LinkChg)
-		phy_mac_interrupt(tp->phydev);
+		generic_handle_domain_irq(tp->phy_irq_domain, 0);
 
 	rtl_irq_disable(tp);
 	napi_schedule(&tp->napi);
@@ -5423,11 +5426,39 @@ static int r8169_mdio_write_reg_c45(struct mii_bus *mii_bus, int addr,
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
@@ -5445,7 +5476,6 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->name = "r8169";
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
-	new_bus->irq[0] = PHY_MAC_INTERRUPT;
 	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
@@ -5458,6 +5488,21 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
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
+		ret = -EINVAL;
+
+	new_bus->irq[0] = virq;
+
 	ret = devm_mdiobus_register(&pdev->dev, new_bus);
 	if (ret)
 		return ret;
-- 
2.43.0

