Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB34477FA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496649; cv=none; b=EfrPrDELyD3VvYeT+d/JxuoFm7P4nuqhX8oHvU64uVmmVjMaQ1xF3VYWH/BUzuYNMLh+HYTo9qWA0+t4JR92bQS1lr97zEQ4feHhUvIu5MPt1RN+kkQcM168b44BaqD/MsqMxguzT2WJBvGwB9wJ+SIvMqvab/AgSSYCoKdcNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496649; c=relaxed/simple;
	bh=qiIwTNYT3Z7lzB+3mHBrNnA/N7WoeFHswCGk76vrmS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE2NfTuIXpSIFuLjzQKQqTALdfpERp8Uq2BPFiCd3rsqvsHBtaFRIFsYun+vvxqyhqPpCAnQRNGrCcWCSIopiXAMC7VXpRQmaENDRtaz1hgxmSCDKeLpEmFw13BfCAntUDRXkH3LnndbIZWog/5AMY1qwlrnwqPj4Ranrq7Tlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPeG70Lz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPeG70Lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496648; x=1823032648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qiIwTNYT3Z7lzB+3mHBrNnA/N7WoeFHswCGk76vrmS4=;
  b=mPeG70LzNIpLp/x6AoNCL52BlTLBrFUooNDnTP+ApVsRb05e5bXhgvZP
   qEf73TP6+CXyRVHynvulquelVPEhg20gtmUNGSo1kKnBQlEYv2S3W0BxV
   dHJmgbd/cYoS96K1118M+Sb3MOX07H9SYWTeDbKMc75uyMaozPOkqVCWv
   kuJwUHdtpE3V+4bUpAq/NwDXob99cXvHf2Pm0yE1GNXOAWXr8rAFxDXKJ
   TnCrg7OQpRm1pD/K+vhJSb1bHa7GzXVh/H6/a35ghq+oX7FM+k+mNH+vi
   mh/ypnh8yV6+bdLVYegsl+lQwKTBpWXQIMFLKPcVFPq+LdI3+RrQQyue0
   Q==;
X-CSE-ConnectionGUID: 1+e+r2oTQKO0ElaTrvNopg==
X-CSE-MsgGUID: g5BgJGHKQw22nqnWxwz4DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294693"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294693"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:19 -0700
X-CSE-ConnectionGUID: sz0e1p7IS0+ywnyeqqaahg==
X-CSE-MsgGUID: RIpmZsbFTsKsqAwv4L2GmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150433"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net v2 12/15] ice: keep Tx timestamp slots tracked until completion or timeout
Date: Thu,  8 Oct 2026 14:56:09 -0700
Message-ID: <20261008215614.1987250-13-anthony.l.nguyen@intel.com>
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

From: Petr Oros <poros@redhat.com>

When the link goes down the processing loop drops every outstanding
request, and a request whose timestamp is not ready yet is freed
without reading the PHY slot. The hardware completes the capture a
moment later, the orphaned ready bit blocks the port interrupt until
the next link-up sweep, and the freed index can meanwhile be reused
by a new request whose slot the hardware then overwrites. Captured on
a reproducer as ready bits with no in_use owner right after a link
bounce.

Stop dropping on link down. Mark the outstanding requests stale so
their completions are read and discarded, reject new requests while
the link is down, and free a not yet ready slot only after the two
second timeout. This way an index is never reused while the hardware
can still write it and never left untracked while a completion can
still arrive.

Since we're adding a new call to ice_ptp_mark_tx_tracker, notice that the
function previously did not check the tracker initialization state. Fix
this by only accessing the bitmaps if the init field is set.

To avoid continuously re-triggering the IRQ at the end of a processing loop
when we have a stale packet that is not timestamped, modify
ice_ptp_tx_tstamps_pending() to ignore stale timestamps when checking for
whether to re-arm the IRQ from the miscellaneous thread function. Instead,
only count stale packets as part of the check in the auxiliary work thread.
This way we do not keep spamming the IRQ when the timestamp won't be
reported anyways.

To ensure that forward progress is made on clearing stale timestamps, fix
the check for ice_ptp_maybe_trigger_tx_interrupt to properly apply for
devices that manage their own interrupt, instead of only checking on the
clock owner. In the case of a timestamp which never completes, this does
result in one extra IRQ every 500 msec until the timeout. In some sense
this is extra work, but we need to recheck to ensure that timestamp slots
do not remain locked forever, and the software can't reliably know whether
a given index will or won't complete.

Note that E810 does not have the ready bitmap in its hardware. It is
currently excluded from the ice_ptp_maybe_trigger_tx_interrupt() by a check
against the has_ready_bitmap field. This could lead to an interrupt stall
if every single Tx timestamp index slot becomes stale. However, just
removing the check against has_ready_bitmap would be problematic for the
low latency path which currently is not protected against another IRQ
happening while a request is outstanding. That is a pre-existing issue, but
we should avoid making it worse until the path can be addressed by another
fix. The low latency path also completely bypasses the
ice_ptp_process_tx_tstamp() flow. For now, skip the
ice_ptp_maybe_trigger_tx_interrupt() when ts_ll_int_read is set and the low
latency path is in use. The path still has preexisting issues but this
avoids making it worse.

