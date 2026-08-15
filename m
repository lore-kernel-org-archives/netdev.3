Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FC38838B;
	Sat, 15 Aug 2026 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775990; cv=none; b=Jlq0H9wst2a7VNSI8Zel0qckGMk+fPtJwrE+mOM419t2KFDWBb4PISuTiR63ICxxvXh+F4o/nMRh8kDYjwYGzh/bb2MwPaFBXLI8JaoozA8rxawPoiOfxMwTls11x4d79DD8x6OpAGoVrftlUvvbIBDo1d24dlbCtNltmsBy9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775990; c=relaxed/simple;
	bh=LYH961mrf2KMUtvnSoUqVLCXwphD+ycmxC6An4KFd7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XnrN3YM3hllBI7/yZv1RsxOE2ZkREtphSRn6MoeC/qfdZFfRqtBmBFWwsnGCklAg5t2HM83G+0ta0o3RxDyPbPIa/2h6r1UACq27oSLtCFgmffWeONdV+PB9KbrbubBFIvY76MRTZNxgocZuywl1SX7f2CCQyeN/Scfcggscp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wv834-0000000071w-2oWT;
	Sat, 15 Aug 2026 06:39:18 +0000
Date: Sat, 15 Aug 2026 07:39:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
	Kiran K <kiran.k@intel.com>,
	ChandraShekar <chandrashekar.devegowda@intel.com>
Subject: [PATCH net-next v11 0/6] net: dsa: mxl862xx: devlink flash and rescue
Message-ID: <cover.1786773971.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds "devlink dev flash" and "devlink dev info" support to
the MaxLinear MxL862xx DSA driver, and makes a switch stuck in its
MCUboot loader recoverable through the same path.

Patch 1 adds a flash_update callback to dsa_switch_ops so a DSA driver
can implement the devlink operation. Patch 2 adds clause-22 SMDIO
register access, which is the only channel the loader answers on.
Patch 3 adds device_schedule_reprobe() to the driver core. Patch 4
implements the flash and info operations over SMDIO. Patch 5 detects a
switch sitting in MCUboot, registers it in a reduced rescue mode so
devlink stays reachable, and drains an interrupted download back to a
state the loader will accept a new image in. Patch 6 documents the
result.

The AI review Paolo forwarded on v10's patch 3 found two real issues in
the deferred re-probe: the work function's trailing module_put() races
a concurrent rmmod freeing the module text, and nothing synchronizes
the deferred detach against device_shutdown() or an administrative
unbind. Both are inherited from the iwlwifi pattern the code was
modelled on, and neither can be fully closed from driver code, since
device_shutdown() holds device_lock() across ->shutdown() and
device_reprobe() takes the same lock, leaving any driver-side check a
TOCTOU. They are therefore fixed in the driver core instead: patch 3
adds device_schedule_reprobe(), as posted in the RFC together with
conversions of the existing open-coded users [11], and the driver now
schedules its post-flash and post-drain re-probe through it. Following
the discussion on the RFC thread, the helper is picked up into this
series so that mxl862xx does not add another open-coded copy; the
conversions of the existing users (iwlwifi, hci_h5, btintel_pcie) will
follow as a separate series once the helper has landed.

The helper itself was runtime-tested (backported to 7.0.11) on Intel
AX101 hardware with PROVE_LOCKING and DEBUG_OBJECTS_WORK, driving
iwlwifi's crash escalation into the re-probe path: normal detach and
rebind, an unbind racing a pending re-probe (the unbind is not undone),
rmmod with a re-probe pending, and reboot with a re-probe pending; no
lockdep or debugobjects reports. See [11] for details.

Tested on an MxL86252C switch of the BananaPi R4 Pro 8X (asic.id 8628).
Repeated devlink dev flash cycles across three firmware builds each
completed in under a minute -- running firmware detected at probe, a
full flash and reprobe, the new version reported afterwards. A crash
mid-transfer left the switch wedged in its loader; the next boot
detected the interrupted download, drained it in the background, and
reprobed into rescue mode (firmware 0.0.0), from which devlink dev
flash restored running firmware. A hard reset during a flash brought
the loader up clean at READY, flashable directly without a drain.

Changes since v10 [10]:
 - new patch 3: driver core: add device_schedule_reprobe(), as posted
   in the RFC [11], used to schedule the post-flash and post-drain re-probe with
   device_schedule_reprobe() instead of a driver-owned work item.
 - the dsa_switch allocation returns to devres. Keeping it out of
   devres only defused the remaining check-vs-detach window, which the
   core helper closes outright
 - scheduling the re-probe is now the one step that can fail after the
   switch was flashed, since the helper allocates its work item
   internally and v10's allocate-up-front dance is no longer possible.
   An -ENOMEM there is a system-wide condition no driver-level message
   or recovery improves, so flash_update just returns it (unbind and
   rebind reinitialises the driver), and a drain whose hand-off fails
   still marks recovery failed so devlink does not keep promising a
   retry

