Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D547F2F7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496648; cv=none; b=oP1aU1nlJ3r4Z1EnTMmBkwmSLnW/s3tlDJXlgSPeGY4lCAEjxghUx5Q6SniOijWpFx/R2CxWnae4gES6otAlxPVTVbg3EikghiX0hyGNNzgSZU/keWA1ZKYXvweuY5Un5nyL1uc83kfaod83M90WVBt+agJ8e+lx6F6f9ooVfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496648; c=relaxed/simple;
	bh=wlDRaTUajiivd99C7n3P5uz5GZVC7qBWlFF+qe7VsbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0QEer8l6xmKozwklfm+ZP6Alz3+IuXUUQm0u6U0PrsAiI4gfpa9HBp7ZhyLfcnxVPsANbXZxgQUhx/rn57/dyPL9cvKGoxsARxfVSAnQEvMWqRejJwssN+8dYD35nl+wvfJI4og4jI+/+PuNqiJe8zdFxZTNXA1Vef9rg3Bf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqEBaicG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqEBaicG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496648; x=1823032648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlDRaTUajiivd99C7n3P5uz5GZVC7qBWlFF+qe7VsbU=;
  b=RqEBaicG46ZFmXMLNv1Cc/ocSVcCg3vf++NdWRPorPmLSyPxjbFnEcY9
   xNtgJbGIO1ISZw47IyF+okI8RSCb3kn5Jn1JL7QAmZNy8SVVw+Ep3ctoi
   QFJP6k7wIu13QBlyUkvQx++REDdS/V6rmTQkIe/ks+a3hjUNexArztEx0
   7MBzwGSBrIRZlQ0f+q4DZXdZ1HlItYVmkWhynXxOSQOTJ3XcJBjZ1pBtZ
   9wreQ0eDPEgVQEETr0GyLE7E0JE4dnvfvJF9qvId0cMh/Jbb6eWDOtum3
   YCWdjNjR/LVfmiZKk/8pD1bEaTfMRDhKgrGkPgcCdb4wNVriSa8U1qZNj
   g==;
X-CSE-ConnectionGUID: RTryOIVWQNqmdyzwLlaWaQ==
X-CSE-MsgGUID: 5rX3vbB+S8imRvOynLY31Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294699"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294699"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:19 -0700
X-CSE-ConnectionGUID: 26H8BfIvTM2SDy8q3V/Tkw==
X-CSE-MsgGUID: eQR4N+M0R/mHOWkBj9xmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150436"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
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
Subject: [PATCH net v2 13/15] ice: skip reading Tx ready bitmap on ports with no timestamps
Date: Thu,  8 Oct 2026 14:56:10 -0700
Message-ID: <20261008215614.1987250-14-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

On E82x devices, the interrupt for Tx timestamps are handled by the clock
owner. When an interrupt with the Tx timestamp cause is fired, the clock
owner PF iterates the list of ports and checks for timestamps across all
ports.

The existing logic reads the PHY timestamp ready bitmap before iterating
the list of in-use timestamp indexes, even for ports which have no
timestamps waiting in the software timestamp tracker. This has a
significant and measurable latency impact on reporting Tx timestamps.

Check the bitmap and exit early in the event that there are no timestamps
waiting on a port. Observant reviewers may notice that the check is done
without acquiring the lock. This is fine, as whether the thread sees or
fails to see a new outstanding timestamp does not affect correctness, only
determining whether or not it should do extra work.

Skipping the check has the highest impact on E822 an E825 devices which
iterate all ports in a single thread, but it is applied universally to all
device types since the extra read is unnecessary regardless.

The average latency of a Tx timestamp is impacted by several factors
including system load, the number of timestamp requests, and some random
factors that are difficult to control. However for comparison on my system
with these changes, while operating ptp4l on a single port with a sync rate
of 16/second:

  Before: mean 317.43 microseconds, standard deviation 34.51
  After: mean 189.71 microseconds, standard deviation 43.24

Of course this level of improvement may not be indicative of a production
setup as one might expect timestamps to be operating out of multiple ports
on the device. However, even in that case an improvement is still likely
depending on the actual timestamp rates.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a5ee8c8edf3d..9dc0b5fa3319 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -576,7 +576,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */
-- 
2.47.1

