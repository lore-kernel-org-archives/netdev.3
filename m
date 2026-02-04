Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A837416D;
	Wed,  4 Feb 2026 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182802; cv=none; b=sAJPbH03I2fa8IZ0uL1l5SFqH39CAK6epFFPNGb43RYw5kwFZjkCPp78mWXIwZMUWlT6J3TwDgOWD6RSyqK8NMq5YKQrgmsrzs3upl6myr7/v/TWl/fvz7TpPf2vBlQyXPj+hbCl6LP3BhAa2LrG711xW47sMvQ7yVhOg/WFZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182802; c=relaxed/simple;
	bh=XgKX0xdZa46he8amsmEI8h76ecDZ3K1z1hppQLAht+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jKtv0PBbOoyaVWGt5O3LFOSUgIWrxhlHNNHUZ+V12nf76wJPPO53K+wDKc+llO/XMkNAG9htFD98xwI9jAUzDRSCJrOiJFsPBB44G/HnKEBnKGcYvBnFVp1scfw8cpscGCvRhlP/7M6Uust4RsVbxbslVIziM6SQZdOscxVMDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Feb
 2026 13:26:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Feb 2026 13:26:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Feb 2026 13:26:32 +0800
Subject: [PATCH net-next v4 06/15] net: ftgmac100: Use devm_clk_get_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-6-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=2593;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=a77ZGVgJdbUEVv/HmsFHuKrP2+pmsIXAJ/kpHVOPu+Y=;
 b=f42Djj2MFdswJHllugqy4c0ba5oVcYJPSUsmoj3zkFuAQ/aWYtPZ9+XuWKhI6tFuUpPl+hPJl
 7709yWwAyFfAiDKRiisMRFTOE0+g3QGkq0Yq5W9ymtigXFqM7KUIX7i
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Make use of devm_ methods to request and enable clocks to simplify
cleanup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index ec2e7ec23ddf..1fb03dd55c8f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1801,13 +1801,10 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	struct clk *clk;
 	int rc;
 
-	clk = devm_clk_get(priv->dev, NULL /* MACCLK */);
+	clk = devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	priv->clk = clk;
-	rc = clk_prepare_enable(priv->clk);
-	if (rc)
-		return rc;
 
 	/* Aspeed specifies a 100MHz clock is required for up to
 	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
@@ -1816,21 +1813,17 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
 			  FTGMAC_100MHZ);
 	if (rc)
-		goto cleanup_clk;
+		return rc;
 
 	/* RCLK is for RMII, typically used for NCSI. Optional because it's not
 	 * necessary if it's the AST2400 MAC, or the MAC is configured for
 	 * RGMII, or the controller is not an ASPEED-based controller.
 	 */
-	priv->rclk = devm_clk_get_optional(priv->dev, "RCLK");
-	rc = clk_prepare_enable(priv->rclk);
-	if (!rc)
-		return 0;
+	priv->rclk = devm_clk_get_optional_enabled(priv->dev, "RCLK");
+	if (IS_ERR(priv->rclk))
+		return PTR_ERR(priv->rclk);
 
-cleanup_clk:
-	clk_disable_unprepare(priv->clk);
-
-	return rc;
+	return 0;
 }
 
 static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
@@ -2064,8 +2057,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	return 0;
 
 err_register_netdev:
-	clk_disable_unprepare(priv->rclk);
-	clk_disable_unprepare(priv->clk);
 err_phy_connect:
 	ftgmac100_phy_disconnect(netdev);
 err_ncsi_dev:
@@ -2088,9 +2079,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 		ncsi_unregister_dev(priv->ndev);
 	unregister_netdev(netdev);
 
-	clk_disable_unprepare(priv->rclk);
-	clk_disable_unprepare(priv->clk);
-
 	/* There's a small chance the reset task will have been re-queued,
 	 * during stop, make sure it's gone before we free the structure.
 	 */

-- 
2.34.1

