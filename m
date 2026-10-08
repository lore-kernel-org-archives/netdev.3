Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E4347BC6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496640; cv=none; b=HbXEms5qF/ET1xDU0Ce6TdES37JwpxCB74/gUfnxjYqaCphh0F1ARz5prUXybqKh6s3vTHGuR1QzRYujF16+FVcMcHuLCwOsYQc67mF0gT/65TzllOHrTJyrWX8rmDg5sfCYUtBAffN4p5UHsScQtxlo9IUjGn8P5yeZCWfm6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496640; c=relaxed/simple;
	bh=pVdXJPFGeSLkOyMtLlROwqHLRuO8OF9ncxvZimUzFRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SA+40rXfiZnYOjPwOPYQ6utTEB0TmlziPnOBl7NHghxrd1AoDUHfqbUwAqcNDO8qmJRcpUhEx01sW+E1VLmAql48cvi1yoptgzmiiWWWmCtOAb7JWGl0LVcuofOUW8pvEELDunWtFiVfhetIJSUbO1Juk1P4Lh3I249UCXHvuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Znq/Peqb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Znq/Peqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791496638; x=1823032638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pVdXJPFGeSLkOyMtLlROwqHLRuO8OF9ncxvZimUzFRw=;
  b=Znq/Peqb8w6jIY+l2copy/wO+Q2nAGoGIoX2+SZYSa28IFtzBloAyCo5
   Jxk7ugO2eEbgpzibUZjB2jYNPmGsLRwkKnXPPaViPsqh6bze4QdKdaX88
   4XZ7CGIaW2nGqbHykC7kcUip/HJq2GRBu6ame0btJh0xg3bwJMSCJTzDo
   7VhEOScHZ8/tkdHzvBQun0iHrk89ENRobeL7Y5QB9MG1vRMkpOdVHYUip
   K453Hcc/dprOXi50kiRnmYG/52ETuvMzG5BCYWKiBu60/9MIk1kTn0NIT
   /BPZyzA8aqbc4a+XjGtrD9PdBD692J24KyIghoJTAE9djfijxZhkIEXws
   g==;
X-CSE-ConnectionGUID: R9Jy/tafS0OFvBtURqmviw==
X-CSE-MsgGUID: lViyUciCQwqFpRjvSXXS8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="294616"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="294616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:57:17 -0700
X-CSE-ConnectionGUID: j11NuzUkRmu+okOPsOhwPg==
X-CSE-MsgGUID: 1jEU9xNOTmuejZo10eDX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="150394"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2026 14:57:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
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
Subject: [PATCH net v2 00/15][pull request] ice: E82x: timestamp processing logic fixes
Date: Thu,  8 Oct 2026 14:55:57 -0700
Message-ID: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
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

First, the PTP reset flow is fixed to stop tearing down the Tx tracker
during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
permanently after such a reset. The fix also ensures that all teardown
paths properly release the tracker. This issue was found by Sashiko during
review of a previous version of this series. 

Next, the locking around the PTP ports list in the adapter structure is
converted to use RCU primitives and a spinlock, resolving a couple of
reports from Petr about places where the original list was accessed without
lock protection. Note that an older version of this fix used an xarray
instead of the list. The xarray has more overhead and results in an
increase of ~25 microseconds to the average latency for processing Tx
timestamps. The list is simpler and avoids this overhead.

Next, the PHY restart locking is fixed to avoid an issue with a concurrent
execution of ice_ptp_restart_all_phy() and a link change on a given port.
Additionally, the PHY port locks are merged into a single per-adapter lock
to reduce locking complexity.

Next, the ice_ptp_request_ts() function is updated to sequence the marking
of the in_use bitmap in order to work properly with the lockless reader in
the IRQ thread. This issue was reported by Sashiko during review of a
previous version of this series.

Next, Arkadiusz and Jake modify the driver to stop pretending that the link
has changed at administrative ice_down() and ice_up(). This removes
"virtual" PTP link changes that occurred on several flows including MTU
change, Eswitch setup, and others. Now, the driver only triggers a PTP PHY
timer reinitialization when the physical PHY link has changed instead of
during many other actions.

