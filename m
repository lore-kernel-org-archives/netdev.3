Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850356;
	b=ATO4O2ZhXNpcln7cKXGqoRGLRieKQUS3+eDRwRtKxY8bAlyPrp2KB3ajKHLoOEmFL1Fc
	 UXcyOonnXW9A7H8l7D4zYX9smeYd+PN8KAGeFmmBdgyItqi7gmi72LN+aRTt/jFXZTQF6
	 Xv4fI7taVq6PYg8db86jZbyjkWdZlLPnld1gPrt0BC6t6QRtCfaMpoKokl8fPF67yrB8F
	 MPNX+0IJQw0K+DEdyJvJR1bNBkLIh6BR+E/7BI551L7x3EyM0UVsb0K6Z4qn/DZ4Vb3nr
	 Fu+iyeuHc9qhpcs1GyTS7H2XVng3kr//npoE/+MNKgGCZdrR6QEUbBbfzXkuMYySjig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850356;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LmG9Jbv5SahHA5VeOcSR1QY0RwFCc5jQA5Dh0iL0UAE=;
	b=5fFpBBY5ir79rc31E/SiWGFoGTBmBICrg7DtAxW8d9x4RsfoYZcC3rd16H6clss82bqy
	 4jN+Mp7T8hqTPIimbJHZBRzw46Umjtbq8FUpsKVzF6rRg5auenR0XfwAvJMkmy8bmJouj
	 ee+maftaUHnzkAC0Pqe7FCnAkSKpCkMV6snIenRXl71yxp4xUaM2OXYAZlosAa7mAM+mu
	 YM9MPZAdEr3J91jwV5BBEzrtV/tQWgKnr/D45uwWSLGy/AeiKlsxUyCt7I6Ihc1b0ZDtm
	 5IDLDWcXS3DIVQmNJW6jpU5d7Yy4bp89FRsPyNoGV/vsU9tST8BE8HmZZylQZKdCsaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F01606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F01606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj40002480;
	Wed, 4 Nov 2026 19:45:42 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 12/12] cxgb4: select ULD Tx and control queues by TID on T7
Date: Thu,  5 Nov 2026 08:15:49 -0500
Message-Id: <20261105131549.547554-13-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On T7 adapters with more than one uP core, TIDs are distributed over
core groups and a work request carrying a TID must be sent on an egress
queue allocated in the core group owning that TID. Firmware reports the
TID bits selecting the group through the TID_QID_SEL_MASK device
parameter.

 - Query TID_QID_SEL_MASK on T7 adapters with multiple cores and add
   helpers returning the number of core groups and the group of a TID.
 - Allocate the shared ULD offload Tx queues of each port round robin
   over the core groups, passing the group to firmware in
   FW_EQ_OFLD_CMD, with at least one queue per group and port.
 - Add cxgb4_uld_tid_qid_sel_update() and
   cxgb4_uld_tid_ctrlq_id_sel_update() for ULDs to move a connection's
   Tx and control queue to the TID's core group once the TID is known.
   Tx queues of a group are used round robin.
 - Send CPL_TID_RELEASE on the control queue of the TID's group.
   cxgb4_remove_tid() keeps taking a port, so ULDs that do not select
   queues by TID release TIDs on the right queue as well.
 - Control queues are now allocated num_up_cores per port. Route the
   completions of all of them to the RDMA response queue, stopping at
   the first failure, and pass num_up_cores to ULDs.

Without TID based queue selection, on T4 - T6 and single core T7, all
queues stay in group 0, the number of queues is unchanged and the
helpers leave queue indexes unchanged.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  28 +++-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  27 +++-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    | 140 +++++++++++++++---
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.h    |   5 +
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |  14 +-
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |   5 +
 6 files changed, 186 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index e6250e031609..ca208164a9c3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -903,6 +903,7 @@ struct sge_uld_txq {               /* state for an SGE offload Tx queue */
 	struct tasklet_struct qresume_tsk; /* restarts the queue */
 	bool service_ofldq_running; /* service_ofldq() is processing sendq */
 	u8 full;                    /* the Tx ring is full */
+	u8 tid_qid_group_id;        /* uP core group of the queue */
 	unsigned long mapping_err;  /* # of I/O MMU packet mapping errors */
 } ____cacheline_aligned_in_smp;
 
