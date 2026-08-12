Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2522576E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493369; cv=none; b=SW8A3HWjh2UKyW3CjnLuCE+j5cQZ/5576KwWtWuo1e3zd6mwtFSXs4okCfnCk3SNhNkXzpzCwVfBxETrn/4iobFUL90uS0BWhRsAGCBgbFombSdMPeygbPlCXqinujWjZ6FOA0F5hqg1zq00/y23VPPbQyrPRMmpouUBLNtV4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493369; c=relaxed/simple;
	bh=4IsJ/JTk9wLbzg8Ix/CoBeYxkqlsqa74qb0nLl1RTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCvPP1EZUZ06A/drbk1mKwsrFFmCXuj5YZcZeDKYw1WLTIC1oxXhjReW2Dwi3Ew0NHvqMRRd//1kSBQ4qnI6+4lN1YLH9LlXHOEHjcsZZvXGZZR/eUegyHp/AHc+xgxvx6p+Yarbra7EdELsvRm+iIhohSK2DuBdpNNpnVWAWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diW77lMm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diW77lMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786493368; x=1818029368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IsJ/JTk9wLbzg8Ix/CoBeYxkqlsqa74qb0nLl1RTFo=;
  b=diW77lMmNQO0eQy0g8rCcjICTTuhEI0GRLRr1kTXkCRK1WBb+j29xSof
   yre/xGnY0hHVv/KHF1kvIzt4o11Ir158LkRniMpP+pGO7ZMb/XjBeuTLO
   vVicSHeFdJDoYpIhCP/MjbG4bvEIAN1kib+kQAhD/4g3ksMlIAV3eK0qE
   4P9V2f9ig1sUajfRzHanqjKjCH0SnO1AkLiM1HopyZg+Fj+I9Ijha/rjV
   HjDECUyZTjn6zwvOBytyNCEM2oMDqrH4YWZj+z+m2iAe317oGrp0RAoLb
   q2egfl7rG2jiwncp5pFI26N2fYFgXJ4s9k7rtLmIB6tLlijfKFdVz7L6B
   w==;
X-CSE-ConnectionGUID: l+P7g2TzQ0uHonGQYay0Pg==
X-CSE-MsgGUID: OIiHawwzSMCjXQ9cItTLvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87110551"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87110551"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 17:09:25 -0700
X-CSE-ConnectionGUID: zz+WECijQOSdzpawRp5PCg==
X-CSE-MsgGUID: gHhvsELWR8aMoQ13SWzmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263522974"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2026 17:09:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	konstantin.ilichev@intel.com,
	richardcochran@gmail.com,
	poros@redhat.com,
	przemyslaw.kitszel@intel.com,
	robert.malz@canonical.com,
	willemb@google.com,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 1/4] ice: fall back to SBQ when LL PHY timer interface times out
Date: Tue, 11 Aug 2026 17:09:14 -0700
Message-ID: <20260812000918.220714-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
References: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 38 +++++++++++----------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8e5f97835954..3a41c711e751 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4808,15 +4808,12 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
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
@@ -4837,8 +4834,12 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+		if (err != -ETIMEDOUT)
+			return err;
+		ice_debug(hw, ICE_DBG_PTP, "LL adj timed out, falling back to SBQ\n");
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -4901,15 +4902,12 @@ static int ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
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
@@ -4927,8 +4925,12 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+		if (err != -ETIMEDOUT)
+			return err;
+		ice_debug(hw, ICE_DBG_PTP, "LL incval timed out, falling back to SBQ\n");
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	low = lower_32_bits(incval);
-- 
2.47.1

