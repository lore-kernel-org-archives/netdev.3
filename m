Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643229;
	b=WS8iYkSbk4a2NJ4crbdOs7IVmjVPFBOm2gFHr7WUFYDQbNVV8ynbDh7Ws5FTtt0IcpHe
	 e6JhDGo/wnMPa9R2T1QyVeczQhNbmNsOJHLcD7R5KhePd48ir43r70YV1BGvsZE0AD7yG
	 zscu46QmV5CRtbHLj2w+4I6/Rl6VSpeNMsat6zRCbn8XP/DjkCv+MwirOqCGeUQfkBQmc
	 PqMsnX6MBB/ZUM8PZsQQmfcter6ZX32ad6QapmFumY7SHEjnZKgw+RpFa5VurlZ0/DHA9
	 dE8imFjAoNKobnlQVL/AFpMO2uK+kc++LZ82HSJF5ja8Evstd89oUAjtXJhtVI+9drQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643229;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=rH8pGjEtidnpy0V8mnZxHHovkrrmWnKjEbxiezsTATo=;
	b=ZleicoMjVh4Ud8QXkObRaeJXkLL9Fg1pHsYDNOzBIkZj9+mvyjliRxxWJP48JA+ZWemM
	 3TrAHI9+vPGSLJCEqS4O/ca/E8M1q2m+kTe+Nv9vhyYSlLiW2KZ8FQHx49tD6nvqGqnx1
	 uqJDxBbFxq3DvV8NLyoa09e0gGBVL0cXtdj+wb0Wu79dZvJ5A+yJUe0O3S8WcnX1TQQ4S
	 JMeJw0cTVij/sR9uOr73R9jldByiEvgU4kiZbSu7i6Ap3jSOoIrFnkrd2GER5hJjgcGLv
	 mRUTXG3mbPBPal23jHOkiuDrHMKKYC866fTJ9LTPryClYzyWFY0GUC5ucpYe4maa9fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=X86vWshC;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D6606A31A;
	Thu, 22 Oct 2026 04:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=X86vWshC
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3id033826206;
	Wed, 21 Oct 2026 21:26:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=rH8pGjEtidnpy0V8mnZxHHo
	vkrrmWnKjEbxiezsTATo=; b=X86vWshC/M7q02cs1z2BH95kJoV8+KVTiHTtuPb
	703BQdBo+7hTNx5XXrK4RQyXOChyazZ6G8oK6yGnbi+9tWrCryRrY9w7g9h1N5cO
	5UXGrorA5ATVKoo67qH+ZXQQHbdqpr00JQHM25Xy3ir3s+CMtKZV2QQ0XWTqyQSn
	9lC/PcjA9sgEJVgOcRUXfFIx/U3NWmJDZRFZT+Ar4TbNTzKYr1MQNPZIQrAHKUKg
	FxRdxt9hwf07kxYUHYeHIfeUCs9qiX9t2h5bEoMdYBGarNKOnAR8rSWEVoRUe39A
	GhbrDQw00T1TbKj9PDdYQnB2kJPU1Dle1LXlIO1qpPRPhmg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hf94b0mvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 21:26:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 Oct 2026 21:26:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 21 Oct 2026 21:26:58 -0700
Received: from sjc4ccscust-vm07.sclab.marvell.com (unknown [10.110.24.160])
	by maili.marvell.com (Postfix) with ESMTP id A7ECF3F7055;
	Wed, 21 Oct 2026 21:26:57 -0700 (PDT)
From: kmahammadraf <kmahammadraf@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Satha Rao
	<skoteshwar@marvell.com>,
        kmahammadraf <kmahammadraf@marvell.com>
