Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793776958;
	b=r+GrLaZcBbgImjfK3yFrjG+GHOVQcaes4U7fRF4urTf+MX5Kces/QtVBzrycOYWpmkcZ
	 jKm5Kh+9Sx3SvqeeKAHcoH0Lm6zWnyen8FCKOQ60pAa0qxlohDXWnGmFeNLvhDT30xy5q
	 mKW85h93fnifTMV+uPiVbjneXnjSlXvhVGihGI1obEB1XZ/eRsaiFaIR7nrAMQWSJuubk
	 tS7cxvfzQAgsIVuLJktc2ArmqA8pU5kr+tXc14WEu716KZ5PR2lBgV1j6hMEskS5Uy1lo
	 jgsqc7qLXapO9wUBRRT1FjHdQWCwkRBXP3xwZf9ZGCk0hddauABVbi+lObXALedqdIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776958;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MOReuoec1CLoNa//dtGNf5m3XGY/nvtMHuSPmq6nhyA=;
	b=zYKCYrQjEbrxpDCqouybR1WtpDIjFw8RP01vUoW4z/d/Bbe5NgWSOgdqGGyoDAf+SgXY
	 4BqodJ+8BFEnubP7LjBEgwo46BVVPRvPC5VFfrovR0Z95ZiC3tsgP5UGPHLpIB63FLixv
	 V1E2feaWMUFduwJ38Ept7BkkqsBGcBjywoK5Cm9IsFar8uk/Ap603HWnpPj3Q5a3KbRS6
	 HSTJZN4tYqQr8asbGC8dkKyTG2U23nPMiF0UHvsJVGgbwX+iPKHiVhHHTIAeIgr1isp8m
	 31iibJTQfw1oRlZNIuFkHjknQ3wK1wEsBj2e+bi7Ge1dePXys1WABDe+6RKE93Xu+UA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIEwbRL3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AE606D81C;
	Wed,  4 Nov 2026 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIEwbRL3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793776958;
	b=kPVkBcWLsFvwh05Zxf6XyMTa/p/d0daGyxyqeToOLQyiQRZHn6MKrG2uDElMAdPr/Usx
	 ye9jSjfxGcIVZzl7Wke6QF8JBbz6Exf2Vf6ALBlZKOdbiLTM5mN8N25s2YkrLEZXA1LzQ
	 U7qjmcXnvBG5S4AQSmRxPDCZe2voYjsBgyq4fweL+hbN879muH85FvS6V4jrkfn77VBdA
	 GVaMbxgPF60NPz0VR9Te2r/VjroK0Qu9PNP1okO1H71idY/XYGMb4afhM8oLMCpb1py5D
	 36vJHtU3y3PzNDkUWR7HRfBgoRv++D2MuFRJ4w6angMGxpLntzCQwLuJ/TCF60lNxLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776958;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MOReuoec1CLoNa//dtGNf5m3XGY/nvtMHuSPmq6nhyA=;
	b=TQTAMw18AikVfVvsmIsQN3lPeBCee0pnCJXf0b/ynbB6UI5G3QakzYpQRzTNIp0E8eDM
	 heiDrbWc2qriCIlcpRf7nsEsdc+fFezFg9+6mc3omHCnEnN0eANrLK9VD03Y6YP2ryp6U
	 wJkf5E2KtbWRC+Mp3EcnLVfVR12d6DeYC1sbnsmOLpjQtr2q/4h3p4ARD8PN3fLsETuO2
	 AYckv5rtgDQ9I0cV7HaWG8SDLwUGskQvG623oAf0D/D51XGMAdj0NyCcDO+R+VULl345o
	 OjoY9HtCSP9q/nV/0hv61lpQOlWVuOoy7nvkOkZR+W+NwKrClg+BgJAdKZpvWCf9Q9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9CD061F0093A;
	Wed,  4 Nov 2026 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776958;
	bh=MOReuoec1CLoNa//dtGNf5m3XGY/nvtMHuSPmq6nhyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TIEwbRL3sLpRnF56qQHid6QrDYfoeOkxuStey2WN8p/Y7kDaMRlDi4pHNwl8BX2Mm
	 1SUkHAw/AzTQt3Xt15rrdM7plIgInkq/ywZCPHaTKsvEUUGG8qFXjO9+KG4FUtYE+C
	 PiwvXouOohh0r+fjJe6S/LhBuZxEv/wwS3pm4B+AvO4Np0RbjuLEvlFqmSe0fiIUaZ
	 mV9eNr26q95uD1958OfB1T6THn7UhpEACmXrPgRhJbk4SGfDHoYKQ2QPsoN71T6ohZ
	 i1dlgYRzwwmbVCdOTAEV5o170/udrrvbezeMd2/rzFH8dGPJ4Y7JY63H9m1GlWdZur
	 wZb5HRHW51i6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32EBC46D2D;
	Wed,  4 Nov 2026 07:22:36 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Wed, 04 Nov 2026 02:22:24 -0500
