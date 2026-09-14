Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF64570E1;
	Mon, 14 Sep 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389289; cv=none; b=EkHv5bT7HQYV+sJPxzj2ReCKNkkihUq/iNn2tvzD0F9QfJY4DJb0dMyyXbLGiaeSfIEg2iVgcV6JU/tS/sEgPruQUGb47e3/V7lTDgXJoKeUeJdZ6/LIc+L9i/ct8EYdMY5OpedWVRv4BeH/p9n4x0myJec8AKYgDhBuLPpJf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389289; c=relaxed/simple;
	bh=7e8J2HyD9HafP4I6pGBTBDZ9+6SbILrfaMFkpBs8TZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpC3RbbAc4AovDNHszYZovuJ4uzBJLrVk2DLk9yVVfbW333j3YPnmsXwbILts/DTRKeQ08+ttIw9HrQ1j1tnjgtmpLtRCf8MQnBvpwJIJF3aXQONkhRIvzQYMKYL+j184x/QjDMB7vo5fXWfb4Q9JOT+Y7Lm7n9E3Mu534VV32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.4673752;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0810535-0.00229122-0.916655;FP=10617235010322255019|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jDG7RGO_1789389278;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jDG7RGO_1789389278 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 20:34:39 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v28 net-next 05/10] net/nebula-matrix: add intr resource implementation
Date: Mon, 14 Sep 2026 20:34:19 +0800
Message-ID: <20260914123429.56596-6-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914123429.56596-1-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Introduce nbl_interrupt module to manage driver-wide global chip-internal
MSI-X vector index space (intr_net_bmap / intr_other_bmap) and program
the chip-internal MSI-X mapping registers.

This module manages hardware global vector indices, not the physical PCI
MSI-X entries. Physical PCI MSI-X vector allocation via pci_alloc_irq_vectors
is handled separately by the device layer; the corresponding entry point
nbl_dev_init_interrupt_scheme() will be added in a later patch in this series.

Core interfaces:

1. cfg_msix_map
Allocates global hardware MSI-X indices from independent net/other interrupt
bitmaps. The coherent DMA buffer for the function MSI-X map table is allocated
once per function. Subsequent reconfigurations reuse the existing DMA buffer
and avoid free/realloc cycles, removing the associated DMA race window and
quiesce sleep on reconfigure.

Old hardware state is torn down only after all new allocations succeed
to avoid interrupt loss. Writes the MSI-X table DMA address and control-PF
BDF into NBL_PCOMPLETER_FUNCTION_MSIX_MAP.

2. destroy_msix_map
Recycles global hardware vector indices, clears hardware MSI-X mappings,
releases coherent DMA memory and interrupt descriptor array.
Step 0 disables mailbox IRQ routing before teardown; Step 1 masks each vector.
Two-stage hardware teardown retains live DMA address while clearing VALID bit,
then waits ~1ms for in-flight hardware DMA table fetch to quiesce (best-effort,
no idle status register available). After quiesce, zero the table entry before
freeing coherent memory.

3. set_mailbox_irq
Toggles mailbox MSI-X routing for a specific PF by updating
NBL_MAILBOX_QINFO_MAP_REG_ARR. The disable path works without a configured
MSI-X map, so destroy_msix_map can safely clear routing before releasing
vectors.

4. cfg_msix_info
Programs PADPT_HOST_MSIX_INFO and PCOMPLETER_HOST_MSIX_FID_TABLE.
Hardware requires strict programming ordering: enable path writes MSIX_INFO
then FID table; teardown uses reverse order to prevent inconsistent hardware
state.

The interrupt manager owns a self-contained mutex (intr_mgt->lock) that
protects the global vector bitmaps and per-function state.
All public entry points (cfg/destroy/set_irq) take this lock internally;
callers need not hold any upper-layer lock.

nbl_intr_mgt_stop() iterates all 520 function IDs and destroys any leftover
MSI-X map (including maps for remote PFs configured via mailbox RPC), followed
by a final global quiesce sleep. It is called from nbl_res_remove_leonis()
before devres releases coherent tables.

This interrupt manager only supports PF; VF func_ids are not supported.
nbl_res_func_id_to_bdf() returns -EOPNOTSUPP for function IDs outside PF range.

The manager is instantiated via nbl_intr_mgt_start() during resource
initialization and attached to the resource management context.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 140 ++++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  42 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  33 +-
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 591 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  38 ++
 .../nbl/nbl_include/nbl_def_hw.h              |   9 +
 .../nbl/nbl_include/nbl_def_resource.h        |   6 +
 .../nbl/nbl_include/nbl_include.h             |   1 +
 12 files changed, 910 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 3dab9519a277..5aec8e44f5d7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -8,4 +8,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 		nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 		nbl_hw/nbl_resource.o \
