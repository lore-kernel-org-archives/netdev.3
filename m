Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BD582B95
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883037; cv=none; b=YMsArDdRMcED5ZnBBG4x9neoyAxciN6/QX/ek0+dl6mHSmzy8G+2iA9MJglW3jlf9V7nL+KCczrv+vzgNHF0y5zO/Vqf3+EXorQM7yMQXJDBQk61xcdgQx/An3UXJmzmmbMTi3XkXImZ+f00TinSDcaWvTouWfhivpz++dw0ZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883037; c=relaxed/simple;
	bh=HUiQgG0Ab58RzH7cTOULN/FwqxmG3Zy8ZtGvppbbjQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK/+55cNcB0eLHKqKS600za1kVg3OX91R4LrstsNIJtD80qhwqLEDRol4uBXqgbaJBWaTvSExt1fIPS9+ApGK2MNYJq/C+Oiahg1ysuYYLI0EfmDq827RDvPh+vfpE3l2Evh644+HuhVABFiuL2geLp4zSVsFSexqY65MXPvGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=NJlMwxPL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="NJlMwxPL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48436251906so5389215f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883031; x=1789487831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82jzbCOQ45+MaSZigwp+ZA2kvhC92VJszaAiVh+iTr8=;
        b=NJlMwxPLHxVA0SpxQ4+K6HUYtdhSPnFmkFCkhnGZ7XG6mDwzJEZKG6C4JwMOBzHojp
         fbZx6Z3XEFQjz54LkgoEWStuQdjj6L+7mElzKLg98TudZ2XvJCX3bu9/58Tzz+cSnc4J
         A/cUK5k6yWQnDkiLnYCbtF/ZGjdlAqfUial7qrxFKADY/XJ04uqna6qPqMlAbNmga9Ny
         q61ZBuA10nboB6Ss1/KrX0wnr7PKBlE0ccyQrMnXA7ogYjQ+YfqEaxA/14VVqzAdQ9at
         R/zXatFTC72IsnLD1R3JHKb206fRHEhHA0Hc8Hl5qEe0FpNK0h1SKBMCxNn/+l6KGGfn
         uIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883031; x=1789487831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=82jzbCOQ45+MaSZigwp+ZA2kvhC92VJszaAiVh+iTr8=;
        b=C+6mg4uMIeOthv9WTKFpQSY9S3l63ziVTSfKKiX1qFPh4Z4i60qqXQxxREBStcHxba
         gTi3F5reBQZkZlK7k+6E+luRQcjZv1x23AvSHS5SKs/uyMHpNV8a6s/I3AqkaX+eMjzd
         uYfpurr4kXx+TPJKVqb7iS/I1SmWegW8SN/xCesEQbTqfJgfdEy2pDElKBII0o4kriY7
         f11O2Tf+IABn5bLrAML90WeXULPbs6BnjiFOL30IWk9I0ANinXwcs0i0BBLQfiR/n5Cg
         Hv6sIltTrwQzKix1dZ0SzSocLfHQkpDdgIOABPV9D3Syg6cvz5YoEOj+RegJj+ly7ZF0
         aeoA==
X-Forwarded-Encrypted: i=1; AKwUvBwlgaKYOpxoC7oyatRhmFkhMNGFNxkAIAKRyXzeeL9P1iMlmwAo7clL2jw1MjpLeSgnF0TUu8w=@vger.kernel.org
X-Gm-Message-State: AFuF++m96Sm4Z16YXyzDtIa5h8ttY/nyPoGLxr1ZSJT9nlPj4itsTF0+
	wXWilzP6qKIO+k6qq1npDkWFprG+SI2PJZ+3LX/jMSiBBOmd/+qjHWYMihrZqy4Kz9GQjYuPd0N
	XGCld6tAaBvHW9VA=
X-Gm-Gg: AYBFou3qD7y7XiBC30TAaYhTeATmCGCp9lMFVs77HZE9b7JFC8KPFZSkJ5hbzg4ti2K
	P0+ypXDYpXL0z3PmspiHrQI+n1QBA5zFswpKnzrWS1xxz78TlRZrv6VzbeXYoSlTBKhxRWR17i5
	DYJGf89E9ivK1ybxgOpBdZdeJFTeRc7Q2fx2TD9rTD3xzHI+QRoRllT4O339ZaUMGBwbo3Uuiu0
	u3YbuRVo+tLKdGn74rJtNeg6vaOsLeUnHdE0dyen/yzGv/Q+0nnG/638dEJ/u+arRIf9Ctm3W2Q
	2TjFGmN5WEP9UA+pcgelZ6LnFvJrPBN25A52ixWoMKX35aBD+zmCXFaloPw20ySF83pscfGGcRr
	66VIcE0j4cJgubrwf6zFdTKqhEvi4kNKqcl9P9ZfBjkBTccRF23PNUSgXqgVHhaeXJ6LZ4HJRux
	DKAPiB9mgqeO+5L/vcCFKxdf5NTIwRwVaXY+STeNM=
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id ffacd0b85a97d-4858ad63a6fmr53719486f8f.5.1788883031447;
        Tue, 08 Sep 2026 08:57:11 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm37345704f8f.21.2026.09.08.08.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:11 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 1/7] dt-bindings: net: add Airoha EN8811H PHY MCU
Date: Tue,  8 Sep 2026 15:57:01 +0000
Message-ID: <20260908155707.4164559-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908155707.4164559-1-f@lex.la>
References: <20260908155707.4164559-1-f@lex.la>
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
 .../bindings/net/airoha,en8811h-mcu.yaml      | 119 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
new file mode 100644
index 000000000000..b44331d80315
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
@@ -0,0 +1,119 @@
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

