Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699612;
	b=Hq3dF28G0FqF9yCLeTwf0V55xM/UVk20sGzUdzaTdEE7zapBtLOmSYfZXa1VPzft3Iw/
	 HmhbnPlBQk9vx7RL2ss/JKPmFNRe7rdGrfjFoKcMdXg6Lu7RIo/PAto8f+pNvcVxQ7WD9
	 Xj+Hhe33EDOQHcmNVzbYIq+F6O8e5tof/oWnbCLq1vX5QPm4Eyz+zAR+x+eQBMJ5Fw6ep
	 33WmK8w3TSOzQds+JHuUxhFnDLEAghVxti+8ftgGgHv7Qqcs15v9Sr2vbrRmDnoNoUDnJ
	 ohj6GGVBGWnbi8H5+u1m2+JeZdvFeV3yvIJ0OGVXu7jWxDGTT1X6lruONLzl2DWqzlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699612;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=96350WqdsGhyHxXINfUlMmZbjGGRzw92jsjc9LeGtoU=;
	b=zxJiV3HsdRjSqi1hSIgLmaeWc9iLEYmM4fzOlDapP1s8cASeRZV8D5dBpQX42FidAqQH
	 35UuhoenIounoo92YM5FOBEHtT98ENC4aZbNEzO9IZYlTi2xWLUqgjr6dJNr4Og6jnkiq
	 hv1WDHY7o17a/PRUtubfhfkrOBIDxV7FQ0vf1beR3Gd8lvEb7lDnXU3hFZtBzxkoUd5l/
	 FD9OtpXcpL9WlabHPSCPfw6qUqOG6ifVM68Nn8F/hTqsko37+GCn35xb+0GlRnbJhl+F4
	 jQClR2zHqjcYpSFJhOmYR4GxJL3+7cgraV4677JfkdG4xOEDIrwfNJ/t8TNJewjTREg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3460A3804
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34E3460A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso2049525e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699611; x=1793304411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96350WqdsGhyHxXINfUlMmZbjGGRzw92jsjc9LeGtoU=;
        b=J1pj7ZgPwxN0DqL5ipk95YxdqF8V8CZS3TzRBJ/eZpb1iLHo1bVmDJM+FRGgtGXY1N
         xmWN2Kj7hB+jV9lK3K/jjOt7mCSGXqg/ZnDvRU9fbM5gSLnX8SYvMTuUV7KPqS0+Flu0
         Tj9rTr0y04YLa29SILabYW4HaP4aq7ZdSTWHLUyuvY4dxGiSfhw8iKd61VwC9UeymDgN
         I5D9ookLZdPmCS6VtOLC0vp4ZnJ7iBaY827BK3imgm0bvfNXCY1GQpzEiaVk7SnRRy3e
         OzQBHZpwvJxovLTPQVA0AyHouAoHnlpSIn7fam6QAC9Ft0sQheKG9iVcELLkaIEjGhzW
         C8Nw==
X-Gm-Message-State: AFq9FYLjBTACGqkDnHmKzFs7XajB7wdrMNvNMWZaP2Uirw0KdQWsLj4A
	lozEUnEIGkMGDwmDtbPiaF+grGZpeouKgqJNa7eUY+M1K13Cjq7Krsx2
X-Gm-Gg: AYBFou3bFDGlkcTZTlljcFn484NLL0F7r69xOBcMO1/RGqlpqDinu2B/oT9t7pZ5p27
	5MhMzqv57n+M2Pw9jqyi+BCWgBw0qDmEBW4HxzTWJjjm52fV5GTSxiWAx7BsMgRjJixdvmamFKb
	+dGMZVR328UCyfy4ke/TZr1lrlGPDEqYgC3/ml720+L18cMU00+dgrqkjhix22jMAthG/vUPfZ0
	3LRh8npsc7XjXa6C85353O9aKawRwtEzjnTdx5kmOUo0ymVAgYH8dOlZWNyfzDL6rGpEAAN64UX
	q9h15Y2lu6yJpYwxBgXeX2szq3/fd6ugix6aysAvWsWMwU08zY7ogu/+lLiMjud5WrgXFj42SpU
	0VS/4ngXOWC5iYilpMWASLQQe/de+xYoINp2FGYJWGw2Lhr9b33XZGRasvaKW5NFwf8rT8iFUP4
	z+SR9Xkd4FspGARSEXbWaSof38MWGTB7BFhlF9YONRriNM66B2HnJJzXgA1zlpBgXF2ImrI/y/C
	m3MoY+ruQIJdrv+WCP0LCVXoxImnxPyOE6jtv2aPLDBoOGSovLe5zRE39X7yE6vnC1+qzTbdKLe
	atPNL+YleuFjwsM=
