Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391209;
	b=WhE+mCv5Gx4rzS+7jDAhLjJ32QE67+QehXDihlSddhPoJtmj5YwUeloU1FFJZ4f+BLKq
	 1XVvJAKCFWqKD7dXCAmzJe4wu1S+g3w3mTXFVHEWzSIadbjk9LaQ7lEycVfACiW7XGs3x
	 NLdQ73QBk43ql68s01WKKQFev+k+Lpb2GYlNdIBAtnp8FoGCcGt4U54CCfWYajDdoRNy9
	 KtgXfuT2JuN5T0UOumQfZhWE8ntLf7WZZtMRzOLYELeAvT3LGltCVxVBDx/6o7Be5L6MO
	 WigWoBErOzpZs4m6pamwqw59FvtClL3XJqtjJReWCsidr83rsDI+JTCHVysfULUNYEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391209;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0inTc72tNtgjCZaCWeW8u0+OSffO1GI14ZtqPEL3d8g=;
	b=FoZlSP1nUiK0PwTlK3i+OBnz/PyIuGNUAFygvihZhCock5PVzlVLBqoknY9uqqXA1ysF
	 dT7/CzeCxtlzKLkuSfqzS1663ZqQUZW+pex1BMzXIXmPNxhb2Zn//+XO6FlfEtb6WMv7f
	 2VSkOFbnhguo0hWwdFB1p5PH8JNcuTNMYtSWl8PiUbIbFY1bCcEOtz7TxFns1osLW38Qj
	 UX0rvOOOaotwlre7GjPtuTuwPJUIRDjy2G5xu40oJRVHN3K89ZX2wNqg7YOSrcfZI1LbV
	 7muUYGxlQsQzbcOhncDQX8SH0mYe8o4UhIQUIrZmEIUhcdsIJyGkrQEvIwFbWh5QuiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Drd0BjnY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309760A2608;
	Wed, 11 Nov 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Drd0BjnY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794391209;
	b=CND2mgUa4lC8QTmyxQB2T+ogvDAPnJ2BUDno4Zr7nzJKfiN0e8uVGJ9IXZ62QIGxccEF
	 RNW2d/hmbHuUEVdq9MlbkZC75zKsNZjAhtMX1YFf8Hr6E0xt1rTmYXYom1wDZZMjZYEgV
	 Gr3B7k1E4I3h16KLRn6tfPVVS/ldquCUXHRthcfyanPu6FP7GTYYvGMwKsSrrJg+YRT2w
	 4UGNQMSA44hGi3fyn9ryM45av91GIP6x1/fuBD8kLyAUqV1VIHoMUvGah2/wVQUFzk9Hq
	 MybW+SD/jJlEes+PuWMGyRbOEPPFTJQ+HEqelt6lqhgzDYxkJliIniKLyDYL7E3B0aw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391209;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0inTc72tNtgjCZaCWeW8u0+OSffO1GI14ZtqPEL3d8g=;
	b=LCnzQ+3df6b9gb0/J99qSlyXFt4cKfGffebcvXzmL4969bZEw4gjvD9jJuAco0x3FRTp
	 TpiOi9sGeiNZczPkVuJ1QsBUR6UWpcvQWE2JFwfCJpL/oaa49l9JlgxUiIARjeDVlslLs
	 rVN3/ifOVUVy8gmlkCbKX9h2JjJLZRrZsp/BWyjVN6l98YYQDp7S8dBB0FXzb8B8etS4o
	 SgGl3cfe9zD2UUBL/FZT0lNRWxM19cLQcqrFw7wzU9RlTOVKOcXv8ZkLSzL+/texOG3n9
	 cXUGiIcBzj93Nl0OM+ZXvW/I47cek0nJ46vehEND/Ip3MRmXOicnYMwH54J2w9dsW4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 910611F00A08;
	Wed, 11 Nov 2026 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391209;
	bh=0inTc72tNtgjCZaCWeW8u0+OSffO1GI14ZtqPEL3d8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Drd0BjnYiSrO4SK7ZAE6NfOVa2EjNChOu1CpWL44/USqgngfq6L9dChZCDkbAanFt
	 uGB86e46mXAxR7bfY9sIxRAa1o6OvLm2HjMMvOcXaD8rOLXELlQ8CsY1I5FB5B3st0
	 LqfCdz/e7Y7dtdLhDGCuVo0b6VTqjw++FGWTy4d4SHQk+PMa2tHAXc7XhJAcI6BZxR
	 ou8RZfYXQQKjH+Ftn2E6Ig4goREPv7DW2qed1qS8fqKtrNUDoW0RW1dCrZdMrc4bg0
	 hOdQMkU7nlNzy+GpFexsJMTXV4VfSUTbcDOZiQcAtqaE4ZISjkXMkP0VW8ms5kv4H2
	 pXqt4rt1G4NKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 17B8048F25;
	Wed, 11 Nov 2026 10:00:08 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 17:56:29 +0800
