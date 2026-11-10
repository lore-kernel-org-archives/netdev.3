Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320150;
	b=Ggwzt0i4ATJ5oUzfiX8JCAFrOEBaxJpdkZvJglKj8O1Og/ZxMov6enJA4B+syZJaNT+i
	 OR3Q+x4Z3bJv8Lc356hyL5Ci56dX/KvIvhobVfzfManb2qfbEQ6ZiMLXxERYHoRt0TCU3
	 2VxktDQKY0gWCV9ZgEXuJCUPAAV5WyMT7KfK79p27zQ+wdAFoWHlGOi1aO/mqJwAGm1Cw
	 ffjv7jkR8wUzc+U+1OWolJeT5mHeb+9e16p+YyzTV59AdPX75m05nvc/jMCmfl+iKbzru
	 UI4wjRmcrfYYZEQpP8CGb2wxU0LFSRe8fBm20HOfXviyPb6k7j1uzz4czeWb5npjX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320150;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V+HqbEKpycOnI+Oi3toN2l8P7qJ1Trg8OBj+O3djaP4=;
	b=JkzJD8rusW/dt3OzPn/qHzGoZPfEKpzT6iYntcGwRVjWfLjYUTRtkLqwQOVF7HSTp/WC
	 gRWcnPsv4Q6LOBfyPsE7VurwA6YNGkAfiEhGC6rP3nOvq7LfzpK648MvsJS2Txj4C7V8t
	 QtrXT8TzPETMMkYxjYNZDQPA3XsirHZPzgGwpsPIcRhuSgo2I28/oBgSGM2RWfF/jZ/lE
	 UB2A/y52a7eU5IbQ3tPHV1xJPaMC0JvOqUbJf55DuZxUU26YhdoHLOkAKLg841o3xyt8s
	 6N7KQLPLnY5tPRjoPnUUFBx7110E0CIxMFxlEc18a1gLwZUySL93oxliUfeGiHN5ixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V1e3aMJT;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA24606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V1e3aMJT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320148; x=1825856148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JvV/9NQF9k3TDRZ4vK4C7m9U/yv7LBBXYiFGPsaV8tI=;
  b=V1e3aMJTia/rytZRlJjQs9WfuhAkKbo+46CrWRBE1giKFIzH/zi1SNNm
   G4dpacGOWQWP8qf/k4iRIY4l3/lhiVGou2pj+W5xl1PAxFqvtKhm2gXpG
   NwZWVP0OeWSB3y62FRM1Iu4KuTLTrAiJJtoZ1IbWKpBwlVxB7FHj7dkbb
   pa9D5KM5+j7YElktlOeYPhW2YYwA/esMUk5kz32pwxCeLXjDH3yLtqTTs
   SrVqqP6OsiiTmcs0XjGXBXw0mSSEBadilLBSwiinNOZBP9BISYX2P1L4N
   zcyg4UiBni3yb66l4FbmY//BsF1t8d44MVXLnRT94BFLOO2bRyqxbFHmR
   A==;
X-CSE-ConnectionGUID: Yx/+5otPTlGul/MVkBBGWg==
X-CSE-MsgGUID: yug1CEjdRaKIdc9CDy5ieg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091039"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091039"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:15:47 -0800
X-CSE-ConnectionGUID: opzG1KYoRgSdb6rINxoWFA==
X-CSE-MsgGUID: 50B3qpw1QsO6CP0WhJzO9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327574"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:15:42 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C56E52FC57;
	Tue, 10 Nov 2026 14:15:39 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
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
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 00/15] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Tue, 10 Nov 2026 15:07:09 +0100
Message-ID: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also available here
https://github.com/pkitszel/linux/tree/xlvf-v5

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
3. (minor) Add devlink_alloc_drv(), to allocate a devlink instance for
   a device on behalf of another driver. ice uses it for the VF devlink
   instance, which has to be owned by ice regardless of the driver bound
   to the VF device.

