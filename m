Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3B47AF56;
	Tue, 22 Sep 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078615; cv=none; b=ua2/Hc8PfBZVOULUFBuBBQOee6wlWJmtuxVhcM2pSPDyuFpS0dhJZKf51rMV773CDRy/uFeig7sPvqGidk2SZ/aSj42Xn5qxjdH6QD2DNr6P6RQvGOQ8QKGRVbhi/rZMb12UoqKjNtGeB1oTCMRUVv3DuHiY3oufWTvV7nysIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078615; c=relaxed/simple;
	bh=I/Qhem4ktGtu18KdPjKWyNH1V6DFJZjIlCjNKQzNANk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9MAkhDC7bjgMNgArTzEl4bYThDtrblnj99Hu77w842EXqAqEsUfC85sqf8sIrqPZC+IATJoK1NQ/m6ORdDCLLFvqgQ2czGbvMZYjE9xJga+ttr3Kk66f2d8seUebJmQwA5kVejct8pIT6VwSugXYASqTFwhbniWL1ZP0jCMkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0025803-0.000603671-0.996816;FP=17535847315963206290|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jK4DPT1_1790078597;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jK4DPT1_1790078597 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:03:18 +0800
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
Subject: [PATCH v29 net-next 4/8] net/nebula-matrix: add chip-wide hardware init/deinit implementation
Date: Tue, 22 Sep 2026 20:03:01 +0800
Message-ID: <20260922120311.86593-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add Leonis chip-wide hardware init/deinit logic for Nebula Matrix Ethernet driver,
providing full datapath pipeline configuration and orderly chip-level resource
teardown infrastructure.

This patch implements complete chip hardware lifecycle management to initialize
core datapath components including packet engines, scheduler, buffer stores,
queue manager, per-port traffic shaping and flow control. It also maintains
the firmware-synced driver_status flag to coordinate driver-firmware state.

Core framework enhancements:
1. Add hw_ops.init_module/deinit_module and resource_ops entry points for
chip-level hardware lifecycle management. Callback invocation path will
be added in a subsequent patch, only ops registration here.
2. Implement PCI domain/bus/slot based chip-wide PF registry to track active
driver-bound PFs, preventing premature chip-global firmware deinitialization.
3. Add device link dependency for non-management PFs to enforce deterministic
teardown order, ensuring consumer PFs release before management PF (func 0).

Datapath sub-module initialization covers all core hardware units:
- dped/uped: Configure packet engine registers, checksum offload and TCP profiles
- dsch: Setup scheduler VN quanta and host QID maximum threshold
- ustore/dstore: Tune Tx/Rx buffer thresholds, drop control and flow control
- dvn/uvn: Configure descriptor timeout, PCIe RO and prefetch with firmware quirks
- uqm: Reset queue counters and initialize queue working mode
- shaping: Apply port-speed tailored rate shaping and PSHA scheduler config

Complete chip initialization flow:
1. Initialize all datapath sub-modules via unified nbl_dp_init() entry
2. Configure host adapter PADPT layer flow control via nbl_intf_init()
3. Set driver_status active flag and flush all hardware register writes

Key safety and design guarantees:
- Restrict all chip-global operations exclusively to management PF via has_ctrl
- Only driver register programming; full chip reset is managed by firmware
- Explicit register flushing ensures consistency with async firmware cleanup
- Strict teardown ordering blocks new DMA and in-flight mailbox transactions
- Support UVN descriptor prefetch alignment firmware quirk optimization

Deinit behavior note:
Chip-wide datapath registers are not auto-restored by firmware on deinit.
The deinit path only clears driver_status and flushes writes, retaining
hardware state until chip reset or explicit overwriting.

Add corresponding register definitions, firmware ABI enums, helper routines,
resource callbacks and Makefile entries to wire up the new chip management.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |   1 -
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.c       |  32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.h       |  12 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 633 +++++++++++++++++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 222 ++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   5 +-
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nbl/nbl_include/nbl_def_common.h          |   1 -
 .../nbl/nbl_include/nbl_def_hw.h              |   3 +
 .../nbl/nbl_include/nbl_def_resource.h        |   3 +
 .../nbl/nbl_include/nbl_include.h             |  19 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  56 ++
 13 files changed, 985 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 5aec8e44f5d7..be314b909d66 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -9,4 +9,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 		nbl_hw/nbl_resource.o \
 		nbl_hw/nbl_interrupt.o \
+		nbl_hw/nbl_chip.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
index 7c664195db7f..302c3c48dc4d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -50,4 +50,3 @@ int nbl_common_func_id_to_rel_pf_id(struct nbl_common_info *common, u32 pf_id,
 	*rel_pf_id = pf_id - common->mgt_pf;
 	return 0;
 }
-
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
new file mode 100644
index 000000000000..419eb6392ada
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include "nbl_chip.h"
+
+void nbl_res_chip_deinit_module(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+
+	if (!common->has_ctrl)
+		return;
+	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
+}
+
+int nbl_res_chip_init_module(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_hw_ops *hw_ops;
+	u8 eth_speed, eth_num;
+	struct nbl_hw_mgt *p;
+
+	if (!common->has_ctrl)
+		return -EINVAL;
+	eth_speed = res_mgt->resource_info->board_info.eth_speed;
+	eth_num = res_mgt->resource_info->board_info.eth_num;
+	hw_ops = res_mgt->hw_ops_tbl->ops;
+	p = res_mgt->hw_ops_tbl->priv;
+	return hw_ops->init_module(p, eth_speed, eth_num);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h
new file mode 100644
index 000000000000..d14093ba916c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CHIP_H_
+#define _NBL_CHIP_H_
+
+#include "nbl_resource.h"
+int nbl_res_chip_init_module(struct nbl_resource_mgt *res_mgt);
+void nbl_res_chip_deinit_module(struct nbl_resource_mgt *res_mgt);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 457e0212a7bf..c19c60c9dd99 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -144,6 +144,633 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
 	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
 }
 
