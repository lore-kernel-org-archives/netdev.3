Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05A483BC5;
	Mon, 21 Sep 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987994; cv=none; b=Jl7RI7XGst7ghebgg97RlkB5oknLSVPNDfqesexnQk5j44dAO5S2HN8Ah89y1XUkU9d9LzegHEtisRYCQh5Ku4Dz9rrpuDzoQyGcztEuXqmmGHZBInKXl0j7l/5M9GnJE/lBGKjaCQj4bXa5MUWOGgvE+m4g1HsN0ur/Z8zuc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987994; c=relaxed/simple;
	bh=P6hoLnRrxNgZe/hOkFs0XcLZKF4rcsUXbUU0x4k1rZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pshTvARdEmgq6ORcpGd7qdKVmreiFukEoUo2XUVOnCu+YwtwGIBllhNHsrs1l+q3fi0ULu8IBvmIYUZbeZISmJWF8NDbKEyEinXcnxrOMYYPBtqafEPYXonoevsI+gwY6zLrpzsAqY9zOwRVZDrjXdxabPJB1UbpTStlyl1q8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=mCgcPawv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="mCgcPawv"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 991C53EBC2;
	Mon, 21 Sep 2026 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789987985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJD01rN5UEa3pjfOwFaAzn/OShX3dU5FY+R3aedzBzo=;
	b=mCgcPawvLpkwT+ttoNfkGIMmfXBQTuXKDpvOe7fHUEAR+OCGRXQ/wEa0DRb7+78OjbOY8l
	U0lP81G3jO4jk/LnaeOhC5Slv8KiIQQwpfzUUNHW5XD+cw7jLF0D1ghlWqd+g8/JYTXWIh
	CvNTxerHldGCAV6tPactRo8Pzfcg6IVeaz5i7Feb1t+ncv/saMNE8UEiD8UXS+cqO1Hnpx
	3VvM3M++tHmrZ6MHHEMN3xruIR3w+Nsl7npHI5FLf+qn4Pf2iKVvukIHqrD/SnCIQ41f+c
	NBTg5mWO9u6dwMasohAklI2XR0l+QpAhbXVkx/X//y7YmAiaH2IfYVNR1ODoLw==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Mon, 21 Sep 2026 12:52:50 +0200
Subject: [PATCH net-next v10 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-wiznet-link-gpio-v10-2-5874a7a147a2@marmottus.net>
References: <20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net>
In-Reply-To: <20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF79TOwS9mmcXnbZ89aMqXjMfXPkbMVvwlJSQdL6OHy3EnDHQxy5CVg0148Z5ht1U/nbpU3PZUqLPGOki2C78HdPWNyA3UNSI/wpfQmbu8ISM4xKahczekJ+QatWGsXUK2CxZtL6pGTVYWAPz8FTILv1NkkRpX+1J4bjwSJg7BkKu84yDJWyr0UnV5glwoXY2C+ZZBXZgElWH0cjEmesfetbFq0CDPPdxHzezdaZIyB8Sy17nrRPIPC/TiSxyTaiZ/P0hXV9kiHlPqRXGQkoNXHIKryyanQwCzmHRK1ZDEzDv4BOBPAGn5ydR9A9cV6j3a58wPrKNY1VLzFZcmPWMuyBVBLhJVTX/06b2+KggqUfLuChtrDMUqZn9CtCaPdLt1S2PrKVn24Or2cP9xScL5mspzYbrOpDOqGZsfIx4moai0frGhH6G6/XTgXEuSmU8I8ZINpRnqxrkvc0Wi3PLLOOTJxsMMvFmwhY4Lr+OWX3UOaV+xUF3eK4Xr+MAwai/0kGRTrE/jnUMGVNnOmymAS44mEHXzMXmwKDx20i/l6UKs0DZugXBtNV5esoAkBR6O5yJgpQ3zPgBc76QZBX2uRqkVxR+KBjz0hSem4cCk4iydSixSCv9QmoJBJdxlJOYytrfu/yn9Z08uMK1LXawIVgx30kxOqi4+Ih7cW+DPocQ

Add an optional link status interrupt which can be connected to the
LINKLED pin on the device to detect link status changes. This second
interrupt is only supported on wiznet,w5500.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
v9:
 - Simplify the interrupts description:
  - Describe the 2 interrupts in the top-level properties
  - Limit the maximum number to 1 on non-w5500 with a condition
  - Somehow only adding minItems in the top-level and then describing
    2 items in the if block led to dt checks errors.

v8:
 - Remove Krzysztof Kozlowski reviewed-by tag after Sashiko review
   changes
  - Make the interrupts property conditional

v7:
 - No changes

v6:
 - Fix DT error: use minItems
 - Remove conditional properties

v5:
 - Make the DT interrupts property dynamic from the compatible one
 - Fix DT bindings errors

v4:
 - Update interrupts in DT bindings

v3:
 - Fix DT binding errors

v2:
 - Convert device tree binding to YAML
---
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 34 +++++++++++++++++-----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 25098308eb6e..ac2ee725af5d 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -12,10 +12,6 @@ maintainers:
 description: |
   This is a standalone 10/100 MBit Ethernet controller with SPI interface.
 
-allOf:
-  - $ref: /schemas/net/ethernet-controller.yaml#
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
-
 properties:
   compatible:
     enum:
@@ -24,8 +20,16 @@ properties:
       - wiznet,w5500
 
   interrupts:
-    maxItems: 1
-    description: Main interrupt (INT pin on the device).
+    minItems: 1
+    description:
+      The main interrupt (INT pin) is mandatory on all devices. The w5500
+      additionally supports an optional second interrupt for link status changes
+      (LINKLED pin). If it is not specified, link state changes will not be
+      reported.
+    items:
+      - description: Main interrupt (INT pin on the device).
+      - description:
+          Optional interrupt for link status changes (LINKLED pin on w5500).
 
   reg:
     maxItems: 1
@@ -42,6 +46,21 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - wiznet,w5500
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
@@ -60,7 +79,8 @@ examples:
             pinctrl-names = "default";
             pinctrl-0 = <&eth1_pins>;
             interrupt-parent = <&gpio>;
-            interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+            interrupts = <25 IRQ_TYPE_LEVEL_LOW>,
+                         <24 IRQ_TYPE_EDGE_BOTH>;
             spi-max-frequency = <30000000>;
             local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
         };

-- 
2.55.0

