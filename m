Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557041;
	b=kuerOzgeWAhMqB6GHgYVGaOvSRU8Sf6KXy1R1jgQG3PPOrlhDB/SpJ6UL8mCZKAZeFUB
	 Pzx3bYIpOdW5JvZdC7hvXY9Am3AujhBSa4JFsgYg7H9/+Q7TPWH8YpQFkU/uamS9DpIDF
	 36NGfFid7s75wl+DYYcj0aDZ/GxqBUYz7ehNTOzsWWiWhS8DXf93Kj/cNsJrpGu6nHBA+
	 te3FZ2UJBVDohOYUKh/JMaAJQp7gw+kKOsNJSZ8fLlXxEmaTF5MYDEshbx+8F3kG7KRNJ
	 D4wwOiuoRBPhdlvNbfS/rtOx6mqORhK+U9gSCh+LXgHD2iQ89VyuUxSM5RD+mRvpV4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557041;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9aTGmfKoZNcf7jTTJ6RvYLx/icbQQbPWjeg9zDfJi4c=;
	b=kSEYZSTkwUOdJ5lVhZjWMqQG+j6yf72Ra/YFQ9hjSXza5WodAYkBPJjDTNRdzQOYZ/m+
	 PFBsOk/SzhqdwsHJVacs+Wd+29LglANZcxTPX+cbRs3auZutY3HhHZt9cAAqcadM8JASI
	 gvMpFZ530vfxaF6XSxi+kMxRDXPtPA761vcxi2OPfLUEYeQvWGRp5etgAzErACwNKo/xf
	 xOKE6HBCdAxCLjFTgGeMAJPhzqzH3kS7ggu766L7vjpHhvCNZ/5omh9fApP+U+hg6Mr0k
	 G7mHHANcRm5WhyJrDUKi0DZCc3USbk2VpYSiryXW7b5AVP3m5VUt6+jDgQEK1TcE00g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lshj+DVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E85606A31C;
	Fri, 13 Nov 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lshj+DVG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794557040;
	b=aDZ11lWe/UBD4fk0CacR1o9ZDEaMZaFxyLQeAW7m47XJpMaSmngp4V3KeBQlSFz7mQS9
	 ogatGEwlvzNIG2SQqCXWjEzicXtmEaOnUclk9cVskuioGs+ZPf11Lb8EowQ8k7Fu1wKNv
	 DcBggL40GwPPRxmLUAApSKvdD6IWgYc6pZ6UBT+GK9+6Uixi3ls5gbA/4qW3Pi/BYCSsY
	 8fWwwrjkcie/1SMPzesi+Kx5hHDkZnULp8nIu7/3PaG6N5NloDxJzQjtSE80o0eHizWpz
	 c7pAnlZi3nCRZjZTgOFqzdOOKb2zBDIzxXrmEVmhF828ZW0fihmaOILmlsRGTVFM9Fw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794557040;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9aTGmfKoZNcf7jTTJ6RvYLx/icbQQbPWjeg9zDfJi4c=;
	b=CLb78VPBIaQiDt4pdhTp3RCeRt4CCy+yrW/3ycyIxsSLIz0rZFt39u1PHamF0Zb57Pab
	 54tCQAJU+3ML/Iwv7wqA/GB/1JHu63fWP5GDja4s6lVcOhB7ikPjoa0YHxUvqfX++FFXA
	 3raYk1H3+s5biXYqUn1f7E9d+FOisz1ChGW2adSy3pZQGb9tACUWU0bnfX6PwiLmG0tY2
	 Ay/kdpYK/2BYlSDcnzpv5zfUpCPl+RQQHl04j1tyT/xucRlZU+ZI/Nqc4fAjS80t/Klq0
	 eKZDAPnUaohQMzuoRjNjkdMwEVzPl+4PxkCkmVVMNBLVFrRJ2Lvz0RhccE+5TYq6Bgg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2F37A1F000C4;
	Fri, 13 Nov 2026 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794557040;
	bh=9aTGmfKoZNcf7jTTJ6RvYLx/icbQQbPWjeg9zDfJi4c=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Lshj+DVGf0XV1Tpuw1oQGOhRWKoxja3uypxUI7JFYTfBY8+dtB37Fy2nLiMssT9K2
	 SSdZ0e4mzTWtso4A41qtaq5r2MJGjo2dRlppLZ/nKEcNQze6rrPKCQv99zjmu56scS
	 6ckA3oqx6lXVo32UlKzoVwlPMEpeQXBXU5XfKLm6r4okwVZvmSUSwic6icDeot4bgB
	 SbHdlqMQ/optq5iGe6ToRR4KJiDoOVCfPJcuJkMQZ062lG10A8KvFmEl8EFlN2ysGu
	 D2MLbp05W31lVL6hfXBMeo95h+m8kvfBzOELSa0Nech0lWYNAynbCS7YBa6pHJQkAx
	 J60EE6L/W3G0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 81E564769E;
	Fri, 13 Nov 2026 08:03:59 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 08:04:00 +0000
