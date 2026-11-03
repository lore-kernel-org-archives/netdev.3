Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723843;
	b=P9okEeWLvS8bBcdjee9wQg4HLUhGRDH4RfmyYiVy8sWQHBSPXZz6DwfZrgDtwjM/WD04
	 X0cGpZYUgB/0jnxRy/sB462GNhRJVUzf0ELxVfy7V2iAqRaaXrkDZC1RZlZoTQB/0wCIy
	 aRIj0/jFI8GwXpq0d6pkIH74ZISjrp+DBjJpDWCiNvD0cEk2Sg/3ch+PqUH0gH9hmzzYw
	 WjUOddF/+HphVcd+49lHNRj/smlSvDEFIOMTTPzhPWBSh/GZO3seKH+rBeiKM/yVDnjhx
	 wAUSRSSzYXwh5vkBoYuNi5HQmtyQFIkOH1AOtChFWUMFydhzap7gBe8EvDAFfxoueuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723843;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b7yfUIavlqkZvjW0hdKuc7GNLhU6uDD+OhW8RPwrMQg=;
	b=dHQcYwwS2b3IikWDNwxHWz1bZO/hGjfdNCBCYaEmyWwALf7iddfgOczr81Y9TEXYWuOQ
	 /sTTjZ0whCR+o5/4leTIcgf2yxwBe6WLUEdM1o0ppgkcYmrO+suwsaQooE9JmuHCSOB4V
	 ZanU62QNI4f0bYvlculiW59IfHj+CdSkjzMfk8YPyBbdaVgtpRVtIU3vw7CBWXonTKy1J
	 ZSYpGt4zNTC2TOBaDbwuZno0NQP2DQe0pxZ0Pmgia/8aS5IL0k0zkhOD0l0XU7lgHv6RN
	 +/tXplaDnyoed/rGDn9P/GS/PtoyLfzQb+FVj/Q2Ghh3PtYtH2oXgtT7RZ/wd3jCp2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362F606EE99
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0362F606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2257587f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723841; x=1794328641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7yfUIavlqkZvjW0hdKuc7GNLhU6uDD+OhW8RPwrMQg=;
        b=mWuskmlPpEeEbcewx+dUv4tt41a8hFgn+c/18T9FiaoTJpQfH4iLI5e1ePMstxZOXd
         II0R1C0Mq2snG+U7bL2iRWrPV7ktg+JO2ZR/Kz3KHye5whaOc4soVlU3ZNdpyi68HdSa
         gQPFCOo+KkbbfFlWv7NI9NsgNtazbSJ7UOstf19BgRZTW8yBeIGlwiWaimKZGhe1+9ud
         wGKGeXeKOLkGkUBso86fge47AKo8TCZc1AsFYJcc0MXxA0O7tOuaN8cIQElsffbKbuM8
         HJYZmH2EuOiZOgHr6EHwcfhbZBFgcitKHvk8LG0UCnhHFQswnaaOfk9xxNeRIM5gEumx
         vLVA==
X-Gm-Message-State: APuU4Z9qLdxg6LtDQ6sHzG3zTulLi1DekSEeqwwqVukTbBQ3l4Af3PR2
	Q6VNRh/7ut3DW8WM9jdk0+g19QJ+Lag4L3wDnP0Gqetc55pw9L1eTigt
X-Gm-Gg: AYBFou2116OTGO1238sQGHwuDFWvFVIhmsgMn1z2GB6xWtqTjggeOYy0VV6/Y7mKeQk
	8y44dH/ax0RXbmuz2ADexvWCYGfYkSBbLmMRuzisX7tp0oLCjbWVjhUtNVai3WIiw39QxYtvlsx
	jo340r9jfbDky9admdb49eyHwBqAJ08mVTao5rMNEmnmipnVgcrDKBQEAupWCsduelTJGyEsok6
	eRS4HmFHxBfJOJTuwd3Lt3nGHnTWh4Z5w0IT3LHbUwql2D1/W15ARUZm5c8Bs8LYP0aeJAORYKR
	LVHPk1eOBLminotdXC6c6N0HFQIwfRPrMB2Jk5qrotBGJ7HYTytpQQ95r0FHwbon4n4V6lwGf/C
	CkJ84lu9WYYy7AQucIqH6CKdKnL1qjgYnYtdF8lfUvmnuk7Z04j8WD9l/GDVLIEkUoF9KPd3icB
	PFCvp4fg22NIG38kEK7e+vVt+Afr96YhFFazisR8NlPhpyIcAUjrrGpfZyfwSY0TdQYFL9RTrDB
	JwY/KwF23Vhub4kCzFrLOVj87txlwb/GKI/nxE1rn8DCuStO9DcDCOnWWQcYz00yB02UTl4SZ7K
	0jMGX/2X5ul4Zb+FQYG1MCc19uDvVLg+MhYm1TcffurFnp5Pps1lJ32rPLeT4CyrmlZbiv2LiA8
	8db+JMX8YkduWajCf+yPmRre2IA==
