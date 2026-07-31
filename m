Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223630B502;
	Fri, 31 Jul 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500238; cv=none; b=ZiQNoZCDRhzaQI3Gy/CM+j/b2XL3vnDdPPRXoo4leIqN0JPkjffWlojGW5JLaXLN3vZsYM50vlgC6KmV22WOUsyTRAT6pwDuEYLTTeauBUWRiN1yotXdM1nm8Jbs3fTs1eU0kKC0nNElz4JkcTfWhWYQwh1Ajv3XtnDqIvTGIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500238; c=relaxed/simple;
	bh=rf1mFh7h5zJUZKuy5tZZW2jUDW4ugjsSwKQ7RQgLP5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZPcz9+SOhbxbWFuwncozIM6gXjBMOzItf82lQSLH7BZdMdX69XyfY2Q4VUFPGpJJEGt0f6/tJOpXzcNcQXnTwImC64HhP460hgFIyIvLsLMyHA8YVNuuqsV+zBbu0U85SHUvO8fM+tcsRcgTMH8jXmwQeqK2/CaAr7byBteAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA99R1mR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA99R1mR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785500236; x=1817036236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rf1mFh7h5zJUZKuy5tZZW2jUDW4ugjsSwKQ7RQgLP5s=;
  b=eA99R1mRZILE+DDAYeQ3z0+MKXgMKifUyBIS1WZvsFwQ3RWXob4tz7xr
   TIyRa2bW1FzZoq/GQo7nhz2BPMdWDrXtDB9WQ7swxTl0pPLISCSYwaASd
   qXWdQoXcb5S0uUs76rLlNHSv4bal5LMpP0x6YoKLzwG9YkHCqCVGkQ77g
   omPS6o8RTBopLzlBlEXAEBPjfVCU3ZlzxbDHqzpXQufawIwYXPbL3kwtD
   3QTzBIKG4aPxeccgQLp+xQ9EQK+BW/hHrbSYtaGILTO/7Z63o+UFTK4zF
   n5Wru3fX6dztc6qSrXgQEk9tjXoJiOpsQlls8X2PO6YvdKImCvVzbOZQY
   g==;
X-CSE-ConnectionGUID: g92ul1nvSuKMnzW3pBEpgQ==
X-CSE-MsgGUID: kITsVl0rRB6MEmSIhXJjXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="73662865"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="73662865"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 05:17:14 -0700
X-CSE-ConnectionGUID: 2z4qQXnHR0GHDmW/q5u9EQ==
X-CSE-MsgGUID: d6BkuRy0QlK1snsQin/BRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="298765972"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa001.jf.intel.com with ESMTP; 31 Jul 2026 05:17:12 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v2 iwl-next 0/3] ice: expose TSPLL state on E825 through dpll subsystem
Date: Fri, 31 Jul 2026 14:12:13 +0200
Message-Id: <20260731121216.1841413-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On E825 devices that own the source timer, the TSPLL can lose lock when
the TCXO or TIME_REF signal is disrupted. This series adds monitoring
and recovery for that condition, then surfaces the lock status and clock
source selection through the dpll subsystem. It also fixes the clock_id
generation for E825 generic DPLL devices so userspace can unambiguously
map each DPLL device to its owning interface.

Patch 1 adds TSPLL lock monitoring to ice_ptp_periodic_work(). Placing it
there ensures recovery runs regardless of whether DPLL init succeeded or
CONFIG_DPLL is enabled. Lock state is cached in pf->ptp.tspll_locked via
WRITE_ONCE()/READ_ONCE() for consumption by the DPLL worker.

Patch 2 registers the TSPLL as a DPLL_TYPE_GENERIC device for E825 owner
PFs, with a fwnode-backed "time_ref" input pin. The pin state_on_dpll_set
callback switches the clock source between TIME_REF and TCXO. Lock status
is read from pf->ptp.tspll_locked; UNLOCKED is reported unconditionally
when the clock source is TCXO to reflect the free-running oscillator state.

Patch 3 changes the clock_id generation for E825 TX-CLK and TSPLL DPLLs.
Previously they used the board-level PCIe DSN, which is identical for
all interfaces sharing the same NAC/quad, so userspace could not tell
them apart. The new scheme derives the clock_id from the permanent port
MAC (with a dedicated tag bit distinguishing TSPLL from TX-CLK), while
other DPLL objects (EEC/PPS and non-E825 paths) keep the board-level
DSN-derived clock_id.

Changes in v2:
- rebased
- Patch 2: Fix TOCTOU race between DPLL state_on_dpll_set and PTP
  TSPLL monitor by serializing both paths on pf->dplls.lock. Lift
  pf->dplls.lock lifetime to ice_init_features()/ice_deinit_features()
  so ice_ptp_tspll_monitor() can take it unconditionally. Remove the
  now-redundant ICE_FLAG_DPLL gate in the monitor. Update kernel-doc
  Context: notes to reflect the new lifetime. (Addresses review from
  https://sashiko.dev/#/patchset/20260728091314.1420656-1-grzegorz.nitka%40intel.com)

Grzegorz Nitka (3):
  ice: monitor TSPLL lock from PTP periodic worker
  ice: add TSPLL DPLL device and TIME_REF pin for E825
  ice: use per-interface clock_id for E825 generic DPLLs

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 497 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  79 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 122 ++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 7 files changed, 667 insertions(+), 61 deletions(-)


base-commit: 6e41d29c60deeb29a88debd2540dab757674834d
-- 
2.39.3

