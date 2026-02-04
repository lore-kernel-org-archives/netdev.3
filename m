Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641F3644D2;
	Wed,  4 Feb 2026 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182810; cv=none; b=s/qjW6aCGVovzZDJ/81yOFEfF+wp4K3dUSwZ2hh3gdsnkvFmr6Ao8jEfWOcGp4tv8FJdlVxm4teA5Rfnqs7IcNaTKlZk4n2UbGeLWlUEn9uRBTPkmGxz/YfAz4rV3SJsRc59k6VPtMc29vv90y76FkonB4kK3ltlFJjtlqCLZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182810; c=relaxed/simple;
	bh=471njwjL7QH16iQLFFNaaEQsRgbpFzhSLY3wfbfJexE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tQD/w2nMx5s9Plwkd+dujnYQ0XI255jFjspb6JvmbssAnQiW0ZMCgWqigpg+FA9qmogDkAYqGg9R7zH0hGsy9KHaqfOrUzhu9WpBAbjltGjuSk2cvTac++rvaGqFGgeoHO9pRrigAHwMjGrx0BAnmgpsf70mKVq/D99wvZCyeVE=
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
Date: Wed, 4 Feb 2026 13:26:38 +0800
Subject: [PATCH net-next v4 12/15] net: ftgmac100: Remove redundant
 PHY_POLL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-12-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=1321;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=5+muffs8Bl237UUbs270t5MmAvqGM6B99cKxqCf504c=;
 b=vP5i/GFYdElRqDSNnq/lxUFc344/M7iP3rYVrDMRraontraRcfJTsiLcJvmDHRKA/baOmDINa
 gEObmlQTFpsBuU0cC3+8GZrnpLlCKn/GlHvUv1Xpwm1Ov4BZ2dvN3mQ
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

When an MDIO bus is allocated, the irqs for each PHY are set to
polling. Remove the redundant code in the MAC driver which does the
same.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1c02660b8f96..d4d686066f2c 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1712,7 +1712,7 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	struct platform_device *pdev = to_platform_device(priv->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *mdio_np;
-	int i, err = 0;
+	int err = 0;
 	u32 reg;
 
 	/* initialize mdio bus */
@@ -1740,9 +1740,6 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	priv->mii_bus->read = ftgmac100_mdiobus_read;
 	priv->mii_bus->write = ftgmac100_mdiobus_write;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		priv->mii_bus->irq[i] = PHY_POLL;
-
 	mdio_np = of_get_child_by_name(np, "mdio");
 
 	err = of_mdiobus_register(priv->mii_bus, mdio_np);

-- 
2.34.1

