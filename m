Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5C41D63A;
	Tue, 28 Jul 2026 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230303; cv=none; b=UfuzU7ZhU+R/AStPztNvYX8+daUqo1nZeQ/tzIbNoHMQAd9xvV19jeia8vGeapmVt/i4OkysdJ/NEhsCiiKkCX5nDWP/IbQeF6iRk4zhkOcy3HmZ2gE1hSnKLXJv0KeeEdDrVssFp42oMJKUBLJQ02o0DZ7ey0eWmHpp5ACzV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230303; c=relaxed/simple;
	bh=SWxZG5+sOL0eaYnnUUqJ1958bHVxM3Dc0x29DZMl+zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCFzg84V7jAIcrrgftXmI9lAxEw8eb64RdKCDml3XpCr3Jed/JV+2xtDdgUZ+fhKBnxyZtgnQGB1FCqd3HDRhuka27JV+3N9kzB/9Ch7bOtcgoS5jDoi9T4eQGsc1pg2O4tzlRrARKIdVciIFSO3Y+1uBlUAEtnpH92ywPNHCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewXu2k6f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewXu2k6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785230301; x=1816766301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SWxZG5+sOL0eaYnnUUqJ1958bHVxM3Dc0x29DZMl+zk=;
  b=ewXu2k6foc9E8KdtjP167I1/CZoaVccMqFqYLksTvQwUfqD2DexOdS1A
   TtFBN+q0ntPX1cOF0zG/VuZIR9lhupwel4k+CnyIqDdAEaV6Czs9jAue0
   Obkkr1INnm3CtSWcDYE0+l2kwRaYflK5mA7c4g2PicAnBsxfgkcy4Znc3
   p6Ds3Jo3uPHkeEITxtpIhDsWhCSpW6bwdep4Dj1xaKkFi5mUYeXio8Wp4
   gFiqOvRIqKT1O5DthrvLFLPflWPFFNg3jrNE3y2sc91K4j1g6XXksdfKt
   4xN4HfiJbUUJNQxqHFuwif9WsC5axojUaFtFKQjwAMywpx4OW41CUxkLf
   g==;
X-CSE-ConnectionGUID: jVIrWfMhQO2HSIBI2+K+VA==
X-CSE-MsgGUID: cJEujt7bT7Gg4x4gH5nIsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85677238"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85677238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 02:18:20 -0700
X-CSE-ConnectionGUID: 0/6CBofXSVGzYMsPPqvEsA==
X-CSE-MsgGUID: DM08+b4SRJGVolx4ShI3hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="258378411"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 02:18:17 -0700
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
Subject: [PATCH iwl-next 0/3] ice: expose TSPLL state on E825 through dpll subsystem
Date: Tue, 28 Jul 2026 11:13:11 +0200
Message-Id: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
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

Grzegorz Nitka (3):
  ice: monitor TSPLL lock from PTP periodic worker
  ice: add TSPLL DPLL device and TIME_REF pin for E825
  ice: use per-interface clock_id for E825 generic DPLLs

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 479 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  80 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 122 +++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 6 files changed, 657 insertions(+), 45 deletions(-)


base-commit: d621cef13189b54ee67019d170a6d8ec727785aa
-- 
2.39.3

