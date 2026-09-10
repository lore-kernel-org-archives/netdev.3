Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98B3D1CC6
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035950; cv=none; b=IfiiSoT+1/+oSNeBfb/z/GA43MecbX71hfHCCe2vxYhuu7AFrmnc6kVp5rXLOq6N3fO+iyJuTFC8xPcEFTriMIxftpSZFsKBJC8pMs6RKIcna6YHljzGkx6ZMwBW4EtuZZai1p7ZGLu2pXNBRNhRGONvZE4uRqEjg6PIOuso4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035950; c=relaxed/simple;
	bh=dGwRU59pe0sF4kjsOhQWQNnHY2FCR9s7ump401KQyLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5tsGXMAGawsV39kIX1VN+H51HPUapYyl8t7Eah86NrZ7cvNj8FUDyGo4+szV2z5dAn+owOncWWRl4Xf49go/5D8uI6FeFuudnYq2BvEFPnNJIUx7hN80+ZKhcPL76wP18ki1ty3W+tFjA5af2QRkX5r53sKina71VJ5Q3pti+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nbWGcsn0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nbWGcsn0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso9532085e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789035940; x=1789640740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zolPHkX75MVfEQoqJHx0lnD2lNS7PbBbxJvARPQA/YM=;
        b=nbWGcsn045uo6XPq7tedjpucMH6Nj4Zlk5Rpz358RSHDntO5Ci8TAAtj6Zleds4JQm
         0YuN34Oe9loRgKxYGMoEe1sDyeA/aLgjEKHXn73nZc7q5NaMlBBRBQ0sEbqe4ZvV47TF
         KSzhCwNFDecdFG6dgyMIWtDXD6DEL6+XmrJOrkEl8ps15O/H7MOD91ETRIE/fZG2xnjw
         OTrB3b9YX5DhQcAIZpHISAdxIsLTHVpBcWK3kEEVDKHR6ccQrLXDZaFUf5lIDXb4Kfee
         ouwNXUYkC2E1IQtDwnLfSKDvRIQ8Bl9mHH4OqRo3iyw3bxRWzmKNe1IGFc7yMENbb+a5
         TPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789035940; x=1789640740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zolPHkX75MVfEQoqJHx0lnD2lNS7PbBbxJvARPQA/YM=;
        b=EIaDwzrKoyH7TpRjBSCMsAwcL3ONU7MXaZ2qTbRvHE43IS5j9bHqsfkNFlmmV8Jnjk
         sMVx8ZbVtLvH694WvUUozKiVkfDoL0OS14IZj2b6nA0LbQ9n4mxsrg7HTl+yCAwyUrxM
         IfxdbB2LA5aUoE9LC+78JOpi+eWIpcyJLzYjeWnIm1nJ5P8Vm21/iYOHAmWW+vS3mKyf
         o18XT0dQAUYci+OB/YW/Ow6lYLzbt0LFwTivCVZP1Ld2k3NRPS+h2h1+rIaIvJsmIHb+
         onJyCgFNG/tUyxKTFpGRtEQsj/C3d/tAhDT6+hemFiiuUmACYc7pkjjUf82Q9J6RngUA
         ao0g==
X-Gm-Message-State: AFuF++lqgDrNJpIno69VtFIT2+rH4WzU+uxdjFkjoiHDubpZnQqkwx/l
	nETKb7MF1btmfdeuv0iDFQwYoJVC/TMsVB1IJvUAu7lOAWX88Z2DBXZjfafXXhCZhFg=
