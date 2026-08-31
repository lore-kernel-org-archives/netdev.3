Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F725B093;
	Mon, 31 Aug 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142469; cv=none; b=YuyHiyKO/maa4RmIBtMsUUzAszoIOUJ362ci3lxd9EC1KNp2DunxtYFNz/9h6XMWc6T/cCTtllQkAhYbCE3/fPSxVrFWUJ2Eha+li85DXD9CVm1jnuEopBlc0ghZsfRGnRWZtnBRwY+8LKI4vdSBywjB4Jxg3DR7eLJ/oDkW0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142469; c=relaxed/simple;
	bh=jgbzBcTGqr4bmYspYgzjpaE1PNdw4iH8bJpd+NI3/RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URFGs8BR7D1skzruW66yeUf10ADaa4gP/CvS5RKVsP1+YUBF1Ot8wHD7/vPnxzLcfybp/eSaGtSUC7aJFbNPi5ZW0gFzj1BjUQm1LralxozowVbvrr8cxDp43mVTQBTVKu8ogBhI8765+39i0A+rYCpb9trs6zx3bh6lqwQytMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0534534-0.0015194-0.945027;FP=12058225540175781378|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.j0lvzcA_1788142455;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.j0lvzcA_1788142455 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 10:14:15 +0800
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
Subject: [PATCH v26 net-next 04/10] net/nebula-matrix: add common resource implementation
Date: Mon, 31 Aug 2026 10:13:55 +0800
Message-ID: <20260831021408.2325-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

The Resource layer processes entries and data of chip modules to implement
entry management operations.

This patch provides the common part of resource layer, including conversion
helpers between vsi_id, func_id, eth_id, and pf_id. These mappings are used
by upper layers and the resource layer itself.

nbl_res_start() initializes VSI/Eth/PF data structures only for control
devices (`common->has_ctrl == true`). Framework dispatch layer ensures
resource mapping APIs such as nbl_res_func_id_to_vsi_id() are only invoked
on control devices.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   2 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  22 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  70 +++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  14 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 334 ++++++++++++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |  10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 120 +++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  73 ++++
 .../nbl/nbl_include/nbl_def_channel.h         |  10 +
 .../nbl/nbl_include/nbl_def_common.h          |  19 +
 .../nbl/nbl_include/nbl_def_hw.h              |   5 +
 .../nbl/nbl_include/nbl_def_resource.h        |  29 ++
 .../nbl/nbl_include/nbl_include.h             |   6 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   9 +
 15 files changed, 724 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 04e1aa1fb4bd..3dab9519a277 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -6,4 +6,6 @@ obj-$(CONFIG_NBL) := nbl.o
 nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_channel/nbl_channel.o \
 		nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+		nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
+		nbl_hw/nbl_resource.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
index 38abf41d9bb0..597c11ed7fd8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -30,6 +30,28 @@ int nbl_common_create_wq(struct nbl_common_info *common)
 	return 0;
 }
 
