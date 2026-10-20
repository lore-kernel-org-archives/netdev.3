Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489580;
	b=wOHAeNcM2gSU5u1lY1b8ne/fv921FM54pzW48C4tIlcvB8FcDceSP5rHXP6GeqZlt9we
	 219c7IC12hNPaRp/yRx3VotkGUzi7KygNWP2pFrsnV+CNXtOTg9rD2rJmBRU1RDfUNKb5
	 9g8Ky10wssMm4rTgsibGF3QwphHCUH0PNMyeuS1cXQFTH7xipvCvNPOS6jb+VltqIf0zp
	 cY00c7n6G1wjOfHzcynsgY1KqsK4oFGHhUrGopy32BPVVB1oVJmFgrpbKft9knl0AyGze
	 8ClYUH9mO42ZcQovf8jr+pVwVEayycef/9YBIweuixPC11bKzds5sw5eQX5VSQDa0TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=bi5Gs14L+hwjYefZ1iMRP/5grJ4wrhdqfa7iodgRKIo=;
	b=ScTKUtlZWUK678SW4Zqv/kbfkeQRqmbm+z4tHF5N27HDC5jt4sthgaQCmjIKpgsYoyRq
	 2BLZkhAx/rCX87V8GmEEDzbqbHkrLZY7HwreclYZ50BQodXIn3Tj6+ygzgPCpPFWlim9I
	 vW76NMlNUCW54WykXQZrn9BhSmDaXP+WPVEVdEM01H/qgXfxV8nG3UWRnbEUWCB3zMrN0
	 ujMeEV6GTf2EnWpdojDq1crJCLR1OwE0YsWBYELj/k5zlMzXWSDIVUGxGwRc8Ca19vpb4
	 y/fwnAyKd6VNrbxHwReRRm4un17Bl0Sfjdn8mJKraZ/778EUbcypqGT/4AGrxidKNSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c6rT0osP;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F160A2603
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8F160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c6rT0osP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489579; x=1824025579;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gMF1k/DidLnMG3JitjfEhw+MVWBElnr1lKkht2WKj3o=;
  b=c6rT0osPoQFZZ/IuauqCYijxjs75w+WPHZnV/ykVT1cFlA3bGOFcmTJu
   CdgZRaGiGpPfItIjQTAyIfIsFi6dzCaOP8nExdZApqHnNXH0EU4ZYT5So
   SnA1sJ+XwWcTUTKdr441xdBtJtMV0ZCSJ3CwB+wLN+lbjww4hTieIvy+d
   sS4aRSI/LuXGyaAlDhpk6gE0OlhNMlWACv64YylACDr4QSCeaoxkehAup
   x6d25d67oyekUrTIRPK3BcSoV/jN4QDlu98BXlr2BiAJw5g/PcYBxbFSg
   J7BeeehNR/SQq8moqXIdpB8uBZ7j4yx2RVUALI2G5rByy/T8ABO243VtU
   Q==;
X-CSE-ConnectionGUID: 8Y3BEWkcRWmtIfM7vAhB/Q==
X-CSE-MsgGUID: qhLXoYA/TUqX2pwUb+6MdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287908"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287908"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
X-CSE-ConnectionGUID: DLBTuR29QZqsa4Ur6Pb1oA==
X-CSE-MsgGUID: nQwz+hp1SraABujc/B6Caw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2723907"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 20 Oct 2026 02:45:38 -0700
Subject: [PATCH iwl-net v4 07/13] ice: E822: cancel offset verification
 work during reset preparation
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
Message-Id: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-7-3e30fc9adc73@intel.com>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=BsQHBsRuqp/m+YzQChD3xdUG73971POEAmOun7Iz2Q4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzrFvFqFsmqtQ/8Jmk/7KjIj/sburV7813xf+rNdpvWp
 oYYych3lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJGDJQx/5S/lnVVpkTW0ue6n
 dr1ZXWfVMSOulDv+DOm3vRM+JRxpYGTYwvtXqLHIp2Ob7Qnv62HLzolliCYt4ymsaxB7mx54vY4
 VAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 57e2606655c4..6e1f60d7eef7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3004,6 +3004,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	kthread_cancel_delayed_work_sync(&ptp->work);
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (reset_type == ICE_RESET_PFR)
 		return;
 

-- 
2.56.0.212.g129ede20d986

