Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FF40A95F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272962; cv=none; b=EPyPqhq4UaxiStVBpPONUsaFesCiaadEw/Ts7uDtm6TRM9ooc/fy2S24uDVYSo/yHKWmqd1pfkWRFCXadgf/XphyaTZO8wamkjHQdc5MLRrmodSf54ZWoyMfc7Xv0V3M2hkfHH01OLI+3tMoIlYGZ+7jCScAzS7Y78uRAAaDa7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272962; c=relaxed/simple;
	bh=VQgwJ1w/2ytq+FO670qEdd0xDar8G3SUdFlLlTGCYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfVCN+O8QG49B72niXqZMQvaAXMZ0M4o/HlBpAddjAslLGDkus/MkAshgRoDdwT+wgLeT5RaGSbWcNYB/mT8paStXR4BSYC0bWehfaGoU6rcDpAaXXVfXhhh5mgQbN0+Zz0+JZ8wRkvRjKs1Ii75cH3olHDzwU/+Rf7AUx3HRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWoQnZBU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWoQnZBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272960; x=1816808960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VQgwJ1w/2ytq+FO670qEdd0xDar8G3SUdFlLlTGCYWI=;
  b=NWoQnZBUDAgsC8ryTiIyrGZc9lv+D3HuWcsGsLqzVkNjzkxNG5/YOjmV
   g4pV53xyEAaCUwcgBZx0TLCKP1youOxP7b0t5bCJ/mwGAOWj2ic1Fz/cH
   Y/TOOdYYjSJGsOaLKzEEtkou4k1sk2n0toUsjGsgMwIrc4PdLtIVf19uu
   tKoLOT4XG4T4/zwarw+6gVDVflf8l/AU0ZU724j986+FLAFN42b6+V8rb
   vt5HpQJawASgRtVHJ/3jYJp9Se/wVuyVC/FzM3I7FjS8Km58hSbmA8rK9
   XMrjPjYFAujyo05nNfnwSneKb5MniUskwmKLo2W8A9D2/+FS8wQR/v72H
   g==;
X-CSE-ConnectionGUID: CT/FxmMTQ5+gM0jBZSruuA==
X-CSE-MsgGUID: TVXRncnTQJm5zG2TNx1UFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85884986"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85884986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:18 -0700
X-CSE-ConnectionGUID: /Ymb48GiS2y6Rdec1pym5Q==
X-CSE-MsgGUID: zcc9jjO6S9a3zLpb57DozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558937"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates 2026-07-28 (idpf, ice, igc, igbvf, e1000)
Date: Tue, 28 Jul 2026 14:08:57 -0700
Message-ID: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michael Bommarito adds bounds checking to ensure interrupt vector array
stays in-bounds on idpf.

Josh adjusts minimum value for Tx ring descriptors to prevent Tx
timeouts in flow based scheduling mode in idpf.

Yuho Choi frees IRQ name in error path to prevent memory leak for idpf.

Aaron Ma adds a wait for reset completion before returning from resume
on ice driver.

Dawid completely disables and clears VF interrupts during reset on ice.

Dawei Feng adjusts error path for ice loopback test setup and e1000 probe
to prevent memory leaks.

Przemek ignores, expected, -EBUSY errors that can occur during reset
and cause disabling of DPLL on ice.

David Carlier removes napi_synchronize() during igc_down for igc.

Matt Vollrath removes incorrect decrement of count which could cause
leaking due to off-by-one issue.

The following are changes since commit e095f249e2209674f6366f6db0383a2b96e19239:
  net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Aaron Ma (1):
  ice: wait for reset completion in ice_resume()

David Carlier (1):
  igc: remove napi_synchronize() in igc_down()

Dawei Feng (2):
  ice: fix memory leak in ice_lbtest_prepare_rings()
  e1000: fix memory leak in e1000_probe()

Dawid Osuchowski (1):
  ice: fix VF interrupts cleanup

Joshua Hay (1):
  idpf: adjust TxQ ring count minimum

Matt Vollrath (1):
  igbvf: Fix leak in TX DMA error cleanup

Michael Bommarito (1):
  idpf: bound interrupt-vector register fill to the allocated array

Przemyslaw Korba (1):
  ice: suppress DPLL errors during reset recovery

Yuho Choi (1):
  idpf: Fix mailbox IRQ name leak on request failure

 drivers/net/ethernet/intel/e1000/e1000_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 19 ++++++++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 10 +++----
 drivers/net/ethernet/intel/ice/ice_main.c     | 10 +++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 27 +++++++++++++++++++
 .../ethernet/intel/ice/ice_vf_lib_private.h   |  1 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 21 +++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  5 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  5 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c     |  2 --
 drivers/net/ethernet/intel/igc/igc_main.c     |  3 +--
 16 files changed, 87 insertions(+), 28 deletions(-)

-- 
2.47.1

