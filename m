Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07F3B6C18;
	Fri, 24 Jul 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879439; cv=none; b=sBNrGPROzgMnqP6JHoMXSTO+mCUxUsreEebgC12PKSnO52CeKPcxEC3BNs0CIwjO9mwoEfvpKRuXCrK7Dye6a3+6PoHrJiG31e3jtXDcsExDpurzU/NCOD312L2qNK6jsACZ5wyT+uq801+sYOsUz9nuoxVIxYzU67lgVk81yaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879439; c=relaxed/simple;
	bh=c6cUjvYYiiMCs99hHFVMkQFxBQfbTlpNFUs/IlWXu5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cuqL1x9jwvVdjNty7jLS/zjZBSOzga2FXFzheb8fFJSIjvIg5phd3/W4rL2zdM/PmLmaQgNyDGW3AKZFK5oAa7rrcn4Pf6SL49z4G+7wTCuFNWwh1KNX/tVv62qW82Xq8+qFZtINpA1XJ4qBT1EKlXkmOzIS9qeZZufpJtnjL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kVnn4mAr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kVnn4mAr"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4mkQt922744;
	Fri, 24 Jul 2026 00:50:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ORxMyvPqAbJZiWrq4bBRyM4
	SIKos9kc0vCym20+QnCk=; b=kVnn4mAr0WGOWU7TZKFaxL9irA5guRvAdswr1bW
	xhXXSHtrcvDyQxS5cmBQq5729qi9ZhXbL9CslpXGr4s2dNUhOOKCsMKBmDLKBMB5
	1W5zxA0ekMoCuHb6jyMvIADvsHYXf+uKe22BEfEn/JIA6djB1yuSXU6fM+q2S6BF
	9bNac7y2UgkzNO/UNEz+L2j2i9LhkKQLycnEinue59yclVq3OQTx1czIppiIxW+e
	IjnPbumeYZ9xYokdB6iZ3XsMD0z6RzQ8hxpaPSUn0Y0vhaWRom7uN34ybTFGcIvL
	lrnR5SQjs0b/eXuQM/xh3pCd7NIT/03DQGfDP32AGbZGaww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fk7jkvpjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 00:50:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Jul 2026 00:50:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Jul 2026 00:50:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B7AC83F7084;
	Fri, 24 Jul 2026 00:50:18 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Fri, 24 Jul 2026 13:20:10 +0530
Message-ID: <20260724075010.2665758-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3MCBTYWx0ZWRfX+MxpV4079zn4
 AEU8GchQdBwwNA8mzFaBGk1BXsCKZT/ByW0Lx7J165bSkifSul7uB/K6TCawdTIKwA1dGY8w2vj
 pPLAWnbLN/sfqfgHAfzy6zU9Fx3dG6Kw2/1URYoXcI+78nOPMayMdADzQEoFielsi/IH1waauk/
 olxlXNKxe28OYDtvRHxdHIFI3JHGl+UhWysyhQmfhahPI0FagBu+Mlui1hRXTYmKMoMCgQX0XNX
 RfmrlNSjJshRCM647HtYCOEDqY/j5FfVxyla4ycqnPTcxQ5kJebX8z2cyDa+HR0qsXdez4Ei89i
 hE1qOs9us9OGBWnZAHsydlHyUW+7ClnKV0G+0u0m0bMJkR0bqzVuKXGJVDjKrOw9RTHH+D9Hbom
 dlKB32LEoYTj4NC55CEE9RjINBCymNuqs5JJwMqoz1hmENzf9J3JljkbwWw7O3pKPGa5U6i0FYM
 kFKPCpgfXi8udfTpG7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3MCBTYWx0ZWRfX87QmueZgcgob
 WGXnTnpPSLkmSByAvAuNhOkr50W0bPevsPiY2j0eVhl1YKUYCr5jZkie/IZBK1NKGCBrHDqOtcP
 MyUQ/Lzdvr6zrKMzehWWIv7XzJcyvKs=
