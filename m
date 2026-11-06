Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941009;
	b=siQD2Gp8LTCs8GoZbHPt15wTm6qgRC2j2tbvibtAyZ8lNm8n9EZ8M3vcxqgCQnW7K+9q
	 36LqLInNllwra4LT5C6/sxEFKYLd8NBJc7lpvsp3xG+AQO9Fdlj81+OAEgTuk+PqVgcQN
	 I1Ann2fqF6poD6n3hko/gmWwvI54sfluPejav4pEtkYW/KeadIXbLDPuWD5KjXG48Jgwj
	 +4ly06OkKgWjN8vy9cL3SBaz46znu9DRIz98K/XNlz5luGa4m8D/hFpnIRCr8mwrLJs8k
	 jbXhyxuv0+UhGlrSQxzL7P4g5LTJWcQ0ZMMBRwnckB8g0algWkI50GmsxCKR/UO9CAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941009;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WXep718RuFIf+nMBzPZ64eCZ/bjmspQNyhFKmof9V1o=;
	b=Ra7pnKIKF9hqhksPEvD5hTWmETjZt0tPj7CtbMWn7dkj9nD6bezsM4kv18hzqOMYdeAg
	 FxtAKIZjaFSdGkj8rWgVv8bXXybpe5O5y853mJegcwB4OJGV1wsli8QbBPLl+IBGBqArP
	 1N7rR6WUal4bpwDizwH5BBW/gRhwI9SOM59fOtwhitlct5C1Tu6xY8tMxP5lTsIG4uRxp
	 LuFCABrurHHjvCYHGCkCsl7LBvpK9goKhHm0T5sJwTM/IG4g+RCz45Hbp7ZZAzDGoB5m9
	 BgY00Zvm3NMPvfx/iHrcftFW1hGEn9llhTPNX61B+K1f/wNV09OD2AYtub08x5cgszA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.122
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992D606A32C;
	Fri,  6 Nov 2026 04:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3992D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.8895047;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0306749-0.00175247-0.967573;FP=9472154398279405105|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jy28Jjo_1793940997;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jy28Jjo_1793940997 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 12:56:38 +0800
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
Subject: [PATCH v33 net-next 3/8] net/nebula-matrix: add intr resource implementation
Date: Fri,  6 Nov 2026 12:56:20 +0800
Message-ID: <20261106045631.2224-4-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106045631.2224-1-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-1-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add dedicated nbl_interrupt module to manage chip-internal MSI-X interrupt
resource and hardware mapping for the Nebula Matrix Ethernet driver.

This module manages the driver-wide global hardware MSI-X vector index
space, split into independent network and control interrupt bitmaps
(intr_net_bmap/intr_other_bmap), and handles programming of the
chip-internal MSI-X mapping registers.  It explicitly does not manage
physical PCI MSI-X entries; physical vector allocation via
pci_alloc_irq_vectors() will be implemented in a follow-up patch via
nbl_dev_init_interrupt_scheme().

The published manager is control-PF only: the resource ops reject calls
when common->has_ctrl is not set.

Core functional interfaces:
1. cfg_msix_map: Allocate global hardware MSI-X vectors from the separate
   net/other interrupt bitmaps.  Reuse the per-function coherent DMA map
   table on reconfig, so a reconfiguration neither frees and reallocates
   the table nor has to take the destroy-path quiesce window before the
   old vectors are recycled.  The first configuration of a function still
   takes one invalidate + flush + quiesce window before the table is
   written; that window belongs to the first configuration only and is
   not part of the reconfiguration path.  Only tear down the old hardware
   state after the new allocation succeeds, to avoid interrupt loss, and
   program the MSI-X table DMA address plus the control-PF BDF into
   NBL_PCOMPLETER_FUNCTION_MSIX_MAP.

2. destroy_msix_map: Recycle global vector indices, clear hardware MSI-X
   mappings, and release DMA/descriptor resources.  Implements two-stage
   teardown: disable mailbox IRQ routing first, mask vectors, clear
   hardware VALID bits while retaining the live DMA addresses, take a
   bounded best-effort ~1ms hardware DMA quiescence window, then zero the
   table entries and free the coherent memory to prevent torn reads.

3. set_mailbox_irq: Toggle PF-specific mailbox MSI-X routing by updating
   NBL_MAILBOX_QINFO_MAP_REG_ARR.  The disable path works without a
   configured MSI-X map, enabling safe routing cleanup before vector
   release.

4. cfg_msix_info: Program PADPT_HOST_MSIX_INFO and
   PCOMPLETER_HOST_MSIX_FID_TABLE with the strict hardware-defined
   programming order (forward for enable, reverse for teardown) to avoid
   inconsistent hardware state.

