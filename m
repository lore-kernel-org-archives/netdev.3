Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489583;
	b=Xg8wvQ69FIkOjwuUBG2/1XVn73TRY0ne7b1Gs0i9HgFSj5h/5J6WPUyerQCb8UIK9WyI
	 c+zrhmcUxG1jWe4b2e5neaX69hFVxtWra1kS5hbb8ImvQxqSZ9r4bXS6cWOEES6d5xFbz
	 JY4db1bbT0MYh59g1MR3KJA9YDwmF3v8cFY+VzbWZQT1fBuBYW9e3Iu7gOqOvSh5zQu7Y
	 OeMq/1Q7IwNZZec5MAZXRqSU/RPA+NEud5mbMdpqj0KKraHCUZrSFwaqe7dSN6JKIx+Uo
	 eA2iVHdhVsz0hJZjo6LHHjoIWlfYQC6YoYjJgrvJRkse+P0XWvMFaN7Bxbg5ClqCYsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489583;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1rVz2vPekVqUmB8MnE/SgtQq+6Ea8NzH+Fd77I/TO3M=;
	b=tFosxKFb6b+5N0Zblud8Cja1rjZ94g1j7qXfObbzOJWntuB1cLEg3/iiGtHgN7xOLodv
	 tWcX+7rZdXLsiD1ShBqOin4hpyQO3Bcv/GF6P7IY8LmgeFQKw6hdD8iVGkNnVW52EasiY
	 NmlhyKIQMy+ajMlzN/EbkmP/2kgFvwmDlr84F4Vllx/zePaH+ub7LhVu77CijjB/AysIi
	 XRL3R/KPx2fIh7lyVGgqhoB9bGBjMDKezfaFIFB2iP0L0lOYg3bLTpIH1l38mjx9z7Jk7
	 ZMMU9e04WoHvNoUl8PNEcpCgtJPiiIQyG0w9A55MYcDiSnaIn1pDXhgi4zp7Gyjrn9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jG/Csp2Y";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71B606A329
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F71B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jG/Csp2Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489582; x=1824025582;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+4A+RkOHfuJnIvE012toBLBv342m2F6CzT9TMSYTjUU=;
  b=jG/Csp2YYrPiVev0RgAckV/jlnuNrb1HRa2o3dDjlN5ZsA5VcWHX0Wgt
   ML3RCMQxbc/pzcFDIHfFYGMLb1dVxcN/ubQSZ5UYv/SL81sDiYdve6chQ
   T5pI1ElJZ9EmRL9hTzjAE5+vyf5dzjv2hSPvJbrhxYTk9PYt4ULlLIU2m
   xha11YA4aIQqF+5+ljN/5x4mSevz/+zoVHaFYPAFgV379YPCuL8MaXiCT
   XLPv/fRU/tj7xyItOM0WR2ctUvuU6sI3IPC+siv+S1GeSI3vTsNClXVqI
   wtfd3yqstosTcLq5lPoa2GG5JT6tO0Dxa5XgOOyo62T81qWm4A8/aThGL
   A==;
X-CSE-ConnectionGUID: lzXf4QpERrufeGBo+tGI0A==
X-CSE-MsgGUID: wrzHw2SYTE2rVwBDlJ8uTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287944"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287944"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: gFUfSJCpT+GRbxSdONScYQ==
X-CSE-MsgGUID: jPm+MJTKSBSL1FD1kNI0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723925"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:44 -0700
Subject: [PATCH iwl-net v4 13/13] ice: don't clear in_use until HW clears
 ready bitmap
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
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-13-3e30fc9adc73@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13315;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=+4A+RkOHfuJnIvE012toBLBv342m2F6CzT9TMSYTjUU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFgn3mmp1K/9trTL+x2GjrsZ+du2BMqNzXxufzN328
 /9fQd6ajlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYidoOR4XZf03XHavdYnhMa
 zifUb9sePfys6uutf3azNpaGafn98mb4w3VOMPEF7968wtflQo71ohVmEird8VuEC6d0LSovXZf
 JDwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
works.

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 88 +++++++++++++++++---------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b0ea01cfcc4f..c0d056896825 100644
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
@@ -786,6 +806,7 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
 
 		spin_lock_irqsave(&tx->lock, flags);
+
 		skb = tx->tstamps[idx].skb;
 		tx->tstamps[idx].skb = NULL;
 		clear_bit(idx, tx->in_use);
@@ -2766,10 +2787,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
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
 
@@ -2801,41 +2826,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 
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
@@ -2919,6 +2921,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
+	int ret;
 
 	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
 	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
@@ -2928,7 +2931,8 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	    !ice_pf_src_tmr_owned(pf))
 		return;
 
-	if (ice_ptp_tx_tstamps_pending(pf, false)) {
+	ret = ice_check_phy_tx_tstamp_ready(hw);
+	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
2.56.0.212.g129ede20d986

