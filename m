Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66357F735
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091511; cv=none; b=DsVtD2nkBr1bYf5wHUso8ug6eYbcaevAGzFnpy59yI7092XZNlU52dJ3Wqbuj6s/oqFwqTE3PhbouW3nBMWJDGS/034lgLYeTqMiRAcSF5dUMn7AQD5dunuFKAhwEOlrTFehTDpWt5pOSbZy1vAaG1SSRlgX+Xe3jzSjnP1sP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091511; c=relaxed/simple;
	bh=wa+OIdOkitId2/tfZD+w2Vh7uvE5DYF208ajO7Sz1kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI8AtytTkSwk8s3kyA+foEE8alsvSoUXQjDpBnE888a0BUOWVJXm+poizoGyS4nAQmBklnTGDJzHtUm4MH218vcTv0TtuCDd7goJIjQg3bw76GsyXchhAxqTpnXP7yEg0yCcbja568RoUDR5AQP76TmyvgsmsMKPYMQ651uBgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co0eQxst; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co0eQxst"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091502; x=1823627502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wa+OIdOkitId2/tfZD+w2Vh7uvE5DYF208ajO7Sz1kE=;
  b=Co0eQxstrQykHCp8FBQN/cto2F5nBpNfVO9e2DktcBa6Qjxsojy4yrzO
   wy0sNaSd4IgiSQPcgZXTZNt6q9K1P+hdo1uaL3wlwotXz4k0btIz8Y4p9
   jEIFlD7o6/yd1ENtrsFwWAEscc/WsIORoZsOJSQj4oJrw501eIOUPbs7U
   G/6EpGI4+C4h1Dy1Ai5+tUiVQKG3X5tTT/vxGNKgVtp7RJDKGP7enW+Nu
   I4MJ+MV+Oul1OqgpPXOCgaNMLCipNoskvTfem1XxZoG7R87ehtZrib33c
   jRollXfjtNpZOQJMZTmtEF9DSHkyrMy9Q0hvW6RmSvPmaTXTwCG1fDRlC
   A==;
X-CSE-ConnectionGUID: d7nvLtnYQQ2zh6xv6IvbsQ==
X-CSE-MsgGUID: 0jrLo3SxQeuOwyAtpCeeFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765633"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765633"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:17 -0700
X-CSE-ConnectionGUID: Usa8mEGsRx2mT9YhTaRNyA==
X-CSE-MsgGUID: gGnsP2aIQf6USTKQKxsbKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078531"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:17 -0700
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
Subject: [PATCH net v3 14/14] ice: don't clear in_use until HW clears ready bitmap
Date: Thu, 15 Oct 2026 12:11:00 -0700
Message-ID: <20261015191102.1174111-15-anthony.l.nguyen@intel.com>
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

During a link down transition, there is a small window where hardware
does not properly respond to reading the PHY timestamp registers. When this
occurs, the PHY does not automatically clear the ready bitmap or the valid
bit for the timestamp. This begins happening slightly before a link
transition even before the firmware has notified the driver of the state
change.

The driver happily completes the timestamp, releasing the in_use bit. This
allows another request to reuse the bit potentially reporting an invalid
stale timestamp. Additionally, with the ready bit still set high the driver
continues to re-trigger the IRQ and check for timestamps in a tight loop,
wasting CPU cycles.

To fix this, re-read the PHY timestamp memory status after each read of a
PHY index. Double check if the hardware cleared the index properly. If it
hasn't, mark the timestamp index as stale and keep the index locked.
The index remains locked in software, and will be re-checked the next
iteration through ice_ptp_process_tx_tstamp(). The driver will still see
the ready bit set, and will re-read the timestamp. Once the hardware link
down phase has completed, the read should clear the ready bitmap. Note that
it is expected that a read to the timestamp will either clear the ready bit
or be blocked and leave the ready bit stuck.

Marking the packet as stale makes sense since we know this hardware
behavior begins near when link is going down.

If the ice_get_phy_tx_tstamp_ready() fails, treat it the same as if the
hardware hadn't cleared the bitmap. Continuing here is safe since the
ice_get_phy_tx_tstamp_ready() device implementations do not update the
output parameter except on success. Note that such "transient" errors to
access the PHY may result in locking na index for two seconds, but this is
expected to be extremely rare and unlikely to trigger in most production
environments. This is the simplest approach and avoids risking a potential
reuse of the stuck ready bit which could lead to reporting garbage data.

The extra reads of the timestamp ready bitmap are saved in the same
tstamp_ready field. This effectively updates the ready bitmap for all
timestamps remaining in the loop. This is safe, and actually increases the
chance that a given timestamp will be processed by the loop in the event
that a timestamp completed after the initial read. Update the comments to
remove some text that might imply otherwise.

