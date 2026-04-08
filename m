Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA983AF65E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653941; cv=none; b=JZFwaF0Ud+gxCYT8009oyd53qb4OFr1YZJar1NK79mRvWXRKi8WibOR4iS+nUyjYCL3gOMQ1CHPn7V8kFUCZGO6ugdvzzugzgzLzDdUWVGkJRmBwefF7qye/fqJrHqbScAAixwqKX0tZ8QBfFCQSitxf9L0ggJicrRNuc5pA2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653941; c=relaxed/simple;
	bh=ntpjB1EZtCslNyS93hZX36BdvkZc2KDqWWKQnlUrZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEzoQgJb0cNnaJqgzIU+LzZWVV/Eaw87gFhkwyn56deMadjbVMDV20vJjxZAr74pWSfQH5ND8WNaBJkRQt1x2e/W/u+v0kxnBZhnlWmo/cPBBmE4aX55pEKSFTxfjignLqdwT+Wcdlm1Vsyn+VJZYTAhmZzZbAn8lpHkklMf4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl1htdca; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl1htdca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653940; x=1807189940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ntpjB1EZtCslNyS93hZX36BdvkZc2KDqWWKQnlUrZQk=;
  b=Tl1htdcaGJBqoQnVOC0fynfZjakxZ0xzPub+UpAtEbgNLP+FvtML5/4y
   4crNs4tvZrki2+8I4OYICGYjZSUjHxVEdL84UaBR/prdPuAOO/PrPTIPy
   P8Tx2SWlbBUbX6YcSeZsSZOszy7W5Hims01noxAya6ChqbdpUXpBuDqT6
   iM00snCAaOmZUmFfGVOnW0W1zUnPNr6QezyJhDKeEsfM5Dgwt/ZLWJ2hd
   9zwI85nOuOP6pYxcBl+54ITmaswUkCtAn2XZ6kWHFqEhQJXc1C6a8KanM
   3qgSi0ORNbRRBG5ZmXfh7jd5kSOBZRwBiX69qpcAXB0/VF6aaAUpwnFfR
   w==;
X-CSE-ConnectionGUID: Bx0KZqV7SAqjlxLzOAzpRw==
X-CSE-MsgGUID: 0x+Yilc+R/e1lQT8+m+PdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087255"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:19 -0700
X-CSE-ConnectionGUID: x2+7OnqDQAqqhJSJD2OAIQ==
X-CSE-MsgGUID: OzxT01VaRrql0uo/QazW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228715050"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:18 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/8] ixgbe: nits and improvements
Date: Wed,  8 Apr 2026 15:12:08 +0200
Message-ID: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eight cleanups and improvements for the ixgbe driver.

Patches 1-4 split the adaptive-ITR algorithm improvements into
independently reviewable pieces as requested by Simon Horman.  Each
patch is self-contained and can be reviewed and reverted independently:
  1. Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 to prevent RX
     starvation at minimum bulk-mode rates.
  2. Add ixgbe_container_is_rx() helper and refine the RX-specific
     latency algorithm (thresholds, no-packet handling, mode tracking).
  3. Limit ITR decrease in latency mode to at most 2 us per update so
     ACK workloads do not overdrive moderation.
  4. Add IXGBE_ITR_ADAPTIVE_MASK_USECS constant to replace the
     open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY complement in ixgbe_set_itr.

Patch 5 removes ixgbe_ping_all_vfs() from both ixgbe_watchdog_link_is_up()
and ixgbe_watchdog_link_is_down().  The original submission only removed
the call from the link-up path; this version also removes it from the
link-down path, which carries the same race window against VF mailbox
initialization.

Patch 6 replaces ktime_to_ns(ktime_get_real()) with ktime_get_real_ns().

Patch 7 restructures ixgbe_fcoe_ddp_setup() so that dma_pool_alloc()
is called outside the get_cpu()/put_cpu() preemption-disabled section,
enabling GFP_KERNEL instead of GFP_ATOMIC.  The prior submission left
the allocation inside the preempt-off block (GFP_KERNEL can sleep under
direct reclaim, which triggers a BUG() with preemption disabled).

Patch 8 fixes six local variables declared as u32 that are used to
store signed kernel error codes.  Reviewed by Simon Horman.

Changes in v2:
 - 1-4/8: Split monolithic ITR cleanup into four independent patches
          as requested by Simon Horman.
 - 5/8:   Extend fix to also remove ixgbe_ping_all_vfs() from
          ixgbe_watchdog_link_is_down() to cover the identical race.
 - 6/8:   No code change; add [N/M] numbering.
 - 7/8:   Move dma_pool_alloc() outside get_cpu()/put_cpu() so
          GFP_KERNEL is used safely without sleeping under preempt-off.
 - 8/8:   Add Reviewed-by: Simon Horman; no code change.

---

Alexander Duyck (4):
  ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
  ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

Aleksandr Loktionov (2):
  ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers
  ixgbe: use GFP_KERNEL in ixgbe_fcoe_ddp_setup()

Jacob Keller (1):
  ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()

Aleksandr Loktionov (1):
  ixgbe: use int instead of u32 for error code variables

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 50 +++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 97 ++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 +--
 6 files changed, 113 insertions(+), 59 deletions(-)
-- 
2.52.0
