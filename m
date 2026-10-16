Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F924746B7;
	Fri, 16 Oct 2026 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147154; cv=none; b=XkNCkvCfBPWZ0l3uF69lz6Vi7w2oPQCH5tCmvYVR6tFvcU9dvZ7ZBokOfYaVKYBNmzdrzEP1KhJb7yaJ+gD45+sYFBtgdhlFBI7/KH7wHZJQWswzB1ACr4oHZv2s6O4v3nHp3ni46WSxXvoau3fGNhljsrwTFBtuawb2tYEaC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147154; c=relaxed/simple;
	bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oswfTk8B+1EWSlySxepNZr7dM1SWu7UTZgmPWRCTYZTY10DqoGqmre+UF4Ggn+/BmsNGvKd99/rJmUNlfbULY1jMI+fV6/LRcsmSf2mpDdaIJqqttYQiCAkL7a3UEuJxUbeXi+X2QIvFCs1OPrgngdD3hLct3/sJj237XDotkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RXxwf6FJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RXxwf6FJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792147149; x=1823683149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
  b=RXxwf6FJqDt1FeJ+MTUDPT5vieMFlhe9xpP6/lTzgyMaXr0X2ZkQA2x1
   BEFVKnKwptj5dLMvio1N0iB0p+FXGB2HwksJmWCBg3RY9FWYBChn+dGg+
   H+0FhEEZBFX2aS/rmUHRnc7WhQtnwnLHyS8wY1HDQpUZ4jG1yYMbl2vID
   bQJP4XIbI2r5RQNYwFJC4xlHsoHaKpqIWt4gvPe3gQ+R8CzREC1DJEQX5
   x2w4VxglBJTauhPLgLg8QSxvk2GOz0PWwKIvckfn7f6no6eiBMcCZcN5C
   VUOfbnk/wM4Lm9rkuKqyE6CgApZCPdjTHuGPvqT1ZH/wWwoLJ3IMuNJ9w
   w==;
X-CSE-ConnectionGUID: OsHIr860RCG/N1zJJJeQmg==
X-CSE-MsgGUID: Bpp0WqZMS2G8E90EKdEMCg==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="64191080"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 03:39:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 03:39:08 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 03:38:59 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <pengpeng@iscas.ac.cn>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v9 1/8] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via NVMEM
Date: Fri, 16 Oct 2026 16:08:29 +0530
Message-ID: <a7ae73e69f1f64503d4be4718fda370c436fa781.1792145382.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792145382.git.manikandan.m@microchip.com>
References: <cover.1792145382.git.manikandan.m@microchip.com>
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

