Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75117459AE0
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496644; cv=none; b=MaqnKfwVrFNn6AdpeBZvA0xVSP6oQNXGxrmEc6VO0E0xgAceICXPdnZuHM1PRdpYvEAzWUfxjXldK2/YUeICOmgA28roeKzlzyeNQnKAwsynJCv37KALh3n8n3d/RFBTNwxaBJoqhGhU/KuYH4YZ6FO/vP+pDG87dQgHbl3Ad4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496644; c=relaxed/simple;
	bh=IkHLMi7ZDeAnapxCKg8/0hOySKD3g/cb5bFGu/ISyHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp0UkTUyOyhhEApcdwI5Hs8PpIccS757/ftEoyJlzwS6WtfFr1igDRmMNfPQcbpEVvX51jt4pT4Ot3IAau1XzyW+EMTNh8qbi7xCbAB1gcucujpsb/d1YFDXwe1AziJD+JlupkXSSUkOiqIIaiQ0do7jAZ8YtZOCmWqrmqMresE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgKFsLFQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgKFsLFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496643; x=1823032643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IkHLMi7ZDeAnapxCKg8/0hOySKD3g/cb5bFGu/ISyHU=;
  b=DgKFsLFQKz4Fvd3I7DLElviijKIl66wXH6aZzMwOET6LEuLBIQe39a+E
   ZNmawyNKrDMad2r0+UXg2EARw7cQ6Je2LJIEgOlAqRCvg8lXQx5JuqWRu
   8T9H47g9VIx5NNnTSoUF9HblcphuJEfPaBBzxmDySwYqX65ljZwKWR5yA
   48jqF75iUlfyAPA1cmh6zHNhpY+OQ8dM0gSpkbnSGdiXj7mpau0O3sy6z
   XhIsnflYKgxqtjTiRJLQ3NJt1WReQu+GeB14eXYCh/9xUgluzOa0tu0AX
   AvlV+d9angKuaU4H0E4Qhx2qZW75sPx1nYLeivegeSY+xqsN6st56PNBD
   g==;
X-CSE-ConnectionGUID: 0G3jxw0kQEOPk7G8NQY8JA==
X-CSE-MsgGUID: Pz7kTQYeRXOSW9VkCDkWSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294657"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294657"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:18 -0700
X-CSE-ConnectionGUID: 232EsMEQRYeA90/b3QgybA==
X-CSE-MsgGUID: vOrK/KDoRhS92jY0XyIkEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150417"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net v2 07/15] ice: E822: cancel offset verification work during reset preparation
Date: Thu,  8 Oct 2026 14:56:04 -0700
Message-ID: <20261008215614.1987250-8-anthony.l.nguyen@intel.com>
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

The offset verification work task for E822 is executed after a PHY restart
to complete vernier calibration. In the event that either Tx or Rx
calibration hasn't finished, it may still be executing when a reset occurs.

A single PF reset does not trigger a PHY restart, but larger resets (CORE,
GLOBAL, EMP) will initiate a PHY restart.

The ice_ptp_wait_for_offsets() function does check if the driver is
resetting, and will reschedule itself. However, it is possible that a given
execution is already past this check. The function may then fail to access
the sideband queue. It treats failures as a reason to re-schedule and check
again later. This re-schedule will then see the updated reset state via
ice_is_reset_in_progress() and will keep re-scheduling until the reset
finishes.

The larger resets will restart the PHY, canceling any outstanding vernier
calibration and forcing a restart. Preemptively cancel the task for non-PF
resets to avoid doing unnecessary checks while resetting. The task is not
canceled for a PF reset, otherwise nothing would restart the task to finish
vernier calibration after the reset.

Fixes: 95af1f1c4c9f ("ice: reschedule ice_ptp_wait_for_offset_valid during reset")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7f82439c47ee..7cc151b01a13 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-- 
2.47.1