X-Proofpoint-GUID: umzr2SJMnWq1s1B7AKwHjvA74cRyHcrc
X-Proofpoint-ORIG-GUID: umzr2SJMnWq1s1B7AKwHjvA74cRyHcrc
X-Authority-Analysis: v=2.4 cv=Zrzd7d7G c=1 sm=1 tr=0 ts=6a63193e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=MxPkFbUnXorYhrUldtYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01

Add TC_SETUP_QDISC_MQPRIO handling to program per-queue MDQ CIR/PIR
shaping after mqprio channel mode setup, widen SMQ allocation when
per-queue rate limiting is enabled, and align MDQ parents under that
mode. Reuse otx2_convert_rate for bps-to-Mbps, fix sparse register
writes when only one of min/max is set, and improve AF txschq map
mismatch diagnostics.

Configuration examples:

1) Set up commands

a. ifconfig eth0 xx.xx.xx.xx up
b. tc qdisc add dev eth0 parent root handle 100 mqprio num_tc 4 \
   map 0 1 2 3  queues 1@0 1@1 1@2 1@3  hw 1 mode channel shaper \
   bw_rlimit \
   min_rate 100Mbit 200Mbit 300Mbit 400Mbit \
   max_rate 150Mbit 250Mbit 350Mbit 450Mbit

c. iptables -t mangle -A POSTROUTING -p udp -j CLASSIFY --set-class 0:1

This will guarantee max rate as 250Mbits for UDP traffic

2) Tear down mqprio

a. ifconfig eth0 up
b. tc qdisc del dev eth0 root

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  79 ++++++++++++-
 .../marvell/octeontx2/nic/otx2_common.h       |   4 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 107 ++++++++++++++++++
 4 files changed, 194 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 78667a0977c0..5ed6c225bd73 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -323,8 +323,12 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 			return true;
 	}
 
-	if (map_func != pcifunc)
+	if (map_func != pcifunc) {
+		dev_err(rvu->dev,
+			"pcifunc %x map pcifunc %x not equal, lvl=%u schq=%u\n",
+			pcifunc, map_func, lvl, schq);
 		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index ca73a94db794..b0b9e273e06c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -614,6 +614,76 @@ void otx2_get_mac_from_af(struct net_device *netdev)
 }
 EXPORT_SYMBOL(otx2_get_mac_from_af);
 
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *req;
+	int err, smq;
+
+	smq = otx2_get_smq_idx(pfvf, 0);
+
+	mutex_lock(&mbox->lock);
+	req = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return -ENOMEM;
+	}
+
+	req->lvl = NIX_TXSCH_LVL_MDQ;
+	req->num_regs = 2;
+
+	req->reg[0] = NIX_AF_MDQX_PIR(smq);
+	req->regval[0] = 0;
+
+	req->reg[1] = NIX_AF_MDQX_CIR(smq);
+	req->regval[1] = 0;
+
+	err = otx2_sync_mbox_msg(mbox);
+	mutex_unlock(&mbox->lock);
+	return err;
+}
+
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf,
+				 int txq, u64 minrate, u64 maxrate)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *req;
+	int err, smq, n = 0;
+	u64 rate;
+
+	if (!maxrate && !minrate)
+		return 0;
+
+	smq = otx2_get_smq_idx(pfvf, txq);
+
+	mutex_lock(&mbox->lock);
+	req = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return -ENOMEM;
+	}
+
+	req->lvl = NIX_TXSCH_LVL_MDQ;
+
+	if (maxrate) {
+		req->reg[n] = NIX_AF_MDQX_PIR(smq);
+		rate = otx2_convert_rate(maxrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
+		n++;
+	}
+	if (minrate) {
+		req->reg[n] = NIX_AF_MDQX_CIR(smq);
+		rate = otx2_convert_rate(minrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
+		n++;
+	}
+	req->num_regs = n;
+
+	err = otx2_sync_mbox_msg(mbox);
+	mutex_unlock(&mbox->lock);
+	return err;
+}
+
 int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for_pfc)
 {
 	u16 (*schq_list)[MAX_TXSCHQ_PER_FUNC];
@@ -650,7 +720,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 						(u64)hw->smq_link_type);
 		req->num_regs++;
 		/* MDQ config */
