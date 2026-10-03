Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA34398F2;
	Sat,  3 Oct 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042672; cv=none; b=S7KGrGsr3Da4ygNOiVskEgFoHPSYN9SIevChI4rQF7GazSdMIhA2+FmmoIsxd3W+ZBbrysdZr0YwYg0OtjoAw5ZWUTWf2iG5Fq6mSNbqZCQTcYyh4EXScnunWebnIsGg58+oWSp7Kos8LH21Wu6mDJHQkum9/GO8ivnIFouTyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042672; c=relaxed/simple;
	bh=dMyirHvwqvR6p+DvbQm8o+b3tGNqzfZzzOYTvRhse8w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kSF4O/CZDpR9vy8PjyGmlgSSWTuCL/uEH3ib4fBoW0kHV8YRvd1SmFJuCz8bK6LiGwYbPXzAiT3Z3oR3s2Fqtkt0SmQv0EOFYn0HaOFa8JEkycs6RY9EljsqwyipoI6JQjXOIVK2kKbJRhk8wLo0n8aLnPRFvMPVipSH9UqvCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD20e-000000001F7-0UFn;
	Sat, 03 Oct 2026 15:50:48 +0000
Date: Sat, 3 Oct 2026 16:50:44 +0100
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
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v19 0/6] net: dsa: mxl862xx: devlink flash and rescue
Message-ID: <cover.1791035885.git.daniel@makrotopia.org>
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
device_schedule_reprobe(), which the bound driver calls without a
module reference; it also replaces the open-coded self-reprobe that
iwlwifi, hci_h5 and btintel_pcie carry, whose work function frees its
own module text from under a racing rmmod. fwupd's devlink plugin
carries the matching quirks [17].

Patch 3 is a driver-core change and patch 4 does not link without it,
so the series needs a driver-core ack before net-next can take it.

Tested on an MxL86252C switch of the BananaPi R4 Pro 8X as well as
the MxL86282C of Adtran SDG-9000:
 - an upgrade through `fwupdmgr upgrade`
 - an unbind and a reboot issued while a flash was running, which wait
   out the transfer and announce the wait
 - a host crash (`echo c > /proc/sysrq-trigger`) recovered by the
   background drain and by the rescue path on the next boot
 - and a power cut mid-transfer, switch is detected in MCUboot rescue
   mode on the next boot
 - an unbind and a reboot issued while a background drain was running,
   which abort the drain at once and let it resume and complete on the
   rebind or reboot.

