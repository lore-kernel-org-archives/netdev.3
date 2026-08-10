Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE53D8901;
	Mon, 10 Aug 2026 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364152; cv=none; b=pWLNj8OC886sOnJtp+JnwM82dn1Dotn3UOj57Ratzq25jQJCcy9e+0jdzrrrohTw8PgKO9UJFv/rE97wehpOS9fEaGvOUvQl1NgTXxXBclap9qoY08NQqVcEoRwuLA+t77xYOGKeauq+KsJleGJFAMx/DaxEsz0M5p1Zi39gQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364152; c=relaxed/simple;
	bh=NQyJJlcPFAO0sM7qXsqPILz7OOJlZWfyA8v7GbUfGq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS+hESI5e5GzGADS4b8GGo1ropFhtS31ps5chYKZOb1jLSN78/FRWEsF1eLlacKwaFXk8TsptXb47Ah8Xq9RV1ii/8a4MGMzPv7BrmGPuggxaSCLLxL/aGTv/ihWzpQYMnj2Fj6zHRuK5W7KXADpT8TYF2lz7avKZ0rw0eBihE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=EupqziQl; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="EupqziQl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BB7BC0517;
	Mon, 10 Aug 2026 15:15:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786364149; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ja3ddn8Iyrr0BPUQgL0q4vghx18v/jp3QyN5ZHrPqoo=;
	b=EupqziQltR4M0MziVrus8tmeNouchv6VjiDPgtVw/CnZ/Xkk5OjmGmZKXQgQxjIxe5sQ3e
	ghMdgnPty6SMJghCBu5sFgnJBpBB3ytSkam3ttej8Ax8rPYzoXvNwQqPqhUj3nVGHxT0j5
	X50lCTYYm3IvMiw+xO/yRsIG56vxB/Xf5KC5jNT7xBxN4asHahNXGu4Njv8e/LATX3II68
	67fwUFva8u3F81TvAh7WFmqcpKI5q3R3a1klP/uG4ji2cz+/WwEFY1AgwW50dwgLVt1s4y
	99rn7TEuKNIKNc97tgyM/URj99DByOIcWvuR++LmxFwPcZfhNxQPQQCUpB19NA==
From: Vladislav Leonov <vlad@zlab.su>
To: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org
Subject: [PATCH 05/25] net: ethernet: stmicro: stmmac: dwmac-rk: Add RV1106 support
Date: Mon, 10 Aug 2026 15:10:56 +0300
Message-ID: <20260810121121.210040-6-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
References: <20260810121121.210040-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Rockchip RV1106 GMAC 10/100 ethernet controller.

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8d7042e68926..a1bf545467cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1034,6 +1034,60 @@ static const struct rk_gmac_ops rk3588_ops = {
 	},
 };
 
+#define RV1106_VOGRF_GMAC_CLK_CON		0X60004
+
+#define RV1106_VOGRF_MACPHY_RMII_MODE		GRF_BIT(0)
+#define RV1106_VOGRF_GMAC_CLK_RMII_DIV2		GRF_BIT(2)
+#define RV1106_VOGRF_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(2)
+
+#define RV1106_VOGRF_MACPHY_CON0		0X60028
+
+static void rv1106_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	regmap_write(bsp_priv->grf, RV1106_VOGRF_GMAC_CLK_CON,
+		     RV1106_VOGRF_MACPHY_RMII_MODE |
+		     RV1106_VOGRF_GMAC_CLK_RMII_DIV2);
+}
+
+static int rv1106_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
+{
+	unsigned int val;
+
+	if (interface != PHY_INTERFACE_MODE_RMII)
+		return 0;
+
+	if (speed == SPEED_10)
+		val = RV1106_VOGRF_GMAC_CLK_RMII_DIV20;
+	else if (speed == SPEED_100)
+		val = RV1106_VOGRF_GMAC_CLK_RMII_DIV2;
+	else
+		return -EINVAL;
+
+	regmap_write(bsp_priv->grf, RV1106_VOGRF_GMAC_CLK_CON, val);
+
+	return 0;
+}
+
+static void rv1106_integrated_phy_powerup(struct rk_priv_data *bsp_priv)
+{
+	rk_gmac_integrated_fephy_powerup(bsp_priv, RV1106_VOGRF_MACPHY_CON0);
+}
+
+static void rv1106_integrated_phy_powerdown(struct rk_priv_data *bsp_priv)
+{
+	rk_gmac_integrated_fephy_powerdown(bsp_priv, RV1106_VOGRF_MACPHY_CON0);
+}
+
+static const struct rk_gmac_ops rv1106_ops = {
+	.set_to_rmii = rv1106_set_to_rmii,
+	.set_speed = rv1106_set_speed,
+	.integrated_phy_powerup = rv1106_integrated_phy_powerup,
+	.integrated_phy_powerdown = rv1106_integrated_phy_powerdown,
+
+	.supports_rmii = true,
+};
+
 #define RV1108_GRF_GMAC_CON0		0X0900
 
 /* RV1108_GRF_GMAC_CON0 */
@@ -1628,6 +1682,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
 	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
 	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },
+	{ .compatible = "rockchip,rv1106-gmac", .data = &rv1106_ops },
 	{ .compatible = "rockchip,rv1108-gmac", .data = &rv1108_ops },
 	{ .compatible = "rockchip,rv1126-gmac", .data = &rv1126_ops },
 	{ }
-- 
2.47.3