+		nbl_hw/nbl_interrupt.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 960263d8f28c..33f6b4e87081 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -86,6 +86,20 @@ static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+static void nbl_hw_wr_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				const u32 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	spin_lock(&hw_mgt->reg_lock);
+	for (i = 0; i < size; i++)
+		wr32(hw_mgt->hw_addr, reg + i * sizeof(u32), data[i]);
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
 /*
  * Registers reset to zero after cold boot / FLR / bus reset. Firmware
  * programs valid values before driver probe, so zero is only seen on
@@ -101,6 +115,124 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
 	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
 }
 
+/*
+ * nbl_hw_set_mailbox_irq - read-modify-write NBL_MAILBOX_QINFO_MAP_REG_ARR
+ *
+ * The full RMW sequence is wrapped by reg_lock, so concurrent register
+ * access from different CPUs is already serialized safely.
+ * nbl_hw_cfg_mailbox_qinfo() overwrites the entire register during init,
+ * which unconditionally clears MSIX_IDX and MSIX_IDX_VALID bits, disabling
+ * mailbox MSIX interrupt routing for this PF.
+ */
+static void nbl_hw_set_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				   bool en_msix, u16 gvec)
+{
+	u32 data = 0;
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id), &data,
+		       sizeof(data));
+	data &= ~(NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK |
+		  NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK);
+	if (en_msix)
+		data |= FIELD_PREP(NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK,
+				   gvec) |
+			FIELD_PREP(NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK,
+				   1);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id), &data,
+		       sizeof(data));
+	spin_unlock(&hw_mgt->reg_lock);
+	nbl_flush_writes(hw_mgt);
+}
+
+static void nbl_hw_cfg_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				bool valid, dma_addr_t dma_addr, u8 bus,
+				u8 devid, u8 function)
+{
+	struct nbl_function_msix_map function_msix_map;
+
+	memset(&function_msix_map, 0, sizeof(function_msix_map));
+	if (valid) {
+		function_msix_map.data[0] = lower_32_bits(dma_addr);
+		function_msix_map.data[1] = upper_32_bits(dma_addr);
+		/* use ctrl dev's bdf, because the dma memory was
+		 * allocated by it
+		 */
+		function_msix_map.data[2] =
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_FUNCTION_MASK,
+				   function) |
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_DEVID_MASK, devid) |
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_BUS_MASK, bus) |
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_VALID_MASK, 1);
+	} else {
+		/*
+		 * reg_lock prevents concurrent CPU writes to the same
+		 * function's MSIX entry, but cannot synchronize hardware DMA
+		 * reads. Upper layer uses two-stage destruction + sync sleep
+		 * to avoid torn hardware read of partial MSIX entry.
+		 * Keep valid live dma address here, only clear VALID flag.
+		 */
+		function_msix_map.data[0] = lower_32_bits(dma_addr);
+		function_msix_map.data[1] = upper_32_bits(dma_addr);
+		function_msix_map.data[2] = 0;
+	}
+
+	nbl_hw_wr_regs_lock(hw_mgt,
+			    NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
+			    function_msix_map.data, sizeof(function_msix_map));
+}
+
+static void nbl_hw_cfg_msix_info(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				 bool valid, u16 interrupt_id, u8 bus,
+				 u8 devid, u8 function, bool msix_mask_en)
+{
+	u32 host_msix_fid = 0;
+	struct nbl_host_msix_info msix_info;
+
+	memset(&msix_info, 0, sizeof(msix_info));
+	if (valid) {
+		host_msix_fid =
+			FIELD_PREP(NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_FID_MASK,
+				   func_id) |
+			FIELD_PREP(NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_VLD_MASK,
+				   1);
+
+		msix_info.data[1] =
+			FIELD_PREP(NBL_HOST_MSIX_INFO_FUNCTION_MASK, function) |
+			FIELD_PREP(NBL_HOST_MSIX_INFO_DEVID_MASK, devid) |
+			FIELD_PREP(NBL_HOST_MSIX_INFO_BUS_MASK, bus) |
+			FIELD_PREP(NBL_HOST_MSIX_INFO_VALID_MASK, 1);
+
+		if (msix_mask_en)
+			msix_info.data[1] |=
+			FIELD_PREP(NBL_HOST_MSIX_INFO_MSIX_MASK_EN_MASK, 1);
+	}
+	spin_lock(&hw_mgt->reg_lock);
+	/*
+	 * Programming order rule:
+	 * Enable: PADPT_HOST_MSIX_INFO -> PCOMPLETER_HOST_MSIX_FID_TABLE
+	 * Teardown: reverse order, clear FID VLD first to avoid inconsistent
+	 * state
+	 */
+	if (valid) {
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+			       msix_info.data, sizeof(msix_info));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(interrupt_id),
+			       &host_msix_fid, sizeof(host_msix_fid));
+	} else {
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(interrupt_id),
+			       &host_msix_fid, sizeof(host_msix_fid));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+			       msix_info.data, sizeof(msix_info));
+	}
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
 static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
 						 u16 tail_ptr, u8 txrx)
 {
@@ -228,6 +360,8 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.cfg_msix_map = nbl_hw_cfg_msix_map,
+	.cfg_msix_info = nbl_hw_cfg_msix_info,
 	.flush_write = nbl_flush_writes,
 
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
@@ -239,6 +373,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.set_mailbox_irq = nbl_hw_set_mailbox_irq,
 
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
@@ -269,11 +404,12 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
 	hw_ops_tbl = devm_kzalloc(dev, sizeof(*hw_ops_tbl), GFP_KERNEL);
 	if (!hw_ops_tbl)
 		return ERR_PTR(-ENOMEM);
-	if (!hw_ops.flush_write || !hw_ops.update_mailbox_queue_tail_ptr ||
+	if (!hw_ops.cfg_msix_map || !hw_ops.cfg_msix_info ||
+	    !hw_ops.flush_write || !hw_ops.update_mailbox_queue_tail_ptr ||
 	    !hw_ops.config_mailbox_rxq || !hw_ops.config_mailbox_txq ||
 	    !hw_ops.stop_mailbox_rxq || !hw_ops.stop_mailbox_txq ||
 	    !hw_ops.get_host_pf_mask || !hw_ops.get_real_bus ||
-	    !hw_ops.cfg_mailbox_qinfo ||
+	    !hw_ops.cfg_mailbox_qinfo || !hw_ops.set_mailbox_irq ||
 	    !hw_ops.get_fw_eth_map || !hw_ops.get_board_info)
 		return ERR_PTR(-EINVAL);
 	hw_ops_tbl->ops = &hw_ops;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 251dd68d0721..7d0adc5bfb0a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -54,6 +54,48 @@ struct nbl_mailbox_qinfo_cfg_table {
 #define NBL_PCIE_HOST_TL_CFG_BUSDEV (NBL_INTF_HOST_PCIE_BASE + 0x11040)
 
 #define NBL_PCIE_BUS_MASK	GENMASK(12, 5)
+
+/*  --------  HOST_PADPT  --------  */
+/* host_padpt host_msix_info */
+#define NBL_PADPT_HOST_MSIX_INFO_REG_ARR(vector_id) \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00010000 +    \
+	 (vector_id) * sizeof(struct nbl_host_msix_info))
+
+#define NBL_HOST_MSIX_INFO_DWLEN	2
+/* data[0] */
+#define NBL_HOST_MSIX_INFO_INTRL_PNUM_MASK GENMASK(15, 0)
+#define NBL_HOST_MSIX_INFO_INTRL_RATE_MASK GENMASK(31, 16)
+/* data[1] */
+#define NBL_HOST_MSIX_INFO_FUNCTION_MASK GENMASK(2, 0)
+#define NBL_HOST_MSIX_INFO_DEVID_MASK GENMASK(7, 3)
+#define NBL_HOST_MSIX_INFO_BUS_MASK GENMASK(15, 8)
+#define NBL_HOST_MSIX_INFO_VALID_MASK BIT(16)
+#define NBL_HOST_MSIX_INFO_MSIX_MASK_EN_MASK BIT(17)
+struct nbl_host_msix_info {
+	u32 data[NBL_HOST_MSIX_INFO_DWLEN];
+};
+
+/*  --------  HOST_PCOMPLETER  --------  */
+/* pcompleter_host pcompleter_host_virtio_qid_map_table */
+#define NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(i)   \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00004000 + \
+	 (i) * sizeof(struct nbl_function_msix_map))
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(i) \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x0003a000 + (i) * sizeof(u32))
+
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_FID_MASK  GENMASK(9, 0)
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_VLD_MASK  BIT(10)
+
+#define NBL_FUNC_MSIX_MAP_DWLEN		4
+/* data[2] */
+#define NBL_FUNCTION_MSIX_MAP_FUNCTION_MASK GENMASK(2, 0)
+#define NBL_FUNCTION_MSIX_MAP_DEVID_MASK GENMASK(7, 3)
+#define NBL_FUNCTION_MSIX_MAP_BUS_MASK GENMASK(15, 8)
+#define NBL_FUNCTION_MSIX_MAP_VALID_MASK BIT(16)
+struct nbl_function_msix_map {
+	u32 data[NBL_FUNC_MSIX_MAP_DWLEN];
+};
+
 #define NBL_FW_BOARD_CONFIG			0x200
 #define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
 #define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 46180522295a..338cebcbcc8b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -10,6 +10,9 @@
 static struct nbl_resource_ops res_ops = {
 	.get_vsi_id = nbl_res_func_id_to_vsi_id,
 	.get_eth_id = nbl_res_get_eth_id,
+	.cfg_msix_map = nbl_res_intr_cfg_msix_map,
+	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
+	.set_mailbox_irq = nbl_res_intr_set_mailbox_irq,
 };
 
 static struct nbl_resource_mgt *
