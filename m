Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894349C4BE;
	Thu, 15 Oct 2026 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046833; cv=none; b=qzkXA/fYehsrw1qkhAqp6FhTI/+gPlILJ3ajUzm9LFJLx7p3iJhrURRIU27qk69gpFXDdMmP+xC/bV4lbW41vyy9oqQM2hVwMQ8C8cskI/zsMl0BOkIxr3llVuc7FQl2FCfLHJgUpucNVCSZJvf5ZX41adyBwpr3hdl+UwhqYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046833; c=relaxed/simple;
	bh=Fhi2QQE0gYXCC0ZbXJOZaqvp8cju90o459tkZDIGBG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BJlRNtec9UjSZbzZ8nGqHJMN7YuOEUoDSsAeK/sg4vUUrzBRo/tcvx+t9CNDqXGdiC9Zi73BW5WVRr4TPvpVGa1PLJ5BH1CYM1w+/4UPsaLB9aDMame5FPmXHjJ69iqDQ9HIFHIP4VaDpWmrFYuAB/z30fsjjpIfNcc5DiEnpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Oct
 2026 14:46:59 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Oct 2026 14:46:59 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 15 Oct 2026 14:46:54 +0800
Subject: [PATCH net-next v3 2/6] net: ftgmac100: Add AST2700 compatible
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-support_ast2700-v3-2-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
In-Reply-To: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792046819; l=2037;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Fhi2QQE0gYXCC0ZbXJOZaqvp8cju90o459tkZDIGBG4=;
 b=dasE0q/o2zU1asKr1LkswAg7RIWWi7K1CPI17Bwy24mF1ko+vjReq0aAa8dPAED0gK7QSZ/tS
 Go1LkSkapUvDhdX7XXRpyLunL6HNkp2AFcQRUxwcBL4PPrN1H/2vqRk
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add match data for the Aspeed AST2700 FTGMAC100 controller and wire
its compatible string into the OF match table. This lets AST2700 device
tree nodes bind to the ftgmac100 driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 6d2fe5c2f390..67b1fa464a42 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -37,7 +37,8 @@ enum ftgmac100_mac_id {
 	FTGMAC100_FARADAY = 1,
 	FTGMAC100_AST2400,
 	FTGMAC100_AST2500,
-	FTGMAC100_AST2600
+	FTGMAC100_AST2600,
+	FTGMAC100_AST2700
 };
 
 struct ftgmac100_match_data {
@@ -2017,7 +2018,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 
 	if (priv->mac_id == FTGMAC100_AST2400 ||
 	    priv->mac_id == FTGMAC100_AST2500 ||
-	    priv->mac_id == FTGMAC100_AST2600) {
+	    priv->mac_id == FTGMAC100_AST2600 ||
+	    priv->mac_id == FTGMAC100_AST2700) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -2131,6 +2133,10 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
 	.mac_id = FTGMAC100_AST2600
 };
 
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
+	.mac_id = FTGMAC100_AST2700
+};
+
 static const struct ftgmac100_match_data ftgmac100_match_data_faraday = {
 	.mac_id = FTGMAC100_FARADAY
 };
@@ -2142,6 +2148,8 @@ static const struct of_device_id ftgmac100_of_match[] = {
 	  .data = &ftgmac100_match_data_ast2500 },
 	{ .compatible = "aspeed,ast2600-mac",
 	  .data = &ftgmac100_match_data_ast2600 },
+	{ .compatible = "aspeed,ast2700-mac",
+	  .data = &ftgmac100_match_data_ast2700 },
 	{ .compatible = "faraday,ftgmac100",
 	  .data = &ftgmac100_match_data_faraday },
 	{ }

-- 
2.34.1

