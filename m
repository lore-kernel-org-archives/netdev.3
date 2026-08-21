Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAC33C536;
	Fri, 21 Aug 2026 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289648; cv=none; b=NTEowMMsS1miwhX1DPSq/Zi03BFKLv4HTImp2unL8i+VH+VsAqZ2h/aArYpiOELoCZpxBnLRZZG0/f2ScICIRRRw4HOtoKv6coUTsImt1sx5+4S3cwkChKZlPIfSWTcqIyHMh2rRg75q2VrFyn0EKH+pzconDo1dMMcslPduYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289648; c=relaxed/simple;
	bh=0k2AWNwBuSt2Pevwn2ZACUPH3UeGE2EfwwGnXtb3KhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7WeDhlvEEdyMQuPHLwN6CdHBqR5OqDwTqsXY5jvUQ+KCodPefwfFzrkr7o9aG/ddlpIb45TnTcyNeqvZQDxsVytjlKnKKZQAAFswpCl7RMwYmeAk3k8PexRsQt+SU+fAg0kaD3Sm6N0CgFcNmO5+qB2z/PnUHcTNiZsBjXuDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N9DuQWeN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N9DuQWeN"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L21Kbo3501479;
	Thu, 20 Aug 2026 22:20:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=+GlpK6/E0efJRTfLasGycHD
	4fki+vsKaJ1h1eMH5ToA=; b=N9DuQWeN6cbtzcUaI50Gr1bv9mHtA9x3o2G7PSQ
	jie8qZwgeMIAh05PEinrfYCkLQIu+3q+0KLZ04JbaMCfWQCgr7zjR95L9k/JWqgV
	GEsuRdjaREnP+AXU4XQi7sIINJheSWkIGTdBbINGu2jyxOWlvapwpOYUAdQ9wvpx
	oLKDrHQFz5Oz8UCBsWZgkGonjI6WgwckEM/fk144oJYevlP4GVbdh0nbhKFrqrfy
	tcp2x4DuIM3HIUS6G67eNDHGWdLcqUTcymbFgkBq47whbZF9L4/KhInkMnmt5bXZ
	cHVZJ1T/4NRzjPkiqaKXNsLANm16g7bnDP63k7/6oXM+kbA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g602evakr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 22:20:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 22:20:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 22:20:37 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id D44113F7053;
	Thu, 20 Aug 2026 22:20:32 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Geetha sowjanya <gakula@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Harman
 Kalra" <hkalra@marvell.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] octeontx2-af: Fix Rep link state sync up with PF/VFs
Date: Fri, 21 Aug 2026 10:50:29 +0530
Message-ID: <20260821052030.2361371-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YwA-c4pWcECr6H1_S3AmUAVzpQmk5txy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAzNSBTYWx0ZWRfX/FaHKlegqplC
 VUJOjNA+s36D2OVhELSvJ7JZAjY2jCQRhkpb0yS0TvlSTEqPLdTtX0DJIFk8oz4MJqAgYRiQBAs
 J1ZNVtgWgxl+Os6mwF2Vab5llbkFt4Z8Ye8daWKJ60wsg/BaKinyJ/tkAB+FUTaMD81gdAnNi2y
 ZW3ujItxaP5t3+ALQgunsMm4mxY5xI7KevGItDeZxFLQU18gBWOkn//cbvqQFoVSHEIFExiKH2f
 zmfHj3fUH7XKmzI039SRMcs6LNsxcZnMuSkz1Ji/YYvS0mP7O3ZfJuK7nNTaIIK5y81f05cm19U
 IKz6aH5XCl7MjQ9G8qf8pbxa+WYD9MU8/TwU+B0x7KeZIQXlmyMzS5FeBfJ5ZAGRHHF64hUZroM
 ELBxdc3kNO3MBlgrea1EDNb21jO9R2woi6z3UL9iupdbaxVHS4b02dUbtvfrl7pYsEZeUym7Vz8
 cgiZZibqpNY5pRLaaPw==
X-Authority-Analysis: v=2.4 cv=NNvlPU6g c=1 sm=1 tr=0 ts=6a87e026 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=eZ0GRgrAo8MkU3D3ccEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAzNSBTYWx0ZWRfX0IkmM2M7/1B3
 MeAR4tbGYRIIIu7h16SfEMocY6WkLPb9UvomCMFH8uOg92UQE2VW8zGQFGCQAPejiNyicynyLl7
 DH1vedb+ifB+4M8+1RMTrq+HUF2KWAI=
X-Proofpoint-GUID: YwA-c4pWcECr6H1_S3AmUAVzpQmk5txy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_01,2026-08-20_02,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Sync representor link state with PF/VFs and move rep event workqueue
init to rvu_mbox_handler_get_rep_cnt().

Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 77 +++++++++++--------
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  6 ++
 3 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ffba56ee8a60..69983091a5e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3709,6 +3709,10 @@ static void rvu_remove(struct pci_dev *pdev)
 	rvu_unregister_dl(rvu);
 	rvu_unregister_interrupts(rvu);
 	rvu_flr_wq_destroy(rvu);
+	if (rvu->rep_evt_wq) {
+		destroy_workqueue(rvu->rep_evt_wq);
+		rvu->rep_evt_wq = NULL;
+	}
 	rvu_cgx_exit(rvu);
 	rvu_fwdata_exit(rvu);
 	rvu_mcs_exit(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..9daee5de0185 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -44,6 +44,8 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
 	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
 		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);
 
