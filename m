Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805A437878;
	Sat,  1 Aug 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583276; cv=none; b=RtXZQV5jXFNTPwvGI+fEhA0D4F5hJSRYnWHYDJP9/tkpFiqP0lJmBY69rHNMJ3cP9dx9NRAA9z80KCsPGLLzkXXM0G4eskJq51d+nVa3yjtg/n8sg3Lp1c/viGIhMsDfF8ITCm2eYQfOoFywggneKLUA3oUvF846waT4FPly6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583276; c=relaxed/simple;
	bh=cjuFgs4kt/OXrQB8uT8Ws3+HRyObOw0jFc1fBOb+ebQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=it3AqvJECSeCqj+4vvNuFL8sgpxg318y3bV2oDw+fQ1b252ODIETe/PlxvAKi+OLwjeikygy2fKel2H1iKys/WN1gulb9YQuzXE5qEZkTBAKWdTFVDgxmQL2oOxAIZGgR6ZujQQF6cqw8fwg08v9F24UwmRn/QhUCU/44ivhvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p+rNMXxZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p+rNMXxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583269;
	bh=cjuFgs4kt/OXrQB8uT8Ws3+HRyObOw0jFc1fBOb+ebQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p+rNMXxZ/ebo5DIGWipYSeEFAY5zXablD/PW2XhI5l9n7w5+dv9lMxP1qu4ln3KRZ
	 StHayIpl/lO6Xf/Gbinyz5uK8yq7VqW6B7T6+Yv5zcYGHWfEl4XtCVVVBX+bivNmyh
	 j4W8vF3827eHQnseNiDR3gFz4Kqug0FEyOZpp7QElA5feivgdVjrtGJFpbrE33aKNr
	 HauR5y3vUgi6qwlRe8VC9yst5190i5GC6NtArrCUTyrClwFh+AT7nzU9YT1Xc4X/04
	 +FjU+Duq7dlNWYZFgezYPLjh/hHwqvbAW0Ew3cB7VbdUszjajD84H9qbHGwN/Bprfg
	 O64YXFeZxzdqg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0B3317E091F;
	Sat, 01 Aug 2026 13:21:08 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:52 +0200
Subject: [PATCH v5 06/25] dt-bindings: clock: mediatek: regroup MT8192
 dt-bindings into MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-6-ac4410697cc2@collabora.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=10330;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=cjuFgs4kt/OXrQB8uT8Ws3+HRyObOw0jFc1fBOb+ebQ=;
 b=iiKmkux4AuiOw9RFg8mVeEFPBBi1DH50Gs3PhImN5OefydMGv/ZFh3WV7svwxN5uVOr2x/mTl
 HNncEgMSqWkBCzmpzqCWRexYXn4NgruJzs82qvsdBZWpZNeFFi6oCXQ
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Regroup the MT8192 clock and system clock dt-bindings into MT8186 ones
to ease maintainability and have common files for several currently
supported SoC or new future ones, that have the same kind of clock
controller design.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml      |  20 +++
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   4 +
 .../bindings/clock/mediatek,mt8192-clock.yaml      | 192 ---------------------
 .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |  69 --------
 4 files changed, 24 insertions(+), 261 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index 0bc2da60a601..b5988d122e4d 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -58,6 +58,26 @@ properties:
           - mediatek,mt8188-vencsys
           - mediatek,mt8188-wpesys
           - mediatek,mt8188-wpesys-vpp0
+          - mediatek,mt8192-camsys
+          - mediatek,mt8192-camsys_rawa
+          - mediatek,mt8192-camsys_rawb
+          - mediatek,mt8192-camsys_rawc
+          - mediatek,mt8192-imgsys
+          - mediatek,mt8192-imgsys2
+          - mediatek,mt8192-imp_iic_wrap_c
+          - mediatek,mt8192-imp_iic_wrap_e
+          - mediatek,mt8192-imp_iic_wrap_s
+          - mediatek,mt8192-imp_iic_wrap_ws
+          - mediatek,mt8192-imp_iic_wrap_w
+          - mediatek,mt8192-imp_iic_wrap_n
+          - mediatek,mt8192-ipesys
+          - mediatek,mt8192-mdpsys
+          - mediatek,mt8192-mfgcfg
+          - mediatek,mt8192-msdc_top
+          - mediatek,mt8192-scp_adsp
+          - mediatek,mt8192-vdecsys_soc
+          - mediatek,mt8192-vdecsys
+          - mediatek,mt8192-vencsys
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 199eac2034f2..41b8c61132e2 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -35,6 +35,10 @@ properties:
           - mediatek,mt8188-infracfg-ao
           - mediatek,mt8188-pericfg-ao
           - mediatek,mt8188-topckgen
