Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F040FD93;
	Tue, 20 Jan 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905290; cv=none; b=QJZ2WHpWi4t47wMiNfld+Y/vpVJMt4FrnpXWV9ZBUStCTRnazDJVhXqSzaLW+gkQ+AkaRUJufU926NMc2SJ2/rwC0f4H1BiNrp+o9AKteDb0ByImyAqnRgjwA2QG5sQgrtNwzrJbBWAP6a3Xx66wwjnEUT/u73MWTG42xb1CPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905290; c=relaxed/simple;
	bh=aDADJULyrOXAsvln2yMJyhXY1pU5VH5XFxcMbCSZkys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVlroVf1w235hsLpQ5e5LFLlZ+K44fa5ynTKc+IfhFxLlSm6ODoo+kf/LZ8hwKiLOWGOh8D1xlhayT7xK+CBu4AbncXyGv4zcJZMKxS3gePdk+IX0wwYKKrfL5HNauBxwjH82Ig8nLq1RkPARKSzHjEPAb7TJgNI9OCuOD2P99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2VZe6kN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2VZe6kN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768905289; x=1800441289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDADJULyrOXAsvln2yMJyhXY1pU5VH5XFxcMbCSZkys=;
  b=L2VZe6kNCM3mJ5p2XUQYmtvbF113TMRABVW4SztMA2iipDstGV9BCu3v
   ZeXpvUzu5ojQwSgV8yvqtaDpdz1HNUZYaXnnTXmLRTTQoBVm+xjxggJH+
   lY3BOJxnX+GU1MRkYaJe3iYlJL88+wWaA4olK5HakOUxlCiLVfTNDpyHC
   yNzh//oTEzv9C5Uet77aNJLM27oTuI3gkzeGMcG1hh4ra0WpRGYOqq85L
   oruSY7VweHb45MKeCOw9Jegl8YO+qBqL5FRW65QGrjXDAAIWRzjRS/5vT
   x4b32FCGeGcaBC6fxGXdY4fSI9rQowrEdKM2D1iHjQsqHGqWbm1H6h2Ub
   A==;
X-CSE-ConnectionGUID: nEmRUv3TRMCqFe9v7pFLHA==
X-CSE-MsgGUID: UKNwLt+JQwWnbAYwjCuRGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70161741"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70161741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:34:48 -0800
X-CSE-ConnectionGUID: NvYLKDxGQyWBfxmtwkNDqA==
X-CSE-MsgGUID: fapk4ngNSNiiB7Fsj00qqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210935853"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 02:34:47 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 3/8] ice: do not check for zero mac when creating mac filters
Date: Tue, 20 Jan 2026 11:34:34 +0100
Message-ID: <20260120103440.892326-4-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120103440.892326-1-jakub.slepecki@intel.com>
References: <20260120103440.892326-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

A zero MAC address was considered a special case while creating a new
MAC filter.  There is no particular reason for that other than the fact
that the union containing it was assumed to be zeroed out.  Now, address
is pulled out of the union by ice_fltr_mac_address which checks all of
the previously assumed zero-address cases and returns an error if they
are hit.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v3.
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0275e2910c6b..04e5d653efce 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3648,7 +3648,7 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 		u16 hw_vsi_id;
 
 		err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
-		if (err || is_zero_ether_addr(addr))
+		if (err)
 			return -EINVAL;
 		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
-- 
2.43.0

