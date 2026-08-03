Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A14383C67;
	Mon,  3 Aug 2026 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729149; cv=none; b=p4n2ymtHjlgWYEyepmhxdkB3lG/ABIHV2ITJKQsHzF2PIiLQt0nTurlAaHOden2DaXmrxuFk11/fP+4c69f5Js2itLMGtRqKLbmAaV+pIw6Kus/fTjPsWfuCqqREPmyxDtdX01+HaHjFsR9yGzBQfbZI3GgDgUw0bl0vhdA1yS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729149; c=relaxed/simple;
	bh=Y5cxMjwL8c3V6eeyKHgaO2vT7gOvy2wtVlGeesqRHHI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3il1SzPbhRf+fIjFTxpZBMnnQszfNUmfA0QyHziFejM+IXbetG4goXaUO+Izy/yqnTl/HEx/hRoH6eLHaetBRnP06Fzn/TDQUj3DAP1RTMlIFdHt6et8I8fEGWSDNtNF0Td3cjnDcM1RV2EgBYiCy+/G+4iArflpm5WPEFmJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wqjit-000000004de-33SH;
	Mon, 03 Aug 2026 03:52:19 +0000
Date: Mon, 3 Aug 2026 04:52:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 5/5] net: dsa: mxl862xx: document devlink flash
 and info support
Message-ID: <a3d064909b441aa3c8524328ebe8d9cad5ef1c0d.1785728574.git.daniel@makrotopia.org>
References: <cover.1785728574.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785728574.git.daniel@makrotopia.org>

Describe the devlink info versions and the flash update behaviour,
including the MCUboot rescue mode recovery, in a dedicated file under
Documentation/networking/devlink/ and link it from the index. Add the
new file to the driver's MAINTAINERS entry.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
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
 Documentation/networking/devlink/mxl862xx.rst | 71 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 73 insertions(+)
 create mode 100644 Documentation/networking/devlink/mxl862xx.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 4745148fecf4..058999d0dc56 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -94,6 +94,7 @@ parameters, info versions, and other features it supports.
    mlx5
    mlxsw
    mv88e6xxx
+   mxl862xx
    netdevsim
    nfp
    octeontx2
diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
new file mode 100644
index 000000000000..7c2dc11f6585
--- /dev/null
+++ b/Documentation/networking/devlink/mxl862xx.rst
@@ -0,0 +1,71 @@
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
+     - The chip version read from the same register word, so it is
+       omitted whenever ``asic.id`` is.
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
+Flash update
+============
+
+The ``mxl862xx`` driver implements support for ``devlink dev flash``.
+The signed firmware image is transferred to the switch over the same
+MDIO bus which is also used to manage the switch, then verified and
+installed by the MCUboot bootloader running on the switch. All ports
+of the switch are closed for the duration of the update and the driver
+reprobes the switch after it has rebooted into the new firmware. A
+complete flash and reprobe cycle takes about one minute.
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
+If the recovery fails, the loader needs a power cycle: ``devlink dev
+flash`` then returns ``-EIO`` and says so in its extack message.
diff --git a/MAINTAINERS b/MAINTAINERS
index 932ea1db048e..c27c449159c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16107,6 +16107,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+F:	Documentation/networking/devlink/mxl862xx.rst
 F:	drivers/net/dsa/mxl862xx/
 F:	net/dsa/tag_mxl862xx.c
 
-- 
2.55.0
