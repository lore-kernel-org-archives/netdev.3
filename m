Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E647F799
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254760; cv=none; b=WTTJqnuEXRorDx0nn5kC64iuGWEs2msM6w3AHarLfsBjn1AlP1TeidY0nLIROTPQb5pcNZ66PNF0e1k6RpTvCmsF+lgXvJcCWP9ZgJhVtWrd5flS5H6jQFD6vsD6bCATWY25g8xr4nLFpdd6LOEe0gS5JUr8D+HEm0vpqmgGxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254760; c=relaxed/simple;
	bh=5QWVtlFUpytddrVPpZoEcE4zpXfuf6MyswnZ4U1BsKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hznAZ3BwV+Dv7dRgA+fckh7IXScoA9AjyUf0Ta8sW781GtZRmy3000QWzJSg2pm2OXlmEcBIkdi6kn1EKAUY6Eajo0oe/O7PM7SlvMiS8KOMuckGzyWHSL/IVLCPAYp+S+AmR98pqb2mzUsvGEsxOXmuGajTaaNUjJMtUjhARUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5RYFDYX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5RYFDYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254758; x=1821790758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5QWVtlFUpytddrVPpZoEcE4zpXfuf6MyswnZ4U1BsKg=;
  b=k5RYFDYXHQKumgaxyfZxwFm3tFOIYAmpG8a9DazOpwZwQjuXNbiYy1Jt
   989xv0cPPHlJPI6Az++zj9ekUIFAk21KEl8wpmVSrURY2AX6BVrXQTUhp
   heTvb1X+yJzErngr92dBliFx5dBeFHYNYY3/icaHNtq3vRS+SdVITLo1E
   b0U56Gnwj1zNfiZfH/B6fI3roj615Hjo1AM2WMKeNoxE5zEQyxkDS0pxK
   6A3XwbNZ4oXLXkFuGYfQDJL57sLdV5ir/ngKmXeVojRjggFzYK4q5/Tk1
   weD62RcW3EwuV5T/YkLdwQDJbupzJghb43bDHF7JO1WWR5jqIHb44XY/f
   g==;
X-CSE-ConnectionGUID: sA/EHfaIQJ6KqCTxYyI0Kg==
X-CSE-MsgGUID: TijSbke7TMu72kd24u16VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249207"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249207"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:18 -0700
X-CSE-ConnectionGUID: BD8xpVliR5Se0XDy65El+w==
X-CSE-MsgGUID: n2S/Cwm3StWqNl6EfhVr6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934422"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:17 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 0/8] Rework usage of the control PF pointer in struct ice_adapter
Date: Thu, 24 Sep 2026 12:59:08 +0000
Message-ID: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260831/056612.html

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes
v3->v4: Add the rw_semaphore to protect the ctrl_pf
v4->v5: Split patches into smaller self-contained parts, tighten potential race
        condition windows, annotate RCU-related code

Sergey Temerkhanov (8):
  ice: Unlink the PTP port before destroying its ps_lock
  ice: Protect the control PF pointer with RCU and a rwsem
  ice: Cache struct ice_hw pointer for split register reads
  ice: Reject PTP access without a control PF
  ice: Clear the control PF pointer when the control PF is removed
  ice: Document control PF lock ordering
  ice: Annotate PTP control PF lock handoff
  ice: Release control PF lock before RCU wait

 drivers/net/ethernet/intel/ice/ice.h          |  42 +++-
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  17 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 179 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  77 ++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    |  20 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |   5 +-
 10 files changed, 283 insertions(+), 80 deletions(-)

-- 
2.53.0

