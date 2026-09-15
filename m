Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A843B05B2
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476942; cv=none; b=LaFERXEOPgea6Bt9l0IDroBp92+DfITpG/26OjV1BW4GtMjlzTGK5F/AHNPUwjFKRSN2bTKe/Vj1hFrlqF/D03QYmpF7NPCxXBHYAvyCtBt/pPOtKtiiZO8T5eFkW2P+hCwbyYpffF7QhSkRROdPAEkCrz3WU8JQCheD0UHbZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476942; c=relaxed/simple;
	bh=rpdh8R+NRZzqvazI4/u0qaGqY5bMi/i8jHNEkqrrHhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBWO5f91BjMf55yWKxiIGDaO6AQhkROKaS2fV0jdR64fgpivc+mdACgE978yvTtm7Mceokyxp9BQOI06UmHtDWdyiSkFK7paIgo5NoGJFrds3SJ3gfJpsEj8wG3mo9ZQayoEaY9oThedkmV6kiq6S/g+ftNZbmaTEvLU2/STHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGk1JUlF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGk1JUlF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476941; x=1821012941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rpdh8R+NRZzqvazI4/u0qaGqY5bMi/i8jHNEkqrrHhY=;
  b=DGk1JUlFXGJI/xabrYUiS7fJELRINuCoXps/fbrbVkTLY0jT5JgHJdHv
   vvIzHEbxBiELMVcj0jKPrf+Yas+LVcXH2upHS6ykh/4NO9PYZ5QSs4Doa
   UkMAXvZiqQm8F//AW0XdtC4cd+S52zeNEScZu+Kk4nUfN/IeQ5bOY/JxH
   kEdVXGvQeNa1PUbRnbvWN8yR0ap/ObwDqjbZoTlkP2XMoRuuUJdqJ2DLk
   AkUXhJZBLFxhIx5Zu4ziYW9sL0tKEv+HCK9qUL1lGgCDIzJfhCS8wBFJM
   v3OnHecFzNSi2hRi/G48tTcM4v91Q9wSA+Wevx1HAhgapvha/zvqGKEsz
   Q==;
X-CSE-ConnectionGUID: Vavbq1NSQEC6BS15YaLxwA==
X-CSE-MsgGUID: YeEeWdpYT6e4iQFU7JAD/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853114"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853114"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:40 -0700
X-CSE-ConnectionGUID: p31Ag7D1RoSIdkQSviTJBQ==
X-CSE-MsgGUID: ITyztPNjQuWR9Q3zi0vbWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225213"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:39 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/4] ixgbe: adaptive ITR tuning to prevent RX starvation and ACK overdrive
Date: Tue, 15 Sep 2026 14:55:34 +0200
Message-ID: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series was split out of a larger internal "ixgbe: nits and
improvements" cleanup batch. It tunes the adaptive-ITR algorithm and is
kept as four small, independently reviewable/revertible patches rather
than one monolithic rewrite:

1. Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 so the minimum
   bulk-mode interrupt rate cannot drop low enough to starve the Rx
   descriptor ring under sustained full-line-rate traffic.
2. Add an ixgbe_container_is_rx() helper and give Rx containers their
   own latency thresholds, replacing the shared Tx/Rx heuristic that
   the lowered maximum would otherwise interact with poorly.
3. Limit how far a single ITR update can decrease while in latency
   mode, so a low-rate ACK-only stream cannot overdrive the interrupt
   rate in one step.
4. Name the usecs mask used by ixgbe_set_itr() instead of relying on
   an open-coded complement of the mode-flag bit.

A fifth patch from the same original batch, removing a redundant
ixgbe_ping_all_vfs() call from the link watchdog handlers, addresses an
unrelated VF mailbox race rather than ITR/RX-starvation behavior and is
sent separately so this series stays focused on one topic.

Alexander Duyck (4):
  ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
  ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 80 +++++++++++--------
 2 files changed, 49 insertions(+), 34 deletions(-)

-- 
2.52.0