There are also patches for Admin Queue extension, GLOBAL RSS LUT
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
 * lock inversion between rtnl and PF devlink lock: mqprio in channel
   mode calls ice_tear_down_devlink_rate_tree() under rtnl, while
   devlink reload takes rtnl under the devlink lock; pre-existing, this
   series follows the reload order: devlink RSS LUT change of a PF
   takes rtnl under the devlink lock

Some of the pre-existing issues reported by AI are fixed in a separate
series:
https://lore.kernel.org/netdev/20261102105346.30739-1-przemyslaw.kitszel@intel.com

Thanks to Petr Oros for testing v4, both problems he has found are
fixed in v5 (the first two items below):
https://lore.kernel.org/netdev/20261105122558.1701877-1-poros@redhat.com

v5:
 * ice: keep reporting the 64 entry RSS LUT to VFs without
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, and repeat their LUT over the bigger
   LUT of the VSI; iavf before this series allocates its LUT buffer
   only once, and overflowed it after a bigger LUT was assigned (Petr)
 * ice: grant REQUEST_QUEUES only when the VF fits in one free range of
   Tx and Rx queues, and offer no more than that in the reply to a too
   big request; requests of 64 or 256 queues fragmented the PF queue
   space, and VFs came up with unprogrammed queues, as scattered
   mapping is not implemented for VFs (Petr)
 * ice: mark VFs disabled when preparing for PF reset, until
   ice_reset_all_vfs() rebuilds them, so devlink can't change their RSS
   LUT in between
 * ice: register VF devlink resources before devl_register(), and
   unregister them after devl_unregister(), so the VF devlink instance
   is never visible without them
 * ice: set the default rss_size on every VSI config again, as before
   this series, and clamp it to what the RSS LUT can address for all
   VSI types, under rss_lut_lock
 * ice: keep the NAC topology in safe mode caps, secondary NAC PFs
   collided with primary ones in the devlink RSS LUT table
 * ice: widen num_ring_{rx,tx} of struct ice_q_vector to u16, mapping
   all 256 queues of a VF to one vector wrapped them around
 * ice: LAG: call ice_aq_cfg_lan_txq() for up to U8_MAX queues at
   a time, 256 VF queues were sent as 0
 * iavf: ethtool -L: validate rx, tx and other counts before returning
   early for an unchanged combined count; keep the queue request
   pending until it is sent
 * iavf: clear adapter->vsi_res together with adapter->vf_res, and skip
   the rest of GET_VF_RESOURCES reply handling when parsing it fails
 * iavf: cap the legacy VIRTCHNL_OP_{EN,DIS}ABLE_QUEUES bitmaps at 16
   queues
 * iavf: report the RX ring count limited to the PF RSS region, the
   default LUT made by ethtool core for ethtool -X was rejected
 * devlink: document @drv lifetime and device lock rules of
   devlink_alloc_drv()
 * smaller fixes, mostly after Sashiko review; per-patch changelogs are
   under "---"

