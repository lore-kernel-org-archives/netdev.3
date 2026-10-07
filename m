Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32041442C
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360432; cv=none; b=km4SIr3obc9JrwGI+ucfko/hZxj/zUWeMcfPMngYAqyBo1C0hmtvXYIG2sANUdfqlMl2VZj4pFWNcDJrU0ooFyKptIhsgjYsiVOEmaXMFJwhvB7rRbXaNs9VaW3uo8nrGrEy2XJ34d5mdZkdMpQpw62eAt0nBC77QCO0gI99Tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360432; c=relaxed/simple;
	bh=romjlo+9XGi6AHS6ZJhdS/i4Eu/Sc0BFFjJspgHaBRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUd1YJAIQZoPPUBceh2TwyB8fREn0eYQLhC60PRA1AStVINpjk5H34YAQGPU9VIkliMpSEAx5C2dzEzLgqsqj4I9n0JD17L9G/+2sOVl+rOAum+HA3NaNiMONS8xf98XUFtTUdyiDIAbe9LLWcVmCBjojF5Nw8zm0rvEFXPTmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fydh8RXe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fydh8RXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791360429; x=1822896429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=romjlo+9XGi6AHS6ZJhdS/i4Eu/Sc0BFFjJspgHaBRQ=;
  b=Fydh8RXe/cVk2ESxvkcHrTIBLhX8I+YFPJQZ2ceLcRhPNCvg+XGDyXIb
   abO/mJoRjXmj7ePjXKumkKPKeg7OqXAuQGb9owOtbjvLd0qa3ZGmQIlZM
   M7poJ5kpn38haUOFPzkaEngt7fdcM312xuv0ztH1RySebnTlpdyfUVNr/
   2et3QAByGDkpx9AO+BIhDUDcWjFk3pssbFYIBK9zatCeZ7qb4Bb2zGiw0
   0qgZg09suwbFfWsX0+JXBpcLl2lROZ7fLDNhXk+SfiUYBymSpGPpaW1ci
   g0rwfucjdK8hYNqFfNcSqWnm6z4R9vcibpymONdGVlchaPrVwk/4AZJZU
   w==;
X-CSE-ConnectionGUID: 3wqRgSIQQVmBXCDMO/Y/EA==
X-CSE-MsgGUID: EK5SLvHCSFOkUh0uPuCc+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108532"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="108532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 01:07:07 -0700
X-CSE-ConnectionGUID: 0Mk0mLUSRr2GF0Bs/rpY/w==
X-CSE-MsgGUID: CouYNn0jRoy1mAI6wVYmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="315405490"
Received: from aravind-dev.iind.intel.com ([10.190.239.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 01:07:02 -0700
From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	tejas.upadhyay@intel.com,
	himal.prasad.ghimiray@intel.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	raag.jadav@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	pratik.bari@intel.com,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	YiPeng.Chai@amd.com,
	jinzhou.su@amd.com,
	cesun102@amd.com,
	lijo.lazar@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Subject: [PATCH v2 0/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Wed,  7 Oct 2026 13:33:52 +0530
Message-Id: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory page offlining support tracks bad VRAM pages and currently
only exposes them through debugfs (vram_bad_pages), which is not a
stable ABI. Add a proper userspace interface using the drm-ras
generic netlink family.

Introduce a new node type DRM_RAS_NODE_TYPE_RETIRED_RESOURCES which
enumerates hardware resources that have been permanently taken out of
service. Each node reports a single resource type, identified by its
node-name, so the resource type is implied by the node rather than
carried per entry. The per-entry payload stays extensible: each entry
carries a single type-specific nested attribute, so future resource
types can be added without touching existing consumers. VRAM pages are
the first supported type, reported via the vram-page nest as
{address, size, status} where status is one of retired/pending/failed.

A single operation is added on the node:
 - GET_RETIRED_RESOURCES: dump the resources retired on the node. The
   dump opens with a leading capacity summary entry (max-pages
   inside the vram-page nest, i.e. the maximum number of pages that
   can be offlined, with no address/size/status), followed by one
   entry per retired resource. Userspace derives the retired/queued
   counts by counting entries.

The netlink interface is described by the YAML spec
Documentation/netlink/specs/drm_ras.yaml. The following files are
generated from that spec with tools/net/ynl/ynl-regen.sh and must not
be edited by hand:
 - include/uapi/drm/drm_ras.h        (uapi attribute/command enums)
 - drivers/gpu/drm/drm_ras_nl.c      (generated policy and op table)
 - drivers/gpu/drm/drm_ras_nl.h      (generated declarations)

Eg:
$ sudo ./tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/drm_ras.yaml \
     --dump list-nodes

[{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name':'correctable-errors',
 'node-type': 'error-counter'},
 {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name':'uncorrectable-errors
', 'node-type': 'error-counter'},
 {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name':'vram-retired-pages',
 'node-type': 'retired-resources'}]

$ sudo ./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/drm_ras.yaml  --dump  get-retired-resources \
--json '{"node-id": 2}'

[{'node-id': 2, 'vram-page': {'max-pages': 100}},
 {'node-id': 2, 'vram-page': {'address': 12807041024, 'size': 4096,
 'status': 'retired'}},
 {'node-id': 2, 'vram-page': {'address': 12809400320, 'size': 4096,
 'status': 'retired'}}]

The first entry is the capacity summary (max-pages); subsequent entries
are the retired pages.

v2:
 - Rebase on drm-tip
 - Drop the per-entry resource-type discriminator attribute; the type is
   now implied by the node (node-name), which reports a single type.
 - Fold all VRAM-page fields, including the retirement status, into the
   vram-page nested attribute; the top-level entry is just
   {node-id, vram-page}. (Rodrigo)
 - Drop the separate GET_RETIRED_RESOURCES_INFO operation. The capacity
   (max-pages) is now emitted as a leading summary entry inside
   GET_RETIRED_RESOURCES (max-pages in the vram-page nest, no status);
   offlined/queued counts are derived by counting entries.

Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>
Cc: Ashwin Kumar Kulkarni <ashwin.kumar.kulkarni@intel.com>
Cc: Pratik Bari <pratik.bari@intel.com>

Aravind Iddamsetty (2):
  drm/xe: Expose retired VRAM pages via drm-ras
  drm/xe: Remove bad VRAM pages debugfs interface

 Documentation/netlink/specs/drm_ras.yaml |  91 ++++++++++-
 drivers/gpu/drm/drm_ras.c                | 174 ++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  12 ++
 drivers/gpu/drm/drm_ras_nl.h             |   2 +
 drivers/gpu/drm/xe/xe_debugfs.c          |   2 -
 drivers/gpu/drm/xe/xe_drm_ras.c          |  77 +++++++++
 drivers/gpu/drm/xe/xe_drm_ras_types.h    |   3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     | 190 ++++++++++++++---------
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   4 +-
 include/drm/drm_ras.h                    |  74 +++++++++
 include/uapi/drm/drm_ras.h               |  48 +++++-
 11 files changed, 592 insertions(+), 85 deletions(-)

-- 
2.25.1

