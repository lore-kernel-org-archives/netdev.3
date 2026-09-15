Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE646C84F;
	Tue, 15 Sep 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457254; cv=none; b=Oa7il5sbejLltuz7oGRv9XTLAY5zORDW7s7q9GZ4XHkhJWM009qOrN1VNDMWgwK7yNdEMiHlzk025cPhP+rH5gtMXXKb8bSThF96q/xLfu8DEAQzNiYIQLcQttzE0i7y00+DAGuUmqn++xHCinTeiKNSsxFqbBeRuUGdCPXPJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457254; c=relaxed/simple;
	bh=yfOH/BuFCdkILYp99CMmrXC7wYYwEFQcyUeUjLHsCW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1raDk7wqAdkVIoWC19wEdJWxstJ8Vl9sKNapfUjpBpVYtwkzXt28jCfx8RAAc0pa9V7uZtZH9rMLcpkPjLNpEjBkY+SrYps/ylBDDQf6Kgye+alWcNc7ucfDtSICoh7w5yqI+J1yy4l3i8sktTYd05E+aHqy+Q2dt4b1wyBsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NaiwMkHs; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NaiwMkHs"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZX3h2902132;
	Tue, 15 Sep 2026 00:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=I1E9VX1poiN06owBgX/fpTR
	V3pPvCJHvyGxfY2JFgJA=; b=NaiwMkHsGyZzIux3xnbPm1C520hJkPRfgephFOV
	XKtLypvSNFjPMLwbGQWAhtBF8dR9Uw4gfMO1x8355bryFSxZiC8jRRqCQVs7ISTW
	FS1M9YQgn3XW/WIoQbPXL9xtck852BoJ489UQwPg6N5zSuRqdDdAth+l2HkIyw2T
	OfXanwow/VGne1hT5gXJyGbMZ0Q+6A6De41QV/1VaiWDnpRIznMGaFoYplPh/t7+
	6uWw4kyCyVvjjRge5I4TNJNjcoAh5e3u5ynOucxEW4bo5B61RoFaZn6aZz8Qt5/U
	SIi2KQTWrx5ZGCK52NK8JeAknq1WnMDZc9Ev8Ra6doc459g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gpsc7t0pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 00:27:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Sep 2026 00:27:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 15 Sep 2026 00:27:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0719D3F7063;
	Tue, 15 Sep 2026 00:27:17 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>, <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: nix: Fix NIX LF allocation for representor devices
Date: Tue, 15 Sep 2026 12:57:11 +0530
Message-ID: <20260915072711.985075-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=aIhlOr9m c=1 sm=1 tr=0 ts=6aa8f35a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=P0cs9MrDAgVRIvXMrGoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 24U20gqcjR3FK0VUzagbNwfOql-qYta1
X-Proofpoint-GUID: 24U20gqcjR3FK0VUzagbNwfOql-qYta1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEwNSBTYWx0ZWRfX7n/N7Km/YwOO
 CG4nnCCr5lct0Tt5mKgeX8HJ9wZ3ae+Awi3nL9/V8/dxzCSfN9KE3gOg8Qg0O8fyTVX3+0oNlEI
 D8n+mt1KDJwnyn2xc4Dls/3cJxyjBSM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEwNSBTYWx0ZWRfX5AHs2id/d8cu
 6HD30+n0H55jmiCXBdG93ll1Zyy8AKIpqemutU8kyYut6VlhVaP17A8kYnF6Sx/JJMkw5M5GUWh
 C1jVWJFpfvt/zyO27Z+HMX6j3IU5VzSNvbOqF1WB4phpt7xY9GfR6wZm57VsCLMPDThEPuJI7oB
 ojz8ejq16NjmhI3ptcNkAEm3GpK+sc9lubCHloLjn47rx6blxHxgqjjzfnRXoSPncHblsRXjV/s
 uLAvax8Om60Yw9DPNz5p/z9Fy/6Mu8h28jg2cT3OZ4phgd3yanp93JVuozG1HH5ixEkDlDhmCvx
 V2Y5QEeP62ahdcmngBHl73ll+NQMkjLb1Li2a7Nf+NMmVBrcw3bJji1Mg/Jy5qWWL1IVBcRo0Gy
 8KqW0aLqV3TNPMEuU0+zU6EIUt8OLModvE9hdbct4bU5xwoylQMreWeNGXR1+ilWPya39jqcUvO
 3UDvOTkxOvwnpeFv+IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

Representor NIX LFs need the LBK TX link and PKIND configured so
packets can traverse the switch path between representor and VF.
Also skip copying the MAC address into the alloc response since
representors do not have a valid netdev MAC.

Fixes: 683645a2317e ("octeontx2-af: Add packet path between representor and VF")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..ed62ef336a73 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1713,6 +1713,9 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (is_rep_dev(rvu, pcifunc)) {
 		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
 		pfvf->tx_chan_cnt = 1;
+		/* Setting the TX link as that of LBK */
+		rsp->tx_link = hw->cgx_links;
+		rvu_npc_set_pkind(rvu, NPC_RX_LBK_PKIND, pfvf);
 		goto exit;
 	}
 
@@ -1755,8 +1758,9 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	nix_ctx_free(rvu, pfvf);
 
 exit:
-	/* Set macaddr of this PF/VF */
-	ether_addr_copy(rsp->mac_addr, pfvf->mac_addr);
+	if (!is_rep_dev(rvu, pcifunc))
+		/* Set macaddr of this PF/VF */
+		ether_addr_copy(rsp->mac_addr, pfvf->mac_addr);
 
 	/* set SQB size info */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQ_CONST);
-- 
2.43.0

