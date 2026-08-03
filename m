Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21B39CCF7
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734145; cv=none; b=uWR+E/84xH2OUHUSkZl4tc68kt2eUhM1vwQaN5IxgctWs8uFE9BXZ36GAazuDlH7BnLRywdie/Al66TyKgoZ9bcukyPkccxtCP9K2U4UJadWge5UMoDdA+fYsSgl2MxbR1MUVfofnfoUR+Dwga0Vx9dbJJlwHZ44Wc3hMrlxees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734145; c=relaxed/simple;
	bh=DTn/pnAwjoqAyUd80mDT7MV7oTEK5ffPq/Jme8VHnRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmpDHLYabXJXDnx3bcpQ55fsNHh+kTaq8Ov90oXREZXx18ko6Q/+S4uX+EksGnM9hljostSENheWNqNcOnaBqOFnJvBl9uj7hNERooSRchGakMS0wNXMPWXu3s0KlyGh41jDxphBe5nR/xrVofZSO98Low/VfmbGoBjlkBCfihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q316WcA8; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q316WcA8"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ecd7216cso1538616a34.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734142; x=1786338942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jidbxiox7dX03nOKASiwvW/wC69oSzUN52btxDpp97E=;
        b=q316WcA8v72PzRic2zxv8ou7FCtD9wInxSBdYdOeV3f15ICzn7mP/+kBrshXd2G6xC
         /Kd/ZvtEI93uFfwJBWUV4XNOa+3oRR03EwfBiDRvY0oKJ39MsoM6OOCKKJ6HxP9AzIQo
         SlExCbg54uJNaAev7l+bhplWdvA068IypIXRa0kTCVoGKB5T5DaHsXpO9PvwUIf85gJy
         YK/x/AFVSKnkSdGyOqRrKVpP6MNZCJRloICUsZ3lFsOYA3m/gecXwZTmPS7DbUkJ1xmD
         EdTBmKnq1NGVa1JixF8KiKFuomnkitGZ/7f62b43XW207T5lJJB996rTG2tLZFVjpgip
         GFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734142; x=1786338942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jidbxiox7dX03nOKASiwvW/wC69oSzUN52btxDpp97E=;
        b=iMSqMpb6SoG2zCHrDxRrYEUXfDg7Ot3DmHqj0VtqxW1eqhWtxGi+e4qVitqlXd5vXo
         w4vnutVRehdkgJg91aP91irsHOPrQ0LAx+/rwKy2RexsX3aWwcjqNEF09rqXoW1vH1Fq
         GXfLtsQeBC/ckW1rrVZuto1XUE+av+s5tu9RDDV//7XqcCYElJHf3vq3fE+F+zkZ72/L
         8ie2PZq1IEnCKpm4SBMAknQMONf7/jvpOT9p98KZSmvbobtRaagA3Qg3thTba+SH/6HE
         cynI9HppGiOWY5LNrELZaVZwtKmZ/Z2lEWikmdvJat105M2NAwTsM0mGS9UXnGIP+eMY
         863g==
X-Gm-Message-State: AOJu0Yy0WQrc6a6dOx9U01WuXyeBfXOb2ukDv0OhUwP2c7qmdt0Ft2tN
	a/OlcSoDw3GTBmYLS8KrjV3WtW/oyE0/DzWcyWgvdIVwkQiXmYMiKRlZ
X-Gm-Gg: AR+sD10tsolon7HOfDJnGYUYg3RcxzY5GqRBUbO2bZiMLBiQjupZ92QVWFgcuYdR63y
	ZjRsWClfJHWUusJKufV27+frQAPg5Et9CUcnT6xiICUQ+I50BTmFldyfqgKjiC2Trr2oeXkA8NO
	aK3mq+xbv86/Vhw4a5uegBF7BKj0jZPaVvgIc3HZwW8NWz4LDdNDA6u5lHc8YxEtWDpCeaGEfgf
	DVaLT6/Vyq+Duvb4Ha2sScMXai3FFjPegnABu8z3cqxn60gb4oC8qMBwUcc8GeAjhbz7QevCAMt
	tENlWk3LO5iugR9O0RNlxpFxIWowH0f682tNWk4r8KL4o9BIfm6nAoWsoG6xOZOMSRTuMBN1AnC
	3nUfJANDFIPvZbabugmCdrCqepBb1RN4YZYSi1SVqB5eIjMrwPl1Kq8ol3XETAlQ+OXFHF13lDk
	u6yCTK/oaEoIZPkQeV/N0tl+s0Xbi9ojeWy/RiVd9zzJ0vQq/EZVbVZUjz6WPCrrJx+NcJyDdsg
	gacjl+eD/cgfpfFwN5JukobXZKxG7BsGj+CHHxlwPbYyd6UcmZ75ZUEcoHUuTWMqVkPAcsIv0m5
	IeyCHROcMyJFFZTtWs9KksCVGCTLcG/rG0iXz36j0LPUodLu8Jz3Br4ehW9GQRD/0Adc6/t+bq7
	PTRq2kIMYXYi7w4hj
X-Received: by 2002:a05:6830:411d:b0:7d9:f50f:9691 with SMTP id 46e09a7af769-7f1968c88e1mr15370101a34.0.1785734141726;
        Sun, 02 Aug 2026 22:15:41 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:23 -0600
Subject: [PATCH 13/21] dt-bindings: net: x-powers: add AC200/AC300 EPHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-13-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

AC200 and AC300 companion ICs contain compatible Fast Ethernet
link-PHY implementations which report the same PHY ID but use
different control interfaces.

