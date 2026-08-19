Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A21AC44D;
	Wed, 19 Aug 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098349; cv=none; b=uL624nAzu1GO3kC9wfyKwUPGvvcwIxxz9Hedk9y5WbZxo9N8vDfJr+dEFqL2ak1JjE0z26Lz/3rzg1tf1H91atpG/OSrBmyaa8laK6FH/7Q5qiwoR2vm1KhGd2KD+339zB6T0kk5d5WNOOsDkdbzDDAsV9/Kd5t1gPBLKKGtIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098349; c=relaxed/simple;
	bh=jh5elXKRv6OA4jypk6XMSop82gc5d4iKPywd1Ljk5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev15vG9C70Qrzu9e8wUl68Qaix4mYHjHmq6L0EFxEenlSQuD59WnW4S9aCfoHwdxPWCn5dBWR2HaURe+NHlo7O649CEpUq6oLrOaJyK8u/mIZdFYFkz0tPIXYw+QQI/q0PfwdjIswoo5fJMMU6s2v+viQh34dJeVI802CiUUKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.7838945;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0810535-0.00229122-0.916655;FP=9464171943869140138|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iqi7nW9_1787098333;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iqi7nW9_1787098333 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 08:12:14 +0800
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
Subject: [PATCH v25 net-next 05/10] net/nebula-matrix: add intr resource implementation
Date: Wed, 19 Aug 2026 08:11:07 +0800
Message-ID: <20260819001117.46785-6-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
References: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Introduce nbl_interrupt module to manage driver-wide global MSI-X vector
index space, and extend hw_ops with hardware callbacks to program
vendor-specific internal MSI-X mapping registers, populate MSI-X metadata,
and bind interrupt vectors to PF mailbox channels.
Core interfaces:
1. cfg_msix_map
Allocates global MSI-X indices from independent network/other interrupt
bitmaps (intr_net_bmap, intr_other_bmap). All coherent DMA buffers for
new configuration are allocated upfront; old hardware state is torn down
only after new allocation succeeds to avoid interrupt loss. Writes
MSI-X table DMA address and PF BDF into NBL_PCOMPLETER_FUNCTION_MSIX_MAP.
Physical PCI MSI-X vector allocation lives in device layer via
nbl_dev_init_interrupt_scheme().
2. destroy_msix_map
Recycle global MSI-X vectors, clear hardware MSI-X mappings, release
coherent DMA memory and interrupt descriptor array. A bounded sleep is
inserted prior to DMA deallocation to prevent IOMMU faults from lingering
hardware DMA access after MMIO disables the mapping. Two-stage teardown
avoids torn hardware read states by retaining valid DMA addresses before
clearing hardware valid bits.
3. set_mailbox_irq
Toggle mailbox MSI-X routing for a specific PF by updating
NBL_MAILBOX_QINFO_MAP_REG_ARR with the assigned global vector ID. All
register RMW operations are serialized by per-device reg_lock to prevent
concurrent hardware register corruption.
4. cfg_msix_info
Program PADPT_HOST_MSIX_INFO & PCOMPLETER_HOST_MSIX_FID_TABLE to record
each vector's PF BDF and MSI-X enable mask attributes, with strict
programming/teardown order to avoid inconsistent hardware state.
This module solely manages the chip's internal MSI-X routing table and
software vector allocator. It never calls kernel PCI MSI-X allocation
APIs (pci_alloc_irq_vectors() etc.); physical PCI MSI-X vector
allocation is handled separately by the device layer.
The interrupt manager is instantiated via nbl_intr_mgt_start() during
resource initialization and attached to the resource management context.
Locking note: exclusive serialization of cfg_msix_map / destroy_msix_map /
set_mailbox_irq is guaranteed by the dispatch-layer mutex introduced in
a subsequent RPC framework patch. Callers must hold the corresponding lock.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 152 ++++++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  42 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  12 +-
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 402 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  30 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  35 ++
 .../nbl/nbl_include/nbl_def_hw.h              |  10 +
 .../nbl/nbl_include/nbl_def_resource.h        |   6 +
 .../nbl/nbl_include/nbl_include.h             |   1 +
 12 files changed, 710 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index c522ce8ac270..6f14c8e8fd60 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -8,4 +8,5 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_interrupt.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 1ed2928b9a1c..04c695ea13a7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -46,6 +46,30 @@ static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
 		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), data[i]);
 }
 
