Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700761;
	b=GkG7lq0EJy1cfpdq2JhOA9Za4+Gc7NWbJ4FOzdQcRnzjHFedw2kpMFVFp8GbgQKntWzJ
	 rUqCmLFLGX26VBqje0GfbDEOZ7WRssajD1Lek1ZjCXJ2hk1yxWV5kqtbOmQodPnifP330
	 3ntUR+tra5fsf3hxMOOJEl44rzJoxZA0I7B+ND4gBaJiYAo9pjgm/wXmxyahH2XwIZlyd
	 PNDU8DT6qDCOGS5tmHMyNuVqwftOnLQXvUC5efpDdQBaqIjn88Zv3IJD1VJG6URpefvcK
	 +CZ6/NLBpa06WvBBvB+tt1el8vAWf7thVwDLg9Ehp3KT+fhItzMlAcMm/m/FrrP6kMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700761;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rmU0lOMI73VyRNzdBu44GHmLmeTwCCxZpA5Js0VgXVc=;
	b=VgPJn9NYkrjqt1uc4t263h1aqucYGQIGWdlTJ65WeGD6hZPa46I6IdrgNSg2Z+xo4H6W
	 OES83Dgh9RINm+28RajA6XXAwQVjmFYrrAbzfjn2LnNZWKvit+7YEpgu52nEPc25xnglL
	 rJY8y/+sJbHmWRUjlm0TFjDfZZx6dTbDuXTcmbUqIjZqQ7TygmMBc4u3tCNL6B/3g+EYW
	 nBJPvzueDoZudTS/utznksFqw2ktCBIPvc/BD+ciHYEL+G6QZ+VAPZkxprzOmwdqHFVvC
	 y9+GMDYg4eV45uo0aCoZEwLbdqAgabKSF7ZINck84VT/t8HqRwHHvEul3cmkm9ew7hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VkGdETdc;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C36606C546;
	Tue,  3 Nov 2026 10:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C36606C546
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VkGdETdc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700759;
	bh=DGyuH1RLL2NLAi4E9FC+VwwNK0cWsuaQH1J59ikPRVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VkGdETdckJt4qpdcHprsdCiU5V0T1sNFT0X4WAMQz21ca/6fPT+DFefRGwoJrV8yg
	 xjgM/MBwy46LdqK4wwoJizqRQdeb0LbFz4Av+7rfDAt72JLbfGo51lyX69tXUtKnFh
	 WbJnKD7RwZUBebclY1Xu8YrJ/tKmJW6f/UqTyvkTucLqD004Y39p92bvf1lvCiiLwo
	 opcJqTmy0/oiA8iXX4tgyHR3m1DFHPlyacY/o5Ovp1lJkZAWsXyLQxC4DvIlkOZpRq
	 DD5WPlme74dEj96isZEEkUIXGgFuktyrrWngnEn9w1xflThqx/Tla3Zm6zkKpPH6CZ
	 koKR0PsMiU9oA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 94FFF17E0A80;
	Tue, 03 Nov 2026 11:12:38 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:08 +0100
Subject: [PATCH net-next v4 03/10] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-3-c86c14fc50f4@collabora.com>
References: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
In-Reply-To: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=3237;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=DGyuH1RLL2NLAi4E9FC+VwwNK0cWsuaQH1J59ikPRVg=;
 b=dSvGCwOf4kMy9Oa/yUSl/XCo+k8Y/LmjUBZjvxw0skoIVWEHfnllD2sfNBjRX8LZI4/qpP8e7
 4lynl0cl/RYAQ4qzd71Lq6d7y93AeXUrT6KZuSa77YX6ur5Yi9ogP1e
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add new compatible string and clock definitions for the Ethernet MAC
IP found in MT8189 SoC.

Regarding the required clocks, the MT8189 datasheets list in the
paragraph related to this IP clocks the mac main and ptp reference
clocks as the ones to turn on.

No specific peripheral clock for Ethernet MAC is described in the SoC
clock list.  But at the same time, the Ethernet MAC block diagram,
present in the datasheets, shows this IP is interconnected to the rest
of SoC with AXI and APB interfaces (and in MT8188 datasheet too).
There is no APB related clock, that is specific to the IP in MT8189,
contrary to MT8188 or MT8195 that have one. But since it is on an APB
bus (likely shared between multiple IPs), then there is a bus clock for
peripheral access. Describing the IP having it makes sense, same thing
for AXI too, so the clock lists for this compatible are reflecting
that.

Also, don't allow mediatek,rmii-clk-from-mac property for MT8189
compatible.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.yaml    | 42 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index 956240616638..0fc2eed06646 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
@@ -20,13 +20,11 @@ select:
         enum:
           - mediatek,mt2712-gmac
           - mediatek,mt8188-gmac
+          - mediatek,mt8189-gmac
           - mediatek,mt8195-gmac
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -36,6 +34,7 @@ properties:
           - const: snps,dwmac-4.20a
       - items:
           - enum:
+              - mediatek,mt8189-gmac
               - mediatek,mt8195-gmac
           - const: snps,dwmac-5.10a
       - items:
@@ -45,7 +44,7 @@ properties:
           - const: snps,dwmac-5.10a
 
   clocks:
-    minItems: 5
+    minItems: 4
     items:
       - description: AXI clock
       - description: APB clock
@@ -55,7 +54,7 @@ properties:
       - description: MAC clock gate
 
   clock-names:
-    minItems: 5
+    minItems: 4
     items:
       - const: axi
       - const: apb
@@ -153,6 +152,39 @@ required:
   - phy-mode
   - mediatek,pericfg
 
+allOf:
+  - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2712-gmac
+              - mediatek,mt8188-gmac
+              - mediatek,mt8195-gmac
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
+        clock-names:
+          minItems: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8189-gmac
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+
+        mediatek,rmii-clk-from-mac: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.56.0

