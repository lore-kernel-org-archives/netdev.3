Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF944FDA50
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738400; cv=none; b=eEG6ljsOZkoUPFo2nrJFcyC3wC5DD8ETyckk4dVR53jkuTI1kKCsZ78CsS1EkIsNf1dTkDhG8GU312sb7b1/Q307BUhrHyOhl40Ei7lB3rawzAbY/ZCgUF7XN8NVyyZDGuTvHxGfm08M35HrWCdPivw79Os0WDfNtKYv0V3hg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738400; c=relaxed/simple;
	bh=YZW4VC7D0xXPbuKScthZKOX7ucUwQmE9L3p/jFA459Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xf6BiT666en2VlOpFF9j1LzccMO+Ps4HRczCrsz4ZxkrdLTCMreHbs8eeik7rRbkGPYqCFOiLOlC2N659cpQV99R1VOTZuZ60HDVd9miczx4ylQ8nLffT+EJeE025QQkiPGIQpjrxFBdxjoCNuTYs+1aDk6P+qNaSrVB2gXb/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRjJLDsa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRjJLDsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738399; x=1821274399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YZW4VC7D0xXPbuKScthZKOX7ucUwQmE9L3p/jFA459Q=;
  b=JRjJLDsaaSauD1Q1IqLfoYnfSFUgB7iNbynD09omQRdPBxmyFwqOFKqY
   SyYEXMeBW01f6/x2Tpw+fOpUWm2ekSDBVba9p+/kmO3CeXGSu75kbrCqq
   /Wfs2ls0MEZU5zduPjMEIRY2y2fqFxfH88Tx0V9hRjIqoMkTwXB0cAa+h
   6pXE2kbPkLN3WBN2B/d61zjYETiTBy0skY+ZPrvlhFv37LgiyHHZ+cFNP
   WYFfJ2fkMhF+97UU6zzxEXrZTGewJcfCoRnagGFcux7n717aoOVpVWDqM
   9a/qlwB9gTt6mbK+aZo4vwuOJbflgpNmP84HCLuaVot+KpQGIYI/di7hZ
   Q==;
X-CSE-ConnectionGUID: CAnGTbXCT7Cjq129lubLbg==
X-CSE-MsgGUID: xzJj+MBARnGPm90MUZVudQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101592495"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101592495"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:33:19 -0700
X-CSE-ConnectionGUID: qCJn+m0bSw+MD/cNqhIA0Q==
X-CSE-MsgGUID: InrMOP8sTmOlL2tm9Q63/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270717941"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:17 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/4] ixgbe: adaptive ITR tuning for RX starvation and latency workloads
Date: Fri, 18 Sep 2026 15:33:12 +0200
Message-ID: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the ixgbe adaptive ITR tuning patchset for iwl-next.

v2 changes:
 - No code changes. Resending to pick up Reviewed-by: Simon Horman
   on patches 1 and 2 (patches 3 and 4 already carried it).

This series tunes the adaptive interrupt-throttle-rate (ITR) algorithm
in ixgbe_update_itr():

- Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us so the minimum
  bulk-mode interrupt rate is high enough to avoid descriptor ring
  starvation under sustained full-line-rate RX traffic.

- Add an ixgbe_container_is_rx() helper and refine the RX-specific
  latency-detection thresholds for finer-grained control over
  low-rate RX latency workloads without affecting TX.

- Limit how far a single ITR update can lower the interrupt rate while
  in latency mode, so a low-packet-rate ACK-only workload cannot drive
  the moderation down too aggressively in one step.

- Add an IXGBE_ITR_ADAPTIVE_MASK_USECS constant to replace an
  open-coded complement expression with an explicit named mask.

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

