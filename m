Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873012;
	b=OBx4kWd9m+KYxRegpcBqpmNjlQshj5H+F7xeoRoUiunw0sAJVD0x3/oyWhzP0sv7yQRz
	 zLBzrP45jsmiQh7Ca/G9MZTte+9yyAclV8LdfkphNJQTpq0bpXwlQNeoAUrEG2PPEMHJK
	 Ch34kJDrAlKkiuZ5X60kh/T+jTVLMmPKHBmLhpB0ICKlNTZyt7zCJ7UCmXMRsDwOQVP6X
	 TbmZpzjCqM2JE5NGHyb5Qz73Z8ITtFOB7KL6QDs6fN1+QgZ4RNFsrHlQZjpJ98pKKKobn
	 wqhYPL7csh346J2M+dMjUSjciinrR6l+jF/G422enNBO1YnNrYYiuVMbxQKSAeUT3AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873012;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b7yfUIavlqkZvjW0hdKuc7GNLhU6uDD+OhW8RPwrMQg=;
	b=cBn7pz1oT5eyactOG6WMd26FzZcQXgDlqBXyU2T+84gJriKIVViVGypFpds8r8qnIuin
	 SeJ4yyH/GdMc1KQaEt7Am5ga966dX7O0m67wNhMVMoVxj8cnvzR6/YQ0G+UePmDXzVEcX
	 3D/uvWr5/aIk6cYROXfkuwA9J760zNgUtchWZFGIflKIH05PoO2DVjIcV7wpKqWgcv1Zw
	 o61V4JMYRRl/O+IhY1p3P5RumcY2mozMDnERhKps9bfLsmHQLEwsVACMc8qWFv9dNw4V/
	 4Ex9L1BEGQ8UVe+L0WuTTMBnBAU2vyeCy3EQVa6fkzzkGGRD+A8gzEFKJatuc6W2YbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B589606D828
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B589606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a210470b49so12133005e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873010; x=1794477810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7yfUIavlqkZvjW0hdKuc7GNLhU6uDD+OhW8RPwrMQg=;
        b=GW7MXD9QPqMQ1hvohlBirUOe3QcHzzVvdDM9MvG1ntyFlmN+Q2lPa9Crq0tVTlCMMe
         o+eCNssHonvs7NORsKtLpL9tGXQSSNtHAxgwmvx7TE+IyOeFyEWmn3qfFuWnv82PXTJD
         DBCqTYmoZ1FMPC7KW6pHGJ/7LMR/3JzqwjGuCbi/GjMh0ZiiJeZnorXDd5w0TcCB/2cG
         JUYdoHFzVsEOjMY/+YJFWohkm3TUN+Sf4VH3Ck64y7iGfuYG6l7Sl/OryBCXGCnbrHeQ
         EpsOqe0D1MOyMZcPnS7DqXBwzvQYNRRBGfeO+ZEJkNey3ZO7Q549MsPqQBD5J7rZtJYp
         H09A==
X-Gm-Message-State: APuU4Z/UdquRzb3/XtfkUUiCAriDY+M5P+GRFRO3sxf2xd/14dk3JckF
	kHR5/ON5Kt7vyf4OtdwwrZ+nv8oB4DTZBcerZKnGiRB8qtEH0NPlLs4j
X-Gm-Gg: AYBFou1xj8vu0twiwLvlbTqszKQEVTVCpKkr7IRc5pAsnzBh91Eo5SoqTEb7IUTaHi6
	IHAUwzLKM+4Kfz5if6UFx+RfJ/z+SwCpIFkmDV/5WQAjodFBwCcgkYDO0OqdQQkVVG3z5pWfW9S
	NOujqxNDFLJN7W73cHWiolNyA3pfh9q1nRRFpW5e0klbCv40oQqFMQII82AmvTqhXFFwZ2cu1wv
	7NwNhR4Y3lrBoiMGfSkpeIrs5vnKdS0/kiRpYhRhQ5Iuz0hjzw4ZP14APfHmAx9ZubdKeCxKxGf
	2ojkRGQx7TOt/51yKbxe74rCpVouCVAQisz2JN+wwVpalsooe/6MCpf4bOI3G+jUI35xkeIoRlT
	EyZ0GLET24J8zt0D3amNB9vI5EnXWwYrK2uuFooUPtfSSE61xOagu2n3v5yBoRj5ibGSvfZFs4/
	ZZPo8IwCAxvKVy3Fjg26gwoJB+fM1VgqE0by7LFOvJjJnyMa1cIRurwP3pM3IxUTwXQNaZruefZ
	wO2dZpjoHEi6wXgR5mQ0Qz+xkBC6rZ+2OUaHvavacNtioyR2rjmAk3Br310zqWFQuen3DPQMAfJ
	jOEH3wk9kuRO/s03UJACX4mP17E5OhEwVxdiU93s0XzzJwXETkxFK2fun4czkMVrQJW/zpnc7RJ
	93REs1vkD6UDhUsN/4br5pI0wdw==
X-Received: by 2002:a05:600c:871a:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4ac18d68babmr382886655e9.29.1793873010557;
        Thu, 05 Nov 2026 02:03:30 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:30 -0800 (PST)
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
Subject: [PATCH v6 4/7] net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on the T7
Date: Thu,  5 Nov 2026 10:03:19 +0000
Message-ID: <20261105100322.37816-5-tanure@linux.com>
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

