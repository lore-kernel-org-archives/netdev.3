Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E01324B20;
	Fri, 28 Aug 2026 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889170; cv=none; b=aUP5+ISbTih/Q4XRYMigXoV+I0XFY3wx8+tx4uABJBvlmW6x2/FEMhvc2A1JCeVtfkN8zX+AFrniHWrCqIT1G9KnzmbQBQV0ebWBW5Rkem7RwR/qg6wKNl1B/fzAi7PbMrRezR/s8xpMhFpHWkPFc8SDTZSUJlIfQZvcYDmXCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889170; c=relaxed/simple;
	bh=PKCarzxa7XiNXnPxFgr/x2dkK2Ej87CGw/W+tSRnDIA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jehKWu6kVFlzTsLkQewlEpSmjUNfEw10nxFl6JOH8pc5Cl2uRItjrfTTeoAo+GkbGCTYm+01iiz9VMGbeiooc7K1beH3cACVyZ+ZOp187ZIi/z9f9kJrmIw137G4OIgSmAgULkaTgg/41mBYA2uUTD+PNtvi5dg713m1f0Jthmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MIFHxnuV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MIFHxnuV"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S223ph440082;
	Thu, 27 Aug 2026 20:52:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ngwmB6xJLwD9o53tmuOr+Xg
	eZX6geOISFL12sbDv1/w=; b=MIFHxnuVDznF3ODTxcAVS3IPwK4B0G3e2JHMeqN
	LeHpJU9tL6DyBcCPO8ZM+vonDIOsYDkJpG5a4MsbMShqx3gF/mBPH1TPtB5AwTOJ
	3M5SNidNKmKpyKQ1QGMaeRYaPeLjxu6CJDv0sD6O5yDi/oGvMWNIH/1+WFdZ4I+9
	Mz1esvQs8RckQCq/HFVpI38kgSPnHmryl5ZhIq0vw9z2YB0ciKnaFXSFP9F+DkN4
	o9/T3lp5Y6KN1DS0EWJc66fyZ0HFqhdDgYUB2MH6WPcRLUNxU/tl3ivj3vgL7/z5
	ttXZ6gbevFpX5bad7R/urAKXfJBLftgBkA3EBIdVffDi1ug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gan4w3apg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 20:52:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 27 Aug 2026 20:52:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 27 Aug 2026 20:52:37 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 941783F7084;
	Thu, 27 Aug 2026 20:52:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v3 net] octeontx2-pf: reset HTB scheduler topology before freeing queues
Date: Fri, 28 Aug 2026 09:22:31 +0530
Message-ID: <20260828035231.46911-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pLHqxDNCo4lYDlo64WKvEgdTnzed5nYh
X-Proofpoint-GUID: pLHqxDNCo4lYDlo64WKvEgdTnzed5nYh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDAzMCBTYWx0ZWRfX1b1wJIDCzBJO
 P4sObI7cYuTIkJw5VuYTVzsNrUoGX8+KofyeJuBEQNPBhYedoqzQNlawe2vkckkKN3gJckBBFEI
 Z5anK1ZlVs+wOqO4iXZ8jT4ML+ePfnU=
X-Authority-Analysis: v=2.4 cv=AsneGu9P c=1 sm=1 tr=0 ts=6a910606 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=feDtNzwfOZ3BIhz8oLkA:9 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDAzMCBTYWx0ZWRfX+sJ9+LBd0ZR4
 4rjDQ2uQzwFoVmC6OqZPKVyqgxkYKQGb9H0R2vtrKW9hb/9tStYzCaRxIctLm/7ETMwP5x8BqFk
 DAgzY3rcFrhnoBL9Tl5cXqRkJCqn7I7aiDshSl+iFpWO4CH+SDrYRRg4ZR7OF93+40h6/oSW+cQ
 FrXZHoqGzKA0+QWfi0ia2cbr7ojVecmwd+ifO2Su6ykfYcd4N94vAL3orIsbj5Di5AOCGpb8MO4
 ltuBU6CUY07bEjL+F9Sj/dzghBY8uCuRsayfZWra6C5DBo2jYwTVJ9ePiW/FWTr2zoWpdi5Te2s
 U6PzjQAum73H4A3fGXqCNpo411rmKmwHIGG0TtrTW0AzzsdNAP43Qjpxn+ZRPIDLKFBcQqxEYFK
 Y2SOB3mOXMyVqcsm4Wo7BXrJs8gxwUEduOaO2KV0oi9g8J5XkhuLCJJnnbUV7gVKVfuSIOM9JD7
 2OdFFDbAl1G/z7H8zmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01

