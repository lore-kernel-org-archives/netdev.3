Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697534;
	b=xoEDjhHbHGMje3JfP7peCS8OuOacdv0c3dKBeP1fdYPvRFL/RIW72qeET3iQKAuUI838
	 H6vRd0ZwdREpHOYJw7Qk08RKGc03cz/X++M5LwvFcmx2moPS5MB6t21o0kVI6gCa/loto
	 8QgwOZTRFCZlc1UYoTcX7NFfMV9Co/h2Hr2BtAxozgnrJymyKMsnbb+jL4m7fb4nQ1It+
	 5GAjo0CkEjs/ES0aoYAjtuDCzlUil+9dnZ+9OkcqnMrmifBvqZOHxCOeAXaXqHE1hSXqO
	 /G+33u6olPAoGK3ogcgaOdOp/8hXthvxzDB9c06j6y2lAFOFIer/7ILENoa9BqCYxwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697534;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=xISkQ4ggutqNW0wtvAUTTAZu+ZP915uGUTRDp/jxhx8=;
	b=pJL8YMcPq6WCJy3qLCvKK89BNe6Y7Sa3nfBxGUrwdyFwlayRLKOV2dWwtA6wGdnXNfvG
	 tGOT9xO3hCEpR2EZCzB6ggEL9z95bOgk7DlQSx9vWtkxVgzPFv77VyrtzbYriNKfDK4rg
	 ZGfF7jxJMsqcYHoVIXdNns/KmimRpZgLQUGBGws74XfJMr3fuxtrfwprG6BtA1QJVsoWP
	 4imR2h2mDH4SYR0FKjn9MV16b7WiiNcwDEmJB+e0Z59ryCa96HRPzfPYhEcH/rO+FTKHl
	 JAvsmAFNNqNiFX7YuQBuN8NVkPDnv53Kve5IeeEdgqRnjA/3A8fOmvkKmzWox/OWPAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=FjeTVyAd;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75271606A324;
	Tue,  3 Nov 2026 09:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75271606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=FjeTVyAd
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31hhj53853946;
	Tue, 3 Nov 2026 01:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=xISkQ4ggutqNW0wtvAUTTAZ
	u+ZP915uGUTRDp/jxhx8=; b=FjeTVyAdwlcvP+dGOvNPtaPZstgLlxwEi/IpV6S
	awC2q+k+C0us999qdZV8q3HDFV99bd9SVvr6dWwmyvM/+zSTd1wwN6XfVPT3YX3p
	dZdTn/2nJOqmgnDO/VcCDJEqLlN3kr8q5P+BAKuN+V7LZ1i+veRdR/3DhyZ7Vs90
	K9Ab8GWqJxhOh6yyEeF46zwK0MOagGEfIH4+JPl3OfFcbzuP+my2PI2ZxZ2VV850
	/ukS/6eGFFQtMZpItd6t/vp5dHJllyDnTzS6l/1TO1z4KBVCpbp0DfGGGf2PLhG4
	KWDH5fbVoq8W3LG0xiOqwa0gbe9xHXrsinHR0zV8W4eswQA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hq58y9kru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 01:18:40 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Nov 2026 01:18:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 3 Nov 2026 01:18:38 -0800
Received: from localhost.localdomain (unknown [10.110.24.192])
	by maili.marvell.com (Postfix) with ESMTP id 466263F7053;
	Tue,  3 Nov 2026 01:18:38 -0800 (PST)
From: Vadluri Mukunda <vmukunda@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S
 . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Vadluri Mukunda <vmukunda@marvell.com>
