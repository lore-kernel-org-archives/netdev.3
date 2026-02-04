Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A835FF67;
	Wed,  4 Feb 2026 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182804; cv=none; b=PJF/s6I56Acxo+E/4EQ+uYQGCorT2i6Pdf0H61RAuONWQNVVkTilJIP17Cr8cxn/1XHLmi3UoFxq+8IzwzNmPqH7HxI3P3eZeqcIqAwJ/OG46Me32454kQZeC8M557LV8uLJZH96vpzlP20Qn4HsCZx4J/04Q6/fvTabbtfajgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182804; c=relaxed/simple;
	bh=V2JOY0gasY29VXtxo3LEmIpGkBi9oafw6uc+/ZJToXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rCMrXyXAIZIgWIs8NpbhAD2fqI2zGyyAA/F5BgcDUAHFkHb6upl6RWgo64Wq7LYazy+LRadXNI8p40Y0FKsyPa9JfeCqLs/4BW2er2/97sPH8nPKJJ9XWPsaXs5umlhGuGRN8dwkmE1G6JYdbt/sKCPNFJAp5SFBTYNTJSlVySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Feb
 2026 13:26:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Feb 2026 13:26:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Feb 2026 13:26:36 +0800
Subject: [PATCH net-next v4 10/15] net: ftgmac100: Simplify legacy MDIO
 setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-10-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=1096;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=DGnv6La43c/7aB3OKSk34oqJb6jYWEE5545lnKEdofo=;
 b=qqZcaGrIla4O4xY9Jwr/x3dYbntzuA/JNS4/QvcEmZcgCnBn4J1K1IV0zwTj2XZPpwPgxKcxy
 KFsx00KtEdrCw7e9g8heNNrN1NxKHE85FzLvyrwRzg2ngif4Sh9v/eb
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

There are old device trees which place the PHY nodes directly in the
MAC nodes, rather than within an MDIO container node.

The probe logic indicates that the use of NCSI and the legacy
placement of PHYs is mutually exclusive. Hence priv->use_ncsi cannot
be true, so there is no reason to set it false.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 7d6e7f2ae969..debecb21bc8e 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2004,8 +2004,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * child node. Automatically scan the MDIO bus for available
 		 * PHYs.
 		 */
-		priv->use_ncsi = false;
-
 		err = ftgmac100_mii_probe(netdev);
 		if (err) {
 			dev_err(priv->dev, "MII probe failed!\n");

-- 
2.34.1

