Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C349E12D;
	Thu, 15 Oct 2026 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046838; cv=none; b=EJf008Zub0+PUgvAfsHni+HpGyJKRhdeX9MaGafu6dSHw+NNxPw9Hrx1mZhZzDPO6EhbjUjlJZWa+pLf0OS+vzvON3NsdEj0UgIosA6Q70dbq3qOmd9SgSj0b+EBr7ImM00fE2joadhBlh9EiZjCgKKs+yLZQAJAJ9MdpiuD4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046838; c=relaxed/simple;
	bh=dd7P4+PugK5mwhjG3d4AZp5OatRG7Q7MldqYgWjbbbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KstJ8i9BnHoPpu7zA7tYEkxdvovd/fDsphZnRpovTuXXJrjCiB4v+YDqF++QI/J0NLxYhu2aG1lPiAKitJi66XxMmn/an9cMc2FZDkC1RCOLngeiSnjyUBlRQzNuoa2PznTHKOAj2xjbSv6/Iv2z6G+w2hshGDGeZLvmB2fVxCw=
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
Date: Thu, 15 Oct 2026 14:46:56 +0800
Subject: [PATCH net-next v3 4/6] net: ftgmac100: Require phy-mode for
 AST2700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-support_ast2700-v3-4-8d7999171ac4@aspeedtech.com>
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
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792046819; l=1298;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=dd7P4+PugK5mwhjG3d4AZp5OatRG7Q7MldqYgWjbbbc=;
 b=XKq5ygEeqOQaLPorZyv/GLUMR2DgHzrtnStbAU3oezEGckT3wmbYBQ5EAAujVvb2+hvEQBpvT
 w0CZQ3OgaUDBa2vft8p9x9HmfUDagpsjuFUR5ZcnVcdnAbG8zUauxdJ
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The driver currently defaults to RGMII when the "phy-mode" property
is missing from the device tree. This default is no longer valid for
AST2700, which also supports RMII via FTGMAC100_QUIRK_RMII_ENABLE.

Make "phy-mode" a required property for AST2700 and fail probe with
an error message if it is not specified, instead of silently
defaulting to RGMII.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 9b7becb01726..5a578a62df67 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1526,8 +1526,13 @@ static int ftgmac100_mii_probe(struct net_device *netdev)
 
 	/* Default to RGMII. It's a gigabit part after all */
 	err = of_get_phy_mode(np, &phy_intf);
-	if (err)
+	if (err) {
+		if (priv->mac_id == FTGMAC100_AST2700) {
+			dev_err(priv->dev, "phy-mode is required for this SoC\n");
+			return -EINVAL;
+		}
 		phy_intf = PHY_INTERFACE_MODE_RGMII;
+	}
 
 	/* Aspeed only supports these. I don't know about other IP
 	 * block vendors so I'm going to just let them through for

-- 
2.34.1

