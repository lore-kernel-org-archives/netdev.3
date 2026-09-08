Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2BE5867F4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906283; cv=none; b=XzdZ3CVjDCwpy19Tu/kwwG9DsYnt714Y/FyXU7zyw4gWskjt2luHsq81SWHfwPL7HxvhTbOpQfQKFwCUroE3Xp1zHRM1FvOyrK2uuRVJT/BXU9jlfzoOITIAOKCuVdln8Yq1X5Qp87pI1ASCOM7JxZoISWByDnnasHISKEeKeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906283; c=relaxed/simple;
	bh=6wQoCSLPiBc3+/qKoHv1eAHSKqNesTAOS478bMqVpws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExAfMhyaMR7gtbSXVui2R01T5SQ8yg5fmWicLRGYW1Gso2k2EbrG489+Iy9Yw0Pq33xPBSkWBfnMGW3CTTldRj07DiM7DqkI1nHvREQBWlq/ePfkWCrj682aNXgFvjToj7Kz5nlk2808Xx8UFRvsJMYFzmptYZgW2Poc6AH/gI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7E0s3Eo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7E0s3Eo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788906281; x=1820442281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6wQoCSLPiBc3+/qKoHv1eAHSKqNesTAOS478bMqVpws=;
  b=H7E0s3Eo+GH1QRz0z/DYRVSDR81bHL+95Be1TyPkfNETyQbC0sWt6Idb
   mDPhYK6obw2IxL45z2OrZEWlB9tmUIwF0IOE4ZHOHYlD1KXb9ez5PE0uQ
   SYXViCWTUEqz2AYA2BPc/ZoE7TCKvIXT3/crQE2WbezuAGC5JIvI5njf1
   sjfbT1mOOyoLqHlDi3NdbGvFxbBTGcP0hohBkdIhoDnJmhNLSehM8DcPQ
   Bv1gdcjebr5cuykl73ZnuXtSp1ooc1K+MmYjW0apsDpyQHgPJHiOiHI9n
   acyRwsiAJDz5lJynwB+Fa7PZRlFjKW6jLr52dQurDLW8RuknFaWR4Lf1C
   g==;
X-CSE-ConnectionGUID: 9sEaGSmdROq6L2Tu3CIV5g==
X-CSE-MsgGUID: QSHGW/M9R6KE4/44gneWxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89354873"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89354873"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:24:38 -0700
X-CSE-ConnectionGUID: 4/r7rm1BR7i091tBut9OGg==
X-CSE-MsgGUID: 2XbWmdLMRzWU6rM79LaLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274660829"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Sep 2026 15:24:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.korba@intel.com,
	richardcochran@gmail.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 1/3] ice: monitor TSPLL lock from PTP periodic worker
Date: Tue,  8 Sep 2026 15:24:24 -0700
Message-ID: <20260908222428.872254-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
References: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

On E825 devices that own the source timer, the TSPLL can lose lock when
the TCXO or TIME_REF signal is disrupted. Recovery requires re-enabling
the TSPLL via CGU register writes; without it, the PHC keeps running on
a degraded reference indefinitely.

The DPLL periodic worker (ice_dpll_periodic_work()) would be a natural
home for this monitoring, but placing it there has two problems:

  1. ice_dpll_init_e825() sets ICE_FLAG_DPLL only after all initialization
     steps succeed. If any earlier step fails, the driver would run
     without any TSPLL recovery mechanism.

  2. When CONFIG_DPLL=n, the DPLL worker is compiled out and TSPLL
     recovery would be silently absent.

Add the monitor to ice_ptp_periodic_work() instead, which always runs on
E825 owner PFs regardless of DPLL init state or config. Introduce two
small helpers, ice_tspll_lost_lock_e825c() and ice_tspll_restart_e825c(),
which encapsulate the CGU register reads/writes required to observe and
recover the TSPLL.

Cache the observed lock state in pf->ptp.tspll_locked using
WRITE_ONCE()/READ_ONCE() so a follow-up change can consume it from the
DPLL periodic worker (for user-space notification via
dpll_device_change_ntf()) and drop the redundant poll+recovery from
that path. Precise synchronization is not required: both workers converge
on the same value within one poll period.

Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 70 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   | 11 +++
 drivers/net/ethernet/intel/ice/ice_tspll.c | 86 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |  4 +
 4 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..4b1040d09f70 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -4,8 +4,11 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
+#include "ice_tspll.h"
 #include "ice_txclk.h"
 
