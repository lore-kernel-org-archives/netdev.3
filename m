Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF83B95FA;
	Tue, 15 Sep 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477763; cv=none; b=tJ45IoCAuw35WbSbJGPDM09Ti8iOjqKLTtdX/XywmqW4hgQxg68iSnAgSc+Ebs56Es9OqjQoTGeU/bYDNE9V3pKgos6YIamNW4CfP6n5NaghmCo8Y9aM/ZerabBSpPdid+3yRgPhCiiolVUUJbpFuZO60faVA9ORLxwggCcC47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477763; c=relaxed/simple;
	bh=53n1MCYQaAP+huGEysAnvDYY8n703bbUGocUogE8xmg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RHPt6zpqBchp57TBomTfU5GKbVXqjEtHB2bhWsgjVz752ZRxXS4Ga9dCeWa26I3OC4YJT2tuuwTZU6chCO/qoJo5Kx22eqDNpw0lkG2QILEM0sB8W/TTex9wiKRh852hnfYRERnTapXlM+YUyC/sVYSDD8600OsWA+Y0zU9n9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6SuK-000000000Ce-003e;
	Tue, 15 Sep 2026 13:09:08 +0000
Date: Tue, 15 Sep 2026 14:09:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v16 0/6] net: dsa: mxl862xx: devlink flash and rescue
Message-ID: <cover.1789477568.git.daniel@makrotopia.org>
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

The switch is flashed over the loader's clause-22 SMDIO download
interface after the firmware API has rebooted it into MCUboot, and the
driver reinitialises through a deferred detach and re-probe once the
new image runs. A switch found in MCUboot at probe registers in a
reduced rescue mode with firmware version 0.0.0, so the same flash flow
recovers it; an interrupted download is drained in the background
first. The deferred re-probe comes from a new driver-core helper,
device_schedule_reprobe(), since a driver-owned work item cannot
survive a racing rmmod, nor give up its detach once the core has
blocked probing for a shutdown. fwupd's devlink plugin carries the
matching quirks [17].

Patch 3 is a driver-core change and patch 4 does not link without it,
so the series needs a driver-core ack before net-next can take it.

Tested on an MxL86252C switch of the BananaPi R4 Pro 8X: an upgrade
through fwupd; a reboot issued while a flash was running, which waits
for the transfer to finish; a host crash mid-transfer, whose wedged
download the background drain recovered; and a power cut mid-transfer,
after which the loader came up ready and fwupd flashed the switch from
0.0.0 back to a released firmware.

