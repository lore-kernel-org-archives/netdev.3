Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8B3655FA;
	Tue, 15 Sep 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477882; cv=none; b=Rjibnol0mG6Ypge1+RAS3DRLla2/ZpxeCGKQEoxNr1yVsHOn0m2CbN7lYLg/cJI+vRWisflXypU0hIV2Yi2uiycwmW7LobNLqfAMREwbD9viWizErE4Yq6UAX+WXplvTpBcXezfC83P1VZNPrlCZntaSra80TrAxmpP7uV0tZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477882; c=relaxed/simple;
	bh=+dgCnqZ4UITNFg9myT2OOr0eyNbFaLGNHEr72cMkMgU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjGrGXPQulI6L3JvtEGDX0bLbxNcIzl8xt/aOXPoNOWFpt7QIHnfRLQXiy17T0FZV7s1bjYARHRSDofr/ujZUCBw2MFTju0CNZlzpKZTwW3L75CToVJBeDxPITKKLw2bv8aeNCTzRr2k1z9s7eavr4YkbI8seoJYYk5zHfeOQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6SwM-000000000GX-3PM7;
	Tue, 15 Sep 2026 13:11:14 +0000
Date: Tue, 15 Sep 2026 14:11:11 +0100
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
Subject: [PATCH net-next v16 6/6] net: dsa: mxl862xx: document devlink flash
 and info support
Message-ID: <593c60c6ebaa2526fd1e2d06cd8bd6910cd3ad92.1789477568.git.daniel@makrotopia.org>
References: <cover.1789477568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789477568.git.daniel@makrotopia.org>

Describe the devlink info versions and the flash update behaviour,
including the MCUboot rescue mode recovery, in a dedicated file under
Documentation/networking/devlink/ and link it from the index. Add the
new file to the driver's MAINTAINERS entry.

Assisted-by: LLM
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

 Documentation/networking/devlink/index.rst    |  1 +
 Documentation/networking/devlink/mxl862xx.rst | 91 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index d4a83fdcff7f..145cb8a4becf 100644
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
index 000000000000..793f3521f505
--- /dev/null
+++ b/Documentation/networking/devlink/mxl862xx.rst
@@ -0,0 +1,91 @@
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
+       firmware), for an unfused part, and after a failed flash.
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
+       flash, and in MCUboot rescue mode while an interrupted download
+       is still being recovered in the background. Once the loader is
+       ready to accept a new image the version appears as "0.0.0",
+       which no released firmware reports, so version-comparing tools
+       offer any available release as an upgrade. Use ``devlink dev
+       flash`` to tell a recovering switch from a ready one, see below;
+       a missing version on its own does not say why.
+
+Flash Update
+============
+
+The ``mxl862xx`` driver implements support for ``devlink dev flash``.
+The signed firmware image is transferred to the switch over the same
+MDIO bus which is also used to manage the switch, then verified and
+installed by the MCUboot bootloader running on the switch. All ports
+of the switch are closed for the duration of the update and the driver
+reprobes the switch after it has rebooted into the new firmware; they
+come back registered but down, so userspace brings them up again. A
+complete flash and reprobe cycle takes about one minute. In the rare
+case that the reprobe cannot be scheduled at all, ``devlink dev
+flash`` reports that error and the driver stays bound to a switch it
+no longer tracks until it is unbound and rebound. A reboot started
+while an update is running waits for the transfer to finish, and an
+update requested after the system has begun shutting down is refused
+with ``-ENODEV``.
+
+A switch stuck in MCUboot rescue mode, e.g. after an interrupted
+update, is registered without user ports. If the previous download was
+interrupted mid-transfer the loader is wedged; the driver drains it
+back to a clean ready state in the background, one byte at a time,
+which takes tens of minutes for a large image and is reported through
+the kernel log as it progresses. During that recovery ``devlink dev
+flash`` returns ``-EBUSY`` with an extack message saying so, and
+``devlink dev info`` reports no firmware version. Once the loader is
+ready the firmware version appears and flashing a firmware image
+through the regular update flow recovers the switch.
+
+If the driver gives up on the recovery, ``devlink dev flash`` returns
+``-EIO`` and says so in its extack message. The drain runs once and is
+never resumed, so a failed MDIO transaction ends it as well. A loader
+that stops answering the drain needs a power cycle; a completed drain
+whose reprobe could not be scheduled, and a drain a bus error cut
+short, need only a driver rebind. The driver re-examines the switch
+when it binds and at no other time, so a power cycle on a board where
+the switch can be cycled on its own still has to be followed by an
+unbind and rebind for the recovered switch to be recognised.
+
+A download interrupted during its opening handshake, before the image
+header reached the loader, is reported the same way. The loader waits
+for a header that no later session can supply, so that state needs a
+power cycle.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e04d92d1b09..43137dee4331 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16248,6 +16248,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+F:	Documentation/networking/devlink/mxl862xx.rst
 F:	drivers/net/dsa/mxl862xx/
 F:	net/dsa/tag_mxl862xx.c
 
-- 
2.55.0
