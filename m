Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91748F03E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906280; cv=none; b=GiYOP6YbMne5CxPD1vQFibb45u5kockBcOhjoeNTfipSwQB5/tzKTZshrJ63/1Ccil7QQnF3ibil9idxHFRMo+5LICMUEuAOC0EDbX5lClZbxPdHYQ0TlhxA+iMCd77ngmcEp7NdiGWh353LutBfPLwlOlo6fRq8sfL7FAmkQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906280; c=relaxed/simple;
	bh=YW32eYhsbVhBNMr4BPJWiGP/2hveBWDbi/l2t0WKqus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXDIAmK0RoWmdsZrrO7dBEY0MX6IJEgxADtZOa5Y/Ydnp/xZx83n9rOUkMl87X5Qdr6y5+yeqvSSunPMOT/56mKxpQYEc5uwrSSGPe1CCbTIee/zsfiNcXTCfdScWcdjeEkj5dKbwNG1SPOm9mh+VY2wyPnhI4YkCN9rA/Kt4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd0Rki1Q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd0Rki1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788906279; x=1820442279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YW32eYhsbVhBNMr4BPJWiGP/2hveBWDbi/l2t0WKqus=;
  b=kd0Rki1Q8/i/uvJZwY54LMMtxZ5MRJywOwZ7hxvJNol9ggEGhgcJgglu
   Q/fBS+LC1BJ14FhU6Y2zjFJmvmpFQt8ER+fOmR+Pza08rbPKmMJ/lgsia
   SV1dqIFilFU9UAtoGOUy3Y2bCF23/1UrrlO8x5+ZNEwbQnrEDFovbes52
   BIzheHSyUrR5bp7Mzv5aAC4dBo5SyTAhlMDzKP+sP3Nxff9nfTDXi7p2x
   1W3wXWvJP4IWhhqz1Wyz9IyFNarQ2fgH2Y0t08Cgu8B6b8TubG6LvA+Se
   waGN7RyKsnT2jsWQT8KXuhGjcuaewg46uik8kBIgDJ4suZoe4/NDrdemi
   g==;
X-CSE-ConnectionGUID: pghn5DQGSneb5tSSox5i1g==
X-CSE-MsgGUID: WRvqdWD5RpyL66a3k/bObw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89354866"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89354866"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:24:38 -0700
X-CSE-ConnectionGUID: kG8qzRjLTyGYZMopIBxV1w==
X-CSE-MsgGUID: MxjkAGd8Rc+6yXvTYPw8sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274660826"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Sep 2026 15:24:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	grzegorz.nitka@intel.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.korba@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 0/3][pull request] ice: expose TSPLL state on E825 through dpll subsystem
Date: Tue,  8 Sep 2026 15:24:23 -0700
Message-ID: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Grzegorz Nitka says:

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
---
IWL: https://lore.kernel.org/all/20260803113507.1858083-1-grzegorz.nitka@intel.com/

The following are changes since commit ab217fbb9b2169ce677b09a66558d5c3adcfbb76:
  Merge branch 'net-sysfs-use-ops-lock-for-speed-and-duplex'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Grzegorz Nitka (3):
  ice: monitor TSPLL lock from PTP periodic worker
  ice: add TSPLL DPLL device and TIME_REF pin for E825
  ice: use per-interface clock_id for E825 generic DPLLs

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 493 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  82 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 120 ++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 7 files changed, 669 insertions(+), 56 deletions(-)

-- 
2.47.1

