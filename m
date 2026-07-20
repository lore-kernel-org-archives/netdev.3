Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DB3FFFAF
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548801; cv=none; b=fGtlvUbEciuMwVhejDHb7FVwSv/RA/stlD99i7CDL+t8+yOqVvQhb+nE6i8tC77D0a0QGJjbd04enB1FK8Nb3FSQjMvzWg8vzpqYu8Oj6McY+Yuw/Mg57fHjh+oplHpjqg3N2El73USWN9a5tnbur5yUtY5lB9XR4t16LUwSua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548801; c=relaxed/simple;
	bh=Ps/3r+DGIS5f0w6yq40Tm1HkyRmExGtUJeU3P2xhp6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cck/YxWrjMzQleT9mubDbp7I6gq5Q8EXK47qI4+fVjGtzUTgJJRdmK/T2zP3p77f3czLnO4VudLSx5npn6A5YQILbTH4m2fZCUiIjVOmJ3ET1x6sbdeJOIEoHswMhXAqwHX5eNhb92lAyZxrA3PoZaMr2gbQiQAFhUptfVgFrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqsUr50G; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqsUr50G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784548800; x=1816084800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ps/3r+DGIS5f0w6yq40Tm1HkyRmExGtUJeU3P2xhp6k=;
  b=RqsUr50GlUa9L0QEcL0RhqYPKpWwjFCGmxAurpP78b1H99qOQHPsxC8q
   qH4aHZcMsvRWh44U2/t3s5kTwGfepu6N2gPTrGzJBJ3/wTkalnYKlOKLK
   A92PRTV549+YhHCojb2xzWttr81/PhvC2yFlkXzrNZGuy8n5uJIBT1qaw
   G1FcywsFlj0Soin3M9pbjLEfIrAb0O5uYNfyQliTPsNmEMVhzsdu3Nrsp
   WAGkJl3ycvM1ba3roAny+t9cOnOk8GA3EP2a6NKcjB++uLcRDPOa+FpN4
   VFfEErEpY5Yf+Zx+4xmmVxdcDoSGT1vlOyOGAWNbMUIODQN0W/3728G2T
   w==;
X-CSE-ConnectionGUID: dmpoyAAYSBSq2svZ8NpPRg==
X-CSE-MsgGUID: 4NX8rI66TQinTY96naQlkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85328179"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85328179"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 05:00:00 -0700
X-CSE-ConnectionGUID: 58Jrd2qnRZOccd38VEz6oA==
X-CSE-MsgGUID: sbcuDswiRFOWL/6GD8ghpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="258078406"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa009.jf.intel.com with ESMTP; 20 Jul 2026 04:59:58 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	konstantin.ilichev@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net 3/4] ice: cancel E82x offset verification work during reset preparation
Date: Mon, 20 Jul 2026 14:01:31 +0200
Message-ID: <20260720120151.2675206-4-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
References: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Cancel the offset verification delayed work (ov_work) during PTP reset
preparation to prevent it from running concurrently with the reset
sequence.

Without this, ice_ptp_wait_for_offsets() can execute during a reset,
find that ice_is_reset_in_progress() is true, and re-queue itself in a
tight loop. Meanwhile, the reset path in ice_ptp_rebuild_owner() calls
ice_ptp_port_phy_restart(), which starts a new ov_work. This results in
two ov_work instances running simultaneously, racing over the PHY offset
registers and the calibrating flag.

Cancel ov_work in ice_ptp_prepare_for_reset() alongside the existing
cancellation of the Tx tracker. The comment in the existing code already
documents that ov_work interference during reset is a concern but only
cancels it during ice_ptp_release().

Fixes: 4809671015a1 ("ice: Fix E810 PTP reset flow")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9d9d9958fe5c..e0be88024ac3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3042,6 +3042,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	/* Cancel the offset verification work for E82x before releasing the
+	 * Tx tracker. If ov_work is running during reset, it may issue
+	 * sideband queue commands that will fail or timeout, and may
+	 * reference state that is being torn down.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 
-- 
2.43.0

