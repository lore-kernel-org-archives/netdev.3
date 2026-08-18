Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AD25C804;
	Tue, 18 Aug 2026 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024242; cv=none; b=MUVac9bM4Y88+WlZZoOQ8TcYp3v5qKvzME3+dOkxDzqEQ2qD/D+Zhyy99tqxgjz5p2Hgsii7FAYC8me5XYm+8qJXk5j5V0HWc+nw/IGtWJm3ky3M4hMCI7x75c8Kd+2EnLePMeXlPnYuwMR0abwE/BaKNJz1dSyoLJIvF6jT0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024242; c=relaxed/simple;
	bh=+AHc/WjunEJ44re9MRtwMMfI6ZLs5Xzml1MGvH3v/eE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lD9oH4N/IiUQoMlosT8+ZXFCsHfMeNLGF9/x79L8aFwjqJ/va1bZy454GGv7dGsG1ug1GAXZPMcaSHI5Ishjcs62F3P/9yLOfBBh7/kpOgFu69Cqol3qQap08gRz2QfVCI8rArre/HC+a08L71vXRlIzzLY63eQE6dmOcZ0Qx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ii0lKc9s; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ii0lKc9s"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLwrNs3314065;
	Mon, 17 Aug 2026 20:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=tZniMrT5wIeEASAw/cZiV2e
	vtghYliWzW/1orxQXs7s=; b=Ii0lKc9sy40tIUsEshdTvXU/Zkc+PhzuWnSl7sF
	8jJC/s/sEsb7GqZr4+hxU8+vMJyCUSSA9xZfbbH9Hv8hXjEaAC11Pxm8i/3Sty7p
	UNuPne1M/1s3DHvpbSKvdq3K6z1bDOh7uAr5Lz/jUDAeZ23O7ysIt6N76mzzhNKQ
	ANYlc3pE1vn5Nw7iNlhvRUUkqEDYmUzQq+NV2yX5T9w89tUNDM67Met4Zt4jnyp9
	lPHvbrYx8kpL+SOjGwD7cDb7Skq9Tv7mstzMyxBKNvb1yAfGD0yh4PKrbhgF/ITN
	4/nWLa2aAvSI0uwPbqrlIcW3KglJ+wjtYcIPSh3AuTclmog==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g36v3cyn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:36:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 17 Aug 2026 20:36:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 17 Aug 2026 20:36:58 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 454563F704B;
	Mon, 17 Aug 2026 20:36:54 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <cjacob@marvell.com>, <davem@davemloft.net>, <hkelam@marvell.com>,
        <jbrandeb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Naveen Mamindlapalli <naveenm@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: poll for TX link credits before link mode change
Date: Tue, 18 Aug 2026 09:06:52 +0530
Message-ID: <20260818033652.2038116-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX2mjcbg/MRqgj
 bzacSnkT6bPbLZnfunIHfkRnwmmvY58QYw5uco7R0z+tJBBzXCQR3uaEEzys3lWI8W9PkGveOib
 k8famwxGysn5mrJ0R/xnD+vT3J76U0s=
X-Proofpoint-ORIG-GUID: LKqdyBnsQAyUN4BlstHgCaWORy4gVbHs
X-Authority-Analysis: v=2.4 cv=MatcfZ/f c=1 sm=1 tr=0 ts=6a83d35b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=WtFRnXJ9NEaXzeBqDjoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: LKqdyBnsQAyUN4BlstHgCaWORy4gVbHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX47XPUlS5Scba
 YpX6u/NcA8rPfh+/9wkkYqSKjbXiFRKlCc8xGKERzwjiCPBoVa5TAAYj4KABcfIuJ7F1WGXw9VH
 s61BTqnde9AsykGI5MRZ3BFYYdobP1HQE+yhNzti+dD4yjDzNhkKHiMwF6Bcyyp9++PPXDRGEBP
 Gfv81SYCGdGwb3xFI+TuYecwoOujfaK8X6v8DodPQYlOKUIbefBpmu01W/jwjlEoZoCkiKq59Yx
 pHazOg7JamdoBrKfNHqYQ0zLQkjD2pXQA0x+w4f7JDroL3wggiVHpkkxWyWJmuapiOJNgcOMDQy
 /3kdi/atmGMec3DPoiO0tEmoLTZNunYoUPX31btb/H54GQ/SvrI7z6hg/kkjvhn15Uf9kZkHAf+
 ENNpx6nP/i3sfy/5HNONHvbl5aAwJCl0tFwYSpH6SZGl5wc46t5s0TANoX71uOGgZzLoXtWZtuO
 ODNHnRsn+ouqKG5lT3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

