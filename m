Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07C35C1AD;
	Tue, 30 Jun 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811589; cv=none; b=Fv/LZ0VJJ0b1kea3OGkaPaHhHsRcg+R6H1/sj4AAi6quRQNld0MVD/lQYd9YWrXP/lXsKsnFAnVUy5mFLl6HR3sNL7Kv8ciAhkXRWcE+jOUD5btMEI4mpa82BUXaJTd87w/BTgiChGYNrFc13EMAM7q0l3ECigI1RXP0m+qWoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811589; c=relaxed/simple;
	bh=U7Dm9w0opxqgrfyVR37miYn+2HmakoHS4QAPEE706wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tl1wHDp0ScTcwHHjHU8Vg5rVKgCJghuJFlPnesDUQL9crpHk73k75q5F06MER+qejKU/jHQWkMI2UePg2uLysuu9q3baclQ2N0lj873jn3Qo8DLFz2beN+dbu/39M2NEuPJeNtZp32qwWm7TCQjOduLr3PIR7mXaIVKP66wtk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YIjGzaFL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YIjGzaFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782811588; x=1814347588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7Dm9w0opxqgrfyVR37miYn+2HmakoHS4QAPEE706wU=;
  b=YIjGzaFLj/cOxHdtKYprZE+1seb+dP1wo8IAQ1k5gVmHD0vDhKxJsckd
   JuNakp7hoHXfCYUQUtwzoQCbhqcWt1xXSRWePkXkmGI3MTRbjTOZTZDU3
   DbJN0uoRtQkiD30AjvdeVwGUbT/6g2UWmBX7fbGKKt7Xk/lnwYYydxx5G
   WLcMI2S7UtI9PR8B0F0/xtTx7T7t2Urvi+BdoiEXFs2UG9CR+McYG8rI5
   tcqzqYPyWy/AIhJqRUfJyEvlDttmGXvWYddL+6dSCHO9+xPjqnM/W843i
   fH3DwE68Q5V55dKZcxh4fSgOAozckWYNHcBicRY84Wqb7ta4cASzZX1BZ
   Q==;
X-CSE-ConnectionGUID: sYkn4PCLTs+ow1M6Jod65w==
X-CSE-MsgGUID: zy5FU9PySxC5cIsgPuCTeg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="291266527"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 02:26:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Jun 2026 02:26:26 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:26:16 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v4 6/7] ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
Date: Tue, 30 Jun 2026 14:54:05 +0530
Message-ID: <20260630092406.150587-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630092406.150587-1-manikandan.m@microchip.com>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
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

