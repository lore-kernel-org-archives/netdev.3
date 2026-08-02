Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934432931D4
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785664887; cv=none; b=JshWpq7VNaPAHBCyegm6ZkkGySguhZh0+c+3KOZj/ehSuVRXgMeuk34zg3ia/QlaR7Gt7mu1qGv4Mkip0Et57kSFxSdzpr2kl3N3re7HBW+H+aU8I4ytUeE5r8eDWOkZJZK/7bf5Z9j2dN9MhJdQu9NNVNKGhdwUTMJKaddn9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785664887; c=relaxed/simple;
	bh=u7ppirKfLU4ZVz/nEOJZj7e8SzDZbS0KCbHmJCtYC4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyi2+im80pHiZ4qWhRn30wn5f05wOXucwSuaMspGG7CpON997Z0QZWN6BEzEbNlJQlAR4b82OS0VLFrksYDyOi63bBDHEN6N5ClQ1+hSLNJdN9d4MfD+/uwenmHN0BetrYwuYF2xBknxpCwfNsbPsTzZHtIDSpO5Y5g0Tq+5zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSnSugIB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSnSugIB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954afac04bso13668885e9.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785664882; x=1786269682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QonosjSsHGuiSY52r6oXtU1gWhClDfkzKprjwVtzsIY=;
        b=pSnSugIBLzbKihrI6tLvVbVQIajWncuOleL4EgHTVCGwh4iC1T9igZ6V6bnIaQ+/Nw
         CyYPyWpr9hZtTcXoDjAfk69hA1/GtarWKU7tOErCFpBToOkXj3qBewhssHFCSr01W+ji
         ZPVjQa+Ox+Gs6tjAgBBHwbszX8oR3DT5bJpNcuc2zntNEKpPNpQhStxWcw+7DJ5AELgr
         zRR5NW4YH07o3fMW+6IV+BVP8cAIE2wSwlHkjv5T2PtMmBLnSXwrufDe62OXOJW7lyYe
         3u13JmC8BlJQufIlf5ZHjmNwdNOhOa5QCagyk5g6r4bT9fG8jJathNhs73r6g20n6CTU
         E5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785664882; x=1786269682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QonosjSsHGuiSY52r6oXtU1gWhClDfkzKprjwVtzsIY=;
        b=nzbiPDlvsGd7tpdp0D/ek6GCVZnnYxzoSGfSifKDbeL6ihwPMk2ArCNuiisLL+dZoY
         n4KZc3UdzaGtQnHtAaaYF9sLWiTkmm83vWwOXlFHkvGEq1X/kXjJSx1p03S7rOO/YLg1
         BeDQEqOnGTipY4w0pSFC+bmBDRpqx8SQtEXl11KSwNG1r68En9smQCdTMcn3wyO9cAu8
         1sAhcJuTj9b8izpd9ziM0ajk4LqvqfotlTmGP3jnJqrB77KWD+coMe+O96WBqE/60qpR
         Qz1kHF/FA9dv0z5jyWi4M0AeQfD1dxGe70tT3C70KQBzlSAW8JsrA8dTu41A0vdh0FHD
         uD0Q==
X-Gm-Message-State: AOJu0YyM8n/urUybXjv9MPmQG6Or7yZXplFlTXsS5Oub0UGfM1cv0z6Z
	e4ghdNRGo3wB5kCN6ESlkRLNtz2ieRIESt/EU6EtypPxvoEjt4A+fn+o
X-Gm-Gg: AR+sD12Lar6dnA9KGtGps63iq9LC61YuW55KtUtBl8dCPtJw51stel6OCaOmMbylmGZ
	Waqz7EO30MvKekG49bxg2ZLnyjj9BgWBNK1r+Pr7xlixD7GKdRrj64by8eIWt3tzNtUoehF1Qyi
	sBNm4T96rkPdmNFiYXt86yEY14zV4GMJmW8645d3hROXBbVCzJ+XuMDoezExCffqCj9kSxSHk/6
	97llIJPdfocCRY4189L4NuFDKcaiUi7swx5RqsjJ0jfjlkYUtOx2zPE5MEmhCL9ehZstRV324rH
	Qj4lrwN1sWySI/4QQPlIa57AdxwSimF3WKqiKID3hof9BziIIXwoChAhYthc4fBg0nXJpBo07Sc
	hGu0wKsGY2WBiY/q4H/Obt8a8Jqxjeje2Alcoeo6ta6N/EX3YF907IerlD1lOeZCu08SuAuw2WO
	vt9Sxl9euq7Iv/mYkF6Nk0OiHgbcLD6tu2gsyloAd2YwDK64bfm37Idw917YEibSk=
X-Received: by 2002:a05:600c:314f:b0:495:4572:21af with SMTP id 5b1f17b1804b1-4980c673252mr95812175e9.9.1785664881820;
        Sun, 02 Aug 2026 03:01:21 -0700 (PDT)
Received: from builder ([2001:9e8:f117:b116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5b4a2sm140991375e9.1.2026.08.02.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 03:01:21 -0700 (PDT)
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
Subject: [PATCH net-next v11 1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
Date: Sun,  2 Aug 2026 10:01:08 +0000
Message-ID: <20260802100114.720594-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802100114.720594-1-jelonek.jonas@gmail.com>
References: <20260802100114.720594-1-jelonek.jonas@gmail.com>
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

