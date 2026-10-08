Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B0421247
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496642; cv=none; b=rHwTExWhZkotvsO7uVZGzmj0Iv6/ZFc5stm72hr6b60V0M1LF9sMGW2EG1o7IiLxw2AMic4vMVEciB+6AY+trZjcY3aZjJmItWZvpWEje0rM+BgfG/4OQl6jLMJD9NxkUKGn0Sb7faXFuR3gUSbMykH07dKxp6tJ41Hw9Pqnfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496642; c=relaxed/simple;
	bh=axgVRcvtyGKCPjvVZIlbQ/NJDnXGjWuWoRKZlMU/PiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkVSLHt0xSiXmrrIavdymRpM96zL/aqK6MERY2084ONdceQIgzBPzjph42+s3jENvtmUjjTNAiG8MrMbKyI6PbuJYy1GoayiRFHiwo7OzN4iurRPj6kxtx9PDAnPkOroix74SVWsbdTkY13+1WRiS1/HkiiQHal6AEVwc5w1vZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO0yuhG+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO0yuhG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496641; x=1823032641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axgVRcvtyGKCPjvVZIlbQ/NJDnXGjWuWoRKZlMU/PiQ=;
  b=SO0yuhG+12gG5pqC049eOr2n70RqnqKVUwFr7w2QdjU1yaEA8yh+k+Bt
   pIytZ4aJ7eVopdUhFOWp02cTceKD0dirupxutExv1WWmH9U7c8x9nfMhf
   I2fSEw7j0k84FT1tF3X8/QNqX+xFnc623qp/yFT3b7ZlXgmQ2V/q2rl5K
   pFQoOTMeGuV6bR/TAvjFUQ23Jzpl1JAkyf/zuyxGhEOc9ZigYavfcT/Qd
   r5dNJa/kSaCeRZbHVU91K2TaZf4wlO2hsR0sm8Bxcv5YhTKBXOXffJ9ff
   v/tass9BaKSNe+EaGMCfVKVRITyWJ/eyWP/TV6nws4j+/+xcJKUbndGNs
   A==;
X-CSE-ConnectionGUID: 4kd5bnzOSkeY0pRQY7qk6A==
X-CSE-MsgGUID: 7hrTSK8nQaiutfdDnezNTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294634"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294634"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:17 -0700
X-CSE-ConnectionGUID: eVMuEUT7Tl+UNxEmVNfBRQ==
X-CSE-MsgGUID: 9z6s4m0nQrmRHF4q5BgrZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150404"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net v2 03/15] ice: fix PHY port restart serialization
Date: Thu,  8 Oct 2026 14:56:00 -0700
Message-ID: <20261008215614.1987250-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_port_phy_restart() function is responsible for restarting a PHY
port, primarily after a link transition. PHY ports must also all be
restarted after a reset, and the E822 devices also restart the PHY after
the .settime64 operation.

If a PHY restart occurs concurrently with a link transition, it is possible
that the link state read could be re-ordered such that the link transition
would start the PHY but a concurrent restart (such as from .settime64)
could see the old link state and decide it must stop the PHY.

This occurs because the restart procedure depends on the link state value
but setting that value is not serialized with the per-port ps_lock. A
following fix for E825 is going to modify the .setttime64 to also correctly
restart the PHY timers, opening the E825 device to a race between
.settime64 and a concurrent link change.

To avoid this, we need to ensure that the port link_up field is set within
the same critical section as the restart procedure. This way we ensure that
the end result is the PHY programmed to the correct state.

Additionally note that the PHY restart procedure already cannot run
concurrently across two ports. The procedure requires executing timer
commands which in turn require the PTP hardware semaphore.

Thus, to simplify the locking behavior, convert the per-port ps_lock to a
single mutex in the ice_adapter. Acquire this in ice_ptp_restart_all_phy(),
and hold it while calling ice_ptp_port_phy_stop() and
ice_ptp_port_phy_restart().

The ice_ptp_link_change() function now acquires the port lock for the
entire change. This ensures that the link state is set under lock. Note the
function does also acquire the dplls.lock for E825 devices. This ordering
is safe because the other callers of dplls.lock do not acquire the
ps_lock.

The switch to a single lock for the adapter instead of one per port is
easier to reason about. It also could be a first step in a plan to replace
the PTP hardware semaphore completely, which is under investigation for the
future.

This fixes one of the issues reported by Sashiko during a previous review
of this series, linked here as the Closes tag.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |  3 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 58 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  2 -
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae97..572862fcd247 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -77,6 +77,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
 
+	mutex_init(&adapter->ps_lock);
+
 	return adapter;
 }
 