Subject: [PATCH net-next 1/2] dt-bindings: net: Add Siflower SF19A2890 GMAC
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-sf19a2890-gmac-v1-1-a15965a49574@telaak.dev>
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
In-Reply-To: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793776955; l=4305;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=XOuu0yKHxzyySINW5UI8L81RpxlJ/TBeyAQn1sO1t/Q=;
 b=fisEUu+QvicaWpO+KC4U+S4bZAlkUMjZ+KOJ4cxZYLaahaAsnH+U3P8OYszWrmpXkxZA9VQ8I
 ZyA4qvWinNvBKDhiFXJ1ry6q9QPeY6FdUTNdQjeTDSBshkVQbt/xD/R
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

The Siflower SF19A2890 has a DesignWare GMAC 3.73a whose interface
type and RGMII clock delays are set in a configuration block of their
own, next to its clock and reset manager. It takes a fourth clock, the
RGMII transmit reference.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 .../bindings/net/siflower,sf19a2890-gmac.yaml      | 110 +++++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 2 files changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/siflower,sf19a2890-gmac.yaml b/Documentation/devicetree/bindings/net/siflower,sf19a2890-gmac.yaml
new file mode 100644
index 000000000..377f24a65
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/siflower,sf19a2890-gmac.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/siflower,sf19a2890-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Siflower SF19A2890 GMAC
+
+maintainers:
+  - Joseph Telaak <joseph@telaak.dev>
+
+description:
+  The Siflower SF19A2890 has a Synopsys DesignWare GMAC 3.73a. Its
+  interface type and RGMII clock delays are set in a configuration block
+  of their own. The MAC adds an RGMII delay only where the
+  rx-internal-delay-ps or tx-internal-delay-ps property says so.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: siflower,sf19a2890-gmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: siflower,sf19a2890-gmac
+      - const: snps,dwmac
+
+  reg:
+    items:
+      - description: MAC registers
+      - description: Interface configuration registers
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+      - const: eth_lpi
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: Peripheral registers interface clock
+      - description: PTP reference clock
+      - description: RGMII transmit reference clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: pclk
+      - const: ptp_ref
+      - const: byp_ref
+
+  rx-internal-delay-ps:
+    description:
+      Applied in steps of about 55 ps, rounded to the nearest step.
+    maximum: 14025
+
+  tx-internal-delay-ps:
+    description:
+      Applied in steps of about 55 ps, rounded to the nearest step.
+    maximum: 14025
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+
+    ethernet@10800000 {
+        compatible = "siflower,sf19a2890-gmac", "snps,dwmac";
+        reg = <0x10800000 0x200000>, <0x19e04440 0x10>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SHARED 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 34 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 33 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
+        clocks = <&gmac_crm 0>, <&gmac_crm 1>, <&gmac_crm 3>, <&gmac_crm 2>;
+        clock-names = "stmmaceth", "pclk", "ptp_ref", "byp_ref";
+        resets = <&gmac_crm 0>;
+        reset-names = "stmmaceth";
+        phy-mode = "rgmii-id";
+        rx-internal-delay-ps = <550>;
+        tx-internal-delay-ps = <935>;
+
+        fixed-link {
+            speed = <1000>;
+            full-duplex;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2c4842404..c3d96d58a 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -98,6 +98,7 @@ properties:
         - rockchip,rk3588-gmac
         - rockchip,rv1108-gmac
         - rockchip,rv1126-gmac
+        - siflower,sf19a2890-gmac
         - snps,dwmac
         - snps,dwmac-3.40a
         - snps,dwmac-3.50a

-- 
Git-155)