Subject: [PATCH net] Subject: [PATCH] octeontx2-af: fix TX scheduler queue index mask for 2K schedulers
Date: Thu, 22 Oct 2026 04:26:53 +0000
Message-ID: <20261022042653.2640537-1-kmahammadraf@marvell.com>
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
X-Proofpoint-GUID: ZgIZUDW2KJOCSl8TpC71_Jmm7F5w1Bov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxNyBTYWx0ZWRfX6OeQMX/NN1yk
 a96uWq5ZGTsXwcnA7jKolCNCEYSAssEjJuiASWbVfyZH1fnCd6WgwaO9fiF5Ptj2r2CSC5b34W6
 wYtp3yBtGJa6DwjdIy7Vs3CWO0L73yGJjIAHrasAMvDLTbrh1z2PQDwRpa24umwS06A45/LzXC5
 A0W/Xxn/3RD7puD0xXOhuZpBDy8q34BubuudxL4GJ3WQOB4V7fu/F/VTwfPd4MbCicTvxzNC9he
 7ZB/BK1AsM4rgDk2CZpEV8SUZLh9BMM+4pk1M3rnIdxgsdcl6Lp7IUvMZhHCk9cpFGXDkcedO6f
 fIWqd/+U9vNlkguc8J1PVjUlPvkPXYrQIcOxa0W2dSGq+FRxOrIi0mpZiJKCYW538s6X2nJsCFj
 eCO0uXiyN+CyRkLfOgNrxCrNje95fzah+wLn2cbtX+N/mE/cs+G5/rnyIfJnsxPJinv9q5bGbI5
 kxYsmbWd3/NbUPTnTqw==
X-Proofpoint-ORIG-GUID: ZgIZUDW2KJOCSl8TpC71_Jmm7F5w1Bov
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxNyBTYWx0ZWRfX5yyWVvgZ8A4Q
 Nc4kOMa/T4AopZiqAxl9ZjuFQ9azuOLogzZ2j+AZ73rHo2jWFRQWzbLjLTb4EfDfvwDQpenZ3FP
 AD7LX3Y9CCYlV+6/T1gaTbf0LC8mR3E=
X-Authority-Analysis: v=2.4 cv=OrDaWC/t c=1 sm=1 tr=0 ts=6ad99093 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=hU_0wQR7ThAvaC2VLwYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01

From: Satha Rao <skoteshwar@marvell.com>

In CN20K, the maximum number of TX schedulers per layer increased from
1K to 2K, so the scheduler queue index field is now 11 bits wide.

Update the TX scheduler masks used for mailbox/config register access:

Increase TXSCHQ_IDX_MASK from 10-bit to 11-bit
Expand NIX_TX_SCHQ_MASK to include bit 26

Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..1b62f9d7f00a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1164,7 +1164,7 @@ struct nix_txschq_config {
 	u8 lvl;	/* SMQ/MDQ/TL4/TL3/TL2/TL1 */
 	u8 read;
 #define TXSCHQ_IDX_SHIFT	16
-#define TXSCHQ_IDX_MASK		(BIT_ULL(10) - 1)
+#define TXSCHQ_IDX_MASK		(BIT_ULL(11) - 1)
 #define TXSCHQ_IDX(reg, shift)	(((reg) >> (shift)) & TXSCHQ_IDX_MASK)
 	u8 num_regs;
 #define MAX_REGS_PER_MBOX_MSG	20
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 95f782d47927..a1d68afd7c9e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2850,9 +2850,9 @@ static void nix_tl1_default_cfg(struct rvu *rvu, struct nix_hw *nix_hw,
 }
 
 /* Register offset - [15:0]
- * Scheduler Queue number - [25:16]
+ * Scheduler Queue number - [26:16]
  */
-#define NIX_TX_SCHQ_MASK	GENMASK_ULL(25, 0)
+#define NIX_TX_SCHQ_MASK	GENMASK_ULL(26, 0)
 
 static int nix_txschq_cfg_read(struct rvu *rvu, struct nix_hw *nix_hw,
 			       int blkaddr, struct nix_txschq_config *req,
-- 
2.25.1

