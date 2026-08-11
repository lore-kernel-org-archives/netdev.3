Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259641A792
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437444; cv=none; b=Hn+raQVdMDLkjXlr2LRu93DBCBo7I9EiZ1p0J6M5JmzZben6cAu87Gmr75Wh46h9dchYgM0BJTUQXIUxsONhnjil91JCZHuV9ylz3O2KwUe9pSVxp4jKmeWhaxYwaahkPC+iCV6glkSiyBuQznOykWr0YksR8iN10jMdhJpVV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437444; c=relaxed/simple;
	bh=GK/B8pOwlGpt6eA1invozWkbmKYokLi7estcfj50KjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lwl7dfGH5S6lE0ooq9kmCpJ295fH+KQeOq/L9q05UxDIlA6jcaRcqKajIpBDDgYZ72sx1mu1+WL73xiSQiTB+taITXBlMP/NQ1GfGkbQAEAByM/Cjxz+OnPQNQlAli3hGcKhRlvPSa553X7RLX8vObW6krCdOLLW8nzVmPVUuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex+xEeq8; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex+xEeq8"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4518ad44e83so1699554fac.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437441; x=1787042241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63zdf5RPhbrqfdDiAyDgjJa82jjDKftBr7Y+b2RfV+E=;
        b=ex+xEeq8qHKU58aJ+4k2nxsrT6j1zVQObwYe9tYKnI1Mn68S5c1R6d5Jjpu6yVVLGa
         ida62WZrQeVE9aXhc0qf48yfAscUMHdNiFPKBJP4838pUOxexJAoYjZAC8vt/lbnTj/y
         +yCbCXIRgz/sUPeHD7hxfwwXLap1OdcZIG2ipIg8nByxiyf22zZRFJCmI2CYEkNO40Zf
         G81QiV78XYRcntIwERTyQPwLjwezJNYvDnWMPK3FBNWJSuR4R7C5mFEqJNLVPqdIAFgO
         g6CEKaEy528bI5jS75m06tJFDDUwiDCl8sDVEdYbYgYdt+4kaj7jue4pfKyKTDDPDZuT
         Umxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437441; x=1787042241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63zdf5RPhbrqfdDiAyDgjJa82jjDKftBr7Y+b2RfV+E=;
        b=pT977+Y8YaB+WzBfLYyQ5sjO5/dPNplpKSvC9z+RfCTuYO0b06sqEHqO62AEK/iKeq
         ei3CeTQ0tAS8a1Fk3C9ZZXTuKQoWy4HqFlbbzkffrs81q2bRJjhJhuX81SLu5rEjh5yr
         ZVmjNf9Rb3fe4G3DVknZ0H9S/i4YTs2PuRMfQX2dd/l9ICYDLcKQyWM9B2NQnd4ZLfod
         v8apbTVAKWPH3vaaCwltCMM4hhZpDZ1219uqOOe6+Vo0S2PMORa4sJpFYtRoAJJ/06yb
         ljyQzGKWggj105y9u1Qr4NTZpNb655qvRcJvJaVGE7DigjHDtoLc5mdtO55nH/NosrA5
         5fuQ==
X-Gm-Message-State: AOJu0YxBbxJFH0/lvIml7m87u9cQrdI9w9SAZUGQopEI+eVxHON/VO+h
	fbaJFw3GNvbynwmd5Ehe8Umcj6owtzPtFZ3/9K2c6AyTCw+f1DeIC/Yu
X-Gm-Gg: AR+sD12Ad3BEHRp0nRBVReqiZ9xE2Px2Z6XKJT7OGZUbRyu/V1cNYoElSrfak/QrhAj
	8jDIv6e7moycF52W5WDqbAXm9Xbq4vLQwlWbjRYPYVRNjV7aqCi1/YS0L7L7mi1BLFp8WKl0uMh
	O8LNu4vssT6bjqJStdsTmPZqFHx0pSu6ZXGh9a1347BL1UCpil2lMRp4A2Edf/b26pCRinqDRrl
	/AOVFplODhH0CZ6HjjJ8hLZOPB/isY11AnStBG66cdlJsfARzBmVaeOz0LN/QDmzkHBk8gr4GzY
	VTeFaR2ifvkk8WijHaw8r5oP3PZs1dZCwcCR3JAu8zrL8qMpVn6bmS02SiWGblVjOb9CmYcMF3R
	silJirBrrcYmEJA3+SIkz5HphFxL4D7cnZMC/7MeOsXiJQkMp3nwofJ8weFJXq9WKkrL1BauXmG
	ug9NY90l93ZzeQVaPpBIrkASxfBYMhcgKyhMNFvr99HBHRrezrYRY0DjyYYWuOJP3sFH3xm7K+v
	CztKIEN87Ar0wL+QG924yvRGtChGINTVyCDspAagsX0tGVPUE/VJRfQzQLuh3HiT0Nxs9bWQYyT
	HcL5Mrhc6UiOxImf0XgWrlFeFEVisRbIjMHUhd5cCA+k4ESxUEhz7/QtWWLogkyPxMZeOA7ikH9
	CcOaTxH/Yd4M7YKc6h8DKTvfLxLU=
X-Received: by 2002:a05:6870:9e8b:b0:456:c9f7:787c with SMTP id 586e51a60fabf-45e2165a289mr918884fac.17.1786437441009;
        Tue, 11 Aug 2026 01:37:21 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e1d8393e0sm738613fac.12.2026.08.11.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:37:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 11 Aug 2026 02:37:06 -0600
Subject: [PATCH net-next v6 1/2] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY packages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-submit-acx00-of-dynamic-v1-v6-1-0229b99a32f6@gmail.com>
References: <20260811-submit-acx00-of-dynamic-v1-v6-0-0229b99a32f6@gmail.com>
In-Reply-To: <20260811-submit-acx00-of-dynamic-v1-v6-0-0229b99a32f6@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
report the same Clause 22 identifier and use the same link-side register
layout. Their package control paths differ: AC200 control registers are
accessed through the I2C register interface of the companion IC, while
the AC300 control range is at a second Clause 22 address fixed at 16 plus
the link address.

Describe both variants as Ethernet PHY packages. The package reg value is
the link PHY base address and the child supplies the documented PHY ID,
because the identification registers cannot be read until package setup
has completed. The AC300 driver reaches its control range with the PHY
package offset helpers. The AC200 package instead references the
companion IC whose I2C interface provides access to the package controls.

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
 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 154 +++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
new file mode 100644
index 000000000000..afe57bd163dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
@@ -0,0 +1,154 @@
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
+  package control paths differ. AC200 package control registers are accessed
+  through the companion IC's I2C register interface, while AC300 control
+  registers occupy a second Clause 22 address fixed at 16 plus the link PHY
+  address.
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
+    description: AC300 input clock, running at 24, 25, or 27 MHz
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
+    description:
+      Phandle to the AC200 companion IC providing I2C access to the package
+      control registers used to power and configure the Ethernet PHY.
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
+...

-- 
2.53.0

