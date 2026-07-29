Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443923ABBE;
	Wed, 29 Jul 2026 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299491; cv=none; b=SYSaEjzXkaAjXF9csl6C/mRNXKfRnG0WYCEKJJ9SHd0HCwGPRmH6eSw7Yg3GO+zZpdpq7jd7b9LG2Logzth9KbFVEoc78RrIFCtNjcSSalH2F4s+Q626uHZOrr0Mx8vFuZvxykZPHYRUsmeJm8dbCXjlj8kNy7D3JBb56lzk/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299491; c=relaxed/simple;
	bh=+Txf5rjD+DI2shJcwGP84PS0A02ha3PLs4g7tp/AJhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egb31BhBfPOatdotu9IS4dmgZEYz2+PjRrHYG6R4F+2Ed9OCP4HlJDX4t3/lB7nsXjAK0sXDhMtrE2LmwHa0AJ9TlMQK0DEbRlPu3HASHAasdSTyMrXDVPbRKQ29b4/HTXVerxnEI3m29ItueCxDXG3U+2Nv6rAyPDWkduOjx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cc8KoZIx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cc8KoZIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785299490; x=1816835490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Txf5rjD+DI2shJcwGP84PS0A02ha3PLs4g7tp/AJhg=;
  b=cc8KoZIxKBrvS5bhgGMONDz0rqjK2bkZzxu32AzPiM81OYTdG4uWb8Vy
   Fm+ysOg0/TUpeR5KaQVGbu6qnQU3WC8jk8VYSNmKnLyG9D6FvT1YRiQQC
   qJF8vpcaUMN7z7TODb8ORfeBeksqwJcl8ZxIMPp2NsDb6jeR3pcZzovTM
   pmWmMltrQgktS+vxVlo+akC0vAnm2ic60gfTAWkd5IsVAuA5Q6gr1sRpX
   so+lMJL3Z8CF6m6Y1EEL7reYmAZMhRg7qxq2kTAQjgvnuvSbyK8en8qIN
   svsPgA4el0kHO4J8PhLNrtqo/5f7sXfJXDDiSiFRQb7e/vlUPu+swyOAo
   Q==;
X-CSE-ConnectionGUID: 0XBTj9xIRi2mrTgPFZ1xkQ==
X-CSE-MsgGUID: 6t5S/ySKRZSv9COd5FXg1g==
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="61636953"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2026 21:31:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Jul 2026 21:31:29 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Jul 2026 21:31:20 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v6 5/7] ARM: dts: microchip: sama5d27_wlsom1: use fixed-partitions for QSPI flash
Date: Wed, 29 Jul 2026 10:00:24 +0530
Message-ID: <20260729043026.1811147-6-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729043026.1811147-1-manikandan.m@microchip.com>
References: <20260729043026.1811147-1-manikandan.m@microchip.com>
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
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   | 52 +++++++++++--------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 0417f53b3e96..062aa02a98ed 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -240,34 +240,40 @@ qspi1_flash: flash@0 {
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
+
+			at91bootstrap@0 {
+				label = "at91bootstrap";
+				reg = <0x0 0x40000>;
+			};
 
-		bootloader@40000 {
-			label = "bootloader";
-			reg = <0x40000 0xc0000>;
-		};
+			bootloader@40000 {
+				label = "bootloader";
+				reg = <0x40000 0xc0000>;
+			};
 
-		bootloaderenvred@100000 {
-			label = "bootloader env redundant";
-			reg = <0x100000 0x40000>;
-		};
+			bootloaderenvred@100000 {
+				label = "bootloader env redundant";
+				reg = <0x100000 0x40000>;
+			};
 
-		bootloaderenv@140000 {
-			label = "bootloader env";
-			reg = <0x140000 0x40000>;
-		};
+			bootloaderenv@140000 {
+				label = "bootloader env";
+				reg = <0x140000 0x40000>;
+			};
 
-		dtb@180000 {
-			label = "device tree";
-			reg = <0x180000 0x80000>;
-		};
+			dtb@180000 {
+				label = "device tree";
+				reg = <0x180000 0x80000>;
+			};
 
-		kernel@200000 {
-			label = "kernel";
-			reg = <0x200000 0x600000>;
+			kernel@200000 {
+				label = "kernel";
+				reg = <0x200000 0x600000>;
+			};
 		};
 	};
 };
-- 
2.43.0

