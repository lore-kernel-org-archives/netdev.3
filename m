Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB125A642;
	Mon, 24 Aug 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556140; cv=none; b=PROY95PgrKH5TM5tRVM9PngaVZ2oCxOMPh3AZnkxjAQW8yUxAbmtdxKqrkFGZxFh0XOFWiRptHR1osjrAg5U/Jf8YVjOBmM7XVTjtlqDo1ljb9iT9rNWHRhBE8m6+wxhyarHJkn9gogcjlmVmM7Clru17GCnDwvphIv6OUw2G7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556140; c=relaxed/simple;
	bh=A5iivlwhDTIgazqaRga4/q+jiHpQX/slYfvX2bEXcQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aS1udir7CGivh1H8br4ClGabCcGGkO0xd9IxSZugvb3WlW6Aa4kx0ZhSCYRYeU8yNXpNNWmlC0ssN1nbcaeZZaXX1xBtzTRv5j7YRxteCu5j2o4jCjKpWJ0LUwITCOeB+nKEclkLxClmmCJYR2u/pbwk9tpEtOhGb4W1BdOcA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e54z4C+P; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e54z4C+P"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5Ug253170620;
	Mon, 24 Aug 2026 00:22:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=rjFWIwAGPHYSrNb1UI9AKcz
	ctPXxKsk3uOADORVsUgs=; b=e54z4C+PJF+HJFXbGUvGeBz5mxk9xPCQmJP/q0H
	3BNw6d6jEg8gUmlDqvUSy2Jo/sdHT7ed/+4UztTRwsyojh8P445EA1+5nEQslMxE
	K7yQrqQq9lZ313dvXcPiEO1Xl61QWyGKdtslVRZXlxhmKhqgySEKNDdb4H3QQ55m
	+6kXcs6lvXNPyyKBVqIECMzsxTznrXBpa9p16N2YdLWNlVXfyDQsI50ed3kHKdvY
	m9iL/Wul8RraC0QflOcfqdLJBJP1Row6DGqsJEpiirnB250b79Uyzho02nmCKl+g
	4N1BH2+IxFB0w8l9kbjwtVTpbOcwpmyQTscxDXhbkjT7eSg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g8cabgntr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 00:22:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 24 Aug 2026 00:22:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 24 Aug 2026 00:22:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 320D83F707F;
	Mon, 24 Aug 2026 00:22:04 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-pf: reset HTB scheduler topology before freeing queues
Date: Mon, 24 Aug 2026 12:51:46 +0530
Message-ID: <20260824072147.3524339-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfX50KhgrHEWPuV
 Cu0AhGm8rmIXPcHVY0DKPX7req+aIE+1J/+dHVSnPvfbZJMtFog0n/M2/806j3uURjm6pdXcdBY
 wxfSz0kzDHMnzbNZWOF9BcPGNnqzwhc=
X-Proofpoint-ORIG-GUID: dbRnIJd3noyhqON8QwoTfVJIFLa4_Cva
X-Authority-Analysis: v=2.4 cv=SePHsPRu c=1 sm=1 tr=0 ts=6a8bf122 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=0m6KuKFDjvClTsrKsqMA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfXzKJlIpZuK+Rx
 R2SZ4k1BZuXniCCZDhs/7QgYR8AuC5V2yP9leI2Oby4YXDsknV34/qzpN3mN4WVG2b4S1GHmMXd
 KZ6PFp2zDYiAep/WMqYkhSlbgqV9pSqpvDroAL5nn85fzpcMHF6uTZjWkarjEGiwDyq59fPNfZ5
 QdNmjW2K5ZHG7pJCAfP+mAhFR13qQ02GzzwAdbClBu2XYu2nso5d4tAYdAcOG0zxlzKWtCOy/yX
 2F/COgZrjDz7Mlun9YC3o1+QB/exNfhBTf9PzYbxhsgUjlgqsnGeIJ0MGx5nVGS9GPsm21kIQHj
 fpnM3FUu+KNqSiKKM5WaVZ/vKLWV6XN2pArfjJsrB3E/0/agPIUY5/8bmHa9Qg79ZCJf7+hj/og
 vt4mk4gAeHUNGWici8lhoi92OifRr1jhbCCw4iruEDFjNY8yCngWV1/D9VxpCImpE+kX/J33eJQ
 uJgtx5J2LbySg1tmUPw==
X-Proofpoint-GUID: dbRnIJd3noyhqON8QwoTfVJIFLa4_Cva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01

HTB offload programs NIX_AF_TLxX_TOPOLOGY on QoS-allocated scheduler
queues via otx2_qos_txschq_set_parent_topology(), but teardown freed
those queues without clearing TOPOLOGY. The AF only restores PARENT and
SCHEDULE on free, so PRIO_ANCHOR/RR_PRIO settings can survive in the
shared scheduler pool and affect later allocations.

Reset TL1 through TL4 TOPOLOGY to zero on each HTB node's schq before
returning it to the AF during hierarchy teardown and cfg rollback.

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260821072812.2890922-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..100342b68ffa 100644
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
+	if (lvl < NIX_TXSCH_LVL_TL4 || lvl > NIX_TXSCH_LVL_TL1)
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

