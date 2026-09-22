Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FA4825B1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100517; cv=none; b=S7yYWjS3VSxvwps8sY+2dpv0lBlcRzWqmErlw79XNemDv06yeV72GhGwc5Dfcx3EOJFGVLjxhE2PAyhC1htw8OgA0uISjoI3Zhr8bim8MCv174Zw8/SLdlhggoh/Rb4mkdj730pROnAwa8PawUpvqopJOUFt3Lt0IjLBlstTL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100517; c=relaxed/simple;
	bh=Ckp24sqJcKgxFa8rbNUiMvY34Hz8I1/uzZo8ARccLMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfNJHVUda1Li+ajD0sSdr4H6H0LOjDmjTzVR4GaIM3rxoxXsdmA9QSElhC4YOQxB0ab4cdUQ6WJ48dD46IigiIYx6E6KKYydQOukSs7ySXv4He5HgovrMJLeIpSpssPm2UZEIUvN3ir5zXgel4QB+oA6txSUHoDxkOtvkK7sPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e93rEBwo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e93rEBwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100512; x=1821636512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ckp24sqJcKgxFa8rbNUiMvY34Hz8I1/uzZo8ARccLMQ=;
  b=e93rEBwoWJC26jOIwA/OSeqOak6VxM/tjsePSAstiWz9klYTm/+JUFDY
   PPnGJ9th1+nyf+rFoYV6Wacgi7Go/KhxAKfY56wt/z4qtbsD7iNABYoFn
   8McWn6iMra+YjoC0xlTVivieB1aFhf+pROBXMxUpQb3osKL3Bx2ZgfoMg
   cR+azFJt0hof/g9RVXFwk0j6uOe18HXq+2MhH7QzmSCUv9X5X2NBVmQF+
   PPom4ZnxNxiJDRwhxVSF3D8ujqgvgth5bgdQQYzIAvf/3h14VbVqFgAoN
   QpnsPZMT2/lpI+S/69F4qnbGlEyeQZnlgJzFyWN/RUQ5hhtrxQNfDQVBG
   A==;
X-CSE-ConnectionGUID: mLQDSQWtTq2/NrzpAnL0sw==
X-CSE-MsgGUID: WMjERymGSBSx8bwXChI/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232043"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232043"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: 0vpD6wXETpeAmo5W7remVA==
X-CSE-MsgGUID: igAZSAQARhimxV4PB2UDJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315325"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:41 -0700
Subject: [PATCH iwl-net v2 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-8-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=7881;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Ckp24sqJcKgxFa8rbNUiMvY34Hz8I1/uzZo8ARccLMQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6ULzKKae5qFV65Z/UVQketCtVf2Ib7EPyzC6w9Ob
 6nUEY7rKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCIxbQz/U5s+hlUfO/er4ien
 VeiRlx7GhpPuWJ1RYjtxUXp1yOxnpowMh1ItbGbdLJgXu+D/dat57re2357GJ5v96cxvTl2fJT7
 WTAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
will be rejected until the PHY timer calibration has completed. Unlike E822
devices, set the calibrating flag when "stopping" the PHY and clear it
immediately after the start procedure. The E825 device does not perform
vernier calibration and thus does not need to wait for hardware to mark the
offsets as valid.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 24 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 21 +++++++++++----------
 3 files changed, 35 insertions(+), 12 deletions(-)

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
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 328e90dc51aa..657cd78ec738 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1221,6 +1221,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_pf *pf = ptp_port_to_pf(ptp_port);
 	u8 port = ptp_port->port_num;
 	struct ice_hw *hw = &pf->hw;
+	unsigned long flags;
 	int err;
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
@@ -1236,7 +1237,12 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		err = ice_stop_phy_timer_eth56g(hw, port, true);
+		/* Disable new Tx timestamp requests */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		err = ice_stop_phy_timer_eth56g(hw, port);
 		break;
 	default:
 		err = -ENODEV;
@@ -1302,7 +1308,23 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
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
 		err = -ENODEV;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..c8a67a307832 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2101,24 +2101,25 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * ice_stop_phy_timer_eth56g - Stop the PHY clock timer
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
@@ -2151,7 +2152,7 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
-	err = ice_stop_phy_timer_eth56g(hw, port, false);
+	err = ice_stop_phy_timer_eth56g(hw, port);
 	if (err)
 		return err;
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

