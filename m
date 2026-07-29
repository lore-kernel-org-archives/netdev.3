Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64A44BCB4;
	Wed, 29 Jul 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319401; cv=none; b=T+Idg6oN12Dzqs8uCTKyH9BJTMOCOIIg2hzuQFD+g/W6fOMV9VCNInHUuDJ/u51lhGKMdBtCmrBpUowMJq/SRnmX9CNabA6EHmka5DEbz+lBWyVLLuGCeQgzWOV5HYS29wtnrUEZC0fjeGoDuq54xnaYV/+oZn5IxVzA8z7D7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319401; c=relaxed/simple;
	bh=QK/z2/OlU9f+haYluWVfeQDHy1ylay/b/2MI0HOuaVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCq02qj7uDel6EdPO+Z9GcW/X/tE2sm64qyTvnRSf4uy1F35zbDiu8NwlmQXHRZ6XiNaIs/beeEpuAS6EWs+q2MDddCyIDvm6I/2owvb7ZzUdDkx7PRTWJ1aS4SrjikDn5xklj2adqFfCXhbTDvwqqgFkg/s+U2COg/JzjmSy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=orQwrAQ2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="orQwrAQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319397;
	bh=QK/z2/OlU9f+haYluWVfeQDHy1ylay/b/2MI0HOuaVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=orQwrAQ2OuL7SWyh+YanvE7N9zQacw8hbAAnIAbb5MNbCgd3MG/wsJ+vsdgIUUYJT
	 MLZmGbFmefC83hwOlHt28mAlhqxa8ODrzj0l13NL7YkeJ8hzFD5g5RgJYdDYiZUVqf
	 TLCEGIuWmxKV0+OOkD6wXgGLC+a9HYEY33rS1JxazjpojJCkqKhl/yYMBbqvWtXKlU
	 xGNYc65KMAq6bUOhaKCZsYruc8mMf9AJSVVlIpVdcfcgEyO3kvV8U4xx3LT+vdkhuQ
	 nl5L0EMWSzGmQ2ETReva111ut/ZbwwDeuRyB8AvMCsB7XAJu66gtAcZPJ4tvy++mQs
	 agXqX3E7LJyDQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D119A17E08D9;
	Wed, 29 Jul 2026 12:03:16 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:02:51 +0200
Subject: [PATCH v4 07/24] dt-bindings: clock: mediatek: regroup MT8195
 dt-bindings into MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-7-e356b813a64c@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785319387; l=12317;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=QK/z2/OlU9f+haYluWVfeQDHy1ylay/b/2MI0HOuaVw=;
 b=98svCEXIFPbC7MRJh605PR0jAYAytfoXYYtSYATFKUKqutniHcLhQZqwicQyA/skt9YVvLis+
 NSqcjgrpMB/BaxV/Nz5b3K76K5cHXBsbIXAK0OT1g8aRlb5sa0E5Dj8
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Regroup the MT8195 clock and system clock dt-bindings into MT8186 ones
to ease maintainability and have common files for several currently
supported SoC or new future ones, that have the same kind of clock
controller design.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml      |  25 +++
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   4 +
 .../bindings/clock/mediatek,mt8195-clock.yaml      | 239 ---------------------
 .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |  77 -------
 4 files changed, 29 insertions(+), 316 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index b5988d122e4d..ab9f8cb7dd6e 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -78,6 +78,31 @@ properties:
           - mediatek,mt8192-vdecsys_soc
           - mediatek,mt8192-vdecsys
           - mediatek,mt8192-vencsys
