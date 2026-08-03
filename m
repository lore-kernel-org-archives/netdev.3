Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B064393DF2
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734140; cv=none; b=iZztqBqhqSz+IWXnPwq2LAStK+5Dk1BG3IK4Zxmku98+7781bjZ1vLMNwad+RpQ7rSfXhpnKErPtGNyfsbYm5n1c0U97ghcJ2ioApw/Ll027cjaXz6F0x+nSQ8GPlcCI4H1c9v4D3EDgO1yPI8UAgZWlr4mE5LIVnUgsx1LNUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734140; c=relaxed/simple;
	bh=6OQnGRpMnyrb+bp+bGTn43xoUYsbGDK19SjrvuCzOUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGdjt95/B+bvNH8u9wcgvsdYekW1pv2hfzz/A9A6+zhLvST9ItdPGhXDqn7IeFqeHRRnBJBlyPAGoFwX6VImVzpdUOLC9Smbkjid2Tr/mmWuh4Qsw/CRxGJkqsB/xo1NUmEljafWuLS+A7bH830Y4H0+m2h/bPXsbqaa+v0korw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi4x0b3k; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi4x0b3k"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb34c17b96so2068817a34.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734137; x=1786338937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ws0LFhZuUjZTnhwPoD3ztO16rIL3gtosandi83LBFNY=;
        b=Oi4x0b3ki8qQ0Wsn2Pa/0zAMxU4V7MYLmkko5UHfR/mnt8fAJf/wa7w8Zd0SFg+i9F
         SKiTQ2TH2b61Dfx/XPCn50eJzFZQ8Etk1MruJlSljUUI92TiR9CdVS2YhYrXDGed5fyS
         KE/zm6LYsMvoLXwdSWVYR22Bnn0lzC2L0NoJsTEbvBxijmkASl+08CbhtsUZXdqVbQi+
         dgRY9p+GNM+WsV9/2f7F+Y1k5JkycQPMxHioQW2Y9LiBP5hsGydB9ovCxXbedO/2lDT7
         WhxKq2J/Fy5OSKP18/hLIRphPoeWxSEDcsx3dglNewRU/p0+zgl30dEsv8XyAHGHCpwJ
         MNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734137; x=1786338937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ws0LFhZuUjZTnhwPoD3ztO16rIL3gtosandi83LBFNY=;
        b=q+/yqlF3PthTSI8URTdERqx5M7OcjWa8BKwvb9H8hAqZVoHX0FjlYuhIboQu2q1Kek
         K+h2sLUUcaz0/nR0R9tYG77yFkJ5VPxQ9kWMqmDzJqMoR9uvbQ51Yu/VGZqiWRs5tKCf
         crsQkItoJ1A81I1Jp+TPjr2yJFIaPrFkhmZmCL1cJ1AVqMT3pI6BmXeIJJ9/aq6sXRNR
         vu2wGTcJE73GOiDoGOzT1YqBQhSJBgvvGnBNP8cY4NP//IU4w+WLjiTvs2aB7dR0YP3e
         pP4iAOSEtt8sTGrx0QzColh1i2Tyvp/mWUsUPdf98DJm6w+Unuzt/hci2VPcsEIin1ao
         tCsA==
X-Gm-Message-State: AOJu0YxUJ0UOFhPk5BTCjJ8d4dUHuZA+iSg4KZv59pNb0rRUd+6FEZgq
	Iwt1mPniju1I7h0AeAoP+W3iWQiu6xxl8VFwF8hjiFaKWL6g8GcKgCpE
X-Gm-Gg: AR+sD12Fi9f+OZPLWalEv7ZM9Gbm1001iT5GImJJgAzeSTJr6R78ogLL/3Nlq4ebbis
	4xZk7QgMusFrSNrJNdD1u2qsiCTZGPMreYIe+uwRDPMMcvjbSfU2IcDjoSf+dmQJW2nDQ/6rfQq
	67wCd1QbbeJRrvtxLl5IklIRymEBRYpg5OEBxCOA7QZIrrRe6DPqgoQGm87nKyIjLMbYhg84Pcs
	/Y+UndpS7wbq0dj0OaYM7tj8ctsl2DoGV4HmbjTuQKTgD3TKrRTYcZeRlm7jVPPe0kd46FUP4u0
	78789OTp7S8DJ8kCdlfMhdJc2/QKWu3md6X84l0EyVm+T5uiDazIlzWEF4ZpAVu87omYAqJ/mq6
	zJ+HORb4EDoptaLC31ZEKAhsez15G3wrSYdNJDmUPCichtJyoqGKAcqVmrQDslkyZkzS51GPxhq
	xOimnM7ZCDRinA6+C7lpZ4GnGnKZWy2N7LkojNVFLKkNFfDsPgoBq/nA1hdBK1S7MH2wDSh2ZNW
	d4YsLh8ncgyLoO5IzckAvb/rO0zwvWJbJfctx0LRSSfgXTQ6I6R5vAKefijsDcAyQLh0uiXA4r7
	JuEak7LOIwS0r/1c/8VB9L4uBi0+5RLVxurFq99MyUH/gm7rCCU9DreikBLuP9NGB9T+I702ULo
	dUrhjkRr0tgJcX6NV
