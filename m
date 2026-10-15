Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA41563280
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091491; cv=none; b=tsrMN8NmZqboogvX84/NQVfHNEejLEyDwLEWA/0iSqzcFl3q3skBi94b47JHJVKyQdFJHksvJh0TZb5UFdIO1CgmBVU/dNqm7FVsGuFedoj1vnEqkSgdpR+KfTd62mN9O3lq8wSZhar3Jk+EMTPm7JlA57jGNVVWdCacZjRVkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091491; c=relaxed/simple;
	bh=UQIPNZXGaCwP2b9lkzpH7jaZv9me7meBp+UbZn6Fn0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdm2qmzu478g7mbFrj1SFqq7E7UqZvA3cMgQLA8SDHv4eD7Tzmp0JOwG1rm6xwSUvZu09UN86eWcxkgAioZDVVGnVtYvQ3cF/hY+rqOkXYiJQ55tMI5RJSdXt2i53BHGMfiEPSPle52QzZt35mLiFqXBSFC/X1ipOIbrzmlzGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey1Jw1XN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey1Jw1XN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091486; x=1823627486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQIPNZXGaCwP2b9lkzpH7jaZv9me7meBp+UbZn6Fn0U=;
  b=Ey1Jw1XNv+d/y0xiY6n1K7AJhBDuli0snjKZ8N905aB1L5Uruz48sb7m
   ZV9hlZSEGiDRQeR/Jg7JJvb/Uq7RA2rDIQND4rsdhsErSroSJE/Lubeu+
   cBQsT680XXmB381uwuwaB7gtqqzaF/YpfartyGdaAsw+k9rv6fHcXXxkV
   KUn2rpMEnIiV8gq6na6RVMaqLV+JtUET6A/HFrw6QKXIvD8zZZHkAzOBh
   s34RlX7Cw3NBOzV9ujhOsOuIuecKKc3hUhqhChoWnuR6D33s8pYPov2Cv
   R2RJP7MdaDEp4K/+RXHt5zcERVGlwUJUSfm62FcPN5Vo2yb7BsIxiYuHd
   w==;
X-CSE-ConnectionGUID: 8TA7tYMtS3K9fVXiEtnq/w==
X-CSE-MsgGUID: XHO7lKJdR+Or4LgLF55RwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765582"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765582"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:14 -0700
X-CSE-ConnectionGUID: 5GozeGpRSSCg2LgUS7wVPw==
X-CSE-MsgGUID: y3fjjZsuQimEP1IvPuGv0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078487"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:14 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v3 07/14] ice: E822: cancel offset verification work during reset preparation
Date: Thu, 15 Oct 2026 12:10:53 -0700
Message-ID: <20261015191102.1174111-8-anthony.l.nguyen@intel.com>
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

The offset verification work task for E822 is executed after a PHY restart
to complete vernier calibration. In the event that either Tx or Rx
calibration hasn't finished, it may still be executing when a reset occurs.

The ice_ptp_wait_for_offsets() function does check if the driver is
resetting, and will reschedule itself. However, it is possible that a given
execution is already past this check. The function may then fail to access
the sideband queue. It treats failures as a reason to re-schedule and check
again later. This re-schedule will then see the updated reset state via
ice_is_reset_in_progress() and will keep re-scheduling until the reset
finishes.

However, a device reset will result in the PHY being reconfigured either as
part of the clock owner resetting or due to the ice_ptp_link_change() call
at the end of the rebuild. Preemptively cancel the task to avoid doing
unnecessary checks while resetting.

Fixes: 95af1f1c4c9f ("ice: reschedule ice_ptp_wait_for_offset_valid during reset")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 828d46a73f29..629777380694 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	kthread_cancel_delayed_work_sync(&ptp->work);
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
-- 
2.47.1

