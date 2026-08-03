Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433343551E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790228; cv=none; b=hluqIc98tf3z48whQ1BbvXRJn+awuabERNRkfUU8i3KKTIHa8YiFUgzxwxrwTy3DEDISzEGBZcLhXreX8oyMPwJ3VpeG9ERYzdW1aCVxTQNT01YDeBoHUF3nupfTEFnz5yZF/1ZufvVrj54j1OWv75T3KY5daUBVRyg3JOE99y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790228; c=relaxed/simple;
	bh=bOdUwZOm3el4ZTYOz7a8pzdsGE5dfIEAW/tE8GDGbGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcClOaatzq6pn7aapuKmbVqAN/KWT3CVJh7etNFURIAIAoj56UNYoSmhA+csDNItt0hSSVd24ExQBs1LQ3rEo/vq/US2lLtu1npkUQoFJLniLxdI/RxqTV/+Q3vEPtsu68sl3OzxWY+qQZPEKCbaFHTNaG7VWy2IJ56ZrSqPPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H26LeBb4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H26LeBb4"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2850246a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790221; x=1786395021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPNeOdiz6uWEqmYyRrHHYQLDd/67o6llgv5ZaCAb9Bk=;
        b=H26LeBb4DOsYCGZFn+YADYc4qGgmOKuZNMZMy48DzhSe+69w6d0aNQ1oxIde14pKYQ
         QPkYek93pQxiQhXZ4Vif8MXIjFqCS5w4hi9Ee/whd7n8F6kSR9kFU5UmFg7Tz8PYxWv8
         xF/yQmV5HRzxbhW/9B85LEMgZJGXRdp+cvwLFwBNSxyQiq8/Y9/eY46Sq+txwsF8JgY+
         zg3YU6kyur0CTBWUSHrW6bZC1PvX+K9rO075FCuwazTVaJvGpS9a488ikndaBS971okv
         hwNhLfwo2ywT7L4RcVDxZbCzyta34jVMdzZjiBWfg0SGy39l6RfZ5jtsZRh+/tU4X/wR
         F/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790221; x=1786395021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPNeOdiz6uWEqmYyRrHHYQLDd/67o6llgv5ZaCAb9Bk=;
        b=oCRJP03APxrMr6pBiHeXKp60GKtANEomkppGgNU+7Hmw+P9UfmX/bZS4bKj7qfYmRh
         1+Ch5YTOJihQHYjcfJD2ZBWS/pF7oubZjKn9JJb7ubg09rv7KsEmyUW0e3aD1db1K9b3
         hw2SIqJTdi8NtF9qaWV99x8BfeNstdZ2gbS+2iYTR9NmPrgjWzZnaXDTxxR+6vD1dCre
         a5ph3736Uo/96lYHTsZBYDi65J85IsX/EJOtopqaoHlY0PBqL8Rh+zFpCg7whwortZBC
         XG9iSIGqwiCKvE6XBhh5QhXve4aVdZr9WE8afmpsBanH7lAqmGuI6E1TzLH5N5VaZqJP
         +mIA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7ys5KPBY+eTadjKDfZGCWatqlLI0ku79d3sh+S7dEfVagl6+EFQKt1L0ZikSDJuxngyRwHac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FUX2o3E3dAnAgz0wzxlqH2Z0k7nN16+Oc7PsrJ1XPrJrJkme
	K2sdklSPBYoCQN0Dy3snQJons8gbOOYIT1PSYpLEDy903uio5blhHBqO
X-Gm-Gg: AR+sD13XUpGkqaWDZU7V/Gdb2EcXaKzMEtzTki8+1UWRzSVTnlMkvU5xg2sRpc7xt2Q
	0C/mVj0H4Zwc50vXNGy1JHtnqJ/ksiHOB8YIb64l49m0teLz/BoBap0KUt78DjkOB4uz9dS9hd9
	9sxF0Lgs9stp6ZCL6gGk4+q7WfMHrL6kn4xYxpwMRQolqkqyuwoNqUAe+SiyhjlA/1Ag/4Hff7S
	OOZHxCC76ri455oe/QhYnTwhC2jZLR/3wkAPyOz0sLZmGzLxuEfT2N10w/l7ZfLjXpN7cdWB+ni
	GA5ubapFK7fNGBEUtr3t1FI0iCc2sGXagaZvtkOUy0MMYykcrFMl3VtO71jmAHifqKLplaKdmUA
	IBI2AsEW/QL6P/cL7SZ/pMIOXmnFN8ETJjmR4KxK3Qrxf5Q0LNK0go6NlrUyiwLem+VY1zxdG6d
	+MVINV+vs2ZAjNRAmmVBvSV1zemkiGtEqxCK8MdtOZesOIIK3Rl5v6OyHiytNGUI/wi9U=
