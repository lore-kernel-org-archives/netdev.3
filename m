Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB043AC0E4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076970; cv=none; b=lNgTtVRPCn1BXtyf9p2WsI/AvGg+gbU74FHRyVRFnQY1CazR3QcXg44yZlA600l5vRur9GF/0MifyATAvxjxohdapFUb62ZzpqTTMsV3U92pY0CKPTlxfBw91Lxnje27otCBfw+lHAIhB0y9fsrQL5rEz5yE5se65cEITByHZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076970; c=relaxed/simple;
	bh=Q7Qq1ojA9P4t/8q0aG9ChIfME7AZFSv4Z/bbT5TDIO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEnuVeto5z7z4JyTh++A84UlcwxjlR3LlKw0evzRVBY37ECgRdAp2fxHWX2QNQPW6mGpjm9lggsfITra4nReR+s8YkBtgIpqqJHHVYT3nppfCpZEVDiMq8kpTn0QNTiVp3x2gJFsflhbtUEV7mNFJYy5vIs/K5BE4K+3Ddt1rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+st14d7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+st14d7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790076964; x=1821612964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q7Qq1ojA9P4t/8q0aG9ChIfME7AZFSv4Z/bbT5TDIO0=;
  b=W+st14d7svALQfDggcXACts1fXXltllL3EIJYmEnAzZs8q7UdBffMYLL
   v7hjmTE53xP5oT/64MKymPXWEBvU9DtMl6NLtXpxmqCVDgRIlcF1yKimM
   t4J4m/AXojCNdj2Kup6BWhaYtyfkMsTnd18rQQV8PUJgkyzVQ6c5UINNL
   ZebrKQ8f50ifVWzCVGjSB1WYa3X68F/irJQVKyBBzuLGdTbWNfSC/GgLb
   oxjZ+Q1hDyrOlDYE2lMgiRD1S9wOUIWGwFsq9GVPaXiqOmNjwrF8fMigb
   4j5PftmTzcjN7rzM2La7c6dM1rnaLtrJz9W1DK3J6zW4XBRFSQMvkQT1U
   Q==;
X-CSE-ConnectionGUID: Q0EQk3YZT/emHcQOfOfSuQ==
X-CSE-MsgGUID: Fx5LGblGTL2dCznYGX4Fkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787326"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90787326"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:35:59 -0700
X-CSE-ConnectionGUID: qhl5J6QWSouxkDES+jgeQw==
X-CSE-MsgGUID: hUsLZAzQTHK8bLav/guSVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272591974"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:35:59 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v2 0/4] ixgbe: fix FCoE/XDP issues and PCI reset handling
Date: Tue, 22 Sep 2026 11:35:54 +0000
Message-ID: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several ixgbe error and reset codepaths.

The first three patches are prerequisite fixes that make sure that
the driver does not access hardware during the reset time when it
is unavailable. These add the required availability checks etc.

The final patch adds missing handlers for PCI function reset through sysfs
in the manner that is safe for ixgbe. It implements the PCI reset prepare
and completion callbacks to quiesce and reinitialize the adapter. This
prevents TX queue timeouts and other related problems caused by
inconsistent hardware state after a sysfs-triggered PCI reset.

Previous version: 
https://lore.kernel.org/netdev/20260617084329.199110-1-sergey.temerkhanov@intel.com/
v1->v2: Almost complete rework of the series to ensure safe
	reset procedure

Sergey Temerkhanov (4):
  ixgbe: Refactor device operations to check whether netdev is available
  ixgbe: Fix FCoE refcount taking for unsupported adapters
  ixgbe: Restore previous XDP program on ixgbe_setup_tc() failure
  ixgbe: Implement PCI reset handler

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   6 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  42 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 193 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   4 +-
 7 files changed, 262 insertions(+), 31 deletions(-)

-- 
2.53.0