@@ -928,6 +929,7 @@ struct sge_uld_txq_info {
 	struct sge_uld_txq *uldtxq; /* Txq's for ULD */
 	atomic_t users;		/* num users */
 	u16 ntxq;		/* # of egress uld queues */
+	atomic_t *tid_qid_rr;	/* per port, per core group round robin */
 };
 
 /* struct to maintain ULD list to reallocate ULD resources on hotplug */
@@ -1503,6 +1505,30 @@ struct filter_entry {
 	struct ch_filter_specification fs;
 };
 
+static inline unsigned int cxgb4_tid_qid_ngroups(const struct adapter *adap)
+{
+	if (!adap->params.tid_qid_sel_mask)
+		return 1;
+	return (adap->params.tid_qid_sel_mask >>
+		adap->params.tid_qid_sel_shift) + 1;
+}
+
+static inline unsigned int cxgb4_tid_qid_group(const struct adapter *adap,
+					       u32 tid)
+{
+	return (tid & adap->params.tid_qid_sel_mask) >>
+	       adap->params.tid_qid_sel_shift;
+}
+
+static inline u16 cxgb4_tid_ctrlq_idx(const struct adapter *adap,
+				      unsigned int port, u32 tid)
+{
+	if (port >= adap->params.nports)
+		port = 0;
+	return port * adap->params.num_up_cores +
+	       cxgb4_tid_qid_group(adap, tid);
+}
+
 static inline int is_offload(const struct adapter *adap)
 {
 	return adap->params.offload;
@@ -1662,7 +1688,7 @@ int t4_sge_mod_ctrl_txq(struct adapter *adap, unsigned int eqid,
 			unsigned int cmplqid);
 int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
 			 struct net_device *dev, unsigned int iqid,
-			 unsigned int uld_type);
+			 unsigned int uld_type, u8 group);
 int t4_sge_alloc_ethofld_txq(struct adapter *adap, struct sge_eohw_txq *txq,
 			     struct net_device *dev, u32 iqid);
 void t4_sge_free_ethofld_txq(struct adapter *adap, struct sge_eohw_txq *txq);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 563a0ee1ce2c..7a004b2de9c1 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1749,13 +1749,15 @@ EXPORT_SYMBOL(cxgb4_free_stid);
 
 /*
  * Populate a TID_RELEASE WR.  Caller must properly size the skb.
+ * @chan is the port whose control queues are used.
  */
-static void mk_tid_release(struct sk_buff *skb, unsigned int chan,
-			   unsigned int tid)
+static void mk_tid_release(const struct adapter *adap, struct sk_buff *skb,
+			   unsigned int chan, unsigned int tid)
 {
 	struct cpl_tid_release *req;
 
-	set_wr_txq(skb, CPL_PRIORITY_SETUP, chan);
+	set_wr_txq(skb, CPL_PRIORITY_SETUP,
+		   cxgb4_tid_ctrlq_idx(adap, chan, tid));
 	req = __skb_put(skb, sizeof(*req));
 	INIT_TP_WR(req, tid);
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_TID_RELEASE, tid));
@@ -1806,7 +1808,7 @@ static void process_tid_release_list(struct work_struct *work)
 					 GFP_KERNEL)))
 			schedule_timeout_uninterruptible(1);
 
-		mk_tid_release(skb, chan, p - adap->tids.tid_tab);
+		mk_tid_release(adap, skb, chan, p - adap->tids.tid_tab);
 		t4_ofld_send(adap, skb);
 		spin_lock_bh(&adap->tid_release_lock);
 	}
