Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34C379C35;
	Wed, 30 Sep 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796887; cv=none; b=PEYLsue1tErARrmP98WYVuFues1JjLPCVLQLtlXUSwxZvgT35CLuM5zWoSwZ/ntMlokqj7KfBhW/4U93+gvr8FMT85s4x469gbwH5xkDFp4qutWepO2H7HPqTs/Pw34NL3/2oBhzM8rTFaS1wEhCCCzodbTImcKTc/N80Ia7rag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796887; c=relaxed/simple;
	bh=Gu/EkVwyQJgBD74XfphlWAlZsYmhDmD3C/OZgKSBQBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pVSZYigMyWoTgPwgnNKZ9YV7EMpcNMuhR3qxFxBzyi+DpWfmdXc9X1grXVISUWsa5aDO3oMZ/7jFyz4ye8mH+1KnkL2ke1fZ+pbxEKK7jTybKY0XcTSJzsoaDtlayIgm2Jlw5WHIyFa005yC+vba2rHkeZSpYL4uoqKr+lSPsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWfAJM5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWfAJM5y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80568C2BCB9;
	Wed, 30 Sep 2026 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790796887;
	bh=Gu/EkVwyQJgBD74XfphlWAlZsYmhDmD3C/OZgKSBQBc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tWfAJM5yLuZC6x0EfMQK/k3ydOvchipWQN7xO/1+ZyRwfPwLBMgXVQF6LuomhQ6Pu
	 y8HtxeUS2ido0xMuz78q6WaW1Xc/7g2xW0Cgb1NJrfGiG6sUVuU5+UE4CVMkL4tCwF
	 vGEYVls4UF8EnAEAtHVgc8/Y2cpjVdrGbsuA8sn1S+eXEFWwYpDWi8acZpHhZZRXns
	 XYAOtied2p6M1SzknDM+5y23QF8DN9cVnVEmy2FOGeCa6fRRfCnhUoOf+zp4w67UrA
	 D44qDt05z2GP6PYliJ0T0Jz5Dx4IvVPomWy4PCvSrXxCnyvD1zpnNouKvovG0IHd9B
	 5yjb0aCJktsnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF8CCA5FC4;
	Wed, 30 Sep 2026 19:34:47 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 30 Sep 2026 19:34:45 +0000
Subject: [PATCH net] net: stmmac: dwmac-rk: keep the GMAC powered when the
 PHY wakes the system
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>
X-B4-Tracking: v=1; b=H4sIAFRkvWoC/x3MQQ5AMBBA0avIrE1SJJNwFbEohk5Q0oqSxt01l
 m/xfwTPTthDk0VwfImX3SYUeQaD0XZmlDEZSlWSqiuFY9j0gG7BwzwY9hV7LliTJkXUQ8oOx5P
 c/7IFyyd07/sBjY2M0WcAAAA=
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=v2FMuWUABRc83FaiGNq51H6LZX+xOp9sURDtyb+WJCs=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFl7U8JcJqjtMr1SfGhbwq86VaVL/1MuRUq7PIqVaL2io
 GEjv0y3o5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAEzkTg8jwzmJwFPGq3ZeYFsS
 VPt7jdRjNfmM5R/j5KKmbAtOF7U142dkmPtLeZd1f+6e3RFn/2wsXTBTxan4v5GWQnXAL3sDvfP
 HOAE=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

Since commit 6911308d7d11 ("net: stmmac: convert to phylink-managed
Wake-on-Lan"), the MAC device gets its wakeup flag only when the MAC
handles Wake-on-LAN itself. When the PHY handles it, device_may_wakeup()
is false for the MAC, and rk_gmac_suspend() powers the GMAC down: its
clocks stop and phy-supply is released.

On Helios64 (RTL8211F, Wake-on-LAN in the PHY) the board then hangs on
the first or second suspend with a magic-packet wake.

Also keep the GMAC powered when phy_may_wakeup() is true, and remember
the decision for resume.

Fixes: 6911308d7d11 ("net: stmmac: convert to phylink-managed Wake-on-Lan")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on Helios64 with 7.3-rc5: 20 of 20 suspends woke on a magic
packet. The mainline Helios64 DT has no PHY node, so the test used a
DT that describes the PHY with its interrupt and wakeup-source (a DT
patch will follow), together with [1], which fixes an interrupt storm
on resume.

[1] https://lore.kernel.org/r/20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 72bdbcb5e863..06faeb156b97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -98,6 +98,7 @@ struct rk_priv_data {
 	bool integrated_phy;
 	bool supports_rgmii;
 	bool supports_rmii;
+	bool suspend_powerdown;
 
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -1530,10 +1531,13 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 
 static int rk_gmac_suspend(struct device *dev, void *bsp_priv_)
 {
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rk_priv_data *bsp_priv = bsp_priv_;
 
-	/* Keep the PHY up if we use Wake-on-Lan. */
-	if (!device_may_wakeup(dev))
+	/* Keep the MAC and PHY powered if either of them wakes the system. */
+	bsp_priv->suspend_powerdown = !device_may_wakeup(dev) &&
+		!(ndev->phydev && phy_may_wakeup(ndev->phydev));
+	if (bsp_priv->suspend_powerdown)
 		rk_gmac_powerdown(bsp_priv);
 
 	return 0;
@@ -1543,8 +1547,7 @@ static int rk_gmac_resume(struct device *dev, void *bsp_priv_)
 {
 	struct rk_priv_data *bsp_priv = bsp_priv_;
 
-	/* The PHY was up for Wake-on-Lan. */
-	if (!device_may_wakeup(dev))
+	if (bsp_priv->suspend_powerdown)
 		rk_gmac_powerup(bsp_priv);
 
 	return 0;

---
base-commit: 99b43ede9e355ba35244cc9470bf1819774ce39d
change-id: 20260930-dwmac-rk-phy-wol-be1ea6a6066b

Best regards,
-- 
Igor Velkov <iav@iav.lv>


