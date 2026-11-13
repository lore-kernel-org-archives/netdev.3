Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572339;
	b=wLPPOK2492ZajEzh+1Xk8yulc7DqbamsIZGmYIpv1xGk2c4VkaystJik4Muh4JhNdZg8
	 BRD0pF2JvZdh3X0P6BqUAcC7d2bnvHomBkgxutP9mACKdhPX+O41PWKq/t4P2AQ1zpUVp
	 J66eatvqwa53S4qiNle4vYDJBHSLxcEBOfsod7N4FT70KRbwPVA47mK2IOFvrB4Tu3IPs
	 5FWQIsEUzAn1Al+LWKV8HDykxri6AWh/vKaVsseKaeJrBTJY/oY4bp2VeH6MTepdk/ZdS
	 XJLCnKEHQK+stEVpx+cM40uCBVS7I+5AiT1yALgvfBj+tsP0DyPKrkocAh/U2oWjKJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572339;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tb6BE0R49kXMcQ/rHy6An/pZJMM7XZOtIB+MBfpG+84=;
	b=TKaIW5dtyNv0rFVajN3GAkMEZkk7CeAm1g5wo1AkxKuuvZ4CdG6U+LPhBN1NKQ5E7FBS
	 nejjNmNs23Ffthim8LRWEUw1DrXfc1Trz1FXMYvyTwPcNTep0XxCQHliX0ZmTwzwLUREQ
	 g4Gx4aDm0t6wNkDE3h7UQsRi3SQbHQgexyNJ5dRXlxLVjCT8FoINO41j68ijG6vY8vcDj
	 tJUoCOyNCacw3FN+hrLsjz52wIqaZPBn89RHXrqJD+A3Ua+n87jlUK1M+dCt/GKYaeMnz
	 PeIXFgZ9JghT9qZftETU2QNw6fCh7VlelIIGczb06vs9utNBmGTAtwKGWaDwt7nYZoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9266606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9266606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so11263125e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572336; x=1795177136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tb6BE0R49kXMcQ/rHy6An/pZJMM7XZOtIB+MBfpG+84=;
        b=iq3wgdIYogzEXZM21VYJu49AxJUCF88fTACeQuPwLo6WHjXfXCeSlTkUV30erZk4Tn
         grrtfg5bxzCmtpe6DvyOn46SsK1UEQibZABDXdqe0rauZ+vVNCCwW485qic6WxEH8asD
         luL2muw6sLPh/g86Hc+UnOW8kwPQ9Ig5gkJGGHQ2FqGxRQiYYzDmPyjdHRbu42LF9shS
         nXxe9qrcoegw3XThVebeZZU83XI9wH5CtOD3N5YUNmjcwFoPaUtkn48+OLLZmZeAyQcs
         QUNeg24g9bHW4bzPQh5vzjxbFOAeaDSSsfiuKnq+ulf80Oo4nvhnQBafMZsIoUFAC6Ct
         vuiQ==
X-Gm-Message-State: APuU4Z+HeUly+CSXkwRBkvIB8FerKPqeVzL1Bl+LmLlNfwk0Qglr2tfe
	JY0SPCTESba8sKRsU8U5E2xoLu1IZ4LVn70xIjvNljNUFXFBgoPeSuoK
X-Gm-Gg: AYBFou0rJb7ZgMC+ALO+V3Hjnsjy8HSvuCTeTdAR1GD7PzchzAf85Ybs5CwdLxJay5x
	mw7JlFa55jYfV6HW+LAVNDRYf8xIAQF/z43ui2qUUQJHPntlFD+QP36AtxZyW0VK4AI3j1d4Kpo
	XM3NEgLDXUGJuNorMpPX5RSdFoRLVg4Ry3BavxLZHqLIqFWKpI1MAeeeg+0wwVnu1sHJJLPe+2b
	uoBWX3c8H33uwNWR+eaRMWv2Gv9xfZZIcnO+b8MSNvrkH6sx0riluxmkZuxyp9Q2h7w7prkQZ+B
	HxWGnXkXAQUWm31i9BjvYMHgvVN1Ei/oB6hO6zNVTPiidX6aXHCATt2lY7XIu62VdNa5Zpyyk+e
	wkslytKq2I4QcYhAgcu+kU6NP1QYwmoiBGQyrBnDey9w0MasSKgIKk9VRcScmRk0YbpEqCvDNvP
	ZIBEL8Nm/q4qO71SdI6h8LB3xeCX3/ehUTWDGqcXqMJkjqCx+Gk4qr0luO/wehvQcuOwM+epCg/
	2Z8PpzZ0VRQxJKQr+aIjJtnIK+KQkHg63oNSFLC3R1mkB/8eL1m5y7hvzqov10J0jDN7xLyWpjJ
	8+Ipu65K7X1qRO4btynUM568n8fXao50BNBIQRlIc6yGh+d4X5/zv0346nDYeLWG9IAW9BGISCW
	qxwaJvT3cVn17ftLSLYLPwh/U
X-Received: by 2002:a7b:cc16:0:b0:4a1:d766:758 with SMTP id 5b1f17b1804b1-4bb4e2fc5eamr105768935e9.16.1794572336252;
        Fri, 13 Nov 2026 04:18:56 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:55 -0800 (PST)
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
Subject: [PATCH v7 3/7] net: stmmac: dwmac-meson8b: add support for the Amlogic T7
Date: Fri, 13 Nov 2026 12:18:48 +0000
Message-ID: <20261113121852.334604-4-tanure@linux.com>
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

The glue registers on the T7 are laid out exactly as the G12A ones, RX
delay field included, so the T7 can reuse the G12A settings.

What it does not share is how the controller reaches memory. That path
runs through a pipeline stage with a gate of its own, and no other
device has any use for that gate. Nothing claims it, so it is switched
off as unused and a transfer that has started can never finish.

Without that gate the controller cannot do DMA at all, so it is
required rather than optional: a clear probe failure beats an
undiagnosable hang later.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 2ad70f0dc4a3..ad30730db57f 100644
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
2.56.1