X-Gm-Gg: AYBFou2TQXpj9lM4F+sfwUy/DrwyZxSqWOr5RjPN77UpLs1Xd8IAOUTDCET0X2AEEba
	aQvCSYjTmi2YPpvStkrci4+JOKq7IZRXPEHqPa+M57NUFrAzyhVBlCkxXWRyS+u2NN7N+/NwX7Z
	Sep30wHMMwGPlsbi3cqDoq82gc9CWkuAB3J36d5w9XWCkEAuiFMCSzUnMev9yxHlxq5xUlUVsLg
	+ux8eXLgZpc02N+I4DakUUfh7Gbr7200jNY0tOiWHHk7SZl6XSBaqpv6pNn+xesqy0JYOkc5zBN
	kmnOlaPGYuYUFnIRfmgrW1IkqITNC4xGE596qsR5/mFfHnRbwfPVlEbt3VVUk3zR/O7iIf/ZaRw
	OLuVNsfShIk9/W/FSZ4njC/NLmdq6vl0U0UQ1D2zzwbLAqq30Ox1s8kUbt4OGYw5ljz7R6tWOGb
	dOEcU3GAT+LhOf/KQmeJDCPDnUl2aySE7Zkxc17j2FsXNR9E1DAzS2Wil3ZU3Ou64HI7a76WGPA
	nnLcg148H0jQSYWFKBsOyYiM5le
X-Received: by 2002:a05:600c:5647:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49d259138bamr96347135e9.10.1789035940023;
        Thu, 10 Sep 2026 03:25:40 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c07c17sm80398975e9.14.2026.09.10.03.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:25:39 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 10 Sep 2026 12:25:26 +0200
Subject: [PATCH net-next v2 1/2] dt-bindings: net: sun8i-emac: Add A733
 GMAC210 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-allwinner-a733-gmac-support-v2-1-4f4a1e520c23@baylibre.com>
References: <20260910-allwinner-a733-gmac-support-v2-0-4f4a1e520c23@baylibre.com>
In-Reply-To: <20260910-allwinner-a733-gmac-support-v2-0-4f4a1e520c23@baylibre.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6093; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=dGwRU59pe0sF4kjsOhQWQNnHY2FCR9s7ump401KQyLE=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqooWeZxMiwo0um19rhs5hPFUy/F70TN34N0ekt
 c3qzsdT2TaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaqKFngAKCRDm/A8cN/La
 hZejEACg/bnxpg1KnlHEiJc1VDPDY/+8Ow0tT+fJQXkXgHPAU+MRARUHKSaHbj+FMtI5pbY64+b
 UkybYmYJ9kNkhCCZqTa3/mp9jzot/dvYXHo1H0FwBgLVmEa2h73TBHdkAjG5xD+OkyCXXU7GmXb
 HEzv8RGdsYOdTX/ixDdAEAnlwNs4yHRQmCGGXZtIwKDQPXbt1I+LT53o5ybGtdPsO92fx0Aalgo
 9bNcYqKqYAOffOjVIekKYLXlND4noSrjNk7qTpOffkNxApJZceY/jPhVHnPa/A4UpAQ4npCdvw0
 q90kfKOaPWDj2dmWKAtODernP/0mY+4Ahp1z6Rm4ytDnQ2z+nk6q6kjZh3iB1SjDF/CC0yueScx
 qXFJluTkuPAS/1mgYmwlhQhduO0oehARz+k6UUwJygDhgeQtdVR5pS3Jpb2dg7ECCxAqMoOZzJ7
 BlCrQUuX30rB7xmkBRhBf1V4iF9lUOr3P0wftVWp3W3P8+845yd/7fwVelvJOkIST8hN94YZ2EB
 o2Zze9jYQDRlvmtiy745TjgdrCArVVZt/DuDe6unpPK27lLul9wAU3I8aHV0bW8n24c7kHADMzW
 x3PvX0rb7p5jFJntcdzqeBjvYoQYzb3Iodqa9A2Rbn29RPtMbAQB7rRfOjr7VWQofw3W/OAjcc/
 UHMDa2b4r0x4qRQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 GMAC210 is a DesignWare MAC 5.20 close to the A523 GMAC200, with
the following differences:

 * The glue configuration registers are a dedicated MMIO region of the
   controller instead of a syscon register, so a second reg entry replaces
   the syscon phandle.
 * The DMA channels and the LPI event have their own interrupt lines.
 * A PTP reference clock and an AHB reset are needed.
 * Unlike the A523, the controller does not appear to belong to a power
   domain.
 * The TX clock delay field is 5 bits wide, allowing up to 3100ps.

