Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7F2D7802
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597292; cv=none; b=ka1ezSVtsG5D/+uLv+gR81yN6DAbubwuR6+rHNpYXyFLGQPMO50bHCZwKCpQatQzLvXXUHUaitJ1z3t6YV4xa3nEqPp91T0CWSjAGweEkJ7vp/RCa9g7abOwM5knSPRToRDP2TE3f80wktYlvH65diwCTmLgPB99lJD4mmkO6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597292; c=relaxed/simple;
	bh=aoFEmhNKJNlS97vKDmveV/sR8Tk8OwFtkHtyYMStjzs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=AhQZSu8urPbepQvEckdPvF8X2KjYl0anXWXNKVc7Bm4EaRT8Jgdx+i9U1NrX9K0or33ebkyIF10Hd7RoDmECZ5ALJteYzOEVnhPJEAjpABrz+tinHQ/QLZ4hEilsDtadWveD0l4NtfMeqXWEd+sP0o2yhooftUMYFH3UJbs+S4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SZmBD5e1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SZmBD5e1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WefJzj7rPdEoa3EYJhEBhhBcLW/TXT4G2TpOC+K7+7s=; b=SZmBD5e17eMVBo94UovYkYk0UA
	2hy01dibmfmyk7UbyNGIZ6yFgUK8uV0ApQeuKQtSOjk0cGmzNrX1M7HLdhZQxVXsWBmgoC8kZFLzV
	WhyfptICJi8vglSO1pXnNTaT8fUmOK453/IDk1153SZx9UxCARowSsx6rsbJ5EUDPTfBI2Pn5gszk
	LjOSKVe8oW4GjHFgqBUVKnTnVNoReiCD4leSDw+XkQvzlx3s9BSqJ41JWnDNbVuooctUEAFFzLYHp
	cJh5AJCuuJ2Gc2ULJ51E7IjkZkwZkouYUm/pV980+UkRZpXpkcmskoI7U38s2jwn1kKQvH8a1dgf4
	TzqW0RGA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53680 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vl35c-000000007Cl-24lX;
	Wed, 28 Jan 2026 10:48:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vl35b-00000006upH-2zt9;
	Wed, 28 Jan 2026 10:47:59 +0000
In-Reply-To: <aXnoV3Ay0uCc3HGQ@shell.armlinux.org.uk>
References: <aXnoV3Ay0uCc3HGQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] net: stmmac: thead: avoid conflicts with
 PHY_INTF_* definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vl35b-00000006upH-2zt9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 28 Jan 2026 10:47:59 +0000

Avoid conflicts between stmmac PHY_INTF_* and GMAC_INTF_CTRL register
definitions by replacing the PHY_ prefix with GMAC_.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index e291028ba56e..0d46a6c3f077 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -37,9 +37,9 @@
 #define GMAC_GTXCLK_SEL			0x18
 #define  GMAC_GTXCLK_SEL_PLL		BIT(0)
 #define GMAC_INTF_CTRL			0x1c
-#define  PHY_INTF_MASK			BIT(0)
-#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
-#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
+#define  GMAC_INTF_MASK			BIT(0)
+#define  GMAC_INTF_RGMII		FIELD_PREP(GMAC_INTF_MASK, 1)
+#define  GMAC_INTF_MII_GMII		FIELD_PREP(GMAC_INTF_MASK, 0)
 #define GMAC_TXCLK_OEN			0x20
 #define  TXCLK_DIR_MASK			BIT(0)
 #define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
@@ -58,13 +58,13 @@ static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
 
 	switch (plat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		phyif = PHY_INTF_MII_GMII;
+		phyif = GMAC_INTF_MII_GMII;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
-		phyif = PHY_INTF_RGMII;
+		phyif = GMAC_INTF_RGMII;
 		break;
 	default:
 		dev_err(dwmac->dev, "unsupported phy interface %s\n",
-- 
2.47.3

