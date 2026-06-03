Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82F43D518
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524523; cv=none; b=pEfmXIxbSTAasC8hW6UmEIV3uYBykOTfy6hGV5xYOUK8sui6LgLonmIFzsNkL347a5FY4nMO7bv11jOd4BPQ+2ezXWZprY92nRSM4cxRV12bv2gcJCgrUVP5a30+Py/Vo6tHJZi9lxplB/1BeXMAisqsqXQl7D1u2Pg6UAZ/Jww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524523; c=relaxed/simple;
	bh=Vd61evmOvOQhSTyTN+i7errJWL2WTWSl7zmDmhH+sVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/r7AqL6JGALf8JlWDwdoX5O62Zk7ZV2ZPmM0OT1hZjiKKEwqXugaDN5aixFCO/ifyYIG16tcsHnAVXTVBIS96z8RgU3EEKLe5J+DSorXkkNpirNE9hvGO6caPKZc5gmqtsDws+unIxTu2gsx0iN3QNyCVGzqH5qNxolNYAIuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtUxALYQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtUxALYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524522; x=1812060522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vd61evmOvOQhSTyTN+i7errJWL2WTWSl7zmDmhH+sVs=;
  b=LtUxALYQ9nZl0qP4Jky5kixsC/YR/jdzVRMyUEc6sNx21Zxk0RgcW4Y9
   OhN6MVebYPAlBovCXntppwO+e20jnvUa21muhFTv/EB2OejK1xgVtVVev
   oMzznUgSr0u/29tE5nlsqpbSVgKtiP/thDdUOHNxoG67o+SSNQBDmgM7Y
   13Y4GJoFIjjh0eEyrod7Z+/jJ3EqEtL7fnYDESpzAWYJL0P6GXL171WVe
   jwRxmPzFR25ts0uHLjKNZA7o4uQotSGQlAlUY03onUFVnkwli8maRcsg8
   uFC0SRXnm3YjcO8mDJ2cMY6S9WLpv78w3au+V45qbFcUKjSNdhL+hiH5/
   Q==;
X-CSE-ConnectionGUID: yykvIimrQJ2uGeGDh6AoSA==
X-CSE-MsgGUID: KwJlbYmYTCehzhfwnskzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98920926"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98920926"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:36 -0700
X-CSE-ConnectionGUID: 1WqrTXUhQNGUEYL5TtHDoA==
X-CSE-MsgGUID: 3kns4ISiSZiWD78eCKitLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282458896"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 15:08:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 06/10] ice: use plain alloc/dealloc for ice_ntuple_fltr
Date: Wed,  3 Jun 2026 15:08:22 -0700
Message-ID: <20260603220828.829969-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Change struct ice_ntuple_fltr allocation from devm_ to plain alloc,
since its lifetime is not tied to the device. All such objects are being
removed on device remove via ice_deinit_features() -> ice_deinit_fdir()
-> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs()

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index 684c832b0c58..2f333ec48536 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1775,7 +1775,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 			ice_fdir_write_all_fltr(pf, f_rule, false);
 		ice_fdir_update_cntrs(hw, f_rule, false);
 		list_del(&f_rule->fltr_node);
-		devm_kfree(ice_pf_to_dev(pf), f_rule);
+		kfree(f_rule);
 	}
 }
 
@@ -1878,7 +1878,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			 */
 			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
-		devm_kfree(ice_hw_to_dev(hw), old_fltr);
+		kfree(old_fltr);
 	}
 	if (!input)
 		return err;
@@ -2229,7 +2229,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	input = kzalloc_obj(*input);
 	if (!input)
 		return -ENOMEM;
 
@@ -2273,7 +2273,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	mutex_unlock(&hw->fdir_fltr_lock);
 free_input:
 	if (ret)
-		devm_kfree(dev, input);
+		kfree(input);
 
 	return ret;
 }
-- 
2.47.1