Changes since v9 [9]:
 - Harmonised the SB PDI timeouts. The verify wait is now one constant
   shared by the flash and drain paths (15 s), the 1-byte mailbox step
   is another (2 s) used by the drain and by both detection waits, and
   the per-slice write budget drops from 120 s to 60 s. The last-slice
   flush, which cannot see the boundary between programming and
   verifying, gets the sum of the two.
 - The post-flash and post-drain reprobe no longer detaches a device
   that has been shut down or unbound, and the dsa_switch is allocated
   outside devres so a lost race cannot leave dsa_switch_find() reading
   freed memory. This was a live bug in v9's patch 3 as well, reachable
   by rebooting within 500 ms of a flash.
 - A failed reprobe hand-off after a successful drain now logs and
   fails flashing outright, instead of leaving devlink answering "retry
   shortly" for good. Dropped heal_lock and mxl862xx_stop_work() with
   it: the lock only made the flag test and the queueing atomic, which
   is not the guarantee the comment claimed, and the reprobe's own
   check is what actually decides now.
 - A loader that publishes READY but never services the register-read
   challenge now reports -ENXIO rather than propagating -ETIMEDOUT, and
   the documented return sets of mxl862xx_rescue_mode_detect() and
   mxl862xx_rescue_drain_finish() match what the code returns.
 - Commit message for patch 4 no longer claims a running firmware is
   "left untouched" (the presence probe writes two mailbox scratch
   registers, inert to a firmware that does not read them), says that
   an SB PDI window away from the OTP reset offsets also yields
   -ENODEV, and describes the -ENXIO outcome above.
 - Commented why STAT == 0 during a drain is unambiguous: by the
   r_remain == 0 rule the loader cannot be both inside the receive loop
   asking for a chunk and publishing a verdict.
 - Documented that a switch power cycled on its own needs the driver
   unbound and rebound before a failed recovery is re-examined.

Changes since v8 [8]:
 - install the flash_update devlink op unconditionally and return
   -EOPNOTSUPP from the trampoline for drivers without the callback,
   instead of a second devlink_ops permutation (Andrew Lunn)
 - picked up Andrew's Reviewed-by on patches 2 and 5, given on v5

Changes since v7 [7]:
 - most of the changes below address findings of the Sashiko AI reviews
   of v7
 - the MCUboot loader's transfer completion was reverse-engineered to
   settle two of them: it publishes an image verification verdict in its
   status register, finalises without the END magic once a 2 s timeout
   expires, and keeps the host's byte count visible while it programs a
   chunk. The interrupted-download drain therefore no longer sends END,
   which a loader still in its receive loop consumes as a byte count and
   underflows its receive counter on, and the flash path now reports a
   rejected image instead of a write timeout
 - refuse a second devlink dev flash while the previous one's reprobe is
   still pending, and stop publishing a zeroed firmware version after a
   failed transfer
 - initialise the SerDes state before the rescue-mode early return, so a
   successful rescue-mode flash cannot hand phylink an unconfigured PCS
 - do not fail probe from the wedged-download branch of the rescue
   detection, which a download interrupted with exactly one byte
   outstanding would trigger, and report a failed recovery through
   devlink rather than refusing every flash for good
 - reset the SB PDI mailbox before probing it, log the drain's progress,
   and correct the protocol and register comments throughout

Changes since v6 [6]:
 - reprobe from a single delayed work item instead of a kthread spawned
   by a workqueue kickoff; the kthread existed only to drop the module
   reference from core code, but its creation-failure path did the racy
   module_put() from module text anyway and could strand the driver
   bound with skip_teardown set. The collapsed form matches
   iwl_trans_reprobe_wk(), and a failed reprobe now leaves the device
   unbound like a failed probe
 - only signal END on a successful transfer; a failure leaves the loader
   mid-payload, where END is read as a byte count and can underflow the
   receive counter, so return the error and let the reprobe recover
 - add cond_resched() to the payload loop so a long transfer over a
   bit-banged MDIO bus under CONFIG_PREEMPT_NONE does not trip the
   soft-lockup detector
 - drop the cached firmware version and chip id on a failed flash so
   devlink dev info stops reporting the pre-flash version until the
   reprobe
 - report the firmware version under DEVLINK_INFO_VERSION_GENERIC_FW
   instead of a bare "fw" string
 - correct the SB PDI header comment's SMDIO register map and expand the
   note on why closing the shared conduit is safe

