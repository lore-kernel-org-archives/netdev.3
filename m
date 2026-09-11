Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0662217648
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086886; cv=none; b=fWKKjF7KIStLAdrKnadA3YmdhcAWI9Hasgn7Lo5kmM7lltO7xknr7Ik0HS3FeLE6N0kueyHaeMdWfHzrQxqa2zPDO61rPu1GvpxQ2jnzZygi8nwzlofqsnIAshLSHtw70tp9H/9UygWefS/QCLKsDnDOFEpilukjzHo1wsRLwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086886; c=relaxed/simple;
	bh=NP20hE6bahMgl1EI+IjenEpDt+7JXvgtK1XyB22gpCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzF/3N2V/h7xNtjxgLJF2cJdB/YcEfQJYWO+cX0CaPXlza6F/iYS+vB0NuI0WG+iW9Ysb/7If84eYJ1kU7dDuWiRpVMWpKOfEF1gQYdcKykGKp56AxnkWIbYH22/g0JIIk5j2qA1vWLDWqt9le2PRto55ryDLzLMGUykwRO7HqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJGmQaJQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJGmQaJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789086884; x=1820622884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NP20hE6bahMgl1EI+IjenEpDt+7JXvgtK1XyB22gpCk=;
  b=LJGmQaJQ4Ft9RBOpechvW2JZ9rxjL+kcrz44VBF+VgOSsgNdqKFqSLZN
   qcDCCm9rxND7yJ8oHqqh5VZi1rgErd86XA9BLJtzwRzOpSdJMq+AGtzxJ
   0xVsaZgQ5XbAFn2MhIbo/y5l5d4XZju5efCuTLoly9pB4VSFrWhn1QwLa
   VFeNwe+69y7X3MQ3C1ULwgBARclaGWRqKDnktsdrA/vqg/osymWuXY07d
   jQFdcA2orBVvIeCiz/Irea3i9JU7qAIhBOfqh8tNy5QUz2k9fRuq7JWLy
   OQf8lrX53zEm1S2H0Eg2aJ5akLymeEtYuC8i6VkPrvZBuD1f3ZixjIKsL
   A==;
X-CSE-ConnectionGUID: 5aj1rK82SN2WxYUuUXMZMw==
X-CSE-MsgGUID: FH/v3+juQHqHWbbaftpa5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89564662"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89564662"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 17:34:43 -0700
X-CSE-ConnectionGUID: Z5ErcdLKTeqlJKWH84dEkA==
X-CSE-MsgGUID: hXSpABRkTCebHySeSiKb8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272291039"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2026 17:34:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jacob.e.keller@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: [PATCH net 00/15][pull request] ice: E82x: timestamp processing logic fixes
Date: Thu, 10 Sep 2026 17:34:09 -0700
Message-ID: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jake Keller says:

This series contains several related fixes for the ice driver PTP logic
relating to timestamp handling and device (re)initialization.

Of particular note is some changes around the handling of timestamps that
are requested near device state changes such as administrative up/down
cycles and link change events.

The E825 device logic in the PHY has an internal counter which is used as
part of the "threshold" logic which determines when the device will trigger
an interrupt signal from a given PHY port to the MAC. This internal counter
requires some precise handling to ensure that the internal device state
remains in sync with software expectations. Otherwise, the device can be
finagled into a state where the PHY stops producing new timestamp interrupt
notifications to the MAC indefinitely. This in turn degrades the timestamp
processing latency and results in application failures for common
timestamping applications such as ptp4l.

There are four major categories of problem resolved by this series:

 * Timestamp requests made while the PHY_REG_TX_OFFSET_READY bit is cleared
   will increment the internal counter, but leave their valid bit set to 0.
   Upon read, the counter is not decremented. This leads to a desync of the
   counter and blocks the PHY interrupt.

 * Software logic for tracking timestamps incorrectly cleared in-use bits
   without waiting for completion in certain cases. If the timestamp *does*
   later complete, it leaves an "orphaned" ready bit which is not
   tracked by software. This results in the internal counter becoming
   desynced if that index is re-used.

 * The PHY timestamp memory region lacks pull-down zero-initialization at
   power on, resulting in uninitialized random data in the memory region.
   If software reads these values, an entry with its valid bit set to 1 can
   trigger a counter decrement and cause an underflow which results in the
   counter becoming desynced.

 * Timestamp request which complete near the beginning of the PHY losing
   link can become "stuck" such that the hardware logic triggered by a
   timestamp read does not activate. The memory status bit and the valid
   bit in the timestamp index are not cleared. This window where this
   may occur begins *before* the firmware notifies the driver of link loss.
   When this occurs, the driver may accidentally re-use a stale timestamp,
   and the IRQ re-trigger logic triggers a repeated IRQ "storm" that can
   consume significant excess CPU time.

