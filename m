Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9A46EC91
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779068; cv=none; b=bAAkRNZLjHLzv8NkdEweUKC3ZbiFiQWZ/lCQiDaI53zPnC2Wext+zuZTuIn96O6ZuENaR+/6drej6q6i0/J5izg1z4Q1E5+gi/5sxk1VsDp6WhWReWj+dNa1aajjvBYdmsrF+bFil3ThHs53KwmUzGt/yeXU8ky8xJf5zTeb7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779068; c=relaxed/simple;
	bh=X4VfQ772ctDM0FB8HpIEukoLsFNMo0MLMRcOWpajPno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENB7p7bjuX1P5cyfS92PhE0FMiNUPKEcOkGz3Rv4HITMJ3PpIgFm/V/2YQocKF5hkBncIwihO4PF7t0vrTpcJUO1uFEZxknYd3zx9fyLLFoui9PJ6DENWk+rDNW/rJ8glNt9RCK1AepNWo7i+LNNnIeog87YLHk1Fvlt60uR9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naK6nluz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naK6nluz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788779067; x=1820315067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4VfQ772ctDM0FB8HpIEukoLsFNMo0MLMRcOWpajPno=;
  b=naK6nluzx8dZ+r7c5OXb+LASZI9omc+KRN/X5jo8zdkILP/MCZhCtRy1
   hFva4IWjxImUC/1i4cv0WCvxVKpLbOa/Brc0zCYXBriNjadKEeDwxcuWn
   bGv/jKkyfM/WPv11+GK0yHJiM4gcEsn1TULIX7ClDBJasmlYgp60s8/NW
   0g43JADs/SgrbgzPWHZv2JbQIecN+/kFjlUruCmtlCGGRDPQwCXu8gxdT
   +EAAAk8tt8MCeAkDiY5hNdhicoQPWtAUe6QHYZ058dsq0yFXa/2qRdZNF
   OTg0TGUbWVfLG/V/qW49LCV4wIFXAd1Ij9kWbCeYdeYAN6Z1RFNm6i/Gd
   Q==;
X-CSE-ConnectionGUID: KTBzXlGTSnO7OlqeRU4Hng==
X-CSE-MsgGUID: PJ97q94TRpCf0HG1+e03jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214078"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89214078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:04:27 -0700
X-CSE-ConnectionGUID: IcE68psHRXqOgdVVPybwog==
X-CSE-MsgGUID: nENw2yhgQE+73Qoa1qJiMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274195430"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:25 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v1 06/10] libie, idpf: move hardware irq info struct to libie
Date: Mon,  7 Sep 2026 12:24:13 +0200
Message-ID: <20260907102418.2697317-7-michal.swiatkowski@linux.intel.com>
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

Manually move definition related to irq info from idpf to libie_irq.
s/idpf_/libie_

