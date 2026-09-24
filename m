Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F740480324
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254776; cv=none; b=B68nYiMdvQc+5quoC5L2pcL19o7bLq5oS5ykDfO6b4Nra9PcUKR7q8GayUElt6aV6imEMm6HPwHjSsrjYjBNvrRdWuRcNM1KfYSLve7EUy6irYVU1PnaniM+i5qNhIZgxMXqRg+NigP86P3hAzHDibL9jrP00Ono6pE3bCS6tCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254776; c=relaxed/simple;
	bh=XTikmKf6gQDrTZu/kQxT5155ydRKPagkSJygHGDmZuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQUf3qZu0yl6dHnzjOmF/PsycPAMcy5JSqOMsXWK9G5MsQj0SpoIuKEhP912NvEdVJGXr/YkRjIbyhHIu/OVQOaEj+1NHjJ/D/4GNHa3Jb3LcVYhQPtdETfMXa7ye09DLBeaxc1nYo70GnH96ZbBzJTk/gV7I5/Q+Fm7zqhZEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAquJsOw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAquJsOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254774; x=1821790774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XTikmKf6gQDrTZu/kQxT5155ydRKPagkSJygHGDmZuo=;
  b=AAquJsOwgp9kC3ccFmU/ndWZoQ6UMQg3hzTLC0zZrASEG89u+cZ3k6S5
   S0VwRLfli4/dt47C2yrlwwLD4Ny0J3DzVk0BOZ/bqQ/c6kdNhZ3yNM9U7
   4DuJmPYzAsAUzlpdbaQrURo5XMC+7bJxVwd69jMXwmlPqrF/uz6q6tzEi
   pPKxtG5MzNMvZRNJNQLkD0UIHaHVbl/XJRQ+lbBP73PV3E43JjzyXNAOe
   0xqhe/qH8Qxpw8u9FsJy7ef7dSRtEU+kj0coANbHM75G8felF0MNg2XBe
   Gwq1gaUYaIipsYvvHkTuBQ8B6HZ6u22e3QfLJHftcU485yQ8oaaasZtpe
   Q==;
X-CSE-ConnectionGUID: /DzcvWFRSXCR98SwqiO8+w==
X-CSE-MsgGUID: qHBa3/IZQ0qwKhlAiZQHxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249250"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:26 -0700
X-CSE-ConnectionGUID: pb/ZDq2ZT26kSpfoFx9lKg==
X-CSE-MsgGUID: /zWNdHnIQeyw/fwM9d1iCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934432"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:25 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 7/8] ice: Annotate PTP control PF lock handoff
Date: Thu, 24 Sep 2026 12:59:15 +0000
Message-ID: <20260924125916.2796499-8-sergey.temerkhanov@intel.com>
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

ice_ptp_lock() conditionally retains ctrl_pf_lock for read when it
successfully acquires the hardware semaphore. The matching unlock occurs
in ice_ptp_unlock(). Describe this cross-function handoff with context
analysis annotations so static analysis can verify callers.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 12 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 26 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  6 +++--
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index c454f19a2cb2..8b7891ac25b0 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1179,4 +1179,16 @@ static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 		rcu_dereference_check(pf->adapter->ctrl_pf,
 				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 }
+
+/* container_of() expands to a statement expression, which clang cannot parse
+ * inside a context analysis attribute argument, so open-code the cast here.
+ */
+#define ice_hw_ctrl_pf_lock(_hw)					\
+	(&((struct ice_pf *)((void *)(_hw) -				\
+			     offsetof(struct ice_pf, hw)))->adapter->ctrl_pf_lock)
+
+bool ice_ptp_lock(struct ice_hw *hw)
+	__cond_acquires_shared(true, ice_hw_ctrl_pf_lock(hw));
+void ice_ptp_unlock(struct ice_hw *hw)
+	__releases_shared(ice_hw_ctrl_pf_lock(hw));
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a85aa8f99057..eb7fdd000cf2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5361,15 +5361,16 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
 bool ice_ptp_lock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_hw *pri_hw = hw;
 	u32 hw_lock;
 	int i;
 
-	down_read(&pf->adapter->ctrl_pf_lock);
+	down_read(ice_hw_ctrl_pf_lock(hw));
 
 	if (!ice_is_primary(hw)) {
-		hw = ice_get_primary_hw(pf);
-		if (!hw) {
-			up_read(&pf->adapter->ctrl_pf_lock);
+		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw) {
+			up_read(ice_hw_ctrl_pf_lock(hw));
 			return false;
 		}
 	}
@@ -5377,7 +5378,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 #define MAX_TRIES 15
 
 	for (i = 0; i < MAX_TRIES; i++) {
-		hw_lock = rd32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
+		hw_lock = rd32(pri_hw,
+			       PFTSYN_SEM + (PFTSYN_SEM_BYTES * pri_hw->pf_id));
 		hw_lock = hw_lock & PFTSYN_SEM_BUSY_M;
 		if (hw_lock) {
 			/* Somebody is holding the lock */
@@ -5389,7 +5391,7 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	}
 
 	if (hw_lock)
-		up_read(&pf->adapter->ctrl_pf_lock);
+		up_read(ice_hw_ctrl_pf_lock(hw));
 
 	return !hw_lock;
 }
@@ -5404,14 +5406,18 @@ bool ice_ptp_lock(struct ice_hw *hw)
 void ice_ptp_unlock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_hw *pri_hw = hw;
 
-	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+	lockdep_assert_held(ice_hw_ctrl_pf_lock(hw));
 
+	/* ctrl_pf cannot be cleared while ctrl_pf_lock is held for read, so a
+	 * successful ice_ptp_lock() guarantees a primary hw is still there.
+	 */
 	if (!ice_is_primary(hw))
-		hw = ice_get_primary_hw(pf);
+		pri_hw = ice_get_primary_hw(pf);
 
-	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
-	up_read(&pf->adapter->ctrl_pf_lock);
+	wr32(pri_hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * pri_hw->pf_id), 0);
+	up_read(ice_hw_ctrl_pf_lock(hw));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 16b1988e993d..ce8eb0672e71 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -293,8 +293,10 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
-bool ice_ptp_lock(struct ice_hw *hw);
-void ice_ptp_unlock(struct ice_hw *hw);
+/* ice_ptp_lock()/ice_ptp_unlock() are declared in ice.h, where struct ice_pf
+ * and struct ice_adapter are complete and ice_hw_ctrl_pf_lock() can be used
+ * in their context analysis annotations.
+ */
 void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd);
 int ice_ptp_init_time(struct ice_hw *hw, u64 time);
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval);
-- 
2.53.0

