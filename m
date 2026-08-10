Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A290282F06;
	Mon, 10 Aug 2026 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786333679; cv=none; b=PxgtJwbUdXWruc+UKlw1S2rq2CWR0p+CZfW3BHYBuErxyKml/FKt3wYe+4K+mtYiD/kpTLLidvznU2WHXu6azidOFMzNAbjLzOKUoXDKOIVtINj8jUc5KmY4n5m08sl4VdP1I0pbl5A6+1HwOBKJOgiamEeDRSxHQ8ptscqFUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786333679; c=relaxed/simple;
	bh=FjPxCOy4Mo1nP5M7L7WaLEaLDyksHjeESPZsAEms1uE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMTqWWSzZz84M6jCPe62ZTZTS5HVdmu2D5YhAXv36YeClhqLroavVjmUKClNe1t//yJ9JtsGCus2PJoATxbeh00mVHQQA5fEF91hKMOrBWACcREcpyLaUQJpOsY1gM8akgxj7nHEuQ7W4eyMdcws+4LMgd2m9y1J1ToCe+39Rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Kmc41CMK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Kmc41CMK"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A0WndY360579;
	Sun, 9 Aug 2026 20:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=i2gVEZTDfkubFG/pFS34zbO
	dvcAFGJ3MdB1usGcK1t8=; b=Kmc41CMKUyShmiIAw8UYF+PGgKFDO6XKkiNug7G
	h0RpRS/Hxzp36VRrbOGiZbTt2af3Ox1bLqXt5wWF04Na8Tea9k8EgWdvVXC4iCAN
	97QCdyjuPeGJKziCsEuFp60eMd59M7pkBV74vQzQ8dkUa6DLkEoEiOSU89Hpi53O
	pftRnvAb0m6Fp+1O8PpzsnHmamqjrKPyC1E28PVYHEHqnDv2dzT66WeSAen33DL1
	7UpSRPSb87H+bHtfm3QB6IfNTt1ME/U9zVOKpPsxvZa/0/SbrSlj7xTSsm/jOvxt
	1NtOPGWbqnEf+ElyB0IP3TPg/LDDw4J+FO/iFW5NOjpy/vA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fxn78hc2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 20:47:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 9 Aug 2026 20:47:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 9 Aug 2026 20:47:43 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8978D5B693B;
	Sun,  9 Aug 2026 20:47:40 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v6 net-next] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
Date: Mon, 10 Aug 2026 09:17:38 +0530
Message-ID: <20260810034738.1786029-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyNyBTYWx0ZWRfX5mGYNhN8CJwL
 OA2wbikwXEpEbUvWg+h4YGFRLszpRbc+ZJU5c3kcWGpkBF55tOjSqjJqPcWESpLWhTPPRlqquLJ
 Hd9MMnufV5e7L5HIBbVmGmN5WF7+yNUhv+CsWgAjXQdDCpUSFAfJ6a8qDutgpCOev8o8aOJzipz
 1G7b10OCdAy+fYP16bLIlYhZKEeK5Hqbqn91rT6AcRYXspOh9vLfq+GnOWDi8zrprJc8JLTiM1e
 bKBUHhVB8NoJuwV2fUKdYY0BmZQxCwGHaR8vmi6zVrHbKZbFgcDIVODzGfTRsfgqcRjBG/9juT0
 +Llf2HdVPREL1vKNf83OzqxbTMbJzmKQIv/Ifjx5zh47C6Xt1hrKXMaYxJDAoCtSzL8uB/2vOJV
 GMB8+gcl0GlynASkyjTMeurfxbIMptgG9rS1CaX880fjVAG1yOBYgREtpYE2AEPVUD0VM8iM9jN
 4zrUrS7h+gr7tLsJYJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyNyBTYWx0ZWRfX8SJqpf+dQ3tW
 k4YQpW6qYQ64uIl3zZYwF3QquLLw2HnAKwjvJxUVezPeZuLh8O67oT5+QN7q+mwZNvDq789qjpT
 if91sZcGokXLqbA4QXTzSjJ1drxQ77A=
