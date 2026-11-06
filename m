Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007138;
	b=ArLrcRipVtWwllSEubcj9/x7dFiaUwTs0FSHLR6/yhGdwv1Pp4VzjnmIraa0cuAhrdje
	 tA9B6YbvC60rfYIjsHuTv1+DHwtJYKDzMvkIfMNsSHda585i0j3S8MeCa6fj8EhVZkIzT
	 CBLB0O5vWW+eM4o2Rvo/5sUhRVGPiKeJnl1NZVDbAolUZlNQHezCbTjAVcVoKxAHtgGYc
	 NKXhv9yEiqp7hcj7fe+RVNkrKb5Ywrpp73Jj/1DAVkYRiRZdEF88OqbNtjHXVkeT8etox
	 ML0lg9Bcd4oxKqYOoAPuSdcSBmrxK9Mk6gXFUMaUCuk1FIxe8NIpdE5WhOiOniGiAKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007138;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uJNCoUVExvuKNiPDQyCb5bV/6Yj4WKaOmCisg4WPENs=;
	b=aKXFGflEd5rBI3JVk3+R+0cKOcAH4dZCIKUZONzsU0jLuv0btnx/COvJdeLfZGq6GFRS
	 wcp4YuKTGfl88Qhy+fcpGIn6KZ7gAnhODF4XBemS6uY6yP+lJ4EI/pd1DKXIm8ACFkhd2
	 7Mu1xHQR+UG/Nrl4sx1w6bfeaJwC0SuXf5UnuUUMrBWybWW4gd8HI/4QZUNodj+JHhmY0
	 LuAio/v273FPWKN51R9qDl/mog1dAWJJi48hEolxJw5LnoEi6NHehdAX17Qx3MPsY3HTb
	 tELEItbINVl89ACFBH4/1pW/OFPY9+DF/vpaMRPQ+KTRbQWZhDapsaI8DryQLcMFikA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaUIW0po;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F71606A33C;
	Fri,  6 Nov 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaUIW0po
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007137;
	b=xMhp1RM9B8lPAuj4FzlgIGBzibuPZ4oIGdN119Yy6Y1NeCfKCg0fi+m5HfIGuwcxGyFm
	 /AKIguXJVYxY3u5Hg9UnO2eT1v9w2IPA39eifsGL6rhcKHNirxf49IfjnxQ45/gYj69Et
	 mozZq9TX3ujrP5z85QqKQsffLM6e3tf2qEXfiOrWsfpPXGij+UT7zQ/VInl3qw9tfBBIU
	 OGv9wZ41RFIIp4a2maW7y6+MpBWKQ3JV7NUEpHMv+8kP++2wy0miHS9KLTJuHwCjmymma
	 7H5wMnai2NpcvOUqEgXJWYMMQ4Dw2aqnNuUPdTa9LjgxEgVUqECzNEik3xSRad30E5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007137;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uJNCoUVExvuKNiPDQyCb5bV/6Yj4WKaOmCisg4WPENs=;
	b=3b6vtqFaaPlXuVCskt1zlkH3ogvk++u5+DIWbSZZ8Mt9nrnQ0GuIYyqkBneqcp4K/ztQ
	 i1hhRrbgIpAgsS4FpXYTeTxz8SqJAkY8nTMkseAGKWEJnC1ZAYDSuV7J5WZq3RkB6LpMI
	 8bpPZFAXooh1fME9C3IZpoSJ4PowzqzKTpZ2EIY7dsypMOquJLFpsW22LvdcwscouULAP
	 rOz1EiA+vYIAR5KB/xvq5Pu/aeM/EFMqnr05IyHNK12lZLAUR19KoEOK79pY3GAqN/UVP
	 CVrXeWFOMHxQ7easYTkr12biqykASF4BM9nZ7eqSdbf9oguWpuHpFfQyw+ME4FKiQVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7A0A01F008A5;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007137;
	bh=uJNCoUVExvuKNiPDQyCb5bV/6Yj4WKaOmCisg4WPENs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UaUIW0po47vdkrYDJYqB1Ym8MGOxxau4+0iFjTsEIsAbeTa1OGRO+V7v9c+RY7RXi
	 g1GglCqKXg2Eef9OSm6m+18uYu/mAGM8lqk4qkV4PSzolQLro2z54Jfcld3y0o5J7j
	 87F68mmsuz6Y0OS7hPSeB4YqgslyijKAeuYdGerEGrDh9CagT07W1dSQ1DMpcfmi+I
	 KbBYU404NVPl2amUvLwmnwuu8ptjuan7QByml6st5rU1gixNqs+iV9iWS9m+jfy4gu
	 tj1/35e5gaPd695Xxw95BJsHtGONVFJ5oqnlDmPPWm+qs3JAaiGtI7E00ingX0/AxS
	 0DvT+zp4xH1mQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 04FE3478E4;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:49 -0800
