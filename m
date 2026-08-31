Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2043E09D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192663; cv=none; b=O+tEaqS/sKQB3TYHhHAoEsYWmFubQD4GmrZxOUzuQ2kBdLXsBdzbSS3jkd7eSiHMmRNLfI4HEgaCZG9SBODOYCDrbWxMLtcKO73Fl8p0HHpNhEGn7wrEKuRPnKjH82vHgdEOPDlJR/e6DXDnDfYYrt1HQrG8nWLOOytha7VU37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192663; c=relaxed/simple;
	bh=rMwrlZAKKi7d6ptfAaRa3Yi2AtUD30qHz5yLcuMWlrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4/62+rXAJyVx2oqzTZ1yZmcCiisuvVjcqVv4yrW/quV6WK7nuMHAVU7UiqTgFCyV6JzDEgSJqwC9Uc2aUpEFOPqnviASYXfllR0sLMZrum6MOPuz8lwHHNDtzaXcgJwN1mdF4kipgIGcSJMg2NBovN0kobFC2/WqDiUeW0P5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVFNbK9S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVFNbK9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788192662; x=1819728662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rMwrlZAKKi7d6ptfAaRa3Yi2AtUD30qHz5yLcuMWlrU=;
  b=UVFNbK9S6n0Ezt9mwc1eUkJrHJZ5hg1k1ME47NYsoQ6FXUv9QdSd0LN8
   4v43G3U1/W183iTjiNvpBlNh1HQfrZViV20B9Aj9pcfo1SM79mHlMiHZh
   c2EJL1i1g6TExkq3vm9vrQh3WtnALYYuRYXFjAeHdT3q2RNz0ttDDBQox
   HkeS9EqkoESAIlC74c2FZiu5jWJq6l4/4SgtslCprb1iLx8IEOiz+zs65
   2pZiV9h3rM4+fEUcXsdDAW7ti3suO9WzYcwgduLVBFYeNT1pvQFdaKmkL
   CxG/cL2kZ9FYCZIIjyTdEDYRtIekZetUqxAZi92hqCgTO5IiFCons5Wp9
   Q==;
X-CSE-ConnectionGUID: aKN8+PbjRFG81BeM+8zz9A==
X-CSE-MsgGUID: s6Tkt5FkQESCARtsjrW+lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88729027"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88729027"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:11:02 -0700
X-CSE-ConnectionGUID: H7JjW9HKSTylolVB5SHuzA==
X-CSE-MsgGUID: LgPdOwYqTfOhvQWQLX5ROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="262706385"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2026 09:11:01 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next  v4 0/3] Rework usage of the control PF pointer in struct ice_adapter
Date: Mon, 31 Aug 2026 16:10:57 +0000
Message-ID: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
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
https://mail-archive.com/intel-wired-lan@osuosl.org/msg18407.html

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes
v3->v4: Add the rw_semaphore to protect the ctrl_pf

Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads


Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads

 drivers/net/ethernet/intel/ice/ice.h         |  25 ++++-
 drivers/net/ethernet/intel/ice/ice_adapter.c |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 101 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  37 ++++++-
 drivers/net/ethernet/intel/ice/ice_txclk.c   |  19 +++-
 6 files changed, 147 insertions(+), 41 deletions(-)

-- 
2.53.0

