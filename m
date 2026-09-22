Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2214BC00B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107468; cv=none; b=W28fzEZSvhAdVaGVdMYkhXI3AFNVsoWht0kRvZbu7UXxCR9xmnzZG/JeDeQfymhgiSK24NT+Ua8i/3w5evS0vrS0/+OqHv8Qz5zRgedKbUbwRUIkG7GJtDILbqmL/ZORyKfGAOd3HffptiYQi5H1wLAGr48Fdimg5jUaYC+QPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107468; c=relaxed/simple;
	bh=kq0vt9SckJqy94uGlHWiGVuBk0MckU/fwsg6pcjJXHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0Y7u8J/1naVDZ8b3dy6HlFkQBoNSZVQcVmbIBO9QqDwHZImbD4ypEEKLjV8cAcgf1RApOZ49lQ4zHrXaA6A8XSN8UZkI5KIKnb6CHQLdQ1i5v4+kXTc7bo/Uk65PnkaKbEGO0t4fe1qrRKWrdfgO6nawL5dZQ+Ac8sh9ciNj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2njGY/v; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2njGY/v"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so454285ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107451; x=1790712251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Rz7MTGiT2Oa/TzTvQEqnIct/KOrKk64RBkMgo9sxQM=;
        b=Y2njGY/vJqA0B9SwWL7b9Q8d39A97yp0YX7pW7xGyqXQeffoFWBxKbhZdq1rFpz7DF
         dUG2q9AWrSDKt8axz/8qClE0aKSqOu7EVytCM3mBVNG7LndYG6P/ctfKa7M4P6ohSis3
         JmZUAk6bAN5z1ySx9YnaU6UyUo9QDsy5Fo4PGNIPTPjwNGa/B5gSqrh6s43n+Jj+wBD6
         91sK+vgFNIxN2MVTGZpfEvrflYciCQ9eTwUZrFJIb0Psl5IvDRPIr5jOHknmP+uLbWVw
         SrnHgtaKFrahmqCydHZcPKmNKGKVkS7kPJOME5qQi79crSe8FeyjBHmYpqTbvQmgkXZ8
         2bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107451; x=1790712251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Rz7MTGiT2Oa/TzTvQEqnIct/KOrKk64RBkMgo9sxQM=;
        b=Gq9kpVsUYplpQsgv5AxaAwi923O5iLaqLFlNtAh4GzU/e6uYmQ5zrP7c7wQyHTWpxJ
         fHKphcI/LdR/pe0sbKMHgur8MqAuPxdQYzvgbweauooA6UpN50YKl2wQrCaG0VH0+y7H
         f2xFlNfuQTmuQz4apzPShS8rSu0qPPPCaWpLhZYUmOjHPjWrdHhwmxB6eRaLg3Bb3XzB
         jU2+T82n+zcHJq1JyoPT4f8sHpXPfPseuzkiMsgbpgCiybM1UveD3jy3BUHWTxl7MJNO
         kqnhcaN4RJ5jS+azWG9EXYFf070iLrDDmLvI5Iew521k/PfeY6FIy5zIpAPWKOK3bF3+
         xq1A==
X-Forwarded-Encrypted: i=1; AKwUvBwEb/3inVNvfqhZP1DmMEaEOIF6QFC9V3Kg4HjSNIczSLFNA0UfbQTlf3vWV0Jp6AZVb13/PDA=@vger.kernel.org
X-Gm-Message-State: AFuF++n/3E6bLvvhKmtwqMoOupd65tC/JZZfM5M6dlreFrnqQ77iF3EQ
	2zi+n6gBThx2wf4ckALq6Kut+yXEaWBaGYzy5RdQoMHP9kckgvflcn/n
X-Gm-Gg: AYBFou19p8wXZP2/0uoq0CP/PVSGNAzppSL5JedVTPogcNsHhcr4nmZAFVy5ejpFjqD
	+Zwh93bOnrUxu+Cu5CZ+IdCRjySqPgVR9QY8MkFGF+zkrZuigVQ6RW3djybE2xvof6JYfrxZsvk
	cZwYlrsyq66skQ1deKzxadZ0o6vLVx/oD4iRuaNgohOKUYB40ofoBH5uBxQzqVeowBXlmSa7+O4
	Fs6u7qyWABA+wjYaRlWUcaZI6af5ujGX4z9ZpYa3mDxZxHRiAfuP0C4+aX2gc82+Hcpf7XqACDO
	G7Yl/WY1Ko84+QOO5ZtxDZ2qOEFPUwc4AVUVOVnanxoZsjo4zyr600ouE2M9bgqTZQih8yUTUz0
	Bb9PVY7EWILoqVHJ3K1pLDHXhyBM4gcnN9+rsyAYDhloX9WBOpnKyxKy8TnAPrS12heMU9WS2Ep
	CZ6XUQ4fhpde5OJiWJwTZT91K6cWjj9utvIFNmH/ZVcTBg2bpUMVVqAWL3IWyPMjRJgI+y
X-Received: by 2002:a17:903:2302:b0:2df:6969:7d5d with SMTP id d9443c01a7336-2df69ddf0c0mr4048995ad.40.1790107450787;
        Tue, 22 Sep 2026 13:04:10 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:04:10 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Wed, 23 Sep 2026 04:03:27 +0800
Message-ID: <20260922200336.2201212-4-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On RK3568, the SGMII interface can be routed to either GMAC0 or
GMAC1 via the GRF register pipe_sgmii_mac_sel.

Add support for this selection by introducing
the "rockchip,sgmii-mac-sel" DT property.

From the RK3568 TRM (Part1, Page 229), the PIPE_GRF_XPCS_CON0
bit 1 (pipe_sgmii_mac_sel) is defined as:

    0: SGMII routed to GMAC0
    1: SGMII routed to GMAC1

The hardware reset value is 1 (GMAC1). If the property is set to 0,
the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
remains at GMAC1.

This is necessary for boards such as the Ariaboard Photonicat, which
uses the SGMII interface connected to GMAC0.

Out-of-range values are rejected by dtschema, so the driver does not
duplicate the range check.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 7843356a4dd47..7b867e7520064 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -186,6 +186,7 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_xpcs_phy_ready;
 	struct combphy_reg pipe_pcie1l0_sel;
 	struct combphy_reg pipe_pcie1l1_sel;
+	struct combphy_reg pipe_sgmii_mac_sel;
 	struct combphy_reg u3otg0_port_en;
 	struct combphy_reg u3otg1_port_en;
 };
@@ -212,6 +213,7 @@ struct rockchip_combphy_priv {
 	bool enable_ssc;
 	bool ext_refclk;
 	struct clk *refclk;
+	u32 sgmii_mac_sel;
 };
 
 static void rockchip_combphy_updatel(struct rockchip_combphy_priv *priv,
@@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
 
 	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
 
+	priv->sgmii_mac_sel = 1;
+	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
+
 	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
 	/* fallback to old behaviour */
 	if (PTR_ERR(priv->phy_rst) == -ENOENT)
@@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 
 	case PHY_TYPE_SGMII:
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
+					     priv->sgmii_mac_sel > 0);
 		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
@@ -984,6 +991,7 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
+	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
 	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
 	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
 	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
-- 
2.47.3

