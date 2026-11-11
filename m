Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398223;
	b=2Bw69Z8U5r5h+GGw2G+2YlQeSpbh254RHPQkKnjc6sV6u9bzwRpuoQAloxQ1IyjnMQQG
	 0ZCAgBqxNRcvfA1eD50hQRPBIZpZFnApt28cR0J/ZSl5EQSbRzMhCNKE793DC1eIhubir
	 jc+cxUuDLcNFsKluVj/vArImuNghM7HHYqpVoJVEUAVMPGZpep0NDYZnZF/TMnGDVUtkG
	 XNxDkfVGyrNWbwmiZBAZBJ/i3EoGlff4U4CHuKi4YnyhU8mvGMyoZEFk3CLPsHs7J0DiZ
	 1vCBQfqX43r0kfpxvi9vnP4zELyp3sAH0cirj69xyScowVoueCtggBZ6xekSsA3JRxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398223;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=8NN1KprR0LLS4vlFTVx1Ru5wkbwtSMmnxML2A6jvcNI=;
	b=eTYNuxo/X8Qqk6xwFXdrHlacG4+Ik53je00n4umOZAe5KI0Kh/FRdUBW4jOVeGfHYhis
	 taMnuDRs8np4vxFUpPkQTJ0mliS2N7BQBkuKZvOcV9rWH0NLiF2mRR+Lgt7jWeWmF40wr
	 aKyRVltAV5DYgZBZmfLhwuXCsmSgKhcNG3dDvKbeVbzWx+iad7XxjsbfdURLmO6dmRnkf
	 dr8yVBgV6qsv6w+N9CmyI0NG4aK2Egh+HAIAuGGeQuXuybY5GgJ/1H7BC019gJbLJFwWk
	 n+fXHHXlnuHzENC3x9Rdcv6s/MHayfc33puvkkPykkg2ZKzfd03KAVFOUbzyJP70nhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=O63vU7II;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BB606A324;
	Wed, 11 Nov 2026 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98BB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=O63vU7II
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794398222; x=1825934222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrQ+7PL5630ATgxoE7VYa6LeS6ariIsX+2lERifN+3g=;
  b=O63vU7IISIOToFapCwPSLKm+PwDwjBIX2acEIamfU2VLZDJgjmbcvTcI
   k9rKKr5o7EVHW/t58/Z4gwOhUtTYeKJVZOVgsMqEL0wM+yxUj3yAMJDGo
   /7bj1mVJm/osXi3jiWvvStYgLw92QHZ1yJ1XNTKhxdP0hOzlzD/rkMBbK
   aU0UyKv19WxXNRXbfzrXZlFw5LMys9HR5l3a+S23Hd5JyXcnMVfeLcGho
   dVogVYIKSo/DETDskaJHeC/cACXaQuyiAsZl8CKps5TUEvIj5jlM/vxUa
   u1d5btgss+MklnPhvuBWspqmRlmWnrSDVZ8fgVO6SKG6yjGT0k/hKIS9B
   A==;
X-CSE-ConnectionGUID: J1ON1wBiTg+9Ye8tNM2gdg==
X-CSE-MsgGUID: dtFGioayRR+RFPLNY8zzRA==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="65385220"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:57:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 04:57:01 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 04:56:52 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <enelsonmoore@gmail.com>, <aaro.koskinen@iki.fi>,
	<pengpeng@iscas.ac.cn>, <mathieu.dubois-briand@bootlin.com>,
	<gregkh@linuxfoundation.org>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v10 7/8] ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
Date: Wed, 11 Nov 2026 17:25:39 +0530
Message-ID: <7061a8e20a3755d233200441cfc68a2da7163999.1794391660.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794391660.git.manikandan.m@microchip.com>
References: <cover.1794391660.git.manikandan.m@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
index 6ce42a42a1bf..a4f55b2aa232 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -238,6 +238,17 @@ qspi1_flash: flash@0 {
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

