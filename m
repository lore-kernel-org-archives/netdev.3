Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0D342C9E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635502; cv=none; b=oPGQY/iI/xpGm39o+7+5SJ4ircbHJCaXBoMswunBWT13gcPENIt6tsn6xuGMPvoUkLm/LJ6bDdfjpXqn2X7uorxllDmyd4rZHCT2mM3i8Bdadnu3nsIGXrDPOgy4ZxDOncfHPEQ2oMG+OYmGHxVxrLLl7LWUfRvCgrxZy+HWqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635502; c=relaxed/simple;
	bh=oi4H/6SLQYRCovZZVjnpIu8q58ca94NntPJs1HOtgtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzkiXDQeb71+szSqpLWsxcVYeamd6/XHkaVfsTYpibaoJSohwZ947JV1bIM6s+xbFrSNzFa5HMeXZCFslvt69mK0nAJpcReMZzPI8UK0QsM/oEjnt7u9RqGfV7iB1t21ST1VOAnrp5HmVuJw6tzsL2YlgCTOGs+fg9C7szyVEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsFoLZ1I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsFoLZ1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790635501; x=1822171501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oi4H/6SLQYRCovZZVjnpIu8q58ca94NntPJs1HOtgtI=;
  b=dsFoLZ1I203Gc0F366Df0cjib7rPGWOO59MEnXvNQMYI04b7tC6Xd4RT
   WZvrKjYT7CD4J5o8Qio+nkxTFliZmiLGynBX9ustzrQeKZEOWQ3Gha4k/
   /c0NATqHT/ei3COTnDw+dKArKCnJold8n8t/IqdEUTwUMN3JtMY7ezrkU
   AmZeQrnfEumsUNL5ccAO7I4gIY0nrMj10xFTL5lifzAxTvh+16umdo51v
   0rpigVdnrMndQa9ailKcQSTtN15ghPrU+lbCTlXYCTwcv9RlGq+H75wkE
   y8BIr9zTUvfqwPvqkQ3kx6mXeWuP/tOYzWJxltwx/iQiYenIQgDAMjdgo
   w==;
X-CSE-ConnectionGUID: 3/JbpnrSQyaOvw+Sbig4rQ==
X-CSE-MsgGUID: 9/QBVRA2QdKxP4MiaJKR7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91209059"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="91209059"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:44:59 -0700
X-CSE-ConnectionGUID: pw3wYNpnRqKrLCebpIXM2A==
X-CSE-MsgGUID: oHvArRJbQHWG2LQ5tBzD5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278392123"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Sep 2026 15:44:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jtornosm@redhat.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	horms@kernel.org,
	sdf@fomichev.me
Subject: [PATCH net v2 0/3][pull request] Fix i40e/ice/iavf VF bonding after netdev lock changes
Date: Mon, 28 Sep 2026 15:44:48 -0700
Message-ID: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
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
1. Eliminates unnecessary VF reset when setting trust in i40e (reset only
   if revoking trust and VF has advanced features configured).
2. Fixes lock contention by polling admin queue synchronously
3. Eliminates unnecessary VF reset when setting trust in ice, (reset only
   if revoking trust and VF has advanced features configured).

The key fix (patch 2/3) implements a synchronous MAC change operation
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
v2: 
- Drop patch "iavf: return EBUSY if reset in progress or not ready during MAC change"
- Convert set_bit/clear bit pattern to assign_bit

v1: https://lore.kernel.org/netdev/20260821204537.2189112-1-anthony.l.nguyen@intel.com/

Split off from this submission:
https://lore.kernel.org/netdev/20260804222205.1580328-1-anthony.l.nguyen@intel.com/

The following are changes since commit a7bfaba4823e3c165bb2004c74eff7c096672bc7:
  ipv6: fix prefix route expiry in modify_prefix_route()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Jose Ignacio Tornos Martinez (3):
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 35 +++++--
 drivers/net/ethernet/intel/iavf/iavf.h        | 11 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 85 ++++++++++++----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 99 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 +++++-
 5 files changed, 217 insertions(+), 45 deletions(-)

-- 
2.47.1

