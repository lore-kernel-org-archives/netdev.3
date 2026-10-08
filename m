Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443B4718F9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496645; cv=none; b=L1V6Nn6Ac4vBkuiMz701X6K+5NzcV9zq3NWQ9H6gAONp2wo4OveiyXjlRhPkTt5z7LuM16hAFSvyiuryqm+ZYxQD7/VI2ZVi1rNOalaGbJBwdnaSJpUbTPDG4w8VBQtvFG3AuwpCRw4+yksJJRHtGnP+4krIVmjHj6eiK60j3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496645; c=relaxed/simple;
	bh=XdhtDGpKTJiBi7TVDXgtT5dSzKZ52KvfIeOGrfPCznA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLfeFbvnpDIXs9Bc4bvYyOvzMGPiL7TdxazG40Va5PI/pXgXx8nmOu3n3KFqPmNktSWOqPTFFqpFdTGLPhDvvHEne0nHFcreGNWOjpyLZCS3nXUCw/kV2qJCguzIY2HRYl2IEOIbViKk/ur8qhDNueHYECDaFh9WvXwUMtelCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G87Aj5zd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G87Aj5zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496644; x=1823032644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XdhtDGpKTJiBi7TVDXgtT5dSzKZ52KvfIeOGrfPCznA=;
  b=G87Aj5zdXIOzYIv4SBfCJA9SnB7YYqcIj+Vl6pkOtb728AKzOxEOzIX6
   3vWLLQxilBeSLucOzsCt0lWClkzGHNZkWsUfGcgxp642W0Y3JCUCwemZ8
   7qsxM447eVs7BIwZeGUlsy73G+fEZNjrc8GgF+iQvRT0nm9UsIhDEVaOH
   bOnGqBR3l9jL/XVXhjMrd3aRmlUAPKEpufqQA4IRdxeee1n6xslv8Q0iZ
   uRVBxjjJhOQyGsSVbu1SXmZASOb6AbgUyhm1jbwrin+YHohD8sh8nxJ+Z
   pUeYKmsg0pkyJK33u54/6XiN6gujLPHU+9iHpzI4N1oFugm0uLzf+dTUX
   w==;
X-CSE-ConnectionGUID: u0ZCWC10Q9CSVw5O7pzagQ==
X-CSE-MsgGUID: goT6n7fgQKiCg9bDayGBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294664"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:18 -0700
X-CSE-ConnectionGUID: p/71NI6SR4K+JZsmAR2oHg==
X-CSE-MsgGUID: LhRMgUJjQKeUmSM1xQAmRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150420"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:17 -0700
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
Subject: [PATCH net v2 08/15] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
Date: Thu,  8 Oct 2026 14:56:05 -0700
Message-ID: <20261008215614.1987250-9-anthony.l.nguyen@intel.com>
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

The ice_stop_phy_timer_eth56g() function is called by the driver for E825
devices to ensure that the PHY timer has been stopped. The equivalent
function for older E822 devices performed many steps. However, on E825 it
only clears the PHY_REG_TX_OFFSET_READY and PHY_REG_RX_OFFSET_READY bits to
indicate to HW that it should no longer treat the PHY offset as valid.

When PHY_REG_TX_OFFSET_READY is cleared, the hardware still captures Tx
timestamps, but it no longer sets the valid bit for these timestamps. This
sounds reasonable at first glance. However, this results in the internal
outstanding timestamp counter becoming out of sync.

When capturing a timestamp, hardware increments its internal counter and
sets the associated "ready" bit in the timestamp memory status. Then it
compares the timestamp count to the threshold to determine if it should
trigger an interrupt to the MAC.

Upon reading the timestamp hardware is supposed to decrement the counter,
clear the valid bit, and clear the associated bit from the memory status
register. However, it only performs these steps *if* the valid bit is set.

Since the valid bit is not set while PHY_REG_TX_OFFSET_READY is clear, the
timestamp counter is not decremented and the memory status is not cleared.
This leaves the counter out-of-sync until a PHY soft reset.

According to the hardware engineers, the PHY_REG_TX_OFFSET_READY bit has no
other effects. It only controls whether hardware captures timestamps with
the valid bit set or not. Since capturing timestamps with the valid bit
clear is problematic, they recommend simply not clearing
PHY_REG_TX_OFFSET_READY.

Note that the PHY_REG_RX_OFFSET_READY performs a similar task. However,
clearing it is fine as there is no associated timestamp counter on the Rx
side. Receive timestamps are simply inserted into the descriptor. Clearing
this register clears the valid bit for timestamps until we complete
calibration and re-enable the register.

Notice that the soft_reset parameter of ice_stop_phy_timer_eth56g() is
totally unused. It is a relic from a copy-paste of
ice_stop_phy_timer_e82x() that is unnecessary, so remove it.

