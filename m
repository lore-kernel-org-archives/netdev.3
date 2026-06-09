Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E473EC2F6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040971; cv=none; b=ridslUGMhFSQr3n8NOapdsY1rdg6Y5umPUq0HzIgFz2rJFLnIZqycBegT5KTFIOyDyxcKUhLRqU0rZWYF4uy/rLZUqM7AS48yGiw4aDjhvjAaaUcGeA8fiC8SIOsqaWn4U28uc0M9Lta09aTV+5iq5LiYSp5ZGLtHl96CvpoWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040971; c=relaxed/simple;
	bh=Euap87+zczdHXCuYiVVwvXVJnTOGjW5GQxOEU+sMZPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nz4HwDOTH2nA4zWkpToY1R5M7khdZS+P88JctERpzE4Bx57FNInHj6w9ZRWZNyzE+k7+osGBx/ay3wlKMX4zaT6JfjXTwhXeGoUoN8XUqd5S5wlU0m1/dYrqp1DtSD2dpCu0+01VW9hNI+BTIxJCbPMNvwQp/ZY9CU6iwlbYSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Og5qpozm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Og5qpozm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040969; x=1812576969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Euap87+zczdHXCuYiVVwvXVJnTOGjW5GQxOEU+sMZPE=;
  b=Og5qpozmHAW2R5oWl2Axeuckuyqp0IiyWVT/i0ybC2r+k2ZJOmsEQmrs
   6q9xL57yhR2XNdlfdtdA04aCmcsf4kXCz57pq4l6lUFb600pxcKG8C9D4
   vEXpLTwb9YBEsJXmg5VF/0fjMadQ9YIDFCp/WFQZftYviLS+Vd9XTBWam
   /g80EKh10V94A798PI4MwamR1Yue7g49QqjOp71GsFIOrTR6y/OKVkxVl
   SlAM6mipGN5kRGTYtll4eD7PGJupMZoM3+X9eLPQ1Kj0UH0/BSxc1RJpv
   ffEOgSKUV0DzTYmrK+peXO5rj18DrRspwIt/H/XuWykNY9aFoiU72cWKa
   A==;
X-CSE-ConnectionGUID: W5yfvYyQSTG0C8XJMDOwdg==
X-CSE-MsgGUID: zcswmTovTgigUkXZOlbuqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568508"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:07 -0700
X-CSE-ConnectionGUID: ksHnEgHsTLO439YlFsKZWg==
X-CSE-MsgGUID: t7MbbCjrQzCQFxlD7VTwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838564"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2026-06-09 (idpf, ice, i40e, iavf, ixgbe, igc, igb, e1000e, e1000)
Date: Tue,  9 Jun 2026 14:35:41 -0700
Message-ID: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marco Crivellari replaces obsolete use of system_unbound_wq to
system_dfl_wq for idpf.

Natalia removes redundant PTP checks on ice.

Corinna Vinschen removes redundant MAC address check on iavf.

Jakub Raczynski replaces open-coded array size calculation to use
ARRAY_SIZE for i40e and iavf drivers.

Piotr removes a couple redundant assignments on ixgbe.

Kurt Kanzenbach moves processing of Tx timestamps from system workqueue
to BH workqueue for igb.

Alex utilizes ktime_get_* helpers for igb and e1000e.

Daiki Harada replaces napi_schedule() to, more appropriate,
napi_schedule_irqoff() call in igb and igc.

Matt Vollrath does the same on e1000e.

Agalakov Daniil skips unnecessary endian conversions on e1000e and
e1000.

Maximilian Pezzullo fixes some typos on igb and igc.

The following are changes since commit 9415471e01c1aaac43daa6af3a261dc0c6c3a47c:
  selftests/net/openvswitch: guard command substitutions against empty output
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Agalakov Daniil (2):
  e1000: limit endianness conversion to boundary words
  e1000e: limit endianness conversion to boundary words

Aleksandr Loktionov (2):
  igb: use ktime_get_real helpers in igb_ptp_reset()
  e1000e: use ktime_get_real_ns() in e1000e_systim_reset()

Corinna Vinschen (1):
  iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test

Daiki Harada (2):
  igb: use napi_schedule_irqoff() instead of napi_schedule()
  igc: use napi_schedule_irqoff() instead of napi_schedule()

Jakub Raczynski (1):
  net/intel: Replace manual array size calculation with ARRAY_SIZE

Kurt Kanzenbach (1):
  igb: Retrieve Tx timestamp from BH workqueue

Marco Crivellari (1):
  idpf: Replace use of system_unbound_wq with system_dfl_wq

Matt Vollrath (1):
  e1000e: Use __napi_schedule_irqoff()

Maximilian Pezzullo (2):
  igb: fix typos in comments
  igc: fix typos in comments

Natalia Wochtman (1):
  ice: remove redundant checks from PTP init

Piotr Kwapulinski (1):
  ixgbe: e610: remove redundant assignment

 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++++++----
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 19 ++++++++++++-------
 drivers/net/ethernet/intel/e1000e/netdev.c    |  8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h |  2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 12 +++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 14 ++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/igb/e1000_defines.h    |  2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c    |  2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h    |  2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c    |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 10 +++++-----
 drivers/net/ethernet/intel/igb/igb_ptp.c      |  7 ++++---
 drivers/net/ethernet/intel/igc/igc_diag.c     |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c     | 10 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 14 ++++----------
 17 files changed, 57 insertions(+), 63 deletions(-)

-- 
2.47.1