Next, come two fixes for E822 hardware that were originally posted as part
of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
work task is properly canceled during device reset, and new timestamp
requests are kept disabled until the validation task completes.

Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
bit. This bits only purpose is to tell hardware to mark any captured
timestamps as invalid. Since this also disables the necessary side effects
on read it is problematic to have cleared. According to hardware engineers,
keeping it enabled should not have any other side effects. Instead, the
tx.calibrating field is used to disable new timestamps from software in a
similar manner to the older E822 devices.

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

Next, the ice_ptp_process_tx_tstamp() function is modified to verify
that hardware actually cleared the ready bitmap. This ensures that we do
not report false timestamps near a link down event.

Finally, Maciek adds a needed PHY recalibration for E825-C after large system
time adjustments. Without recalibration, PHY timestamps do not properly
converge to the new time, resulting in inaccurate timestamp readings.

[1] https://lore.kernel.org/intel-wired-lan/20260720120151.2675206-1-przemyslaw.korba@intel.com/
---
For those interested, here is a summary of the latency numbers for Tx
timestamps on my setup for comparison throughout the series. In all cases,
the ptp4l test used a profile with a sync rate of 16/second and the
"torture" test additionally operated a second thread on another port
operating a burst of 32 concurrent timestamp requests every 10
milliseconds, all operating on E825 hardware, with a 3 minute capture time
for each test.

1. Before this series

  ptp4l only
  Mean: 298.67 microseconds, stddev: 28.60

  ptp4l + torture
  Mean: 637.02 microseconds, stddev: 351.59

2. After SRCU rework

  ptp4l only
  Mean: 314.10 microseconds, stddev: 32.99

  ptp4l + torture
  Mean: 622.68 microseconds, stddev: 343.57

3. Everything up to keeping Tx timestamps tracked until completion

  ptp4l only
  Mean: 317.43 microseconds, stddev: 34.51

  ptp4l + torture
  Mean: 622.31 microseconds, stddev: 339.26

4. After rechecking the HW ready bitmap

  ptp4l only
  Mean: 184.98 microseconds, stddev: 53.79

  ptp4l + torture
  Mean: 719.71 microseconds, stdev: 321.195

5. After the full series

  ptp4l only
  Mean: 195.92 microseconds, stddev: 25.28

  ptp4l + torture
  Mean: 717.77 microseconds, stddev: 321.58

The run-to-run variance here is somewhat high, but its clear that
timestamping across multiple ports under heavy load has a significant
latency cost. This is to be expected due to the nature of serializing the
timestamps to a single IRQ. In the usual cases with a lower timestamp load
and especially if ports do not have active timestamp requests, the series
has a decent reduction in timestamp latency. The use of Sleepable RCU does
seem to have a minor latency cost but it is overshadowed by the improvement
to elide checking when there are no requests in software.
---
v2:
- Drop the timeout on waiting for kref drain. The synchronize_srcu() makes
  it moot, and its only purpose is for a case that won't happen without
  programming errors like a reference leak.
- Check for errors on init_srcu_struct() when initializing.
- Hold the ps_lock in ice_ptp_link_change() earlier, as it is safe to
  acquire around the dplls.lock, which simplifies the reasoning for the
  given patch as well as following patches in the series.
- Re-order ice_ptp_init_port() in ice_ptp_init() to happen prior to
  ice_ptp_setup_pf() so that the Tx timestamp tracker is already
  initialized before the PTP port is inserted into the list. Ensure that we
  also tear the tracker down only after the port has been removed from the
  list.
- Re-order the patch that adresses PTP link changes to be before E822
  fixes, since AI pointed out that one of the issues was addressed by the
  link change re-ordering.
- Revert back to kthread_cancel_delayed_work_sync() instead of
  kthread_flush_work() since the latter doesn't safely handle a delayed
  work task.
