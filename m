Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D44CCDD2;
	Thu,  3 Sep 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401170; cv=none; b=LUdpbIHw7SGzorx2VOsw/dBpfdx5EuO87ynkbZ7ZRiJ78McuP72nbUU/Vugr6p6YgHljlTsub37cxIiTRTcUK8cxOIF7ljunYZNZB5DvtMfPogmHcmqCQ9+jw1Zi8nqC8ummbNxO7IrSgFllNrT1Tw6y3H8dVkeiA/Z5GTo7Y+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401170; c=relaxed/simple;
	bh=0e1vuKU50Yqi6X7TTZSRuCR+pzcPXjps5PG2c5yGvD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZyfSkxS/IuvJWmA9AbK1nzOuVSKQYhdflnp+aPKpre86HtW979sDZIM89a4LiRYsD2lv1LmmRCXKD2H5Y+Euju+zPmHpcNb1cRLdJaWhQRNB5Cu4jFsDCDfNoxej6eJFyRHVsRhPVsR9QOORWbADF2F/rsBn+k3blktAWlnkVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KF8KQtq9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KF8KQtq9"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682NL7623671858;
	Wed, 2 Sep 2026 19:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5HoE1QD41E5Z0d1Bwy3WBQL
	AhPv4d0CvpEMS7Je+Cwo=; b=KF8KQtq9d7BdQrFkDB8XGngF35UJ78/EiChZpPH
	0ileyehqEUBAy/OlCj9gbpFYaE1P7Io3Fd8xbd/n8hBMUpJoVEXPM/xiwFp0hV8E
	VD1VhkoOW0e1ZLp9cqyr2EgnQ5m6qnJnrr738P5LiSVFC2ot/E6K9KUQiZcx+SWy
	r6t7swkFRUEi5IwTDLag+XifJkKofdUds0mcfe6Nun4ClvInp4wi7EyBIW2GoiME
	iZgoa5OpgAVXFK4QA/Lf7A0MTIYCrDxvdmsCUiDKE4eYwAtcpXYxDxMXasX69Dno
	rYMGuZjB7XDaAzToZDBFfQblpRTbzUBjRHQl1zn7Md0UFaA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gew3k0exq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 19:05:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Sep 2026 19:05:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 2 Sep 2026 19:05:48 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id ABAE03F7072;
	Wed,  2 Sep 2026 19:05:44 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v4 net] octeontx2-pf: reset HTB scheduler topology before freeing queues
Date: Thu, 3 Sep 2026 07:35:33 +0530
Message-ID: <20260903020533.3068041-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: r1ZM-1AYElD4pcWtfYvlepf2WrDu1SwR
X-Authority-Analysis: v=2.4 cv=OYSoyBTY c=1 sm=1 tr=0 ts=6a98d5fd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8
 a=c92rfblmAAAA:8 a=feDtNzwfOZ3BIhz8oLkA:9 a=YTcpBFlVQWkNscrzJ_Dz:22
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAxNyBTYWx0ZWRfX4cI4uPUeq+uy
 06nceivzBoAtjVJm+AGDG2FTzhASFehsjSInwkCcAR4LUzslSjC8oDTJQJ0mWnv0RGKVBbR5qmn
 H+WVrthfxMIMAVZ13Y38BK2muGxWivFrp97HSQEIzzbqEjdFdYnEsL3ucX3lSMNh6rYVGnHy6mJ
 hYuJYO/RFvASq8VYsGxt6N0h62KUsw8PUEyqZPV2P1y3LSEwIfwBkxwZwoBtbZVjgUkrkI16inV
 W0xa7z9aJUIf1Vi+VgLs/KGTj2eOetOIltH7yJqMmUOmOyMXDWR6vkhPgQ8pMhqXMNXYUUCQULI
 xJqSntE1vv4URLyojUyWpeuLoEBGqBlNeDdxfX2mpy0uPHTz+HsDwbO4q3rveQld4WazRlrKvLE
 G4kuHJXkw1OZGcOKs8Qpj+9pI71z0g+8tyYSWT9gHqML5cYeMtvY1Gw983jtefePqqoZ63Psixu
 QF5bETRm1JOok3JVfdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAxNyBTYWx0ZWRfX2DwH9LwtBW/m
 BrhPRNfRJotjhdo5wUZfsS1HuheMbmYeYVWcqEtoYeKgxek5FvPsHIWxn/F7+cVZSi+4ljVjqNo
 u5CAMObnkBhRvsIVCZFXTR+QMKW8SYg=
X-Proofpoint-GUID: r1ZM-1AYElD4pcWtfYvlepf2WrDu1SwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_06,2026-09-02_04,2025-10-01_01

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
v3 -> v4: Addressed AI review comments.
	https://lore.kernel.org/netdev/20260902172428.534936-1-horms@kernel.org/
v2 -> v3: Addressed AI review comments.
	https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824072147.3524339-1-rkannoth@marvell.com?part=1
v1 -> v2: Addressed sashiko comments
        https://sashiko.dev/#/patchset/20260821072812.2890922-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 60 +++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..f160b1618efa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -235,13 +235,63 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
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
 	struct otx2_qos_node *node;
 
 	list_for_each_entry_reverse(node, &parent->child_schq_list, list)
-		otx2_txschq_free_one(pfvf, node->level, node->schq);
+		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
 }
 
 static void otx2_qos_free_hw_node(struct otx2_nic *pfvf,
@@ -252,7 +302,7 @@ static void otx2_qos_free_hw_node(struct otx2_nic *pfvf,
 	list_for_each_entry_safe(node, tmp, &parent->child_list, list) {
 		otx2_qos_free_hw_node(pfvf, node);
 		otx2_qos_free_hw_node_schq(pfvf, node);
-		otx2_txschq_free_one(pfvf, node->level, node->schq);
+		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
 	}
 }
 
@@ -266,7 +316,7 @@ static void otx2_qos_free_hw_cfg(struct otx2_nic *pfvf,
 	otx2_qos_free_hw_node_schq(pfvf, node);
 
 	/* free node hw mappings */
-	otx2_txschq_free_one(pfvf, node->level, node->schq);
+	otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
 
 	mutex_unlock(&pfvf->qos.qos_lock);
 }
@@ -913,7 +963,7 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
 		for (idx = 0; idx < cfg->schq[lvl]; idx++) {
 			schq = cfg->schq_list[lvl][idx];
-			otx2_txschq_free_one(pfvf, lvl, schq);
+			otx2_qos_free_hw_schq(pfvf, lvl, schq);
 		}
 	}
 
@@ -921,7 +971,7 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
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

