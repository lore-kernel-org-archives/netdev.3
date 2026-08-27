Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874023C4F3;
	Thu, 27 Aug 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819110; cv=none; b=NkTV5rg2sijz5tqOG1Q4kuxkJFMKlF6MToG/YEokyC5auHR6Lt4EPZuxG0iP3yEbJ1pFI386+WCfjnL0wiIgLYvJfMGryr/ntvMrIM3eh6iXe99iMHNEN4S1xH6Z4ZCol8NMPzwucC3OCQR+ZBeABilWgK4Oj+eDHRAQtd4q8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819110; c=relaxed/simple;
	bh=K//dcqOj/u1f4v/t1XJXee1C8LWkVqJwhqugohvZIwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cNkkc5UxTXAuro6qO+9TbNfmuWHU2EqFrYXP4zeKKT3BFbk2GaaUZK0rDEvQfsUptr4mQ0YqxHj2HOaOHfNNPYIjhk/qafK2EjchQ7sxX06UAgcSy9DGMS8+5bDg7dJi0r5HOdOvk5yU93KDKeCocYMYkJgAiL6lz3hQyxC3T7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A1xOEvsw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A1xOEvsw"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6PgNI2868611;
	Thu, 27 Aug 2026 01:24:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=b2ICdb/gaA7hSkuEmMuxQ/U
	oiiH5nTsEmWK24FkrIaE=; b=A1xOEvswsaiB1NSkbZh+pnZ+Vv8kCiVRx9MQKBI
	lm+0rwN9KM3tVzSYdHFeqQbnLkPKQugttHzJo+WdL9qMYf/ZRZEFxo5sNW2br/l1
	cSyIhDvZrSstZLerAq+ijvQANllPBWtLrlkAGemcmNpl+Ths8UDZuzoX/KKWp9bH
	GMCCsMg+5NYlWNv9IHtdzP61NYmHWUrKoEr2XjuuEqoHbrzyDDR9rMj98Xp8VriN
	Bk3T/gQGnviUL9SpttgiPl8+zETRbzzn+cIkxYPGCUD3mseHcX0urDz9jDKrQytW
	NL/8V+l4J9F5f6ypCHRjxVpYjHaKjgMdQiQMS7nWFoXIItA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ga970sb9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 01:24:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 27 Aug 2026 01:24:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 27 Aug 2026 01:24:46 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 878FB3F7058;
	Thu, 27 Aug 2026 01:24:42 -0700 (PDT)
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
Subject: [PATCH net v2] octeontx2-af: Fix Rep link state sync up with PF/VFs
Date: Thu, 27 Aug 2026 13:54:29 +0530
Message-ID: <20260827082430.383813-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 41Dm5wEoMnQq6uRLgIvF5CNVd0nU2iWK
X-Proofpoint-GUID: 41Dm5wEoMnQq6uRLgIvF5CNVd0nU2iWK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2OSBTYWx0ZWRfXzB7hh+Mxkuk/
 yUx7KyABdYPmaXTTKMbUUyIpj7O85EzOl3LcgU9JW983A8uGXXyj4K5uhA16KoGPogEa6ZgJGH8
 RIORR5jAFeRJXLjg0Q2tCBJHcCvkP5E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2OSBTYWx0ZWRfX9i94z0qRWxiX
 Z/6C5FcRf8JbOUkAoQpHAJ27cxUCfSKNbQPJyJwSGQil6evbl0dToQXkL/4x/OTm80WblgLi0fD
 dFkZY48Ge9d8PxMEKIl4Q0SevuH11eIRSRyU2kizJNl+4rqlEbsbHvUdP3YSGnbOu9minXtfF9a
 04XdQd520jhImmE1r4F3QG/fT+xRKjkXxJmSuF0CU4+xr3Vepz9omkDDM2IYHXMmdwLG2ATURw1
 Sx7Pp6MnDrJ3/1y/eNAB8LNrT+7KOAdHP1nq4tO+6wPpSvSshUVZSx1smBydTAiNRtuH930sbE8
 MS51mJlgWRIfVYWQdIHjp2nFr79v5aGqPyxWiXwZEf/vbgs25XwS0Ra5ijuxnXMFlDbdWVJux2m
 MEK7M4zTyh1Cd35JGCYQpviRI0O7begQ9nKAdZ+Z0A9B43Bo6g2zYbsKBzs/ltrYwy6Z73UwTDa
 VQFRvurPwcEDeZKmoEA==
X-Authority-Analysis: v=2.4 cv=NvbhtcdJ c=1 sm=1 tr=0 ts=6a8ff450 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=kp-MP-1-nDhws-s2F5cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Sync representor link state with PF/VFs and move rep event workqueue
init to rvu_mbox_handler_get_rep_cnt().

Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
v2: Reject REP event notifications before workqueue setup and
    validate PF/VF state event pcifuncs.
v2: Make REP map initialization atomic by using a temporary map,
    handling zero-REP cases, and rolling back on workqueue allocation
    failure.