X-Proofpoint-GUID: ng--cgu5GzUh27aAml4fWV0XKRYK1yEi
X-Proofpoint-ORIG-GUID: ng--cgu5GzUh27aAml4fWV0XKRYK1yEi
X-Authority-Analysis: v=2.4 cv=NIblPU6g c=1 sm=1 tr=0 ts=6a7949e1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=wa32tIMN8F0AGd3ddpcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01

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

v5 -> v6: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260806095434.1144397-1-rkannoth@marvell.com/
v4 -> v5: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260803042724.3380209-1-rkannoth%40marvell.com
v3 -> v4: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260729105139.2302908-1-rkannoth@marvell.com/
v2 -> v3: Addressed sashiko comments
	https://lore.kernel.org/netdev/amnYX866mYx02cBe@rkannoth-OptiPlex-7090/T/#m67310cbec48b21c7720858ab3a1ea083a0f8dc10
v1 -> v2: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260724075010.2665758-1-rkannoth@marvell.com/
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 145 +++++++-
 .../marvell/octeontx2/nic/otx2_common.h       |  10 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  11 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 332 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  15 +
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |   1 +
 9 files changed, 532 insertions(+), 2 deletions(-)

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
index ca73a94db794..c2b64a482036 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -614,6 +614,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)
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
+	int err, smq, i, cnt = 0;
+
+	for (i = 0; i < pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ]; i++) {
+		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][i];
+
+		reg_addr[cnt] = NIX_AF_MDQX_PIR(smq);
+		reg_val[cnt] = 0;
+		cnt++;
+
+		reg_addr[cnt] = NIX_AF_MDQX_CIR(smq);
+		reg_val[cnt] = 0;
+		cnt++;
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
+	/* MQPRIO exposes only min/max rate, not burst.  Pass burst 0 so
+	 * otx2_get_egress_burst_cfg() programmes the largest burst the NIX
+	 * encoding supports (CN10K_MAX_BURST_SIZE on CN10K).  This differs
+	 * from the 65536 byte default used in the HTB path, which is a
+	 * kernel-side default when no explicit burst is configured, not a
+	 * hardware cap.
+	 *
+	 * mqprio setup restarts the netdev (otx2_mqprio_restart_netdev),
+	 * which resets MDQ shapers to zero.  Program both PIR and CIR on
+	 * every update so omitted rates are applied explicitly rather than
+	 * relying on stale hardware state.
+	 */
+	req->reg[n] = NIX_AF_MDQX_PIR(smq);
+	if (maxrate) {
+		rate = otx2_convert_rate(maxrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
+	} else {
+		req->regval[n] = 0;
+	}
+	n++;
+
+	/* CIR+PIR support is required and checked at mqprio setup. */
+	req->reg[n] = NIX_AF_MDQX_CIR(smq);
+	if (minrate) {
+		rate = otx2_convert_rate(minrate);
+		req->regval[n] = otx2_get_txschq_rate_regval(pfvf, rate, 0);
+	} else {
+		req->regval[n] = 0;
+	}
+	n++;
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
@@ -650,7 +786,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
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
@@ -778,6 +918,9 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
 	}
 
+	if (pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED)
+		req->schq[NIX_TXSCH_LVL_SMQ] = pfvf->hw.non_qos_queues;
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..df175fb14951 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -512,9 +512,14 @@ struct otx2_nic {
 #define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(18)
 #define OTX2_FLAG_PORT_UP			BIT_ULL(19)
 #define OTX2_FLAG_IPSEC_OFFLOAD_ENABLED		BIT_ULL(20)
+#define OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED	BIT_ULL(21)
 	u64			flags;
 	u64			*cq_op_addr;
 
+	u32			mqprio_flags;
+	u64			*mqprio_min_rate;
+	u64			*mqprio_max_rate;
+
 	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
@@ -1246,6 +1251,11 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
+int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf, int txq,
+				 u64 minrate, u64 maxrate);
+int otx2_nix_tm_clear_queue_shaper(struct otx2_nic *pfvf);
+int otx2_mqprio_down(struct otx2_nic *pfvf);
+int otx2_mqprio_up(struct otx2_nic *pfvf);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
 int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index f110dfa42360..676f78d8fb34 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -413,6 +413,12 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 	u8 old_pfc_en;
 	int err;
 
