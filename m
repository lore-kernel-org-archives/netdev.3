Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F432FA14;
	Fri, 16 Oct 2026 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123924; cv=none; b=KIegxrJZuhyecMOWyMWOuOT9f3nreKlGkljUMIJ236+7PzzIijDqKIbWQ4VkVI0h3E5rzBeC2XHfLyhNEcKnBwizalUfCRXr84rgF4+6jlF0cLOTcR7HiW0JYNVKwIcExGVW5yR30q0mxKXiUCgwtKeL7uE6LcDuaUZk9g9wpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123924; c=relaxed/simple;
	bh=OgXG9xn1VhbmpD3sZFlDS/6VC7TmwnmO1E4t0G6slRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj5O6fD56soEo9kzbdcRvf5F6pJMpHHHXhp3ac1HfkXzrc3JPC9L9gF/LNbNt+f7JP6RbKdfIt/nlGuqKyR7bwb14aY2+nq/yBB9NkQAz54x7kjxF8b/h85msoIF7zTPti0n1vAMgczpxaz0YVZggqyBxGgbFLlTU5bWNOPmtIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=PfEItNdY; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="PfEItNdY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792123919; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=71feyORWQkSmwxAOuaP3w0/Ra72Lm1sSFQyUP6Bwp6s=;
	b=PfEItNdYyMA/UFms2WricaqyOUDo64Fp5ZOmjBaaV9TQ6+V9A7apEDIoKRwxMw0v4YccGJW326lPfKvYYYgGO0UtwhxE8rff4wKioF20EeiJ+ppX1XO5wXdkVsZEKyDnC+vOaGPuVzdN2yyEwr+4JEgTsUjMX2PHPHuFhJ4lH2M=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07457611|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0140128-0.00412352-0.981864;FP=13147590598409216308|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jfq-NSj_1792123916;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jfq-NSj_1792123916 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 16 Oct 2026 12:11:57 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: fix tx buffer release loop on invalid skb
Date: Fri, 16 Oct 2026 12:11:56 +0800
Message-ID: <20261016041156.2295670-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t7xx_dpmaif_release_tx_buffer() iterates release_cnt times over the
TX ring, advancing cur_idx and updating txq->drb_release_rd_idx on
each iteration. When a PD DRB has no associated skb, the loop hits
the "invalid skb" error path and does a bare continue, skipping the
ring index advance and the budget notification.

The loop counter i still increments, so the function returns a
release count that does not match the number of DRBs actually
consumed from the ring. The caller t7xx_dpmaif_tx_release() then
compares real_rel_cnt against rel_cnt and may keep returning
-EAGAIN, causing the TX reclaim path to spin without making forward
progress on the stuck entry.

Advance the ring index and update drb_release_rd_idx before
continuing, so every iteration consumes exactly one DRB and the
returned count stays consistent with the ring state.

Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 8dab025a0..a51bad54d 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -103,16 +103,15 @@ static unsigned int t7xx_dpmaif_release_tx_buffer(struct dpmaif_ctrl *dpmaif_ctr
 				dma_unmap_single(dpmaif_ctrl->dev, cur_drb_skb->bus_addr,
 						 cur_drb_skb->data_len, DMA_TO_DEVICE);
 
-			if (!FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header))) {
-				if (!cur_drb_skb->skb) {
-					dev_err(dpmaif_ctrl->dev,
-						"txq%u: DRB check fail, invalid skb\n", q_num);
-					continue;
+				if (!FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header))) {
+					if (!cur_drb_skb->skb) {
+						dev_err(dpmaif_ctrl->dev,
+							"txq%u: DRB check fail, invalid skb\n", q_num);
+					} else {
+						dev_kfree_skb_any(cur_drb_skb->skb);
+					}
 				}
 
-				dev_kfree_skb_any(cur_drb_skb->skb);
-			}
-
 			cur_drb_skb->skb = NULL;
 		}
 
-- 
2.50.1

