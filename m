Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061B4908D4
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698519; cv=none; b=bBRg6LwycsFSEozvDk0UHxU+OyCfsENvnfBhlzhK2RUBxhjiK21yAbDz73IuVZS+FwhpOVtckcQ/NC5PFoNJ64Djf8zlQsr8EoHaBXK1Szy/bV0ibyzV4nXIY0JHRfRTE8PQeI9IM1Tzc5tvw39PNlbCHyKAdRfwTgo0h8WpPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698519; c=relaxed/simple;
	bh=iRbwGApC4tmQ0aGWGh+Q2tqfhGKKtnkcYis151rAsVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFrGbU8m4dhuegll3yxpAejKhpaeJOLQndA5os4OVjJxNWyhZIaMD2GpdHNiZxyxb+/x3Y7HiXm6ibAgIcxsYwGej1GO3sgu4UCl7w44XXlqNzuUAUzZYQ0r2/6v7voE0+5Bxshg6fXb5bAue7nFKNmEMXRap4M8C1HbYx4r0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv7M4+RY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv7M4+RY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787698518; x=1819234518;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iRbwGApC4tmQ0aGWGh+Q2tqfhGKKtnkcYis151rAsVs=;
  b=Tv7M4+RYmjU2hXIGpDH/Jm+zaWiKJQSbbi/y03EAAgDPKfI5qN3D1GQp
   aTiki3pU2xfh5DwOi5kEa9tkPPS+xz7XT0WGkzPv27KHn7ORpjPpNj0ra
   5jZBuV2bpSM0Je6b31JdaSIqBCy121f47NQ6+62Z5GHQNDv6mUpT4sPGR
   1ibcMDfdEVOQ0IzmefT/KLVQrKtA7pfHN/B4Ta7wJlDW2uGw5Tv+ATv/q
   lFj7rI4Xv0xLCk0cTxYr9msXkm3Lca5s2ikIaqZC2+AAbn6dAsjmuGLI5
   GabLVCjMbN9j7rtPgxYhLO+Zh3mv6BIFC69Od9FjpsJQApKUdFavFdEMg
   g==;
X-CSE-ConnectionGUID: ZHDvxprvQ+KhsbWBJD2Aqw==
X-CSE-MsgGUID: 7ysvQ4gaTEy2kqZE8nDC6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120448"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87120448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
X-CSE-ConnectionGUID: sbDQ7b/ARTmkbuzrP4ZIGQ==
X-CSE-MsgGUID: fXZGoVnhSjScuNeAXtMCtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264789700"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 15:55:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 25 Aug 2026 15:53:36 -0700
Subject: [PATCH iwl-net v2 12/14] ice: remove unnecessary discarding of
 timestamps after clock adjust
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-12-8223f95d26e3@intel.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=iRbwGApC4tmQ0aGWGh+Q2tqfhGKKtnkcYis151rAsVs=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WbtS1QLpW2rWMhPORVo+nlPrceCP/anC66XZqr3f1
 2p/M17UUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwEReFjMynOWPnXWi/vmCySvL
 0rPa265412hv598S9yHbRb74y5cdjQz/lPsC03ovbjm8Kmn97bwb+3fFxHEIv+ed/83oe3PVX0d
 ORgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index f8ef054ca966..8500e9a5b047 100644
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
2.55.0.814.gc42f45431d0f

