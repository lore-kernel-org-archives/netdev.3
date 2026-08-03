Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB02F290A;
	Mon,  3 Aug 2026 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785731266; cv=none; b=jqBIf7BR0g3+yjFlyFy1PXX7V1Uf6TKaucpm5hYrNEMTewlJjsLr/LR+5atBdigCeaOdFyugrVICfv1dFVmfy2k5o5UkHa0f0//HR1lEaLhsWB1gSNau7zxAM79oIma+fR8NcF/RxCySZrVc4mK8AugaviUbS6k+8y2rHDPMptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785731266; c=relaxed/simple;
	bh=APoZOztRInskNm4D32ckFRU/mkpOwrGJXKDyYXi7sq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CYhDNbzCGDUFSI/iSD0fc43IETAh4y8TvIzmHqcLLpRjj4YkQ2WuGkJIL0jELfPMHyVVh1D5zKJxDlpTTAjYpO7qwzL/twFa5TbE2uVpEu7WiUcFwOCNkgrOa6LOsWYvflHUzyJ9xMn+LY/NNHzYeHXE2MOI6RsIPpwXMZLEebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TYxXgUpQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TYxXgUpQ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672NCR1k1649812;
	Sun, 2 Aug 2026 21:27:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=79yxldWWGj+EJKa/SSSpmnZ
	6ujmPxEHIlf8At4LT6M4=; b=TYxXgUpQ8tK61Rd3kluhE7qR2Mj0fGNstBAoj4O
	Anmtenlrkb6ADiMT1d9e6+AE2dBx5V5/NyfMn/d+8vz4QqpuuU67nHVzeRHvx8eV
	UFrjJfvOU2u4rhA+qX1NG/RsADssjl54LVCuLw75UDEunMvzZOTT1OFb35ucDtan
	TzmOP6MdqOqDlk4ByYmYj942o/mFV3FO72UJWPtBIvf+cOeAnhSo8oDG/U2Hwzan
	mZQZl3jjz8dNaa6ZDFllyJAA5w/Vq0xMnvOMiyOOqRN3n/FUqcxJpKjpBvYBP6pZ
	t+7utW2FOIl14btm3CbdwjOUn18X52ylKMvTmMwMd6Vo0ag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fsgag34uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 21:27:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 2 Aug 2026 21:27:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 2 Aug 2026 21:27:30 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 28D363F703F;
	Sun,  2 Aug 2026 21:27:26 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Mon, 3 Aug 2026 09:57:24 +0530
Message-ID: <20260803042724.3380209-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sC4ZELvDoNNiY_gdVn2Dq-h-_f3R1xxc
X-Authority-Analysis: v=2.4 cv=GaYnWwXL c=1 sm=1 tr=0 ts=6a7018b3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=ZIZyrjxQKP_gZefikeYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAzNSBTYWx0ZWRfX2tkTKF6CYzH2
 CD/YlqKQPg1RhQFEEjgtgBmX8fHLiiJ6RzkbEXXCMLwg+LoOJENYnsVmINv6K8JpfTjfgEqQ3PL
 yuo8rxvjVgLYtnLy2Iz9DniY5dDEOXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAzNSBTYWx0ZWRfX7oK8BEGfdsbc
 dfhcDZYc25d8znbjoLJALtZloKP8zNmS3PPdUEhno6CmMseUNKzWyhRi8rUYFZF1DM1O66MhDRi
 OfZC8vLPFCOROI2ZW+ezy4xjvLlG/MeGe2fuLvvgezB5xv/EOaK6AbJ5Yy+EPdsck4Yveu3RyGk
 YbzNWA8fn3hzIaf7lmW93rWusMsH8vYnYf7JxOpY+yaJMUj99rlbVdsB6+gVEvJ9QsRWDkB5oeP
 3jC06DSprJv3IrRmEuTfyHB5cfkcsdDWgl1YV5r7c4PaK0uscYSrZJYxFddBveZ+Itcjap/gRjD
 NjWqiZLATLkw6h6AqyhALf//cBqba/Wu0mXkUPa9fIyShCVKhDUfdBJDqH1PThHYztWd71f+x63
 YxMg8HjY/WHy8BlTynoChCFNhSdU4KK+ZlcPJzj8w+9KqvH/mLvUXHg/Q4rgUQj8m19w3snHeaC
 DuM8Wm6BRM00iuy0Kow==
