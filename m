Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144263A5E65
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773313; cv=none; b=WFa0qUuNTGE51/wKLTlLiknPUhQWBwDcD2sZ/YNhDIZHz3kRWCUSJ1M7eX2qunfliRZzVc5wVl70sA494kC+QIbJfM5azFFcGoKoX7FKSKqx/zg3/SQuhNWGW1gg7hIglZjgvQ9NzDIgq5Y6YnhvtddfxIvLI7IIrEr72MWWIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773313; c=relaxed/simple;
	bh=4ks3rAJb8J/EyVRzoWKWp1kEAOgJ3ujF+0kq4he6YZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBqmyNh9rdIubkNEoeKzbWDiSJCPHRGXKVH0KCwXjNNc7pgN5hbvMrXHsmDOHBewzD0zwNFU1uxfex7BEgi2R9/5HwFd7bijAhx1HkFMmacVUTFSyup3BW4SXs31BTtS0+ycfTs1vsZJlgx1ZWHF02RR1wJZt0g41TesM4JRlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=oTRX+at5; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="oTRX+at5"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026091823150360e69b58f90002073f
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 01:15:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Gkr6rLJbjHVLjcemmBT2y0ewkqIp355mB66oA3cIa/Q=;
 b=oTRX+at57wk2p5fKdpaUO0c6V3WL5MpAe9aL1zQFI8qKd1O9lgAicvMmDoN+6kakKbfLub
 VPbGi+REkpOeeZlJN6+j8cxSb4kgBT3//GYfRFcftozFzWz18zqOXammZ+drsv2OdNeB0yxY
 ZH1zr4ZY45ikM2m66NkvPJgI7uDs+TPr1nNuF76eJUgsO07iohmkazS1JjDU36dXwmVXBbPr
 u3Kqt2pqdiFtWPr0LM9JAw2r698PmsttI9iBEmjjr/t/ZebTTlbTwM9PmenRTRT6RpADmAHb
 gRCejLWnr0dnoQKx09LjBAsFV3DNOROMs6pXbb8+QY75FmeaRyE/pPCA==;
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
Subject: [PATCH net-next v4 2/3] net: ethernet: oa_tc6: return ERR_PTR from oa_tc6_init()
Date: Sat, 19 Sep 2026 01:14:49 +0200
Message-ID: <20260918231450.55966-3-alessandro.zini@siemens.com>
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

oa_tc6_init() returns NULL on failure, so the reason for the failure is
lost and both callers turn it into a plain -ENODEV. In preparation for
acquiring an optional reset GPIO, which can return -EPROBE_DEFER when the
GPIO provider is not available yet, the error code has to reach the driver
core, otherwise the SPI device would never be probed again.

Convert oa_tc6_init() to return an ERR_PTR on failure instead of NULL,
and update the lan865x and adin1140 callers to check with IS_ERR() and
propagate the error with PTR_ERR().

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
Changes in v4:
- None (renumbered from 3/4 to 2/3).

Changes in v3:
- New patch to allow proper propagation of error codes, such as
  -EPROBE_DEFER.
 drivers/net/ethernet/adi/adin1140.c           |  4 +--
 .../net/ethernet/microchip/lan865x/lan865x.c  |  4 +--
 drivers/net/ethernet/oa_tc6.c                 | 27 ++++++++++---------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
index 93710baca1517..adc6e2ef44f8c 100644
--- a/drivers/net/ethernet/adi/adin1140.c
+++ b/drivers/net/ethernet/adi/adin1140.c
@@ -725,8 +725,8 @@ static int adin1140_probe(struct spi_device *spi)
 	tc6_quirks.quirk_flags = OA_TC6_BROKEN_PHY;
 
 	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);
-	if (!priv->tc6)
-		return -ENODEV;
+	if (IS_ERR(priv->tc6))
+		return PTR_ERR(priv->tc6);
 
 	ret = devm_add_action_or_reset(&spi->dev, adin1140_oa_tc6_remove,
 				       priv->tc6);
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 26a2761332a5a..127afb9e9f141 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -347,8 +347,8 @@ static int lan865x_probe(struct spi_device *spi)
 	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
 
 	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
-	if (!priv->tc6) {
-		ret = -ENODEV;
+	if (IS_ERR(priv->tc6)) {
+		ret = PTR_ERR(priv->tc6);
 		goto free_netdev;
 	}
 
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 6fcc5f561d560..8c82bc8354ede 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1453,7 +1453,7 @@ static int oa_tc6_check_ctrl_protection(struct oa_tc6 *tc6)
  * @quirks: device specific modifiers for the OA TC6 protocol.
  *
  * Return: pointer reference to the oa_tc6 structure if the MAC-PHY
- * initialization is successful otherwise NULL.
+ * initialization is successful otherwise an ERR_PTR.
  */
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 			   struct oa_tc6_quirks *quirks)
@@ -1463,7 +1463,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 
 	tc6 = devm_kzalloc(&spi->dev, sizeof(*tc6), GFP_KERNEL);
 	if (!tc6)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	tc6->spi = spi;
 	tc6->netdev = netdev;
@@ -1476,60 +1476,61 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
-	if (spi_setup(tc6->spi) < 0)
-		return NULL;
+	ret = spi_setup(tc6->spi);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	tc6->spi_ctrl_tx_buf = devm_kzalloc(&tc6->spi->dev,
 					    OA_TC6_CTRL_SPI_BUF_SIZE,
 					    GFP_KERNEL);
 	if (!tc6->spi_ctrl_tx_buf)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	tc6->spi_ctrl_rx_buf = devm_kzalloc(&tc6->spi->dev,
 					    OA_TC6_CTRL_SPI_BUF_SIZE,
 					    GFP_KERNEL);
 	if (!tc6->spi_ctrl_rx_buf)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	tc6->spi_data_tx_buf = devm_kzalloc(&tc6->spi->dev,
 					    OA_TC6_SPI_DATA_BUF_SIZE,
 					    GFP_KERNEL);
 	if (!tc6->spi_data_tx_buf)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	tc6->spi_data_rx_buf = devm_kzalloc(&tc6->spi->dev,
 					    OA_TC6_SPI_DATA_BUF_SIZE,
 					    GFP_KERNEL);
 	if (!tc6->spi_data_rx_buf)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	/* Check the PROTE bit status so that we can reset the device */
 	ret = oa_tc6_check_ctrl_protection(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
 			"Failed to check the protection mode: %d\n", ret);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	ret = oa_tc6_sw_reset_macphy(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
 			"MAC-PHY software reset failed: %d\n", ret);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	ret = oa_tc6_unmask_macphy_error_interrupts(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
 			"MAC-PHY error interrupts unmask failed: %d\n", ret);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	ret = oa_tc6_phy_init(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
 			"MAC internal PHY initialization failed: %d\n", ret);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	ret = oa_tc6_enable_data_transfer(tc6);
@@ -1570,7 +1571,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 
 phy_exit:
 	oa_tc6_phy_exit(tc6);
-	return NULL;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
 
-- 
2.55.0