Describe the forced-ID link PHY and its control-device references.
Fixed systems reference one already enabled control interface. A fixed
AC300 system may optionally provide the configuration field for its
calibration-range bit; omitting it selects the normal range. Systems which
can contain either companion reference both candidates and require a
logical two-bit NVMEM field for variant selection and AC300 calibration-
range tuning.

The link node reg value is programmed through the AC200 control
interface, while AC300 requires it to match the package-strapped
address. A control reference is required to distinguish this
integration from other PHYs which report the same ID. Also describe
the optional xMII receive-clock inversion required by some integrations.

Describe the three fixed-function package LED outputs using standard
PHY LED children. Their functions are link/activity, 100 Mbps speed
and duplex, and their polarity is shared. Omitting the container
retains the vendor fallback with all outputs active-low; an explicit
container enables only the outputs it describes and may select the
shared polarity.

Allow a PHY with a routed interrupt to be marked as a wakeup source
for magic-packet and link-change Wake-on-LAN.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/x-powers,acx00-ephy.yaml          | 217 +++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy.yaml
new file mode 100644
index 000000000000..3e01f6b44006
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy.yaml
@@ -0,0 +1,217 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/x-powers,acx00-ephy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 and AC300 Ethernet PHY
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 and AC300 contain compatible Fast Ethernet link-PHY
+  implementations which report the same PHY ID, but use different control
+  interfaces. Systems with a fixed companion IC describe one control
+  interface, which must already be enabled. A fixed AC300 system may provide
+  an NVMEM configuration field to select its calibration range; omitting the
+  field selects the normal range. Systems that can contain either companion IC
+  describe both control interfaces and require the field to select the
+  matching one before the PHY identification registers are accessible. In
+  that dual-control topology, the AC200 I2C controller and AC300 control
+  device may use status "fail-needs-probe" so the selected one can be enabled
+  dynamically. The PHY node's reg value is programmed through the AC200
+  control interface. For AC300, it must match the address selected by the
+  package straps.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id0044.1400
+  required:
+    - compatible
+  anyOf:
+    - required:
+        - x-powers,ac200-control
+    - required:
+        - x-powers,ac300-control
+
+properties:
+  compatible:
+    const: ethernet-phy-id0044.1400
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Logical SoC SID field whose bit 0 selects the AC300 control interface in
+      a dual-control topology and whose bit 1 selects its low-calibration
+      tuning sequence.
+
+  nvmem-cell-names:
+    description:
+      In a dual-control topology the configuration field uses bit 0 to select
+      AC200 (zero) or AC300 (one). Bit 1 selects the AC300 vendor sequence for
+      a low-level calibration value in both dual and fixed AC300 topologies.
+    const: configuration
+
+  x-powers,ac200-control:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AC200 Ethernet PHY control function
+
+  x-powers,ac300-control:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AC300 MDIO Ethernet PHY control device
+
+  x-powers,xmii-rx-clock-inverted:
+    type: boolean
+    description:
+      Invert the xMII receive clock inside the PHY. This is required by some
+      SoC integrations, including the Allwinner H6 AC200 connection.
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that the PHY interrupt is routed to a wake-capable interrupt
+      controller and may be used for magic-packet or link-change Wake-on-LAN.
+
+  leds:
+    type: object
+    description: |
+      Package LED outputs. Output 0 indicates link and flashes for transmit or
+      receive activity, output 1 indicates a 100 Mbps link, and output 2
+      indicates full duplex and flashes on a half-duplex collision. The
+      polarity setting is shared by all outputs, so active-high or active-low
+      declarations on different children must agree. Without an leds
+      container, all three outputs are enabled active-low to match the vendor
+      initialization. An explicit container replaces that fallback: only
+      outputs described by available child nodes are enabled, with active-low
+      used when no child specifies a polarity.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^led@[0-2]$':
+        type: object
+        $ref: /schemas/leds/common.yaml#
+
+        properties:
+          reg:
+            enum: [0, 1, 2]
+
+          inactive-high-impedance: false
+
+        required:
+          - reg
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+oneOf:
+  - properties:
+      nvmem-cells: false
+      nvmem-cell-names: false
+      x-powers,ac300-control: false
+    required:
+      - x-powers,ac200-control
+  - properties:
+      x-powers,ac200-control: false
+    required:
+      - x-powers,ac300-control
+  - required:
+      - nvmem-cells
+      - nvmem-cell-names
+      - x-powers,ac200-control
+      - x-powers,ac300-control
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+  nvmem-cell-names: [ nvmem-cells ]
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+  - if:
+      required:
+        - x-powers,ac300-control
+    then:
+      properties:
+        reg:
+          maximum: 7
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id0044.1400";
+            reg = <0>;
+            nvmem-cells = <&ephy_config>;
+            nvmem-cell-names = "configuration";
+            x-powers,ac300-control = <&ac300_ephy_ctl>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    active-low;
+                    default-state = "keep";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_YELLOW>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+                    active-low;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
+
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id0044.1400";
+            reg = <0>;
+            x-powers,ac200-control = <&ac200_ephy_ctl>;
+        };
+    };
+
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id0044.1400";
+            reg = <0>;
+            nvmem-cells = <&ephy_config>;
+            nvmem-cell-names = "configuration";
+            x-powers,ac200-control = <&ac200_ephy_ctl>;
+            x-powers,ac300-control = <&ac300_ephy_ctl>;
+        };
+    };
+...

-- 
2.53.0

