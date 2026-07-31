Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA33859EC;
	Fri, 31 Jul 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490980; cv=none; b=mmz3Vx6o8s20kxnG4nHGANUmvvueDPewHY8uFemmuc/JZsXUmGbHuFfeKkABtu5U7S934ol5ADVHYoI4Of1i3n1Drcfqxu1kjTLlZSYRXth5pEfWOuGKlP7yCo7FJMPPhZNplr7R4lt2UypxzIoWXCdMnz0BPipMWbCtv9jc8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490980; c=relaxed/simple;
	bh=gkoJq86yZxF3Jj80lEqgVBd/hpAa7YwwPE1/Ga4d8Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIJeuZ8W6rPIEnXEScyCKGvUtUWT4AeR2dV5Z7Sj9QgLdvJsBZ8KfIl6MXerlYBJaqt0sOcshtykOULrwr6jq/64nsFO/VnIpOA4mBGdBfrmIXkutSpAqmCabGi074gCjpgayniE+na1RyZvmE7Hb0dkuKLbthwdEYLh9CJhS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.8777656;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0648243-0.0012499-0.933926;FP=10617093585646505146|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iaIzMjn_1785490971;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iaIzMjn_1785490971 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 17:42:51 +0800
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
Subject: [PATCH v23 net-next 06/12] net/nebula-matrix: add intr resource implementation
Date: Fri, 31 Jul 2026 17:42:29 +0800
Message-ID: <20260731094242.2655-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>
References: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add nbl_interrupt module to manage driver global MSI-X vector indices,
and extend hw_ops with callbacks to program vendor-specific internal
MSI-X mapping registers, configure MSI-X metadata, and bind interrupts
to PF mailbox channels.

Key interfaces:
- configure_msix_map:
  Allocates driver global MSI-X indices via separate net/other interrupt
  bitmaps (interrupt_net_bitmap / interrupt_others_bitmap).
  Preallocates all required coherent DMA resources first; only tears down
  old hardware configuration after all new allocations succeed.
  Programs NBL_PCOMPLETER_FUNCTION_MSIX_MAP with the MSI-X table DMA address
  and function BDF info. PCI MSI-X vector allocation itself is performed
  via nbl_dev_alloc_msix_intr() at upper layer.

- destroy_msix_map:
  Releases allocated global vector indices, clears hardware MSI-X mappings,
  frees DMA buffer and interrupt array. A delay is inserted before releasing
  DMA memory to mitigate potential IOMMU faults caused by in-flight hardware
  DMA access after MMIO disable.

- set_mailbox_irq:
  Enables or disables MSI-X routing for a given PF mailbox by updating
  NBL_MAILBOX_QINFO_MAP_REG_ARR with the target global vector id.

- configure_msix_info:
  Programs PADPT_HOST_MSIX_INFO and PCOMPLETER_HOST_MSIX_FID_TABLE
  to record function BDF and MSI-X mask enable attribute for each global
  interrupt vector.

This module manages chip-internal MSI-X routing table and global vector
index space. It does NOT invoke kernel PCI MSI-X allocation helpers
(pci_alloc_irq_vectors, pci_msix_alloc_irq_at, irq_domain); physical
PCI MSI-X vector allocation belongs to separate device layer.

Interrupt manager instance is created during resource startup
(nbl_intr_mgt_start) and attached to resource management context.

Note: Mutual exclusion for configure_msix_map, destroy_msix_map, and
set_mailbox_irq is enforced by dispatch layer. These routines assume
caller holds required locks.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 142 +++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  42 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   8 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 387 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  30 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  35 ++
 .../nbl/nbl_include/nbl_def_hw.h              |  10 +
 .../nbl/nbl_include/nbl_def_resource.h        |   6 +
 .../nbl/nbl_include/nbl_include.h             |   1 +
 12 files changed, 684 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 831b6cb51c37..bcedf278bab2 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -8,4 +8,5 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_interrupt.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index bc273f13ed67..56b979cdc99a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -34,6 +34,30 @@ static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
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
@@ -78,6 +102,119 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
 	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
 }
 
