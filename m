Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873009;
	b=Ynh0lpGWLvK2s2e4+KNksOsFnwBVMkzjVPgPojk5cCerrvmCah/nT2uQD5MczENUKHRS
	 AinsW6vErq0W/KVnsWt8Cm3tEM6NM2tcrL23S7/2ttvL86WC+Y4LmM0h/6l9IjC5TKaHw
	 aRMP0l7SRh0wIfVbj3anFtu27cwX4+HJ2lQ+DKbS6rOeNLDZuP+eIjrNfnUTVLtaotNZ5
	 QHLbl3iNEWCjT1qlHMPHdcW8/wOVYCq2Tjwzsg36lX4sQKVtHEO+qjxeYt/VzMgelrTqD
	 LV8uqBTHBy4MjdL9bppWDOAlaAYJtoWtnd/2AkhWkkAfbxmuAG/M8fHIyKFalpkBX9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873009;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=riOJeDHnKOl8qZ1I9NldksXV+t7kX6cUU4xrN1nR2eM=;
	b=ILkY7QzuqVcg4JdcW43MtIoANqgLZaXR4WjRjjOpaMIh808E3cmz1sGfPNhU+LQuI2qQ
	 kgh5Eo8s6h8efu65XqRZb0csoRp1Ndw2eV6RRFoG3FXIon3n+d4E67fmGVELrWnWKzTYr
	 dZhH9OTFwcy+nWEGhBbjmkwhzghDqcxrj7lvdQBy9Kj0ppQOs69lJnrw2TLfRqK4x9fUO
	 JSAaKDgYsNol/+pvYgdV/JB4i9mMutyB9/F57UuaN/jbZP4XDR0FVGhgxlWyH/a9qjmDh
	 RJAui7kKJJgiJINofmOyzuG4riyHd6kfmv8cutvAZuCa7bqEmOyUdyjM2RNw/geEoAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2F606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B2F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so15337455e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873008; x=1794477808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riOJeDHnKOl8qZ1I9NldksXV+t7kX6cUU4xrN1nR2eM=;
        b=auX4DEo4QPniIqwU8/BzH3YC5WJWwFrM8+jDWlZ11h85pTA1sKVW1f8hCVkBKK2Awn
         H+OBSCIkXRFhv+BMNcIWqhHHvO6gdnp22EcrbeFhvAGUvL0jNzbsfQGgpKSCGq1+eZRQ
         8wIiKv6Bmd0yD2hZkHTMMmWmHRADfV19Lap0OENm2eELkBy1+sa50p4Eznv5oDA0qLQ3
         v+MyNiUZ9TzIkK1AiByYyO7jNf6nztWvyydRbp8pMTHouzRofZ0YsHdwzWj+8J7YOadn
         jfLPwpU3Dm023yftKwaziURUK7FA7QywZ33VYsRG+W7w7P7x+SBUuKALSmWuW5GpkJkF
         02/g==
X-Gm-Message-State: APuU4Z8JYnbu2OFXphrGVm/koEsOAI1MM6/s8kmpvSrGXkE4u9PIqUcA
	Vn8FgWheY2X3gOGAuWfJXd/0zPz4Ar70+9tFQKdfVVIfemqfe2ePWyLq
X-Gm-Gg: AYBFou0baKo29dVHiC5Y6W/i65d0Yt3/wcUZD1unVTSKwV5WEVqG0v0gTdzcIZNQF32
	3pdnyHJ9RBP/Bn/38eyt6AzaOGzinTuaLbrL+S77D2wDBZUnTHJRVv7Ka31QftF0E8yD+cQAKDE
	gNBUWb6UT3jkk3uNnwpTCzGqY7ZGXyEPoNZUAVvMuSrURSCPp2NGtTLws8o12imrd2HnPk0Lv84
	Qe4q81WmE6fqKrVmASjRd3Kvk6xI1WkFFex8RdWHWPqPhpO9uQM9GW7bWIGm+b22eLOwGnLlmrf
	XaQSL1ermIRunjj8WG9uQ9TX+SV4mGTtILRBwgO11rmnF97OShxTcM+HvJnyajjCZOnr5D6OF8v
	Ztjglafftu4PQ0N5mbho8npdRQYAqmCYH946JusanyWyiM62u1m5NCgBqra2krY+VYhmJtx8OL4
	WB8sVctlm5XZK5cRv8KQ7m42vlWKk+Ms89aSfQvhNHfaiG68VANCbyZ1XdjR4NLH2uwctgDBSXH
	4lEXpxzL5rdLAi+6tCQfF6tomleWxLllq8b3t3/IDAUNp1HuPdQNi7M4Hx0RV3pl4k5e4yJ/QcJ
	26RjTBm4g2OHFFmAqaYPCp2Ts6fZCSbTUhq7wWA6wNyEY0Sjfq+wtW+KDj4RXowwFygDh7bWgsE
	mbB+4kAmIPAI89vUry5450tYZCw==
X-Received: by 2002:a05:600c:3b2a:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4ac1709a2c3mr391986775e9.15.1793873007590;
        Thu, 05 Nov 2026 02:03:27 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:26 -0800 (PST)
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
Subject: [PATCH v6 2/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
Date: Thu,  5 Nov 2026 10:03:17 +0000
Message-ID: <20261105100322.37816-3-tanure@linux.com>
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
 .../bindings/net/amlogic,meson-dwmac.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index e769c9bb70d8..ff5e50f65114 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -23,6 +23,7 @@ select:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
   required:
     - compatible
 
@@ -84,6 +85,49 @@ allOf:
         rx-internal-delay-ps:
           default: 0
 
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
+        rx-internal-delay-ps:
+          default: 0
+
+        tx-internal-delay-ps: false
+
+        # Deprecated: new SoCs use the standard *-internal-delay-ps
+        # properties instead.
+        amlogic,tx-delay-ns: false
+        amlogic,rx-delay-ns: false
+
   - if:
       properties:
         compatible:
@@ -106,6 +150,7 @@ allOf:
           contains:
             enum:
               - amlogic,meson-g12a-dwmac
+              - amlogic,t7-dwmac
     then:
       properties:
         rx-internal-delay-ps:
@@ -142,6 +187,10 @@ properties:
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