Add the new compatible and describe those differences.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 130 ++++++++++++++++++---
 1 file changed, 115 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 323a669fa982..fec42f46378a 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -22,6 +22,7 @@ select:
           - allwinner,sun8i-v3s-emac
           - allwinner,sun50i-a64-emac
           - allwinner,sun55i-a523-gmac200
+          - allwinner,sun60i-a733-gmac210
   required:
     - compatible
 
@@ -44,25 +45,38 @@ properties:
       - items:
           - const: allwinner,sun55i-a523-gmac200
           - const: snps,dwmac-4.20a
+      - items:
+          - const: allwinner,sun60i-a733-gmac210
+          - const: snps,dwmac-5.20
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: MAC controller registers
+      - description: Glue configuration registers
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   interrupt-names:
-    const: macirq
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_lpi
+      - const: tx-queue-0
+      - const: rx-queue-0
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   clock-names:
     minItems: 1
     items:
       - const: stmmaceth
       - const: mbus
+      - const: ptp_ref
 
   phy-supply:
     description: PHY regulator
@@ -87,7 +101,6 @@ required:
   - reset-names
   - phy-handle
   - phy-mode
-  - syscon
 
 allOf:
   - $ref: snps,dwmac.yaml#
@@ -219,36 +232,94 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun55i-a523-gmac200
+            enum:
+              - allwinner,sun55i-a523-gmac200
+              - allwinner,sun60i-a733-gmac210
     then:
       properties:
-        clocks:
-          minItems: 2
-        clock-names:
-          minItems: 2
         tx-internal-delay-ps:
           default: 0
           minimum: 0
-          maximum: 700
           multipleOf: 100
           description:
-            External RGMII PHY TX clock delay chain value in ps.
+            Internal RGMII PHY TX clock delay chain value in ps.
         rx-internal-delay-ps:
           default: 0
           minimum: 0
           maximum: 3100
           multipleOf: 100
           description:
-            External RGMII PHY TX clock delay chain value in ps.
-      required:
-        - power-domains
+            Internal RGMII PHY RX clock delay chain value in ps.
     else:
       properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
         clocks:
           maxItems: 1
         clock-names:
           maxItems: 1
         power-domains: false
+      required:
+        - syscon
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun55i-a523-gmac200
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        tx-internal-delay-ps:
+          maximum: 700
+      required:
+        - power-domains
+        - syscon
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun60i-a733-gmac210
+    then:
+      properties:
+        reg:
+          minItems: 2
+        interrupts:
+          minItems: 4
+        interrupt-names:
+          minItems: 4
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+        tx-internal-delay-ps:
+          maximum: 3100
+        syscon: false
+        power-domains: false
 
 unevaluatedProperties: false
 
@@ -412,4 +483,33 @@ examples:
             };
         };
     };
+
+  - |
+    ethernet@4510000 {
+        compatible = "allwinner,sun60i-a733-gmac210",
+                     "snps,dwmac-5.20";
+        reg = <0x04510000 0x8000>,
+              <0x04518000 0x1000>;
+        clocks = <&ccu 58>, <&ccu 59>, <&ccu 60>;
+        clock-names = "stmmaceth", "mbus", "ptp_ref";
+        resets = <&ccu 30>, <&ccu 31>;
+        reset-names = "stmmaceth", "ahb";
+        interrupts = <0 175 4>, <0 179 4>, <0 176 4>, <0 177 4>;
+        interrupt-names = "macirq", "eth_lpi", "tx-queue-0", "rx-queue-0";
+        pinctrl-names = "default";
+        pinctrl-0 = <&rgmii1_pins>;
+        phy-handle = <&ext_rgmii_phy_2>;
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ext_rgmii_phy_2: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
 ...

-- 
2.53.0

