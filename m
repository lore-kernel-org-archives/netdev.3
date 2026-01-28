Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A79339844
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597929; cv=none; b=MB4CUgcEXKNbUu/TV1Airhs9gtKZaefgL1inT7ulMCNNdEHCGo2WEjLIIBM18tr8pg78zF/JaRMZ4ixLc8RruC7M2oG4oKRxoUAwCuJeV8MXIM9zhdXjDDB3pVtKOJL7/ANM39a7/EuqP/wuker1MQlSdCBibn6sRY4nnQuhkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597929; c=relaxed/simple;
	bh=4x7LuHjPK8XgE+y0VJvhWt8KJquk/WA+d+diP8nxK/k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hryofhBn3BWA9a7nHUPruzcM6OBtpXFx+fS1hLLcCaipyR8J9c5eLiOD6KNHXS/ZxYSQSITw2O9ir5MauA7HDvjmXwyY3Va0WzDOctZ7Fgki337uCmlM+zJn3g4yhgtPNp0a1dJzLUHcKqPOwfYHUzN7MMf6C0Yoo3kscg4XqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mfBPwzQb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mfBPwzQb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TQbhJic195icRH9DOBVb9n01Zo2c/1UpNVxdtJLDUFQ=; b=mfBPwzQbQzvTKMcS5/G0eCK4rz
	rcDywclYF9VAv0s9JEq72l0epMmo74oiFqc46YpNDaEtuotCdWtWEEKsCFLAlW+9lU1ZKkbSX2Ts/
	1BZ38F5KTEYdlWGGtejahfmDwc6CaLS6loCWdbUed+NpkLOrkqc3tYdXkG2WkX0wW7PAmp9kBsIHU
	51YoIluLMukWdGn60Z/qcUz7n33B3CPiVIIk2zttQiHRW+AEqlppz8qFRP+HQgkmIGnq5t+4UkXvk
	VEXUQmXZrMzSNKNabRMJutvyipQ4+LEmqDbzhd6B14FndGjYUpa/ker1ESK3DNXPOq8uKjVIrt76V
	Jk8dRsBQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42246 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vl3Fw-000000007Fm-0wVm;
	Wed, 28 Jan 2026 10:58:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vl3Fv-00000006v3L-215v;
	Wed, 28 Jan 2026 10:58:39 +0000
In-Reply-To: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH net-next 1/3] net: stmmac: rk: fix missing reset_control_put()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vl3Fv-00000006v3L-215v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 28 Jan 2026 10:58:39 +0000

rk_gmac_setup() delves into the PHY's DT node to retrieve its reset
control using of_reset_control_get(). However, it never releases it
when the driver is removed. Add reset_control_put() to rk_gmac_exit()
to clean this up.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 5f8d2031b97c..bc69cbb5a7d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1784,6 +1784,8 @@ static void rk_gmac_exit(struct device *dev, void *bsp_priv_)
 
 	if (priv->plat->phy_node && bsp_priv->integrated_phy)
 		clk_put(bsp_priv->clk_phy);
+
+	reset_control_put(bsp_priv->phy_reset);
 }
 
 static int rk_gmac_probe(struct platform_device *pdev)
-- 
2.47.3