It will be used by idpf and ixd driver.

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 36 +------------------
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  8 ++---
 include/linux/net/intel/libie/irq.h           | 34 ++++++++++++++++++
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index b7ed8272bc93..1c67895a014e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -577,40 +577,6 @@ struct idpf_vport_config {
 	     iter = (++__##iter) < &(adapter)->vports[(adapter)->max_vports] ? \
 	     *__##iter : NULL)
 
-/**
- * struct idpf_vec_regs - hardware registers related to vector
- * @dyn_ctl: Dynamic control interrupt register offset
- * @itrn: Interrupt Throttling Rate register offset
- * @itrn_index_spacing: Register spacing between ITR registers of the same
- *			vector
- */
-struct idpf_vec_regs {
-	u32 dyn_ctl;
-	u32 itrn;
-	u32 itrn_index_spacing;
-};
-
-/**
- * struct idpf_hw_vector - single hardware vector info
- * @regs: address of irq registers
- * @idx: hardware vector index
- */
-struct idpf_hw_vector {
-	struct idpf_vec_regs regs;
-	int idx;
-};
-
-/**
- * struct idpf_irq_info - hardware data needed to setup irq
- * @vectors: allocated during initialization store hardware information
- *	     for all vectors that can be used on a whole device
- * @num: amount of vectors stored here
- */
-struct idpf_irq_info {
-	struct idpf_hw_vector *vectors;
-	int num;
-};
-
 /**
  * struct idpf_adapter - Device data struct generated on probe
  * @pdev: PCI device struct given on probe
@@ -685,7 +651,7 @@ struct idpf_adapter {
 	struct msix_entry *rdma_msix_entries;
 	struct libie_irq irq;
 	struct virtchnl2_alloc_vectors *req_vec_chunks;
-	struct idpf_irq_info irq_info;
+	struct libie_irq_info irq_info;
 	struct idpf_q_vector mb_vector;
 	irqreturn_t (*irq_mb_handler)(int irq, void *data);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index cd947fd24ff6..61f5e8e4d20b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -87,7 +87,7 @@ static void idpf_noirq_intr_reg_init(struct idpf_adapter *adapter,
 static void idpf_intr_reg_init(struct idpf_adapter *adapter,
 			       struct idpf_q_vector *q_vector, u16 idx)
 {
-	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct libie_hw_vector *v = &adapter->irq_info.vectors[idx];
 	struct idpf_intr_reg *intr = &q_vector->intr_reg;
 	struct libie_mmio_info *mmio;
 	u32 rx_itr, tx_itr;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index df3eabe12b18..4c1c2476613b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -86,7 +86,7 @@ static void idpf_vf_noirq_intr_reg_init(struct idpf_adapter *adapter,
 static void idpf_vf_intr_reg_init(struct idpf_adapter *adapter,
 				  struct idpf_q_vector *q_vector, u16 idx)
 {
-	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct libie_hw_vector *v = &adapter->irq_info.vectors[idx];
 	struct idpf_intr_reg *intr = &q_vector->intr_reg;
 	struct libie_mmio_info *mmio;
 	u32 rx_itr, tx_itr;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e24740bbb7ca..9377af87125f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1855,7 +1855,7 @@ idpf_prep_map_unmap_queue_set_vector_msg(u32 vport_id, void *buf,
  */
 static int
 idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
-					 const struct idpf_irq_info *info,
+					 const struct libie_irq_info *info,
 					 bool map)
 {
 	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
@@ -2238,14 +2238,14 @@ int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
  *
  * Returns 0 on success, negative on failure.
  */
-static int idpf_create_vectors_info(struct idpf_irq_info *info,
+static int idpf_create_vectors_info(struct libie_irq_info *info,
 				    const struct virtchnl2_get_capabilities *caps,
 				    const struct virtchnl2_alloc_vectors *vectors,
 				    const u16 num_vectors)
 {
 	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
 	int all_vectors = num_vectors + IDPF_MBX_Q_VEC;
-	struct idpf_hw_vector *vector;
+	struct libie_hw_vector *vector;
 	int reg_cnt;
 
 	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
@@ -2266,7 +2266,7 @@ static int idpf_create_vectors_info(struct idpf_irq_info *info,
 	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
 		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
 		u32 dyn_spacing, itrn_spacing;
-		struct idpf_vec_regs reg_val;
+		struct libie_vec_regs reg_val;
 		u16 vec_id;
 
 		reg_val.dyn_ctl = le32_to_cpu(chunk->dynctl_reg_start);
diff --git a/include/linux/net/intel/libie/irq.h b/include/linux/net/intel/libie/irq.h
index 8af8fc22ab09..e219fde575d8 100644
--- a/include/linux/net/intel/libie/irq.h
+++ b/include/linux/net/intel/libie/irq.h
@@ -64,6 +64,40 @@ struct libie_irq {
 	struct xarray entries;
 };
 
+/**
+ * struct libie_vec_regs - hardware registers related to vector
+ * @dyn_ctl: Dynamic control interrupt register offset
+ * @itrn: Interrupt Throttling Rate register offset
+ * @itrn_index_spacing: Register spacing between ITR registers of the same
+ *			vector
+ */
+struct libie_vec_regs {
+	u32 dyn_ctl;
+	u32 itrn;
+	u32 itrn_index_spacing;
+};
+
+/**
+ * struct libie_hw_vector - single hardware vector info
+ * @regs: address of irq registers
+ * @idx: hardware vector index
+ */
+struct libie_hw_vector {
+	struct libie_vec_regs regs;
+	int idx;
+};
+
+/**
+ * struct libie_irq_info - hardware data needed to setup irq
+ * @vectors: allocated during initialization store hardware information
+ *	     for all vectors that can be used on a whole device
+ * @num: amount of vectors stored here
+ */
+struct libie_irq_info {
+	struct libie_hw_vector *vectors;
+	int num;
+};
+
 int libie_irq_init(struct libie_irq *irq, struct pci_dev *pdev,
 		   int min, int max);
 void libie_irq_deinit(struct libie_irq *irq);
-- 
2.49.0

