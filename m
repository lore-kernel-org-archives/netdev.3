Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD36501F39;
	Fri, 25 Sep 2026 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375645; cv=none; b=mqhzByHFZnmmap1nGAwIUnppN/Egb6ClSQnk/IZSKHJppqKG5KNLIHnQJ5XerRUvM6v/7nAyDh6RCRkwveFkP3O17AY0oaoQU6NidJTir16UlY1dFzzP+uhLP0w20qt+qvWhL02X0QYsqOb7ytQVShr34xV4Wz94DSzi2mF+fvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375645; c=relaxed/simple;
	bh=/fRiT2uIHxSoKh+ze8gNFT3ceQoN28uehW9Lr55Jmxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNYGJfs8zk0QzGM8hMZ5ejRSgVqfxjI/IkdARO5cW0JFxN0o3JjgkTxB7AGBtj8Xx3k9yTuA60cA89njfWaCTnF6wqGrfZXg4mtzuVAWJxKC1Y1KkXuZIK8f+edTzgma3lwZVZIqM261Cr71OWNexcA6S1+msg/akKbWOZYs/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYbjBHUa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYbjBHUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790375643; x=1821911643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/fRiT2uIHxSoKh+ze8gNFT3ceQoN28uehW9Lr55Jmxc=;
  b=fYbjBHUas7+Oviuv2vw+6Apyg6KvXFdlxcNsYdcemAz5r+bcKvWswqcW
   W1VMY8/AxU1farAxHToUnWBEeJY+oItFsI1pu6ZpW71Vi6OaitNRfCkUG
   pDGnrGXEdpCtkRkPHuQovMnPbhHVzuk3nqMwKcUydk+74R0hPpZ+GJCA3
   PIs8KgEsRd+cVgW+UYaN44zBgQXXa1HE3WcLHJKKJezA9XMAssXoUGunU
   6Jdd0O9W+RrfoNNUK2AiO8XSWww6OqeN+aYmhom7OqXOU996DDQm9ifo2
   onrv50EYmFzflkbnxe3IDFOqHBp5NqVzivenWiL0Z/81zfWP0aihMpXGp
   Q==;
X-CSE-ConnectionGUID: Jsy2NKPnTpipXDluho4V5Q==
X-CSE-MsgGUID: uhHwN+Q/RuSfRdomOwugGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90071987"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="90071987"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 15:34:02 -0700
X-CSE-ConnectionGUID: 0LShXwHdTsGiNCK/k3RJ4g==
X-CSE-MsgGUID: mhIRvkYIS0OMWSBUT3Iatg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="273053398"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2026 15:33:59 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	Maciek Machnikowski <maciej.machnikowski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Marc Neustadter <marc.neustadter@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with PTP lock and incval
Date: Sat, 26 Sep 2026 00:28:23 +0200
Message-Id: <20260925222824.270640-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260925222824.270640-1-grzegorz.nitka@intel.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciek Machnikowski <maciej.machnikowski@intel.com>

ice_start_phy_timer_eth56g() programmed the PHY increment value and
performed the PHY-to-PHC phase synchronization in two separate PTP
semaphore critical sections, and touched the shared source command
register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
before acquiring the semaphore at all.

Because GLTSYN_CMD is a single global register latched for the source
timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime (small
offset, <= S32_MAX) or adjfine could clobber the source command between
the incval-init and the phase-sync steps. In the worst case the source
timer command written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was
overwritten by the unlocked ICE_PTP_NOP from ice_start_phy_timer_eth56g(),
so the adjustment was applied to the PHY ports but not to the PHC. This
left the E825 PHY clock permanently offset from the PHC, showing up as an
intermittent clock drift.

Hold the PTP semaphore across the entire start sequence: acquire it
before the first shared-register access (ice_ptp_src_cmd()), keep it held
through the incval read, PHY incval init, and the phase synchronization,
then release it once. Since the hardware semaphore is not recursive, split
the phase-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which
assumes the caller already holds the lock, and call it directly from
ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
longer has any callers.

Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP lock")
Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 20bd1813650f..d3e4aeb7e496 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2045,7 +2045,7 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 }
 
 /**
- * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC timer
+ * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer with PHC timer
  * @hw: pointer to the HW struct
  * @port: the PHY port to synchronize
  *
@@ -2058,22 +2058,18 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
  *
  * Return:
  * * %0     - success
- * * %-EBUSY- failed to acquire PTP semaphore
  * * %other - PHY read/write failed
+ *
+ * The caller must acquire PTP semaphore lock
  */
-static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
+static int ice_sync_phy_timer_eth56g_unlocked(struct ice_hw *hw, u8 port)
 {
 	u64 phc_time, phy_time, difference;
 	int err;
 
-	if (!ice_ptp_lock(hw)) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to acquire PTP semaphore\n");
-		return -EBUSY;
-	}
-
 	err = ice_read_phy_and_phc_time_eth56g(hw, port, &phy_time, &phc_time);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	/* Calculate the amount required to add to the port time in order for
 	 * it to match the PHC time.
@@ -2089,11 +2085,11 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	err = ice_ptp_prep_port_adj_eth56g(hw, port, (s64)difference);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_ADJ_TIME);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	/* Issue the sync to activate the time adjustment */
 	ice_ptp_exec_tmr_cmd(hw);
@@ -2103,15 +2099,13 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	 */
 	err = ice_read_phy_and_phc_time_eth56g(hw, port, &phy_time, &phc_time);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	dev_info(ice_hw_to_dev(hw),
 		 "Port %u PHY time synced to PHC: 0x%016llX, 0x%016llX\n",
 		 port, phy_time, phc_time);
 
-err_unlock:
-	ice_ptp_unlock(hw);
-	return err;
+	return 0;
 }
 
 /**
@@ -2174,19 +2168,24 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	if (!ice_ptp_lock(hw)) {
+		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
+		return -EBUSY;
+	}
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	err = ice_phy_cfg_ptp_1step_eth56g(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	err = ice_phy_cfg_mac_eth56g(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
 
 	if (ice_is_primary(hw)) {
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
@@ -2203,11 +2202,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	}
 	incval = (u64)hi << 32 | lo;
 
-	if (!ice_ptp_lock(hw)) {
-		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
-		return -EBUSY;
-	}
-
 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
 	if (err)
 		goto err_ptp_unlock;
@@ -2218,11 +2212,11 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	ice_ptp_exec_tmr_cmd(hw);
 
-	ice_ptp_unlock(hw);
-
-	err = ice_sync_phy_timer_eth56g(hw, port);
+	err = ice_sync_phy_timer_eth56g_unlocked(hw, port);
 	if (err)
-		return err;
+		goto err_ptp_unlock;
+
+	ice_ptp_unlock(hw);
 
 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 1);
 	if (err)
-- 
2.39.3

