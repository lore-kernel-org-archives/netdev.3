Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455434D934
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482544; cv=none; b=lyQVA/68uvm5JNGLA3nVVFGSIq9D1PA37awM0FxqOraxffx+yM5bkF+K+djg3eUFBNY42kNKN86DThn5sZ1rc7ucpsnW6/Cx8d0whgKCtGBqQObhWbUffBz3xKr04vu1eqLXYen9meex34jyHj5+NhAYXbBdsg3isqbbPMn8gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482544; c=relaxed/simple;
	bh=aVi0oTxKil65uBY1E9T3MK7XfbJsxmnfyI56zDaj6Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgJGWiLM4XrA3CjIXnVUDE3mGmaMfHv++4nYwVHL4mxdr+mE8n1l+MFye32Ik3fxYsOZQVWHIG1vHy22Sd81YKgsVYlCrVTrSZ7BpraM+Fayd/mrl609UVMFNHubpvMtm3RyIhUk0Ql5idDtNLvc3sFkmuwUi61BGS3h6Zj1NX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvsDZ44g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvsDZ44g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786482541; x=1818018541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aVi0oTxKil65uBY1E9T3MK7XfbJsxmnfyI56zDaj6Co=;
  b=ZvsDZ44gizPSdDPn0hh37QqCpXGGJR4MgP0axSLtaiuudVey3jp9rCz8
   7pzBPzwsl0qi+zDh0k/hBWmV/e/2PkBe3XAP4qdhyt+sXb8Hcq3m02ROi
   ZQN05A6DkTOE4JMyJs70Ny3qLxV06ylnhiNkoQL0hIXFljNBbSUyX/4sz
   wdFYZzy9inuyaQ/04ZQVRvba6zHSNb8UoWpcTT0qKg6yFIRfrICqrqF04
   8Zhv2kgcZDJk2BJ+9AuZvAj4bRVebG6udbqKlUB7h+wPkVg/yXMwWiDzN
   35jyA+AeSX19xikHsb6tbsW5CNOtPmGirjwXNpLmLdg2GywmivRYv0MOx
   w==;
X-CSE-ConnectionGUID: ak5Hs0A+TXidIxU/arPgvw==
X-CSE-MsgGUID: P/uqkF+KSkWEXRTx7uFPVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98542016"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="98542016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 14:09:01 -0700
X-CSE-ConnectionGUID: nQR5LLpWTXmpD+COpJt7OQ==
X-CSE-MsgGUID: 54rR1qTtS8CARYNUnCZzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="268594453"
Received: from dmert-dev.jf.intel.com ([10.166.241.33])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 14:09:00 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ice: Fix incorrect LLDP filter assumptions
Date: Tue, 11 Aug 2026 14:11:27 -0400
Message-ID: <20260811181127.1142095-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
necessary"), it was assumed that llpd_fltr_ctrl was a unique application
of a filter instance and the other command in the flow was generic.
This is an incorrect assumption, they are both meant to add a filter to
handle LLDP packets and only varied in the actual AQ call made.  The
newer AQ call was created to handle a special case in some NVM images
where a LLDP filter was already existent and the old AQ command would
generate an error if a new filter was attempted to be added. The newer
AQ command would detect this case and instead would add the current
target to the existing filter rule.

Fix the flow so that the newer command is always used if available and
only fall back to the older command when that is the only solution.

Also remove the obsolete state flag from the PF struct.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  1 -
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++-------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fc91b6665f90..7eaa3d1e78a5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -522,7 +522,6 @@ enum ice_pf_flags {
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
-	ICE_FLAG_LLDP_AQ_FLTR,
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdc4fda89e9..2fe91ff8119f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2090,24 +2090,16 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
 				  ICE_DROP_PACKET);
 	} else {
-		if (!test_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags)) {
+		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
+		if (status == -EOPNOTSUPP) {
+			/* If fltr_ctrl not supported, use legacy
+			 * add/remove command
+			 */
 			status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
 					  ICE_FWD_TO_VSI);
-			if (!status || !create)
-				goto report;
-
-			dev_info(dev,
-				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
-				 vsi->vsi_num, status);
 		}
-
-		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
-		if (!status)
-			set_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags);
-
 	}
 
-report:
 	if (status)
 		dev_warn(dev, "Failed to %s %s LLDP rule on VSI %i error: %d\n",
 			 create ? "add" : "remove", tx ? "Tx" : "Rx",
-- 
2.55.0

