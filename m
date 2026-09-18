Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109D51477D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738363; cv=none; b=rlqViaqYaooseTTp/JZAH9VWdck/1oLnMTpTfqYK+QqNkHCWuva88kyXpwcyvgaqrrh2k4zMMWo/20pFfRXSyWBn2x0mRI9VPJl4ZJkEoxlw4/qaQmF+xMeDkc2Ggz3DiQBgDZzpz6WS80mHk8DVhIqAmqzrv/0KTArAAzS1FAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738363; c=relaxed/simple;
	bh=BtwOBXqZ/1rbZ6xusRjG+PNwnS2FdwGYUBsaWILvJCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C43oOzjDxYwTHOexaCDVEOiTHrJ0eLiMk94NJCGtZ8Qsbi5RHPrcJuPco0I391RePw73AA29Sm4boo91tXjOAjo30afy2L1cdvaNBaBy/OF5Lm8dP9bsTpQwFiObiZgS3jj0s/tYyPPz87kNrzhyv8kaE3Xv2PwC5gRDazLoGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2JVOfsH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2JVOfsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738361; x=1821274361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BtwOBXqZ/1rbZ6xusRjG+PNwnS2FdwGYUBsaWILvJCc=;
  b=F2JVOfsHMvpvQeJ40ZPL1Jx5Enx1BOBxsXlIZawARO8ooBaud2Z0PlLv
   7Vm/+R899lOk91eFAZ7mcecDucdJVd5+gwV0NZ5DYajbDb6jEhcofM/9D
   edywagGKs2B86tIDEf4h6CUzKkm7Ef7KYO8uezOvQyX2lkH/iCaK7oQqE
   aMqkIM5R6AS0WlNHdS0XhnfDCJzB2x0LUjJxgPqxFVEjoAjmGkWvlQK6n
   OCpjB6MVRyDL5ElxRXariDdt5/qnRmCe329sdAOI5Pe7YoVBZx6OHXccD
   jdpMB2Q6qWO8fHoQ3YRPfrGluaeh2vYLceKWD0Ym58Nrm/VGhsBpYBikb
   A==;
X-CSE-ConnectionGUID: sZyFK4GCRreOkAkEP/K1pw==
X-CSE-MsgGUID: EO3Y9/DxSNqXZn4neCnW3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776419"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776419"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:32:41 -0700
X-CSE-ConnectionGUID: FkIJlOAET6CCW+QR4Aw3YQ==
X-CSE-MsgGUID: IuzPXyZUT5ywZmvuHW07tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835252"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-net v3 3/3] ice: support RDMA on 4+-port E830 devices
Date: Fri, 18 Sep 2026 15:32:34 +0200
Message-ID: <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

E810 and E82X devices do not support RDMA on configurations with more
than 4 ports. This limitation does not apply to E830 devices, which
have a different hardware design and support RDMA regardless of the
port count.

Narrow the RDMA capability disable condition to skip E830 devices.
Move the 'RDMA functionality is not available' notice inside that same
condition so it is only printed when RDMA is actually being disabled,
instead of unconditionally whenever num_funcs > 4 -- otherwise E830
would log a spurious warning even though RDMA stays enabled.

Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0463310..1c4421f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2510,16 +2510,16 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
 		caps->maxtc = 4;
 		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
 			  caps->maxtc);
-		if (caps->rdma) {
+		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
 			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
 			caps->rdma = 0;
-		}
 
-		/* print message only when processing device capabilities
-		 * during initialization.
-		 */
-		if (caps == &hw->dev_caps.common_cap)
-			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
+			/* print message only when processing device
+			 * capabilities during initialization.
+			 */
+			if (caps == &hw->dev_caps.common_cap)
+				dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
+		}
 	}
 }
 
-- 
2.52.0