HTB offload programs NIX_AF_TLxX_TOPOLOGY on QoS-allocated scheduler
queues via otx2_qos_txschq_set_parent_topology(), but teardown freed
those queues without clearing TOPOLOGY.  The AF only restores PARENT and
SCHEDULE on free, so PRIO_ANCHOR/RR_PRIO settings can survive in the
shared scheduler pool and affect later allocations.

Add otx2_qos_reset_schq_topology() and otx2_qos_free_hw_schq() to zero
TL4 through TL2 TOPOLOGY before each schq is returned to the AF during
hierarchy teardown and cfg rollback.  Skip the aggregation level (TL1):
it is a per-tx-link queue shared by the PF, default Tx hierarchy and VFs,
and is not freed back to the AF by nix_txschq_free_one().

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v2 -> v3: Addressed AI review comments.
	https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824072147.3524339-1-rkannoth@marvell.com?part=1
v1 -> v2: Addressed sashiko comments
        https://sashiko.dev/#/patchset/20260821072812.2890922-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..ab9661334e6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -235,6 +235,58 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
 	return rc;
 }
 
+static int otx2_qos_reset_schq_topology(struct otx2_nic *pfvf, u16 lvl,
+					u16 schq)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *cfg;
+	int rc;
+
+	if (lvl < NIX_TXSCH_LVL_TL4 || lvl >= NIX_TXSCH_LVL_TL1)
+		return 0;
+
+	mutex_lock(&mbox->lock);
+
+	cfg = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+	if (!cfg) {
+		mutex_unlock(&mbox->lock);
+		return -ENOMEM;
+	}
+
+	cfg->lvl = lvl;
+	cfg->num_regs = 1;
+
+	if (lvl == NIX_TXSCH_LVL_TL4)
+		cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(schq);
+	else if (lvl == NIX_TXSCH_LVL_TL3)
+		cfg->reg[0] = NIX_AF_TL3X_TOPOLOGY(schq);
+	else if (lvl == NIX_TXSCH_LVL_TL2)
+		cfg->reg[0] = NIX_AF_TL2X_TOPOLOGY(schq);
+	else
+		cfg->reg[0] = NIX_AF_TL1X_TOPOLOGY(schq);
+
+	cfg->regval[0] = 0;
+
+	rc = otx2_sync_mbox_msg(mbox);
+
+	mutex_unlock(&mbox->lock);
+
+	return rc;
+}
+
+static void otx2_qos_free_hw_schq(struct otx2_nic *pfvf, u16 lvl, u16 schq)
+{
+	int err;
+
+	err = otx2_qos_reset_schq_topology(pfvf, lvl, schq);
+	if (err)
+		netdev_warn(pfvf->netdev,
+			    "QoS: failed to reset topology for schq %u at level %u: %d\n",
+			    schq, lvl, err);
+
+	otx2_txschq_free_one(pfvf, lvl, schq);
+}
+
 static void otx2_qos_free_hw_node_schq(struct otx2_nic *pfvf,
 				       struct otx2_qos_node *parent)
 {
@@ -252,7 +304,7 @@ static void otx2_qos_free_hw_node(struct otx2_nic *pfvf,
 	list_for_each_entry_safe(node, tmp, &parent->child_list, list) {
 		otx2_qos_free_hw_node(pfvf, node);
 		otx2_qos_free_hw_node_schq(pfvf, node);
-		otx2_txschq_free_one(pfvf, node->level, node->schq);
+		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
 	}
 }
 
@@ -266,7 +318,7 @@ static void otx2_qos_free_hw_cfg(struct otx2_nic *pfvf,
 	otx2_qos_free_hw_node_schq(pfvf, node);
 
 	/* free node hw mappings */
-	otx2_txschq_free_one(pfvf, node->level, node->schq);
+	otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
 
 	mutex_unlock(&pfvf->qos.qos_lock);
 }
@@ -913,7 +965,7 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
 		for (idx = 0; idx < cfg->schq[lvl]; idx++) {
 			schq = cfg->schq_list[lvl][idx];
-			otx2_txschq_free_one(pfvf, lvl, schq);
+			otx2_qos_free_hw_schq(pfvf, lvl, schq);
 		}
 	}
 
@@ -921,7 +973,7 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
 		for (idx = 0; idx < cfg->schq_contig[lvl]; idx++) {
 			if (cfg->schq_index_used[lvl][idx]) {
 				schq = cfg->schq_contig_list[lvl][idx];
-				otx2_txschq_free_one(pfvf, lvl, schq);
+				otx2_qos_free_hw_schq(pfvf, lvl, schq);
 			}
 		}
 	}
-- 
2.43.0

