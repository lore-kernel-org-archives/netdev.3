Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499826980F
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357711; cv=none; b=QuYnvFofu1adglklUSa83BNAxB2jGFvMLrDp6mS5UTdISazv2DBEBW0WhTKlEWcWDxUqKSJlskMASEw5430HNg8mEhmL59piEWgAX+/6MoBCPPedFEDBDJLPqM4f4b6+7BWejx43s63YxCAII6gGkpNN64jFUAfqNiN30W7NBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357711; c=relaxed/simple;
	bh=uA66S9LgWH4Cu3mjCRofvh4OAjJNVg8vbR9+NSJQuH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7aB1mt2TNH2yCasqhwktEyk5hHnyLopF1IlWI+sbcnQ14K+8l197ESDLl6+ttP+UCrTzhju0rw0WFpP4dqMsm5CDxgFIvCNIg35lWDTTpnzTNGZ75KmzjWjY1JYoVizWTgLipHBDbMiwF/LAkglzSDO9U7IKG0d5/jwxraTHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmUJ/0vE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmUJ/0vE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357707; x=1818893707;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uA66S9LgWH4Cu3mjCRofvh4OAjJNVg8vbR9+NSJQuH0=;
  b=YmUJ/0vEV1+hG1+qLO6JNiPhTLdSF0vnftBTmTGEG5YCozDCTshw9GeG
   PL8MXvp8hoV4c/MsN+h/JdDCo3eK6VFy5NzK26QOUJtpuwlXgUiw5koln
   QG77yYbCMZFPmO9Pdjsyu9wIdVVwKaI5I4FZnbwtgFLgHd25gtpN2BsF0
   z2ID6Zv1iJUFBTzUMQ5Nh49d0nH0ulPvaZuCr2DyoBGmX0P1NxLVUOSA/
   fFpu8ZGfXUtuOi4YwU/FstTILBYPHa89qfhStVLw6739y3XXul1Izst6i
   GIl4MA+286G2lO/dsV/uFAL/miA9UM5CP0lcZrwEAORa8XQHEgD1ylpMn
   A==;
X-CSE-ConnectionGUID: PiR9rUGmTmal+Dx7GOe7nA==
X-CSE-MsgGUID: oWL8WvCyQJmawZLc8AbAdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584784"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:15:00 -0700
X-CSE-ConnectionGUID: 2iLgpgbpQjSFgw4Gkt32hg==
X-CSE-MsgGUID: NJfPlO0SRheqTUYngJAN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836492"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:15:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:15 -0700
Subject: [PATCH iwl-net 10/12] ice: remove unnecessary discarding of
 timestamps after clock adjust
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-10-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=4007;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=uA66S9LgWH4Cu3mjCRofvh4OAjJNVg8vbR9+NSJQuH0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl78v1Zul7ftwe/pXJ8fzJhdal6T7vGGMVlzaG7sz7
 rGYsOW2jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYi94iR4fh/zROnZ4funHuu
 seVr8LQtf37UFrLFVbl8M9oxs2n+wdkM/6P4Chbvs9L6F1ihes165425kzduzu54l+XbzzOX8cZ
 pbnYA
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
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1a9bf8839404..8c2dd83d8d6c 100644
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

