Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749688;
	b=oaBrIhDSQZU8ZE6OmUl0hbNiTTVGQsl6mUnTRo3x74RDw9zA10siBuyqNBRmIYlXtpT1
	 YDlNeL1bV0Ifc4jTt6UIlXmeciD+VEbIw+Rec3zkjKIeA95c3VkBwk+E3ByVdaUoP2agJ
	 jewhP6OQ0iVaH84rUPRoEOsc1AZ56YgLdfGzgnWmA6/3VNX1BUSSbfc07JkuZtAq6Hvmd
	 WCK8W8lKwUBDagrVYkrs52kiQ49BlqcBgN4GeMjE6LDIULt32Ta1U9rNwn5CRwQ7pV4iI
	 LTvGEjzXa36FIKsUbwICwQvuyy6r6yWTow5B4SjkU9x6VLhHydJro6a2hpcyV3TmzAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749688;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=6iq612J16q5nGpq9ukoIawRWHB2fhQA00l1lXotI5tM=;
	b=aD+O7MzyHx8beC6QFMKB5c6hV0SRHFeSqMOhamHHu8qW/sMgyugzQxkXHlUE16V44vPy
	 +1hQzCngwYQyGgfoKwQq4cyZqZ5Yy35kFs5IlByNsYtwZ3KAncR6/kYWufjvdLMJqsnNB
	 MKX0L5iGXSej/+JnV0X+EW66nA+9yxkPC1JKNaoXVko6TBk9NpcKv4PfAOdQAOxjbaAmU
	 OKu6MCnnh8RA95M66TK5pRZeVOVoIMohE45oOxE2EUrgwTjRsyV4SNA+8RjTo2uNv3mI2
	 JRt0DoPSns5LuLIQGYUBSKQP+bcCMGxbEEJVCRDv37nMExZd5vRxvjNLiGx4BGqMY+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=Rea2Zsl+;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A42606A31B;
	Fri, 23 Oct 2026 10:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42A42606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=Rea2Zsl+
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FgD43411314;
	Fri, 23 Oct 2026 03:01:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=6iq612J16q5nGpq9ukoIawR
	WHB2fhQA00l1lXotI5tM=; b=Rea2Zsl+IXp7sjJJsI3/84goQVornVEeGbPim/X
	mCKGyZJI+qYL2KEPTo1OtUY0ZYwpw1lATspCaXHirGBuiFfoV37sbutXW8Do2d+B
	6mDdIUbK+yqkqT8P7VSEok9R527x3yDmFhmgQsprr7ejvzjoU6JeE/EkMc5055fe
	gU3g/MH3vWqfSGUyWEbBxwTxO3gfMaEZ0PnyGGQaGFKt3prmHS6mzn2dYn2C9Onp
	S0Z2YrgjZr+xjjJY8Rt1N7XZkluxNR75AJ7OTiCVgpRS/oGkeTzSnNTkrstYoxZy
	6wwvVKHrurdAmknAMbXalVORCWCBHlC71OdoxuYFceUT/4A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hfmdtn7wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 03:01:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Oct 2026 03:01:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Oct 2026 03:01:16 -0700
Received: from localhost.localdomain (unknown [10.110.24.192])
	by maili.marvell.com (Postfix) with ESMTP id A07F73F707D;
	Fri, 23 Oct 2026 03:01:16 -0700 (PDT)
From: vmukunda <vmukunda@marvell.com>
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
        vmukunda
	<vmukunda@marvell.com>
Subject: [PATCH net] octeontx2-af: Fix npc_delete_flow counter read for cn20k
Date: Fri, 23 Oct 2026 10:01:12 +0000
Message-ID: <20261023100112.3402726-1-vmukunda@marvell.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfXxyUHtSiexsmL
 adNQOoA1ThznkVSu07qnbPMVNFB8JaUzDC8EfDb1t/iCSdKrhmKVGSQ/GqvBbTpjrXb62j56c+t
 KoVBl8omdrcflVCFCmyAg2RJyaDT7eg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX2UXQzpKsM4ws
 Lu4t3lMsnQIW8AxwBrdT3FxSaeeDJeaMm4lTG3XK4EU4n7zkF1tAIH3JD7ckcWLFA0CXBj6PqdV
 ptZovzg1dq064z/jHBtdBbGPXpSU9OM328A/kEY/9GHhz6/Zy6F5D2KgA67D7mPCbf7p+XE6Hfu
 cwFvD/oE5MRcVzEwLvYygxv19DsF61lsw40Lad+doOAkJoejkGt5budbT9ULibLuj3kaudoxyI2
 2xlLGHjuUpcax48KQrR7eQYe/dobVgm5OuAVhkIoX1GvqZx3RlSdaAEYe0ftWp0xPcOywlL3JpH
 WmJ3rINUPV+6FCiBdbEOve0fSZqp4rXD88CdjakOCOi+utOjTO4/8yt8o42AksVNosIHIeNTyrU
 AHkoRVGiIEPy8esEumrpI6wI6c3nTQpmoQcr9vIzFOKvrl07IjSJDz3HxyzLe1DCL0lBJ1ntyix
 5YhXag8PD+EiGXjK5Lg==
X-Proofpoint-GUID: CXvk2G0y0xCJAedXx4zy1Y-wMHe-_Cux
X-Proofpoint-ORIG-GUID: CXvk2G0y0xCJAedXx4zy1Y-wMHe-_Cux
X-Authority-Analysis: v=2.4 cv=PalqFShd c=1 sm=1 tr=0 ts=6adb306d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=j3AFsqOYKst2VyhahHcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

On cn20k, the MCAM match counter cannot be read from
NPC_AF_MATCH_STATX. Skip reading the counter value in
npc_delete_flow on cn20k. Counter support for cn20k is TBD.

Fixes: 5f83b4729440 ("octeontx2-af: Do not access match stats for cn20k")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: vmukunda <vmukunda@marvell.com>
---
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index ea5d462a66ee..06916b38ae2c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1960,7 +1960,7 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 			/* single rule */
 			} else if (req->entry == iter->entry) {
 				blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-				if (blkaddr)
+				if (blkaddr && !is_cn20k(rvu_pdev))
 					rsp->cntr_val = rvu_read64(rvu, blkaddr,
 								   NPC_AF_MATCH_STATX(iter->cntr));
 				list_move_tail(&iter->list, &del_list);
-- 
2.25.1