Subject: [PATCH net v2] octeontx2-af: skip NPC_AF_MATCH_STATX access on cn20k
Date: Tue, 3 Nov 2026 09:18:31 +0000
Message-ID: <20261103091831.914393-1-vmukunda@marvell.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Vfpir1p9 c=1 sm=1 tr=0 ts=6ae9a6f0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=dWBa20jgcZIKP2ppMNMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNiBTYWx0ZWRfX+3gZ07W0Ombm
 nkL/akySkhu3TeL2oxVZphsXwScn+p8kJVFij55rUoDEuT/UECsWXR3+kUOuo5XTx8z5NUHNko4
 T9dqdkoMvxTwwzyxL3PC4w181OCZsHQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNiBTYWx0ZWRfX3VgVbc/DDk/6
 YTbNNFQCDSOiIjDcMKCno2OGU0EcX2hx9paZjt3tCf8gs5UeamET2dn/883wr5Bxwkp2oxFhrJm
 YT6ysSZO/XdCCv1jeGksdLNlBiLq5ry7wgO7jNo7MzhFH9l3VxpEPfSK94WX8QP7yk+17b9P+26
 4vie4cb+dlIHhI5/y7sgFExkl4LogooQBtCj85cOcnrOFH417HAFWByTPVohImqBtFxpEPRKCBz
 5JVPS0J8vUui/ZoZfVVgOEXdVsJXO6x5RJqOG9B+vcZUd3vmxVjLJR6QZNQ0n2fb46EVBB9uro6
 6DSYvjDgdX86ki3bFSESVnU+LtTKlHaIuIeoQYMnG+TkxTKdnbSHYrqlLN0zmWit5pvN/jVCC3R
 LveAPWPvttKQnvdpyiv0d7B7Z5nwFizXEhlfTXOt7d4nMmD6rrlvnShblKSsWr6RTTe6tc5ljVB
 /gzojdj5HOCQgxzFwqA==
X-Proofpoint-ORIG-GUID: Hu2nBntPGLFx3EGqut3ht6466VzEVama
X-Proofpoint-GUID: Hu2nBntPGLFx3EGqut3ht6466VzEVama
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

NPC_AF_MATCH_STATX is not present on cn20k silicon, and cn20k does
not set up an RX miss action counter. Two paths still access it:
the npc_delete_flow mailbox, which reads the counter of the deleted
rule, and the rx_miss_act_stats debugfs file, which would read
counter 0. Avoid the access on cn20k. Counter support for cn20k is
left for later.

Found by code inspection. The issue was not triggered on hardware.
Compile tested only; not tested on real hardware.

Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Vadluri Mukunda <vmukunda@marvell.com>
---
v2:
  - Fixes tag now points to the upstream commit
  - Also skip creating the rx_miss_act_stats debugfs file on cn20k
  - Use full name in Signed-off-by
  - Add how the issue was found and what testing was done
v1: https://lore.kernel.org/netdev/20261026035140.666684-1-vmukunda@marvell.com/

 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 6 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 2927633465d9..119426beb946 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -3740,8 +3740,10 @@ static void rvu_dbg_npc_init(struct rvu *rvu)
 	debugfs_create_file("mcam_rules", 0444, rvu->rvu_dbg.npc, rvu,
 			    &rvu_dbg_npc_mcam_rules_fops);
 
-	debugfs_create_file("rx_miss_act_stats", 0444, rvu->rvu_dbg.npc, rvu,
-			    &rvu_dbg_npc_rx_miss_act_fops);
+	/* RX miss action counter is not available on cn20k */
+	if (!is_cn20k(rvu->pdev))
+		debugfs_create_file("rx_miss_act_stats", 0444, rvu->rvu_dbg.npc,
+				    rvu, &rvu_dbg_npc_rx_miss_act_fops);
 
 	if (is_cn20k(rvu->pdev))
 		npc_cn20k_debugfs_init(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index ea5d462a66ee..f3b0b082443b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1960,7 +1960,7 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 			/* single rule */
 			} else if (req->entry == iter->entry) {
 				blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-				if (blkaddr)
+				if (blkaddr && !is_cn20k(rvu->pdev))
 					rsp->cntr_val = rvu_read64(rvu, blkaddr,
 								   NPC_AF_MATCH_STATX(iter->cntr));
 				list_move_tail(&iter->list, &del_list);
-- 
2.25.1

