Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC056E072
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091506; cv=none; b=S9Uh84zfTmumNYaLE+zX96YDelTlS4fogcUNmZlimJd5vOHIA80q3+C2z2Ou6lrc6PG5MCkoxaPD68cK/rjzfc0OEk1Cy6VwKfv/pSIqzfLhGQBkJXdaK1Nzkmd9fwfmtp2S9fIt3TV9jPYRn74TRE/XJ/ADkKo53U+BglfzKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091506; c=relaxed/simple;
	bh=PxvNRaAdNkBF5Q0XWgxfrt6CE4oOJGgclQtEXGDhk94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p465uMKCmXW9wUxASPywiDeZd7R6GTYQRVJDDV7+x9ig2Ry7T4BLiXxPTA4ZKEhZm2bDQGB84N/eBSnsS9ax9VaqSwvzbMy5fLvNKktN6tcVzcGh5LTCerFP4KeMtfCEB2Cz+8NXgEAUs2oF0o1Nx0QaroxeOLul8Ov+rBHwcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDxQsw/e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDxQsw/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091502; x=1823627502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PxvNRaAdNkBF5Q0XWgxfrt6CE4oOJGgclQtEXGDhk94=;
  b=UDxQsw/ebqxmgm3PQnUiKGE+Ruunvkc8vpSBVkBvUNcuOGEVDVPPEWdg
   PIizkh5moRawRVxxp1PBi2+dHiRodtcMyAZ4P9F278N5MfNaU7C8ieeFv
   7MnxeXAA398ONw7GcHSX9bYd1K5fnpg/UMzKRLmo+7vwa7RLJJRez1PCt
   dMNKoibokmhw8m1TJo919uYWmLzTlZYdKkjogs2wslEstLrAdtLEsjzQC
   K0HGCnFQbQYtg0pWNJJ+GjAmDDZHX91I1WFdFzuJ3EzByWsCOpYDG/DQY
   njCgVzB1qWqk1oGya/Z8Yqo+MkhRjrf9l4HPAEhNmbHdB3US0wkPoQT+4
   g==;
X-CSE-ConnectionGUID: hC4SOR3wRLqF/0jlp2zCGw==
X-CSE-MsgGUID: YQkeeU2hSuW+bUQy4Bn5vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765627"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765627"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:17 -0700
X-CSE-ConnectionGUID: t34on/3BQBKqhfx79coDiQ==
X-CSE-MsgGUID: D6L7ahocTp6tyNPDhQILQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078527"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:16 -0700
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
	horms@kernel.org
Subject: [PATCH net v3 13/14] ice: skip reading Tx ready bitmap on ports with no timestamps
Date: Thu, 15 Oct 2026 12:10:59 -0700
Message-ID: <20261015191102.1174111-14-anthony.l.nguyen@intel.com>
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 57141e94c570..a9658f859c2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -574,7 +574,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
 
-	if (!tx->init)
+	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
 		return;
 
 	/* Read the Tx ready status first */
-- 
2.47.1

