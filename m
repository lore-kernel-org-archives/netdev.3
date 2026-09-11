Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC99416124
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133395; cv=none; b=GqDU7dtdauAcGL31Ee0v6Ylmv10Z/luX/h1OnjS00UH11qzqpWQq6itGl2WZ/Ro8c5ctft9W/t44ilJnP8FtINvG/pyzcwnF5vXe2S1u697YQRubZ98T3iX3xme6xB98PqPj+oL31ucIS3UGciOja+0MT6kbtIW17TmGWxUUPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133395; c=relaxed/simple;
	bh=P7KYpg5UPwC7kIRKVXnoSQn7FyGdFoWe6ZzbbKhMvic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go7NNtxSgZef+DApIfM3BjMZVZ3en9Fe7en7kml4JYZLzQDI/9UH2ZtFFyJqjC67+Yscg0fmn3Mi237J411xL4RBzrJqM2DntdPJQ/tzO0dynVYq8RqjWN1qcGKfpAwRiSFjXaOPAe19wId9xI5MnCZWmf4+0kejDr7C0pKkl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8EYMXiI; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8EYMXiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789133393; x=1820669393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7KYpg5UPwC7kIRKVXnoSQn7FyGdFoWe6ZzbbKhMvic=;
  b=W8EYMXiIx6Qaxi40sHYwcb1AJ8Jx2w6672o0zw4fgtUZS/TP5dxJKZMH
   M6og3T3/DiHtYCbl9dIAaXhrBJ/+vqVRY+F2+Y0J7dafv50M3Z79SeXFo
   hzRY387AicO+TrK+X8tWfsj6RnN2ys5cSe0uPWhPWmWqBRObAAY0H7mTq
   Kuh+MCk8xKoizXkcuHQVyDYlXCqTPzOuX9tP7rCZHyFSl6VJ/reCIg032
   Irv+KzjhtaA6B0vhS8M45fIHsyvZ7hSrBrO2zMHukdclwr8MEoypVVlvA
   i74+ODbC/1oj0CJncYqgnTjbsBMkYEVTmxQmLGTk2ZcAU8rRGYUX5uc3q
   w==;
X-CSE-ConnectionGUID: uWqihPxGTeWXGS9K5sh5nw==
X-CSE-MsgGUID: CE0xGLuwS0G01zcYx0EOag==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107527"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107527"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:29:53 -0700
X-CSE-ConnectionGUID: 3MTAB8GFQdqVJ0Ao1zkAYw==
X-CSE-MsgGUID: GbYNWh1PTw2ne4lj7vFJ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270541267"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:52 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v2 02/10] idpf: fill q_vector interrupt registers one by one
Date: Fri, 11 Sep 2026 14:49:13 +0200
Message-ID: <20260911124921.2881348-3-michal.swiatkowski@linux.intel.com>
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