Subject: [PATCH net-next v2 2/2] net: stmmac: dwmac-rk: Add RK3572 support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-add-board-ok3572-c-net-v2-2-304466394970@qq.com>
References: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
In-Reply-To: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 David Wu <david.wu@rock-chips.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Cunhao Lu <1579567540@qq.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391206; l=3142;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=bJZr2jTjg4023AjgAd/Zj2CWJraJeUFEaOgI88A3Cbk=;
 b=jEQpmIjRN58KDsmIItARMWGBR9/tQFG9sLJdgCnv3tiEkLj98mJUEUUC9c0t/JiC7ZJXHDEJN
 se60OOE7HDgBwGvEfdETUlLxU6Ep4JJ/F8R1aNpxxWA3irkjAbFxbXR
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The RK3572 has two GMAC controllers with separate mode and clock control
registers in the PHP and NVM0 GRFs. RGMII delay lines are configured
through the IOC.

Add the register layout and delay callback for both controllers so the
Rockchip glue driver can configure their RGMII and RMII interfaces and
select the appropriate clocks for each link speed.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index a37df5767d84..c9d8d8bf51f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -900,6 +900,58 @@ static const struct rk_gmac_ops rk3568_ops = {
 	},
 };
 
+#define RK3572_VCCIO0_3_VO_IOC_CON1		0x10608
+#define RK3572_VCCIO1_2_4_VI_IOC_CON1		0x12604
+#define RK3572_VCCIO5_6_IOC_MISC0		0x14630
+#define RK3572_PHP_GRF_GMAC0_CON		0x0070
+#define RK3572_NVM0_GRF_GMAC1_CON		0x0020
+
+static int rk3572_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->gmac_grf_reg = RK3572_PHP_GRF_GMAC0_CON;
+		break;
+	case 1:
+		bsp_priv->gmac_grf_reg = RK3572_NVM0_GRF_GMAC1_CON;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	bsp_priv->clock_grf_reg = bsp_priv->gmac_grf_reg;
+	return 0;
+}
+
+static void rk3572_set_to_rgmii(struct rk_priv_data *bsp_priv,
+				int tx_delay, int rx_delay)
+{
+	u32 val = GRF_FIELD(14, 8, rx_delay) | GRF_FIELD(6, 0, tx_delay) |
+		  GRF_FIELD(15, 15, !!rx_delay) | GRF_FIELD(7, 7, !!tx_delay);
+
+	if (bsp_priv->id == 1) {
+		regmap_write(bsp_priv->php_grf, RK3572_VCCIO0_3_VO_IOC_CON1, val);
+		regmap_write(bsp_priv->php_grf, RK3572_VCCIO5_6_IOC_MISC0, val);
+	} else {
+		regmap_write(bsp_priv->php_grf, RK3572_VCCIO1_2_4_VI_IOC_CON1, val);
+	}
+}
+
+static const struct rk_gmac_ops rk3572_ops = {
+	.init = rk3572_init,
+	.set_to_rgmii = rk3572_set_to_rgmii,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
+	.gmac_rmii_mode_mask = BIT_U16(3),
+	.clock.io_clksel_io_mask = BIT_U16(7),
+	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
+	.clock.rmii_clk_sel_mask = BIT_U16(5),
+	.clock.rmii_gate_en_mask = BIT_U16(4),
+	.supports_rmii = true,
+	.php_grf_required = true,
+	.regs_valid = true,
+	.regs = { 0x29d20000, 0x2a040000, 0 },
+};
+
 /* VCCIO0_1_3_IOC */
 #define RK3576_VCCIO0_1_3_IOC_CON2		0X6408
 #define RK3576_VCCIO0_1_3_IOC_CON3		0X640c
@@ -1720,6 +1772,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3506-gmac", .data = &rk3506_ops },
 	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
+	{ .compatible = "rockchip,rk3572-gmac", .data = &rk3572_ops },
 	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
 	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },
 	{ .compatible = "rockchip,rv1108-gmac", .data = &rv1108_ops },

-- 
2.34.1


