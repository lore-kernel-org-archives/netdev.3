Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37E377A92
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756487; cv=none; b=u7mcdeHXKdQ20i7Q/jZeoxRQKHch5zOWrPSwH8rtolS/yehl4YKQW9gJZ8TrGRJcYkQDT3iPGlP+Xt/oxHtDck+SRnPQFCu1U4qHAqfJr4+3TyJyy79EuLcAtNpbBYbfTlwdwD0MmYnURpzkKZ37AJOGxcVNQKj2wohPQdCb/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756487; c=relaxed/simple;
	bh=cc+qS80i91e3iF+LZeQguwZtW8X1bfrYw7jNSRlkhpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QN/DoLogYS4jQeku7+JmB8XF8/SPZ8JXn1StZO936FkOMLOPXtLJGRSTXOQ5v2nOoJcg2cMKiZnOtmKohpj+gMF/Ym85ksWrkwmNUp05a5mh1/peqkyT0XLOD+HGeRIsgrHpRrV3VgZlI9JEKr7sxNPhwRx4+ceQBNSi00nrXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puHFnV0+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puHFnV0+"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4563ac048f4so3204978fac.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756484; x=1789361284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K28+i2/PlfR+JETeUlifhNXKb2RdSy48tKswPz635Jk=;
        b=puHFnV0+qI+mQr4N7zfby2bstPgDk+tgxM7WvzKeAqWskF9I/6Ga1YmbYbnGe5X7BQ
         zLTJKdju0/FysXlJyTayWkGpiUuG99dIViefkJq47/62t3uuBwdGNZLgcft92krQ55Jp
         cHj7NQoURE0/PEmx8P6c5o3ltDfboVgi4pXPS8VLzEaNhm+Fxlj+SIWgZEY8+spEURsR
         ljwbdvlYyW+ICpNyyn9EVVvlWSva/oWrAaoE9qT7ZcYCReowu2e2dHFe4d6Iv4BR0mza
         bwExpRFgZ9CFZatndGLTERb4rsIR3Hu/lHgG6n+uPhMnQlBVetVpJc5d6dhG1QA95JFb
         gDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756484; x=1789361284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K28+i2/PlfR+JETeUlifhNXKb2RdSy48tKswPz635Jk=;
        b=oPevYkBjCgcSrHiBUrCmkTgrc3LC3pjEgfTXgYrFb+Gl77RK8ZaDUdv85HqJOXib5a
         hSms/Np6dhrsNYWsVbC8O2VuvaHjT8gaSp/4lkOJmcTwNv2JRSdFiUwapooMYPdpP9EZ
         hgi3Ty8aAX0dCA2NyrJnJ76QrbHF9Dfq2L8/DNbg2ye6fGQa2w5uWiFR4x6Jm6q9gq5/
         1tNdKd2fpcrCg+gZVB0wvW2VnnWk93+7tdcJxd/5lBBosbRgsiXTl3sdxoZchhzxxGtG
         68PlaChzl37rFulYdM/7fQ9vGd45llFTWnwYkWeExEQPyRcLnqEGuWZEIWwNuZZzARH4
         vOUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxl5I20dvavA54oi7NFhBPVJPCEkFSWWl4EOa/Sr9SrBbkLiWnIQ8QN4qOkaT0xGtFOkkYoLwk=@vger.kernel.org
X-Gm-Message-State: AFuF++kS3GeIOdr+ar/9Q4jyiSu0i0GLziYNRawojolpXBl+IG05Gmmf
	sv2OJvf+E4lAiM9R/f7OJrEa0vzYsif7sQcQIJhF+A75ZWw2IhKEGTwS
