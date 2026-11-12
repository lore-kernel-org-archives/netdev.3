Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472761;
	b=ajvFhMd0DO6JLk88/QpT+rAJ558NzC/zHmYlQKGv9xZyL/FZ2e/IZLNuTBLvt2q8TGNh
	 U85tKadKTS1PV+ja7Xht2vBd0qzLOJLerTUbs4o2QmZYIEIBuvy6URquszVcjVrUBHYrL
	 tqqlpaz1XJ13YOy485o96dDIW8AH1KZ+rWBt3hwBrzpbq/vETWv3N8+QmLY93FY/UGe6w
	 KQF6LyurP72cmktcYyM9AxIyZEZODV5fjVYFhWiQLzM0HrBkbih6ypE+LlimdQb+yEdGe
	 8KT2b8KSypZC3MX89VTRAbNR16RZA4nLA5sQA8Z+VZDJItYqZWMLobLrTc4iaUsNXtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472761;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LyXFiOgSd/gS7t17gC6C4jnHNJdK0hrmfTDD2nscfFE=;
	b=fiy08nMxLoobVD69nPnfmN6BxgQV7lXdp5kxCPfDX2Z0ebN8DVS9wkYRfvKwb3iiKZcn
	 z9XTXybukZHTwfiQxPEQ5swsLOVE7vLzsUGxLecouIbtHOp8WMp2z8XA9cl/FPCFm04sa
	 +E67Z2l/GKh2H5zL0B91CEYe1i8Zeyrane8ZU72tsXEbV5YDax3djOH9wO9qn9Diw7176
	 6+cr/nRnn98arf9rgLsKeFeQ1hgR7QwIrxdPxEPC63eJs5j9MSjseUQemsxcUT/bOxwq2
	 zWPDLk2Hm0h5iyyaQtktiTmYHrLNJZcsQHfGkLX2cdD9UlBycBdjPbWiXaOqAo7usXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FA606B245;
	Thu, 12 Nov 2026 08:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9FA606B245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 16:39:09 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 16:39:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 12 Nov 2026 16:39:09 +0800
Subject: [PATCH net-next v6 3/7] net: ftgmac100: Add AST2700 compatible
 support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-support_ast2700-v6-3-238020bf46cf@aspeedtech.com>
References: <20261112-support_ast2700-v6-0-238020bf46cf@aspeedtech.com>
In-Reply-To: <20261112-support_ast2700-v6-0-238020bf46cf@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472748; l=2037;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Fhi2QQE0gYXCC0ZbXJOZaqvp8cju90o459tkZDIGBG4=;
 b=nhUoFmymozzORK2bK/bQraXK706YLMqBau8OGaFJw4NHjVZZtJSdKP4c4DldtEB+Tkvbdx0wf
 kixROtlsKWDAEW6tYgstLdU449ZhJWUcMHBgCSO31x4TgYeGDwB/b0y
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

