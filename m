Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AC409121;
	Wed, 12 Aug 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531830; cv=none; b=VHtBRH+AGdaO6egY2OgekOkEx9Jyu8XjuzU0lklb7ihPtEekP7aOtdww4VFt6jCXMANgv4Z7clYwdPcruklbvGO+uIlFsbEGAfhHmdcTuyHurSHqNsYYW6qW0dRpsbZcjkBhHvxKy1QM10AcC3tpivJe7bBjtSS2F/57AAIYNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531830; c=relaxed/simple;
	bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1fz+4NOSr8MhtQLoFWZ0kkkn+VTnTD5307DdbIa5kno7OowNyW+xLixtA50k/3lr2zzuCKwlzTOsTL1XVXPJmCrF0WLBdV1J4b6LMpYYTRSGr2breMm4MfLvXlOqeXJ5Zzmd6JatJombEkleuKxntFKH1xAD1LmROFfGjkYQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TrB/xxCj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TrB/xxCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786531830; x=1818067830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
  b=TrB/xxCjeNJFLINMoUAn5LEVom0/oR6glULM56iIXTHSTfnB3+onNCMl
   7Ims7iF+DjWtGPLsIW6izC56bzJLXXytl+vX2BhVh8VZClDCBRxpdE/wU
   5wY/WJ/MI7g4AyLdqfokyCBZS5sfDktsQC2ojf1FmLX7yxPLEp08YRd7C
   pWS9ZNFT81mC7jJZIDqxqCaasY1yydl2Dp/avNN3pUzAUb+QsB0hvaV1q
   ICi2HiAukwbKTOwp2oC9sElQerLjZR0myexEd1timC/2dP4NJtXRBtJur
   p7dxuX3I0M5Tcn9vfNTzDHyEzXdzzeOeF6CwdfI2cc5ZxAGvOcCi5kT8l
   g==;
X-CSE-ConnectionGUID: DONMir8iQPOoqeFD/87JYg==
X-CSE-MsgGUID: gtfK8EHuRHatpaSlu7C0Lw==
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="293389497"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 03:50:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 12 Aug 2026 03:50:27 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 12 Aug 2026 03:50:17 -0700
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
Subject: [PATCH v7 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via NVMEM
Date: Wed, 12 Aug 2026 16:19:49 +0530
Message-ID: <20260812104955.485667-2-manikandan.m@microchip.com>
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

Add an optional "sfdp" child node (compatible "jedec,sfdp") that
describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../bindings/mtd/jedec,spi-nor.yaml           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 587af4968255..d7e659912b4a 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -103,6 +103,22 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  sfdp:
+    $ref: /schemas/nvmem/nvmem.yaml#
+    unevaluatedProperties: false
+    description:
+      The Serial Flash Discoverable Parameters (SFDP) tables exposed as a
+      read-only NVMEM device. This allows standard or vendor-specific SFDP
+      data (for example a factory-programmed EUI-48/EUI-64 identifier) to be
+      consumed through NVMEM cells.
+
+    properties:
+      compatible:
+        const: jedec,sfdp
+
+    required:
+      - compatible
+
 dependencies:
   spi-cpol: [ spi-cpha ]
   spi-cpha: [ spi-cpol ]
@@ -122,6 +138,10 @@ examples:
             spi-max-frequency = <40000000>;
             m25p,fast-read;
             reset-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+
+            sfdp {
+                compatible = "jedec,sfdp";
+            };
         };
     };
 ...
-- 
2.43.0

