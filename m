Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FA288BA;
	Sun,  5 Jul 2026 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278422; cv=none; b=Yvlyf57Spym2uboISJL6jpn9FVJSYx3LPuFriZhEWE0rjdlx+nHDVR1wKsEJWMcz6BKLT2P2VZZ0hxngGcS1469uYJsP7IoVOqKS/pXco8E1jTnFPFdWhx182ptVm/krrwveJ6F4YdRouSp/b8hDXu+CKBEfftIDfmyU24DyQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278422; c=relaxed/simple;
	bh=btemRyCFyJtptzwcCMXU8qxXO+yMcrNuYz6+RcYQLm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFbz/LDOENCeFQix2FKX67N1+Ca2quJpwwcefBNJh324IFTatf7M1hTWXs/gnYDRpozkkQjZXcxv5XKJe1IbIG1JpEJn4KPBMuq8zFPfj66cD4IC6G7BrpU9v+vNridJAWHaRTKqyEpIHuEgvIFjog7fqhAhVTy71uTQlmN/0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-13 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4gtcRS40rBz3hhTS;
	Sun,  5 Jul 2026 15:06:43 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dt-bindings: net: nfc: samsung,s3fwrn5: add S3NRN4V and clk-req-gpios
Date: Sun,  5 Jul 2026 21:06:19 +0200
Message-ID: <20260705190621.128257-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
References: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S3NRN4V is an S3FWRN5-family NCI NFC controller found e.g. on the
Fairphone 6 (SM7635). Its host interface is NCI over I2C like the
S3FWRN5, but it is not compatible with any of the existing parts, so no
fallback compatible applies: its bootloader speaks a different protocol
and its RF configuration is loaded through a different proprietary
command set.

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

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
Changes in v2:
 - Drop the -i2c bus suffix from the new compatible; the parent bus
   node already implies the interface (Requested by: Conor Dooley).
 - Document the PVDD supply; required for the S3NRN4V, optional for the
   existing parts whose deployed DTs never described a supply.
 - Add an S3NRN4V example exercising clk-req-gpios, clocks and
   pvdd-supply.
 - Make clk-req-gpios depend on clocks.
 - Describe the CLK_REQ pin in hardware terms (what the pin is, not
   what the OS does with it).
 - Rework the commit message: justify the GPIO modelling in hardware
   terms and explain why no fallback compatible applies.
v1: https://lore.kernel.org/20260703202601.78563-2-jorijnvdgraaf@catcrafts.net

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

