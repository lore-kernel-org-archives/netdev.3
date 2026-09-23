Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBAE568554
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196468; cv=none; b=dd7FCs42BJ6cEob7XZOU+j30jjhXiQ+ToDfjB78nWCtDQgwsm5WpuyciBaEqidcoGrqYNY3MJoJlcChkicdXCWQN2zHXTm4qqGI6bEqMNsd6657G/xHgg9/qtrWlHqCwlv5YBrnvjV6RupxjDEswjHcg2fSAswRbcO30jsRoWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196468; c=relaxed/simple;
	bh=2Rk7dcj1EIntxo1C/ioN2dfS7ZxOV+D+YaH7GClK4Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I2b1ykQqPtzAxXvmIG250nqk+8oGcwuRBRSaJzXr3NxjTCZ/IKNSQKPTHk8ROca0UVaQ4+H9NSqiiWoahYuZxW9D9zMf/pfbi2FG9Cp5tnBXyfE4itqQjyImg3q9o2CVBZOuxhQAcjJ0bLEKK+JRamb1TVBLG/ZtRX0oakfHSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RZjmM5ZT; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RZjmM5ZT"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so802964f8f.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790196465; x=1790801265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWoyChkF8PBA93YfN7WK6+qy/EfUiqZ/evixTMMcgfA=;
        b=RZjmM5ZTQ2abI5sKPWDx8RQY2Q4r0HApK7/uZ3nRavmrrJtIBiCn9q8kXWwpyCe/9T
         wW5wGHwE3dlgMJ569UDM/h9rUDAaJkjYk9MP7l1dqb/zKNlz+gAcEKj1PMpOGHFd7J55
         OVY+fZ1urO5QSmOq5bW+UiC0vrB3jsWR+ask+8dCX+SzCYZNj2FSRcJ9qeYk8TtDK/0X
         HvSSzPbjrledFI5LTszh7/rvo+2d3/UMz8cK34au/6DEqMYFK+gy5/nWSHAys2B9hzuY
         JUIMTIcrtl9fCqpaNox9rWGqObibuUqftLea3zaCB3MVdpxpLSA9YQg4xARU+byviyAs
         veQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196465; x=1790801265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWoyChkF8PBA93YfN7WK6+qy/EfUiqZ/evixTMMcgfA=;
        b=WEYfTAoohK1RnUtHIpfSaRJq9OdSxJJ79BZpIhD5OxDyyVWINlGdJp1mRY1e1jAEAR
         XY+ezErPH7mkODiYv/kO7PT9gYu1Wib5OzWJWSv30ITl3ofiR1HMA/d6pCcX0EVzzNns
         Mi8UuaKQjQNV6EJwRWFLQid9ZDr+2hz/NILAvljU2CbhpkFnsBqqjZlleNydOvrTrnMx
         f92hkZCcvHdcfOE/VyIvS/NzDm35ZgSpS2YHjBsF8JPMFSAHMZ5c8VKxeJ7nv8Ma1krL
         iiJlkatrXQY6yl9mW15AE/S3Zqzqi1GltpK5xKnOx6QAhi0agXbbE8v7wIFdBIGzjjU4
         ZW7A==
X-Gm-Message-State: AFuF++kQENP12co0VVnPW7T5LMqyLWZDIDcbLlbMS7A5OLP/FieWChvi
	89rEqqL8FXkedwz9f5Ci+lQ6Ca7rUC+I+Hmtxzud07kR2ZSyZmb4iH38HF012qA+Mo4=
X-Gm-Gg: AYBFou3wjFwS/mb18mLTU/faSaLOoAymIsLD9HaaS19OQfh/aH88GMtwD7SUEpgZVDW
	MPZhWXZZskTdZqU0Ze9luIKQgSNkb0h8cSODELWrdWpsiuh6zSmThaBOpnT1mkRHkHISfbyoxx+
	BNm/JxJELA3R2Crs+SP6SuYQaXuMZkdurv9yFfGke+P1ITtaKtOwzaBmuzmy/TlT3TCc+SbpMT1
	VEAj5/RcdzQgpu8vW5UuBbKB9ZbZ2KkaFVOmxpKHxzMsM6k9nyi8hyJiVIs0LSojwsZzWhMKTPE
	eZdKh5fX2imbpuPPyVlvppeFOnPFoJ8y/hWPa+t7KIU+ow8ocey9Y+0hierUzuEG18rKUqF5qsk
	o6aO3EJrDG15+fHiJQDcyzvUjWkyZZ4tqJaQ8wqikurAH/QmFMTHivsoVu6tA02Vy43JfvJI/IR
	3aoomsUafOrfVWup/xegVegvhgVqmZj8sJuWIewuHwui7jTL0jdQK7q6tIHy9dU2YI1GMU0SlWg
	D4d5z2TpEkXmm6hyA==
X-Received: by 2002:a05:6000:25c2:b0:487:2354:d9d5 with SMTP id ffacd0b85a97d-488717240c7mr464443f8f.55.1790196464768;
        Wed, 23 Sep 2026 13:47:44 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c500sm9316780f8f.19.2026.09.23.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:47:43 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 23 Sep 2026 22:47:31 +0200
Subject: [PATCH net-next v3 1/5] dt-bindings: net: sun8i-emac: Add A733
 GMAC210 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-allwinner-a733-gmac-support-v3-1-15735155a789@baylibre.com>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
