Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713E569F33
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091499; cv=none; b=U6w4djm1AOMAGJqQtTauXZpNAPWYmq8OvbhFK1tmuiIqojO9Fcyj9/BVsFiHP3c73jQzN2gWClKGoMsK3aOaNEsKn8MkoP9QNh7uLoXnzjBcw4RFDxiWbAP9mWZuNXRc7O4G2Aj48QMpEzybfjtDdD9LMmome3tMHtTA7pyme+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091499; c=relaxed/simple;
	bh=Sw/9gI1iQqaEBf2dge1Jl0RIX0mWopKYeXli5xLXP48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E57c6NqMpwpvl3gNkWCR8/bZSrmznQomqO8KqMCVN6S7byj1i679/C6wVf20U09qOK7/mcF+hc/qTAnw1QZtst8kuBCT2it4Qg9Rm22UZRWf7ru0v8GINgaGx7nyBsIl7ADOotCHnNMK1mfsJ2yjBYAVhrUZ5umcSEh3PgXEs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ8KpSQB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ8KpSQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091496; x=1823627496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sw/9gI1iQqaEBf2dge1Jl0RIX0mWopKYeXli5xLXP48=;
  b=IQ8KpSQB1+l/G6EhDnawnKEf48+lEJYzpN+9csdAPQXO85mirC+C3os4
   wetIhwtLMnPv2Maz+PiXK9Q+l9jYrfpT+WIooDyBIsaAGt5EGLbcBv0z9
   TzuySOWOkiTsOK7wMQpkjUnf9BOqZZ9xEE3UPjiyke6Ycmx1iSDihnu/0
   jDPpREf9o/Ua2hCqWsKQp7gb7ZhWYU11ZHXa/CECXg1n4b2zEbCBK4Scq
   K1itkxVhJwuYaKyMGW591PPiRX6KA/MvnzRvMq3ri40U9IQXAf3bgVBd5
   jKuYMqNdp5DpkmP7D9ONZrNiMsfN2VY3a7TXzOpTuKBCjlw4mtBI8vVAj
   A==;
X-CSE-ConnectionGUID: CoiscBt1QC+labFDqZEDOg==
X-CSE-MsgGUID: /aIx4npzQFqKij2XIZBkIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765608"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765608"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:16 -0700
X-CSE-ConnectionGUID: b81WpwCgRyeWg+XobNb7xA==
X-CSE-MsgGUID: CFU4keJXSUWg89Cb99UXfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078514"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:15 -0700
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
	horms@kernel.org
Subject: [PATCH net v3 11/14] ice: wait for in-flight Tx timestamps before removing the tracker
Date: Thu, 15 Oct 2026 12:10:57 -0700
Message-ID: <20261015191102.1174111-12-anthony.l.nguyen@intel.com>
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

From: Petr Oros <poros@redhat.com>

ice_ptp_flush_tx_tracker() frees every tracked request, but a request
whose timestamp is still being captured by the PHY at that moment is
freed without touching the PHY entry. The ready bit published shortly
after has no tracked owner, and the PHY does not raise another Tx
timestamp interrupt until every outstanding ready bit is read, so
delivery for the whole quad degrades to the periodic work.

Wait up to 10 ms (per port) for in-flight captures to publish their ready
bits before flushing during tracker removal, so the flush clears them
together with the rest before removing the tracker.

Note that the ice_ptp_flush_tx_tracker() function was introduced along with
the original E810 support, but that device does not have a ready bitmap.
Only later devices (E822, E825, E830) have the bitmap and potential issues
with internal tracking. Thus, skip the wait for E810 by checking the
tx->has_ready_bitmap flag.

Only apply the wait to the ice_ptp_release_tx_tracker() call. Other callers
(such as the port restart path for E825) reset the PHY, so any desync will
be cleared immediately, making the wait redundant.

Fixes: 10e4b4a3a3e1 ("ice: check Tx timestamp memory register for ready timestamps")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 32be908373c3..ca581490f3ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -751,6 +751,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+/**
+ * ice_ptp_is_tracker_drained - Check for outstanding timestamps
+ * @pf: Board private structure
+ * @tx: Timestamp tracker structure
+ *
+ * Return: False if there are any timestamps still waiting for hardware;
+ *         otherwise true, including when unable to read the ready bitmap.
+ */
+static bool
+ice_ptp_is_tracker_drained(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	struct ice_hw *hw = &pf->hw;
+	bool pending = false;
+	unsigned long flags;
+	u64 tstamp_ready;
+	u8 idx;
+
+	/* If HW reset is ongoing, we can't access SBQ */
+	if (hw->reset_ongoing)
+		return true;
+
+	if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
+		return true;
+
+	spin_lock_irqsave(&tx->lock, flags);
+	for_each_set_bit(idx, tx->in_use, tx->len) {
+		if (!(tstamp_ready & BIT_ULL(idx + tx->offset))) {
+			pending = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&tx->lock, flags);
+
+	return !pending;
+}
+
+/**
+ * ice_ptp_wait_for_tracker_drain - Wait for PHY to complete timestamps
+ * @pf: Board private structure
+ * @tx: Timestamp tracker structure
+ *
+ * Wait for up to 10 milliseconds for the PHY to complete any outstanding
+ * timestamps before flushing.
+ */
+static void
+ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	bool drained;
+	int err;
+
+	if (!tx->has_ready_bitmap)
+		return;
+
+	err = read_poll_timeout(ice_ptp_is_tracker_drained,
+				drained, drained, 500, 10 * USEC_PER_MSEC, false,
+				pf, tx);
+	if (err) {
+		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
+			tx->block);
+	}
+}
+
 /**
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
@@ -868,6 +930,8 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	/* wait for potentially outstanding interrupt to complete */
 	synchronize_irq(pf->oicr_irq.virq);
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	ice_ptp_flush_tx_tracker(pf, tx);
 
 	kfree(tx->tstamps);
-- 
2.47.1

