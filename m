Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04647F3B3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254774; cv=none; b=WCNLye0sztfpC+m5xGCHBfjwtZDblgmaqR/Kuenvwp7Ft+JFHdDKCIAiAJBrQkVrRmqfvENYZFDoseRHQiwhR65VcWX0oCNz7BPLswMvBBrTAj57QWw0HWTPA3oH/USHZ6O2BYxybIiu109n3OJ/Y7WKBpNZMQSkIdRGJjcgF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254774; c=relaxed/simple;
	bh=TFXPy66pLteuugCAv0UVm4p+uz1rFLrm6jJ5MqbLUyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0paLYQOw85nUKxacupPh+dQuIA8oMnCHIgCZA/rGDYn1ygVQnMIuDusYM+VMbVfW2BWQZtsnnEv9pMKwUoUi//XjJwoVew9T3hw4PIlIAt1lwICYck+PC+BsGzGEeNqgwDapY2YEOrzEbqvWU+i2Yi/SJ95iDOEoaHD9GAqm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRzcx14v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRzcx14v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254773; x=1821790773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFXPy66pLteuugCAv0UVm4p+uz1rFLrm6jJ5MqbLUyM=;
  b=JRzcx14vvu5XlIfzUNwSc6pSweLW1jrULsHLMCG4WDkZp5JS8n31RdYi
   InR1areC52OQcQpmLC2ELH+IM0+uir3CuTnCb7JuU9kO+HXfb0DpXDSFN
   1yfszZuhKP9CBisIg1PyOCP58SvG86WNiMVBbXD2e76tZXGFKghh3jhAJ
   xwbxbAomy/joCM+9iQpt3yzWRXDGTCJ8rB0jUu2cHkxXVlGofgMtT8vYT
   tEuyciqfbqFr2e4Y2J1E5x7Dh2sqhCpBnZAm1/tpi+bOAmbuv3hUs1Tzp
   JWwsjh5+HAUlVEa7Oxug50agJ2QGYHs59KE1fybK4ITRhYWk/JiRyoOre
   Q==;
X-CSE-ConnectionGUID: G7kWUxn0Tq26XEFgfqn5Pg==
X-CSE-MsgGUID: RL+bUnjFQSud/MulAcShjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249227"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249227"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:22 -0700
X-CSE-ConnectionGUID: oxql0OkUTdKTW7bEU7miAw==
X-CSE-MsgGUID: cla2MIzJT8GAta8CtV+IvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934427"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:21 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 4/8] ice: Reject PTP access without a control PF
Date: Thu, 24 Sep 2026 12:59:12 +0000
Message-ID: <20260924125916.2796499-5-sergey.temerkhanov@intel.com>
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

The timesync register space is not accessible through a secondary NAC.
ice_get_primary_hw() currently falls back to the caller's hardware when
the control PF is absent, causing secondary PFs to access the wrong
register space after the control PF is removed.

Return NULL instead and propagate the missing control PF through PHC
reads and timer setup paths. This leaves secondary PFs operational while
PTP requests fail safely until a control PF is available again.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  9 +--
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 71 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      | 11 +--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 23 +++++-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  5 +-
 5 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 08b40626b876..c454f19a2cb2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1146,8 +1146,8 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
  * while holding adapter->ctrl_pf_lock.
  * hw is embedded in struct ice_pf, so either mechanism protects its lifetime.
  *
- * Return: A pointer to ice_hw structure with access to timesync
- * register space.
+ * Return: A pointer to ice_hw structure with access to timesync register
+ * space, or NULL if the control PF is not available.
  */
 static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 {
@@ -1156,10 +1156,7 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 	ctrl_pf = rcu_dereference_check(pf->adapter->ctrl_pf,
 					lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 
-	if (!ctrl_pf)
-		return &pf->hw;
-	else
-		return &ctrl_pf->hw;
+	return ctrl_pf ? &ctrl_pf->hw : NULL;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 455e3af30abe..3ee29c0cd726 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -214,17 +214,23 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
  * @pf: Board private structure
  * @sts: Optional parameter for holding a pair of system timestamps from
  *       the system clock. Will be ignored if NULL is given.
+ * @time: Storage for the source clock time
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
-u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-			     struct ptp_system_timestamp *sts)
+int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts, u64 *time)
 {
 	struct ice_hw *hw = &pf->hw;
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
 	scoped_guard(rcu) {
-		if (!ice_is_primary(hw))
+		if (!ice_is_primary(hw)) {
 			hw = ice_get_primary_hw(pf);
+			if (!hw)
+				return -ENODEV;
+		}
 
 		tmr_idx = ice_get_ptp_src_clock_index(hw);
 		guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
@@ -232,12 +238,12 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 		ptp_read_system_prets(sts);
 
 		if (hw->mac_type == ICE_MAC_E830) {
-			u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+			*time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
 
 			/* Read the system timestamp post PHC read */
 			ptp_read_system_postts(sts);
 
-			return clk_time;
+			return 0;
 		}
 
 		lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
@@ -260,7 +266,9 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 
 	}
 
-	return ((u64)hi << 32) | lo;
+	*time = ((u64)hi << 32) | lo;
+
+	return 0;
 }
 
 /**
@@ -997,13 +1005,15 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
  * Return:
  * * 0 - OK, successfully updated
  * * -EAGAIN - PF was busy, need to reschedule the update
+ * * -ENODEV - no control PF owns the source clock register space
+ * * -EOPNOTSUPP - PTP support is not compiled in
  */
 static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	unsigned long update_before;
 	u64 systime;