v4:
 * devlink: return -EMSGSIZE directly on
   devlink_resource_occ_size_put_legacy() failure (Jakub)
 * devlink: document in devlink-info.rst that an instance created for
   another device reports the name of the creating driver
 * ice: declare rel_err at function scope, a declaration right after
   a label does not build with GCC < 11 and breaks sparse (Jakub)
 * ice: take rtnl when devlink changes the RSS LUT of the PF, and tell
   the ethtool core when the user RSS LUT is dropped, on devlink LUT
   change and on reset; drop the -EAGAIN checks from get/set_rxfh
 * ice: reject devlink RSS LUT changes while a reset is in progress, drop
   global RSS LUTs of the PF from the table already in
   ice_prepare_for_reset(), as FW frees them on reset
 * ice: log when a reset discards a devlink RSS LUT assignment, keep the
   specific extack message and the real errno when a LUT change fails
 * ice: take the Q_OPT section from vsi->info under rss_lut_lock when
   toggling the RDMA filter
 * ice: document the devlink resources and the VF devlink instance in
   ice.rst
 * ice: limit queue chunks of the LARGE VF opcodes to ICE_MAX_QS_PER_VF;
   set the q_vector and ITR fields in VIRTCHNL_OP_MAP_QUEUE_VECTOR, as
   VIRTCHNL_OP_CONFIG_IRQ_MAP does
 * ice: after a PF reset, lower the queue count only of VFs that lost
   a bigger RSS LUT, and only to 16
 * ice: restore the VF RSS LUTs after reset outside of rtnl, cap
   REQUEST_QUEUES at 16 for VFs without VIRTCHNL_VF_LARGE_NUM_QPAIRS,
   report ICE_VF_VSI_ID as vport_id in GET_MAX_RSS_QREGION reply
 * ice: do a pending deferred VF reset before handling the next message
   from that VF, clear ICE_VF_STATE_NEEDS_RESET on every VF reset, and
   re-run the service task at once if a deferred VF reset was scheduled
   during its pass
 * ice: don't create VF devlink instance without VF pci_dev, e.g. on s390
 * ice: report the VF queue allocation in num_queue_pairs also with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, as in legacy mode
 * ice: use scoped_guard() instead of guard()
 * iavf: send queue configuration and queue to vector map one message per
   watchdog run, instead of polling for each reply with a 1s timeout;
   stop sending on a PF NACK
 * iavf: ethtool -L: let the watchdog send the queue request, instead of
   failing with -EBUSY whenever another op is in flight
 * iavf: init: wait for the outcome of the queue request before other
   extended caps; ask for up to one queue per CPU, take the request as
   granted only when PF gives that many, and on a denial go on with what
   we have; check IAVF_VF_ARQLEN1 while waiting, as the PF reset event
   could be lost
 * iavf: reset aq_wait_count when init starts over after the PF stopped
   responding, forget the queue request there
 * iavf: refill the RSS LUT when the RSS region changes across a reset,
   kzalloc() the RSS key and LUT on reallocation, reject ethtool -X LUT
   entries outside of the PF RSS region
 * iavf: num_queue_pairs is the VF allocation also with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, ethtool -L max is the PF RSS region
 * iavf: limit MSI-X budget to 64 queue vectors, program ITR of vectors
   16..63 via VFINT_ITRN_64, change ADQ total_qps to u16
 * many smaller fixes after Sashiko review; per-patch changelogs are
   under "---"

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
 * devlink: add devlink_alloc_drv(), so ice owns the VF devlink
   instance, regardless of the driver bound to the VF
 * ice: unregister VF devlink on ice_start_vfs() failure
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

v3:
https://lore.kernel.org/netdev/20261015185454.6332-1-przemyslaw.kitszel@intel.com

v4:
https://lore.kernel.org/netdev/20261103141646.303620-1-przemyslaw.kitszel@intel.com


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

 .../networking/devlink/devlink-info.rst       |   2 +
 .../networking/devlink/devlink-resource.rst   |   5 +
 .../networking/devlink/devlink-shared.rst     |  19 +-
 Documentation/networking/devlink/ice.rst      |  74 ++
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  35 +-
 .../net/ethernet/intel/iavf/iavf_register.h   |   2 +
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 .../net/ethernet/intel/ice/devlink/resource.h |  28 +
 drivers/net/ethernet/intel/ice/ice.h          |   9 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  55 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  36 +-
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 drivers/net/ethernet/intel/ice/virt/rss.h     |   1 +
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   4 +
 include/linux/net/intel/virtchnl.h            | 136 ++-
 include/net/devlink.h                         |  41 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  49 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 261 +++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 291 ++++++-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 .../net/ethernet/intel/ice/devlink/resource.c | 803 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 115 +--
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  91 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  25 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  54 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 200 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  64 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  19 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  52 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  84 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 574 +++++++++++--
 drivers/net/ethernet/intel/ice/virt/rss.c     |  54 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  39 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |   6 +-
 net/devlink/core.c                            |  24 +
 net/devlink/resource.c                        |  97 ++-
 net/devlink/sh_dev.c                          |  57 +-
 45 files changed, 3099 insertions(+), 351 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

-- 
2.51.1