Changes since v18 [24]:
 - patch 3: keep one pending re-probe request per device in struct
   device_private and cancel it when the device is deleted or its
   binding ends, so the reference it holds is dropped with the binding
   and a rebind or a module reload within the delay gets no stale
   re-probe; drop the error for a re-probe that left the device unbound,
   since the probe path logs a failed probe itself and a deferred retry
   is off the deferred-probe list while it runs, so no state read tells
   it from a failure; drop a request that fires while probing is blocked
   for a shutdown and re-arm one that fires during a suspend once a
   second; kernel-doc and commit message corrections (found by Sashiko
   AI review and a local review)
 - patch 4: refuse a flash while the DSA tree is still being set up,
   since devlink registers the switch before the core creates the user
   ports, which it creates and frees without rtnl held; read the flash
   gates under the MDIO bus lock in the MDB ops and get_ethtool_stats();
   tell devlink when the new firmware runs but the driver needs
   rebinding; log a rejected image once and name it in the extack;
   message, comment and kernel-doc corrections; the final slice's
   verification window moves here from patch 5 (found by Sashiko AI
   review)
 - patch 5: map the firmware's CRC verdicts where the command is issued
   and keep the host's own verdict outside the firmware's result range;
   confirm READY with the register-read challenge after the settle step
   too, judged by the re-armed ready word alone; return a bus timeout
   during the challenge as the bus error it is; drop the "firmware
   booted while draining" outcome, which the loader's CRC gate makes
   unreachable, so any count outliving the window is a stuck loader;
   log a self-heal re-probe that cannot be scheduled; set WORK_STOPPED
   before waiting out a flash in .remove() and ->shutdown(); drop the
   unreachable rescue-mode disjunct from the MDB ops; commit message
   and comment corrections (found by Sashiko AI review)
 - patch 6: the documentation names every recovery failure with its
   remedy and says the kernel log names the cause, lists every state
   without a firmware version, and says that the conduit is closed too,
   that the reprobe loses the user ports' configuration and that the
   duration depends on the board's flash chip (found by Sashiko AI
   review)
 - patches 1 and 2: commit message corrections, and the comment on the
   SMDIO helpers names the rescue work among their callers (found by
   Sashiko AI review)
 - a local run of the same review pipeline on this version found more,
   acted on as follows. Patch 3: the unbind cancelled the request before
   ->remove(), where this driver's flash and drain wait and then
   schedule, so the cancel moved to the end of the binding, where it
   also covers a probe that fails; a spinlock pairs the slot with the
   queueing and cancelling of its work, which closes the windows between
   publishing and queueing a request and around the re-arm; the slot is
   held until the work has released the driver, so a second request
   during a re-probe is refused. Patch 4: the DSA workqueue is flushed
   after the ports close, so the bridge's host address deletions reach
   the firmware while it still runs; the chip ID is zeroed before it is
   re-read; the unreachable component check is gone. Patch 5: rescue
   mode counts among the gates get_ethtool_stats() keeps quiet for, the
   CRC codes are logged as reported, -EINVAL from the self-heal's
   request is the device deletion it is, and the probe-time messages
   name the state. Patch 6 and the messages of patches 1 and 2 follow.
   A second pass on that result found less: patch 3 drops the driver
   pointer and name copy, which the slot makes redundant, and re-arms
   across a hibernation restore; patch 4 takes -EINVAL from the
   re-probe request as the device deletion it is; patch 5 returns a bus
   error of the challenge's closing reset as such and names the host's
   CRC verdict in the log; the rest is prose
 - Andrew's Reviewed-by is kept on patches 1, 2 and 6, which changed in
   prose only
 - the Sashiko review's remaining findings are not acted on: a refused
   FW_UPDATE command keeps the teardown and re-probe, since the ports
   are closed by then and the re-probe is what reinitialises them, and
   the log and extack name the refusal; the wait of a reboot for a flash
   in flight is announced in the log and ends with the transfer; a
   switch left unbound by a failed re-probe hand-off is a rebind matter,
   as documented; an MDIO bus without clause-22 access cannot carry this
   switch, as no SoC or MAC on a real board exposes one without both
   clauses; a final slice whose byte count equals a status magic holds
   that value only while the loader programs the slice, well before a
   host that died could probe again; the drain stays off a freezable
   workqueue, a suspend during the exceptional recovery path being rare
   and recovered by a rebind; and a running firmware never holds 0 in
   the status register, which reads 0x0003 after boot whatever the
   loader left behind, as observed on the BananaPi BPi-R4 Pro 8X after
   a flash and after a plain rebind; a status word left at 0 by an END
   write that failed is not guarded against either, since a clause-22
   write failing after the hundreds the transfer made is a broken bus,
   which the readiness poll that follows fails on as well.
 - the changes to patches 1 to 6, the commit messages of patches 1 and 2
   included, were written with an LLM coding assistant working from the
   Sashiko findings and a local review, and reviewed by hand; the
   Assisted-by tags on patches 3 to 6 record this

