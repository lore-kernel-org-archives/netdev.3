Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BB30F549;
	Mon,  2 Feb 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015735; cv=none; b=Hwde7d2bt6rEDwnMTL0mcvx9gpUpA5wLAAdB3VgNLwLghKumSshDeO2IfJ/rrkxhK0ZKaOAW6r4obwjR8OLnlSDvVeU4YaiOygFcFo7wQQBaJTuHDBvEi5xLQm9M9pqwx/WerXuQ1BGIRp+Whrtt49rGp8ahM54x716fN8BCSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015735; c=relaxed/simple;
	bh=TvPvwgbTpwSpyw/7g9BTYt5lpmiQYEi+FH4stMJoeMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ixMkSq4VkRytJSn7yd/sffMVG/KYMd0Bv9xcOrHRMioFMSjj0gyhscKEqQdKJUtJa+CrdsPu1UFX+JSrN3XsHS8NET52J6dD/Q1S2xmz6nhzeiyXA6KwXtHyhtLHbF3T56W4RTq6gw58yDVHUQ7LG1dmgb1CS2ZEP+7HuUBbjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Feb 2026 14:56:56 +0800
Subject: [PATCH net-next v3 02/15] net: ftgmac100: Add match data
 containing MAC ID
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-2-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015419; l=3993;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=NVi1QwkA7JxwSCPAVjGjUYu41AXXsXEhvfrBSk1vf/A=;
 b=0mX1VGeXx3NDPyuMM36dYgRQexaqSJFibj+CQOSTRX5ghfWzRfkQcGs8CevfE6JJdmE0rJdBb
 tpxvbUnAXCND3nUA0A3PfOwG8LutUXgm/Am+PgiZprQr8R+tlobT9UH
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

The driver supports 4 different versions of the FTGMAC core.  Extend
the compatible matching to include match data, which indicates the
version of the MAC. Default to the initial Faraday device if DT is not
being used. Lookup the match data early in probe to keep error handing
simple.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index bd768a93b9e6..104eb7b1f5bb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -33,6 +33,17 @@
 
 #define DRV_NAME	"ftgmac100"
 
+enum ftgmac100_mac_id {
+	FTGMAC100_FARADAY = 1,
+	FTGMAC100_AST2400,
+	FTGMAC100_AST2500,
+	FTGMAC100_AST2600
+};
+
+struct ftgmac100_match_data {
+	enum ftgmac100_mac_id mac_id;
+};
+
 /* Arbitrary values, I am not sure the HW has limits */
 #define MAX_RX_QUEUE_ENTRIES	1024
 #define MAX_TX_QUEUE_ENTRIES	1024
@@ -66,6 +77,8 @@ struct ftgmac100 {
 	struct resource *res;
 	void __iomem *base;
 
+	enum ftgmac100_mac_id mac_id;
+
 	/* Rx ring */
 	unsigned int rx_q_entries;
 	struct ftgmac100_rxdes *rxdes;
@@ -1835,6 +1848,8 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 
 static int ftgmac100_probe(struct platform_device *pdev)
 {
+	const struct ftgmac100_match_data *match_data;
+	enum ftgmac100_mac_id mac_id;
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
@@ -1843,6 +1858,16 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int err = 0;
 
+	np = pdev->dev.of_node;
+	if (np) {
+		match_data = of_device_get_match_data(&pdev->dev);
+		if (!match_data)
+			return -EINVAL;
+		mac_id = match_data->mac_id;
+	} else {
+		mac_id = FTGMAC100_FARADAY;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
@@ -1870,6 +1895,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	priv = netdev_priv(netdev);
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
+	priv->mac_id = mac_id;
 	INIT_WORK(&priv->reset_task, ftgmac100_reset_task);
 
 	/* map io memory */
@@ -1900,7 +1926,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (err)
 		goto err_phy_connect;
 
-	np = pdev->dev.of_node;
 	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
 		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
 		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
@@ -2090,11 +2115,31 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	free_netdev(netdev);
 }
 
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {
+	.mac_id = FTGMAC100_AST2400
+};
+
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2500 = {
+	.mac_id = FTGMAC100_AST2500
+};
+
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
+	.mac_id = FTGMAC100_AST2600
+};
+
+static const struct ftgmac100_match_data ftgmac100_match_data_faraday = {
+	.mac_id = FTGMAC100_FARADAY
+};
+
 static const struct of_device_id ftgmac100_of_match[] = {
-	{ .compatible = "aspeed,ast2400-mac" },
-	{ .compatible = "aspeed,ast2500-mac" },
-	{ .compatible = "aspeed,ast2600-mac" },
-	{ .compatible = "faraday,ftgmac100" },
+	{ .compatible = "aspeed,ast2400-mac",
+	  .data = &ftgmac100_match_data_ast2400},
+	{ .compatible = "aspeed,ast2500-mac",
+	  .data = &ftgmac100_match_data_ast2500 },
+	{ .compatible = "aspeed,ast2600-mac",
+	  .data = &ftgmac100_match_data_ast2600 },
+	{ .compatible = "faraday,ftgmac100",
+	  .data = &ftgmac100_match_data_faraday },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ftgmac100_of_match);

-- 
2.34.1

