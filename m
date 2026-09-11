Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360931AF1F
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086897; cv=none; b=Hl34avhq2/aaEpXXfmj/9fXF/qbhaFdioGE+PQxWJOL7Eye6ZiDAoNqMCtoJsSFYe2QCJH9VK+30rOXyQ3+PaVsDOSOZUg0quFlMCxiHDe+vaeZnt9lsNTShnHTKorPc5Vc/5GJqMmekgvyU3AH4gOfWSQJS2OMfPhIrbM9AfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086897; c=relaxed/simple;
	bh=YF28pliL+3jDtbfBBumWE5jewEv/dM8FMSl9MyDdXH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXvhEF2vz1xWVi2Tf94sz6bBP+kTltYDbE5VtHIjkPwS7QRTjs+5DgTBPoLGDNosiNrt8aZZ5am7EVEHv6ynql4a0RAWd8fBhtGuRMAf/BZ3C0yofU4PmxLoskrwU9ez8A6ZESImlFfp6mbjw4VIUMqnwerftO4R6KZe+vIKHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra2fGkKn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra2fGkKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086895; x=1820622895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YF28pliL+3jDtbfBBumWE5jewEv/dM8FMSl9MyDdXH8=;
  b=Ra2fGkKn+q0Sk3B7BDvOnFbeSUfkmXRFu4lzwGnRFkB72oHCyLVlY1ji
   S2mOPlCXlfJUBUklTyJ5pUDeNWbKVRYIhV3OYwAS6mlOY1kXCHrxnnrKs
   R2hoybWtvGHDTGk8ZKVphjDl1pzkj02+LoX9Qw1aQ4kXx/AFPF6fQBFJn
   WmkbrfZC9BDjB3jIVXVCl2qh8Dw26GXoqAKiP8+HEBQ40xjKz9SZivQCo
   sGVI/f2sM1ISMENpJCV1VZr/Gpk+I3y5v2wPY3aQBku+/qLo2WFymjZV+
   iFKxZAfhb4Bd4ELN5JHjqHWbdwb/R0Sa3JaJAWmfGVWxS8HejBh5j+m7p
   Q==;
X-CSE-ConnectionGUID: j5mdLq3PQwe+eA6qCLzLqw==
X-CSE-MsgGUID: ysDZn0OVQny6u7DfVGEGEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564771"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564771"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:45 -0700
X-CSE-ConnectionGUID: YqFr9l/JRZ6PzTbVeJj04A==
X-CSE-MsgGUID: fpefE7hsRMmvFoM8wpMeCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291102"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
Subject: [PATCH net 15/15] ice: Recalibrate PHY after settime64 on E825-C
Date: Thu, 10 Sep 2026 17:34:24 -0700
Message-ID: <20260911003430.3386340-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
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
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 832cc6ad2f90..a5efb0a95941 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2020,8 +2020,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
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

