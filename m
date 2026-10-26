Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995819;
	b=VpXQdVK6qT/Ae7yU+r0HuHhsPqg9zfZ7svWxVsh9uoZM4JUDcC2FBrVzJpZevqqM6CNW
	 vPXIkZ/vf687B3Aals35/FnKzxyVwGQKkhdsptnrowAsVc3BEp5lgDZyzIQ8+/CKIKOVO
	 pksOXJURvxXMskAgiMbT55YN4342U86nVsPDPbAmbeTBb2xNVNWSYm82wo4Ggq7Rw6RCt
	 e6jZEuQJmf6wzF43TGXlOaQkMPUTPylwZGADZdC5f0MjzQSJGgraHRPgQPMvH0EBYavx1
	 oX0nk3jDd5rgrxaxdgjEyzbX80Nk3icmUVnbxI3Hn/loEw4RDxEEhKR4Df2Xm1SUPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995819;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=MWYzmunPpf5aWlyS36n3IeCOrJulHX8edbCiZwZNehY=;
	b=kObY7kpDPoapfGT0q5F4IEVAQRFSz5t9uPg4fV/Fyz+RCTHJG1Wc10WlNKaErSZqrWdf
	 syJiqeTVvTRMGWwn36zMN9iBx62a4GoNI9A6Y4mXeYqAy4NqVVlPmv1NVh7lUMdm4mt1b
	 5TGvRdq3niQ0KId9OeX70OdfGwYARlNVY/AX9hxtBldUiOqJAvcQR9wfnzKtjFe8uEVHS
	 SXcXw7K7Mm245MeTFLQBP89IXPuxDHsQpmGFbLOkrIdqAzgHw/2MN8J0mIhpYnnNMp9lh
	 sqsk24tavpe5M7RjyCjTYwdUuNNeDsDlTw3EEFXCQdLfP/XD78TVDGyOg9aX/P+OXSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=a7Iw5LgB;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E5606A324;
	Mon, 26 Oct 2026 06:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 735E5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=a7Iw5LgB
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2NN3i1799187;
	Sun, 25 Oct 2026 23:23:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=MWYzmunPpf5aWlyS36n3IeC
	OrJulHX8edbCiZwZNehY=; b=a7Iw5LgB9kViooimtI0NIpb8rZncMqlw+oKFIJo
	dBTQBBQRgCGAmN6CZ+l3NCttL9lumdFCBUSyRFviWFp4gq2qOoTMA3frsl6dcIJf
	5KlpM1yyxQZoC/IEcHIQ/dNV4rAhlsnepAw4otVMP4lLdNQ0KLf1KC8M/c2gbkBt
	LV+CxH+tmOyTO1ktTAaaV8lknLVq8/Ar5oscj/+pg1v918FBeHSTyC/ivQcaim8Q
	D/wKfq7lOH0FmfWgYYmh5r2NdVIBaKS3rOddZ12Ul3IR/uOOJTnQk0YQgmO5N9aR
	GPxvohgshxOx29qdunQ6h7q9BJtnITnUi15BwupXVE+9mXQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hhgx9262j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 23:23:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 Oct 2026 23:23:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 25 Oct 2026 23:23:20 -0700
Received: from localhost.localdomain (unknown [10.110.24.192])
	by maili.marvell.com (Postfix) with ESMTP id B416C3F7059;
	Sun, 25 Oct 2026 23:23:19 -0700 (PDT)
From: vmukunda <vmukunda@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
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
        "Nithin Kumar
 Dabilpuram" <ndabilpuram@marvell.com>,
        Satha Rao <skoteshwar@marvell.com>, vmukunda <vmukunda@marvell.com>
Subject: [PATCH 1/1] octeontx2-af: widen TX scheduler queue index to 11 bits
Date: Mon, 26 Oct 2026 06:23:16 +0000
Message-ID: <20261026062316.754904-1-vmukunda@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=N+O8hG9B c=1 sm=1 tr=0 ts=6adef1d9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=EuGbU4x2D8lrRcO57msA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: vq8X4tVattUWODoPTP1rj8mFN7DfhdYc
X-Proofpoint-ORIG-GUID: vq8X4tVattUWODoPTP1rj8mFN7DfhdYc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX0SevdIeUcyGz
 SRb6620/zb4HZv+AdrJaUKycW3q97NjMbaT/qYuK//DXjDTvg5daeqIwj/uKUZrqy77sUY6WYJ/
 rWvcJGflNggWYx412sCzJf6im4bZ2gY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXz193rha4JGxm
 0z2slJ+QwZWEdbYZAqkEWi0FmPckN5e/JdMhSud/pz4AQdSfGnToYfA3gi9Itu/j5YLwLi4hknx
 vuew/XIxyPU7L/VxFrk3QdRAzM08oWdq/7saX1xbrUEMQo1NeRi3TgR0FobBjmdVzhGBDdaLE6W
 KICJuTHKhldUGTNplpPLIAR/n14vGV78mDn4X9ittnTajdd7zAvqpDGw5NY/7RY5V7uvNjYq7LB
 FPfLWc2r+ZdrFgFpiI+Z2wTnxXEDzI7JcxW1TAMEOpY3FxddPfYlqxjGtMcTT40POcYZhOv3NOP
 OTMOYN6Jxx9RXr+QBcRZfhD5JsLETX/NH+A6dy4qqzeeHlGrjIo1A+YrR8kdpqagVnmTRuOkEUa
 cmn+/pXnFSRjK/UFK453tBIvAHDMPE/xHvFB/nJc4ePvbbb+QPxb4Z26AuFnWEeLgYN8AgYCQeM
 j4D2B1seaWOc3MT3uCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

From: Satha Rao <skoteshwar@marvell.com>

The scheduler queue number packed above the 16-bit register offset
was masked to 10 bits ([25:16]). Queue indices of 1024 and above
were truncated, so configuration and readback used the wrong TX
scheduler queue. The queue number is 11 bits ([26:16]).

Widen TXSCHQ_IDX_MASK to 11 bits and NIX_TX_SCHQ_MASK through bit 26.

Fixes: 98e09d19688c ("octeontx2-af: fix TX scheduler count")
Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: vmukunda <vmukunda@marvell.com>
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
index 153eb57bad06..68cf730a8372 100644
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