Changes since v5 [5]:
 - run the post-flash reprobe from a kthread that drops the module
   reference with module_put_and_kthread_exit() from core code, fixing
   a use-after-free where a work item's trailing module_put() could
   return into module text a racing rmmod had freed; a workqueue kickoff
   spawns the kthread off the devlink caller where kthread_create() can
   return -EINTR
 - send END on every flash failure from the ready handshake onward so an
   aborted transfer lets MCUboot reboot instead of leaving it waiting
 - after the background drain finalises an interrupted download, reprobe
   and let the probe-time detection re-classify the switch, so a valid
   image a last-moment interruption left bootable comes up as running
   firmware; rescue_drain() no longer inspects or reports the outcome
 - re-read the SB PDI status register once more after a poll timeout
   expires, so a preempted poll cannot report a spurious -ETIMEDOUT
 - bail out of the periodic stats poll when the flash teardown has set
   WORK_STOPPED, closing a get_stats64() re-arm race
 - allocate the reprobe kickoff before disturbing the switch, so an
   -ENOMEM cannot leave it flashed but never reprobed
 - omit asic.id/asic.rev when the CHIP ID read returned 0, instead of
   publishing a bogus "0000" for fwupd to match firmware against
 - treat the flashless-download loop (STAT 0xc33c) as an unsupported
   configuration and fail probe with -ENODEV instead of advertising it
   as flashable

Changes since v4 [4]:
 - report the numeric chip part number and version read from the
   static CHIP ID registers as the "asic.id" and "asic.rev" fixed
   versions instead of a model-name string, which does not belong in
   a devlink version identifier (Jakub Kicinski)
 - report the running firmware version as the "stored" version too,
   since the switch boots it from its own flash, so userspace can
   distinguish a flash-backed part from a flashless one by the
   presence of "stored" without a future API change
 - run the post-flash reprobe from a self-contained work item again
   instead of the v4 kernel thread, which tripped the hung-task
   watchdog while parked across the flash and returned -EINTR from
   kthread_create() when the devlink command was interrupted
 - re-read the new firmware version through the reprobe's fresh probe
   and drop the SYS_MISC_FW_VERSION exemption from the host block
 - raise the firmware command poll timeout so the FW_UPDATE command
   that reboots into MCUboot is not cut short
 - detect the switch state from the value MCUboot publishes in the SB
   PDI STAT register (loader ready, wedged download, or running
   firmware), confirming a live console loader with a register-read
   challenge, instead of trusting a bare SMDIO scratch write
 - fail probe with -ENODEV over SB PDI when the switch does not respond
   at all (absent, unpowered, or misdescribed in the device tree)
   instead of letting the clause-45 API flood the log with CRC errors
 - drain a wedged interrupted download back to a clean ready state
   from a background work item so the multi-minute recovery never
   holds the devlink instance lock, reporting no firmware version and
   refusing flash with -EBUSY until it completes
 - report the rescue-mode null firmware version "0.0.0" as both the
   running and stored version, matching the running/stored reporting
   above
 - split the devlink documentation into its own patch and add
   Documentation/networking/devlink/mxl862xx.rst describing the info
   versions and the flash update behaviour (Jakub Kicinski)
 - include example "devlink dev info" outputs in the commit messages
   of patches 3 and 4 (Jakub Kicinski)

Changes since v3 [3]:
 - only install the flash_update devlink op for switches whose
   driver implements it, so the devlink core rejects unsupported
   requests before fetching the firmware file from userspace
 - run the deferred reprobe from a kernel thread which ends in
   module_put_and_kthread_exit() instead of a work item that
   dropped its module reference while still executing module code
 - fail firmware API read commands with -ENODEV after the update
   has finished instead of faking success with an unfilled buffer,
   which could send port_fdb_dump() into an endless loop
 - keep the host block in place across the post-update version
   query by exempting SYS_MISC_FW_VERSION from block_host instead
   of briefly lifting the block, and write all blocking flags under
   the MDIO bus lock
 - check the return value of all SB PDI control writes; a failed
   address write during the half-bank switch could otherwise place
   the second half of the payload at the wrong flash offset
 - initialise the progress notification deadline from jiffies so
   notifications are not suppressed on 32-bit systems shortly
   after boot
 - log a distinct diagnostic when rescue mode detection fails on an
   SMDIO bus error instead of silently treating it as not being in
   rescue mode
 - flush the switchdev deferred queue after closing the ports so
   the bridge's deferred STP DISABLED transitions reach the
   firmware while it is still running instead of failing against
   the host block with "failed to set STP state" errors
 - treat -ENODEV as successful deletion in port_mdb_del() so the
   post-update teardown no longer leaves host MDB entries behind
   for the DSA core to report when the tree is torn down

