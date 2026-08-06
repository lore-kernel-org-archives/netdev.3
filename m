Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370A3B19B4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979481; cv=none; b=PRUHK3BOhdY4oJxwc0G6hi8wXuNmTrx0lBpPXeBR0/Gz4y6E/C4A9ntscuJESMSxJzu5S5UUlJK3gsV9bOJDhBDta0qeLOkoR2VsOh+T8DJsu67lfVh7BGEQlYBkms3GVeLlqKcNWKIE6jDaVaZld+jIB6/DbWfcSE7Qc10YAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979481; c=relaxed/simple;
	bh=PQrmptIkB9+FHFCt7654nCnkDwp4ijPJju9VLqHK+oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkjQraLORef8FfpjgqUzkjqKVb7Ix0AVN4CtRR6eCuooCOL42BSH/1nHG1rFxhmZVJW6ZDUjyd3upeZX8FDa55ARK/W8M4+leL/rD51rCgbLIcNUa3ZlHIyWYPPhboz6/0hSweqD1EYNnUcp9lYMcXmK/yUq+BCTPJf6taZTKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8R88MO0; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8R88MO0"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a40bcc8d69so1074844b6e.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979473; x=1786584273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKnDaJp5ZviVMN/jgF3Auq00JWcI1+Cd7CJPkOYq6WA=;
        b=L8R88MO09mNpRxE1PmKKZVEvOE6yOAj93jwqHLigL+t0Cyymydg8nihD5WqMDNORkn
         AbBtWxb6ocMkvmZTp/FhgNA3aQRSOjWsPrKaH1uofmzrhsih1Y/ijnXCKzuFKj8X0b5y
         QhDsx+ECuI35a6g2YeVt7dIe6bqaEm0LYXK35cPBVNBuLn4W8Ck5/PE4R6CudDxL1ksD
         UF2HFZpegoCz3kYS0VhIUvXxOwfxgWF7nyOAigDs8ueDIGyDP3PGenHq6wA7vtzG4xbd
         aCpx6dwMTqAfH3EK2YSaPqRwRRoTNW1zhaxzOtS/k4kIeXz0KuP/kxeLgq6gIJ85fIWh
         66gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979473; x=1786584273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKnDaJp5ZviVMN/jgF3Auq00JWcI1+Cd7CJPkOYq6WA=;
        b=p+nwy+6wX7JnjopEJETVbjPz4pAhWE/SC+YLF0Vbzb0GgCylsWRkEJr9A7ntcXWgwh
         IoB1l1kxA4/zEO8I6XUxB4nQtLNI8PAphSzoyV2wWw+zcZ85a2xVaNjsUUxKnZfEshIG
         XKUHzqx1pspWV9eR9KJb1C+C88GAIsKzw5ya1ByRZR49mKKwd612hhedM5vItWNpTeoj
         XXAQ6Qs/Z+V6GNNt0R75xytlfWO0oBzMSd9oh8gEqJd7ThSdPTzejWX1SAsOFz3bletN
         WratpEJqBbx5HyGXaWFt8ZCvPLQlB/S1ZRn6gnZrtOx6n6TcUoh5tYQZEJ9cur7NW6of
         o2xQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzF7lJMXOcsZnleQcFuAQY6t6PeXT8km58zV59QviUELG9v1FMboz4UO1Cf4siPN/zvOUJVpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPqWMkTI5mRiTHHAOQZh8LNuvmKH/JQaY/afBMAZovSyQamuP
	dmik2cShGvJpLEj3/Ymhvau4BNqs85FmxFUVpAMnMoAtRfC94UPaf40m
