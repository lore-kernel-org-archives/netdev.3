Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9F3E7BCC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090528; cv=none; b=bcnJBRmQqR9FULh7sqanX0aZmeS/XS5OH2iGPJsMf/rnKxWDnEfHNjBifT/ad1Kcs/WAp+UuBPYddq1ztQYGE+CxpBesFTapon2KUwierDOqbZl1uRUt1pxdml4O/egE7ngIHzDncrD93kbImy3lrRhuCGjS8ZgxjC/EvvQn7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090528; c=relaxed/simple;
	bh=9vptynbq6QxGROy7LebFE8pF/lRnocskd2YAhoCa0xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbfwDvRw460tMuXttrj4rYUr4I3rAjLIy5Hs26mtAhEd3KiEcvcSr0iHt/e02VHWvbpCkhuKQNeS8r/zW82YS5KYM6x2sJ+b5vxm4CwQSRsvE7nKX7YD4sCG7VJgXweiVVknzNHEEPgTKua32OG3LeibCCfphbQaLYk0Op2/z8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZb7ly6n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZb7ly6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090517; x=1823626517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9vptynbq6QxGROy7LebFE8pF/lRnocskd2YAhoCa0xM=;
  b=ZZb7ly6nHgn7xrFyG7oGy1U1sqOQrK+hOs2WIvza215NgVGnhOCcERqs
   PU0X5pkoo26mReNsGQ6Rj5QdYdWfJiGSWI0Pb5pdC1AwyTjhwogTBsNIq
   NA/eVJpnG1Sz6XjoQNe/jdPLLCKqlSGk4vTqe4oX9Kqy3X71MqdpdTLBM
   OzUJzWBuAh29oV43LVXIhFeDIi/vP6geNdTdc78+rxCgej0KNeDWGDSxr
   ECs2M1gXbUsj58zAhD+IB8eNPJ6KeLRY702fILOezmlmX0loH91XRyiP9
   qn8jgymiKZLNwyMpVENsMl9Ey89SHKjli9axat2sw8y92GDZzmzgig1Oe
   w==;
X-CSE-ConnectionGUID: eMV5oKxQQJG9nG7YH/e1tw==
X-CSE-MsgGUID: 1aPGbT2nRtKzN1z+7q8vSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="757920"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="757920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:16 -0700
X-CSE-ConnectionGUID: B6YKlKH3R7eEMTuosSIIyw==
X-CSE-MsgGUID: iTdBVK+sQ1yKswS1mZXHzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003131"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:06 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 065D032EC3;
	Thu, 15 Oct 2026 19:55:03 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 00/15] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Thu, 15 Oct 2026 20:51:11 +0200
Message-ID: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also available here
https://github.com/pkitszel/linux/tree/xlvf-v3

The purpose of this series is to allow iavf to use more than 16 queue
pairs, in two modes: up to 64 and up to 256 queue pairs.

In order to support more queues for VF, we must give it a bigger RSS
table (GLOBAL LUT or PF LUT). There are 16 GLOBAL LUTs on E810, and one
PF LUT for every PF on given card. Both kinds could be (re)assigned to
a VF, while a PF must hold at least one of them at any given moment.
GLOBAL LUT allows VF to use up to 64 queues, PF LUT lets it use up to
256 queues.

RSS LUTs are exposed to the user for assignment via devlink resources
API, which I have extended to make it possible.

Devlink changes:
1. Extend shared devlink by two callbacks, that give the driver
   a constructor/destructor for the priv data attached to the shared
   devlink instance. The constructor gets an additional param, used in
   "ice: represent RSS LUTs as devlink resources". mlx5 is touched only
   to adjust to the API change.
   ice uses the shared devlink instance as a "whole device" aggregate
   over all PFs on given card, instead of its custom xarray.
2. Extend devlink resources API to allow user to assign resources.
   Before, only the driver could assign resources, without any way for
   the user to interact. Now the driver could register an occupancy
   setter (.occ_set()) for a resource. ice RSS LUTs are exposed that
   way. It was proposed as an RFC in Feb 2025, link in the patch.
