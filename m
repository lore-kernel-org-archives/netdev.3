Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC03655CC
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716754; cv=none; b=MwmjS/keZLbtk8s/tDM1nEFnUk93zm0EtmJ5Aj3w7UbcyftjI875o7/jjmnHYyZ/hOwsMK5gWnrZPsWLBtJzzq7MgMsi/NRuK2glPyJUM/fVQBK3RV3uTS7Pz+edsqWDKRrl73Ep9oCS5/MLKqlIMV4JTyoPCU+/gSIDgWbfrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716754; c=relaxed/simple;
	bh=eTj+v4XZ/mc1fs4KGXNTWMfLWYAfDj0EedWktiYlkHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt+03EnnChN6v2taJDbhVdY0AR782NevFJ1wSr0A9M1x+rjtGvMBn/ulpGCCvfyEV4uMWHdXZjQAhg510Y/Cc+0TPjMYYvMxLMOMdp8uaviJARKgmfcN7kTFwcJ3JWewVJ2BrmLl3XQUxOebmoo4fuPNqrpnaKDczfhgNF3qTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=iqShrAT9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="iqShrAT9"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1801444f8f.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788716750; x=1789321550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CaAy/OOlyYaqWLAHRZ+LDOoXJmE0/3wBUASyxhKepw=;
        b=iqShrAT9e7JfEmgnyioc9eKb1fqXFNjntNRZhBQ2Oa8ScrBWZsKTWcU8B7mz2LpAWe
         7O4Bx1AEdDqZADPXIEYvApnWtuPnS1Cbce2sE0T5R8gHlrJ2/C1mLwShWIKgWiPNOHYQ
         a1gTTFuHST37Xj5AKb2BHy91RXU8+m7wdK5hWbJ49NpglmmijgBgz3mw8Dt+oCV+m5ac
         rk00+lkxnMckvq/J22363yUZoeTnvPVbO+GvSqhNPFdiq2cBtGGUhdJdVqlDRWi6FKo9
         dtLuGvH+GPnp4YSouDS3feuys+LrIJRW95Pw4Nh7KIPSGqIqG7zLLW0dxs1cooNUnEzq
         FgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716750; x=1789321550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CaAy/OOlyYaqWLAHRZ+LDOoXJmE0/3wBUASyxhKepw=;
        b=JnVMZcOi8rAyNhcAAdoD4gulJptlOd1LDZ66hzvO+ZyoMuIT3liGImbjMxLnSU2fxX
         8ZQ14Y1Hka+E3p2K6eICtaEPBZ/mIu53Z+dze9bvMhUiYNtX5XdxgMx/6xP4x5y0rUxD
         SQuO2qOt5HDrzIaXW2DgZXttCN07FaLt3eO+rVeiErmT0LK2//Imb8HqyRDfGUKHgNtM
         wAjdORvKehNOBxF/1MJk2MBH4uPBVygupHqpJYhCuU3RA6mK7cpWsSnRS+b9r1kjlQJf
         1NyjDXWR+YL1/jRyi29dACmkrhOxDvmPa9Z62cxG8Ue31M6kKE3YP1GmDiqPCvk0UXya
         oo3A==
X-Forwarded-Encrypted: i=1; AKwUvBxq4GcYtCUHSwFHtUpoKFB3tF+n6jN+hUjr0QlB+jT/2tKhuI5Kcy/tfcKlH8+Q67HFrbx1/9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kCjaKVsSnNmGdqwbqj/HD6d0eyQl9BG6S0I+mhkWhxpJYnv0Z5
	cSpESm+vwPFEqrKDQnbTpOxZCN3WsPGFJRSVaXCFDh+hvl+jW7wj81P+UlRsaBsGlQU=
X-Gm-Gg: AYBFou15UoEmQSqRjjoCqrr74pZ/SgeW81gOIFXcTmysZBISrW45lUVXj0zMBB5ylm8
	c4XmnjjOWBL4BqUD8T3PxpKcMq0sN5a3eWUXPlGeee2+pe+OrmUDYHUDuWl0Ao9xpyrBKt7IaB1
	ValY+Mf+vSuqpsSAn2YgJoN9k8UuHcD7X4Cugqa0gVcGfW6FZCH3nZk8IKdYFN/sTPmqwVtiKPo
	/6pWyyPX7hA5XQI52osPits2YzlDiYq5OT/tWN1apA1XokS2qT91lOFtYqPHRwLWyelTTUNXO8Y
	EeOtc4IsK6C2a5WkFCBg3td1t9MJ9Sqxr5Y5oKUwDqR98YOmOdRIY742y42gv/UeszX2ct5Bdxo
	l38TumZZcypDHlK+kEp69Ug0f6J601f80Lmf1B9jdWmuvH9hLPJi72g3rFkaRQMUgI98CdDMjcl
	PEY1fXq+5Fm9HqXuHkcHBEv/MZXvYJec2FVFIXwTg=
X-Received: by 2002:a05:600c:3b1f:b0:49c:ee06:9c58 with SMTP id 5b1f17b1804b1-49cf821eff7mr182941215e9.4.1788716750222;
        Sun, 06 Sep 2026 10:45:50 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm245418805e9.0.2026.09.06.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:45:49 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/7] dt-bindings: net: add Airoha EN8811H PHY MCU
Date: Sun,  6 Sep 2026 17:45:37 +0000
Message-ID: <20260906174548.4106801-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788711797.git.f@lex.la>
References: <cover.1788711797.git.f@lex.la>
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
 .../bindings/net/airoha,en8811h-mcu.yaml      | 117 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
new file mode 100644
index 000000000000..7be0ab862266
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
@@ -0,0 +1,117 @@
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
+      one address is passed through.
+
+    patternProperties:
+      '^ethernet-phy@[0-9a-f]+$':
+        type: object
+        $ref: ethernet-phy.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reset-gpios: false
+          reset-assert-us: false
+          reset-deassert-us: false
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

