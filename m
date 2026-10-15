Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993344D956F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091502; cv=none; b=cRleKBFIXvroTXdlwHs6pFm/5zB82cbufinOEdqHqB2/M+PzjK3L0SxZeP4UVuO7vSY2+VF/I1iVcewSAYcIUvrZzTeJnNyYR2YjZyGfAkX4jZOA1x51ZKsTU6HEwDbrbEfCYQtBCtzTBOxTLv87L0wQ8tp1j0esfBpvQ2c/7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091502; c=relaxed/simple;
	bh=6dWRievjIGJRSdCGaTcAZp7KYrACFgEf3k6T7z/l4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX2YSJ6Spe9ukIRmZKRNYE6WpMZshQy3ZcVEYEKTPPfW5zPCiPdr7VXmzXGTLqApClEZhn9vbZvYDrOfkLDBfKFW6Td+cS+V0oEaCnZnMRBTkrBBrAf/mOPHWM+rxf+tSIE7ghcHUczmbDJGHM4zcfscio2ognaZuQ/kt6PBOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxmXVlw4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxmXVlw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091492; x=1823627492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6dWRievjIGJRSdCGaTcAZp7KYrACFgEf3k6T7z/l4Ww=;
  b=lxmXVlw4MLcvoL6sSRxA4yuwKE+esd0QXzXh6AVg+nbMyzteD47kTbC0
   xvmYZEvI3USdem/9EOPoW5bEzQmWb0ApM/3Jw7+mmbF/2I2ILn8fYAXbx
   EAYMAeZ2Xt0edXddfUccYjP/UVD6ERdHLUvBgtRZe6cBlEoc5Ho6uUwqs
   UgrLDPZtTtkpD8pspyE3z6QV3BP8a4qKxfZPhcIQ3rPvwiyJaV93jICiP
   u+EkBb1lKYGOdcZKg8VaWgK5g2sHpj0qsfBKLpGVDAJlr+g3VeFaRg+Ya
   NxowIPCgq0bUndvPChjJvI13yGDZbCyWd/m6F02f1nwRUMwRHRc2e4pWI
   g==;
X-CSE-ConnectionGUID: BYIJrAytRa+n9Od0J8HS8Q==
X-CSE-MsgGUID: YZzVvpXOTGSkDZWcn/hHyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765601"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765601"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:16 -0700
X-CSE-ConnectionGUID: 5oCBUt3DSKWkXd/1KUN1bw==
X-CSE-MsgGUID: Ph7OjRk+QU+pbc7nTSlSqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078509"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:15 -0700
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
	horms@kernel.org
Subject: [PATCH net v3 10/14] ice: E825: perform a soft reset when starting the PHY timer
Date: Thu, 15 Oct 2026 12:10:56 -0700
Message-ID: <20261015191102.1174111-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
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

Since the E825 PHY restart procedure now performs a soft reset, flush the
outstanding timestamps instead of marking them as stale. This avoids
keeping those indexes locked in software unnecessarily for 2 seconds. This
is safe because the soft reset procedure will restore the timestamp state
and clear any desync.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  5 +++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 365cff9c1017..32be908373c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -756,7 +756,8 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
  * @pf: Board private structure
  * @tx: the tracker to flush
  *
- * Called during teardown when a Tx tracker is being removed.
+ * Called to immediately discard any outstanding Tx timestamps, including when
+ * tearing down the Tx tracker, and on E825 when restarting the PHY.
  */
 static void
 ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
@@ -1327,7 +1328,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		ptp_port->tx.calibrating = true;
 		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
 
-		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+		ice_ptp_flush_tx_tracker(pf, &ptp_port->tx);
 
 		err = ice_start_phy_timer_eth56g(hw, port);
 		if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 38d0ded1d0cc..51442b26516e 100644
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

