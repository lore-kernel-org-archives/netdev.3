Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F636409635
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545259; cv=none; b=tMxin1xgczwHi7EqsptAm6mF9YTd4+ambMhg658nXWauX6+23WTlyGD+B+jTSN1v7IjdaZcEKNf4bC+4kis5uQJ+Y0DGW09vkKs8pAP/ErMNgGyB3Qzg9iPX6YD0jSL+x245tT31Rv+CwUWOI8erQfrbC48Fvs06QewNyVGNeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545259; c=relaxed/simple;
	bh=atKj9yZd7bOuDqF3xDDftWv9MTIMofHbixwNijMpl5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqqqZbHfha5DtB605P2H6rmCkRB8rAHYg3Tpk5t/0csnigF1TnyaeqvBxTXwCmW81wrKFC8NaBfEmxeiplGSsUPbkr0qgK7Fc+AbR0diELRhMY4FqnoWlBTanC67bW35rujb2e2FtwBYy+3mSQH+tFDYLUQ5jGDFYu/XbKeGlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=SPdXDaQZ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="SPdXDaQZ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260916075357ff5005dfd400020742
        for <netdev@vger.kernel.org>;
        Wed, 16 Sep 2026 09:53:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VCN4LnshPEHTnJ5tYfUXf9PUwPrJN1QyCFEQkQMpKrg=;
 b=SPdXDaQZxGW/gA1WT2vgJrloPlHSBS5bTYY0Eoz/ZncSZ6JLTK7Pf6WCknf8E3uV7Yg8le
 9nXEWSllJMhF5sppKWs1yW3IQK2w6tNsTo5lkhu0KHD33UOHOjALEUqiRMdNp2hztKKu0YY+
 h+xS/335qHpxI4hCrqUOzweI84k1tigVmiW963BoOHYfRGIgJ4TScTrePgFVekKuJE3XQma9
 h/+gs8zGQPbUTZQ0YTXqBwa13TBbJ3hk7M3RXfviod6QNv67nrnuis9GZleH09GV+lDKLrN5
 M9r1I713U0NKEaxJ1LxcFEhkejOIbw6bCCtKfDGMOHJeMzSB4wqHCvRA==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH net-next v2 2/2] net: ethernet: oa_tc6: add reset-gpios support
Date: Wed, 16 Sep 2026 09:53:49 +0200
Message-ID: <20260916075349.21822-3-alessandro.zini@siemens.com>
In-Reply-To: <20260916075349.21822-1-alessandro.zini@siemens.com>
References: <20260916075349.21822-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface specification
(v1.1, Section 8.2) defines an external RESET pin as an optional reset
source for the MAC-PHY.

Add support for an optional reset GPIO in oa_tc6_init(). If specified in
the device tree, assert the hardware reset line for 10 us and allow 1 ms
settle time for crystal oscillator startup before performing the initial
TC6 control protection check and software reset.

Suggested-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
Changes in v2:
- Moved reset GPIO handling from lan865x.c to common oa_tc6.c as suggested
  by Parthiban Veerasooran.

 drivers/net/ethernet/oa_tc6.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 6fcc5f561d560..a697e2cb99cd8 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -11,6 +11,8 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
@@ -88,6 +90,7 @@ struct oa_tc6 {
 	bool disable_traffic;
 	bool prot_ctrl;
 	enum oa_tc6_quirk_flag quirk_flags;
+	struct gpio_desc *reset_gpio;
 };
 
 enum oa_tc6_header_type {
@@ -1503,6 +1506,24 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	if (!tc6->spi_data_rx_buf)
 		return NULL;
 
+	tc6->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(tc6->reset_gpio)) {
+		dev_err_probe(&spi->dev, PTR_ERR(tc6->reset_gpio),
+			      "Failed to get reset GPIO\n");
+		return NULL;
+	}
+
+	if (tc6->reset_gpio) {
+		/* Assert hardware reset for 10 us (datasheet specifies min 5 us)
+		 * and allow 1 ms settle time for crystal oscillator startup.
+		 */
+		gpiod_set_value_cansleep(tc6->reset_gpio, 1);
+		fsleep(10);
+		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
+		fsleep(1000);
+	}
+
 	/* Check the PROTE bit status so that we can reset the device */
 	ret = oa_tc6_check_ctrl_protection(tc6);
 	if (ret) {
-- 
2.55.0

