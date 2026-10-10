Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B53411A0B
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629948; cv=none; b=TbeE4rfxf8AljZk6z54pNShbnYrTImnj22WhiXeS1oHA0FHWkHHMmbUEZ1ruf0pGHplQfIpFdlZji+tXom3FlPVPVkVIoCRoeUTkZnjBRLc+MCYAaPXav1u+gmXfA9RjIE/B7PboR8y9Qfif5E3U75ACYJkYWzBurp2EPajY+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629948; c=relaxed/simple;
	bh=5hwn9dmZm2lL4gEzMv7nMKFRmoByFyt7ooc5m5FQqRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLH1yuzaIJv/28pukFI2OVdc1tVX3kqmGKkwwKwT/M2MYBo+SQTExMTVrEuvsIvQXPaQJGORuiixnQBkY5CcebmyVQ7Bi3HuQamEmgWVBufbx2PgmwwzTfBl+MeGkk3JbF1IUa058vObIeVtvlRsd8ORT2P6hwhVaP5yULY11K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so4459485e9.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629945; x=1792234745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9iDEeSRYepWdUPmgZSkaxaPn0y4xYgwY4k/M0MT4wvc=;
        b=HFQGvzd8WZGhT1Cy1XEme4HpyIsBQ2pMRIpFmADljnVBQpn8dIjo1vIS96xAllBO9d
         9SnsyKVVGfkQlhiJ6ZxCjgyLTMgEnV7IhbHiFMx2ZWEpaWPrXsnMrwvKDWXfLedzhaDM
         V++YwgeggcENDu8/tqxZcoIKUFUUy2eXz0wlucvdgZKHzF0UhwSPO4/F9KHPpsV9fR6r
         OLxmnYIavkEbh9SSEg1fUQtP80W2jaZS3NjODWB7OjhTc4uFkikezeW3hi6jS8j376JD
         pSFUX9CRkdH3LIYH/FbyQPos5WSO5VBC/RnKSJY043XDt80xFz8TVVNv+r7yd2xKXfzf
         3+oQ==
X-Gm-Message-State: AFq9FYKGql6lt1UjKUToQAg4k+8SsjzOyOE30zfSm2x/s9aqvLFrfPEM
	mij+PnTZx3j1oJ4OIwckJLqySEHqMg6FlhA/CSk70ZXt2q5Y5Qou/wWG
X-Gm-Gg: AYBFou2FJZOCb0trs9KxgBS2aCPVeVQ0GWVdaJVY04FvlCs6rUDNWwZWlsDBFO6cHqp
	4vcoWZO+5czoJGKgapBKOHwL2hqdK1Nmu5gVpzfaO18g24y7QjDGjkdbm1lWFUCdgmvgmzA4Wlq
	NW5ZZR/mwTdSnmnMd/UXAKb4fi5CaFgQMT/EMWs1mk4GEJwwvn1sS524XaDC8A2zCZ68av/QtKh
	+7fixeRVrOAphhMVosjhKFUdUj58DKftoitkOu8pqshKatW5fkf8mQJDwWOsXXOvBnH///JheS4
	q7E0VF53RYsjRHrfAzVs8uc5uI4pIIb012HM3IaLTa1iFbX8HzwSntUWo7wKkyAX96BPOD3NQuh
	F+gCuZfJQ8exFP+sEFoQJcohv4bxRzxV2fBJA8adstU1kXc18EcMcNhK/9X/wzA08hb5D4GkG5U
	SC+x2lx4QbsvRBIxTEeczyNl5xrK76k5XEHn/0FTQmwBUYEt4+fcckHchVRypVnjF/CjzRc5AaA
	YkWGGdb4dIt1xuA6bw/7DQSEM9uSnA9NqkOV2U76EdMA00=
X-Received: by 2002:a05:600c:3e14:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-4a18e49316dmr71091115e9.7.1791629944857;
        Sat, 10 Oct 2026 03:59:04 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm8709526f8f.57.2026.10.10.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:59:03 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v3 1/8] dt-bindings: net: amlogic,meson-dwmac: list the compatible combinations
Date: Sat, 10 Oct 2026 11:58:53 +0100
Message-ID: <20261010105900.247342-2-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010105900.247342-1-tanure@linux.com>
References: <20261010105900.247342-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatible property only checks that the first entry is an Amlogic
name and that "snps,dwmac" or "snps,dwmac-3.70a" appears somewhere in
the list. It cannot express which fallbacks each SoC takes, so a SoC
built on a different Synopsys core cannot be added without loosening
the check for every other one.

List the combinations the device trees actually use: Meson6 and
Meson8m2 fall back to "snps,dwmac" alone, the others also name the
3.70a core. The example used a two-entry form no device tree has, so
give it the Meson GXBB combination.

Assisted-by: LLM
Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 5c91716d1f21..90ef79161ab1 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -129,20 +129,20 @@ allOf:
 
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
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+              - amlogic,meson-g12a-dwmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - enum:
+              - amlogic,meson6-dwmac
+              - amlogic,meson8m2-dwmac
+          - const: snps,dwmac
 
   reg:
     items:
@@ -172,7 +172,7 @@ unevaluatedProperties: false
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

