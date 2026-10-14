Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385C446075;
	Wed, 14 Oct 2026 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960056; cv=none; b=pibHTSAXJm2/mbJi5JAcUG0KxU61IMlCRZDy/U0y+DfvkxluEhsMCUQ3s8/weW4ZdZ6JpaudNb1shVZVvmFs6ZF6689Vqtb/ParGVIg1zyAm4g5o+xZiboKyFxYeXrYzFhcI8ijVuymm90nNR2bEWn78LBXqg5K71d9bZQckMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960056; c=relaxed/simple;
	bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHFV60Gr9mPAPhsDfRWFNiEV+2SOU3IoibM9lTVkC/uAnuIo/vdZTWqkYhIknbRAqHoPUW2284JAWon/3C9iuqQV26/eMgXwWw0tIg0f83TkPZQ7Qr99MI6jg4RB3v9SB/VznF7qt7xQ3cay7q8Gs2Z4qZpp9KLldixEHFNSas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s3BHK+Il; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s3BHK+Il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791960056; x=1823496056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbNAFzSIw3R2cm7Wm2v5oyHJUBSuXKlXSqen3A0swWY=;
  b=s3BHK+IlyRjx1DSJiZ1fT43Ux8Exe4rYkEon+IynJGTYM9acFlg002Uc
   s4oZuMtDnRdXBO2M4zbjREj+YT8E7QrM3ZEd1H7tpN4Bb+mgLmct//SD9
   IGkIvxORVNKvS2KObEYLHAZh2RFkKQPldl+RcdnDnUCgev+BYKw945wQZ
   NIu6pRuP1fRKkT3c/1cbzR1Pdu/HrFnsdO0drAJFtuG89KVKDdcguE58s
   X+CFc3YU5j8lbtB1+VZC+4J6GpFpT/MJydurzzqOyx9HMXIbC6iejOeKD
   li3dvDHNQwyx7vsMMuEEORF98QL0ALmsz61H16wBqn/2GOilPuk7h1pi4
   g==;
X-CSE-ConnectionGUID: TZLC4ChDRUufmJ6IJQ4o5A==
X-CSE-MsgGUID: vTz0chRfTEm9rZ9FTLs9hg==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="75382494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 23:40:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 23:40:53 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 23:40:44 -0700
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
Subject: [PATCH v8 1/8] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via NVMEM
Date: Wed, 14 Oct 2026 12:10:05 +0530
Message-ID: <61838998ad9c0ca2da43dbc176ec2cc6a92a9305.1790847519.git.manikandan.m@microchip.com>
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

