Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71F37C0E5
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028143; cv=none; b=p5CZpL4Yl4fqHiUvZlerwFeRwZ7tHtky6Wg4SLfZdGVh+cGG+JclKyAiR87MzHp8iTpHgsdH++yr0gzPPbqCcHcJo+8ylefaDpyVlpZIBOhDsEsu7kAxxERM5O6PS9oyxtJKT1y2kA8auL5LIEDTYoRTyjNj/NPE/BSGAFw+USs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028143; c=relaxed/simple;
	bh=u0ng+jfraXxC5w+GHsCnRqxWvA9mJXmlY5W5PqAcPAM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=l9+4wJnaPQtpUNmumovYGxJ1yyiHNUrzwbHE+J8dSvPgPEn5Lo8e6eLvONJ8jdrKBNNOcamYS9+Hea67Y3yM7AkrwBeV6PgxRRt+kt4V6HWmwfgL5Fw5a0D1EErb3sxbIRbhh404g9yh5woYltaqX+tR1B4aA2YFfY2YYTdQEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FsrWPQtp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FsrWPQtp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+RyK+eRRBkE3UgpmRoyI5D1IfX9f6dcXT9xzKKqqf4w=; b=FsrWPQtp4PB+mQdaxpcBKCI+DJ
	IipB2NibKru4keiDwcnEEdL08zMlSpXrbhzh3rb0tr5Fr1fa+eYdui5MNI+otccMVgVHfVbcZWtTr
	/UgLuMbM+6qw8DwyInFAhfQ69CjRYGUUoa75ucJQV+cJ3QtEVB1BiSLRzRbKwx1SSZVy45MN1sXHf
	4O8YsxBHygkfvlTwUN1zuzwpCwk/MK+nZjHDIKNQYvswRUyXr79FEyznq1ExXNO3Nb1HvC+Ri/YTc
	J7KXwiQ0j0hdqIeraBRhcN20PDyqgsQy00NicEiHaNcE9CHex+cPqdpCcyTy/XZaTNitr01OYavN6
	hnkFl9LA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59448 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7pu0-000000002ir-3bCU;
	Wed, 01 Apr 2026 08:22:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7pty-0000000Eatt-2TjZ;
	Wed, 01 Apr 2026 08:22:10 +0100
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
Subject: [PATCH net-next v2 12/14] net: stmmac: add warning when TSO is
 requested but unsupported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7pty-0000000Eatt-2TjZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:22:10 +0100

Add a warning message if TSO is requested by the platform glue code but
the core wasn't configured for TSO.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7134f6c6075b..5286ad6412a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4392,8 +4392,10 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 	if (!(priv->plat->flags & STMMAC_FLAG_TSO_EN))
 		return;
 
-	if (!priv->dma_cap.tsoen)
+	if (!priv->dma_cap.tsoen) {
+		dev_warn(priv->device, "platform requests unsupported TSO\n");
 		return;
+	}
 
 	ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-- 
2.47.3

