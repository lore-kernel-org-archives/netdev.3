Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D2417362;
	Wed, 29 Jul 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309858; cv=none; b=L4PS1QMCJjYTU37Pdet7+wGy7mAVGdw9tQbFKVT0GItLdDuxqRwBsyCXzvkv2wycZuSL9yDbbKWm0ljGYo58xrGekssm00c2+uXF3VxgLWYD8hooR1sTngymzfqEAjXX09593Bk8ivnyg5UsjKDaDA2Q8a1Y5bKOKZuzekc735E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309858; c=relaxed/simple;
	bh=qmLT2CqbKHdwHvgite/XZ56mWMwgS/lYq7z8i4DeWtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohQXsG5+ruCBhBj3VaylDLnjB/XKuBz3KfqzlO05cPq2MBGNHNkdWXtGEbu+/EANo6P2405vOwrb4O0u1VU71LJer3avLXEBDYG+dl526pDObbAZtyb35cO8aHxysI3FM588/YGctO5eIrSb5BpZIgGFarju6Tn2JSv9A3FUX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HcMnmmnO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HcMnmmnO"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4dnIS3358232;
	Wed, 29 Jul 2026 00:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	aMabz+7OcBygqx1EJrTLq3qcerxZNxaqCiAAp2vi1E=; b=HcMnmmnO90IOQXLhl
	PE9Y+WGhzhO0wl4ELirb/a+F6F7zRa8caRq4qD1nk4zJ0Cf5rIBZOFpl+wfQ76/s
	hhMo2pFE1r7YXg+akHNX7IoPIvJKcAI7hUxAmVypBKTQkK/aGGA/vO9Y6Y/kJt3l
	Wc8MAjuBAoCgFeligF5o0JAnTjlLVdU2brsdVLVaF2JbMbYRw273a8ocGcXLV8T6
	2SQikXwhiiDHtqIAbutWScFH00e8ABkVpMXfrc2IsOKt8ANXoCMi32dTTSrqJIMa
	mjjcjqQaAbR6Awxktyf4qKD6ZH2PDKXII59se9unLfgOsnZKm5wCHfjy+FnNqXpY
	FWZ6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fpym7jg1m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 00:23:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Jul 2026 00:23:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Jul 2026 00:23:46 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 1E0413F704A;
	Wed, 29 Jul 2026 00:23:42 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: [PATCH net 1/3] octeontx2-af: Fix mcs string buffer size
Date: Wed, 29 Jul 2026 12:53:35 +0530
Message-ID: <20260729072337.664479-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729072337.664479-1-subratp@marvell.com>
References: <20260729072337.664479-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX5kR1BodoprIJ
 bPhFbuQmIwSFTU5PjoxQ/zVaDzcEjxk9WW/qWeot5TlssG9KXHFfJco5VwjxfeKCwWT0MChLWR4
 YoIdJAGo7tC3jSgeCQeo2FmF9gsH8Pir4pdI1nCgcaRrW9qrJkIPcbwMcHlUPMK59RKnbpY4wv4
 Vl+eguPy4+4hO+FJjGer+lfSi8qkk6gqpbVNcQ2hylFajzx/WuVRj8FxkRts/3XTo/H/wz6pDv2
 nswxPaRpb3HbCyPwAMHKHGJCkxNkZ/5mZRROBoVOwzQqY2wSgRw9Ozsk09pbtCmQQS4LUywYNHf
 k69IliGgRW1DbROw1LSXzJsvZsLL1YjN72IMJddWQRZ7qbLroaYlYTR+ToQfJyPGQuGXQ5XeV50
 8CTBGQHacQwpuW59nn1PJJdKkiQ74t9qEzxfHogegys7+h9FGIwbYiNaRAGHTMmtjX6zuEps5MH
 +mfHtWuWI3PED4nlSaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX2AHjaIw8BdnV
 8ga9NKN1YgadYRWxNzCVj8kq8GPeBzWyKoI16k6pMIhgn/v9xdjGAERhddmOwOgZJMC1ryaILWb
 9TxMzcKeXK3hqc/tg+bCa44HwaW3WKY=
X-Authority-Analysis: v=2.4 cv=YJOvDxGx c=1 sm=1 tr=0 ts=6a69aa8c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=8kYGrqOciXyvW2u7iDUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: MLeQyXVrOwXeDRRp_h0qXP7UFnfuR76B
X-Proofpoint-GUID: MLeQyXVrOwXeDRRp_h0qXP7UFnfuR76B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01

From: Stefan Wiehler <stefan.wiehler@nokia.com>

The "mcs%d" name is built with the unbounded sprintf(), which writes
without any regard for the size of the destination buffer and can
overrun it. Switch to snprintf() with sizeof() so the formatted write
is always clamped to the buffer. The buffer is also enlarged to
24 bytes to comfortably hold the string for any MCS block index.

Fixes: d06c2aba5163 ("octeontx2-af: cn10k: mcs: Add debugfs support").
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3456313d3b3c..a13848f26ae9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -497,7 +497,7 @@ RVU_DEBUG_SEQ_FOPS(mcs_rx_secy_stats, mcs_rx_secy_stats_display, NULL);
 static void rvu_dbg_mcs_init(struct rvu *rvu)
 {
 	struct mcs *mcs;
-	char dname[10];
+	char dname[24];
 	int i;
 
 	if (!rvu->mcs_blk_cnt)
@@ -508,7 +508,7 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
 	for (i = 0; i < rvu->mcs_blk_cnt; i++) {
 		mcs = mcs_get_pdata(i);
 
-		sprintf(dname, "mcs%d", i);
+		snprintf(dname, sizeof(dname), "mcs%d", i);
 		rvu->rvu_dbg.mcs = debugfs_create_dir(dname,
 						      rvu->rvu_dbg.mcs_root);
 
-- 
2.43.0

