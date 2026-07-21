Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FC3EB7FB;
	Tue, 21 Jul 2026 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611786; cv=none; b=Fng5VvVwxJ2lNeV5E56QlPqXv4wgCBTxWOOk6PmBqGKM6fTKEczKteBCubd+aVRYTiODdJZHnMZ7rH+Qk2nHLeArFDc5zUimkN2B89NOXbReUh26q9umNrs+RiWL2WkgbDErZwHBq3+v2qzTITXb0QTGPolp7AjbMkUUfsf5+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611786; c=relaxed/simple;
	bh=ul2AN1PX1j52nJQ4/DQ2FY1Vi/Pv2UeQc6IZXxAKTuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOv5HdcZ3oOlPJK1QzPS/U6Lsom2r5H9z9nuN/u3yESZcdFKPOYRoz+eIxReLKfFlphk6krWlr12jK1zl2bbGSPu2KFRhbcBf0gV7f+LUEeNXq9Fts+NHq/5G397187ctFKY8fWlxCoL9zSh3QtV79l075blsvNdBXVGEMg2/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BRlpGFHF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BRlpGFHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784611788; x=1816147788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ul2AN1PX1j52nJQ4/DQ2FY1Vi/Pv2UeQc6IZXxAKTuY=;
  b=BRlpGFHFW3WZlT7CtDneVG2JMcAxxgvByNpE6bfNXeZe88UfBca22LBO
   jWbe7N6T6l+FsDDa6QyVgBoKUPOUZAM+WLPcaIjYNEwRrb4enyeZxbLpk
   LVfNnuSmRTyfQ9z6DIUR8C/nNRUx4ie5qt5EL5Qg85jOClGswlspEMv7g
   2973H0QeYrBJwIuaC2+RtLMGZucenWNCasLjnDCcGPm6r1u8iBorruy3X
   v1sc6xEQfxD60kNfdBIMZTJJDwrTHPZhJIEZuVBkwT9AfMHf3zKubr8V3
   ArknN8yJFCBSGrfJvIdIciZcznOiMWMzDDfflHq0kaaPx9gj8PH/5MzWc
   A==;
X-CSE-ConnectionGUID: 8/GfNbG4RQmG2SQoGKp6Fw==
X-CSE-MsgGUID: BcCpRDj3SWCx9ic29KVnqA==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="292305116"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 22:29:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 20 Jul 2026 22:29:43 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 20 Jul 2026 22:29:35 -0700
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
Subject: [PATCH v5 2/7] dt-bindings: nvmem: layouts: add Microchip/SST SFDP EUI layout
Date: Tue, 21 Jul 2026 10:58:54 +0530
Message-ID: <20260721052859.171341-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721052859.171341-1-manikandan.m@microchip.com>
References: <20260721052859.171341-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a binding for the NVMEM layout that exposes the factory-programmed
EUI-48 identifier from the Microchip/SST vendor-specific SFDP parameter
table (e.g. SST26VF064BEUI) as a "mac-address" NVMEM cell, and reference
it from nvmem-layout.yaml.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../layouts/microchip,sst26vf-sfdp-eui.yaml   | 60 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml b/Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
new file mode 100644
index 000000000000..37357efb7840
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of the Microchip/SST SFDP EUI-48 identifier
+
+maintainers:
+  - Manikandan Muralidharan <manikandan.m@microchip.com>
+
+description:
+  Some Microchip/SST serial flashes (for example the SST26VF064BEUI) are
+  factory programmed with a globally unique EUI-48 identifier stored in a
+  vendor-specific SFDP parameter table and permanently write-protected. This
+  layout locates that table and exposes the EUI-48 as an NVMEM cell so that,
+  for example, a network driver can use it as a MAC address. The location of
+  the data is discovered at runtime from the SFDP; no offset is encoded in the
+  device tree.
+
+select: false
+
+properties:
+  compatible:
+    const: microchip,sst26vf-sfdp-eui
+
+  mac-address:
+    type: object
+    description:
+      The factory-programmed EUI-48 identifier, usable as a MAC address.
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+
+            sfdp {
+                compatible = "jedec,sfdp";
+
+                nvmem-layout {
+                    compatible = "microchip,sst26vf-sfdp-eui";
+
+                    mac-address {
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 382507060651..e63b93083821 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -20,6 +20,7 @@ description: |
 oneOf:
   - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
+  - $ref: microchip,sst26vf-sfdp-eui.yaml
   - $ref: onie,tlv-layout.yaml
   - $ref: u-boot,env.yaml
 
-- 
2.43.0

