Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B43440A30
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361602; cv=none; b=jzM5KLStGHqmSdvenmIDcy3IaSF1YK+WenF4jmWXedvBsi2oarWL72TkVhK/2U69TLxbwzvdpkLYAf3kPF4hldoO1Y/ybcHSHaRxWnD15faqW92XD7coRoYCW0Y7hyz38d2eYEhgfnpZblQxRpFgLX8TKX3Z40tFQLwrilfecGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361602; c=relaxed/simple;
	bh=xd2G7R66hpaAeW/MdfLjffNu2Gc+gWu0LmsCFDuAJjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLDOBNrmZETMvkB3jfcN2jNvbpWsuIipeIgTiyJhR7+6RcfvK89KsBw2UotjVqYTH9z4MDAOJhWBfQeKTVLlUAmhqqwbStkQ6kjl6UVhHO8Seu9m00dcKuICYJZDymBI4bpen7yyucff2J3jc1P1vqNQUmj4pftTi2Wp7tC0g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b0946c2c2so1046861f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361592; x=1791966392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMznkgAU7RcKCyo2f/X40iNVhoTQVjtCnARNVdFftYk=;
        b=rRidSoUi0etZC7mLlFBgxpY1GSAUcNw9YpIzUssj+BEccZJFQuzznG5UBZp4EKee/7
         6fDMaBNIIPNQ6EpLC4cJRXKEdWUaq/Wy5625cGoM73bedhA2K8EYL4vSTEI/haw/an8k
         ARNLm5A9xgYYoTLHG09DifrUeZVuZKPeoVeoMp/Bo+HfjDb7rHhcD86KUOWjfWVcpf9C
         4AaObu18t5IQgOCAmSO4ePlELYv4kNKDKzwsOwtBmJWsfb2yekpbE8uzPkiSYiRswWKq
         qS5r+Fhj2o8EPHR3Gy6VOFxJ9kjq2bKatttqEKIIQKM0af8B7fhl5DJgvy/5eG9rwzFZ
         enbw==
X-Gm-Message-State: AFq9FYICxGDSzZ1FGu8wc1SNOhpTaQEGIDU/AXiusK/9optrDR9py7bI
	YW9K6uQ9zqgJoHF2m6pd6z63fKSbQkdIlHNNyYzcKVE5h9UzjzVOCHLI
X-Gm-Gg: AYBFou2AYP2SwbJmHeWXqQDSWEq3LnEAIgGN+iKo3qNe5NMlN34Psrzxpb7ftwa81Mb
	hi6ELEyndXEqyaJucMcSVQvJa/y3OE+GCSk+2m9uigZCse1DIaocbJiUjrNM3UB92UBkmvj61S+
	Bo3DqVNViU0/VT455+asqmM5Z02gwOgxaPbXf/0TgNDOb6xknVhXSkdQVCDcApXn/CvOCAP+Gp9
	pzyoy+mRyJd9+M5GpMpt+U593RyAUZztGSrCqoSC9i/0ckDQRr206bsgNLNREuU/1d1MMJr7rup
	REP38GRDyMFf4UKnnDLk/klXiAJcPShIbCWOJMOeNV3By9pTqKn5sO5dKQZKHkYZkGWFJeB1hNW
	q96IwS65GuEyNUOCATQQUnf5mTU2UuLb8U5PNj0jJyHJXhmPe9SGoDgkTpZMr06to/DOHmP7KeT
	CMyKUtJkTTu5c43gM6c/X4i+n9rFBbFsh5eLU5Kpyzcj7O9eKRugWRGf0N28PDBXKWd0WRf03Ib
	5ZwOK5+2sc4++rpS+cNoQseDF4YaxxYOSc=
X-Received: by 2002:a05:6000:4819:b0:488:80d0:873a with SMTP id ffacd0b85a97d-48c726f19d8mr2561452f8f.5.1791361592372;
        Wed, 07 Oct 2026 01:26:32 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/7] net: stmmac: dwmac-meson8b: add support for the Amlogic T7
Date: Wed,  7 Oct 2026 09:26:24 +0100
Message-ID: <20261007082627.63807-5-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007082627.63807-1-tanure@linux.com>
References: <20261007082627.63807-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index d73dfd0ac167..dd10d719ab84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -81,6 +81,7 @@ struct meson8b_dwmac;
 struct meson8b_dwmac_data {
 	int (*set_phy_mode)(struct meson8b_dwmac *dwmac);
 	bool has_prg_eth1_rgmii_rx_delay;
+	bool has_pipeline_clk;
 };
 
 struct meson8b_dwmac {
@@ -402,6 +403,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct meson8b_dwmac *dwmac;
+	struct clk *pipeline_clk;
 	u32 tx_delay_ps;
 	int ret;
 
@@ -485,6 +487,13 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
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
@@ -521,6 +530,12 @@ static const struct meson8b_dwmac_data meson_g12a_dwmac_data = {
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
@@ -542,6 +557,10 @@ static const struct of_device_id meson8b_dwmac_match[] = {
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

