Received: from mail-wr2-f41.google.com (mail-wr2-f41.google.com [74.125.225.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F744E65B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124853; cv=none; b=P4ZtZQc+uUq5YKHIkENODT62gxZZaw2EWZl+F11kG5oiuOpaSHV79ttsFJMGH8WiLzjUpxlYtSHpVGM9bluSLbQLC1bDlz9hO5Hh/m1Af4FtZxpDOcxwzgjxlY6JAeRZdRr37Rl8/MTdtpsmrX4H/re7qOzTy7OluZ08LZNjR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124853; c=relaxed/simple;
	bh=r0bZehJ/h9qV6bZwoNpL5+7u+BLPuFzPlDLsb0N2RCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyAYO3C0tDNukpArScvg5erV0z0ThqwHCX+1wNe2hLyJi4G7nvgG3D+inckQ1MFlu5o8vVUyqc38la0ZUjuZTdxbzCGrrmxLq0iK/SfXgNRa68yH+WUpfQvEM8pzrBTg6kl8JDxq72P4cVU+ZAnX70Sglcmg1ZcLRfLNJQxEqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f41.google.com with SMTP id ffacd0b85a97d-4834977ae75so427053f8f.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791124849; x=1791729649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPkMV4LDUGNtqaIPInjsEvbPyhBM9s86wkifiwBiN14=;
        b=U+GOvBay596fIMRbDLgbpNo/vgM0Q8oNpdhWL8V8SKaJhVtb7Kze+rGRXKzSe4GTS8
         co72jk24XyCRSEpubE3h4ppHkuarh8D1rWstF4d9SsQJzT0S71nh02rF1LJCBCCB2XGK
         w98wofyNPSEy0S85v/EixTAh9TwopCt9Rx9L747xRR0ENHEUiOOGCHjPVqgtrN+Vul+B
         mtzPI2QxDkT+uFH7RZw7qLRa3Sf00ro1g0cio3XMacAZ4caF7huDCfk8xQkoQD4vTn6h
         Zhz1STYPHsaadet63G9jyryBgF8S81iBaw6WJy3mUwctnnShOjRPbazcAPdDDN0Je1Lg
         IlRQ==
X-Gm-Message-State: AFuF++mkLnDUX6xgfNGMxtgoz4PkGwg6ZCper9K7k9yv4yOAs8YBBQmp
	7hNJNGcvWhjeoV6O9hWM4gR3MZZ191421eHlDk0xXAhYvQLbGnXGrKhq
X-Gm-Gg: AYBFou2sYrW8L/WDK5zRNWEQ5+jVkcFjizVH2GbKmHLususqvEAJlMmmpitu/5JQXna
	mKUai1NoSZ28Ow61dd9yZ8p5EUZkXHjJg4tJrZSCpE0o2Q5w1aZiMW1TzLAl+qX4MUuW2TpPRHm
	3gT3Y5P0FDhPpJZyKOqHUtzu9kIvoxK+wGh7lv2aFy5UAmh8wc7tNfxqSwVh2KEfpMNuje1/OLz
	Lm0oEp8ItkEdUaK2e1RyAX4N4uA8wl1mg3h74OFZj1uVNeXfRV0D1Nbf0HHqvIRtEgXwpptxvJZ
	PWKZcHdvM6X8TjOzcg+VGkN6UfuhGzSaowNv7ToAlZyg6uMOFdzIAkJGu3k27lR9qplXgDMYfks
	iVwvSWyH9LVPaZ67hVkg+fKwsvJhL07tRF6BYvLjHrcFlrxW2DDz8UHG3sCTEoECUlhgSXdaAmd
	KHGgocmA5HJlfoxb2enw05fucBf9nvXv/LL9eToarMQ5o8wjI+v6VjX9kdlqoh48eYgze2nnjXQ
	p1BvpSq+pR9EN5Hq0GPn8iCdrsxfFMKmw==
X-Received: by 2002:a05:600c:870f:b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a0274e9d30mr145830305e9.2.1791124848951;
        Sun, 04 Oct 2026 07:40:48 -0700 (PDT)
Received: from threads.localdomain ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm298907685e9.13.2026.10.04.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 07:40:48 -0700 (PDT)
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
	linux-stm32@st-md-mailman.stormreply.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RFC PATCH 1/6] dt-bindings: net: amlogic,meson-dwmac: spell out the compatible combinations
Date: Sun,  4 Oct 2026 15:40:41 +0100
Message-ID: <20261004144046.391444-2-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004144046.391444-1-tanure@linux.com>
References: <20261004144046.391444-1-tanure@linux.com>
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

