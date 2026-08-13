Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D636D9F9;
	Thu, 13 Aug 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611529; cv=none; b=VShYWFBswJSnhmvHyiCIkXyMteh+b+2fmivwad/KDsQvnwrOu9iWNqf6KSOeKPpB6/thfovR/roye9qpeQg8N3rD56ZaKGhX9WVXU7AXk6VnuT5uiexKZMG2Bjvwlm7wGwPODeZywhhosgjEtFEU4KdNoX0F9L6JpKZHrCyn5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611529; c=relaxed/simple;
	bh=2izXu46JTqwc7ECMQLwEx3srH/UtXbyYI47w0RvLocQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQYNwIg08sFuli9yd9rwDYawF+1qi2i03LPkHAHy9FhYePzFHmAtUELnTWP5sGvrwltorJDWL72uRfoIcrhYJJ8gQ/kzQFnIEfmKX9a1xBGTyQQnAbemMYELl8GTAlin6qZIhLAEwzm09NOSUhPTWdZEkhheLvGuihlY30ssKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=R3v6p5uO; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="R3v6p5uO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 236231F4F6;
	Thu, 13 Aug 2026 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786611508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFGT+wlZ8v/tMI9vsoS1Vyx4Ec5r+ju/y8tc/RnmVTU=;
	b=R3v6p5uOGDKa/2V9kVMHOIybOPa4/b6HIUgsq0Dj6yowTkJYpDnWPY7aeTYrQVuB+wz+e2
	idtRkE2/9VaeRMHgVVq3FIXyPi3ilQ1alHOzmi6MpZtXRaR8ci57b8WRa0biOxDVq9PgPV
	UiHT8gKecsr7sXxXESkezKo8EvVfd1Kv/pyDUFG2AaUCk46+nYo0cH1Yyj+2M+ydxpV14f
	q8qn7ERctw5W7nZI4JGGyyOwRnhysQXdkuQrL2x+34ekMva+Vp9H/r+iNXQ7VdBlQpEypz
	CMk1N/n7fsQqN8KT4Rm8zFnM6MCiECNg4K/5nz5Pl2xUtuK9q0deGmtrDKRMvA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Thu, 13 Aug 2026 10:58:15 +0200
Subject: [PATCH net-next v5 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-wiznet-link-gpio-v5-2-ac8046f24413@marmottus.net>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
In-Reply-To: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTEefOc/klXO7/5PUwgpO9aRGI+MvHJFAt8DwIne0cCoUt3ECEsrJA+BLmH72mDq1CsFMbtDh1wiK9YProHM+4AJcNpDI1DxoHXxzBomKdJoAhzFio4WIF4skfNRCv0QnBTlMatn8lL+un+8XKtAU3pRmsF62Sf7cD6o4B4k9QACUP6Zj9C2LGJv2CCBSayjtsku/gq66ggcCYTKGgAb4gqE282IS+8zKcU/KIAE/6oNSGQxh35K2ERw38WUWtQi99oRjhphiwk7WD6fjDSl/Ta4BKlnEeIExNOZGRKqLT51RhryA/YkA0PNXUuQVWLo5tZJyCoNoc10x1+deWdLRTuSKy0wQW9JNgpydofqzOlIvD+WOyGdBN1AUWUlGQyfF2GKPTMFJ+edCUBnGIZcswCr6l85drmwJS7mbJ2RiucIs1zsIpSUS9Jk4qhb2AKS2Bwwo6sdbNpdsCScjMBd9i3pZ4jrA91Wmrla3Eo3tuuzJD9y4+C8Zw0FGQF6pXD0oGkgPAYQz6L3IFO2+0rNKGxcjakB7NtoXfW7XNUHLO4oYC7XT+vmEwhCMClMjJJUtaFveiCGfH/+Ltc8nm9nr+Z0yhhtf6a5ycPY8cwpRil7iF96WrVeKuZjtDz+PjZGy75WeHtmAaO+z0uWM7keI3QqcY1iHj1FCEYisWipUMSgMQ
X-GND-State: clean

Add an optional link status interrupt which can be connected to the
LINKLED pin on the device to detect link status changes.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 34 ++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 217f301db182..81f4382eb96c 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -15,6 +15,33 @@ description: |
 allOf:
   - $ref: /schemas/net/ethernet-controller.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - wiznet,w5500
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          items:
+            - description: Main interrupt (INT pin on the device).
+            - description:
+                Optional interrupt for link status changes (LINKLED pin on
+                w5500).
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - wiznet,w5100
+              - wiznet,w5200
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Main interrupt (INT pin on the device).
 
 properties:
   compatible:
@@ -23,10 +50,6 @@ properties:
       - wiznet,w5200
       - wiznet,w5500
 
-  interrupts:
-    items:
-      - description: Main interrupt (INT pin on the device).
-
   reg:
     maxItems: 1
 
@@ -59,7 +82,8 @@ examples:
             pinctrl-names = "default";
             pinctrl-0 = <&eth1_pins>;
             interrupt-parent = <&gpio>;
-            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>,
+                         <24 IRQ_TYPE_EDGE_BOTH>;
             spi-max-frequency = <30000000>;
             local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
         };

-- 
2.55.0

