Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008E4A2A76
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342840; cv=none; b=KkiC+W/HmcGkBU1LcZOAGevGz4NBWeMkd0fZ9KsCqxVhb729yoqO3SorM293CuFnNXT37BEzFy70F8lagydbxbi/n0tlnNIplgyLEyUd4rYbadQHebFqStqyv3TXb9U2di6CN0v8W8zXi971yIWU8tUMbkyxj0B1nFnCr608qlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342840; c=relaxed/simple;
	bh=hsg2hy32xsOWA/rGxo8kSbDDDTWcpJ/zjj56mZu3SAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzAVDE1SuTLP04tnjA00PUrVB4oE7HajIzP1Dzwhl8d/8NjhJepFDQDqvSZJAUYlUy4ZNIrDX0vqXho+M72j3huAV3tAQXtF87fhnX1VBgOdMfNu4fd/qWGy4BgY6prikvm+KIN6GV/CBY+v/4zT1QsZU+U9I6Eia9IQFYBduvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lONRCnsQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lONRCnsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342834; x=1821878834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hsg2hy32xsOWA/rGxo8kSbDDDTWcpJ/zjj56mZu3SAc=;
  b=lONRCnsQuzXVgLjYYG5Zh9T7MJppj3gscRqS1xGjZo0ejxBcXJnbjgeZ
   QSPTrUL7lQF9boVYj3gsIPEfJ2MQwhYfhqzQ6dcdl76OMPECdhHTmOEbb
   DayO93nH+sabs6Hwad+wrUiZV2V7WfLSh9l2o280qbPJyFwW5hL06a/6P
   rfoiVJANuJ2ddbexc4jiKH/BL6EC4CG0IeMhuoBzb8BRAUPCThdi6Xvtd
   uja3f9qRk2F56tHQMqS8jlSmOkeqCCf/vElMCafw7wsf9KTdaQ4jZ5lVa
   2ApTJR9tANNvGRUHaU4Gnzfs4z1wCnh1kij+rYnJvOhAp+Ap1GmhE+hhF
   Q==;
X-CSE-ConnectionGUID: jpl8ZfH3Te+J429A/MhGDw==
X-CSE-MsgGUID: moVf7QYvQsiWPYzgFnOu+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508280"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508280"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:27:02 -0700
X-CSE-ConnectionGUID: Od3LSTqsQnOn2KvL010oxQ==
X-CSE-MsgGUID: kbOY5eqJSnCdlnlCZ7gOdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414763"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:58 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 16FC82FC54;
	Fri, 25 Sep 2026 14:26:57 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 6/6] ice: size ring stats arrays from the final queue count
Date: Fri, 25 Sep 2026 15:15:48 +0200
Message-ID: <20260925132636.123300-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ring stats arrays were sized in one place and indexed in another,
with nothing reconciling the two. ice_vsi_alloc_stat_arrays() gave up as
soon as a container existed:

	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;

while ice_vsi_alloc_ring_stats() walks the arrays with
ice_for_each_alloc_txq() / ice_for_each_alloc_rxq(), that is, up to
vsi->alloc_txq / vsi->alloc_rxq. Whenever the arrays are shorter than
the count ice_vsi_set_num_qs() ends up computing, that loop reads and
stores past the end of the kmalloc'ed pointer arrays.

Deferring to "the rebuild path" does not hold. It cannot get the size
right, and some paths never call it at all.

ice_devlink_reinit_down() is one of the latter. It calls ice_vsi_decfg()
directly, which does not free pf->vsi_stats[], and nothing on the way
down releases the main VSI's entry either: ice_dealloc_vsis() runs only
from ice_init()/ice_deinit(), and the single entry that ice_unload()
does drop is the control VSI's, via ice_deinit_fdir(). The main VSI's
arrays therefore survive the reload, while ice_devlink_reinit_up() runs
ice_vsi_cfg() and recomputes the count from
netif_get_num_default_rss_queues(), which follows cpu_online_mask.
Sizing the arrays with most CPUs offline and then onlining them is
enough, no VF involved:

  for c in /sys/devices/system/cpu/cpu[0-9]*/online; do echo 0 > $c; done
  echo 0000:18:00.0 > /sys/bus/pci/drivers/ice/unbind
  echo 0000:18:00.0 > /sys/bus/pci/drivers/ice/bind
  for c in /sys/devices/system/cpu/cpu[0-9]*/online; do echo 1 > $c; done
  devlink dev reload pci/0000:18:00.0 action driver_reinit

