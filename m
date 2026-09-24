Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958640BCD8;
	Thu, 24 Sep 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243324; cv=none; b=YRgHYWqurcng3ohRgoSe3wDB8CFLRrnA2OVOu0H8zB8OGMo2TMn0kDm7uydV1mbTpGxV1/n/Q6r9Wife+4c/YsypcFFmCcglCyZ1J4AOydcs7qtvTutYi8UhvE7qQU6ppqp7Egn/qJe/4yrrWa4anb9nFLBpy3gomUlu7jM7lVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243324; c=relaxed/simple;
	bh=HGWHw0+YsN2VQstzvhMpaUDdm5nfsbF4QCXSXxbvO7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxTgyP8e1bcF/VmGWpmK2M7uUoEA2P681O0spCqt2ALlKdw8OwrSlNKi0nzy3rw/gHr/iQAIYocwG4p6EOkRDbQAjPX0rToUvupM0RRuqD3vA4a2EDIQis+simuvmnYa3sRfm212bHzy4ZGUqkogkIPNlxh9PQ3jrHFCX8DwSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=F1Lkf6lA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="F1Lkf6lA"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C6453EBCA;
	Thu, 24 Sep 2026 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790243307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7G/mzknT0LdlsJFiO3EI1X6z4fxbyYMkEyPcMVpFzw=;
	b=F1Lkf6lAuYcBw8M9acyDJhqD8jg6X/veXpz9i6Dq279RxzU1iPRhIzJ8VHEm3gkpKmlJw3
	DObIoRO4/SjHQaPxWhuSPIZoIaVZ/nHWg6Mj7Edgy5qDF8wL++zt1ThAfkQ4cI/xseZXtY
	NV3TnWns8bp2sRT56YOabJp+4G6GsMKhea15bP4KDVZYDLCGic2m8XRMcrL2ZmNi79KXMO
	bOvzrM6tRw6sE5C+kOlJt3GYAw/32vtg1X8jnch8VGXCn4//BnIIm+KecMQr0AylMYVqBj
	Yc28c/qMhcCUhiaGwQGrp4XLNXGzhwLymlzxBxTswE6dtWjJDmrJHmACYem1XQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Thu, 24 Sep 2026 11:48:12 +0200
Subject: [PATCH net-next v11 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-wiznet-link-gpio-v11-2-42a332517b30@marmottus.net>
References: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
In-Reply-To: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
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
X-GND-Cause: dmFkZTEjLBf4y4Siu2iwbVH18d6vixFRfFlkBwnrNIfLoSiA6THOUXuxHkCV+kQPJfUtihY6IS07ihrBNpGO3LGviKc8LNOMkRXeypMNfcSrxd/tEVy/2UL7m3p76A2/5L7PXQmchic95PSAdePrNfeZCpoZnndGEQuruoUHGybRCkhO8TFtPAyVI7xG6aVoCvCniKf8YFsF70iaOmF+TacJLIPSipNytlQp6WYWen187J93xlN5AIu6PGrrGVNaOcHto+MJMr/Xgm+ad7VVrUquD2gf85seYuuN0CIVVemdURze1E4QBKtVu8L3+cXcVAAuOhiRsdSlPRqxcMUKOEpSGF/UdNDXuICNMdVUULFtNf/9kEHWirb99j+WFxeFhZ87zmS/YUWMYMdpAs/lfwPQIx3h8yYRFtFKNgz3cojHZuXUx4PERoqJzwSA07Mskgw8TdQ79V5oxwJZ2XXp1KPcViNo3vmiwGIx3aQzD2rGIYT5crMnnxORvQSm/+orhVC0VRzKCQ0nMK0oIHI/ZUIXRA5dIRIJ3qhodDDso+/MxWZkKdkVdUa/KUifrvRF/7rA7XRYijHWbKPKNouh0u5DZy4ASs9VzA1r5qNFcOrw1zy96nW4hCHfJuhAJRJHTkVAbPhbZ/ADP/P/CvMpFb38TJxdz0AeCJGUJmjrz/qDsp3Bwg

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
index df83f90b3919..b0d1e1d699dc 100644
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
@@ -58,7 +77,8 @@ examples:
             compatible = "wiznet,w5500";
             reg = <0>;
             interrupt-parent = <&gpio>;
-            interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+            interrupts = <25 IRQ_TYPE_LEVEL_LOW>,
+                         <24 IRQ_TYPE_EDGE_BOTH>;
             local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
             pinctrl-0 = <&eth1_pins>;
             pinctrl-names = "default";

-- 
2.55.0

