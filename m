Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398167;
	b=uBMrkmh95LxsKn6uC2bb2dd8RMxTND3f74NLpBX9ip8wZ5uiWHST4S24iPtlZXQI+7kC
	 tvmKE+oFISWZEraAh+dK+KAEv0Q0xn7AwINo31jlbFEHkg3rBXkW+gMgHi7w2h6EC4DVe
	 BQEnmiTtnsY9z+yWTDnrz+jKnBOafRUwF/OUjYPiuRXO6kTMF7baa2ARbmAK4JIaSugEb
	 m//F5ofJV18et8peSePasWBpneQIdJvJHry72BwCXcWrXLfSEvDBFDqvKMltb9S+JFvqj
	 sKlQve+hUqpnrAs/gEQoav6OdkZ0oHanNdnRrIsqfs0r7K24SaM9GjhKKkA+Cn4mCzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398167;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=VBTF2W9pPzjw10zOzS7dHTxuRGxLvSu4sJjvOS08hm8=;
	b=3fWGKR0SQzZFMkf/EYnZ+aAxtnVRWjpSmadTSPe0l5pbmE8ZgEv1i07cr+VWG77yF0V2
	 imbO7hQIKDTgWWdWujfYmHiEhKaThF1ykFqUlg0riv9hJil76DweU5WPJkWrFZMogeO/k
	 uPDL1x6xmOqrHt9mJ3ZMZR+MX79YIPiBYZrWmmZxzTzn35w/Vifcd2HDPNFKidQ0xKHPm
	 YZKrrftRGUTOr/Mnx8x2VU2vuLqPItWL9WErKLMKQNCrojPlfD+/DGyWrF7UJXQh0qU1k
	 UwbuQ+SS7ITf0tnqJC6q4bWhVrp4khIl88tRXW7ZHQJ4gsPQcbN8xreZb9pO792SH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aHMpbT1o;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905D606A33C;
	Wed, 11 Nov 2026 11:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C905D606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aHMpbT1o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794398166; x=1825934166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
  b=aHMpbT1oivdFJhUgu5/QQq4764JNOmIpKGiANqTL8GCsUREldO5Ezjuy
   PH7e+x8o6FwAypw1R85ffzmIXR7cIkiqJguljkgCAXxjzr9fnK8dG+Dej
   dU21zEWQaVTwT1yAqzBgCZb4hKGyy9/4R25YxVL/woiFJSlA3ES/xhf5B
   rspS4nYzhj28XAg7109gq19cvAqCfgzh2q9seQCgq8xMLEdg+dvyxXBM/
   NC2VwUFIr6GnbLnuKOKOMTye6X6eXxIUioj4icYPMTY2v4mBZo54+J8Gz
   ppw5qoMIaOh1aB9EkFpgipZOHGRMate7XgOMG72sre5NTnGvyqcGVfa/B
   Q==;
X-CSE-ConnectionGUID: T894UqdwStqWKRR5NpsBxg==
X-CSE-MsgGUID: fwgcWE15SYSr+8otYHSWug==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="65385193"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:56:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 04:56:05 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 04:55:56 -0700
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
Subject: [PATCH v10 1/8] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via NVMEM
Date: Wed, 11 Nov 2026 17:25:33 +0530
Message-ID: <a16525fd3c28c4d41d1840a0a875f0471e242af2.1794391660.git.manikandan.m@microchip.com>
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

