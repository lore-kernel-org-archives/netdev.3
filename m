Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723842;
	b=d7cajR/n1hr6OO5tF3TfHup3vmSKSziKh0oVnZxDRZomC8ivypGofNRQsa3zrsiHY9zZ
	 azPuVN8BMy66TtxK0oEp2C3m+tDbi4+Av84nng61+s7RtyAhZcEbTaMdhP06dOydGZvz/
	 EMxe3cNPzxbCS9uHijMvK7Ot8R8q4IhRsFAHI2wAvEj7BTTr89CiBmLT3/QDyh9vI/Zgh
	 8aMXV4Y0qujvzImC/v+dkwovVeDdRl+SBcCF+ysmmiSUtYCLI4MWk0Lbe3TeWgFbftpa0
	 eq47RyVfgEo24uTGWhd+WPL3Dsnbn03lmuMRT6BXGC01ZrpTRXwBQBCdhdA5XSz2U8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723842;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=puIm5drKvsAtTzpQuwSkW9RuuhHt2CPtr5r817ZaEWU=;
	b=V4nuyPxCkRn+X4ya2NXogp5gcHxSV/WqEwE4g8UnWiQZ66BOxn/NkBiOP5m+YkNfiiaE
	 PZEqwjQSEmHkRzIGwsvvfgJ7I/URe32eN0bMJOwqkEc4Xy8CdivccgdEJ6mOsCO0hPhxE
	 tkKIKA6vlP5Ynk8RRwJ9kJmfr/5PM3aDIfhUQ2mv343omk59zlyL+l85Uj8D1IO3xBXkI
	 nwHPvPv85KChq15yLsmKvH9+LFHqZ+7qipVDCpvPh9cPIfWwT90Va7P86qH13XiyCYYoh
	 GD6c2aK046M5/SkfLTylN0EWrbM4xuGwNjWPMyLQAXMQRJ/hcFXSC2ZGjpY7w2s1TAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D8606D83D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220D8606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so4092699f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723840; x=1794328640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puIm5drKvsAtTzpQuwSkW9RuuhHt2CPtr5r817ZaEWU=;
        b=LeO/GO61YfBeU/HC6uEjFKgjT9rGrQzpanGD47Ceqer28ZtRbjlrXN666Oe/nhmAcc
         ErMm0LvvpeyvLrQPlyQ+V1/Gkwxh4DZG+wEOaauFHUGsp35Fxsk3nrt8we/H3ROyQeqB
         VIpsXMZUKHQqx1wduh9/EmSQqMHBnWL+Z+PR8Kkg2aq7c7xcMYoWcKHJ02DQOYhdARWB
         rom6xtglNLyQVcfUuhG4XZJ24/Pg3btHppZQp4eLBOl/cP8O0YDZ5evziamKI2cWUIjT
         WjQlfnPKb6bvNj5TUR/M8HohUlwmyhUHhA/J3D3NGVyXgOuBr3lH6dFlwyDeoPc3zeAU
         nWoQ==
X-Gm-Message-State: APuU4Z+6Y4HA3hoaWEimipd8xt/Hkm4dsoJ7UqyVBFNiyCGLQb8GsnkR
	SelpyzM+8y4vkthKvdhSsWqet2fCuM+FLnDLqzkYdlOoKCPHcImIt1wW
