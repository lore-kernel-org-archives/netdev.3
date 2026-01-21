Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19C30E835
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986450; cv=none; b=ITFGHAhSMb8ltLNG9Gv9dIWrgLVZFtCpjoSZ+xZ4PFhRC0r3VJRGY1g1jTXacHu125P6rZjv6DTIO5ie1YNVPq2nPLloHl/M2ceb4RmbRPpFxBswDnlpECZ88PiPhk2rNaNt12Ol6s/4o5KUQCKGFfBvwUdjX5UsUdk9EbHXuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986450; c=relaxed/simple;
	bh=aI26termfloRMGA7Pr8/Ede7Zg+JV4cDdwVSFbO7ZC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hanlbyVeLQ5XUTWi1A1hGv/a6ZIMCfIXMg6c4qoLKo4zKeLFBklHHNgV69US/2YFRJAE3EwF9EIsaxIPGgclVLc0JyGFrSHOjyN6yaU/HowhN3Qr/nllgBHGuAB/2Ydc3i16duziNpZ7xI1UkkA30yqbnlaab3a7YcnJzntaWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH5dd47Y; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH5dd47Y"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5634d866615so4362825e0c.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768986448; x=1769591248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJLNhxpUuunLpKkwMWOBq42/DhYih3hY7Y23pMOtVm4=;
        b=jH5dd47YXEv0qK5cmkEaBfboF0wuGJH6JSBqv+fUR3hYCb0EONr3pjdJmel6AGCL4O
         lFHxo/eDo2NlguYaI5gOO63d4Jh/+6lCi01U4k8ExWoElXSXDtNqc6K495nOhymrbAKc
         +AdfJpnhJbvVOtwvs8d7osbn5VgYp62fs9PxRGy+EDbyDkOuF8Qh2B/clmL8UV9HxeAj
         AYxBHNy1dvjRgpOjZld72vA0iTgxPBMnQG3bh4PynU9OSQL0/oJjgY/W4gqBfJ1eSNOD
         hZeDt+0ZaXCRr51SDjhv7aPK3SVoZOHPhntrxILCcjjTsdVnt7KkZ7w6od/QNCq2qwow
         PXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768986448; x=1769591248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJLNhxpUuunLpKkwMWOBq42/DhYih3hY7Y23pMOtVm4=;
        b=l9Y39r33rQZG+GWqMGWc+JpJpl9gD2emCrJzv+Jby9jkUwl7qBxo1KMRZUBguq/qlf
         xQs2DDdIgtxc5WPFJ7l2mqxR7qBklU8ebK8U0HGL6GLRlMleIqGy+bwvYiEDawx3YGao
         LyRsFEkXum8R5EVlxU4LJwp9Gb1ucO9SqARN59uQU4L0K5FgffVzovxTTMczixI+6Uj5
         aIhncNZHmpLEXmhKE3M8Ro3l7YB8KCDaGTSe22VAqlUcfcspQrtCI29EwzuMhTqaEcri
         aoZr3aEtLxuhh3v3LjYzBdaIHYscJFafvRzqbeaZQbO1nYcajqUr7Kg3HeUUrECBeh/e
         KqGg==
X-Gm-Message-State: AOJu0YxYI9rFzkS/NFpS0MiPpUDGcOUyOmKqFCsAWxzROOhatsn98ctE
	0DD+N/CgpFKT+zYYcsswbmqqxYXWjXrrVu1pURhumOUH8U9fe5jt2rpuq94NZ6yg
X-Gm-Gg: AZuq6aIClKEC6K5cg/7hhLq2HS8dxG2fJamMu7d6ydclea4Njy64Du5rpdHWK8ET6HO
	6LlFlHksdz1pY/TtSKxZgbpGQzuyQq6+o3a587ATreHSaJ5eKl/SiHzB5EY0Jefek5TeGg9qXhH
	NtvV+TMXMsmSdM76fk+Ypbc4j9BZ4NY6T5NZ4lu66uhf/QnsY/75ZSXfChdRyNs+2BslWYpRrgs
	DWHU9kwKMi/SVUWjfu9U0rNslbS60fYPu/+j8advhrES6XCLnH0/mY1yCXIbvLaY3MJQkGlgkt0
	h1f0iKKTuElMIFDurlGrHtonAZn3spAsYemXj5GejwMNm53FEwnK9JJXx0sU3kyRJLpnzLhKYZv
	eLEAVpAvPP0+GKn//KWxivv17YQ8tTAKKIYN474FvjTUEdSElEQZvmSjp7Ob7ts+B9zpPbnDP1i
	Aer13bLX/Qng==
X-Received: by 2002:a05:7022:1e01:b0:11b:d6f2:a6d6 with SMTP id a92af1059eb24-1244b36efefmr13558965c88.34.1768979613029;
        Tue, 20 Jan 2026 23:13:33 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefac48sm21239676c88.11.2026.01.20.23.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:13:32 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <ziyao@disroot.org>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: Add support for Spacemit K3 dwmac
Date: Wed, 21 Jan 2026 15:13:09 +0800
Message-ID: <20260121071315.940130-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121071315.940130-1-inochiama@gmail.com>
References: <20260121071315.940130-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
MAC (version 5.40a) with some extra clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index dd3c72e8363e..3c2c6cb6b10b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -34,6 +34,7 @@ select:
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
           - snps,dwmac-5.30a
+          - snps,dwmac-5.40a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -108,6 +109,7 @@ properties:
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
         - snps,dwmac-5.30a
+        - snps,dwmac-5.40a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - sophgo,sg2042-dwmac
@@ -653,6 +655,7 @@ allOf:
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
                 - snps,dwmac-5.30a
+                - snps,dwmac-5.40a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
diff --git a/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
new file mode 100644
index 000000000000..e69f3b60c51f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/spacemit,k3-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K3 DWMAC glue layer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: spacemit,k3-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: spacemit,k3-dwmac
+      - const: snps,dwmac-5.40a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: PTP clock
+      - description: TX clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+      - const: tx
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: MAC interrupt
+      - description: MAC wake interrupt
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: stmmaceth
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the syscon node which control the glue register
+          - description: offset of the control register
+          - description: offset of the dline register
+
+    description:
+      A phandle to syscon with offset to control registers for this MAC
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    eth0: ethernet@cac80000 {
+      compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+      reg = <0xcac80000 0x2000>;
+      clocks = <&syscon_apmu 66>, <&syscon_apmu 68>,
+               <&syscon_apmu 69>;
+      clock-names = "stmmaceth", "ptp_ref", "tx";
+      interrupts = <131 IRQ_TYPE_LEVEL_HIGH>, <276 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_wake_irq";
+      phy-mode = "rgmii-id";
+      phy-handle = <&phy0>;
+      resets = <&syscon_apmu 67>;
+      reset-names = "stmmaceth";
+      spacemit,apmu = <&syscon_apmu 0x384 0x38c>;
+    };
+
-- 
2.52.0

