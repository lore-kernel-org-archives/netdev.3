Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606084;
	b=3sfQAGdnZlbDbbD3+mAC4VxLhiSmePaiqMuDFl1Sqfj2AEU1PANzwB4aNaJrBSvZWV3J
	 yvwQz2egUaICvxIZP0wpo75KhbcEwqtmsLDMdoQMwtVrlcUCdz/9X9vimolxwjjHJ2uYr
	 lTfh+i9fiodB82JbdB1i46PE4dhBpmtLjSZwGf5q9nuCJEXqZJiDfw43VX0i1nlrf2u2S
	 Qcnfq39NPmOUV8D5GWH/UrGJLRCh8NNqS/ujiw72NUY95rf/NOHPAwsXwXW85kTpymCr/
	 MwZJkgsUOI3i/A/8svwihhP6tMAiJn8sqB/xw45btlSZ9Y+LLDI+0qhvzVVVKwg+QzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606084;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KvGyvmyLpt9CPWE8t50J0nXHoPyBsYA4mVwn5JiR0Hc=;
	b=pFn5rcz1rnEga2y3jNm/ftPYsmPhsUWphm41EbDNebuSkUHGlUDba/oQCosv+m3e7kc1
	 q4RpPDXrq5nzRq/A9IbtYTSou+dHqPCJgG40ToPjdUhT9TD7AUw891LYhqknMNODtrAbx
	 XmJnB2Qye1STqt4o3b+oBUrNOX5TNuXTy733RtNbRgFWaxCRjwkZ2tWj7SwJPxzLoz3Y/
	 gWwowoZVWiPhgfwJhOto85udsG3wAdheO0YdQbXbylTf1aLQbLF0Y3IZ9TnCuvyhcT6VG
	 fEmoLC93gRbHATlbpNMHo2LWPwz4+k/egSpsrscHnop0u9NnFs5FsDt5cphaFROvQbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.49
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94288606A331;
	Mon,  2 Nov 2026 07:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94288606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.025645-0.000503552-0.973851;FP=17390626030395940274|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jumCpXR_1793606070;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jumCpXR_1793606070 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 15:54:31 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v33 net-next 4/8] net/nebula-matrix: add chip-wide hardware init/deinit implementation
Date: Mon,  2 Nov 2026 15:54:05 +0800
Message-ID: <20261102075424.2165-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
References: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add the Leonis chip-wide init_module() and deinit_module() hooks in the
hw and resource layers.  The resource layer gates both on has_ctrl, so
they only run on the control PF.

init_module() programs the chip-wide datapath registers, none of which
firmware sets up on the driver's behalf:

  - DPED: VLAN/DSCP offsets and the SCTP L4 checksum enable.
  - UPED: V4/V6 TCP L3-length edit profiles.
  - SHAPING: per-port CIR/PIR from the firmware-reported speed (the DVN
    dport entry carries PIR at the full rate and CIR at half rate), a
    bucket depth derived from the rate, PSHA enable for the ports
    present, and a clear of the PF-indexed shaping_net table.
  - DSCH: host QID max (0x7ff) and the host/ECPU quanta.
  - USTORE: minimum packet length 42 and the per-port drop threshold,
    scaled by the PF count, plus a clear of the port drop/truncate
    counters by reading them back.
  - DSTORE: clear the per-port drop enable, program the XON/XOFF
    flow-control thresholds (a larger pair at 100G), and enable the
    discard backpressure threshold.
  - DVN: ECPU queue count, descriptor-write merge timeout, descriptor
    request count (by speed), and the relaxed-ordering bits.
  - UVN: ECPU queue count, descriptor read-wait/write-timeout, the error
    mask, and the relaxed-ordering bits.  The relaxed-ordering bits in
    both DVN and UVN are derived from the PCIe DEVCTL state through
    pcie_relaxed_ordering_enabled().
  - UQM: clear the drop counters and force que_type to backpressure.
  - PADPT: the host flow-control credits.

This also adds a firmware ABI dependency: nbl_hw_get_quirks() reads a
quirk word at mailbox offset NBL_LEONIS_QUIRKS_OFFSET (0x140), where
~0U means "no quirks" and BIT(1) selects the UVN prefetch mode (sel=0,
use the configured descriptor count) instead of the internal
calculation.

deinit_module() clears the driver_status bit, flushes writes and sleeps
2-3 ms to give the asynchronous firmware cleanup pass time to run.  It
deliberately reverts none of the above: that pass covers per-PF state
only (qinfo registers and mailbox routing), so the chip-wide datapath
registers stay programmed until chip reset or until a later
init_module() overwrites them, even if the control PF is later bound to
another driver.  The hardware exposes no cleanup-complete status bit, so
the sleep is best-effort and cannot prove the pass has finished.