The series' primary focus is towards preventing driver flows that can
trigger the above sequences. It is based on work from Przemyslaw Korba which
was previously posted at [1]. During that series development, Petr from
RedHat reported the 3rd issue mentioned above. While attempting to root
cause that issue, several other issues were uncovered and those fixes have
also been included in this series.

First, the locking around the PTP ports list in the adapter structure is
converted to use RCU primitives and a spinlock, resolving a couple of
reports from Petr about places where the original list was accessed without
lock protection. Note that an older version of this fix used an xarray
instead of the list. The xarray has more overhead and results in an
increase of ~25 microseconds to the average latency for processing Tx
timestamps. The list is simpler and avoids this overhead.

Next, the PTP reset flow is fixed to stop tearing down the Tx tracker
during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
permanently after such a reset. This issue was found by Sashiko during
review of a previous version of this series.

Next, the ice_ptp_request_ts() function is updated to sequence the marking
of the in_use bitmap in order to work properly with the lockless reader in
the IRQ thread. This issue was reported by Sashiko during review of a
previous version of this series.

Next, come two fixes for E822 hardware that were originally posted as part
of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
work task is properly canceled during device reset, and new timestamp
requests are kept disabled until the validation task completes.

Next, Arkadiusz modifies the driver to stop pretending that the link has
gone down during ice_down(). This removes "virtual" PTP link changes that
occurred on several flows including MTU change, Eswitch setup, and others.
Now, the driver only triggers a PTP PHY timer reinitialization when the
physical PHY link has changed instead of during many other actions.

Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
bit. This bits only purpose is to tell hardware to mark any captured
timestamps as invalid. Since this also disables the necessary side effects
on read it is problematic to have cleared. According to hardware engineers,
keeping it enabled should not have any other side effects.

Next, the driver is modified to clear the PHY_REG_TX_MEMORY_STATUS by
reading each index *prior* to the PHY soft reset. This ensures that any
stale or invalid data left in the memory array is cleared, followed by the
counter being reset via the PHY soft reset procedure.

Next, the E825 timer start procedure is modified to first include a soft
reset. This ensures that upon link up the device is reconfigured from a
known-good state with its internal counter reset and everything cleared.

Next, Petr modifies the ice_ptp_flush_tx_tracker() function to wait a little
bit for any outstanding timestamps before flushing.

Next, Petr modifies the ice_ptp_process_tx_tstamp() function to avoid
releasing any index from software unless either a) it is actually completed
by hardware or b) it is timed out waiting for a full two seconds. This
closes the final gap from the second issue mentioned above. Instead of
immediately releasing the index, the software now waits until hardware has
completed it or the driver has waited long enough to be sufficiently sure
that no such timestamp will be done.

Next, the driver is modified to no longer mark timestamps as "stale" during
a clock adjust event. This avoids marking timestamps as stale unnecessarily.

Next, the ice_ptp_process_tx_tstamp() function is modified to verify
that hardware actually cleared the ready bitmap. This ensures that we do
not report false timestamps near a link down event.

Finally, Maciek adds a needed PHY recalibration for E825-C after large system
time adjustments. Without recalibration, PHY timestamps do not properly
converge to the new time, resulting in inaccurate timestamp readings.

Link: [1] https://lore.kernel.org/intel-wired-lan/20260720120151.2675206-1-przemyslaw.korba@intel.com/
---
IWL: https://lore.kernel.org/intel-wired-lan/20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com/

The following are changes since commit 78445023439506ebd83b86d40b1e428a3b309d4a:
  Merge tag 'net-7.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arkadiusz Kubalewski (1):
  ice: call PTP link change only from link events

Jacob Keller (9):
  ice: use reference counting and RCU for PTP port access
  ice: fix removal of PTP timestamp tracker during reset
  ice: set in_use only after preparing Tx timestamp index
  ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
  ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
  ice: E825: perform a soft reset when starting the PHY timer
  ice: remove unnecessary discarding of timestamps after clock adjust
  ice: skip reading Tx ready bitmap on ports with no timestamps
  ice: don't clear in_use until HW clears ready bitmap

Karol Kolacinski (2):
  ice: E822: keep Tx timestamps disabled during offset calibration
  ice: E822: cancel offset verification work during reset preparation

Maciek Machnikowski (1):
  ice: Recalibrate PHY after settime64 on E825-C

Petr Oros (2):
  ice: wait for in-flight Tx timestamps before flushing the tracker
  ice: keep Tx timestamp slots tracked until completion or timeout

 drivers/net/ethernet/intel/ice/ice_adapter.c |   7 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |   6 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 358 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 104 +++---
 6 files changed, 326 insertions(+), 173 deletions(-)

-- 
2.47.1

