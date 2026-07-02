Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DA4189A9
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991846; cv=none; b=qcNGkXnEFVfPgEaO0xqh2UwA1ePjcVq9PgOdVyFgAUkClLKkGhwcfd1XxfB48VKo/AAn4oDcKNasXkedN+W9XpJUiE8rmGcMELdykeC87EW6b7PumB6K0EtFISnBEosPrijZLBU8oWXf8NoTtctpeAqhFHjpWr3HRMeck9P91Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991846; c=relaxed/simple;
	bh=ndGchCS5JVPbUpmlXAIE5uIQE/y0C+G6UWSGJInGOfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCLSK4QwMtMhyilWvrCh1dmQ+Y0QoanGRd/QUdKHt8XOWNF8DPY8LQJvLTRyCgQ255ARnTn2Gh1ubiJO3TG/UYl1NRIeVBBwjjSwD1TfKVRpFnB9mmhbHKJxx/hbgM4ytgHKrsGVmG/My9BKgqxY9e8z4P+Zsm9M18Rculea9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cx8ZKW5q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cx8ZKW5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782991845; x=1814527845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ndGchCS5JVPbUpmlXAIE5uIQE/y0C+G6UWSGJInGOfg=;
  b=Cx8ZKW5qFCe7U+wmInBHcovQj4UsMlZxTnFaEfYXHoBXY8zIvtg8277j
   1XExoi/vmx45OrtCPkHguQ5n2gf5r8Z0sR41lEHnR493Bhgq0KN0hzIJA
   3vPecRC5ToXqfFOKtdv45JJhUO/P/CU0GhGI6WOsRgBnnmQ/vvMoD4Hxh
   ezZ7VnThyVMTcaGgIuVtFKJ3k3AjAmciUB6CfTZTGuft1EHukmRIWyCNN
   HLePC1U1tsrnUktfveIFDnWTs57a/St8A5L6lrXMswjs0fRnijW3Ffgc4
   eY7EEAx2tbIbjLw8R+734Oth1RXL6++MZrAkH+MayJPuRrJgJrnBBzugj
   A==;
X-CSE-ConnectionGUID: rIm0FjZnRuqSN0dSjfFYFg==
X-CSE-MsgGUID: h5yJG2kET8SmVJbugskAog==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83611742"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83611742"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:30:43 -0700
X-CSE-ConnectionGUID: 8sN9oUMARiG6xsPnu+kRQA==
X-CSE-MsgGUID: SdYo9MTtQFaD2e6wXAVo7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="251788416"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2026 04:30:42 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0C1FB28760;
	Thu,  2 Jul 2026 12:30:39 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v5 07/12] ice: use plain alloc/dealloc for ice_ntuple_fltr
Date: Thu,  2 Jul 2026 12:30:01 +0200
Message-ID: <20260702103007.97020-8-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
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
index 87457e739e2a..242be0a297db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1781,7 +1781,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 		ice_fdir_write_all_fltr(pf, f_rule, false);
 		ice_ntuple_update_cntrs(hw, f_rule, false);
 		list_del(&f_rule->fltr_node);
-		devm_kfree(ice_pf_to_dev(pf), f_rule);
+		kfree(f_rule);
 	}
 }
 
@@ -1882,7 +1882,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			 */
 			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
-		devm_kfree(ice_hw_to_dev(hw), old_fltr);
+		kfree(old_fltr);
 	}
 	if (!input)
 		return err;
@@ -2234,7 +2234,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	input = kzalloc_obj(*input);
 	if (!input)
 		return -ENOMEM;
 
@@ -2278,7 +2278,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	mutex_unlock(&hw->fdir_fltr_lock);
 free_input:
 	if (ret)
-		devm_kfree(dev, input);
+		kfree(input);
 
 	return ret;
 }
-- 
2.49.0

