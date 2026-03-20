Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1993D413C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025257; cv=none; b=MetJqHOfQq+2+l8y6SgErYRoq8avaaIwYeqQ2pv2675l0/ExRjgrWF2DAe5d7GrLUE89cLzTwYGDNTxbbcfbGbHdQpoT54s4WBR7wlojw02Co+K0kNNyymhQvVgDH1ye2H8MWjHZOt4YyqF6xTMDHnkpTmdl/Tj5Bck3RZBle5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025257; c=relaxed/simple;
	bh=PnW4jYVtvJFw0YCCeBsRsrjIrdcrLT+NkwzC2REjMjw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bLql/7fwerYyGkKwds6AOb3XOpyn4hL20m+6RtzBgWsFT1H7/RAEOXXNNay1k5hIfsmttokD9d68VB3kTKp4CSga3gnZDIxm0ch7l+lcDEFQy2EYpMLF72Ca/F+mURA+NCx5jW8xOEQ0s+RlTuLtdvH0g9JIGVteapGK+LvV75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RokbSFW1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RokbSFW1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eZ2KERFjyyQf8dxQP/UdKYTPcwvV1gn7poLNdNWhNwc=; b=RokbSFW1YJaX5DndiPpnSPZipq
	nvI5JqJpgi4FGAoenz7kBeFm5T8xsfWEvrKGq2BQ5vRSa7zqyut9pEqx5fF6h4VfjvfgUTb0aIcO8
	AwPi+xPfVhV19p9rsf9eZAHiOR0xTl5K4YesEAHm8dVd1EYblLAqvPqbomVuI5vtSWipJzjhDEp0R
	ccZqXDTrG0AlehxC/dxivmMJO48y1pHwarH0iNajxZGl0KKecUFOoedjmt5yjrTi4029LeXREtiH+
	c9ueZOdtsKIRvQFdw0DlJO96d/gpEhjvutmJeNLAwJySINj0WlHBjLMVNRhr3fjUzwu8NZIhjM72S
	t3xiNjmg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34054 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0S-000000006M2-27Lp;
	Fri, 20 Mar 2026 16:47:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0R-0000000DfM1-1itN;
	Fri, 20 Mar 2026 16:47:27 +0000
In-Reply-To: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
References: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/6] net: stmmac: move stmmac_xmit() initial variable
 init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0R-0000000DfM1-1itN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:27 +0000

Move tx_q, first_tx and txq_stats just before their first use.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d5e28ecf9fb4..95da2940cc3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4692,10 +4692,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	dma_addr_t dma_addr;
 	u32 sdu_len;
 
-	tx_q = &priv->dma_conf.tx_queue[queue];
-	txq_stats = &priv->xstats.txq_stats[queue];
-	first_tx = tx_q->cur_tx;
-
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
 		stmmac_stop_sw_lpi(priv);
 
@@ -4732,6 +4728,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
+	tx_q = &priv->dma_conf.tx_queue[queue];
+	first_tx = tx_q->cur_tx;
+
 	/* Check if VLAN can be inserted by HW */
 	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
 
@@ -4889,6 +4888,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
+	txq_stats = &priv->xstats.txq_stats[queue];
 	u64_stats_update_begin(&txq_stats->q_syncp);
 	u64_stats_add(&txq_stats->q.tx_bytes, skb->len);
 	if (set_ic)
-- 
2.47.3

