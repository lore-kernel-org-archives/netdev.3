Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B2448D15;
	Wed, 29 Jul 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319399; cv=none; b=cMepBdtx0M8PzNU/xES/3CA9rCwaXQ2oclG9GsgZzy8/QBJNBPeQEmj6AKOyIW0WHnXpJ3NIue159voss/TRNfXd+eynlwecfQmQ8SflAFMIW02GQpsgE8sXpJPvlvfxs6O2NkOg4qpCXRTCmsRqN/xbIO9S+waPhjqz/sbkQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319399; c=relaxed/simple;
	bh=bZwCPfz/oC+ZzaJTPsZoph2SeRDJ9CNJ/zw85Kx+nW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gm0lPShSwxuzpZ9tLqUiKBNlYxM4jSjYuJ9IiThnrN4T0wjMCMrvlIv/QRxCViPzcgM+IT+iwfJ5ig7gmY9wf24Bm1tXcEjj2NsAKKNiQd3wnf/ctrSZEi55YeL4yZe3EqgCPNuPMIYQ2YYisbciKfuoMSINjUpB5watvrGe4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JJ0UmwTH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JJ0UmwTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319395;
	bh=bZwCPfz/oC+ZzaJTPsZoph2SeRDJ9CNJ/zw85Kx+nW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JJ0UmwTHH40a1O1rClQYh1EiKh36zqsq/oEVp3oGinYJyWsaqBxIC0wMoRyDc4zsY
	 TF8EMmhqis7Wks9zkeEtHaPdcS+1SbvXLX5QRzWacPfUtGtTIQRfKba29MvZI+gLBj
	 ASxLOMUeQosXkwj9jtVh4KxRMj49aUHgzB6+2GmwBD6szLwSG0AiuEOUHAljL2av2s
	 5EAi/+zFIjfLYn23Z8FHzQxfWH5O08MgL7ks95UuPKJ2sVCEtACm0UVqMKy3K6oJqR
	 WCG5btLr9yGqEZ74jssfDPhqWe7mLMJi2Hx1vTNgZsJgwU4FCQyfX6V9qPHu0iADvY
	 urs75jZQS8JHg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AB0617E08D6;
	Wed, 29 Jul 2026 12:03:14 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:02:49 +0200
Subject: [PATCH v4 05/24] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-5-e356b813a64c@collabora.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
In-Reply-To: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785319387; l=9269;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=bZwCPfz/oC+ZzaJTPsZoph2SeRDJ9CNJ/zw85Kx+nW0=;
 b=1Q02DU76syto9aDhnbnj3YsP3aAalLl8dimwbgBIC9I6nAJfAWnj8EP319qXZLb1tXE0pAGoi
 30d1CdYiLkgBYKfS2MSmw2vkfoTaS+evZrYtrxCMch8x30Tw2yMUoSI
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Regroup the MT8188 clock and system clock dt-bindings into MT8186 ones
to ease maintainability and have common files for several currently
supported SoC or new future ones, that have the same kind of clock
controller design.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml      | 50 +++++++++++-
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |  6 +-
 .../bindings/clock/mediatek,mt8188-clock.yaml      | 93 ----------------------
 .../bindings/clock/mediatek,mt8188-sys-clock.yaml  | 58 --------------
 4 files changed, 54 insertions(+), 153 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index 756b937bb7c4..0bc2da60a601 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/mediatek,mt8186-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek Functional Clock Controller for MT8186
+title: MediaTek Functional Clock Controller for Mediatek SoCs
 
 maintainers:
   - Chun-Jie Chen <chun-jie.chen@mediatek.com>
@@ -35,6 +35,29 @@ properties:
           - mediatek,mt8186-vdecsys
           - mediatek,mt8186-vencsys
           - mediatek,mt8186-wpesys
+          - mediatek,mt8188-adsp-audio26m
+          - mediatek,mt8188-camsys
+          - mediatek,mt8188-camsys-rawa
+          - mediatek,mt8188-camsys-rawb
+          - mediatek,mt8188-camsys-yuva
+          - mediatek,mt8188-camsys-yuvb
+          - mediatek,mt8188-ccusys
+          - mediatek,mt8188-imgsys
+          - mediatek,mt8188-imgsys-wpe1
+          - mediatek,mt8188-imgsys-wpe2
+          - mediatek,mt8188-imgsys-wpe3
+          - mediatek,mt8188-imgsys1-dip-nr
+          - mediatek,mt8188-imgsys1-dip-top
+          - mediatek,mt8188-imp-iic-wrap-c
+          - mediatek,mt8188-imp-iic-wrap-en
+          - mediatek,mt8188-imp-iic-wrap-w
+          - mediatek,mt8188-ipesys
+          - mediatek,mt8188-mfgcfg
+          - mediatek,mt8188-vdecsys
+          - mediatek,mt8188-vdecsys-soc
+          - mediatek,mt8188-vencsys
+          - mediatek,mt8188-wpesys
+          - mediatek,mt8188-wpesys-vpp0
 
   reg:
     maxItems: 1
@@ -42,11 +65,36 @@ properties:
   '#clock-cells':
     const: 1
 
