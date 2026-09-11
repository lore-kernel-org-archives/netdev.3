Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B343F8D9
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126751; cv=none; b=psFpYdSAaK7zfznbnaj/MFva0WG1RDcOr3K6t6Jq7Q27A2LA/wMnwqJpoQ7PgNN4Xn8qjvsnczfbnZiNo71NG5JOFtblj4K0/H4agueeqfkGiWs4znc1bWvHzoEhSsmILgN280DYZriUY4qYNiBg4vX5qKv9MFKABw98rWfamIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126751; c=relaxed/simple;
	bh=x+z2E/BXDzu7x4ByXHSGSYxrc17/+WSJzXzxc0RiUG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roi89DqBtVUrZBeS+02H2ZDobTCfeLBPWjCWZbnX85TMF630BQT9Zb5FEyxCxW97av/KIymhzLRpTZY6slx9O8//EroyKrMjE3FbUFEWGYIkpJfDsASDdXr3AYjhv+qQzeaEidLoDi5zE+RZv25TlfJXpirkmICpLQqwWLBNP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q15Lc78+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q15Lc78+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789126750; x=1820662750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x+z2E/BXDzu7x4ByXHSGSYxrc17/+WSJzXzxc0RiUG8=;
  b=Q15Lc78+c+rRQd1LO/GCPGyWvg7InMoKDeigGYVV30YTV9VgCQunHVBY
   2LQS9CpynLdum6c+s88c4L4YJjGxT7VV5Z/k+lnH740EsstdLohl4PGSc
   XclbAgCA9ePzQb9o211U2mynCgNpUidqLV/3w9erLRcX/wRlBKwateuLd
   pfLt7qCjVvH8Uhl/zmxc8cTRQeTvhrdR9j2vfOIHMCXXXjbiDzDLDvUEF
   fXPSY13yyp9JME7DqiddoanMxQiHYtLsaJ7Vn7bB+HwFuQhuRNr2AMI6k
   KakKyworfefCUxvWmUTdPF+pUMBQs3LX6mjkc2T/Enyzi4CagRWEjFPk/
   w==;
X-CSE-ConnectionGUID: wukJtCanQzyYNLgnm58HMg==
X-CSE-MsgGUID: HrfcKJLtRgGQloe6r1IQmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359908"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="112359908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 04:39:08 -0700
X-CSE-ConnectionGUID: O1RGEEIcSXWa/EvhRmElzg==
X-CSE-MsgGUID: 4YTkuS1ATEqtnqInE6CXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270135865"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:06 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8083A2877A;
	Fri, 11 Sep 2026 12:39:04 +0100 (IST)
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
Subject: [PATCH net v3 5/5] ice: fix stats array overflow when VF requests more queues
Date: Fri, 11 Sep 2026 13:26:20 +0200
Message-ID: <20260911113848.44086-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
alloc_txq/alloc_rxq to the new larger value, but
ice_vsi_alloc_stat_arrays() returns early because the stats already
exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
alloc_txq and writes beyond the bounds of the old, smaller
tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
metadata.

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
 ...
 ==================================================================

ice_vsi_rebuild() handles this correctly by calling
ice_vsi_resize_stat_arrays() before reconfiguration, but
ice_vf_reconfig_vsi() was missing this call.

Fix by calling ice_vsi_resize_stat_arrays() in ice_vf_reconfig_vsi()
before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. The
helper sizes the new arrays with ice_vsi_get_num_qs(), which for a VF
reads vf->num_req_qs directly, so there is nothing else to set up for
it.

See the linked RHEL Jira item for a reproducer.

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Closes: https://redhat.atlassian.net/browse/RHEL-164321
Assisted-by: Claude:claude-opus-4-6 semcode
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3: rebase on top of all the pre-work commits, now there should be neither
    mismatch between the alloc-time and use-time sizes nor regression on
    failed memory allocation
---
 drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
 drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98dcfe..5236088c320b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -67,6 +67,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
+int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
 void ice_vsi_free(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0cd54af40c37..4949f29e538e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3093,7 +3093,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
  *
  * Returns 0 on success and negative value on failure
  */
-static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
+int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
 {
 	struct ice_vsi_alloc_queues_params qs;
 	struct ice_vsi_stats *old_stat;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 27e4acb1620f..fd70a93b9869 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -268,6 +268,10 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
 
 	vsi->flags = ICE_VSI_FLAG_NO_INIT;
 
+	err = ice_vsi_resize_stat_arrays(vsi);
+	if (err)
+		return err;
+
 	ice_vsi_decfg(vsi);
 	ice_fltr_remove_all(vsi);
 
-- 
2.51.1