+/**
+ * nbl_common_func_id_to_rel_pf_id - convert absolute PF id to relative PF id
+ * @common: common device info
+ * @pf_id: absolute PF identifier
+ * @rel_pf_id: output relative pf id
+ *
+ * Leonis uses fixed mgt_pf = 0. Support future non-zero management PF.
+ *
+ * Return: 0 on success, -EINVAL on invalid arguments.
+ */
+int nbl_common_func_id_to_rel_pf_id(struct nbl_common_info *common, u32 pf_id,
+				    u32 *rel_pf_id)
+{
+	if (!rel_pf_id)
+		return -EINVAL;
+
+	if (pf_id < common->mgt_pf)
+		return -EINVAL;
+	*rel_pf_id = pf_id - common->mgt_pf;
+	return 0;
+}
+
 static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
 {
 	u32 hash;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index f998a2b44e5c..dd24ebec0171 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -16,11 +16,13 @@ enum {
 
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_resource_ops_tbl *resource_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
 struct nbl_core {
 	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_resource_mgt *res_mgt;
 	struct nbl_channel_mgt *chan_mgt;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 24b15418e601..3637c00cdfce 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -10,6 +10,24 @@
 #include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+				 u32 len)
+{
+	u32 i;
+
+	if (len % 4)
+		return;
+	if (reg >= (u64)hw_mgt->mailbox_bar_size ||
+	    reg + len > (u64)hw_mgt->mailbox_bar_size) {
+		dev_err_once(hw_mgt->common->dev,
+			     "mbx read out of range: reg=0x%llx len=%u bar_size=%pa\n",
+			     reg, len, &hw_mgt->mailbox_bar_size);
+		return;
+	}
+	for (i = 0; i < len / 4; i++)
+		data[i] = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
 static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
 				  const u32 *data, u32 len)
 {
@@ -58,6 +76,21 @@ static void nbl_hw_wr_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+/*
+ * Registers reset to zero after cold boot / FLR / bus reset. Firmware
+ * programs valid values before driver probe, so zero is only seen on
+ * hardware fault or register read failure. Initialize data=0 to guard
+ * against nbl_hw_read_mbx_regs() early-return on bounds-check failure.
+ */
+static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
+{
+	u32 data = 0;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW6_OFFSET, &data,
+			     sizeof(data));
+	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
+}
+
 static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
 						 u16 tail_ptr, u8 txrx)
 {
@@ -136,6 +169,15 @@ static void nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask)
 			    sizeof(*pf_mask));
 }
 
+static void nbl_hw_get_real_bus(struct nbl_hw_mgt *hw_mgt, u8 *bus)
+{
+	u32 data = 0;
+
+	nbl_hw_rd_regs_lock(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV, &data,
+			    sizeof(data));
+	*bus = FIELD_GET(NBL_PCIE_BUS_MASK, data);
+}
+
 static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				     u8 bus, u8 devid, u8 function)
 {
@@ -149,6 +191,26 @@ static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 			    sizeof(data));
 }
 
