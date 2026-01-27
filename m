Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A322355816;
	Tue, 27 Jan 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518592; cv=none; b=O5sHjn2QVFrjBgMuThy0w1iArDhRF0GmJq9aOaozKA4sYZ4ulWsIm0ZTEHAqaaiL20BwwO+8T0e1BgGZi8EHvmwZmCfR+sv64Lnpg0Df0FpHbsUbUimDzlpELl3ZgA4Ej0IKLy4Wi8rv0pOW8ipjLoYIlS0fjc0UuKYVAY0ZGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518592; c=relaxed/simple;
	bh=7q6n9P/VsWrFeGAC/iWRxdQO4ZpVwwUDs8T6d8XPmqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUlseLNUIHyYk1dUmJi4ddhtws6gcDbmnS0dSBlrUR5b80VT0aMeQKtv41bnsdyQJY93SWcLXoOV345JsrfjyiT+ZyaDVSHIQS53Ug1VhxhPj6HUrQ+4eNde3On0z7fjpXXS2/LufBD1powSPYde/tRFqU4xjvf1PbIvGj643/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=NHm+9ynW; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="NHm+9ynW"
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=NHm+9ynW;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60RCtr331881658
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 12:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769518553; bh=qT2SzI6DPeUnDnAQdGtCZKDKsWsV2Y1uoIX0LITzEK0=;
	h=From:To:Cc:Subject:Date:Message-ID:References:From;
	b=NHm+9ynWTtcV4lM53sESSs0yXzsJv/h0UyTQFqHuACNYmUBeQ5yKJQuwWHB9ceUN7
	 YHUKtjqbllZSRRmNmjIxJslKLZzACIC2JCOTW8SqHhDFgCehOpKUKUN6Yhr5I/vBVt
	 wGVnwEkg4A8nnqywrdSYzmWS5/BhhIVZHW2teGtU=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60RCtrm2908895
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 13:55:53 +0100
Received: (nullmailer pid 1475191 invoked by uid 1000);
	Tue, 27 Jan 2026 12:55:53 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v4 3/3] net: phy: air_en8811h: Add clk provider for an8811hb
Date: Tue, 27 Jan 2026 13:55:47 +0100
Message-ID: <20260127125547.1475164-4-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127125547.1475164-1-bjorn@mork.no>
References: <20260127125547.1475164-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Implement clk provider driver so we can disable the clock output when it
isn't needed. This helps to reduce EMF noise

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/net/phy/air_en8811h.c | 107 ++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 67a1bf60255f..29ae73e65caa 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -949,6 +949,105 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	return 0;
 };
 
+static unsigned long an8811hb_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & AN8811HB_HWTRAP2_CKO) ? 50000000 : 25000000;
+}
+
+static int an8811hb_clk_enable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				       AN8811HB_CLK_DRV_CKO_MASK,
+				       AN8811HB_CLK_DRV_CKO_MASK);
+}
+
+static void an8811hb_clk_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				AN8811HB_CLK_DRV_CKO_MASK, 0);
+}
+
+static int an8811hb_clk_is_enabled(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_CLK_DRV, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & AN8811HB_CLK_DRV_CKO_MASK);
+}
+
+static int an8811hb_clk_save_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	priv->cko_is_enabled = an8811hb_clk_is_enabled(hw);
+
+	return 0;
+}
+
+static void an8811hb_clk_restore_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	if (!priv->cko_is_enabled)
+		an8811hb_clk_disable(hw);
+}
+
+static const struct clk_ops an8811hb_clk_ops = {
+	.recalc_rate		= an8811hb_clk_recalc_rate,
+	.enable			= an8811hb_clk_enable,
+	.disable		= an8811hb_clk_disable,
+	.is_enabled		= an8811hb_clk_is_enabled,
+	.save_context		= an8811hb_clk_save_context,
+	.restore_context	= an8811hb_clk_restore_context,
+};
+
+static int an8811hb_clk_provider_setup(struct device *dev, struct clk_hw *hw)
+{
+	struct clk_init_data init;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s-cko",
+				   fwnode_get_name(dev_fwnode(dev)));
+	if (!init.name)
+		return -ENOMEM;
+
+	init.ops = &an8811hb_clk_ops;
+	init.flags = 0;
+	init.num_parents = 0;
+	hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent)
 {
@@ -1094,6 +1193,12 @@ static int an8811hb_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	priv->phydev = phydev;
+	/* Co-Clock Output */
+	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
+	if (ret)
+		return ret;
+
 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
 				      AN8811HB_GPIO_OUTPUT_345,
@@ -1487,6 +1592,8 @@ static struct phy_driver en8811h_driver[] = {
 	.get_rate_matching	= en8811h_get_rate_matching,
 	.config_aneg		= en8811h_config_aneg,
 	.read_status		= en8811h_read_status,
+	.resume			= en8811h_resume,
+	.suspend		= en8811h_suspend,
 	.config_intr		= en8811h_clear_intr,
 	.handle_interrupt	= en8811h_handle_interrupt,
 	.led_hw_is_supported	= en8811h_led_hw_is_supported,
-- 
2.47.3

