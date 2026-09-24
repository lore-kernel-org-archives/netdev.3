Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77252222597
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254773; cv=none; b=NZ0hiRmn+0ZTJpYW5pVx7BzjgCxx/fGP2U/v7VsU+UM8ua2pGOBXpff5vIsaETsHeFnpZsYGMewXOt4ahLJVlLAOVwSYs8hnssOhc2K0YKEmt/me0rTjprRd147dUXyibzUCzIMv8MMcN3QIY1aY5P6oQlGfypdNDEazdN7+TV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254773; c=relaxed/simple;
	bh=msXKp6CC/ep+giV26muxkpmdRcbKph8YIsTJZyZZg6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9EKLKvMAcFACKDiuqk+GcpcdxeP+tOjIylfKAsmTYAdLAONB+8IkS953ge36RkWxN7yJmOzQjb1R8KOfydq5Sm49dxMqMnMQL3gCdPG0H9rXbZ57q5LeAO3f3uGa0bhbsdFIJlRhZP3foeNa4XRbTE6AJ4AiChgrW8BDyjj+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq+vz4Rg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq+vz4Rg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254772; x=1821790772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msXKp6CC/ep+giV26muxkpmdRcbKph8YIsTJZyZZg6Y=;
  b=Bq+vz4RgT3hMjHX4yjbinPmaglhLToYs4RsY0k/Tx9RgQo2I2IeW2/R9
   1cngEWHYn6RLEo8fMUseIzC/bFmWeulaW+eLD0+kLMi3c2yWpxV7Evw3O
   LarhzNjEaeBKrJUUEuVyFmrwNg0BKEu6zEmOX/Jfp+JIOwGN8SmXy9G6G
   Xtp33lN8XZklFPgAQS2HY0tWVK1tYTViJrW1SgkTuPlJ7c1/aw99Yn/ot
   g6U8W/1fIcgu/w4oXJGv8gIgNp3Fhtjx11T2/Yvk/ry8VOU+fKfnw3ZI+
   qxhxCc+hZGjSmAU3dFv3kWchlyt/YLxQ4WplfwnC+6SoJDZWuJepEQaUH
   A==;
X-CSE-ConnectionGUID: pbMtAKf4QZCd8wunMqwUZQ==
X-CSE-MsgGUID: QuhT9MgWQC6K4KasaXaoHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249218"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249218"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:20 -0700
X-CSE-ConnectionGUID: QmPKzMBJQkSSXmbbyXIHHQ==
X-CSE-MsgGUID: L96KtBOiSPuKChQeV7fC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934424"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:19 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 2/8] ice: Protect the control PF pointer with RCU and a rwsem
Date: Thu, 24 Sep 2026 12:59:10 +0000
Message-ID: <20260924125916.2796499-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark adapter->ctrl_pf as __rcu and route every reader through
rcu_dereference_check(), publishing it with rcu_assign_pointer(). Readers
that can run in an RCU read-side critical section are wrapped
accordingly.

Add adapter->ctrl_pf_lock for the sleepable users which cannot sit in an
RCU read-side critical section, namely the PTP hardware semaphore in
ice_ptp_lock()/ice_ptp_unlock() and the TX reference clock paths in
ice_txclk.c. Pass the resolved control PF into ice_txclk_enable_peer()
so it is looked up once under that lock.

The pointer is still only ever published and never cleared, so there is
no functional change here. This only puts the annotations and the
locking in place for the lifetime handling that follows.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 25 +++++-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 83 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 23 ++++++
 drivers/net/ethernet/intel/ice/ice_txclk.c   | 20 +++--
 6 files changed, 120 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 117391f62848..08b40626b876 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -41,6 +41,7 @@
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
+#include <linux/rcupdate.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tc_act/tc_mirred.h>
@@ -1141,26 +1142,44 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
  * ice_get_primary_hw - Get pointer to primary ice_hw structure
  * @pf: pointer to PF structure
  *
