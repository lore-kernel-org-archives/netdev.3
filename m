Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAD21D591;
	Wed, 12 Aug 2026 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512947; cv=none; b=sR7RBRimllNlDbgDjL/v1O8WfPrtxrHKY7deIfoIaNtbyK6+l6/pPeCFYSXIZSgyCyZ9U3ZcDzQhE/1KRSpwYd9GgRhuSAhUMng1/34f2zqPlea9Blkcu/03QgULBq1Klchx5+J4Y6Sta1D2NBHeHpJN7xuNEuh//SYMDYcZJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512947; c=relaxed/simple;
	bh=dCKX9pyJbRqQmQb7npyQJDYRAijvgYPlqNwyA8Leimg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TGz2uxre4TvqRhuWtvTfMjSazYarZWTZ6/G5H1gHw7rGU5Zvs/62s9VB/eOiCHJQUxODmG/NVntyx779OYgz+ZfZleeCI+k5/Zzbi24OKLfZyeFetF8Bq19IHL+dyE1U/1JGgPcKKYLL40RqnW+o/PVulQe5mqVettvPGliWqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O3iOmlhc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O3iOmlhc"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C57QFG994930;
	Tue, 11 Aug 2026 22:35:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=EEFZlOGGXTzLwgtc/uz7R7T
	Y5JYojPRfe5j2EPtUZ48=; b=O3iOmlhc6zEPRB4SUv/Xr/XH9vpb/YDhYMGuPwJ
	EyxOHoX8oQnfirUHfHmUtPOclWzMfyOyjr8AyCoMS6CIej0sT/u/XzvC/UwLcZXU
	N9bP30zN1oJA5TwOpHrKfe0Zmj5gunR8ML94PCa0HhMw/iezOKIRckIxKGHTSkG8
	6FWIS6ZUb03B/eufCawJtSdBFmpzdBj4/s/nA/XSpr4UHZDzBiz6I9mBcDwtN/Sp
	tFBE5GUvIDSpMuPBxgTB0pP3XG0ZTfIpGevGkT0nIHVmvHtw8YBkJvpZJsLPFKz/
	KKksd6va09XP+28Zv7+LuWjKPDkdC9F/ac29Qhmzm7A8+AA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g0deb0w8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 22:35:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 22:35:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 22:35:37 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 4B5273F7071;
	Tue, 11 Aug 2026 22:35:33 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Satheesh Paul <psatheesh@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2] octeontx2-af: Add mailbox to read default MCAM entry
Date: Wed, 12 Aug 2026 11:05:22 +0530
Message-ID: <20260812053523.3329305-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MiBTYWx0ZWRfX/XiET5TYZjPG
 1lFzOo7shKVK0S1CRsEBrCnf+mjHRlEF0bkdmB2cDtKLgzR7SKGTxxIxWn2yUW6h9Pc/LKTwrVv
 OSH7kT9m9Y9m5WNmWxQDOawgg3Zd6tg=
X-Proofpoint-ORIG-GUID: PiNuzVbFqQBZofcgzQW0A12xX18N2_Cg
X-Proofpoint-GUID: PiNuzVbFqQBZofcgzQW0A12xX18N2_Cg
X-Authority-Analysis: v=2.4 cv=MJxQXsZl c=1 sm=1 tr=0 ts=6a7c062a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=BKkIFbPduOxyNhHukjcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MiBTYWx0ZWRfXzQJ3oLt7Uibt
 D4/WcRuihiy7ScF+H3EkZxS3Z3LejKcv6rE8Ge9fYDKoaeWgNhn29ItlPAbaDEB+ur9sz5KSOj/
 RDs9nvIlVlDvLLVBb5swVAe8z1+ZKP+bSENvBE5Tt5z09MG9/k5lWOTtgNj1dM3mKGNq+2r/qL4
 vDXEWXEACo6x+T1AcfFXnkGGt44B6x4MYybAJoRuoiwq59jtAZjwER/hXaFr6Jdm6sKAe50wKxv
 Rdkt61U7kkJd8xRiIKUFm0pGCflKljq3Elrf/8+W8kPKjOhCH97B8cLnhfnT/viXf3PK8x3hffL
 JzjIky7o2Qe4bd8/DBWZFVoJl46BVWSO7fEz+jSvt+xtjmX9G30ptiBzeyYj7l753OAgIdfoy9E
 IB1l5B8MlOESO55RORsyLJnFIVREy8AZhfkeUOut8HGsyynjQR1CDw8chqiqMvYPjt6J6i+NApA
 nKwphdr7NWXOC3yKqwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01

From: Satheesh Paul <psatheesh@marvell.com>

Add support for reading the default unicast MCAM
rule associated with a NIX LF on non-CN20K silicon.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
v2:
- Added a CN20K guard to reject legacy default MCAM rule reads on CN20K.
- Updated the commit message.
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 37 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 73f743e4a83d..cece197d1074 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -309,6 +309,8 @@ M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601e, npc_get_dft_rl_idxs,	\
 M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601f, npc_get_pfl_info,		\
 					msg_req,		\
 					npc_get_pfl_info_rsp)	\
+M(NPC_MCAM_READ_DEFAULT_RULE, 0x6021, npc_read_default_rule, msg_req,	\
+					npc_mcam_read_base_rule_rsp)	\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index db27ea622f35..60922944675b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -4303,6 +4303,43 @@ int rvu_mbox_handler_npc_set_pkind(struct rvu *rvu, struct npc_set_pkind *req,
 				      req->skip_size);
 }
 
+int rvu_mbox_handler_npc_read_default_rule(struct rvu *rvu,
+					   struct msg_req *req,
+					   struct npc_mcam_read_base_rule_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int index, blkaddr, nixlf, rc;
+	u16 pcifunc = req->hdr.pcifunc;
+	u8 intf, enable;
+
+	if (is_cn20k(rvu->pdev))
+		return NPC_MCAM_INVALID_REQ;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	rc = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
+	if (rc < 0)
+		return rc;
+
+	/* Read the default ucast entry */
+	mutex_lock(&mcam->lock);
+	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
+					 NIXLF_UCAST_ENTRY);
+	if (index < 0) {
+		mutex_unlock(&mcam->lock);
+		return NIX_AF_ERR_AF_LF_INVALID;
+	}
+
+	/* Read the mcam entry */
+	npc_read_mcam_entry(rvu, mcam, blkaddr, index, &rsp->entry, &intf,
+			    &enable);
+	mutex_unlock(&mcam->lock);
+
+	return 0;
+}
+
 int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
 					      struct msg_req *req,
 					      struct npc_mcam_read_base_rule_rsp *rsp)
-- 
2.48.1

