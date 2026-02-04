Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3835CBD3;
	Wed,  4 Feb 2026 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182812; cv=none; b=Mv31P1894RsKHdS1MSVcg15gLhuVYtRGFcbzcX0je9H0z3AnDmABxuyL3zoP1pny5NJwisS+8PweWn8cl2unpUJija74Hz8XlhKG76u4tFWScqOpfuA3fqllLad/+9vZLHcsnWZ2ydibWcWIn0wmea1osqFs+E0+Er3DvlRPxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182812; c=relaxed/simple;
	bh=Yd6vQEPj4/+WhzY3jDwMf+4P39ERawGAPA74SPseMMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LZipvnBYNchb8zmzLZqBw6yZBgzrPBAtg99G4vXMHKkGZlhuqkbxT3EI28Qmvn/En217RzC2oneurtaEU55ucaKp4cV9iE+T9N28f7e9POF7kOXdapwQjNsqi0PJuc50Re6J6YuT9DbjxrbxJisvpTO3Fbnvpa7uerA9snahymI=
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
Date: Wed, 4 Feb 2026 13:26:39 +0800
Subject: [PATCH net-next v4 13/15] net: ftgmac100: Simplify condition on HW
 arbitration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-13-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=1250;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=o651DaCpvZD+qCiXtLl6WBoDBGKdbexvwRsh4kVsKfY=;
 b=WVJlds0BrZaF7epP+am4/Br9PcpRkvYCNEiVENI6Z4P22e5pVTRIOuANAizAtP+lVTBSw4uED
 Dmk4rDHxrZ7Bc3gIvyVjUQ3CnMBfwvzMtvks4QO/ovGDTQtx/xQzLxx
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

The MAC ID is sufficient to indicate this is a ast2600.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index d4d686066f2c..652a20a7bfe3 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2040,13 +2040,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		err = ftgmac100_setup_clk(priv);
 		if (err)
 			goto err;
-
-		/* Disable ast2600 problematic HW arbitration */
-		if (priv->mac_id == FTGMAC100_AST2600)
-			iowrite32(FTGMAC100_TM_DEFAULT,
-				  priv->base + FTGMAC100_OFFSET_TM);
 	}
 
+	/* Disable ast2600 problematic HW arbitration */
+	if (priv->mac_id == FTGMAC100_AST2600)
+		iowrite32(FTGMAC100_TM_DEFAULT,
+			  priv->base + FTGMAC100_OFFSET_TM);
+
 	/* Default ring sizes */
 	priv->rx_q_entries = priv->new_rx_q_entries = DEF_RX_QUEUE_ENTRIES;
 	priv->tx_q_entries = priv->new_tx_q_entries = DEF_TX_QUEUE_ENTRIES;

-- 
2.34.1

