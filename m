Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E533D667F
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307351; cv=none; b=RY+rZyP6L5nDx+MzHJP0bh6aLKJzxZhbMllRnncyVpE4fn+ZlbGUqdz44vbX7MlvTQ1PnpM1OVt/YX89p6d8HFSq071pkCT79h052E9Vt3MPiz4GdvtiWZ7MbNnPsv++TfC/2CpqCkXPP79u38WLasAVs7KW2DZnbjUa1Kvw9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307351; c=relaxed/simple;
	bh=f16CR4wsF11AJHtigJu/UDcYZkiDz9qNNN8F9f7jf/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHZqzb3JNdA6o4jFUR0Pb8AFJtPeK2dVxkMDGz6Cvpc95h3MbT7cr8AXMjPIzjtc2LTvz0+nnuvmvk9K375nG67+XaFcV0p4qN5P6Zh0xSpyKQx2bLT7BVxzSE7jCxkvFbaQfkg7dWWNG4SZ4V1VSiG3diOPi07d3/txxxUWOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXtc1Yh7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXtc1Yh7"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-448de0cc236so724943fac.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307346; x=1786912146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4H5+HCVFStmSzg+aAxnJnPK9AusNX/B0D2xVSvE2xvw=;
        b=cXtc1Yh7QaF6Ne7a9nnCTZCxgkPxi21aLGeev/dqeKF9FxIePJgcCcNf+yYomelN1E
         10kpBR0mz01hyi1EnnB2uNNwtwwJmQAYGnOWhBA5Axb80E+C6KbmswLJ1wElwhFy1lbJ
         kYL+8g2SnAqXYs1MIZD+3mS2pbiaeGhTIryknVJlMDJXpIOpu0qUkUzUp8gc/4/tqE8g
         8dCNVvU+xGWMmf60er79UBej3F0+LyZpT6oqng2jbPWb+PGwlytGHIgtcBuhwcwlOTyq
         6MGffAZ7yR2ar+84GntAStxudcV2LQ+UoC/EtQvV2yroftZmkrs9yHLVkKaRV8jN3bFe
         QeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307346; x=1786912146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H5+HCVFStmSzg+aAxnJnPK9AusNX/B0D2xVSvE2xvw=;
        b=i5GYuMWyDtFvXZcMnjmTdsVnGT7d3axIEzjP6SZYbdaJrj2jvT6FsfYIEkOVoyZOrA
         L9Cm1vHhT4UtS2B4ZiCBCrExbJuQ9AfqF93733j/7mjMAHj2K+PWeREYQw3K6ZvitIzU
         J8Am6UChXzeBDDXZ8vDwrJEYjGVUugQ0Jyh8Q4bCVIPz6Flgtmq19N9bIZOrjA6xzye7
         yH1P3Rg36IShDJNdXBRHty77WOJpOCnBNiIYVGceK95DfjEu3fJ9eULTuEZaCXSQJbvq
         AqQPFxPhORrj7gQQwOzJSyEgfN1f/XefnMnc9z2R05iP0Pp7Y/CXrBgn640lN0k+zNBV
         wpoA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4iNu5tVFim8NzFznDXFI4vXpLR7GFdjLwuveeHJ6BumCiB68TjHfNJw4eQoHwAmDxaJt6zIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2j0I3+1GNdUR2ILfoWDN35wV7w6WLgbaQNJj88SyIj2jt1u6H
	0TYXq3+5xLRSt72KUE/sCRyiMFCmRGwSdJOE0sPhPYp6fJLZtz+vzRne
X-Gm-Gg: AR+sD13vrS33M90LvI7ucGAlL3M268Ct5eWWNEAdtZsh55kItkYTej8uP9KjRl5KjgS
	A/DrD35kW6UZMKC69FPghkiBJ7v4uwIA6NkT3eY8HrEh89OOnGyvZTR40ZLqmjN063RidgWm59b
	S5ee2ezEmr99zdmfEd8HWUPiwDiK7yHaz1ZuRUUxMW2YHxPVwR3x/TQl5VZfBNxmg8FoEq19jVJ
	i5xOyKmf54mMJWs2eXJflVFAL8OhSH/FsIMKfJWkHkHo5KEmmkSTwtfXuo3WHo+SAyrjPICSn3S
	Sm0JpXiowlYXHUKLEgDLr/hWqmzYvs3g6hXxczevPgocsHeCux5L1Morgj8rEWXrAdrXAfIffNc
	BWZr0P5o3SneEaSQ+JhaMeJQYX6lbvyd15fALswGxoIbBZWRgz2ukLdiUkdAf4l1vhwG1xQGr3O
	E5yUn/2e+iPV8YGF0teqL1uI8Nab54JVCh178rLymq9TkA3XIKEZQPivNGToU9pzBse8iuHCrv+
	LKrzWpXaJ+bJpzrnzP3ncu3IEYP0K8/gEXejQgq1A676Uy2rspDLHI5N9LWhTTYzIDaOkNbk638
	KxnwtVsIWT3pBJP0nJ+e1lRfu3nVK2tXT/n1/WzeYOItXFncN1BBgPAsZOtDJppm6inidCX9aUj
	0pIwJmOiSaCjMcOk4T76wekMKQd4=
X-Received: by 2002:a05:6871:79c:b0:451:ca3d:4b0d with SMTP id 586e51a60fabf-4599ebf1927mr18411696fac.9.1786307346168;
        Sun, 09 Aug 2026 13:29:06 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm6975362fac.1.2026.08.09.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:29:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 09 Aug 2026 14:28:34 -0600
Subject: [PATCH net-next v5 4/5] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY packages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-submit-acx00-of-dynamic-v1-v5-4-bfa1f8518b28@gmail.com>
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
In-Reply-To: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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
 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 207 +++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
new file mode 100644
index 000000000000..ae0c5e980c39
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
@@ -0,0 +1,207 @@
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
+  vcc-supply:
+    description:
+      3.3 V package supply. This is connected to EPHY_VCC on AC200 and VCC1
+      on AC300.
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
+  - vcc-supply
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
+            vcc-supply = <&reg_3v3>;
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
+            vcc-supply = <&reg_3v3>;
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
+            vcc-supply = <&reg_3v3>;
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