X-Gm-Gg: AR+sD124zHUeiGxYxLGguCxQ9qStz28cFLtTaXZnnH86P+g5d+tTcZRUCMDLZ6vLgdQ
	GDclcAdx/8rFEjjDFW3ddqus+YPd8Yq1a7fa9+LZ2PepG1sBq26JjyEMf5MOgJ2gkL2Tnl0AoV7
	wGzwne/uf8R3UX2C/0KhTYYiBYp4YhfDDCj87rntpSPr8amCTlUCp4ozTTFBzK4Bp3tJcMRy9h9
	Ga7M6OChZPu0ZmwmWoHI8DlExydeIeDlsb7Av8754oT7vqA8c490JB91sAShSyfFMeAK3BKlk6u
	XIdeyNvvQflgDFys1RlJQBXvTb/qJ8ZH3SxsWKn160wb3w7FisblPfzI8smx4upXprDhpxHqjqS
	XYrexfHpLKw3lz42EdE7koTOTKbAAMAPruT7G7ygXo/IOSo4ZukFbcUE84qo3D4CjV7XPmDpmFA
	vA3sNu7UA3aUY6pNIMGGBpPlAeiBNerfhFfh8EnPSvJoit/Lax4KSvty/3iA8uuQWJT8nI4cP7N
	UFrGppFT8Vj5h3ci1CsLAXvalCdaJptriqLF8DI3AEmsrqyqDBSQTnjXbI9h7SOveWtiYr7EdRm
	i+zp0xSVbS0CiEvx60h1om+IZwXmG0Wc2pmH4+1EsyJTmBvqfzO88H92VmhXG5l+IUcVxT0UI8A
	XTTYjxh2t73PyMTCG
X-Received: by 2002:a05:6808:3448:b0:49b:c387:36b6 with SMTP id 5614622812f47-4afadf347f5mr6042021b6e.13.1785979473435;
        Wed, 05 Aug 2026 18:24:33 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae75db20sm3274755b6e.14.2026.08.05.18.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:24:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 05 Aug 2026 19:24:20 -0600
Subject: [PATCH net-next v3 3/4] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY packages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-submit-acx00-of-dynamic-v1-v3-3-32c3210a6f25@gmail.com>
References: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
In-Reply-To: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2

The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
report the same Clause 22 identifier and use the same link-side register
layout. Their package control paths differ: AC200 uses registers in its
I2C MFD, while the AC300 control range is at a second Clause 22 address
fixed at 16 plus the link address.

Describe both variants as Ethernet PHY packages. The package reg value is
the link PHY base address and the child supplies the documented PHY ID,
because the identification registers cannot be read until package setup
has completed. The AC300 driver reaches its control range with the PHY
package offset helpers. The AC200 package instead references its MFD.

Give fixed hardware variant-specific compatibles. Also provide an ACx00
compatible for systems which can contain either package, with one packed
NVMEM field containing calibration in bits 3 through 0, the AC300 selector
in bit 8 and its low-calibration selector in bit 9. Such a description
contains the potential resources for both backends; the driver consumes
only those selected by the configuration field.

