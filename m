Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637A305670
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086893; cv=none; b=HmFsYqJq+4i20sdJtMTAB2RhKqskBW1rNBNpaHjKFxH5PRmQ5OxxhxZggHbttSYCWVCodvnjqhXUnSZhKmhQKOvH4Df0Hh7iS4FE8ejNaVtZYxBvsGHCkMxN/t6aqdx2ku3CeyVkYK0PBvoaUPTlNRW7su36EZI0igrmuzGq5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086893; c=relaxed/simple;
	bh=eYD7Hn5Y5Qm/IzfnYhJ/PJlPMufkIwaRd/tihzEr5vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMPv55/5c+BbNjUvoEzPrnzN8tmm99M1NWMcwoTjAnOrsCh0LidWQTpVycMcSvRhFBEWZLV3x459/a8DmyFvMyBfwX/GmC/1eKBjPu5bF3FrxlgI/2Xam8v8TAP8a22C8OW40QRg9m0PGfcXGZedNGiVmk0DoqaI2VWvxoNxPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoloxALS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoloxALS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086891; x=1820622891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYD7Hn5Y5Qm/IzfnYhJ/PJlPMufkIwaRd/tihzEr5vo=;
  b=HoloxALSEYBKZBePDgI1N7XTXsGJvlfdk3pNmteXkBfyS2iDrEHi9oe7
   v3a8FA8uf019VBJ++Z7PNz5aofGVuEXGqnJnxhdgAam2wLgPGeoG1wPkK
   AvHchhIIWb6ijeCscUvVPojpyL4zMGqjbs5x29v2sZQ+vLKSDBz7Z1N9k
   0DMdsIC91hSQ+Iisl6gEloCblRwaKFevuHxnWlgfTbfk+YheOOEf4OEE2
   0vlKFgLwtuPQDuR5aV9WhT5ob3v3Ql4ay73DOzeyg4WDv3GiJQrxDwUuu
   LvN4B7XhbZdFn7CEpqLXzre2vOwxBELr1xrXaKOiN7mgNUgHXQqxD3aJe
   Q==;
X-CSE-ConnectionGUID: i4ImzcChSYab/ZA7kqXNIw==
X-CSE-MsgGUID: TG/Ff9uYSpOomhVjwwKCkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564726"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564726"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:44 -0700
X-CSE-ConnectionGUID: kUzkZ6gAR/y3qZb0EudFOg==
X-CSE-MsgGUID: tnD00t49QUeKjZnr13ijgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291071"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 09/15] ice: E825: perform a soft reset when starting the PHY timer
Date: Thu, 10 Sep 2026 17:34:18 -0700
Message-ID: <20260911003430.3386340-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
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
has been completely reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a3a9f7ce04d2..64e18fe1176b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2120,9 +2120,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
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
@@ -2138,6 +2140,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	err = ice_stop_phy_timer_eth56g(hw, port, false);
 	if (err)
 		return err;
-- 
2.47.1