+ * The function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ * hw is embedded in struct ice_pf, so either mechanism protects its lifetime.
+ *
  * Return: A pointer to ice_hw structure with access to timesync
  * register space.
  */
 static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 {
-	if (!pf->adapter->ctrl_pf)
+	struct ice_pf *ctrl_pf;
+
+	ctrl_pf = rcu_dereference_check(pf->adapter->ctrl_pf,
+					lockdep_is_held(&pf->adapter->ctrl_pf_lock));
+
+	if (!ctrl_pf)
 		return &pf->hw;
 	else
-		return &pf->adapter->ctrl_pf->hw;
+		return &ctrl_pf->hw;
 }
 
 /**
  * ice_get_ctrl_pf - Get pointer to Control PF of the adapter
  * @pf: pointer to the current PF structure
  *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ *
  * Return: A pointer to ice_pf structure which is Control PF,
  * NULL if it's not initialized yet.
  */
 static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 {
-	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+	return !pf->adapter ? NULL :
+		rcu_dereference_check(pf->adapter->ctrl_pf,
+				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 }
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index ba2a50f0da95..5dc4e5f1c6aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -69,6 +69,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
+	init_rwsem(&adapter->ctrl_pf_lock);
 
 	return adapter;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 6f94c5fd6a88..9de00435bf2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
@@ -36,6 +37,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @ctrl_pf_lock: Protect control PF lifetime for sleepable users
  * @ctrl_pf: Control PF of the adapter
  * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
  * @ports: Ports list
@@ -52,7 +54,8 @@ struct ice_adapter {
 	/* Serialize PFR recovery touching shared FW global state */
 	struct mutex rebuild_lock;
 
-	struct ice_pf *ctrl_pf;
+	struct rw_semaphore ctrl_pf_lock;
+	struct ice_pf __rcu *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5104ccc70d4c..455e3af30abe 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2021, Intel Corporation. */
 
 #include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
@@ -60,6 +61,19 @@ static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
 	{  SDP3, {  3, -1 }, { 0, 0 }},
 };
 
+/**
+ * ice_get_ctrl_ptp - Get the PTP structure for the control PF
+ * @pf: The PF pointer to look up at
+ *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ *
+ * Return: Pointer to the PTP structure of the control PF, or NULL if not found
+ */
 static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
 {
 	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
@@ -208,39 +222,42 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
-	if (!ice_is_primary(hw))
-		hw = ice_get_primary_hw(pf);
-
-	tmr_idx = ice_get_ptp_src_clock_index(hw);
-	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
-	/* Read the system timestamp pre PHC read */
-	ptp_read_system_prets(sts);
-
-	if (hw->mac_type == ICE_MAC_E830) {
-		u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+	scoped_guard(rcu) {
+		if (!ice_is_primary(hw))
+			hw = ice_get_primary_hw(pf);
 
-		/* Read the system timestamp post PHC read */
-		ptp_read_system_postts(sts);
-
-		return clk_time;
-	}
+		tmr_idx = ice_get_ptp_src_clock_index(hw);
+		guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
+		/* Read the system timestamp pre PHC read */
+		ptp_read_system_prets(sts);
 
-	lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+		if (hw->mac_type == ICE_MAC_E830) {
+			u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
 
-	/* Read the system timestamp post PHC read */
-	ptp_read_system_postts(sts);
+			/* Read the system timestamp post PHC read */
+			ptp_read_system_postts(sts);
 
-	hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
-	lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			return clk_time;
+		}
 
-	if (lo2 < lo) {
-		/* if TIME_L rolled over read TIME_L again and update
-		 * system timestamps
-		 */
-		ptp_read_system_prets(sts);
 		lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		/* Read the system timestamp post PHC read */
 		ptp_read_system_postts(sts);
+
 		hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		if (lo2 < lo) {
+			/* if TIME_L rolled over read TIME_L again and update
+			 * system timestamps
+			 */
+			ptp_read_system_prets(sts);
+			lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			ptp_read_system_postts(sts);
+			hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		}
+
 	}
 
 	return ((u64)hi << 32) | lo;
@@ -3245,14 +3262,19 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
-	pf->adapter->ctrl_pf = pf;
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
+	struct ice_ptp *ctrl_ptp;
+
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
 
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp) {
 		dev_info(ice_pf_to_dev(pf),
 			 "PTP unavailable: no controlling PF\n");
@@ -3327,11 +3349,15 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
  */
 int ice_ptp_clock_index(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
+	struct ice_ptp *ctrl_ptp;
 	struct ptp_clock *clock;
 
+	guard(rcu)();
+
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp)
 		return -1;
+
 	clock = ctrl_ptp->clock;
 
 	return clock ? ptp_clock_index(clock) : -1;
@@ -3595,6 +3621,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (ptp->port.tx.init)
 		ice_ptp_release_tx_tracker(pf, &ptp->port.tx);
 	mutex_destroy(&ptp->port.ps_lock);
+
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 881f002daa74..0e138390f8c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include "ice_common.h"
@@ -335,6 +336,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -353,6 +356,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -2009,6 +2014,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
 	}
@@ -2180,8 +2187,13 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		/* cleanup.h advises against mixing goto with scoped helpers,
+		 * and this function unwinds the PTP semaphore with goto below.
+		 */
+		rcu_read_lock();
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+		rcu_read_unlock();
 	}
 	incval = (u64)hi << 32 | lo;
 
@@ -5321,6 +5333,9 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
  *
  * Software must clear the busy bit with a write to release the lock for other
  * functions when done.
+ *
+ * A successful call holds adapter->ctrl_pf_lock for read until
+ * ice_ptp_unlock() is called.
  */
 bool ice_ptp_lock(struct ice_hw *hw)
 {
@@ -5328,6 +5343,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	u32 hw_lock;
 	int i;
 
+	down_read(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -5345,6 +5362,9 @@ bool ice_ptp_lock(struct ice_hw *hw)
 		break;
 	}
 
+	if (hw_lock)
+		up_read(&pf->adapter->ctrl_pf_lock);
+
 	return !hw_lock;
 }
 
@@ -5359,10 +5379,13 @@ void ice_ptp_unlock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
 	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
+	up_read(&pf->adapter->ctrl_pf_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_txclk.c b/drivers/net/ethernet/intel/ice/ice_txclk.c
index 48459f971cbf..4a59ad729547 100644
--- a/drivers/net/ethernet/intel/ice/ice_txclk.c
+++ b/drivers/net/ethernet/intel/ice/ice_txclk.c
@@ -41,6 +41,7 @@ ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
 /**
  * ice_txclk_enable_peer - Enable required TX reference clock on peer PHY
  * @pf: pointer to the PF structure
+ * @ctrl_pf: control PF protected by adapter->ctrl_pf_lock
  * @clk: TX reference clock that must be enabled
  *
  * Some TX reference clocks on E825-class devices (SyncE and EREF0) must
@@ -54,13 +55,15 @@ ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
  *
  * Return: 0 on success or negative error code on failure.
  */
-static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
+static int ice_txclk_enable_peer(struct ice_pf *pf, struct ice_pf *ctrl_pf,
+				 enum ice_e825c_ref_clk clk)
 {
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	bool peer_clk_in_use;
 	u8 port_num, phy;
 	int err;
 
+	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+
 	if (clk == ICE_REF_CLK_ENET)
 		return 0;
 
@@ -118,12 +121,15 @@ static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
  */
 int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 {
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	struct ice_port_info *port_info;
+	struct ice_pf *ctrl_pf;
 	bool clk_in_use;
 	u8 port_num, phy;
 	int err;
 
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
+	ctrl_pf = ice_get_ctrl_pf(pf);
+
 	if (pf->ptp.port.tx_clk == clk)
 		return 0;
 
@@ -164,7 +170,7 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 	mutex_unlock(&ctrl_pf->dplls.lock);
 
 	if (!clk_in_use) {
-		err = ice_txclk_enable_peer(pf, clk);
+		err = ice_txclk_enable_peer(pf, ctrl_pf, clk);
 		if (err)
 			return err;
 	}
@@ -215,15 +221,18 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 void ice_txclk_update_and_notify(struct ice_pf *pf)
 {
 	struct ice_ptp_port *ptp_port = &pf->ptp.port;
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	struct dpll_pin *old_pin = NULL;
 	struct dpll_pin *new_pin = NULL;
+	struct ice_pf *ctrl_pf;
 	struct ice_hw *hw = &pf->hw;
 	enum ice_e825c_ref_clk clk;
 	bool notify_dpll = false;
 	int err;
 	u8 phy;
 
+	down_read(&pf->adapter->ctrl_pf_lock);
+	ctrl_pf = ice_get_ctrl_pf(pf);
+
 	phy = ptp_port->port_num / hw->ptp.ports_per_phy;
 
 	/* Hold txclk_notify_rwsem for read across the entire critical
@@ -351,4 +360,5 @@ void ice_txclk_update_and_notify(struct ice_pf *pf)
 
 out:
 	up_read(&pf->dplls.txclk_notify_rwsem);
+	up_read(&pf->adapter->ctrl_pf_lock);
 }
-- 
2.53.0