@@ -1847,7 +1849,7 @@ void cxgb4_remove_tid(struct tid_info *t, unsigned int chan, unsigned int tid,
 
 	skb = alloc_skb(sizeof(struct cpl_tid_release), GFP_ATOMIC);
 	if (likely(skb)) {
-		mk_tid_release(skb, chan, tid);
+		mk_tid_release(adap, skb, chan, tid);
 		t4_ofld_send(adap, skb);
 	} else
 		cxgb4_queue_tid_release(t, chan, tid);
@@ -5453,6 +5455,21 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 		adap->vres.ddp.size = val[4] - val[3] + 1;
 		adap->params.ofldq_wr_cred = val[5];
 
+		/* On T7 with multiple uP cores, each TID is owned by one core
+		 * group and TID bound work requests must be sent on an egress
+		 * queue of that group.
+		 */
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7 &&
+		    adap->params.num_up_cores > 1) {
+			params[0] = FW_PARAM_DEV(TID_QID_SEL_MASK);
+			ret = t4_query_params(adap, adap->mbox, adap->pf, 0, 1,
+					      params, val);
+			if (!ret && val[0]) {
+				adap->params.tid_qid_sel_mask = val[0];
+				adap->params.tid_qid_sel_shift = ffs(val[0]) - 1;
+			}
+		}
+
 		if (caps_cmd.niccaps & htons(FW_CAPS_CONFIG_NIC_HASHFILTER)) {
 			init_hash_filter(adap);
 		} else {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
index 23244cdfc1bc..2be70ccb6a96 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
@@ -170,6 +170,28 @@ static int alloc_uld_rxqs(struct adapter *adap,
 	return err;
 }
 
+/* Route the completions of all control queues of @port to @cmplqid.
+ * Control queues are allocated num_up_cores per port.
+ */
+static int uld_set_ctrlq_cmplqid(struct adapter *adap, int port, u32 cmplqid)
+{
+	struct sge *s = &adap->sge;
+	int k, idx, ret = 0;
+	u32 param;
+
+	for (k = 0; k < adap->params.num_up_cores; k++) {
+		idx = port * adap->params.num_up_cores + k;
+		param = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DMAQ) |
+			 FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DMAQ_EQ_CMPLIQID_CTRL) |
+			 FW_PARAMS_PARAM_YZ_V(s->ctrlq[idx].q.cntxt_id));
+		ret = t4_set_params(adap, adap->mbox, adap->pf, 0, 1,
+				    &param, &cmplqid);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 static int
 setup_sge_queues_uld(struct adapter *adap, unsigned int uld_type, bool lro)
 {
@@ -182,18 +204,11 @@ setup_sge_queues_uld(struct adapter *adap, unsigned int uld_type, bool lro)
 
 	/* Tell uP to route control queue completions to rdma rspq */
 	if (adap->flags & CXGB4_FULL_INIT_DONE && uld_type == CXGB4_ULD_RDMA) {
-		struct sge *s = &adap->sge;
-		unsigned int cmplqid;
-		u32 param, cmdop;
-
-		cmdop = FW_PARAMS_PARAM_DMAQ_EQ_CMPLIQID_CTRL;
 		for_each_port(adap, i) {
-			cmplqid = rxq_info->uldrxq[i].rspq.cntxt_id;
-			param = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DMAQ) |
-				 FW_PARAMS_PARAM_X_V(cmdop) |
-				 FW_PARAMS_PARAM_YZ_V(s->ctrlq[i].q.cntxt_id));
-			ret = t4_set_params(adap, adap->mbox, adap->pf,
-					    0, 1, &param, &cmplqid);
+			ret = uld_set_ctrlq_cmplqid(adap, i,
+						    rxq_info->uldrxq[i].rspq.cntxt_id);
+			if (ret)
+				break;
 		}
 	}
 	return ret;
@@ -214,18 +229,10 @@ static void free_sge_queues_uld(struct adapter *adap, unsigned int uld_type)
 	struct sge_uld_rxq_info *rxq_info = adap->sge.uld_rxq_info[uld_type];
 
 	if (adap->flags & CXGB4_FULL_INIT_DONE && uld_type == CXGB4_ULD_RDMA) {
-		struct sge *s = &adap->sge;
-		u32 param, cmdop, cmplqid = 0;
 		int i;
 
-		cmdop = FW_PARAMS_PARAM_DMAQ_EQ_CMPLIQID_CTRL;
-		for_each_port(adap, i) {
-			param = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DMAQ) |
-				 FW_PARAMS_PARAM_X_V(cmdop) |
-				 FW_PARAMS_PARAM_YZ_V(s->ctrlq[i].q.cntxt_id));
-			t4_set_params(adap, adap->mbox, adap->pf,
-				      0, 1, &param, &cmplqid);
-		}
+		for_each_port(adap, i)
+			uld_set_ctrlq_cmplqid(adap, i, 0);
 	}
 
 	if (rxq_info->nciq)