Key design & safety features:
- Self-contained intr_mgt->lock protects the global bitmaps and the
  per-function state; all public APIs hold the lock internally, so callers
  need no upper-layer locking.
- Global cleanup via nbl_intr_mgt_stop(): under the lock it latches the
  manager stopping and invalidates the hardware map entry of every function
  still left CONFIGURED, then takes a single global quiesce window before
  the coherent tables and vector indices are released.  Remote PF maps are
  created via mailbox RPC in later patches; the cleanup itself uses local
  MMIO writes.
- Only PFs are supported: every op rejects a func_id outside the PF range
  (a VF id) with -EINVAL, and cfg_msix_map additionally rejects a func_id
  that maps to a PF which is not present on this board with -EOPNOTSUPP,
  via nbl_res_func_id_to_bdf().
- FUNCTION_MSIX_MAP survives a kexec or a forced unload without FLR and
  there is no .shutdown callback to scrub it, so nbl_intr_mgt_start()
  invalidates all NBL_MAX_PF map entries once, followed by one flush and
  one quiesce window, before any function is configured.  nbl_probe() now
  leaves bus mastering disabled until nbl_core_init() has returned, so
  this scrub runs before the device can issue a single fetch against a
  stale VALID entry - those fetches are bus-master reads, and a stale
  entry points at memory this kernel may already have reallocated.
  Everything between pci_set_master() and the scrub is host-side setup
  plus MMIO and does not wait for the device.  The gvec-indexed INFO/FID
  tables are not scrubbed; their entries are rewritten before a map entry
  is armed again.

Known limitation - MSI-X map table DMA quiescence:
The chip exposes no idle or completion status for a pcompleter fetch of a
map table, so the only ordering available anywhere in this module is
"clear VALID -> flush_write() -> bounded delay".  The delay is sized well
above the tables' worst-case fetch/response latency, but it is a
best-effort approximation and not a guarantee; a caller that cannot
tolerate the residual risk must keep the table allocated for the lifetime
of the function rather than rely on it.
Two things narrow the window rather than close it.  Tables are freed only
after that delay, and nbl_remove() now clears Bus Master Enable before
any teardown runs, so the device cannot start a new fetch once teardown
has begun and the residual window covers in-flight requests only.
Neither helps a sibling PF's map destroyed at runtime: those fetches are
tagged with the control PF's BDF, so clearing bus mastering on the
sibling does not stop them.  Runtime destroys of sibling maps only become
reachable with the mailbox RPC added later in this series.

Instantiate the interrupt manager via nbl_intr_mgt_start() during device
resource initialization, and attach it to the resource management context.

Add corresponding hardware register definitions, helper functions, resource
ops callbacks, and Makefile entries to wire up the new module.
The new resource ops (cfg_msix_map, destroy_msix_map, set_mailbox_irq) are
hooked into resource_ops but have no in-tree callers within this patch;
invocation will be added in subsequent patches in this series.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 164 +++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  44 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  38 +-
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 851 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  90 ++
 .../nbl/nbl_include/nbl_def_hw.h              |   9 +
 .../nbl/nbl_include/nbl_def_resource.h        |   6 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  48 +-
 12 files changed, 1291 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 3dab9519..5aec8e44 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -8,4 +8,5 @@ nbl-objs +=	nbl_common/nbl_common.o \
 		nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 		nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 		nbl_hw/nbl_resource.o \
+		nbl_hw/nbl_interrupt.o \
 		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index e0c885f2..75d6982a 100644
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
@@ -315,6 +471,8 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.cfg_msix_map = nbl_hw_cfg_msix_map,
+	.cfg_msix_info = nbl_hw_cfg_msix_info,
 	.flush_write = nbl_flush_writes,
 
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
@@ -326,6 +484,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.set_mailbox_irq = nbl_hw_set_mailbox_irq,
 
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
@@ -356,11 +515,12 @@ static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
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
index 251dd68d..b7c0a87c 100644
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
index dd8cf9e5..da4258cf 100644
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
@@ -328,8 +337,31 @@ int nbl_res_init_leonis(struct nbl_adapter *adap)
 
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
index b9355262..6eb4dc9e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -7,4 +7,5 @@
 #define _NBL_RESOURCE_LEONIS_H_
 
 #include "../nbl_resource.h"
