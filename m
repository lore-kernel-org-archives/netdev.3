Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1355374194;
	Wed,  4 Feb 2026 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182813; cv=none; b=eRCU2CCZTuQybL8S+VLuUDGNyjYGNjp0nxs+m8wH7ygWUO2g/fUONGwER2Kaxg/GNHbEMlR5Wc39V9QsGCzd4C9M/FEAoo2cadAPCP1JHVoUQLGzJJDW0rf298C7DTN7PEj3ZngQS7gAFMgpJt1MoCZODFUqt/R8lLtIo7ImaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182813; c=relaxed/simple;
	bh=VjnFZx7IhhL9ZymjAB4MNit+/oQv65Dw7l/sS5fa1r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BywjX7wD+xzfKJFAUTu8ao8Oie0fHlfbFBvBnQIsJ3IJRtCBcZ8TUGxonVeCFNczUC3JM0TFYZU3e4YRrnscaK+qjnO5UtkVzEnGgZ7Eh7a0hIoP3OT/j0Ts4JnpOmYJwgFwP1Mi7ePmKP3pvTucJaejJ52elQO98UtESyxL0CA=
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
Date: Wed, 4 Feb 2026 13:26:40 +0800
Subject: [PATCH net-next v4 14/15] net: ftgmac100: Fix wrong netif_napi_del
 in release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-14-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=910;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=WMJxdeGDLfXSqtw+jtmI+hZXKEcfdsYZEq1/J6zdoRU=;
 b=KJA8cuDqmvZEcTLtkkBMLAmGneFGHerfb8CdcTAJ/D4PS5lqq+2QDQy4aN7xCgwpkH386NAgc
 ZSpeA68jxrBBvOjcQ2ZGJYsxr4OjC6QRI+DeY5+dL27dYnVW1i8Inp1
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

netif_napi_add() is called in open. There is a symmetric call to
netif_napi_del() in stop. Remove to wrong call to netif_napi_del() in
release.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 652a20a7bfe3..d5cdd6ac65eb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2109,8 +2109,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 
 	ftgmac100_phy_disconnect(netdev);
 	ftgmac100_destroy_mdio(netdev);
-
-	netif_napi_del(&priv->napi);
 }
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {

-- 
2.34.1

