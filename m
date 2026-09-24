Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A99477E2E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254774; cv=none; b=Sbp7nEQC8MV0Bj5zSjCEpY95TxZ7v/USC/GRCjWxGDmLLt0zkqXcuAJKsYG275/UZJeAyOJDcu6INevSPXadZTJ6IfbJG8z4qxHJ+UZiqmW+WBIb4Kfm7TgiqPVAZn1FLsumt2FyDd94YVAgMyfmVbRz/177E/D5gI+TGkNeXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254774; c=relaxed/simple;
	bh=LZ9TrTcQM9inz6/eTHV49ReXqnEAzy1K1Bj4zEwKK5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPyGfUt+EFA4EJgRrCIB1wjcSk74WHTL6iUIlG7Lo2YNMyVcG1L5h5vuMUkyJmq0elZ4JowkvEZRdIgRrc9nkcKhQmrwPYO9tZvip0hNrOXuciYm2YDRdHKhXR4VIDRua3LpnhTX8aLAnk45Ypp8QjW3UCK0F3TwF57Lg5ZlHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0Lj31i9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0Lj31i9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254772; x=1821790772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LZ9TrTcQM9inz6/eTHV49ReXqnEAzy1K1Bj4zEwKK5E=;
  b=V0Lj31i94x3PF6g9L/ZMDDfw65Rl7d0OtZMu7qiQr3fsJRcbn6dWPVsl
   si2IkoWt+C+SPPpmlZ97GwYTVkn6H3toxGXJYsmDitcqtT0zH/mfIqkeU
   +yrIKURA5i6vLoiSmXl/WziWhrnwIOtPtq+zEGypEvrib4R7NU+z7Sq3d
   tFsTk++K7QgvddVNfrTE3bkUF8BwaN7M0ihJ4ymtF+UvpIPwQueM0AYZ+
   h3+owg/q0kxu/vS21u7dM2aAArI2+Fikgp3ZmP5AznvHEls7XG28W6c3D
   dYxsBtrq6MHGt9qB55sYWwFLqCKwZc0aR6dbG/E2Bk37GFwKtckAz0D/c
   w==;
X-CSE-ConnectionGUID: /CYxlJnARWOZel/htqnE+A==
X-CSE-MsgGUID: 5zLywIygQIeStkMy1foO2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249223"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249223"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:21 -0700
X-CSE-ConnectionGUID: h+oSSchvRamarbfU0jEiBw==
X-CSE-MsgGUID: 62oj8oixS3uo4IEQNG1g+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934425"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:20 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 3/8] ice: Cache struct ice_hw pointer for split register reads
Date: Thu, 24 Sep 2026 12:59:11 +0000
Message-ID: <20260924125916.2796499-4-sergey.temerkhanov@intel.com>
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

Cache the primary ice_hw pointer to ensure consistency between
calls (both parts of a value will be read from the same NAC).
ice_get_primary_hw() will never return NULL, but during the
ctrl_pf cleanup there may be a case when one call will return
the pointer to the ctrl_pf->hw and the subsequent one - to the
pf->hw which generally are not the same.
Struct ice_hw is embedded in the struct ice_pf so it is protected
by the same critical section - no additional synchronization is
needed.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 0e138390f8c8..38e90a68ba78 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4,6 +4,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include "ice.h"
 #include "ice_common.h"
 #include "ice_ptp_hw.h"
 #include "ice_ptp_consts.h"
@@ -2014,10 +2015,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		guard(rcu)();
 
-		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
 	}
 	*phc_time = (u64)lo << 32 | zo;
 
@@ -2187,12 +2192,16 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		/* cleanup.h advises against mixing goto with scoped helpers,
 		 * and this function unwinds the PTP semaphore with goto below.
 		 */
 		rcu_read_lock();
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
-		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
 		rcu_read_unlock();
 	}
 	incval = (u64)hi << 32 | lo;
-- 
2.53.0

