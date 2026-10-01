Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BF3C1F41
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893500; cv=none; b=L5mwd1NL9rELjUVYVb6S9S6a80AmBxudqjQD4C1Eq4HtcQaDyqEn3LpeEVSAVDb5m+sX9ktyFLmJLXPldO9qgmBtx0yNbx491TZprYHOAc0O3SIlxu65CWSOybje3+t6JSHqRZVvMI3RV+jJn2I8qV2zmd6bIinaHPHX90OB5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893500; c=relaxed/simple;
	bh=XxZ0iOz4Ubv80z4kU5k5fxLAWrMh+fDgG99a+4YwlQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AozxGLXZ6lYU4O3silZ8Q/R02MiFXg/0KBZW9HCtB6jSlsdCe39l+vIGIJ9vcrIK8Wpd0r5LOC/6aME8XygeZGsFUkPkToXAWUBdf9NDVrByL+kW9QeQgvuZ1D8lM74mvDeGvjop5YN8MLgmuxLfuEazA20/CcduyFVSCn9JndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWAO8wnq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWAO8wnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893499; x=1822429499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XxZ0iOz4Ubv80z4kU5k5fxLAWrMh+fDgG99a+4YwlQk=;
  b=dWAO8wnqUkpdzPzLM1GhdrTFBvADscLJE2Rt3930biUAICVgJtOD1Ux5
   O4up3fuFGpnoXLTbSbC/ufEWXkY0Sf2X3G02K4UQ4nv4F/pKBkmVN/VAS
   M+s7xMZnZqzyjtghQLALJ06uW0HniI1U9EVHc/AOZ8A1a5gMNMhVLuy6v
   j6vuKAWbDt7B0shjHSnTYyAc+GofGhc7nFUTgTFANGFkYRiFg8K3alw5X
   uykFYs7IoBiFnAXGvk6hLQKkxesVCnFKorK2oG4aB017COljiEjikU/4F
   l2UKDVjKk/BKoxLTrnE7hzGNASBomWErr8c/hvQtFO4o40QH9W4QKBKAZ
   g==;
X-CSE-ConnectionGUID: U/L1xgNfRVWO3tkWFf4Vtg==
X-CSE-MsgGUID: b9dNAQLfSLKTsG3sl3d5WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567677"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567677"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:58 -0700
X-CSE-ConnectionGUID: wHN+LKpkR+WesMoVC8Sayw==
X-CSE-MsgGUID: gu/dH6UXSgqQjZ3OqEH61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863759"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	florian.bezdeka@siemens.com,
	meng.ding@siemens.com,
	p@1g4.org,
	tkusters@aweta.nl,
	jiayuan.chen@linux.dev,
	pulehui@huawei.com
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-10-01 (igc, igb, e1000e)
Date: Thu,  1 Oct 2026 15:24:33 -0700
Message-ID: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For igc:
Ding Meng fixes Rx hardware timestamp when NET_RX_BUSY_POLL is disabled
by populating the skb hardware timestamp from the NIC's Rx timestamp.

Paul Moses limits timestamp-header stripping to the first buffer of
each packet, preventing continuation-buffer data from being truncated.

For igb:
Tjerk Kusters does the same limiting of timestamp-header stripping for
the igb driver.

For e1000e:
Jiayuan Chen prevents MSI-X IRQ leaks in IRQ error path.

Pu Lehui prevents out-of-bounds MMIO access by rejecting devices whose
BAR0 is smaller than 64 KB.

Tony adds Lenovo ThinkPad P14s to disable list for K1 to avoid reported
issues with K1 re-enablement.

The following are changes since commit d24e8ac715de2e16a53c144005b1863660a5fbea:
  Merge tag 'net-7.3-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Ding Meng (1):
  igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled

Jiayuan Chen (1):
  e1000e: fix IRQ leak when request_irq() fails in e1000_request_msix()

Paul Moses (1):
  igc: only strip RX timestamp header from first buffer

Pu Lehui (1):
  e1000e: Fix out-of-bounds MMIO access by validating BAR0 size

Tjerk Kusters (1):
  igb: only strip Rx timestamp header on the first buffer of a frame

Tony Nguyen (1):
  e1000e: add system to disable K1 list

 drivers/net/ethernet/intel/e1000e/netdev.c | 26 +++++++++++--
 drivers/net/ethernet/intel/igb/igb_main.c  |  7 +++-
 drivers/net/ethernet/intel/igc/igc_main.c  | 44 +++++++++++++++-------
 3 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.47.1

