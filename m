Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47F486B8A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496650; cv=none; b=XAicHcNhrfs4UG6D0KnhC5ctiwMvKn7Kx/s4r345byXdcnjTEG2++Rf9rbkXPIpUWYwdAwmYzwE+spJ2b+jiqgkqzy4JRMFF2a09b+kgGKCtPfCRZ6/f6HPDrN1b4g2ixDfthWQ3YoDmi7zibH0YSsE8MNCzoenpEM69YWJ119c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496650; c=relaxed/simple;
	bh=NCBv/IPDiye5lPnSlsakSu3aBCSxgSD4QjQcBUpZWGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ije79gUmTXrDrCEsKnO7Ccr2a1Dg1TR+cWF2c4DvMSFTccU53PXccpQAdYJSlTI/It0dqfErfy6TwTKInXQ4N8YaCKMpCnvtbKiNrpOywXObGpC6eHIvOFeUSCIW/T5jvRsSpeowYgWh5YwlDlccA8fnLvMrPXaS4zJldIgkGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISedyyJY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISedyyJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496649; x=1823032649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCBv/IPDiye5lPnSlsakSu3aBCSxgSD4QjQcBUpZWGw=;
  b=ISedyyJYT2e1DovKcSFRjRgjsYy6SQePZOerL+Y2qjhEswZPCi6WiM3K
   /zgFDZoAcfFthQm5qTAuKjWXafIUiQaCj28MxQV60LVGYOOc0BecvDGBP
   s4kuv7fJeESDNxJxXMG9iuZtv1DSNHLpwVblKj0ALiZZ+2lvvsAYzTScK
   xJmCcl0KPh5smOr0AJcjQNV/laY6WY2DeUVT6XELKoNn6QrFaB0k4yqCK
   O1VhbQ+li2/J4+3NPmtuUJyRw0AlJYjrOOSktsU3cHprhRy+1E3fq0/zJ
   pJzoLv6qL+gSbIOIq6q5D6GQC29RXL3PP0WAa+kYZVCQI/G4yVAhBASKm
   w==;
X-CSE-ConnectionGUID: i+pJydlQQ1OaRuXqmN9PMw==
X-CSE-MsgGUID: KepI6Wl4SkyjOpIcu0Dh5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294706"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294706"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:19 -0700
X-CSE-ConnectionGUID: Xq5tHigLSdmA6N25jjgZWA==
X-CSE-MsgGUID: 73KdkiTBSwO0TCoHYr7T9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150443"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciek Machnikowski <maciej.machnikowski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net v2 15/15] ice: Recalibrate PHY after settime64 on E825-C
Date: Thu,  8 Oct 2026 14:56:12 -0700
Message-ID: <20261008215614.1987250-16-anthony.l.nguyen@intel.com>
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

From: Maciek Machnikowski <maciej.machnikowski@intel.com>

The PHY on E825-C requires recalibration after large jumps of the
system time. This step is required and is done for E822 devices
previously, but was accidentally skipped due to oversight when
E825-C support was added.

Lack of recalibration will fail to converge quickly as the effective
adjustment requested is not applied properly to the PHY timestamps,
so the readings from the timestamp are incorrect.

Without the fix:
> ptp4l[12591.505]: port 1 (eno8303np0): SLAVE to UNCALIBRATED on SYNCHRONIZATION_FAULT
> ptp4l[12591.951]: port 1 (eno8303np0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
> ptp4l[12592.027]: rms 752851973 max 1102277559 freq -84408798 +/- 53560133 delay  6009 +/- 92308
> ptp4l[12593.038]: rms 91302045 max 136894784 freq +100000000 +/-   0 delay 93700 +/- 24153
> ptp4l[12594.050]: rms 16036314 max 35711594 freq +47433070 +/- 46746070 delay 44899 +/- 45255
> ptp4l[12595.061]: rms 5558880 max 12292103 freq -13092285 +/- 6627317 delay -13499 +/- 6560
> ptp4l[12596.073]: rms 759533 max 1081638 freq +837063 +/- 802691 delay   711 +/- 979
> ptp4l[12597.085]: rms 60485 max 106800 freq +146706 +/- 263535 delay   145 +/- 263
> ptp4l[12598.096]: rms 16428 max 41896 freq -46707 +/- 34325 delay   -40 +/-  34
> ptp4l[12599.108]: rms 3049 max 5356 freq  +5337 +/- 1730 delay     7 +/-   2
> ptp4l[12600.120]: rms  284 max  381 freq   +104 +/- 759 delay     2 +/-   1
> ptp4l[12601.131]: rms   42 max  119 freq   -124 +/- 143 delay     2 +/-   0
> ptp4l[12602.144]: rms   11 max   25 freq    +39 +/-  12 delay     3 +/-   0
> ptp4l[12603.156]: rms    2 max    4 freq    +14 +/-   5 delay     3 +/-   0
> ptp4l[12604.167]: rms    1 max    3 freq    +15 +/-   5 delay     2 +/-   0
> ptp4l[12605.179]: rms    1 max    4 freq    +16 +/-   5 delay     2 +/-   1
> ptp4l[12606.191]: rms    1 max    3 freq    +15 +/-   5 delay     3 +/-   0

With the fix:
> ptp4l[12834.266]: rms 27178238388098 max 30079328952737 freq +479164 +/- 1040869 delay     5 +/-   1
> ptp4l[12834.522]: port 1 (eno8703np0): minimum delay request interval 2^-8
> ptp4l[12835.315]: rms 86919 max 139746 freq +111289 +/- 539214 delay   -35 +/-  28
> ptp4l[12836.376]: rms 5415 max 8884 freq   +579 +/- 22798 delay     4 +/-   5
> ptp4l[12837.429]: rms  335 max  559 freq   -305 +/- 842 delay     4 +/-   1
> ptp4l[12838.471]: rms   20 max   45 freq    +79 +/-  33 delay     4 +/-   0
> ptp4l[12839.512]: rms    2 max    5 freq    +44 +/-   8 delay     4 +/-   0
> ptp4l[12840.545]: rms    1 max    4 freq    +46 +/-   8 delay     4 +/-   0
> ptp4l[12841.586]: rms    1 max    3 freq    +46 +/-   7 delay     4 +/-   0
> ptp4l[12842.637]: rms    1 max    3 freq    +46 +/-   7 delay     4 +/-   0

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8d302b500a39..a5fe05d70461 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2086,8 +2086,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
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

