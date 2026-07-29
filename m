Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE83D3CF0;
	Wed, 29 Jul 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309860; cv=none; b=KnoKL49hZiOJxn1cFPrtz0SSVGC2YMnDhbLx1Ybd7qnRszuOQCmhtljZgxacUg+5nOd+cJkAhZprU+GXA2ktaz2jxYvBatfgsPj8Uk3uVsn07HQg/46baA2rpiSFQ4iuxGFUPnS2dMCQmtcbZ8kNwY6cJg0QT8TSF56tIXzgsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309860; c=relaxed/simple;
	bh=7w2IzaaUA1BeXue6JhSxWCMuTwrJePOUUbHLbdMGPcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isMzgqxqGcxHr1e7K8rzwwINdlopxlfiPg6DgB+WjTony3xdfI01+XRZcVEbVApQwjJOhKbZs1rd9QVBp7SOmvwnAwb97a2RLIGB/12U5UPuBAIlDPvABfcijLr4xvFMZMjY8G30V1pgycSifA1da7K1nXgeycsaaMxrVfRnAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Xn6hqCVx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Xn6hqCVx"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4dnIR3358232;
	Wed, 29 Jul 2026 00:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	02rlHNJdLSG56b+d/VG4iN7mdggz52P+TzSOS5Q0hA=; b=Xn6hqCVxfUtkplw6C
	7GkCg4REXWemRdqbcYKjJG1Hndk6//gZ5bDHpcoyQ+L+g4adyY06xymd83yclDJz
	FsnhARNsNcnafXyoixzLXqzbsE+hgNhcaZNY6t99QEvQ1NNSrqy3tEH9DCN/LDKI
	yJ9Iypv71k8sDSfliBvk1a/Xk8nRLLMcvL29ZlA4+FpdqtUiI9LQ+ur1gnf4Ggrt
	M4yZKdax1FpD9ll2cUGGzEglwklqgVsBV2nbE2jdiSmrZBU3LSMyxJWTHL4vfpXn
	lop6/51YmtdQwuXlFg8XVDzENibU1hAmtxlKeybnUh1M1IqpwAEMLzM8t0ItlSww
	LTkKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fpym7jg1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 00:23:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Jul 2026 00:23:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Jul 2026 00:23:50 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 4B0B33F704A;
	Wed, 29 Jul 2026 00:23:47 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: [PATCH net 2/3] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Wed, 29 Jul 2026 12:53:36 +0530
Message-ID: <20260729072337.664479-3-subratp@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX22f/mu88AqVs
 3IoEJQ9rHul/uStEWafNwCsNWbzHeaeuyGi3+1Z0PqFaN3buOWevzcycCUuQCWV4PgS6AaYnHcX
 spWPOFfPow/mlx0+hDqw1/RIAkAwKS0U8h+VBTebQdSycow3Yj8mQkbKpLR7zd6br/X8TbZwYUa
 yoRr6HMHQmBtLqAmEtHCeP0mW0TXzR3DKtOXZNmimwqpPSwRHEyVUuz8H1NDYaUcik46ZzGNlmw
 zK9j/Pbf3+cGKiDLMWERt6ZlAK7+MztokQMha2P4rIb49CuWbyB2rlD1lakpPtfJeyxV53Sn+6D
 zXRHQdAOxkwX+ge33/Ztw5NSgQDV7XmsVMsUDThlZbLtMZvg2+cfHS06ghGAVmxMMISKwSsVRU+
 WoNz0z70UMjyg8Cv+/FWOIS4ft2C99OJn3OnuVr1IEO1E4fp5r6dNdmwAxf7AAbuxaF2qGQnbG2
 FcKZrAduYxF4R/7bphQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX49Ntu2Ku6pYA
 /Rg7sOaJ/93XcgjCFLTqGmwDCb4hYRg+i2Py9lp9MV0SZ/gpm89JMA/seKOSZDwz760PvXUem8u
 Duvbiuwiw4nb9rh3H0g9PlsAvx3nYFU=
X-Authority-Analysis: v=2.4 cv=YJOvDxGx c=1 sm=1 tr=0 ts=6a69aa8b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=MZaZBdy3eYgu71wtW0YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: cUzbSFrUWiR3h8Oy4T2SSsgCad_iYEl1
X-Proofpoint-GUID: cUzbSFrUWiR3h8Oy4T2SSsgCad_iYEl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Previously, BPID assignment under CONFIG_DCB assumed
`queue_to_pfc_map` was always initialized. For SDP VFs this leads to
invalid memory access as it was not initialized.

This patch adds a NULL check for `queue_to_pfc_map` before
dereferencing it. Also, simplifies the logic by always assigning a
default BPID first, then conditionally overriding it if CONFIG_DCB is
enabled and the map exists.

Fixes: 184fb40f731b ("octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c  |  8 +++++---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c    | 13 +++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index dbf173196608..f3903cce9bf7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -245,10 +245,12 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
 {
 #ifdef CONFIG_DCB
-	return pfvf->queue_to_pfc_map[aura_id];
-#else
-	return 0;
+	if (pfvf->queue_to_pfc_map)
+		return pfvf->queue_to_pfc_map[aura_id];
+	else
+		return 0;
 #endif
+	return 0;
 }
 
 static int cn20k_tc_get_entry_index(struct otx2_flow_config *flow_cfg,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3d253132a17f..b4691472d2a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1132,10 +1132,10 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		if (!is_otx2_lbkvf(pfvf->pdev)) {
 			/* Enable receive CQ backpressure */
 			aq->cq.bp_ena = 1;
-#ifdef CONFIG_DCB
-			aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
-#else
 			aq->cq.bpid = pfvf->bpid[0];
+#ifdef CONFIG_DCB
+			if (pfvf->queue_to_pfc_map)
+				aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
 #endif
 
 			/* Set backpressure level is same as cq pass level */
@@ -1433,10 +1433,11 @@ int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 		 */
 		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
 			aq->aura.bp_ena = 1;
-#ifdef CONFIG_DCB
-		aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
-#else
+
 		aq->aura.nix0_bpid = pfvf->bpid[0];
+#ifdef CONFIG_DCB
+		if (pfvf->queue_to_pfc_map)
+			aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
 #endif
 
 		/* Set backpressure level for RQ's Aura */
-- 
2.43.0

