Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B448A8D1
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317325; cv=none; b=M49bCuj8iV6y8z1ysjdPbtq0kyA7KBfey34iLe+yvTLGCdhAyErZZ1hE3Byu1ZZmBDl+p/ilqvNZ87sohQ3x27eYQwywEMEeywjmxeqf/WGFElUZspi/cx1/x60y2pOpHFdAVfNSI3/4aT7qmrqFLhU89o2n23VRWfp4go9BwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317325; c=relaxed/simple;
	bh=nw3iUyLxXldjaUCaQJDPrq3oYRJPiB2mPDaxB+mHRck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiF79o5zLi1QVcpBp8Ls3sqXOphu/kWtCOrmMA0l1hxTAwPAdiWfdYv6mt0t/iH3V+V+JSzRoQ+yQgwnXnMALkfiSBK1MgoGEtP6446cvtABufH2MH/p95nHWNJldN3lAQ/wtvBdJKhiSpIh3O2pmURVWo6wzXwtLCGnXII3E2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ+39YcQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ+39YcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787317323; x=1818853323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nw3iUyLxXldjaUCaQJDPrq3oYRJPiB2mPDaxB+mHRck=;
  b=SQ+39YcQJH9K+HJL8B8rKbO9/mGeB/MjlExFdBOkhvCy8BRa0bW6nxd0
   W9LfGgfMOuEAnfSZjgQj84dEr24V3FDQckIJSEcWj4zZALXWjzesNvlY1
   KomHoEJgOA15r74IvkvANyvb47qCjFai5JwIa3+c8v2ufBI4iViG0o5jQ
   Q/KYxVuBYrBhsHT4N9Di9DN4I3TWDfHQrlzUyvUBqCKKpsQeD+gipH2nB
   VWX5GJRlrnWSTq7WjEkyD49LztcPH6i+SYppD8EjBgcIGKv5Flj+hU7fp
   kxBJgkFGh76rKu9XZr8k4gDKRowdRnwMwJJTX+UD7WBvSkgJ2sUaFFVnP
   g==;
X-CSE-ConnectionGUID: n8DMam4vQ166wvwVxshm0w==
X-CSE-MsgGUID: sNoMp7JXT+SE+3PQ3LrGmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75400962"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="75400962"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:02:01 -0700
X-CSE-ConnectionGUID: USNqRBxKQ0OgKvCPieX+Ww==
X-CSE-MsgGUID: GOh2slfXSJeSDoOtm9AlAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271568479"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 06:01:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2 0/2] i40e: fix set_ringparam error path crashes
Date: Fri, 21 Aug 2026 15:01:55 +0200
Message-ID: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i40e_set_ringparam() has two independent ways to crash a live queue
while resizing descriptors. Both need a failure injected into the
middle of the resize to hit, but both are 100% reliable once you know
where.

Patch 1 is the reported bug: the free_tx: label frees vsi->tx_rings[i]
(the live, NAPI-active ring) instead of &tx_rings[i] (the staged copy),
on Rx allocation failure. desc/tx_bi go to NULL under a running NAPI,
next poll dereferences them. Reproduced by forcing an Rx alloc failure
right after a Tx descriptor count change; panic address matched the
original report exactly (CR2 == old_count * sizeof(desc)).

Patch 2 was found reviewing patch 1. The staged tx_rings[] copies are
shallow copies of the live rings, so they carry over the same
ring->netdev/queue_index. Freeing one of these copies before
i40e_down() has run - either from this same free_tx: label or from the
i40e_setup_tx_descriptors() failure unwind loop above it - resets BQL
state for the live queue it was copied from. dql_completed() then
BUG_ONs the next time the live ring reports a completion that was
queued before the reset. This one predates patch 1's bug by four
years (Fixes: 9f65e15b4f98, 2013) and doesn't need patch 1 applied to
be reachable via the setup_tx_descriptors() path.

Reproduced by forcing i40e_setup_tx_descriptors() to fail on a later
queue while flooding real Tx traffic on the earlier ones:

  kernel BUG at lib/dynamic_queue_limits.c:99!
  RIP: dql_completed+0x285/0x2a0
  Call Trace:
   <IRQ>
   i40e_napi_poll+0x74b/0x1700 [i40e]
   __napi_poll+0x10a/0x200
   net_rx_action+0x2f7/0x380
   handle_softirqs+0xcc/0x270

Confirmed clean with the fix applied, same traffic, repeated
resize cycles.

Patch 2 touches both error paths above, but only the free_tx: hunk
needs patch 1 applied first to match its diff context - the
setup_tx_descriptors() unwind hunk applies, and matters, on its own.

Cc: Simon Horman <horms@kernel.org>

Aleksandr Loktionov (2):
  i40e: fix set_ringparam error path freeing live Tx rings
  i40e: avoid resetting BQL state when freeing temporary Tx rings in
    set_ringparam

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.52.0
