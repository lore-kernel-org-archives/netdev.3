Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6873448B80;
	Mon, 28 Sep 2026 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578654; cv=none; b=siSv9B9alzH6YNXJiu4nOw4x6XW3OIFR61xupCjkdUP3OAG/IRZFIRH22Upev/ykXueKht3Q+6pY05LlVzXbxceYzvpU+WfmLLMxpsIlRjGy+oZOu4KPmoiRtIU7e2YRBPLuSz/JUpmW7HuyewEgQ7Qh0HGstBQz951VT1e57Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578654; c=relaxed/simple;
	bh=oHEPc6NBHv+WAN3iqd61tfK/yFVW0Dg7UdYyujjf5lg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zzd3CvijRKub2KvXqIUQ4nW6Ds/z+Iur7SesBYhNKBSca76juWg4fkLRSj8RtlQjXQE5TbZhUFBhbjuJ+BobYY6IB1+abbcn1UdglbgKPKtVrCwrsebMs3+UJ/6q/hh4gD46Ob5NpCCiO4fc88qNnZsNYdywLbF1BTcMW0R7MUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jwGlfF5x; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jwGlfF5x"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RNlc7p1266692;
	Sun, 27 Sep 2026 23:57:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RhCpwb7cDGVOlwzmef99EBl
	cG5fohZgrhbnTjCCi1Gc=; b=jwGlfF5xgUbbQnfeIZaHmMkcjd2s55FBKKKhL3g
	1aQh9FSQe31bjEoEva6FCTOhwBKgtgZBFhgfU7olUDOKDvBjY4mQ4hpr0Lw6Fkw6
	uq8yGX4COg0fVf1DOGpeZndpXYJTIAmpsQqtFlrXwup/NMf0fBgbrWlsafW26fjA
	uqRgE7ifre/AritZ+z2iF0vUlsO95l1y4MeC14ifzAGoZpxVmmCVIg+leqO1xMzQ
	I2okbueF8pVFu0UjeHdwD1hbFCISaeMezxBfnQNlZDT0FSc5E5y1nR32EyYVG9rP
	gA+mN8jCeCUJ4dhOfMR1OmanssmWGijY+QmeDtvCgUsS4Ng==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gy2a6j5ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Sep 2026 23:57:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 23:57:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 23:57:24 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id B9C063F706C;
	Sun, 27 Sep 2026 23:57:20 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Rakesh Kudurumalla <rkudurumalla@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH net v3] octeontx2-af: Fix BPID leak in nix_bp_enable()
Date: Mon, 28 Sep 2026 12:27:17 +0530
Message-ID: <20260928065718.3378580-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SI7sbldzQ0IjKp3swC6Vd3e4pP-6Knt3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNyBTYWx0ZWRfX2qw+C9PQTmLv
 mFWRgiRNC9W8Lrt1OMYCMzYZiOnBh9C7gpjby+tYF5fXr5n/KAhNdMcq6EarCGNo9pAKfbfyLWz
 GFbSNmtIw5Udlrry3QLjZKyvyT+uSY0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNyBTYWx0ZWRfX1DlDC+2Xh8nA
 SPzB2uK2q5F+j5NXVo8VBtq/UPMeencCzr4qfDfh9K4o1YO7WiXedtj25FKBEfVywaGPjr8zIWX
 zItn/VAevXMTwoLwOlaE34sbrb+YGRlCymCuzOEDU65aZMXgvLdAlrj13IcqNaygDfQYxPlRX8k
 dUOCQ6BYMimHHjrTo51mnurpO4BIJK+II22ye5Zbr+u02MfTqes0vJ4+5kxON8R6yGSqCDuovxo
 U5ppeozP7iHj+2M3ps7Sh842FTTkS1sVGcMIaqK8otkv8h87yd4BGE0AtKQ3vEqEhFfJYf8+MIR
 1wEhgeVBzJHrkJ5enD743SqiuiyfastZOJa+MZ18FtfVLhCtowcU+3TtmpoaFXhgADO3kvP45AA
 mknQ5rSnjFUQI1E71QLpg77gXtq52kCxccCnsjBfwu74hSonwqqn7gASnnU8b7Kxkx1Xl7rZ2Dv
 yCEwwKlTh3wK3fA19Xg==
X-Proofpoint-ORIG-GUID: SI7sbldzQ0IjKp3swC6Vd3e4pP-6Knt3
X-Authority-Analysis: v=2.4 cv=DJIacCNb c=1 sm=1 tr=0 ts=6aba0fd5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=OKQiO2E4w6gJhqY63eYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

For LBK interfaces, rvu_nix_get_bpid() allocates a BPID from the free
pool on every call. nix_bp_enable() called it unconditionally before
the loop, and again after the last channel was programmed, leaking a
BPID whenever that extra call's result went unused. With
req->chan_cnt == 0, the pre-loop call leaked a BPID on every call.

Move the allocation into the loop body so it runs exactly once per
channel actually programmed, and reject req->chan_cnt == 0 upfront.

Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
changes in v3:
- Unwind BPID allocations and disable programmed channels on mid-loop failure in `nix_bp_enable()`.
- Report the actual BPID written per channel instead of reconstructing it arithmetically.
- Validate the BPID range in `nix_bp_disable()` before freeing it, preventing an out-of-bounds write.

