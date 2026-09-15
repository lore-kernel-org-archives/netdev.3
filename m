Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACC361668;
	Tue, 15 Sep 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459589; cv=none; b=uSpBO7mBSAXytdrNpHSe6AQCUG78lO/lWjR2MbH4GuEBdu/uC98l0Scm+sffUwgYHkQUTGU5/dGpoVnSPbZlPfRlP4H75bVRq28R8TpTYfVXlMk7dsnY8iYX57vPzTCiBcQG4Uw+LzctJsxS+Q2XVNbu/Iil1KoPW8Nlf9MS8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459589; c=relaxed/simple;
	bh=0UtIK4EWaEM5NyLfWC9AQHfi3cx+W4riJmN7gPYqazU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5hHOjlNgyesIyTXu75punBs5AXB2SiVneHE2qqrgNCooMWZao3PHL+SkkVTDW4Sgs+PDPYxrzrNaVm3EAW1YNEeu7bRpXZStSBPXwAWPTbBTqmxS+Df3N6BMeIpri0xwXl7NRpzIZ9aaM/dqzcV4ig1BkjLJvaKR+naP9Y0NtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=g/xpKYEg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="g/xpKYEg"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 308F83EDE1;
	Tue, 15 Sep 2026 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789459579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjp8PjXiAnLAmgWmDr7CM8wc83Z7ba0mT6o7NJd+Dv0=;
	b=g/xpKYEgVTl9Y+YC+g6ZryBRi3HeskV5U7z+Gd/XqOsv7ra6nbKEcSo46YPzNvvgT+drJC
	G/59HHj8u+mo9NcxDx/DDWi4xhQVTwORLcATwuoVXv6Z1J2knt53jea7od54PNLwsOH5bb
	QYIGiTT0s0HJu3NkeKzB/MzG4/LNGFpiNi56NAZejgJoJrix40m/clbZfx1y/8PA2ANYM2
	t4WjDGZZY3D3EcjZk/qLqwg8iWck/nvZUpRNKkv4C66kv0lo2pzKWRQMuaJNpex74ITpv0
	zDsSroFjeTxOKph+W+xKJIwIj4BUhRdvakhqmKlAuv30MQa2U8eYS7C5Bif0rQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Tue, 15 Sep 2026 10:06:03 +0200
Subject: [PATCH net-next v8 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-wiznet-link-gpio-v8-2-d173622474cc@marmottus.net>
References: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
In-Reply-To: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
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
X-GND-Cause: dmFkZTFAFqprjYmMpGKftCTkYlbk5kdK4l8Fitu7zs4+KBA0m8t3VRCs8xUf9+CZ5U3qNYjJxsUJwkHFm6CTcIxkrUixEh9MRSgg+b+3GEgRVe5rGxdkPxTUXurRaic+wE2+hLOnmGcr/adm+W6FlAeH+y8E/wnjtu9WluIC4LFUQWUCjN5rGuBUOIxMySz0myLCeSuyrzkg/LXvW4ECcruBfdzuWPCZwp6ZINeRnspLS9TpE5Yd/tynzLutmhfM0brccBXPAVxNesNx0XZY7/j/f+G1m4k5L9tNogzM4K5fCyjvtneZA9frkKyXLiznFGo2i+z3w4FUXo7q2gbFgrem5XnCi+9CkF8DkIA3TwdKC259mZjyvgtUJ8nlXrwETJlI4ErBnq3K503rAcYSfd4ldDha0bktGAjExBWdkB+tjVaVSbNm24ehAZiradpdQE8nR3kmMz76V9gmQLN+aolve/tzCDiklA1mTDt4XbJvPcNuXft6eN+FyHaiPVjuA0HoNp65evUFEBNiPv20q9jBKhGDA92aMTNwK0GdZC2zMBaigiWmR4YToMeUPx1P1QkCAia/IffwYK5C5idA5WwpmrNriQzavRlVxhnhWehWP3GkVxf40BS359FjgYUef6QO9js8ogeYuPb9ZZA6H4Z1FZD0h97q6a/iHukMEsAaXQF+aw

Add an optional link status interrupt which can be connected to the
LINKLED pin on the device to detect link status changes. This second
interrupt is only supported on wiznet,w5500.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
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
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 38 ++++++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 25098308eb6e..da03f4e07f29 100644
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
@@ -24,8 +20,11 @@ properties:
       - wiznet,w5500
 
   interrupts:
-    maxItems: 1
-    description: Main interrupt (INT pin on the device).
+    description:
+      The main interrupt (INT pin) is mandatory on all devices. The w5500
+      additionally supports an optional second interrupt for link status changes
+      (LINKLED pin). If it is not specified, link state changes will not be
+      reported.
 
   reg:
     maxItems: 1
@@ -42,6 +41,30 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+          description: Main interrupt (INT pin on the device).
+
 unevaluatedProperties: false
 
 examples:
@@ -60,7 +83,8 @@ examples:
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