@@ -41,7 +44,9 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
 	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
 	if (!res_ops_tbl)
 		return ERR_PTR(-ENOMEM);
-	if (!res_ops.get_vsi_id || !res_ops.get_eth_id)
+	if (!res_ops.get_vsi_id || !res_ops.get_eth_id ||
+	    !res_ops.cfg_msix_map || !res_ops.destroy_msix_map ||
+	    !res_ops.set_mailbox_irq)
 		return ERR_PTR(-EINVAL);
 	res_ops_tbl->ops = &res_ops;
 	res_ops_tbl->priv = res_mgt;
@@ -288,6 +293,10 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
 		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
 		if (ret)
 			return ret;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -328,8 +337,26 @@ int nbl_res_init_leonis(struct nbl_adapter *adap)
 
 void nbl_res_remove_leonis(struct nbl_adapter *adap)
 {
+	struct nbl_resource_mgt *res_mgt = adap->core.res_mgt;
+	struct nbl_common_info *common = &adap->common;
+
+	if (!res_mgt)
+		return;
+
 	/*
-	 * No resource release here because all memory uses devm managed
-	 * allocation
+	 * Tear down all MSI-X maps before devres releases the coherent
+	 * tables.	This is critical on the control PF, which may hold
+	 * maps for remote PFs that are still bound.
+	 */
+	if (common->has_ctrl && res_mgt->intr_mgt)
+		nbl_intr_mgt_stop(res_mgt);
+
+	/* Note:
+	 * per-function interrupts arrays (kcalloc) are freed by
+	 * nbl_intr_mgt_stop().
+	 * MSIX coherent tables are explicitly freed by dmam_free_coherent()
+	 * inside the intr destroy path, before nbl_intr_mgt_stop() returns.
+	 * intr_mgt itself (devm_kzalloc) is released by devres after this
+	 * function returns
 	 */
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index b9355262c00d..6eb4dc9e695a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -7,4 +7,5 @@
 #define _NBL_RESOURCE_LEONIS_H_
 
 #include "../nbl_resource.h"
+#include "../nbl_interrupt.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..6ad65f6e1c61
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/bitfield.h>
+#include "nbl_interrupt.h"
+
+#define NBL_MSIX_DMA_SYNC_MIN_US	1000 /* us */
+#define NBL_MSIX_DMA_SYNC_MAX_US	1200 /* us */
+
+/*
+ * Release global vector IDs back to intr_net_bmap / intr_other_bmap.
+ * Caller must hold intr_mgt->lock.
+ */
+static void nbl_intr_release_bitmap(struct nbl_resource_mgt *res_mgt,
+				    u16 *vec_buf, u16 cnt)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	u16 bit;
+	u16 i;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (!vec_buf || cnt == 0)
+		return;
+
+	for (i = 0; i < cnt; i++) {
+		u16 intr_index = vec_buf[i];
+
+		if (intr_index >= NBL_NET_INTR_BASE) {
+			bit = intr_index - NBL_NET_INTR_BASE;
+			if (bit < NBL_MAX_NET_INTERRUPT)
+				clear_bit(bit, intr_mgt->intr_net_bmap);
+			else
+				dev_warn(res_mgt->common->dev,
+					 "invalid net intr index %u\n",
+					 intr_index);
+		} else {
+			if (intr_index < NBL_MAX_OTHER_INTERRUPT)
+				clear_bit(intr_index,
+					  intr_mgt->intr_other_bmap);
+			else
+				dev_warn(res_mgt->common->dev,
+					 "invalid other intr index %u\n",
+					 intr_index);
+		}
+	}
+}
+
+/*
+ * Internal (unlocked) mailbox IRQ bind.  Caller must hold
+ * intr_mgt->lock.  The disable path does not require a configured
+ * MSI-X map because the hardware op ignores gvec when
+ * en_msix=false.
+ */
+static int __nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+					  u16 func_id, u16 vector_id,
+					  bool en_msix)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	u16 gvec;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "func_id %u out of range\n", func_id);
+		return -EINVAL;
+	}
+
+	if (!en_msix) {
+		hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv,
+					func_id, false, 0);
+		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+		return 0;
+	}
+
+	if (!intr_mgt->func_intr_res[func_id].interrupts) {
+		dev_err(dev, "func %u MSIX map not configured\n", func_id);
+		return -ENODEV;
+	}
+
+	if (vector_id >= intr_mgt->func_intr_res[func_id].num_interrupts) {
+		dev_err(dev, "vector_id %u out of range (max %u)\n",
+			vector_id,
+			intr_mgt->func_intr_res[func_id].num_interrupts - 1);
+		return -EINVAL;
+	}
+
+	gvec = intr_mgt->func_intr_res[func_id].interrupts[vector_id];
+	hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
+				en_msix, gvec);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	return 0;
+}
+
+/*
+ * Internal (unlocked) MSI-X map teardown prepare phase: only hardware register
+ * operations. Caller must hold intr_mgt->lock.
+ */
+static int
+__nbl_res_intr_prepare_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+					u16 func)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	u16 *interrupts;
+	u16 intr_num, i;
+	int ret;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (func >= NBL_MAX_FUNC) {
+		dev_err(res_mgt->common->dev, "Invalid func_id %u\n", func);
+		return -EINVAL;
+	}
+
+	interrupts = intr_mgt->func_intr_res[func].interrupts;
+	if (!interrupts)
+		return 0;
+
+	intr_num = intr_mgt->func_intr_res[func].num_interrupts;
+
+	/* Step 0: disable mailbox IRQ routing before tearing down map */
+	ret = __nbl_res_intr_set_mailbox_irq(res_mgt, func, 0, false);
+	if (ret) {
+		dev_err(res_mgt->common->dev, "disable mailbox irq failed, func=%u ret=%d\n",
+			func, ret);
+		return ret;
+	}
+
+	/* Step 1: invalidate each MSIX info entry in hardware first */
+	for (i = 0; i < intr_num; i++) {
+		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+				      func, false, interrupts[i],
+				      0, 0, 0, false);
+	}
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	/* Stage1 tear down: retain DMA address, only clear VALID bit */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func,
+			     false,
+			     intr_mgt->func_intr_res[func].msix_map_table.dma,
+			     0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	/* Stage2: zero MSIX map entry */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func,
+			      false, 0, 0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	return 0;
+}
+
+/*
+ * __nbl_res_intr_complete_destroy_msix_map - release vector bitmap, DMA memory
+ * and interrupt buffer after global hardware quiesce. No hardware register ops.
+ *
+ * Caller must hold intr_mgt->lock.
+ */
+static int
+__nbl_res_intr_complete_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+					 u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_msix_map_table *msix_map_table;
+	u16 *interrupts;
+	u16 intr_num;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+
+	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
+	if (!interrupts)
+		return 0;
+
+	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+
+	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);
+
+	if (msix_map_table->base_addr) {
+		dma_free_coherent(dev, msix_map_table->size,
+				  msix_map_table->base_addr,
+				  msix_map_table->dma);
+		msix_map_table->base_addr = NULL;
+		msix_map_table->dma = 0;
+		msix_map_table->size = 0;
+	}
+
+	kfree(interrupts);
+	intr_mgt->func_intr_res[func_id].interrupts = NULL;
+	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+	intr_mgt->func_intr_res[func_id].num_net_interrupts = 0;
+
+	return 0;
+}
+
+/*
+ * Internal (unlocked) MSI-X map teardown.  Caller must hold
+ * intr_mgt->lock on entry.
+ * This is used for single function synchronous destroy path.
+ */
+static int __nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+					   u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	int ret;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	ret = __nbl_res_intr_prepare_destroy_msix_map(res_mgt, func_id);
+	if (ret)
+		return ret;
+	mutex_unlock(&intr_mgt->lock);
+	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
+	mutex_lock(&intr_mgt->lock);
+
+	return __nbl_res_intr_complete_destroy_msix_map(res_mgt, func_id);
+}
+
+int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+				  u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	int ret;
+
+	if (!intr_mgt)
+		return -EINVAL;
+
+	mutex_lock(&intr_mgt->lock);
+	ret = __nbl_res_intr_destroy_msix_map(res_mgt, func_id);
+	mutex_unlock(&intr_mgt->lock);
+
+	return ret;
+}
+
+/**
+ * nbl_res_intr_cfg_msix_map - allocate & program MSI-X mapping table
+ * @res_mgt: resource management instance
+ * @func_id: target function identifier
+ * @num_net_msix: required net data interrupt vectors
+ * @num_others_msix: required control interrupt vectors
+ * @net_msix_mask_en: enable mask for net interrupt entries
+ *
+ * Allocate interrupt vectors; MSIX coherent DMA table is allocated once
+ * per function on first configuration, entries are updated in-place on
+ * subsequent reconfigurations. No free/realloc of DMA table on vector
+ * count changes. This removes the DMA table free/realloc cycle,
+ * per-reconfig timed sleep and the in-flight DMA race window.
+ *
+ * Serialization: this function takes intr_mgt->lock internally to
+ * protect the global vector bitmaps and per-function state against
+ * concurrent callers.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int nbl_res_intr_cfg_msix_map(struct nbl_resource_mgt *res_mgt,
+			      u16 func_id, u16 num_net_msix,
+			      u16 num_others_msix,
+			      bool net_msix_mask_en)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_msix_map_table *official_tbl;
+	struct nbl_msix_map *msix_map_entries;
+	struct device *dev = common->dev;
+	u16 requested, intr_index;
+	u8 bus, devid, function;
+	bool entry_masked = false;
+	u16 *tmp_interrupts = NULL;
+	u16 allocated_cnt = 0;
+	u16 *old_interrupts;
+	u16 old_num;
+	int ret = 0;
+	u16 gvec;
+	u16 i, j;
+
+	if (!intr_mgt)
+		return -EINVAL;
+
+	if (!common->has_ctrl)
+		return -EINVAL;
+
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+
+	if (num_net_msix == 0 && num_others_msix == 0) {
+		dev_err(dev, "MSI-X vector count cannot both be zero\n");
+		return -EINVAL;
+	}
+
+	if (num_net_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES ||
+	    num_others_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES) {
+		dev_err(dev, "MSI-X count out of limit: net=%u, others=%u\n",
+			num_net_msix, num_others_msix);
+		return -EINVAL;
+	}
+
+	if (check_add_overflow(num_net_msix, num_others_msix, &requested) ||
+	    requested > NBL_MSIX_MAP_TABLE_MAX_ENTRIES) {
+		dev_err(dev, "Total MSI-X vectors %u exceeds maximum %u\n",
+			requested, NBL_MSIX_MAP_TABLE_MAX_ENTRIES);
+		return -EINVAL;
+	}
+
+	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
+	if (ret) {
+		if (ret == -EOPNOTSUPP)
+			dev_err(dev,
+				"MSI-X mapping for VF func_id=%u is not supported\n",
+				func_id);
+		return ret;
+	}
+
+	mutex_lock(&intr_mgt->lock);
+	official_tbl = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	/*
+	 * Phase1: allocate global vector array first.
+	 * Allocate the fixed-size MSIX DMA table only ONCE for this function.
+	 */
+	tmp_interrupts = kcalloc(requested, sizeof(tmp_interrupts[0]),
+				 GFP_KERNEL);
+	if (!tmp_interrupts) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+	/* Allocate MSIX DMA table once per function */
+	if (!official_tbl->base_addr) {
+		official_tbl->size =
+			sizeof(struct nbl_msix_map) *
+			NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
+		official_tbl->base_addr = dma_alloc_coherent(dev,
+							     official_tbl->size,
+							     &official_tbl->dma,
+							     GFP_KERNEL);
+		if (!official_tbl->base_addr) {
+			dev_err(dev, "Failed to allocate DMA memory for MSIX table\n");
+			ret = -ENOMEM;
+			goto release_vecs_unlock;
+		}
+	}
+
+	/* Allocate net interrupt vectors */
+	for (i = 0; i < num_net_msix; i++) {
+		intr_index = find_first_zero_bit(intr_mgt->intr_net_bmap,
+						 NBL_MAX_NET_INTERRUPT);
+		if (intr_index == NBL_MAX_NET_INTERRUPT) {
+			dev_err(dev, "No free net interrupt vectors left\n");
+			ret = -EAGAIN;
+			goto release_vecs_unlock;
+		}
+		tmp_interrupts[i] = intr_index + NBL_NET_INTR_BASE;
+		set_bit(intr_index, intr_mgt->intr_net_bmap);
+		allocated_cnt++;
+	}
+
+	/* Allocate other interrupt vectors */
+	for (; i < requested; i++) {
+		intr_index =
+			find_first_zero_bit(intr_mgt->intr_other_bmap,
+					    NBL_MAX_OTHER_INTERRUPT);
+		if (intr_index == NBL_MAX_OTHER_INTERRUPT) {
+			dev_err(dev, "No free control interrupt vectors left\n");
+			ret = -EAGAIN;
+			goto release_vecs_unlock;
+		}
+		tmp_interrupts[i] = intr_index;
+		set_bit(intr_index, intr_mgt->intr_other_bmap);
+		allocated_cnt++;
+	}
+
+	/*
+	 * Phase2: tear down old hardware MSIX config, release old global
+	 * vectors.
+	 * NOTE: NO DMA table free here, only invalidate HW entries and
+	 * release vec bitmap.
+	 */
+	if (intr_mgt->func_intr_res[func_id].interrupts) {
+		old_interrupts = intr_mgt->func_intr_res[func_id].interrupts;
+		old_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+
+		ret = __nbl_res_intr_set_mailbox_irq(res_mgt, func_id, 0,
+						     false);
+		if (ret) {
+			dev_err(dev, "%s: disable old mailbox irq failed, keep old config\n",
+				__func__);
+			goto release_vecs_unlock;
+		}
+		for (j = 0; j < old_num; j++) {
+			hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+					      func_id, false, old_interrupts[j],
+					      0, 0, 0, false);
+		}
+		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+		nbl_intr_release_bitmap(res_mgt, old_interrupts, old_num);
+		kfree(old_interrupts);
+		intr_mgt->func_intr_res[func_id].interrupts = NULL;
+		intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+		intr_mgt->func_intr_res[func_id].num_net_interrupts = 0;
+	}
+
+	/* Swap new vector array into func state */
+	intr_mgt->func_intr_res[func_id].interrupts = tmp_interrupts;
+	intr_mgt->func_intr_res[func_id].num_interrupts = requested;
+	intr_mgt->func_intr_res[func_id].num_net_interrupts = num_net_msix;
+	tmp_interrupts = NULL;
+
+	/*
+	 * Fill MSIX map table IN-PLACE in the pre-allocated DMA buffer.
+	 * Only zero entries beyond requested count to avoid full table
+	 * memset overhead.
+	 */
+	msix_map_entries = official_tbl->base_addr;
+	memset(msix_map_entries + requested, 0,
+	       (NBL_MSIX_MAP_TABLE_MAX_ENTRIES - requested) *
+	       sizeof(*msix_map_entries));
+
+	for (i = 0; i < requested; i++) {
+		gvec = intr_mgt->func_intr_res[func_id].interrupts[i];
+		msix_map_entries[i].data =
+			cpu_to_le16(FIELD_PREP(NBL_MSIX_MAP_VALID_MASK, 1) |
+				    FIELD_PREP(NBL_MSIX_MAP_INDEX_MASK,
+					       gvec));
+		entry_masked = (i < num_net_msix && net_msix_mask_en);
+		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+				      func_id, true, gvec,
+				      bus, devid, function,
+				      entry_masked);
+	}
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	/* Flush CPU writes to coherent memory before hardware DMA access */
+	dma_wmb();
+
+	/*
+	 * cfg_msix_map uses the control PF's own BDF (common->hw_bus etc.),
+	 * not the target function's BDF.  This BDF tags the pcompler DMA
+	 * read of the MSI-X map table as originating from the control PF.
+	 * The target function's BDF (bus/devid/function from
+	 * nbl_res_func_id_to_bdf) is used only in cfg_msix_info for the
+	 * host_msix_ctrl table entry BDF filtering.
+	 */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+			     true, official_tbl->dma, common->hw_bus,
+			     common->devid, common->function);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	mutex_unlock(&intr_mgt->lock);
+	return 0;
+
+release_vecs_unlock:
+	nbl_intr_release_bitmap(res_mgt, tmp_interrupts, allocated_cnt);
+	kfree(tmp_interrupts);
+out_unlock:
+	mutex_unlock(&intr_mgt->lock);
+	return ret;
+}
+
+/**
+ * nbl_res_intr_set_mailbox_irq - bind mailbox IRQ to specified vector
+ * @res_mgt: resource management instance
+ * @func_id: target function identifier
+ * @vector_id: index inside local interrupt array
+ * @en_msix: enable/disable mailbox interrupt
+ *
+ * Serialization: takes intr_mgt->lock internally.
+ *
+ * Return: 0 on success, negative errno on parameter or state check
+ * failure.  The hardware op is void and cannot report failure.
+ */
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool en_msix)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_common_info *common = res_mgt->common;
+	int ret;
+
+	if (!intr_mgt)
+		return -EINVAL;
+
+	if (!common->has_ctrl)
+		return -EINVAL;
+
+	mutex_lock(&intr_mgt->lock);
+	ret = __nbl_res_intr_set_mailbox_irq(res_mgt, func_id,
+					     vector_id, en_msix);
+	mutex_unlock(&intr_mgt->lock);
+
+	return ret;
+}
+
+static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
+{
+	struct nbl_interrupt_mgt *intr_mgt;
+	int err;
+
+	intr_mgt = devm_kzalloc(dev, sizeof(*intr_mgt), GFP_KERNEL);
+	if (!intr_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	err = devm_mutex_init(dev, &intr_mgt->lock);
+	if (err)
+		return ERR_PTR(err);
+
+	bitmap_zero(intr_mgt->intr_net_bmap, NBL_MAX_NET_INTERRUPT);
+	bitmap_zero(intr_mgt->intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
+
+	return intr_mgt;
+}
+
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_interrupt_mgt *intr_mgt;
+	int ret;
+
+	intr_mgt = nbl_intr_setup_mgt(dev);
+	if (IS_ERR(intr_mgt)) {
+		ret = PTR_ERR(intr_mgt);
+		return ret;
+	}
+
+	res_mgt->intr_mgt = intr_mgt;
+	return 0;
+}
+
+void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	u16 func_id;
+	int ret;
+
+	if (!intr_mgt)
+		return;
+
+	/* Phase 1: batch invalidate all hardware MSIX map entries */
+	mutex_lock(&intr_mgt->lock);
+	for (func_id = 0; func_id < NBL_MAX_FUNC; func_id++) {
+		if (intr_mgt->func_intr_res[func_id].interrupts) {
+			dev_info(res_mgt->common->dev,
+				 "intr_mgt_stop: preparing destroy map for func %u\n",
+				 func_id);
+			ret = __nbl_res_intr_prepare_destroy_msix_map(res_mgt,
+								      func_id);
+			if (ret)
+				dev_warn(res_mgt->common->dev,
+					 "intr_mgt_stop: prepare destroy map for func %u failed: %d\n",
+					 func_id, ret);
+		}
+	}
+	mutex_unlock(&intr_mgt->lock);
+
+	/*
+	 * Global quiesce: wait for straggler DMA table reads after all
+	 * MSIX map entries have been invalidated in hardware, before
+	 * freeing coherent memory. Best-effort only.
+	 */
+	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
+
+	/* Phase2: safely release MSIX coherent memory and intr resources */
+	mutex_lock(&intr_mgt->lock);
+	for (func_id = 0; func_id < NBL_MAX_FUNC; func_id++) {
+		if (intr_mgt->func_intr_res[func_id].interrupts) {
+			ret = __nbl_res_intr_complete_destroy_msix_map(res_mgt,
+								       func_id);
+			if (ret)
+				dev_warn(res_mgt->common->dev,
+					 "intr_mgt_stop: complete destroy map for func %u failed: %d\n",
+					 func_id, ret);
+		}
+	}
+	mutex_unlock(&intr_mgt->lock);
+
+	res_mgt->intr_mgt = NULL;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
new file mode 100644
index 000000000000..9f66f5e19c98
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_INTERRUPT_H_
+#define _NBL_INTERRUPT_H_
+
+#include "nbl_resource.h"
+
+#define NBL_MSIX_MAP_TABLE_MAX_ENTRIES	1024
+int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+				  u16 func_id);
+int nbl_res_intr_cfg_msix_map(struct nbl_resource_mgt *res_mgt,
+			      u16 func_id, u16 num_net_msix,
+			      u16 num_others_msix,
+			      bool net_msix_mask_en);
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool en_msix);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
index 6fa0e0d550f4..411790adfb39 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -68,6 +68,38 @@ int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
 	return -ENOENT;
 }
 
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_sriov_info *sriov_info;
+	int pfid = func_id;
+	u8 pf_bus, devfn;
+	u32 rel_pf_id;
+	int ret;
+
+	if (!common->has_ctrl || !bus || !dev || !function)
+		return -EINVAL;
+	ret = nbl_common_func_id_to_rel_pf_id(common, pfid, &rel_pf_id);
+	if (ret)
+		return ret;
+	if (rel_pf_id >= common->max_pf) {
+		dev_err(common->dev,
+			"func_id=%u rel_pf_id=%u exceeds max_pf=%u, VF BDF unsupported\n",
+			pfid, rel_pf_id,
+			common->max_pf);
+		return -EOPNOTSUPP;
+	}
+	sriov_info = res_mgt->resource_info->sriov_info + rel_pf_id;
+	pf_bus = PCI_BUS_NUM(sriov_info->bdf);
+	devfn = sriov_info->bdf & 0xff;
+	*bus = pf_bus;
+	*dev = PCI_SLOT(devfn);
+	*function = PCI_FUNC(devfn);
+
+	return 0;
+}
+
 int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
 		       u16 vsi_id, u8 *eth_num, u8 *eth_id, u8 *logic_eth_id)
 {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index a3bc7b3aecde..5f0dfc74c068 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -17,6 +17,39 @@
 
 struct nbl_resource_mgt;
 
+/* --------- INTERRUPT ---------- */
+#define NBL_MAX_OTHER_INTERRUPT			1024
+#define NBL_MAX_NET_INTERRUPT			4096
+#define NBL_NET_INTR_BASE		NBL_MAX_OTHER_INTERRUPT
+
+#define NBL_MSIX_MAP_VALID_MASK		BIT(0)
+#define NBL_MSIX_MAP_INDEX_MASK		GENMASK(13, 1)
+#define NBL_MSIX_MAP_RSV_MASK		GENMASK(15, 14)
+
+struct nbl_msix_map {
+	__le16 data;
+};
+
+struct nbl_msix_map_table {
+	struct nbl_msix_map *base_addr;
+	dma_addr_t dma;
+	size_t size;
+};
+
+struct nbl_func_interrupt_resource_mng {
+	u16 num_interrupts;
+	u16 num_net_interrupts;
+	u16 *interrupts;
+	struct nbl_msix_map_table msix_map_table;
+};
+
+struct nbl_interrupt_mgt {
+	struct mutex lock; /* Protects bitmap + func_intr_res[] */
+	DECLARE_BITMAP(intr_net_bmap, NBL_MAX_NET_INTERRUPT);
+	DECLARE_BITMAP(intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
+	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
+};
+
 /* --------- INFO ---------- */
 struct nbl_sriov_info {
 	unsigned int bdf;
@@ -59,14 +92,19 @@ struct nbl_resource_mgt {
 	struct nbl_resource_info *resource_info;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_interrupt_mgt *intr_mgt;
 };
 
 int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
 int nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			      u16 type, u16 *vsi_id);
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function);
 int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
 		       u16 vsi_id, u8 *eth_num, u8 *eth_id, u8 *logic_eth_id);
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
 int nbl_res_pf_dev_vsi_type_to_hw_vsi_type(struct nbl_resource_mgt *res_mgt,
 					   u16 src_type,
 					   enum nbl_vsi_serv_type *dst_type);