+#define ICE_TSPLL_LOG_INTERVAL		120
+
 static const char ice_pin_names[][64] = {
 	"SDP0",
 	"SDP1",
@@ -2849,6 +2852,67 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_ptp_tspll_monitor - poll and recover TSPLL lock on E825 owner PFs
+ * @pf: Board private structure
+ *
+ * Called from the PTP periodic worker. On E825 devices that own the source
+ * timer, poll the TSPLL lock status via CGU registers and trigger a restart
+ * if the lock has been lost. The result is cached in @pf->ptp.tspll_locked
+ * so it can be consumed by the DPLL periodic worker via READ_ONCE().
+ *
+ * TSPLL lock is critical for PHC operation and must be monitored regardless
+ * of whether DPLL init succeeded or CONFIG_DPLL is enabled. Placing the
+ * monitor here makes recovery independent of the dpll subsystem.
+ *
+ * AQ read errors are rate-limited and do not stop monitoring. Lock-lost
+ * events are logged every 120 retries (~60 s at normal poll rate) to
+ * surface persistent failures without flooding the log.
+ */
+static void ice_ptp_tspll_monitor(struct ice_pf *pf)
+{
+	bool lock_lost;
+	int err;
+
+	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825 ||
+	    !ice_pf_src_tmr_owned(pf))
+		return;
+
+	err = ice_tspll_lost_lock_e825c(&pf->hw, &lock_lost);
+	if (err) {
+		dev_err_ratelimited(ice_pf_to_dev(pf),
+				    "Failed reading TimeSync PLL lock status (err: %d). Retrying.\n",
+				    err);
+		return;
+	}
+
+	if (lock_lost) {
+		WRITE_ONCE(pf->ptp.tspll_locked, false);
+		if (!(pf->ptp.tspll_lock_retries % ICE_TSPLL_LOG_INTERVAL))
+			dev_warn(ice_pf_to_dev(pf),
+				 "TimeSync PLL lock lost. Retrying to acquire lock.\n");
+		err = ice_tspll_restart_e825c(&pf->hw);
+		if (err)
+			dev_err_ratelimited(ice_pf_to_dev(pf),
+					    "Failed to restart TimeSync PLL (err: %d).\n",
+					    err);
+		pf->ptp.tspll_lock_retries++;
+	} else {
+		if (pf->ptp.tspll_lock_retries) {
+			const char *src_str = "unknown";
+			enum ice_clk_src clk_src;
+
+			if (!ice_tspll_get_clk_src(&pf->hw, &clk_src))
+				src_str = ice_tspll_clk_src_str(clk_src);
+			dev_info(ice_pf_to_dev(pf),
+				 "TimeSync PLL lock acquired with %s clock source after %u retries.\n",
+				 src_str, pf->ptp.tspll_lock_retries);
+		}
+		WRITE_ONCE(pf->ptp.tspll_locked, true);
+		pf->ptp.tspll_lock_retries = 0;
+	}
+}
+
 static void ice_ptp_periodic_work(struct kthread_work *work)
 {
 	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
@@ -2858,6 +2922,8 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
+	ice_ptp_tspll_monitor(pf);
+
 	err = ice_ptp_update_cached_phctime(pf);
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
@@ -2975,6 +3041,9 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	err = ice_tspll_init(hw);
 	if (err)
 		return err;
+	/* Rebuild reinitialized TSPLL, so reset monitor retry state. */
+	WRITE_ONCE(ptp->tspll_locked, true);
+	ptp->tspll_lock_retries = 0;
 
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
@@ -3319,6 +3388,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	}
 	ptp->port.port_num = hw->lane_num;
 
