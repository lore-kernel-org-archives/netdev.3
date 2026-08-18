Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9926345EA2;
	Tue, 18 Aug 2026 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024865; cv=none; b=CgfZpeiep5x0N3RhlLFO6Yke/qTx9iMSciRDEFFBlycBk3Xh/w+PTbn9OO8HVVmKn1L1Vbr+BN00+O8iBm3MJ/75EtaK5QsZzGe3Weh7mkGUKkV2Iyyy6Gms4iCfUKKYWlpBJDzHNDlvGvI2jrPEh0JHf+rsU9N+uNMQ0lzMurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024865; c=relaxed/simple;
	bh=upmS6Tt/1LYQTn77vhUw6y/Pr/A7R8RTkZ+fYx3x+xg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1sqDAfvZvCwAreEy9o98Gbc6hg5kMEBtwSzmKs5mN2ba/A9HK4GR5tyuUAHiGDpfqf+v9hEHBavoOWCO8sSQau3EtVVcsMr6abOgRDmV1eg19aTmvYSu/xM+V+k3bhHq+KJuNpNKgLes8P+MV8aosVLnIE5jEn+bQSqX+HML9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KnmGO3IJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KnmGO3IJ"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLvjEB3764246;
	Mon, 17 Aug 2026 20:47:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5hNux874+2yprymnzSZ6D83
	7SRrCo0mED+j00ijsQpQ=; b=KnmGO3IJqEKlHtaNWwgaB4y7CyPZKbQibVVTtnh
	YFVpsLrea7GkBlYxLUw0L6TDAMIvBa0g487M4Y8FFS0DhU5387lgow5chqYvkWwU
	pW8YR6uEY/nuN0axf7J5gDeHG2dqFEkuwHJgxfV9iHDcNMWSpbnit1LQxdhr0Kcj
	H/OqD9aU6XIijFgExdApeOc8rOsfTuVI6WYwBl84aBG83fp8wQIgbWuTUTmmrZu3
	mriYPFvmXSxDocVqHFqnHL+e3CuYV75ZA6slSuyYP2eGFZ9K295lCxiwxOeCTAIv
	2Kxsw1Hc9U9m89zkTeubPuugSMYeijtCZuadVpahd9Nctnw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g4ap4gr7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:47:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 17 Aug 2026 20:47:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 17 Aug 2026 20:47:34 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8B6863F7057;
	Mon, 17 Aug 2026 20:47:30 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <hkalra@marvell.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <saikrishnag@marvell.com>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2: fix PTP RX enable mbox failure on VF
Date: Tue, 18 Aug 2026 09:17:28 +0530
Message-ID: <20260818034728.2047614-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q7LiJY2a c=1 sm=1 tr=0 ts=6a83d5d7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=NHMKxiKwEXHd31jJAx8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: YIrPYyh6SwbyN8IKB9vwdKSH8epDZ8IU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNSBTYWx0ZWRfX8OF5mAbztc8J
 yl5ejeRpzhdoaHouUh187S0cZbcX5XZuczyDvoSpKDhnmQaNZPbE2o2DxD+43Y3CQ9BNP7jgRv2
 xCQmdM6nOlLh2UjLRGPcMSk+lHDgxAE=
X-Proofpoint-GUID: YIrPYyh6SwbyN8IKB9vwdKSH8epDZ8IU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNSBTYWx0ZWRfX15aWy75jGkZm
 KnPejDczn5hQdJW677rpOMWlp86Po29Sihzc01XV9qA06ij1i+3t+IyMZ94uI9MCFGdTLFRHrjc
 WJETuCiqygyhQ9/rtgthmYOcSaJ81Y3WYucWV4XpUhQ87wDIjzBjNTKaDmRlwIxrzNFfj3U7PUW
 FNNgZTNfSTEkPIXTEmJ9FBzikdBPhlaw6qw/1fPmjsawKISkE5ajzi5QlLU8LUWJV1QHtwpvj/e
 HqLOtce5EubvluDAGW/dsViXXO3S5VCfmLIm2VjGeLnzrgJYFEf9sa7cOdZ+HiqieUmGyiUqm7n
 1uPdWJ3uZkmiSGO8UlL1xVKb0kX/q0+D3XUGQNIxgMrIp+RciAKQZSnM9fmjA4j9hcwEtc6tXNh
 groRwcfXgoaHo0NpjrosoPhkoqboFbMNKW6s4IwTfRGO0t4RW1Z302wulaUKeNhWGpGww+yzfl/
 XvsLsjZp1bJzAtbQSow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

