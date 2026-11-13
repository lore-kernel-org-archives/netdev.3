Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589171;
	b=nD3tyqr+ylOl/iUcWbNqOrfwznwT6uqeVbi9ZBNxNC9n1T/v1UtX1Rh6TVJR2CT6smqo
	 KqDYvUaPxFc83frYNTtxJGgtsGUC9T7mmBsktfZdTjJz/kVaGj6uRM13kbrnfbsx4H5Ta
	 cPNHoytFzCLwiHERU9709AcqmP3ouSvq+HnPU3wZlbuduftI15ud5t4cokfqlNSNdWblR
	 z4uFrlREt0rdlXkUDe05EtbYsjYXCf2zLDW0PsKw7dsj1fu2ggvaI/bPptX+PGtJrejzT
	 NJduUTtxEt332c6Id9j7l0PIP/9YhYKwSDiCp+50Q8KeQ/A4ZN2HE3E2xEtdsTGaLRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589171;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Q/0M4oAKHSfcIxLWoIOzvEskHd1YaPMv1fPGNuOv7k=;
	b=hvqKbGvFPwmWBqjF4uEViKBaEeCMv0NAP+73VZXi3DNpT7bso7snE1Naa6aH5hKwpYtR
	 ufyjSuFBVdNmksvOiQpBtHewHav/X2Q5opqKNjxgKRtE1L9G82b3hjSmZdkgvRs6aMU3B
	 22qe6ASMFe3FVsOQ5Glx6dXSsMHWNRMR2QbQdY0MiJDH32Ur8cVBXZ9fnNajZbbAIp79E
	 XZ7tCmE10JQLln6yr9u3TCoGhZum4az1MBXNxWvUpZhVQOeonQE53iqfR6tntA11jCcQM
	 AYpRTn9yu8RYj0ju36l8EwiglPZTTI7R2um+DR+2bavSjczl8sA7lJQ6YaKCwXTr5og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xur/rauz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0474606A8A0;
	Fri, 13 Nov 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xur/rauz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589171;
	b=y+DIzrbsjzgpBUs8ICBYgwtu38s7NsqwwYhQt1Acduh0GtET48iROa3XOvY50h6ZjKCC
	 Ssyi3TgeRSOygC5GQA8WU2ng7F9hwPRA7vkOXYIPW467v7wOXDQe4BfubOcnQ92elFyHz
	 uLM81sfjLK5AVxols1GXsDCOGv8Av+S/YNw5yeUmTJEynsYgbcoax6euE7ff3TwhguS+J
	 Ote/mqe5Ry3x/BslGpchscvNM5FhGY0yheKXkysbdnq2C5c8+Oaar1yg2Mr+nt3SMTeKN
	 g2i3RkfAMeyT/hOO/ixgTSyK2b9KaCn1s5WRq0g+H99p+JbOE/DwpcMQGl86ykdE9Hw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589171;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Q/0M4oAKHSfcIxLWoIOzvEskHd1YaPMv1fPGNuOv7k=;
	b=E0FlgZ0G3xSYPKcaYIhU6abfRWR+CcXJFjKUtzQWXPM8lG+zjZZzaZ2uSu02430pXRdD
	 lrg31nVQqD7+0+4CVopUHBAu6iRJ8w/06xv0n6yHBQf6sMgu/WGnG+qJoD5FK6mNf0oD9
	 /A2DlpkpgYtNQ7vWEYb+pycYeXiR/ouHxKWpmlBmszwEYW84nOPC4UBDvLqdb+DZIEGWb
	 +PJZozo30a6F5Pu0F3j8OJeCFWRsAXSi29vXpCw3KiUrvkzNxkJuHPGmYyRUqmllxMvjt
	 536ijTIl30G+MJ5TKdT6Tmy96JyvN/z0H5AHX60jDJeFlMXOFVy8PlhqlH/70duFG3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A131D1F000C7;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589171;
	bh=1Q/0M4oAKHSfcIxLWoIOzvEskHd1YaPMv1fPGNuOv7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Xur/rauzAarze2EtkAmgxFQ1fB7tmFaQYs9UOZpuJsLNjc9pwfh1KsJkFIdf2ACMm
	 RCOhs4DTFCCsgaElwGoIlZn5b0uVGM1sKc/wdGQbhFjg35UlYJQHDrowDix8CBaGuk
	 VNd2eSX4T0RgJwhGaWkrNgfhyVBrXdT9p4aeY3O5jb6ClGsdbd1Bi2cGYbldyei1MM
	 b8mcwmiufJwkv3O7YPbFulGgf3/9O8jehN8mOrIGjSdwA58INb/okluIn27IGYbytw
	 aCNGU7xorJGt27T1L4/LZKdTIDsh/8wWnaec8/wS0lhyVIZ68QSFfLsRyEEFeBHMR7
	 M6efuAa9cfx/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2D20C49A17;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:22 -0800
Subject: [PATCH net-next v11 03/14] net: ethernet: oa_tc6: Move oa_tc6.c to
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
Message-Id: <20261113-s2500-mac-phy-support-v11-3-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=5322;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Pd0dXYiMZlEIzgfNTnIo8RTA035x6ymrrjs+dN6mS2Q=;
 b=JRFSyQGbCZ8jGyDjr4z8DPDUdVEu+D5gxL0JIoVbBg//vc00+drFos1SnCzqp/Cg5MsW10X1e
 4yQbYRjTsvVC9DpaiuIDEy6g0Q+Jk3gHno/MyXtokt5eUQwZlmC6g9X
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Move oa_tc6.c to its own directory, drivers/net/ethernet/oa_tc6.
File oa_tc6.c is renamed to oa_tc6_main.c to maintain the kernel
module's name as oa_tc6. This will facilitate adding more files
to support other features defined by OPEN Alliance 10BASE-T1x
Serial Interface specification.

This patch series adds two files, one for hardware
timestamp related functions and one for PTP related APIs.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Mentioned the renaming of oa_tc6.c in the commit message
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
 drivers/net/ethernet/oa_tc6/Kconfig                     | 15 +++++++++++++++
 drivers/net/ethernet/oa_tc6/Makefile                    |  7 +++++++
 drivers/net/ethernet/{oa_tc6.c => oa_tc6/oa_tc6_main.c} |  0
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a4c26694ba7..028fa967674e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21043,7 +21043,7 @@ M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
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
index 000000000000..ec2787eae4b1
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/Kconfig
@@ -0,0 +1,15 @@
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