This flow has been observed on E825, but allowing the driver to free an
index which is not cleared would be incorrect regardless of which device
type it occurs on. Thus, this re-read is applied to all device types.

In the unlikely event that a timestamp has timed out the 2 second wait
*and* somehow suddenly has its ready bit set but unable to clear on read,
this could accidentally increment the timeout counter. It is intentional
that we do *not* release the index even in a timed out case, as we must not
allow reuse of that index until we can be certain it has cleared. Instead,
refactor so that the timeout counter is only incremented once the index is
released, (after the skip_tx_read label). This ensures that we don't double
count timeouts or count them prematurely. The "stuck" ready indexes remain
locked *indefinitely* until the hardware reaches a state where the clear
works. Also make sure to count Tx timestamp timeouts if we flush a
timestamp that waited for >2 seconds but had not yet had its index cleared.

Stale timestamps are already ignored by the ice_any_port_has_timestamps()
function. However, the ice_ptp_tx_tstamps_pending() function also checks
the ready bitmap. Instead, modify it to only check the software tracker.
Additionally, stop re-triggering the interrupt from the IRQ if the
timestamp tracker is calibrating or has the link marked as down. Continue
to check the hardware ready bitmap from the watchdog to catch cases of
unexpected timestamps.

With these changes, the timestamp processing no longer triggers a repeated
spamming of the IRQ during link down events where timestamps get stuck as
the PHY transitions to link down. Once link is restored, the PHY will be
reset and the stuck timestamps are cleared.

Measuring CPU utilization of the miscellaneous IRQ thread function during
timestamp storms near a link reset shows that this prevents the spikes
caused by the "stuck" ready bit. Without this fix, the CPU handling the IRQ
becomes slammed due to the IRQ re-triggering logic.

Measuring latency using the ice Tx timestamp traces does show that this fix
comes at a latency cost. Latency is measured using the ice Tx timestamp
traces for the request to completion time. I measured a couple of different
workloads both before and after this fix:

 * ptp4l using a profile with ~16 SYNC messages per second

    before: 189.71 microseconds mean, stdev 43.24
     after: 195.92 microseconds mean, stdev 25.28

 * a C program generating 16 timestamp requests every 10 milliseconds on
   two different ports:

    before: 457.11 microseconds mean, stdev 180.63
     after: 717.77 microseconds mean, stdev 321.58

In the normal work flows this comes with about a 10-20 microsecond penalty
on the average, and the standard deviation remains similar (with some
variance between run to run comparison).

For heavy workloads with many more timestamps than expected for typical
applications this comes at a significant cost. This is because we handle
all timestamps in a single thread. If there are many concurrent timestamps
being requested at once, any which use the later slots on ports later in
the port list will take much longer to be processed once the interrupt is
fired. Since each timestamp now requires an additional PHY register access,
this cost is much higher in the case where the device is under unusually
heavy load. The high standard deviation indicates a very high variance in
timestamp latency, with many timestamps completing in the usual time but
some taking significantly longer when multiple timestamps are outstanding
in a single IRQ.

Ultimately, *correctness* is more important than speed here. Additionally,
we still remain well below the default limit of 10 milliseconds that ptp4l
will wait before complaining about missing timestamps.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 106 +++++++++++++----------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a9658f859c2e..74e0c0138c50 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -557,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
  * extremely unlikely that a packet will ever take this long to timestamp. If
  * we detect a Tx timestamp request that has waited for this long we assume
  * the packet will never be sent by hardware and discard it without reading
- * the timestamp register.
+ * the timestamp register. Note that in the unusual case where the PHY
+ * continuously fails to clear the ready bitmap index, the slot may remain
+ * locked for more than two seconds.
  */
 static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 {
@@ -586,9 +588,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
+		bool drop_ts = false, timeout = false;
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Paired with smp_mb__before_atomic() in ice_ptp_request_ts()
@@ -600,18 +602,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		/* Drop packets which have waited for more than 2 seconds */
 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
 			drop_ts = true;
-
-			/* Count the number of Tx timestamps that timed out */
-			pf->ptp.tx_hwtstamp_timeouts++;
+			timeout = true;
 		}
 
