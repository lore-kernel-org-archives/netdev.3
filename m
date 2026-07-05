Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F898003D
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269786; cv=none; b=mCmS8rAPzZnG7HTuaRqA+c00tWO2ecgnwN1cOMMzjxxYkES/jkcxepC3P4vbXdiQHpXoqEuxlRX47apewAcJVdpGa1EPBbFY3msQMQ+RcarsCGoiLyeTtPkd8exJbLY3/l3EOmaJ5kpO042mI0bNAkCORTo/EDrhgS2RL1gnY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269786; c=relaxed/simple;
	bh=gYyKwV4JpN3uA5KQMgScFd1EP+GspcSck5WeMsOk1i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWyzQIFUBBnjI9mlRMJFLh3RwUXNLggW6QrUxmaHYBjOTClrd+X3ENieOXOcgG6mnITYLBqDtZlc3KBcm31LEs/3HK+hkes1IiHNmu0s8kVKZxMQvF2Hf0ZwWCqpwN2mnEj5921dsLKuvEaW/+RXfnvD+SW5K8IQSq/RlOqlLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J7KNMk0k; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J7KNMk0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=sAwLMaDBVqVN0C
	bUuOcwihTDdG1LMgecEQPnGoaS2RA=; b=J7KNMk0kopIsLYdvWSPv+86XzVXSDY
	ezMyPb1DHRzovqWYOKH1JF/Id8X/iLubrKFny7KwLIwcxGSXMab9jZwhJbamznU8
	ctyixjk1u78zSrogA38wHpHEiNWjavStrwBO53h8QmVLWmNRoz2FYDeB/K+0tltG
	Isbtho/7hWt4PpGTWmZz/Of91tk8QsUQ28FAiWmAbgZzle6HNyeLV/ZhAylK6T+K
	C+IZqes3aIzFkAMzVrHAniyKqOMlI7CGdXiwexdLsQ1peE1ioJdNoM1/MM3a/CKU
	rCJk3eSbLs0fPDbAlpD810cEQRA503+iPX1/uWdAkOmtd8/lM3hHyrVQ==
Received: (qmail 2289212 invoked from network); 5 Jul 2026 18:43:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Jul 2026 18:43:02 +0200
X-UD-Smtp-Session: l3s3148p1@sxjn2d9VhW1tKjFj
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: qualcomm: remove unneeded 'fast_io' parameter in regmap_config
Date: Sun,  5 Jul 2026 18:41:59 +0200
Message-ID: <20260705164208.2184-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/net/ethernet/qualcomm/ppe/ppe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index be747510d947..3c301e609d3e 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -106,7 +106,6 @@ static const struct regmap_config regmap_config_ipq9574 = {
 	.rd_table = &ppe_reg_table,
 	.wr_table = &ppe_reg_table,
 	.max_register = 0xbef800,
-	.fast_io = true,
 };
 
 static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
-- 
2.51.0