X-Proofpoint-ORIG-GUID: sC4ZELvDoNNiY_gdVn2Dq-h-_f3R1xxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

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

v3 -> v4: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260729105139.2302908-1-rkannoth@marvell.com/
v2 -> v3: Addressed sashiko comments
	https://lore.kernel.org/netdev/amnYX866mYx02cBe@rkannoth-OptiPlex-7090/T/#m67310cbec48b21c7720858ab3a1ea083a0f8dc10
v1 -> v2: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260724075010.2665758-1-rkannoth@marvell.com/
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 142 +++++++++++++-
 .../marvell/octeontx2/nic/otx2_common.h       |   5 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 180 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  12 ++
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |   1 +
 7 files changed, 347 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index b81c47ea023b..22f64c1ede91 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -331,8 +331,12 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 			return true;
 	}
 
-	if (map_func != pcifunc)
+	if (map_func != pcifunc) {
+		dev_err_ratelimited(rvu->dev,
+				    "pcifunc %x map pcifunc %x not equal, lvl=%u schq=%u\n",
+				    pcifunc, map_func, lvl, schq);
 		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index ca73a94db794..ad83ab3b75fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -614,6 +614,139 @@ void otx2_get_mac_from_af(struct net_device *netdev)
 }
 EXPORT_SYMBOL(otx2_get_mac_from_af);
 
+static int
+otx2_nix_tmq_reg_write(struct otx2_nic *pfvf, int cnt,
+		       u64 reg_addr[MAX_REGS_PER_MBOX_MSG],
+		       u64 reg_val[MAX_REGS_PER_MBOX_MSG])
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *req;
+	int i, err;
+
+	mutex_lock(&mbox->lock);
+	req = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return -ENOMEM;
+	}
+
+	req->lvl = NIX_TXSCH_LVL_MDQ;
+	req->num_regs = cnt;
+
+	for (i = 0; i < cnt; i++) {
+		req->reg[i] = reg_addr[i];
+		req->regval[i] = reg_val[i];
+	}
+
+	err = otx2_sync_mbox_msg(mbox);
+	mutex_unlock(&mbox->lock);
+
+	return err;
+}
+
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf)
+{
+	u64 reg_addr[MAX_REGS_PER_MBOX_MSG];
+	u64 reg_val[MAX_REGS_PER_MBOX_MSG];
+	DECLARE_BITMAP(slots, 2048);
+	int err, smq, q, cnt = 0;
+
+	bitmap_zero(slots, 2048);
+
+	for (q = 0; q < pfvf->hw.non_qos_queues; q++) {
+		smq = otx2_get_smq_idx(pfvf, q);
+		if (test_bit(smq, slots))
+			continue;
+
+		reg_addr[cnt] = NIX_AF_MDQX_PIR(smq);
+		reg_val[cnt] = 0;
+		cnt++;
+
+		reg_addr[cnt] = NIX_AF_MDQX_CIR(smq);
+		reg_val[cnt] = 0;
+		cnt++;
+
+		set_bit(smq, slots);
+
+		if (cnt < MAX_REGS_PER_MBOX_MSG - 1)
+			continue;
+
+		err = otx2_nix_tmq_reg_write(pfvf, cnt,
+					     reg_addr, reg_val);
+		if (err)
+			goto fail;
+		cnt = 0;
+	}
+
+	if (cnt) {
+		err = otx2_nix_tmq_reg_write(pfvf, cnt,
+					     reg_addr, reg_val);
+		if (err)
+			goto fail;
+	}
+
+	return 0;
+fail:
+	return err;
+}
+
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf,
+				 int txq, u64 minrate, u64 maxrate)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *req;
+	int err, smq, n = 0;
+	u64 reg_addr[2];
+	u64 reg_val[2];
+	u64 rate;
+
+	if (!maxrate && !minrate) {
+		smq = otx2_get_smq_idx(pfvf, txq);
+		reg_addr[0] = NIX_AF_MDQX_PIR(smq);
+		reg_val[0] = 0;
+		reg_addr[1] = NIX_AF_MDQX_CIR(smq);
+		reg_val[1] = 0;
+		return otx2_nix_tmq_reg_write(pfvf, 2, reg_addr, reg_val);
+	}
+
+	/* CIR shaping needs CIR+PIR support, unsupported on OTX2/96xx */
+	if (minrate &&
+	    !test_bit(QOS_CIR_PIR_SUPPORT, &pfvf->hw.cap_flag))
+		return -EOPNOTSUPP;
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
+	/* Don't configure CIR when both CIR+PIR not supported
+	 * On 96xx, CIR + PIR + RED_ALGO=STALL causes deadlock
+	 */
+	if (minrate && test_bit(QOS_CIR_PIR_SUPPORT, &pfvf->hw.cap_flag)) {
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
@@ -650,7 +783,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
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
@@ -778,6 +915,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
 	}
 
