Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489580;
	b=vH/ss2VKAOi3Y8m8o4qYHArR83hFo3LOT5iqBbi0tuFUAFDuqDQA4TzVRrOWV3pO9Z0h
	 dswX4XHGi8NhHVCtD7UwZTen1stHTEcXBz8CdchZ7MVj4VwBRQ22rF0zcYs9m7E2+qmxz
	 UBiBpd5TgIN9YGxYadNf+lDn9tKjveXfO6uQTwRSToS9fz9oby780dujOJrhzSY0PS9pF
	 0PHvUtFhjEkTFIaEQsVKUaN2DVBFxhgwCB0WtxEGxQkhmFxj73MtoKO3U6h7oIRs6/jcf
	 nVwHziRNUDv890dTy7RYfu+6qjlxGtxwDZ00Z59KTMGx89HGT9CQi3xnnjfVPd5gAdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=tM+i5NiMzE0bzmyf3kwUh/wgTvsAEb+BmUxd/QhFSvg=;
	b=kvAzJd8kv3nGvSF6g53I/1EQzewCpgQCh2YXDAeOjxoP7t6D/3104/IT3qFZ924Q+7A+
	 fvqtIwcMlgmWXToOvFP6oHYX/ArZKPHNgKOBZUX902zs8sDS1ur5dk91Nb4nC/KMeAvI5
	 eY1eZ1sBuqra6wH6mKY3af0TMzUFevGqBpkM9wvOs+BpXtvFLUsvTP28/lH99qpDhViLm
	 91pFuAmQuBB/JwRmzmU7J3mxF79NDLBlI7iZ7hvslx1MMoc0703l5OUTZB1rkRT4xrsgk
	 Qhj7bSz6BEp999r6ebOn61q137LLbvzXqdBlbs/56rvqPk01XCZVNhrxii+xCM7XhMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=msy92rHz;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB8606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=msy92rHz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489579; x=1824025579;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CNvS6NZpBi2ExKWWqB0TBqvrkHvGUS4WxBYlf/EFMF4=;
  b=msy92rHzBWSNAK+JX8RwozrON+xRD6Z8Ola9UoZkBXsVUHbLd+LyQ+9y
   Ur0FHh7+dQBoX5JL2Lfxqg5KgMSZL9/JeZ5diq8U6j0oS3DrAjn/sz+WP
   4eD1B6G3++ws9YJelVCb4b6P+0TftAUC2XI77EIMUWLhFUIp08UvlvT/1
   YwTsVvMy9/mrLCOTQ8lC5lSC3Rb2DRwLK7yWThvICcAE81jOoR1d68aZ8
   FoLnKKBHNTG6QNNfCsyZGfiGhUATj+l891rjGFZUgOB6QfnTtJefzKII2
   HSn79DcX5DyLM2Sc0GWNIrkNOlH4CtbGCeWjl2Uivrm967iR8l2ZlNMOH
   g==;
X-CSE-ConnectionGUID: t/ABjeWXReOMmDqoCvpkYA==
X-CSE-MsgGUID: YQ0oLhNfRCed60Fdot0HyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287914"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287914"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: hpB4KK+yTn2jvR4MltXs6w==
X-CSE-MsgGUID: 3S1EHTnOTtG6al4/GjI2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723910"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:39 -0700
Subject: [PATCH iwl-net v4 08/13] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-8-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=11731;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=CNvS6NZpBi2ExKWWqB0TBqvrkHvGUS4WxBYlf/EFMF4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvETeZQlQl5vzG6KNjkb9SPnV3r1kTUr8/q9W25GL
 a5JlFjQUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESCDBgZXrT/5Wl0808UMHjs
 Xt2Wfl78zdnW340bc1dxvG/9WivUyshwetmBmi05C0sK3/nXn9o0JXraYRvBiNOzEmYLipjFMOj
 xAwA=
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
will be rejected until the PHY timer calibration has completed. Also call
ice_ptp_mark_tx_tracker_stale() to prevent reporting any previous
outstanding timestamps to the stack. Fix ice_ptp_mark_tx_tracker_stale() to
properly check if the tracker is initialized, to prevent a possible
use-after-free on the bitmap.

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
Clearly indicate that timestamping is not functional, and add a note that a
link toggle might recover the device. For the invalid MAC type path
returning -ENODEV, skip this message and log a dev_dbg that we failed with
an unknown MAC type instead.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h    |  5 ++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 42 +++++++++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 25 ++++++++---------
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index d70f022c850b..43a02759a7ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -106,8 +106,9 @@ enum ice_tx_tstamp_work {
  * @offset: offset into timestamp block to get the real index
  * @len: length of the tstamps and in_use fields.
  * @init: if true, the tracker is initialized;
- * @disabled: set to true when new Tx timestamp requests are disabled, such as
- *            while the PHY Tx offset configuration has not yet completed.
+ * @disabled: set to true when new Tx timestamp requests are disabled. This
+ *            includes during E82X Vernier calibration, and for as long as the
+ *            PHY is considered stopped on E825.
  * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
  *                    bitmap register. If false, fall back to verifying new
  *                    timestamp values against previously cached copy.
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
index 6e1f60d7eef7..b7c539f98276 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -808,9 +808,6 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
  * Mark currently outstanding Tx timestamps as stale. This prevents sending
  * their timestamp value to the stack. This is required to prevent extending
  * the 40bit hardware timestamp incorrectly.
- *
- * This should be called when the PTP clock is modified such as after a set
- * time request.
  */
 static void
 ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
@@ -818,7 +815,8 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tx->lock, flags);
-	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
+	if (tx->init)
+		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
 	spin_unlock_irqrestore(&tx->lock, flags);
 }
 
@@ -1228,6 +1226,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_pf *pf = ptp_port_to_pf(ptp_port);
 	u8 port = ptp_port->port_num;
 	struct ice_hw *hw = &pf->hw;
+	unsigned long flags;
 	int err;
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
@@ -1243,7 +1242,14 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		err = ice_stop_phy_timer_eth56g(hw, port, true);
+		/* Disable new Tx timestamp requests */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.disabled = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
+		err = ice_stop_phy_timer_eth56g(hw, port);
 		break;
 	default:
 		err = -ENODEV;
@@ -1307,15 +1313,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 					   0);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
+		/* ice_ptp_port_phy_stop() may have already disabled
+		 * timestamps, but some restarts occur without first stopping
+		 * the timer, so we ensure that new requests are disabled
+		 * here.
+		 */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.disabled = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 		err = ice_start_phy_timer_eth56g(hw, port);
+		if (err)
+			break;
+
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.disabled = false;
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
+		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with err %pe; Timestamping not enabled; A link-toggle may recover.\n",
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
 

-- 
2.56.0.212.g129ede20d986

