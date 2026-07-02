Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167C356764
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991843; cv=none; b=Gq27zsqAKw8ieh5Gk57BVW+CU3tF2yoxqRcJs89U4tecxkuXEI//WJiy7U+EYJzUEaJHXnGNPOpXv2NWx99GkcyLG9RjzBSulB3f8c0hTfBcURUKgSUEuRiXVEVmGtVqSbGCx7YdkkFMN4cirbn+4gbqZ4zewAwdzYuLGqAm1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991843; c=relaxed/simple;
	bh=NBmRd/mym/nbRKZy4VssKZzM7IgLf4LNcTOCiKMN710=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFyMRyUj4xyJKJ1e29GCALX+RdWZM+S/IjAYtac8yvKGAZ6uIAeYKOIsl4/DPlh/Aa+/AX21GH3y3BX2yUjh5FJbAYXmXSjLenEkSuama/GkMDlesLsBZSdI0O7OZC9ZpXHSjlcpYYDAzvav5AB62BWw2qKBFa/Ygy0M9hwC3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h52/bB+Q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h52/bB+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782991841; x=1814527841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBmRd/mym/nbRKZy4VssKZzM7IgLf4LNcTOCiKMN710=;
  b=h52/bB+QghtN6UxjD/mcZbx4zgosCj4SRGDAPKadFcQRdo1w4CpGsyIC
   7VjcOyOCvdTkf2WngFt/q3KJQJuANikHKVga7cT58NBQTsWhHdEd+h3X6
   vANRiSNHTa5NBKPdmrEZQWRyaM0J39YE+Av/rfIBHSCQu460GH1DYNDMc
   O2WQhjLHBwlrWQKG9Ny+t4+dGKmLvAAIZ6mzSZFscKdkI+qizb7vKNiii
   4gGxnZNNRov/Q+yU1wnlAUR73COqJbfyK1VqtSVndp5mlr/h4xM0T9437
   ldbovTutENYO+j+8I55r/n2Eqx2xBWMyat0EzPEy2NzWMe1qHRFYKMKbz
   g==;
X-CSE-ConnectionGUID: bbk2EvJXRgWBFhXJCpdxSg==
X-CSE-MsgGUID: P7/wdlrMRoKtyZHO17RbUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83611722"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83611722"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:30:39 -0700
X-CSE-ConnectionGUID: ji7S5MnsSda9kduKqicZ3A==
X-CSE-MsgGUID: Nus3vS8bSd2gWKLu29u7CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="251788388"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2026 04:30:37 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 037A728762;
	Thu,  2 Jul 2026 12:30:35 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v5 02/12] ice: remove unused ICE_FD_FLUSH_REQ from PF state
Date: Thu,  2 Jul 2026 12:29:56 +0200
Message-ID: <20260702103007.97020-3-marcin.szycik@linux.intel.com>
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

It's hard to tell what this flag was intended to represent. The commit
adding it only added a check that was always false, because the flag is
never set. There is no relevant comment and commit message doesn't
mention it. Therefore, it looks like it has always been unused. Remove
it.

Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v5:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice.h                | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 738bd9d0c2c6..72941e3736d0 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -303,7 +303,6 @@ enum ice_pf_state {
 	ICE_CFG_BUSY,
 	ICE_SERVICE_SCHED,
 	ICE_SERVICE_DIS,
-	ICE_FD_FLUSH_REQ,
 	ICE_OICR_INTR_DIS,		/* Global OICR interrupt disabled */
 	ICE_MDD_VF_PRINT_PENDING,	/* set when MDD event handle */
 	ICE_VF_RESETS_DISABLED,	/* disable resets during ice_remove */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index cc60b2c36518..ad519a8513db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1768,9 +1768,6 @@ int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -EBUSY;
 	}
 
-	if (test_bit(ICE_FD_FLUSH_REQ, pf->state))
-		return -EBUSY;
-
 	mutex_lock(&hw->fdir_fltr_lock);
 	val = ice_ntuple_update_list_entry(pf, NULL, fsp->location);
 	mutex_unlock(&hw->fdir_fltr_lock);
-- 
2.49.0

