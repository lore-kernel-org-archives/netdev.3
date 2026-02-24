Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3811369988
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923724; cv=none; b=l51ZVzu6uFd/jpQ3qJF5SffpJx6DfH5SYf9N5thVydw29vEtM73FLB2Dvyg4uxwVYb/WnFpgDUpz1rgXNF6TQ/QklUsMppzcpX05M4InQylJXlGvE0LwKJs06CqYWmjFRYEGyG7NzuSpeypCZTB7SdMpUUd3J92M2YCiEbZ0lHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923724; c=relaxed/simple;
	bh=ci6K+P9Z1zNijD/nyDK4mq3ABwcFD/1pLpd/sO7WEA4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=g063G6ImzN/REnL036dv+sxQ9o8OQde2QMOoKlHMd1jnd3DZDjTxsQdDAETIJfY+qjWi2QU3rqci+mgec//JvbCtlnLSBN6RrpYf2VJgZtqMe/GHWntkLv8jOlsxS3IlH4BP8XJvUK5f6w+imR09niJjCsSiI5ni0y6++T6CQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mw2ib0Hu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mw2ib0Hu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wrYNaMOH0TzghKNkY2gl5+fHgiHnouoR8L4MzPIrLQs=; b=mw2ib0HuC9E0Zqjnf7ey4YyaQ0
	PbfUPNlapr6uP9hLfkxAQ/qPrEd4gLN+1dWbLlDINtrha5GqZTMrC2lGIuDzkWyt6KUpCHeqloYuj
	4zWcsBsUhnsDovNGy1CNfpGRpK/+2FcNjcgGruVjnHYr06idMjGpATU9vyzUX4q9E1QqBm/3ihHO3
	OPcYErNmn6kNVALpk4Yn22tf8bFSmXTD/QjWIJlDtKZV4Uh+wDMxN9Oo2i230Z8tQHNEnzaDfWNkg
	/x2f4c33cDvdOYAXziQwelaCp6p4Tpx3wjHaf8eE0Y9UrkWMylONrKxXzvebRF99o0SQ5UZzXyPJv
	8tmWV0CA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41980 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuoIl-000000004yS-3zCH;
	Tue, 24 Feb 2026 09:01:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuoIl-0000000Aouz-0ttb;
	Tue, 24 Feb 2026 09:01:55 +0000
In-Reply-To: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
References: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 2/2] net: stmmac: fix transmit interrupt
 coalescing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuoIl-0000000Aouz-0ttb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Feb 2026 09:01:55 +0000

The accounting for transmit frames does not count the descriptors
correctly. It uses:

	tx_packets = (tx_q->cur_tx + 1) - first_tx;

however, these are indexes into a circular buffer, so cur_tx can be
less than first_tx, and when that happens, tx_packets becomes a very
large unsigned integer. When this is added to tx_q->tx_count_frames,
it has the effect of reducing the count of frames, possibly causing
it to also wrap to a very large unsigned integer.

Fix this by using CIRC_CNT() to calculate the number of descriptors
used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2d74fe98ad61..baf2ff577f45 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4503,7 +4503,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* Manage tx mitigation */
-	tx_packets = (tx_q->cur_tx + 1) - first_tx;
+	tx_packets = CIRC_CNT(tx_q->cur_tx + 1, first_tx,
+			      priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
@@ -4781,7 +4782,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * This approach takes care about the fragments: desc is the first
 	 * element in case of no SG.
 	 */
-	tx_packets = (entry + 1) - first_tx;
+	tx_packets = CIRC_CNT(entry + 1, first_tx, priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
-- 
2.47.3

