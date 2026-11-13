Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572337;
	b=pQFpiqn3I5qNN0/3Ih1ij9Q7yDzCieAw9vLhuiy4NrAYZQWXvHJxoQatKNEuIkB4Ofls
	 aRoF30iE4WzIb57Hpka1xToGpm7uw5JMzsx6MDH5DnRXorjuBHlBcnRyiUoKaoTmO0Ed7
	 8Oo6inXE0OyhOCAoYBgbsk4RzuIJ2JbW3yRGKsQQiA6FwoCfVO9V+fKmfR6G78/np5vNI
	 iL32C/eYsuqvDE5I/jyMeAVxaEf6Mz+Ln3RnfOFozK0JPZf/GCN/w3h75I1t/9zOtxzEd
	 3U+2SqDWeQMdLdu9VuyfcJwono1z/iaWkj3pjwuxD+sanArB3qLcrSKwo2Rit5+qgCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572337;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=erPMA1s3GrrjDIAYXKeMxd8td7q74oejXK0RvW/RZfA=;
	b=xFN9LMHR4k3ABAEpmYLSz1gaRychMFJ3/isCJZAonrXP8JSz5bEdLeOhEEy/ylMPozy0
	 6pOdsFOppeSF63S9Wo6HGT8uuPtubNLPL8LcEn58PuurhIyhiEAVzMNJugS5xoIIQUozG
	 FegOEOR6Una6U8ewc8WanY8d348ZN7B6O265GYIe0rPqky+IGfGznBMvLAtr/Jav693bA
	 WsP5279wQlW2pCIr1yNN9AQpcoI89ivJc8CiC9DlUpt1vEN3RpqK1d2p3gQyX4SHHh0xC
	 1XiloYFcW4kQFjeVId/U7CBLyMz9skYnPrLi6XeW+ohlNjXYh2dLR/hbn3JdOX0f2CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEB606A33F
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46FEB606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so221170866b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572335; x=1795177135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erPMA1s3GrrjDIAYXKeMxd8td7q74oejXK0RvW/RZfA=;
        b=2QF0GxlBgJrr78abGxhmliZc4s0Jl79OjJQHb98uIDb4O5cTkU97n7MD0SNZJkJWAd
         ECTvPAPOJ9CK/6i7DsysSqTQ4EG6mvS1Gpn7eBUBjKIg4AAoXZv3CBlUv+XCuD5YSC7u
         L2MAgLVFbI0oBk7ffLKv5x3dCcPUK8eAsl4kry/LLuy62nHehyWMfIazXlShW0nEL0u3
         yGB6Nj2OsC9+3SRB/aJ2RcZTWTOsaZHgWdEVSq71Mz4s/zyfxEDmUnbvPncCwDGzDd91
         p1AFP+ajGLvVldYzY7cuKR8VIxfsA7CgynWOl4MBC+xuBfUj+/lCFggbnPVSsVaD7p7R
         mOeQ==
X-Gm-Message-State: APuU4Z+x8KFx6aqjnH399h6wqC20gzrmbVkgjFvRM5kJ+ScX0ElB/YEy
	mOWJ3PhewtS/l0ProXzOrV67AxzWC8y+Ee4VKdsKlo5GNeSpVD0jnw5L
X-Gm-Gg: AYBFou37K1ab+u2a4SldyhB54BWQs85zR9luVzctRg15ojiDq+lq4nwokBuRrVhpNfu
	FAS/6iEP0OZeWvi4JXedUzVGFxTB117E9xQ0jVq1mPar5SAwsGo7inbpNAPLfS2D0khMe3suaMY
	4EV+CtIUxrMU8b2OJ9DrXAUfY+LhwaqhfVu1D/zDKds3O3i/xJtdi7T6N9lRcgaiavKRmofwVhN
	gHO7OV82XKJMBxGZXdOz22vFm1BvQ9mBDLw3Q8BzzEECceSFxYeVR5tkmMd47oTySTrLfP8WGOe
	YhF3+xLB4FLmBxzauT8E0wulhBx5daIp8ho/x8WMmg227BgYI+Ej7DZlwSvyXQy7HmcmUcMVSub
	FZw29q1VpPA1mXksXUBEXU8MrnWZINr5yayh2cH2tqopRH1O8WakJyRRxssGfn8ZqeSlEqYV4TK
	3ok/EfmI81W2VJdtnIga8SVnFSGkofSDXbYMRcFpLMQO4ZpQYYc3JzDp8tGJ7pXb/qQRTGr67JL
	CPv34AFYZ5S2i1bEJWzdXw3fdCZMNTSCcm7KGw4RGw7nmRIyv+oflRgFc3AKdwg3BNNkR4s+oUQ
	pqBHkzSse82gxS7/FOsNTy6woidW8/nrhWkP+tq9slgwM9L5jziVv5LVHZ/o3wfmZGDqeh3ER4v
	Udc9rA+gT6Z8pj6uYto2m2HQJfTDDlo3xa64+5T/pDrsaZQ==
X-Received: by 2002:a17:907:72cf:b0:c41:e75e:5889 with SMTP id a640c23a62f3a-c5096398b58mr185619766b.33.1794572334460;
        Fri, 13 Nov 2026 04:18:54 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:54 -0800 (PST)
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
Subject: [PATCH v7 1/7] dt-bindings: net: amlogic,meson-dwmac: list the compatible combinations
Date: Fri, 13 Nov 2026 12:18:46 +0000
Message-ID: <20261113121852.334604-2-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113121852.334604-1-tanure@linux.com>
References: <20261113121852.334604-1-tanure@linux.com>
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
2.56.1

