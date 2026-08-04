Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED75432300
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882145; cv=none; b=P4Gp9me6J3WX4GNJwJHJKkZJNcdnvupVJN0bJPkY2kw/KAwjqNHr3ftsk++80DS2eOsupZu2vpbHQhx9YRyHxkHvT5zWAbbkRBZMKzZK6NngZSZVkbAQbZ1fBhJQyVOvmKb4QoZ/3HlKsbeL7dnYa2+L9btimkhLoajNwlrqiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882145; c=relaxed/simple;
	bh=yoJKNzxCAgsEP0SRePKihf9hReG/8Q1k+hG+FaF3ZYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQeFGvicxOdgCPyCYP9qV1fKuX1jt94TEOjHInXca1BcH9rfJZnHETJkdmt17ZDaEUToFVR5zML7Ohf4ulkwo7sXuClpM087549n4nC7IoQw0CjcssKc6VLm1CZP8tNQdVpKg82Ar/qNQSC/sUFQGTQXWop/v+1/m2joszEfS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkxcCyzm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkxcCyzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882143; x=1817418143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoJKNzxCAgsEP0SRePKihf9hReG/8Q1k+hG+FaF3ZYc=;
  b=XkxcCyzmF+NaXABSAHS9uKwVStrMzOrri/kwgW8UPTHPKX0OiNrQ3MhR
   vqPNDK5Fuj3AoGUGictDFWhTmo5z5xTfrpCPFbUPTQkABNzAuN1JldraV
   aQY/cQAZ7XC0nDF7ms6r11wrlHnCczMkXYz8BAGHP5s7Eo5TmXe4Eem3l
   cr4P+KdcKlKDg2N9SyS9GVMu8O3DDhZ0UsLARqCPnjodHblvbTpkmlbIr
   iXg5VqLIwfJi35Ja9I7Gdz0Quox7hw37vVIM+ak4X4Gx8bytaQlCjVEjY
   MPlQT86V4Hwvuwj95MAdEZMfvJD+Lp+gQF8CEprs/gCz3RFR07YA461ch
   A==;
X-CSE-ConnectionGUID: piVrziWpRDWkRGXYKfRRXA==
X-CSE-MsgGUID: Q7LAn3EhSuGI/wpbt4RYDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803438"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803438"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:20 -0700
X-CSE-ConnectionGUID: d9cML2WDQLGQ1gpSZhBVwQ==
X-CSE-MsgGUID: wnCGSfNiQTWfM9M4iaXXOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257307987"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:19 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 06/10] ice: fix stats array overflow via proper realloc
Date: Tue,  4 Aug 2026 15:21:59 -0700
Message-ID: <20260804222205.1580328-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Integrate ice_vsi_alloc_stat_arrays() with realloc variant.

Instead of keeping two functions for stat arrays allocation, change the
ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
ice_vsi_realloc_stat_arrays().

Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as they
were in the replaced ice_vsi_alloc_stat_arrays().

This is a fix for stats array overflow that occurs when VF is given more
queues (an operation that will be more frequent, and by bigger increase,
when we will merge my "XLVF" series).

