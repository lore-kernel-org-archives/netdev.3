Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9464B4885
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638213; cv=none; b=e0HjWCGpTfq8aguxyNdIFOKMMOgnZ6GUeEFmYCLYDbVhYSHU71qrhl02NZHYlYWqG8VRLuELd4ordyWumqnMXt1S8MnrPy8/IjuWAO6toxxz6zWQFZAPz06t8DLe5LsCkj7l4aiHhuHZlIbjs3SGm4D9rBqHbyRvEyTC9odNWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638213; c=relaxed/simple;
	bh=MN2DxHf8TLY4aIv7zDHBhmbNiqc1Vxe97NR6yAmJsIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUyQEdYQdBoDDUGAbtlzIIMtg/zFHsC8muuwrAkQSWLzTCnvWIl37zj0rF6Xl2Vu/j8QTGrEbtChcYijDxtbcq7FYN3NgbTKrZDB9fhL7pXM7x33+on4FwR6XBVJJnBS9IEGZwAm1sfb4VsjPRqu99Ge1xpLrs5ceXF1u0hUq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hl/WSnoZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hl/WSnoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638200; x=1821174200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MN2DxHf8TLY4aIv7zDHBhmbNiqc1Vxe97NR6yAmJsIE=;
  b=hl/WSnoZ3OCuQDpC71AXu5nmZl1r0x6cA739KQeEYdCos5+9/3zWmhX5
   iU+f2vhrAMSOImcMMfOATDPFeB4ca13FsigogY5HCVI0Sj86WZT9B31e5
   lv2x/mKCgyY0hGUfxXPSolEqJuSAfbqR7Wyt8c/CjNCQXH79jtIOz5dId
   glzORfXhzqiOMPWcg59H0j5kKzCVzO4405CffF4fHd9UPHiDmsS4dcR8v
   rbt4JUGRvpPJlOwNgqsHHakGZHGcLgZhSxBm/ggT+9zlNb9mBNuCW4qHL
   FWBDpwpBpk5AIbZx956/3G06Ge9Qhj2FeUpdCKZowJjX4sblyjgkTKxzF
   Q==;
X-CSE-ConnectionGUID: 53pp5iWHSCGxbycThhQNJQ==
X-CSE-MsgGUID: FcOjbwXcTbeeQ98aPs9TEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100706496"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100706496"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:43:15 -0700
X-CSE-ConnectionGUID: WbyJpUSGTfmTAnhqX1YA3w==
X-CSE-MsgGUID: MTuqmTMDSmmR5gym5OjbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269400567"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 02:43:13 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH next-queue v1 0/2] ice: eRoT adapter NVM update guard
Date: Thu, 17 Sep 2026 11:43:10 +0200
Message-ID: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CNSA 2.0 PQC adapters carry an external Root of Trust (eRoT) controller
that performs full-image authentication on every NVM update.  The eRoT
does not allow updating individual components; it requires NVM, OROM,
NetList, and Manifest all together in one shot.  If you hand it a partial
PLDM capsule today, firmware rejects the write mid-session (i.e. partway
through the PLDM component transfer sequence), after the erase has
already been issued.

Patch 1 detects eRoT presence.  Newer firmware advertises it directly
via device capability 0x004E; older firmware does not, so there is an
NVM-based fallback that reads the eRoT presence fuse (SR 0x1016 bits[1:0]).
The result goes into hw->erot_present and is surfaced as ICE_F_EROT.

Patch 2 uses that flag to gate the flash path.  Component identifiers
are tracked as the PLDM component table is walked, and if the full
required set is not present when ice_flash_component() is first entered,
the whole update is rejected with -EINVAL and a netlink error message
before a single flash bank is touched.  The Manifest component itself is
only ever accepted on eRoT adapters in the first place.

Testing: validated on real eRoT-equipped hardware.

Aleksandr Loktionov (2):
  ice: detect eRoT presence via device capability
  ice: reject partial NVM update on eRoT adapters

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  7 ++
 .../net/ethernet/intel/ice/ice_fw_update.c    | 80 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  3 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 39 ++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.h      |  5 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |  6 ++
 include/linux/net/intel/libie/adminq.h        |  1 +
 9 files changed, 143 insertions(+)

-- 
2.52.0