+/*
+ * nbl_hw_set_mailbox_irq - read-modify-write of NBL_MAILBOX_QINFO_MAP_REG_ARR
+ *
+ * Note: This RMW is currently safe because the two callers are strictly
+ * sequential: nbl_hw_cfg_mailbox_qinfo() runs at init, nbl_hw_set_mailbox_irq()
+ * runs at start. Future reset/hot-add/VF-reinit paths must preserve this
+ * ordering; do not introduce concurrent access to this register without
+ * making the RMW atomic (e.g., hold reg_lock across read+write, or use
+ * cached state instead of read).
+ */
+static void nbl_hw_set_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				   bool enable_msix, u16 global_vec_id)
+{
+	u32 data = 0;
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id), &data,
+		       sizeof(data));
+	data &= ~(NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK |
+		  NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK);
+	if (enable_msix)
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
+static void nbl_hw_configure_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				      bool valid, dma_addr_t dma_addr, u8 bus,
+				      u8 devid, u8 function)
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
+		/* clear VALID flag first, avoid transient invalid entry */
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
+static void nbl_hw_configure_msix_info(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				       bool valid, u16 interrupt_id, u8 bus,
+				       u8 devid, u8 function, bool msix_mask_en)
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
@@ -198,6 +335,10 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.configure_msix_map = nbl_hw_configure_msix_map,
+	.configure_msix_info = nbl_hw_configure_msix_info,
+	.flush_write = nbl_flush_writes,
+
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -207,6 +348,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.set_mailbox_irq = nbl_hw_set_mailbox_irq,
 
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 1dee07cb7156..1d6d614be7d6 100644
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
index bbd510f7f2cd..2d7c7747c712 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -10,6 +10,9 @@
 static struct nbl_resource_ops res_ops = {
 	.get_vsi_id = nbl_res_func_id_to_vsi_id,
 	.get_eth_id = nbl_res_get_eth_id,
+	.configure_msix_map = nbl_res_intr_configure_msix_map,
+	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
+	.set_mailbox_irq = nbl_res_intr_set_mailbox_irq,
 };
 
 static struct nbl_resource_mgt *
@@ -257,7 +260,12 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
 		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
 		if (ret)
 			return ret;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			return ret;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 4e61a5c141e5..1da2abcaf00f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -7,4 +7,5 @@
 #define _NBL_RESOURCE_LEONIS_H_
 
 #include "../nbl_resource.h"