-		/* Only read a timestamp from the PHY if its marked as ready
-		 * by the tstamp_ready register. This avoids unnecessary
-		 * reading of timestamps which are not yet valid. This is
-		 * important as we must read all timestamps which are valid
-		 * and only timestamps which are valid during each interrupt.
-		 * If we do not, the hardware logic for generating a new
-		 * interrupt can get stuck on some devices.
+		/* Only read a timestamp from the PHY if it is marked as ready
+		 * by the timestamp_ready register.
 		 */
 		if (tx->has_ready_bitmap &&
 		    !(tstamp_ready & BIT_ULL(phy_idx))) {
@@ -627,6 +622,27 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		if (err && !drop_ts)
 			continue;
 
+		/* verify ready bit cleared */
+		if (tx->has_ready_bitmap) {
+			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
+			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
+				spin_lock_irqsave(&tx->lock, flags);
+				if (test_bit(idx, tx->in_use) &&
+				    !test_and_set_bit(idx, tx->stale))
+					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
+						ptp_port->port_num, phy_idx);
+				skb = tx->tstamps[idx].skb;
+				tx->tstamps[idx].skb = NULL;
+				spin_unlock_irqrestore(&tx->lock, flags);
+				/* Free the SKB immediately since we're never
+				 * going to report a timestamp for the stale
+				 * packet.
+				 */
+				dev_kfree_skb_any(skb);
+				continue;
+			}
+		}
+
 		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
 		/* For PHYs which don't implement a proper timestamp ready
@@ -643,6 +659,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			drop_ts = true;
 
 skip_ts_read:
+		if (timeout)
+			pf->ptp.tx_hwtstamp_timeouts++;
+
 		spin_lock_irqsave(&tx->lock, flags);
 		if (!tx->has_ready_bitmap && raw_tstamp)
 			tx->tstamps[idx].cached_tstamp = raw_tstamp;
@@ -653,8 +672,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			drop_ts = true;
 		spin_unlock_irqrestore(&tx->lock, flags);
 
-		/* It is unlikely but possible that the SKB will have been
-		 * flushed at this point due to link change or teardown.
+		/* The SKB may have already been freed such as due to failure
+		 * to clear the ready bit, or being flushed due to link change
+		 * or teardown.
 		 */
 		if (!skb)
 			continue;
@@ -849,14 +869,20 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
 
 		spin_lock_irqsave(&tx->lock, flags);
+
+		/* Count the number of Tx timestamps flushed */
+		pf->ptp.tx_hwtstamp_flushed++;
+
+		/* Also count timeouts if we flush a request that timed out */
+		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ))
+			pf->ptp.tx_hwtstamp_timeouts++;
+
 		skb = tx->tstamps[idx].skb;
 		tx->tstamps[idx].skb = NULL;
 		clear_bit(idx, tx->in_use);
 		clear_bit(idx, tx->stale);
-		spin_unlock_irqrestore(&tx->lock, flags);
 
-		/* Count the number of Tx timestamps flushed */
-		pf->ptp.tx_hwtstamp_flushed++;
+		spin_unlock_irqrestore(&tx->lock, flags);
 
 		/* Free the SKB after we've cleared the bit */
 		dev_kfree_skb_any(skb);
@@ -2839,10 +2865,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 		if (!tx->init)
 			return false;
 
-		if (in_irq)
+		if (in_irq) {
+			if (!ice_ptp_is_tx_tracker_up(tx))
+				return false;
+
 			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
-		else
+		} else {
 			return !bitmap_empty(tx->in_use, tx->len);
+		}
 	}
 }
 
@@ -2874,41 +2904,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
-	struct ice_hw *hw = &pf->hw;
-	int ret;
-
-	/* Check software indicator */
 	switch (pf->ptp.tx_interrupt_mode) {
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
-			return true;
-		break;
+		return ice_port_has_timestamps(&pf->ptp.port.tx, in_irq);
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf, in_irq))
-			return true;
-		break;
+		return ice_any_port_has_timestamps(pf, in_irq);
 	default:
 		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
 			  pf->ptp.tx_interrupt_mode);
-		break;
-	}
-
-	/* Check hardware indicator */
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
-			ret);
-		/* Stop triggering IRQs if we're unable to read PHY */
 		return false;
 	}
-
-	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
-	 * available, 0 if there are no waiting timestamps, and a negative
-	 * value if there was an error (which we checked for above).
-	 */
-	return ret > 0;
 }
 
 /**
@@ -2992,6 +2999,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
+	int ret;
 
 	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
 	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
@@ -3001,7 +3009,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	    !ice_pf_src_tmr_owned(pf))
 		return;
 
-	if (ice_ptp_tx_tstamps_pending(pf, false)) {
+	ret = ice_check_phy_tx_tstamp_ready(hw);
+	if (ret < 0) {
+		dev_dbg(dev, "Unable to read PHY Tx timestamp ready bitmap, err %pe\n",
+			ERR_PTR(ret));
+		/* Don't trigger an IRQ if we are unable to access the PHY */
+		return;
+	}
+
+	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
-- 
2.47.1

