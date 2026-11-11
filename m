Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398177;
	b=Mky8By+nW070jD4CpbJjiOUZ6MU6CN2jjYZxod3uhNYgLCwagVSzLa99aZXdONl+HyfL
	 9IjoznURoWpmugNNgvj7zSShIhMupvaNtrUbbukqjj3UznNGysr97FFm2AottQb1pYmo1
	 d//x/yWoqlXZu19XSbkvfP+zQPQ2qGzDRotDWy3tjrEgYyK1OxjA0ONLuQHme9uLNGXIy
	 9Fo1clUm6lY4EtwUwY6YC3mRZtIPSNlKHbgsrmGz2R4bmVXF/pZLIHAHezxo9AQ7XvZrk
	 ZW+PqWLnEZuGKyT6qLR2VWBx/5XqK/HG45fyG69BhXo/P40GilW2s7lJ5Hk4w8PJsFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398177;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=93jM+J+lP3mtxvwi0EkvYqkk7JnNKj4lbENkiARVaow=;
	b=2SzfTn3YzOzoe8zCiu2hqTCTJEWTTPy+vpzfpE8iOZS8NbvyZoWfC97NDoBGNXid4If3
	 lcFFq3N1Eh180qrLXByQaqjUY2pJtlK3E+d40OVwA+1Q6u5V/VEA6JEst2S3pqXrcjgmF
	 f2ZnhOXfac+uiNMl7oMxF/akD4ee72vDK6+hyaUXEInRoC4Er9+55YJgZCN4ykngYh46N
	 PkZWa7AZhIzT/oD94/UhAi/A2doHR6x8Gr1eZv3fPeZZVgeeqqyQzzj2qFpViVKoK3vPK
	 X/Lh17zC2fYxlNEGBVTridPSpJSIdNBy/3bVbzziXbojyVIVcf01kZXaypZdlmieIJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=DTNLBIhm;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09474606A327;
	Wed, 11 Nov 2026 11:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09474606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=DTNLBIhm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794398184; x=1825934184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9sspgSaYTLzPxx3ClMpy7dqKoUQ+jVKhLBbkq1ajX5A=;
  b=DTNLBIhmvDt2lj5GWGIaj5Fh6xOcisUfmteDF11bM4Jsg5uj5V9ln5CD
   7AJH1dVEp9TRjC3qefSl4C/jmwwfq0nS6ca7pporWO7T4+nHHrdM2bFDb
   LqxqwSZtsrS8RJDzBHeWGqdfAKMQEI+TMiuebPtqVsAxCSC6MEr/1Gk7n
   sh4CKbw9NWCkzSqTy8cQq2d2lFMsvDD9Woj5sjfRV8sV4n80luzf2XlZv
   FS7I0PoDwKIqRHzngJajjZOGgIbscU3G7iKPjmEr715hi57KEQLpyWwgc
   dm9romNt0bVbey40C+3TlCwoCc5fnC4pGozFks2oW+xBbSXx2z6KgHVSA
   A==;
X-CSE-ConnectionGUID: AyYEieVYTtq88gg6XxZzgA==
X-CSE-MsgGUID: yVcKmPtNQpOIL2fr02UaxA==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="66350164"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:56:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 04:56:15 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 04:56:06 -0700
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
Subject: [PATCH v10 2/8] dt-bindings: nvmem: layouts: add Microchip/SST SFDP EUI layout
Date: Wed, 11 Nov 2026 17:25:34 +0530
Message-ID: <ec17ff65fda01b2aa38cfe28b0158acd871b060b.1794391660.git.manikandan.m@microchip.com>
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

Add a binding for the NVMEM layout that exposes the factory-programmed
EUI-48 identifier from the Microchip/SST vendor-specific SFDP parameter
table (e.g. SST26VF064BEUI) as a "mac-address" NVMEM cell, and reference
it from nvmem-layout.yaml.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

