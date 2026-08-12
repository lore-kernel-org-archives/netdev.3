Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2842641B;
	Wed, 12 Aug 2026 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531888; cv=none; b=nsFVlwukwSwGP3fYmIjZSwXLOi+wVazNMSKy2qQLbyICbEv1XUg911y9NIf/dfoHwjH8pN9M+T/JL8Hwm4c6jd70bIICxWo3IOZm8YgVzkQzmqLGyxpgYcSAtVFquQH2JH1L0OBt+Dol6PVcvGZ1LsYPkLDBY3WmK/CprS6q9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531888; c=relaxed/simple;
	bh=Z70fjpYttGJ5pF28+/q5Hw0XOwexxfwU6c0isKT50eA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ttkxb2cIRtjxcwCYOGJEH/21tKxyDhqDCG2arvtyhFGig0mGqKC/ILBJ3YgZ/HAJeYse20pHaUJwafyZ8JYzHOpyJ4oqcm750rVIzCKnMu2EHJ15tLal03oi07CynimN/QdCVryG40fEjSk5hmDW4OqD0j8Xc6uE/Qz4lCxqjKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UwutCFZY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UwutCFZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786531886; x=1818067886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z70fjpYttGJ5pF28+/q5Hw0XOwexxfwU6c0isKT50eA=;
  b=UwutCFZY1B2+Dhh4p74m1HAO601crOHhTkUVxnyXbF47OLwWW0PG7XxB
   GFLDVvxvEaMWusTJj1cisOBQyI+OVBO6aDx1nbx/nhuq5YXgSGVItLzMS
   KA7KJZpspH4jO8KI8wmQ26Hk7hdT7/qoKr+PSjiXTp8n63a5QOXHBua6y
   IP32JrsQloeBQ4ABAwSc7mAS1nypducvYG0HaXT64fX/5AxA4gjbBZSD9
   +tS6goa+gpSG4hMMAge171Vp46/3bXKCI1LvEKEa4EPpKUxtvQY0gWPId
   WSdonmxSyLRrbJWVdoJ89OT4NVtlrMyEcjndyNYYCknuCcKihD1aRYx+A
   w==;
X-CSE-ConnectionGUID: LSAcPquSSsak6epvTX2MmA==
X-CSE-MsgGUID: lzlKLKSLQnGi/vL1LfQsDw==
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="71673518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:51:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 12 Aug 2026 03:51:25 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 12 Aug 2026 03:51:14 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v7 6/7] ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
Date: Wed, 12 Aug 2026 16:19:54 +0530
Message-ID: <20260812104955.485667-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812104955.485667-1-manikandan.m@microchip.com>
References: <20260812104955.485667-1-manikandan.m@microchip.com>
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

The sama5d27_wlsom1 SoM is fitted with the factory-programmed
SST26VF064BEUI, and the QSPI flash node is only enabled on boards carrying
that part, so the EUI-48 marker and its "mac-address" cell are always
present. Boards without an EUI-programmed part simply do not reference the
cell, so macb0 never defers waiting for it.

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

