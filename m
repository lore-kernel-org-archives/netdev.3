Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F53B9DAB;
	Mon,  3 Aug 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757280; cv=none; b=M84OIUswDJsKRlmSJQg10+AYknWVGXM3VEt6IBTBp+mfyMa49yR//tPDVsPxkE0Y3HoJKIo+5jRHmwsoCXmJiYKIbm3vsHRVMWiu+U9RoWpdSXIqPlTmbpGhq/7uFhqkqexDbU0EP+IngLlN5B2tvV6duQH8zkFOVqsaGhuyCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757280; c=relaxed/simple;
	bh=J5J8BGB+qNHC0Yjk2zJKkVE6+rid+ufAR9hbEF2Mo/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yp9so0W4RJxyUp8agTEhQFCI6OxARXghHswG1BYV8NfRyY5WBMUeuUPuOJzjTxwDB0dA+R/Eh4IjW2Wj+Jy/gBIWTBiTMToNWsEOz1JdzshSdfsUsyIVdDddveVMNe/AfRwlNFZgZlQcpbtuFRIP6bMBweU/j/hYVOzJp+GiOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpVUf3ec; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpVUf3ec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785757279; x=1817293279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J5J8BGB+qNHC0Yjk2zJKkVE6+rid+ufAR9hbEF2Mo/w=;
  b=UpVUf3ec2qNPDI96QPjeAu4lUyfSZv41ApHBEeEOBOeKGt2r+L8OWZQC
   o+kQbCwoJ9dx4rG1CqsNOAhef1FCTZfLMuXtqH2gupfBTHgZWrSji1/X9
   8ByjP2Er2rcnFJ1gehAoeq1jx/qxT1zyCZoVj5Z5WRVZG8IX7y9Vn/58v
   2OfWDEytai82YPLA8MELjNA0hgEEEsTgQR3/+xYeeTxayyLFJgkhR37xO
   cVi6tlNHy1cPZkQVe8TxU9/mgFxLhocNwTDXWGwrS6zV2fqnEjXox0fiE
   uAlZTNNG8qI9ClQ9Rl4svBkbHuX6KpxvgXzv7n7FJaadYv8m3WSuqvTuC
   g==;
X-CSE-ConnectionGUID: JkdThejfQUep7e3XNfw/Cw==
X-CSE-MsgGUID: KbMmp7moRA2ZshTECoC1Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="96878831"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="96878831"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 04:41:17 -0700
X-CSE-ConnectionGUID: 1j6TNZkoRIGltW9gZIzNug==
X-CSE-MsgGUID: ukto2IKZS7WUUT64vEHI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="257299043"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa010.fm.intel.com with ESMTP; 03 Aug 2026 04:40:06 -0700
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
Subject: [PATCH v3 iwl-next 0/3] ice: expose TSPLL state on E825 through dpll subsystem
Date: Mon,  3 Aug 2026 13:35:04 +0200
Message-Id: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
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

Changes in v3:
- Addressed Sashiko concerns from:
  https://sashiko.dev/#/patchset/20260731121216.1841413-1-grzegorz.nitka%40intel.com
  - Fix spurious TSPLL lock-status flapping from the DPLL set callback.
  - Serialize ice_ptp_tspll_monitor() with the DPLL set callback under
    pf->dplls.lock (mutex lifetime moved to ice_init_features()).

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

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 501 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  82 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 122 ++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 7 files changed, 674 insertions(+), 61 deletions(-)


base-commit: 6e41d29c60deeb29a88debd2540dab757674834d
-- 
2.39.3