+          - mediatek,mt8195-apusys_pll
+          - mediatek,mt8195-camsys
+          - mediatek,mt8195-camsys_rawa
+          - mediatek,mt8195-camsys_yuva
+          - mediatek,mt8195-camsys_rawb
+          - mediatek,mt8195-camsys_yuvb
+          - mediatek,mt8195-camsys_mraw
+          - mediatek,mt8195-ccusys
+          - mediatek,mt8195-imgsys
+          - mediatek,mt8195-imgsys1_dip_top
+          - mediatek,mt8195-imgsys1_dip_nr
+          - mediatek,mt8195-imgsys1_wpe
+          - mediatek,mt8195-imp_iic_wrap_s
+          - mediatek,mt8195-imp_iic_wrap_w
+          - mediatek,mt8195-ipesys
+          - mediatek,mt8195-mfgcfg
+          - mediatek,mt8195-scp_adsp
+          - mediatek,mt8195-vdecsys_soc
+          - mediatek,mt8195-vdecsys
+          - mediatek,mt8195-vdecsys_core1
+          - mediatek,mt8195-vencsys
+          - mediatek,mt8195-vencsys_core1
+          - mediatek,mt8195-wpesys
+          - mediatek,mt8195-wpesys_vpp0
+          - mediatek,mt8195-wpesys_vpp1
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 41b8c61132e2..4a9d3eea4316 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -39,6 +39,10 @@ properties:
           - mediatek,mt8192-infracfg
           - mediatek,mt8192-pericfg
           - mediatek,mt8192-topckgen
