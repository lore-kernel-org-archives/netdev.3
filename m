Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B52242D84;
	Sat, 26 Sep 2026 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463685; cv=none; b=XW4fOXQgutI2Fm0CkCzaMRJh9K+cU35mC4m1sr6XDXU8djA1BW7WkGYjoHYBEPt0zXkue0koYgGeVoRvOznyPBOs+mtPNJap1aFp6W+aNepL5uYHI+eX0x3qcoihdtoV64QUH7NMB4sO79pUXgcGOltft6bikoon4xvZa4lzIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463685; c=relaxed/simple;
	bh=+as7B20QlN4tPkEqJia6UBef7h3LvyOllILsrRg6N1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef0auTIEiTM4Gk5UDwkxONS5koZTWWenwawglQ7xOhuctLF0l3GaTGSp/8qYH/yF8gXzVi7V+DLG9YYpR2LHzr4ST9kt/2gwOhr/NtDdPKmkcrHkjgMDnB9iEJ4Bropo6rlIFPmsYprJlp6R7AZWXbMkFnbobQ31PVSrbHugJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q65I0bhf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q65I0bhf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218CA1596;
	Sat, 26 Sep 2026 16:01:18 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52223F632;
	Sat, 26 Sep 2026 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790463681; bh=+as7B20QlN4tPkEqJia6UBef7h3LvyOllILsrRg6N1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q65I0bhfczdhoIlERyiZE2BvamtwIOgL7iyLu95uhxtBdXf3VbTrRoySo+aO+Z7AR
	 vLP8H8+qAZQbArHbtR72sDDlQcPn1EjsVwZv7P7swumCRAojrYpdpXwg0hwr4H7jxb
	 NHzaR/tGsEVfNWDd/eIjvi0FNb4FTkNYbWEaxc4w=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/5] dt-bindings: net: Add Maxio MAE0621A PHY
Date: Sun, 27 Sep 2026 00:56:21 +0200
Message-ID: <20260926225625.25969-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260926225625.25969-1-andre.przywara@arm.com>
References: <20260926225625.25969-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Changjie <liucj1228@outlook.com>

Document the MAE0621A PHY IDs (for the -Q2C and -Q3C variants) and their
optional 125 MHz CLKOUT setting. Boards which do not provide the property
retain the hardware strap or bootloader configuration.

Only the 125 MHz setting is exposed because it is the only setting
exercised on hardware.

Signed-off-by: Liu Changjie <liucj1228@outlook.com>
[Andre: Add PHY-ID for -Q2C variant]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/maxio,mae0621a.yaml          | 40 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml

diff --git a/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
new file mode 100644
index 0000000000000..c4d06c6261681
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/maxio,mae0621a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxio MAE0621A Ethernet PHY
+
+maintainers:
+  - Liu Changjie <liucj1228@outlook.com>
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id7b74.4411
+      - ethernet-phy-id7b74.4412
+
+  maxio,clk-out-frequency-hz:
+    description:
+      Selects a 125 MHz clock on the CLKOUT pin. If the property is absent,
+      the hardware strap or bootloader configuration is preserved.
+    const: 125000000
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id7b74.4412";
+            reg = <1>;
+            maxio,clk-out-frequency-hz = <125000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba20029693734..8ea4d421719b0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1035,6 +1035,8 @@ patternProperties:
     description: MaxBotix Inc.
   "^maxim,.*":
     description: Maxim Integrated Products
+  "^maxio,.*":
+    description: Maxio Technology (Hangzhou) Co., Ltd.
   "^maxlinear,.*":
     description: MaxLinear Inc.
   "^maxtor,.*":
-- 
2.46.4

