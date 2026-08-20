Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8913D886
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189039; cv=none; b=J3MjAD3bZ3BLJmp7YsWRrlTiOeNWgJGtWiTlgQYR6ZLQr+HyztMkeqsgD6b0kCzWuZ8Z7UHxXDkpNIYp1hVkyZ/mWN9k9Wsu4Wdtlyc41joQvaKAlGTvxyYkisQbFkPVyYo0Xg/XjSYzCaxymZsAifQ+IruPf7iteN/eSzWTDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189039; c=relaxed/simple;
	bh=rGdHdaufUQbl/XHAGbOn03/PuPGRUsVA6K9FwIyNosQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQQI7WkxUdvZc5gMHU6bSgQYxRJdL7qEQ+4dy/nrIKbrG+TPybzdSInkT75LGsxuKTxMPmZ57ljDek7Hf9TwFhN3MwkNrgdBDeXbgG0uhGtuIdH1HTh1pfIbfDhpHcsOqlc0rVXs9rvVF2nKD+RBuXuIdjBetuP2C9mer4wft8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc9656409c3511f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:729eeacc-7267-4a90-b859-aede4c23b542,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3c4bcd297c66daf3279dcf58207c7cfb,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc9656409c3511f19a56ed5b684f684d-20260820
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 91295608; Thu, 20 Aug 2026 09:23:50 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH net-next v2] net: stmmac: platform: use scoped child loops in stmmac_mtl_setup()
Date: Thu, 20 Aug 2026 09:23:39 +0800
Message-Id: <20260820012339.3231289-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819073258.467604-1-gonglinkai@kylinos.cn>
References: <20260819073258.467604-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_child_of_node() takes a reference on the current child. Breaking
out of the RX loop leaks that node because the TX loop then overwrites
q_node. The TX loop has the same break, and only happens to be safe
because of_node_put(q_node) at the out label drops the last TX child.

Use for_each_child_of_node_scoped() for both loops so the child is put
on every exit, including break, and drop the out-label put of q_node.

Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
v2:
- Use for_each_child_of_node_scoped() for RX and TX (Andrew Lunn)
- Target net-next

 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index dc5f951a311d..c0ffee11e0a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -130,7 +130,6 @@ static int stmmac_axi_setup(struct platform_device *pdev)
 static int stmmac_mtl_setup(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *plat)
 {
-	struct device_node *q_node;
 	struct device_node *rx_node;
 	struct device_node *tx_node;
 	u8 queue = 0;
@@ -169,7 +168,7 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
 
 	/* Processing individual RX queue config */
-	for_each_child_of_node(rx_node, q_node) {
+	for_each_child_of_node_scoped(rx_node, q_node) {
 		if (queue >= plat->rx_queues_to_use)
 			break;
 
@@ -227,7 +226,7 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 	queue = 0;
 
 	/* Processing individual TX queue config */
-	for_each_child_of_node(tx_node, q_node) {
+	for_each_child_of_node_scoped(tx_node, q_node) {
 		if (queue >= plat->tx_queues_to_use)
 			break;
 
@@ -276,7 +275,6 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 out:
 	of_node_put(rx_node);
 	of_node_put(tx_node);
-	of_node_put(q_node);
 
 	return ret;
 }
-- 
2.25.1
