Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84E46D2DC
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515457; cv=none; b=neHBip23H81iFOjBBAneydNGrQKxO+FmTQl/Un7qYWs81dVOPilQxY8bnZvUbJBdr5sHXuZW6lLhXyO52SyQdVuVceE0e4EYzTJHIa0+YVbD8paqeTLZDSLk9v0LVekoCEqwRjiLQ5wcofhw4Z9J1oSCcSVdELTyaSCtuIQQjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515457; c=relaxed/simple;
	bh=0KxQNfxHtgxVP7p+J7kLnmloyIjqtkqU8bi4/9D5Pn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNlb0ti2DUnTwTgMA/L9JyPyf0Rf5a0u3dL+E2HfrEEAb3Qs/CCvQTvbfpJ/CEDG+A2w0UE95KTXKMOTO37SqF9oJqcQyYmx1AMFgq5Dv1hTuzhSbJmoJCg7zWW+goP4SbeTyeOwCkN5v/ZOSOGeO5byC+LKDxIa3oGXITOKvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=k4n0Ncnk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="k4n0Ncnk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so609179f8f.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785515452; x=1786120252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXK3NWYi082LyOZjH5CFEpjpWT9epWTpuRaVAOKU4cw=;
        b=k4n0NcnkffnwX6VxC1q/kgOjq4ExUsEShLogQHGadzSyVr9fSJw83KuvKSgnXietIe
         /phpPr3/Qj/50Lj56jh0AeC81PWygwonrGBxQXV3KjETPN09VkN/sz+7u7sF1j5ip8Ja
         Mo8T7giMgdzIrqWyqvbopBjKCRMoPd886M2FtmTiFgb+nO8BjwwknM76UCDWgHCwDsFQ
         wpHsaWXHjDzrM+XAuCJBDtLN+Tiv+qwFG9LVCcadtwXP76Ddcne7hweOgEHq5XLpULr5
         YeyQpTbS4Iaj1ZLb7pM1VWYPoFOOlVaqTRf0AbsFfv9UYzxT4KMxl33af6vm+0Z8714O
         EiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515452; x=1786120252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXK3NWYi082LyOZjH5CFEpjpWT9epWTpuRaVAOKU4cw=;
        b=PnVDo2FGkhejXS330TR9pAciS8rPLWrsgCVOMI4h0QnkOfle8tMV0b+AAfkQ2reTGS
         TvpbrKmx+6H4QBRqSCQrZkrUo9RLO8yP2Y6XRK7qB/lVb3EtC6IAMjV1BqgaKPhHQskj
         v9vi61XfGYdSwVcvAdwJcAB7erwqtWVgCXcqXB38NavcZedJAdaOTQWR157kWFrxkZnv
         s/Y/iwEYrmm5IT+tWHg+7sT2yuwAZoMSuIda2b361nEQu9aIkB/llZ8SdO9tNQ+m2/Ah
         bEOCoo3+MGtj59JG+J2+5ugKkAwCes4pQ6EVoTnp3rcCS2k6m1WEIB/Invklx3n+tXJB
         /AwA==
X-Gm-Message-State: AOJu0YxhUq5V9Z25j7bc+xyLTw9QdYpSWDnbd7Lep2cNdlETXrFSeFVn
	jd8CZuoe5QwCwzOXMTX+6YEGNeSOBGe7BnTlOaDdSZoKJAjuAqKhK+AUDUiEIcloNDMFw0UqIyS
	66k7N
X-Gm-Gg: AR+sD12WC7PXbXVwAgK38Y+ZLNDI5tQhqSmeWpl1yUaplX69/uEDPnwCLlMGwtC3Cju
	5f2NIty4DBPyBhe0TheIC0zJ34ls9SVYZxOjkj/8hy3J6BCOFE75c/7JPX5EWEvpSRa0KENoEg2
	KhF8IaHH8WhzbR1PBh+kA6eOWYyOXkCKH32iXq4WuWlJAoiJlNeBlTEhSZNuZ1wxlUMwiSooAbg
	UzDbiXwUAriNa7qXpthHepbLCVtOz2r3xLR5trOFKzPsC+jJxb/PLIzXGce7sqw+IE76Kl9VXoe
	iljG5jinnbysCpW/+DNznLYfD3D+sGEwO/eJyZ3u5aF6mJAYMrL2MgZxWydaEqHdiudhCxhdZms
	FGKUzmv9dcaPgp4CKtCQ/r3t8PGQ/17kg0NdEI4CC8BUDc4RSOY9BlWrzg1p92L4hpy+3El4DNo
	6uyMD7I9c/6GiYwljUx4NmmKyHwHe/TwDh88QhZWqNIj8zQpktMIv0Wk9Ahw==
X-Received: by 2002:a05:6000:983:b0:47f:8f54:125f with SMTP id ffacd0b85a97d-47fd72a9038mr642064f8f.7.1785515448372;
        Fri, 31 Jul 2026 09:30:48 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d00b:bc94:65a:a73d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd41e296csm6513850f8f.12.2026.07.31.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:30:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 31 Jul 2026 18:30:26 +0200
Subject: [PATCH RFC/RFT 1/2] dt-bindings: net: sun8i-emac: Add A733 GMAC210
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-allwinner-a733-gmac-support-v1-1-d0a8732bfa82@baylibre.com>
References: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
In-Reply-To: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
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
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6093; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=0KxQNfxHtgxVP7p+J7kLnmloyIjqtkqU8bi4/9D5Pn4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqbM2xquVAc309vSgKPGdFcjh7GkmzmsbHShAaG
 2+Xz5vdSoWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamzNsQAKCRDm/A8cN/La
 hVYjD/4h49mYaowx0kPXeu4N+tawC2LKn/y5trYsXdnPdHmdfzHZtHE1sbRZCKd4zo3VNEpCkUz
 3ZEyvd1719+F3UGAqXAndBPgq/sN0WCV7/9y6m8XRfeJWGXcljWdJKIRPMme3g5XzvoyGUDCPAn
 aQ25LXLBhtvnGX5DXbWYSLrYr2lPMu6w1ZxqRMg3eBfZbOBvnwljx2Qv7GDAHlIrvGb3Kgj0AsM
 FOgHmSnW8iSWx/NtDXciYBKu5P4cgv+c20KktVmdANY27RVQsfkeb/ozqs972CE4uTNBkuaEMB0
 ygkCAj2lRmHFKpVxapgG9YD4/UE5zwxVzKQaAzLHOjwVazmXCWdB9tPTUoyaAdAkkTnyqdoEail
 k6iP0hNqNcGam9TmyMkEJkNaHOdswDX/D+H6bHN5lBeUzEoz1AHaAXZi/iDauKKV3tooyukOuGH
 nB2hz5KVP8+VG+vwRZTZZKLsXQQM8568MopRMKciRUtT5HLwjRItUVwVpHwqlmroVhRYyYfwCMu
 49z8l+11BmRDapU7WzzqrQXCoTfTpsTvHwUu18vrpQYAJbnUnkS6fRKbG0l3Hv2DiPncxZeF7Y4
 xma9MDf3jBOllSMS4tgfuAK60M+ntQPUI+mO7GkQdc2RO6qfmwpYuqR5FccHOg2MZU6H0CxAQqr
 OgQSoMmlrTaSxNQ==
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
2.47.3

