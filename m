Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300134;
	b=q7fAJ/ToRgzUX7f90OOUzQmrEGKXPCz1P3ne0uQriRHMxhRml7eoqcfzrx2QPnn5ysa4
	 bzeg10TG1EmzdVnQm+tsgovqgV5vGLh3Wk/S0sEWQRIt/O3G/LmDJvZ/qunhCLpk7tFUw
	 ytX/aLuAdQkBqg4niIbGox66p2pCYfEp5wDC+iSlbwgbsT0zLIM7PV+WRidACr8Vyz3IC
	 2tjRKUSSc5c5rwvb4c8p+Sd/ETJ/c5mASNFveLUhwEaocpEkCF5d1FW7rS7FUKaOQ8E8x
	 F9OcE6FElTK1B/jO60Y0uiYR/1sgFdd1Uey8eQCKLRy96X/xHty2U9vJhX70UJZHfQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300134;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xROhJbTcx+v8Ks3CDXC/i1ucBzesB2CUr4I2LiMv4vY=;
	b=BqReNU/T9WsYgNkybMT3NOeoOayf0dACXgZ9V4bniYAvjHSiBVl9mBrhZJkHa72LKtKu
	 2owhOFSbY8iOB3fYlJ1nT7FE3gIlhyMT46hX25QzzWVyO5zj+YOH5DQu05TJW6u2PKGa1
	 8DsuStz96X0HdTGkez+Ux4ehTP5J5h78XyHvn5Uunda8U7fJgpF4cbxz30Z5o7Vj8Y0gQ
	 HxpCgAKHaiQEusAs9iBfJD2wMHFVAIQhvnCe2RdvHhIMN3F3mKzyxDcAf7ByY/JtLcJB7
	 i4vFdyUX1kIdf5TEW8EOQatNIakT/c7oDyBltLENH8c1WPLoOdzE3i1c9BjMo1/k0Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ir+aZM9B;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444E606A327
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8444E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ir+aZM9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793300132; x=1824836132;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cxPOhWQWywQHySwakiXQMNc2snIeQBsPxC+oRP2Y8GQ=;
  b=ir+aZM9BPwrN3ZZV1Od058Zb1/w/AchK1fx7Tr+ejRvy9EF8lngh4udv
   gESPm/WNHjPq3bmviOO9JPmTq6pdgSflr/eDojmLw0E4W/oQPHXHxsWMx
   QVBqtekwEDE5TOhkRfWGeffO2bq1C60T4L/H3iJm7LsrBCzt3N2EyMITZ
   G2p2lS7bnv6j/+yBSMz+70K6xZgHWefSSoVealzqgoGJZcaQHoywy3fy3
   Xo2vYRhy1WZee5zM3ARxnv6P6feQ6oqCppP0DanvkpJjgcOdZ/bxSCUyF
   0AhUCXGEsxBEeXDph2HJNaAZjUygbkKIql/IiQNQ5sl5a+d4JS9Ou/Xcd
   w==;
X-CSE-ConnectionGUID: Kb7NPHU6StOER9f6/DNQMA==
X-CSE-MsgGUID: b8tGScLfQke4pbULTqmCYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2147536"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2147536"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:55:30 -0700
X-CSE-ConnectionGUID: AIlRiJjXQaOU/S+od4aiIg==
X-CSE-MsgGUID: sufI0jP6TfSn6WQlpoS4mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5348476"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 11:55:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 29 Oct 2026 11:55:03 -0700
Subject: [PATCH net 3/3] ice: E825: perform a soft reset when starting the
 PHY timer
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jk-e825c-critical-timestamping-fixes-v1-3-72128d1dd928@intel.com>
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928@intel.com>
In-Reply-To: <20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=cxPOhWQWywQHySwakiXQMNc2snIeQBsPxC+oRP2Y8GQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzH0+ZsSWQR7JzVyzLhiZCFa9Qu+9+HQ2/Ps2SqDXLaE
 nBCcP2ljlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaSUs3I0P5CvnvePhMul+8R
 8THNhWml9wOnWn9h/K+ykVVrpuQrI4bfLB/93jjunz5VfeJ5djOJlVN4y+5KpL/UDbDk42CO1FZ
 kBQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index ef59b34ba52d..ee945ce08eb7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
2.56.0.215.g47fdf2208c5b

