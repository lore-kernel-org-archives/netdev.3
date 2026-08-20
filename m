Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598433559CA;
	Thu, 20 Aug 2026 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201110; cv=none; b=bhGAUcMxyyq70K5LtP26uUsDrnJxQFMOFCiXHrWQzJWiN+w6Hej4Beby9py42jUNIIi22aw02olZuoIs7P9MqOSXYeyJitp74hTJKpB6lL/AQkQksDikDLk8Esmz1uVU37NUSIEGTu2QHXrI6EfmZfAVixK6ERPo4e+Ct0Js6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201110; c=relaxed/simple;
	bh=8aLre1UVzq9XUwO+L/FOI9aSU2pqDRGlrgZAJ47Hjhw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IV2X2sfUwuIQTV72zxDuGafC2dckv0Bsgv9W0vN6ZlbnBrC67jGLkReuaHy501kFzP381TIakQXTKOfm1GozEuIHbN0DwR97jEucayvvX7yZUc5ksNILdNIm1qCu/6LEchCvfgUTc2VrDTlDiwN6gq5dcUjR6hfsQxtusSYixTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PowRmT+G; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PowRmT+G"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JM8H6U527674;
	Wed, 19 Aug 2026 21:44:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ie0AvGa0+A36SB2v+YQ9h2V
	zb7WUl1Y1+qAhLKHGZ0k=; b=PowRmT+GR7juIMmum66NbsYBidEOiu8I+TtnkYS
	FIHSzlB5QceDbg9DM7tu/FBln0AaGbmY6VYodjMVS8ykZDcZU5biMWp0YpyiesxV
	ejT2HVEXWHyL3Vaxe+x6zkexWK5cLOIbyVPPUdNTMn4iU48N+ZMi+TWE4M8n29kg
	bXZUBF6lZnDQ2FGjjObeIrlwgAWsmX1t27mnCX/c4vDtNq5VL1fjXZv8i4vhONJV
	xKPXwKRbMxtDLJ7crd8iVPlljqbs703kWzawmkhXvU+zq6fXz6DHHv/QYufZf6dP
	rbpg+JO0+UCFTlhvSk3n/9Xubue7PZuEvMDtWPiEL++ufaQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yeve7pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 21:44:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 21:44:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 21:44:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 54C7E3F7051;
	Wed, 19 Aug 2026 21:44:53 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sbhatta@marvell.com>,
        <sgoutham@marvell.com>, <zyta@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, Sai Krishna <saikrishnag@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2: fix PTP RX enable notification on VF
Date: Thu, 20 Aug 2026 10:14:39 +0530
Message-ID: <20260820044439.2592441-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzMSBTYWx0ZWRfX9LKdniqCBs8c
 Ka5lnV/SVbNYoYDDNOZiKtB3z42tYZ0HqFdnxgSSaDvxv94H+8deJa6kc/IfUwwdLuxsbOaYuTu
 +3fDXtfA9MhYO5kqNtdneWn/PgfLVRU=
X-Proofpoint-GUID: uzIqgd96YhOeZEO2Fjl3qD_nIdV2Puw0
X-Proofpoint-ORIG-GUID: uzIqgd96YhOeZEO2Fjl3qD_nIdV2Puw0
X-Authority-Analysis: v=2.4 cv=Wq8b99fv c=1 sm=1 tr=0 ts=6a86864b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=nSSq00Y0FkuvHKgJGNwA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzMSBTYWx0ZWRfX/GCpT2IL79Xk
 GmuU08nyz79K/4v31qFSsEvDO7Z4eCd8nN7R5JsuyMeQhawmAjyjkctXiJbVDN65BxwzclIVVpA
 0PwBtv1K58At4PW0KnCLy4SSgBd8BsTnYp2YmYhlR0n7Mz67KerRS/T0vZ+6YlzrYrAAC1/YL3j
 BSiv6u1QPVW0EncpgHz38QCig/evQcaww3F2GdJMPbUhaYZ/VdFtPDytQlNefKXli7Pi+zWhLlj
 9MlE0IEGi5uZQaPIYk/QJbHoUveMLZK3PpoDsf0nzMr7drSPMEMSu7qf7SK1tt2Sjsfu7TswWkF
 QzK8y+JdeQzC3jiQbb+tmbSypfPqLrXaTVnT+AFAVdzvJiEVzkjGZ7yWDUQ/3d3fX0TqyVKlwfy
 NcoSpa3sN4V6kMsodik2VIImlt9eByd85u6dk2rAWeT4YqWmIrR3s7NHR7Fhe4TkRmyXoSpV/g1
 wpOpKs8LX+rxBwh8DaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Sai Krishna <saikrishnag@marvell.com>

When a VF enables PTP RX timestamping, CGX prepends an 8-byte timestamp
header to each packet. The parent PF and its VFs must adjust their RX
data offset before that happens, but enabling PTP RX only configured CGX
and never notified the PF or VFs.

Add a CGX_PTP_RX_INFO mailbox upcall from AF to PF when RX timestamping
is enabled or disabled. On receipt, the PF records the state and forwards
it to active VFs. Handle the upcall on the VF mailbox path so the
notification completes correctly.

Use the asynchronous upcall pattern (wait for zero, then send) on both
AF-to-PF and PF-to-VF paths, and serialize PF-to-VF delivery with the
mailbox lock, consistent with link-event notification.

Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2:  Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260818034728.2047614-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  8 ++-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 20 ++++++
 .../marvell/octeontx2/nic/otx2_common.h       |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 66 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 14 ++++
 5 files changed, 109 insertions(+), 1 deletion(-)

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
index c995f2900859..9e596fbd421c 100644
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
@@ -3417,6 +3445,44 @@ static void otx2_vf_link_event_task(struct work_struct *work)
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
+	mutex_lock(&pf->mbox.lock);
+
+	msghdr = otx2_mbox_alloc_msg_rsp(&pf->mbox_pfvf[0].mbox_up, vf_idx,
+					 sizeof(*req), sizeof(struct msg_rsp));
+	if (!msghdr) {
+		dev_err(pf->dev, "Failed to create VF%d ptp info event\n", vf_idx);
+		mutex_unlock(&pf->mbox.lock);
+		return;
+	}
+
+	req = (struct cgx_ptp_rx_info_msg *)msghdr;
+	req->hdr.id = MBOX_MSG_CGX_PTP_RX_INFO;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->ptp_en = pf->ptp->ptp_en;
+
+	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
+
+	otx2_sync_mbox_up_msg(&pf->mbox_pfvf[0], vf_idx);
+
+	mutex_unlock(&pf->mbox.lock);
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