+          - mediatek,mt8195-apmixedsys
+          - mediatek,mt8195-infracfg_ao
+          - mediatek,mt8195-pericfg_ao
+          - mediatek,mt8195-topckgen
       - const: syscon
 
   reg:
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
deleted file mode 100644
index 94dd29c2396c..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
+++ /dev/null
@@ -1,239 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8195-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek Functional Clock Controller for MT8195
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The clock architecture in Mediatek like below
-  PLLs -->
-          dividers -->
-                      muxes
-                           -->
-                              clock gate
-
-  The devices except apusys_pll provide clock gate control in different IP blocks.
-  The apusys_pll provides Plls which generated from SoC 26m for AI Processing Unit.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8195-scp_adsp
-          - mediatek,mt8195-imp_iic_wrap_s
-          - mediatek,mt8195-imp_iic_wrap_w
-          - mediatek,mt8195-mfgcfg
-          - mediatek,mt8195-wpesys
-          - mediatek,mt8195-wpesys_vpp0
-          - mediatek,mt8195-wpesys_vpp1
-          - mediatek,mt8195-imgsys
-          - mediatek,mt8195-imgsys1_dip_top
-          - mediatek,mt8195-imgsys1_dip_nr
-          - mediatek,mt8195-imgsys1_wpe
-          - mediatek,mt8195-ipesys
-          - mediatek,mt8195-camsys
-          - mediatek,mt8195-camsys_rawa
-          - mediatek,mt8195-camsys_yuva
-          - mediatek,mt8195-camsys_rawb
-          - mediatek,mt8195-camsys_yuvb
-          - mediatek,mt8195-camsys_mraw
-          - mediatek,mt8195-ccusys
-          - mediatek,mt8195-vdecsys_soc
-          - mediatek,mt8195-vdecsys
-          - mediatek,mt8195-vdecsys_core1
-          - mediatek,mt8195-vencsys
-          - mediatek,mt8195-vencsys_core1
-          - mediatek,mt8195-apusys_pll
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
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
-    scp_adsp: clock-controller@10720000 {
-        compatible = "mediatek,mt8195-scp_adsp";
-        reg = <0x10720000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_s: clock-controller@11d03000 {
-        compatible = "mediatek,mt8195-imp_iic_wrap_s";
-        reg = <0x11d03000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_w: clock-controller@11e05000 {
-        compatible = "mediatek,mt8195-imp_iic_wrap_w";
-        reg = <0x11e05000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    mfgcfg: clock-controller@13fbf000 {
-        compatible = "mediatek,mt8195-mfgcfg";
-        reg = <0x13fbf000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    wpesys: clock-controller@14e00000 {
-        compatible = "mediatek,mt8195-wpesys";
-        reg = <0x14e00000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    wpesys_vpp0: clock-controller@14e02000 {
-        compatible = "mediatek,mt8195-wpesys_vpp0";
-        reg = <0x14e02000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    wpesys_vpp1: clock-controller@14e03000 {
-        compatible = "mediatek,mt8195-wpesys_vpp1";
-        reg = <0x14e03000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys: clock-controller@15000000 {
-        compatible = "mediatek,mt8195-imgsys";
-        reg = <0x15000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys1_dip_top: clock-controller@15110000 {
-        compatible = "mediatek,mt8195-imgsys1_dip_top";
-        reg = <0x15110000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys1_dip_nr: clock-controller@15130000 {
-        compatible = "mediatek,mt8195-imgsys1_dip_nr";
-        reg = <0x15130000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys1_wpe: clock-controller@15220000 {
-        compatible = "mediatek,mt8195-imgsys1_wpe";
-        reg = <0x15220000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    ipesys: clock-controller@15330000 {
-        compatible = "mediatek,mt8195-ipesys";
-        reg = <0x15330000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys: clock-controller@16000000 {
-        compatible = "mediatek,mt8195-camsys";
-        reg = <0x16000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawa: clock-controller@1604f000 {
-        compatible = "mediatek,mt8195-camsys_rawa";
-        reg = <0x1604f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_yuva: clock-controller@1606f000 {
-        compatible = "mediatek,mt8195-camsys_yuva";
-        reg = <0x1606f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawb: clock-controller@1608f000 {
-        compatible = "mediatek,mt8195-camsys_rawb";
-        reg = <0x1608f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_yuvb: clock-controller@160af000 {
-        compatible = "mediatek,mt8195-camsys_yuvb";
-        reg = <0x160af000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_mraw: clock-controller@16140000 {
-        compatible = "mediatek,mt8195-camsys_mraw";
-        reg = <0x16140000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    ccusys: clock-controller@17200000 {
-        compatible = "mediatek,mt8195-ccusys";
-        reg = <0x17200000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys_soc: clock-controller@1800f000 {
-        compatible = "mediatek,mt8195-vdecsys_soc";
-        reg = <0x1800f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys: clock-controller@1802f000 {
-        compatible = "mediatek,mt8195-vdecsys";
-        reg = <0x1802f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys_core1: clock-controller@1803f000 {
-        compatible = "mediatek,mt8195-vdecsys_core1";
-        reg = <0x1803f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vencsys: clock-controller@1a000000 {
-        compatible = "mediatek,mt8195-vencsys";
-        reg = <0x1a000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vencsys_core1: clock-controller@1b000000 {
-        compatible = "mediatek,mt8195-vencsys_core1";
-        reg = <0x1b000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    apusys_pll: clock-controller@190f3000 {
-        compatible = "mediatek,mt8195-apusys_pll";
-        reg = <0x190f3000 0x1000>;
-        #clock-cells = <1>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
deleted file mode 100644
index ba1b36fa0169..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
+++ /dev/null
@@ -1,77 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek System Clock Controller for MT8195
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The clock architecture in Mediatek like below
-  PLLs -->
-          dividers -->
-                      muxes
-                           -->
-                              clock gate
-
-  The apmixedsys provides most of PLLs which generated from SoC 26m.
-  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
-  The infracfg_ao and pericfg_ao provides clock gate in peripheral and infrastructure IP blocks.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8195-topckgen
-          - mediatek,mt8195-infracfg_ao
-          - mediatek,mt8195-apmixedsys
-          - mediatek,mt8195-pericfg_ao
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
-    topckgen: syscon@10000000 {
-        compatible = "mediatek,mt8195-topckgen", "syscon";
-        reg = <0x10000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    infracfg_ao: syscon@10001000 {
-        compatible = "mediatek,mt8195-infracfg_ao", "syscon";
-        reg = <0x10001000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    apmixedsys: syscon@1000c000 {
-        compatible = "mediatek,mt8195-apmixedsys", "syscon";
-        reg = <0x1000c000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    pericfg_ao: syscon@11003000 {
-        compatible = "mediatek,mt8195-pericfg_ao", "syscon";
-        reg = <0x11003000 0x1000>;
-        #clock-cells = <1>;
-    };

-- 
2.55.0

