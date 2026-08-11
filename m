Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E93502A8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489872; cv=none; b=Byyo0YXvAmBH4QwPYSToMKSq0JUydDLrM/uN4MDUUSaxKlTmhfy/QaJB6tWhnLYx20EEnTy7fX9hrcrYeesz3tD2tYNToYALmjZtp+Km/lyYMQwAYedF/+AyFExRxZGIf390BBhOPPriSqDU0egWACoz2xTpGKCCSwxgni1NaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489872; c=relaxed/simple;
	bh=YtQIHTEzC7RyWvUtVZaWiSAzCYcMdIK+HtzcnYnM1Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNnfA7tVACKouCdMUcSVrI9KKGcB5LZVqThHm14L9v0yODTwF3jtt3ZXBdaiDGZS4fhEh42uqc6GHUhjnxM5NobS7s61D+ZCXO4nywavcMNrJDslRm0+u9joOCw5EjpkC+ABuhdS7aTwY34xzVo3gY/98SSaNnhUTdO9Ua/KdDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMl2I3Xu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMl2I3Xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786489869; x=1818025869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YtQIHTEzC7RyWvUtVZaWiSAzCYcMdIK+HtzcnYnM1Yg=;
  b=IMl2I3XupUESE++X2J7YCdGrudiWghbFz2SIf6IVCJQg9dfoU97iJypS
   chn6gRNIguleJ0s19xXRoo12vk1ZxBr0uvEC4DCpT6XDonZjU36BgZ1/n
   S7eymkdTygNhTaco/GG8nqhhYYWNq5Tuwq0ppYYEySijcuFOKVFIpMGwO
   PmtsjLJsjpCLGQ/EWQCBbzfei/+2Yo3S4zjbuWvKga/fhUnAqYY7YjiO/
   ibGrdvv8gg+l3RFZtMkNVnsF6BrmdQaSPJuZTBNqoEVJLkUAwjrCVt4Rk
   X3PWtdSXeBYY29meQllM1/OXnBo6j+u9se27mGn7zrfCzlZZhI/6NXfZQ
   w==;
X-CSE-ConnectionGUID: Hhl/9LiLRHefaXVlsBgZyw==
X-CSE-MsgGUID: qzbGB+sRTv2u5lbiKNIHnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97626767"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97626767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 16:11:08 -0700
X-CSE-ConnectionGUID: jvgS1nFXQCG89mNUgqdpXw==
X-CSE-MsgGUID: mPbTl7fjQ/K5Inv8TJgrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="293401722"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Aug 2026 16:11:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Maciek Machnikowski <maciej.machnikowski@intel.com>,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-net] ice: Recalibrate PHY after settime64 on E825-C
Date: Tue, 11 Aug 2026 16:10:56 -0700
Message-ID: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciek Machnikowski <maciej.machnikowski@intel.com>

The PHY on E825-C requires recalibration after large jumps of the
system time. Add missing PHY recalibration also on E825-C.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 84b99cfc5675..bf625b9f4991 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1956,8 +1956,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* Reenable periodic outputs */
 	ice_ptp_enable_all_perout(pf);
 
-	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
-	if (hw->mac_type == ICE_MAC_GENERIC)
+	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
+	if (hw->mac_type == ICE_MAC_GENERIC ||
+	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
-- 
2.47.1