@@ -428,10 +435,15 @@ alloc_sge_txq_uld(struct adapter *adap, struct sge_uld_txq_info *txq_info,
 	j = nq / adap->params.nports;
 	for (i = 0; i < nq; i++) {
 		struct sge_uld_txq *txq = &txq_info->uldtxq[i];
+		u8 group = 0;
+
+		/* Spread the queues of each port over all uP core groups */
+		if (uld_type == CXGB4_TX_OFLD)
+			group = (i % j) % cxgb4_tid_qid_ngroups(adap);
 
 		txq->q.size = 1024;
 		err = t4_sge_alloc_uld_txq(adap, txq, adap->port[i / j],
-					   s->fw_evtq.cntxt_id, uld_type);
+					   s->fw_evtq.cntxt_id, uld_type, group);
 		if (err)
 			goto freeout;
 	}
@@ -451,6 +463,7 @@ release_sge_txq_uld(struct adapter *adap, unsigned int uld_type)
 
 	if (txq_info && atomic_dec_and_test(&txq_info->users)) {
 		free_sge_txq_uld(adap, txq_info);
+		kfree(txq_info->tid_qid_rr);
 		kfree(txq_info->uldtxq);
 		kfree(txq_info);
 		adap->sge.uld_txq_info[tx_uld_type] = NULL;
@@ -487,6 +500,9 @@ setup_sge_txq_uld(struct adapter *adap, unsigned int uld_type,
 	} else {
 		i = min_t(int, uld_info->ntxq, num_online_cpus());
 		txq_info->ntxq = roundup(i, adap->params.nports);
+		/* Each port needs at least one queue per uP core group */
+		i = cxgb4_tid_qid_ngroups(adap) * adap->params.nports;
+		txq_info->ntxq = max_t(int, txq_info->ntxq, i);
 	}
 	txq_info->uldtxq = kzalloc_objs(struct sge_uld_txq, txq_info->ntxq);
 	if (!txq_info->uldtxq) {
@@ -494,7 +510,18 @@ setup_sge_txq_uld(struct adapter *adap, unsigned int uld_type,
 		return -ENOMEM;
 	}
 
+	if (tx_uld_type == CXGB4_TX_OFLD && adap->params.tid_qid_sel_mask) {
+		i = cxgb4_tid_qid_ngroups(adap) * adap->params.nports;
+		txq_info->tid_qid_rr = kcalloc(i, sizeof(atomic_t), GFP_KERNEL);
+		if (!txq_info->tid_qid_rr) {
+			kfree(txq_info->uldtxq);
+			kfree(txq_info);
+			return -ENOMEM;
+		}
+	}
+
 	if (alloc_sge_txq_uld(adap, txq_info, tx_uld_type)) {
+		kfree(txq_info->tid_qid_rr);
 		kfree(txq_info->uldtxq);
 		kfree(txq_info);
 		return -ENOMEM;
@@ -601,6 +628,7 @@ static void uld_init(struct adapter *adap, struct cxgb4_lld_info *lld)
 	lld->mtus = adap->params.mtus;
 	lld->nchan = adap->params.nports;
 	lld->nports = adap->params.nports;
+	lld->num_up_cores = adap->params.num_up_cores;
 	lld->wr_cred = adap->params.ofldq_wr_cred;
 	lld->crypto = adap->params.crypto;
 	lld->iscsi_iolen = MAXRXDATA_G(t4_read_reg(adap, TP_PARA_REG2_A));
@@ -783,6 +811,74 @@ void cxgb4_uld_enable(struct adapter *adap)
 	mutex_unlock(&uld_mutex);
 }
 
+/**
+ * cxgb4_uld_tid_ctrlq_id_sel_update - select the control queue for a TID
+ * @dev: net device of the adapter
+ * @tid: TID the work requests will carry
+ * @ctrlq_index: in: any control queue index of the port, normally the base
+ *		 index port * num_up_cores; out: the port's control queue in
+ *		 the uP core group owning @tid. Calling it again on the result
+ *		 is harmless.
+ *
+ * Work requests carrying a TID must be sent on a control queue of the
+ * core group owning the TID. Without TID based queue selection the index
+ * is left unchanged.
+ */
+void cxgb4_uld_tid_ctrlq_id_sel_update(struct net_device *dev, u32 tid,
+				       u16 *ctrlq_index)
+{
+	struct adapter *adap = netdev2adap(dev);
+
+	if (!adap->params.tid_qid_sel_mask)
+		return;
+
+	*ctrlq_index = cxgb4_tid_ctrlq_idx(adap,
+					   *ctrlq_index / adap->params.num_up_cores,
+					   tid);
+}
+EXPORT_SYMBOL(cxgb4_uld_tid_ctrlq_id_sel_update);
+
+/**
+ * cxgb4_uld_tid_qid_sel_update - select the offload Tx queue for a TID
+ * @dev: net device of the adapter
+ * @uld: ULD type
+ * @tid: TID the work requests will carry
+ * @qid: in: an index into the ULD offload Tx queue array of the port;
+ *	 out: the index of a queue of the port in the uP core group owning
+ *	 @tid. This is an index into the uldtxq[] array, as used by
+ *	 cxgb4_ofld_send(), not a hardware queue context id.
+ *
+ * The queues of a port in the TID's core group are used round robin.
+ * Without TID based queue selection the index is left unchanged.
+ */
+void cxgb4_uld_tid_qid_sel_update(struct net_device *dev, enum cxgb4_uld uld,
+				  u32 tid, u16 *qid)
+{
+	struct adapter *adap = netdev2adap(dev);
+	struct sge_uld_txq_info *txq_info;
+	unsigned int ngroups, per_port, port, group, n;
+
+	if (!adap->params.tid_qid_sel_mask)
+		return;
+
+	txq_info = adap->sge.uld_txq_info[TX_ULD(uld)];
+	if (!txq_info || !txq_info->tid_qid_rr)
+		return;
+
+	ngroups = cxgb4_tid_qid_ngroups(adap);
+	per_port = txq_info->ntxq / adap->params.nports;
+	port = *qid / per_port;
+	if (WARN_ON_ONCE(port >= adap->params.nports))
+		port = 0;
+	group = cxgb4_tid_qid_group(adap, tid);
+
+	/* Queue i of a port is in group i % ngroups, see alloc_sge_txq_uld() */
+	n = atomic_inc_return(&txq_info->tid_qid_rr[port * ngroups + group]);
+	n %= DIV_ROUND_UP(per_port - group, ngroups);
+	*qid = port * per_port + group + n * ngroups;
+}
+EXPORT_SYMBOL(cxgb4_uld_tid_qid_sel_update);
+
 /* cxgb4_register_uld - register an upper-layer driver
  * @type: the ULD type
  * @p: the ULD methods
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
index d7713038386c..fd48886603d7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
@@ -433,6 +433,7 @@ struct cxgb4_lld_info {
 	unsigned short nciq;		     /* # of concentrator IQ */
 	unsigned char nchan:4;               /* # of channels */
 	unsigned char nports:4;              /* # of ports */
+	u8 num_up_cores;                     /* # of control queues per port */
 	unsigned char wr_cred;               /* WR 16-byte credits */
 	unsigned char adapter_type;          /* type of adapter */
 	unsigned char fw_api_ver;            /* FW API version */
@@ -500,6 +501,10 @@ struct cxgb4_uld_info {
 void cxgb4_uld_enable(struct adapter *adap);
 void cxgb4_register_uld(enum cxgb4_uld type, const struct cxgb4_uld_info *p);
 int cxgb4_unregister_uld(enum cxgb4_uld type);
+void cxgb4_uld_tid_ctrlq_id_sel_update(struct net_device *dev, u32 tid,
+				       u16 *ctrlq_index);
+void cxgb4_uld_tid_qid_sel_update(struct net_device *dev, enum cxgb4_uld uld,
+				  u32 tid, u16 *qid);
 int cxgb4_ofld_send(struct net_device *dev, struct sk_buff *skb);
 int cxgb4_immdata_send(struct net_device *dev, unsigned int idx,
 		       const void *src, unsigned int len);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 2171db2f201a..07537bd0768f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -4779,7 +4779,8 @@ int t4_sge_mod_ctrl_txq(struct adapter *adap, unsigned int eqid,
 }
 
 static int t4_sge_alloc_ofld_txq(struct adapter *adap, struct sge_txq *q,
-				 struct net_device *dev, u32 cmd, u32 iqid)
+				 struct net_device *dev, u32 cmd, u32 iqid,
+				 u8 group)
 {
 	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	struct port_info *pi = netdev_priv(dev);
@@ -4807,7 +4808,8 @@ static int t4_sge_alloc_ofld_txq(struct adapter *adap, struct sge_txq *q,
 			    FW_EQ_OFLD_CMD_PFN_V(adap->pf) |
 			    FW_EQ_OFLD_CMD_VFN_V(0));
 	c.alloc_to_len16 = htonl(FW_EQ_OFLD_CMD_ALLOC_F |
-				 FW_EQ_OFLD_CMD_EQSTART_F | FW_LEN16(c));
+				 FW_EQ_OFLD_CMD_EQSTART_F |
+				 FW_EQ_OFLD_CMD_COREGROUP_V(group) | FW_LEN16(c));
 	c.fetchszm_to_iqid =
 		htonl(FW_EQ_OFLD_CMD_HOSTFCMODE_V(HOSTFCMODE_STATUS_PAGE_X) |
 		      FW_EQ_OFLD_CMD_PCIECHN_V(pi->tx_chan) |
@@ -4836,7 +4838,7 @@ static int t4_sge_alloc_ofld_txq(struct adapter *adap, struct sge_txq *q,
 
 int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
 			 struct net_device *dev, unsigned int iqid,
-			 unsigned int uld_type)
+			 unsigned int uld_type, u8 group)
 {
 	u32 cmd = FW_EQ_OFLD_CMD;
 	int ret;
@@ -4844,7 +4846,7 @@ int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
 	if (unlikely(uld_type == CXGB4_TX_CRYPTO))
 		cmd = FW_EQ_CTRL_CMD;
 
-	ret = t4_sge_alloc_ofld_txq(adap, &txq->q, dev, cmd, iqid);
+	ret = t4_sge_alloc_ofld_txq(adap, &txq->q, dev, cmd, iqid, group);
 	if (ret)
 		return ret;
 
@@ -4853,6 +4855,7 @@ int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
 	skb_queue_head_init(&txq->sendq);
 	tasklet_setup(&txq->qresume_tsk, restart_ofldq);
 	txq->full = 0;
+	txq->tid_qid_group_id = group;
 	txq->mapping_err = 0;
 	return 0;
 }
@@ -4862,7 +4865,8 @@ int t4_sge_alloc_ethofld_txq(struct adapter *adap, struct sge_eohw_txq *txq,
 {
 	int ret;
 
-	ret = t4_sge_alloc_ofld_txq(adap, &txq->q, dev, FW_EQ_OFLD_CMD, iqid);
+	ret = t4_sge_alloc_ofld_txq(adap, &txq->q, dev, FW_EQ_OFLD_CMD, iqid,
+				    0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
index 7bd0c0d8a73c..778b2341e74a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
@@ -1346,6 +1346,7 @@ enum fw_params_param_dev {
 	FW_PARAMS_PARAM_DEV_NUM_TM_CLASS = 0x2B,
 	FW_PARAMS_PARAM_DEV_FILTER = 0x2E,
 	FW_PARAMS_PARAM_DEV_KTLS_HW = 0x31,
+	FW_PARAMS_PARAM_DEV_TID_QID_SEL_MASK = 0x33,
 };
 
 /*
@@ -2139,6 +2140,10 @@ struct fw_eq_ofld_cmd {
 #define FW_EQ_OFLD_CMD_EQSTART_V(x)	((x) << FW_EQ_OFLD_CMD_EQSTART_S)
 #define FW_EQ_OFLD_CMD_EQSTART_F	FW_EQ_OFLD_CMD_EQSTART_V(1U)
 
+#define FW_EQ_OFLD_CMD_COREGROUP_S	16
+#define FW_EQ_OFLD_CMD_COREGROUP_M	0x3f
+#define FW_EQ_OFLD_CMD_COREGROUP_V(x)	((x) << FW_EQ_OFLD_CMD_COREGROUP_S)
+
 #define FW_EQ_OFLD_CMD_EQSTOP_S		27
 #define FW_EQ_OFLD_CMD_EQSTOP_V(x)	((x) << FW_EQ_OFLD_CMD_EQSTOP_S)
 #define FW_EQ_OFLD_CMD_EQSTOP_F		FW_EQ_OFLD_CMD_EQSTOP_V(1U)
-- 
2.39.1

