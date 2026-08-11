Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC87423A79
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439559; cv=none; b=qsvpISZh57f93+nZpVy5YfpRvCHFPHiey3GEFAZIpqlei+R4XqLfLi4pzj72gD1mRHVoyRDNLCCCUCTyaa3TUN6Oc0Bh6RWbyPrMcOEmruQxf6YVJabP0cHGWN1Xd9zt+0Hsj3ef5XRuMmf1xHwrHyxwoLtq3+wi51TlINtM2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439559; c=relaxed/simple;
	bh=AfB3hwTx1xskqIyd/HTsVzwLOu0FSRpO4FosUKJq/ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clcqEDLJq8YwCco/Cb+IEL9ki/LAhbioylT64Z3yGWG7Tsecm7BIj3RQAq58qIvsW6P8213AYKKV+/qBJ+znnr7Dan9NE2UgSs+X8PDHll8JrtMLOF5HLUq/JeSbuJb2jSd1UjZJfsZdRQzdHrQ2jLFYPuykxEuJNv2owL7UEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guyxjFcS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guyxjFcS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49802c418b5so27063985e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439554; x=1787044354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcj1CU8MhHkwIWq3YRgopbt/gvcYI2H3LxV5jJFuXDU=;
        b=guyxjFcS3P3UKrIsmiIrCp2v0dN942Jx71pJjarcIPWkoDUjVC+A4QMspnNJlV+Xek
         G9CXKyOd3jRfLjwhtFxnA0iR2f5JwgtNiAIVEbmRWWhgoZ+u6qx83c2M/wGR89myYKXL
         1YBqcBtL4ubr5z/GPMRISm2121Hm0TceQTsngP/fzOFKOKUqHhXDRMMrU3Q8BjHxA/Mk
         J3egSo7REBgGaJZaTPlnYcVbekPP37uXFXVsBGqLOqW8nJz65DrpXYc1OP4cldkoRUV/
         mraVgEhjE/moZlbQPmDk+uZ+9mvKGCBzdu8pRe21AeWEXhtVlsF9jrFPotoNAITOv+mk
         PiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439554; x=1787044354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcj1CU8MhHkwIWq3YRgopbt/gvcYI2H3LxV5jJFuXDU=;
        b=haP0BOlq0qbmGGJF2qDyG0V6oHM8gLhFj1rlu0lnLPD6UgbOwhsbCR8Ri6/xIRqmFr
         qiKx20j5FbBiCwOW3dP/oOFKUmn3dO0OdQaDkqrzTBgrqz0HkfpOWDrZuLt5HnDgAGG2
         VR3Wr5JQubsckAg956uWRpU5RpvjZYUOZVJRGd15iovtUW2iJ8yEIwhVLa9G3bT69GZt
         zFhweKw58HHO3d8N4AJ/7cV/JSn9azMvap13DkObmT2eQ+CIkbueBrmjBRNbu8nJZjKV
         UU3+wfHxRvnwb7fTbrLP/8eNCJxE/ALsG5UJ9w2q8Eb9hazRXjhw+UgBKsXVu15Z3sZd
         G/CQ==
X-Gm-Message-State: AOJu0YwAbnDfexYLrAv7htkqRn0XR2F0qC+ugUkHj+My7vqsnFz8EInq
	PtU+zIJOZ063L1OY/0LfZiJUEGaHBeS+0O70fFi1IMVNOKJtZkzZUZix
X-Gm-Gg: AR+sD13cHaWPHVLtmpFmy94vid2MchiXJDYhDIR32EP/RwGcu5KTwtGfotdCaotOVeT
	qzI2IvN0y8UbD5yEjKfVuodzTMZayGN5gQcIIYT03JRUvXy2mjn/ufPxBh809dqAS68k7aRTO/S
	O1gTN4Pw/tJotRbVikODGW7uWQu5BtpYtLZoz3CrbVMLSq8AGRqpoqmm5nZAIXx9URHkH1TqXMh
	hmN9DZBk5ZKDFqxtQcFT29P7T7NMl8NvCSXv2PYCVGPS0mtfZOd/3j3p0ZdnGBN7EEURNVB6rew
	thVIBPKEBU/5SBD34WHDsD/NVxkfDualOag8vtaiPHDZm4DmA2B4R+TzBVUq8FJHnfZX3Ez/fqF
	u1+tzCBA+CouqapCFhBUtT/FbPSy8Oo+8NbuntFueYY9DeQO/cRbLdTqwZD0o1cjTiIPmG3H35Q
	9sgPIFWBi3VQFz8De/2d7rX/2MkPbYWENXr7drGA13uANPv7QoxrRrNLSWIvFexsw=
X-Received: by 2002:a05:600c:4f86:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-4997843b3famr25535595e9.8.1786439553657;
        Tue, 11 Aug 2026 02:12:33 -0700 (PDT)