+#include "../nbl_interrupt.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..0ff01e6d3982
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+/**
+ * nbl_res_intr_destroy_msix_map - tear down MSI-X mapping for specified PF
+ * @res_mgt: resource management instance
+ * @func_id: target function identifier
+ *
+ * Clear interrupt bitmaps and disable MSI-X via hardware callbacks.
+ * DMA coherent table buffer uses devm allocation and remains valid
+ * until device removal to avoid IOMMU faults caused by in-flight hardware DMA.
+ *
+ * Caller note: this function has no internal locking. Serialization
+ * must be guaranteed at upper dispatch layer.
+ * Caller must ensure all concurrent resource operations are excluded.
+ *
+ * Caller guarantee: hardware cannot issue outstanding DMA to these regions,
+ * all relevant IRQs have been released or not yet configured.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+				  u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_msix_map_table *msix_map_table;
+	u16 *interrupts;
+	u16 intr_num, i;
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
+	for (i = 0; i < intr_num; i++) {
+		NBL_OPS_CALL(hw_ops->configure_msix_info,
+			     (res_mgt->hw_ops_tbl->priv, func_id,
+			      false, interrupts[i], 0, 0, 0, false));
+	}
+
+	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);
+
+	NBL_OPS_CALL(hw_ops->configure_msix_map,
+		     (res_mgt->hw_ops_tbl->priv, func_id, false, 0, 0, 0, 0));
+	NBL_OPS_CALL(hw_ops->flush_write, (res_mgt->hw_ops_tbl->priv));
+
+	/*
+	 * Hardware provides no idle status register for MSIX map DMA engine.
+	 * Use bounded sleep to mitigate race between posted MMIO disable writes
+	 * and ongoing in-flight table read DMA access.
+	 * The MSIX table buffer uses devm allocation and survives until device
+	 * detach, so no immediate buffer free is needed to avoid IOMMU faults.
+	 */
+	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
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
+ * nbl_res_intr_configure_msix_map - allocate & program MSI-X mapping table
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
+ * Return: 0 on success, negative errno on failure
+ */
+int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
+				    u16 func_id, u16 num_net_msix,
+				    u16 num_others_msix,
+				    bool net_msix_mask_en)
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
+		NBL_OPS_CALL(hw_ops->configure_msix_info,
+			     (res_mgt->hw_ops_tbl->priv, func_id,
+			      true, global_vec, bus, devid, function,
+			      msix_mask_en));
+	}
+
+	/* Flush CPU writes to coherent memory before hardware DMA access */
+	dma_wmb();
+
+	NBL_OPS_CALL(hw_ops->configure_msix_map,
+		     (res_mgt->hw_ops_tbl->priv, func_id, true,
+		      official_tbl->dma, common->hw_bus, common->devid,
+		      common->function));
+	NBL_OPS_CALL(hw_ops->flush_write, (res_mgt->hw_ops_tbl->priv));
+
+out:
+	return ret;
+
+release_vecs:
+	nbl_intr_release_bitmap(res_mgt, tmp_interrupts, i);
+free_tmp_tbl:
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
+ * @enable_msix: enable/disable mailbox interrupt
+ *
+ * Caller note: this function has no internal locking. Serialization
+ * must be guaranteed at upper dispatch layer.
+ *
+ * Return: 0 on success, negative errno on parameter check or hw failure
+ */
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool enable_msix)
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
+	NBL_OPS_CALL(hw_ops->set_mailbox_irq,
+		     (res_mgt->hw_ops_tbl->priv, func_id,
+		      enable_msix, global_vec_id));
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
index 000000000000..5aa46a4fce4c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
+				    u16 func_id, u16 num_net_msix,
+				    u16 num_others_msix,
+				    bool net_msix_mask_en);
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool enable_msix);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
index 8dc3bc101eb6..a6e2c7eeed0e 100644
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
index 8650310bf9b3..7f7624e9215d 100644
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
index 74ed7be2ab7d..6569c567634c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -11,6 +11,14 @@
 struct nbl_hw_mgt;
 struct nbl_adapter;
 struct nbl_hw_ops {
+	void (*configure_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				   bool valid, dma_addr_t dma_addr, u8 bus,
+				   u8 devid, u8 function);
+	void (*configure_msix_info)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				    bool valid, u16 interrupt_id, u8 bus,
+				    u8 devid, u8 function,
+				    bool net_msix_mask_en);
+	void (*flush_write)(struct nbl_hw_mgt *hw_mgt);
 	void (*update_mailbox_queue_tail_ptr)(struct nbl_hw_mgt *hw_mgt,
 					      u16 tail_ptr, u8 txrx);
 	void (*config_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt,
@@ -24,6 +32,8 @@ struct nbl_hw_ops {
 
 	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				  u8 bus, u8 devid, u8 function);
+	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				bool enable_msix, u16 global_vec_id);
 	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
 	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
 			       struct nbl_board_port_info *board);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index cf034ab589fd..9e6995ff6c6f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -12,6 +12,12 @@ struct nbl_resource_mgt;
 struct nbl_adapter;
 
 struct nbl_resource_ops {
+	int (*configure_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+				  u16 num_net_msix, u16 num_others_msix,
+				  bool net_msix_mask_en);
+	int (*destroy_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id);
+	int (*set_mailbox_irq)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			       u16 vector_id, bool enable_msix);
 	int (*get_vsi_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			  u16 type, u16 *vsi_id);
 	int (*get_eth_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index d698190c3abc..00a79004f9c3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -17,6 +17,7 @@
 		((_id) == (max) ? 0 : (_id) + 1);	\
 	})
 
+#define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
 
 enum {
-- 
2.47.3

