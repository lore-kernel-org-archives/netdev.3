Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620820;
	b=wr/VG3rpNLj5sIlZuCrz+P07lhpSLy6YG7Ls0h1Li+DbwYY7FhIr1ChIE5bu9bgC012D
	 Ed0KQzKpzCOtZsiSynXeOUu1e1OhFsb+8ILmKmKAV4FLYH12a6MFnl6STy/R6k8lrhGIJ
	 GoKYpiPwB1SopW67KG3MCRnMSdDd57hDZogbuZnY8P/WPklUJOGA/E/zVLWT1NYmxEfca
	 Yfj3VgH139xDgegWozLVw+CJETusYgcr59Bz8SwjbFB4feYc2b8D+of0BJGvLsmcQfhRC
	 dYOKnNzHIwl2JbYPGTp9ZmiJdRkcbDgat0c3x5k3Ej2ug0z65hSxoOF505OVVHtBPhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620820;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1J9X6X/zEoaFUZhk6t29Awi1oYWyrtCbSnFucSJWgEk=;
	b=h+KQmE5sQdEEdXZXAixGtyaXu7TMFno7mF0jOHiCTqqJq6Br7Hh/REqZVsx6TJ1AmXE+
	 783jJiSi0cry6TIU2Hb1FHQw3wDnJKhWKRSWvbQQfAd//5xTjYUrkmuXF41WvrDtqYQTA
	 EjtKkdYQ4wVQvoyOnyPYHKAnYK8FQIxhJk62/IeL4w1SjgD0Pm5iY37N00BpGOT74iL5U
	 yrvpaaz43Pyk1YK4joQJdIBg3HhCYih1H+RvLmm2dmUMkPtGRzkcFo2YoQ60WdUEi39VN
	 bAIKq9BoX2de7a02LDG0hUUzaOUpRKCHOWBNUFz0qtIFlgS6ig855ppnJmgou+8yO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGL+5bt2;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D6606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGL+5bt2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620818; x=1824156818;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8T/6SgufD9Ytm2r5nDoHRsryONOTFuEJ7Q/8qMg9EWE=;
  b=CGL+5bt2mLckKFu+bKc1Q11jI6WtciREYt9mShyetQ55/bQFr+pdAdgm
   4GYE2JgxDj3DiyFsG5dGTgdOGUe8/1xWEOjyV2F3m52EAzJPu0hLcSmig
   d2mJmjzvbQcvGhirObZsNLPAqyW7A/a4+DxvwzvzF+8x1KEftZVvN9uGk
   o6zzUGgsgo7v1dpg+OXZZdzB2rTIPBdoHYpfkoyxJMGYkcf3awIM4uVdL
   G9LLwpbPaUy/kVICRlWBd9eln0PCdG0NIES77exMZaSC17bLcA445uz7k
   sbyg5z4YxClLOgNZ5+Nfa6DIaTxe1Ee6KD+xEpPLwqLnxim1ebfL1pUf1
   Q==;
X-CSE-ConnectionGUID: VIW0ebXMSLeo79oLYfBTeA==
X-CSE-MsgGUID: CX5VwvRfSsK5y1+td/Cp7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363231"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1363231"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:14 -0700
X-CSE-ConnectionGUID: 68L8iR/OR5+Q3glycrMM3A==
X-CSE-MsgGUID: pTlRfHgHQsOpwsO8GssUgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3275491"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:12 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Oct 2026 15:12:56 -0700
Subject: [PATCH net v5 11/13] ice: keep Tx timestamp slots tracked until
 completion or timeout
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
Message-Id: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-11-72289a4ac8eb@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11467;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sNwINpCP5zWmwZzFCIy/x/0Hiz9jxuDvq+3MiWqKDLk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqybFh9sCzfJnBNZc1z0cPiZS/ZVwd/vRjxr1+CZtulu+
 YnjKW5TO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIrwCGfwqWUabpzxK9K423
 XApLePmhzYdzj32PmFz3t5d75bLquxkZnl6Y3/lh+hvDjVxbpk051K/lWvYirDyU5b/m7yd8ywt
 NOAE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.h    |  8 +++--
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 53 ++++++++++++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  4 +--
 4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 43a02759a7ea..a9c577279023 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -133,6 +133,9 @@ struct ice_ptp_tx {
 #define INDEX_PER_PORT_E82X		16
 #define INDEX_PER_PORT			64
 
+/* Maximum number of timestamp indexes across all devices */
+#define INDEX_PER_PORT_MAX              INDEX_PER_PORT
+
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
  *
@@ -315,7 +318,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf);
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts);
 
@@ -363,7 +366,8 @@ static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	return IRQ_HANDLED;
 }
 
-static inline bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+static inline bool
+ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 910ebdcdde19..125a0b9b260f 100644
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
index b7c539f98276..309fa2877cc3 100644
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
 
-	return tx->init && !tx->disabled;
+	return tx->init && !tx->disabled && READ_ONCE(ptp_port->link_up);
 }
 
 /**
@@ -564,7 +567,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
-	bool link_up;
 	int err;
 	u8 idx;
 
@@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
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
 
 		/* Paired with smp_mb__before_atomic() in ice_ptp_request_ts()
@@ -2759,21 +2758,22 @@ void ice_ptp_process_ts(struct ice_pf *pf)
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
@@ -2786,7 +2786,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (ice_port_has_timestamps(&port->tx))
+		if (ice_port_has_timestamps(&port->tx, in_irq))
 			have_tstamps = true;
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -2799,7 +2799,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 	return have_tstamps;
 }
 
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_hw *hw = &pf->hw;
 	int ret;
@@ -2809,11 +2809,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
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
@@ -2889,7 +2889,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		/* E830 can read timestamps in the top half using rd32() */
 		ice_ptp_process_ts(pf);
 
-		if (ice_ptp_tx_tstamps_pending(pf)) {
+		if (ice_ptp_tx_tstamps_pending(pf, true)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -2911,27 +2911,24 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
  * current timestamp data is read. In rare circumstances, it is possible that
  * the driver fails to read all outstanding data.
  *
- * To avoid getting permanently stuck, periodically check if the PHY has
- * outstanding timestamp data. If so, trigger an interrupt from software to
- * process this data.
+ * To avoid getting permanently stuck, periodically check if there is any
+ * outstanding timestamps or if the PHY has marked any index as ready. If so,
+ * trigger an interrupt from software to process this data.
  */
 static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2d000251b185..b0390f49a5a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5001,8 +5001,8 @@ ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
  * The E810 devices do not have a Tx memory status register. Note this is
  * intentionally different behavior from ice_get_phy_tx_tstamp_ready_e810
  * which always says that all bits are ready. This function is called in cases
- * where code will trigger interrupts if timestamps are waiting, and should
- * not be called for E810 hardware.
+ * where code will trigger interrupts if timestamps are waiting, and which
+ * should not trigger for E810.
  *
  * Return: 0.
  */

-- 
2.56.0.212.g129ede20d986

