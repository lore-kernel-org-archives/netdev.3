Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B801A9FBD;
	Mon, 27 Jul 2026 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120180; cv=none; b=GuJdKrslXBB8quEVGYedZ9M8Uh+8mOyw8uOichnqD1FK1ZmhAb5koSpWITXQkaoazKJ/NH5fM7HeARi0S4AHfiEsHLWegNtLJ/raWt1Xd1idg1lcAg9heXMErWwXIwxr32v24gy6zX/GXODfWSbJMOTMs5AmwdCgveC/6ML1Zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120180; c=relaxed/simple;
	bh=ymrb95lxUdgy+J7HoBBMZR54p3rAGO+SjTRIAymj4DU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YsJjcrHa6Lj6FzzdyG6iTxQ8PQTDgvTtm7o6++esLSNYQPNkv5tuBl+c2Kodsis1DB9MZwCXpsgf64rGE6vYfauts7hvL3LkjGPNlnYaBxPjpiEKYaQn8K4+CxfqmSasjZo4liyMSjhqQiSutvWLvHnenEnK4MnCACnx9yF2HiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1woBIf-000000005iG-2OSa;
	Mon, 27 Jul 2026 02:42:41 +0000
Date: Mon, 27 Jul 2026 03:42:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/5] net: dsa: mxl862xx: support firmware update
Message-ID: <cover.1785119999.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The firmware of MxL862xx managed Ethernet switches can be updated
in-system via the same MDIO bus which is also used to manage the
switch. Wire up the devlink flash_update operation for DSA drivers
and implement firmware update and version reporting in the mxl862xx
driver.

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
Daniel Golle (5):
  net: dsa: wire flash_update devlink callback to drivers
  net: dsa: mxl862xx: add SMDIO clause-22 register access
  net: dsa: mxl862xx: add devlink flash_update and info_get
  net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode
  net: dsa: mxl862xx: document devlink flash and info support

 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/mxl862xx.rst |  63 ++
 MAINTAINERS                                   |   1 +
 drivers/net/dsa/mxl862xx/Makefile             |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       |  10 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c        | 949 ++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h        |  20 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      |  54 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c   |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           | 134 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.h           |  26 +
 include/net/dsa.h                             |   3 +
 net/dsa/devlink.c                             |  50 +-
 15 files changed, 1298 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h


base-commit: 04026c998c24ac47eb76886b9790c5710b603eb4
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0
