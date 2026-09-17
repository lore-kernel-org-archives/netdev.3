Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA163DE447
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670381; cv=none; b=GkW4VZlATWGvqsIYDm4fMNG9ki74OpgzGWMh12WspvbUPASDt6V1ih98Vd7b0d0Hg7Fe+GpPIZQOa5y6fMRXXX4Hb/l1hfQR2F9ay+2JmmvRRdPFbcQh5SJWIzqjbvrJZVGSQfXAsDBPc5SHEa6/yUkotO9SRe/bPia/WDuv5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670381; c=relaxed/simple;
	bh=fzR4JyGQ+6ZbNg6hisc/8njWNHo00slGxVR3f34WVl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr4vjrc1DNFpsmYa8sTak5wwbcnQJkRDBDhpw6JasEw8LzJgF4Mt2ZFUZmQKDawbUG0pzTVUZJb2qQjKICgmDXAYzHgFXRlHwDv5CpWE/wZvwNCkG1S3gmEPcXWYiYxfg+mDJJtzmaNjZmzUwZrThNRRkZWDXc0fr6I2PTbbRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6f83hIa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6f83hIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670378; x=1821206378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fzR4JyGQ+6ZbNg6hisc/8njWNHo00slGxVR3f34WVl0=;
  b=h6f83hIaRGH/UAtHZxUmdR6Z1A395FxiXwbrMDJydNGEU0B4i1HrUDo9
   d2jY4Cy1DsgaLayR7Bm0P41ggE82xc/QMgrhLQ+glUPBycs4yGo3cpWeq
   5wZtAWYULTFbuAUElzUQqcPA+Tmc86p6FcksnpwvheRgD9SwmNeqnmcmz
   HGrpOhI2z+qnow6UkYmfHYpTFfY047XtqgmFFMGBjZ9a4YnyW36+fcc9F
   QY7/tMjOd4F1wxWYDBXuX6dkiZKwhKdbKMCVFXxnCowaLp4jXnEgrj6dX
   X+8D1BNQAWRTc1SULkXWM8R0ZHHpSc8T4jCk7I+z2DzPhD6jDoSjDRPld
   g==;
X-CSE-ConnectionGUID: sb0BItFnS5WxBi3OCyORcQ==
X-CSE-MsgGUID: 32TR7wBvS5uj1eIbkX8MgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100722062"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100722062"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:39:35 -0700
X-CSE-ConnectionGUID: QbQn062gSWqCS5NaqqEYqQ==
X-CSE-MsgGUID: +6HHXQfKS1GcpHM2W/mcrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267728721"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 11:39:35 -0700
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
Subject: [PATCH net-next v2 02/12] ice: remove unused ICE_FD_FLUSH_REQ from PF state
Date: Thu, 17 Sep 2026 11:39:14 -0700
Message-ID: <20260917183927.2692068-3-anthony.l.nguyen@intel.com>
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

It's hard to tell what this flag was intended to represent. The commit
adding it only added a check that was always false, because the flag is
never set. There is no relevant comment and commit message doesn't
mention it. Therefore, it looks like it has always been unused. Remove
it.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h                | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index cb7a73bbcd71..a56e9b7c4dad 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -302,7 +302,6 @@ enum ice_pf_state {
 	ICE_CFG_BUSY,
 	ICE_SERVICE_SCHED,
 	ICE_SERVICE_DIS,
-	ICE_FD_FLUSH_REQ,
 	ICE_OICR_INTR_DIS,		/* Global OICR interrupt disabled */
 	ICE_MDD_VF_PRINT_PENDING,	/* set when MDD event handle */
 	ICE_VF_RESETS_DISABLED,	/* disable resets during ice_remove */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index 744cd0b82470..516b57ff3b1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1793,9 +1793,6 @@ int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -EBUSY;
 	}
 
-	if (test_bit(ICE_FD_FLUSH_REQ, pf->state))
-		return -EBUSY;
-
 	mutex_lock(&hw->fdir_fltr_lock);
 	val = ice_ntuple_update_list_entry(pf, NULL, fsp->location);
 	mutex_unlock(&hw->fdir_fltr_lock);
-- 
2.47.1

