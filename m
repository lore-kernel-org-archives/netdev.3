Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D53BB9FC;
	Sun, 27 Sep 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493461; cv=none; b=Y7vzY1XgQXg16h6+z4M+RJ1AQehGFT8N8H0cvz4kmnqDCOZC4WH5EyxTatYQjnJg/JfwLjgH2SZsFpjARFFId4DWvrJ2b0wSfEMR81T6gSACtsNSxcVwt9EfC0VBI0FtYgNMwZISe1ENlppR031FFYqu3EMwSUcTLyQjUSl/BtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493461; c=relaxed/simple;
	bh=g6gcc5LC0udmFwEVnx/sPtwN13WX4iAqvqBG418m8KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GX9agsblRqp8vzixs7LxAnxQj26vba63R5i7FWRjyv0iWiPKZ4LVEJeTis58Zt9dglnnEemHH1NW+HcebBNVh4ceG1ouYCQX9GC7MUPKhVedIuEE3kdID0ViysntI2o+SbpAZo2ShENJ3G2mv6zMi8UfKJkn1luqlhZprTHCKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 27 Sep
 2026 15:16:21 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 27 Sep 2026 15:16:21 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Sun, 27 Sep 2026 15:16:22 +0800
Subject: [PATCH 3/5] net: ftgmac100: Enable AST2700 RMII support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260927-support_ast2700-v1-3-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
In-Reply-To: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790493380; l=3468;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=g6gcc5LC0udmFwEVnx/sPtwN13WX4iAqvqBG418m8KU=;
 b=nmGuWsq+qv404745GheS49rrT3w0SyWGbnPRSICsO+IResaM+hyL0H3+z80mf6hxXiMyb/k6E
 XlCY+HXcHSwDNd2DHSDixjCvIpYr9+pWPIZgGtVo3PpUpRFI8OuV/eA
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Set the RMII enable bit when an AST2700 port uses RMII so the MAC is
programmed for the selected interface mode. Describe the requirement as
a match-data quirk instead of checking the MAC generation in the data
path, allowing later compatible controllers to opt into the behavior.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 16 ++++++++++++++--
 drivers/net/ethernet/faraday/ftgmac100.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 67b1fa464a42..b835472da360 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -41,8 +41,11 @@ enum ftgmac100_mac_id {
 	FTGMAC100_AST2700
 };
 
+#define FTGMAC100_QUIRK_RMII_ENABLE	BIT(0)
+
 struct ftgmac100_match_data {
 	enum ftgmac100_mac_id mac_id;
+	u32 quirks;
 };
 
 /* Arbitrary values, I am not sure the HW has limits */
@@ -79,6 +82,7 @@ struct ftgmac100 {
 	void __iomem *base;
 
 	enum ftgmac100_mac_id mac_id;
+	u32 quirks;
 
 	/* Rx ring */
 	unsigned int rx_q_entries;
@@ -355,6 +359,7 @@ static void ftgmac100_init_hw(struct ftgmac100 *priv)
 static void ftgmac100_start_hw(struct ftgmac100 *priv)
 {
 	u32 maccr = ioread32(priv->base + FTGMAC100_OFFSET_MACCR);
+	struct phy_device *phydev = priv->netdev->phydev;
 
 	/* Keep the original GMAC and FAST bits */
 	maccr &= (FTGMAC100_MACCR_FAST_MODE | FTGMAC100_MACCR_GIGA_MODE);
@@ -383,6 +388,11 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
 	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
 		maccr |= FTGMAC100_MACCR_RM_VLAN;
 
+	if ((priv->quirks & FTGMAC100_QUIRK_RMII_ENABLE) &&
+	    phydev->interface == PHY_INTERFACE_MODE_RMII) {
+		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
+	}
+
 	/* Hit the HW */
 	iowrite32(maccr, priv->base + FTGMAC100_OFFSET_MACCR);
 }
@@ -1942,7 +1952,7 @@ static int ftgmac100_probe_dt(struct net_device *netdev,
 
 static int ftgmac100_probe(struct platform_device *pdev)
 {
-	const struct ftgmac100_match_data *match_data;
+	const struct ftgmac100_match_data *match_data = NULL;
 	enum ftgmac100_mac_id mac_id;
 	struct resource *res;
 	int irq;
@@ -1987,6 +1997,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
 	priv->mac_id = mac_id;
+	priv->quirks = match_data ? match_data->quirks : 0;
 	INIT_WORK(&priv->reset_task, ftgmac100_reset_task);
 
 	/* map io memory */
@@ -2134,7 +2145,8 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
 };
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
-	.mac_id = FTGMAC100_AST2700
+	.mac_id = FTGMAC100_AST2700,
+	.quirks = FTGMAC100_QUIRK_RMII_ENABLE,
 };
 
 static const struct ftgmac100_match_data ftgmac100_match_data_faraday = {
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..8c35c895b146 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -167,6 +167,7 @@
 #define FTGMAC100_MACCR_RX_BROADPKT	(1 << 17)
 #define FTGMAC100_MACCR_DISCARD_CRCERR	(1 << 18)
 #define FTGMAC100_MACCR_FAST_MODE	(1 << 19)
+#define FTGMAC100_MACCR_RMII_ENABLE	BIT(20)
 #define FTGMAC100_MACCR_SW_RST		(1 << 31)
 
 /*

-- 
2.34.1