-	int i;
+	int err, i;
 
 	update_before = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
 	if (pf->ptp.cached_phc_time &&
@@ -1016,11 +1026,22 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	}
 
 	/* Read the current PHC time */
-	systime = ice_ptp_read_src_clk_reg(pf, NULL);
-
-	/* Update the cached PHC time stored in the PF structure */
-	WRITE_ONCE(pf->ptp.cached_phc_time, systime);
-	WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
+	err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
+	if (err) {
+		/* The source clock is gone, so the cache can no longer be
+		 * refreshed. Publish zero instead of leaving the last good
+		 * value behind: ice_ptp_get_rx_hwts() has no staleness check
+		 * and would keep extending Rx timestamps against it.
+		 * cached_phc_jiffies is deliberately left alone so that
+		 * ice_ptp_extend_40b_ts() still discards Tx timestamps.
+		 */
+		systime = 0;
+		WRITE_ONCE(pf->ptp.cached_phc_time, 0);
+	} else {
+		/* Update the cached PHC time stored in the PF structure */
+		WRITE_ONCE(pf->ptp.cached_phc_time, systime);
+		WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
+	}
 
 	if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
 		return -EAGAIN;
@@ -1043,7 +1064,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 	}
 	clear_bit(ICE_CFG_BUSY, pf->state);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -1073,8 +1094,8 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 		 * properly reset them here. This could lead to reporting of
 		 * invalid timestamps, but there isn't much we can do.
 		 */
-		dev_warn(dev, "%s: ICE_CFG_BUSY, unable to immediately update cached PHC time\n",
-			 __func__);
+		dev_warn(dev, "%s: unable to immediately update cached PHC time, err %d\n",
+			 __func__, err);
 
 		/* Queue the work item to update the Rx rings when possible */
 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
@@ -1811,6 +1832,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
+	int err;
 
 	pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT, rq->index);
 	if (pin_desc_idx < 0)
@@ -1849,7 +1871,10 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	 * at the next multiple of period, maintaining phase at least 0.5 second
 	 * from now, so we have time to write it to HW.
 	 */
-	clk = ice_ptp_read_src_clk_reg(pf, NULL) + NSEC_PER_MSEC * 500;
+	err = ice_ptp_read_src_clk_reg(pf, NULL, &clk);
+	if (err)
+		return err;
+	clk += NSEC_PER_MSEC * 500;
 	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
@@ -1992,8 +2017,12 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
 	u64 time_ns;
+	int err;
+
+	err = ice_ptp_read_src_clk_reg(pf, sts, &time_ns);
+	if (err)
+		return err;
 
-	time_ns = ice_ptp_read_src_clk_reg(pf, sts);
 	*ts = ns_to_timespec64(time_ns);
 	return 0;
 }
@@ -3041,9 +3070,13 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
 
-	/* Run twice a second or reschedule if phc update failed */
+	/* Run twice a second, or retry soon if another thread was busy
+	 * updating the Rx rings. Other errors, such as a missing control PF,
+	 * do not clear up on their own and must not turn the periodic worker
+	 * into a busy loop.
+	 */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
-				   msecs_to_jiffies(err ? 10 : 500));
+				   msecs_to_jiffies(err == -EAGAIN ? 10 : 500));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 8a341e3cba17..562822b106d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -331,8 +331,8 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
-u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-			     struct ptp_system_timestamp *sts);
+int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts, u64 *time);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -384,10 +384,11 @@ ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 	return false;
 }
 
-static inline u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
-					   struct ptp_system_timestamp *sts)
+static inline int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+					   struct ptp_system_timestamp *sts,
+					   u64 *time)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline u64
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 38e90a68ba78..a85aa8f99057 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -339,8 +339,11 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 
 	guard(rcu)();
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw)
+			return;
+	}
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
 }
@@ -359,8 +362,11 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 
 	guard(rcu)();
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw)
+			return;
+	}
 
 	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
 	wr32(hw, GLTSYN_CMD_SYNC, SYNC_EXEC_CMD);
@@ -2020,6 +2026,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		guard(rcu)();
 
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw)
+			return -ENODEV;
 
 		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
@@ -2199,6 +2207,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		 */
 		rcu_read_lock();
 		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw) {
+			rcu_read_unlock();
+			return -ENODEV;
+		}
 
 		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
@@ -5354,8 +5366,13 @@ bool ice_ptp_lock(struct ice_hw *hw)
 
 	down_read(&pf->adapter->ctrl_pf_lock);
 
-	if (!ice_is_primary(hw))
+	if (!ice_is_primary(hw)) {
 		hw = ice_get_primary_hw(pf);
+		if (!hw) {
+			up_read(&pf->adapter->ctrl_pf_lock);
+			return false;
+		}
+	}
 
 #define MAX_TRIES 15
 
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e3dd42..66332d02c5ba 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -2485,7 +2485,10 @@ static int ice_vc_get_phc_time(struct ice_vf *vf)
 
 	len = sizeof(*phc_time);
 
-	phc_time->time = ice_ptp_read_src_clk_reg(pf, NULL);
+	if (ice_ptp_read_src_clk_reg(pf, NULL, &phc_time->time)) {
+		v_ret = VIRTCHNL_STATUS_ERR_NOT_SUPPORTED;
+		len = 0;
+	}
 
 err:
 	/* send the response back to the VF */
-- 
2.53.0

