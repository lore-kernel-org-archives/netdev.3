Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A04D0A14
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548101; cv=none; b=EJXsZrEAHhrhkgPKqrRB8myVJhhqAmjHk7w+dhSfYE+gkVGGiWzepYVh3TRaikeHBd0XiQCSeG1emjG3p21i84PTj8Z3df6LWcRjFVWp88yk09f85PMVBmTZfW/QA9Z6rLE6YNVFS7U1AKYAOD2u7QIfu8I8oyx3zD9+P/pxZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548101; c=relaxed/simple;
	bh=ZDsN0eq5/mxh8k5VilroUP9LRauv2GW83vbX2MoSXog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIwViO+YGA+X6GtiaJl56LnxBEHrITZlD4mTpYIUDBytw5ZkeQOn12gZ1Bgi3mq74FxQGZb+miFIlddx4fwf4AP3xIajO8LISyWDXqxeDC9o33D1NET+NwJBzpKLgPMq5/r786m9IHUzejAg9aStaAE6AAEfR4m6KoBWyFcuZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlg1frOU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlg1frOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791548087; x=1823084087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZDsN0eq5/mxh8k5VilroUP9LRauv2GW83vbX2MoSXog=;
  b=hlg1frOUdit+h69Tp8azKkJyD05X52VgqImIB2G9Ja1OZmagu0linY9P
   x6qablsuU9vG61RHUOAS17PZEn0q+2PKkoopwAk9RsrRNZPeoxksh7mQK
   +T+RDSLpdPXwFneH2uYPLAQZL/F9+IrNZVTWARr86/6xK5jzvH/jsIcRw
   3p+ZYNC4UDMHxGorqcIV2Tp9AkvwDq/caaFtILHoFJnTPH/d1lA3pddKL
   mhRw7FSggEy+aJMRaTvQFty500YDgIIXl9qiQK41BFcO6JPNit74Q64dK
   9WT657VKS/Fj3vD/4f8VZA8Tr9mf/8aZdBpqFQly1BG+rHE7DaEUgul5h
   w==;
X-CSE-ConnectionGUID: gjQYnmb7TF2JZTHjFdemsg==
X-CSE-MsgGUID: MugcowPnTuynPRUAueLGmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251062"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251062"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:14:46 -0700
X-CSE-ConnectionGUID: O7qflKM9Tdmx8yRbDGvcZw==
X-CSE-MsgGUID: HILfhuYpSlepiH+H7S2zkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420368"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:41 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A2A7228799;
	Fri,  9 Oct 2026 13:14:38 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
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
Subject: [PATCH net-next v2 00/14] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Fri,  9 Oct 2026 14:04:11 +0200
Message-ID: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also available here
https://github.com/pkitszel/linux/tree/xlvf-v2


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

Ahmed Zaki (1):
  iavf: use new opcodes to request more than 16 queues

Brett Creeley (2):
  ice: add VF queue ena/dis helper functions
  ice: introduce handling of virtchnl LARGE VF opcodes

Przemek Kitszel (11):
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
  ice: support up to 256 VF queues

 .../networking/devlink/devlink-resource.rst   |   5 +
 .../networking/devlink/devlink-shared.rst     |  19 +-
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  21 +-
 .../net/ethernet/intel/iavf/iavf_register.h   |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 .../net/ethernet/intel/ice/devlink/resource.h |  26 +
 drivers/net/ethernet/intel/ice/ice.h          |   3 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  52 +-
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
 include/net/devlink.h                         |  37 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   3 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 134 +++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 334 ++++++++-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 .../net/ethernet/intel/ice/devlink/resource.c | 644 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 107 ++-
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 103 +--
 drivers/net/ethernet/intel/ice/ice_lag.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 178 +++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  60 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  15 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  41 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  69 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 468 +++++++++++--
 drivers/net/ethernet/intel/ice/virt/rss.c     |  37 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  42 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |   6 +-
 net/devlink/resource.c                        |  88 ++-
 net/devlink/sh_dev.c                          |  57 +-
 41 files changed, 2478 insertions(+), 296 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

-- 
2.51.1

