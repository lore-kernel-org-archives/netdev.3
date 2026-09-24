Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9439CD1B;
	Thu, 24 Sep 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234665; cv=none; b=V3CotQJjJ51W9Lnk37+EnedYYOanabAh6Sx1/3bgymv4UMImCKIjl+dcGqaj1SKDc/RjC3yceZ/QKZEGmEgCRJOdIycJEz9Fn+NTUWAjs2hFfOrbdu8YvkA9ygvj3W9cZNGDL0TPHRH+2XcPT+BW43nfgAHFdwr5cFzgSyiCDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234665; c=relaxed/simple;
	bh=9V9vHNIqjj/P3V/WD9pUW9DZXjV8gTIAVkCblvj1Xq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsayucT/pofLvtXydI1YvWFcxJNFeLq+QyBPikNlQeRATUSy0XlLOP4GovyVQHBWsFRxjyg6DmmpQv8zR9f4m1SQfePbLvKKFbqW5vizrkhCppM2l7Zn4j2ax2j8hApD9qqinLxehc3rKxtOb9AStD6MhjmpiakfGDaE35iFM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iUeeeNxG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iUeeeNxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234654;
	bh=9V9vHNIqjj/P3V/WD9pUW9DZXjV8gTIAVkCblvj1Xq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iUeeeNxGlLxhJrNz6Ckmi6E+lHfIUobG+yTsZBzxrQZ9X7ui2pdlMglCZAwsJCeSa
	 ZqamKT9HAvUOOwFyFCosYeeQ+MKRaVpKD2lQsHChA4KstkHHN6HK91BMgzA/+eqaaa
	 RnVXiXOfS9yNv2cj0H069w2XsByFnfTx21qFehHW8Dclew1qeCNsZ1HDGvyQPsnPaK
	 dsF/eSembWhWj3IBQvb5B1SyXgueVcl2bW+4tbnnv9MKuGSEZWzwHuu2J2hvig9LY/
	 pZcmQccO2196W/2LyboQEyffS1hyGLimnrtZPJw3hoJ+hB4LMxaZ52GW63C9AC3BsK
	 mEG71nyujNusA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 01F0E17E01D1;
	Thu, 24 Sep 2026 09:24:13 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 09:23:24 +0200
Subject: [PATCH net-next v2 1/7] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-1-430bd74d5ef9@collabora.com>
References: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=4693;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=9V9vHNIqjj/P3V/WD9pUW9DZXjV8gTIAVkCblvj1Xq4=;
 b=fGUZW/haDY37KjFlxcP6MBiJCPKTi48kpDtrvwtppr+sq9WcagdmC+gADaBPpSVMtHy8U1rND
 MR3cKuN5i+SDiXrPB7CuiqLLxyAyf6TYDOQl67cQgtplj9Af+1YvBKe
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add new compatible string and clock definitions for the Ethernet MAC
IP found in MT8189 SoC.

Also, update "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps" property
description to add MT8189 RX/TX delay stage divider values, as they
differ from existing supported SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.yaml    | 87 +++++++++++++++-------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index 3aab21b8e8de..6624dff015f0 100644
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
 
@@ -86,8 +65,10 @@ properties:
       or will round down. Range 0~31*170.
       For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
       or will round down. Range 0~31*550.
-      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a multiple of 290,
-      or will round down. Range 0~31*290.
+      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a
+      multiple of 290, or will round down. Range 0~31*290.
+      For MT8189 RGMII/RMII/MII interface, Allowed value need to
+      be a multiple of 180, or will round down. Range 0~31*180.
 
   mediatek,rx-delay-ps:
     description:
@@ -96,8 +77,10 @@ properties:
       or will round down. Range 0~31*170.
       For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
       or will round down. Range 0~31*550.
-      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a multiple
-      of 290, or will round down. Range 0~31*290.
+      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a
+      multiple of 290, or will round down. Range 0~31*290.
+      For MT8189 RGMII/RMII/MII interface, Allowed value need to
+      be a multiple of 180, or will round down. Range 0~31*180.
 
   mediatek,rmii-rxc:
     type: boolean
@@ -147,6 +130,56 @@ required:
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
+
+        clock-names:
+          items:
+            - const: mac_main
+            - const: ptp_ref
+
 unevaluatedProperties: false
 
 examples:

-- 
2.55.0

