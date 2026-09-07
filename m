Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8046EC61
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779065; cv=none; b=OEoFE6qhCathxdAl7ETa/2ijNChzSAPNGdlSMp1QlWMNNDgF6lIDFb7t0istdq8BG62eY82jPCc5F+c/HDxxMDSA9zThkePZYSnpTveZHMoC9mYJaHdJ8+zt3fWMfp2kUC5JGnIHZBBtsU3/X4zx+JrRtqNVSTrQht3rU80SY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779065; c=relaxed/simple;
	bh=F0pplmPp/ILlSOcSyeqQ+ooDXozDLzWq7pPp/tL7t/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhG0aCeF/baEg3D0y4Hul/19AtrRRKHAWueYyT41+LC8l4hVoh3+2rviQ7qeOPvqK5vXfBR0EqOf9esAIyrfXfWgt90r5CvsMFvguXik8+ffmxIU3bV3J3xh0CP+9PLEP267hVJEiuHfThpqBzB165HQ8+Io2poqSPpE0BAW804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/ZFPgQ5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/ZFPgQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788779064; x=1820315064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0pplmPp/ILlSOcSyeqQ+ooDXozDLzWq7pPp/tL7t/4=;
  b=d/ZFPgQ5oqqOWkt7AFoGpQELm7KWpvgGhDTpLpnOQbPPWrzzlKCVN9WY
   QOtnZDbzJX2iZXgkSS71Cw0b1KF5Nscp1eyF1qo8P60HPy96tZNj1K39s
   T1/uf5Wc1wqwMDMWE9sfEl1PSASWTyseCmTQyEGcdOf3eOSivpnLqF9n9
   mCETFSt4V9lLutmNxqEOQX4m7+r4mHX+N7Lu2IG4V/oxZsa8BRsOpLr62
   R5riVIiE5xOdY1SpMDQkj/9tTSi3pJCkE4u8+N3W2ziNcmjZzkY7/t05q
   7h2WA5L8XCcNbcri9yGT+iftzhDwDe8lqjIcluRUH09kVgWYINT1nmuEF
   A==;
X-CSE-ConnectionGUID: 0neQrUTeRL+ANX1G2DpsIw==
X-CSE-MsgGUID: ACBueXk/Ti6HjfDcN7++wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214071"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89214071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:04:23 -0700
X-CSE-ConnectionGUID: 0ddHicIZQTCos+KuA/VGjA==
X-CSE-MsgGUID: OgWQMPyrQxe22AC09v6Qug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274195369"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:21 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 04/10] idpf: drop v_idx from q_vector structure
Date: Mon,  7 Sep 2026 12:24:11 +0200
Message-ID: <20260907102418.2697317-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
References: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Storing another index related to irq in q_vector can be misleading. It
is only used when matching q_vectors with queues. It can be obtained
using 0-based software irq index.

Use irq.index (from q_vector) and get the hardware irq index
(q_vector->v_idx earlier) from irq_info structure.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     |  4 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h     |  5 +----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 86e5bb30ecc6..785d551c795d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -301,7 +301,7 @@ struct idpf_fsteer_fltr {
  * @q_vectors: array of queue vectors
  * @q_vector_idxs: starting index of queue vectors
  * @num_q_vectors: number of IRQ vectors allocated
- * @noirq_v_idx: ID of the NOIRQ vector
+ * @noirq_v_idx: software IRQ index used to get hardware vector information
  * @noirq_dyn_ctl_ena: value to write to the above to enable it
  * @noirq_dyn_ctl: register to enable/disable the vector for NOIRQ queues
  * @txq_grps: array of TX queue groups
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c75fc1fc4f64..2a3dd04ebe23 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4511,8 +4511,6 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
 	for (i = 0; i < rsrc->num_q_vectors; i++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
 
-		q_vector->v_idx =
-			adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
 		q_vector->irq.index = rsrc->q_vector_idxs[i];
 		q_vector->irq.virq = pci_irq_vector(adapter->pdev,
 						    q_vector->irq.index);
@@ -4520,7 +4518,7 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
 			return q_vector->irq.virq;
 	}
 
-	rsrc->noirq_v_idx = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
+	rsrc->noirq_v_idx = rsrc->q_vector_idxs[i];
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 57e61936ffda..9a2e3665277f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -377,7 +377,6 @@ struct idpf_intr_reg {
  * @rx_itr_value: RX interrupt throttling rate
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
- * @v_idx: Vector index
  * @irq: kernel and driver irq numbers
  */
 struct idpf_q_vector {
@@ -418,15 +417,13 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(read_write);
 
 	__cacheline_group_begin_aligned(cold);
-	u16 v_idx;
-
 	struct msi_map irq;
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 136,
 			    56 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
-			    8 + sizeof(struct msi_map));
+			    sizeof(struct msi_map));
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fbb3a0ba9791..71cac3e70ed8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1848,12 +1848,14 @@ idpf_prep_map_unmap_queue_set_vector_msg(u32 vport_id, void *buf,
  * idpf_send_map_unmap_queue_set_vector_msg - send virtchnl map or unmap
  *					      queue set vector message
  * @qs: set of the queues to map or unmap
+ * @info: interrupts info to map software index to firmware one
  * @map: true for map and false for unmap
  *
  * Return: 0 on success, -errno on failure.
  */
 static int
 idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
+					 const struct idpf_irq_info *info,
 					 bool map)
 {
 	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
@@ -1893,7 +1895,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 				vec = q->rxq->q_vector;
 
 			if (vec) {
-				v_idx = vec->v_idx;
+				v_idx = vec->irq.index;
 				itr_idx = vec->rx_itr_idx;
 			} else {
 				v_idx = qs->qv_rsrc->noirq_v_idx;
@@ -1913,7 +1915,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 				vec = q->txq->q_vector;
 
 			if (vec) {
-				v_idx = vec->v_idx;
+				v_idx = vec->irq.index;
 				itr_idx = vec->tx_itr_idx;
 			} else {
 				v_idx = qs->qv_rsrc->noirq_v_idx;
@@ -1925,7 +1927,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 		}
 
 		vqv[i].queue_id = cpu_to_le32(qid);
-		vqv[i].vector_id = cpu_to_le16(v_idx);
+		vqv[i].vector_id = cpu_to_le16(info->vectors[v_idx].idx);
 		vqv[i].itr_idx = cpu_to_le32(itr_idx);
 	}
 
@@ -1989,7 +1991,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_adapter *adapter,
 	if (k != num_q)
 		return -EINVAL;
 
-	return idpf_send_map_unmap_queue_set_vector_msg(qs, map);
+	return idpf_send_map_unmap_queue_set_vector_msg(qs, &adapter->irq_info,
+							map);
 }
 
 /**
-- 
2.49.0

