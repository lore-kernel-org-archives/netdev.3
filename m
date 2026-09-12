Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5F472541
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218281; cv=none; b=fjdFen3xGFfmpkxqdXvIOOCnrL8HPJRpFhSky0wV7/PC9mhp0oZj2u1+2t9T8E7DCEh+mj+leh0pODq+o0OmrHz3AJN/3uDAXwhkATDeL2RSQi49Qv3CqgB1gs6lkisdrjyMvCzyl41V8xJs/6Mg92uu9SirfmQ7PPUCqfGqhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218281; c=relaxed/simple;
	bh=dYtekyfdPkvjbIvhRVWQ56pAdussIAg2Ik5Q1WhEgy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwat4ptknh+ZwJAkZC0ammd7p5k4DBf5g/32rx39G2iyxtc828aF3I3P+7WuBKHP+vG3umyRPHtDmR6dWjm6VZFOE2LUaNgbkfzxnBa+0UFNk4PjZHJ+bHE1uZ3mOksi8kznQ7T//vHffC1uToqdpEzT7ko1c9ynCVont9Td9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Ics/Nckp; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Ics/Nckp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so211105f8f.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789218278; x=1789823078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfMHM791MR18SdZtnthEsjb4fNyTobmnPZ1nyemJ/LA=;
        b=Ics/Nckpralq0wWNTN2YXxdlPJ2Lb33iYnyOeIlZsm2Y4i+cRBqEhFLCcZXemZhV4S
         Fe860Y7uqYaPex6WGA89nK8UNYvo0EZ6J1M/70shiAVhdIsMbUD75zln6V+rHmWfMiYi
         ebpjEeyWh8wv45cEFOy1g+h7/7te5MCzvANVJewKT/PVRUbJj7iyFkpsVw2/juxbIYmD
         g4Hf9TxxYyRFVniGDCBki38eWgxwLieOyE4QpkUWdyxDn5Uo2W22XUMG43pCpwzNMID4
         hwDM16SEoXezDEbg98QF7AzSSO3t9MJNTEugwir68cl+aaCtAgJ4Dji8NNzoH1vA0Gm+
         82Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218278; x=1789823078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfMHM791MR18SdZtnthEsjb4fNyTobmnPZ1nyemJ/LA=;
        b=AfoCnB6um77+77V/T/X29EtYKesCXIZ//1Z+YXaOfYACMZbcKe4Pf4LJ3xSq6dKbk2
         HDH3hvjSAFU987AnEW8qSVAGargJ6IxCbOoKjiwAqwCLMfwJSuuS8f7bAtxyagAGNa9r
         3Eth5p8FIHZTC5TZndVM2OEk5vYgiOkpd4bKJP2Z0UrwQg5C94DcXrJP7m8RZTFdIl08
         MV/wAcrlOgg7DQbIysLvwxsAkXDJ/2OC2fdGMK1UAIOSY0uQO9IGk48PZa36LnFJOtDd
         TG11+PVI0FYHcYRYOJ40tthTpPxWc1sbaPisomnerBL9lrRZTp/0R+w9VecTZHYv+G8J
         /kbQ==
X-Forwarded-Encrypted: i=1; AKwUvByFAj+c0GKcJnKuXW+Y1myffjLcAJ9fLjhGy9fJQzEF2PX06x+uPVNXrFGoAqNM23Hui6WDzgc=@vger.kernel.org
X-Gm-Message-State: AFuF++kvHCnI7CmS9lAeoeaInfsO76ZN7LOrqFmfLKfNCY2s+uI61qJu
	mvRWi6stcua1HCPPhtFLUz7cU4BqhTSHInz3LbRoXRgYBSYYHglGg7Bwm00d/ZfbM8U=
X-Gm-Gg: AYBFou165E98MTzo13wp1cZO053Oa1suwx+9THyt19TqJZWh2Bj2+ei/CGhWDG6ymsg
	qh4e/h2gfxp9eZcLQvgVEOvk9yPBDwWGM6RepoCWHjzqQWX+Pj4OZLqSgdlV6d22ut53Sv0TJtn
	lRGAcnOWzW6RulUXEVonKQtJ0NBDsQE7CMi6ozifCaZbRqQjeV8ijSmP6hFNgvluH/bXIMFzwjj
	KPSdmErcbNtJ0fOHanfqpIpXNygeQw5VGuin+cf3BsvzkPRDuFf7g52pEEEMYwpmIMmiYU1hvg3
	upEKg4TD/rkoSIyyF9v45AYp+ZRaB4Ks+xu3FSbEOmDPhlCYf2C9p11Hb23D6aJbYXnQEfxihEw
	xuxphvCiy4b3dlTgHfzXs/rxxjuvvWS/f1k6suyt/t+4aoLA90jWChwLCEPxXK5J+p5uW+WZNBP
	DJEpM7pSTPVBfYcKa+2otcRvEyr5gyV0dPAA5cO8oXjoA+bWm5xrKbf/aflcKG
