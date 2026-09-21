Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066F4FC343
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014878; cv=none; b=mJ/XSAF80d+FHQ/MViURF1Uoj7M3Wf/IOCRqWBcwZKuZxC6pPveaafMSH4FJ950321UvLZK5kYh0W0rQmVXrc6kkiCtTh77XSyVV4lMOs43qrteDS9vZXBnxs5PIMoFcaXummf69XPDvNwVw0nabg7piLefpKcvTGAMKREKDmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014878; c=relaxed/simple;
	bh=l15rcYhn5O30k1FLeiixDRRMh7usfJgX5iIkIbWvtFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah2Vm6vb0EVldCd5LqrsLb1201NvV8LfHlj2nObHxFTcHzQkGBeB8cfilzMgBjP9BQ8RKXZZX3QrG+9o6QGRU86dsre3pN/PfatsZ/xXrwDUbDe+7dIE3vweOw82WVdm04s8/vOzEILIwiiVzm+p3uK5BwBp9lyz0mEsJLzrRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7IOen3e; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7IOen3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790014875; x=1821550875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l15rcYhn5O30k1FLeiixDRRMh7usfJgX5iIkIbWvtFw=;
  b=H7IOen3eVDPxjgVB6/3r6D0S/v45Hx1wcIjnhtfYI+p1BQkYEWVc55+t
   ZNjHVKzAO53HHkKV5UwOMSSdm/3cKd/G2ygPnA0UdU7lGLWoy3ij6emPj
   nwgI6cl13x0KRUuZP7knPXWjconGe04nS9VWTgQ/ELWSEE1exRW5ZdTD/
   ZNaKhsBP/xrOKrY94AlfpR8grlMvloLu14agzaEfc/klQCK/bZQQTGclr
   KFQ9AdFa7eYUjC7rHMNNx6+5XSGHqICHRUAramPvyOxGry0PUpxVMJmbe
   9CPN9pIdp82yB+1SylAskQXouAAonfqbgt9eEofhVrUwQHw+VOE9uMgMF
   A==;
X-CSE-ConnectionGUID: M7hevuQNSpS7p8w2NnD/4g==
X-CSE-MsgGUID: k5EA27qARoa1VjIomO8FgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90426152"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90426152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 11:21:13 -0700
X-CSE-ConnectionGUID: uY8QleRtQeiJXt4q7ARwGg==
X-CSE-MsgGUID: SJAISpBfQeKKq/1LqR4i9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272267057"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 21 Sep 2026 11:21:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org
Subject: [PATCH net v4 2/5] ice: extract ice_vsi_new_stat_arrays()
Date: Mon, 21 Sep 2026 11:21:01 -0700
Message-ID: <20260921182106.1015019-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260921182106.1015019-1-anthony.l.nguyen@intel.com>
References: <20260921182106.1015019-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Split the allocation of a struct ice_vsi_stats and its two ring stats
arrays out of ice_vsi_alloc_stat_arrays(), which is left with just the
lookup and the store into pf->vsi_stats[].

The sole caller keeps passing the very same queue counts as before,
vsi->alloc_txq and vsi->alloc_rxq. A later commit adds a second caller
in the rebuild path, which cannot use vsi->alloc_* because it has to
size the arrays before the VSI is reconfigured.

Note that the error path no longer clears pf->vsi_stats[vsi->idx]; the
early return above guarantees it is already NULL.

No functional change intended.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 47 +++++++++++++-----------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index cc66ae6f2edb..456b524c0c5f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -519,6 +519,30 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
+{
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
+	struct ice_vsi_stats *vsi_stat;
+
+	vsi_stat = kzalloc_obj(*vsi_stat);
+	tx_ring_stats = kzalloc_objs(*tx_ring_stats, txq);
+	rx_ring_stats = kzalloc_objs(*rx_ring_stats, rxq);
+	if (!vsi_stat || !tx_ring_stats || !rx_ring_stats) {
+		kfree(vsi_stat);
+		kfree(tx_ring_stats);
+		kfree(rx_ring_stats);
+		return NULL;
+	}
+
+	vsi_stat->tx_ring_stats = tx_ring_stats;
+	vsi_stat->rx_ring_stats = rx_ring_stats;
+	vsi_stat->tx_ring_stats_len = txq;
+	vsi_stat->rx_ring_stats_len = rxq;
+
+	return vsi_stat;
+}
+
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
@@ -537,33 +561,12 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 	/* realloc will happen in rebuild path */
 		return 0;
 
-	vsi_stat = kzalloc_obj(*vsi_stat);
+	vsi_stat = ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi->alloc_rxq);
 	if (!vsi_stat)
 		return -ENOMEM;
 
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
-
 	pf->vsi_stats[vsi->idx] = vsi_stat;
-
 	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
 }
 
 /**
-- 
2.47.1

