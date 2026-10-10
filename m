Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6E45348D;
	Sat, 10 Oct 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626408; cv=none; b=ob5O8X1xubec+IfezPlbGKzv844uoMw9+g7KKkO6dYuLTQ6+/LfYE1poUNN8GctFlFCmXRLHIXYcR0ddy+Q+VWCFHlncCk8a62sIHNwizrtBiQNCTLk7KzA6EUzqfvnmPGubw6BLhwY7atkbyw8avg4FFxMLZUlapDUPFWlnN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626408; c=relaxed/simple;
	bh=wY6KIadYCJoSYglf8zOfcH0TnxRv/hXMXKrA3AOd/0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPLB1hrVbIZI3ITUZziCPVUluMovieNRp/2M5gjLuOkDY++5JImxQ4baPtMeE4MthL03Zpp3Mrz0Shh5NRU9xyat07ni0gQ1meb29MOVRNv6nkimYfxcZ7prwlX0dTVugnW4qzHzh4kBjYeL3RQfja+JUnE1/GcyHOgkkocgdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.8895053;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.040116-0.0018242-0.95806;FP=9463187056329575594|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jYOxjo7_1791626386;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jYOxjo7_1791626386 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 10 Oct 2026 17:59:47 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v31 net-next 3/8] net/nebula-matrix: add intr resource implementation
Date: Sat, 10 Oct 2026 17:59:26 +0800
Message-ID: <20261010095939.2230-4-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010095939.2230-1-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add an nbl_interrupt module that manages the driver-wide, chip-internal
MSI-X vector index space and the chip MSI-X mapping tables. It does not
manage the physical PCI MSI-X entries; those are set up in a follow-up
patch by nbl_dev_init_interrupt_scheme().

The global vector space is split into separate net and control bitmaps
(intr_net_bmap/intr_other_bmap). A single intr_mgt->lock protects the
bitmaps and the per-function state and is taken internally by every
public API, so callers need no extra locking. Only PFs are supported;
VF ids are rejected with -EOPNOTSUPP.

The module provides three resource ops:
- cfg_msix_map: allocate global vectors from the two bitmaps and program
  NBL_PCOMPLETER_FUNCTION_MSIX_MAP with the table DMA address and the
  control PF's BDF. The per-function coherent table is allocated once and
  reused on later reconfigurations, which removes the table free/realloc
  cycle. The new vector set is allocated before the old hardware state is
  torn down, so a failed reconfiguration leaves the old configuration
  intact.
- destroy_msix_map: two-stage teardown. Disable mailbox IRQ routing,
  invalidate the per-vector INFO entries, clear the map VALID bit while
  keeping the live DMA address, wait ~1 ms for in-flight table fetches,
  then zero the entry and free the coherent table. The wait is
  best-effort, as the chip exposes no fetch completion status.
- set_mailbox_irq: bind or unbind a PF's mailbox routing via
  NBL_MAILBOX_QINFO_MAP_REG_ARR. The disable path works without a
  configured map, so routing can be cleaned up before vectors are
  released.

The hardware helpers program PADPT_HOST_MSIX_INFO and
PCOMPLETER_HOST_MSIX_FID_TABLE in forward order on enable and reverse
order on teardown, to avoid inconsistent hardware state.

The module also adds register definitions and resource ops callbacks,
and instantiates the manager via nbl_intr_mgt_start() during resource
init. nbl_intr_mgt_stop() is the global teardown, called from
nbl_res_remove_leonis().

The new resource ops are hooked into resource_ops but have no in-tree
caller in this patch; invocation is added in later patches of the series.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 164 +++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  44 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  38 +-
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 801 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  77 ++
 .../nbl/nbl_include/nbl_def_hw.h              |   9 +
 .../nbl/nbl_include/nbl_def_resource.h        |   6 +
 11 files changed, 1189 insertions(+), 5 deletions(-)
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
index 9db7a2adbcc9..1712cdbc5fe7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -97,6 +97,20 @@ static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
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
  * Flush posted MEMORY-BAR writes by reading back a register that only
  * exists in the control-PF mapping.
@@ -136,6 +150,148 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
 	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
 }
 