X-Received: by 2002:a05:600c:4ecf:b0:49c:fc6c:bdfc with SMTP id 5b1f17b1804b1-49e6cbec26cmr23657665e9.19.1789218277887;
        Sat, 12 Sep 2026 06:04:37 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm80985785e9.5.2026.09.12.06.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:37 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v3 1/6] dt-bindings: net: add Airoha EN8811H PHY MCU
Date: Sat, 12 Sep 2026 16:04:25 +0300
Message-ID: <20260912130430.2246285-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912130430.2246285-1-f@lex.la>
References: <20260912130430.2246285-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EN8811H answers its PHY ID from power-on, but a link is only
possible once its MD32 MCU runs firmware that the host loads over
MDIO into volatile RAM. On systems that keep the firmware files in
a filesystem, the files arrive long after the MDIO bus was scanned,
and the PHY node alone cannot express that gap.

Describe the MCU as an MDIO device of its own, with the PHY node on
a child bus underneath it. The device downloads the firmware when
the files appear, or adopts firmware the bootloader left running,
and registers the child bus only then, so the PHY never becomes
visible before the chip can serve it.

The reset line belongs to this node, not to the PHY node: firmware
lives in volatile RAM, so reset may be asserted only while the MCU
is not executing it. On a PHY node the line would be pulsed by
every phy_detach() and wipe the running firmware.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 .../bindings/net/airoha,en8811h-mcu.yaml      | 127 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
new file mode 100644
index 000000000000..7c204b5f29c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en8811h-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN8811H PHY MCU
+
+maintainers:
+  - Aleksei Sviridkin <f@lex.la>
+
+description: |
+  The Airoha EN8811H 2.5G PHY is built around an MD32 core that executes
+  firmware from volatile RAM. The chip answers an MDIO address from
+  power-on, but the PHY function does not exist until firmware has been
+  loaded over MDIO, and it disappears again if that RAM is cleared.
+
+  This node describes the MD32 core. The PHY function answers on a child
+  MDIO bus below it, at the same address the core occupies on the parent
+  bus, and only while firmware is running.
+
+  The reset line is wired to the core, and asserting it clears the
+  firmware RAM. It therefore belongs to this node: a reset described on
+  the PHY node would be pulsed by that node's own lifecycle, whatever
+  the core is doing.
+
+  A board that has firmware in hand while its MDIO bus is enumerated can
+  describe the PHY on its own, as airoha,en8811h.yaml does, and that form
+  stays valid. This binding is for the boards where firmware arrives
+  later, so that there is no PHY to describe until the core has it.
+
+properties:
+  $nodename:
+    pattern: "^mcu@[0-9a-f]+$"
+
+  compatible:
+    const: airoha,en8811h-mcu
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      The GPIO phandle and specifier for the reset signal wired to the
+      MD32 core.
+
+  reset-assert-us:
+    description:
+      Delay after the reset was asserted in microseconds. If this
+      property is missing the delay will be skipped.
+
+  reset-deassert-us:
+    description:
+      Delay after the reset was deasserted in microseconds. If this
+      property is missing the delay will be skipped.
+
+  mdio:
+    $ref: mdio.yaml#
+    description:
+      The bus the PHY function answers on while firmware is running, at
+      the same address this node occupies on the parent bus. Only that
+      one address is passed through. The bus-level reset properties
+      mdio.yaml allows are refused here, because the MDIO core asserts
+      such a line when the bus registers, and that erases the firmware
+      this PHY is made of.
+
+    properties:
+      reset-gpios: false
+      reset-delay-us: false
+      reset-post-delay-us: false
+
+    patternProperties:
+      '^ethernet-phy@[0-9a-f]+$':
+        type: object
+        $ref: airoha,en8811h.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reset-gpios: false
+          reset-assert-us: false
+          reset-deassert-us: false
+          resets: false
+          reset-names: false
+
+        description:
+          The reset line belongs to the MCU node above. A reset described
+          here would be pulsed by this node's own lifecycle, and that erases
+          the firmware that created this PHY.
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - mdio
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mcu@d {
+            compatible = "airoha,en8811h-mcu";
+            reg = <0xd>;
+            reset-gpios = <&pio 14 GPIO_ACTIVE_LOW>;
+            reset-assert-us = <10000>;
+            reset-deassert-us = <20000>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-phy@d {
+                    compatible = "ethernet-phy-id03a2.a411";
+                    reg = <0xd>;
+                    interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..4ca19275f4d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -750,6 +750,12 @@ S:	Supported
 F:	fs/aio.c
 F:	include/linux/*aio*.h
 
+AIROHA EN8811H MCU MDIO DRIVER
+M:	Aleksei Sviridkin <f@lex.la>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
+
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.53.0

