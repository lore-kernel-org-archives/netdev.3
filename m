Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620809;
	b=cT6UTiTupZbiJ6ZUnf/6PNVficCxokdOfa86A6xsAvyvK+0U8w/uFx/n/DLQNSWyHAtH
	 CYyVLgnAdP11cGuAXAqAI5jv2tV4yNSmQ2sRLuFgGvDAATRMspCGkFhnt0OptNWXG7RKx
	 kewDVa61sYMCt6Ay8oCcfqACKG3hFDmWOSvDdJ60m8aoSCwZD+tRBLRToLHGdKrpiOCZD
	 ZOR8TO9BEKFzb+1AaI/HVdu23RnSFVS5s2SGqGQfusdS+/IlitWUPLKuttjjkl9BiEXrk
	 8DJw63GaK/Vvc2Bav6v19I/vPCw3Id+Cofvi6HQRCStAcmPf2j4pNX8ay/NZuukz7yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620809;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=bi5Gs14L+hwjYefZ1iMRP/5grJ4wrhdqfa7iodgRKIo=;
	b=hQuoQGAiivkay2LKCmrF0LXl3O3ujR3ehmMrS0ijfrOJ3FWIAH+eKQGizizu2AjF3pGs
	 tOvMCylkcqvLhu0UIZKMYb3aAR6P8LmwEY6VToRY/Dke0WWpjnxjvt7en0fziNbb40W2Q
	 zX+v4/BXXA442uLebQEcHff7hw70ry7OASIF6QIgoyuTRXgjbDXxcj8HrlRWQjI02Lg5g
	 3yOfB7m562ALg0/ezwDuR3ntrwTqqojZdZiebxZlENHo8QjUzLFJDjU7YSd+YmKoi7+6X
	 1tf05FGzLfKwnhI6fuo1F9Ug7ovN0HDRAEeHnSFs2ZNXCnPpeKFqx8Ao+niB0O54WgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LtEZWjiT;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DE606A32A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841DE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LtEZWjiT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620807; x=1824156807;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gMF1k/DidLnMG3JitjfEhw+MVWBElnr1lKkht2WKj3o=;
  b=LtEZWjiTp8hp0vl7jMLBZJzMlQX4gzZGEQKnUNRe4xe9706yd5nRKGsI
   Zznu9xaJoT4p21FdQoYCoSCbt/TjT9PRYiZEXc98LlNT3bv3LihsaDaZk
   7mkTknrh9b0k/MLZ67WlSiC7RJaXgYLMAc4YCcgXf9rSryl48vqD0A4XV
   LQK5+ghF6RSLRUs3NZcAK5H6u6hvvE4H9boHMbTLaSk7CkNtu7k0aA39K
   Safmt6DrHfRLmeS21nUTx8ELNiQqKT7d5RFGXf785UOao+4ZwK0/UeZyG
   SQSbV5/R2L+9Xlf7QdbySqkOzf2SlQ+ZhCcoLC0P2WDltx5xdwkz4MKSY
   w==;
X-CSE-ConnectionGUID: VGtsNa6CQ4eIB5m0W1HGEA==
X-CSE-MsgGUID: DEN1W6BPTAqRyX4/J1RbDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363199"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1363199"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:12 -0700
X-CSE-ConnectionGUID: 6T1advJjTDKD82at5XO3Zg==
X-CSE-MsgGUID: TDmTPoNIQ7ObNB74MPWxgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3275478"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:11 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Oct 2026 15:12:52 -0700
Subject: [PATCH net v5 07/13] ice: E822: cancel offset verification work
 during reset preparation
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
Message-Id: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-7-72289a4ac8eb@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqybFh+erPwax+ndHsbctvm1efvi+7L7vrwRXnTEemOpL
 ctZtWfeHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkTzvDP42Oax/kLSuUCzcX
 3zp1Ys+i0DDVTauc96leNt6wyzaxZCPD/4TmxJCnc9KiOvrMVvh9SJ0kFR4QIjHj9sZtCb/21+1
 L5AYA
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