X-Received: by 2002:a05:6000:41c8:b0:48d:faa6:cedf with SMTP id ffacd0b85a97d-48e6e50645dmr30646945f8f.56.1793723841371;
        Tue, 03 Nov 2026 08:37:21 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:20 -0800 (PST)
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
Subject: [PATCH v5 4/7] net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on the T7
Date: Tue,  3 Nov 2026 16:37:12 +0000
Message-ID: <20261103163715.385394-5-tanure@linux.com>
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

The delay code reads phy-mode as the list of delays this glue has to
add, falls back to a 2ns transmit delay when no property asks for one,
and takes the vendor delay properties. ethernet-controller.yaml says
the opposite: the PHY adds the 2ns delays, and the MAC properties only
hold small fine tuning added on top. Every board in the tree depends on
the old reading, so it stays as it is.

No T7 board uses this glue yet, so the T7 gets a path of its own that
follows the generic rules: the receive delay line is fine tuning in
200ps steps, and the transmit side, a quarter-period phase step, offers
none, so the transmit property is refused.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 450f7b4b29a6..c8bd15b6780b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -80,6 +80,7 @@ struct meson8b_dwmac;
 
 struct meson8b_dwmac_data {
 	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
+	int (*init_delays)(struct meson8b_dwmac *dwmac);
 	bool has_prg_eth1_rgmii_rx_delay;
 	bool has_pipeline_clk;
 };
@@ -338,6 +339,41 @@ static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
 	return 0;
 }
 
+/*
+ * The T7 follows ethernet-controller.yaml: the PHY adds the 2ns RGMII
+ * delays and this glue only fine tunes the RX clock on top of what
+ * phy-mode describes. Its TX clock has no fine tuning, the only step is
+ * a quarter of the clock period, so the TX property is refused, and so
+ * are the vendor properties of the older SoCs.
+ */
+static int meson_t7_init_delays(struct meson8b_dwmac *dwmac)
+{
+	struct device_node *np = dwmac->dev->of_node;
+	u32 cfg_rxclk_dly = 0;
+
+	if (of_property_present(np, "tx-internal-delay-ps") ||
+	    of_property_present(np, "amlogic,tx-delay-ns") ||
+	    of_property_present(np, "amlogic,rx-delay-ns"))
+		return dev_err_probe(dwmac->dev, -EINVAL,
+				     "only rx-internal-delay-ps is supported, the PHY adds the RGMII delays\n");
+
+	if (phy_interface_mode_is_rgmii(dwmac->phy_mode))
+		cfg_rxclk_dly = FIELD_PREP(PRG_ETH1_CFG_RXCLK_DLY,
+					   dwmac->rx_delay_ps / 200);
+	else if (dwmac->rx_delay_ps)
+		return dev_err_probe(dwmac->dev, -EINVAL,
+				     "rx-internal-delay-ps needs an RGMII phy-mode\n");
+
+	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK |
+				PRG_ETH0_ADJ_ENABLE | PRG_ETH0_ADJ_SETUP |
+				PRG_ETH0_ADJ_DELAY | PRG_ETH0_ADJ_SKEW, 0);
+
+	meson8b_dwmac_mask_bits(dwmac, PRG_ETH1, PRG_ETH1_CFG_RXCLK_DLY,
+				cfg_rxclk_dly);
+
+	return 0;
+}
+
 static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 {
 	int ret;
@@ -452,7 +488,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 					     "missing pipeline clock\n");
 	}
 
-	ret = meson8b_init_rgmii_delays(dwmac);
+	ret = dwmac->data->init_delays(dwmac);
 	if (ret)
 		return ret;
 
@@ -475,21 +511,25 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 
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
+	.init_delays = meson_t7_init_delays,
 	.has_prg_eth1_rgmii_rx_delay = true,
 	.has_pipeline_clk = true,
 };
-- 
2.56.0