A stale driver_status bit (kexec, or an unload that never reached
deinit_module()) is cleared in nbl_hw_init_leonis(), before this probe
programs any per-PF state.  The 1 -> 0 transition makes firmware
reclaim the mailbox QINFO routing and qinfo registers, so clearing it
from init_module() instead - after nbl_dev_setup_chan_qinfo() has
programmed them - would leave the inter-PF mailbox dead and make sibling
probes time out.

Two known limitations of that handshake, neither of which the driver can
close on this hardware:

  - NBL_DRIVER_STATUS_REG is shared with firmware.  Bit 16 is the only
    bit the driver owns, and the register has no documented W1S/W1C
    form, so changing bit 16 has to be a read-modify-write.  reg_lock
    makes the read-modify-write atomic against other CPU writers but
    cannot serialise against firmware, so a firmware update to a
    different bit landing between the read and the write would be
    written back stale.  All three callers (the probe-time stale clear,
    init_module() and deinit_module()) could in principle hit that; no
    such firmware update is known to race them, but that is an
    observation about this hardware revision, not a guarantee.

  - The 2-3 ms wait is an empirical bound, not a documented firmware
    latency.  There is nothing to poll instead: the hardware exposes no
    cleanup-complete bit, and the reclaimed entries read back the same
    before and after the pass, so there is no observable side effect to
    wait on and nothing to validate the delay against.  A pass that
    takes longer than the window - an ECPU still busy right after kexec,
    say - can therefore still race a later probe and reclaim routing
    that probe has already programmed.  What actually protects the
    per-PF state is the ordering around the clear, not the delay, and on
    teardown that ordering comes from the device link between the
    sibling PFs and the control PF.

The two hooks are only checked for non-NULL by nbl_hw_setup_ops() and
nbl_res_setup_ops() at this point; nothing calls them yet.  They gain
callers later in the series, from the dispatch init_module()/
deinit_module() and from nbl_dev_setup_ctrl_dev()/
nbl_dev_remove_ctrl_dev().

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.c       |  32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.h       |  12 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 753 +++++++++++++++++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 242 ++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   5 +-
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nbl/nbl_include/nbl_def_hw.h              |   3 +
 .../nbl/nbl_include/nbl_def_resource.h        |   3 +
 .../nbl/nbl_include/nbl_include.h             |  19 +
 10 files changed, 1069 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 5aec8e44..be314b90 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -9,4 +9,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 		nbl_hw/nbl_resource.o \
 		nbl_hw/nbl_interrupt.o \
+		nbl_hw/nbl_chip.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
new file mode 100644
index 00000000..419eb639
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
index 00000000..d14093ba
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
index 75d6982a..2b55f2c2 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -5,11 +5,36 @@
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
 
