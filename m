Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00F4734F3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496647; cv=none; b=Dp0XYV1fT28Zsab9RqjFBLJ/iGncMITusDnauXCbE2NlGB4P8MxT3/KyoPLVF/pkNjNyus964gKKUvfpGlpx0EQUpdQ7j2+MoYZxd4YsvNsR18TRHFljQzIV8K8CKWU0tJWolu7LU0G4b+WeTpp7VEFGAOSlBnToEKZ6eoqGzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496647; c=relaxed/simple;
	bh=mcYYbmzzPL1JULszMMjcVZoJtn1DhcMVQ6mQrr7bIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1txO8VwuczP/eMd6nVcwf+K1TUwmfXTdwBC9zuanW9GgoGnS4ZGfHlArwj5j5LIP2fUrKf/pK4ZiUuQy0bt21mIifyivLJumDndEuB5OkkTrq9YK6o1mohvjTao96ExRIPag7BXNbsw78jRqYNjhaY4B3S18NPNP1heANIfu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRtAhnPD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRtAhnPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496645; x=1823032645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcYYbmzzPL1JULszMMjcVZoJtn1DhcMVQ6mQrr7bIfU=;
  b=iRtAhnPDTIVF2pmoRlF46SgPARGIG7SRewjV4tu+J68XAtHr4IO0E69Y
   +2jqDMK1US9FbG6MqyEQKrJ6wYAt0766dNrWxB6W+EYNbH9K5QLEXiFRd
   Wc2lil9QDxkgL6mGAzsj5l+HGl3FdXoLtriHtx4SF5wsmZzQ2cJYqFZda
   exegfh5cyQ6ILNKb7lajcGMziddsYNPwuDKkGYxH690X7B97b0fyU+6nv
   LCDZfB7aeFlkQLvow3FUvKj0MbXMn4h3pKN2Yj9Ri2HtJeW5LGDuBbiJg
   Crnc/jFGSoYetjEwCQ4T3AoFGOMSlRrm0imk1blgYbZJ3PHxHToJ+yFMu
   g==;
X-CSE-ConnectionGUID: pvtKxGl2T/e9x6kK3ZUtMg==
X-CSE-MsgGUID: G/w3eRyoSkSxgTumL6oInA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294681"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294681"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:18 -0700
X-CSE-ConnectionGUID: /e3WKU8DRNmy8VeEEhnaGA==
X-CSE-MsgGUID: Da7S6RZwQaGpUKqQ88JxdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150427"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:18 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net v2 10/15] ice: E825: perform a soft reset when starting the PHY timer
Date: Thu,  8 Oct 2026 14:56:07 -0700
Message-ID: <20261008215614.1987250-11-anthony.l.nguyen@intel.com>
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

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e83ad2bb8d42..e5bfede90431 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);
-- 
2.47.1

