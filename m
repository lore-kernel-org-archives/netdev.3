Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543D30DEB2
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733852; cv=none; b=bKMP9gKOXZ2pTkEAJ1zzAKC4rs/4C6XOTemfMlOl6PSYlVPzkurfTLlNyiIEhCFdEriXvYbuEjG9AjrWsS9i+54Cddca0wLMqqEMX7JspiBF2awxkSCaOhxEY8IdlzbFw8YI2UebEcd6NMBxQXY1Np4R1ofIg2UWHF6dW0i7k2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733852; c=relaxed/simple;
	bh=v1g/RJsisq/4F+gX9vMjBV/AdmlxZdtHSlPIyaO0WoU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HFFZCNb9YdHs5pgERX6lx10rVdFBkjYobzC6ZpcB/m11sNSmiPrNsqapGm6NtsUC2lobIXXVdzvCWz23rqfhT3+++z7BQdiu3/4Rt53NeFnVu+xQVVZrztsHrS/NN9y/BaegUhZawWAgZsR+dtPGjC8cy0t4c6pa8/M/Ejf9J68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g81F8vmL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g81F8vmL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xB7kZRpx0s0qXnkYZbHnPSkUdvkt4LqCLfoJJ3DHNgQ=; b=g81F8vmLqcQg3tFPxLx2XzUPR9
	9Kk7rzo/kE9ZV1iCVOppdWSR903pRPBhJz7p7BYTlNidU1hxO7tSGs/OXzcNIzis6yFycOiy3e7AG
	O5T/H9aizkEl8mzBr6OL40Yoiu9j+8VV4xkwLVcAV8zNFWUJ/f1lw/Kw0bQkhm+5D1VvwCHMTBWBm
	H6rx7MHL9hOCM8ssUZFzHDnjmlq4UxJBcWrom5Aw9iPGEeLT/rO+vLgVVTINsfCi9wHMvfXy7ycgz
	QBeH3txMCcvPsmIXez7lgrd1EwV77OS/kGcyVm5f46PPfEtsnWMmPYFT1aA2DV8TMnj074SpCIHhT
	lZaC4vcQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43642 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6bLL-000000007Th-17Q0;
	Sat, 28 Mar 2026 21:37:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6bLJ-0000000ELuL-2oxj;
	Sat, 28 Mar 2026 21:37:17 +0000
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 08/10] net: stmmac: make stmmac_set_gso_features()
 more readable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6bLJ-0000000ELuL-2oxj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 28 Mar 2026 21:37:17 +0000

Make stmmac_set_gso_features() more readable by adding some whitespace
and getting rid of the indentation.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4442358e8280..3bfa4bbe857f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4385,13 +4385,19 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
-	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
-		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
-		stmmac_set_gso_types(priv, true);
-		dev_info(priv->device, "TSO feature enabled\n");
-	}
+	if (!(priv->plat->flags & STMMAC_FLAG_TSO_EN))
+		return;
+
+	if (!priv->dma_cap.tsoen)
+		return;
+
+	ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
+		ndev->hw_features |= NETIF_F_GSO_UDP_L4;
+
+	stmmac_set_gso_types(priv, true);
+
+	dev_info(priv->device, "TSO feature enabled\n");
 }
 
 /**
-- 
2.47.3