3. Add devlink_alloc_drv(), a variant of devlink_alloc() that takes the
   owning driver explicitly. ice creates a devlink instance for each of
   its VFs, while the VF device could be unbound, or bound to iavf or
   vfio-pci at that time.

There are also patches for, Admin Queue extension, GLOBAL RSS LUT
alloc/free, and two rather big "new opcodes" patches, by Ahmed (iavf)
and Brett (ice).

Finally there is a patch that adds devlink instance for VF and
registers devlink resources on it, combined with all the glue code to
make actual use of the whole series and accept the larger number of
queues for VF. This (the last) patch contains usage examples.

There is one resource added that just groups GLOBAL and PF LUTs under
it, so there are 3 rows of data for each device (PF/VF/whole-dev):
$ devlink resource show pci/0000:18:00.0
pci/0000:18:00.0:
  name rss size 1 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 0 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none

Technically the aggregate "name rss" line could be eliminated, with
just the two last ones kept (then renamed to "rss_lut_2048" form, from
the current "rss/lut_2048"). I like it as it is, but this is just an
opinion, I'm open to discussion.

Things AI reports but I don't want to change:
 * hardening against a malicious or buggy FW: we have to trust the FW
 * hardening of the VF against a malicious or buggy PF: likewise, VF has
   to trust its PF; in particular, I'm not adding checks for the PF
   reporting qregion_width so big that BIT(qregion_width) in
   iavf_fill_rss_lut() overflows and yields a modulo by zero
 * non-atomic updates of iavf adapter->flags: pre-existing pattern in
   the whole driver, out of scope of this series
 * lock inversion between PF devlink lock and pf->vfs.table_lock:
   ice_tear_down_devlink_rate_tree() takes them in the opposite order
   than ice_start_vfs() -> ice_eswitch_attach_vf(); pre-existing, will
   be fixed separately; this series takes table_lock first

v3:
 * ice: fix rollback of VF queue configuration to disable queues by
   their IDs, not by qpair index, as the config could be now split into
   many virtchnl messages
 * ice: register PF devlink resources only in the regular probe path,
   not in FW recovery mode
 * ice: don't free the user RSS LUT in ice_vsi_decfg(), it was done
   outside of pf->rss_lut_lock, and ice_vsi_cfg_def() frees it anyway
   when the LUT size changes
 * iavf: auto-request queues in LARGE mode only at init, not on every
   reset, and only after VSI and RSS fields are initialized
 * iavf: schedule a VF reset when RSS key/LUT reallocation fails
 * devlink: keep size of .occ_set() resources in sync with the getter;
   WARN on registering only one of .occ_set()/.occ_get()
 * devlink: new patch, add devlink_alloc_drv(), so ice owns the VF
   devlink instance, regardless of the driver bound to the VF
 * ice: create VF devlinks only after all VFs are started, not while
   ice_start_vfs() can still fail
 * ice: reject out of range itr_idx in VIRTCHNL_OP_MAP_QUEUE_VECTOR
 * ice: fill the new RSS LUT under rss_lut_lock, keep the PF LUT zeroed
   when RXHASH is disabled
 * ice: restore VF aggregator node accounting in ice_vsi_decfg()
 * ice: drop PF RSS LUT ownership also in ice_deinit_pf(), as
   ice_vsi_decfg() skips it after a NO_INIT VSI rebuild
 * ice: restore default RSS LUT assignment of PF and its VFs after
   reset, as FW drops it
 * ice: check VF VSI for NULL in ice_vc_request_qs_msg()
 * ice: fix RSS LUT tracking on dual-NAC E825C: each NAC numbers its
   PFs and global LUTs from 0, so offset secondary NAC PFs by 4, and
   keep a separate global LUT table for the secondary NAC
 * ice: derive VF rss_size from its queue count and LUT capacity on
   each VSI config, instead of keeping a stale value
 * ice: wake up service task when scheduling a deferred VF reset
 * ice: lower VF queue count to the capacity of its new RSS LUT when the
   LUT shrinks, instead of keeping the queues allocated and offering them
   to iavf without VIRTCHNL_VF_LARGE_NUM_QPAIRS

