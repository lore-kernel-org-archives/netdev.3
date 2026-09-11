Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC5416124
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133398; cv=none; b=eBOIzYE44wVIqizpH8bU+MOlmHfuJxVTr3Tmqykroz9vCiV+2FERtHedE4XBW3wBaRcOvsXWq4bmsRS3lGQU/sftGZYv1H83NqrxXfZWLdUogTVV2M/8kDxm+e8Jv1nDoGH8M6fSf8w9siTumH+AYZUTRiR/1MPDdUibbeF2vjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133398; c=relaxed/simple;
	bh=/ylOZDTopd1lsD5tWtHC0lFWnQ3WnsY6z99ehpaGslA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIv5UHXCmaIG+6ShWIZce7uLMm4r8aqXvpzOiXCYvSRkndwiJ7e59xeyLlH8uQfOU5I24hbNRa4Skn0usLx2dlb3zcGXMk23eeV9SgHDclpeTcp/PyggC0Gcn6toz4RvVVIZ0yN0ZBCnEntFHWoTYG3VGosHUC2dR57R16GIkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPFt9B7j; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPFt9B7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789133397; x=1820669397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ylOZDTopd1lsD5tWtHC0lFWnQ3WnsY6z99ehpaGslA=;
  b=UPFt9B7jOjaconzl1L/u3xQPDz2IarMOjga62uMZ5HJNCK/XhFiyqMvP
   6+6ZA0lsvWb5iAOCL+wRz9XlU+RmvHQK7Qj/z6V26wPr80CU2aX8mAfWp
   kfW18i8sdkAKTzm6nN6jafzIx1kAihATJhukd2+t3ZclTcWU7rxSApyAW
   bzUNspDEQqSxvXu7nXtgDKrkfARYtKl1nzjPqm15KMA9OIzpSAvgGVCoJ
   4ypKOS9iVOszZ/5t/+dp59FTQa8RbRyXJypeUqH3D8qX5WPG/sboTj+6f
   HNnWh5KqdXXSlD5+9MzliTqYIKqAmToCLbPwSKrJdqmkjCznXth8J9qhz
   A==;
X-CSE-ConnectionGUID: NszncWcgR86RxjXpsKlgrw==
X-CSE-MsgGUID: dmsCpYc8RhGhwJQ70WQcvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107533"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107533"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:29:57 -0700
X-CSE-ConnectionGUID: QqsmpH/cQ8mGnbrlNP1ToA==
X-CSE-MsgGUID: FF4UPsocTeK9slgdN1hwNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270541276"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:55 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector structure
Date: Fri, 11 Sep 2026 14:49:15 +0200
Message-ID: <20260911124921.2881348-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
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
index 267ac9fa3846..90f3c40c7928 100644
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

