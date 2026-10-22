Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699610;
	b=I9nFRXm+1ZW6PrUbWaS4o759pyzttalmIS9SCkR3RFM+A1h/EKz5s1L0KEzRHMrGTSVB
	 d6PrnMtF0tS2b2XSee2Skh57ds0teHVIVZehRTZzB0D9ceJZAgeolas4MuQnbXkvb8d9D
	 NeOg4okicxRh5Cs6517B86EUvPMFJ+3swmvMWCqy678gznwRrzxCejBrOl59fualZN41J
	 EWvT/7SyfzY7tM5AQB4XdvRV8BZK5gKEDhqKJ0tUoup9WusD1JmLPY9oiryvCDTc3Y3Hz
	 X6Y4roB6Wcg/FQCatA/Ps1523RsPaNGnhN+sLvGF0IJvXrC+p8fVNh1xRuOmCb5o8zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699610;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RJU4MN4q31InnCqnmctD1bfgzdWMNbsD2UQnbMenASA=;
	b=yPgbh6rCQhWVlLrbNGMnAukepqc78hVlWR6xcTFliZraJKNL5LtHppI3CgW9I/bxCUul
	 brYg7SxeoU/s66iihr+KIB/jaGb+9qIoCOfhW0ISz99gNxZey163QZ9Ty6hYIt1QzE2Ad
	 ibj2hsONlbAgsSj2iNFo2Xk6bJOuLtZoCpCuIS/2rrl1X+M7oLL5EmiOfQP6eTI+WX5gX
	 zjNQ4eYNdTg2m9fAz/pUaUelb1BPUQP6rKjypENST3BAUa1TQbNI137dvZVvwiDygXeEn
	 HSzNirCA+ouClZWgn6S/Vgu1p7m7T9kgIIcPEuRK5706O8tpqwtQIAXXkcrb5vKL8RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8603606A33B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8603606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so2157965e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699608; x=1793304408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJU4MN4q31InnCqnmctD1bfgzdWMNbsD2UQnbMenASA=;
        b=oAKN9CP9qrZnzSbbDTAefAhxOxumRwu/FQFsMSxsD0hwnF/UU7/N9PoGSktP97D/Us
         bKj4qCLWR/NPw+feiaAG4Kzj9Bu7wzNI2pOOVN0BW2sTEbP7U1mqVELfZw1jLm+3UwFJ
         MVdBhRGOAsnoNkICYiCzlxsRlFzyduChD4J0zALKrObOBYJDIz6dGBGUxKC8TvxPHtAR
         FtQ35EhLPWO0Q4FJZ7KFgefI1Aqplhv/AisS4npw8hJNSeMsDDZqJ49bvb7YifGuQ98T
         blANL/Lb9PDko47NbJhD4mJjmspKkOjqH+aBM+E15EivA2zJhDC0gB1aAba6EMzNrhUu
         uB1A==
X-Gm-Message-State: AFq9FYIJy3qU0ZbL/4Iim2gAjUQ19DxQpZ9CZagA0Tvkxl/CYr4Wxeih
	g/qn+fCugiy7J1U2s5V4TQhSW5PZB7aRPnvKTJy2ZWB26UiYCdXfooyU
X-Gm-Gg: AYBFou2ZjCkju3LlRXg694kZUSd/fLDtNY7/Ih4opu07vG28bS1Jxm+4YvKPg5FEqIe
	oMKmnl1SjJVMclJP+GqjiNPpNpDvEOkd58FUqny9+GlGISdnfDueHulJhJYRWvyeRKovNowUOz3
	R4cig9biGRCVsKRXB0oRQ3sv4e7dIxPALUN/Pmnd9cYf5DpPoK3Y0SEjq23kzRrAW8klqtSqvKQ
	YJWoZ0Gqet0XYvi7WRBv9dAEOY5QrayA28BIGMP4MfAopoBc+H1dw2jes0fbyU0FgG9lzgncrVE
	86ZNWubtoCAH/B7rpLtSHkCnbBrzftItVhtizGD/IB9mtP6y2QgzKDKMOQKL19yR13dy9eBusR8
	zx2F7sTUili4R2+o3x1HIUtaUMcniJqiCVxwc0kaJIdHlY/61VI8LWO7s5Sa0C5nMJtDI1QwH8g
	+hIRSkUm62YE7kYazk7W+5QvKztf+uzJeIED2wo5bjJHhZBfnp5We9v3OlyaFQgE0BZVgfsHXCU
	LyovfG/ibipUTYt65H5QKQV+5npLTJbKQrowja1QM3VBkZAiX84mDtLNqI/3I5XGYq5B9Lv/J1t
	ihOVi0ShfUuF3Da5ObTSwm+DiRpcVmoFa2ag
X-Received: by 2002:a05:600c:4e8a:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4a211eeea21mr2127325e9.6.1792699608276;
        Thu, 22 Oct 2026 13:06:48 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:47 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
Date: Thu, 22 Oct 2026 21:06:35 +0100
Message-ID: <20261022200640.3101932-3-tanure@linux.com>
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

The T7 has the same ethernet glue as the G12A but needs two clocks of
its own. The controller reaches memory through a pipeline stage with
its own gate; nothing else claims it, so it is switched off as unused
and transfers never finish. The glue registers sit in a block clocked
together with the MDIO multiplexer, which probes after the controller
has programmed them: the writes are lost and the port keeps the
bootloader's delays.

So the T7 gets its own clock list, without the timing adjustment clock
it never uses. Its delays follow ethernet-controller.yaml: the PHY adds
the 2ns, and only the receive delay line offers fine tuning, so only
rx-internal-delay-ps is valid here.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 69244afc4ff8..d27f0f2c52b0 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -23,6 +23,7 @@ select:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
   required:
     - compatible
 
@@ -57,6 +58,61 @@ allOf:
             - const: clkin1
             - const: timing-adjustment
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-dwmac
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GMAC main clock
+            - description: First parent clock of the internal mux
+            - description: Second parent clock of the internal mux
+            - description:
+                clock of the pipeline stage inserted in the bus path between
+                the controller and the DRAM. Without it, the controller cannot
+                complete DMA transfers.
+            - description:
+                clock of the register block holding PRG_ETH0 and PRG_ETH1.
+                Without it, the block reads as zero and ignores writes.
+
+        clock-names:
+          items:
+            - const: stmmaceth
+            - const: clkin0
+            - const: clkin1
+            - const: pipeline
+            - const: pclk
+
+        # The PHY adds the 2ns RGMII delays, see ethernet-controller.yaml.
+        # The RX delay line of this glue is fine tuning in 200ps steps,
+        # added on top of what phy-mode describes. The TX side has no fine
+        # tuning: its only step is a quarter of the clock period, the full
+        # 2ns at 1Gbit/s, so the TX property is not accepted.
+        tx-internal-delay-ps: false
+
+        rx-internal-delay-ps:
+          enum: [200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000,
+                 2200, 2400, 2600, 2800, 3000]
+
+        amlogic,tx-delay-ns: false
+        amlogic,rx-delay-ns: false
+
+  # Delay definitions for Meson8b and newer
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson8m2-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+              - amlogic,meson-g12a-dwmac
+    then:
+      properties:
         amlogic,tx-delay-ns:
           enum: [0, 2, 4, 6]
           default: 2
@@ -142,6 +198,10 @@ properties:
       - items:
           - const: amlogic,meson6-dwmac
           - const: snps,dwmac
+      - items:
+          - const: amlogic,t7-dwmac
+          - const: snps,dwmac-5.10a
+          - const: snps,dwmac
 
   reg:
     items:
-- 
2.56.0

