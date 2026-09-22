Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048C485503
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100523; cv=none; b=rIA3wFk5QUePF5yEXfRz7cWM3jTWAH5s0fSoWfjhRdmok5vg84spA/5d6cudqrwRfwoXmpxqxUu4qNCnvRsbLaVEvWE0WMKnl3Vkpk47wnValRMbAGkeHQX9QHUr1VcNf+OTM6YgAlsKIjHmkIwGmZ0kR7u/rCUd1R9anS9x8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100523; c=relaxed/simple;
	bh=nhBKKC9PlZjFHhRKBrv7L+A1ebPqPvY5iU2rQPakqGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xfbcw9u+k9Dm4i78CWUGbRP1LW557HMuZDVJe3xNuF7EaHJ0GZr+uL3WVwNIjqPkafBXmuaGAlmx740VpaLDZTskIeazvrp7Sm+kpvVUvFsyZjAdTCRkS8p6HdN+gTbCuLTTKrurIBA4Bts4xIOoAw62uF/XQ3bTDPKvlq0V7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jcpc3Z68; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jcpc3Z68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100521; x=1821636521;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nhBKKC9PlZjFHhRKBrv7L+A1ebPqPvY5iU2rQPakqGQ=;
  b=Jcpc3Z68oCcMeNN2YtGc/PIElXi4CwEBcpgvxl7Jkz9LLliiuCKoLubJ
   WVraFUPZG5DSUk/hSNeaZG0U7MA26Hzu17qS0BdN8++u9GRe08iIiKHXj
   jP5tib1hfctLcT8tc6Ue0bEeOjpjnM13u4nCGsFjMNhLl5uQut1YNxNYG
   pSYW7BUmpLyt2ePBGeerEowI8BwFUP3r//SvK/qNktk3CZRMCDTeuce5q
   esG5TWurBhnrh+vGXCshG3qq4unUqfEhoQ/U/H9ROvSQNW11xR0D37GfQ
   m29z1XOJKb7vvl5J+sBKsSJwA3loaLhwH322PSqanoke2FfVWTm3nBFTu
   g==;
X-CSE-ConnectionGUID: ROstnSGwS9iXHwpyBOnZag==
X-CSE-MsgGUID: iJVxzvilSqeNEvlm6wZ6LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232060"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:25 -0700
X-CSE-ConnectionGUID: KOuG1VJFQiq+ZfjmbzkJ0Q==
X-CSE-MsgGUID: XmgHYqoCRRGJXGjmjfJ1EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315348"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:47 -0700
Subject: [PATCH iwl-net v2 14/15] ice: don't clear in_use until HW clears
 ready bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-14-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=9963;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=nhBKKC9PlZjFHhRKBrv7L+A1ebPqPvY5iU2rQPakqGQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2WdZ23p72icGTwtekG926Szf5eukZ58mzfpWoK10
 fm5jGtLOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIYQ2Gf6b+GSGeLjbijd0t
 z9welTvFX4z/leX0qalQ5u6vWb6ahQz/VP7cyA14YmmeuCK9wot/trS3jPOJ9auO7TzndM+yqlu
 aBQA=
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
hasn't, mark the timestamp index as stale and keep the index locked. The
index will be re-checked once another interrupt occurs (either from a real
timestamp or from the watchdog kick). Marking the packet as stale makes
sense since we know this begins happening when link is going down.

This flow has been observed on E825, but allowing the driver to free an
index which is not cleared would be incorrect regardless of which device
type it occurs on. Thus, this re-read is applied to all device types.

In the unlikely event that a timestamp has timed
out the 2 second wait *and* somehow suddenly has its ready bit set but
unable to clear on read, this could accidentally increment the timeout
counter. It is intentional that we do *not* release the index even in a
timed out case, as we must not allow reuse of that index until we can be
certain it has cleared. Instead, refactor so that the timeout counter is
only incremented after the skip_ts_read label, ensuring that we don't
count the number of timeouts incorrectly. This does mean that a "stuck"
ready bit will be locked *indefinitely* until the hardware reaches a state
where the clear works as expected.

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

In the normal work flows this comes with about a 10-20 microsecond penalty on
the average, and the standard deviation remains similar (with some variance
between run to run comparison).

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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 69 +++++++++++++++++---------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 890c2e8d4ece..e654f8962d13 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -586,9 +586,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
+		bool drop_ts = false, timeout = false;
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Prevent speculative re-ordering of start and skb */
@@ -597,9 +597,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		/* Drop packets which have waited for more than 2 seconds */
 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
 			drop_ts = true;
-
-			/* Count the number of Tx timestamps that timed out */
-			pf->ptp.tx_hwtstamp_timeouts++;
+			timeout = true;
 		}
 
 		/* Only read a timestamp from the PHY if its marked as ready
@@ -624,6 +622,20 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
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
+				spin_unlock_irqrestore(&tx->lock, flags);
+				continue;
+			}
+		}
+
 		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
 		/* For PHYs which don't implement a proper timestamp ready
@@ -640,6 +652,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			drop_ts = true;
 
 skip_ts_read:
+		if (timeout)
+			pf->ptp.tx_hwtstamp_timeouts++;
+
 		spin_lock_irqsave(&tx->lock, flags);
 		if (!tx->has_ready_bitmap && raw_tstamp)
 			tx->tstamps[idx].cached_tstamp = raw_tstamp;
@@ -2818,10 +2833,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
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
 
@@ -2855,41 +2874,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 
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
@@ -2973,6 +2969,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
+	int ret;
 
 	if (!pf->ptp.port.tx.has_ready_bitmap)
 		return;
@@ -2981,7 +2978,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
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
2.56.0.rc0.395.gd1f3524e15dc