X-Gm-Gg: AYBFou2yXTr2culBvXF1GwUJMbPOWO+jNBS8RTlVioJ4yMAhkaS+vTY6xqlLoGo3g/g
	LF+q0HNqG+ZcMidsnYoBoIFBtQZdcku8NUifMysQ9kfd+W3ubpYECLN2I8ji/bZbmx3/DCfRyNX
	C1YFoacYUKOtGK09aEAjcjcZ/WklY8fkACIxwlTgq0Dsd/7aH7sNzIjmwelSZqrh2jyfTl4Vots
	iofRDFdnQ2l8c1jg0qiAewVm9T8H6Z5zN4JIUjILuZrfyO+xEd7Fx5eQ+ITcuIOElAFGhVM1140
	3V9t0tZJNA3FJl1qVWqqw7OIL5w8l/WGfsgv6Z4btfWuNoaMR2z9UXN8STNs24UwqF1CsHLFSmY
	/3c8riSDQTGl8mJGpHqoh1JxebVcZHVtjjmg+YWPO8uGS+nydZ7p4EeAOxCGp9USBKux5wyzAab
	6UBbh2Hu0UQyNoqrloTgFeYIJ4/+/53coiBoNaMJGLj9owdC0cpHg4AM6K5O8WE2BhciA55Xc0d
	sZvEdwHZVbg4JUknDnZ52hD8Sd3LAl9bwjRfK1PDjqo8sBl98iWYxH2cE2S2a5WxPaTWRyyB0Un
	MTJAetPzp+fEEttRpcoaiAyvuxxpX65SRMpdPqPqrFHkxw01xHuRmgReoS3CyICdgtcZh6PASBm
	4Bpwaj2Z0xgVYA1Sllp8=
X-Received: by 2002:a05:6870:c245:b0:465:2bde:8b5e with SMTP id 586e51a60fabf-4754f496d93mr15224468fac.1.1788756484281;
        Sun, 06 Sep 2026 21:48:04 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475501412f2sm9013503fac.0.2026.09.06.21.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:48:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 06 Sep 2026 22:47:46 -0600
Subject: [PATCH net-next v10 1/2] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY packages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-submit-acx00-of-dynamic-v1-v10-1-dd272e03b547@gmail.com>
References: <20260906-submit-acx00-of-dynamic-v1-v10-0-dd272e03b547@gmail.com>
In-Reply-To: <20260906-submit-acx00-of-dynamic-v1-v10-0-dd272e03b547@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>, 
 =?utf-8?q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-sunxi@lists.linux.dev, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
package offset helpers. The AC200 package instead references the companion
IC described by the separately submitted x-powers,ac200 MFD binding. Its
I2C interface provides access to the package controls.

Give fixed hardware variant-specific compatibles. Also provide an ACx00
compatible for systems which can contain either package, with one packed
NVMEM field containing calibration in bits 3 through 0, the AC300 selector
in bit 8 and its low-calibration selector in bit 9. Such a description
contains the potential resources for both backends; the driver consumes
only those selected by the configuration field.

Describe the package clock, supply and optional xMII receive-clock
inversion needed by some integrations. A fixed AC200 package may omit the
NVMEM field and use its internal calibration copy. Limit both the package
and child link-PHY addresses in AC300-capable descriptions to 0 through 7
so the control address remains in the documented range 16 through 23.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 165 +++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
new file mode 100644
index 000000000000..ee90c4ffecce
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
@@ -0,0 +1,165 @@
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
+      Phandle to the AC200 companion IC described by the x-powers,ac200 MFD
+      binding. Its I2C interface provides access to the package control
+      registers used to power and configure the Ethernet PHY.
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
+      required:
+        - clocks
+        - nvmem-cells
+        - nvmem-cell-names
+        - x-powers,ac200
+  - if:
+      properties:
+        compatible:
+          enum:
+            - x-powers,ac300-ephy-package
+            - x-powers,acx00-ephy-package
+    then:
+      properties:
+        reg:
+          maximum: 7
+      patternProperties:
+        ^ethernet-phy@[a-f0-9]+$:
+          properties:
+            reg:
+              maximum: 7
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