Changes since v15 [20]:
 - patch 1: the commit message no longer puts a notification pair
   around a missing firmware file; the core fails that before the pair,
   which wraps the call into the trampoline only
 - patch 3: take no lock in the caller's context and drop the parent
   snapshot, refusing buses that need the parent lock instead. The
   caller-context device lock inverted against the devlink instance
   lock, which a flash holds across the call, and against the
   synchronous cancel of the rescue self-heal work; a pinned parent can
   also be freed by device_move(). Only usb_bus_type sets
   need_parent_lock, and the conversions posted separately re-probe PCI
   and serdev devices, so none of them is refused. Patches 4 and 5 need
   no change of their own for either inversion (all found by Sashiko AI
   review)
 - patch 3: abandon the release when probing gets blocked while
   __device_release_driver() has the locks dropped to unbind busy
   consumer links, closing the one window where a ->remove() could
   follow a ->shutdown(). Earlier versions called it pre-existing, which
   it is, but a deferred re-probe is the one unbind that may be
   abandoned, so it takes a flag the other callers do not (found by
   Sashiko AI review)
 - patch 3: the commit message now describes what this patch changes
   rather than bugs in the drivers it does not convert (found by Sashiko
   AI review)
 - patch 3: the commit message no longer claims the detach is
   synchronised with device_shutdown() in every case. Probing is
   blocked only once wait_for_device_probe() has returned, so a
   re-probe already past the check detaches the device, which then runs
   ->remove() in place of ->shutdown()
 - patch 4: a firmware write blocked by a running flash reports success
   instead of -EBUSY. Tearing a bridge down over a flash, as a reboot
   does, made port_vlan_del() fail; the bridge then leaves the VLAN on
   its list and __vlan_group_free() warns and frees the group with the
   entries still linked
 - patch 4: ->shutdown() now waits for a flash in flight and refuses
   one requested after it, so a reboot cannot cut the image in half.
   The devlink core already serialises .remove() through the instance
   lock; ->shutdown() does not go through devlink and takes that lock
   itself
 - patch 4: the -EBUSY extack of a pending reprobe states a fact rather
   than advising a retry, and the comment on mxl862xx_read_chip_id()
   drops the rescue-mode cache that only patch 5 creates
 - patch 4: select CRC32, which nothing else selects for the image
   checksum validation (found by Sashiko AI review)
 - patch 5: treat a byte count outliving the settle step as a busy
   loader and wait out an erase a dead session left running before
   draining, so a host that died during the loader's erase no longer
   fails probe with the -ETIMEDOUT this series exists to avoid; drop the
   loader's clean ready state with the cached identity when a flash
   fails; state facts only in the extack of a failed recovery (all found
   by Sashiko AI review)
 - patch 5: the commit message and the comments no longer say the
   clause-45 API floods the log with CRC errors when no firmware
   answers. The mailbox commands run into their timeouts instead, and
   testing the stuck-in-MCUboot paths produces no such message; what
   probing SB PDI first saves is the ten seconds of polling and the
   -ETIMEDOUT that ends probe
 - patch 5: move the rescue branch of mxl862xx_setup() into a function
   of its own, which brings its messages back inside 100 columns; state
   a fact in the -EBUSY extack of a running recovery; trim the drain
   comment, whose protocol detail is in the file header, and order its
   declarations
 - patch 6: document that the ports come back down, which recovery
   failure needs a power cycle and which a rebind, and what a re-probe
   that cannot be scheduled leaves behind (found by Sashiko AI review)
 - patch 6: document that a reboot waits for a running flash, that a
   flash requested after it is refused, and that a bus error ends the
   download recovery for good; title-case the "Flash Update" heading
   like the other devlink driver documents
 - Andrew's Reviewed-by is kept on patches 1, 2 and 6: patch 1 gained
   commit message text only and patch 6 the documentation sentences
   above. It is dropped on patch 4, which gained the shutdown
   serialisation
 - patch 3 has drawn no driver-core reply here or in its three
   standalone postings [11][14]. The helper is no longer an RFC: Hans
   de Goede reviewed and tested it there [15][16], and the conversions
   of the open-coded users in iwlwifi, hci_h5 and btintel_pcie follow
   once this series is merged
 - the remaining findings of that review are not acted on: patch 1 is
   asked once more to install .flash_update only for drivers
   implementing the callback, as v4 did, and stays unconditional as
   Andrew asked in v9; the empty supported_interfaces a rescue-mode
   probe leaves for the quad-mode sub-interfaces can only reach phylink
   through a CPU port on one of them, which the chip does not support;
   and the driver pointer patch 3 records could in theory match a
   different driver loaded at the same address within the delay, at the
   cost of one spurious re-probe
 - the changes to patches 1 and 3 to 6, the commit message of patch 1
   included, were written with an LLM coding assistant working from the
   Sashiko findings and from a local review of the posted series, and
   reviewed by hand; the Assisted-by tags on patches 3 to 6 record this

Changes since v14 [19]:
 - patch 3: skip the detach while probing is blocked, which
   device_shutdown() does before its walk reaches any device, instead of
   a per-device flag set only once the walk arrives; validate the device
   and snapshot the parent, its locking requirement and the bound driver
   under the device lock; keep -EPROBE_DEFER out of the re-probe error
   path so it cannot overwrite a deferred probe reason (all found by
   Sashiko AI review)
 - patch 4: treat the closing END write as advisory, since the loader
   has verified the image by then, and admit only the flash task's own
   firmware reads past block_host instead of every read from every
   context (found by Sashiko AI review)
 - patch 5: classify a status register left in the download handshake as
   a loader needing a power cycle rather than as running firmware, give
   the loader one step to publish its next state before ruling it out
   after a failed clause-45 wait, abort the drain polls as soon as
   teardown asks for it instead of stalling unbind for up to 17 s, and
   pair the rescue_mode accesses with WRITE_ONCE()/READ_ONCE() (all
   found by Sashiko AI review)
 - patch 6: asic.rev comes from the CHIP ID registers as well, and -EIO
   means the driver gave up on the recovery, which may need a rebind
   rather than a power cycle (found by Sashiko AI review)
 - Andrew's Reviewed-by is kept on patches 1, 2, 4 and 6; the changes to
   4 and 6 are the two small ones above and a documentation reword
 - the same review asks again whether patch 1 should install
   .flash_update only for drivers implementing the callback, as v4 did;
   it stays unconditional as Andrew asked in v9. Its remaining findings
   are not acted on either: the pre-existing window in
   __device_release_driver() where a ->shutdown() can interleave with a
   release, which every unbind path shares; the recorded driver pointer,
   which an unbind and rebind within the delay can match again at the
   cost of one spurious re-probe; and the get_stats64() re-arm race in
   remove(), which predates this series and is fixed separately for net
 - the changes to patches 3 to 6 were written with an LLM coding
   assistant working from the Sashiko findings and reviewed by hand; the
   Assisted-by tags on those patches record this

Changes since v13 [18]:
 - patch 5: initialise the SerDes state once mxl862xx_wait_ready() has
   cached the firmware version, still before the rescue-mode early
   return, so PCS setup can depend on the running firmware
 - picked up Andrew's Reviewed-by on patches 1 and 4; the one on patch 5
   is not carried as that patch changed
 - the Sashiko review of v13 repeats the ABA finding on patch 3 dismissed
   in v13 and marks the two __device_release_driver() windows and the
   get_stats64() re-arm race as pre-existing; no change
 - the change to patch 5 was written with an LLM coding assistant
   working from a report against a downstream tree and reviewed by
   hand; the Assisted-by tag on that patch records this

