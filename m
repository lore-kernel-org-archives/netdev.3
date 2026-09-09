Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971E542809
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958470; cv=none; b=ojEKOvGOscYcGF6hK2TG1BTVgJiVby8D3FSN/l3Pb6dBr5IYVN7VeT8+ESjYkw7S1celb7QyVuWXmQ/fFf/hWGLFl3cEECKRJ+vWFwGxZ8BH9XlGBCW2XlCD36/8pD3KTOrFosfsR2hBq/Qbt54HDO5vHqgfDwyrYIK9WxIkcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958470; c=relaxed/simple;
	bh=LxXuSemfvLfB0hYjhrPyjrstL6HPZJMt/PvEriFCrkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXX1A5V1pJ1P0IiwKZIbbRHXn5NDuBoEI5WaiiaWLhCsHDgol0HogZhjT+Lo7YxubGuLJIxHFVX7fKOckcs1N+ecYOo0uQL9niU2kufEQ5Y7/CC0UQx1GujQW2N8GX0Ylt8jIhbPrroQio3iw1v10l5YDirmQfu7Am+BvL+IZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=ly5zwG0G; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="ly5zwG0G"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202609091254167e6ec63d0f000207c9
        for <netdev@vger.kernel.org>;
        Wed, 09 Sep 2026 14:54:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uARyWAzAhNOFNlSn1qnqPZqLHMWebU/zTPfFGQFWQfo=;
 b=ly5zwG0Gog2ml5AQLyT48BwaPeaE2JvU3uw+46X2sO5h+Jrh1mbwWK3NebNXOPOq8+SEjV
 4eoJ1WT8iGYxFA0m2Sl+U0bolcV+rmmHpWHS6wWTkdjHwLC3tPXd7cOBdjwfAbBojda4X1Cn
 vPCc3PYmPjQqzuBETcqXtnZFLikVbbP3RUkTWxjV7XdLs0QiDLP7KD4Ro81STSxR/6JQL0OX
 ujqZA8/Us7Q55tNwfawTzg6BecuamOc29wxA8lwZXdWOcLkF8rlYPgf/yv1brphwZtB06pp3
 SAYWXUlHAow7CypQcnkh/sQWg/KT1uL8r9SpBhnYGGNv/kXJHF4Dngxg==;
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
Subject: [PATCH net-next 2/2] net: ethernet: microchip: lan865x: add reset-gpios support
Date: Wed,  9 Sep 2026 14:53:58 +0200
Message-ID: <20260909125358.23003-2-alessandro.zini@siemens.com>
In-Reply-To: <20260909125358.23003-1-alessandro.zini@siemens.com>
References: <20260909125358.23003-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

Add support for an optional reset GPIO. If specified, assert the
hardware reset line for 10 us (datasheet specifies min 5 us) and allow
1 ms settle time for crystal oscillator startup before starting OA TC6
communication.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 .../net/ethernet/microchip/lan865x/lan865x.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 26a2761332a5a..62abc577be90d 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -9,6 +9,8 @@
 #include <linux/kernel.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 #define DRV_NAME			"lan8650"
 
@@ -41,6 +43,7 @@ struct lan865x_priv {
 	struct net_device *netdev;
 	struct spi_device *spi;
 	struct oa_tc6 *tc6;
+	struct gpio_desc *reset_gpio;
 };
 
 static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8 *mac)
@@ -346,6 +349,24 @@ static int lan865x_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, priv);
 	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
 
+	priv->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpio)) {
+		ret = dev_err_probe(&spi->dev, PTR_ERR(priv->reset_gpio),
+				    "Failed to get reset GPIO\n");
+		goto free_netdev;
+	}
+
+	if (priv->reset_gpio) {
+		/* Assert hardware reset for 10 us (datasheet specifies min 5 us)
+		 * and allow 1 ms settle time for crystal oscillator startup.
+		 */
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
+		fsleep(10);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
+		fsleep(1000);
+	}
+
 	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
 	if (!priv->tc6) {
 		ret = -ENODEV;
-- 
2.55.0

