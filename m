Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723841;
	b=RHP+jxe+cJyFiSH4NKMSL4sWPZziPkaY/2VlWFX7LHM8tm4zXId//j9gOy2TVH2CxLXw
	 Wh5nYh/TCPayIglCU4wo1+scIznPfBM1z+I4DXZhDbfx+RUYDcz9LXb2QF0C7kGyvCP69
	 5mW/JZTTK1DipKXPegGjUkCm8UYuhujKNa/qpQP0Hxb/qNdKGGN9SNi3xo2RkMzd4K1K1
	 DF/XeDUjBFcNEQ2ljqFMLy99RbeBsMLGH3m+LpdO5nqYfl0ccaobUNDh0EfxAon3F4Ug1
	 1Ef4T6KfMERBDfIMXkqdCVW3OGGsiJ/jQBlQjF9aBFj0VkjYyAHTFnkbKuGtw8LV7VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723841;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zl50UKdvdlW8XEIziu1Zq0cNn23HYvybJSqNilE3YHc=;
	b=trG7n7Fa1uGl1pSc1PrnqgzYHBJyrNFpsNQDa5iQIXdFpy2csWbQFOcmxttg396Wwhws
	 MI5cLsiPIy3ozDS2e4HUVCnVi6fEwxRRBAMaDTS96sGXTMJDIOzgcGzGrKi5nBxEYZCy+
	 syFcjhVUko3QpOfiDwFbp7mBx8TBrB6TJzE5Ig5jSK59mc47Li8+S/JRJLbmSYd7E9TZa
	 5QGyyAJNhSXG6Mb3NUsGebtMbNy9GBI5FkEmu7A+pjJN5bj24EKS6EwrCFcdcFjwrhxDd
	 t62OtEJ3gcpDzhkz+df8dlMD4tRbt0mBBlpHssWdzfo2HDSeTt1p6lydo78YD0CJwcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFB606D81D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01BFB606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e0d1da913so759921f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723839; x=1794328639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zl50UKdvdlW8XEIziu1Zq0cNn23HYvybJSqNilE3YHc=;
        b=DaTy+wZU7KJRV5q2Qqxuqf5Hsq9g8PGgbWcCGvEzU9uej9XvLyzoqrSPxmaoMx9fWr
         jR+63DefAJd/RfvBRzt/oOCL90Dab8vbSfWeTn5Url97djBALbZTqZASKF6EHGZa0N8H
         UEpkQUgTLkdXaTVOmmqQ/CRL7Q059abTgLLfMRiTkCpSQ00E8t7r0F+OlTXUiyxBBNXi
         K4zyrhyBaFsqm+dm/21WB78zevrvjJxj8yLk9foFXEqvz4LJsJLPU9WibjNR4Bm6a5D0
         2hSypOhUlLVAmZVPoStTi1D/kQzQ0ivOVjqk6tVn5ch46z9icKPFbsHmXl0zLX07LEPz
         WoIg==
X-Gm-Message-State: APuU4Z+z2QGiC7dHTdph/48C89NYFbPA2XJjq/hasWzMRiL27cBzv8bt
	D2YzmH6rfgEaoXOpJJaGdxBwinpKKaYH+Y3hLbfk2dHlhdiAV0VZ+mh6
X-Gm-Gg: AYBFou2ESTx+KGyIPecBkwaCuSKsuuc9oN+zTxHH96tKlujS25U8ebswhnByPWPcame
	ZNw4oUgL6RIgq5BISP7s6dBW/RbdN9KPivGQ9yHNcRR33omVf9l4+7edc4DkwYHlymi/o0mun6V
	aiaVCLC/s/ukIWgZM94z1vvhIdN0HgPe8tKrctfhNMztM14Zg5kvKlZ4O9IK4U6cF+el8fhXaRj
	/MGydrejOhWdvgyyYaX9y8WyiS25D01zYr5xdXT5c38kQ56lWequgi/DuVrZ4NJbB+LXwBhmKqJ
	mewSP6/D44CVZkvPV1SvR9tc60oxDMFl6IGVydh5xv2x64vaHYHPJAS1eJa6BJdgzZmaj7jVpSj
	SqwRVFld8gZx4/V48EDfmyaLdpplF43GZFGJtSw6G2XOHOpBmyj5Nkq63v8ZX+GP8BMQHE60ViF
	9Rv8dsnLUCMQSI/LDSNJkKHjx3gdWPH3+24n9uZFnQZvJfrsA0hEXEJzXuGaKaQqi1ZvQ1gGOOC
	8FvobyDYMK8BkYKhoUyXS3reH289Dg2DNXMwzd8QK2QXzfb1Kt8OQjoCB1/Hs9/TxTaK4fS8FbW
	UpBcywI9VhzaHsFfBxVyqe3uzB4Bf/roZEPOvseTNcQAm5DrHxWH4J0aZFKP4sTOy8PkPuOD0Uo
	cbXMoGzuZ1/3kfoKtWuVxs1LZbA==
X-Received: by 2002:a05:6000:2082:b0:487:13a9:80d with SMTP id ffacd0b85a97d-48e6e2cb572mr32349416f8f.10.1793723839219;
        Tue, 03 Nov 2026 08:37:19 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:18 -0800 (PST)
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
Subject: [PATCH v5 2/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
Date: Tue,  3 Nov 2026 16:37:10 +0000
Message-ID: <20261103163715.385394-3-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103163715.385394-1-tanure@linux.com>
References: <20261103163715.385394-1-tanure@linux.com>
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
 .../bindings/net/amlogic,meson-dwmac.yaml     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index e769c9bb70d8..6de013e3e8f6 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -23,6 +23,7 @@ select:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
   required:
     - compatible
 
@@ -57,6 +58,59 @@ allOf:
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
+        # Deprecated: new SoCs use the standard *-internal-delay-ps
+        # properties instead.
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
@@ -106,6 +160,7 @@ allOf:
           contains:
             enum:
               - amlogic,meson-g12a-dwmac
+              - amlogic,t7-dwmac
     then:
       properties:
         rx-internal-delay-ps:
@@ -142,6 +197,10 @@ properties:
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

