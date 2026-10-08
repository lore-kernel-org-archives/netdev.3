Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC56440630
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496647; cv=none; b=G+hDoUJfyjIShNqOrIvmNzzPITz6K2PivH4qbkMUnqBcAbqysVnMl2P8SIR1UZLriCWWSwVBLRb7L2SPKbMjHqRKWRlUWTWlRb/QoJ+qfgDkLcQcMS9QZY3Q0n1yBESVmYbIQOn/8bon4P61i/5NW1+WK73DAgiTg3rgwQwncz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496647; c=relaxed/simple;
	bh=YKrIKBliUpDUNaMnyIw5w5uazZyEhxavcxcBpr6Tm0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDBOLXc3Gvh8+MNHy18LQapLDtSMD2mX10huG/EWhuvxUVpDOz3kj7szyrT9KFil8tBbgckRVs7U8tuhWzuKPPLTiWuwD8JWJ+JcTDYStGyc8SWTUYs/ZhNqN+KWEk1xeJIm0+iPFnMlF5FsoZxba7lRd97k9e/tl44Srfm6bTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtfPCBSa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtfPCBSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496646; x=1823032646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKrIKBliUpDUNaMnyIw5w5uazZyEhxavcxcBpr6Tm0w=;
  b=AtfPCBSaUH76gvcP27D8PJQc7d76ucZ3uZ9ZMa+qW7560g4O7QJSL56C
   QBKd+WZQCczDKvAb9GJyUyEam0Df6R9mCpi7hWwLvQ/nBaXIXKCK0qjt5
   Ju9OiCm5987oYDVLNpS8bmfnJ6E+PCDGsUezHxgPvc7gdgVErnfJcZG5m
   1RFjyEXuvB72q3SHYzu0MnNcSz7PtXEug/YIaTgrzpkq5igfO+izTva8N
   d3pNPxwCA1VEweHNLFa8FavdWvONaQjtNP+MCuS3iGXEVKcHqiCbvM96y
   n/3+q/YMmgK1cpidk/CPqH6Oy3YGX0LKJV/taicm72Ld+4BKlx8qnudn1
   g==;
X-CSE-ConnectionGUID: iS/SMcSbQvS0vDgGpzeeuQ==
X-CSE-MsgGUID: wZ2K/KIvQACQL96gZCYwPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294686"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294686"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:19 -0700
X-CSE-ConnectionGUID: za+zfblwQey76OvCOOz4NA==
X-CSE-MsgGUID: RDsnv3ZzTeadwWy1eHElUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150430"
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
Subject: [PATCH net v2 11/15] ice: wait for in-flight Tx timestamps before flushing the tracker
Date: Thu,  8 Oct 2026 14:56:08 -0700
Message-ID: <20261008215614.1987250-12-anthony.l.nguyen@intel.com>
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

ice_ptp_flush_tx_tracker() frees every tracked request, but a request
whose timestamp is still being captured by the PHY at that moment is
freed without touching the PHY entry. The ready bit published shortly
after has no tracked owner, and the PHY does not raise another Tx
timestamp interrupt until every outstanding ready bit is read, so
delivery for the whole quad degrades to the periodic work.

Wait up to 10 ms (per port) for in-flight captures to publish their ready
bits before flushing, so the flush clears them together with the rest.

Note that the ice_ptp_flush_tx_tracker() function was introduced along with
the original E810 support, but that device does not have a ready bitmap.
Only later devices (E822, E825, E830) have the bitmap and potential issues
with internal tracking. Thus, skip the wait for E810 by checking the
tx->has_ready_bitmap flag.

Fixes: 10e4b4a3a3e1 ("ice: check Tx timestamp memory register for ready timestamps")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 818e2e265a7e..5220de274819 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -744,6 +744,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
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
@@ -760,6 +822,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",
-- 
2.47.1

