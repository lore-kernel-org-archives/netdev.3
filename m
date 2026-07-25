Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DE1A6812;
	Sat, 25 Jul 2026 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784945860; cv=none; b=nYVCEfKHF9Nol+2Vg+iCBn4yr1QDqS4V+VUFQ5tmvII+zKd3blfC7Te4bbjuOhTKOf6C0MBOMzzG4dYNkzaJrgLFWHf/Lc9COG05HcRyEDtbBmKm6ASOuD1cbG+wJK9iWQvZGK2/AoE5K3xXdh4lhpHuJiXGxLW0Xw+g1fCvKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784945860; c=relaxed/simple;
	bh=mRoIgPi4xqc6YB82bZxJdGCTWM3VUVTC4H+B9KPyXKg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKFTwifEoQF6JP1kxD0Fz9ggy1zxc+cngQZK28gQdCoS706G1HS71CrmkDWs0Az9JjLP3VMUwqforaRwcl9TP4sWLZRC55xfSAX8364xifdSUezeMpaO9ubdHgQQT3B2eykUrRh5FcRlC0c3NqqHXCXolfD+5ekNInZqh9rs5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wnRxF-000000002lc-2oWG;
	Sat, 25 Jul 2026 02:17:33 +0000
Date: Sat, 25 Jul 2026 03:17:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/5] net: dsa: mxl862xx: document devlink flash
 and info support
Message-ID: <3a85832b8584543241bc9fe382fcb9849b78bd01.1784945329.git.daniel@makrotopia.org>
References: <cover.1784945329.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784945329.git.daniel@makrotopia.org>

Describe the devlink info versions and the flash update behaviour,
including the MCUboot rescue mode recovery, in a dedicated file under
Documentation/networking/devlink/ and link it from the index. Add the
new file to the driver's MAINTAINERS entry.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: new patch

 Documentation/networking/devlink/index.rst    |  1 +
 Documentation/networking/devlink/mxl862xx.rst | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 65 insertions(+)
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
index 000000000000..b3e9f7d4d496
--- /dev/null
+++ b/Documentation/networking/devlink/mxl862xx.rst
@@ -0,0 +1,63 @@
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
+     - The chip part number read from the CHIP ID registers. Not
+       reported for a switch sitting in MCUboot rescue mode as the
+       registers are only accessible with a running firmware.
+   * - ``asic.rev``
+     - fixed
+     - 0
+     - The chip version read from the CHIP ID registers. Not reported
+       in MCUboot rescue mode either.
+   * - ``fw``
+     - running, stored
+     - 1.0.70
+     - Version of the firmware running on the switch, reported as both
+       running and stored since the switch boots it from its own flash.
+       In MCUboot rescue mode nothing is reported while an interrupted
+       download is still being recovered in the background; once the
+       loader is ready to accept a new image the version is reported (as
+       both running and stored), which is the signal that a flash will be
+       accepted. It reads "0.0.0" when the switch came up straight into
+       MCUboot without ever running firmware.
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
+back to a clean ready state in the background, which can easily take
+more than 10 minutes. During that recovery ``devlink dev info`` reports
+no firmware version and ``devlink dev flash`` returns ``-EBUSY``.
+Once the loader is ready the firmware version appears and flashing a
+firmware image through the regular update flow recovers the switch.
diff --git a/MAINTAINERS b/MAINTAINERS
index 60cff00953dc..3a55ed2bad9c 100644
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
