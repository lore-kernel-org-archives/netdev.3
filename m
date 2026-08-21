Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AFE1DE894
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345144; cv=none; b=WktNUPSTfyS9Xf1Xl9dR4ncT/vIFQ2xFMvZ4ylETv+hLp8wkdX+h4Y0SM5wwpUHWCNCSsuEi/F9epsa1f8sXnhMozeT08Qg6cuCmbMyZaTA82u4tDFFEdxXeWDcP8mMae26i+3mFQ3spszYp+Dgg91DkvfnJkjx0bLzVJ0L648c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345144; c=relaxed/simple;
	bh=YlaU70I7d9fkB/zdJIATfkN2tt70EEVaI+++t4fmDUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB+Z36/SCnuGRjxExlE1VOWaTEjLRYl2enX96+IxW4pzjjax+kJ+n4R3TU5qCDfOjKMzW/D+JD3dRRCkIfkcG9/wVeIIgm7fhRPE80dlPkd8YG2LUCOZAwx8rG4Vf4iq5IgOu739cQg5y8nctN2ji2dp/IOtcepkoCD+SDbBlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YM9aVmEZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YM9aVmEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787345142; x=1818881142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YlaU70I7d9fkB/zdJIATfkN2tt70EEVaI+++t4fmDUk=;
  b=YM9aVmEZlnAtR8fZwueRPZboNXu4eo8Fw7OVfaWQaCsD0Dyy2SZTVgZc
   hNdQQfbDK9CA/fnjzp0t3XQ7IjjkDWaiat9w9ugdpJRSbY4lPHQMIOu3U
   cpNkg5RX6p+38ysF3ct+c/5dQAU4gSuUkMM0UJynjYg0hDrj9oUzAMBFc
   jtgMbox6IOAe4oJSuV2gz3X6TFlMVNLbZY23xj6k4xzfgRdnU81YL0Lnh
   MkpvTKr5fyA9Y2/ReLBupw7p8jm860nc5lOBkvjj7GZT7YMBowcU3Jw2E
   nuED6xGag28qtoP1bOVAIapDA+6cqNAGkfjNEVoQS96hMWN4gKkYxWB1Q
   g==;
X-CSE-ConnectionGUID: 8E9H3jh+QaeMlAKQVAwwCQ==
X-CSE-MsgGUID: k3BJeQRjRuqLcyOTYc0rBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88027592"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88027592"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:45:41 -0700
X-CSE-ConnectionGUID: fG5WLkOtQLmf4qLozmOznA==
X-CSE-MsgGUID: xoeqWfxRR3qPIVNgUgelHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="268400221"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2026 13:45:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	sdf@fomichev.me,
	horms@kernel.org
Subject: [PATCH net 0/4][pull request] Fix i40e/ice/iavf VF bonding after netdev lock changes
Date: Fri, 21 Aug 2026 13:45:32 -0700
Message-ID: <20260821204537.2189112-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jose Ignacio Tornos Martinez says:

This series fixes VF bonding failures introduced by commit ad7c7b2172c3
("net: hold netdev instance lock during sysfs operations").

When adding VFs to a bond immediately after setting trust mode, MAC
address changes fail with -EAGAIN, preventing bonding setup. This
affects both i40e (700-series) and ice (800-series) Intel NICs.

The core issue is lock contention: iavf_set_mac() is now called with the
netdev lock held and waits for MAC change completion while holding it.
However, both the watchdog task that sends the request and the adminq_task
that processes PF responses also need this lock, creating a deadlock where
neither can run, causing timeouts.

Additionally, setting VF trust triggers an unnecessary ~10 second VF reset
in i40e driver that delays bonding setup, even though filter
synchronization happens naturally during normal VF operation. For ice
driver, the delay is not so big, but in the same way the operation is not
necessary.

This series:
1. Adds safety guard to prevent MAC changes during reset or early
   initialization (before VF is ready)
2. Eliminates unnecessary VF reset when setting trust in i40e (reset only
   if revoking trust and VF has advanced features configured).
3. Fixes lock contention by polling admin queue synchronously
4. Eliminates unnecessary VF reset when setting trust in ice, (reset only
   if revoking trust and VF has advanced features configured).

The key fix (patch 3/4) implements a synchronous MAC change operation
similar to the approach used for ndo_change_mtu deadlock fix:
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/
Instead of scheduling work and waiting, it:

- Sends the virtchnl message directly (not via watchdog)
- Polls the admin queue hardware directly for responses
- Processes all messages inline (including non-MAC messages)
- Returns when complete or times out

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task.

The function can sleep for up to 2.5 seconds polling hardware, but this
is acceptable since netdev_lock is per-device and only serializes
operations on the same interface.

Testing shows VF bonding now works reliably in ~5 seconds vs 15+ seconds
before (i40e), without timeouts or errors (i40e and ice).

Tested on Intel 700-series (i40e) and 800-series (ice) dual-port NICs
with iavf driver.

Thanks to Jan Tluka <jtluka@redhat.com> and Yuying Ma <yuma@redhat.com> for
reporting the issues.
---
These patches are split off from this submission:
https://lore.kernel.org/netdev/20260804222205.1580328-1-anthony.l.nguyen@intel.com/

Which had comments from Sashiko; responses to each patch are linked below.

From patch 1 response:
All the comments below fall into pre-existing issues, concerns already
addressed in previous versions, out-of-scope items, or extreme edge
cases. No code changes are considered necessary for a new version.

Patch 1: https://lore.kernel.org/netdev/20260812065650.10326-1-jtornosm@redhat.com/
Patch 2: https://lore.kernel.org/netdev/20260812065955.10460-1-jtornosm@redhat.com/
Patch 3: https://lore.kernel.org/netdev/20260812070236.10559-1-jtornosm@redhat.com/
Patch 4: https://lore.kernel.org/netdev/20260812070502.10679-1-jtornosm@redhat.com/

IWL: https://lore.kernel.org/intel-wired-lan/20260623101800.991293-1-jtornosm@redhat.com/

The following are changes since commit 746fc0787f616da418ffc04a110296fe95d53491:
  net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Jose Ignacio Tornos Martinez (4):
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 +++++--
 drivers/net/ethernet/intel/iavf/iavf.h        | 11 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 88 +++++++++++++----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 99 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 35 ++++++-
 5 files changed, 226 insertions(+), 45 deletions(-)

-- 
2.47.1