X-Gm-Gg: AYBFou2bh8CfO0YkT1UlFiBzByHBsNGnXn9IhTOxMLyOJdFJC6vbaE156kUpUXhFOrX
	3V1qmfHrQ4VWXSWWhedQUfKal9k2DouUaln1+wyFSMtURjdDILLe9S8GUnnzd+7o6ry+fA77WsF
	m4fKTLTKE+J7yP2HfTWJxIVvw+VtDMSI0nrzfJJQTPIhrEqXqM3BlyCQrkmg5ZSNZIPV/b9EcHS
	PUP7MOR7iYebUBLuRxAimljQXROCDMqSiB5hDn2CRw2vVFUpCWKzdwTUBhLLTW+4iXxf73T7XZH
	9zD8N5rruNXMc7qENCziSFpwtHKVUh0Bfv9XJggo9+vCA9x5c7kXBXwH09T6ukMb1+RB3S4dmeh
	9fsfAfFQL3UF/UHU7vaLqeVBeC4UhbJfueXr9byMdv++SETRjqCrNYRm2FcPOQYGqZXvY2FWb4S
	8yugE1X2kAWH6YypoTlS2YONBQgLaXuehg3WLr7Y299aVu4ddWzjmETsQYI+IiAiLulqMNEMNii
	i3CiGpduD+WgoKXpmBzKHQR8LLUtdjruM3bfEA3Iox3bMSGkLLAKylWpF/GfW6184MAWXU6mF2k
	suoEFnrFUliJaAdWh/cHe2zdX0XO16sjuVP18ndUYcCP95S3o6/Z/NXqAoY+0zxJg2jR/FbBoyl
	nAr7BoDSyKseuyCDiLYi33MZYfw==
X-Received: by 2002:a05:6000:2213:b0:48c:7f18:c85e with SMTP id ffacd0b85a97d-48e6e3042d5mr30563697f8f.45.1793723840170;
        Tue, 03 Nov 2026 08:37:20 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:19 -0800 (PST)
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
Subject: [PATCH v5 3/7] net: stmmac: dwmac-meson8b: add support for the Amlogic T7
Date: Tue,  3 Nov 2026 16:37:11 +0000
Message-ID: <20261103163715.385394-4-tanure@linux.com>
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

The glue registers on the T7 are laid out exactly as the G12A ones, RX
delay field included, so the T7 can reuse the G12A settings.

What it does not share is how the controller reaches memory. That path
runs through a pipeline stage with a gate of its own, and no other
device has any use for that gate. Nothing claims it, so it is switched
off as unused and a transfer that has started can never finish.

Without that gate the controller cannot do DMA at all, so it is
required rather than optional: a clear probe failure beats an
undiagnosable hang later.

Assisted-by: LLM
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index e4d5c41294f4..450f7b4b29a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -81,6 +81,7 @@ struct meson8b_dwmac;
 struct meson8b_dwmac_data {
 	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
 	bool has_prg_eth1_rgmii_rx_delay;
+	bool has_pipeline_clk;
 };
 
 struct meson8b_dwmac {
@@ -384,6 +385,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct meson8b_dwmac *dwmac;
+	struct clk *pipeline_clk;
 	int ret;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -443,6 +445,13 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dwmac->timing_adj_clk))
 		return PTR_ERR(dwmac->timing_adj_clk);
 
+	if (dwmac->data->has_pipeline_clk) {
+		pipeline_clk = devm_clk_get_enabled(dwmac->dev, "pipeline");
+		if (IS_ERR(pipeline_clk))
+			return dev_err_probe(dwmac->dev, PTR_ERR(pipeline_clk),
+					     "missing pipeline clock\n");
+	}
+
 	ret = meson8b_init_rgmii_delays(dwmac);
 	if (ret)
 		return ret;
@@ -479,6 +488,12 @@ static const struct meson8b_dwmac_data meson_g12a_dwmac_data = {
 	.has_prg_eth1_rgmii_rx_delay = true,
 };
 
+static const struct meson8b_dwmac_data meson_t7_dwmac_data = {
+	.set_phy_mode = meson_axg_set_phy_mode,
+	.has_prg_eth1_rgmii_rx_delay = true,
+	.has_pipeline_clk = true,
+};
+
 static const struct of_device_id meson8b_dwmac_match[] = {
 	{
 		.compatible = "amlogic,meson8b-dwmac",
@@ -500,6 +515,10 @@ static const struct of_device_id meson8b_dwmac_match[] = {
 		.compatible = "amlogic,meson-g12a-dwmac",
 		.data = &meson_g12a_dwmac_data,
 	},
+	{
+		.compatible = "amlogic,t7-dwmac",
+		.data = &meson_t7_dwmac_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
-- 
2.56.0

