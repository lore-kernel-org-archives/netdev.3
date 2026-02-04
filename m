Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C88376BF0;
	Wed,  4 Feb 2026 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182803; cv=none; b=fkOuZLSIjFF1VRHxD/xt9HgCLChXe2vt7RZHIUztJ9qjubFDmghsuOsaJLLWINR2aSpNEwAnga1t8Jo5lslhQnzF5uAwpGf5bSq2ImwTvrwuNv+5xzXxuV/DCsczRUkvtc/sUqI6sST9I545+DjDK+ZyyG81gt4E2kqBepjEWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182803; c=relaxed/simple;
	bh=OmD5Arfn3RrbJ25M0ctPE3l/LqvXsbLTQxMzqMnbtzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EHXMzpF7heemQaCFwdnFuh7xNz8rDqhjDtccFVoqMVgwU9QXQ6f6D4kEe2E9Q0wU2qVgAW6su7LSyqA0+B0G6mtxvYys1oOPzbigI/DFaUB53TmuR63cy2s5ZUOAaLBbp+yx5kWrlbmoFOwNyoPbQvqClTbpT5EDWv52NnTaFJE=
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
Date: Wed, 4 Feb 2026 13:26:33 +0800
Subject: [PATCH net-next v4 07/15] net: ftgmac100: Simplify error handling
 for ftgmac100_initial_mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260204-ftgmac-cleanup-v4-7-b7f379939b76@aspeedtech.com>
References: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
In-Reply-To: <20260204-ftgmac-cleanup-v4-0-b7f379939b76@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770182790; l=1005;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=v09SrIG5pIMosiqozTDRpfXyvuVR8w7kAu8PLHCKIaA=;
 b=3mrG0gnqLqR8hDPE1y3SsmJLru/R5iT9xfinIlT12Rta5iEoHziD/sUNlxjZqiifWc1rcXFTH
 aRhrALXpsgDDnoCGHGYQLsrvvx8EMzUHun0l8CmZOpXBUinhCwvQfUg
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

ftgmac100_initial_mac() does not allocate any resources. All resources
by the probe function up until this call point use devm_ methods. So
just return the error code rather than use a goto.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1fb03dd55c8f..e511d6d5f7c2 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1914,7 +1914,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	/* MAC address from chip or random one */
 	err = ftgmac100_initial_mac(priv);
 	if (err)
-		goto err_phy_connect;
+		return err;
 
 	if (priv->mac_id == FTGMAC100_AST2400 ||
 	    priv->mac_id == FTGMAC100_AST2500 ||

-- 
2.34.1