Describe the package clock, supply and optional xMII receive-clock
inversion needed by some integrations. A fixed AC200 package may omit the
NVMEM field and use its internal calibration copy. Limit AC300-capable link
addresses to 0 through 7 so the control address remains in the documented
range 16 through 23.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 208 +++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
new file mode 100644
index 000000000000..22bddc7a2f94
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/x-powers,acx00-ephy-package.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 and AC300 Ethernet PHY packages
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 and AC300 contain compatible Fast Ethernet PHY blocks which report
+  the same Clause 22 PHY ID and use the same link-side register layout. The
+  package control paths differ. AC200 control registers are part of an I2C MFD,
+  while AC300 control registers occupy a second Clause 22 address fixed at 16
+  plus the link PHY address.
+
+  Systems with a known package use the corresponding AC200 or AC300 compatible.
+  Systems which can contain either package use the ACx00 compatible and a
+  packed NVMEM configuration field to select the backend at runtime.
+
+  The link PHY cannot report its ID until the package control sequence has
+  completed, so its child node supplies the documented PHY ID. The package and
+  child use the same base address. The AC200 driver programs that address into
+  the package, while the AC300 driver derives its control address from it.
+
+select:
+  properties:
+    compatible:
+      enum:
+        - x-powers,ac200-ephy-package
+        - x-powers,ac300-ephy-package
+        - x-powers,acx00-ephy-package
+  required:
+    - compatible
+
+properties:
+  compatible:
+    enum:
+      - x-powers,ac200-ephy-package
+      - x-powers,ac300-ephy-package
+      - x-powers,acx00-ephy-package
+
+  reg:
+    maximum: 31
+
+  clocks:
+    maxItems: 1
+    description:
+      AC300 input clock, running at 24, 25, or 27 MHz. The AC200 input clock
+      belongs to the referenced AC200 MFD instead.
+
+  vcc1-supply:
+    description:
+      3.3 V supply for the AC300 I/O, bandgap, Ethernet PHY analog front end,
+      and internal digital LDO
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Packed EPHY configuration field. Bits 3 through 0 contain the analog
+      calibration code, bits 7 through 4 are reserved, bit 8 selects AC300
+      when set and AC200 when clear, and bit 9 requests the AC300
+      low-calibration tuning sequence. A fixed AC200 package may provide only
+      the low calibration bits or omit the cell and use its internal eFuse
+      copy instead.
+
+  nvmem-cell-names:
+    const: configuration
+
+  x-powers,ac200:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AC200 MFD containing this Ethernet PHY
+
+  x-powers,xmii-rx-clock-inverted:
+    type: boolean
+    description:
+      Invert the xMII receive clock inside the PHY. This is required by some
+      SoC integrations, including the Allwinner H6 AC200 connection.
+
+patternProperties:
+  ^ethernet-phy@[a-f0-9]+$:
+    $ref: ethernet-phy.yaml#
+    properties:
+      compatible:
+        const: ethernet-phy-id0044.1400
+    required:
+      - compatible
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+  nvmem-cell-names: [ nvmem-cells ]
+
+allOf:
+  - $ref: ethernet-phy-package.yaml#
+  - if:
+      properties:
+        compatible:
+          const: x-powers,ac200-ephy-package
+    then:
+      properties:
+        clocks: false
+        vcc1-supply: false
+      required:
+        - x-powers,ac200
+  - if:
+      properties:
+        compatible:
+          const: x-powers,ac300-ephy-package
+    then:
+      properties:
+        reg:
+          maximum: 7
+        x-powers,ac200: false
+      required:
+        - clocks
+        - vcc1-supply
+        - nvmem-cells
+        - nvmem-cell-names
+  - if:
+      properties:
+        compatible:
+          const: x-powers,acx00-ephy-package
+    then:
+      properties:
+        reg:
+          maximum: 7
+      required:
+        - clocks
+        - vcc1-supply
+        - nvmem-cells
+        - nvmem-cell-names
+        - x-powers,ac200
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@0 {
+            compatible = "x-powers,acx00-ephy-package";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&pwm 5>;
+            vcc1-supply = <&reg_3v3>;
+            nvmem-cells = <&ephy_configuration>;
+            nvmem-cell-names = "configuration";
+            x-powers,ac200 = <&ac200>;
+
+            ethernet-phy@0 {
+                compatible = "ethernet-phy-id0044.1400";
+                reg = <0>;
+            };
+        };
+    };
+
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@0 {
+            compatible = "x-powers,ac300-ephy-package";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&pwm 5>;
+            vcc1-supply = <&reg_3v3>;
+            nvmem-cells = <&ephy_configuration>;
+            nvmem-cell-names = "configuration";
+
+            ethernet-phy@0 {
+                compatible = "ethernet-phy-id0044.1400";
+                reg = <0>;
+            };
+        };
+    };
+
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@1 {
+            compatible = "x-powers,ac200-ephy-package";
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            x-powers,ac200 = <&ac200>;
+            nvmem-cells = <&ephy_configuration>;
+            nvmem-cell-names = "configuration";
+
+            ethernet-phy@1 {
+                compatible = "ethernet-phy-id0044.1400";
+                reg = <1>;
+            };
+        };
+    };
+...

-- 
2.53.0