+static u32 nbl_hw_get_quirks(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 quirks = 0;
+
+	/*
+	 * Read quirk bits from mailbox register.
+	 * All supported firmware implement the quirk ABI,
+	 * firmware always populates NBL_LEONIS_QUIRKS_OFFSET.
+	 * Value ~0U indicates no active quirks.
+	 */
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, &quirks,
+			     sizeof(u32));
+
+	if (quirks == ~0u)
+		return 0;
+
+	return quirks;
+}
+
+static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data = 0;
+
+	/* DPED dped_l4_ck_cmd_40 for sctp */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, &data, sizeof(data));
+	data |= FIELD_PREP(NBL_DPED_L4_CK_CMD_40_EN_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, &data, sizeof(data));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_dped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_VLAN_OFFSET, 0xC);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_0, 0x8);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_1, 0x4);
+	spin_unlock(&hw_mgt->reg_lock);
+	/* dped checksum offload */
+	nbl_configure_dped_checksum(hw_mgt);
+}
+
+static void nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 hw_edit = 0;
+
+	/* V4 TCP: l3_len = 0 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V4_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+	hw_edit &= ~NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V4_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+
+	/* V6 TCP: l3_len = 1 */
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V6_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+	hw_edit = (hw_edit & ~NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK) |
+		  FIELD_PREP(NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V6_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static int nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
+{
+	struct nbl_shaping_dvn_dport_u dvn_dport = { 0 };
+	struct nbl_shaping_dport_u dport = { 0 };
+	u32 rate, half_rate;
+	u32 depth;
+	u64 low_val, high_val;
+
+	switch (speed) {
+	case NBL_FW_PORT_SPEED_100G:
+		rate = 100000;
+		break;
+	case NBL_FW_PORT_SPEED_50G:
+		rate = 50000;
+		break;
+	case NBL_FW_PORT_SPEED_25G:
+		rate = 25000;
+		break;
+	case NBL_FW_PORT_SPEED_10G:
+		rate = 10000;
+		break;
+	default:
+		dev_err(hw_mgt->common->dev,
+			"Unsupported port speed %u for eth%u\n", speed, eth_id);
+		return -EINVAL;
+	}
+
+	half_rate = rate / 2;
+	depth = max_t(u32, rate * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
+
+	/* 1. clear valid first
+	 * dport and dvn_dport are zero-initialised above, so VALID=0 already
+	 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+
+	/* 2. write config words (valid=0, safe) */
+	low_val = FIELD_PREP(NBL_DPORT_CIR_MASK, rate) |
+		  FIELD_PREP(NBL_DPORT_PIR_MASK, rate) |
+		  FIELD_PREP(NBL_DPORT_DEPTH_MASK, depth) |
+		  FIELD_PREP(NBL_DPORT_CBS_MASK_LOW, depth & 0x3F);
+	high_val = FIELD_PREP(NBL_DPORT_CBS_MASK_HIGH, depth >> 6) |
+		   FIELD_PREP(NBL_DPORT_PBS_MASK, depth);
+	/* Fixed split, independent of host endian */
+	dport.data[0] = lower_32_bits(low_val);
+	dport.data[1] = upper_32_bits(low_val);
+	dport.data[2] = lower_32_bits(high_val);
+	dport.data[3] = upper_32_bits(high_val);
+
+	low_val = FIELD_PREP(NBL_DPORT_CIR_MASK, half_rate) |
+		  FIELD_PREP(NBL_DPORT_PIR_MASK, rate) |
+		  FIELD_PREP(NBL_DPORT_DEPTH_MASK, depth) |
+		  FIELD_PREP(NBL_DPORT_CBS_MASK_LOW, depth & 0x3F);
+	high_val = FIELD_PREP(NBL_DPORT_CBS_MASK_HIGH, depth >> 6) |
+		   FIELD_PREP(NBL_DPORT_PBS_MASK, depth);
+	dvn_dport.data[0] = lower_32_bits(low_val);
+	dvn_dport.data[1] = upper_32_bits(low_val);
+	dvn_dport.data[2] = lower_32_bits(high_val);
+	dvn_dport.data[3] = upper_32_bits(high_val);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+
+	/* 3. commit: set valid last */
+	low_val = FIELD_PREP(NBL_DPORT_VALID_MASK, 1);
+	dport.data[0] |= lower_32_bits(low_val);
+
+	low_val = FIELD_PREP(NBL_DPORT_VALID_MASK, 1);
+	dvn_dport.data[0] |= lower_32_bits(low_val);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+	spin_unlock(&hw_mgt->reg_lock);
+	return 0;
+}
+
+static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+#define NBL_SHAPING_FLUSH_INTERVAL 128
+	struct nbl_shaping_net_u net_shaping = { 0 };
+	u32 eth_bitmap = 0;
+	u32 reg_val;
+	int ret;
+	int i;
+
+	nbl_hw_get_fw_eth_map(hw_mgt, &eth_bitmap);
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(eth_bitmap & BIT(i)))
+			continue;
+		ret = nbl_shaping_eth_init(hw_mgt, i, speed);
+		if (ret)
+			return ret;
+	}
+	nbl_hw_rd_regs_lock(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &reg_val,
+			    sizeof(reg_val));
+	reg_val &= ~NBL_DSCH_PSHA_EN_MASK;
+	reg_val |= FIELD_PREP(NBL_DSCH_PSHA_EN_MASK,
+			      eth_bitmap & GENMASK(3, 0));
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &reg_val,
+			    sizeof(reg_val));
+
+	for (i = 0; i < NBL_MAX_FUNC; i++) {
+		nbl_hw_wr_regs_lock(hw_mgt, NBL_SHAPING_NET_REG(i),
+				    net_shaping.data,
+				    sizeof(net_shaping));
+		if ((i + 1) % NBL_SHAPING_FLUSH_INTERVAL == 0)
+			nbl_flush_writes(hw_mgt);
+	}
+	nbl_flush_writes(hw_mgt);
+	return 0;
+}
+
+static void nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 quanta = 0;
+	u32 qid_max = 0;
+
+	quanta = FIELD_PREP(NBL_DSCH_VN_QUANTA_H_QUA_MASK, NBL_HOST_QUANTA) |
+		 FIELD_PREP(NBL_DSCH_VN_QUANTA_E_QUA_MASK, NBL_ECPU_QUANTA);
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, &quanta,
+		       sizeof(quanta));
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_HOST_QID_MAX, &qid_max,
+		       sizeof(qid_max));
+	qid_max &= ~NBL_DSCH_HOST_QID_MAX_MASK;
+	qid_max |= FIELD_PREP(NBL_DSCH_HOST_QID_MAX_MASK, NBL_MAX_QUEUE_ID);
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_HOST_QID_MAX, &qid_max,
+		       sizeof(qid_max));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
+{
+	u32 eth_bitmap = 0;
+	u32 drop_th = 0;
+	u32 pkt_len = 0;
+	u32 reg_val = 0;
+	int i;
+
+	/*
+	 * eth_num is validated in the resource layer:
+	 * nbl_res_init_pf_num() requires 1/2/4 PFs, and
+	 * nbl_res_ctrl_dev_setup_eth_info() requires max_pf == eth_num.
+	 * This is a defensive check only; if it triggers, the resource
+	 * layer validation was bypassed, which is a bug.
+	 */
+	if (WARN_ON(eth_num != 1 && eth_num != 2 && eth_num != 4))
+		return -EINVAL;
+	/* Read current packet length config
+	 *(to preserve other fields while updating 'min')
+	 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, &pkt_len,
+		       sizeof(pkt_len));
+	/* min arp packet length 42 (14 + 28) */
+	pkt_len &= ~NBL_USTORE_PKT_LEN_MIN_MASK;
+	pkt_len |= FIELD_PREP(NBL_USTORE_PKT_LEN_MIN_MASK, 42);
+	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, &pkt_len,
+		       sizeof(pkt_len));
+
+	drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_EN_MASK, 1);
+	if (eth_num == 1)
+		drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK,
+				      NBL_USTORE_SINGLE_ETH_DROP_TH);
+	else if (eth_num == 2)
+		drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK,
+				      NBL_USTORE_DUAL_ETH_DROP_TH);
+	else
+		drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK,
+				      NBL_USTORE_QUAD_ETH_DROP_TH);
+	nbl_hw_get_fw_eth_map(hw_mgt, &eth_bitmap);
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(eth_bitmap & BIT(i)))
+			continue;
+		nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+			       &reg_val, sizeof(reg_val));
+		reg_val &= ~(NBL_USTORE_PORT_DROP_TH_EN_MASK |
+			    NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK);
+		reg_val |= drop_th;
+		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+			       &reg_val, sizeof(reg_val));
+	}
+
+	/* Clear port drop/truncate counters by reading them
+	 * (hardware has read-to-clear behavior for these registers)
+	 */
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(eth_bitmap & BIT(i)))
+			continue;
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(i));
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(i));
+	}
+	spin_unlock(&hw_mgt->reg_lock);
+	return 0;
+}
+
+static void nbl_dstore_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	u32 eth_bitmap = 0;
+	u32 drop_th = 0;
+	u32 fc_th = 0;
+	u32 bp_th = 0;
+	int i;
+
+	for (i = 0; i < NBL_DSTORE_PORT_DROP_TH_DEPTH; i++) {
+		spin_lock(&hw_mgt->reg_lock);
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i), &drop_th,
+			       sizeof(drop_th));
+		drop_th &= ~NBL_DSTORE_PORT_DROP_EN_MASK;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i), &drop_th,
+			       sizeof(drop_th));
+		spin_unlock(&hw_mgt->reg_lock);
+	}
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th, sizeof(bp_th));
+	bp_th |= FIELD_PREP(NBL_DSTORE_DISC_BP_TH_EN_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th, sizeof(bp_th));
+	spin_unlock(&hw_mgt->reg_lock);
+
+	nbl_hw_get_fw_eth_map(hw_mgt, &eth_bitmap);
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(eth_bitmap & BIT(i)))
+			continue;
+		spin_lock(&hw_mgt->reg_lock);
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i), &fc_th,
+			       sizeof(fc_th));
+		fc_th &= ~(NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK |
+			   NBL_DSTORE_D_DPORT_FC_XON_TH_MASK);
+		if (speed == NBL_FW_PORT_SPEED_100G) {
+			fc_th |=
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK,
+					   NBL_DSTORE_DROP_XOFF_TH_100G) |
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XON_TH_MASK,
+					   NBL_DSTORE_DROP_XON_TH_100G);
+		} else {
+			fc_th |=
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK,
+					   NBL_DSTORE_DROP_XOFF_TH) |
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XON_TH_MASK,
+					   NBL_DSTORE_DROP_XON_TH);
+		}
+
+		fc_th |= FIELD_PREP(NBL_DSTORE_D_DPORT_FC_FC_EN_MASK, 1);
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i), &fc_th,
+			       sizeof(fc_th));
+		spin_unlock(&hw_mgt->reg_lock);
+	}
+}
+
+static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u8 descreq_num)
+{
+	u8 split_ring_num = (descreq_num >> 3) & 0x1;
+	u8 ring_num = descreq_num & 0x7;
+	u32 num_cfg;
+	u32 reg_val;
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &reg_val,
+		       sizeof(reg_val));
+
+	num_cfg = FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK,
+			     split_ring_num) |
+		  FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK,
+			     ring_num);
+	reg_val &= ~(NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK |
+		NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK);
+	reg_val |= num_cfg;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &reg_val,
+		       sizeof(reg_val));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	u32 timeout = 0;
+	u32 ro_flag = 0;
+
+	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
+	timeout = FIELD_PREP(NBL_DVN_DESC_WR_MERGE_TIMEOUT_CFG_CYCLE_MASK,
+			     DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX);
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_DVN_DESC_WR_MERGE_TIMEOUT, &timeout,
+			    sizeof(timeout));
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, &ro_flag,
+		       sizeof(ro_flag));
+	if (pcie_relaxed_ordering_enabled(hw_mgt->common->pdev)) {
+		ro_flag |=
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DESC_RO_EN_MASK,
+				   1) |
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DATA_RO_EN_MASK,
+				   1) |
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_AVRING_RO_EN_MASK,
+				   1);
+	} else {
+		ro_flag &=
+			~(FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DESC_RO_EN_MASK,
+				     1) |
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DATA_RO_EN_MASK,
+				   1) |
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_AVRING_RO_EN_MASK,
+				   1));
+	}
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, &ro_flag,
+		       sizeof(ro_flag));
+	spin_unlock(&hw_mgt->reg_lock);
+	if (speed == NBL_FW_PORT_SPEED_100G)
+		nbl_dvn_descreq_num_cfg(hw_mgt,
+					DEFAULT_DVN_100G_DESCREQ_NUMCFG);
+	else
+		nbl_dvn_descreq_num_cfg(hw_mgt, DEFAULT_DVN_DESCREQ_NUMCFG);
+}
+
+static void nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u16 wr_timeout = NBL_UVN_DESC_WR_TIMEOUT_VAL;
+	u32 timeout = NBL_UVN_DESC_RD_WAIT_TICKS;
+	u32 prefetch_init = 0;
+	bool ro_enabled;
+	u32 flag = 0;
+	u32 mask = 0;
+	u32 quirks;
+	u32 reg_val;
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT,
+		       &reg_val, sizeof(reg_val));
+	reg_val &= ~NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK;
+	reg_val |= FIELD_PREP(NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK, wr_timeout);
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT, &reg_val,
+		       sizeof(reg_val));
+	ro_enabled = pcie_relaxed_ordering_enabled(hw_mgt->common->pdev);
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, &flag, sizeof(flag));
+	if (ro_enabled) {
+		flag |= FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_AVAIL_RD_MASK, 1) |
+		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_RD_MASK, 1) |
+		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_PKT_WR_MASK, 1);
+		flag &= ~FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_WR_MASK, 1);
+	} else {
+		flag &= ~(FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_AVAIL_RD_MASK, 1) |
+			  FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_RD_MASK, 1) |
+			  FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_PKT_WR_MASK, 1) |
+			  FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_WR_MASK, 1));
+	}
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, &flag, sizeof(flag));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, &mask, sizeof(mask));
+	mask |= FIELD_PREP(NBL_UVN_QUEUE_ERR_MASK_DIF_ERR_MASK, 1);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, &mask, sizeof(mask));
+
+	spin_unlock(&hw_mgt->reg_lock);
+	quirks = nbl_hw_get_quirks(hw_mgt);
+	/*
+	 * sel=0: use configured num; sel=1: use internal calc (max 32)
+	 * Default is sel=1, unless NBL_QUIRK_UVN_PREFETCH_ALIGN is set,
+	 * in which case override to sel=0.
+	 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT, &reg_val,
+		       sizeof(reg_val));
+	prefetch_init =
+		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK,
+			   NBL_UVN_DESC_PREFETCH_NUM) |
+		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK,
+			   (quirks & NBL_QUIRK_UVN_PREFETCH_ALIGN) ? 0 : 1);
+	reg_val &= ~(NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK |
+		NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK);
+	reg_val |= prefetch_init;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT, &reg_val,
+		       sizeof(reg_val));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_uqm_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 que_type = 0;
+	u32 cnt = 0;
+	int i;
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_FWD_DROP_CNT, &cnt, sizeof(cnt));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_SLICE_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_LEN_ADD_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_HEAD_PNTR_ADD_CNT, &cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_WEIGHT_ADD_CNT, &cnt, sizeof(cnt));
+
+	for (i = 0; i < NBL_UQM_PORT_DROP_DEPTH; i++) {
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_CNT + (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_SLICE_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+	}
+
+	for (i = 0; i < NBL_UQM_DPORT_DROP_DEPTH; i++)
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i), &cnt,
+			       sizeof(cnt));
+	/* bit0: 0=bp mode, 1=drop mode, resv bit1-31 */
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_QUE_TYPE, &que_type, sizeof(que_type));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static int nbl_dp_init(struct nbl_hw_mgt *hw_mgt, u8 speed, u8 eth_num)
+{
+	int ret;
+
+	nbl_dped_init(hw_mgt);
+	nbl_uped_init(hw_mgt);
+	ret = nbl_shaping_init(hw_mgt, speed);
+	if (ret)
+		return ret;
+	nbl_dsch_qid_max_init(hw_mgt);
+	ret = nbl_ustore_init(hw_mgt, eth_num);
+	if (ret)
+		return ret;
+	nbl_dstore_init(hw_mgt, speed);
+	nbl_dvn_init(hw_mgt, speed);
+	nbl_uvn_init(hw_mgt);
+	nbl_uqm_init(hw_mgt);
+	return 0;
+}
+
+static void nbl_host_padpt_init(struct nbl_hw_mgt *hw_mgt)
+{
+	/* padpt flow  control register */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP,
+		    NBL_HOST_PADPT_CFG_FC_CPLH_UP_VAL);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PD_DN,
+		    NBL_HOST_PADPT_CFG_FC_PD_DN_VAL);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PH_DN,
+		    NBL_HOST_PADPT_CFG_FC_PH_DN_VAL);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN,
+		    NBL_HOST_PADPT_CFG_FC_NPH_DN_VAL);
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_intf_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_host_padpt_init(hw_mgt);
+}
+
+static void nbl_hw_set_driver_status(struct nbl_hw_mgt *hw_mgt, bool active)
+{
+	u32 status;
+
+	spin_lock(&hw_mgt->reg_lock);
+	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);
+
+	status &= ~BIT(NBL_DRIVER_STATUS_BIT);
+	status |= FIELD_PREP(BIT(NBL_DRIVER_STATUS_BIT), active);
+
+	nbl_hw_wr32(hw_mgt, NBL_DRIVER_STATUS_REG, status);
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+/*
+ * Setting driver status to false notifies firmware to clean up per-PF
+ * hardware state such as qinfo registers.
+ *
+ * Note: firmware does NOT automatically revert chip-wide registers
+ * configured in this init flow. Those chip-wide settings remain valid
+ * until chip reset or explicitly overwritten by driver.
+ *
+ * This deinit_module only clears driver active status and flush writes.
+ * It does NOT reset or restore chip-wide datapath registers.
+ *
+ * Caller must ensure no new DMA is initiated after this point.
+ * The mailbox channel is stopped by nbl_chan_teardown_queue()
+ * before this function is called, so no in-flight mailbox DMA
+ * remains.
+ */
+static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_set_driver_status(hw_mgt, false);
+	/* ensure registers written */
+	nbl_flush_writes(hw_mgt);
+	/*
+	 * Firmware cleanup is asynchronous: there is no cleanup-complete
+	 * status register in the current hardware revision.  The posted
+	 * write flush above only ensures driver_status reaches the chip;
+	 * firmware may still be performing per-PF state cleanup when this
+	 * function returns.
+	 */
+}
+
+static bool nbl_hw_eth_speed_valid(u8 speed)
+{
+	switch (speed) {
+	case NBL_FW_PORT_SPEED_10G:
+	case NBL_FW_PORT_SPEED_25G:
+	case NBL_FW_PORT_SPEED_50G:
+	case NBL_FW_PORT_SPEED_100G:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nbl_hw_eth_num_valid(u8 eth_num)
+{
+	return eth_num == 1 || eth_num == 2 || eth_num == 4;
+}
+
+/*
+ * Full chip hardware initialization is handled by firmware.
+ * This function only configures driver-level table entries and registers.
+ */
+static int nbl_hw_init_module(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
+			      u8 eth_num)
+{
+	int ret;
+
+	if (!nbl_hw_eth_speed_valid(eth_speed)) {
+		dev_err(hw_mgt->common->dev, "Invalid eth_speed %u\n",
+			eth_speed);
+		return -EINVAL;
+	}
+	if (!nbl_hw_eth_num_valid(eth_num)) {
+		dev_err(hw_mgt->common->dev, "Invalid eth_num %u\n", eth_num);
+		return -EINVAL;
+	}
+
+	ret = nbl_dp_init(hw_mgt, eth_speed, eth_num);
+	if (ret)
+		return ret;
+	nbl_intf_init(hw_mgt);
+	nbl_hw_set_driver_status(hw_mgt, true);
+	/* ensure registers written */
+	nbl_flush_writes(hw_mgt);
+
+	return 0;
+}
+
 /*
  * nbl_hw_set_mailbox_irq - read-modify-write NBL_MAILBOX_QINFO_MAP_REG_ARR
  *
@@ -408,6 +1035,9 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_module = nbl_hw_init_module,
+	.deinit_module = nbl_hw_deinit_module,
+
 	.cfg_msix_map = nbl_hw_cfg_msix_map,
 	.cfg_msix_info = nbl_hw_cfg_msix_info,
 	.flush_write = nbl_flush_writes,
@@ -458,7 +1088,8 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
 	    !hw_ops.stop_mailbox_rxq || !hw_ops.stop_mailbox_txq ||
 	    !hw_ops.get_host_pf_mask || !hw_ops.get_real_bus ||
 	    !hw_ops.cfg_mailbox_qinfo || !hw_ops.set_mailbox_irq ||
-	    !hw_ops.get_fw_eth_map || !hw_ops.get_board_info)
+	    !hw_ops.get_fw_eth_map || !hw_ops.get_board_info ||
+	    !hw_ops.init_module || !hw_ops.deinit_module)
 		return ERR_PTR(-EINVAL);
 	hw_ops_tbl->ops = &hw_ops;
 	hw_ops_tbl->priv = hw_mgt;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 18e3e7da4f9d..8c9ce8b793e9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -11,12 +11,25 @@
 #include "../../nbl_include/nbl_include.h"
 #include "../nbl_hw_reg.h"
 
+#define NBL_DRIVER_STATUS_REG			0x1300444
+#define NBL_DRIVER_STATUS_BIT			16
+
 /*  ----------  REG BASE ADDR  ----------  */
 /* Interface modules base addr */
 #define NBL_INTF_HOST_PCOMPLETER_BASE		0x00f08000
 #define NBL_INTF_HOST_PADPT_BASE		0x00f4c000
 #define NBL_INTF_HOST_MAILBOX_BASE		0x00fb0000
 #define NBL_INTF_HOST_PCIE_BASE			0X01504000
+/* DP modules base addr */
+#define NBL_DP_USTORE_BASE			0x00104000
+#define NBL_DP_UQM_BASE				0x00114000
+#define NBL_DP_UPED_BASE			0x0015c000
+#define NBL_DP_UVN_BASE				0x00244000
+#define NBL_DP_DSCH_BASE			0x00404000
+#define NBL_DP_SHAPING_BASE			0x00504000
+#define NBL_DP_DVN_BASE				0x00514000
+#define NBL_DP_DSTORE_BASE			0x00704000
+#define NBL_DP_DPED_BASE			0x0075c000
 /*  --------  MAILBOX BAR2 -----  */
 #define NBL_MAILBOX_NOTIFY_ADDR			0x00000000
 #define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	0x10
@@ -56,6 +69,17 @@ struct nbl_mailbox_qinfo_cfg_table {
 #define NBL_PCIE_BUS_MASK	GENMASK(12, 5)
 
 /*  --------  HOST_PADPT  --------  */
+#define NBL_HOST_PADPT_HOST_CFG_FC_PD_DN (NBL_INTF_HOST_PADPT_BASE + 0x00000160)
+#define NBL_HOST_PADPT_HOST_CFG_FC_PH_DN (NBL_INTF_HOST_PADPT_BASE + 0x00000164)
+#define NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN \
+	(NBL_INTF_HOST_PADPT_BASE + 0x0000016C)
+#define NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00000170)
+
+#define NBL_HOST_PADPT_CFG_FC_CPLH_UP_VAL      0x10400
+#define NBL_HOST_PADPT_CFG_FC_PD_DN_VAL        0x10080
+#define NBL_HOST_PADPT_CFG_FC_PH_DN_VAL        0x10010
+#define NBL_HOST_PADPT_CFG_FC_NPH_DN_VAL       0x10010
 /* host_padpt host_msix_info */
 #define NBL_PADPT_HOST_MSIX_INFO_REG_ARR(vector_id) \
 	(NBL_INTF_HOST_PADPT_BASE + 0x00010000 +    \
@@ -96,6 +120,203 @@ struct nbl_function_msix_map {
 	u32 data[NBL_FUNC_MSIX_MAP_DWLEN];
 };
 
+/*  ----------  DPED  ----------  */
+#define NBL_DPED_VLAN_OFFSET		(NBL_DP_DPED_BASE + 0x000003F4)
+#define NBL_DPED_DSCP_OFFSET_0		(NBL_DP_DPED_BASE + 0x000003F8)
+#define NBL_DPED_DSCP_OFFSET_1		(NBL_DP_DPED_BASE + 0x000003FC)
+/* DPED hw_edt_prof/ UPED hw_edt_prof */
+
+#define NBL_DPED_L4_CK_CMD_40_ADDR	(NBL_DP_DPED_BASE + 0x00000338)
+
+#define NBL_DPED_L4_CK_CMD_40_EN_MASK		BIT(31)
+
+/*  ----------  UPED  ----------  */
+/* UPED uped_hw_edt_prof */
+#define NBL_UPED_HW_EDT_PROF_TABLE(i) \
+	(NBL_DP_UPED_BASE + 0x00001000 + (i) * sizeof(u32))
+#define NBL_UPED_V4_TCP_IDX		5
+#define NBL_UPED_V6_TCP_IDX		6
+#define NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK GENMASK(3, 2)
+
+/*  ----------  DSCH  ----------  */
+#define NBL_DSCH_PSHA_EN_MASK  GENMASK(3, 0)
+/* DSCH dsch maxqid */
+#define NBL_DSCH_HOST_QID_MAX (NBL_DP_DSCH_BASE + 0x00000118)
+#define NBL_DSCH_HOST_QID_MAX_MASK GENMASK(10, 0)
+#define NBL_DSCH_VN_QUANTA_ADDR (NBL_DP_DSCH_BASE + 0x00000134)
+
+#define NBL_MAX_QUEUE_ID	0x7ff
+#define NBL_HOST_QUANTA		0x8000
+#define NBL_ECPU_QUANTA		0x1000
+
+#define NBL_DSCH_VN_QUANTA_H_QUA_MASK GENMASK(15, 0)
+#define NBL_DSCH_VN_QUANTA_E_QUA_MASK GENMASK(31, 16)
+
+/*  ----------  DVN  ----------  */
+/* DVN dvn_queue_table */
+#define NBL_DVN_ECPU_QUEUE_NUM			(NBL_DP_DVN_BASE + 0x0000041C)
+#define NBL_DVN_DESCREQ_NUM_CFG			(NBL_DP_DVN_BASE + 0x00000430)
+#define NBL_DVN_DESC_WR_MERGE_TIMEOUT		(NBL_DP_DVN_BASE + 0x00000480)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG		(NBL_DP_DVN_BASE + 0x0000045C)
+
+#define DEFAULT_DVN_DESCREQ_NUMCFG		0x03
+#define DEFAULT_DVN_100G_DESCREQ_NUMCFG		0x07
+
+#define DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX	0x3FF
+
+/* spilit ring descreq_num 0:8,1:16 */
+#define NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK BIT(0)
+/* packet ring descreq_num
+ * 0:8,1:12,2:16;3:20,4:24,5:26;6:32,7:32
+ */
+#define NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK GENMASK(6, 4)
+
+#define NBL_DVN_DESC_WR_MERGE_TIMEOUT_CFG_CYCLE_MASK GENMASK(9, 0)
+
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG_DESC_RO_EN_MASK BIT(0)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG_DATA_RO_EN_MASK BIT(1)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG_AVRING_RO_EN_MASK BIT(2)
+
+/*  ----------  UVN  ----------  */
+/* UVN uvn_queue_table */
+
+#define NBL_UVN_DESC_RD_WAIT			(NBL_DP_UVN_BASE + 0x0000020C)
+#define NBL_UVN_QUEUE_ERR_MASK			(NBL_DP_UVN_BASE + 0x00000224)
+#define NBL_UVN_ECPU_QUEUE_NUM			(NBL_DP_UVN_BASE + 0x0000023C)
+#define NBL_UVN_DESC_WR_TIMEOUT			(NBL_DP_UVN_BASE + 0x00000214)
+#define NBL_UVN_DIF_REQ_RO_FLAG			(NBL_DP_UVN_BASE + 0x00000250)
+#define NBL_UVN_DESC_PREFETCH_INIT		(NBL_DP_UVN_BASE + 0x00000204)
+#define NBL_UVN_DESC_PREFETCH_NUM		4
+
+#define NBL_UVN_DIF_REQ_RO_FLAG_AVAIL_RD_MASK BIT(0)
+#define NBL_UVN_DIF_REQ_RO_FLAG_DESC_RD_MASK BIT(1)
+#define NBL_UVN_DIF_REQ_RO_FLAG_PKT_WR_MASK BIT(2)
+#define NBL_UVN_DIF_REQ_RO_FLAG_DESC_WR_MASK BIT(3)
+
+#define NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK GENMASK(14, 0)
+
+#define NBL_UVN_QUEUE_ERR_MASK_DIF_ERR_MASK BIT(5)
+
+#define NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK GENMASK(7, 0)
+#define NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK BIT(16)
+
+#define NBL_UVN_DESC_WR_TIMEOUT_VAL 0x12c
+/* 200us = 200000ns / 1.67ns per tick = 119760 ticks */
+#define NBL_UVN_DESC_RD_WAIT_TICKS 119760
+
+/*  --------  USTORE  --------  */
+#define NBL_USTORE_PKT_LEN_ADDR (NBL_DP_USTORE_BASE + 0x00000108)
+#define NBL_USTORE_PORT_DROP_TH_REG_ARR(port_id) \
+	(NBL_DP_USTORE_BASE + 0x00000150 + (port_id) * sizeof(u32))
+#define NBL_USTORE_BUF_PORT_DROP_PKT(eth_id) \
+	(NBL_DP_USTORE_BASE + 0x00002500 + (eth_id) * sizeof(u32))
+#define NBL_USTORE_BUF_PORT_TRUN_PKT(eth_id) \
+	(NBL_DP_USTORE_BASE + 0x00002540 + (eth_id) * sizeof(u32))
+
+#define NBL_USTORE_SINGLE_ETH_DROP_TH		0xC80
+#define NBL_USTORE_DUAL_ETH_DROP_TH		0x640
+#define NBL_USTORE_QUAD_ETH_DROP_TH		0x320
+
+/* USTORE pkt_len */
+#define NBL_USTORE_PKT_LEN_MIN_MASK GENMASK(6, 0)
+
+/* USTORE port_drop_th */
+#define NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK GENMASK(11, 0)
+#define NBL_USTORE_PORT_DROP_TH_EN_MASK BIT(31)
+
+/* UQM*/
+#define NBL_UQM_QUE_TYPE			(NBL_DP_UQM_BASE + 0x0000013c)
+#define NBL_UQM_DROP_PKT_CNT			(NBL_DP_UQM_BASE + 0x000009C0)
+#define NBL_UQM_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009C4)
+#define NBL_UQM_DROP_PKT_LEN_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009C8)
+#define NBL_UQM_DROP_HEAD_PNTR_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009CC)
+#define NBL_UQM_DROP_WEIGHT_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009D0)
+#define NBL_UQM_PORT_DROP_PKT_CNT		(NBL_DP_UQM_BASE + 0x000009D4)
+#define NBL_UQM_PORT_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009F4)
+#define NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A14)
+#define NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A34)
+#define NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A54)
+#define NBL_UQM_FWD_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000A80)
+#define NBL_UQM_DPORT_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000B74)
+
+#define NBL_UQM_PORT_DROP_DEPTH			6
+#define NBL_UQM_DPORT_DROP_DEPTH		16
+
+/*  ---------  SHAPING  ---------  */
+
+/* Shaping rate unit: 1 = 1 Mbit/s.
+ * e.g. 100000 = 100 Gbit/s, 25000 = 25 Gbit/s.
+ */
+#define NBL_LR_LEONIS_NET_BUCKET_DEPTH		9600
+#define NBL_SHAPING_DPORT_ADDR (NBL_DP_SHAPING_BASE + 0x700)
+#define NBL_SHAPING_DPORT_DWLEN 4
+#define NBL_SHAPING_DPORT_REG(r) \
+	(NBL_SHAPING_DPORT_ADDR + (NBL_SHAPING_DPORT_DWLEN * 4) * (r))
+#define NBL_SHAPING_DVN_DPORT_ADDR (NBL_DP_SHAPING_BASE + 0x750)
+#define NBL_SHAPING_DVN_DPORT_DWLEN 4
+#define NBL_SHAPING_DVN_DPORT_REG(r) \
+	(NBL_SHAPING_DVN_DPORT_ADDR + (NBL_SHAPING_DVN_DPORT_DWLEN * 4) * (r))
+#define NBL_DSCH_PSHA_EN_ADDR (NBL_DP_DSCH_BASE + 0x00000314)
+#define NBL_SHAPING_NET_ADDR (NBL_DP_SHAPING_BASE + 0x1800)
+#define NBL_SHAPING_NET_DWLEN 4
+#define NBL_SHAPING_NET_REG(r) \
+	(NBL_SHAPING_NET_ADDR + (NBL_SHAPING_NET_DWLEN * 4) * (r))
+
+#define NBL_DPORT_VALID_MASK		GENMASK_ULL(0, 0)
+#define NBL_DPORT_DEPTH_MASK		GENMASK_ULL(19, 1)
+#define NBL_DPORT_CIR_MASK		GENMASK_ULL(38, 20)
+#define NBL_DPORT_PIR_MASK		GENMASK_ULL(57, 39)
+#define NBL_DPORT_CBS_MASK_LOW		GENMASK_ULL(63, 58)
+#define NBL_DPORT_CBS_MASK_HIGH		GENMASK_ULL(14, 0)
+#define NBL_DPORT_PBS_MASK		GENMASK_ULL(35, 15)
+
+/* SHAPING shaping_net */
+struct nbl_shaping_net_u {
+	u32 data[NBL_SHAPING_NET_DWLEN];
+};
+
+struct nbl_shaping_dport_u {
+	u32 data[NBL_SHAPING_DPORT_DWLEN];
+};
+
+struct nbl_shaping_dvn_dport_u {
+	u32 data[NBL_SHAPING_DVN_DPORT_DWLEN];
+};
+
+/*  --------  DSTORE  --------  */
+#define NBL_DSTORE_D_DPORT_FC_TH_ADDR  (NBL_DP_DSTORE_BASE + 0x00000600)
+#define NBL_DSTORE_D_DPORT_FC_TH_DEPTH 5
+#define NBL_DSTORE_D_DPORT_FC_TH_WIDTH 32
+#define NBL_DSTORE_D_DPORT_FC_TH_DWLEN 1
+
+#define NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK GENMASK(10, 0)
+#define NBL_DSTORE_D_DPORT_FC_XON_TH_MASK GENMASK(26, 16)
+#define NBL_DSTORE_D_DPORT_FC_FC_EN_MASK BIT(31)
+
+#define NBL_DSTORE_D_DPORT_FC_TH_REG(r)  \
+	(NBL_DSTORE_D_DPORT_FC_TH_ADDR + \
+	 (NBL_DSTORE_D_DPORT_FC_TH_DWLEN * 4) * (r))
+#define NBL_DSTORE_PORT_DROP_TH_ADDR (NBL_DP_DSTORE_BASE + 0x00000150)
+#define NBL_DSTORE_PORT_DROP_TH_DEPTH 6
+#define NBL_DSTORE_PORT_DROP_TH_WIDTH 32
+#define NBL_DSTORE_PORT_DROP_TH_DWLEN 1
+
+#define NBL_DSTORE_PORT_DROP_EN_MASK BIT(31)
+
+#define NBL_DSTORE_DROP_XOFF_TH			0xC8
+#define NBL_DSTORE_DROP_XON_TH			0x64
+
+#define NBL_DSTORE_DROP_XOFF_TH_100G		0x1F4
+#define NBL_DSTORE_DROP_XON_TH_100G		0x12C
+
+#define NBL_DSTORE_DISC_BP_TH (NBL_DP_DSTORE_BASE + 0x00000630)
+
+#define NBL_DSTORE_DISC_BP_TH_EN_MASK BIT(31)
+
+#define NBL_DSTORE_PORT_DROP_TH_REG(r)  \
+	(NBL_DSTORE_PORT_DROP_TH_ADDR + \
+	 (NBL_DSTORE_PORT_DROP_TH_DWLEN * 4) * (r))
+
 #define NBL_FW_BOARD_CONFIG			0x200
 #define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
 #define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
@@ -109,5 +330,6 @@ struct nbl_function_msix_map {
 #define NBL_FW_BOARD_DW6_LANE_BITMAP_MASK GENMASK(7, 0)
 #define NBL_FW_BOARD_DW6_ETH_BITMAP_MASK GENMASK(15, 8)
 
+#define NBL_LEONIS_QUIRKS_OFFSET	0x00000140
 #define NBL_BAR2_MAX_LEN		0x300
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 62af1738e2fd..18ff6de793ba 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -13,6 +13,8 @@ static struct nbl_resource_ops res_ops = {
 	.cfg_msix_map = nbl_res_intr_cfg_msix_map,
 	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
 	.set_mailbox_irq = nbl_res_intr_set_mailbox_irq,
+	.init_module = nbl_res_chip_init_module,
+	.deinit_module = nbl_res_chip_deinit_module,
 };
 
 static struct nbl_resource_mgt *
@@ -46,7 +48,8 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
 		return ERR_PTR(-ENOMEM);
 	if (!res_ops.get_vsi_id || !res_ops.get_eth_id ||
 	    !res_ops.cfg_msix_map || !res_ops.destroy_msix_map ||
-	    !res_ops.set_mailbox_irq)
+	    !res_ops.set_mailbox_irq || !res_ops.init_module ||
+	    !res_ops.deinit_module)
 		return ERR_PTR(-EINVAL);
 	res_ops_tbl->ops = &res_ops;
 	res_ops_tbl->priv = res_mgt;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 6eb4dc9e695a..f1cb0f23240b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -8,4 +8,5 @@
 
 #include "../nbl_resource.h"
 #include "../nbl_interrupt.h"
+#include "../nbl_chip.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index fa76dd6c5323..3e18a2a97850 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -51,5 +51,4 @@ void nbl_common_destroy_wq(struct nbl_common_info *common);
 int nbl_common_create_wq(struct nbl_common_info *common);
 int nbl_common_func_id_to_rel_pf_id(struct nbl_common_info *common, u32 pf_id,
 				    u32 *rel_pf_id);
-
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index b9b92c42f276..6aff1b10eb7f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -12,6 +12,9 @@ struct nbl_board_port_info;
 struct nbl_hw_mgt;
 struct nbl_adapter;
 struct nbl_hw_ops {
+	int (*init_module)(struct nbl_hw_mgt *hw_mgt, u8 eth_speed, u8 eth_num);
+	void (*deinit_module)(struct nbl_hw_mgt *hw_mgt);
+
 	void (*cfg_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 			     bool valid, dma_addr_t dma_addr, u8 bus,
 			     u8 devid, u8 function);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index e718ea41a816..8dc64e806c1e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -12,6 +12,9 @@ struct nbl_resource_mgt;
 struct nbl_adapter;
 
 struct nbl_resource_ops {
+	int (*init_module)(struct nbl_resource_mgt *res_mgt);
+	void (*deinit_module)(struct nbl_resource_mgt *res_mgt);
+
 	int (*cfg_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			    u16 num_net_msix, u16 num_others_msix,
 			    bool net_msix_mask_en);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 2c959832c32f..5ae9fc2ea53b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -30,4 +30,23 @@ struct nbl_init_param {
 	struct nbl_func_caps caps;
 };
 
+/*
+ * Firmware ABI defines port speed enum fixed, value 0 represents 10G, cannot
+ * reassign 0 to INVALID for compatibility
+ */
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
+};
+
+/*
+ * Firmware quirk word @ NBL_LEONIS_QUIRKS_OFFSET (0x140)
+ * Sentinel value: ~0U (0xFFFFFFFF) = firmware reports no active quirks
+ * BIT(1): NBL_QUIRK_UVN_PREFETCH_ALIGN – control UVN descriptor prefetch
+ * selection
+ */
+#define NBL_QUIRK_UVN_PREFETCH_ALIGN	BIT(1)
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 1aafed2d46d7..6df91c751bc5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -83,6 +83,56 @@ static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
 		param->caps.has_ctrl = 1;
 }
 
+/*
+ * Establish chip-wide dependencies for this PF:
+ *  - register it in the chip registry so control PF teardown can detect
+ *    siblings that are still bound;
+ *  - for every non-management PF, add a consumer->management PF device
+ *    link. The driver core then guarantees (sysfs unbind, driver
+ *    unregister, hot-unplug alike) that this consumer is released
+ *    BEFORE the func 0 supplier, which is the only teardown order in
+ *    which the chip-global firmware deinit is safe.
+ *
+ * The management PF is addressed by the deterministic identity
+ * (domain, bus, slot, func 0) instead of any name-based scan: hardware
+ * guarantees PFs are contiguous from func 0 in the same slot.
+ *
+ * The link uses DL_FLAG_AUTOREMOVE_CONSUMER, so it is dropped by the
+ * driver core when this PF detaches; it must not be removed manually.
+ * A DORMANT link (func 0 not bound yet) activates automatically once
+ * the management PF driver binds.
+ *
+ * Return: 0 on success, negative errno on failure. On failure the chip
+ * registry entry has already been rolled back.
+ */
+static int nbl_probe_chip_deps(struct pci_dev *pdev, bool has_ctrl)
+{
+	struct pci_dev *mgt;
+	int err = 0;
+
+	if (has_ctrl)
+		return 0;
+
+	mgt = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					  pdev->bus->number,
+					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
+	if (!mgt) {
+		dev_err(&pdev->dev,
+			"management PF (func 0) not found on this chip\n");
+		return -ENODEV;
+	}
+
+	if (!device_link_add(&pdev->dev, &mgt->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		dev_err(&pdev->dev,
+			"failed to create device link to management PF %s\n",
+			pci_name(mgt));
+		err = -ENOMEM;
+	}
+	pci_dev_put(mgt);
+	return err;
+}
+
 static int nbl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *id)
 {
@@ -103,6 +153,10 @@ static int nbl_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
+	err = nbl_probe_chip_deps(pdev, param.caps.has_ctrl);
+	if (err)
+		goto chip_deps_err;
+
 	adapter = nbl_core_init(pdev, &param);
 	if (IS_ERR(adapter)) {
 		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
@@ -112,6 +166,7 @@ static int nbl_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, adapter);
 	return 0;
 adapter_init_err:
+chip_deps_err:
 	pci_clear_master(pdev);
 	return err;
 }
@@ -122,6 +177,7 @@ static void nbl_remove(struct pci_dev *pdev)
 
 	if (!adapter)
 		return;
+
 	pci_set_drvdata(pdev, NULL);
 	nbl_core_remove(adapter);
 
-- 
2.47.3