+	if (event->event & RVU_EVENT_PFVF_STATE)
+		pf = rvu_get_pf(rvu->pdev, event->hdr.pcifunc);
 	mutex_lock(&rvu->mbox_lock);
 	msg = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
 	if (!msg) {
@@ -53,6 +55,10 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
 
 	msg->hdr.pcifunc = event->pcifunc;
 	msg->event = event->event;
+	msg->pcifunc = event->pcifunc;
+
+	if (event->event & RVU_EVENT_PFVF_STATE)
+		msg->hdr.pcifunc = event->hdr.pcifunc;
 
 	memcpy(&msg->evt_data, &event->evt_data, sizeof(struct rep_evt_data));
 
@@ -119,31 +125,17 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable)
 {
-	struct rep_event *req;
-	int pf;
+	struct rep_event req = { 0 };
+	struct msg_rsp rsp;
 
 	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)))
 		return 0;
 
-	pf = rvu_get_pf(rvu->pdev, rvu->rep_pcifunc);
-
-	mutex_lock(&rvu->mbox_lock);
-	req = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
-	if (!req) {
-		mutex_unlock(&rvu->mbox_lock);
-		return -ENOMEM;
-	}
-
-	req->hdr.pcifunc = rvu->rep_pcifunc;
-	req->event |= RVU_EVENT_PFVF_STATE;
-	req->pcifunc = pcifunc;
-	req->evt_data.vf_state = enable;
-
-	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
-	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
-
-	mutex_unlock(&rvu->mbox_lock);
-	return 0;
+	req.hdr.pcifunc = rvu->rep_pcifunc;
+	req.event = RVU_EVENT_PFVF_STATE;
+	req.pcifunc = pcifunc;
+	req.evt_data.vf_state = enable;
+	return rvu_mbox_handler_rep_event_notify(rvu, &req, &rsp);
 }
 
 #define RVU_LF_RX_STATS(reg) \
@@ -325,6 +317,7 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 	u16 start = rswitch->start_entry;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc, entry = 0;
+	struct rvu_pfvf *pfvf;
 	int pf, vf, numvfs;
 	int err, nixlf, i;
 	u8 rep;
@@ -334,7 +327,10 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 			continue;
 
 		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
 		rvu_get_nix_blkaddr(rvu, pcifunc);
+		if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
+			rvu_switch_enable_lbk_link(rvu, pcifunc, true);
 		rep = true;
 		for (i = 0; i < 2; i++) {
 			err = rvu_rep_install_rx_rule(rvu, pcifunc,
@@ -354,6 +350,9 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
 		for (vf = 0; vf < numvfs; vf++) {
 			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+			pfvf = rvu_get_pfvf(rvu, pcifunc);
+			if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
+				rvu_switch_enable_lbk_link(rvu, pcifunc, true);
 			rvu_get_nix_blkaddr(rvu, pcifunc);
 
 			/* Skip installimg rules if nixlf is not attached */
@@ -379,16 +378,6 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 			}
 		}
 	}
-
-	/* Initialize the wq for handling REP events */
-	spin_lock_init(&rvu->rep_evtq_lock);
-	INIT_LIST_HEAD(&rvu->rep_evtq_head);
-	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
-	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0);
-	if (!rvu->rep_evt_wq) {
-		dev_err(rvu->dev, "REP workqueue allocation failed\n");
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -443,12 +432,28 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 	return 0;
 }
 
+static int rvu_rep_get_rep_map(struct rvu *rvu, struct msg_req *req,
+			       struct get_rep_cnt_rsp *rsp)
+{
+	int rep;
+
+	rvu->rep_pcifunc = req->hdr.pcifunc;
+	rsp->rep_cnt = rvu->rep_cnt;
+	for (rep = 0; rep < rvu->rep_cnt; rep++)
+		rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+
+	return 0;
+}
+
 int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 				 struct get_rep_cnt_rsp *rsp)
 {
 	int pf, vf, numvfs, hwvf, rep = 0;
 	u16 pcifunc;
 
+	if (rvu->rep_cnt)
+		return rvu_rep_get_rep_map(rvu, req, rsp);
+
 	rvu->rep_pcifunc = req->hdr.pcifunc;
 	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
 	rvu->rep_cnt = rsp->rep_cnt;
@@ -473,5 +478,15 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 			rep++;
 		}
 	}
+
+	/* Initialize the wq for handling REP events */
+	spin_lock_init(&rvu->rep_evtq_lock);
+	INIT_LIST_HEAD(&rvu->rep_evtq_head);
+	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
+	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", 0, 0);
+	if (!rvu->rep_evt_wq) {
+		dev_err(rvu->dev, "REP workqueue allocation failed\n");
+		return -ENOMEM;
+	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..3f89a2c04b2b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -459,6 +459,9 @@ static int rvu_rep_open(struct net_device *dev)
 	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 
+	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
+		return 0;
+
 	evt.event = RVU_EVENT_PORT_STATE;
 	evt.evt_data.port_state = 1;
 	evt.pcifunc = rep->pcifunc;
@@ -478,6 +481,9 @@ static int rvu_rep_stop(struct net_device *dev)
 	netif_carrier_off(dev);
 	netif_tx_disable(dev);
 
+	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
+		return 0;
+
 	evt.event = RVU_EVENT_PORT_STATE;
 	evt.pcifunc = rep->pcifunc;
 	rvu_rep_notify_pfvf(priv, RVU_EVENT_PORT_STATE, &evt);
-- 
2.48.1