+static void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+			   u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	for (i = 0; i < size; i++)
+		data[i] = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+}
+
+static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
+			   u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	for (i = 0; i < size; i++)
+		wr32(hw_mgt->hw_addr, reg + i * sizeof(u32), data[i]);
+}
+
 static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
 				u32 len)
 {
@@ -90,6 +114,124 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
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
+				   bool en_msix, u16 global_vec_id)
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
+				   global_vec_id) |
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
@@ -210,6 +352,10 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.cfg_msix_map = nbl_hw_cfg_msix_map,
+	.cfg_msix_info = nbl_hw_cfg_msix_info,
+	.flush_write = nbl_flush_writes,
+
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -219,6 +365,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.set_mailbox_irq = nbl_hw_set_mailbox_irq,
 
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
@@ -249,11 +396,12 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
 	hw_ops_tbl = devm_kzalloc(dev, sizeof(*hw_ops_tbl), GFP_KERNEL);
 	if (!hw_ops_tbl)
 		return ERR_PTR(-ENOMEM);
-	if (!hw_ops.update_mailbox_queue_tail_ptr ||
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
index 88772a11124a..fed2fb16bff8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -68,6 +68,48 @@ struct nbl_mailbox_qinfo_cfg_table {
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
index efca81ff06d0..940530acb5f6 100644
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
@@ -41,7 +44,10 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
 	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
 	if (!res_ops_tbl)
 		return ERR_PTR(-ENOMEM);
-
+	if (!res_ops.get_vsi_id || !res_ops.get_eth_id  ||
+	    !res_ops.cfg_msix_map || !res_ops.destroy_msix_map ||
+	    !res_ops.set_mailbox_irq)
+		return ERR_PTR(-EINVAL);
 	res_ops_tbl->ops = &res_ops;
 	res_ops_tbl->priv = res_mgt;
 
@@ -285,6 +291,10 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
 		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
 		if (ret)
 			return ret;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
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
index 000000000000..52872264e906
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,402 @@
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
+#define NBL_MSIX_DMA_SYNC_MIN_US	100
+#define NBL_MSIX_DMA_SYNC_MAX_US	120
+
+static void nbl_intr_release_bitmap(struct nbl_resource_mgt *res_mgt,
+				    u16 *vec_buf, u16 cnt)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	u16 bit;
+	u16 i;
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
+int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+				  u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_msix_map_table *msix_map_table;
+	u16 *interrupts;
+	u16 intr_num, i;
+	dma_addr_t live_dma;
+
+	if (!res_mgt->common->has_ctrl)
+		return -EINVAL;
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+
+	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+
+	if (!interrupts || !msix_map_table->base_addr) {
+		dev_dbg(dev, "No interrupt resources for func %u\n", func_id);
+		return 0;
+	}
+
+	live_dma = msix_map_table->dma;
+
+	/* Step 1: mask each MSIX vector in hardware first */
+	for (i = 0; i < intr_num; i++) {
+		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+				      func_id, false, interrupts[i],
+				      0, 0, 0, false);
+	}
+
+	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);
+
+	/*
+	 * Stage 1 tear down: retain valid DMA address, ONLY clear VALID bit
+	 * avoid hardware torn read (VALID=1 & dma_addr=0)
+	 */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+			     false, live_dma, 0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	/*
+	 * Hardware provides no idle status register for MSIX map DMA engine.
+	 * Use bounded sleep to mitigate race between posted MMIO disable writes
+	 * and ongoing in-flight table read DMA access.
+	 * After sleep, hardware no longer performs DMA access to MSIX table.
+	 */
+	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
+
+	/*
+	 * Stage 2: hardware has quiesced MSIX table DMA access,
+	 * fully zero MSIX map entry safely now
+	 */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+			     false, 0, 0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	/*
+	 * Now safe to release old MSIX DMA memory, prevents devres accumulation
+	 * leak Since hardware DMA has quiesced after sleep, no IOMMU fault risk
+	 * anymore.
+	 */
+	if (msix_map_table->base_addr) {
+		dmam_free_coherent(dev, msix_map_table->size,
+				   msix_map_table->base_addr,
+				   msix_map_table->dma);
+	}
+
+	/* Release runtime allocated interrupt vector buffer */
+	kfree(intr_mgt->func_intr_res[func_id].interrupts);
+	intr_mgt->func_intr_res[func_id].interrupts = NULL;
+	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+	intr_mgt->func_intr_res[func_id].num_net_interrupts = 0;
+
+	/* Clear stale MSIX table pointers for safety */
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+	msix_map_table->size = 0;
+
+	return 0;
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
+ * Allocate interrupt vectors and coherent DMA table in advance;
+ * only destroy old configuration once all allocations succeed.
+ *
+ * Note: There exists a transient window after tearing down old MSI-X hardware
+ * state before programming new mapping. Atomic table swap is unsupported on
+ * current silicon, this gap is accepted as hardware limitation.
+ *
+ * Caller note: this function has no internal locking. Serialization
+ * must be guaranteed at upper dispatch layer.
+ *
+ * Old MSIX table memory will be explicitly freed inside destroy_msix_map()
+ * after waiting for hardware DMA quiesce, so repeated reconfiguration will not
+ * accumulate devres-managed DMA memory.
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
+	struct nbl_msix_map_table *tmp_msix_tbl = NULL;
+	struct nbl_msix_map_table *official_tbl;
+	struct nbl_msix_map *msix_map_entries;
+	struct device *dev = common->dev;
+	u16 requested, intr_index;
+	u8 bus, devid, function;
+	bool msix_mask_en = false;
+	u16 *tmp_interrupts = NULL;
+	u16 global_vec;
+	int ret = 0;
+	u16 i;
+
+	if (!common->has_ctrl)
+		return -EINVAL;
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+	if (num_net_msix == 0 && num_others_msix == 0) {
+		dev_err(dev, "MSI-X vector count cannot both be zero\n");
+		return -EINVAL;
+	}
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
+	if (ret)
+		return ret;
+
+	/*
+	 * Phase1: Pre-allocate ALL new resources first.
+	 * Do NOT destroy old configuration before all allocations succeed.
+	 */
+	tmp_msix_tbl = kzalloc_obj(*tmp_msix_tbl);
+	if (!tmp_msix_tbl) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tmp_msix_tbl->size =
+		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
+	/*
+	 * Hardware requires fixed stride table layout; allocate full size
+	 * even when only partial entries are used. Memory managed by devm.
+	 */
+	tmp_msix_tbl->base_addr = dmam_alloc_coherent(dev, tmp_msix_tbl->size,
+						      &tmp_msix_tbl->dma,
+						      GFP_KERNEL);
+	if (!tmp_msix_tbl->base_addr) {
+		dev_err(dev, "Failed to allocate DMA memory for MSIX table\n");
+		ret = -ENOMEM;
+		goto free_tmp_tbl;
+	}
+
+	tmp_interrupts = kcalloc(requested, sizeof(tmp_interrupts[0]),
+				 GFP_KERNEL);
+	if (!tmp_interrupts) {
+		ret = -ENOMEM;
+		goto free_tmp_tbl;
+	}
+
+	/* Allocate net interrupt vectors */
+	for (i = 0; i < num_net_msix; i++) {
+		intr_index = find_first_zero_bit(intr_mgt->intr_net_bmap,
+						 NBL_MAX_NET_INTERRUPT);
+		if (intr_index == NBL_MAX_NET_INTERRUPT) {
+			dev_err(dev, "No free net interrupt vectors left\n");
+			ret = -EAGAIN;
+			goto release_vecs;
+		}
+		tmp_interrupts[i] = intr_index + NBL_NET_INTR_BASE;
+		set_bit(intr_index, intr_mgt->intr_net_bmap);
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
+			goto release_vecs;
+		}
+		tmp_interrupts[i] = intr_index;
+		set_bit(intr_index, intr_mgt->intr_other_bmap);
+	}
+
+	/*
+	 * Phase2: All new resource allocation succeeded.
+	 * Now tear down old MSIX hardware configuration.
+	 */
+	ret = nbl_res_intr_destroy_msix_map(res_mgt, func_id);
+	if (ret)
+		goto release_vecs;
+
+	/* Swap temporary resources into official entry */
+	official_tbl = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	official_tbl->base_addr = tmp_msix_tbl->base_addr;
+	official_tbl->dma = tmp_msix_tbl->dma;
+	official_tbl->size = tmp_msix_tbl->size;
+	kfree(tmp_msix_tbl);
+	tmp_msix_tbl = NULL;
+
+	intr_mgt->func_intr_res[func_id].interrupts = tmp_interrupts;
+	intr_mgt->func_intr_res[func_id].num_interrupts = requested;
+	intr_mgt->func_intr_res[func_id].num_net_interrupts = num_net_msix;
+	tmp_interrupts = NULL;
+
+	/* Fill MSIX map table and program hardware */
+	msix_map_entries = official_tbl->base_addr;
+	for (i = 0; i < requested; i++) {
+		global_vec = intr_mgt->func_intr_res[func_id].interrupts[i];
+		msix_map_entries[i].data =
+			cpu_to_le16(FIELD_PREP(NBL_MSIX_MAP_VALID_MASK, 1) |
+				    FIELD_PREP(NBL_MSIX_MAP_INDEX_MASK,
+					       global_vec));
+
+		msix_mask_en = (i < num_net_msix && net_msix_mask_en) ? true :
+									false;
+		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+				      func_id, true, global_vec,
+				      bus, devid, function,
+				      msix_mask_en);
+	}
+
+	/* Flush CPU writes to coherent memory before hardware DMA access */
+	dma_wmb();
+
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+			     true, official_tbl->dma, common->hw_bus,
+			     common->devid, common->function);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+out:
+	return ret;
+
+release_vecs:
+	nbl_intr_release_bitmap(res_mgt, tmp_interrupts, i);
+free_tmp_tbl:
+	/* Release DMA buffer allocated by dmam_alloc_coherent first */
+	if (tmp_msix_tbl && tmp_msix_tbl->base_addr) {
+		dmam_free_coherent(dev, tmp_msix_tbl->size,
+				   tmp_msix_tbl->base_addr,
+				   tmp_msix_tbl->dma);
+	}
+	kfree(tmp_msix_tbl);
+	kfree(tmp_interrupts);
+	tmp_msix_tbl = NULL;
+	tmp_interrupts = NULL;
+	goto out;
+}
+
+/**
+ * nbl_res_intr_set_mailbox_irq - bind mailbox IRQ to specified vector
+ * @res_mgt: resource management instance
+ * @func_id: target function identifier
+ * @vector_id: index inside local interrupt array
+ * @en_msix: enable/disable mailbox interrupt
+ *
+ * Caller note: this function has no internal locking. Serialization
+ * must be guaranteed at upper dispatch layer.
+ *
+ * Return: 0 on success, negative errno on parameter check or hw failure
+ */
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool en_msix)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	u16 global_vec_id;
+
+	if (!common->has_ctrl)
+		return -EINVAL;
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "func_id %u out of range\n", func_id);
+		return -EINVAL;
+	}
+	if (!intr_mgt->func_intr_res[func_id].interrupts) {
+		dev_err(dev, "func %u MSIX map not configured\n", func_id);
+		return -ENODEV;
+	}
+	if (vector_id >= intr_mgt->func_intr_res[func_id].num_interrupts) {
+		dev_err(dev, "vector_id %u out of range (max %u)\n",
+			vector_id,
+			intr_mgt->func_intr_res[func_id].num_interrupts - 1);
+		return -EINVAL;
+	}
+
+	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];
+	hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
+				en_msix, global_vec_id);
+
+	return 0;
+}
+
+static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
+{
+	struct nbl_interrupt_mgt *intr_mgt;
+
+	intr_mgt = devm_kzalloc(dev, sizeof(*intr_mgt), GFP_KERNEL);
+	if (!intr_mgt)
+		return ERR_PTR(-ENOMEM);
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
+	res_mgt->intr_mgt = intr_mgt;
+	return 0;
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
index 6fa0e0d550f4..48d727718f0b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -68,6 +68,36 @@ int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
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
+	if (rel_pf_id >= res_mgt->resource_info->max_pf) {
+		dev_err(common->dev, "PF ID %u exceeds maximum supported PF count %u\n",
+			pfid, res_mgt->resource_info->max_pf);
+		return -ERANGE;
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
index 648481cc21c1..e2d0f04fdfb7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -17,6 +17,38 @@
 
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
+	DECLARE_BITMAP(intr_net_bmap, NBL_MAX_NET_INTERRUPT);
+	DECLARE_BITMAP(intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
+	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
+};
+
 /* --------- INFO ---------- */
 struct nbl_sriov_info {
 	unsigned int bdf;
@@ -66,8 +98,11 @@ struct nbl_resource_mgt {
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index ee53f9e10a8e..fd86eef4a0d3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -12,6 +12,14 @@ struct nbl_board_port_info;
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
+	void (*flush_write)(struct nbl_hw_mgt *hw_mgt);
 	void (*update_mailbox_queue_tail_ptr)(struct nbl_hw_mgt *hw_mgt,
 					      u16 tail_ptr, u8 txrx);
 	void (*config_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt,
@@ -39,6 +47,8 @@ struct nbl_hw_ops {
 
 	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				  u8 bus, u8 devid, u8 function);
+	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				bool en_msix, u16 global_vec_id);
 	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
 	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
 			       struct nbl_board_port_info *board);
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

