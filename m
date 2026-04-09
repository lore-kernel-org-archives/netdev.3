Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EC3CEBB6
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739629; cv=none; b=qrCQn7kPLw8aCKi5i7/sms/tV82Rj95IfrVnRbtp9DRKioJl4rwO7eFSio0d8SFkiubZtrZ4l5kf4OHx9yZNHqxr0QnMmOG4rAN5tGrP1iTmAWwppiY/ZmtBpxDZKfUCv2e04Y8Q1UybFv8ILpR5iYfZ1RVENkJ3swI0XBWZxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739629; c=relaxed/simple;
	bh=bBbnnIzfb8m+qy0omERvBIWpootbQKRVNSRImW14udE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpwxT7hXnObf1aEcGrXtgShA5rS+bEmnlT5n7R5zdOYGB2fTljkHqO6GTCRsNrGhNzrra0DIHhZyUDzeA9SeW5UClVs7VjNYQa9ZD93IxRbFZnRAYInNgQ6nPmoq6GFBoQq7PojsUn731iF4HyyZmxr3Q4DvcP01UGPVGoeE+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntV6S3Ah; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntV6S3Ah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775739628; x=1807275628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bBbnnIzfb8m+qy0omERvBIWpootbQKRVNSRImW14udE=;
  b=ntV6S3AhjS+IFI9cUdeHRO2vN2TWVZf5l9jcEXmUlAQ4Bmr8dEvBm9o3
   HPSlH/2Qmr7JdNoAcBiKg662315f7BM00IL6NrYFaI4MYMxVTOfdW1vIA
   RMWz/9/F1yRR6dPdqsFiDYOWzyYkb4wL3XPm1eBPyUlahmuaYX77Mra8D
   HvdxdoVXOggnoDLdIzQopYhhtlYiEMhOnrpqKOad7tuR/GdyYkaqa3CNv
   XrfHn3qi93NSmWWJFAsqiNviLSO4t9zcRldQH04aWvBawVWMzooKbzGQG
   +hCWX5XyElEYVF3ihsFFxSZJSN/4Z1AzAE1LWUz/lCP7R7PJ2YTNxNw7f
   w==;
X-CSE-ConnectionGUID: Otx2QPmmRRiQuUiSSuLN2Q==
X-CSE-MsgGUID: 2+vDXRjZRF64LVb/R4Ijlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75777525"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="75777525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:00:18 -0700
X-CSE-ConnectionGUID: 36SONYIFQQGixnFsTayVkQ==
X-CSE-MsgGUID: R2QTIDzeSCyXuiGqqOje3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="259208113"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 09 Apr 2026 06:00:16 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A5B2B2FC58;
	Thu,  9 Apr 2026 14:00:15 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 06/10] ice: use plain alloc/dealloc for ice_ntuple_fltr
Date: Thu,  9 Apr 2026 13:59:59 +0200
Message-ID: <20260409120003.2719-7-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change struct ice_ntuple_fltr allocation from devm_ to plain alloc,
since its lifetime is not tied to the device. All such objects are being
removed on device remove via ice_deinit_features() -> ice_deinit_fdir()
-> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs()

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index eca15cb2665e..b5a841732b58 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1748,7 +1748,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 		ice_fdir_update_cntrs(hw, f_rule->flow_type, f_rule->acl_fltr,
 				      false);
 		list_del(&f_rule->fltr_node);
-		devm_kfree(ice_pf_to_dev(pf), f_rule);
+		kfree(f_rule);
 	}
 }
 
@@ -1855,7 +1855,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			 */
 			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
-		devm_kfree(ice_hw_to_dev(hw), old_fltr);
+		kfree(old_fltr);
 	}
 	if (!input)
 		return err;
@@ -2206,7 +2206,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	input = kzalloc_obj(*input);
 	if (!input)
 		return -ENOMEM;
 
@@ -2250,7 +2250,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	mutex_unlock(&hw->fdir_fltr_lock);
 free_input:
 	if (ret)
-		devm_kfree(dev, input);
+		kfree(input);
 
 	return ret;
 }
-- 
2.49.0