This effectively reverts commit fcc2cef37fed ("ice/ptp: fix the PTP worker
retrying indefinitely if the link went down"), which tried to release an
index before this 2 second wait period.

Fixes: fcc2cef37fed ("ice/ptp: fix the PTP worker retrying indefinitely if the link went down")
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 57 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  8 +++-
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f32041dd8b27..d12952171a99 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3248,7 +3248,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	ice_flush(hw);
 
-	if (ice_ptp_tx_tstamps_pending(pf)) {
+	if (ice_ptp_tx_tstamps_pending(pf, true)) {
 		/* If any new Tx timestamps happened while in interrupt,
 		 * re-arm the interrupt to trigger it again.
 		 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5220de274819..a5ee8c8edf3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -365,9 +365,12 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 static bool
 ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
 {
+	struct ice_ptp_port *ptp_port =
+		container_of(tx, struct ice_ptp_port, tx);
+
 	lockdep_assert_held(&tx->lock);
 
-	return tx->init && !tx->calibrating;
+	return tx->init && !tx->calibrating && READ_ONCE(ptp_port->link_up);
 }
 
 /**
@@ -554,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
  * extremely unlikely that a packet will ever take this long to timestamp. If
  * we detect a Tx timestamp request that has waited for this long we assume
  * the packet will never be sent by hardware and discard it without reading
- * the timestamp register.
+ * the timestamp register. Note that in the unusual case where the PHY
+ * continuously fails to clear the ready bitmap index, the slot may remained
+ * locked for more than two seconds.
  */
 static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 {
@@ -564,7 +569,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
-	bool link_up;
 	int err;
 	u8 idx;
 
@@ -582,14 +586,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			return;
 	}
 
-	/* Drop packets if the link went down */
-	link_up = READ_ONCE(ptp_port->link_up);
-
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = !link_up;
+		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Prevent speculative re-ordering of start and skb */
@@ -875,7 +876,8 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tx->lock, flags);
-	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
+	if (tx->init)
+		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
 	spin_unlock_irqrestore(&tx->lock, flags);
 }
 
@@ -1426,6 +1428,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	WRITE_ONCE(ptp_port->link_up, linkup);
 
+	if (!linkup)
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
 		goto out_unlock;
@@ -2824,21 +2829,22 @@ void ice_ptp_process_ts(struct ice_pf *pf)
 	}
 }
 
-static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
+static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 {
-	bool more_timestamps;
+	DECLARE_BITMAP(tstamps, INDEX_PER_PORT_MAX) = {};
 
 	scoped_guard(spinlock_irqsave, &tx->lock) {
 		if (!tx->init)
 			return false;
 
-		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
+		if (in_irq)
+			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
+		else
+			return !bitmap_empty(tx->in_use, tx->len);
 	}
-
-	return more_timestamps;
 }
 
-static bool ice_any_port_has_timestamps(struct ice_pf *pf)
+static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_port_list *ports = &pf->adapter->ports;
 	bool have_tstamps = false;
@@ -2851,7 +2857,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (ice_port_has_timestamps(&port->tx))
+		if (ice_port_has_timestamps(&port->tx, in_irq))
 			have_tstamps = true;
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -2864,7 +2870,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 	return have_tstamps;
 }
 
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_hw *hw = &pf->hw;
 	int ret;
@@ -2874,11 +2880,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx))
+		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
 			return true;
 		break;
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf))
+		if (ice_any_port_has_timestamps(pf, in_irq))
 			return true;
 		break;
 	default:
@@ -2954,7 +2960,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		/* E830 can read timestamps in the top half using rd32() */
 		ice_ptp_process_ts(pf);
 
-		if (ice_ptp_tx_tstamps_pending(pf)) {
+		if (ice_ptp_tx_tstamps_pending(pf, true)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -2984,19 +2990,16 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	int ret;
 
-	if (!pf->ptp.port.tx.has_ready_bitmap)
+	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
+	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
 		return;
 
-	if (!ice_pf_src_tmr_owned(pf))
+	if (pf->ptp.tx_interrupt_mode != ICE_PTP_TX_INTERRUPT_SELF &&
+	    !ice_pf_src_tmr_owned(pf))
 		return;
 
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
-			ret);
-	} else if (ret) {
+	if (ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 029ee4612d76..7810fefc546e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -132,6 +132,9 @@ struct ice_ptp_tx {
 #define INDEX_PER_PORT_E82X		16
 #define INDEX_PER_PORT			64
 
+/* Maximum number of timestamp indexes across all devices */
+#define INDEX_PER_PORT_MAX              INDEX_PER_PORT
+
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
  *
@@ -314,7 +317,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf);
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts);
 
@@ -362,7 +365,8 @@ static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	return IRQ_HANDLED;
 }
 
-static inline bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+static inline bool
+ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	return false;
 }
-- 
2.47.1

