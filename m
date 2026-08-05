Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F932C94A
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912754; cv=none; b=DpV3ciPGV7USoenv/qZPU0dlTbJV4lzr/ZCC82Lhz1aMlGOLTuLMJUiJRVZLrZrl3TkFuP5gCWWRc6hx1ccddbv6wl/iHR27Tk3ChKagQxNROG5qELOCTsTHRPR7oSKWlzBnnptkv1jIrlRtz9wv8ybl+KAb3FPDxlOhX78ef7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912754; c=relaxed/simple;
	bh=YQMkocJ+myS/f9uu9nVXJbzQSE64dwnHk/6FC18aB9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdGSJbFF/0T9jPeD7f7nsAq0+auoQuVBmHiGvHf5H0aeL7kFPM/0maZ9JWvgELU/aRlDbx37r2Z7LaOS0gpJno5IZEkkQZY910+25P9zJLHF5eluKcPCfkzSBqbkvQit/v3jMHmsMqtf6ppXZ8PT/ty25ZHCPb78DZEhG97jaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWhfTo5g; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWhfTo5g"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785912750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l8sT77sMLnvc5J/o1+o8LA24MkhuWIDVXohFcRV7hjQ=;
	b=JWhfTo5gUt8sZIKav4D+kCj2CMwI6V9+P1vTNAQpkHJVmRBoeNmdoakzQ8am6mXv3XNm4t
	3D+/Hz+O0QjlCBQCgTtNfB3N4nBzDA+qv63kdLt6xTvPDCcjCf+KQ6nxWrW3UFO4ek35dS
	2w6NquGfIDGx8bq10rB0ETZJtjOrdB8=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	piotr.kwapulinski@intel.com,
	arkadiusz.kubalewski@intel.com,
	aleksandr.loktionov@intel.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: [PATCH iwl-net v2 0/5] i40e: fix PTP work and teardown races
Date: Wed,  5 Aug 2026 14:51:27 +0800
Message-ID: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <xuanqiang.luo@linux.dev>

The i40e PTP paths have independent ownership and lifetime races. A Tx
timestamp skb can be released concurrently, timestamp configuration can
race PTP teardown, reset recovery can rebuild the device during removal,
and external timestamp work can outlive the PHC or PF.

Split the fixes by invariant so each patch remains independently
reviewable. The series is ordered so the external timestamp work fix can
rely on the configuration and reset teardown synchronization introduced
earlier.

---
Changes:
v2:
  Patch 1 (new):
  - Split Tx timestamp skb ownership into an independent patch and protect
    the slot across transmit, timeout, interrupt, error, and stop paths.
    (Simon Horman, Sashiko)
  - Use ptp_tx_skb as the single source of slot state and verify the skb
    owner before releasing it from the Tx error path.
  - Keep the existing enable checks outside ptp_tx_lock so the critical
    section only covers pending slot ownership.
  Patch 2 (new):
  - Serialize the PTP_ENA transition with hardware timestamp configuration
    so an ioctl cannot re-enable interrupts during teardown. (Sashiko)
  Patch 3 (new):
  - Split reset/recovery synchronization from the external timestamp work
    fix and stop service work before PTP and device teardown.
  Patch 4 (new):
  - Move the reset polling replacement into its own patch and use the
    wait-bit API for reset ownership. (Simon Horman, Sashiko)
  Patch 5:
  - Close the configuration gate, then disable external timestamp events
    and drain the work outside ptp_config_lock before unregistering the
    PHC.

v1: https://lore.kernel.org/all/20260724093448.63154-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (5):
  i40e: serialize Tx timestamp skb ownership
  i40e: serialize timestamp configuration with PTP teardown
  i40e: synchronize reset recovery with device removal
  i40e: replace reset polling with wait-bit synchronization
  i40e: fix races in PTP external timestamp work handling

 drivers/net/ethernet/intel/i40e/i40e.h      |  6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 37 ++++----
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 95 ++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 38 ++++++---
 4 files changed, 120 insertions(+), 56 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0
