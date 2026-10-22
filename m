Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699611;
	b=mZzcRrAng3QVFDJUKe7YYOxPmvHshOVtRGd+yVzQx9puyz+zA5Ibf1rFCsUQCgqByXSJ
	 t7PFdoq+XV6ik3chNPb96QFEvLl4dmxPMJ9nCnf7Uce4TMDScpvu6oPxO25Bphi3609bo
	 nqKS3Q9WUQJ74DTzFoW6/+x05/tJMk4n4U8lUnOsbMaev2vQlqS+lhSRo51zWM0qPpuZV
	 A1aa4ghUMb2dZHcgp3kypR6sKDGC0sZk3AXbNkIkjl5vNT0AcpfSwdEGQbbOcmPC4/s27
	 z4BFotZ5HcJfgx6LarOvp+hK84Wan9DjuGY8Dxp5pSg98mgqaOOOjd36lwJ5larjRgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699611;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=puIm5drKvsAtTzpQuwSkW9RuuhHt2CPtr5r817ZaEWU=;
	b=TbL4kRb3Ni3BuWDoTaP2NBHcKt5vuUJizp5kNGq+4avW9QvOaeyFQq0aebwZXO39vW+j
	 Ln+uvQopyhgi9wAVBRIIO8DssZZxWcndyOINTvenTe1JRGy4tT4KV4ObZd+YVP29REGaN
	 TE6bcEcVCr7ttUyybnH2r7KBSaceRWwd/gtV/z50WWXZXMGL22EByGXUOsrHYXjU4hc+Y
	 vXCqkb4TeBs1r2/DYok683FJMh7MKfcHwd8zQAEtPAD5OvcYWGYUDzzRW9FjOlS/laQ4m
	 1d0YVNq3qMhi+XiuMJQRJQFlgxrhhHLW4Upb2AawRzTdhvDqjHMoL8FllPjGD/bE7Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5460A261D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA5460A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so648675e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699609; x=1793304409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puIm5drKvsAtTzpQuwSkW9RuuhHt2CPtr5r817ZaEWU=;
        b=NqWtIlj7ZDvb3g5ViRpTRiMQZrKyckAkHstKjZN+bc6ENmh7dIw9+h/5zuMHwQUVR0
         XP9wFzoh8MhTeyqITh7/QRs0TSevL6Ahbn/Svsho6r1LqKSR6j7UrJdklv0NNfwVg2+Q
         0HI7Dh+SkvPt+JehZeRTJyGrBYhMdriekfBTya8s1dShfaS1DoNL8vhkTf1L2ywXREGt
         PC1xHMFVKEjhcLejHrtkUe76jOoTWcrA0HGzxVagUDS8INz0ReJg7olHsWBqgpJRM4fs
         P9dn0g11Gj2VkBPvGvFWD1736O4QiZvRmh5iKNyNPUOmQrE3VaXseB8CkFelXpkYyQ7x
         oo+w==
X-Gm-Message-State: AFq9FYJNxXkIsBQmf7vnHeIWbw69DTBfJQKRIdvKC2hwmo2eChTzPyxj
	Xx6XrC+3z6J04buzOcIgB7s+lL7QWeQfU+SF/zW3B/Bn7KQUFdYfJDEO
X-Gm-Gg: AYBFou3mvKrXUm/q+71NBmiIT09+/Zsjb2wGpMe3Us3UnVYftstDvPo1mLrrWwoECBi
	kMtZPvampzPoCppXrItD6P3vNW+MlUvECPOyFpJk+W15dmJctnx1yzz/RWDxN1wGZ2dmE1mx7pC
	L7vSdC2XuqUc/4/uSAoIZw82UZSSUxQtvK02rDvMPEktaMzFKiLJQce6JYAS+anhntl0Yzxsa5b
	KlrI1XqBtiu3ZOKDSQoVifyDg3noNksw2coONLeU84VXcM1JcDmyiXfnwIklaoAtXrhC74AJjMW
	/ojDH0eL6BGxDaKczW6qa6umfHE9cVo9i/3yhZEP7HoLuHZQ9XYRy/0/XWEFAMXmjdyt6IFqAAD
	MNTEFXQWq728rQXXveM5DKNOG1DT1rhU4CR3rzGTjoyznU3QRWa8690cub/gv8GQiVW+LX/BvJC
	aKgrII1H2VfZx6aG3sWkFVJb827A+ThonTcsW0n5RNZ15Q64iRalkQQ6mgYbp/JxGAqow2bCNYd
	Aaap0MhPHv9pZZlmDXlPLBI2ytBlfr96OlZFXHUKu2HNvqTvq8RPwYJMlN8DqI5fgFpw2puRprh
	C+qcbFz1zt7OrEY=
X-Received: by 2002:a05:600c:1389:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4a211cac456mr2469675e9.17.1792699609209;
        Thu, 22 Oct 2026 13:06:49 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:48 -0700 (PDT)
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
Subject: [PATCH v4 3/7] net: stmmac: dwmac-meson8b: add support for the Amlogic T7
Date: Thu, 22 Oct 2026 21:06:36 +0100
Message-ID: <20261022200640.3101932-4-tanure@linux.com>
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

