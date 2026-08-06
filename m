Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448A3DB331;
	Thu,  6 Aug 2026 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003024; cv=none; b=AidkdP3PRmDV8A3u3iCPPc7w09MbPVf+8mPj9a8b26pXazH87tJqALiKbxdI8y40O3lnXkB5qO0F9HcOOQxXHC/1sU/YNA4TmQkX6BiBh78einbyyhDHUxgfbxyyrKREyi1ouRb56hzs+j1kH/YpeHCyFdpKs/7OV0a30/XMXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003024; c=relaxed/simple;
	bh=W56mzqNMMlTPrm10k0CMhedVubbITHwWB6HylOnIFzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0DmIb1tCnkw8Ie9ncgdz01doq5PV28AKzZXNsH2yMe8WV526R7aVaDyy1JQq0yOLlXHSpcw2wvUm8BVGpnMpTcBTyA9dHCYoJitOxt+6TLHfoIttpO3nDTh4YouQFBu87B3cTvn2RvQzlqx5OPx7AuCjV76V9cJe37aAQFsxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JgcTDPjR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JgcTDPjR"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NdavS1368414;
	Thu, 6 Aug 2026 00:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ymrHJpsOZUBNCBIVNQqi4Fp
	7SAP23gyfQ/uBF4ORE/k=; b=JgcTDPjRj0uNGipjX2rnZ9KaycIEUxjI1xwkSJn
	VWAnhNVWpE9Xvty/xVVIzA3wJvPXtyWcxb8N06FczHBD5Fqxnegl1Aed/KrL/6o5
	zpthh/EVI9PIcUl3wu9km938817Kzl159mWBAp9SwvMLWETuQQi1Sc0WSlpDseI2
	74ONmM34w/ShePJ9ubvxON76OkYD954xedyvEubFNy2zGtBshW2gbdn1YUJOHWsb
	/QQ1XRe4aCY35LdqPuiwnfHs4gZgv6F0gED4eDGN7K/2hptaPHyPbIVYHOR3CEt4
	Fx1fd/V/LLZxC+NRjdmiJTsSAeVekPmuFI5lL0jhccbzBgw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fu31da7hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 00:56:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Aug 2026 00:56:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Aug 2026 00:56:41 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 0C0623F7071;
	Thu,  6 Aug 2026 00:56:36 -0700 (PDT)
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
Subject: [PATCH net-next] octeontx2-af: Add mailbox to read default MCAM entry
Date: Thu, 6 Aug 2026 13:26:31 +0530
Message-ID: <20260806075631.2007542-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2MCBTYWx0ZWRfXyYuTXJzgXzck
 K58eaas/1PJJJR+R5Y6YiokVv4bYXsY/ckCUaWSnvESkgT4JesDoC44zNA2cBGGJbhtiYujZA41
 OyW9YL+Ie6R7qL+cDqN2IUVDnuHaubZJcjIH0fuH5zYmSC9f+25/qkwg35ilnHeFV35X4KwFeE6
 SzfICH5uxUHl7Pk8o3YwWf/nnajlygF29yWbM+ZW3G905rzyRxG7AXSe5xP4gd1B3b+k0agioIf
 Fc92LuMLWec2FuEhQ+WqI0Ka2R20aPltPh/OFZs41y7vHZvuVe+KIfz5oWCrftRfhSO6n88WKqI
 rDp39L3llflYNTmz0/NaKYuYJYLVJLPIG9aJvlJx3JSf6ka2tkJPjAhs6iRCpaaXNf7/am9wvYf
 5EK45h/LWoPMasenWP9PFTTfbBkEto3/gQHUtAzaRCWWUzHjJHYviV7Q2wMq5MFtSIy2UDqdn8n
 oRsIe9xe1orSCle53sw==
X-Authority-Analysis: v=2.4 cv=T9K8ifKQ c=1 sm=1 tr=0 ts=6a743e3a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=BKkIFbPduOxyNhHukjcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ReRxJHAGl21mgyL2_ARkj5wPHM9LcSV6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2MCBTYWx0ZWRfX9puhOMegNucR
 yTKhVVmuQXWnb53KXgqEOX1Wdz1LwUpzHsbin+mNwWZp+HdqL86qDvHuIEEC/hjlXruZfK9BeDJ
 9GWC8yKu28eUi5kD9Gwzeeyt5nH31qM=
X-Proofpoint-GUID: ReRxJHAGl21mgyL2_ARkj5wPHM9LcSV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01

From: Satheesh Paul <psatheesh@marvell.com>

Add an NPC mailbox command so PF/VF clients can read the default
unicast MCAM rule associated with their NIX LF.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 ++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index db27ea622f35..266bb762691c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -4303,6 +4303,40 @@ int rvu_mbox_handler_npc_set_pkind(struct rvu *rvu, struct npc_set_pkind *req,
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

