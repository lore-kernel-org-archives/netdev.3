Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611556;
	b=L71zGMQ5OLeDceELAuWsID0rnrz5DTQP66zo9VZX+rBE3q4BK6qpHZRBS4WdbBvYzsUJ
	 2VSqH5p0l14rxsADaAnmNwk+5bSNPUNClRibLpmCUjapi2CfugSeJe9qVrzG0xRLqlkw4
	 AvbTnWxlUlG8UbC6nMFBiKzwTLoi0HHzMcrHRc2dhF+JXvtFozi/zZuoLaF2KX2tQaZKn
	 snPew0KGhYGK4OLFRJ+0L7WjC1TwRM8Ga+WL6bN9IpAwXku5P/SH3sBIlf63tDJ0yGeEU
	 LLgmFAClWqsAM/Q0omOATaTQgzXq2FJoVpCekI2/mT3WhTAzNp+3XATu5YLQXeAJNTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611556;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vhE+R+wrV6W8gecV59SKISkNIhmE8KH974z/q1TqEcQ=;
	b=1zOsRl6z+bfvK4FFHqx8SQcOx5uLPFfJyRnpI/XOXALO7YT+vTloA0GaR8TjnwsdlqFI
	 OmIoHWTLl/7Vt5UHn05lY3LI2g7ISRqui3M6nkcas5BlaDm8fd+0QhyC8zm9YWNlsrNDA
	 yS58czCYpKjT67PfoA6NogMGCpgQ2zIROEt84R4778w5TQOrtT6QEoVTUh4Q1XmvUgmnY
	 BDWFZich4tBnOo+gYKDCnCEKDl4TqmkRPNZehk65/tRCvHKeceoQoUHhZobNGUgeVw01h
	 RjwgXb8dmF7F6MYLKqO63VLwUKByG3oNnsbSalgkI6zw8KOsofDm/jLdEEm98CV4uJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ea1GbJ3D;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13177606A33F
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13177606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ea1GbJ3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611556; x=1826147556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/9Oa6Dbvu4/jHVte395VlXnZRRv2RUfcQOqPFiqVnw=;
  b=Ea1GbJ3DpuQO43Ju/bXKBOp3kLkbKa/y0T+thD323QP6mSuB3odnvdx7
   SGPATbVRPx2XfwGv/T8zLUlL8zmjsZFRt46YkKqcP8Axl0XynI+3iB5pP
   3jNOaQ4cY3tg5TdeK0wAQWHqtSLxoXlXuPGkqWrgG3xDzmKSgeyNfyDP+
   yGEveB7On6dH6N73S5BJ7Uo4xrIYkV/yjUriIIBOhdcwvpBA/wMkN0oUe
   MeFg105YUKOeW8oVXPApR/GYRZzaj4jNqsUAVvXDBNUZxsu0TCE1G/5yc
   LVXQmzK2io6D0nHFTb2E97XcXEPYLoG477w6u+6/S3VnWY78If/DOYQJP
   g==;
X-CSE-ConnectionGUID: kGfDQ6xXSB+dEWMViJ1KGw==
X-CSE-MsgGUID: pPlILzBBRF6yqI++6PJ2lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443158"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443158"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:35 -0800
X-CSE-ConnectionGUID: HloQy21EQHiWPpR5lhIlog==
X-CSE-MsgGUID: H+f4Sm0OQ/Ku0dCuoQhdNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360988"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2026 15:12:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	poros@redhat.com,
	pengpeng@iscas.ac.cn,
	przemyslaw.kitszel@intel.com,
	larysa.zaremba@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net 4/6] ice: Fix incorrect LLDP filter assumptions
Date: Fri, 13 Nov 2026 15:12:21 -0800
Message-ID: <20261113231225.1864810-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
necessary"), it was assumed that llpd_fltr_ctrl was a unique application
of a filter instance and the other command in the flow was generic.
This is an incorrect assumption, they are both meant to add a filter to
handle LLDP packets and only varied in the actual AQ call made.  The
newer AQ call was created to handle a special case in some NVM images
where a LLDP filter was already existent and the old AQ command would
generate an error if a new filter was attempted to be added. The newer
AQ command would detect this case and instead would add the current
target to the existing filter rule.

Fix the flow so that the newer command is always used if available and
only fall back to the older command when that is the only solution.

Also remove the obsolete state flag from the PF struct.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  1 -
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++-------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c0..dded9f7c173e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -525,7 +525,6 @@ enum ice_pf_flags {
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
-	ICE_FLAG_LLDP_AQ_FLTR,
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 977cd8dd6e31..2836f7d8a475 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2179,24 +2179,16 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
 				  ICE_DROP_PACKET);
 	} else {
-		if (!test_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags)) {
+		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
+		if (status == -EOPNOTSUPP) {
+			/* If fltr_ctrl not supported, use legacy
+			 * add/remove command
+			 */
 			status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
 					  ICE_FWD_TO_VSI);
-			if (!status || !create)
-				goto report;
-
-			dev_info(dev,
-				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
-				 vsi->vsi_num, status);
 		}
-
-		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
-		if (!status)
-			set_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags);
-
 	}
 
-report:
 	if (status)
 		dev_warn(dev, "Failed to %s %s LLDP rule on VSI %i error: %d\n",
 			 create ? "add" : "remove", tx ? "Tx" : "Rx",
-- 
2.47.1

