Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30251F942;
	Wed, 29 Jul 2026 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299501; cv=none; b=ClZ8qFOggQzyS6A65hI8peue40aJ9lVbWw57vIJsjGzP+H3xp/9hSixTtXuzWXipBJlewyaSqWhJZEzNv6yNBnpoJH63PpBjsx5aa6l6mmqiGPDb3mMNu90e3g0bzgATCHHPr3Ph3Wl75a8lhOjwRTSiFoT6wLmX52gnHaAwGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299501; c=relaxed/simple;
	bh=u07TJeDCCVaXR3QuNiyHWuVEekradh6f6nrwnIgoJZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwUQC7ZhjkwnQB22WfaaYr3K3R8/wAt4SGomCrNDojrMW4+25xEHJvRi+FMf807i+pD3Y6oNM5xy6HuQxxJ4mv1Vd6AHvrjbm4FE362R/FLvbq+VIYRBLL/55kiEk06FWVAdC72LCBpeeYU8dgkp2XF8As6DRtpExECIEFjyGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t6pMqaJ7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t6pMqaJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785299502; x=1816835502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u07TJeDCCVaXR3QuNiyHWuVEekradh6f6nrwnIgoJZY=;
  b=t6pMqaJ7MNNwjdelikzwLobscHXsinSRIJ9tYsoPvetnEejQWXrd7pH0
   GTV9B5KvUvWrEJPifokAAcefBgkc67CsgYVwiQX95ySJXeSDA0ETICZxR
   InvJGXOdblRlbf6gwdvG1MAQ4FT2BS+ILe3Z8raVw7Du0ACap/v8TTbzH
   4gV+z0zxpEJSX76/5Nx4Wy4nPnZ1doE3zA8JwhbRoRJbCWchv+XTtFoR0
   Yfh3DzWeHFR8Ra5m/aZUMzklUobzon2LYHa4zCSfUjJw4yLeBRZJc6ieC
   aRZaqP342tiETMbGMhx/AygC3GuGDAuqapQ8rAMGhqEQkJI8iUmDEuu74
   Q==;
X-CSE-ConnectionGUID: ni5imx0OTlSyOvf2qThVDg==
X-CSE-MsgGUID: EVhjFy5dQkeuaEA64k3AeA==
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="292693777"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 21:31:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 28 Jul 2026 21:31:38 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Jul 2026 21:31:30 -0700
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
Subject: [PATCH v6 6/7] ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
Date: Wed, 29 Jul 2026 10:00:25 +0530
Message-ID: <20260729043026.1811147-7-manikandan.m@microchip.com>
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

Describe the QSPI flash SFDP as an NVMEM provider with the
microchip,sst26vf-sfdp-eui layout, which exposes the factory-programmed
EUI-48 as a "mac-address" cell, and point macb0 at it through
nvmem-cells. This yields a stable MAC address on boards where U-Boot does
not program one, instead of falling back to a random address.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi | 11 +++++++++++
 .../boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts    |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 062aa02a98ed..6016d7f2a39c 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -240,6 +240,17 @@ qspi1_flash: flash@0 {
 		m25p,fast-read;
 		status = "disabled";
 
+		sfdp {
+			compatible = "jedec,sfdp";
+
+			nvmem-layout {
+				compatible = "microchip,sst26vf-sfdp-eui";
+
+				mac_address_eui48: mac-address {
+				};
+			};
+		};
+
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 35a933eec573..5e87bf04bc47 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -97,6 +97,8 @@ uart6: serial@200 {
 
 &macb0 {
 	status = "okay";
+	nvmem-cells = <&mac_address_eui48>;
+	nvmem-cell-names = "mac-address";
 };
 
 &pioA {
-- 
2.43.0