+void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 095ff548c4a7..b9b92c42f276 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -12,6 +12,13 @@ struct nbl_board_port_info;
 struct nbl_hw_mgt;
 struct nbl_adapter;
 struct nbl_hw_ops {
+	void (*cfg_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+			     bool valid, dma_addr_t dma_addr, u8 bus,
+			     u8 devid, u8 function);
+	void (*cfg_msix_info)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+			      bool valid, u16 interrupt_id, u8 bus,
+			      u8 devid, u8 function,
+			      bool net_msix_mask_en);
 	void (*flush_write)(struct nbl_hw_mgt *hw_mgt);
 	void (*update_mailbox_queue_tail_ptr)(struct nbl_hw_mgt *hw_mgt,
 					      u16 tail_ptr, u8 txrx);
@@ -45,6 +52,8 @@ struct nbl_hw_ops {
 
 	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				  u8 bus, u8 devid, u8 function);
+	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				bool en_msix, u16 gvec);
 	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
 	/**
 	 * get_board_info - Fetch board info from firmware
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 7136b282fb80..e718ea41a816 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -12,6 +12,12 @@ struct nbl_resource_mgt;
 struct nbl_adapter;
 
 struct nbl_resource_ops {
+	int (*cfg_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			    u16 num_net_msix, u16 num_others_msix,
+			    bool net_msix_mask_en);
+	int (*destroy_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id);
+	int (*set_mailbox_irq)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			       u16 vector_id, bool en_msix);
 	int (*get_vsi_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			  u16 type, u16 *vsi_id);
 	int (*get_eth_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 59e44feab44f..2c959832c32f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -13,6 +13,7 @@
 #define NBL_MAX_PF					8
 #define NBL_NEXT_ID(id, max) (((id) + 1) % ((max) + 1))
 
+#define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
 
 enum {
-- 
2.47.3

