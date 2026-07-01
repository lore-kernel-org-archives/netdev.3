Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00957480DEC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909932; cv=none; b=ukMdOgQktVHbsic6u1PfbZezFBda3IJ2z3dGvts/ckU3jX+mPgBw0XhEyBfxGKXl4HtXEDlWccwd7tzaBnT6le2z06B9FSaCc35oRqpRbr8Elo7gQwTubWpOJkNheIGeNCrRGGfRv/BQ3F1o9K0MQT6i4LRSF29BCh4o/7z9dYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909932; c=relaxed/simple;
	bh=FqAu1SYkvELBsVn8SuaoHwAKV6DkoPDKT+iZ6Cw8WBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQzhXEhydo8PskYM4/3oHd/D+L0vzmOoSgljHlg7J6WbCm+Simgip1OHP/x5F6GGDoca3Eec3PcuBBIZtYwRIQZ3+la8wOizvnx3CooNUukU13GnFwVXc0cf2/jfk5JfhJokVgYM3YYYv1uLNpVn6MJ+GxOZRfEF8xHGXtNcivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHvz8Ywp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHvz8Ywp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909931; x=1814445931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqAu1SYkvELBsVn8SuaoHwAKV6DkoPDKT+iZ6Cw8WBQ=;
  b=PHvz8YwpH1/0NkuYLI2TCW34abpxqXDwG5BJ4/em902Hy4xW7T6qSo2O
   pQnibcfKpoD4lUrLpmPXFdRJtii8ndwSOqI4DVo2OxU60aFj257ZkPXPI
   uxGcLce0Lr2Lng484CuEfGXCNFk5QanRINm8OHAQldidXhKlNZuIPaqZ5
   yegor/z9z42yRyzxhvEcaqo38qvb0PD2vmeyV4agl+EGuezSAjaqEq35L
   7sobEAi9OtptJfblTMkoIhCD+LJppyPF5GdKfWwbmvCffor6gjmrGds6z
   MzlxvZNDo77F1FC9/xn7deJXvitT5VtkWkAz0s8xesUAlTF7mt8lgLtne
   Q==;
X-CSE-ConnectionGUID: Rgy09IpHRQ+G2yokK+cz8Q==
X-CSE-MsgGUID: V4YNJ/4XSz64M4ezc1dG/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839221"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:31 -0700
X-CSE-ConnectionGUID: MMKBwQoaRReLn4iu1gMIdA==
X-CSE-MsgGUID: loEbzIE8T4erOdbTRoGUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864889"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:28 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 net 1/7] i40e: unregister netdev before clearing VSI on reinit failure
Date: Wed,  1 Jul 2026 14:45:18 +0200
Message-Id: <20260701124524.13644-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i40e_vsi_reinit_setup() tears down the existing VSI queue/ring backing
state before allocating replacement arrays and queue tracking. If one of
these early allocations fails, the function jumps directly to err_vsi
and calls i40e_vsi_clear().

For a registered netdev, this frees the VSI while
netdev_priv(netdev)->vsi can still point at it, leaving the registered
netdev with dangling private driver state.

Split the error path so failures after destructive reinit teardown first
unregister and free the netdev before clearing the VSI.

Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..471fa7f7b643 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14274,7 +14274,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	i40e_set_num_rings_in_vsi(vsi);
 	ret = i40e_vsi_alloc_arrays(vsi, false);
 	if (ret)
-		goto err_vsi;
+		goto err_netdev;
 
 	alloc_queue_pairs = vsi->alloc_queue_pairs *
 			    (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
@@ -14284,7 +14284,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_netdev;
 	}
 	vsi->base_queue = ret;
 
@@ -14309,6 +14309,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
+err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14318,7 +14319,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
-err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;
 }
-- 
2.43.0