Most structures pointer used in *_intr_reg_init() are already used in
idpf_vport_intr_req_irq(). Use it by rewriting *_intr_reg_init() to
fill one q_vector in one call.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 91 +++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  7 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 92 ++++++++++---------
 4 files changed, 105 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 84b145431693..5eafabacd167 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -197,6 +197,7 @@ struct idpf_vport_max_q {
  * struct idpf_reg_ops - Device specific register operation function pointers
  * @ctlq_reg_init: Mailbox control queue register initialization
  * @intr_reg_init: Traffic interrupt register initialization
+ * @noirq_intr_reg_init: Vector without interrupt register initialization
  * @mb_intr_reg_init: Mailbox interrupt register initialization
  * @reset_reg_init: Reset register initialization
  * @trigger_reset: Trigger a reset to occur
@@ -205,8 +206,10 @@ struct idpf_vport_max_q {
 struct idpf_reg_ops {
 	void (*ctlq_reg_init)(struct libie_mmio_info *mmio,
 			      struct libie_ctlq_create_info *cctlq_info);
-	void (*intr_reg_init)(struct idpf_vport *vport,
-			      struct idpf_q_vec_rsrc *rsrc);
+	void (*intr_reg_init)(struct idpf_adapter *adapter,
+			      struct idpf_q_vector *q_vector, u16 idx);
+	void (*noirq_intr_reg_init)(struct idpf_adapter *adapter,
+				    struct idpf_q_vec_rsrc *rsrc, u16 idx);
 	void (*mb_intr_reg_init)(struct idpf_adapter *adapter);
 	void (*reset_reg_init)(struct idpf_adapter *adapter);
 	void (*trigger_reset)(struct idpf_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 42e65f1285df..cd947fd24ff6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -58,53 +58,17 @@ static void idpf_mb_intr_reg_init(struct idpf_adapter *adapter)
 }
 
 /**
- * idpf_intr_reg_init - Initialize interrupt registers
- * @vport: virtual port structure
- * @rsrc: pointer to queue and vector resources
+ * idpf_noirq_intr_reg_init - Initialize noirq registers
+ * @adapter: adapter structure
+ * @rsrc: to store noirq register and value
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
  */
-static void idpf_intr_reg_init(struct idpf_vport *vport,
-			       struct idpf_q_vec_rsrc *rsrc)
+static void idpf_noirq_intr_reg_init(struct idpf_adapter *adapter,
+				     struct idpf_q_vec_rsrc *rsrc, u16 idx)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	int num_vecs = rsrc->num_q_vectors;
-	struct libie_mmio_info *mmio;
-	u32 rx_itr, tx_itr, val;
-	int i;
-
-	mmio = &adapter->ctlq_ctx.mmio_info;
+	u32 val = adapter->irq_info.vectors[idx].regs.dyn_ctl;
 
-	for (i = 0; i < num_vecs; i++) {
-		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
-		struct idpf_intr_reg *intr = &q_vector->intr_reg;
-		u16 vec_id = rsrc->q_vector_idxs[i];
-		struct idpf_hw_vector *v;
-		u32 spacing;
-
-		v = &adapter->irq_info.vectors[vec_id];
-
-		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
-		intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
-		intr->dyn_ctl_intena_msk_m = PF_GLINT_DYN_CTL_INTENA_MSK_M;
-		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
-		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
-		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
-		intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
-		intr->dyn_ctl_sw_itridx_ena_m =
-			PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
-
-		spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
-					       IDPF_PF_ITR_IDX_SPACING);
-		rx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
-					   spacing);
-		tx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
-					   spacing);
-		intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
-		intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
-	}
-
-	/* Data vector for NOIRQ queues */
-
-	val = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].regs.dyn_ctl;
 	rsrc->noirq_dyn_ctl =
 		libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info, val);
 
@@ -113,6 +77,44 @@ static void idpf_intr_reg_init(struct idpf_vport *vport,
 	rsrc->noirq_dyn_ctl_ena = val;
 }
 
+/**
+ * idpf_intr_reg_init - Initialize interrupt registers
+ * @adapter: adapter structure
+ * @q_vector: q_vector in which the registers should be initialized
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
+ */
+static void idpf_intr_reg_init(struct idpf_adapter *adapter,
+			       struct idpf_q_vector *q_vector, u16 idx)
+{
+	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct idpf_intr_reg *intr = &q_vector->intr_reg;
+	struct libie_mmio_info *mmio;
+	u32 rx_itr, tx_itr;
+	u32 spacing;
+
+	mmio = &adapter->ctlq_ctx.mmio_info;
+
+	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
+	intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
+	intr->dyn_ctl_intena_msk_m = PF_GLINT_DYN_CTL_INTENA_MSK_M;
+	intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
+	intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
+	intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
+	intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
+	intr->dyn_ctl_sw_itridx_ena_m =
+		PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
+
+	spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
+				       IDPF_PF_ITR_IDX_SPACING);
+	rx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
+				   spacing);
+	tx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
+				   spacing);
+	intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
+	intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
+}
+
 /**
  * idpf_reset_reg_init - Initialize reset registers
  * @adapter: Driver specific private structure
@@ -171,6 +173,7 @@ static void idpf_reg_ops_init(struct idpf_adapter *adapter)
 {
 	adapter->dev_ops.reg_ops.ctlq_reg_init = idpf_ctlq_reg_init;
 	adapter->dev_ops.reg_ops.intr_reg_init = idpf_intr_reg_init;
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init = idpf_noirq_intr_reg_init;
 	adapter->dev_ops.reg_ops.mb_intr_reg_init = idpf_mb_intr_reg_init;
 	adapter->dev_ops.reg_ops.reset_reg_init = idpf_reset_reg_init;
 	adapter->dev_ops.reg_ops.trigger_reset = idpf_trigger_reset;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2b21f599f569..00c8fe692821 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4054,6 +4054,9 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 	const char *drv_name, *if_name, *vec_name;
 	int vector, err, irq_num, vidx;
 
+	vidx = rsrc->q_vector_idxs[rsrc->num_q_vectors];
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init(adapter, rsrc, vidx);
+
 	drv_name = dev_driver_string(&adapter->pdev->dev);
 	if_name = netdev_name(vport->netdev);
 
@@ -4064,6 +4067,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 		vidx = rsrc->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
 
+		adapter->dev_ops.reg_ops.intr_reg_init(adapter, q_vector, vidx);
+
 		if (q_vector->num_rxq && q_vector->num_txq)
 			vec_name = "TxRx";
 		else if (q_vector->num_rxq)
@@ -4649,8 +4654,6 @@ int idpf_vport_intr_init(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 	idpf_vport_intr_map_vector_to_qs(vport, rsrc);
 	idpf_vport_intr_napi_add_all(vport, rsrc);
 
-	vport->adapter->dev_ops.reg_ops.intr_reg_init(vport, rsrc);
-
 	err = idpf_vport_intr_req_irq(vport, rsrc);
 	if (err)
 		goto unroll_vectors_alloc;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index c0080842b7e2..df3eabe12b18 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -57,53 +57,17 @@ static void idpf_vf_mb_intr_reg_init(struct idpf_adapter *adapter)
 }
 
 /**
- * idpf_vf_intr_reg_init - Initialize interrupt registers
- * @vport: virtual port structure
- * @rsrc: pointer to queue and vector resources
+ * idpf_vf_noirq_intr_reg_init - Initialize noirq registers
+ * @adapter: adapter structure
+ * @rsrc: to store noirq register and value
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
  */
