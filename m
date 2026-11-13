Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572341;
	b=wdozV6OAoX+JxCZCYSYcS/yLoKcPmt1jV/YA7CJtAQR95jvo/hzEDXrBDmM91HqC3Lr1
	 qMBFmu3M+GFjRLws2up0UCnmsNktMS3IByRSMNqZoIWHMhafTyjSoSLnHnj3Wsl5B27VW
	 t6dypXCP3gmCX3QzhHsTJDLsfTRu2VhZX1yqtiRaaOw6A0am/qTQyfqqgJlSX0hcwyvpC
	 K8infmt6O5eY96F3ywaMRqYcdEmMx2eGjUJ8o4yhHEeyRWknP1vBJnM/3Ubw+ZTzwhz1D
	 Ck4DvFhfHPPq3DVNKa7ZUNBLQTZtzaF+8gdgFjMb86p+lhtpr/VGxmaNQWZtBAUDJ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572341;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tO+egXWm6JoZZG/jdjtdaE5a20hm/Ptu/AmJt75eDBE=;
	b=h7ldLnMpM8wqNVapyxcteol5Svht+1DCKGYSk2Y3JlAjewFpfWWXU45+EBooq+G7KoiX
	 EN7/6fjeKIl8AxMP1r2E2UiaYkUTJBa4L9gTUs6DithgumO75Ica850tPnmp/iaw6ykD4
	 4qFFU8DXf5g+nkDf7+8DTrnBJXR+1OHHHbh69ZNmyb4iJfnH8O0k+T5tWN0jmkD7vRHpM
	 NeBaUFHWHBrybi6voziN7jZQtbrSAZuZcAwXhPYzqj4YZ+XzzfDrLPzAQqubh36KnF9vk
	 1Jhv319r3U/So/cV5Eg3X7DFBvD7wZ1hIetT4+jpAR0+MDZMuWsPA4jK7Or3wlGD2Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E35606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E35606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso12814475e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572337; x=1795177137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tO+egXWm6JoZZG/jdjtdaE5a20hm/Ptu/AmJt75eDBE=;
        b=PItMDPMzsM7XmXYouAVjCuoTOJyFtyJyhSmDYBEi8p684z0lDH0+zN8kQ5jCW7OANJ
         34Uyy98eRQfQpG/Qdn7zubOVcvn6SDZ2EqXG/euJRkxBMKkiSz7gFvBCv58lKTPDbe7I
         wQEZzvi33h6I8Nvo4XCLEFipr+M4Veha+0Okb2JPeEWUY1KCm8NbrfJjaSFoynm0FXcS
         ixA4kCO3GnJwejL7V9Un7FdMP6h1emI3IwSOtH4d/rpBReVcFoZRGONYimeO9yURUJe8
         BsczCwqYTShSU0IQQzVQm6xKNAfeQonSRlGpXmglrHDoRF2F95eVM1zihXVT69c/Oqwx
         ndQg==
X-Gm-Message-State: APuU4Z+xiG/R7LutvRE1HZkDbx9PVrWaRlvjtm4FzVWBDXYGtJlaviD5
	cT8JWKd5DL91E+bi6/Pc48h3VakOonyfYzBtUHVfXrQHN1HEdw/ogSCQ
X-Gm-Gg: AYBFou1SDo4mBWm2BoqRS6S4mIwAxx2STCPc0oYnI7OXETwo1s7wYIhsEyj/OWAMRab
	7istxk9K33YEhUzRgNGgoFTbUuRmlyp34ZqooVI7X3RQZvCCKGPkCpHeCOKX4q5A0kQpvdroA9p
	rY80yblh4j4p8G1M/ZnjScxcit+E409tv0QKmwS5YEFWGrCf1U1Js4A0nPgWfNil6smz+S1n2iJ
	3ZKvdbbljGeOj7ngzCm+pzvbqM6be/EYL70dhMFjz2af99RuwFmHrLwrs0dujgh1TmtvULdLb/B
	R12ilUxn20cAJRj742Myz4SVPMjRHtd9JAY8TfZaKHJH9DVWvOQPGbjpslgpK39jveQNwOFKU7t
	LTu2B7IyIDVH0IqBMT7pKNWC1uKxGpycIwcCzCQ0S0uDxLFhayRCIk9PkgZ6R1XzioPSu8g1KNm
	ycRZnR3ljEe7aotHYAf41UgPx6fohK0jIY3zg+iJjsQuz6XsWRc4dFrQFynjZicyqltEi9E2ueu
	xxWhUwv9KLLFZyk0ZTygMou0O32Fz+kjcwZigZKHrmeu7jCQYNaFUIsCiFx2oR1z5vkC2mqFso3
	aXQADECq6G7tt5GWB8SoKgG4dlIJL4qkEKiYSX1Yy0rO/b4iAWpoWOE1RvNFk9NU5LbYZTmPAYT
	zPNxTq9K+/hYqQtoIMPTcfk+i
X-Received: by 2002:a05:6000:29ce:b0:48f:bb92:c5a7 with SMTP id ffacd0b85a97d-49c70ed9029mr3869206f8f.9.1794572337361;
        Fri, 13 Nov 2026 04:18:57 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:56 -0800 (PST)
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
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v7 4/7] net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on the T7
Date: Fri, 13 Nov 2026 12:18:49 +0000
Message-ID: <20261113121852.334604-5-tanure@linux.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index ad30730db57f..d8c23b280b59 100644
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
2.56.1