X-Received: by 2002:a05:6a21:1fc4:b0:3c3:c185:f334 with SMTP id adf61e73a8af0-3c92a95073cmr13560180637.66.1785790221259;
        Mon, 03 Aug 2026 13:50:21 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:20 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 1/6] dt-bindings: leds: Add IS32FL3207 controller
Date: Mon,  3 Aug 2026 13:50:06 -0700
Message-ID: <20260803205011.1249-2-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803205011.1249-1-ahmadexp@gmail.com>
References: <20260803205011.1249-1-ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IS32FL3207 is an 18-channel constant-current LED controller
with per-output PWM and current scaling.

Describe I2C addressing, power and shutdown controls, RISET, and
individual or multicolor output groupings. Require board current limits
for each output.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 .../bindings/leds/issi,is32fl3207.yaml        | 208 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml

diff --git a/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml b/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
new file mode 100644
index 000000000..ffb305e9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/issi,is32fl3207.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lumissil IS32FL3207 18-channel LED controller
+
+maintainers:
+  - Ahmad Byagowi <ahmadexp@gmail.com>
+
+description: |
+  The IS32FL3207 is an I2C LED controller with 18 individually controlled
+  constant-current outputs. Each output has 8-bit current scaling. PWM
+  brightness control uses the controller's default 8-bit, 62 kHz mode.
+  Outputs may be exposed as individual LEDs or grouped as multicolor LEDs.
+
+  The data sheet is available at:
+    https://www.lumissil.com/assets/pdf/core/IS32FL3207_DS.pdf
+
+properties:
+  compatible:
+    const: issi,is32fl3207
+
+  reg:
+    enum: [0x34, 0x35, 0x36, 0x37]
+
+  vcc-supply:
+    description: Regulator providing power to the VCC pin.
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to SDB, asserted to enable the controller.
+
+  issi,riset-ohms:
+    minimum: 2000
+    maximum: 76500000
+    description: |
+      Resistance in ohms of the external RISET resistor. The resistor sets the
+      maximum output current according to IOUT(MAX) = 76.5 / RISET amperes.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-9a-f]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 17
+        description: LED output number.
+
+      led-max-microamp:
+        minimum: 1
+        maximum: 38250
+
+      color:
+        not:
+          enum: [8, 9]
+
+      max-brightness:
+        minimum: 1
+        maximum: 255
+
+      default-state:
+        description:
+          The controller is reset during initialization, so an existing state
+          cannot be preserved.
+        enum: ["on", "off"]
+
+      default-brightness:
+        maximum: 255
+
+    required:
+      - reg
+      - led-max-microamp
+
+  "^multi-led@[0-9a-f]+$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 17
+        description: Lowest-numbered LED output used by the group.
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      max-brightness:
+        minimum: 1
+        maximum: 255
+
+      default-state:
+        description:
+          The controller is reset during initialization, so an existing state
+          cannot be preserved.
+        enum: ["on", "off"]
+
+      default-brightness:
+        maximum: 255
+
+    patternProperties:
+      "^led@[0-9a-f]+$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 17
+            description: LED output number.
+
+          led-max-microamp:
+            minimum: 1
+            maximum: 38250
+
+          color:
+            not:
+              enum: [8, 9]
+
+          max-brightness: false
+
+          default-state: false
+
+          default-brightness: false
+
+          retain-state-shutdown: false
+
+        required:
+          - reg
+          - color
+          - led-max-microamp
+
+    required:
+      - reg
+      - "#address-cells"
+      - "#size-cells"
+
+required:
+  - compatible
+  - reg
+  - issi,riset-ohms
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@34 {
+            compatible = "issi,is32fl3207";
+            reg = <0x34>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vcc-supply = <&led_3v3>;
+            enable-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+            issi,riset-ohms = <4700>;
+
+            multi-led@0 {
+                reg = <0>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <8100>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <8100>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <8100>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 932ea1db0..744296f1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13828,6 +13828,12 @@ S:	Maintained
 F:	Documentation/filesystems/isofs.rst
 F:	fs/isofs/
 
+ISSI IS32FL3207 LED DRIVER
+M:	Ahmad Byagowi <ahmadexp@gmail.com>
+L:	linux-leds@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
+
 IT87 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.50.1 (Apple Git-155)