+	if ((pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED) && pfc->pfc_en) {
+		netdev_err(dev,
+			   "PFC: cannot enable while mqprio bandwidth offload is active\n");
+		return -EOPNOTSUPP;
+	}
+
 	old_pfc_en = pfvf->pfc_en;
 	pfvf->pfc_en = pfc->pfc_en;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a0340f3422bf..50a31e4419ff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -287,6 +287,14 @@ static int otx2_set_channels(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if ((pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED) &&
+	    (channel->tx_count != pfvf->hw.tx_queues ||
+	     channel->rx_count != pfvf->hw.rx_queues)) {
+		netdev_info(dev,
+			    "Not permitted to change channel count while MQ prio is active\n");
+		return -EINVAL;
+	}
+
 	if (if_up)
 		dev->netdev_ops->ndo_stop(dev);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..d3533b7b5f9f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1980,6 +1980,10 @@ int otx2_open(struct net_device *netdev)
 	if (err)
 		goto err_free_mem;
 
+	err = otx2_mqprio_up(pf);
+	if (err)
+		goto err_free_hw;
+
 	/* Register NAPI handler */
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
@@ -2140,6 +2144,7 @@ int otx2_open(struct net_device *netdev)
 	free_irq(vec, pf);
 err_disable_napi:
 	otx2_disable_napi(pf);
+err_free_hw:
 	otx2_free_hw_resources(pf);
 err_free_mem:
 	otx2_free_queue_mem(qset);
@@ -2846,6 +2851,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
 	bool if_up = netif_running(pf->netdev);
 	struct bpf_prog *old_prog;
 
+	if (prog && (pf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED)) {
+		netdev_err(dev,
+			   "XDP: cannot attach while mqprio bandwidth offload is active\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (prog && dev->mtu > MAX_XDP_MTU) {
 		netdev_warn(dev, "Jumbo frames not yet supported with XDP\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 039fd47ebf52..a71c80588086 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -16,6 +16,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/ipv6.h>
+#include <net/pkt_sched.h>
 
 #include "cn10k.h"
 #include "otx2_common.h"
@@ -61,6 +62,9 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 			*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
 		}
 	} else {
+		/* burst 0: largest encodable burst (CN10K_MAX_BURST_SIZE on
+		 * CN10K), not a minimal burst.
+		 */
 		*burst_exp = MAX_BURST_EXPONENT;
 		*burst_mantissa = max_mantissa;
 	}
@@ -1600,14 +1604,342 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 					  nic, nic, ingress);
 }
 