X-Received: by 2002:a05:600c:83c9:b0:4a1:7ba9:da2c with SMTP id 5b1f17b1804b1-4a211ef7beamr1761675e9.25.1792699610441;
        Thu, 22 Oct 2026 13:06:50 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:49 -0700 (PDT)
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
Subject: [PATCH v4 4/7] net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on the T7
Date: Thu, 22 Oct 2026 21:06:37 +0100
Message-ID: <20261022200640.3101932-5-tanure@linux.com>
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

The delay code reads phy-mode as the list of delays this glue has to
add, falls back to a 2ns transmit delay when no property asks for one,
and takes the vendor delay properties. ethernet-controller.yaml says
the opposite: the PHY adds the 2ns delays, and the MAC properties only
hold small fine tuning added on top. Every board in the tree depends on
the old reading, so it stays.

The T7 has no boards yet, so it follows the generic rules. Its receive
delay line is fine tuning, 200ps steps up to 3000ps. Its transmit side
only has a quarter-period phase step, the full 2ns at 1Gbit/s, so there
is nothing to fine tune and the transmit property is refused.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 122 ++++++++++++------
 1 file changed, 85 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 450f7b4b29a6..95a185691503 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -80,6 +80,7 @@ struct meson8b_dwmac;
 
 struct meson8b_dwmac_data {
 	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
+	int (*init_delays)(struct meson8b_dwmac *dwmac);
 	bool has_prg_eth1_rgmii_rx_delay;
 	bool has_pipeline_clk;
 };
@@ -91,8 +92,6 @@ struct meson8b_dwmac {
 	const struct meson8b_dwmac_data	*data;
 	phy_interface_t			phy_mode;
 	struct clk			*rgmii_tx_clk;
-	u32				tx_delay_ns;
-	u32				rx_delay_ps;
 	struct clk			*timing_adj_clk;
 };
 
@@ -272,20 +271,91 @@ static int meson8b_devm_clk_prepare_enable(struct meson8b_dwmac *dwmac,
 					meson8b_clk_disable_unprepare, clk);
 }
 