changes in v2:
- Move the rvu_nix_get_bpid() call for LBK BPID allocation from before
  the loop into the loop body.
- Validate req->chan_cnt before allocating BPIDs.
- updated commit message and fix tag
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 79 ++++++++++++++++---
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..1ef505009c3a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -631,6 +631,15 @@ static int nix_bp_disable(struct rvu *rvu,
 
 		if (type == NIX_INTF_TYPE_LBK) {
 			bpid = cfg & GENMASK(8, 0);
+			/* Ignore channels that were never armed with an LBK
+			 * free-pool bpid (e.g. never enabled, or belonging
+			 * to a CGX/SDP range) - bpid - free_pool_base would
+			 * underflow and corrupt an unrelated bitmap word.
+			 */
+			if (bpid < bp->free_pool_base ||
+			    bpid >= bp->free_pool_base + bp->bpids.max)
+				continue;
+
 			mutex_lock(&rvu->rsrc_lock);
 			rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
 			for (bpid = 0; bpid < bp->bpids.max; bpid++) {
@@ -738,6 +747,35 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 	return bpid;
 }
 
+static void nix_bp_enable_unwind(struct rvu *rvu, struct nix_bp *bp,
+				 int blkaddr, u16 chan_base, int chan_cnt,
+				 int type, bool cpt_link)
+{
+	u16 chan, chan_v, bpid;
+	u64 cfg;
+
+	for (chan = chan_base; chan < chan_base + chan_cnt; chan++) {
+		chan_v = nix_get_channel(chan, cpt_link);
+		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
+		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
+			    cfg & ~BIT_ULL(16));
+
+		if (type != NIX_INTF_TYPE_LBK)
+			continue;
+
+		bpid = cfg & GENMASK_ULL(8, 0);
+		if (bpid < bp->free_pool_base ||
+		    bpid >= bp->free_pool_base + bp->bpids.max)
+			continue;
+
+		mutex_lock(&rvu->rsrc_lock);
+		rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
+		bp->fn_map[bpid - bp->free_pool_base] = 0;
+		bp->ref_cnt[bpid - bp->free_pool_base] = 0;
+		mutex_unlock(&rvu->rsrc_lock);
+	}
+}
+
 static int nix_bp_enable(struct rvu *rvu,
 			 struct nix_bp_cfg_req *req,
 			 struct nix_bp_cfg_rsp *rsp,
@@ -747,9 +785,12 @@ static int nix_bp_enable(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	struct rvu_pfvf *pfvf;
 	u16 chan_base, chan;
-	s16 bpid, bpid_base;
+	struct nix_hw *nix_hw;
+	struct nix_bp *bp;
 	u16 chan_v;
+	s16 bpid;
 	u64 cfg;
+	int err;
 
 	pf = rvu_get_pf(rvu->pdev, pcifunc);
 	type = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
@@ -764,16 +805,27 @@ static int nix_bp_enable(struct rvu *rvu,
 	if (cpt_link && !rvu->hw->cpt_links)
 		return 0;
 
+	if (!req->chan_cnt)
+		return NIX_AF_ERR_INVALID_BPID_REQ;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
-	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
 
-	bpid_base = rvu_nix_get_bpid(rvu, req, type, chan_id);
+	bp = &nix_hw->bp;
 	chan_base = pfvf->rx_chan_base + req->chan_base;
-	bpid = bpid_base;
 
 	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
+		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
 		if (bpid < 0) {
 			dev_warn(rvu->dev, "Fail to enable backpressure\n");
+			/* Undo the channels already enabled/allocated for
+			 * this request so their BPIDs and armed channels
+			 * don't leak until an FLR.
+			 */
+			nix_bp_enable_unwind(rvu, bp, blkaddr, chan_base,
+					     chan_id, type, cpt_link);
 			return -EINVAL;
 		}
 
@@ -783,16 +835,17 @@ static int nix_bp_enable(struct rvu *rvu,
 		cfg &= ~GENMASK_ULL(8, 0);
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
-		chan_id++;
-		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
-	}
 
-	for (chan = 0; chan < req->chan_cnt; chan++) {
-		/* Map channel and bpid assign to it */
-		rsp->chan_bpid[chan] = ((req->chan_base + chan) & 0x7F) << 10 |
-					(bpid_base & 0x3FF);
-		if (req->bpid_per_chan)
-			bpid_base++;
+		/* Report the bpid actually programmed for this channel,
+		 * instead of reconstructing it arithmetically from the
+		 * first channel's bpid. For LBK, each call above can
+		 * return a non-contiguous bpid from the shared free pool,
+		 * so that reconstruction can diverge from what's actually
+		 * written into NIX_AF_RX_CHANX_CFG.
+		 */
+		rsp->chan_bpid[chan_id] = ((req->chan_base + chan_id) & 0x7F) << 10 |
+					  (bpid & 0x3FF);
+		chan_id++;
 	}
 	rsp->chan_cnt = req->chan_cnt;
 
-- 
2.48.1

