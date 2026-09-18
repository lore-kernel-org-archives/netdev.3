Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32C35201B
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773312; cv=none; b=Jb2mw38GS22YTJMmHIFSlJ3IZL7YvhRhL1IXtor1Iz5mpIyE+RxPpuwoNnW9En5zgJkiC9JqonaFso7W7IW91R6i72EWUzSN+Q2NyGq0HAl5RFdDFIzXutSVa6X+GXgh3K+MLkPW9PqWxaN9OSuh6qmD2XdUoGBKVoADGYu2Byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773312; c=relaxed/simple;
	bh=njv0aHK0Wsob9AbSpsOdZFyaIoN/zXJeZ5/gR3k/I6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI4SLuu1IAyMeoqXjL7XMHnpwljyCN2jCcOTEcsGuLCsbIknHVuRG3i8ic/NNtAsfhh5eA5GqLsOZZSJ/IlOggoBOVVMmDx5RL7l+UZeiPAQXANSb7EaMh2WDtUBrK+ZWYILb3+m+vS6Zl7Y3RCFnOlsjVu11RZdbC2ltr9kypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=MUoHGSW7; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="MUoHGSW7"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202609182315044fc595e04d000207f4
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 01:15:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iRt54UFriLwuvrWsaUSqNIpmcgh0PUNJdcQKFqrAaDg=;
 b=MUoHGSW7xxvsZp32b6QuAep0g260rCb1Tkq2Rk3oNzwJNPQQqJ+AXeN572RviYT9vkjcmp
 R3aBs9NhOKO4pR8X202HmNZgBL3SuWjeLzzKjaY1NZ18Scnxkak7OAccOGj25PtqaaC0J43C
 QAvS1ny6qva0hxRYqwVoR0l0a30q6wDaPWppdk6BDSt/QvLarZcJO5/uQtyJIPUT0XBVY0F2
 vPXLjBxVjV3UDYuz3IxaEHMh6jnG75ZHEtHBqXr8MliVHaumXJUSXHmuM/PQMNo/cXKOTQct
 miCNp7S4hBbnMwHdxzE/Ggjlo6xW4fEgqajhGE7E4OVZrJMBk843u03w==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ciprian Regus <ciprian.regus@analog.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH net-next v4 3/3] net: ethernet: oa_tc6: add reset-gpios support
Date: Sat, 19 Sep 2026 01:14:50 +0200
Message-ID: <20260918231450.55966-4-alessandro.zini@siemens.com>
In-Reply-To: <20260918231450.55966-1-alessandro.zini@siemens.com>
References: <20260918231450.55966-1-alessandro.zini@siemens.com>
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
(v1.1, section 8.2) defines an external RESET pin as an optional reset
source for the MAC-PHY.

Add support for an optional reset GPIO in oa_tc6_init(). The GPIO is
requested asserted, kept asserted for 10 us and, once deasserted, 1 ms of
settle time is allowed for the crystal oscillator startup before the
initial TC6 control protection check and software reset are performed.

As the reset handling lives in the common library, it is available to all
MAC-PHY devices using oa_tc6_init() that provide an external reset pin.

Suggested-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
Changes in v4:
- Clarified commit message regarding devices with external reset pins
  (renumbered from 4/4 to 3/3).

Changes in v3:
- Request the GPIO with GPIOD_OUT_HIGH and drop the now redundant
  gpiod_set_value_cansleep(..., 1) call, as suggested by Qingfang Deng.
- Return the error from dev_err_probe() so that -EPROBE_DEFER is
  propagated to the driver core.
- Reworded comment to stay within 80 columns.
- Sorted the new includes into the existing include block.

Changes in v2:
- Moved reset GPIO handling from lan865x.c to common oa_tc6.c as suggested
  by Parthiban Veerasooran.
 drivers/net/ethernet/oa_tc6.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 8c82bc8354ede..364027c39fa4a 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
 #include <linux/mdio.h>
@@ -88,6 +90,7 @@ struct oa_tc6 {
 	bool disable_traffic;
 	bool prot_ctrl;
 	enum oa_tc6_quirk_flag quirk_flags;
+	struct gpio_desc *reset_gpio;
 };
 
 enum oa_tc6_header_type {
@@ -1504,6 +1507,22 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	if (!tc6->spi_data_rx_buf)
 		return ERR_PTR(-ENOMEM);
 
+	tc6->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(tc6->reset_gpio))
+		return ERR_PTR(dev_err_probe(&spi->dev,
+					     PTR_ERR(tc6->reset_gpio),
+					     "failed to get reset gpio\n"));
+
+	if (tc6->reset_gpio) {
+		/* Keep the reset asserted for 10 us and then allow 1 ms of
+		 * settle time for the crystal oscillator startup.
+		 */
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

