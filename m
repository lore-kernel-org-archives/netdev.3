Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813348E0F2
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933552; cv=none; b=pzCaQcyenKGAT0kdTkk++GY7j/7iUwdPHPwFHwMWh75kWg1rOXPlmcV4Q4kcalzbIRSxTsX6kw9s6/UGEnlQyBwyPUOyx8f91d2SopwW2qfO0D2qE33ld/IwE3DjyAUiP8U3QBV6BsQyb3HkZzBPfeH3PPkEiVtEgc635dLfpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933552; c=relaxed/simple;
	bh=e9hk5Tsdquyr+5avHPEA7bcfLf2nOdnHsiLzbvu4On4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1AxpbyfLvLR6ZgetGOHZ8ptubasoZedaN2HhXWrqXHSWlu5JwxjRO8+u/+Nn8nkhdbuLSv+53TneMRfYC5Q+akvci1c1yZY12ge4OQf9mr4E2JrgqwCZX3/gZKV5ackw/JzWxg5i+yy7R6lrEpAaGMEh7N2GEns+4vY7f4DitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcKnG7Xp; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcKnG7Xp"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-470417e5b52so1709355fac.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933550; x=1790538350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFndLx5Yqc+lsDlrSDVoBXxkYOfQ85XX/QivbJQF5Mw=;
        b=bcKnG7Xp8QQRLPhF9GYfR1QMAIxkw3ofYeozH9zujO9ULcoQ24yZKfn2HuFF5YTSd9
         kP2MzqGquxqZCDR38JDRjeBDJLnTthWjjaEW1pYJieNjG66q7T9QiFU1iaT7/eA3jwH4
         ddS7M972oJ4enoIQlJUoHxFMWjJWy0ycpdApYqiBWG9KE2PBoYtmZJcsQc5gOZ7U6LAG
         Go0+Pm6nYecfOQeyiDb6wH5efFeTuis/h4M9B30EGCiOYAgimXHNyS5PAdZT0m7C1EhI
         MJoR4wtUmeYl/vddJEd/eE/9ysm2oo80pj+Ire3OCGYsBhOhgvKw269Y2X0ACPWIQYff
         yagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933550; x=1790538350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFndLx5Yqc+lsDlrSDVoBXxkYOfQ85XX/QivbJQF5Mw=;
        b=hz5cIYHreSsOnwAdXECsk2VYlnUMnHH2YOR3ybApuFFVibPn4/+7AS27eYU+HqsGRC
         zyh7bFQ6qwvfNKswh7OvHeIsBMNVWRYrPCCGUrGbF0B0c6Sas3hXs7bl3DWAmDdOZd8z
         YtSBwAuq6bL4ee1+dwfhmUYNQnvdaX0mC+uIFoVf7yOkh441xBmQyUyT+P/kzKSV5Qjz
         Z47MY8j3jzSGNnb5K6+uKd4UMIe9E1ASDgaS6cqI7Jwbh7i3sghrBlTHYhEBMTdhLqKD
         1dHlHs7pTYGoRqV8m6FHTpyotkxVvd5G4ZtbmL7vZUsMdFefx41d6ui4UoWhVgqOcGKr
         jUrg==
X-Forwarded-Encrypted: i=1; AKwUvBxtZoWM83rzXANuVxQBPbSlTGdpxJGtsYZFJgmdcHi56Y/mHmZnbMveo5Hg3z9Lyqnsz5+DkjI=@vger.kernel.org
X-Gm-Message-State: AFuF++mg9/TuHzYL/rbQQjOcqwdIx/Z4wbVacnV8a2PPWsEizvBGlGxY
	QrVHJY5Jwv7JZ2H1EglihN3njZmHi1XlA+gl7CMSO82TmTdJ22OQq70v
X-Gm-Gg: AYBFou0VC8If+vYpRm/CLc8fDzYgXOhxshAYL+O/+EDoldPsGhryll+5ScyWjeYbP6V
	1oxvUFMtjQLIs/ND0EW4+JQeu5zc/63xBwG68Sbi8tdJy3WZ0/aZ3WhkyLnGqMZLwUM9iuvihdE
	+4/usWzkw5ZqO64Uh5irTZp0kapUmdUrIVlC7gUh08Yn+jp9b7zgzv5PGeLTrRPE3s5/dSjeM34
	HpRavsP3Quc3QS/4yoqVdhAYTb638pdwqJiSJGsliXA97cSeByHmflN/5sQjp5D6Dn1pd18RSNY
	05SanJ1M9P9Akp+4tXXEXgdH6XYLjvShrd31gcw1uxspouTGTyZEnFFTVDVZ7ojONyug6S4g4Mk
	csJuFMpj8yX1PvGwuCgRC8BfeiigDcmROaRpdh488eCB3k++rjsZ+EJBKnEmggnnRYRyv+F1Uhc
	+2LzzsA2n58WG9mMlHLBWk1oWz7UurHEKJ0FlMwPDitKDgDruUMl5M71Qbd93sDEM3z9aqMGz1/
	dQ2l48MuJybqqayj2k4tfq+ker9H2J1mguyKeCjAIe8s5M8BOZsHGvfTYwlEsIsQN/JkkrcmsI+
	A61OU8uuzy0UVYPwCnv3awt1vrgxRntizKvUGmc0292NsRBt9wBI8uV7dn4LT1u5OF9tgRpWBYg
	mZrJ2SESgwpLbXuMc9SSU
X-Received: by 2002:a05:6820:16a6:b0:6bd:af9e:a7f8 with SMTP id 006d021491bc7-6ca9a130336mr7595370eaf.10.1789933550220;
        Sun, 20 Sep 2026 12:45:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 20 Sep 2026 13:45:32 -0600
Subject: [PATCH net-next v4 6/6] net: stmmac: sun8i: add support for
 Allwinner H616 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-submit-h616-emac1-v1-v4-6-8347dfe2eb7d@gmail.com>
References: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
In-Reply-To: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. It connects internally to the
co-packaged AC200 or AC300 EPHY and has no external PHY pins.

Add an EMAC1 variant using the dedicated register and enable only RMII.
Leave PHY initialization to the PHY driver instead of using the H3
internal-PHY controls. No RX or TX clock delays are configured for this
RMII-only variant.

Co-developed-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
Tested-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 9598c386bb21..0ea1860cf203 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -81,6 +81,13 @@ static const struct reg_field sun8i_syscon_reg_field = {
 	.msb = 31,
 };
 
+/* EMAC1 clock register @ 0x34 in the "system control" address range */
+static const struct reg_field sun8i_syscon_reg_field_emac1 = {
+	.reg = 0x34,
+	.lsb = 0,
+	.msb = 31,
+};
+
 /* EMAC clock register @ 0x164 in the CCU address range */
 static const struct reg_field sun8i_ccu_reg_field = {
 	.reg = 0x164,
@@ -143,6 +150,13 @@ static const struct emac_variant emac_variant_h6 = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_h616_emac1 = {
+	.syscon_field = &sun8i_syscon_reg_field_emac1,
+	/* The co-packaged AC200/AC300 PHY does not use the H3 PHY controls. */
+	.soc_has_internal_phy = false,
+	.support_rmii = true,
+};
+
 #define EMAC_BASIC_CTL0 0x00
 #define EMAC_BASIC_CTL1 0x04
 #define EMAC_INT_STA    0x08
@@ -1277,6 +1291,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
 		.data = &emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
 		.data = &emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-emac1",
+		.data = &emac_variant_h616_emac1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);

-- 
2.53.0