From: Sai Krishna <saikrishnag@marvell.com>

When a VF enables PTP RX timestamping, the AF must notify the parent PF
so it can adjust its RX data offset before CGX prepends the 8-byte
timestamp header. Use the correct upcall mailbox pattern (wait for zero,
then msg_send_up) instead of msg_send/wait_for_rsp, which causes the
mbox to fail on VF.

Add the CGX_PTP_RX_INFO upcall message and PF/VF handlers to propagate
the PTP enable state to VFs.

Fixes: 30e7ecb6441d ("octeontx2-af: Support for PTP notification to PF")
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  8 ++-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 20 +++++++
 .../marvell/octeontx2/nic/otx2_common.h       |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 59 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 14 +++++
 5 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 714e47f68d93..96e1b93f8122 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -427,7 +427,8 @@ M(MCS_CUSTOM_TAG_CFG_GET, 0xa021, mcs_custom_tag_cfg_get,			\
 
 /* Messages initiated by AF (range 0xC00 - 0xEFF) */
 #define MBOX_UP_CGX_MESSAGES						\
-M(CGX_LINK_EVENT,	0xC00, cgx_link_event, cgx_link_info_msg, msg_rsp)
+M(CGX_LINK_EVENT,	0xC00, cgx_link_event, cgx_link_info_msg, msg_rsp) \
+M(CGX_PTP_RX_INFO,	0xC01, cgx_ptp_rx_info,	cgx_ptp_rx_info_msg, msg_rsp)
 
 #define MBOX_UP_CPT_MESSAGES						\
 M(CPT_INST_LMTST,	0xD00, cpt_inst_lmtst, cpt_inst_lmtst_req, msg_rsp)
@@ -647,6 +648,11 @@ struct cgx_link_info_msg {
 	struct cgx_link_user_info link_info;
 };
 
+struct cgx_ptp_rx_info_msg {
+	struct mbox_msghdr hdr;
+	u8 ptp_en;
+};
+
 struct cgx_pause_frm_cfg {
 	struct mbox_msghdr hdr;
 	u8 set;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 87d21889dc49..cb95f3fb60ae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -820,6 +820,24 @@ int rvu_mbox_handler_cgx_promisc_disable(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+static void cgx_notify_up_ptp_info(struct rvu *rvu, int pf, bool enable)
+{
+	struct cgx_ptp_rx_info_msg *msg;
+
+	/* Send mbox message to PF */
+	msg = otx2_mbox_alloc_msg_cgx_ptp_rx_info(rvu, pf);
+	if (!msg) {
+		dev_err(rvu->dev, "failed to alloc message\n");
+		return;
+	}
+
+	msg->ptp_en = enable;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+}
+
 static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
@@ -837,6 +855,8 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	if (!is_pf_cgxmapped(rvu, pf))
 		return -EPERM;
 
+	cgx_notify_up_ptp_info(rvu, pf, enable);
+
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..13b54287facf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -286,6 +286,7 @@ enum vfperm {
 struct otx2_vf_config {
 	struct otx2_nic *pf;
 	struct delayed_work link_event_work;
+	struct delayed_work ptp_info_work;
 	bool intf_down; /* interface was either configured or not */
 	u8 mac[ETH_ALEN];
 	u16 vlan;
@@ -324,6 +325,7 @@ struct otx2_ptp {
 	u64 thresh;
 
 	struct ptp_pin_desc extts_config;
+	bool ptp_en;
 	u64 (*convert_rx_ptp_tstmp)(u64 timestamp);
 	u64 (*convert_tx_ptp_tstmp)(u64 timestamp);
 	u64 (*ptp_tstamp2nsec)(const struct timecounter *time_counter, u64 timestamp);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..8e2443041ee8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -44,6 +44,7 @@ MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(pci, otx2_pf_id_table);
 
 static void otx2_vf_link_event_task(struct work_struct *work);
+static void otx2_vf_ptp_info_task(struct work_struct *work);
 
 enum {
 	TYPE_PFAF,
@@ -960,6 +961,30 @@ int otx2_mbox_up_handler_cgx_link_event(struct otx2_nic *pf,
 	return 0;
 }
 
+int otx2_mbox_up_handler_cgx_ptp_rx_info(struct otx2_nic *pf,
+					 struct cgx_ptp_rx_info_msg *msg,
+					 struct msg_rsp *rsp)
+{
+	int i;
+
+	if (!pf->ptp)
+		return 0;
+
+	pf->ptp->ptp_en = msg->ptp_en;
+
+	/* notify VFs about ptp event */
+	for (i = 0; i < pci_num_vf(pf->pdev); i++) {
+		struct otx2_vf_config *config = &pf->vf_configs[i];
+		struct delayed_work *dwork = &config->ptp_info_work;
+
+		if (config->intf_down)
+			continue;
+
+		schedule_delayed_work(dwork, msecs_to_jiffies(100));
+	}
+	return 0;
+}
+
 static int otx2_process_mbox_msg_up(struct otx2_nic *pf,
 				    struct mbox_msghdr *req)
 {
@@ -3041,6 +3066,8 @@ static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
 		pf->vf_configs[i].trusted = false;
 		INIT_DELAYED_WORK(&pf->vf_configs[i].link_event_work,
 				  otx2_vf_link_event_task);
+		INIT_DELAYED_WORK(&pf->vf_configs[i].ptp_info_work,
+				  otx2_vf_ptp_info_task);
 	}
 
 	return 0;
@@ -3055,6 +3082,7 @@ static void otx2_sriov_vfcfg_cleanup(struct otx2_nic *pf)
 
 	for (i = 0; i < pf->total_vfs; i++) {
 		cancel_delayed_work_sync(&pf->vf_configs[i].link_event_work);
+		cancel_delayed_work_sync(&pf->vf_configs[i].ptp_info_work);
 		otx2_set_vf_permissions(pf, i, OTX2_RESET_VF_PERM);
 	}
 }
@@ -3417,6 +3445,37 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	mutex_unlock(&pf->mbox.lock);
 }
 
+static void otx2_vf_ptp_info_task(struct work_struct *work)
+{
+	struct cgx_ptp_rx_info_msg *req;
+	struct otx2_vf_config *config;
+	struct mbox_msghdr *msghdr;
+	struct otx2_nic *pf;
+	int vf_idx;
+
+	config = container_of(work, struct otx2_vf_config,
+			      ptp_info_work.work);
+	vf_idx = config - config->pf->vf_configs;
+	pf = config->pf;
+
+	if (config->intf_down || !pf->ptp)
+		return;
+
+	msghdr = otx2_mbox_alloc_msg_rsp(&pf->mbox_pfvf[0].mbox_up, vf_idx,
+					 sizeof(*req), sizeof(struct msg_rsp));
+	if (!msghdr) {
+		dev_err(pf->dev, "Failed to create VF%d ptp info event\n", vf_idx);
+		return;
+	}
+
+	req = (struct cgx_ptp_rx_info_msg *)msghdr;
+	req->hdr.id = MBOX_MSG_CGX_PTP_RX_INFO;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->ptp_en = pf->ptp->ptp_en;
+
+	otx2_sync_mbox_up_msg(&pf->mbox_pfvf[0], vf_idx);
+}
+
 static int otx2_sriov_enable(struct pci_dev *pdev, int numvfs)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index b022f52c6845..60f81062007b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -141,6 +141,20 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 		err = otx2_mbox_up_handler_cgx_link_event(
 				vf, (struct cgx_link_info_msg *)req, rsp);
 		return err;
+	case MBOX_MSG_CGX_PTP_RX_INFO:
+		rsp = (struct msg_rsp *)otx2_mbox_alloc_msg(&vf->mbox.mbox_up,
+						0, sizeof(struct msg_rsp));
+		if (!rsp)
+			return -ENOMEM;
+
+		rsp->hdr.id = MBOX_MSG_CGX_PTP_RX_INFO;
+		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
+		rsp->hdr.pcifunc = req->pcifunc;
+		rsp->hdr.rc = 0;
+		err = otx2_mbox_up_handler_cgx_ptp_rx_info(vf,
+							   (struct cgx_ptp_rx_info_msg *)req,
+							   rsp);
+		return err;
 	default:
 		otx2_reply_invalid_msg(&vf->mbox.mbox_up, 0, 0, req->id);
 		return -ENODEV;
-- 
2.43.0