In-Reply-To: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6760; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=2Rk7dcj1EIntxo1C/ioN2dfS7ZxOV+D+YaH7GClK4Vk=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFlbrN5qaUf77BN3bJwfJC++VkBvYaWMbYWR1afZ6mJr4
 ja++vSso4SFQYyLQVZMkaWGu1r8naTWl1nTdW7DzGFlAhnCwMUpABPZupHhxz517jN7T5x3alB1
 N9/pM2vPwZOyh00kIpz4098WTOzczMgwY17a0wPyxufk71jW3GtatmaK+xmGP3+FGRsu27j4yvX
 xAwA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 GMAC210 is a DesignWare MAC 5.20 close to the A523 GMAC200, with
the following differences:

 * The glue configuration registers are a dedicated MMIO region of the
   controller instead of a syscon register, so a second reg entry replaces
   the syscon phandle.
 * The DMA channels and the LPI event have their own interrupt lines.
 * A PTP reference clock and an AHB reset are needed.
 * Unlike the A523, the controller does not appear to belong to a power
   domain.
 * The TX clock delay field is 5 bits wide and both TX and RX delays use a
   180ps step, allowing up to 5580ps.

Add the new compatible and describe those differences. Declare the internal
delay properties at the top level and keep their limits per compatible.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 142 ++++++++++++++++++---
 1 file changed, 126 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 323a669fa982..a4e0d9b760fe 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -22,6 +22,7 @@ select:
           - allwinner,sun8i-v3s-emac
           - allwinner,sun50i-a64-emac
           - allwinner,sun55i-a523-gmac200
+          - allwinner,sun60i-a733-gmac210
   required:
     - compatible
 
@@ -44,25 +45,38 @@ properties:
       - items:
           - const: allwinner,sun55i-a523-gmac200
           - const: snps,dwmac-4.20a
+      - items:
+          - const: allwinner,sun60i-a733-gmac210
+          - const: snps,dwmac-5.20
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: MAC controller registers
+      - description: Glue configuration registers
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   interrupt-names:
-    const: macirq
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_lpi
+      - const: tx-queue-0
+      - const: rx-queue-0
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   clock-names:
     minItems: 1
     items:
       - const: stmmaceth
       - const: mbus
+      - const: ptp_ref
 
   phy-supply:
     description: PHY regulator
@@ -76,6 +90,18 @@ properties:
       Phandle to the device containing the EMAC or GMAC clock
       register
 
+  tx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    description:
+      Internal RGMII PHY TX clock delay chain value in ps.
+
+  rx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    description:
+      Internal RGMII PHY RX clock delay chain value in ps.
+
 required:
   - compatible
   - reg
@@ -87,7 +113,6 @@ required:
   - reset-names
   - phy-handle
   - phy-mode
-  - syscon
 
 allOf:
   - $ref: snps,dwmac.yaml#
@@ -215,6 +240,34 @@ allOf:
             - mdio-parent-bus
             - mdio@1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun8i-a83t-emac
+              - allwinner,sun8i-h3-emac
+              - allwinner,sun8i-r40-gmac
+              - allwinner,sun8i-v3s-emac
+              - allwinner,sun50i-a64-emac
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+        power-domains: false
+        tx-internal-delay-ps: false
+        rx-internal-delay-ps: false
+      required:
+        - syscon
+
   - if:
       properties:
         compatible:
@@ -222,32 +275,60 @@ allOf:
             const: allwinner,sun55i-a523-gmac200
     then:
       properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
         clocks:
           minItems: 2
+          maxItems: 2
         clock-names:
           minItems: 2
+          maxItems: 2
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
         tx-internal-delay-ps:
-          default: 0
-          minimum: 0
           maximum: 700
           multipleOf: 100
-          description:
-            External RGMII PHY TX clock delay chain value in ps.
         rx-internal-delay-ps:
-          default: 0
-          minimum: 0
           maximum: 3100
           multipleOf: 100
-          description:
-            External RGMII PHY TX clock delay chain value in ps.
       required:
         - power-domains
-    else:
+        - syscon
+
+  - if:
       properties:
+        compatible:
+          contains:
+            const: allwinner,sun60i-a733-gmac210
+    then:
+      properties:
+        reg:
+          minItems: 2
+        interrupts:
+          minItems: 4
+        interrupt-names:
+          minItems: 4
         clocks:
-          maxItems: 1
+          minItems: 3
         clock-names:
-          maxItems: 1
+          minItems: 3
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+        tx-internal-delay-ps:
+          maximum: 5580
+          multipleOf: 180
+        rx-internal-delay-ps:
+          maximum: 5580
+          multipleOf: 180
+        syscon: false
         power-domains: false
 
 unevaluatedProperties: false
@@ -412,4 +493,33 @@ examples:
             };
         };
     };
+
+  - |
+    ethernet@4510000 {
+        compatible = "allwinner,sun60i-a733-gmac210",
+                     "snps,dwmac-5.20";
+        reg = <0x04510000 0x8000>,
+              <0x04518000 0x1000>;
+        clocks = <&ccu 58>, <&ccu 59>, <&ccu 60>;
+        clock-names = "stmmaceth", "mbus", "ptp_ref";
+        resets = <&ccu 30>, <&ccu 31>;
+        reset-names = "stmmaceth", "ahb";
+        interrupts = <0 175 4>, <0 179 4>, <0 176 4>, <0 177 4>;
+        interrupt-names = "macirq", "eth_lpi", "tx-queue-0", "rx-queue-0";
+        pinctrl-names = "default";
+        pinctrl-0 = <&rgmii1_pins>;
+        phy-handle = <&ext_rgmii_phy_2>;
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ext_rgmii_phy_2: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
 ...

-- 
2.53.0

