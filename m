Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9C37B402;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214953; cv=none; b=uGSEmHGmj4fIU/NGc/VBmld4mn8DwNGRB/aIFcksA5sv8hGq5LNIDYrrSjcLK7z+JHa4ASr6+lJyN/csBgty3UO8N9U9hR9oZUhXGfjX9+VqOab8iO9PqpmSX6SYpeg+I/yeVYvHFsQyaHapdQGk4AJ2JJOx3ZmY3l0kE8IOQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214953; c=relaxed/simple;
	bh=Pacrb1hpDheZGvPj5b6lI5qmEiVD7X2w+vLnvcN2HfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awWg6kW28z/5nER8ND2wFRvf6seJxQQdwrmmGJgBLyofK5ao7jhsApc83czXV4zFXwvs+xhYkK77S5UsQIcd85tl1YTHlmE2quuREzb0udDX/DhiDUncXb+mBYMl1lvKgehIEb5xunf6yN25RAj7Il7SrmNmVDOIve9qxmy4wLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdILK1R9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdILK1R9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165DDC4AF10;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781214953;
	bh=Pacrb1hpDheZGvPj5b6lI5qmEiVD7X2w+vLnvcN2HfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GdILK1R9hVKxL4Wds1s071usBrLyabBWvFR3w/ptHrdV3gMv007OmWy8JWob9IQ5h
	 lztevHeu4xvdYmOeuQbX9hikTxpRXWX4AqhVsv/T375I9Ljzbc5Hk0fmzWuhh4ene6
	 q+Mj3uRc+yFpR+DkL7zpUBW9uH7+Q56oWqSod0VabJK+ZUdJn7k1Oyvfj/x7d0Nbbw
	 YuWz5MA0J1H9iFw0WDfwo89BgfADg98RrNaWClM+cIi8KChZ/RtYetW7bmRA6XP/a1
	 fdmNUO2oXApz18CZjDcfbdXfRDalgX+FjRKLoX8468vTjLSho4mNEibKarYGNcE7OJ
	 jdxTdkd+4bnbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE01CD98C7;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Thu, 11 Jun 2026 14:55:39 -0700
Subject: [PATCH net v5 2/4] net: ethernet: oa_tc6: mdiobus->parent
 initialized with NULL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-level-trigger-v5-2-4533a9e85ce2@onsemi.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
In-Reply-To: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781214947; l=1364;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=t+dmUxmhz+NSvTxVN33pXrsCLCkCj0A5Bx5yqncn/ig=;
 b=SkapaNnxGJcsM1J0VF4hAwiBSRzQVsHp2MRugT+VyfsnajInTDc6CHmD91efGhifz9rwphcyU
 OqMNQogUT66BNFLmw8wD9e4B5NjEBaK2lLeP+tQYDBPaEKoo81bJrON
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

As "dev" pointer in oa_tc6 structure is never initialized,
mbiobus->parent was initialized with NULL.  This change
fixes it by initializing it with device pointer of spi.

Fixes: 8f9bf857e43b ("net: ethernet: oa_tc6: implement internal PHY initialization")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5:
  Changed Fixes: commit ID to accurately reflect where issue originated
changes in v4:
   new patch
---
 drivers/net/ethernet/oa_tc6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f3ac2875adfb..477ceefde2c5 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -110,7 +110,6 @@
 
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
-	struct device *dev;
 	struct net_device *netdev;
 	struct phy_device *phydev;
 	struct mii_bus *mdiobus;
@@ -520,7 +519,7 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 	tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
 	tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
 	tc6->mdiobus->name = "oa-tc6-mdiobus";
-	tc6->mdiobus->parent = tc6->dev;
+	tc6->mdiobus->parent = &tc6->spi->dev;
 
 	snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
 		 dev_name(&tc6->spi->dev));

-- 
2.43.0