+/*
+ * The T7 follows ethernet-controller.yaml: the PHY adds the 2ns RGMII
+ * delays and this glue only fine tunes the RX clock, on top of what
+ * phy-mode describes. The TX clock has no fine tuning, its only step is
+ * a quarter of the clock period, so the TX property is refused.
+ */
+static int meson_t7_init_delays(struct meson8b_dwmac *dwmac)
+{
+	struct device_node *np = dwmac->dev->of_node;
+	u32 rx_delay_ps = 0;
+
+	if (of_property_present(np, "tx-internal-delay-ps"))
+		return dev_err_probe(dwmac->dev, -EINVAL,
+				     "tx-internal-delay-ps is not supported, the PHY adds the TX delay\n");
+
+	if (!of_property_read_u32(np, "rx-internal-delay-ps", &rx_delay_ps)) {
+		if (!phy_interface_mode_is_rgmii(dwmac->phy_mode))
+			return dev_err_probe(dwmac->dev, -EINVAL,
+					     "rx-internal-delay-ps needs an RGMII phy-mode\n");
+
+		/* the RX delay line moves in 200ps steps and reaches 3000ps */
+		if (!rx_delay_ps || rx_delay_ps > 3000 || rx_delay_ps % 200)
+			return dev_err_probe(dwmac->dev, -EINVAL,
+					     "The RGMII RX delay range is 200..3000ps in 200ps steps\n");
+	}
+
+	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK |
+				PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP |
+				PRG_ETH0_ADJ_DELAY | PRG_ETH0_ADJ_SKEW, 0);
+
+	meson8b_dwmac_mask_bits(dwmac, PRG_ETH1, PRG_ETH1_CFG_RXCLK_DLY,
+				FIELD_PREP(PRG_ETH1_CFG_RXCLK_DLY,
+					   rx_delay_ps / 200));
+
+	return 0;
+}
+
+/*
+ * Delay handling of the SoCs up to the G12A. It reads phy-mode as the
+ * list of delays this glue has to add, falls back to a 2ns TX delay and
+ * takes the vendor delay properties, all of which ethernet-controller.yaml
+ * rules out. The boards in the tree depend on it, so it stays, but a new
+ * SoC must not use it.
+ */
 static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
 {
 	u32 tx_dly_config, rx_adj_config, cfg_rxclk_dly, delay_config;
+	struct device_node *np = dwmac->dev->of_node;
+	u32 tx_delay_ns, rx_delay_ps = 0;
 	int ret;
 
+	/* use 2ns as fallback since this value was previously hardcoded */
+	if (of_property_read_u32(np, "amlogic,tx-delay-ns", &tx_delay_ns))
+		tx_delay_ns = 2;
+
+	/* RX delay defaults to 0ps since this is what many boards use */
+	if (of_property_read_u32(np, "rx-internal-delay-ps", &rx_delay_ps)) {
+		if (!of_property_read_u32(np, "amlogic,rx-delay-ns",
+					  &rx_delay_ps))
+			/* convert ns to ps */
+			rx_delay_ps *= 1000;
+	}
+
+	if (dwmac->data->has_prg_eth1_rgmii_rx_delay) {
+		if (rx_delay_ps > 3000 || rx_delay_ps % 200) {
+			dev_err(dwmac->dev,
+				"The RGMII RX delay range is 0..3000ps in 200ps steps");
+			return -EINVAL;
+		}
+	} else {
+		if (rx_delay_ps != 0 && rx_delay_ps != 2000) {
+			dev_err(dwmac->dev,
+				"The only allowed RGMII RX delays values are: 0ps, 2000ps");
+			return -EINVAL;
+		}
+	}
+
 	rx_adj_config = 0;
 	cfg_rxclk_dly = 0;
-	tx_dly_config = FIELD_PREP(PRG_ETH0_TXDLY_MASK,
-				   dwmac->tx_delay_ns >> 1);
+	tx_dly_config = FIELD_PREP(PRG_ETH0_TXDLY_MASK, tx_delay_ns >> 1);
 
 	if (dwmac->data->has_prg_eth1_rgmii_rx_delay)
 		cfg_rxclk_dly = FIELD_PREP(PRG_ETH1_CFG_RXCLK_DLY,
-					   dwmac->rx_delay_ps / 200);
-	else if (dwmac->rx_delay_ps == 2000)
+					   rx_delay_ps / 200);
+	else if (rx_delay_ps == 2000)
 		rx_adj_config = PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP;
 
 	switch (dwmac->phy_mode) {
@@ -411,35 +481,6 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	dwmac->dev = &pdev->dev;
 	dwmac->phy_mode = plat_dat->phy_interface;
 
-	/* use 2ns as fallback since this value was previously hardcoded */
-	if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
-				 &dwmac->tx_delay_ns))
-		dwmac->tx_delay_ns = 2;
-
-	/* RX delay defaults to 0ps since this is what many boards use */
-	if (of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps",
-				 &dwmac->rx_delay_ps)) {
-		if (!of_property_read_u32(pdev->dev.of_node,
-					  "amlogic,rx-delay-ns",
-					  &dwmac->rx_delay_ps))
-			/* convert ns to ps */
-			dwmac->rx_delay_ps *= 1000;
-	}
-
-	if (dwmac->data->has_prg_eth1_rgmii_rx_delay) {
-		if (dwmac->rx_delay_ps > 3000 || dwmac->rx_delay_ps % 200) {
-			dev_err(dwmac->dev,
-				"The RGMII RX delay range is 0..3000ps in 200ps steps");
-			return -EINVAL;
-		}
-	} else {
-		if (dwmac->rx_delay_ps != 0 && dwmac->rx_delay_ps != 2000) {
-			dev_err(dwmac->dev,
-				"The only allowed RGMII RX delays values are: 0ps, 2000ps");
-			return -EINVAL;
-		}
-	}
-
 	dwmac->timing_adj_clk = devm_clk_get_optional(dwmac->dev,
 						      "timing-adjustment");
 	if (IS_ERR(dwmac->timing_adj_clk))
@@ -452,7 +493,11 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 					     "missing pipeline clock\n");
 	}
 
-	ret = meson8b_init_rgmii_delays(dwmac);
+	if (!dwmac->data->init_delays)
+		return dev_err_probe(dwmac->dev, -EINVAL,
+				     "missing init_delays callback\n");
+
+	ret = dwmac->data->init_delays(dwmac);
 	if (ret)
 		return ret;
 
@@ -475,22 +520,25 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 
 static const struct meson8b_dwmac_data meson8b_dwmac_data = {
 	.set_phy_mode = meson8b_set_phy_mode,
+	.init_delays = meson8b_init_rgmii_delays,
 	.has_prg_eth1_rgmii_rx_delay = false,
 };
 
 static const struct meson8b_dwmac_data meson_axg_dwmac_data = {
 	.set_phy_mode = meson_axg_set_phy_mode,
+	.init_delays = meson8b_init_rgmii_delays,
 	.has_prg_eth1_rgmii_rx_delay = false,
 };
 
 static const struct meson8b_dwmac_data meson_g12a_dwmac_data = {
 	.set_phy_mode = meson_axg_set_phy_mode,
+	.init_delays = meson8b_init_rgmii_delays,
 	.has_prg_eth1_rgmii_rx_delay = true,
 };
 
 static const struct meson8b_dwmac_data meson_t7_dwmac_data = {
 	.set_phy_mode = meson_axg_set_phy_mode,
-	.has_prg_eth1_rgmii_rx_delay = true,
+	.init_delays = meson_t7_init_delays,
 	.has_pipeline_clk = true,
 };
 
-- 
2.56.0

