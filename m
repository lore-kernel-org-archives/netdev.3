Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957230E821
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733861; cv=none; b=huO7IRAYauG8tf/GYyNVEi/yKVja6uUJmVWrWRSPY7SNB9ktcl4xKhxQiQwQwK5tngtr4Uuq97rRbSgOJX+ob+gGo1MOi/RjavpTsel23LmH4d9Yq3OUpaDWlfNulzr1b5lFN1QA6fyWq3LG9X51ATQCL63uFmn8xs0Saehl7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733861; c=relaxed/simple;
	bh=7RZLjP/kecwgwA7Vhcv59do/YPCBDHiENsnXgQfgWwE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=sajuUmE2CB/MME8iMYo8eOOszu+mIR1NqIjvDrzuO7CVV58AMwZmhj3obMDPGHng78SL13agr+H+zeiEUwTE9QegHMGGRmJvbsY3gn5Jx2qR4xVFdGah1SgQu+degYs5Hge0cNfvwol+QadflPY2mexoovSfjk4iy2lrXsjjF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PDVIduwg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PDVIduwg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bFWV/OP3CV7mhIExOnG5mhiTc2BNckmEP5LXFWoKl48=; b=PDVIduwgls+N+1oCrWYwkkvUkU
	47/q9pobho0+pe8hxAQfDF4azieMPn6AYBig88q0wUym3Lcy2DSltnRXD65fx9iZ3s19EWB+Jcxd5
	AzKkdhbJxz65EOAXFIg4O179BSNq9Z8k99kLT1cgbMdJcLQ51ACa46ywJ931JnC/GInTYnLYpGsLL
	jgpVZzw9rPyK8tBHXv7mgNxI3wOKoej+rXJIpacvjvqoErrTdUbYzlo/Wk39medSKqc1O3oGii7ZW
	GGm0uA+jrx82jxOz40ECj29xO4YVe2V1cJgX/dTbkwnHZlhcL9YJWr2ri7wiLLHwR+0WtsLohEV+9
	jtgCl2wQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56404 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6bLW-000000007UO-38ot;
	Sat, 28 Mar 2026 21:37:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6bLT-0000000ELuX-3iNP;
	Sat, 28 Mar 2026 21:37:27 +0000
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
Subject: [PATCH net-next 10/10] net: stmmac: move "TSO supported" message to
 stmmac_set_gso_features()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6bLT-0000000ELuX-3iNP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 28 Mar 2026 21:37:27 +0000

Move the "TSO supported" message to stmmac_set_gso_features() so that
we group all probe-time TSO stuff in one place.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c61ce1282368..d281793cd0f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4385,6 +4385,9 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
+	if (priv->dma_cap.tsoen)
+		dev_info(priv->device, "TSO supported\n");
+
 	if (!(priv->plat->flags & STMMAC_FLAG_TSO_EN))
 		return;
 
@@ -7432,9 +7435,6 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		devm_pm_set_wake_irq(priv->device, priv->wol_irq);
 	}
 
-	if (priv->dma_cap.tsoen)
-		dev_info(priv->device, "TSO supported\n");
-
 	if (priv->dma_cap.number_rx_queues &&
 	    priv->plat->rx_queues_to_use > priv->dma_cap.number_rx_queues) {
 		dev_warn(priv->device,
-- 
2.47.3