Changes since v17 [23]:
 - patch 3: re-arm the work while probing is blocked, since
   dpm_prepare() blocks it as well and a kexec jump or a kernel without
   the suspend freezer reaches that window with the workqueue running,
   which lost the request for good; log an error for every unbound
   outcome of device_attach() except a deferred probe, a failed probe
   coming back as 0, which the check for a negative value missed;
   kernel-doc and commit message corrections (found by Sashiko AI
   review)
 - patch 4: accept a read refused by the flash gate or the teardown gate
   while either is set in port_mdb_add() and port_mdb_del(), since the
   flash moves from one gate to the other after api_wrap() has dropped
   the MDIO bus lock; wait for the header byte count to change rather
   than for its ACK value, which a short erase retires between two
   polls; log a re-probe that cannot be scheduled after a failed
   transfer as well; return silently from get_ethtool_stats() while the
   gates refuse reads, which unprivileged ethtool -S reaches (found by
   Sashiko AI review)
 - patch 5: after a failed clause-45 wait, a status word that outlives
   the settle step is rescue only when it is the erase count of the
   session that died; any other value is a firmware that answered the
   reset without becoming ready, and probe fails with the wait error as
   it did before the patch; the rescue-mode version is reported as
   running only, since the driver cannot tell what the flash holds; the
   probe-time log names the interrupted handshake and the extack covers
   every failed-recovery cause; the commit message describes the
   detection outcomes again (found by Sashiko AI review); a quiet
   firmware command, as the readiness poll issues, does not arm the
   CRC-error work, since a probe that meets the loader mid-erase fails
   every poll's CRC check and closed the conduit with a warning on each
 - patch 6: the documentation follows the patch 4 and 5 changes
 - Andrew's Reviewed-by is kept on patches 1, 2 and 6, whose only change
   this round is two sentences of documentation
 - the review's remaining findings are not acted on: an MDIO bus without
   clause-22 access cannot carry this switch, as no SoC or MAC on a real
   board exposes one without both clauses, so its absence is not
   handled; a final slice whose byte count equals a status magic holds
   that value only while the loader programs the slice, well before a
   host that died could probe again; the drain's chunk == 0 error was
   raised again and the v16 note below stands, the one path that fed a
   running firmware into the drain being the settle classification
   patch 5 now corrects; the ->remove()-after-->shutdown() window and
   the two patches between which a failed transfer is not yet recovered
   are described in the commit messages of patches 3 and 4; and the
   drain stays off a freezable workqueue as in v17
 - the changes to patches 3 to 6 were written with an LLM coding
   assistant working from the Sashiko findings, and reviewed by hand;
   the Assisted-by tags on patches 3 to 6 record this

