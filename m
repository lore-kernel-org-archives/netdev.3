Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC632045AD;
	Tue,  1 Sep 2026 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226113; cv=none; b=HIUVnosiEaEtMdJQhCYIW/WlzK/S33oVjZ2BVXoosCXJ+/njL9wtcRuFe100EVcizAQSdEGwviCTniriBStBP2IzIQiPnqbS8Rr0WaQ42PEacj7IDe/ckAhz3ljU2LbWJ10jVPyuBlbGuCdPE2R2wc+Wj2ZhLJ2pxlFndq77rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226113; c=relaxed/simple;
	bh=CYi87bj0peNiOasgsBO9R91QkY43F/FrkslS+8YFcw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPbDuuQQZZyMmbyAWe6svUaGBrGgm0lKCfFoURVONqnJJl2uOrLI71PNSw7ih+ojwDSpVK+gs9hLKiq2L1rSeTZkWXcmqOO1u6157WpKSiHVmCYW/FdxeaS/muPs7c/u15E22AnI67Y4kQIZJvJxYKAEZ6r4GyDyQHiqUCtjFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=neH4wKOT; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="neH4wKOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=KDrJ8qKZmj8mBstfQ6vGXNiDtCIG1JE
	EtjpWX1LRrbs=; b=neH4wKOTMVDiAq663MQod/wpQltdEgJawCv689xw+qynvOm
	gYtXO5L2KLugIrnyAKI+/rE4K/clbNOjTLqJyFFcJTNK3j8iCCVFkVGTkiB8Z504
	JIjOIzjkxv+aDI6qSy9BI3hO25+yryPO492J0I7Uh40iuGkkD5+KOhVKEAww=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDnrwYZKpZqvx0AAA--.111S4;
	Tue, 01 Sep 2026 09:28:14 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Tue, 01 Sep 2026 09:27:31 +0800
Subject: [PATCH net-next 2/3] dt-bindings: net: Add UltraRISC DP1000 GMAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dwmac-ultrarisc-v1-2-f19454814bcf@ultrarisc.com>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
In-Reply-To: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788226062; l=3097;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=CYi87bj0peNiOasgsBO9R91QkY43F/FrkslS+8YFcw8=;
 b=uuv29OU19WBJ6Z9pIIHSRs3M1C3KwXTeNAyix/Y1l7CVrzlXYgJn+UEwsmv5LUJ4Acyghml7p
 lUgkIt7IJYkBrOicT04ldQCGyyvdvtuu8fFapvwBPioTe01Y6UgvL+l
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDnrwYZKpZqvx0AAA--.111S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw13Jw1UGrWxCF4xGr45KFg_yoW5AF13pF
	ZxCFs5JFs2gF13Ww4fta4xA3ZYyw18AFy3Awn2yw1UtFZ8uasYqrsrK345Zas8JrZrXa4q
	vFyY9r10ka109w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7sRipB-tUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAREWqVJKMAFQAFsp

The DP1000 integrates a Synopsys DesignWare GMAC from the 5.20 series with
one MMIO register range, one clock and one interrupt.

It also provides fixed TX and RX RGMII clock delays that cannot be
disabled. Board connections must therefore not add either delay in PCB
traces, making "rgmii-id" the only supported phy-mode.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 .../bindings/net/ultrarisc,dp1000-gmac.yaml        | 74 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 79 insertions(+)

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
index 3a19da74d00c..3b96ff0734e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28004,6 +28004,11 @@ F:	Documentation/devicetree/bindings/clock/ultrarisc,dp1000-clk.yaml
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