+/*
+ * nbl_hw_set_mailbox_irq - read-modify-write NBL_MAILBOX_QINFO_MAP_REG_ARR
+ *
+ * The full RMW sequence is wrapped by reg_lock, so concurrent register
+ * access from different CPUs is already serialized safely.
+ * nbl_hw_cfg_mailbox_qinfo() programs the BDF fields during control-PF
+ * init and clears MSIX_IDX/MSIX_IDX_VALID at the same time (they survive
+ * kexec/forced unload without FLR), so mailbox MSIX routing for a PF
+ * starts disarmed at init and is armed only by an explicit en_msix=true
+ * call here.
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
+
+	/*
+	 * Clear VALID on its own first.  nbl_hw_wr_regs_lock() writes an
+	 * entry in ascending dword order, so a single whole-entry write
+	 * would publish the new (or zeroed) address in data[0]/data[1]
+	 * while the old VALID bit in data[2] was still set, exposing a
+	 * valid entry with a half-written address to the pcompleter's
+	 * table fetch.  With VALID already zero only the address words
+	 * change, and no fetch can be started from a torn entry.
+	 */
+	nbl_hw_wr_regs_lock(hw_mgt,
+			    NBL_PCOMPLETER_FUNCTION_MSIX_MAP(func_id) +
+			    NBL_FUNC_MSIX_MAP_VALID_DW * sizeof(u32),
+			    &function_msix_map.data[NBL_FUNC_MSIX_MAP_VALID_DW],
+			    sizeof(u32));
+
+	if (valid) {
+		/* program full entry and set VALID */
+		function_msix_map.data[0] = lower_32_bits(dma_addr);
+		function_msix_map.data[1] = upper_32_bits(dma_addr);
+		function_msix_map.data[2] =
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_FUNCTION_MASK,
+				   function) |
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_DEVID_MASK, devid) |
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_BUS_MASK, bus) |
+			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_VALID_MASK, 1);
+
+		nbl_hw_wr_regs_lock(hw_mgt,
+				    NBL_PCOMPLETER_FUNCTION_MSIX_MAP(func_id),
+				    function_msix_map.data,
+				    sizeof(function_msix_map));
+	} else {
+		/*
+		 * reg_lock prevents concurrent CPU writes to the same
+		 * function's MSIX entry, but cannot synchronize hardware DMA
+		 * reads. Upper layer uses two-stage destruction + sync sleep
+		 * to avoid torn hardware read of partial MSIX entry.
+		 * VALID is already cleared above, so the address written
+		 * here is either the still-live table (prepare) or zero
+		 * (complete); data[2] stays zero, leaving the BDF fields
+		 * unused because the entry cannot be fetched.
+		 */
+		function_msix_map.data[0] = lower_32_bits(dma_addr);
+		function_msix_map.data[1] = upper_32_bits(dma_addr);
+
+		nbl_hw_wr_regs_lock(hw_mgt,
+				    NBL_PCOMPLETER_FUNCTION_MSIX_MAP(func_id),
+				    function_msix_map.data,
+				    sizeof(function_msix_map));
+	}
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
@@ -271,6 +427,8 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.cfg_msix_map = nbl_hw_cfg_msix_map,
+	.cfg_msix_info = nbl_hw_cfg_msix_info,
 	.flush_write = nbl_flush_writes,
 
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
@@ -282,6 +440,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.set_mailbox_irq = nbl_hw_set_mailbox_irq,
 
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
@@ -312,11 +471,12 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
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
index 251dd68d0721..b7c0a87c1dad 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -54,6 +54,50 @@ struct nbl_mailbox_qinfo_cfg_table {
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
+/* pcompleter_host function_msix_map_table */
+#define NBL_PCOMPLETER_FUNCTION_MSIX_MAP(i)   \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00004000 + \
+	 (i) * sizeof(struct nbl_function_msix_map))
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(i) \
+	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x0003a000 + (i) * sizeof(u32))
+
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_FID_MASK  GENMASK(9, 0)
+#define NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_VLD_MASK  BIT(10)
+
+#define NBL_FUNC_MSIX_MAP_DWLEN		4
+/* The VLD/BDF fields live in data[2]; it can be cleared on its own */
+#define NBL_FUNC_MSIX_MAP_VALID_DW	2
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
index 7804762a96e0..72b5b889dedb 100644
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
@@ -282,6 +287,10 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
 		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
 		if (ret)
 			return ret;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -322,8 +331,31 @@ int nbl_res_init_leonis(struct nbl_adapter *adap)
 
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
+	 * Tear down all MSI-X maps before destroying coherent tables.
+	 * This is critical on the control PF, whose table carries the map
+	 * entries installed for every configured function: they must be
+	 * invalidated in hardware before the tables backing them are
+	 * freed, otherwise the device keeps DMA-reading released pages.
+	 * Sibling PFs are already unbound by the device-link ordering
+	 * so no remote PF still has a live map entry or a running
+	 * mailbox RPC at this point.
+	 */
+	if (common->has_ctrl && res_mgt->intr_mgt)
+		nbl_intr_mgt_stop(res_mgt);
+
+	/* Note:
+	 * per-function interrupts arrays (kcalloc) are freed by
+	 * nbl_intr_mgt_stop().
+	 * MSIX coherent tables are explicitly freed by dma_free_coherent()
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
index 000000000000..3048af5bfeed
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,801 @@
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
+ * Bounded best-effort wait for in-flight pcompleter fetches of a MSI-X
+ * map table after that entry's VALID bit has been cleared and flushed.
+ *
+ * The chip exposes no idle/completion status for those fetches, so the
+ * only ordering available is: clear VALID -> flush_write() -> wait.  The
+ * window is sized well above the tables' worst-case fetch/response
+ * latency; it is not a guarantee, and it protects two things:
+ *   - the coherent table that __nbl_res_intr_complete_destroy_msix_map()
+ *     is about to dma_free_coherent();
+ *   - the vector set that a reconfiguration is about to hand to another
+ *     function.
+ * A future caller that cannot tolerate the residual risk must keep the
+ * table allocated for the lifetime of the function instead of relying on
+ * this delay.
+ */
+static void nbl_intr_quiesce_wait(void)
+{
+	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
+}
+
+/*
+ * Release global vector IDs back to intr_net_bmap / intr_other_bmap.
+ * Caller must hold intr_mgt->lock, passing the intr_mgt it locked:
+ * nbl_intr_mgt_stop() clears res_mgt->intr_mgt while a caller may
+ * already be blocked on that mutex, so it must not be re-read here.
+ */
+static void nbl_intr_release_bitmap(struct nbl_interrupt_mgt *intr_mgt,
+				    struct nbl_resource_mgt *res_mgt,
+				    u16 *vec_buf, u16 cnt)
+{
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
+ * intr_mgt->lock, passing the intr_mgt it locked (see
+ * nbl_intr_release_bitmap()).
+ *
+ * The disable path deliberately carries no state check: the teardown
+ * sequence uses it to disarm routing while func_res->state is still
+ * CONFIGURED, and it stays harmless after nbl_intr_mgt_stop() because
+ * the hardware op ignores gvec when en_msix=false.  Only the enable
+ * path is gated by the stopping latch and the per-function state.
+ */
+static int __nbl_res_intr_set_mailbox_irq(struct nbl_interrupt_mgt *intr_mgt,
+					  struct nbl_resource_mgt *res_mgt,
+					  u16 func_id, u16 vector_id,
+					  bool en_msix)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	struct nbl_func_interrupt_resource_mng *func_res;
+	u16 gvec;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	/* func_intr_res[] is PF-indexed, VFs are rejected earlier */
+	if (func_id >= NBL_MAX_PF) {
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
+	/*
+	 * Enable path: the map must be live and not under teardown,
+	 * otherwise routing would point at a vector that the complete
+	 * phase is about to release and never re-disables.
+	 */
+	if (intr_mgt->stopping)
+		return -ESHUTDOWN;
+
+	func_res = &intr_mgt->func_intr_res[func_id];
+	if (func_res->state != NBL_INTR_FUNC_CONFIGURED) {
+		dev_err(dev, "func %u MSIX map not configured (state %u)\n",
+			func_id, func_res->state);
+		return -ENODEV;
+	}
+
+	if (vector_id >= func_res->num_interrupts) {
+		dev_err(dev, "vector_id %u out of range (max %u)\n",
+			vector_id, func_res->num_interrupts - 1);
+		return -EINVAL;
+	}
+
+	gvec = func_res->interrupts[vector_id];
+	hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
+				en_msix, gvec);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	return 0;
+}
+
+/*
+ * Internal (unlocked) MSI-X map teardown prepare phase: only hardware
+ * register operations. The DMA address is retained and only the VALID
+ * bit is cleared; zeroing the address (Stage 2) is deferred to the
+ * complete phase after the hardware-DMA quiesce window.
+ *
+ * Caller must hold intr_mgt->lock.
+ */
+static int
+__nbl_res_intr_prepare_destroy_msix_map(struct nbl_interrupt_mgt *intr_mgt,
+					struct nbl_resource_mgt *res_mgt,
+					u16 func)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_func_interrupt_resource_mng *func_res;
+	u16 *interrupts;
+	u16 intr_num, i;
+	int ret;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (func >= NBL_MAX_PF) {
+		dev_err(res_mgt->common->dev, "Invalid func_id %u\n", func);
+		return -EINVAL;
+	}
+
+	func_res = &intr_mgt->func_intr_res[func];
+	if (func_res->state != NBL_INTR_FUNC_CONFIGURED)
+		return 0;
+
+	interrupts = func_res->interrupts;
+	intr_num = func_res->num_interrupts;
+
+	/* Step 0: disable mailbox IRQ routing before tearing down map */
+	ret = __nbl_res_intr_set_mailbox_irq(intr_mgt, res_mgt, func, 0, false);
+	if (ret) {
+		dev_err(res_mgt->common->dev,
+			"disable mailbox irq failed, func=%u ret=%d\n",
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
+	/*
+	 * Stage 1: retain the DMA address, only clear the VALID bit.
+	 * Stage 2 runs after the quiesce window in the complete phase.
+	 */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func,
+			     false, func_res->msix_map_table.dma,
+			     0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	func_res->state = NBL_INTR_FUNC_DESTROYING;
+
+	return 0;
+}
+
+/*
+ * __nbl_res_intr_complete_destroy_msix_map - finish hardware teardown and
+ * release vector bitmap, DMA memory and interrupt buffer after the
+ * hardware quiesce window has elapsed.
+ *
+ * Caller must hold intr_mgt->lock.
+ */
+static int
+__nbl_res_intr_complete_destroy_msix_map(struct nbl_interrupt_mgt *intr_mgt,
+					 struct nbl_resource_mgt *res_mgt,
+					 u16 func_id)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_func_interrupt_resource_mng *func_res;
+	struct nbl_msix_map_table *msix_map_table;
+	struct device *dev = res_mgt->common->dev;
+	u16 *interrupts;
+	u16 intr_num;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (func_id >= NBL_MAX_PF) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+
+	func_res = &intr_mgt->func_intr_res[func_id];
+	if (func_res->state != NBL_INTR_FUNC_DESTROYING)
+		return 0;
+
+	/*
+	 * Stage 2: the quiesce window has elapsed, it is now safe to
+	 * zero the DMA base address in the hardware map register.
+	 */
+	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+			     false, 0, 0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	interrupts = func_res->interrupts;
+	intr_num = func_res->num_interrupts;
+	msix_map_table = &func_res->msix_map_table;
+
+	if (interrupts) {
+		nbl_intr_release_bitmap(intr_mgt, res_mgt, interrupts,
+					intr_num);
+		kfree(interrupts);
+	}
+
+	/*
+	 * Release the coherent table independently of interrupts so a
+	 * partially built config (table allocated, vectors never
+	 * published) cannot leak coherent DMA memory.
+	 */
+	if (msix_map_table->base_addr) {
+		dma_free_coherent(dev, msix_map_table->size,
+				  msix_map_table->base_addr,
+				  msix_map_table->dma);
+		msix_map_table->base_addr = NULL;
+		msix_map_table->dma = 0;
+		msix_map_table->size = 0;
+	}
+
+	func_res->interrupts = NULL;
+	func_res->num_interrupts = 0;
+	func_res->num_net_interrupts = 0;
+	func_res->state = NBL_INTR_FUNC_IDLE;
+
+	return 0;
+}
+
+/*
+ * Internal (unlocked) MSI-X map teardown.  Caller must hold
+ * intr_mgt->lock for the whole sequence, including the hardware-DMA
+ * quiesce window: dropping the lock would let a concurrent caller (or
+ * nbl_intr_mgt_stop()) install/free state against this teardown.
+ *
+ * This is used for the single function synchronous destroy path.
+ */
+static int __nbl_res_intr_destroy_msix_map(struct nbl_interrupt_mgt *intr_mgt,
+					   struct nbl_resource_mgt *res_mgt,
+					   u16 func_id)
+{
+	int ret;
+
+	lockdep_assert_held(&intr_mgt->lock);
+
+	if (intr_mgt->stopping)
+		return -ESHUTDOWN;
+
+	ret = __nbl_res_intr_prepare_destroy_msix_map(intr_mgt, res_mgt,
+						      func_id);
+	if (ret)
+		return ret;
+	/*
+	 * prepare() only transitions CONFIGURED functions; an IDLE func
+	 * has nothing to wait for or complete.
+	 */
+	if (intr_mgt->func_intr_res[func_id].state !=
+	    NBL_INTR_FUNC_DESTROYING)
+		return 0;
+
+	nbl_intr_quiesce_wait();
+
+	return __nbl_res_intr_complete_destroy_msix_map(intr_mgt, res_mgt,
+							func_id);
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
+	ret = __nbl_res_intr_destroy_msix_map(intr_mgt, res_mgt, func_id);
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
+ * per function on first configuration, entries are rewritten while the
+ * map is invalidated on subsequent reconfigurations. No free/realloc of
+ * DMA table on vector count changes. This removes the DMA table
+ * free/realloc cycle. On reconfiguration the map VALID bit is cleared
+ * and the hardware-DMA quiesce window is observed (lock held) before old
+ * vectors are recycled and the table is rewritten.
+ *
+ * Reconfiguration transiently needs room for the whole new vector set on
+ * top of the old one, because the old set is only released after the new
+ * allocation has succeeded (a failed reconfiguration must leave the old
+ * configuration intact).  The bitmap pools are therefore sized for peak,
+ * not maximum, concurrent use: a reconfigure of the same or a smaller
+ * size still fails with -EAGAIN when the pool is nearly exhausted.  The
+ * in-tree caller (nbl_dev_init_msix_cnt()) asks for one non-net vector
+ * per PF, far below NBL_MAX_OTHER_INTERRUPT.
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
+	bool had_config;
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
+	if (func_id >= NBL_MAX_PF) {
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
+
+	/* Reject new configs during teardown or while func is mid-destroy */
+	if (intr_mgt->stopping) {
+		ret = -ESHUTDOWN;
+		goto out_unlock;
+	}
+	if (intr_mgt->func_intr_res[func_id].state ==
+	    NBL_INTR_FUNC_DESTROYING) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	had_config = intr_mgt->func_intr_res[func_id].state ==
+		     NBL_INTR_FUNC_CONFIGURED;
+
+	/*
+	 * Phase1: allocate global vector array first.
+	 * Allocate the fixed-size MSIX DMA table only ONCE for this function.
+	 */
+	tmp_interrupts = kcalloc(requested, sizeof(*tmp_interrupts),
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
+	 * Phase2: quiesce the old hardware MSIX config before touching
+	 * the live DMA table. Same sequence as destroy:
+	 *   disable mailbox routing -> invalidate per-vector INFO ->
+	 *   clear map VALID -> flush -> wait for in-flight table fetches.
+	 * The lock stays held across the wait, so no concurrent caller
+	 * can program the quiesced function. Only then are old vectors
+	 * recycled.
+	 * NOTE: NO DMA table free here.
+	 */
+	if (had_config) {
+		old_interrupts =
+			intr_mgt->func_intr_res[func_id].interrupts;
+		old_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+
+		ret = __nbl_res_intr_set_mailbox_irq(intr_mgt, res_mgt, func_id,
+						     0, false);
+		if (ret) {
+			dev_err(dev, "%s: disable old mailbox irq failed, keep old config\n",
+				__func__);
+			goto release_vecs_unlock;
+		}
+		for (j = 0; j < old_num; j++) {
+			hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+					      func_id, false,
+					      old_interrupts[j],
+					      0, 0, 0, false);
+		}
+		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+				     false, official_tbl->dma,
+				     0, 0, 0);
+		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+		nbl_intr_quiesce_wait();
+
+		nbl_intr_release_bitmap(intr_mgt, res_mgt, old_interrupts,
+					old_num);
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
+	 * A fresh configuration can find the map entry still VALID with a
+	 * DMA address owned by a previous kernel (kexec / forced unload
+	 * without FLR: the chip state survives and there is no .shutdown
+	 * callback).  Invalidate it, and wait out the quiesce window,
+	 * before the per-vector INFO/FID entries below are armed:
+	 * otherwise the pcompleter could still fetch that stale table and
+	 * route it into gvecs this configuration is about to hand out.
+	 * The reconfiguration path has already done both above.
+	 */
+	if (!had_config) {
+		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+				     false, 0, 0, 0, 0);
+		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+		nbl_intr_quiesce_wait();
+	}
+
+	/*
+	 * Rewrite the table in the pre-allocated DMA buffer while the
+	 * map is invalid, so the device cannot observe a torn old/new
+	 * mix. Only entries beyond requested count need explicit zeroing.
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
+	}
+
+	/* Ensure coherent table writes are visible before HW fetch/enable */
+	dma_wmb();
+
+	/* Enable per-vector INFO entries after the table is published */
+	for (i = 0; i < requested; i++) {
+		gvec = intr_mgt->func_intr_res[func_id].interrupts[i];
+		entry_masked = (i < num_net_msix && net_msix_mask_en);
+		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
+				      func_id, true, gvec,
+				      bus, devid, function,
+				      entry_masked);
+	}
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+
+	/*
+	 * Point the map at the table last and set VALID.
+	 *
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
+	intr_mgt->func_intr_res[func_id].state = NBL_INTR_FUNC_CONFIGURED;
+	mutex_unlock(&intr_mgt->lock);
+	return 0;
+
+release_vecs_unlock:
+	nbl_intr_release_bitmap(intr_mgt, res_mgt, tmp_interrupts,
+				allocated_cnt);
+	kfree(tmp_interrupts);
+	/*
+	 * On a failed fresh configuration, release the DMA table
+	 * allocated during this call. On a failed reconfiguration the
+	 * old configuration is still intact (it is only torn down
+	 * after all vector allocations succeed) and owns the table.
+	 */
+	if (!had_config && official_tbl->base_addr) {
+		dma_free_coherent(dev, official_tbl->size,
+				  official_tbl->base_addr,
+				  official_tbl->dma);
+		official_tbl->base_addr = NULL;
+		official_tbl->dma = 0;
+		official_tbl->size = 0;
+	}
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
+ * Serialization: takes intr_mgt->lock internally and passes the
+ * pointer it read (before taking the lock) down to the helpers, which
+ * must not re-read res_mgt->intr_mgt: nbl_intr_mgt_stop() clears that
+ * pointer while a caller may already be blocked on this mutex.
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
+	ret = __nbl_res_intr_set_mailbox_irq(intr_mgt, res_mgt, func_id,
+					     vector_id, en_msix);
+	mutex_unlock(&intr_mgt->lock);
+
+	return ret;
+}
+
+/*
+ * Only software state is reset here.  The chip-internal MSI-X tables
+ * (FUNCTION_MSIX_MAP, PADPT_HOST_MSIX_INFO, HOST_MSIX_FID_TABLE) can
+ * survive a kexec or a forced unload without FLR, and there is no
+ * .shutdown callback to scrub them.  They are not cleared here because
+ * the INFO/FID tables are indexed by global vector id, which would mean
+ * rewriting every entry; instead the map entry that the pcompleter
+ * actually fetches is invalidated by nbl_res_intr_cfg_msix_map() before
+ * it is programmed, and by the teardown paths.
+ */
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
+	intr_mgt->stopping = false;
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
+/*
+ * nbl_intr_mgt_stop - global control-PF interrupt teardown
+ *
+ * Phase 1 sets the stopping latch and invalidates every configured
+ * function's hardware map entry while holding the lock.  The lock is
+ * dropped for the global quiesce window, so a caller that races the
+ * window is rejected by the latch (checked under the lock), not by the
+ * lock being held.
+ *
+ * After this returns res_mgt->intr_mgt is NULL, so the public entry
+ * points report -EINVAL.  -ESHUTDOWN/-EBUSY/-ENODEV are only observed
+ * by a caller that latched the pointer before it was cleared.
+ */
+void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	u16 func_id;
+	int ret;
+
+	if (!intr_mgt)
+		return;
+
+	/*
+	 * Phase 1: set the stopping latch and invalidate all hardware
+	 * MSIX map entries.  A caller racing the quiesce window below is
+	 * either still waiting for the lock, in which case it observes
+	 * stopping == true at its next checkpoint once it is let in, or
+	 * it already holds the lock, in which case this phase waits for
+	 * it to finish.  The latch is never cleared.
+	 *
+	 * The en_msix=false mailbox path is exempt from the latch on
+	 * purpose: this phase and the per-function teardown use it to
+	 * disarm routing, and it only rewrites bits that are already
+	 * clear by then.
+	 */
+	mutex_lock(&intr_mgt->lock);
+	intr_mgt->stopping = true;
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (intr_mgt->func_intr_res[func_id].state ==
+		    NBL_INTR_FUNC_CONFIGURED) {
+			dev_info(res_mgt->common->dev,
+				 "intr_mgt_stop: preparing destroy map for func %u\n",
+				 func_id);
+			ret = __nbl_res_intr_prepare_destroy_msix_map(intr_mgt,
+								      res_mgt,
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
+	 * freeing coherent memory.  Best-effort only, see
+	 * nbl_intr_quiesce_wait().
+	 */
+	nbl_intr_quiesce_wait();
+
+	/* Phase2: safely release MSIX coherent memory and intr resources */
+	mutex_lock(&intr_mgt->lock);
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (intr_mgt->func_intr_res[func_id].state ==
+		    NBL_INTR_FUNC_DESTROYING) {
+			ret = __nbl_res_intr_complete_destroy_msix_map(intr_mgt,
+								       res_mgt,
+								       func_id);
+			if (ret)
+				dev_warn(res_mgt->common->dev,
+					 "intr_mgt_stop: complete destroy map for func %u failed: %d\n",
+					 func_id, ret);
+		}
+	}
+	/*
+	 * Unpublish last.  Readers do not synchronize on intr_mgt->lock,
+	 * so this only has to happen after every hardware access and
+	 * every free above; a caller that latched the pointer earlier is
+	 * rejected by the stopping latch.
+	 */
+	res_mgt->intr_mgt = NULL;
+	mutex_unlock(&intr_mgt->lock);
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
index b316fb8e7051..635f34312c56 100644
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
index ae0a3d33198d..ee09de854aff 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -17,6 +17,69 @@
 
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
+/*
+ * Per-function MSI-X resource state.
+ *
+ * IDLE       - nothing configured for this function.
+ * CONFIGURED - map valid in hardware, vectors owned by this function.
+ * DESTROYING - map invalidated, teardown in flight: neither the vector
+ *              bitmaps nor the coherent table may be released until the
+ *              hardware-DMA quiesce window has elapsed.
+ *
+ * The single-function destroy path holds intr_mgt->lock across that
+ * window.  nbl_intr_mgt_stop() cannot, because it quiesces every
+ * function at once: it drops the lock and relies on the stopping latch
+ * to keep a concurrent configuration from installing a map that the
+ * in-flight teardown would free.
+ */
+enum nbl_intr_func_state {
+	NBL_INTR_FUNC_IDLE = 0,
+	NBL_INTR_FUNC_CONFIGURED,
+	NBL_INTR_FUNC_DESTROYING,
+};
+
+struct nbl_func_interrupt_resource_mng {
+	u16 num_interrupts;
+	u16 num_net_interrupts;
+	u16 *interrupts;
+	struct nbl_msix_map_table msix_map_table;
+	u8 state; /* enum nbl_intr_func_state */
+};
+
+struct nbl_interrupt_mgt {
+	struct mutex lock; /* Protects the bitmaps + func_intr_res[] */
+	DECLARE_BITMAP(intr_net_bmap, NBL_MAX_NET_INTERRUPT);
+	DECLARE_BITMAP(intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
+	/* One-way latch: set on teardown, never cleared */
+	bool stopping;
+	/*
+	 * Indexed by absolute PCI function id.  Only PF entries are ever
+	 * used: nbl_res_func_id_to_bdf() rejects VF ids before any
+	 * func_intr_res[] access, and the chip-internal MSI-X vector
+	 * space is only managed for PFs.
+	 */
+	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_PF];
+};
+
 /* --------- INFO ---------- */
 struct nbl_sriov_info {
 	unsigned int bdf;
@@ -56,14 +119,28 @@ struct nbl_resource_mgt {
 	struct nbl_resource_info *resource_info;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	/*
+	 * Published interrupt manager, control PF only.  The public entry
+	 * points read this pointer without the manager lock (the object is
+	 * devres-owned, so it outlives them) and then pass the value they
+	 * read down to the internal helpers; nbl_intr_mgt_stop() clears it
+	 * under the manager lock as its last step.  A caller that latches
+	 * the pointer before that sees stopping == true and fails with
+	 * -ESHUTDOWN; a caller that reads it after gets -EINVAL.
+	 */
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
index 4b420db91963..89b979e2cdb5 100644
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
 	/**
 	 * flush_write - Flush posted MEMORY-BAR writes
 	 * @hw_mgt: hardware management context
@@ -59,6 +66,8 @@ struct nbl_hw_ops {
 
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
-- 
2.47.3