+	ptp->tspll_locked = true;
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c4b0da7ce20e..0e40fef3b4e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -249,6 +249,15 @@ struct ice_ptp_pin_desc {
  * @tx_hwtstamp_discarded: number of Tx skbs discarded due to cached PHC time
  *                         being too old to correctly extend timestamp
  * @late_cached_phc_updates: number of times cached PHC update is late
+ * @tspll_locked: last observed TSPLL lock state on E825 owner PFs.
+ *	Written by the PTP periodic worker after polling the TSPLL and
+ *	intended to be read (without pf->dplls.lock) by the DPLL periodic
+ *	worker in a follow-up change. Access via READ_ONCE()/WRITE_ONCE();
+ *	precise synchronization is not required because both workers
+ *	converge on the same value within one poll period.
+ * @tspll_lock_retries: counts consecutive poll cycles in which the TSPLL
+ *	was found unlocked. Reset to zero when lock is re-acquired. Used to
+ *	rate-limit the lock-lost log message (~every 120 retries / ~60 s).
  */
 struct ice_ptp {
 	enum ice_ptp_state state;
@@ -274,6 +283,8 @@ struct ice_ptp {
 	u32 tx_hwtstamp_flushed;
 	u32 tx_hwtstamp_discarded;
 	u32 late_cached_phc_updates;
+	bool tspll_locked;
+	u32 tspll_lock_retries;
 };
 
 #define __ptp_port_to_ptp(p) \
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index fd4b58eb9bc0..78752dc1e762 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -129,7 +129,7 @@ static bool ice_tspll_check_params(struct ice_hw *hw,
  *
  * Return: specified clock source converted to its string name
  */
-static const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src)
+const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src)
 {
 	switch (clk_src) {
 	case ICE_CLK_SRC_TCXO:
@@ -531,6 +531,62 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
 }
 
+/**
+ * ice_tspll_lost_lock_e825c - check if TSPLL lost lock
+ * @hw: Pointer to the HW struct
+ * @lost_lock: Output flag for reporting lost lock
+ *
+ * Get E825 device TSPLL DPLL lock status.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_lost_lock_e825c(struct ice_hw *hw, bool *lost_lock)
+{
+	u32 val;
+	int err;
+
+	err = ice_read_cgu_reg(hw, ICE_CGU_RO_LOCK, &val);
+	if (err)
+		return err;
+
+	*lost_lock = !FIELD_GET(ICE_CGU_RO_LOCK_TRUE_LOCK, val);
+
+	return 0;
+}
+
+/**
+ * ice_tspll_restart_e825c - trigger TSPLL restart
+ * @hw: Pointer to the HW struct
+ *
+ * Re-enable TSPLL for E825 device.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_restart_e825c(struct ice_hw *hw)
+{
+	u32 val;
+	int err;
+
+	/* Read the initial values of r23 and disable the PLL */
+	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &val);
+	if (err)
+		return err;
+
+	val &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
+	err = ice_write_cgu_reg(hw, ICE_CGU_R23, val);
+	if (err)
+		return err;
+
+	/* Wait at least 1 ms before reenabling PLL */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+	val |= ICE_CGU_R23_R24_TSPLL_ENABLE;
+	return ice_write_cgu_reg(hw, ICE_CGU_R23, val);
+}
+
 /**
  * ice_tspll_cfg - Configure the Clock Generation Unit TSPLL
  * @hw: Pointer to the HW struct
@@ -577,6 +633,34 @@ static int ice_tspll_dis_sticky_bits(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_tspll_get_clk_src - get current TSPLL clock source
+ * @hw: board private hw structure
+ * @clk_src: pointer to store clk_src value
+ *
+ * Get current TSPLL clock source settings.
+ *
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+int ice_tspll_get_clk_src(struct ice_hw *hw, enum ice_clk_src *clk_src)
+{
+	u32 val;
+	int err;
+
+	err = (hw->mac_type == ICE_MAC_GENERIC_3K_E825) ?
+		ice_read_cgu_reg(hw, ICE_CGU_R23, &val) :
+		ice_read_cgu_reg(hw, ICE_CGU_R24, &val);
+	if (err)
+		return err;
+
+	*clk_src = (enum ice_clk_src)FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL,
+					       val);
+
+	return 0;
+}
+
 /**
  * ice_tspll_init - Initialize TSPLL with settings from firmware
  * @hw: Pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index d650867004d1..05917ae51ded 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -32,6 +32,9 @@ struct ice_tspll_params_e82x {
 #define ICE_TSPLL_FBDIV_INTGR_E825		256
 
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable);
+int ice_tspll_lost_lock_e825c(struct ice_hw *hw, bool *lost_lock);
+int ice_tspll_restart_e825c(struct ice_hw *hw);
+int ice_tspll_get_clk_src(struct ice_hw *hw, enum ice_clk_src *clk_src);
 int ice_tspll_init(struct ice_hw *hw);
 int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
 				      enum ice_synce_clk output);
@@ -39,4 +42,5 @@ int ice_tspll_cfg_bypass_mux_e825c(struct ice_hw *hw, bool ena, u32 port_num,
 				   enum ice_synce_clk output);
 int ice_tspll_cfg_synce_ethdiv_e825c(struct ice_hw *hw,
 				     enum ice_synce_clk output);
+const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src);
 #endif /* _ICE_TSPLL_H_ */
-- 
2.47.1

