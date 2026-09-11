Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D0306756
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086892; cv=none; b=RDIMxJ8AsbaKz+bVWxuWWoG41upwwKTCmNjQA3g7T6gP8gwmWGtX3heSkDggbEhCpp9v3r777a6cDMDVtG9eRazH6Uwb9yY12rpbBGRxFUd1i97Lr9VGI+gerSOEkgZAv3e+a/iBsomFugK0waKiijZ9KIc0ZvzGBspPIgU7OcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086892; c=relaxed/simple;
	bh=7z9F/IPUL98xBd0HdBF8s9ZlEdaNvEL6JNRwjbAYB2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUh9bRrPQxBw9Py+x7lZa0qU1rRyqzUYEkp0Guq23lZIIvCjMI8A/X4QtL0kYWG0xt+h36LehjsWyCRiLdA/59A8jpg7BsnA0nXWTKZz9CNSr8wFrCvKz59vPsvM8R2nBBSwoCKUXd3iCiuxNiK0DhVsj+VrCTODKQ4dqBDi21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6qdmYyT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6qdmYyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086891; x=1820622891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7z9F/IPUL98xBd0HdBF8s9ZlEdaNvEL6JNRwjbAYB2A=;
  b=S6qdmYyT1O973ZTUGmdmVlrMnBkpbxjevK56cKEMhHdnf/EXXOQZvtaI
   nBvVbCVQItlWo6uRyiZWJVrUprzyP5tBsqwECXlRLzgmHdIc95VtLermF
   GL9cNaTgIv6g5JqQe0eM6R34IixeA7Y13vdH+DwQfOXvftFSF7i7bA5L/
   6iOwNK/Q2S7KsTwIN8A/IxSFnf925wf4LS2FYHBjFOy7W0wM/7n16jIyy
   m0OTQ2sxtK7QWa6iRc9JtpUUJSypePrKPjSOnSi2fSDcRJoncHNaiYo9X
   +uRODWNkZzUDFc4QtNLOBes50udI1j8pTHG6BCYhf/k4anp6k06oQF4X/
   w==;
X-CSE-ConnectionGUID: 7zPBLdFhS++Hb0chVmVwOA==
X-CSE-MsgGUID: Npgs2pjpTkOFyq3J1K0hmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564734"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564734"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:44 -0700
X-CSE-ConnectionGUID: 7KaKOPDnQKyNr+Y/4gtvBA==
X-CSE-MsgGUID: Hube50FdRS2ZuGA4Z66Phw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291083"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 10/15] ice: wait for in-flight Tx timestamps before flushing the tracker
Date: Thu, 10 Sep 2026 17:34:19 -0700
Message-ID: <20260911003430.3386340-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
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

Wait up to 10 ms for in-flight captures to publish their ready bits
before flushing, so the flush clears them together with the rest.

Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4dec728e219d..b142b779dc10 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -740,6 +740,37 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
 	return 0;
 }
 
+static void
+ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(10);
+	struct ice_hw *hw = &pf->hw;
+	u64 tstamp_ready;
+	bool pending;
+	u8 idx;
+
+	if (hw->reset_ongoing)
+		return;
+
+	do {
+		if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
+			return;
+
+		pending = false;
+		for_each_set_bit(idx, tx->in_use, tx->len) {
+			if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
+				pending = true;
+		}
+		if (!pending)
+			return;
+
+		usleep_range(500, 1000);
+	} while (time_before(jiffies, deadline));
+
+	dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
+		tx->block);
+}
+
 /**
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
@@ -756,6 +787,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
+	ice_ptp_wait_for_tracker_drain(pf, tx);
+
 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
 	if (err) {
 		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",
-- 
2.47.1