-		parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
+		if (pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED)
+			parent = schq_list[NIX_TXSCH_LVL_TL4][0];
+		else
+			parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
+
 		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
 		req->regval[1] = parent << 16;
 		req->num_regs++;
@@ -778,6 +852,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
 	}
 
+	if (pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..65687840d005 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -512,6 +512,7 @@ struct otx2_nic {
 #define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(18)
 #define OTX2_FLAG_PORT_UP			BIT_ULL(19)
 #define OTX2_FLAG_IPSEC_OFFLOAD_ENABLED		BIT_ULL(20)
+#define OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED	BIT_ULL(21)
 	u64			flags;
 	u64			*cq_op_addr;
 
@@ -1246,6 +1247,9 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf, int txq,
+				 u64 minrate, u64 maxrate);
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
 int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 40162b08014d..bce8a866b495 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -16,6 +16,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/ipv6.h>
+#include <net/pkt_sched.h>
 
 #include "cn10k.h"
 #include "otx2_common.h"
@@ -1595,6 +1596,110 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 					  nic, nic, ingress);
 }
 
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+
+	if (!if_up) {
+		netdev_err(netdev, "mqprio: clear requires interface UP\n");
+		return -EOPNOTSUPP;
+	}
+
+	pfvf->flags &= ~OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED;
+	otx2_stop(pfvf->netdev);
+	otx2_open(pfvf->netdev);
+
+	otx2_nix_tm_clear_queue_shaper(pfvf);
+
+	qopt->hw = 0;
+	netdev_set_num_tc(netdev, 0);
+
+	return 0;
+}
+
+static int otx2_setup_tc_mqprio(struct net_device *netdev,
+				struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	bool if_up = netif_running(netdev);
+	int tc, txq, err, i;
+
+	if (!if_up) {
+		netdev_err(netdev, "mqprio: setup requires interface UP\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!qopt->hw) {
+		otx2_teardown_tc_mqprio(pfvf, mqprio);
+		return 0;
+	}
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+		netdev_err(netdev, "Unsupported mqprio shaper %#x\n", mqprio->shaper);
+		return -EOPNOTSUPP;
+	}
+
+	if (qopt->num_tc > pfvf->hw.non_qos_queues) {
+		netdev_err(netdev, "Number of TCs (%u) exceeds hw queues %u\n",
+			   qopt->num_tc, pfvf->hw.non_qos_queues);
+		return -EINVAL;
+	}
+
+	pfvf->flags |= OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED;
+
+	otx2_stop(pfvf->netdev);
+	otx2_open(pfvf->netdev);
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = mqprio->min_rate[tc];
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = mqprio->max_rate[tc];
+
+		if (min_rate && max_rate && min_rate > max_rate) {
+			otx2_teardown_tc_mqprio(pfvf, mqprio);
+			netdev_err(netdev,
+				   "min_rate %llu exceeds max_rate %llu for tc %d\n",
+				   min_rate, max_rate, tc);
+			return -EINVAL;
+		}
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qopt->count[tc]; txq++) {
+			if (txq >= netdev->real_num_tx_queues) {
+				otx2_teardown_tc_mqprio(pfvf, mqprio);
+				return -EINVAL;
+			}
+
+			netdev_dbg(netdev,
+				   "mqprio: tc %d txq %d min_rate %llu max_rate %llu\n",
+				   tc, txq, min_rate, max_rate);
+
+			err = otx2_nix_tm_set_queue_shaper(pfvf, txq,
+							   min_rate, max_rate);
+			if (err)
+				goto cleanup;
+		}
+	}
+
+	netdev_set_num_tc(netdev, qopt->num_tc);
+	for (i = 0; i < qopt->num_tc; i++)
+		netdev_set_tc_queue(netdev, i, qopt->count[i], qopt->offset[i]);
+
+	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+	return 0;
+
+cleanup:
+	otx2_teardown_tc_mqprio(pfvf, mqprio);
+	return err;
+}
+
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data)
 {
@@ -1603,6 +1708,8 @@ int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		return otx2_setup_tc_block(netdev, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return otx2_setup_tc_htb(netdev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return otx2_setup_tc_mqprio(netdev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.43.0