Subject: [PATCH net-next v10 03/11] net: ethernet: oa_tc6: Move oa_tc6.c to
 its own directory
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-s2500-mac-phy-support-v10-3-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=5162;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=s4sA1nhnY21OlMJemCo3DnG6S+9E75VEi5MOHg8r9KY=;
 b=Wpr44rXg5NyiyPEO+0Jed7YuekH3DZ0SqTbkHqLNnM+oDgdyQkOGwd/xPTHr7SSxuBu9R76Yx
 UuWvcTMcNB+CzosMAn878g2n8iZBuV6E7hlUZFfiVRpAzrnBxD34iKO
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Moving oa_tc6.c to its own directory, drivers/net/ethernet/oa_tc6. This
will facilitate adding more files to support other features
defined by OPEN Alliance 10BASE-T1x Serial Interface specification

This patch series is adding two files, one for hardware
timestamp related functions and one for PTP related APIs.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v10
  - Kernel module restored to oa_tc6.ko from oa_tc6_mod.ko
changes in v9
  - Changed MAINTAINERS to add "all files" under oa_tc6
  - Added the missing "if COMPILE_TEST"
  - Added Reviewed by tag
changes in v8
  - No change
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Removed reference to onsemi in Kconfig files
changes in v3
  - Moved oa_tc6.c to its own, oa_tc6 directory under ethernet.
  - First patch
---
 MAINTAINERS                                             |  2 +-
 drivers/net/ethernet/Kconfig                            | 12 +-----------
 drivers/net/ethernet/Makefile                           |  2 +-
 drivers/net/ethernet/oa_tc6/Kconfig                     | 16 ++++++++++++++++
 drivers/net/ethernet/oa_tc6/Makefile                    |  7 +++++++
 drivers/net/ethernet/{oa_tc6.c => oa_tc6/oa_tc6_main.c} |  0
 6 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92053fd89bb2..7cf0e33a8be9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21029,7 +21029,7 @@ M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/oa-tc6-framework.rst
-F:	drivers/net/ethernet/oa_tc6.c
+F:	drivers/net/ethernet/oa_tc6/*
 F:	include/linux/oa_tc6.h
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index c2b0161d0bec..5758e0fbbca5 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -135,6 +135,7 @@ source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
 source "drivers/net/ethernet/nxp/Kconfig"
+source "drivers/net/ethernet/oa_tc6/Kconfig"
 source "drivers/net/ethernet/oki-semi/Kconfig"
 
 config ETHOC
@@ -147,17 +148,6 @@ config ETHOC
 	help
 	  Say Y here if you want to use the OpenCores 10/100 Mbps Ethernet MAC.
 
-config OA_TC6
-	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
-	depends on SPI
-	select PHYLIB
-	help
-	  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
-	  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
-
-	  To know the implementation details, refer documentation in
-	  <file:Documentation/networking/oa-tc6-framework.rst>.
-
 source "drivers/net/ethernet/pasemi/Kconfig"
 source "drivers/net/ethernet/pensando/Kconfig"
 source "drivers/net/ethernet/qlogic/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index a306dae23bcb..e0e86c249e42 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_NET_VENDOR_NETRONOME) += netronome/
 obj-$(CONFIG_NET_VENDOR_NI) += ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
 obj-$(CONFIG_LPC_ENET) += nxp/
+obj-$(CONFIG_OA_TC6) += oa_tc6/
 obj-$(CONFIG_NET_VENDOR_OKI) += oki-semi/
 obj-$(CONFIG_ETHOC) += ethoc.o
 obj-$(CONFIG_NET_VENDOR_PASEMI) += pasemi/
@@ -105,5 +106,4 @@ obj-$(CONFIG_NET_VENDOR_XILINX) += xilinx/
 obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
-obj-$(CONFIG_OA_TC6) += oa_tc6.o
 obj-$(CONFIG_NET_VENDOR_ZTE) += zte/
diff --git a/drivers/net/ethernet/oa_tc6/Kconfig b/drivers/net/ethernet/oa_tc6/Kconfig
new file mode 100644
index 000000000000..657567276030
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# OA TC6 10BASE-T1x MAC-PHY configuration
+#
+
+config OA_TC6
+	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
+	depends on SPI
+	select PHYLIB
+	help
+	  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
+	  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
+
+	  To know the implementation details, refer documentation in
+	  <file:Documentation/networking/oa-tc6-framework.rst>.
+
diff --git a/drivers/net/ethernet/oa_tc6/Makefile b/drivers/net/ethernet/oa_tc6/Makefile
new file mode 100644
index 000000000000..c51621fae8be
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for OA TC6 10BASE-T1x MAC-PHY
+#
+
+obj-$(CONFIG_OA_TC6) += oa_tc6.o
+oa_tc6-objs := oa_tc6_main.o
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
similarity index 100%
rename from drivers/net/ethernet/oa_tc6.c
rename to drivers/net/ethernet/oa_tc6/oa_tc6_main.c

-- 
2.43.0


