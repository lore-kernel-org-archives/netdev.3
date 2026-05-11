Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289D3E63B8
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508458; cv=none; b=spbf0KeUleNAJnMekTwqjmzjVfQyI2L66AEQ3BfZx1v7GVmo2QIN3grJ7YXR2kpck2afZIoEsO7V8azFEZFkirq7pipGkIRyLbdlbh2koLUCEHFloYryl8sEuHtfU3ReQ7HxOUKvI+mwh1yKid84AGF5pL33r+TY3hWW1Wlm2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508458; c=relaxed/simple;
	bh=F7jFNdnh09WfVR6eOYaGwY+WEg+3eXvo/cT82vX4ZcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS/3+PgH4htlzms5QvMr2dtpcR1YrbiiXsEYL1vjzr1paFtC+HxQ7gosjS951MUpFE5qIk8uPnGq2TSQikCvHOiQts5sJ6VQCKsFqTW5fMjeeYmEgZQ/zO0bxBil3+5JjgJbdQfHRpxlL2o2KgxcsDFuNnarDlc1d+yTgDV19Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb4rina7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb4rina7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778508457; x=1810044457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F7jFNdnh09WfVR6eOYaGwY+WEg+3eXvo/cT82vX4ZcU=;
  b=Wb4rina7ZV77NzJJtgSqGXLeoQsZtmpmL3EoODHbrd+EqgOFsItI2Zmd
   oVfL29fxJzrJrCHaOH2TV7SL2a4OAJ2v8rFumHuHMkCgmISUMJ17ScWti
   o2C8y8sZzNbXfT4WfNNFm97JDm7606K7MB0GvIWC8cjSu3I1aQIAFNtBq
   Vq0EKB29BcDz8b+BJVO+WeCxC3gRkhseM8NEKNmk7oCJgPnEmevr/5uio
   pPLtLHlUKR+Lq14Kmq+ukSVSlEpQ/UoP9xJVqrq3WlcyO1ld013BV/Xaz
   8PiwwdW/nT9t2B8F9PmZ0+PCkYmDwQePQFBWHb2oHlZRovpOV/YdRRYR1
   g==;
X-CSE-ConnectionGUID: Puv+i9P8RFuoG4Up3PCj2w==
X-CSE-MsgGUID: wk6sh7x0TmqnIV+zxv5MHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83265221"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83265221"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:07:35 -0700
X-CSE-ConnectionGUID: Cimb0U5mQ3qV3LkRjUlvig==
X-CSE-MsgGUID: 8z6iAGhvROG+X5tbKlISPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237685827"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 11 May 2026 07:07:34 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4A69D2FC4B;
	Mon, 11 May 2026 15:07:33 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3 06/10] ice: use plain alloc/dealloc for ice_ntuple_fltr
Date: Mon, 11 May 2026 15:07:05 +0200
Message-ID: <20260511130710.38801-7-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
References: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
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
index e3ea5aed4dd5..f0e14bac2539 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1722,7 +1722,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 			ice_fdir_write_all_fltr(pf, f_rule, false);
 		ice_fdir_update_cntrs(hw, f_rule, false);
 		list_del(&f_rule->fltr_node);
-		devm_kfree(ice_pf_to_dev(pf), f_rule);
+		kfree(f_rule);
 	}
 }
 
@@ -1829,7 +1829,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			 */
 			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
-		devm_kfree(ice_hw_to_dev(hw), old_fltr);
+		kfree(old_fltr);
 	}
 	if (!input)
 		return err;
@@ -2180,7 +2180,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	input = kzalloc_obj(*input);
 	if (!input)
 		return -ENOMEM;
 
@@ -2224,7 +2224,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	mutex_unlock(&hw->fdir_fltr_lock);
 free_input:
 	if (ret)
-		devm_kfree(dev, input);
+		kfree(input);
 
 	return ret;
 }
-- 
2.49.0

