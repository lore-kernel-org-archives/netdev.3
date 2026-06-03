Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089E3ACA50
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487202; cv=none; b=mq/tYf/ldWcUUu/lRzg4lD9tYDQhmSLaLhvzelE/NcGt+Jm5DAYeN3InMrEoQwk6CybX6vGQN+UBBbRtIBcu2qukqbQJCbiUr3chBkY1lWSkAkJP/7/OlRpy9Yd5PKYCvGhEQwFU/TZoUF8dFE63pofxg5lOGrC/tOtLf+EPZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487202; c=relaxed/simple;
	bh=twJh+v61YmVOCdD3LU+n0f4tRtzRHvzSF5fUmm2ShPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/OnPzS5+wBocu6A9hBsJ+0R/BHmY5fox/P1nwr5i9TwLF2Gm2zsOhTPXbO4Y8o/noXwFiX51Ll70e4Vt9OdKxJyGcVazHtNvC8BpGLcg9Cpt44/8Xx1e5VkVh/QIGpo1F4VbLUcB2O4jMEXr6fFlgbt0aVBgU7RCTjrT9ksajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxYiqVKU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxYiqVKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487201; x=1812023201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=twJh+v61YmVOCdD3LU+n0f4tRtzRHvzSF5fUmm2ShPs=;
  b=SxYiqVKUf0+sacIKojMlNSMktdYJPkYmkIof3zluey4ehvM/63geSNCJ
   jZbzUjCblM7iLhrVxnL66KOYa6rNjoKRTmh7ngNDA4DQMgjk4a3xscmo/
   l18mXRhy+s2Dqa3A34L496UZvTxX4KMaMzk3/pR+1BxDy+RZg2wXOGB6l
   uqoOyL5oI1AIewIXIZJJ9I+tWq2jHkybK5JeWyKeADn+JO+IpFrxtpzAC
   SzL3Zit2OJX/AUL+xcsoMtLtU5p/qV6gjZFaHih6aOS6bjFzk2oOrkmVG
   U2Ch05Z1MG1mzDh0G7w/GrUuqY7MVVpLp4PQesR6HCa0upMlso7Jzfz0z
   w==;
X-CSE-ConnectionGUID: 6REY10y6S6mxvILLRKDYXg==
X-CSE-MsgGUID: DUrUnVyIRkG8dMZGjCS00g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81419466"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81419466"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:46:41 -0700
X-CSE-ConnectionGUID: UVJKNZSJR9G/qmzudOipxQ==
X-CSE-MsgGUID: mYXpDeZ9R3K0PZ6JyTLlVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="274446175"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa002.jf.intel.com with ESMTP; 03 Jun 2026 04:46:38 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net v2] ice: fall back to SBQ when LL PHY timer interface times out
Date: Wed,  3 Jun 2026 13:48:15 +0200
Message-ID: <20260603114904.1297713-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The low-latency (LL) PHY timer interface relies on a tight, atomic poll
of the PF_SB_ATQBAL register with a 2ms timeout. After an NVM update /
EMPR, FW may need significantly longer than 2ms to start responding to
ATQBAL commands. The first PHY adjust or incval write issued by
ice_ptp_rebuild_owner() fails with -ETIMEDOUT.

Fix this by falling back to the existing SBQ-based PHY register write
path when LL times out. This makes sure PTP is initialized when FW takes
longer than expected to come back online.

Steps to reproduce:
./nvmupdate64e -if devlink -f
Update E810 card with nvmupdate64e, and observe dmesg errors:
  Failed to write PHC increment value, status -110
  PTP reset failed, error: -110 (-ETIMEDOUT)

Fixes: ef9a64c07294 ("ice: implement low latency PHY timer updates")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
v2:
* add TIMEDOUT check in ice_prep_phy_adj_e810
v1:
https://lore.kernel.org/intel-wired-lan/20260511095830.1095984-1-przemyslaw.korba@intel.com/
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 40 +++++++++++----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2c18e16fe053..9cd323bd9739 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4771,15 +4771,12 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
 				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
 				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
 				       REG_LL_PROXY_H);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
-		spin_unlock_irq(&params->atqbal_wq.lock);
-		return err;
-	}
-
 	spin_unlock_irq(&params->atqbal_wq.lock);
 
-	return 0;
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
+
+	return err;
 }
 
 /**
@@ -4800,8 +4797,13 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+		if (!err)
+			return 0;
+		ice_debug(hw, ICE_DBG_PTP, "LL adj failed (%d), falling back to SBQ\n",
+			  err);
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -4864,15 +4866,12 @@ static int ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
 				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
 				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
 				       REG_LL_PROXY_H);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer increment using low latency interface\n");
-		spin_unlock_irq(&params->atqbal_wq.lock);
-		return err;
-	}
-
 	spin_unlock_irq(&params->atqbal_wq.lock);
 
-	return 0;
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer increment using low latency interface\n");
+
+	return err;
 }
 
 /**
@@ -4890,8 +4889,13 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+		if (!err)
+			return 0;
+		ice_debug(hw, ICE_DBG_PTP, "LL incval failed (%d), falling back to SBQ\n",
+			  err);
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	low = lower_32_bits(incval);

base-commit: 80b47e88f7ead00b0795e9f2833f1d0cafe11d90
-- 
2.43.0