+  '#reset-cells':
+    const: 1
+
 required:
   - compatible
   - reg
   - '#clock-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8188-camsys-rawa
+            - mediatek,mt8188-camsys-rawb
+            - mediatek,mt8188-camsys-yuva
+            - mediatek,mt8188-camsys-yuvb
+            - mediatek,mt8188-imgsys-wpe1
+            - mediatek,mt8188-imgsys-wpe2
+            - mediatek,mt8188-imgsys-wpe3
+            - mediatek,mt8188-imgsys1-dip-nr
+            - mediatek,mt8188-imgsys1-dip-top
+            - mediatek,mt8188-ipesys
+    then:
+      required:
+        - '#reset-cells'
+    else:
+      properties:
+        '#reset-cells': false
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 6733dafbde16..199eac2034f2 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/mediatek,mt8186-sys-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek System Clock Controller for MT8186
+title: MediaTek System Clock Controller for  Mediatek SoCs
 
 maintainers:
   - Chun-Jie Chen <chun-jie.chen@mediatek.com>
@@ -31,6 +31,10 @@ properties:
           - mediatek,mt8186-infracfg_ao
           - mediatek,mt8186-mcusys
           - mediatek,mt8186-topckgen
+          - mediatek,mt8188-apmixedsys
+          - mediatek,mt8188-infracfg-ao
+          - mediatek,mt8188-pericfg-ao
+          - mediatek,mt8188-topckgen
       - const: syscon
 
   reg:
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
deleted file mode 100644
index 5403242545ab..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
+++ /dev/null
@@ -1,93 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8188-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek Functional Clock Controller for MT8188
-
-maintainers:
-  - Garmin Chang <garmin.chang@mediatek.com>
-
-description: |
-  The clock architecture in MediaTek like below
-  PLLs -->
-          dividers -->
-                      muxes
-                           -->
-                              clock gate
-
-  The devices provide clock gate control in different IP blocks.
-
-properties:
-  compatible:
-    enum:
-      - mediatek,mt8188-adsp-audio26m
-      - mediatek,mt8188-camsys
-      - mediatek,mt8188-camsys-rawa
-      - mediatek,mt8188-camsys-rawb
-      - mediatek,mt8188-camsys-yuva
-      - mediatek,mt8188-camsys-yuvb
-      - mediatek,mt8188-ccusys
-      - mediatek,mt8188-imgsys
-      - mediatek,mt8188-imgsys-wpe1
-      - mediatek,mt8188-imgsys-wpe2
-      - mediatek,mt8188-imgsys-wpe3
-      - mediatek,mt8188-imgsys1-dip-nr
-      - mediatek,mt8188-imgsys1-dip-top
-      - mediatek,mt8188-imp-iic-wrap-c
-      - mediatek,mt8188-imp-iic-wrap-en
-      - mediatek,mt8188-imp-iic-wrap-w
-      - mediatek,mt8188-ipesys
-      - mediatek,mt8188-mfgcfg
-      - mediatek,mt8188-vdecsys
-      - mediatek,mt8188-vdecsys-soc
-      - mediatek,mt8188-vencsys
-      - mediatek,mt8188-wpesys
-      - mediatek,mt8188-wpesys-vpp0
-
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-required:
-  - compatible
-  - reg
-  - '#clock-cells'
-
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - mediatek,mt8188-camsys-rawa
-              - mediatek,mt8188-camsys-rawb
-              - mediatek,mt8188-camsys-yuva
-              - mediatek,mt8188-camsys-yuvb
-              - mediatek,mt8188-imgsys-wpe1
-              - mediatek,mt8188-imgsys-wpe2
-              - mediatek,mt8188-imgsys-wpe3
-              - mediatek,mt8188-imgsys1-dip-nr
-              - mediatek,mt8188-imgsys1-dip-top
-              - mediatek,mt8188-ipesys
-
-    then:
-      required:
-        - '#reset-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    clock-controller@11283000 {
-        compatible = "mediatek,mt8188-imp-iic-wrap-c";
-        reg = <0x11283000 0x1000>;
-        #clock-cells = <1>;
-    };
-
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml
deleted file mode 100644
index db13d51a4903..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml
+++ /dev/null
@@ -1,58 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8188-sys-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek System Clock Controller for MT8188
-
-maintainers:
-  - Garmin Chang <garmin.chang@mediatek.com>
-
-description: |
-  The clock architecture in MediaTek like below
-  PLLs -->
-          dividers -->
-                      muxes
-                           -->
-                              clock gate
-
-  The apmixedsys provides most of PLLs which generated from SoC 26m.
-  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
-  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
-  The mcusys provides mux control to select the clock source in AP MCU.
-  The device nodes also provide the system control capacity for configuration.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8188-apmixedsys
-          - mediatek,mt8188-infracfg-ao
-          - mediatek,mt8188-pericfg-ao
-          - mediatek,mt8188-topckgen
-      - const: syscon
-
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-required:
-  - compatible
-  - reg
-  - '#clock-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    clock-controller@10000000 {
-        compatible = "mediatek,mt8188-topckgen", "syscon";
-        reg = <0x10000000 0x1000>;
-        #clock-cells = <1>;
-    };

-- 
2.55.0