+/*
+ * Registers reset to zero after cold boot / FLR / bus reset. Firmware
+ * programs valid values before driver probe, so zero is only seen on
+ * hardware fault or register read failure. Initialize data=0 to guard
+ * against nbl_hw_read_mbx_regs() early-return on bounds-check failure.
+ */
+static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
+				  struct nbl_board_port_info *board_info)
+{
+	u32 data = 0;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, &data,
+			     sizeof(data));
+	board_info->eth_num = FIELD_GET(NBL_FW_BOARD_DW3_PORT_NUM_MASK, data);
+	board_info->eth_speed =
+		FIELD_GET(NBL_FW_BOARD_DW3_PORT_SPEED_MASK, data);
+	board_info->p4_version =
+		FIELD_GET(NBL_FW_BOARD_DW3_P4_VERSION_MASK, data);
+}
+
 static struct nbl_hw_ops hw_ops = {
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
@@ -156,8 +218,12 @@ static struct nbl_hw_ops hw_ops = {
 	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
 	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
 	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.get_real_bus = nbl_hw_get_real_bus,
+
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
 
+	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
+	.get_board_info = nbl_hw_get_board_info,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
@@ -188,7 +254,9 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
 	if (!hw_ops.update_mailbox_queue_tail_ptr ||
 	    !hw_ops.config_mailbox_rxq || !hw_ops.config_mailbox_txq ||
 	    !hw_ops.stop_mailbox_rxq || !hw_ops.stop_mailbox_txq ||
-	    !hw_ops.get_host_pf_mask || !hw_ops.cfg_mailbox_qinfo)
+	    !hw_ops.get_host_pf_mask || !hw_ops.get_real_bus ||
+	    !hw_ops.cfg_mailbox_qinfo ||
+	    !hw_ops.get_fw_eth_map || !hw_ops.get_board_info)
 		return ERR_PTR(-EINVAL);
 	hw_ops_tbl->ops = &hw_ops;
 	hw_ops_tbl->priv = hw_mgt;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 99ee126db9dc..88772a11124a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -67,4 +67,18 @@ struct nbl_mailbox_qinfo_cfg_table {
 #define NBL_PCIE_HOST_K_PF_MASK_REG (NBL_INTF_HOST_PCIE_BASE + 0x00001004)
 #define NBL_PCIE_HOST_TL_CFG_BUSDEV (NBL_INTF_HOST_PCIE_BASE + 0x11040)
 
+#define NBL_PCIE_BUS_MASK	GENMASK(12, 5)
+#define NBL_FW_BOARD_CONFIG			0x200
+#define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
+#define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
+
+#define NBL_FW_BOARD_DW3_PORT_TYPE_MASK BIT(0)
+#define NBL_FW_BOARD_DW3_PORT_NUM_MASK GENMASK(7, 1)
+#define NBL_FW_BOARD_DW3_PORT_SPEED_MASK GENMASK(9, 8)
+#define NBL_FW_BOARD_DW3_GPIO_TYPE_MASK GENMASK(12, 10)
+#define NBL_FW_BOARD_DW3_P4_VERSION_MASK GENMASK(13, 13)
+
+#define NBL_FW_BOARD_DW6_LANE_BITMAP_MASK GENMASK(7, 0)
+#define NBL_FW_BOARD_DW6_ETH_BITMAP_MASK GENMASK(15, 8)
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
new file mode 100644
index 000000000000..a719cc8fbf8a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/bits.h>
+#include "nbl_resource_leonis.h"
+
+static struct nbl_resource_ops res_ops = {
+	.get_vsi_id = nbl_res_func_id_to_vsi_id,
+	.get_eth_id = nbl_res_get_eth_id,
+};
+
+static struct nbl_resource_mgt *
+nbl_res_setup_res_mgt(struct nbl_common_info *common)
+{
+	struct nbl_resource_info *resource_info;
+	struct nbl_resource_mgt *res_mgt;
+	struct device *dev = common->dev;
+
+	res_mgt = devm_kzalloc(dev, sizeof(*res_mgt), GFP_KERNEL);
+	if (!res_mgt)
+		return ERR_PTR(-ENOMEM);
+	res_mgt->common = common;
+
+	resource_info =
+		devm_kzalloc(dev, sizeof(*resource_info), GFP_KERNEL);
+	if (!resource_info)
+		return ERR_PTR(-ENOMEM);
+	res_mgt->resource_info = resource_info;
+
+	return res_mgt;
+}
+
+static struct nbl_resource_ops_tbl *
+nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+
+	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
+	if (!res_ops_tbl)
+		return ERR_PTR(-ENOMEM);
+	if (!res_ops.get_vsi_id || !res_ops.get_eth_id)
+		return ERR_PTR(-EINVAL);
+	res_ops_tbl->ops = &res_ops;
+	res_ops_tbl->priv = res_mgt;
+
+	return res_ops_tbl;
+}
+
+static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_eth_info *eth_info;
+	u32 eth_bitmap = 0, eth_id;
+	u32 eth_num = 0;
+	u32 fw_port_num;
+	int i;
+
+	eth_info = devm_kzalloc(dev, sizeof(*eth_info), GFP_KERNEL);
+	if (!eth_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->eth_info = eth_info;
+
+	fw_port_num = res_mgt->resource_info->board_info.eth_num;
+
+	hw_ops->get_fw_eth_map(res_mgt->hw_ops_tbl->priv, &eth_bitmap);
+	if (eth_bitmap & ~((1 << NBL_MAX_ETHERNET) - 1)) {
+		dev_err(dev, "FW reported invalid eth_bitmap 0x%x\n",
+			eth_bitmap);
+		return -EINVAL;
+	}
+	if (fw_port_num != hweight32(eth_bitmap)) {
+		dev_err(dev, "FW inconsistency: port_num=%u, bitmap=0x%x\n",
+			fw_port_num, eth_bitmap);
+		return -EINVAL;
+	}
+	/*
+	 * Firmware is ready before probe. Valid port counts are 1/2/4;
+	 * 0 (invalid config), 3 (unsupported topology), and >4 (exceeds
+	 * hardware max) are all rejected with -EINVAL.
+	 */
+	if (fw_port_num == 0 || fw_port_num == 3 ||
+	    fw_port_num > NBL_MAX_ETHERNET) {
+		dev_err(dev, "FW reports %u Ethernet ports, unsupported (valid: 1/2/4)\n",
+			fw_port_num);
+		return -EINVAL;
+	}
+	eth_info->eth_num = fw_port_num;
+	/* Intentional design constraint: each PF maps to exactly one
+	 * Ethernet port. This couples PF identity to port identity
+	 * and is required by nbl_res_get_eth_id() which indexes
+	 * eth_info->eth_id[] by relative PF id.
+	 */
+	if (res_mgt->resource_info->max_pf != eth_info->eth_num) {
+		dev_err(dev, "Invalid PF-to-port topology: max_pf=%u, eth_num=%u\n",
+			res_mgt->resource_info->max_pf, eth_info->eth_num);
+		return -EINVAL;
+	}
+
+	/*
+	 * Original comment said dual-port board eth_id fixed to 0,2;
+	 * Code accepts any contiguous valid bitmap bits (0/1 or 0/2 etc).
+	 * Firmware only needs to report correct count of active ports,
+	 * no hard-coded fixed bit positions required.
+	 */
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if ((1 << i) & eth_bitmap) {
+			set_bit(i, eth_info->eth_bitmap);
+			eth_info->eth_id[eth_num] = i;
+			eth_info->logic_eth_id[i] = eth_num;
+			eth_num++;
+		}
+	}
+
+	for (i = 0; i < res_mgt->resource_info->max_pf; i++) {
+		eth_id = eth_info->eth_id[i];
+		eth_info->pf_bitmap[eth_id] |= BIT(i);
+	}
+
+	return 0;
+}
+
+static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_sriov_info *sriov_info;
+	struct device *dev = common->dev;
+	u8 hw_bus = 0;
+	u16 function;
+	u16 func_id;
+
+	hw_ops->get_real_bus(p, &hw_bus);
+	if (common->function + res_mgt->resource_info->max_pf > NBL_MAX_PF) {
+		dev_err(dev, "PF count exceeds available function space\n");
+		return -EINVAL;
+	}
+	sriov_info = devm_kcalloc(dev, res_mgt->resource_info->max_pf,
+				  sizeof(*sriov_info), GFP_KERNEL);
+	if (!sriov_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->sriov_info = sriov_info;
+	/*
+	 * common->hw_bus supplies bus number for channel mailbox QINFO mapping.
+	 * Execution order guarantee: this assignment runs before
+	 * cfg_chan_qinfo_map_table() in nbl_dev_start(), only executed
+	 * on control PF path.
+	 */
+	common->hw_bus = hw_bus;
+
+	for (func_id = 0; func_id < res_mgt->resource_info->max_pf; func_id++) {
+		sriov_info = res_mgt->resource_info->sriov_info + func_id;
+		function = common->function + func_id;
+		sriov_info->bdf = PCI_DEVID(common->hw_bus,
+					    PCI_DEVFN(common->devid, function));
+	}
+
+	return 0;
+}
+
+static int nbl_res_ctrl_dev_vsi_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	struct nbl_vsi_info *vsi_info;
+	int i;
+
+	vsi_info = devm_kzalloc(dev, sizeof(*vsi_info), GFP_KERNEL);
+	if (!vsi_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->vsi_info = vsi_info;
+	/*
+	 * case 1 one port(1pf)
+	 * pf0 (NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0
+	 * case 2 two port(2pf)
+	 * pf0,pf1(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,512
+	 * case 3 four port(4pf)
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,256,512,768
+	 */
+
+	vsi_info->num = eth_info->eth_num;
+	/*
+	 * eth_num can be 1/2/4:
+	 * - 2/4 ports use dedicated gap constants;
+	 * - 1 port falls back to NBL_DEFAULT_VSI_ID_GAP (1024).
+	 * All three values produce valid base_id offsets.
+	 */
+	for (i = 0; i < vsi_info->num; i++) {
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].base_id =
+			i * nbl_vsi_id_gap(vsi_info->num);
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num = 1;
+	}
+
+	return 0;
+}
+
+static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	u32 exp_contiguous_mask = 0;
+	u32 pf_mask = 0;
+	u32 pf_num = 0;
+	int i;
+
+	hw_ops->get_host_pf_mask(res_mgt->hw_ops_tbl->priv, &pf_mask);
+
+	/*
+	 * k_pf_mask register rule:
+	 * bit N == 0  -> PF#N enabled; bit N == 1 -> PF#N masked out.
+	 * Hardware constraint: bit0 is reserved, PF0 cannot be masked.
+	 * All-zero pf_mask means all PF0~PF7 are enabled.
+	 *
+	 * Product firmware constraint: only 3 valid configurations supported:
+	 * 1 PF  (PF0 only): pf_num = 1, mask = 0xfe
+	 * 2 PFs (PF0,PF1):  pf_num = 2, mask = 0xfc
+	 * 4 PFs (PF0~PF3): pf_num = 4, mask = 0xf0
+	 * No other PF count or sparse/non-contiguous PF layout is allowed.
+	 */
+	for (i = 0; i < NBL_MAX_PF; i++) {
+		if (!(pf_mask & (1 << i)))
+			pf_num++;
+	}
+
+	/*
+	 * Sanity check: enabled PFs must be contiguous starting from PF0.
+	 * Current resource framework uses relative PF id, sparse PF layout
+	 * will cause mismatch between resource layer and hardware func_id.
+	 */
+	for (i = 0; i < pf_num; i++)
+		exp_contiguous_mask |= BIT(i);
+	if ((pf_mask & exp_contiguous_mask) != 0) {
+		dev_err(res_mgt->common->dev,
+			"pf_mask 0x%08x: non-contiguous enabled PF, unsupported\n",
+			pf_mask);
+		return -EINVAL;
+	}
+
+	/* Only allow product-specified PF count: 1 / 2 / 4 */
+	if (pf_num != 1 && pf_num != 2 && pf_num != 4) {
+		dev_err(res_mgt->common->dev,
+			"Invalid pf_num=%u (mask=0x%08x), only 1/2/4 PFs supported\n",
+			pf_num, pf_mask);
+		return -EINVAL;
+	}
+
+	res_mgt->resource_info->max_pf = pf_num;
+
+	return 0;
+}
+
+static void nbl_res_init_board_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+
+	hw_ops->get_board_info(res_mgt->hw_ops_tbl->priv,
+			       &res_mgt->resource_info->board_info);
+}
+
+static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_common_info *common = res_mgt->common;
+	int ret = 0;
+
+	if (common->has_ctrl) {
+		nbl_res_init_board_info(res_mgt);
+
+		ret = nbl_res_init_pf_num(res_mgt);
+		if (ret)
+			return ret;
+
+		ret = nbl_res_ctrl_dev_sriov_info_init(res_mgt);
+		if (ret)
+			return ret;
+
+		ret = nbl_res_ctrl_dev_setup_eth_info(res_mgt);
+		if (ret)
+			return ret;
+
+		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int nbl_res_init_leonis(struct nbl_adapter *adap)
+{
+	struct nbl_channel_ops_tbl *chan_ops_tbl = adap->intf.channel_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl = adap->intf.hw_ops_tbl;
+	struct nbl_common_info *common = &adap->common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct device *dev = &adap->pdev->dev;
+	struct nbl_resource_mgt *res_mgt;
+	int ret;
+
+	res_mgt = nbl_res_setup_res_mgt(common);
+	if (IS_ERR(res_mgt)) {
+		ret = PTR_ERR(res_mgt);
+		return ret;
+	}
+	res_mgt->chan_ops_tbl = chan_ops_tbl;
+	res_mgt->hw_ops_tbl = hw_ops_tbl;
+
+	ret = nbl_res_start(res_mgt);
+	if (ret)
+		return ret;
+
+	res_ops_tbl = nbl_res_setup_ops(dev, res_mgt);
+	if (IS_ERR(res_ops_tbl)) {
+		ret = PTR_ERR(res_ops_tbl);
+		return ret;
+	}
+	adap->intf.resource_ops_tbl = res_ops_tbl;
+	adap->core.res_mgt = res_mgt;
+
+	return 0;
+}
+
+void nbl_res_remove_leonis(struct nbl_adapter *adap)
+{
+	/*
+	 * No resource release here because all memory uses devm managed
+	 * allocation
+	 */
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
new file mode 100644
index 000000000000..b9355262c00d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_RESOURCE_LEONIS_H_
+#define _NBL_RESOURCE_LEONIS_H_
+
+#include "../nbl_resource.h"
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
new file mode 100644
index 000000000000..6fa0e0d550f4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#include <linux/pci.h>
+#include "nbl_resource.h"
+
+int nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type, u16 *vsi_id)
+{
+	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
+	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = res_mgt->common->dev;
+	int pfid = func_id;
+	u32 rel_pf_id;
+	int ret;
+
+	if (!common->has_ctrl || !vsi_id) {
+		dev_dbg(dev, "No control plane or null vsi output ptr\n");
+		return -EINVAL;
+	}
+	ret = nbl_common_func_id_to_rel_pf_id(common, pfid, &rel_pf_id);
+	if (ret)
+		return ret;
+	if (rel_pf_id >= vsi_info->num) {
+		dev_err(dev, "PF %d (diff=%u) exceeds vsi_info->num (%u)\n",
+			pfid, rel_pf_id, vsi_info->num);
+		return -EINVAL;
+	}
+
+	ret = nbl_res_pf_dev_vsi_type_to_hw_vsi_type(res_mgt, type, &dst_type);
+	if (ret) {
+		dev_err(dev, "Invalid vsi type %u func_id %u\n", type, func_id);
+		return ret;
+	}
+	*vsi_id = vsi_info->serv_info[rel_pf_id][dst_type].base_id;
+	return 0;
+}
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = res_mgt->common->dev;
+	int j = NBL_VSI_SERV_PF_DATA_TYPE;
+	int pf_id, i;
+
+	if (!common->has_ctrl) {
+		dev_dbg(dev, "No control plane available\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < vsi_info->num; i++) {
+		if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
+		    (vsi_id < vsi_info->serv_info[i][j].base_id +
+					vsi_info->serv_info[i][j].num)) {
+			pf_id = i + common->mgt_pf;
+			if (pf_id >= NBL_MAX_PF) {
+				dev_err(dev, "PF ID overflow\n");
+				return -ERANGE;
+			}
+			return pf_id;
+		}
+	}
+
+	dev_dbg(dev, "VSI ID %u not found\n", vsi_id);
+	return -ENOENT;
+}
+
+int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+		       u16 vsi_id, u8 *eth_num, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = res_mgt->common->dev;
+	int pfid = func_id;
+	int rel_pf_id;
+	int abs_pf_id;
+
+	if (!common->has_ctrl || !eth_num || !eth_id || !logic_eth_id)
+		return -EINVAL;
+	abs_pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+	if (abs_pf_id < 0) {
+		dev_err(dev, "Failed to get PF ID from VSI ID %u\n", vsi_id);
+		return -EINVAL;
+	}
+	if (abs_pf_id != pfid) {
+		dev_err(dev, "func_id %u does not match pf derived from vsi_id %u\n",
+			pfid, vsi_id);
+		return -EINVAL;
+	}
+	rel_pf_id = abs_pf_id - common->mgt_pf;
+
+	if (rel_pf_id >= eth_info->eth_num) {
+		dev_err(dev, "rel_pf_id %d out of range [0, %u)\n",
+			rel_pf_id, eth_info->eth_num);
+		return -ERANGE;
+	}
+
+	*eth_num = eth_info->eth_num;
+	*eth_id = eth_info->eth_id[rel_pf_id];
+	*logic_eth_id = rel_pf_id;
+	return 0;
+}
+
+int nbl_res_pf_dev_vsi_type_to_hw_vsi_type(struct nbl_resource_mgt *res_mgt,
+					   u16 src_type,
+					   enum nbl_vsi_serv_type *dst_type)
+{
+	switch (src_type) {
+	case NBL_VSI_DATA:
+		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+		return 0;
+	default:
+		dev_err_once(res_mgt->common->dev,
+			     "Unsupported vsi src_type %u\n", src_type);
+		return -EINVAL;
+	}
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
new file mode 100644
index 000000000000..226903be080f
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_RESOURCE_H_
+#define _NBL_RESOURCE_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_channel.h"
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_resource.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+struct nbl_resource_mgt;
+
+/* --------- INFO ---------- */
+struct nbl_sriov_info {
+	unsigned int bdf;
+};
+
+struct nbl_eth_info {
+	DECLARE_BITMAP(eth_bitmap, NBL_MAX_ETHERNET);
+	u8 pf_bitmap[NBL_MAX_ETHERNET];
+	u8 eth_num;
+	u8 resv[3];
+	u8 eth_id[NBL_MAX_ETHERNET];
+	u8 logic_eth_id[NBL_MAX_ETHERNET];
+};
+
+enum nbl_vsi_serv_type {
+	NBL_VSI_SERV_PF_DATA_TYPE,
+	NBL_VSI_SERV_MAX_TYPE,
+};
+
+struct nbl_vsi_serv_info {
+	u16 base_id;
+	u16 num;
+};
+
+struct nbl_vsi_info {
+	u16 num;
+	struct nbl_vsi_serv_info serv_info[NBL_MAX_ETHERNET]
+					  [NBL_VSI_SERV_MAX_TYPE];
+};
+
+struct nbl_resource_info {
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_eth_info *eth_info;
+	struct nbl_vsi_info *vsi_info;
+	u8 max_pf;
+	struct nbl_board_port_info board_info;
+};
+
+struct nbl_resource_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_info *resource_info;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+};
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+int nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type, u16 *vsi_id);
+int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+		       u16 vsi_id, u8 *eth_num, u8 *eth_id, u8 *logic_eth_id);
+int nbl_res_pf_dev_vsi_type_to_hw_vsi_type(struct nbl_resource_mgt *res_mgt,
+					   u16 src_type,
+					   enum nbl_vsi_serv_type *dst_type);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index 4fc987c0e56d..61dd97c779ef 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -39,6 +39,16 @@ enum nbl_chan_state {
 	NBL_CHAN_STATE_NBITS
 };
 
