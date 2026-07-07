Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965D3101B6;
	Tue,  7 Jul 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412500; cv=none; b=QxPb74K2x56VaQbYbMuIPBiwKCxnX6pF2qnQjAPj9s63rGB3v+oLGdqCysqr99MpWINbLogt452rz9XQbFFrDf927cLHT40rnjyzxlUAYQMQ8+RZzgIuEBN3/IDMlmxUpVLiGbSdJStRZx7e2PHgRUshkc8TMItuV8L6yP3oiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412500; c=relaxed/simple;
	bh=bH9Gs0qF0keeUPajExUcfUVpg+DQrsbg/viTr25L8LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmqsP3vJFW//2n29ugGL1zhrRAE1nu/6Zu6OyNsOsDQsyMn8DUMxh2Nd8/7x7025ZXONgFfJDoN3LJWou7zbxdLh6WTltVWG6S2Qog4hmECoSV933n2LtBunn2vuQ0RlSsvCaZigSY55tDySjdaOYJeUSfJ1hzogs83BnGMIy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FYuXXy8x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FYuXXy8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783412496;
	bh=bH9Gs0qF0keeUPajExUcfUVpg+DQrsbg/viTr25L8LI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FYuXXy8xaODgicQa0bDQdSq4Vr4LREoEZC1shF5oKZQIwiXMUo2DnIVMgsMwwtuqY
	 snJt/6M96H690QoAhDNNXvSPBpz2eN7Pxj8Mm+DRXEn3/nwhbf+LaKdWLXqaThWzuv
	 jPhgoE5e+ngG4g+MZLLXBiibQlJM5AJqWbUg0RaV9l6OsWCFHLFHttsuJU3pN2iCUy
	 SQ+aHmWmWFH3hrXRaFkWJJXLjgvQ8d5cHCRiCU/ETbZ82XbeFVV4eJ9acF5MLd1DSx
	 H4kgctMUI+TYWrMLJXo0yM30hP2JImZ+A99CQgRaT9qMCpw6+x2dnVXqGY78OQoc7S
	 Pn6f6ZfmwK8+g==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EFF9C17E0795;
	Tue, 07 Jul 2026 10:21:34 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 07 Jul 2026 10:21:19 +0200
Subject: [PATCH net-next 1/6] dt-bindings: net: mediatek-dwmac: add support
 for MT8189 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk, 
 kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783412493; l=3289;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=bH9Gs0qF0keeUPajExUcfUVpg+DQrsbg/viTr25L8LI=;
 b=gCeukStCgJ3WFlJpW6pSIe620a8nm6VrzleEOcXfvUlIOJwl6YLnEWPDvr7+fO9EMzCYz/QF7
 STF4dpk3ltvBOAKfg+6sYokZWxenb11nexxLATn8UxgFzR+vNWEf9lQ
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add new compatible string and clock definitions for the Ethernet MAC
IP found in MT8189 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.yaml    | 77 +++++++++++++++-------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index 3aab21b8e8de..000abec023b3 100644
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
@@ -44,26 +43,6 @@ properties:
           - const: mediatek,mt8195-gmac
           - const: snps,dwmac-5.10a
 
-  clocks:
-    minItems: 5
-    items:
-      - description: AXI clock
-      - description: APB clock
-      - description: MAC Main clock
-      - description: PTP clock
-      - description: RMII reference clock provided by MAC
-      - description: MAC clock gate
-
-  clock-names:
-    minItems: 5
-    items:
-      - const: axi
-      - const: apb
-      - const: mac_main
-      - const: ptp_ref
-      - const: rmii_internal
-      - const: mac_cg
-
   interrupts:
     maxItems: 1
 
@@ -147,6 +126,58 @@ required:
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
+          items:
+            - description: AXI clock
+            - description: APB clock
+            - description: MAC Main clock
+            - description: PTP clock
+            - description: RMII reference clock provided by MAC
+            - description: MAC clock gate
+
+        clock-names:
+          minItems: 5
+          items:
+            - const: axi
+            - const: apb
+            - const: mac_main
+            - const: ptp_ref
+            - const: rmii_internal
+            - const: mac_cg
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
+          items:
+            - description: MAC Main clock
+            - description: PTP clock
+            - description: RMII reference clock provided by MAC
+
+        clock-names:
+          items:
+            - const: mac_main
+            - const: ptp_ref
+            - const: rmii_internal
+
 unevaluatedProperties: false
 
 examples:

-- 
2.55.0