+	if (pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..7ad29c5833cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -512,6 +512,7 @@ struct otx2_nic {
 #define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(18)
 #define OTX2_FLAG_PORT_UP			BIT_ULL(19)
 #define OTX2_FLAG_IPSEC_OFFLOAD_ENABLED		BIT_ULL(20)
+#define OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED	BIT_ULL(21)
 	u64			flags;
 	u64			*cq_op_addr;
 
@@ -1246,6 +1247,10 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf, int txq,
+				 u64 minrate, u64 maxrate);
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf);
+void otx2_mqprio_down(struct otx2_nic *pfvf);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
 int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..aa1936a50256 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2158,6 +2158,9 @@ int otx2_stop(struct net_device *netdev)
 	if (pf->flags & OTX2_FLAG_INTF_DOWN)
 		return 0;
 
+	/* Mqprio offload is not preserved across stop; user must reconfigure. */
+	otx2_mqprio_down(pf);
+
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 0b46ec29e64e..d83305d499b4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -16,6 +16,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/ipv6.h>
+#include <net/pkt_sched.h>
 
 #include "cn10k.h"
 #include "otx2_common.h"
@@ -1598,6 +1599,183 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 					  nic, nic, ingress);
 }
 
+/* Tear down mqprio bandwidth offload: clear per-queue shapers, TC
+ * mappings, and the rate-limit flag. Invoked from otx2_stop() when the
+ * interface is brought down, so mqprio offload state does not survive an
+ * administrative link toggle (e.g. ip link set dev X down/up). Users must
+ * reapply the mqprio qdisc after bringing the interface back up; the driver
+ * does not preserve or restore this configuration across stop/open.
+ */
+void otx2_mqprio_down(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+
+	if (!(pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED))
+		return;
+
+	otx2_nix_tm_clear_queue_shaper(pfvf);
+	pfvf->flags &= ~OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED;
+	netdev_set_num_tc(netdev, 0);
+}
+
+static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	int err;
+
+	err = otx2_stop(netdev);
+	if (err)
+		return err;
+
+	/* Set before otx2_open() so otx2_txsch_alloc() widens SMQ allocation. */
+	if (rate_limit)
+		pfvf->flags |= OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED;
+
+	err = otx2_open(netdev);
+	if (err) {
+		netdev_err(netdev,
+			   "Failed to restart device after mqprio change: %d\n",
+			   err);
+		otx2_mqprio_down(pfvf);
+		/* Caller holds netdev/RTNL lock; dev_close() would deadlock. */
+		netif_close(netdev);
+	}
+
+	return err;
+}
+
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+	int err;
+
+	otx2_mqprio_down(pfvf);
+
+	qopt->hw = 0;
+
+	if (if_up) {
+		err = otx2_mqprio_restart_netdev(netdev, false);
+		if (err)
+			return err;
+	}
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
+	if (!qopt->hw)
+		return otx2_teardown_tc_mqprio(pfvf, mqprio);
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+		netdev_err(netdev, "Unsupported mqprio shaper %#x\n", mqprio->shaper);
+		return -EOPNOTSUPP;
+	}
+
+	if (is_otx2_sdp_rep(pfvf->pdev)) {
+		netdev_err(netdev, "mqprio: bandwidth offload not supported on SDP rep\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (otx2_qos_htb_active(pfvf)) {
+		netdev_err(netdev, "mqprio: cannot enable offload while HTB is active\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (qopt->num_tc > pfvf->hw.non_qos_queues) {
+		netdev_err(netdev, "Number of TCs (%u) exceeds hw queues %u\n",
+			   qopt->num_tc, pfvf->hw.non_qos_queues);
+		return -EINVAL;
+	}
+
+	if (pfvf->hw.non_qos_queues > MAX_TXSCHQ_PER_FUNC) {
+		netdev_err(netdev,
+			   "Number of queues (%u) exceeds max scheduler queues %u\n",
+			   pfvf->hw.non_qos_queues, MAX_TXSCHQ_PER_FUNC);
+		return -EINVAL;
+	}
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+
+		if (qopt->count[tc] > 1) {
+			netdev_err(netdev,
+				   "mqprio: TC %d has %u queues, only one queue per TC is supported\n",
+				   tc, qopt->count[tc]);
+			return -EINVAL;
+		}
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = mqprio->min_rate[tc];
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = mqprio->max_rate[tc];
+
+		if (min_rate && max_rate && min_rate > max_rate) {
+			netdev_err(netdev,
+				   "min_rate %llu exceeds max_rate %llu for tc %d\n",
+				   min_rate, max_rate, tc);
+			return -EINVAL;
+		}
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qopt->count[tc]; txq++) {
+			if (txq >= netdev->real_num_tx_queues)
+				return -EINVAL;
+		}
+	}
+
+	err = otx2_mqprio_restart_netdev(pfvf->netdev, true);
+	if (err)
+		return err;
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = mqprio->min_rate[tc];
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = mqprio->max_rate[tc];
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qopt->count[tc]; txq++) {
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
+
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
@@ -1606,6 +1784,8 @@ int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		return otx2_setup_tc_block(netdev, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return otx2_setup_tc_htb(netdev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return otx2_setup_tc_mqprio(netdev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..a726f00d9388 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -1729,11 +1729,23 @@ void otx2_qos_config_txschq(struct otx2_nic *pfvf)
 	otx2_qos_root_destroy(pfvf);
 }
 
+bool otx2_qos_htb_active(struct otx2_nic *pfvf)
+{
+	return otx2_sw_node_find(pfvf, OTX2_QOS_ROOT_CLASSID);
+}
+
 int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb)
 {
 	struct otx2_nic *pfvf = netdev_priv(ndev);
 	int res;
 
+	if ((pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED) &&
+	    htb->command != TC_HTB_DESTROY) {
+		NL_SET_ERR_MSG_MOD(htb->extack,
+				   "HTB offload cannot be used with mqprio bandwidth offload active");
+		return -EOPNOTSUPP;
+	}
+
 	switch (htb->command) {
 	case TC_HTB_CREATE:
 		return otx2_qos_root_add(pfvf, htb->parent_classid,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
index 221bd0438f60..c777cc42eac9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
@@ -23,6 +23,7 @@ enum qos_smq_operations {
 u64 otx2_get_txschq_rate_regval(struct otx2_nic *nic, u64 maxrate, u32 burst);
 
 int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb);
+bool otx2_qos_htb_active(struct otx2_nic *pfvf);
 int otx2_qos_get_qid(struct otx2_nic *pfvf);
 void otx2_qos_free_qid(struct otx2_nic *pfvf, int qidx);
 int otx2_qos_enable_sq(struct otx2_nic *pfvf, int qidx);
-- 
2.43.0

