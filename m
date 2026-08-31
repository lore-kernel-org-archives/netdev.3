Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC733C65F4
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161894; cv=none; b=qAkakV6DXCIMe7iYuX7ZNCopi0YEAaiD/F/J5/9i4XWkQbDboBHYY7+A+8sLoFv9/9zs72nHm8iSjpwIKR0KTRbEwvzT2/atWHuUD9SD2OW7NlpY8Z35BMFo7aqeuf0vDtrxzBLOQppG4a08s2ICHkkDh/XblJl0VDsdaaaJhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161894; c=relaxed/simple;
	bh=jobS+fW1cfi+/TFTjOaS4ZSVZLZh9/OtLBcsjr0QNy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMCxjK4I7Am0hGi5mWra+6ee07CLL9sKOlbTmVDowdC5vJl4A3T+9E5u/Zw49LIVU6YpSRdA4azioHfuC25H38HVp0F4pTL1v801PZzUksp4arb3rCy37Ekio9oRWTtLJnO+77uDUAOtTmZmsMYqBjATfxqQ2V7fJxelwZ+gc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mnb+riN9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mnb+riN9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C14181A18ED;
	Mon, 31 Aug 2026 07:38:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EEC7601E1;
	Mon, 31 Aug 2026 07:38:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEB0D11C783B9;
	Mon, 31 Aug 2026 09:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788161885; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=k8/zkJTEH+6Vr7PveY/3bVW0CtCwJqmEOXtgHVQOUrc=;
	b=mnb+riN9q6mcC+1deaaN4ax1ARZE+Yoh3uxjpu1qKVyg0jccyHzJPqUNCa54Yix/VrlHTY
	/wD3ZrcWZIs9ywtLFBu4K/15ZScAld1nliaC01w0aKkTKkdiRBsjBqNUljfRva9aXhqJO4
	bORSIoksiBZPH26IrzD3ScHxPBKBz5LQHYJyT56qgXESq8TKOHElz5Nd42MjVdnE5g78LJ
	5hdXiW4M/LKqJXDtZfvnuza9GKD1LuV7R2x7gLZ2B+xt/+bOZA0WEmTEio9WtWn5NRyxCC
	cqhugPO5OAaOuubKJb2troVmZkxiYeo733w6uLeV0EjTN8rsJUJGbKyOJ+9d4w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Yao Zi <me@ziyao.cc>,
	Frank <Frank.Sae@motor-comm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 3/3] net: phy: motorcomm: Enable analog frontend on YT8531S
Date: Mon, 31 Aug 2026 09:37:45 +0200
Message-ID: <20260831073747.361482-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
References: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The YT6801 PCIe NIC includes the dwmac-motorcomm IP for the MAC part, as
well as a YT8531S PHY, configured in GMII mode.

It seems this PHY requires the Analog Front-end (AFE) DAC clock to be
enabled for link to reliably establish, otherwise the link just doesn't
come up.

Let's enable it at config_init().

This logic has been extracted from the vendor driver provided by
Motorcomm.

It's really unclear if this is specific to the integrated version of
that PHY, and how this potentially interacts with the fiber mode this
PHY supports, so this configuration is only enabled when the interface
is GMII, i.e. the PHY is integrated.

With this, the PHY reliably establishes link and the YT6801 PCIe card
becomes fully functional.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/motorcomm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 36c229460a77..90a4f86f2758 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -144,6 +144,11 @@
 #define YT8521_CLOCK_GATING_REG			0xC
 #define YT8521_CGR_RX_CLK_EN			BIT(12)
 
+/* Analog front-end control register 3 */
+#define YT8531S_EXT_AFE_CTRL3			0x12
+/* Analog front-end DAC clock enable */
+#define YT8531S_AFE_CTRL3_CLKDAC_AON		BIT(13)
+
 #define YT8521_EXTREG_SLEEP_CONTROL1_REG	0x27
 #define YT8521_ESC1R_SLEEP_SW			BIT(15)
 #define YT8521_ESC1R_PLLON_SLP			BIT(14)
@@ -1740,8 +1745,15 @@ static int yt8531s_config_init(struct phy_device *phydev)
 	if (ret)
 		goto err_restore_page;
 
-	if (phy_interface_is_rgmii(phydev))
+	if (phy_interface_is_rgmii(phydev)) {
 		ret = yt8531_set_ds(phydev);
+		if (ret)
+			goto err_restore_page;
+	}
+
+	if (phydev->interface == PHY_INTERFACE_MODE_GMII)
+		ret = ytphy_modify_ext(phydev, YT8531S_EXT_AFE_CTRL3,
+				       0, YT8531S_AFE_CTRL3_CLKDAC_AON);
 
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
-- 
2.55.0

