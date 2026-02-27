Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26178368946
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185997; cv=none; b=hgHn8BgUiu6JGhWEmQf333hZDfHjJzm0Nh1Dhai6qPi6/lfbBfF+neIGYC+xvGYnc1pNxD4jBxDZ9AWKu/atJiWniUkfxOGC9PqrKj1Omnc53G+RuLlHl+k58myoBNbajT7mpNCMJUDV5K3djvgXi392vvh/Md9jMQHNaGcTQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185997; c=relaxed/simple;
	bh=M8naX+NkPxbOaDs153BEq/VG9wChDoInlLyuNZMCJbQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Jh/H8lu2N8Axg/AbZotXNH3Hi8K2/Co5PqjxMOSpQYtZ09UYLHsM+PUnySY5zPWOicnngJb/pynKUwA4v4b5u5z9A+8L0NiSggz47KdUQO4e1hwkD3fbvSxFAYRYnZYJPdn85sQHRT6WQFOBd3GmtVo4poP0ewelPJpEHNJV+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pxKNgEqG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pxKNgEqG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b2eZz6n+JSnIZp/Guf2kgufVNYPqAEQOOWO68giC+nE=; b=pxKNgEqG0x7GN2Vk1aTXF7ptT8
	EsoqvMdG+gzQCA7Ggk1HFFYTclr/d94qcYr/xrKQWWIU2U9Nj7PIcxx435d1TAvQAnRhiYUM+RVGX
	J8CRkhyF4IH5dOUgEIm36Ruo+7RpuB+jGGamp+QQS0Y/pabrUnoYBOBDwwSsyb4/6ArKx2qrHIrki
	LRCBAM4AAMBrIfS1ksqxtDPygyDobxt5OAKTUjzaTlz0M/ndWTiDfQvZuwTbt1CKx/VvWo+H1aKLI
	9NgX8n8xIDjCAZ/Y5gymf7Vo4cLtjXi6l2KIkq2AozcBmxJn8HfINv+rS0CdyPmGO4/mV0Bik/egv
	/66nH1hA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51864 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuWz-000000000bv-2HVW;
	Fri, 27 Feb 2026 09:53:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuWy-0000000AvmY-3GWN;
	Fri, 27 Feb 2026 09:53:08 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 01/14] net: stmmac: clean up formatting in
 stmmac_mac_finish()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuWy-0000000AvmY-3GWN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:08 +0000

Wrap the arguments for priv->plat->mac_finish() to avoid an overly long
line.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c5e31492035..2b21cc839146 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -968,7 +968,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
 	if (priv->plat->mac_finish)
-		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
+		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
+				       interface);
 
 	return 0;
 }
-- 
2.47.3