From: Naveen Mamindlapalli <naveenm@marvell.com>

When a CGX/RPM link mode change is performed while traffic is flowing,
the link is temporarily disabled. NIX TX link credits can drop below
zero during this window and are not restored when the link comes back,
leading to a TX hang.

Set TL1 SW_XOFF before initiating a link mode change and poll until TX
link credits return to their original value. Clear TL1 SW_XOFF when the
link comes back up.

Fixes: 56b6d5398613 ("octeontx2-af: Physical link configuration support")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 19 +++++++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 48 +++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9d5b7b51bdfa..66e46528e3bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1048,6 +1048,8 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc,
 				u32 mcast_grp_idx);
 int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 				    u32 mcast_grp_idx, u16 mcam_index);
+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc);
+int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc);
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
 int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			    int blkaddr, int nixlf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 87d21889dc49..85143684bb6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -234,7 +234,7 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 	struct cgx_link_user_info *linfo;
 	struct cgx_link_info_msg *msg;
 	unsigned long pfmap;
-	int pfid;
+	int pfid, err;
 
 	linfo = &event->link_uinfo;
 	pfmap = cgxlmac_to_pfmap(rvu, event->cgx_id, event->lmac_id);
@@ -249,6 +249,15 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 				      rvu->cgx_cnt_max * rvu->hw->lmac_per_cgx);
 		clear_bit(pfid, &pfmap);
 
+		/* clear TL1 sw_xoff */
+		if (linfo->link_up) {
+			err = rvu_nix_tl1_xoff_clear(rvu, pfid << 10);
+			if (err)
+				dev_warn(rvu->dev,
+					 "tl1 sw_xoff clear unsuccessful, cgx=%d lmac=%d\n",
+					 event->cgx_id, event->lmac_id);
+		}
+
 		/* check if notification is enabled */
 		if (!test_bit(pfid, &rvu->pf_notify_bmap)) {
 			dev_info(rvu->dev, "cgx %d: lmac %d Link status %s\n",
@@ -1221,6 +1230,7 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 	struct cgx_lmac_fwdata_s *linkmodes;
 	u8 cgx_idx, lmac;
 	void *cgxd;
+	int err;
 
 	if (!rvu->fwdata)
 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
@@ -1230,11 +1240,18 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
 	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
+
 	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
 		linkmodes = &rvu->fwdata->cgx_fw_data_usx[cgx_idx][lmac];
 	else
 		linkmodes = &rvu->fwdata->cgx_fw_data[cgx_idx][lmac];
 
+	err = rvu_nix_tl1_xoff_wait_for_link_credits(rvu, req->hdr.pcifunc);
+	if (err)
+		dev_warn(rvu->dev,
+			 "tl1 sw_xoff/link_credit_poll unsuccessful, cgx=%d lmac=%d\n",
+			 cgx_idx, lmac);
+
 	rsp->status = cgx_set_link_mode(cgxd, req->args, linkmodes,
 					cgx_idx, lmac);
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 964bcaae098e..92d8f318783d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -6704,3 +6704,51 @@ void rvu_block_bcast_xon(struct rvu *rvu, int blkaddr)
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0));
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0), cfg);
 }
+
+int rvu_nix_tl1_xoff_wait_for_link_credits(struct rvu *rvu, u16 pcifunc)
+{
+	int link, blkaddr, count = 1000;
+	u64 tx_credits, regval;
+	struct nix_hw *nix_hw;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	if (blkaddr < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	nix_hw =  get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return NIX_AF_ERR_INVALID_NIXBLK;
+
+	/* set TL1 sw_xoff */
+	link = nix_get_tx_link(rvu, pcifunc);
+	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(link), 1);
+
+	/* wait for link credits to return */
+	tx_credits = nix_hw->tx_credits[link];
+	while (1) {
+		regval = rvu_read64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link));
+		if (((regval >> 12) & 0xFFFFF) == tx_credits)
+			break;
+		count--;
+		if (!count) {
+			dev_err(rvu->dev, "TX link(%d) credit poll timeout\n", link);
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+		udelay(1);
+	}
+	return 0;
+}
+
+int rvu_nix_tl1_xoff_clear(struct rvu *rvu, u16 pcifunc)
+{
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	if (blkaddr < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
+			  nix_get_tx_link(rvu, pcifunc));
+	return 0;
+}
-- 
2.43.0