-static void idpf_vf_intr_reg_init(struct idpf_vport *vport,
-				  struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vf_noirq_intr_reg_init(struct idpf_adapter *adapter,
+					struct idpf_q_vec_rsrc *rsrc, u16 idx)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	int num_vecs = rsrc->num_q_vectors;
-	struct libie_mmio_info *mmio;
-	u32 rx_itr, tx_itr, val;
-	int i;
-
-	mmio = &adapter->ctlq_ctx.mmio_info;
+	u32 val = adapter->irq_info.vectors[idx].regs.dyn_ctl;
 
-	for (i = 0; i < num_vecs; i++) {
-		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
-		struct idpf_intr_reg *intr = &q_vector->intr_reg;
-		u16 vec_id = rsrc->q_vector_idxs[i];
-		struct idpf_hw_vector *v;
-		u32 spacing;
-
-		v = &adapter->irq_info.vectors[vec_id];
-
-		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
-		intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
-		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
-		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
-		intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
-		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
-		intr->dyn_ctl_swint_trig_m = VF_INT_DYN_CTLN_SWINT_TRIG_M;
-		intr->dyn_ctl_sw_itridx_ena_m =
-			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
-
-		spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
-					       IDPF_VF_ITR_IDX_SPACING);
-		rx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
-					  spacing);
-		tx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
-					  spacing);
-		intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
-		intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
-	}
-
-	/* Data vector for NOIRQ queues */
-
-	val = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].regs.dyn_ctl;
 	rsrc->noirq_dyn_ctl =
 		libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info, val);
 
@@ -112,6 +76,44 @@ static void idpf_vf_intr_reg_init(struct idpf_vport *vport,
 	rsrc->noirq_dyn_ctl_ena = val;
 }
 
+/**
+ * idpf_vf_intr_reg_init - Initialize interrupt registers
+ * @adapter: adapter structure
+ * @q_vector: q_vector in which the registers should be initialized
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
+ */
+static void idpf_vf_intr_reg_init(struct idpf_adapter *adapter,
+				  struct idpf_q_vector *q_vector, u16 idx)
+{
+	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct idpf_intr_reg *intr = &q_vector->intr_reg;
+	struct libie_mmio_info *mmio;
+	u32 rx_itr, tx_itr;
+	u32 spacing;
+
+	mmio = &adapter->ctlq_ctx.mmio_info;
+
+	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
+	intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
+	intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
+	intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
+	intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
+	intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
+	intr->dyn_ctl_swint_trig_m = VF_INT_DYN_CTLN_SWINT_TRIG_M;
+	intr->dyn_ctl_sw_itridx_ena_m =
+		VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
+
+	spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
+				       IDPF_VF_ITR_IDX_SPACING);
+	rx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
+				  spacing);
+	tx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
+				  spacing);
+	intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
+	intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
+}
+
 /**
  * idpf_vf_reset_reg_init - Initialize reset registers
  * @adapter: Driver specific private structure
@@ -157,6 +159,8 @@ static void idpf_vf_reg_ops_init(struct idpf_adapter *adapter)
 {
 	adapter->dev_ops.reg_ops.ctlq_reg_init = idpf_vf_ctlq_reg_init;
 	adapter->dev_ops.reg_ops.intr_reg_init = idpf_vf_intr_reg_init;
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init =
+		idpf_vf_noirq_intr_reg_init;
 	adapter->dev_ops.reg_ops.mb_intr_reg_init = idpf_vf_mb_intr_reg_init;
 	adapter->dev_ops.reg_ops.reset_reg_init = idpf_vf_reset_reg_init;
 	adapter->dev_ops.reg_ops.trigger_reset = idpf_vf_trigger_reset;
-- 
2.49.0

