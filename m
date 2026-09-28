Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D6503901
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636688; cv=none; b=njlbcsjnuaImAmC/WOtqmiBMsQ9x2rJDmDL71bnIwzmjMqNL6DjQXV8zzHZ0WqX/nLENesITalUAfWJqO4XJ93GuaQNx1axRk6shwgGziSFP8vJ2fBIlfv5f4Lfi5bv6ehw8E1FwvkJT85jEH5KQZwtuPyU8LUNl1mxcus2gU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636688; c=relaxed/simple;
	bh=be80O4Fm018vL7t812I8OiBBQJhShbvoijtYLCW+8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOwSvkObjrZyVcMUYfPHnfZApLVzQLtgWPerdVaqU+y5nzdlDpwgUT6KcbiFpZXF8b3MYxVyvmKbekL0vwG9t+wBZHo85NuNypKr2b6vrLESrJzifb0TpOii+bq2a+fJGm39ASGzl4y/mms+542lPf9/iNo+RVBWm+I2uDq+VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbDywrbO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbDywrbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636687; x=1822172687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=be80O4Fm018vL7t812I8OiBBQJhShbvoijtYLCW+8/k=;
  b=KbDywrbObf+qaNvmA175fnSXvZs0RWz9OQ7d9hwpGmbfxRnRAmgAJhwf
   mVT51jHWj1Z0VIGK7/YZ2mMJiR3/O4rndMlF2LQ+oSXi9Rzfv3XZ8pHCW
   hlSlabaVMVq20evsG1j3QpD2QN0dhtrRO7qSMzhOja/dXiG2DwdMvKQQa
   F9Rxiak6UGetaw8hfOnQGmLFOFy+H6IZplhq1KVJ/d9GdkOCQQsjoFCAI
   NgZdAlvZlkuDr6lKg6abXk2LhLSB1LSmz3BXrq4dm7fuUAm52RA1Yyaqw
   BlX2txokS/ph18vCd2PXqXIoq60JvVEtnmuge1a+2snvbJOiEqOIImUJV
   w==;
X-CSE-ConnectionGUID: eIcN15yfShS7kstOPX8aoQ==
X-CSE-MsgGUID: HLEfXk5DSHy7+3U08eGvVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513290"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513290"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:43 -0700
X-CSE-ConnectionGUID: ntgm5peLSn+ZM4aZ8UvvMw==
X-CSE-MsgGUID: ApwVZzHDTXqPUsMrUiapVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317695"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	luoxuanqiang@kylinos.cn,
	bryan.fraschetti@canonical.com,
	tristan@talencesecurity.com,
	david.butler@appgate.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 5/6] iavf: fix VF stats not updating due to PTP command preemption
Date: Mon, 28 Sep 2026 16:04:26 -0700
Message-ID: <20260928230429.495442-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

Since the introduction of PTP support in iavf, commit 7c01dbfc8a1c
("iavf: periodically cache PHC time"), the periodic PTP clock caching
task always provides a pending admin queue command, causing
iavf_process_aq_command() to always return success and permanently
preventing the stats fallback path from executing, which results in VF
statistics remaining at zero despite traffic flowing.

Fix this by making the stats request unconditional when the adapter is in
the running state, rather than relying on it as a fallback when no other
admin queue commands were processed.

Fixes: 7c01dbfc8a1c ("iavf: periodically cache PHC time")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066b..c0686ad5c411 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2932,18 +2932,12 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
 				iavf_send_api_ver(adapter);
 			}
 		} else {
-			int ret = iavf_process_aq_command(adapter);
-
-			/* An error will be returned if no commands were
-			 * processed; use this opportunity to update stats
-			 * if the error isn't -ENOTSUPP
-			 */
-			if (ret && ret != -EOPNOTSUPP &&
-			    adapter->state == __IAVF_RUNNING)
-				iavf_request_stats(adapter);
+			iavf_process_aq_command(adapter);
 		}
-		if (adapter->state == __IAVF_RUNNING)
+		if (adapter->state == __IAVF_RUNNING) {
+			iavf_request_stats(adapter);
 			iavf_detect_recover_hung(&adapter->vsi);
+		}
 		break;
 	case __IAVF_REMOVE:
 	default:
-- 
2.47.1

