Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED043469852;
	Wed, 14 Oct 2026 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960101; cv=none; b=fcwumvmGNBOUMrGF1IhBE5j3FvCQDN1tuavTRfRMziucS3m4VAi8/1ejRZy2o5NKrMkOUKIjC5h/KSyjMrhX/T3tpYvBzoX0JHwEb4E3wOY8CJHokcoy+3KBFSoiAhpy1XwANUaX1QKFrlWGl9aJyY709GNzQejV3DBPBS9MQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960101; c=relaxed/simple;
	bh=vrwYmM5Vth4AIix4/4mGQ4sTGgffKjR1GLZyy+Li7o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHO6940xUcLYsVnzNbXFFyBx0LeVR4vxeDbB+S8QUw4PrKISeLPiiI53uoW5YVcyzE9AUBCsx/Au3wCni1ZAF7+4vpksBQrrlWHek7p0toDRq+0yv2pAI1kd5LkINzWNX/XySGdlxLo1YOVWzBDRoxAR75JtuINUTDHDCDJM6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pa3E+/4t; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pa3E+/4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791960100; x=1823496100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrwYmM5Vth4AIix4/4mGQ4sTGgffKjR1GLZyy+Li7o0=;
  b=pa3E+/4tESiQbewQ/MXdmI+FXbYzA1fkqHvR7aOtrzvTqbEaQ+HMPVFQ
   f1CS8zI1xXCH6nbdasfUaAV4WyW1Q3mpwFXnDSrzuzPb8fhO3S2OmLOzU
   dX8XmnZtrlKGX5AbchAoOlwhOe3vZAs1IQamAeB0XmyTTScF1GjHRHGzO
   K8CpANTs0nrDxO3geGgmBC74eStkmwRzny+PqciDc2SOXl2/GKJPhF+XH
   jZOc1iZ4vXFJR7KxL/yCzdzd/8m1D/xUrvS0E0Bz+R39N+UDeLrpPAKuk
   8nN0b4BydZo+2st9sSO3L5NHur0IUDv/QNfMRVqutL6TKch5vQ0NywjSj
   A==;
X-CSE-ConnectionGUID: GLBYWGQOTzW6B7xcbU6cfA==
X-CSE-MsgGUID: vO/EN+ZwQn6axeg2P/CocQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="296426236"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 23:41:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 23:41:38 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 23:41:29 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <aaro.koskinen@iki.fi>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v8 6/8] ARM: dts: microchip: sama5d27_wlsom1: use fixed-partitions for QSPI flash
Date: Wed, 14 Oct 2026 12:10:10 +0530
Message-ID: <57b6d9c4664727ca16a3ff3c3005342db5f64d78.1790847519.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790847519.git.manikandan.m@microchip.com>
References: <cover.1790847519.git.manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move the QSPI flash partitions under a "partitions" node with the
"fixed-partitions" compatible, as required by the current MTD partition
binding, instead of declaring them as direct children of the flash node.
No functional change.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 0417f53b3e96..6ce42a42a1bf 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -229,8 +229,6 @@ &qspi1 {
 	status = "disabled";
 
 	qspi1_flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <104000000>;
@@ -240,34 +238,40 @@ qspi1_flash: flash@0 {
 		m25p,fast-read;
 		status = "disabled";
 
-		at91bootstrap@0 {
-			label = "at91bootstrap";
-			reg = <0x0 0x40000>;
-		};
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
 
-		bootloader@40000 {
-			label = "bootloader";
-			reg = <0x40000 0xc0000>;
-		};
+			at91bootstrap@0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x40000>;
+			};
 
-		bootloaderenvred@100000 {
-			label = "bootloader env redundant";
-			reg = <0x100000 0x40000>;
-		};
+			bootloader@40000 {
+				label = "bootloader";
+				reg = <0x40000 0xc0000>;
+			};
 
-		bootloaderenv@140000 {
-			label = "bootloader env";
-			reg = <0x140000 0x40000>;
-		};
+			bootloaderenvred@100000 {
+				label = "bootloader env redundant";
+				reg = <0x100000 0x40000>;
+			};
 
-		dtb@180000 {
-			label = "device tree";
-			reg = <0x180000 0x80000>;
-		};
+			bootloaderenv@140000 {
+				label = "bootloader env";
+				reg = <0x140000 0x40000>;
+			};
 
-		kernel@200000 {
-			label = "kernel";
-			reg = <0x200000 0x600000>;
+			dtb@180000 {
+				label = "device tree";
+				reg = <0x180000 0x80000>;
+			};
+
+			kernel@200000 {
+				label = "kernel";
+				reg = <0x200000 0x600000>;
+			};
 		};
 	};
 };
-- 
2.43.0