+/* Tear down mqprio bandwidth offload: clear per-queue shapers, TC
+ * mappings, and the rate-limit flag. Used on explicit mqprio teardown
+ * (tc qdisc del), not on internal stop/open cycles such as MTU change.
+ */
+static void otx2_mqprio_free_cache(struct otx2_nic *pfvf)
+{
+	devm_kfree(pfvf->dev, pfvf->mqprio_min_rate);
+	devm_kfree(pfvf->dev, pfvf->mqprio_max_rate);
+	pfvf->mqprio_min_rate = NULL;
+	pfvf->mqprio_max_rate = NULL;
+	pfvf->mqprio_flags = 0;
+}
+
+static int otx2_mqprio_alloc_cache(struct otx2_nic *pfvf)
+{
+	u16 num_txq = pfvf->hw.non_qos_queues;
+
+	otx2_mqprio_free_cache(pfvf);
+
+	pfvf->mqprio_min_rate = devm_kcalloc(pfvf->dev, num_txq,
+					     sizeof(*pfvf->mqprio_min_rate),
+					     GFP_KERNEL);
+	pfvf->mqprio_max_rate = devm_kcalloc(pfvf->dev, num_txq,
+					     sizeof(*pfvf->mqprio_max_rate),
+					     GFP_KERNEL);
+	if (!pfvf->mqprio_min_rate || !pfvf->mqprio_max_rate) {
+		otx2_mqprio_free_cache(pfvf);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static bool otx2_txschq_is_allocated(struct otx2_nic *pfvf)
+{
+	int lvl, idx;
+
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		for (idx = 0; idx < pfvf->hw.txschq_cnt[lvl]; idx++) {
+			if (pfvf->hw.txschq_list[lvl][idx])
+				return true;
+		}
+	}
+
+	return false;
+}
+
+int otx2_mqprio_down(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+	int err = 0;
+
+	if (!(pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED))
+		return 0;
+
+	if (otx2_txschq_is_allocated(pfvf))
+		err = otx2_nix_tm_clear_queue_shaper(pfvf);
+
+	pfvf->flags &= ~OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED;
+	netdev_set_num_tc(netdev, 0);
+	otx2_mqprio_free_cache(pfvf);
+
+	return err;
+}
+
+int otx2_mqprio_up(struct otx2_nic *pfvf)
+{
+	struct net_device *netdev = pfvf->netdev;
+	int txq, err;
+
+	if (!(pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED))
+		return 0;
+
+	if (!pfvf->mqprio_min_rate || !pfvf->mqprio_max_rate)
+		return 0;
+
+	for (txq = 0; txq < pfvf->hw.non_qos_queues; txq++) {
+		u64 min_rate = 0, max_rate = 0;
+
+		if (pfvf->mqprio_flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = pfvf->mqprio_min_rate[txq];
+		if (pfvf->mqprio_flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = pfvf->mqprio_max_rate[txq];
+
+		if (!min_rate && !max_rate)
+			continue;
+
+		err = otx2_nix_tm_set_queue_shaper(pfvf, txq, min_rate,
+						   max_rate);
+		if (err) {
+			netdev_err(netdev,
+				   "mqprio: failed to restore shaper for txq %d: %d\n",
+				   txq, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/* Restart the netdev to reprogram the TX scheduler hierarchy for mqprio
+ * bandwidth offload.  Both mqprio add and delete (when offload was active)
+ * take this path via ndo_stop()/ndo_open() so VF-specific open logic (e.g.
+ * LBK carrier on) runs correctly.  The full stop/open cycle clears
+ * carrier, stops all TX queues, tears down IRQs/NAPI and drops in-flight
+ * traffic.  If open fails, netif_close() clears IFF_UP and leaves the
+ * interface administratively down.
+ */
+static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
+{
+	struct otx2_nic *pfvf = netdev_priv(netdev);
+	const struct net_device_ops *ops = netdev->netdev_ops;
+	int err;
+
+	netdev_info(netdev,
+		    "mqprio: restarting interface to reprogram TX scheduler; in-flight traffic will be dropped\n");
+
+	err = ops->ndo_stop(netdev);
+	if (err)
+		return err;
+
+	/* Set before ndo_open() so otx2_txsch_alloc() widens SMQ allocation. */
+	if (rate_limit)
+		pfvf->flags |= OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED;
+
+	err = ops->ndo_open(netdev);
+	if (err) {
+		int down_err;
+
+		netdev_err(netdev,
+			   "Failed to restart device after mqprio change: %d\n",
+			   err);
+		down_err = otx2_mqprio_down(pfvf);
+		if (down_err)
+			netdev_err(netdev,
+				   "mqprio: failed to clear shapers after restart error: %d\n",
+				   down_err);
+		/* Caller holds netdev/RTNL lock; dev_close() would deadlock. */
+		netif_close(netdev);
+	}
+
+	return err;
+}
+
+static u64 otx2_mqprio_per_queue_rate(u64 rate, u32 qcount)
+{
+	if (!rate || qcount <= 1)
+		return rate;
+
+	return div_u64(rate, qcount);
+}
+
+static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	bool had_mqprio = !!(pfvf->flags & OTX2_FLAG_PER_Q_RATE_LIMIT_ENABLED);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *netdev = pfvf->netdev;
+	bool if_up = netif_running(netdev);
+	int down_err, err;
+
+	qopt->hw = 0;
+
+	/* Skip the netdev restart when mqprio offload was not active. */
+	if (!had_mqprio)
+		return 0;
+
+	down_err = otx2_mqprio_down(pfvf);
+
+	if (if_up) {
+		err = otx2_mqprio_restart_netdev(netdev, false);
+		if (err)
+			return err;
+	}
+
+	return down_err;
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
+	if (!qopt->hw)
+		return otx2_teardown_tc_mqprio(pfvf, mqprio);
+
+	if (!if_up) {
+		netdev_err(netdev, "mqprio: setup requires interface UP\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
+		netdev_err(netdev, "Unsupported mqprio shaper %#x\n", mqprio->shaper);
+		return -EOPNOTSUPP;
+	}
+
+	if (!test_bit(QOS_CIR_PIR_SUPPORT, &pfvf->hw.cap_flag)) {
+		netdev_err(netdev,
+			   "mqprio: bandwidth offload requires CIR+PIR support\n");
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
+	if (pfvf->pfc_en) {
+		netdev_err(netdev,
+			   "mqprio: cannot enable offload while PFC is enabled\n");
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
+	err = otx2_mqprio_alloc_cache(pfvf);
+	if (err)
+		goto cleanup;
+
+	pfvf->mqprio_flags = mqprio->flags;
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		u64 min_rate = 0, max_rate = 0;
+		u32 qcount = qopt->count[tc];
+
+		/* Rates omitted from tc mqprio are passed as zero and both MDQ
+		 * shaper registers are programmed; see
+		 * otx2_nix_tm_set_queue_shaper().
+		 */
+		if (mqprio->flags & TC_MQPRIO_F_MIN_RATE)
+			min_rate = otx2_mqprio_per_queue_rate(mqprio->min_rate[tc],
+							      qcount);
+		if (mqprio->flags & TC_MQPRIO_F_MAX_RATE)
+			max_rate = otx2_mqprio_per_queue_rate(mqprio->max_rate[tc],
+							      qcount);
+
+		for (txq = qopt->offset[tc];
+		     txq < qopt->offset[tc] + qcount; txq++) {
+			netdev_dbg(netdev,
+				   "mqprio: tc %d txq %d min_rate %llu max_rate %llu\n",
+				   tc, txq, min_rate, max_rate);
+
+			pfvf->mqprio_min_rate[txq] = min_rate;
+			pfvf->mqprio_max_rate[txq] = max_rate;
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
+static int otx2_setup_tc_query_caps(void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+	struct tc_mqprio_caps *caps;
+
+	if (base->type != TC_SETUP_QDISC_MQPRIO)
+		return -EOPNOTSUPP;
+
+	caps = base->caps;
+	caps->validate_queue_counts = true;
+
+	return 0;
+}
+
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data)
 {
 	switch (type) {
+	case TC_QUERY_CAPS:
+		return otx2_setup_tc_query_caps(type_data);
 	case TC_SETUP_BLOCK:
 		return otx2_setup_tc_block(netdev, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return otx2_setup_tc_htb(netdev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return otx2_setup_tc_mqprio(netdev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..0fa5c65d6221 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -118,6 +118,9 @@ static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
 	/* configure PIR */
 	maxrate = (node->rate > node->ceil) ? node->rate : node->ceil;
 
+	/* 65536 is the kernel-side default burst when HTB does not supply an
+	 * explicit value, not the NIX hardware maximum (CN10K_MAX_BURST_SIZE).
+	 */
 	cfg->regval[*num_regs] =
 		otx2_get_txschq_rate_regval(pfvf, maxrate, 65536);
 	(*num_regs)++;
@@ -1729,11 +1732,23 @@ void otx2_qos_config_txschq(struct otx2_nic *pfvf)
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

