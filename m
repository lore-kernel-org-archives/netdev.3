Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C941D655;
	Tue, 28 Jul 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230311; cv=none; b=MuV4BWB9jM5Iee0e5MGSbZlrCGtfMBe/IV7Gu96N0ajLuQozeRQAJ6pu62Psw8upka+lCsXPAUm2XxQymZbQ+IJU5eCKbFt09tWr7+Jzoih3+zmaXBzlFNB3N8Z1WT6ULAHugzs08zHjZ8IVW7TkXSmXJV4i5h1LiQDbxwFQukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230311; c=relaxed/simple;
	bh=3VHs14ctbdCHZHJmw79Nv6gyfdb/VhIja/1/P1uZIWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFAbjwLC1h6yxpUEviURA0oLAT4lsu0jnNuEXPbIbeewGAapYohE3l3lQdGIlCDxbholdQot0T7967H1oWyQGZfmaIXmA9n8Zqqbd40R/tMMQba12UzyWHVWzEWC/MO6Ivol0q9FYU3bxFARbWEgP6nFFBb1N++mGlZRAYKF3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPDS/Pe3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPDS/Pe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785230309; x=1816766309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VHs14ctbdCHZHJmw79Nv6gyfdb/VhIja/1/P1uZIWk=;
  b=RPDS/Pe3dAdHGg9rMdjCF/b/DwCUZ0YPPFhSP/w27uwcu7e97jrosV7m
   XRCL64bb5TW2D8PoDWpNvzK6jpxoUAL5hBeEVS9LctaXcd5z4/yj+R0QO
   utVmm0vubYMN1QENCCw2yW/390Uv/JgmFVKa7XtFRpVkUzWssO2vgH1KW
   hkCNYjX77THtp6iVSwhPwYsNwCqu/qgpSC0m+zDtnNEiS4DTJaa1Gr7Bc
   V9hxfmH7z/rUIj2Yd3PDSh7i5BnvraRlJLxWYm3opCivDTgwjAKCd46m+
   +FcJLS4loTZZi8j/cELVBLckplPYVzk+bzRWRwI7KD7utj8ZorgJzz9XT
   Q==;
X-CSE-ConnectionGUID: rbD377nfT9Od8b5YLsYI+g==
X-CSE-MsgGUID: GH+1ZofaR0KKmqNrhwH0aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85677250"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85677250"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:18:29 -0700
X-CSE-ConnectionGUID: jg8iE/LARt66ISzkxmA2Ig==
X-CSE-MsgGUID: 0i5HfwD7SN29Q7/TxIujxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="258378416"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 02:18:26 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next 1/3] ice: monitor TSPLL lock from PTP periodic worker
Date: Tue, 28 Jul 2026 11:13:12 +0200
Message-Id: <20260728091314.1420656-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
References: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 70 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   | 11 +++
 drivers/net/ethernet/intel/ice/ice_tspll.c | 88 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |  4 +
 4 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4df3d83b5066..a997be5f7d8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -5,8 +5,11 @@
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
@@ -2875,6 +2878,67 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
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
+			enum ice_clk_src clk_src;
+			const char *src_str = "unknown";
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
@@ -2884,6 +2948,8 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
+	ice_ptp_tspll_monitor(pf);
+
 	err = ice_ptp_update_cached_phctime(pf);
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
@@ -3001,6 +3067,9 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	err = ice_tspll_init(hw);
 	if (err)
 		return err;
+	/* Rebuild reinitialized TSPLL, so reset monitor retry state. */
+	WRITE_ONCE(ptp->tspll_locked, true);
+	ptp->tspll_lock_retries = 0;
 
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
@@ -3364,6 +3433,7 @@ void ice_ptp_init(struct ice_pf *pf)
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
index fd4b58eb9bc0..be8e2da21dd6 100644
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
@@ -531,6 +531,64 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
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
+	err = ice_write_cgu_reg(hw, ICE_CGU_R23, val);
+
+	return err;
+}
+
 /**
  * ice_tspll_cfg - Configure the Clock Generation Unit TSPLL
  * @hw: Pointer to the HW struct
@@ -577,6 +635,34 @@ static int ice_tspll_dis_sticky_bits(struct ice_hw *hw)
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
2.39.3

