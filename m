Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA93DDAF3;
	Wed, 19 Aug 2026 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124793; cv=none; b=nJ3aYn7qd5mjRSslq+EmF2L9hI0fvwKt0LSxepTAeO7o04SSfwAiktXrXt0Z0ZoX7poVvTNaR8wXrOk964gEqkA8T2rrs0LmWL1RwZpe5Kyp1Dr80VO5h9sHR2OypjE4IWHXiP/yyMcqnSNEcXT484HqGAIhVldAvXPJydONxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124793; c=relaxed/simple;
	bh=4tABpnjmWxs4syXiy+KlqWZpIDOkjthR4d8v/qJhITA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNZrUFM+g1nFP1aS8N9A8NJCOJwZeZHb9aUa74nElE2+F15C3MuiOWPVTfcVb2mpa3XoFF1CIFTWfc3hwKkhU0MSc+HLHBe690pXUlo6hALzAeimA/BICteRwBoJuTRIObyJXeY55BGeqP26kSmLmoa+hcm1zx3rUpN0qrHBkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 378973889ba011f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0a6e9b6d-14cb-4732-99d6-28735b2b9678,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:fec5f4ffb56ea27f3049a3cd8128a57b,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:5|-
	100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 378973889ba011f19a56ed5b684f684d-20260819
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 429724535; Wed, 19 Aug 2026 15:33:05 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] net: stmmac: platform: fix of_node leak when breaking RX queue loop
Date: Wed, 19 Aug 2026 15:32:58 +0800
Message-Id: <20260819073258.467604-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_child_of_node() on the RX queues breaks once enough queues are
parsed, which leaves the current child referenced. The TX loop then
overwrites q_node, so that reference is never dropped.

of_node_put() the child before breaking. The TX loop already drops its
last reference via the of_node_put(q_node) at the out label.

Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index dc5f951a311d..66a048ecadb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -170,8 +170,11 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 
 	/* Processing individual RX queue config */
 	for_each_child_of_node(rx_node, q_node) {
-		if (queue >= plat->rx_queues_to_use)
+		if (queue >= plat->rx_queues_to_use) {
+			of_node_put(q_node);
+			q_node = NULL;
 			break;
+		}
 
 		if (of_property_read_bool(q_node, "snps,dcb-algorithm"))
 			plat->rx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
-- 
2.25.1