Changes since v2 [2]:
 - validate the firmware image, including both CRCs, before taking
   down any ports, so that a malformed file is rejected without
   disturbing the running switch and without the needless flash and
   reprobe cycle it previously triggered
 - reject images whose declared payload sizes overflow when summed
   (check_add_overflow) or sum up to zero; the latter previously
   erased the flash without writing anything back
 - allocate the reprobe work item and take the module and device
   references before starting the update, so scheduling the reprobe
   can no longer fail after the switch has been pushed into MCUboot
 - prevent the stats poll work from being re-armed and cancel the
   CRC error work before starting the transfer
 - check the host-blocking flags in mxl862xx_api_wrap() under the
   MDIO bus lock to close the race window where an API command
   which had already passed the check could reach the bus after the
   switch rebooted into MCUboot
 - check the return value of SB PDI data word writes so a failed
   MDIO transaction aborts the transfer instead of being noticed
   only through a corrupted image
 - report a per-model chip name (e.g. "MaxLinear MxL86252") as the
   devlink "asic.id" fixed version instead of the devicetree
   compatible string, whose comma is awkward for userspace
   consumers such as fwupd (see discussion on v2 patch 3)
 - report the canonical null version "0.0.0" instead of
   "mcuboot-rescue" as the running firmware version in rescue mode,
   so that version-comparing update tools like fwupd treat every
   available release as an upgrade and offer it for recovery

Changes since RFC [1]:
 - detect a switch stuck in MCUboot rescue mode at probe, register
   the switch without any ports and report "mcuboot-rescue" as the
   running firmware version, so devlink flash can recover from a
   failed or interrupted update (Andrew Lunn)
 - clarify in the commit message of patch 2 that the per-transaction
   MDIO bus locking is about other, non-switch devices on the same
   MDIO bus (Andrew Lunn)
 - mention in the commit message of patch 3 that closing the ports
   also stops phylib from polling the switch-internal PHYs during
   the transfer (Andrew Lunn)
 - split up run-on sentence and explain the dynamically allocated
   reprobe work item instead of just pointing at iwlwifi in the
   commit message of patch 3 (Manuel Ebner)
 - use kzalloc_obj() (Manuel Ebner)
 - state the actual duration of a complete flash and reprobe cycle
   (just under a minute) in comments and the commit message, and
   clarify that the timeout values are generous upper bounds
   (Manuel Ebner)

[1] https://lore.kernel.org/all/ak0J-HgzMRea53om@makrotopia.org/
[2] https://lore.kernel.org/all/cover.1783988826.git.daniel@makrotopia.org/
[3] https://lore.kernel.org/all/cover.1784513694.git.daniel@makrotopia.org/
[4] https://lore.kernel.org/all/cover.1784665017.git.daniel@makrotopia.org/
[5] https://lore.kernel.org/all/cover.1784945329.git.daniel@makrotopia.org/
[6] https://lore.kernel.org/all/cover.1785119999.git.daniel@makrotopia.org/
[7] https://lore.kernel.org/all/cover.1785274610.git.daniel@makrotopia.org/
[8] https://lore.kernel.org/all/cover.1785389905.git.daniel@makrotopia.org/
[9] https://lore.kernel.org/all/cover.1785728574.git.daniel@makrotopia.org/
[10] https://lore.kernel.org/all/cover.1786294649.git.daniel@makrotopia.org/
[11] https://lore.kernel.org/all/anpxFdwNxk0XwPjQ@makrotopia.org/

Daniel Golle (6):
  net: dsa: add devlink flash_update callback to dsa_switch_ops
  net: dsa: mxl862xx: add SMDIO clause-22 register access
  driver core: add device_schedule_reprobe()
  net: dsa: mxl862xx: add devlink flash_update and info_get
  net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode
  net: dsa: mxl862xx: document devlink flash and info support

 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/mxl862xx.rst |   74 ++
 MAINTAINERS                                   |    1 +
 drivers/base/base.h                           |    5 +
 drivers/base/core.c                           |    3 +
 drivers/base/dd.c                             |   82 ++
 drivers/net/dsa/mxl862xx/Makefile             |    2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       |   10 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c        | 1057 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h        |   20 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      |   59 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c   |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           |  160 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.h           |   34 +
 include/linux/device.h                        |    2 +
 include/net/dsa.h                             |    3 +
 net/dsa/devlink.c                             |   13 +
 19 files changed, 1516 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h


base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
-- 
2.55.0