+struct nbl_board_port_info {
+	u8 eth_num;
+	u8 eth_speed;
+	u8 p4_version;
+	u8 rsv[5];
+};
+
+static_assert(sizeof(struct nbl_board_port_info) == 8,
+	      "nbl_board_port_info size must be 8 bytes");
+
 struct nbl_chan_send_info {
 	void *arg;
 	size_t arg_len;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 4916c384611b..b3bdecb23b47 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -11,6 +11,22 @@
 #include <linux/device.h>
 #include "nbl_include.h"
 
+#define NBL_TWO_ETHERNET_PORT			2
+#define NBL_FOUR_ETHERNET_PORT			4
+#define NBL_DEFAULT_VSI_ID_GAP			1024
+#define NBL_TWO_ETHERNET_VSI_ID_GAP		512
+#define NBL_FOUR_ETHERNET_VSI_ID_GAP		256
+
+static inline u32 nbl_vsi_id_gap(u32 m)
+{
+	if (m == NBL_FOUR_ETHERNET_PORT)
+		return NBL_FOUR_ETHERNET_VSI_ID_GAP;
+	else if (m == NBL_TWO_ETHERNET_PORT)
+		return NBL_TWO_ETHERNET_VSI_ID_GAP;
+
+	return NBL_DEFAULT_VSI_ID_GAP;
+}
+
 struct nbl_common_info {
 	struct workqueue_struct *wq;
 	struct pci_dev *pdev;
@@ -25,6 +41,7 @@ struct nbl_common_info {
 	u8 devid;
 	u8 bus;
 	u8 hw_bus;
+	u16 mgt_pf;
 
 	u8 has_ctrl;
 	u8 has_net;
@@ -40,6 +57,8 @@ struct nbl_hash_tbl_key {
 
 void nbl_common_destroy_wq(struct nbl_common_info *common);
 int nbl_common_create_wq(struct nbl_common_info *common);
+int nbl_common_func_id_to_rel_pf_id(struct nbl_common_info *common, u32 pf_id,
+				    u32 *rel_pf_id);
 struct nbl_hash_tbl_mgt *
 nbl_common_init_hash_table(struct nbl_hash_tbl_key *key);
 void nbl_common_remove_hash_table(struct nbl_hash_tbl_mgt *tbl_mgt);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 587ac0c58c24..ee53f9e10a8e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 
+struct nbl_board_port_info;
 struct nbl_hw_mgt;
 struct nbl_adapter;
 struct nbl_hw_ops {
@@ -34,9 +35,13 @@ struct nbl_hw_ops {
 	 * or other PF counts are unsupported by driver resource management.
 	 */
 	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);
+	void (*get_real_bus)(struct nbl_hw_mgt *hw_mgt, u8 *bus);
 
 	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				  u8 bus, u8 devid, u8 function);
+	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
+	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
+			       struct nbl_board_port_info *board);
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
new file mode 100644
index 000000000000..7136b282fb80
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_RESOURCE_H_
+#define _NBL_DEF_RESOURCE_H_
+
+#include <linux/types.h>
+
+struct nbl_resource_mgt;
+struct nbl_adapter;
+
+struct nbl_resource_ops {
+	int (*get_vsi_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			  u16 type, u16 *vsi_id);
+	int (*get_eth_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			  u16 vsi_id, u8 *eth_num, u8 *eth_id,
+			  u8 *logic_eth_id);
+};
+
+struct nbl_resource_ops_tbl {
+	struct nbl_resource_ops *ops;
+	struct nbl_resource_mgt *priv;
+};
+
+int nbl_res_init_leonis(struct nbl_adapter *adapter);
+void nbl_res_remove_leonis(struct nbl_adapter *adapter);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index f2d802397d98..59e44feab44f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -13,6 +13,12 @@
 #define NBL_MAX_PF					8
 #define NBL_NEXT_ID(id, max) (((id) + 1) % ((max) + 1))
 
+#define NBL_MAX_ETHERNET				4
+
+enum {
+	NBL_VSI_DATA = 0,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index b7c80ea54c8d..1aafed2d46d7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -10,6 +10,7 @@
 #include "nbl_include/nbl_include.h"
 #include "nbl_include/nbl_def_channel.h"
 #include "nbl_include/nbl_def_hw.h"
+#include "nbl_include/nbl_def_resource.h"
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
@@ -27,6 +28,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	adapter->pdev = pdev;
 	common = &adapter->common;
 
+	common->mgt_pf = 0;
 	common->pdev = pdev;
 	common->dev = &pdev->dev;
 	common->has_ctrl = param->caps.has_ctrl;
@@ -42,7 +44,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	ret = nbl_chan_init_common(adapter);
 	if (ret)
 		goto chan_init_fail;
+
+	ret = nbl_res_init_leonis(adapter);
+	if (ret)
+		goto res_init_fail;
 	return adapter;
+res_init_fail:
+	nbl_chan_remove_common(adapter);
 chan_init_fail:
 	nbl_hw_remove_leonis(adapter);
 hw_init_fail:
@@ -51,6 +59,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	nbl_res_remove_leonis(adapter);
 	nbl_chan_remove_common(adapter);
 	nbl_hw_remove_leonis(adapter);
 }
-- 
2.47.3