The unbind/bind is what makes the arrays actually be allocated at the
small size; a reload alone only reuses them.

The read then runs off the end of tx_ring_stats[] and picks up whatever
follows it in kmalloc-32. Here that was a string, 0x74756f5f6c697475
spelling "util_out" in memory order. It is stored into ring->ring_stats
and faults on the first dereference, in ice_setup_tx_ring(), call trace:

 RIP: 0010:ice_setup_tx_ring+0x8d/0xe0 [ice]
  ice_vsi_setup_tx_rings+0x2a/0x80 [ice]
  ice_vsi_open+0x28/0x170 [ice]
  ice_open_internal+0xc9/0x160 [ice]
  __dev_open+0x138/0x2b0
  __dev_change_flags+0x1d5/0x250
  netif_change_flags+0x21/0x60
  do_setlink.constprop.0+0x336/0xcf0
  rtnl_newlink+0x4a4/0x9b0

Even where the rebuild path does run, it sizes the arrays before
ice_vsi_decfg() returns the queues to the PF pool, and for an
ICE_VSI_PF VSI with no explicit request it derives the count from that
shared pool. Nothing serializes it against the recount in
ice_vsi_set_num_qs(), so a concurrent release, say
"echo 0 > sriov_numvfs", leaves the final count larger than the arrays
that were already installed.

ice_vsi_alloc_stat_arrays() runs from ice_vsi_cfg_def(), right after
ice_vsi_alloc_def() called ice_vsi_set_num_qs(), so it is the first
place where the queue count is final. Make it the only authority: keep
the existing arrays when they are already long enough, and otherwise
grow them with ice_vsi_install_stat_arrays(), which carries the
surviving entries over. The check only forces a grow: while both arrays
are long enough they are kept, an oversized one being merely wasteful.
Once either is too short the whole container is replaced, and then the
other one follows the final count too, shrinking if that is what it
takes.

Michal Schmidt hit the same corruption through the VF path, where a
guest raises its queue count with VIRTCHNL_OP_REQUEST_QUEUES and the
following VF reset reconfigures the VSI with the larger count while the
old, shorter arrays are still installed:

 BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
 Workqueue: ice ice_service_task [ice]
 Call Trace:
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

Fixes: 288ecf491b16 ("ice: Accumulate ring statistics over reset")
Reported-by: Michal Schmidt <mschmidt@redhat.com>
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 - new patch, replaces the VF-only fix with one that covers every path
   reaching ice_vsi_alloc_ring_stats() (Clashiko)
 - the reproducers both postdate the cited tag: devlink reinit arrived
   with 31c8db2c4fa7 ("ice: implement devlink reinit action"), the VF
   path with 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
   ice_vf_reconfig_vsi()"). The sizing itself went wrong in the cited
   commit, hence the older tag (Clashiko)
 - drop the follow-up VF resize patch, it could abort a VFLR after the
   hardware had already reset the VF (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 448d3c7780ad..c393d913d037 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -634,27 +634,29 @@ static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
+ *
+ * Runs after ice_vsi_set_num_qs(), so this is the first point where the queue
+ * count is final. Grow the arrays if an earlier sizing guessed too low.
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
 static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 {
-	struct ice_vsi_stats *vsi_stat;
+	struct ice_vsi_stats *old_stat;
 	struct ice_pf *pf = vsi->back;
 
 	if (vsi->type == ICE_VSI_CHNL)
 		return 0;
 	if (!pf->vsi_stats)
 		return -ENOENT;
 
-	if (pf->vsi_stats[vsi->idx])
-	/* realloc will happen in rebuild path */
+	old_stat = pf->vsi_stats[vsi->idx];
+	if (old_stat && old_stat->tx_ring_stats_len >= vsi->alloc_txq &&
+	    old_stat->rx_ring_stats_len >= vsi->alloc_rxq)
 		return 0;
 
-	vsi_stat = ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi->alloc_rxq);
-	if (!vsi_stat)
-		return -ENOMEM;
-
-	pf->vsi_stats[vsi->idx] = vsi_stat;
-	return 0;
+	return ice_vsi_install_stat_arrays(vsi, vsi->alloc_txq,
+					   vsi->alloc_rxq);
 }
 
 /**
-- 
2.51.1

