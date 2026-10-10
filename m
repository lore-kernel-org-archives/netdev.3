Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA540F736
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629949; cv=none; b=qUFu+GbYftbNShbRt/nTtOQ6HHcBriT0PDrluAgWzt80VECt20JOxGbXA3cLxnyZWzn3PMfMLJXnp3HFa/OJXW8tPXxmd/AdoJ+3OKUrD2JGNYoJUWHocfCN9eedt0qXYC+OArQblYnRRxB+ac2HD6sLkSYFoabck7D/Iv1Snu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629949; c=relaxed/simple;
	bh=oE2Rl8+D1TRG1w8Cfdh6UV45uZxBzx9uVMcPjpIOUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot5xraXml9EwULX7yLQu60IiEEJC1q6v85pOjXKqKpYiTkrpK49zJOQaClo1Lx0MqKA0y0XM1okKt7UKlSF63kI4ccpAvL8i3orbePo4F/NwnDeXe+lMyMFDEhXO1UwIbtvmKmhnFqGnOoab6f0GDAynuVbzzjqf5igjSbN8gNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4be28b82so456649f8f.2
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629946; x=1792234746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4gXjrYN0DCkNltbrRiGH9pQiOBUm1iOh6yJiBhfVz8=;
        b=dyOfZBCWaUbMICSAevun3fAL6+S2DvSbcnGxDpmVUDQ3khVLg5DznTi+Hqtc4fIW7Q
         fWVn2iFftjkhJW2o4ebpeTpOPMDArkGSssfSO3ltpB/mklZLx8zmggmQd/8t5CoGBfXA
         wyp7TtlgGMKbsO4XeJCmmMliAEgURLlysaUfGWl4JLwKcv36Pbg84fPW6OUFuXkwKGuj
         37fxzfo+dgTxAEOSf5YTSe8pGs2/HMNfQ1R01rVVL1Hq/R9n5dp42Dllcr3OHX/Vchnx
         M5EqytPE+pIGAtaal/+hMvKls/9WChzkyjYBet9KlDuiI+/pZ2Sg9injNR1S9OELFHGn
         swlw==
X-Gm-Message-State: AFq9FYLULixn+Ee1XA2eSEK/pN+oliAOIgOBeCljHV1v6ZW7GnqTc0Bg
	8Vg2RhUb7DpWq0Oc0MvBygDeXTYd8Mmsl0/iIDkpV+wnCiDHdUMpU5Qa
X-Gm-Gg: AYBFou1YhNkmtp7KyZ5JVg756Oi7X3bL76UkBYjT5HoKvVkbUCwKRZy2uvnjHEEI89p
	yW5PKWu1MiUhEQN1q9uz4TQfb2Z7wDHDi3Dwt2n10QBHCkJPedJVuJ91sP6Ia0ic5yXh5ccJNs/
	EWNzSBanV8+wp51fXQda89I2MmgT0mr+34V1y5kLMMTSCVwdXLPBB7m24tTt7wv/w8LVOkP0Arz
	y0kCzaGgbV2h55sG16fEX6mnRyuZGUVeErwefws8e5D3CUoqZg7DjYztI4ldZdFnRWdGmOpPNwX
	aUD4WPXqlHJF5/Pk7+Lc36iyMF7fzxRJa9/j534ScTg4ItvGt8JP295GGuaIckQe/lO0CVsgcpt
	vb3cll80cQMxXVMfbBkHMYqA5K8lJ8o3Lhpqw5WjvKMxMg8WOyKZcqmvDgfGUptSqO8+0kyKPJD
	qavMT/qsCd+5urVqPOlRwSK82nZBpVk3Pf4kJJTtNBo/jlxEuhjkQkAdJiVgqVEtV6eBZWQ3sZJ
	2yLX/jzBm0G5eeZSVqJq9sHQiHyYUzweQI=
X-Received: by 2002:a05:6000:40ce:b0:48d:bb54:77e7 with SMTP id ffacd0b85a97d-48dbb547b24mr8860590f8f.29.1791629945711;
        Sat, 10 Oct 2026 03:59:05 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm8709526f8f.57.2026.10.10.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:59:05 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
Date: Sat, 10 Oct 2026 11:58:54 +0100
Message-ID: <20261010105900.247342-3-tanure@linux.com>
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

The T7 has the same ethernet glue as the G12A, but needs two clocks of
its own. The controller reaches memory through a pipeline stage with a
gate of its own; nothing else claims it, so it is switched off as
unused and the port can no longer finish a transfer. The glue registers
sit in a block clocked together with the MDIO multiplexer, which only
probes after the controller has programmed them: with the clock still
off those writes are lost, and the port keeps whatever delays the
bootloader left behind.

So the T7 gets its own clock list, without the timing adjustment clock
it never uses. The delays follow ethernet-controller.yaml, so the
vendor properties are not valid here.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 90ef79161ab1..2353dd9181ed 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -23,6 +23,7 @@ select:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
   required:
     - compatible
 
@@ -57,6 +58,56 @@ allOf:
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
+        # The TX delay is a quarter of the RGMII clock period per step,
+        # which is 2ns at 1Gbit/s.
+        tx-internal-delay-ps:
+          enum: [0, 2000, 4000, 6000]
+          default: 0
+
+        rx-internal-delay-ps:
+          default: 0
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
@@ -106,6 +157,7 @@ allOf:
           contains:
             enum:
               - amlogic,meson-g12a-dwmac
+              - amlogic,t7-dwmac
     then:
       properties:
         rx-internal-delay-ps:
@@ -143,6 +195,10 @@ properties:
               - amlogic,meson6-dwmac
               - amlogic,meson8m2-dwmac
           - const: snps,dwmac
+      - items:
+          - const: amlogic,t7-dwmac
+          - const: snps,dwmac-5.10a
+          - const: snps,dwmac
 
   reg:
     items:
-- 
2.56.0

