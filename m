Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873008;
	b=uIvdEN9cBrPrpXQmAKVX9bm0NeUGq0G+PcayLcojXNSeA9gbnSGADbhKAzJ5f8It/04z
	 Jt9KegzF+9Rxwz3z2R5cg4WKPnGG9oG6pw5MFW7wbW21b3ghLD2CJho5Yj6PDDqb178rw
	 YFaPZ64IKN7tKDUapxF8wCO/H2tLIavmTCv/cAiIVxYr9sCpkHJ7WqtiVV0kY8+Awt7g6
	 2MZSMgBs3VwXw+3tsEdv1K+VbsGWbO2XQqK9sz8ck7TzL10MBywcIOPTlndSWOz0m70fU
	 XkIUwPlT0GoCyVah0Rqb3UQHYtJkdcLPtAd8ai/3XQwBWJcjdvGkrENizg7y4LasiJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873008;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xaLsM5U5ulazZmmMZOUrbsqFBf8E5Hd+TLCd3a7zUQs=;
	b=vvcn2bPZY8iK25MTUQDv6nNWBHUevbE1KfB+g+08XuqrwyWS1qUUMU04jksRTteID+7u
	 uI1TCUp573PJ6pQwwVdDcqTlZdgBwrvrnnDCeHLoiQIUgWSqT+tHlZ14TtX6aCnYUTIgk
	 71ayYxzAHvhOHVNofXP2aQ7y+cWtKZdpFRYdN2X8BKW58KMX3ZQOFoqNOMf+m5TCnk5Ox
	 gTXm91LUcFVp7HhakN/dHZJpjqrsfQxDkHYhGEDO9Bo02tBX3qBa0EM/OwWx7tRacb+3X
	 CAyYebuAkj2nu1AoEDqF7oPxCs+5GAoVIi6+PUJ+NsB6Hy29s+tEy/RV7jms+E5KmWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C80606D80A
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C80606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so4851945e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873006; x=1794477806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xaLsM5U5ulazZmmMZOUrbsqFBf8E5Hd+TLCd3a7zUQs=;
        b=sxchZIFlyD1Oi3w4SB1drzWklucWjiIf6eDzl78gfQZiPjklI4/AdMSM4SZoExzrBB
         frrqfmb8BT7DWHiyQxDCOVuICTmElg5Yi3SbeN6zO3DYhI0FQgc+Ar/mM9/sYOUHt9zE
         ykuLfKlMoTjmFNydwe2XnMZwX3RytjD3A+bOy68F9yZsUjJj/w2iutri1lqDtERGcLI0
         fgE7R5xKLP7bqd8uWLFrbg6gaD/q09Qy+m+06BzhdMUYyvLTG34nD4+o5umIcQ6oyvny
         /wQxZ35tNffonJarAUvOsuZG4XWXUfnBLxXU0pzsJdE4Yau1vxmvKBmAHo4XwFf89Zlp
         6NlQ==
X-Gm-Message-State: APuU4Z+XgWfhdOubwm+nvJJaeOrch1RderYVeT1RZ3wRYUbUUNMm+xWW
	GwdDrUyCIq5FF+BR0DKU+BwZS714ViBjaPAfTACd5MrCoskxYrTwRpTj
X-Gm-Gg: AYBFou3v/HtRBMaTgQ2iC1RSq523xYBD/YeB/X77bZZ6cmX0EthvNCV3g1Bls4jJB2Q
	+pFj6SmrWKO3EUvLa/kY5rtfoXEShNJgPLiVbOA7kkuEPjv8E+2x0HKzcXNmChrD1VkFU1m5i9C
	ZVWsQqhEvrcrwz0h3Aoapv8pdt9+4D206UZMdqZYFe/GmNA+P7VXM1OPsJi1HYYljdmeC/AkHMy
	vuZWDIV2ncNF3jiulWMcbYeG1yfpDv9loocR0S6wqsBf9wTM57Lp93E+WbkZ9hmueiFdBDcZ3Ht
	sr2Sypx3QHJ4B5esmikbjXD8CtQ1RuWMAFxxiZkFu2LMiHeAUdKGPRVKcqrfbyForP6Snhrq2fF
	cDN9Zil5fNnefgyJ6VVAY/whYVVL5Zzz4EoEHOd7WyOL9tPbVxNN5n93AxzfAn60A74LqoRwnul
	Zxm6bIycC6fQ5K6hCVuhUIf86QozN7lRtqtcyzxtdsIfw8asH/tUTeY+xIEh5fPDur8sPB4zqfc
	8cvZNHZS3P0TVceEoEk3VfXbXf3O2OGIK93r2VzV2Mj3efx5QW8ArlDQsJet5pGpexg1w23y61W
	Teca3QilJXjr7ToicuCQd8GY4eZMovc8Pg5zqWYYvnO8raCxk69QV4Na49avbWHeiBowebrxIzP
	0sZOmIdichxJQByPDJTMkUyAfRw==
X-Received: by 2002:a05:600c:45d4:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4b55de92333mr36628635e9.14.1793873006268;
        Thu, 05 Nov 2026 02:03:26 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:25 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/7] dt-bindings: net: amlogic,meson-dwmac: list the compatible combinations
Date: Thu,  5 Nov 2026 10:03:16 +0000
Message-ID: <20261105100322.37816-2-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105100322.37816-1-tanure@linux.com>
References: <20261105100322.37816-1-tanure@linux.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatible property only checks that the first entry is an Amlogic
name and that "snps,dwmac" or "snps,dwmac-3.70a" appears somewhere in
the list. It cannot express which fallbacks each SoC takes, so a SoC
built on a different Synopsys core cannot be added without loosening
the check for every other one.

List the combinations the device trees use: Meson6 falls back to
"snps,dwmac" alone, the others also name the 3.70a core. The Meson8m2
reports a 3.70a core too, so it joins that list; its dtsi gets the
missing entry in a separate patch. The example used a two-entry form no
device tree has, so give it the Meson GXBB combination.

Assisted-by: LLM
Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 9c9cc3ef384d..e769c9bb70d8 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -129,20 +129,19 @@ allOf:
 
 properties:
   compatible:
-    additionalItems: true
-    maxItems: 3
-    items:
-      - enum:
-          - amlogic,meson6-dwmac
-          - amlogic,meson8b-dwmac
-          - amlogic,meson8m2-dwmac
-          - amlogic,meson-gxbb-dwmac
-          - amlogic,meson-axg-dwmac
-          - amlogic,meson-g12a-dwmac
-    contains:
-      enum:
-        - snps,dwmac-3.70a
-        - snps,dwmac
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson8m2-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+              - amlogic,meson-g12a-dwmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - const: amlogic,meson6-dwmac
+          - const: snps,dwmac
 
   reg:
     items:
@@ -175,7 +174,7 @@ unevaluatedProperties: false
 examples:
   - |
     ethmac: ethernet@c9410000 {
-        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac-3.70a", "snps,dwmac";
         reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
         interrupts = <8>;
         interrupt-names = "macirq";
-- 
2.56.0