Changes since v16 [21]:
 - patch 3: drop the abort_if_blocked flag and the bool return of
   __device_release_driver(), leaving that function unchanged. The flag
   left the device-links state half torn down when it fired and did not
   cover the consumers unbound in the same window; the shutdown-versus-
   release window it targeted is pre-existing to every unbind path
   (driver_detach(), unbind_store(), the consumer recursion), so the
   re-probe, which is device_reprobe() deferred, shares it rather than
   introducing it, and the kernel-doc now says so (found by Sashiko AI
   review)
 - patch 3: record the bound driver's name beside its pointer and
   compare both, so a freed struct device_driver address the allocator
   later hands to a different driver is not mistaken for the original
   binding; this closes the recorded-identity race without a module
   reference (found by Sashiko AI review)
 - patch 4: wait out a flash in flight in .remove() as ->shutdown()
   already did, before dsa_unregister_switch() frees the user netdevs.
   The instance lock a flash holds does not cover that free, which the
   teardown reaches first, so an unbind racing a flash could touch a
   freed netdev; both paths now take the lock up front and announce the
   wait with dev_info() so the up-to-a-minute pause is not mistaken for
   a hang (found by Sashiko AI review)
 - patch 4: report success for a firmware read blocked by a flash
   (-EBUSY), not only the teardown -ENODEV, in port_mdb_add() and
   port_mdb_del(), so an MDB change racing a flash does not fail and
   leave the entry linked; clear the SB PDI ADDR and DATA latches with 0
   rather than a CTRL mode value that only happens to be 0; log that a
   rebind is needed if the re-probe cannot be scheduled after the new
   firmware is already running; correct the block_host/skip_teardown
   kernel-doc to the policy the code implements (all found by Sashiko AI
   review)
 - patch 5: bypass the firmware-version gate in
   mxl862xx_phylink_get_caps() in rescue mode, so a SerDes CPU port does
   not get an empty supported_interfaces mask and fail phylink_create(),
   matching the mac_select_pcs() bypass; the @rescue_failed kernel-doc
   and the setup log message no longer prescribe a power cycle for every
   cause, whose per-cause remedy is in the documentation (found by
   Sashiko AI review)
 - Andrew's Reviewed-by is kept on patches 1, 2 and 6, unchanged this
   round
 - Jakub asked whether the mode transitions could be driven from
   userspace through devlink reload [22]. The deferred re-probe is kept:
   DSA has no reload plumbing, and adding it would need a new DSA-core
   path to reinitialise a switch while its devlink instance stays alive,
   whereas the re-probe reuses the existing unbind/register path, and
   the helper it uses is wanted regardless to replace the open-coded
   self-reprobe in iwlwifi, hci_h5 and btintel_pcie
 - patch 5: the interrupted-download drain's chunk == 0 error, which the
   review reads as mis-reporting a firmware that booted mid-drain, was
   reproduced on hardware and does not arise. The loader verifies the
   received image by CRC, so the zero-filled drain never reconstructs a
   bootable image; it returns the loader to its ready state instead, and
   the chunk == 0 error only fires for a genuinely wedged loader, where
   it is correct (found by Sashiko AI review)
 - the review's remaining findings are not acted on: patch 1 stays on
   the unconditional shared ops table as Andrew asked in v9; the SB PDI
   register offsets and the status words patch 5 classifies the switch
   by are a fixed hardware property configured by MCUboot and a stable
   contract the firmware release QA gates enforce, probe detection being
   part of the gate, so neither a relocated window nor a status value
   that breaks classification is a configuration that ships; and the
   background drain deliberately stays off a freezable workqueue, a
   suspend or bus error there being a rare event on an exceptional path
   that a rebind recovers
 - the changes to patches 3 to 5 were written with an LLM coding
   assistant working from the Sashiko findings and a local review, and
   reviewed by hand; the Assisted-by tags on patches 3 to 5 record this

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
[21] https://lore.kernel.org/all/cover.1789477568.git.daniel@makrotopia.org/
[22] https://lore.kernel.org/all/aq5QDmuQnqQTudca@makrotopia.org/
[23] https://lore.kernel.org/all/cover.1790130482.git.daniel@makrotopia.org/
[24] https://lore.kernel.org/all/cover.1790426599.git.daniel@makrotopia.org/

Daniel Golle (6):
  net: dsa: add devlink flash_update callback to dsa_switch_ops
  net: dsa: mxl862xx: add SMDIO clause-22 register access
  driver core: add device_schedule_reprobe()
  net: dsa: mxl862xx: add devlink flash_update and info_get
  net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode
  net: dsa: mxl862xx: document devlink flash and info support

 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/mxl862xx.rst |  118 ++
 MAINTAINERS                                   |    1 +
 drivers/base/base.h                           |    5 +
 drivers/base/core.c                           |    1 +
 drivers/base/dd.c                             |  172 +++
 drivers/net/dsa/mxl862xx/Kconfig              |    1 +
 drivers/net/dsa/mxl862xx/Makefile             |    2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       |   10 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c        | 1188 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h        |   21 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      |  143 +-
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |    3 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c   |    9 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c           |  187 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.h           |   56 +-
 include/linux/device.h                        |    2 +
 include/net/dsa.h                             |    3 +
 net/dsa/devlink.c                             |   13 +
 20 files changed, 1894 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h


base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
-- 
2.56.0
