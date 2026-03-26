Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8463B8928
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534673; cv=none; b=jiU0KsQ5WkoqsyBl1uKFCvxLDkyUAmtonJApVwX0wm+4OpWnSypJD79XVuCN/XCM4vww4x5eEoDg6v4ZuQeSsRqYv9E6C6C9epubmjlt1OWZomgpv+HqI/7x4R/BL9N3MCLTlKXleBMm0O30PyeTyKUt5keOrPDJI+VMwVGdipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534673; c=relaxed/simple;
	bh=19JNJgIC1w0C8iD0XBuDVA7+MnIqP+1uGvp0jR8zkts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOr4sw4KBI93Sx3W2YiS6zzqner+Qut9pGX1BWIw/rLIxq3FcWDFaxIYoacNiXr/M2LDArundKwXM3tqjl86K0dloAVvlmEPa7pk1HH+oKrH2wDUIKoONw5TxGShOluMIi+0CnNsMOfAxsu6ZnH51ndRWtIhuKtyfnfLWRPrYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlMIDE+m; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlMIDE+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774534668; x=1806070668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=19JNJgIC1w0C8iD0XBuDVA7+MnIqP+1uGvp0jR8zkts=;
  b=XlMIDE+m6QXDZ0OaS3mfBl6ol7PG+KSTplErc4YMyKthUnJgdvX6xYsN
   JbtisRJkP7AFe59k5gUsCT6dlv7DviPzmGSdLMy/pOnSNAXlQj7wG2FCu
   6AuQo90JtA3uOFVpAHVnl31+Ln4fSDZd+bpavzGyCuil3WkYsPiQaOuFb
   0JjaGn9uDR7hl+JiwjNbcyhxHDPdlxT7biOuUApkR10xL7ZHcETXeJVbK
   OlCeRn2Mzmw/BzAcrbVBi4/dA/Zc+CTz8ZiUvZ7rUwtpS7pQoJ/twQ0Rq
   ubbBmsADx1AAzcr7mOXARBdSGDtRFPLqDhS/J19FArQsi7Wo0dJfvVmNA
   g==;
X-CSE-ConnectionGUID: KFn8lJO0S2uItVw4VvlAYQ==
X-CSE-MsgGUID: LTdEIZrdQQe2FMlpWcC9Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="98212692"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="98212692"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 07:17:47 -0700
X-CSE-ConnectionGUID: zlYbFasVTCCazD3zHtYOyA==
X-CSE-MsgGUID: FuCbrUlrRh6ZBfeOE+Krvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="229963510"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2026 07:17:46 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Subject: [PATCH iwl-next v3] ice: remove excessive memory allocation in ice_create_lag_recipe()
Date: Thu, 26 Mar 2026 15:17:45 +0100
Message-ID: <20260326141745.3804284-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@intel.com>

For some reason ice_create_lag_recipe() allocates an array of 64
struct ice_aqc_recipe_data_elem elements, while it only needs one (1).
Fix it, while also using kzalloc_obj().

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3 use sizeof(*new_rcp) in memcpy() to match the allocation (Jakub)
v1 -> v2 remove 'Fixes' from commit message because it's not a critical bug
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe..9ad19c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2418,11 +2418,11 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
 	if (err)
 		return err;
 
-	new_rcp = kzalloc(ICE_RECIPE_LEN * ICE_MAX_NUM_RECIPES, GFP_KERNEL);
+	new_rcp = kzalloc_obj(*new_rcp, GFP_KERNEL);
 	if (!new_rcp)
 		return -ENOMEM;
 
-	memcpy(new_rcp, base_recipe, ICE_RECIPE_LEN);
+	memcpy(new_rcp, base_recipe, sizeof(*new_rcp));
 	new_rcp->content.act_ctrl_fwd_priority = prio;
 	new_rcp->content.rid = *rid | ICE_AQ_RECIPE_ID_IS_ROOT;
 	new_rcp->recipe_indx = *rid;
