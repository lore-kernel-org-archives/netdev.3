Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700849C4B1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476969; cv=none; b=gEN08q3+i2ITmrBIzr//YnKlnyuLicJRmvieKxMeduUmTfgtt7UfuxjvXxecOp5AcnhNm/rQJyQYUJle9HSvtRzLEpHbR5yzm0ZeTDJrvfXa2Ho7YvvZaxbPRf1z5ZD9UyYJo88lLTwGkqzhtagKodOkXvuQ2d2Ohr0uRuz6N8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476969; c=relaxed/simple;
	bh=edb5eoknSPUq1qK19ORid7e1f+At9ujZ549j/v/oJaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aj+j4PKhQKwJ3fvMzUXh46pKAW33vo2bT0inQ3JsQEpUw4IXOkYXusBmXqsf2oxye0/85ozdWphKvB6X6puAdJ77y9/GKxo0lGvU4tFpGmAv+xWbTwT4WdOyflqIeuOuHSV8V5dJUs2ewLhuvkl3S6avTFNdxT3n934OgvGfG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzzs3mtp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzzs3mtp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476968; x=1821012968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=edb5eoknSPUq1qK19ORid7e1f+At9ujZ549j/v/oJaM=;
  b=nzzs3mtpn1iwOaflTOEHcdMijP/lv3KcSWDCVL2Vl9BZ8RtDzjaGAvCv
   L/VadO2Oq5G/ISfxfcNRrbQcM+xKNfw7e+uOV0hmojAjtkFkuROZs4n2O
   OGej4lFX4i0m7XafLf7MGYGsqzj2PCpM0I+wtsN7EFlKW0UKzjb2ITNI6
   ioyqPxmfEmTZIlm3omyjMg93dvJcFKeJZSe5aL5POmt5D7A05OHdchCjv
   e5zy3dljZvipOsa07VZUZg2tKliV6DeL5trAikVuVHXAgvKMnKYTAr15C
   hAqwxc1ydIhxnxmh+1Jl4PVQ7fVljrMcoDKQJX1RmXkC9cJ08GH6c62SY
   Q==;
X-CSE-ConnectionGUID: XqGNeaDaTAaBxqyTNWnfNQ==
X-CSE-MsgGUID: 8YFFTKRjQ2aQ6U2UH9RWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607068"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607068"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:53 -0700
X-CSE-ConnectionGUID: HIJuEqdDSCOJCqsILxWGTQ==
X-CSE-MsgGUID: 0OeayaWfQmyBVdXIQwr/cA==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:52 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 0/5] iavf: five correctness fixes
Date: Tue, 15 Sep 2026 14:55:46 +0200
Message-ID: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small batch of iavf bug fixes. Patches address a NULL-pointer dereference
crash in the hung-tx detector, a spurious free_irq() call in the misc-IRQ
error path, a VSI-state-corruption race when ethtool changes ring
parameters during an active reset, an inverted TC-boundary comparison
that silently steered frames to non-existing traffic classes, and an
-EINVAL that confused upper layers when a TC flower filter was looked up
after its qdisc had already been torn down.

All five are genuine correctness fixes with no functional changes for the
common path. All five are marked for stable given the crash/corruption/
kernel-warning/misdirection/error-reporting impact on shipping kernels.

This series was originally posted in April without a version tag and
stalled without being picked up. Re-posting as v2 with the fixes Simon
Horman requested in review, carrying forward the Tested-by tags collected
on the unchanged patches.

Changes since v1:
- Patch 1: Fixed the Fixes tag, which pointed at an unrelated i40e-only
  commit (9c6c12595b73); the function was actually introduced into the
  iavf lineage by 07d44190a389. Simplified the misleading NULL check on
  tx_ring (an array-element address, never NULL) to a check on
  tx_ring->q_vector instead, and read it with READ_ONCE() so the watchdog
  can't observe a torn/re-read value while a concurrent reset swaps it.
- Patch 4: Reworked the boundary comparison. `tc > adapter->num_tc` still
  let every in-range tc skip the destination-port requirement and let an
  out-of-range tc with a destination port fall through and return 0.
  Now explicitly rejects tc >= adapter->num_tc before checking for a
  destination port.
- Patches 2, 3 and 5 are unchanged from v1.
- Added Cc: stable@vger.kernel.org to all five patches.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Kiran Patil (2):
  iavf: fix null pointer dereference in iavf_detect_recover_hung
  iavf: return 0 when TC flower filter not found after qdisc teardown

Piotr Gardocki (1):
  iavf: fix error path in iavf_request_misc_irq

Sylwester Dziedziuch (1):
  iavf: prevent VSI corruption when ring params changed during reset

Avinash Dayanand (1):
  iavf: fix TC boundary check in iavf_handle_tclass

 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  5 +++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 19 ++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.c    | 50 +++++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.52.0