- Fix the ordering of the parameters in the warning in
  ice_clear_ptp_tstamp_eth56g().
- Add a note about the E810 hardware skipping the
  ice_ptp_maybe_trigger_tx_interrupt(). The hardware doesn't have the same
  ready bitmap issues as E822 and E825. There is a possible gap because
  nothing will re-arm and sweep the tracker if all 64 slots are filled.
  However, there is a pre-existing issue on E810 where triggering a new
  timestamp interrupt could cause issues with outstanding low latency
  requests. I can't fix that in this series, and plan to address it as a
  followup.
- Check tx->init in ice_ptp_mark_tx_tracker_stale.
- Call ice_ptp_mark_tx_tracker_stale when stopping the PHY timer for E825,
  preventing existing outstanding timestamps from being reported with a bad
  offset.
- Update the dev_err on failure in ice_ptp_port_phy_restart() to better
  reflect the magnitude of the problem, and indicate a link toggle may help
  recover.
- Update some comments and kernel doc messages for clarity.
- Skip maybe_trigger_tx_interrupt for the E810 low latency interrupt path
  only, not for the older legacy paths.
- Re-order patches so that the Tx tracker fix comes first before the PTP
  port SRCU changes. This should avoid some spurious reports from Sashiko
  about ordering guarantees which are fixed by that change.
- Convert to sleepable RCU instead of the convoluted and likely broken
  dropping of RCU readlock critical sections.
- Update the messaging to be clear this does not solve the ctrl_pf access
  issues.
- Update the comments regarding the teardown and 15 second timeout to
  better reflect the intention.
- Drop the patch that reverted marking timestamps as stale during an
  adjustment. It may be safe for some smaller atomic adjustments, however
  possible issues were reported for larger adjustments by multiple models.
  Since we do not have many reports of missing timestamps, just keep the
  logic as-is.
- Add a new patch to correct serialization of the PHY port restarts to
  avoid a potential re-ordering of the link_up status causing the port to
  be left in a disabled state if a race occurs near a link up transition.
- Fix the PTP teardown during a failed reset to avoid leaking the Tx
  timestamp tracker and other PTP state.
- Add smp_rmb() to the lockless in_use reads in
  ice_ptp_process_tx_tstamp() ensuring that weak ordered architectures do
  not re-order the start time in the event of a race with a new timestamp
  request.
- Update the patch which drops the E825 clearing of PHY_REG_TX_OFFSET_READY
  with a software gate of new timestamp requests via the tx.cablibrating
  field, so that new requests will be rejected until the PHY has been
  initialized.
- Update the fixes tag for one of the E822 fixes to better reflect the
  actual kernel that introduced the problem.
- Update several commit messages and comments for clarity and accuracy as
  suggested by Sashiko during review.
- Since the E822 offset validation work already checks and reschedules when
  the driver is resetting, replace the kthread_cancel_delayed_work_sync
  with kthread_flush_work() to ensure that it sees an updated state. This
  avoids some complex changes that would otherwise be required to be
  certain that a reset with a concurrent link change wouldn't result in the
  offset task being canceled indefinitely.
- Use READ_ONCE/WRITE_ONCE when checking the link_up field of the PTP
  state.
- Treat failure to read a timestamp during the E825 sweep before a soft
  reset as non-fatal with a warning. In practice, if a read is skipped we
  still should not have a problem unless other code incorrectly reads the
  index without checking the PHY ready bitmap first. To avoid log spam if
  the device is truly inaccessible, the total read failure count is
  summarized in one message per port.
- Remove the unused soft_reset parameter from one of the E825 functions.
- Fix the watchdog re-trigger of the timestamp interrupt to work for
  devices which manage their own interrupt, instead of only on the clock
  owner.
- Fix the accounting for timed out timestamps in the unlikely case that a
  timestamp will timeout but suddenly have its ready bitmap bit stuck high.
  Now, the timeout counter is only incremented once the timestamp is
  actually dropped.