v2: Use an unbound REP event workqueue.
v2: Serialize LBK link TL2 configuration with rsrc_lock.
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 113 ++++++++++++------
 .../marvell/octeontx2/af/rvu_switch.c         |   2 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |   6 +
 4 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 74c041ab5280..f484e362cf57 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3716,6 +3716,10 @@ static void rvu_remove(struct pci_dev *pdev)
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
index a2781e0f504e..ef8d30eeeafd 100644
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
 
@@ -97,6 +103,9 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 {
 	struct rep_evtq_ent *qentry;
 
+	if (!rvu->rep_evt_wq)
+		return -EINVAL;
+
 	/* The mailbox dispatcher normalises only the header pcifunc; the
 	 * nested struct rep_event::pcifunc body field is sender-controlled
 	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
@@ -105,6 +114,10 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 	if (!is_pf_func_valid(rvu, req->pcifunc))
 		return -EINVAL;
 
+	if ((req->event & RVU_EVENT_PFVF_STATE) &&
+	    rvu_get_pf(rvu->pdev, req->hdr.pcifunc) >= rvu->hw->total_pfs)
+		return -EINVAL;
+
 	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
 	if (!qentry)
 		return -ENOMEM;
@@ -119,31 +132,17 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 
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
@@ -325,6 +324,7 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 	u16 start = rswitch->start_entry;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc, entry = 0;
+	struct rvu_pfvf *pfvf;
 	int pf, vf, numvfs;
 	int err, nixlf, i;
 	u8 rep;
@@ -334,7 +334,10 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 			continue;
 
 		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
 		rvu_get_nix_blkaddr(rvu, pcifunc);
+		if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
+			rvu_switch_enable_lbk_link(rvu, pcifunc, true);
 		rep = true;
 		for (i = 0; i < 2; i++) {
 			err = rvu_rep_install_rx_rule(rvu, pcifunc,
@@ -354,6 +357,9 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
 		for (vf = 0; vf < numvfs; vf++) {
 			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+			pfvf = rvu_get_pfvf(rvu, pcifunc);
+			if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
+				rvu_switch_enable_lbk_link(rvu, pcifunc, true);
 			rvu_get_nix_blkaddr(rvu, pcifunc);
 
 			/* Skip installimg rules if nixlf is not attached */
@@ -379,16 +385,6 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
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
 
@@ -443,35 +439,74 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
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
+	u16 *map;
+
+	if (rvu->rep2pfvf_map)
+		return rvu_rep_get_rep_map(rvu, req, rsp);
 
 	rvu->rep_pcifunc = req->hdr.pcifunc;
 	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
-	rvu->rep_cnt = rsp->rep_cnt;
 
-	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
-					 sizeof(u16), GFP_KERNEL);
-	if (!rvu->rep2pfvf_map)
+	/* Allocate at least one element so the map pointer is always non-NULL
+	 * once published, making the above guard unconditionally reliable.
+	 */
+	map = devm_kzalloc(rvu->dev, (rsp->rep_cnt ?: 1) * sizeof(u16),
+			   GFP_KERNEL);
+	if (!map)
 		return -ENOMEM;
 
+	rvu->rep_cnt = rsp->rep_cnt;
+
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
 			continue;
 		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
-		rvu->rep2pfvf_map[rep] = pcifunc;
+		map[rep] = pcifunc;
 		rsp->rep_pf_map[rep] = pcifunc;
 		rep++;
 		rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
 		for (vf = 0; vf < numvfs; vf++) {
-			rvu->rep2pfvf_map[rep] = pcifunc |
-				((vf + 1) & RVU_PFVF_FUNC_MASK);
-			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+			map[rep] = pcifunc | ((vf + 1) & RVU_PFVF_FUNC_MASK);
+			rsp->rep_pf_map[rep] = map[rep];
 			rep++;
 		}
 	}
+
+	if (!rvu->rep_cnt) {
+		rvu->rep2pfvf_map = map;
+		return 0;
+	}
+
+	/* Initialize the wq for handling REP events */
+	spin_lock_init(&rvu->rep_evtq_lock);
+	INIT_LIST_HEAD(&rvu->rep_evtq_head);
+	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
+	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_UNBOUND, 0);
+	if (!rvu->rep_evt_wq) {
+		dev_err(rvu->dev, "REP workqueue allocation failed\n");
+		devm_kfree(rvu->dev, map);
+		rvu->rep_cnt = 0;
+		return -ENOMEM;
+	}
+
+	rvu->rep2pfvf_map = map;
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index 49ce38685a7e..6f1330ae8d90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -15,8 +15,10 @@ void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool enable)
 
 	nix_hw = get_nix_hw(rvu->hw, pfvf->nix_blkaddr);
 	/* Enable LBK links with channel 63 for TX MCAM rule */
+	mutex_lock(&rvu->rsrc_lock);
 	rvu_nix_tx_tl2_cfg(rvu, pfvf->nix_blkaddr, pcifunc,
 			   &nix_hw->txsch[NIX_TXSCH_LVL_TL2], enable);
+	mutex_unlock(&rvu->rsrc_lock);
 }
 
 static int rvu_switch_install_rx_rule(struct rvu *rvu, u16 pcifunc,
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

