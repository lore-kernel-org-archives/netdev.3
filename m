Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21325386C19;
	Wed,  4 Mar 2026 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614165; cv=none; b=CQA25s/lQXcFNyEsi6uONP1Xl5UzQgpSX7ogJtXYG6txo6zE1YlMcMJacqTQzCiwOxukzA105CfOEYuOSy/5vUgcvKcI/W4GfE0mdXXGl8wr7pNvURJVTQJIrrzG43zEMnrPi7rmsyMjlEmh+oSTMgNFApxA5//X8Kdt1MKPaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614165; c=relaxed/simple;
	bh=a/QcLunjGyz9GynXNXKylY6bpg1dEUi6TO1NB9+T4pM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UyEo1hmHgNro+FK7Znmj/95hoOw/9X+0gUzuzWTLB6rTdAJ/B9zIJJ4va4iNHzn6ZmaR/jYPtV1U83H+fU9EiLXgG3lJrHAtP3YHoRLC7Hh8Xy4daqtnkFSzcfsd7SIjJhXYnxGUrzm4DayQmd+h9SnVMDjK9oXpCqZEdKh3SFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jk9T+Jze; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jk9T+Jze"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MtyItftqheZyJr9R3wUpvn9mGQIFWLFIwnIWg5pAtEk=; b=Jk9T+JzepncKRLy5oS27CaBpBm
	FLsy1d9a+e0N9EHWlPuzj9qYZohiRuviPKf164Q6vDettgXETX3+7uqAHsgsWVaVvFVRLxuGttYQz
	jnoqzIEE4Xjdi39+q8BDYlLQsImP2uvh2M/iSAsDaLrS9NETk1UKbJ/3+4yOe5ATyGQLTc+E0CMHm
	6yiHYvn+oVKO/KtLq4gyETxn1NE2oVnCg6TElpaepViGttLsYhXgwqxOCkfcplFNbmNvfy4s6+let
	iyOKm+hKq526DWlkhq9KSQtOi1FAqqvGVP32UW2rO/xLFJVHc2A8/DGcrMYBDt2Xi+NJgUNNhIfjS
	nq8sWxTA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41170 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxhuu-0000000069o-3eA5;
	Wed, 04 Mar 2026 08:49:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxhut-0000000BqGc-138V;
	Wed, 04 Mar 2026 08:49:15 +0000
In-Reply-To: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
References: <aafxqCvJ_XY4YbWw@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next v2 4/7] net: stmmac: add struct stmmac_pcs_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxhut-0000000BqGc-138V@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 08:49:15 +0000

We need to describe one more register (offset and field bitmask) to
the PCS code. Move the existing PCS offset and interrupt enable bits
to a new struct and pass that in to stmmac_integrated_pcs_init().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 9 ++++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 8 ++++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c     | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h     | 9 +++++++--
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index af566636fad9..a3ef237de1b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -22,14 +22,17 @@
 #include "stmmac_ptp.h"
 #include "dwmac1000.h"
 
+static const struct stmmac_pcs_info dwmac1000_pcs_info = {
+	.pcs_offset = GMAC_PCS_BASE,
+	.int_mask = GMAC_INT_DISABLE_PCSLINK | GMAC_INT_DISABLE_PCSAN,
+};
+
 static int dwmac1000_pcs_init(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.pcs)
 		return 0;
 
-	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
-					  GMAC_INT_DISABLE_PCSLINK |
-					  GMAC_INT_DISABLE_PCSAN);
+	return stmmac_integrated_pcs_init(priv, &dwmac1000_pcs_info);
 }
 
 static void dwmac1000_core_init(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 623868afe93d..7f4949229288 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -22,13 +22,17 @@
 #include "dwmac4.h"
 #include "dwmac5.h"
 
+static const struct stmmac_pcs_info dwmac4_pcs_info = {
+	.pcs_offset = GMAC_PCS_BASE,
+	.int_mask = GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE,
+};
+
 static int dwmac4_pcs_init(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.pcs)
 		return 0;
 
-	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
-					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE);
+	return stmmac_integrated_pcs_init(priv, &dwmac4_pcs_info);
 }
 
 static void dwmac4_core_init(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index e606dfb85f94..77a83e415597 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -167,8 +167,8 @@ int stmmac_integrated_pcs_get_phy_intf_sel(struct phylink_pcs *pcs,
 	return -EINVAL;
 }
 
-int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
-			       u32 int_mask)
+int stmmac_integrated_pcs_init(struct stmmac_priv *priv,
+			       const struct stmmac_pcs_info *pcs_info)
 {
 	struct stmmac_pcs *spcs;
 
@@ -177,8 +177,8 @@ int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
 		return -ENOMEM;
 
 	spcs->priv = priv;
-	spcs->base = priv->ioaddr + offset;
-	spcs->int_mask = int_mask;
+	spcs->base = priv->ioaddr + pcs_info->pcs_offset;
+	spcs->int_mask = pcs_info->int_mask;
 	spcs->pcs.ops = &dwmac_integrated_pcs_ops;
 
 	/* If the PCS supports extended status, then it supports BASE-X AN
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 12ea87792fcb..f3dada71e381 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -27,6 +27,11 @@
 
 struct stmmac_priv;
 
+struct stmmac_pcs_info {
+	unsigned int pcs_offset;
+	u32 int_mask;
+};
+
 struct stmmac_pcs {
 	struct stmmac_priv *priv;
 	void __iomem *base;
@@ -45,8 +50,8 @@ void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 			       struct stmmac_extra_stats *x);
 int stmmac_integrated_pcs_get_phy_intf_sel(struct phylink_pcs *pcs,
 					   phy_interface_t interface);
-int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
-			       u32 int_mask);
+int stmmac_integrated_pcs_init(struct stmmac_priv *priv,
+			       const struct stmmac_pcs_info *pcs_info);
 
 /**
  * dwmac_ctrl_ane - To program the AN Control Register.
-- 
2.47.3

