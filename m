Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F0411FA6;
	Mon,  7 Sep 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767258; cv=none; b=DJLkQFHU1G+x3Pw0hRGvG8TCBBbsqXw6HYG0O7WtlTyCvE+uTU2+yCojgXm+Yk67WFqPeRIRR5nGkntadWVUqnaywacT+sFcVC9LxX26kHvBF2KhXyJVZow1cbcrFgPSr6sRDw121a3AR00fjfgGeYkAzASxXpvF6r75VwV54Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767258; c=relaxed/simple;
	bh=hVW7kxIlJWKK6GmEDtwPV5h6IvvOs7xgT4usmIedGEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6yCgXXEL161FzL1YG2EEleoi/sDYiikDVKd7kgAjmDAegGEUXH0P/rp69R7fdSJGcWCVsGaRk6auC/fKlsLhHMDtXhPKD4AMY4CQleeDwXaDciIvgazJ8pL5JJsj4UYWf2QO6ap6/0jhdGdPWUZNG4nX7RdHDCJ61q/4dTYuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=WUewQy2L; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="WUewQy2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=5AEcR7kglOxkPlraOwPL2V4mlGtETzE
	yke9xSmsbwpI=; b=WUewQy2LEwUM8ZXXtXi1utzS2MvhXxpi4rI3RATGH0zvY23
	es5DgiIz1VStOEetJv7l3TyrWBX75wHmgEHm+PgUAu7XEto1E1Jq4G3v28Zg4VXH
	DRSgCwymh5Fa5fkDnOIb00UHnRJmSjwho/6HtOJW5XVD1a2jTnWEGkAvjgzs=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAf_a55qnlUAAA--.364S6;
	Mon, 07 Sep 2026 15:47:24 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 07 Sep 2026 15:46:53 +0800
Subject: [PATCH net-next v2 4/5] dt-bindings: net: Add UltraRISC DP1000
 GMAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-dwmac-ultrarisc-v2-4-9a39bf8db313@ultrarisc.com>
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Jia Wang <wangjia@ultrarisc.com>, 
 sophgo@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788767221; l=3690;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=hVW7kxIlJWKK6GmEDtwPV5h6IvvOs7xgT4usmIedGEw=;
 b=WQkgTG42gvlcvGWw+mpq3+buBMHKqc7QB3Fb/UkBfAn9ERSSF7VP/DRrjFNFIEMdBjwdT0ooR
 M4UEd/0l0PxAfcmshVyCycClcVWsNvBoIjpZ/OJ26YqpYN/vfzBwZOQ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDHQAf_a55qnlUAAA--.364S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAw13Jw13Kry8Zr1rXw1kZrb_yoW5KrW3pF
	ZxCFs3JFn2gr13Ww4fta4xA3ZIqw18AFy3A3Z2yw18tF98Was5XwsFk345ZF98ArW7Xayq
	9Fy09r1Fy3W09w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQACEWqdDaQAAQATse

The DP1000 integrates a Synopsys DesignWare GMAC from the 5.20 series with
one MMIO register range, one clock and one interrupt.

It also provides fixed TX and RX RGMII clock delays that cannot be
disabled. Board connections must therefore not add either delay in PCB
traces, making "rgmii-id" the only supported phy-mode.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        |  1 +
 .../bindings/net/ultrarisc,dp1000-gmac.yaml        | 74 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 3 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..2ed4564ae99d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -119,6 +119,7 @@ properties:
         - starfive,jh7110-dwmac
         - tesla,fsd-ethqos
         - thead,th1520-gmac
+        - ultrarisc,dp1000-gmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml b/Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
new file mode 100644
index 000000000000..13029302877b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ultrarisc,dp1000-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UltraRISC DP1000 DWMAC Ethernet controller
+
+maintainers:
+  - Jia Wang <wangjia@ultrarisc.com>
+
+description:
+  The DP1000 integrates a Synopsys DesignWare GMAC controller from the
+  5.20 series. The SoC integration adds fixed RGMII TX and RX clock delays
+  which cannot be disabled. Consequently, a functional RGMII link requires
+  a PCB without TX or RX clock delays, represented by "rgmii-id".
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: ultrarisc,dp1000-gmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: ultrarisc,dp1000-gmac
+      - const: snps,dwmac-5.20
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: stmmaceth
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
+  phy-mode:
+    const: rgmii-id
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@38000000 {
+        compatible = "ultrarisc,dp1000-gmac", "snps,dwmac-5.20";
+        reg = <0x38000000 0x1000000>;
+        clocks = <&clk 0>;
+        clock-names = "stmmaceth";
+        interrupts = <84>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6215fcb07770..01597d1df270 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27995,6 +27995,11 @@ F:	Documentation/devicetree/bindings/clock/ultrarisc,dp1000-clk.yaml
 F:	drivers/clk/ultrarisc/*
 F:	include/dt-bindings/clock/ultrarisc,dp1000-clk.h
 
+ULTRARISC DP1000 DWMAC GLUE LAYER
+M:	Jia Wang <wangjia@ultrarisc.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
+
 ULTRARISC DP1000 PINCTRL DRIVER
 M:	Jia Wang <wangjia@ultrarisc.com>
 L:	linux-gpio@vger.kernel.org

-- 
2.34.1

