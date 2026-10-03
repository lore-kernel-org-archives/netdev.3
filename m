Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4383AA4EF;
	Sat,  3 Oct 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042856; cv=none; b=FEw61W5V+mX0/DtPMzNLfRTvwfw8XWrnjXaSwZuxTcKLpGqW0mXQT5c2qZrK7D2ok3kxqQcRPIZzqO9IKRIHaoshS3bEI2VAEGI784hy/YgFE+sqRITbsMrWn3ACUYW2BWOHQwWJZ6W6epWURfFOkPSiktHIPB/tOTTQ3oOW+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042856; c=relaxed/simple;
	bh=yp32WOdEB0ESeqeQ0jOy2pJj2YGQmkAp8LW96QId7tA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL2cnhfHzcj7ZnzfoyVZ0Gzk9jDsHou1EX9Ef+SV/GLksEHIT2uzt2Bae3LWi1N+pCrXHrL3PYRLdw/T8QGSUiqO4EbvKFocwQNrHYvPc3cJGN/UGeSpK1yNGKYeQ7pg12ksAZJ7M5R4pwsDo14jLzcvTdVZguBoD1KQ4/Rhvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD23t-000000001J5-2EhJ;
	Sat, 03 Oct 2026 15:54:09 +0000
Date: Sat, 3 Oct 2026 16:54:06 +0100
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
Subject: [PATCH net-next v19 6/6] net: dsa: mxl862xx: document devlink flash
 and info support
Message-ID: <2f9c6249f77a1940ef64e04de8153ec4b5a5f08f.1791035885.git.daniel@makrotopia.org>
References: <cover.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791035885.git.daniel@makrotopia.org>

Describe the devlink info versions and the flash update behaviour,
including the MCUboot rescue mode recovery, in a dedicated file under
Documentation/networking/devlink/ and link it from the index. Add the
new file to the driver's MAINTAINERS entry.

Assisted-by: LLM
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v19:
 - name every recovery failure with its remedy, the loader still busy
   past the erase of the interrupted session and the exhausted drain
   bound included, and say that the kernel log names the cause (found
   by Sashiko AI review)
 - the fw row lists every state without a version, and devlink dev
   flash tells a recovering switch from one whose recovery has failed
   and needs an image file to load; asic.id is also omitted when the
   read fails on a running firmware (found by Sashiko AI review)
 - the conduit is closed as well and reopened with the user ports, the
   reprobe recreates the user ports and loses their configuration, and
   the duration depends on the board's flash chip (found by Sashiko AI
   review)
 - the loader checks the image's integrity, the conduit is closed but
   not held closed, the ports are unusable while a re-probe that could
   not be scheduled is awaited, a loader in the flashless loop or with
   an unserviced mailbox fails probe, the handshake left behind by an
   interrupted session is one the driver does not resume, and the
   extack and log of a failed recovery say what they say, the driver
   validates the file before touching the switch, a flash is refused
   while the switch is still being set up, a re-probe that could not be
   scheduled is among the final states, and a failed flash's refusal
   clears with its re-probe (found by a local review)

v18:
 - the rescue-mode firmware version is reported as running only, and a
   re-probe that cannot be scheduled is logged on every path and leaves
   later flashes refused with -EBUSY until a rebind (found by Sashiko AI
   review)

v17: no changes

v16:
 - document that a reboot waits for a running flash and that one
   requested afterwards is refused, and that a bus error ends the
   download recovery for good
 - title-case the "Flash Update" heading, as the other devlink driver
   documents do
 - say that the ports come back down from a flash, that a reprobe which
   cannot be scheduled needs a rebind, and which of the two recovery
   failures needs a power cycle and which a rebind (found by Sashiko AI
   review)

v15:
 - asic.rev is read from the CHIP ID registers as well, not from one
   register word shared with asic.id (found by Sashiko AI review)
 - -EIO says the driver gave up on the recovery, which may need a driver
   rebind rather than a power cycle, and an interrupted opening
   handshake is reported the same way (found by Sashiko AI review)

v14: no changes

v13: no changes

v12: no changes

v11: no changes

v10: document that a switch power cycled on its own needs the driver
     unbound and rebound before a failed recovery is re-examined

v9: no changes, picked up Andrew's v5 Reviewed-by

v8:
 - asic.id and asic.rev are omitted whenever the part number reads
   zero, not only in MCUboot rescue mode (found by Sashiko AI review)
 - drop the claim that "0.0.0" marks a switch that never ran firmware;
   rescue mode always reports it (found by Sashiko AI review)
 - document devlink dev flash as the signal that says whether a
   recovery is still running, including the -EIO it returns once the
   recovery has failed (found by Sashiko AI review)

v7: no changes

v6: no changes

v5: new patch, splitting the devlink documentation out of the flash
    update and rescue mode recovery patches so each keeps to code
    (Jakub Kicinski asked for the documentation)


 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/mxl862xx.rst | 118 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 120 insertions(+)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 1af780c811ee2..53d3ef16d13f4 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -95,6 +95,7 @@ parameters, info versions, and other features it supports.
    mlx5
    mlxsw
    mv88e6xxx
+   mxl862xx
    netdevsim
    nfp
    octeontx2
diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
new file mode 100644
index 0000000000000..6ec2c793fd0f3
--- /dev/null
+++ b/Documentation/networking/devlink/mxl862xx.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+mxl862xx devlink support
+========================
+
+This document describes the devlink features implemented by the
+``mxl862xx`` device driver.
+
+Info versions
+=============
+
+The ``mxl862xx`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Example
+     - Description
+   * - ``asic.id``
+     - fixed
+     - 8628
+     - The chip part number read from the CHIP ID registers. Omitted
+       when the part number reads as zero, which happens for a switch
+       sitting in MCUboot rescue mode (the registers need a running
+       firmware), when the read fails on a running firmware, for an
+       unfused part, and after a failed flash.
+   * - ``asic.rev``
+     - fixed
+     - 0
+     - The chip version, read from the CHIP ID registers as well. Both
+       values are published behind the same check, so it is omitted
+       whenever ``asic.id`` is.
+   * - ``fw``
+     - running, stored
+     - 1.0.70
+     - Version of the firmware running on the switch, reported as both
+       running and stored since the switch boots it from its own flash.
+       It is omitted while no firmware version is known: after a failed
+       flash until the reprobe it schedules, and in MCUboot rescue mode
+       while an interrupted download is still being recovered in the
+       background, once that recovery has failed, or while the loader
+       waits in an opening handshake nobody can finish. Once the loader
+       is ready to accept a new image the version appears as "0.0.0",
+       which no released firmware reports, so version-comparing tools
+       offer any available release as an upgrade; it is reported as
+       running only, since the driver cannot tell what the flash holds
+       while the loader runs. A missing version on its own does not say
+       why; ``devlink dev flash``, given an image file that passes the
+       driver's validation, answers ``-EBUSY`` while the switch is still
+       recovering and ``-EIO`` once it cannot be flashed from this
+       binding, see below.
+
+Flash Update
+============
+
+The ``mxl862xx`` driver implements support for ``devlink dev flash``.
+The driver checks the image file's header and payload checksums before
+touching the switch and refuses a file that fails them. The image is
+then transferred to the switch over the same MDIO bus which is also
+used to manage the switch, checked for integrity again and installed
+by the MCUboot bootloader running on the switch. All ports of the
+switch are closed and held closed for the duration of the update, the
+conduit interface is closed with them, and the driver reprobes the
+switch after it has rebooted into the new firmware. The reprobe
+destroys and recreates the user ports, so their bridge membership,
+VLANs, addresses and every other per-port configuration are lost with
+them; they come back registered but down, and userspace configures and
+brings them up again, which opens the conduit with them. A complete
+flash and reprobe cycle takes on the order of a minute, depending on
+the board's flash chip. Until the reprobe has run, a further update is
+refused with ``-EBUSY``, as is one requested before the switch has
+finished setting up. In the rare case that the reprobe cannot be
+scheduled at all, the kernel log says so, ``devlink dev flash`` reports
+that error or the transfer's own if the transfer failed as well, and
+the driver stays bound to a switch it no longer tracks, with its ports
+unusable and further updates refused with ``-EBUSY``, until it is
+unbound and rebound. A reboot started while an update is running waits
+for the transfer to finish, and an update requested after the system
+has begun shutting down is refused with ``-ENODEV``.
+
+A switch stuck in MCUboot rescue mode, e.g. after an interrupted
+update, is registered without user ports. A loader found in its
+flashless download loop, or one that does not service its mailbox, is
+not usable from here and fails probe; the kernel log reports the
+state's errno, ``-EOPNOTSUPP`` for the flashless loop and ``-ENXIO``
+for the unserviced mailbox. If the previous download was interrupted
+mid-transfer the loader is wedged; the driver drains it back to a clean
+ready state in the background, one byte at a time, which takes tens of
+minutes for a large image and is reported through the kernel log as it
+progresses. During that recovery ``devlink dev flash`` returns
+``-EBUSY`` with an extack message saying so, and ``devlink dev info``
+reports no firmware version. Once the loader is ready the firmware
+version appears and flashing a firmware image through the regular
+update flow recovers the switch.
+
+If the switch cannot be flashed from its binding, ``devlink dev flash``
+returns ``-EIO`` and says so in its extack message; the kernel log
+reports why, naming a loader that stopped answering, a drain that
+reached its bound or a reprobe that could not be scheduled where that
+is the cause and the bus error otherwise. The drain runs once and is
+never resumed, so a failed MDIO transaction ends it as well. A loader
+that stops answering the drain, one still busy once the erase of the
+interrupted session should long have finished, and a drain that
+reaches its bound without the loader returning to its ready state need
+a power cycle; a completed drain whose reprobe could not be scheduled,
+and a drain a bus error cut short, need only a driver rebind. The
+driver re-examines the switch
+when it binds and at no other time, so a power cycle on a board where
+the switch can be cycled on its own still has to be followed by an
+unbind and rebind for the recovered switch to be recognised.
+
+A download interrupted during its opening handshake, before the image
+header reached the loader, is reported the same way. The driver starts
+a download only from the loader's ready state and does not resume that
+session, so the switch needs a power cycle.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6de1ff058db64..cb1dad080f63c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16250,6 +16250,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+F:	Documentation/networking/devlink/mxl862xx.rst
 F:	drivers/net/dsa/mxl862xx/
 F:	net/dsa/tag_mxl862xx.c
 
-- 
2.56.0