Now that we do not clear the PHY_REG_TX_OFFSET_READY, new timestamp
requests could happen while the PHY is calibrating. To avoid this, set the
tx.calibrating field of the Tx timestamp tracker when stopping the timer
and clear it when finishing the restart. This ensures that any new requests
will be rejected until the PHY timer calibration has completed. Also call
ice_ptp_mark_tx_tracker_stale() to prevent reporting any previous
outstanding timestamps to the stack.

Unlike E822 devices, set the calibrating flag when "stopping" the PHY and
clear it immediately after the start procedure. The E825 device does not
perform vernier calibration and thus does not need to wait for hardware to
mark the offsets as valid.

In the event that the PHY timer start procedure fails, the device is in an
unknown state and timestamps will not behave properly. As such, and similar
to E822 devices, the calibrating field is not cleared on failure. This
leaves timestamp requests disabled until the next link restart.

Failure in the start flow is unexpected and it is unclear precisely what
state the hardware is left in. Attempting to add a complex retry mechanism
for a rare event is not worthwhile. The port restart procedure can already
be re-initiated by triggering a link reset (i.e. via ethtool).

Instead update the dev_err message at the end of ice_ptp_port_phy_restart.
Clearly indicate that timestamping is disabled, and add a note that a link
toggle might recover the device. For the invalid MAC type path returning
-ENODEV, skip this message and log a dev_dbg that we failed with an unknown
MAC type instead.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 36 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 25 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7cc151b01a13..818e2e265a7e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1221,6 +1221,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_pf *pf = ptp_port_to_pf(ptp_port);
 	u8 port = ptp_port->port_num;
 	struct ice_hw *hw = &pf->hw;
+	unsigned long flags;
 	int err;
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
@@ -1236,7 +1237,14 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		err = ice_stop_phy_timer_eth56g(hw, port, true);
+		/* Disable new Tx timestamp requests */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
+		err = ice_stop_phy_timer_eth56g(hw, port);
 		break;
 	default:
 		err = -ENODEV;
@@ -1302,15 +1310,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 					   0);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
+		/* ice_ptp_port_phy_stop() may have already disabled
+		 * timestamps, but some restarts occur without first stopping
+		 * the timer, so we ensure that new requests are disabled
+		 * here.
+		 */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 		err = ice_start_phy_timer_eth56g(hw, port);
+		if (err)
+			break;
+
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = false;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
 		break;
 	default:
-		err = -ENODEV;
+		dev_dbg(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with unknown MAC type %d\n",
+			port, hw->mac_type);
+		return -ENODEV;
 	}
 
 	if (err)
-		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
-			port, err);
+		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u on link-up with err %pe; Timestamping remains disabled; A link-toggle may recover.\n",
+			port, ERR_PTR(err));
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..07b55fbb88dd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2098,32 +2098,33 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 }
 
 /**
- * ice_stop_phy_timer_eth56g - Stop the PHY clock timer
+ * ice_stop_phy_timer_eth56g - Clear PHY Rx offset ready flag
  * @hw: pointer to the HW struct
  * @port: the PHY port to stop
- * @soft_reset: if true, hold the SOFT_RESET bit of PHY_REG_PS
  *
- * Stop the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Disable Rx timestamping by clearing the PHY_REG_RX_OFFSET_READY. This
+ * causes Rx timestamps to be captured with their valid bit clear, ensuring we
+ * discard any timestamp captured while the PHY is being recalibrated.
+ *
+ * Note this does *not* clear PHY_REG_TX_OFFSET_READY. Clearing it would
+ * cause the Tx timestamps to be captured with their valid bit clear.
+ * Unfortunately the captured timestamps still increment the internal counter
+ * and result in off-by-one accounting. Instead, Tx timestamp requests should
+ * be disabled by other means.
  *
  * Return:
  * * %0     - success
  * * %other - failed to write to PHY
  */
-int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
+int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 {
 	int err;
 
-	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 0);
-	if (err)
-		return err;
-
 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
 	if (err)
 		return err;
 
-	ice_debug(hw, ICE_DBG_PTP, "Disabled clock on PHY port %u\n", port);
+	ice_debug(hw, ICE_DBG_PTP, "Disabled Rx timestamps on PHY port %u\n", port);
 
 	return 0;
 }
@@ -2151,7 +2152,7 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
-	err = ice_stop_phy_timer_eth56g(hw, port, false);
+	err = ice_stop_phy_timer_eth56g(hw, port);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 16b1988e993d..17000df77ce9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -378,7 +378,7 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 
 /* ETH56G family functions */
 int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status);
-int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
+int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
-- 
2.47.1

