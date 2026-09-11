Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172430F52B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086895; cv=none; b=VjFoIt/7bdDTslJeZ+jhOQsJkSTpnd5tDH2+jgmHEimYBuYS011X+ZFbK+TjBZoZIBpgaEWM6bFpBEitVkXv18avoDHprsm4nhKl4CY3Jcuqw6WkIIqVBlBP0NVfhKsWY+TLikqtZ6KW5zsqreLj34W1SEx0lozB2ekewi5X0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086895; c=relaxed/simple;
	bh=bi1Mh2ylCthFSYaQhsb96h28C/8TNF8uvFZTymLVGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfYQmSufrTvyRCwSrG5mKG2ppFlcdMPv9ejWzeSVehaUfDN22d2Ruf9hSTu9Vnnvwtiu5YuhB/beFCahVXXyx2N2ZcnKhmeklYYqULkj0M9cVMIdA2ULkCu59axT6nRXZNJq4s/WJb3f2C6ZfeXGgsdpob2hqW6FzdSTN89/I38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEGGWLpe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEGGWLpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086893; x=1820622893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bi1Mh2ylCthFSYaQhsb96h28C/8TNF8uvFZTymLVGEw=;
  b=EEGGWLpeaK/s88PDsPiaGNzgU7oZvXXip0TWwd4kLr7mUFov/qhvyEJA
   C+n0HX8/bnnG15hd2EdPIygZeMAKvzyjLfdH1sZQfQASeB82R4bHYA+6i
   jYuqzs874V8xSvewlkW3hoz4F9vG58YR6epRjYUVTEoKoXgLbOpRcmS43
   dbUqSNVHMC50Vov/Yu5fgFZpturv0HYCet8RYlTe5nwvo4twfV250Gftz
   uRVErQctFT4ZeuKF1RfXaAAD175AFsZUqtnIwYxn48AqQwxwSzKB7Sdd0
   J3xSzh4gCJdWWNtPh404IrqYXFip/h7Uhlvu53VL3j2yw7n4MWBrl4cuj
   A==;
X-CSE-ConnectionGUID: Wa+KVAe5SG6SUVr37kK0TA==
X-CSE-MsgGUID: cCmk2JvvTOC9g11aSCKtmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564750"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564750"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:44 -0700
X-CSE-ConnectionGUID: v1/EbfHXTlGQ5+4Cn/8spw==
X-CSE-MsgGUID: pv5dSAfCQC6FuyzkIK13Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291091"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
	horms@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 12/15] ice: remove unnecessary discarding of timestamps after clock adjust
Date: Thu, 10 Sep 2026 17:34:21 -0700
Message-ID: <20260911003430.3386340-13-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

The ice driver currently discards any outstanding timestamps that are
happening very near to a .adjtime or .settime callback. This was originally
add by commit d40fd6009332 ("ice: handle flushing stale Tx timestamps in
ice_ptp_tx_tstamp").

The original motivation for discarding timestamps was that extending an old
timestamp using the new cached value of PHC was a problem, as it could
produce incorrect results. The change did not describe what such "incorrect
results" were.

There are no such incorrect results. Extending the 32 bit timestamp with
the new time value just means that the timestamp is reported in terms of
the newly updated and adjusted system clock. This won't produce incorrect
results or problematic timestamps to applications. Either the timestamp
will be extended with the value of the PHC just prior to the time
adjustment (if the timestamp completes prior to the adjust callback), or it
will be extended using the new PHC value after the adjustment. In either
case, the resulting extended timestamp value makes sense.

The timestamp extension logic is very similar to the logic found in
timecounter_cyc2time, the primary difference being that the ice hardware
maintains the full 64 bits of nanoseconds in the MAC rather than being
maintained purely by software as in the timecounter case.

Indeed, I couldn't find an example of a driver using timecounter_cyc2time
which does discard timestamps that occur nearby a time adjustment. The ice
driver behavior of discarding such timestamps just results in failure to
deliver a Tx timestamp to userspace, resulting in applications such as
ptp4l to timeout and enter a fault state. Reporting the extended timestamp
based on the updated PHC value isn't producing "garbage" results, and
doesn't lead to incorrect behavior.

This effectively reverts commit d40fd6009332 ("ice: handle flushing stale
Tx timestamps in ice_ptp_tx_tstamp"). However, the stale logic remains, as
we now use it to inform the driver to drop timestamps which might fail due
to link down.

Fixes: d40fd6009332 ("ice: handle flushing stale Tx timestamps in ice_ptp_tx_tstamp")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 299de9d49423..277d9c77af1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -826,12 +826,10 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
  * ice_ptp_mark_tx_tracker_stale - Mark unfinished timestamps as stale
  * @tx: the tracker to mark
  *
- * Mark currently outstanding Tx timestamps as stale. This prevents sending
- * their timestamp value to the stack. This is required to prevent extending
- * the 40bit hardware timestamp incorrectly.
- *
- * This should be called when the PTP clock is modified such as after a set
- * time request.
+ * Mark currently outstanding Tx timestamps as stale. This prevents the driver
+ * from reporting the timestamp to the stack. This is called to inform the
+ * driver that a timestamp is expected to fail if it was initiated as the link
+ * went down.
  */
 static void
 ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
@@ -1049,13 +1047,6 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
 					   msecs_to_jiffies(10));
 	}
-
-	/* Mark any outstanding timestamps as stale, since they might have
-	 * been captured in hardware before the time update. This could lead
-	 * to us extending them with the wrong cached value resulting in
-	 * incorrect timestamp values.
-	 */
-	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
 }
 
 /**
-- 
2.47.1