+/*
+ * Firmware cleanup after driver_status=false is asynchronous and the
+ * current hardware revision exposes no cleanup-complete status bit, so
+ * this delay is best-effort only: it gives the firmware pass time to
+ * settle before the caller returns, but cannot prove that it has.
+ * Bounding the wait keeps a later probe from re-programming the per-PF
+ * registers that pass reclaims (mailbox QINFO routing, qinfo registers)
+ * while firmware is realistically still wiping them.  The chip-wide
+ * datapath registers init_module() writes are not part of that pass and
+ * stay programmed until chip reset.  The hard teardown ordering comes
+ * from the device-link relationship between the sibling PFs and the
+ * control PF.
+ *
+ * These bounds are empirical, not derived from a documented firmware
+ * latency.  There is nothing to poll for instead: the hardware exposes
+ * no cleanup-complete bit, and the reclaimed entries read back the same
+ * before and after the pass, so there is no observable side effect to
+ * wait on and nothing to validate the delay against.  A firmware pass
+ * that takes longer than this window - an ECPU still busy right after
+ * kexec, say - can therefore still race a later probe.
+ */
+#define NBL_FW_CLEANUP_SYNC_MIN_US	2000
+#define NBL_FW_CLEANUP_SYNC_MAX_US	3000
+
 static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
 				 u32 len)
 {
@@ -150,6 +175,719 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
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
+	/*
+	 * Read-modify-write as one critical section: reg_lock is dropped
+	 * between the two _lock() helpers, which would let another writer
+	 * of this register land in the middle of the update.  Nothing
+	 * else touches NBL_DSCH_PSHA_EN_ADDR today, but the RMW has to be
+	 * atomic for that to stay true.
+	 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &reg_val,
+		       sizeof(reg_val));
+	reg_val &= ~NBL_DSCH_PSHA_EN_MASK;
+	reg_val |= FIELD_PREP(NBL_DSCH_PSHA_EN_MASK,
+			      eth_bitmap & GENMASK(3, 0));
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &reg_val,
+		       sizeof(reg_val));
+	spin_unlock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < NBL_MAX_PF; i++) {
+		nbl_hw_wr_regs_lock(hw_mgt, NBL_SHAPING_NET_REG(i),
+				    net_shaping.data,
+				    sizeof(net_shaping));
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
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
+	spin_unlock(&hw_mgt->reg_lock);
+
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
+/*
+ * Read-modify-write under reg_lock: NBL_DRIVER_STATUS_BIT is the only
+ * bit the driver owns, and the RMW writes back every other bit exactly
+ * as it read it, so firmware state in those bits survives.
+ *
+ * That only holds against concurrent CPU writers.  reg_lock cannot
+ * serialise against firmware, and the register has no documented
+ * W1S/W1C form that would let the driver flip bit 16 without the
+ * read-modify-write; see NBL_DRIVER_STATUS_REG.
+ */
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
+ * Firmware cleanup is asynchronous with no completion status register.
+ * The flush only guarantees the status write reached the device; the
+ * bounded delay after it (NBL_FW_CLEANUP_SYNC_MIN_US) is best-effort and
+ * does not guarantee that the firmware pass has finished.  The ordering
+ * this relies on is the device-link one: the siblings are consumers of
+ * the control PF, so they are unbound first, and that link is created
+ * with DL_FLAG_AUTOPROBE_CONSUMER.  AUTOPROBE only re-probes consumers,
+ * never the control PF itself, so a later init_module() needs an admin
+ * (or a driver rebind) to bind this PF again, and only then does the
+ * core re-probe the siblings.  Both steps are far slower than the
+ * firmware pass, but there is no hard firmware handshake.
+ *
+ * Caller must ensure no new DMA is initiated after this point.
+ * The mailbox channel is stopped by nbl_chan_teardown_queue()
+ * before this function is called, so no in-flight mailbox DMA
+ * remains.
+ */
+static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_set_driver_status(hw_mgt, false);
+	/* ensure driver_status reaches the chip */
+	nbl_flush_writes(hw_mgt);
+	/*
+	 * Give the asynchronous firmware cleanup pass time to settle
+	 * before returning; best-effort, see NBL_FW_CLEANUP_SYNC_MIN_US.
+	 */
+	usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US, NBL_FW_CLEANUP_SYNC_MAX_US);
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
+ * Clear a stale driver_status active bit before this probe programs any
+ * per-PF state.
+ *
+ * A previous kernel instance can leave the bit set (kexec, or an unload
+ * that never reached deinit_module()) and firmware then never ran the
+ * per-PF cleanup it drives off the 1 -> 0 transition.  That cleanup
+ * reclaims the mailbox QINFO routing and the qinfo registers, which is
+ * exactly what nbl_dev_setup_chan_qinfo() and nbl_chan_setup_queue()
+ * write later in this probe.
+ *
+ * So the ordering this has to guarantee is: clear the bit before any of
+ * that per-PF state is programmed, and before the mailbox queue is live
+ * so the cleanup cannot reclaim routing under an in-flight transfer.
+ * Clearing it later - once nbl_dev_init() has programmed the routing and
+ * enabled the queue - wipes those registers and leaves the inter-PF
+ * mailbox dead, so sibling PFs' RPCs time out in nbl_dev_start() and
+ * their probes fail.  That is why init_module() must not do it.
+ *
+ * Only the control PF owns this chip-wide handshake.  The bounded wait
+ * after the clear is best-effort, see NBL_FW_CLEANUP_SYNC_MIN_US.
+ */
+static void nbl_hw_clear_stale_status(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 status;
+
+	if (!hw_mgt->common->has_ctrl)
+		return;
+
+	/*
+	 * Unlocked read: this runs only from the serialized control-PF probe,
+	 * and the driver is the only writer of NBL_DRIVER_STATUS_BIT.  A stale
+	 * sample at worst causes one redundant clear plus sleep; the
+	 * authoritative update happens under reg_lock in
+	 * nbl_hw_set_driver_status().
+	 */
+	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);
+	if (!(status & BIT(NBL_DRIVER_STATUS_BIT)))
+		return;
+
+	dev_warn(hw_mgt->common->dev,
+		 "driver_status already set, stale cleanup forced\n");
+	nbl_hw_set_driver_status(hw_mgt, false);
+	nbl_flush_writes(hw_mgt);
+	usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US, NBL_FW_CLEANUP_SYNC_MAX_US);
+}
+
+/*
+ * Firmware brings the chip up at power-up, but the chip-wide datapath
+ * registers this programs (SHAPING, DSCH, USTORE/DSTORE, DVN/UVN, UQM,
+ * PADPT) are not part of that: the driver owns them from here until chip
+ * reset, and firmware does not revert them when driver_status goes low -
+ * see nbl_hw_deinit_module().
+ *
+ * The driver_status handshake is entered from a known state: a stale
+ * active bit is cleared earlier, in nbl_hw_init_leonis(), before this
+ * probe programs any per-PF state.  It must not be cleared here, because
+ * the mailbox QINFO routing and the mailbox queue registers are already
+ * programmed by then and the cleanup the 1 -> 0 transition starts would
+ * reclaim them; see nbl_hw_clear_stale_status().
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
@@ -471,6 +1209,9 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_module = nbl_hw_init_module,
+	.deinit_module = nbl_hw_deinit_module,
+
 	.cfg_msix_map = nbl_hw_cfg_msix_map,
 	.cfg_msix_info = nbl_hw_cfg_msix_info,
 	.flush_write = nbl_flush_writes,
@@ -521,7 +1262,8 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
 	    !hw_ops.stop_mailbox_rxq || !hw_ops.stop_mailbox_txq ||
 	    !hw_ops.get_host_pf_mask || !hw_ops.get_real_bus ||
 	    !hw_ops.cfg_mailbox_qinfo || !hw_ops.set_mailbox_irq ||
-	    !hw_ops.get_fw_eth_map || !hw_ops.get_board_info)
+	    !hw_ops.get_fw_eth_map || !hw_ops.get_board_info ||
+	    !hw_ops.init_module || !hw_ops.deinit_module)
 		return ERR_PTR(-EINVAL);
 	hw_ops_tbl->ops = &hw_ops;
 	hw_ops_tbl->priv = hw_mgt;
@@ -645,6 +1387,15 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 	hw_mgt->mailbox_bar_size = bar_len;
 	spin_lock_init(&hw_mgt->reg_lock);
 
+	/*
+	 * Clear a stale driver_status now, while this is the only register
+	 * access this probe has done: the firmware cleanup the 1 -> 0
+	 * transition starts reclaims the mailbox QINFO routing and qinfo
+	 * registers that nbl_dev_init() programs later, so it must not be
+	 * deferred to init_module(); see nbl_hw_clear_stale_status().
+	 */
+	nbl_hw_clear_stale_status(hw_mgt);
+
 	hw_ops_tbl = nbl_hw_setup_ops(common, hw_mgt);
 	if (IS_ERR(hw_ops_tbl)) {
 		ret = PTR_ERR(hw_ops_tbl);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index b7c0a87c..7d27ab19 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -11,12 +11,45 @@
 #include "../../nbl_include/nbl_include.h"
 #include "../nbl_hw_reg.h"
 
+/*
+ * Chip-wide driver-present handshake with firmware.
+ *
+ * NBL_DRIVER_STATUS_BIT is the only bit the driver owns: setting it tells
+ * firmware that a driver is bound, and the 1 -> 0 transition starts the
+ * firmware pass that reclaims per-PF state (mailbox QINFO routing, qinfo
+ * registers).  Every other bit of this register belongs to firmware and
+ * the driver must leave it as it read it.
+ *
+ * Because the register is shared, bit 16 can only be changed with a
+ * read-modify-write: it has no documented W1S/W1C semantics that would
+ * let the driver set or clear that one bit atomically.  reg_lock makes
+ * the read-modify-write atomic with respect to other CPU writers, but it
+ * cannot serialise against firmware, so a firmware update to another bit
+ * landing between the read and the write would be written back stale.
+ * No such firmware update is known to race the three driver callers
+ * (the probe-time clear, init_module() and deinit_module()), but that is
+ * an observation about this hardware revision, not a guarantee the
+ * driver can enforce.
+ */
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
@@ -56,6 +89,17 @@ struct nbl_mailbox_qinfo_cfg_table {
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
@@ -98,6 +142,203 @@ struct nbl_function_msix_map {
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
@@ -111,5 +352,6 @@ struct nbl_function_msix_map {
 #define NBL_FW_BOARD_DW6_LANE_BITMAP_MASK GENMASK(7, 0)
 #define NBL_FW_BOARD_DW6_ETH_BITMAP_MASK GENMASK(15, 8)
 
+#define NBL_LEONIS_QUIRKS_OFFSET	0x00000140
 #define NBL_BAR2_MAX_LEN		0x300
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index da4258cf..ba589af5 100644
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
index 6eb4dc9e..f1cb0f23 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -8,4 +8,5 @@
 
 #include "../nbl_resource.h"
 #include "../nbl_interrupt.h"
+#include "../nbl_chip.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index ca131e43..e9cd3136 100644
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
index e718ea41..8dc64e80 100644
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
index 59e44fea..efc4c79a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -29,4 +29,23 @@ struct nbl_init_param {
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
-- 
2.51.0.windows.1