Splat for increasing number of queues thanks to Michal Schmidt:
KASAN detects the bug:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
 Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221

 CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
 ...
 Workqueue: ice ice_service_task [ice]
 Call Trace:
  <TASK>
  ...
  kasan_report+0xd7/0x120
  ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
  ice_vsi_cfg_def+0x12e2/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_reset_vf+0x858/0xf80 [ice]
  ice_vc_request_qs_msg+0x1da/0x290 [ice]
  ice_vc_process_vf_msg+0xb15/0x1430 [ice]
  __ice_clean_ctrlq+0x70d/0x9d0 [ice]
  ice_service_task+0x840/0xf20 [ice]
  process_one_work+0x690/0xff0
  worker_thread+0x4d9/0xd20
  kthread+0x322/0x410
  ret_from_fork+0x332/0x660
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 2439:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x96/0xb0
  __kmalloc_noprof+0x1d8/0x580
  ice_vsi_cfg_def+0x115c/0x2060 [ice]
  ice_vsi_cfg+0xb5/0x3c0 [ice]
  ice_vsi_setup+0x180/0x320 [ice]
  ice_start_vfs+0x1f3/0x590 [ice]
  ice_ena_vfs+0x66d/0x798 [ice]
  ice_sriov_configure.cold+0xe4/0x121 [ice]
  sriov_numvfs_store+0x279/0x480
  kernfs_fop_write_iter+0x331/0x4f0
  vfs_write+0x4c4/0xe40
  ksys_write+0x10c/0x240
  do_syscall_64+0xd9/0x650
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 The buggy address belongs to the object at ffff88810affea40
                which belongs to the cache kmalloc-32 of size 32
 The buggy address is located 0 bytes to the right of
                allocated 32-byte region [ffff88810affea40, ffff88810affea60)

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 80 ++++++++----------------
 2 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fc91b6665f90..83da5ba6eeb1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -328,6 +328,8 @@ enum ice_vsi_state {
 struct ice_vsi_stats {
 	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
 	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
+	u16 tx_ring_stats_len;
+	u16 rx_ring_stats_len;
 };
 
 /* struct that defines a VSI, associated with a dev */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e48ee5940f17..c71849119d04 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -338,7 +338,6 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
 {
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	int i;
 
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
@@ -349,14 +348,14 @@ static void ice_vsi_free_stats(struct ice_vsi *vsi)
 	if (!vsi_stat)
 		return;
 
-	ice_for_each_alloc_txq(vsi, i) {
+	for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {
 		if (vsi_stat->tx_ring_stats[i]) {
 			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
 			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
 		}
 	}
 
-	ice_for_each_alloc_rxq(vsi, i) {
+	for (int i = 0; i < vsi_stat->rx_ring_stats_len; i++) {
 		if (vsi_stat->rx_ring_stats[i]) {
 			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
 			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
@@ -513,51 +512,6 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/**
- * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
- * @vsi: VSI pointer
- */
-static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
-{
-	struct ice_vsi_stats *vsi_stat;
-	struct ice_pf *pf = vsi->back;
-
-	if (vsi->type == ICE_VSI_CHNL)
-		return 0;
-	if (!pf->vsi_stats)
-		return -ENOENT;
-
-	if (pf->vsi_stats[vsi->idx])
-	/* realloc will happen in rebuild path */
-		return 0;
-
-	vsi_stat = kzalloc_obj(*vsi_stat);
-	if (!vsi_stat)
-		return -ENOMEM;
-
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-
-	pf->vsi_stats[vsi->idx] = vsi_stat;
-
-	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
-}
-
 /**
  * ice_vsi_alloc_def - set default values for already allocated VSI
  * @vsi: ptr to VSI
@@ -2316,11 +2270,19 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 	struct ice_ring_stats **rx_ring_stats;
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	u16 prev_txq = vsi->alloc_txq;
-	u16 prev_rxq = vsi->alloc_rxq;
+	u16 prev_txq, prev_rxq;
+
+	if (vsi->type == ICE_VSI_CHNL)
+		return 0;
 
 	vsi_stat = pf->vsi_stats[vsi->idx];
+	if (!vsi_stat) {
+		vsi_stat = kzalloc_obj(*vsi_stat);
+		if (!vsi_stat)
+			return -ENOMEM;
+	}
 
+	prev_txq = vsi_stat->tx_ring_stats_len;
 	if (req_txq < prev_txq) {
 		for (int i = req_txq; i < prev_txq; i++) {
 			if (vsi_stat->tx_ring_stats[i]) {
@@ -2337,9 +2299,11 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 			       GFP_KERNEL | __GFP_ZERO);
 	if (!vsi_stat->tx_ring_stats) {
 		vsi_stat->tx_ring_stats = tx_ring_stats;
-		return -ENOMEM;
+		goto err_free_partial_vsi_stat;
 	}
+	vsi_stat->tx_ring_stats_len = req_txq;
 
+	prev_rxq = vsi_stat->rx_ring_stats_len;
 	if (req_rxq < prev_rxq) {
 		for (int i = req_rxq; i < prev_rxq; i++) {
 			if (vsi_stat->rx_ring_stats[i]) {
@@ -2356,10 +2320,20 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 			       GFP_KERNEL | __GFP_ZERO);
 	if (!vsi_stat->rx_ring_stats) {
 		vsi_stat->rx_ring_stats = rx_ring_stats;
-		return -ENOMEM;
+		goto err_free_partial_vsi_stat;
 	}
+	vsi_stat->rx_ring_stats_len = req_rxq;
 
+	pf->vsi_stats[vsi->idx] = vsi_stat;
 	return 0;
+
+err_free_partial_vsi_stat:
+	if (!pf->vsi_stats[vsi->idx]) {
+		/* vsi_stat was not visible before current alloc attempt */
+		kfree(vsi_stat->tx_ring_stats);
+		kfree(vsi_stat);
+	}
+	return -ENOMEM;
 }
 
 /**
@@ -2379,7 +2353,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		return ret;
 
 	/* allocate memory for Tx/Rx ring stat pointers */
-	ret = ice_vsi_alloc_stat_arrays(vsi);
+	ret = ice_vsi_realloc_stat_arrays(vsi);
 	if (ret)
 		goto unroll_vsi_alloc;
 
-- 
2.47.1

