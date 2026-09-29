Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE4577E2C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721725; cv=none; b=myFeMHRfVmF1c3MPunCR4idJLLhcTaUWyfV/xxS6gvPD44FULSUWgOP96ZsDyJQadVPsU11Ied7KASOUZBpfGYhrhJkWnbm6Gg2/XwzaJ88iYT2wis9sRL6CzUhQyUtrfaosyub8uYvRffKimqc9IL7Fwb2WOaNqvPaFrAMR9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721725; c=relaxed/simple;
	bh=PrzdNJziqPAKxA77zp2g8melLy2r+M33L8bhk9msJ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4t0gAUp9cmsaultyF7DqFBIqUsPUift540+BdzIgLKAxeTCPGl/1lJZwCVliE/jrZh0xsw8bBDZ3I7+9OU0zjAJ4E2c0z+lsyiAtUuRXDmgsKZyGGZT8yUfoXTVUMTwAwVI+B09P9krM/GxWd51sVYSaN9vxLloB/RfLqqNm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBQFxtI9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBQFxtI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721722; x=1822257722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PrzdNJziqPAKxA77zp2g8melLy2r+M33L8bhk9msJ+0=;
  b=FBQFxtI9b4bcqF8o+GgKdCQhauhtjxBCaZfW+Ed1x6q2dRlnIcfoPRk7
   NYKjkfTDYFGzaMX1J79sBNN4je85Lm8oDEQDuvP1dVghOxtztNAKATykm
   m770DulOJU06NfNV2YgOm46SYOQAhfD5Vp9APlKmAiXCuYTBTfm4BF0b0
   rojwVZIRffKugxf7m4zKS/zut72YttHzRDSEbyvS5SZ4JJ0hM47XYwFpq
   BKwDegLJdY7kvQh6jaCQE+lVspZFOYmBmBiGpxshacdKI7+wn7ma1XBJg
   aak87ZEibXTLez448R+RMcXRFaExAxz4Xtaui2K13I/xLGiwxlIAkYHr5
   A==;
X-CSE-ConnectionGUID: L8YWZJ0HSNCw/mwGcDbsBQ==
X-CSE-MsgGUID: QdPSN1KkTham5x5Yd/jNrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548846"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548846"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: 4k+OG0uGRxCR+T94+zpsuQ==
X-CSE-MsgGUID: PSYCbpb0TfGgZ1u55YjI1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452293"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: [PATCH net-next 00/10][pull request] Intel Wired LAN Driver Updates 2026-09-29 (ice)
Date: Tue, 29 Sep 2026 15:41:40 -0700
Message-ID: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Grzegorz reduces DSCP message from error to debug when FW DCB
management is active since it's an expected condition.

Marcin utilizes, existing, ice_fill_eth_hdr() call to set ethernet
header value.

Jake reduces padding in ice_flash_info struct by moving sr_words
location.

Aleksandr adjusts OICR interrupt moderation rate to reduce latency for
Tx timestamps and VF mailbox messages. He also simplifies IPv6 mask
checks; replacing memcmp() and mask structs to helper functions.

Przemek Korba adds an Rx timestamp tracepoint to help debug PTP issues.

Weimin Xiong converts parser-table allocation to kcalloc().

Yury Norov simplifies PF nominal-state check by reducing the number of
calls and removes a redundant NULL check as most are already non-NULL.

Przemek Kitszel simplifies VF queue disabling by removing ineffective
batching for queues.

The following are changes since commit 6e23f90f2b8c3ea3bf904f86f3ed06bf2844b4bc:
  Merge branch 'net-consolidate-devmem-net_iov-freelist-and-dma-handling'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Loktionov (2):
  ice: increase OICR interrupt moderation rate to 20K interrupts/sec
  ice: use inline helpers instead of memcmp() for IPv6 mask checks in
    ice_ethtool_fdir

Grzegorz Nitka (1):
  ice: reduce loglevel to debug for 'Can't delete DSCP' message

Jacob Keller (1):
  ice: reorder ice_flash_info fields to eliminate padding

Marcin Szycik (1):
  ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()

Przemek Kitszel (1):
  ice: simplify ice_vc_dis_qs_msg() a little

Przemyslaw Korba (1):
  ice: add rx timestamp tracepoint for debugging

Weimin Xiong (1):
  ice: parser: use kcalloc for table allocation

Yury Norov (2):
  ice: simplify ice_pf_state_is_nominal()
  ice: drop pf == NULL check in ice_pf_state_is_nominal()

 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |  2 +-
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 57 ++++++-------------
 drivers/net/ethernet/intel/ice/ice_lib.c      | 11 +---
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
 drivers/net/ethernet/intel/ice/ice_parser.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  6 +-
 drivers/net/ethernet/intel/ice/ice_trace.h    | 18 ++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  2 +-
 drivers/net/ethernet/intel/ice/virt/queues.c  | 17 +-----
 10 files changed, 47 insertions(+), 74 deletions(-)

-- 
2.47.1

