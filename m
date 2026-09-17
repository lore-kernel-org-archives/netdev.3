Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4A49739D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670386; cv=none; b=ZgJFyCNI7jGCzzBFgrT6/5abq4O7C5iI0It6DmiNL7TsM7wSljgD0rFpk6hI9PQiYH7Tst6sRX1jw8/aiR+DYzhZoku6x8ln2ztyMDygJ7akNHW0u+qw0uk8mg8cus5KwWTigSQ3ZUW68utP/64nS8SGajGz8ALEN3d09ZvUM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670386; c=relaxed/simple;
	bh=dMbwW6VujkQBMo/BaCpWFuONyVq3c5ipRHOYi6D8Egc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgfvcKciTNbOJl0Gylr5O9xOMJv7FEMa9/KCF/TS0TZv6vyer483Nl87nmCcjYovCLmj3QTd1p46EEbQ/mk1dTGal5PoYGMz5ekUE5zldpN9B40coVpviwIzk0iHuxsKgy5u5uenOBnQNuWDB3u0GsmALINWaa80WvTLU19Q3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwtmNoAt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwtmNoAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670385; x=1821206385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dMbwW6VujkQBMo/BaCpWFuONyVq3c5ipRHOYi6D8Egc=;
  b=KwtmNoAtXm1ks3eg84bVOlNIiUCFDoXBOvzUtPcNKFpXuD0XDcxCHxq1
   ZTKXRhdh0XtT7VAZ+UTF+gsW7FhoB+t1/a3Wg+d0/pnoceBsvPBY7ZRfL
   LTGqZI5CN7Lb+U9UDFAbvlUE/P2Lq8G1MDpzm0EGlbGEDSUPMQTifqV2b
   Vg7dRE5VeXaNVb/OkpNl0jBzH5auEGrv2SkYMPOwgDnVGco4lrzZ/6qju
   yorIm4V05HAXN+TXXSepehu+lWyiTeutSrnJaxFlps2v1YHzLog5Us+iV
   idhKHB3sc0Ue10sVMo9u5XSqm5X+YpwiDLBJacNXpY/O/xjlcfeUbbX2t
   A==;
X-CSE-ConnectionGUID: MDSYwKCQTRmJ2I9P/UKXKA==
X-CSE-MsgGUID: zAx1qkwZSLWECZ3ZkO2iiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100722100"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100722100"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:39:38 -0700
X-CSE-ConnectionGUID: 3RFmMlcBROefkH3JylVGpg==
X-CSE-MsgGUID: +FW3ZTHhQi6US9qVwJAa1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267728753"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 11:39:37 -0700
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
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next v2 07/12] ice: use plain alloc/dealloc for ice_ntuple_fltr
Date: Thu, 17 Sep 2026 11:39:19 -0700
Message-ID: <20260917183927.2692068-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
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
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index afeda2110940..0c088e626143 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1806,7 +1806,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 		ice_fdir_write_all_fltr(pf, f_rule, false);
 		ice_ntuple_update_cntrs(hw, f_rule, false);
 		list_del(&f_rule->fltr_node);
-		devm_kfree(ice_pf_to_dev(pf), f_rule);
+		kfree(f_rule);
 	}
 }
 
@@ -1907,7 +1907,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			 */
 			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
 		list_del(&old_fltr->fltr_node);
-		devm_kfree(ice_hw_to_dev(hw), old_fltr);
+		kfree(old_fltr);
 	}
 	if (!input)
 		return err;
@@ -2259,7 +2259,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	input = kzalloc_obj(*input);
 	if (!input)
 		return -ENOMEM;
 
@@ -2303,7 +2303,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	mutex_unlock(&hw->fdir_fltr_lock);
 free_input:
 	if (ret)
-		devm_kfree(dev, input);
+		kfree(input);
 
 	return ret;
 }
-- 
2.47.1

