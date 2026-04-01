Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9837C101
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028134; cv=none; b=mSEuiTs/WOMysTIvDJYCN4pmq3opXnwWzp+hURXBD7KIaQ54kMiHyMu5thGFfJSFwP7F4ql3wJEztgrqO7syixFwtAOg9n6mCDEUNa8ECmw/A5dtpYxrcWoifMKfSfxE+hdsDWd7QqfLk82bY0mCKdX/WCPk8vmVLo8dtKF3o6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028134; c=relaxed/simple;
	bh=orsKqdVyis/F/ATul7zEAX9ufwafjlB3zCOcVkpjJck=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ofr4UNKTCSUXsgacjDt6lPlMR/1e8Ua4wvQvzv7gbgsmm/mQzlG9pdKp/mSCHu9Ilfk+FdDNLHLrAsXq3XXHRWAiBkegWnl43qla+j4Fqp+4LRO1Az7mkSfjPurrUGQYgSLpygkhVp67iTtxBojhjBORfxLqLu9CANb9WVU4Dn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VW7sAHti; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VW7sAHti"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RVI5lyA9Y331B3DR8RZwCYHymPCwQsuFF9FPzNlqkkQ=; b=VW7sAHtiC9MFIwUar6jQRtimGQ
	/wRXV3Vs36XkW4u3u17eTC52xwI86sxgun/V+MG23k4F5wpNFBf5F5MFWzx0ZKM4BMui6PPM//AK4
	8lqrQ6d5zrRIeOv/cg0HEIRJjP++MGWxg37+cps636ZWoUEHyohXVLFzUXIOoOOwnJyJc/mEYpvZQ
	hM2Ud/gH1UbdR/CyrPb+IEg4ZjMr11ZBW1AU1M2vEvLUoGtKNMRvGILUAiGr3UPJF7vSJhryfKQAO
	jK7AZinJDZLwCulNgFDgNZg4Go7TKOByswBHgLKlTiSfP20KTYJ3zM5LD9cU6lkPnFjAfcqXmIT3w
	3diHESWQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59024 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptp-000000002iE-2kwa;
	Wed, 01 Apr 2026 08:22:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7pto-0000000Eath-1VDH;
	Wed, 01 Apr 2026 08:22:00 +0100
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 10/14] net: stmmac: split out gso features setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7pto-0000000Eath-1VDH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:22:00 +0100

Move the GSO features setup into a separate function, co-loated with
other GSO/TSO support.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 42e2196e82a4..e868fb0c9894 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4385,6 +4385,19 @@ static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
 	}
 }
 
+static void stmmac_set_gso_features(struct net_device *ndev)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
+		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
+		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
+			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
+		stmmac_set_gso_types(priv, true);
+		dev_info(priv->device, "TSO feature enabled\n");
+	}
+}
+
 static size_t stmmac_tso_header_size(struct sk_buff *skb)
 {
 	size_t size;
@@ -7888,13 +7901,7 @@ static int __stmmac_dvr_probe(struct device *device,
 		ndev->hw_features |= NETIF_F_HW_TC;
 	}
 
-	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
-		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
-		stmmac_set_gso_types(priv, true);
-		dev_info(priv->device, "TSO feature enabled\n");
-	}
+	stmmac_set_gso_features(ndev);
 
 	if (priv->dma_cap.sphen &&
 	    !(priv->plat->flags & STMMAC_FLAG_SPH_DISABLE)) {
-- 
2.47.3