+#include "../nbl_interrupt.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 00000000..3969392a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,851 @@
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
+ *
+ * Both are bus-master reads tagged with the control PF's BDF, so
+ * pci_clear_master() is the only other lever, and nbl_remove() pulls it
+ * before any teardown runs: that keeps the device from starting a new
+ * fetch inside this window.  It cannot help a sibling PF's map destroyed
+ * at runtime, because those fetches carry the control PF's BDF and so
+ * are unaffected by clearing bus mastering on the sibling.  Runtime
+ * destroys of sibling maps only become reachable with the mailbox RPC
+ * added later in this series.
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
+	/*
+	 * func_intr_res[] is indexed by the raw hardware function id; this
+	 * bound check is the only guard on this path, so it is what keeps
+	 * VF ids out.  Whether the PF is present on this board is not
+	 * checked here: callers pass either common->mgt_pf or an id that
+	 * nbl_res_intr_cfg_msix_map() has validated.
+	 */
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
+				"MSI-X mapping: func_id=%u is not a PF present on this board\n",
+				func_id);
+		return ret;
+	}
+
+	mutex_lock(&intr_mgt->lock);
+	official_tbl = &intr_mgt->func_intr_res[func_id].msix_map_table;
+
+	/* Reject new configs once global teardown has started */
+	if (intr_mgt->stopping) {
+		ret = -ESHUTDOWN;
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
+	 * First configuration of this function.  Re-invalidate the entry
+	 * and take a quiesce window before the table below is rewritten:
+	 * while the entry is VALID the pcompleter could fetch a table
+	 * that is being written and route stale gvecs.
+	 *
+	 * This is a second, real quiesce window rather than part of the
+	 * reconfiguration path, and it costs one delay per function on the
+	 * first configuration only.  Reusing the table removes the
+	 * free/realloc cycle and the destroy-path quiesce window from
+	 * every *re*configuration; it does not remove this one.
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
+ * Reset the software state and invalidate every function's hardware MSI-X
+ * map entry once.  The chip-internal tables (FUNCTION_MSIX_MAP,
+ * PADPT_HOST_MSIX_INFO, HOST_MSIX_FID_TABLE) can survive a kexec or a
+ * forced unload without FLR and there is no .shutdown callback to scrub
+ * them.  Only FUNCTION_MSIX_MAP is scrubbed here: it is indexed by
+ * func_id, so covering all NBL_MAX_PF entries costs one register write
+ * each, after which the pcompleter can no longer fetch a stale table that
+ * points into memory this kernel may have reallocated.  The INFO/FID
+ * tables are indexed by global vector id and are not cleared; instead a
+ * map entry is always invalidated by nbl_res_intr_cfg_msix_map() and by
+ * the teardown paths before it is armed for a new configuration.
+ *
+ * No sibling PF is live at this point: the device links make them probe
+ * only after this PF and remove before it, so clearing all NBL_MAX_PF
+ * entries cannot disturb a running function.
+ */
+static struct nbl_interrupt_mgt *
+nbl_intr_setup_mgt(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_interrupt_mgt *intr_mgt;
+	u16 func_id;
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
+	/*
+	 * Invalidate any map entry left VALID by a previous kernel.  One
+	 * flush plus one quiesce window covers the outstanding table
+	 * fetches, same as the teardown paths do.
+	 *
+	 * This is the scrub that makes it safe to enable bus mastering:
+	 * nbl_probe() calls it with bus mastering still disabled, so no
+	 * new fetch can start while these entries are still VALID.
+	 */
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++)
+		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
+				     false, 0, 0, 0, 0);
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+	nbl_intr_quiesce_wait();
+
+	return intr_mgt;
+}
+
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_interrupt_mgt *intr_mgt;
+	int ret;
+
+	intr_mgt = nbl_intr_setup_mgt(res_mgt);
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
+ * The latch is what rejects a caller that raced the window; it is not
+ * what makes the manager safe to touch.  No caller is in flight here by
+ * construction: nbl_remove() clears bus mastering and stops the device
+ * before reaching this point, and every sibling PF - the only remote
+ * source of these calls - is unbound first through its
+ * DL_FLAG_AUTOPROBE_CONSUMER device link.  A caller that did latch the
+ * pointer earlier and then gets in under the lock hits the latch
+ * instead:
+ *   - the config path, destroy_msix_map and the enable path of
+ *     nbl_res_intr_set_mailbox_irq() report -ESHUTDOWN.  The latch is
+ *     checked ahead of that path's per-function state check, so its
+ *     -ENODEV is only reachable while the manager is not stopping.
+ *   - the en_msix=false disable path consults neither and returns 0,
+ *     which is what lets teardown disarm routing after the latch is set.
+ * Once this returns res_mgt->intr_mgt is NULL and the public entry
+ * points report -EINVAL.
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
index 00000000..9f66f5e1
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
index b316fb8e..49c7d441 100644
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
+			"func_id=%u rel_pf_id=%u exceeds max_pf=%u, no such PF on this board\n",
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
index ae0a3d33..24cf4947 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -17,6 +17,72 @@
 
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
+	 * Indexed by the raw hardware function id.  Only PF entries are ever
+	 * used: the public entry points reject ids outside the PF range (VFs
+	 * included) with -EINVAL, and nbl_res_intr_cfg_msix_map() also
+	 * rejects a PF that is not present on this board.  The destroy and
+	 * mailbox paths only bound-check NBL_MAX_PF; they rely on their
+	 * callers passing either common->mgt_pf or an id that the config
+	 * path has already validated.
+	 */
+	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_PF];
+};
+
 /* --------- INFO ---------- */
 struct nbl_sriov_info {
 	unsigned int bdf;
@@ -56,14 +122,38 @@ struct nbl_resource_mgt {
 	struct nbl_resource_info *resource_info;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	/*
+	 * Published interrupt manager, control PF only.  The public entry
+	 * points read this pointer without the manager lock and then pass
+	 * the value they read down to the internal helpers;
+	 * nbl_intr_mgt_stop() clears it under the manager lock as its last
+	 * step, after every hardware access and every free, so a caller
+	 * that reads it after that gets -EINVAL.
+	 *
+	 * The object is devres-owned and is released together with the
+	 * device rather than by nbl_intr_mgt_stop(), so a latched pointer
+	 * is never dereferenced into freed memory.  That is not what keeps
+	 * a concurrent caller safe, though: see nbl_intr_mgt_stop() for
+	 * the ordering that makes sure there is none.  A caller that
+	 * latched the pointer before it was cleared and then gets in under
+	 * the lock hits the stopping latch: the config path,
+	 * destroy_msix_map and the mailbox-enable path report -ESHUTDOWN,
+	 * while the mailbox-disable path (en_msix == false) returns 0
+	 * without consulting the latch.
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
index 08ce19b0..ca131e43 100644
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
@@ -60,6 +67,8 @@ struct nbl_hw_ops {
 
 	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				  u8 bus, u8 devid, u8 function);
+	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				bool en_msix, u16 gvec);
 	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
 	/**
 	 * get_board_info - Fetch board info from firmware
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 7136b282..e718ea41 100644
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index d11b68be..3c711f9d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -269,24 +269,36 @@ static int nbl_probe(struct pci_dev *pdev,
 	/* never return fail when DMA_BIT_MASK(64) */
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
-	pci_set_master(pdev);
-
+	/*
+	 * Bus mastering is enabled only after nbl_core_init() returns.
+	 *
+	 * FUNCTION_MSIX_MAP survives a kexec or a forced unload without
+	 * FLR and there is no .shutdown callback to scrub it, so at this
+	 * point every map entry left VALID by a previous kernel still
+	 * holds a DMA address that this kernel has already reallocated.
+	 * Those entries tag their table fetches as bus-master reads, and
+	 * the only thing standing between such a fetch and a read of
+	 * reused memory is Bus Master Enable, which the PCI core cleared
+	 * on the way into this kernel.  nbl_intr_setup_mgt() invalidates
+	 * the entries from inside nbl_core_init(); enabling bus mastering
+	 * before that would re-open the window.  Everything up to that
+	 * point is host-side setup plus MMIO and nothing in it waits for
+	 * the device, so it does not need bus mastering.
+	 */
 	err = nbl_probe_chip_deps(pdev, param.caps.has_ctrl);
 	if (err)
-		goto out_clear_master;
+		return err;
 
 	adapter = nbl_core_init(pdev, &param);
 	if (IS_ERR(adapter)) {
 		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
-		err = PTR_ERR(adapter);
-		goto out_clear_master;
+		return PTR_ERR(adapter);
 	}
+
+	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
 
 	return 0;
-out_clear_master:
-	pci_clear_master(pdev);
-	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
@@ -296,9 +308,27 @@ static void nbl_remove(struct pci_dev *pdev)
 	if (!adapter)
 		return;
 	pci_set_drvdata(pdev, NULL);
-	nbl_core_remove(adapter);
 
+	/*
+	 * Stop bus mastering before any teardown runs.
+	 *
+	 * nbl_core_remove() releases the coherent MSI-X map tables whose
+	 * DMA addresses are still programmed in FUNCTION_MSIX_MAP, and the
+	 * only thing standing between a late pcompleter fetch and a read
+	 * of freed memory is a bounded best-effort delay - the chip
+	 * exposes no completion status for those fetches (see
+	 * nbl_intr_quiesce_wait()).  Clearing Bus Master Enable first
+	 * keeps the device from starting a new fetch at all, so that
+	 * residual window only covers requests already in flight.
+	 *
+	 * nbl_core_stop() above has already torn down this function's own
+	 * map, so what is left to protect here is the control PF's table of
+	 * per-function entries, freed from nbl_intr_mgt_stop() inside
+	 * nbl_core_remove().
+	 */
 	pci_clear_master(pdev);
+
+	nbl_core_remove(adapter);
 }
 
 /*
-- 
2.51.0.windows.1

