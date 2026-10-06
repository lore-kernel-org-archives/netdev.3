Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110D3A9616;
	Tue,  6 Oct 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791271264; cv=none; b=gMPfg19VUIVGpbL2llQcX+xEzD0aPRInBCInYnjzikYen5j9go0XZ5vcvC9j9GD6lToSZH6pJ0XQvRU9jQYd8eagk1jjq1PmGZOBhN70xKEHjCPzl2UVnVx0Wpm14vn068vFKh3nOErF2vu6FA3pOa2M5dxrXA5FRMJYTXcUmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791271264; c=relaxed/simple;
	bh=z17pcl+lVslofCSy7YMUKS5YRB1KlIamz4u33OVryDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k3upoeaNIGKQZ3MvEh+PETKFvtR3NARaysPMYEtbe79I5Yvs+OG9sN7LXL3dx/kkY4MnCrRpjjWHjFBKMFsW6+y7RZPJ18c1ZRkBpiuLXbMZj7rzWPr5tEy7u74LRuSz2srUhxEV6R/c/ylV8QXrjesEN7E/10AQ7DNSlPoOo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 6 Oct
 2026 15:20:44 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Oct 2026 15:20:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 6 Oct 2026 15:20:42 +0800
Subject: [PATCH net-next v2 4/6] net: ftgmac100: Require phy-mode for
 AST2700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-support_ast2700-v2-4-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
In-Reply-To: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791271243; l=1298;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=z17pcl+lVslofCSy7YMUKS5YRB1KlIamz4u33OVryDE=;
 b=xwnuy/WkTaBCfKBdXxMF/5/iu8bSbrg+MLy10cctEhdPBatgLdI/RFNGfAkpVGErLvOPVAdWn
 79aofZP9n3zBSGwGN86ps/kRRhW8QbHvmO9tyaSHj+LWOL8GZ2W3SFp
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
index b835472da360..2d029d1262e6 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1521,8 +1521,13 @@ static int ftgmac100_mii_probe(struct net_device *netdev)
 
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

