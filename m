Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0251C064
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667732; cv=none; b=QCz6tK0jOEidf0uo2+7C/r65PypsUJlRQiPwYoV7BcYGGhi1ZaldoVo4kUc5KRxfyFAGr+n6b2xYJVH1tY6WG3Bu5tZOKxk//YwS1XFfeDZr7zr5QcN9ipXLWx8ZvWracTmPKFh1RGbORBEhOkqGU/MJlud+SsT5ZPJWzUA/Nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667732; c=relaxed/simple;
	bh=TBZYNnslEgmqiIFbP9mDmQG8f/Ol4S/uoq75IjbY8ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uspV076+2VcA8BSUwhVZppUVoD/iLMZ95pU6IzAGNXpk7YOlTGZzc/6Ock35aegD/WkUn2i++JvOSq7711LluKm6E2XE96nWTS5pW9LvD9FFcV1YIpkHh7WpUnfixS7vYQ95w1kHfQFMlItL/kj6pUz3G84AKrpdOUjaUoSeuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaiH3OH5; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaiH3OH5"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478bso544329fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667729; x=1790272529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phbcC86CmmKUH9rw46P9WlcsDl/Y5d267n36zdxy5Pw=;
        b=PaiH3OH5g+Fxso0AFA+/7EH/t7izeATzIx0H7igSGkDAOEu0C0T0w8AWm7Y2fSwIxa
         SAg/vIlCdtBZ6fTJdiGfvwJ+4I5vqDqTBh16u0AcogAm8GqPhxGLJ2vN3ghpOUXkL1dj
         V9jt97xyXbBiqp9ucqvBnEbT7BJn27dzUyQEAIiZfBihpbRpS2aReMGoTQvUF2qTHMk2
         GItta9BVyK1ISCiMfNHiEO6TaBlfWXr4n7NKb0WtcE0/UTSNvtaQhaXX86Sb4IFd4UM0
         L4/4lLAtdL9r5BJS48VTLCXEjN2umyrwPvSxrOReiYYAnqIskkoZkX8Ptu4XCVe6iZ8E
         i32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667729; x=1790272529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phbcC86CmmKUH9rw46P9WlcsDl/Y5d267n36zdxy5Pw=;
        b=Tiu11BZnHy8fhF1rjPT5hQ640gXwE8cqqJur/uuMpTi97czKbjacFAwjH2zObn4PTx
         mB+uwjrRPpctPrEn1R5Oeljq+ZTYQM9pXkvzwTUggbVS9xJ45GGOvr01LHkBYv4r5fGQ
         osjG9kzqpxrBIbpByXYRSmdTNx5FYdhjhikT6sy0Qc7bQBh8z1b/OWPg2h4bWmYpUbMK
         4/menYKCyJCbvJLh+Xu6C1mTbaDe8k5QfY8YyQBE5UEvoHq3AQT8tHtq463B7Pd/Wgs4
         LMamExIx3oBLQ/XEuKEj+jQsi7AlRBP1FpxXSz78j4JTeRLF1l8l5bGlmyPOJgW4uMvy
         myzA==
X-Forwarded-Encrypted: i=1; AKwUvBwFvNherNiODicOkUIywIppxQSopfoQFTyd2Db/IoxaK+tu/tga7fdutQml34v8NFY+mSrsOOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ7SDI7Tn0Sxxr7X72kgeMSOJ1eU7V7PitB9FPR7ct0ZwaUqt+
	T9KQp2F2QyruNu4vDTu3aS+seHbmSKvRTJmCkeEu6XZ5JM0kiKyiQ0/4
X-Gm-Gg: AYBFou26X3/48OYVTg1LvZxO8v8yo0l3gtiT2QecFCvI9zZeYZK/bNy505kK34hrYY7
	48ayJKkgmA5Y6XmH6y95sBKYU0a5K7sa0fSUZMEdUhlIRA/5ADyWwW8ymAf3CCDYIBH/myWwwMV
	JCCOFMx2RxzuvgXJsJ9m6vXgK8NuHVScxySVW+vmzRA+rVc1HrUxJYjXpNS5TPKgXbJ4HZGtc+h
	m4l7eB7wkzYAR8D/7HGsvndhg8J7KE964RGw7O0UszDbJiQ0q874FeJSEc3zYzNiL+S5oIsTcLN
	adkmU+I9b1PO+kMpD0MeFCRsHnroaY6xJy2GzeWDbhLgeqeKXvTdX/jK8TH4jtfFHPHpq0D45fb
	Arc2OEWI4NaAoiWow37rogpn56zpWc5BDioNC+XHLIC0sYcnma26KcP8GjlcvGvAHnAchJfzZ4B
	1nIu4Y4p4KLdz99oF2BRG4wOygcKkfICpQMFT9FH80IeAjMP6eTZ0XBGVolL5IdXPn5jy2Z9RPx
	fE22+f6yN0yvXLAFnZzjFPX2D9UWDln1mGuPQ0q5JMaRiqIm4Cz+Y2nZ14Fwj6Rk+TiyEd1FJHC
	8oDzsZmZ7yFpy5VK2PV/J9uRBm0tegn4gT3FOLnGtrQzhH/yw2JcZR3HmtfABWAPO7g7BdQUegV
	CXtV3LNmHfzfqP9/sHZwq
X-Received: by 2002:a05:6870:1696:b0:46a:c0ff:feab with SMTP id 586e51a60fabf-484752f7f6fmr6824911fac.6.1789667724804;
        Thu, 17 Sep 2026 10:55:24 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-486ab6c1f31sm578446fac.10.2026.09.17.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:55:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 17 Sep 2026 11:55:14 -0600
Subject: [PATCH net-next v3 3/3] net: stmmac: sun8i: add support for
 Allwinner H616 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-submit-h616-emac1-v1-v3-3-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 4523a14f5e0c..1020168f1c3a 100644
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
@@ -1276,6 +1290,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
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

