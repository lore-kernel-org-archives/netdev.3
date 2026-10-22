Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699609;
	b=gPROO6WhPRUeocgGZiw5bhuL+EaUL/R8wHgCCCWBoA85+i2SkIUlZ1a/61PT45IKg+Ea
	 vmUGoAWG6Va6DRa65t9ue6zyFQn2joGg/2qGng2opKqgb07L2Omx1qMZ2yNZsE8MCL8C+
	 UPVQdFG5Pr5mbHgYyTzfXqYEzAkwkTg8TKT+bV66jGt+ufR+oQXrgjETGpQPN6NKtWVR4
	 l+KPQkKiw6PVfgcxzvKJNEEvGDspD37MD7CoxpUEimM0jp9f8EaN/KbqIfsEu/1J7UJF1
	 vid1yu5T54tXACYgNdsvxXxBtBxsNKNoYDHsYdp/ueuc/JnPT4wT73+dV+e9L/GszhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699609;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QqXWTwTTRqCzzF0bQdyuAykpcOnACxEXXIFplcbdvJY=;
	b=dPP4uz8TEL6pFH6PPjRCoZNY6Ki43sAYS9NPEemARxNyXc+22dhAvCYrAdLovXVy2mQL
	 2cQ1DCB9wvhFavGKOtVaxPJmocmM3NeA/YDVGmjjF198AH/OcEZY9qDIQzIPUEbcCsD0p
	 3ATckSzXnFBfkwmDyhp5yDykUFFedaPwEkUghy1FWebnVMeoOKQ2tqym3bH4trN1vmCnY
	 prZt4hRTzrvh4oyMrco0XCNIgX6afKnTcvyDbL0K0HtmQmQIX7M+TkDcKXJZRHPahUscb
	 irW+n0brBKB/lCwN2VdPI/zHwFLV69KfFwKQqwDeqmsTv4tKKJU/GwCObQJ4f19KMig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE672606A323
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE672606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso1827575e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699607; x=1793304407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqXWTwTTRqCzzF0bQdyuAykpcOnACxEXXIFplcbdvJY=;
        b=Pljch+UMDBMDFFWlI1jY72GhtXLNojuF7fw+x5a9W3DM02GGynBRUAbydefKnUfsQ3
         k+x9Pm/KtjPxqeOcYbfYVG4vFLL3VYr0jAGrYvV9WjrYtf0O4Vgz9J+0XyynBJEPh/4e
         vPD9B0luvFYSVsGyhKCcQKpm1aG0e2t0nevi3/+0zOkx8nPvNdfi61rmtl0Ez67dolCW
         WWaXRZJ1R7DV/FXW0F0JKOrXyGR85q1WKvdYRQDRE5vpXuJUhLLGkwmNWFNWblz5KK0c
         uLZ/sLZpVidPb2TsQkcdxIFQp0ntzzvgsFwUeTpyuSB0511W4ssAE2UnbXKh9N86XNq6
         Z6kw==
X-Gm-Message-State: AFq9FYJV41K3rVV6uUZRUqqy6JqOfhfCfRsUPsirApFGPgRyj22j8TcC
	u+fGETJ7daVo+iQSFLwgUAmKxT0if9sdgDrssCe0M9EJdPNaC5/9LqLj
X-Gm-Gg: AYBFou3m68aa8ZZxQfkqAocmKrfe7t0G6KrP7OylGzyQJOaXLsXVjPNPtLPozV7r66Z
	anjgFZ+Bc97TFGdfkbzmW2h6o7wMseI3cxTz8YfwvUiYFaX6jPj/mmzQsL0dMwuHHvK0KM3eBDb
	iV1ehGZW28ZQIuUDMP+xzgk+J2BnYV/PJcOPc16xSI250mfqowH3N5Qwip2tGFL/CKcJhjBZstw
	IKlOy59+eZGzLSFVEgIdjMCONHLjJD/w5PYxbMWHZGGwRXltBKRjM7TTwo3KYNECWtMao0i7E2d
	cclNPgVwgnoCeFzZZdoVxeMLhLr90PPtootYUuaGx0uEdSBE2c6I7AiTE2wisONq2xl1CJPnoen
	M+v7wBXJGBX9+9U2GrkbQOv8bFJDOlxxJLWbb5lmM9fwPEANAFmZjWP34SHGkEMB4kONaUiRKao
	eBBBjWSR/FYaUQdTFsEAjAJB5o4tGxAmzSDAEO42Oofsgz0G4TBRD3bo6XOb2DuYOaSqkbLxxyi
	i210IJTuGVLzeFSZMf9yDSy59Itww1az2jOMeVEqLp5AiBYrVGQnGoKICBXfb5ZS4YRWD3tXRwM
	/1cbdHUZf1WocGGFqNxsR1YUXLcHkSaUDkj/
X-Received: by 2002:a05:600c:5247:b0:4a0:263c:704f with SMTP id 5b1f17b1804b1-4a211caf3a5mr2595685e9.16.1792699607284;
        Thu, 22 Oct 2026 13:06:47 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:46 -0700 (PDT)
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
Subject: [PATCH v4 1/7] dt-bindings: net: amlogic,meson-dwmac: list the compatible combinations
Date: Thu, 22 Oct 2026 21:06:34 +0100
Message-ID: <20261022200640.3101932-2-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022200640.3101932-1-tanure@linux.com>
References: <20261022200640.3101932-1-tanure@linux.com>
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
index 5c91716d1f21..69244afc4ff8 100644
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
@@ -172,7 +171,7 @@ unevaluatedProperties: false
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

