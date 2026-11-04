Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769258;
	b=vZV0z/JyVOdsLck0gTr9Yuo9c6yE/0JnwOOBEBs4VcZ2o/XKoPipzocLJ3IeooqvdFuD
	 Lr4zCySmUMI6SmXHDPOj68r89SzgJGaWuHjq9vf7n+GfhQcduqzSRlSc9aYXMJwHp0fsb
	 Lc+C6hIT3rD9AAW5HdHoxV/Xdw1cslauZeZgeGZk1wwwuZJcpg3r+DehZpEGqlgtDtH9w
	 +HW7OKNqn5/3JHse5sb5Mao9RojjLjChx3IakcoR8PxnjQW8Jvvx3MnUuBapcP2Kjn2Vw
	 tJXQAcvSZuDlVEo390ruOdcLSWUuLgNeab28D+xFVdRc6+xbblIacI1x4HbYYPaJEiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769258;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YgiL9PYeUdMsQQJdZ2R1QPV9MD8KIpSSIKhcXP8qDRU=;
	b=bEBzmE649ib0IgzG4xOl1tvv/fl0WDsvXI5fFP+WExsd89SWUFW+pQzAe3wYGZgxGdB6
	 FjtLDE+nFL4vDvR+/cKRtfx+5Kz8dRY4X2OfPhNscXleV6YEZb8GrOLbhr0OUzVfBJ6tZ
	 SHNLh0gOUeY0qSLdIug2zBen/jTor+xdeF6UbMlc4TgGu3zs+/TBTMKlItAlVE5z5KHu3
	 HZpACmVuGEfOuhN0mIJTAtLN1gsQUxis81Jm+gSC4IEHcydWHoOAeKyZZXAYgggEYtCOv
	 IJrqWWkObWv5qg3QnpaoaXqVHeKNXzDlPa7bhBUT6vOIKpvinNYP9TqN2ZCfq5yU6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199B606A337;
	Wed,  4 Nov 2026 05:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6199B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 13:14:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 13:14:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Nov 2026 13:13:58 +0800
Subject: [PATCH net-next v5 5/7] net: ftgmac100: Require phy-mode for
 AST2700
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
Message-ID: <20261104-support_ast2700-v5-5-44057f4dde75@aspeedtech.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
In-Reply-To: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793769249; l=1341;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=1RAjtRaBnlESdbdb4uGZ6kTcr6R3XDz0Y1IoL5YzWHQ=;
 b=a52udDbe2XS3MhWCPdi8xP4QWZ7GjtV50FqSLlfQuISTlW1FZ8oRPuR7bgQCmWQIskjJvC7Kf
 jrF7eSnjpGiAtvxKM4zJboKJoOqcqWwF3YEHeoP0wkF7u+d6BmYQv1e
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The driver currently defaults to RGMII when the "phy-mode" property
is missing from the device tree. This default is no longer valid for
AST2700, which also supports RMII via FTGMAC100_QUIRK_RMII_ENABLE.

Make "phy-mode" a required property for AST2700 and fail probe with
an error message if it is not specified, instead of silently
defaulting to RGMII.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