Subject: [PATCH net-next] net: stmmac: dwmac-sun8i: Defer probe when the
 EPHY clock is not ready
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
Message-Id: <20261113-b4-sun8i-emac-ephy-defer-v1-1-12a8591702fe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2U0obQj4K8ZDKQ9ZEyvpFoMh/
 LtVj5PJzE6KJFA6VzslvETlGQuYU0Vh9vEGlrEwNXXTGmMsD451jZ0wHj4wlvnNIyYkdl0dbG9
 7h9ZTyZeESbbf+kIRmSO2TNe/0XW4I+TvmY7jAySUWp6GAAAA
X-Change-ID: 20261113-b4-sun8i-emac-ephy-defer-480c39394e6a
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794557039; l=2284;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=3vOWWV9l/RPEbbthTMkW1C/XCstj8pm3YVWcUELiCkk=;
 b=Zh00xt2IqE0H4WmqmMEFzkuWSzcVdr9Qa1Qf6eTGMm86i/HvyogK5dSaE/9LQJc9xcVZIiy9D
 Q9zA4UQMzy0DKdbTShY1TsZo15qzneFaut3ohv/froP6aUhibJFsMIG
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

get_ephy_nodes() skips an internal PHY node on any of_clk_get() error.
If the EPHY clock provider is not registered yet, the node is skipped,
the function returns -ENODEV and the probe fails for good. The reset
lookup right below already returns -EPROBE_DEFER in this case.

Return -EPROBE_DEFER for the clock too. Other clock errors still skip
the node, as before.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Reported by the Sashiko review bot while it reviewed my MDIO mux error
path fix for this driver:
https://sashiko.dev/#/bug/linux-98384c14-541e-410e-a074-fff5e98b3820

Only the H3/H5 and V3s variants (soc_has_internal_phy) reach this code.
With the in-tree device trees the EPHY clock comes from the same CCU as
the EMAC clock and reset, so the EMAC probe already waits for that CCU
and this cannot fail there. It matters when the EPHY clock comes
from a provider that probes later. Build-tested only (W=1, arm64 and
arm); I have no board with the internal PHY.

This patch was developed with Claude (Anthropic) as a coding assistant:
it checked the report against the code and wrote the fix and the commit
message. I reviewed it.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 2ece7ba9dd73..8163e49fa7ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -801,8 +801,13 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 		struct clk *ephy_clk;
 
 		ephy_clk = of_clk_get(iphynode, 0);
-		if (IS_ERR(ephy_clk))
+		if (IS_ERR(ephy_clk)) {
+			if (PTR_ERR(ephy_clk) == -EPROBE_DEFER) {
+				of_node_put(mdio_internal);
+				return -EPROBE_DEFER;
+			}
 			continue;
+		}
 		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);

---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20261113-b4-sun8i-emac-ephy-defer-480c39394e6a

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


