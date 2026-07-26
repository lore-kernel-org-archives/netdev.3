Received: from MTA-15-3.privateemail.com (MTA-15-3.privateemail.com [198.54.122.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A783E5567;
	Sun, 26 Jul 2026 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104740; cv=none; b=tU1sFCyknsRNXEgSNqnPZgFOtzZ6wY8JgcdEkBhW422oiovyLaSyv873za07yfQrzScyHGXLfLorkFOY4FZ58vn4k5nzp1d2xVh+NIHuWLOuY0MEahrNijzO+UEzv791hNVVQxmgIwGC/Bw6Ml7k1x+NJrxbdwAoMxnygFZkJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104740; c=relaxed/simple;
	bh=xOiXQg7+13RYg0tC70yy9vkhDW5u0fhDIaPlzzVPN/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa+CwZvI1u7pE4/zP8sD9FJ7hnCAUmfvmFbOXzwbV0kwzvwFGS1U0PDiRZKIKYgytG8KROkRzOWOgcRxdgwwjSSPOKJmWpNDC5h/rD0VqXVKuhFMCfUaKB33y/B6sx5MrrAP4H8CkOqUzhTTJV/P/7lKjGkFfK6w32bz2/ymgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4h7brs1Bvbz3hhTF;
	Sun, 26 Jul 2026 18:25:15 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/5] dt-bindings: net: nfc: samsung,s3fwrn5: add S3NRN4V and clk-req-gpios
Date: Mon, 27 Jul 2026 00:24:03 +0200
Message-ID: <20260726222405.153008-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
References: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S3NRN4V is a later part in the Samsung NCI NFC controller line
this binding documents, found e.g. on the Fairphone 6 (SM7635). Its
host interface is NCI over I2C like the S3FWRN5, but it is not
compatible with any of the existing parts, so no fallback compatible
applies: its bootloader speaks a different protocol and its RF
configuration is loaded through a different proprietary command set.

Document the optional clk-req-gpios property: the controller's CLK_REQ
output is asserted for as long as the chip needs its external reference
clock, notably while generating the 13.56 MHz poll carrier. The pin is
a level signal reflecting the chip's current clock demand, not a
one-shot event, so it is modelled as a GPIO. No user of the handshake
is known on the already-supported parts, so the property is restricted
to the S3NRN4V (easily relaxed should one appear), and it depends on
clocks, as its purpose is gating an external clock.

Also document the PVDD supply, the externally switched rail powering
the controller (boards feed it from a PMIC LDO). It is required for the
new device; deployed DTs for the existing parts never described a
supply, so for those it stays optional. Add an example for the new
device exercising the new properties.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 .../bindings/net/nfc/samsung,s3fwrn5.yaml     | 65 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
index 12baee45752c..1e784a90d015 100644
--- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
@@ -14,12 +14,20 @@ properties:
     enum:
       - samsung,s3fwrn5-i2c
       - samsung,s3fwrn82
+      - samsung,s3nrn4v
 
   en-gpios:
     maxItems: 1
     description:
       Output GPIO pin used for enabling/disabling the chip
 
+  clk-req-gpios:
+    maxItems: 1
+    description:
+      Input GPIO pin connected to the controller's CLK_REQ output, which the
+      controller asserts for as long as it requires its external reference
+      clock.
+
   interrupts:
     maxItems: 1
 
@@ -29,6 +37,9 @@ properties:
   clocks:
     maxItems: 1
 
+  pvdd-supply:
+    description: PVDD power supply
+
   wake-gpios:
     maxItems: 1
     description:
@@ -53,17 +64,45 @@ required:
   - en-gpios
   - wake-gpios
 
+# The clock-request handshake gates an external clock, so it needs one.
+dependencies:
+  clk-req-gpios: [ clocks ]
+
 allOf:
   - if:
       properties:
         compatible:
           contains:
-            const: samsung,s3fwrn5-i2c
+            enum:
+              - samsung,s3fwrn5-i2c
+              - samsung,s3nrn4v
     then:
       required:
         - interrupts
         - reg
 
+  # No user of the clock-request handshake is known on the other parts.
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: samsung,s3nrn4v
+    then:
+      properties:
+        clk-req-gpios: false
+
+  # Deployed DTs for the older parts never described a supply, so PVDD is
+  # only required for the new device.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s3nrn4v
+    then:
+      required:
+        - pvdd-supply
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -97,3 +136,27 @@ examples:
 
         };
     };
+  # S3NRN4V with a clock-request gated external clock
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nfc@27 {
+            compatible = "samsung,s3nrn4v";
+            reg = <0x27>;
+
+            interrupt-parent = <&tlmm>;
+            interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+
+            en-gpios = <&tlmm 56 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+            clk-req-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+            clocks = <&rpmhcc 4>;
+            pvdd-supply = <&nfc_pvdd>;
+        };
+    };
-- 
2.55.0

