Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839304FDA7C;
	Fri, 18 Sep 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744452; cv=none; b=TJjI5ozMZoXew/Foeg/iQzdLsY/XoQQI8WlM2+6MVdX1BhlT60Le0LxQXXWtyzCpZ58MtGyiQJnuy3Wv11ws1j1wrkoYX7gg4OE/bwKFTf66/H8McktgnUfmvRVSZck29pSgymlnkWLEclc+wqwRqn+vqUdPuPSyS1cMk1jf5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744452; c=relaxed/simple;
	bh=P6hoLnRrxNgZe/hOkFs0XcLZKF4rcsUXbUU0x4k1rZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbMQlTIt336l6hhtvhv9ozLVlWUEWmZJdT7avpSwVbItqF18Vr4czzT1UA9MT2K1NNt0aeK/TeyyriNMsv7vjuaISSovPknmC/SdCNwgWu4Di9KApYY2RhWkPYy5+8+7pcQgNRIhepXTtmfDn6DqvNgCvFeb7TOLvph9CIk9Rnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=XqnzOqhM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="XqnzOqhM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1291B3E994;
	Fri, 18 Sep 2026 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789744448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJD01rN5UEa3pjfOwFaAzn/OShX3dU5FY+R3aedzBzo=;
	b=XqnzOqhMWivqqI7W9QTW3hpBr1wvFfcMYDKluK1Vyy2vrJXi4x7jbs8KsSTEV1ycSx6GZR
	XkJeSsaB+8GLb0uzu19jxzO1vYoSRpywHlprGMsKJBAw5+Z8CK2QWFziq9vfrdWE/e9d87
	l8SA7XAY1L8pPW/EH9P4yCbKnzPQLyH2Sxkzw2NI1iQOuaF76nsorxjmBvVRo4jfP4EVJ6
	fuEheebvRPLOisWr4xmi8ZePtyGYHRqYQMzbxoV6ZTToF1kDbngFSVUg2rgB04ERRbrMeK
	abw33LEpkvEGzRK4f43Sll33ma30HsqaeZDJk1NNGF3aTSGQONzpqPUac6ILYw==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Fri, 18 Sep 2026 17:13:54 +0200
Subject: [PATCH net-next v9 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-wiznet-link-gpio-v9-2-5536f24d8d6d@marmottus.net>
References: <20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net>
In-Reply-To: <20260918-wiznet-link-gpio-v9-0-5536f24d8d6d@marmottus.net>
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
X-GND-Cause: dmFkZTFS2sth9ps5Z787jmCwf5jUB4saRsy3OjoHb9M4YNA5CDF7I2Mi7BiMfC9+pXRW620mnrspKoKpuOc0KfwAyeWCVCbV9ihLJRxo8ERcxkmdm2DobYI3tVzkDTrt9anaHq9cTSwZq2hofIYHMnYhpdKVL/i+8qiX3vs6lJPcKpu1NGUXorkAEbog0SmgQ04AmGgqICTJVuJmwGqWEHBDoO6GwMfFN2nybgVOhoOZt9dogl9n011JuRx7lK1oLSNPM1QpWV+kQddhVCNqhKijs6Cz5AK23nglakh+K2j6VL4/OavLC4HjoRLI2pYkHkstuapRWIfXpBsbycJgXrXKqb1fICiVbX3hIeWoBrAIvlvPunwgVKS69+SFpGCPYaUI1ORnDunXpySvmZnCsRfNYdLQiIStrBSmZIqZAzDJH09gSwLBkD1iYAUpcWqJXFVdAtp//7HNia5PYeCf65xal76SwalU5NCx2xJNOxXrC35hshGc59TSM9FlHIkUpXQA/M1ICsgzv3aCd73DJGEBsfe7TasM80sgYlDMUYxL6bujpSL0FOY72dE6hFsoJTKJnKDqvo3tvww1EhnXI1J9Yt/ghAsh+Xvd9DyDvNSIxdbNZoJzZQ1QhcDrlUnKvunIFYwFgVrmXTkyTBj23m6eiVaMUg1GeJGOBDm3VX0imeHU/Q

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

