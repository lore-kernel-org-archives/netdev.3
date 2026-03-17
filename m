Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682381519B4;
	Tue, 17 Mar 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773237; cv=none; b=c8UZR8RfUTGQkSFCD9lhNjK5tllcBm1X1TiUAhnZtOjptAWZg/9wzIhT3iZlH9n3b5O748aYTekI62PZuOsrvUaJPvmJwPunmXBcPmnGAoD25djt4XTclwPC4bMODYpR1K1uuT3nyfAC6C+ZjsKt4i47EcgnhAkVjGKcJsbjDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773237; c=relaxed/simple;
	bh=CqWV1M3Z7tlt5lmqpc6dFtALph+6wv1R9tic9kEpMCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3vz8uLdEjTwCiZ7x2mBb/bNl7qMV2f7bZ3K1NBU9E5IE17PtV0XK//Eq5Rf7yqVcktPBOl/1hvRYL6nnFjpaqiDM/Dtj3Quyj0ZxurE6f5Z3lWDORSeneSzDjjdAPC0qagVdKgiW1HfQeC7DyqGUSRNHwx6vElKE7FLYS2duAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zc76JUbG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zc76JUbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773773236; x=1805309236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqWV1M3Z7tlt5lmqpc6dFtALph+6wv1R9tic9kEpMCw=;
  b=zc76JUbG4DUUYHEfEj6iehXOmkKq+jqKPFX6cPTzzaQG90qQJn9ceGRu
   xBO6ohylR8KzOwb5ArvSldrU7eLVv+wdmACDgUU3Nru0zGdlSVLOiUTDR
   KJurWHCAI21RSOqx9BfGO1J5XC5CCHTkTOXaJoCd35sdEj3zcYJyb3tqX
   hcNaapbK9t4kEC2cbYIm6Gj1nsPX6EqBy8yG6+fwWcVct7+zm7aOHMRIs
   flCP3jw49RLcwyoHa0bxxngW3SFoPc3sJ1Ph0+CgP5zVP5XiAnNi3Kjws
   r+Aca2K1qlmMpQ3vqktsJrc/8rE0QnU0Ybnld2diKn/M4Fml2sh8QnrlR
   Q==;
X-CSE-ConnectionGUID: wahvWo40QRmVOyIEFQPcXQ==
X-CSE-MsgGUID: NlvPBpvzQW2p+IYSJnx22w==
X-IronPort-AV: E=Sophos;i="6.23,126,1770620400"; 
   d="scan'208";a="222060300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:47:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Mar 2026 11:46:44 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 17 Mar 2026 11:46:43 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
Date: Tue, 17 Mar 2026 11:46:09 -0700
Message-ID: <20260317184610.315852-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317184610.315852-1-charles.perry@microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This MDIO hardware is based on a Microsemi design supported in Linux by
mdio-mscc-miim.c. However, The register interface is completely different
with pic64hpsc, hence the need for separate documentation.

The hardware supports C22 and C45.

The documentation recommends an input clock of 156.25MHz and a prescaler
of 39, which yields an MDIO clock of 1.95MHz.

The hardware supports an interrupt pin to signal transaction completion
which is not strictly needed as the software can also poll a "TRIGGER"
bit for this.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 .../net/microchip,pic64hpsc-mdio.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
new file mode 100644
index 000000000000..21c76199c11b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,pic64hpsc-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC64-HPSC/HX MDIO controller
+
+maintainers:
+  - Charles Perry <charles.perry@microchip.com>
+
+description: |
+  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO bus
+  controller supports C22 and C45 register access. It is named "MDIO Initiator"
+  in the documentation.
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: microchip,pic64hpsc-mdio
+      - items:
+          - const: microchip,pic64hx-mdio
+          - const: microchip,pic64hpsc-mdio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mdio@4000C21E000 {
+            compatible = "microchip,pic64hpsc-mdio";
+            reg = <0x400 0x0C21E000 0x0 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
-- 
2.47.3