v2:
 * drop "ice: simplify ice_vc_dis_qs_msg() a little", already applied
 * devlink: propagate the .shd_init() error to the caller, so
   devlink_shd_get() returns ERR_PTR() now; register the shared
   instance only after successful .shd_init(); document the new ops
 * devlink: document the .occ_set() mode of resources
 * ice: prefix the shared devlink id with "ice:", handle errors of
   devl_nested_devlink_set()
 * iavf: stop multi-message virtchnl ops (queue config, queue-vector
   mapping) at the first error or PF NACK, keep the op pending on
   timeout
 * iavf: fix queue and RSS (re)negotiation on init, reset and
   ethtool -L
 * ice: serialize devlink RSS LUT changes with ethtool -x/-X/-L, RXHASH
   toggle and VSI (re)configuration, by new pf->rss_lut_lock; make ADQ
   and devlink RSS LUT reassignment mutually exclusive
 * ice: limit VF queue count and PF RSS size to the capacity of the
   current RSS LUT
 * ice: create VF devlink together with the VF, rework deferred VF reset
 * many smaller fixes, mostly after Sashiko review; per-patch changelogs
   are under "---", together with Sashiko suggestions that I decided
   not to apply, and why

v1:
https://lore.kernel.org/netdev/20260508124208.11622-1-przemyslaw.kitszel@intel.com

v2:
https://lore.kernel.org/netdev/20261009121433.30347-1-przemyslaw.kitszel@intel.com

Ahmed Zaki (1):
  iavf: use new opcodes to request more than 16 queues

Brett Creeley (2):
  ice: add VF queue ena/dis helper functions
  ice: introduce handling of virtchnl LARGE VF opcodes

Przemek Kitszel (12):
  devlink, mlx5: add init/fini ops for shared devlink
  ice: use shared devlink to store ice_adapters instead of custom xarray
  ice: add helpers for Global RSS LUT alloc, free, vsi_update
  ice: rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1
  ice: bump to 256qs for VF
  iavf: extend iavf_configure_queues() to support more queues
  iavf: temporary rename of IAVF_MAX_REQ_QUEUES to
    IAVF_MAX_REQ_QUEUES_VCV1
  iavf: increase max number of queues to 256
  devlink: give user option to allocate resources
  ice: represent RSS LUTs as devlink resources
  devlink: add devlink_alloc_drv()
  ice: support up to 256 VF queues

 .../networking/devlink/devlink-resource.rst   |   5 +
 .../networking/devlink/devlink-shared.rst     |  19 +-
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  21 +-
 .../net/ethernet/intel/iavf/iavf_register.h   |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 .../net/ethernet/intel/ice/devlink/resource.h |  27 +
 drivers/net/ethernet/intel/ice/ice.h          |   5 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  55 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  36 +-
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 drivers/net/ethernet/intel/ice/virt/rss.h     |   1 +
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   4 +
 include/linux/net/intel/virtchnl.h            | 136 +++-
 include/net/devlink.h                         |  41 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   3 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 140 +++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 334 +++++++-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 .../net/ethernet/intel/ice/devlink/resource.c | 722 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 107 +--
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 103 ++-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 175 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  61 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  19 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  41 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  71 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 493 ++++++++++--
 drivers/net/ethernet/intel/ice/virt/rss.c     |  37 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  42 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |   6 +-
 net/devlink/core.c                            |  20 +
 net/devlink/resource.c                        | 100 ++-
 net/devlink/sh_dev.c                          |  57 +-
 42 files changed, 2637 insertions(+), 292 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

-- 
2.51.1

