Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BC360745
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726172; cv=none; b=Da8+KPXnPFhOO5Ae4e4HKF3FDfaMP7ABhJmsqa3EcNt6LPVDeYoJt12/SYN02dV1q0BCLX4jJMJqvSmKtFQOmDHlNJeMkdbysFNiVloStlVGbyrVJtZKCX3kAvAmcZ5ZWrmpksfupGcWXIQLJ216Yu2bAr9ilHuXfNKEoDlG2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726172; c=relaxed/simple;
	bh=2ypBJFZejzl3U8rgI1nHi231EjUtIKg6wLLXZKyeFxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgpe21Ip+N23Fvd6rdvmtztbsyzRzc4oh29qupnJ7eDN83s4XiPN3eilQfGsinJ7cJKENlJyGu08BTMg2Vh63m0Z6b2jX4LA5A+igiRf/M9pwa1P/2niOaGzWK1FfEM3YT2LcWaI3Hp7kknmoXgm35+UUQrP/Rsh6n7E+cNllks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdNIUCoV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdNIUCoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782726171; x=1814262171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ypBJFZejzl3U8rgI1nHi231EjUtIKg6wLLXZKyeFxY=;
  b=gdNIUCoVE79LAf/zAfEvH4xcJSgvfYnpaFigntDjFMzhXNYAp+a/3b1T
   eaeJ//JmBo3g9X6LJgW0pEXNOyeb5dAADiXi4js+JLACRh51jPhgw677E
   bvmyu+k7LPeNocMrDCAdMEn10qvbO+rvBag00tBTZf6XMLIPZzC9pAyCV
   VtYus+2FrMKUpxe2S/mKYsgOIkTtP1HPR/AbOGCHK3sq6vdJk9SQNpegx
   J2hR8PGqblTWZZiRAVgp/Xsh4ZFQ+S7dkSTLk28lcpQkvblStW3B+qEBE
   JoYOIbyQu+MSttumnxgunoaxWtmxN8ldl2L9ge7FxOYI5GumWfCpoI6HJ
   w==;
X-CSE-ConnectionGUID: Nmib/3VORPeRRJbUTvKKiA==
X-CSE-MsgGUID: +mjgZRLmQBGIvnJlq9WWrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="85957302"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="85957302"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 02:42:50 -0700
X-CSE-ConnectionGUID: TfzmJJ1ZQxynJIDPPCckMw==
X-CSE-MsgGUID: NyYvSUMDTPGKIjVs5NZwkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="253815918"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa004.fm.intel.com with ESMTP; 29 Jun 2026 02:42:49 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1] ice: use global queue index in TC to-queue offload
Date: Mon, 29 Jun 2026 11:12:03 +0200
Message-ID: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously index within PF was used, which caused rules to fail on any PF
other than PF0.

Switch to global queue index by adding first RX queue id from caps.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Fixes: 143b86f346c7 ("ice: Enable RX queue selection using skbedit action")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c04127..6f49ecb4165b 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1202,7 +1202,8 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 		break;
 	case ICE_FWD_TO_Q:
 		/* HW queue number in global space */
-		rule_info.sw_act.fwd_id.q_id = tc_fltr->action.fwd.q.hw_queue;
+		rule_info.sw_act.fwd_id.q_id = tc_fltr->action.fwd.q.hw_queue +
+			hw->func_caps.common_cap.rxq_first_id;
 		rule_info.sw_act.vsi_handle = dest_vsi->idx;
 		rule_info.priority = ICE_SWITCH_FLTR_PRIO_QUEUE;
 		rule_info.sw_act.src = hw->pf_id;
-- 
2.49.0

