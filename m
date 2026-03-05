Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696137B3F2
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707388; cv=none; b=NV+m69hkiPcTR3eZHaxxCwMhLyl4qsp0nyex5l2iYDxbKVtH/vuDB2nxBaEMi9uw9aWObYV9sEc7Dz5TLirjW0M2YVm7Dzq6rYE6umWx5PgD1YrMW3IGmFBZnaevu6WXXidGj82PXBeI7LyCvPebq78KA2wv24Jhjr8tSEbPXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707388; c=relaxed/simple;
	bh=fzMT9a10aDVr4NgGA+zak+pM8uZrheT0J0ztMX8ClXo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Vgrmc79AbC8jvPmXTNWC4RviUmtUFPGB6Kbs85fT3IQA1bAl1zLYMC5glc2ltiIu/WNE7o+S314HIjjbqUfT4wt+kgXSRgb8S61jlJNQ9emlJGhQzhtxStw5Zr118LuXVbCQRU0sMBczOrunYsaYA2quoF2wF/8lfvJgQ+ekuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yIxKsNaG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yIxKsNaG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXZyqgN8dMCgcgZFM/zLAXjQCHFSgvYmx6oyb7xGPsI=; b=yIxKsNaGj0884hFedTKYrmGTv/
	MAIIGTLD7qzIQsE475lPs20slPp7XAAAP8NSnYMYyvhcIMZtgEw3LF0+V1RXxhlVrJAmIXt736i0T
	R6Czkb2uLPIvNHddhiTLVhQQ8RV9SVNrFpLtmIx8eRsLg6wsaJALyR2v9LLTsKHaBWtIoxc7Fw2UV
	G9q169qOTxX+LFxJ4gyof1LlB08uxcli3JIods61zjSvVrCMyoOGiK1liXNu0Qu1k8xDU9UKDSoE+
	qM9tgeWSfLYNPQ245GY7HRxk1dPx5N8qlDSF5Dv3qp0rstPtefPlahLlPbl01p+TVPLMIqnl4rXip
	pBEASvQQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43338 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vy6AP-000000007oH-3b3E;
	Thu, 05 Mar 2026 10:42:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vy6AO-0000000Btx7-2NDV;
	Thu, 05 Mar 2026 10:42:52 +0000
In-Reply-To: <aald--qJquWGIvmO@shell.armlinux.org.uk>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next v2 6/8] net: stmmac: use GENMASK_U32() for mdio
 bitfields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vy6AO-0000000Btx7-2NDV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Mar 2026 10:42:52 +0000

Rather than using hex numbers, use GENMASK() for mdio bitfields.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index a6f8e78856aa..b913fe5af488 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -367,8 +367,8 @@ static int loongson_dwmac_setup(void *apriv, struct mac_device_info *mac)
 	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
 	mac->mii.addr = GMAC_MII_ADDR;
 	mac->mii.data = GMAC_MII_DATA;
-	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.addr_mask = GENMASK_U32(15, 11);
+	mac->mii.reg_mask = GENMASK_U32(10, 6);
 	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 4ea55be04c5c..c7cb30672604 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -496,8 +496,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
 	mac->mii.addr = GMAC_MII_ADDR;
 	mac->mii.data = GMAC_MII_DATA;
-	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.addr_mask = GENMASK_U32(15, 11);
+	mac->mii.reg_mask = GENMASK_U32(10, 6);
 	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index 7c91ea2775d4..6b5cf3a0866a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -184,8 +184,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	mac->link.speed_mask = MAC_CONTROL_PS;
 	mac->mii.addr = MAC_MII_ADDR;
 	mac->mii.data = MAC_MII_DATA;
-	mac->mii.addr_mask = 0x0000F800;
-	mac->mii.reg_mask = 0x000007C0;
+	mac->mii.addr_mask = GENMASK_U32(15, 11);
+	mac->mii.reg_mask = GENMASK_U32(10, 6);
 	mac->mii.clk_csr_mask = GENMASK_U32(5, 2);
 
 	return 0;
-- 
2.47.3

