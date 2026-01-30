Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E342D2390
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799248; cv=none; b=udekx2/rE2AuSaJQq4zhUMB0K2EH5qRH0IwEyoNaecYxrmrnH1zYsIwROLvL127cvBPVM69ouFgUyjPlaC19Yw9nJkHsMdLlOfhILGMtW42ORgdILdf27FPfPb5x7vgq3C/wQCs2i96d3CuYR8CuX3Hkqaus4ZlhutQS0stKMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799248; c=relaxed/simple;
	bh=typ8+shyl4IpM/iliwY3TwFfLFBoVOkb+UMWIA/rxOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjZS3SfTmzh9QLG+EOqjbKLaQ2nTzqFLKwMRfNnlcSLRX2z9dSUQzmG0hjfVbpAa7/8RI/kqZAMzZePNfm3lpjKBupG9a+MvZZCQJJ6N+3TF+C67Vey6PNm0P7XYebpIhQlKhqA7c+AMkidH3+1/9Un+UrMVPphtEi3PRrroaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6wzeqzE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6wzeqzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769799246; x=1801335246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=typ8+shyl4IpM/iliwY3TwFfLFBoVOkb+UMWIA/rxOw=;
  b=n6wzeqzEPuJuSfkeiLcbTyb+LCEHIZfe8E1JTvoZCMbMwTz9ZC8i/xBc
   JtU+y6wrUoY/9JR15gxCd3dfuzvtkghYkhdZZYJGxtZ/QmKrHFZUEEjW6
   BGshXPC00r01wGqpd2m8Q+je+KM3knckTzx9NMiVxQH3pLRkmzx1VMvUR
   GKqQKEknAklFd572McI4THLqMNg2c36TPGfBs2Oe8N2Ljik90Ms0PLI0m
   D+jUHAExF7NDaqZNnFUqbhJ2izwnF7snKWUhpcroFgGbHfbOs6H2xPagC
   gyR5aGVe+crOcdU9h4Fk7HdiRTThLgOijlpGJOcQ24q5A9ivpwbNG+Z3z
   g==;
X-CSE-ConnectionGUID: nGg5INATRoe+UoXYtGIGQA==
X-CSE-MsgGUID: A6+/2SblSx2ye2HFmAjLPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71091267"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71091267"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:54:06 -0800
X-CSE-ConnectionGUID: ICjbhJKcQyiGkqI9kq1SmQ==
X-CSE-MsgGUID: QW09L9JNRpSPGebBqeNjnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="231840995"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 10:54:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2026-01-30 (ice, i40e)
Date: Fri, 30 Jan 2026 10:53:53 -0800
Message-ID: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to ice and i40e drivers.

Grzegorz and Jake resolve issues around timing for E825 that can cause Tx
timestamps to be missed/interrupts not generated on ice.

Aaron Ma defers restart of PTP work until after after VSIs are rebuilt
to prevent NULL pointer dereference for ice.

Mohammad Heib removes calls to udp_tunnel_get_rx_info() in ice and i40e
which violates locking expectations and is unneeded.

The following are changes since commit 31a7a0bbeb006bac2d9c81a2874825025214b6d8:
  dpaa2-switch: add bounds check for if_id in IRQ handler
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Aaron Ma (1):
  ice: Fix PTP NULL pointer dereference during VSI rebuild

Grzegorz Nitka (1):
  ice: fix missing TX timestamps interrupts on E825 devices

Jacob Keller (1):
  ice: PTP: fix missing timestamps on E825 hardware

Mohammad Heib (2):
  ice: drop udp_tunnel_get_rx_info() call from ndo_open()
  i40e: drop udp_tunnel_get_rx_info() call from i40e_open()

 drivers/net/ethernet/intel/i40e/i40e_main.c |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c   |  26 +--
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 179 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h    |  18 +-
 4 files changed, 136 insertions(+), 88 deletions(-)

-- 
2.47.1