@@ -87,6 +89,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
+	mutex_destroy(&adapter->ps_lock);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 0b01c7f5cf0d..5f39166795b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -40,6 +40,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -53,6 +54,9 @@ struct ice_adapter {
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
+	/* For serializing PHY port start/stop sequences */
+	struct mutex ps_lock;
+
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 94a66e9d8c05..adc5308baefc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1191,6 +1191,8 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 /**
  * ice_ptp_port_phy_stop - Stop timestamping for a PHY port
  * @ptp_port: PTP port to stop
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
@@ -1200,7 +1202,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	mutex_lock(&ptp_port->ps_lock);
+	lockdep_assert_held(&pf->adapter->ps_lock);
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
@@ -1222,8 +1224,6 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d down, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1234,6 +1234,8 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
  * Start the PHY timestamping block, and initiate Vernier timestamping
  * calibration. If timestamping cannot be calibrated (such as if link is down)
  * then disable the timestamping block instead.
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
@@ -1244,11 +1246,11 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 	unsigned long flags;
 	int err;
 
+	lockdep_assert_held(&pf->adapter->ps_lock);
+
 	if (!ptp_port->link_up)
 		return ice_ptp_port_phy_stop(ptp_port);
 
-	mutex_lock(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -1290,8 +1292,6 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1310,12 +1310,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	ptp_port = &pf->ptp.port;
 
-	/* Update cached link status for this port immediately */
+	mutex_lock(&pf->adapter->ps_lock);
+
 	ptp_port->link_up = linkup;
 
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
-		return;
+		goto out_unlock;
 
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
@@ -1358,17 +1359,20 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
 		/* Do not reconfigure E810 or E830 PHY */
-		return;
+		break;
 	case ICE_MAC_GENERIC:
 		ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	case ICE_MAC_GENERIC_3K_E825:
 		if (linkup)
 			ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}
+
+out_unlock:
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -1434,18 +1438,11 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 	}
 }
 
-/**
- * ice_ptp_reset_phy_timestamping - Reset PHY timestamping block
- * @pf: Board private structure
- */
-static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
-{
-	ice_ptp_port_phy_restart(&pf->ptp.port);
-}
-
 /**
  * ice_ptp_restart_all_phy - Restart all PHYs to recalibrate timestamping
  * @pf: Board private structure
+ *
+ * Context: acquires the adapter ps_lock
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
@@ -1453,6 +1450,8 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 	struct ice_ptp_port *port;
 	int srcu_idx;
 
+	mutex_lock(&pf->adapter->ps_lock);
+
 	srcu_idx = srcu_read_lock(&ports->srcu);
 	list_for_each_entry_srcu(port, &ports->list, list_node,
 				 srcu_read_lock_held(&ports->srcu)) {
@@ -1465,6 +1464,8 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
 	srcu_read_unlock(&ports->srcu, srcu_idx);
+
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -3303,8 +3304,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	mutex_init(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -3404,14 +3403,16 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err_destroy_ps_lock;
+		goto err_exit;
 
 	err = ice_ptp_setup_pf(pf);
 	if (err)
 		goto err_release_tx_tracker;
 
 	/* Start the PHY timestamping block */
-	ice_ptp_reset_phy_timestamping(pf);
+	mutex_lock(&pf->adapter->ps_lock);
+	ice_ptp_port_phy_restart(&ptp->port);
+	mutex_unlock(&pf->adapter->ps_lock);
 
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
@@ -3429,8 +3430,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	ice_ptp_cleanup_pf(pf);
 err_release_tx_tracker:
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-err_destroy_ps_lock:
-	mutex_destroy(&ptp->port.ps_lock);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
@@ -3470,7 +3469,6 @@ void ice_ptp_release(struct ice_pf *pf)
 		}
 		ice_ptp_cleanup_pf(pf);
 		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-		mutex_destroy(&pf->ptp.port.ps_lock);
 		return;
 	}
 
@@ -3487,8 +3485,10 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
+	mutex_lock(&pf->adapter->ps_lock);
 	ice_ptp_port_phy_stop(&pf->ptp.port);
-	mutex_destroy(&pf->ptp.port.ps_lock);
+	mutex_unlock(&pf->adapter->ps_lock);
+
 	if (pf->ptp.kworker) {
 		kthread_destroy_worker(pf->ptp.kworker);
 		pf->ptp.kworker = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index da2003ba3bb0..27ea502b7576 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -143,7 +143,6 @@ struct ice_ptp_tx {
  * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
- * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
  * @tx_fifo_busy_cnt: number of times the Tx FIFO was busy
  * @port_num: the port number this structure represents
@@ -155,7 +154,6 @@ struct ice_ptp_port {
 	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
-	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
 	u8 tx_fifo_busy_cnt;
 	u8 port_num;
-- 
2.47.1

