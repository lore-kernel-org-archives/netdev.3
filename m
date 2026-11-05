Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873011;
	b=Ejr/MaajBHO+74mF364aUtd7Hsq1t8G9sk2olPfR7bH4+7HeV6azxfmdjikIuz2gaUq/
	 sKbTYftbcbToW06g17yDJoPni2iwDSAZ1Bjdup6hal0IZTkq4JXvDVRytlkb72teyb9wF
	 lUKDYyLCLXUVxGES1uEY/8aXfM/VPz21shXhFbHeMgbKdyGshDTLESPpjBSBlPBKYFXCf
	 myggQFE0khvEPMMK05e4/58qRSWzHfrh8zVVICvOcg0JfP6fKPWf8k+yu6OqKbh1whJd6
	 WSEUDLbyZbAhmF2bk2YwI5uUWRwaxgy2m44HbQ2iPYQnEVJePXlbMgE8B3aUrmavZrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873011;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=puIm5drKvsAtTzpQuwSkW9RuuhHt2CPtr5r817ZaEWU=;
	b=D1Ao6FYQ0x4zRrIuah5tuN+3TDAFl2lA5+XsOZNDrHwjI+KVG7PX3VRNXk3kebUHqeI4
	 kzTR5kuwTvcyR+AC7ljYaqmlss8uso46fur9omlcTgcwACUIejNbGgV6gfiqGzgm3KZUg
	 OjIKhWSpge+KsG/3zJwwS4x8YVas87u1IAgqo3vPy1EJj16rZeZJcQROaIXW0Po+cZKVj
	 i0GiAap/D0xnGVX/uP6wAyGC4+sudeLt6uKJXas1o1H1b/3bTNygB0u6yOnjm2pLgQB4W
	 deu3fdtXlEn+WRWoBNPXkbMcKLYfi7mbhYnItluAtyXVyshDLqsB0xAhFvB4XBUIWJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C111606D804
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C111606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so15574545e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873010; x=1794477810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puIm5drKvsAtTzpQuwSkW9RuuhHt2CPtr5r817ZaEWU=;
        b=Jo1SuH9o1qHU2Q9rIFEsY/gU3OlGnvGGXTu0TmDFX0fWylsaJp0Rhke5rWa4Kpp0X2
         bHm+5CZy9gQxeFMwrPkBWbPFfVT/jgJwGwvflMMziGyt9GqigdV61yRuw1KtDj7Kfv/2
         v4uh56OVmVabN68XYrp8aCUdRWvW2WvJL84A64x/TQ4RQQvEyLylddhYaBMs2k0UDHlq
         U4EJUdSb0spNXb9kSzqYiMlU4PHAAClgc3H3lZtq3aaaetjXlX6QUOeYkG/aRU+SuBYZ
         ZIBK7DrJhdf8zBvQVrNqB9+/hRFv/GfnafLgJ1CsphGB3Og8QQflGIzleSynu8IP+t+2
         VkZw==
X-Gm-Message-State: APuU4Z/Buyhsk7zP15caPNglDx1DC8xSfXNGP5ED4Qg/l3rSsLJAeAey
	HRuTycPTbpNB2ak5Tkbq8A2dOZzfNuWREDnMlPw72xlGfB/xM6yfDIZM
X-Gm-Gg: AYBFou0JaZHbwVoLBTtHLD+KjHmmVOTK5h0vdK+aU+IaDJbwRyPHqJShWQEjtztSBge
	e9J/He4qEAxSzSFwEg1zQTG9aiQScOpSjb/IO4mOBaGWFY/BF9a/VQ5YavbyCNV+2NT+puW9LqG
	lsP1wySF9D5pOQ88I61Gpr1GgqIT6iADxzAkKiFdWaaPLfAu7DMn/76/H0pRJoz9UoyrG+XWVL4
	+wEU+63DTzkXOwDfoK8drzVu03kXeE7hnMWmnrG3781nOCSG1umU+4OVI4xG6TQvHhqvx9KgZuD
	l/BXrihvx9myiyJp8jhJu0iNVwCQsn7ihyDh+NoXhXtEhkv7Gdui0Hw9jULN56roatSmnoCkRhh
	vmMl2HNg9s3hjdCUzrjKJ60U5FJD9eIUeuSPW4hpYR15JkQt/LfnppgI23O+hO0FHbhSST4EXlX
	LPs4TdUK8BQtUM/QxLMzlu6HHCAJuOk/FANlgeNAXEdMZpt8OV72MVKReCtu6Ctg6/6Ev0UG2x1
	KR3zD+L3iYMgrLSIGyMoWMQt+rcyGkEP+44+L/V0JLFD/m1qT7Io10SNosBXMdKvTXzUhV5+GnL
	mO6OYRkUDkoLlTW6aFmPc1ouNQavm//J0Gy6XYJKYgDrrNm9XslG750MuTkSfLs02HR69243APO
	rlTIdWnXC1i37BoRoTlub4c3BLw==
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id 5b1f17b1804b1-4ac182dca99mr455243555e9.15.1793873009584;
        Thu, 05 Nov 2026 02:03:29 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:28 -0800 (PST)
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
Subject: [PATCH v6 3/7] net: stmmac: dwmac-meson8b: add support for the Amlogic T7
Date: Thu,  5 Nov 2026 10:03:18 +0000
Message-ID: <20261105100322.37816-4-tanure@linux.com>
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