Changes since v12 [13]:
 - v12 went out just as net-next closed for the 7.3 merge window. The
   helper of patch 3 was then posted on its own, with conversions of the
   existing open-coded users in iwlwifi, hci_h5 and btintel_pcie, most
   recently as v3 [14], which Greg's patch bot deferred past the merge
   window; Hans de Goede reviewed and tested the helper and the hci_h5
   conversion there on RTL8723BS hardware [15][16]. The Sashiko review
   of that posting found the same issues in the helper as the review of
   v12 did, so patch 3 here supersedes the helper patch of that series;
   once this series is merged, the conversions follow as patches for
   bluetooth-next and wireless-next. On the userspace side, fwupd's
   devlink plugin has meanwhile gained the quirks for these switches
   [17]
 - patch 3: queue the re-probe on system_freezable_wq, so one pending
   across system suspend runs after resume instead of detaching a
   suspended device or racing its late suspend callbacks; record at
   scheduling time whether the parent needs locking instead of reading
   dev->bus, which may be gone with its module once the device was
   unregistered; let __device_release_driver() report whether it
   released the driver, so an administrative unbind that wins the race
   inside the device links loop is not undone by the re-attach (all
   found by Sashiko AI review); use dev_err_probe() for the re-probe
   error path (Hans de Goede)
 - patch 4: stop the stats poll with disable_delayed_work_sync() in the
   flash path, so a racing get_stats64() re-arm is a no-op, and drop the
   early return in the work function; the v12 reordering of remove()
   is gone as well, since the get_stats64() race it addressed predates
   this series and needs a fix of its own (found by Sashiko AI review)
 - two further findings of the same review are not acted on: the
   recorded driver pointer could in theory match a different driver
   loaded at the same address within the delay, which would cost that
   driver one spurious detach and re-probe; and the final put_device()
   from the work could call a release() whose module was unloaded in
   the meantime, which is the same hazard every asynchronous device
   reference in the core carries, the async probe helper included
 - the changes to patches 3 and 4 were written with an LLM coding
   assistant working from the Sashiko findings and reviewed by hand; the
   Assisted-by tags on those two patches record this

Changes since v11 [12]:
 - patch 3: pin the parent device across the deferred re-probe and take
   the parent lock across device_attach() on buses that need it; a
   reference on the child alone left a freed dev->parent dereferenced
   under __device_driver_lock() (found by Sashiko AI review)
 - patch 4: cancel the stats poll after dsa_unregister_switch() so a
   racing get_stats64() cannot re-arm it against freed priv; and keep
   the host blocked for writes across the post-flash readiness poll,
   letting only the flash path's own reads reach the new firmware
   (found by Sashiko AI review)

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
[12] https://lore.kernel.org/all/cover.1786773971.git.daniel@makrotopia.org/
[13] https://lore.kernel.org/all/cover.1786922210.git.daniel@makrotopia.org/
[14] https://lore.kernel.org/all/cover.1787281239.git.daniel@makrotopia.org/
[15] https://lore.kernel.org/all/c461462f-de0b-43e8-ac9e-541013f5f8da@oss.qualcomm.com/
[16] https://lore.kernel.org/all/7ffe0c2e-0742-488a-ab6c-1dc2fabc049c@oss.qualcomm.com/
[17] https://github.com/fwupd/fwupd/commit/e50c9e5ab39d31242e664efbbf441fd46d15a0cd
[18] https://lore.kernel.org/all/cover.1788783126.git.daniel@makrotopia.org/
[19] https://lore.kernel.org/all/cover.1788976064.git.daniel@makrotopia.org/
[20] https://lore.kernel.org/all/cover.1789175618.git.daniel@makrotopia.org/

Daniel Golle (6):
  net: dsa: add devlink flash_update callback to dsa_switch_ops
  net: dsa: mxl862xx: add SMDIO clause-22 register access
  driver core: add device_schedule_reprobe()
  net: dsa: mxl862xx: add devlink flash_update and info_get
  net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode
  net: dsa: mxl862xx: document devlink flash and info support

 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/mxl862xx.rst |   91 ++
 MAINTAINERS                                   |    1 +
 drivers/base/dd.c                             |  111 +-
 drivers/net/dsa/mxl862xx/Kconfig              |    1 +
 drivers/net/dsa/mxl862xx/Makefile             |    2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       |   10 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c        | 1135 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h        |   21 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      |   68 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c   |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           |  165 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.h           |   41 +
 include/linux/device.h                        |    2 +
 include/net/dsa.h                             |    3 +
 net/dsa/devlink.c                             |   13 +
 18 files changed, 1653 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h


base-commit: 1142eb185b05db61a78130890fc4ed268f4cb4e6
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0