+          - mediatek,mt8192-apmixedsys
+          - mediatek,mt8192-infracfg
+          - mediatek,mt8192-pericfg
+          - mediatek,mt8192-topckgen
       - const: syscon
 
   reg:
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
deleted file mode 100644
index 65e4c2fddf5b..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
+++ /dev/null
@@ -1,192 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8192-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek Functional Clock Controller for MT8192
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The Mediatek functional clock controller provides various clocks on MT8192.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8192-scp_adsp
-          - mediatek,mt8192-imp_iic_wrap_c
-          - mediatek,mt8192-imp_iic_wrap_e
-          - mediatek,mt8192-imp_iic_wrap_s
-          - mediatek,mt8192-imp_iic_wrap_ws
-          - mediatek,mt8192-imp_iic_wrap_w
-          - mediatek,mt8192-imp_iic_wrap_n
-          - mediatek,mt8192-msdc_top
-          - mediatek,mt8192-mfgcfg
-          - mediatek,mt8192-imgsys
-          - mediatek,mt8192-imgsys2
-          - mediatek,mt8192-vdecsys_soc
-          - mediatek,mt8192-vdecsys
-          - mediatek,mt8192-vencsys
-          - mediatek,mt8192-camsys
-          - mediatek,mt8192-camsys_rawa
-          - mediatek,mt8192-camsys_rawb
-          - mediatek,mt8192-camsys_rawc
-          - mediatek,mt8192-ipesys
-          - mediatek,mt8192-mdpsys
-
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
-        compatible = "mediatek,mt8192-scp_adsp";
-        reg = <0x10720000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_c: clock-controller@11007000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_c";
-        reg = <0x11007000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_e: clock-controller@11cb1000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_e";
-        reg = <0x11cb1000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_s: clock-controller@11d03000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_s";
-        reg = <0x11d03000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_ws: clock-controller@11d23000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_ws";
-        reg = <0x11d23000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_w: clock-controller@11e01000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_w";
-        reg = <0x11e01000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_n: clock-controller@11f02000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_n";
-        reg = <0x11f02000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    msdc_top: clock-controller@11f10000 {
-        compatible = "mediatek,mt8192-msdc_top";
-        reg = <0x11f10000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    mfgcfg: clock-controller@13fbf000 {
-        compatible = "mediatek,mt8192-mfgcfg";
-        reg = <0x13fbf000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys: clock-controller@15020000 {
-        compatible = "mediatek,mt8192-imgsys";
-        reg = <0x15020000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys2: clock-controller@15820000 {
-        compatible = "mediatek,mt8192-imgsys2";
-        reg = <0x15820000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys_soc: clock-controller@1600f000 {
-        compatible = "mediatek,mt8192-vdecsys_soc";
-        reg = <0x1600f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys: clock-controller@1602f000 {
-        compatible = "mediatek,mt8192-vdecsys";
-        reg = <0x1602f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vencsys: clock-controller@17000000 {
-        compatible = "mediatek,mt8192-vencsys";
-        reg = <0x17000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys: clock-controller@1a000000 {
-        compatible = "mediatek,mt8192-camsys";
-        reg = <0x1a000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawa: clock-controller@1a04f000 {
-        compatible = "mediatek,mt8192-camsys_rawa";
-        reg = <0x1a04f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawb: clock-controller@1a06f000 {
-        compatible = "mediatek,mt8192-camsys_rawb";
-        reg = <0x1a06f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawc: clock-controller@1a08f000 {
-        compatible = "mediatek,mt8192-camsys_rawc";
-        reg = <0x1a08f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    ipesys: clock-controller@1b000000 {
-        compatible = "mediatek,mt8192-ipesys";
-        reg = <0x1b000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    mdpsys: clock-controller@1f000000 {
-        compatible = "mediatek,mt8192-mdpsys";
-        reg = <0x1f000000 0x1000>;
-        #clock-cells = <1>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
deleted file mode 100644
index 0ebd0d60e2f6..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
+++ /dev/null
@@ -1,69 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8192-sys-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek System Clock Controller for MT8192
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The Mediatek system clock controller provides various clocks and system configuration
-  like reset and bus protection on MT8192.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8192-topckgen
-          - mediatek,mt8192-infracfg
-          - mediatek,mt8192-pericfg
-          - mediatek,mt8192-apmixedsys
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
-        compatible = "mediatek,mt8192-topckgen", "syscon";
-        reg = <0x10000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    infracfg: syscon@10001000 {
-        compatible = "mediatek,mt8192-infracfg", "syscon";
-        reg = <0x10001000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    pericfg: syscon@10003000 {
-        compatible = "mediatek,mt8192-pericfg", "syscon";
-        reg = <0x10003000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    apmixedsys: syscon@1000c000 {
-        compatible = "mediatek,mt8192-apmixedsys", "syscon";
-        reg = <0x1000c000 0x1000>;
-        #clock-cells = <1>;
-    };

-- 
2.55.0