- Update commit message and comments to better reflect current
  understanding of the PHY soft reset behavior including its (non)impact on
  configuration registers.
- Switched to read_poll_timeout for the tracker drain logic to get better
  timing behavior.
- Skip the tracker drain on E810 with a has_ready_bitmap flag check.

v1: https://lore.kernel.org/netdev/20260911003430.3386340-1-anthony.l.nguyen@intel.com/

Possible outstanding issues not addressed:
- ctrl_pf serialization and access is not handled by this series. Another
  developer has been investigating this and is still undergoing feedback.
  Perhaps the solution could piggyback on the port reference count, but we
  do not yet have a complete solution.
- Recent reports of missing PTP semaphore locking on certain flows are
  being investigated by another engineer and will be handled as a follow
  up.
- The low latency timestamp interface for E810 appears to possibly have
  some gaps and potential to override an in-flight timestamp request. This
  will be investigated as part of a separate follow-up series.

AI reports that may still remain:
- Sashiko pointed out some ideas about flushing the tracker when we restart
  the PHY port for E825, which I have not opted to implement in this
  series. It still needs investigation and I am currently thinking that it
  is best if we always keep timestamp indexes locked by software until we
  wait that 2 seconds. There are just so many ways this can race and go
  wrong :\ Relatedly, Sashiko also pointed out some potential races with
  flushing the trackers, which I will investigate but do not think should
  hold this series up.
- Sashiko pointed out that the behavior of restarting the PHY ports
  post-reset may be somewhat problematic. This needs investigation and I do
  not yet have a solution. In particular, we can't just let each port do
  its own restart because we need to be sure that the clock owner has
  finished setting the time, but we also cannot necessarily just let the
  clock owner handle it either because the clock owner cannot reliably know
  the link state of the other ports. This is being investigated as well,
  but I would prefer to not hold this already large series up for this.
- Sashiko has complained about potential for missing link event triggers
  since we no longer call ice_ptp_link_change() at ice_up_complete(). This
  seems to be a theoretical problem which I don't have a good solution for.
  The attempts to fix this in previous versions has consistently still led
  to complaints from Sashiko. We need to investigate what mechanism would
  robustly ensure that any link transition or failure to program the PHY is
  not missed and can be restored. However, I would prefer not to delay this
  series while we try to figure that out.
- Sashiko suggested clearing the PHY soft reset device state if the
  function exits early. I opted not to change this flow as it was the
  suggested flow from hardware engineers, and the chance of failure in this
  flow is low and likely already implies a more catastrophic failure (i.e.
  failure to access the sideband queue).
- Some models love to point out places where we bail out on failure to
  access the PHY and leave various flags or state in a disabled way, such
  as not clearing the calibrating flag or leaving the PHY with its soft
  reset bit set. I did not make an attempt to fix these. It is very
  unexpected to be unable to access the PHY, and we're more or less
  treating such failures as catastrophic.
- Sashiko complains about possible ways that ice_ptp_process_tx_tstamps()
  could fail and exit early that would cause problems, either keeping an
  SKB held in memory and essentially leaked for longer than expected, or if
  we fail to clear the in_use bits and could keep re-triggering the IRQ.
  These are highly unexpected errors which are pre-existing issues that may
  be tricky to address, and I haven't attempted to resolve them here.

The following are changes since commit 2b82e16d6084cbc651e3c902198f1945408ee1a5:
  net: sparx5: free the matchall entry on destroy
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arkadiusz Kubalewski (1):
  ice: call PTP link change only from link events

Jacob Keller (9):
  ice: fix removal of PTP timestamp tracker during reset
  ice: use reference counting and SRCU for PTP port access
  ice: fix PHY port restart serialization
  ice: set in_use only after preparing Tx timestamp index
  ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
  ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
  ice: E825: perform a soft reset when starting the PHY timer
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

 drivers/net/ethernet/intel/ice/ice_adapter.c |  20 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  20 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 494 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 143 +++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   2 +-
 7 files changed, 477 insertions(+), 230 deletions(-)

-- 
2.47.1