X-Received: by 2002:a05:6830:6737:b0:7dc:df37:844b with SMTP id 46e09a7af769-7f196baee6fmr14985696a34.4.1785734132204;
        Sun, 02 Aug 2026 22:15:32 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:18 -0600
Subject: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com>
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

The AC200 is an I2C-controlled mixed-signal companion IC containing
audio, video, RTC and Fast Ethernet PHY functions.

Describe the parent device, its input clock, required function supplies,
the optional SID bandgap calibration cell used by the vendor initialization
sequence, and its optional Ethernet PHY control child. Document the 24 and
27 MHz rates encoded by the public EPHY clock selector.

Also describe the optional open-drain, level-triggered INTB output and the
nested interrupt controller which exposes the TV encoder, Ethernet PHY and
RTC sources. Define the interrupt source numbers for child consumers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/mfd/x-powers,ac200.yaml    | 118 +++++++++++++++++++++
 include/dt-bindings/mfd/x-powers,ac200.h           |  13 +++
 2 files changed, 131 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
new file mode 100644
index 000000000000..017629cca73c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/x-powers,ac200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 mixed-signal IC
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 is a mixed-signal companion IC containing audio, video, RTC and
+  Fast Ethernet PHY functions. Its control registers are accessed over I2C.
+
+properties:
+  compatible:
+    const: x-powers,ac200
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      AC200 input clock. When using the Ethernet PHY, its configured rate must
+      be 24 or 27 MHz, matching the rates encoded by the documented EPHY clock
+      selector.
+
+  interrupts:
+    maxItems: 1
+    description:
+      The INTB pin, which is a shared open-drain, level-triggered output for
+      the TV encoder, Ethernet PHY and RTC interrupt sources.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+    description:
+      The interrupt number, as defined in
+      include/dt-bindings/mfd/x-powers,ac200.h.
+
+  ac-ldoin-supply:
+    description: 3.3 V supply for the audio-codec LDO input
+
+  ephy-vcc-supply:
+    description: 3.3 V supply for the Ethernet PHY analog front end
+
+  rtc-vcc-supply:
+    description: 3.3 V supply for the RTC
+
+  tv-vcc-supply:
+    description: 3.3 V supply for the TV encoder DAC
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Optional SoC SID cell containing the AC200 bandgap calibration value.
+      The trim is used by the TV encoder; the public AC200 datasheet does not
+      document the corresponding register fields.
+
+  nvmem-cell-names:
+    const: bandgap
+
+  ethernet-phy-control:
+    $ref: /schemas/net/x-powers,ac200-ephy-ctl.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - ac-ldoin-supply
+  - ephy-vcc-supply
+  - rtc-vcc-supply
+  - tv-vcc-supply
+
+dependencies:
+  interrupts: [ interrupt-controller ]
+  interrupt-controller: [ '#interrupt-cells', interrupts ]
+  '#interrupt-cells': [ interrupt-controller ]
+  nvmem-cells: [ nvmem-cell-names ]
+  nvmem-cell-names: [ nvmem-cells ]
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mixed-signal@10 {
+            compatible = "x-powers,ac200";
+            reg = <0x10>;
+            clocks = <&pwm 5>;
+            ac-ldoin-supply = <&reg_3v3>;
+            ephy-vcc-supply = <&reg_3v3>;
+            rtc-vcc-supply = <&reg_3v3>;
+            tv-vcc-supply = <&reg_3v3>;
+            interrupt-parent = <&pio>;
+            interrupts = <1 20 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+            nvmem-cells = <&ac200_bandgap>;
+            nvmem-cell-names = "bandgap";
+
+            ethernet-phy-control {
+                compatible = "x-powers,ac200-ephy-ctl";
+                nvmem-cells = <&ephy_calibration>;
+                nvmem-cell-names = "calibration";
+                phy-mode = "rmii";
+            };
+        };
+    };
+...
diff --git a/include/dt-bindings/mfd/x-powers,ac200.h b/include/dt-bindings/mfd/x-powers,ac200.h
new file mode 100644
index 000000000000..cc59e2ab4912
--- /dev/null
+++ b/include/dt-bindings/mfd/x-powers,ac200.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Interrupt numbers of the X-Powers AC200 interrupt controller.
+ */
+
+#ifndef _DT_BINDINGS_MFD_X_POWERS_AC200_H
+#define _DT_BINDINGS_MFD_X_POWERS_AC200_H
+
+#define AC200_IRQ_TVE			0
+#define AC200_IRQ_EPHY			1
+#define AC200_IRQ_RTC			2
+
+#endif /* _DT_BINDINGS_MFD_X_POWERS_AC200_H */

-- 
2.53.0