Received: from builder ([2001:9e8:f10e:2116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f17ccsm25738935e9.11.2026.08.11.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:12:33 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Sander Vanheule <sander@svanheule.net>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v13 1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
Date: Tue, 11 Aug 2026 09:12:13 +0000
Message-ID: <20260811091218.353399-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811091218.353399-1-jelonek.jonas@gmail.com>
References: <20260811091218.353399-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for the microcontroller (MCU) that fronts the PSE silicon
on a range of managed Realtek-based switches. The host talks only to the
MCU, over I2C/SMBus or UART, using a fixed message-based protocol; the
PSE chips behind it never appear on the bus.

The device is the MCU together with its Realtek firmware: the firmware
and its host protocol are what the binding describes, not the
general-purpose microcontroller they run on. The PSE silicon behind the
MCU (Realtek or Broadcom) is reported by the MCU and detected at runtime,
so it is not described here - hence the 'realtek' vendor prefix.

Two protocol generations exist, both Realtek's, selected by the
compatible: gen1 on older boards (fronting Broadcom PSE silicon) and gen2,
the altered protocol used with Realtek's own PSE silicon. On an I2C
attachment the framing the MCU firmware expects is part of the compatible
as well - '-smbus' or raw '-i2c'; a UART attachment carries no framing
suffix, as the transport is given by the parent serial node.

Each board additionally carries a device-specific compatible that falls
back to one of the protocol compatibles above. Drivers bind on the
protocol compatible; the device-specific string identifies the board and
reserves a place for a future per-board quirk without having to retrofit
device trees already in the field.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 .../net/pse-pd/realtek,pse-mcu-gen1.yaml      | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
new file mode 100644
index 000000000000..3bb32349c28c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu-gen1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek PSE MCU
+
+maintainers:
+  - Jonas Jelonek <jelonek.jonas@gmail.com>
+
+description: |
+  A microcontroller (MCU) that manages the PSE (Power Sourcing Equipment)
+  hardware on a range of managed PoE switches. The host CPU talks only to
+  this MCU - over I2C/SMBus or UART - using a small message-based protocol;
+  the PSE silicon it drives sits behind the MCU and is never accessed
+  directly. For example, on the Zyxel GS1900-10HP the SoC reaches the MCU
+  over UART, and the MCU manages the on-board PSE chip.
+
+  This binding describes the MCU together with its Realtek firmware: the
+  firmware and its host protocol, which are stable across boards. The
+  microcontroller silicon is a general-purpose part that varies, and the
+  PSE silicon behind the MCU (Realtek RTL823x/RTL8239* or Broadcom
+  BCM59xxx) is reported by the MCU and detected at runtime - neither is
+  named here.
+
+  Two protocol generations exist, both Realtek's:
+    gen1  older boards, where the MCU fronts Broadcom PSE silicon
+    gen2  the altered protocol used with Realtek's own PSE silicon
+
+  On an I2C attachment the framing the MCU firmware expects is part of the
+  compatible: '-smbus' (reads carry a leading command byte and a repeated
+  start) or '-i2c' (bare block writes and reads). A UART attachment carries
+  no framing suffix; the transport is given by the parent 'serial' node.
+
+  Each board additionally carries a device-specific compatible that falls
+  back to one of the protocol compatibles above. Drivers bind on the
+  protocol compatible; the device-specific string identifies the board and
+  reserves a place for a future per-board quirk without having to retrofit
+  device trees already in the field.
+
+properties:
+  compatible:
+    oneOf:
+      # UART
+      - items:
+          - enum:
+              - zyxel,gs1900-10hp-a1-pse
+          - const: realtek,pse-mcu-gen1
+
+      # I2C, SMBus framing
+      - items:
+          - enum:
+              - zyxel,gs1920-24hp-v2-pse
+          - const: realtek,pse-mcu-gen1-smbus
+
+      # UART
+      - items:
+          - enum:
+              - zyxel,gs1900-10hp-b1-pse
+              - zyxel,xmg1915-10ep-pse
+          - const: realtek,pse-mcu-gen2
+
+      # I2C, SMBus framing
+      - items:
+          - enum:
+              - zyxel,xs1930-12hp-pse
+          - const: realtek,pse-mcu-gen2-smbus
+
+      # I2C, raw framing
+      - items:
+          - enum:
+              - linksys,lgs328mpc-v2-pse
+          - const: realtek,pse-mcu-gen2-i2c
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: Reset line of the MCU.
+    maxItems: 1
+
+  disable-ports-gpios:
+    description:
+      Hardware gate that forces all ports into admin-disabled state while
+      asserted.
+    maxItems: 1
+
+required:
+  - compatible
+
+allOf:
+  - $ref: pse-controller.yaml#
+  # A '-smbus'/'-i2c' compatible is an I2C attachment: it has 'reg' and
+  # cannot carry serial bus properties. A bare gen compatible is a UART
+  # attachment: no 'reg', the transport comes from the parent serial node.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,pse-mcu-gen1-smbus
+              - realtek,pse-mcu-gen2-smbus
+              - realtek,pse-mcu-gen2-i2c
+    then:
+      required:
+        - reg
+      properties:
+        current-speed: false
+        max-speed: false
+    else:
+      allOf:
+        - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+      properties:
+        reg: false
+
+unevaluatedProperties: false
+
+examples:
+  # SMBus-framed I2C attachment
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "zyxel,xs1930-12hp-pse", "realtek,pse-mcu-gen2-smbus";
+            reg = <0x20>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
+
+  # Raw-I2C-framed attachment
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "linksys,lgs328mpc-v2-pse", "realtek,pse-mcu-gen2-i2c";
+            reg = <0x20>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
+
+  # UART attachment
+  - |
+    serial {
+        ethernet-pse {
+            compatible = "zyxel,gs1900-10hp-a1-pse", "realtek,pse-mcu-gen1";
+            current-speed = <19200>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.53.0

