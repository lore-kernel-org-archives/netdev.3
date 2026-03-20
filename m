Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2973DB653
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025268; cv=none; b=oR8N9HwUA6tju+SNP2MUfh1yxyF5bILQgJFE3daVAOfprtds6kAs++wwUq1dLcWRWP8qPbcAi4B/YbBbEm5PdWeBvZr/UZP2Y0wnEKOJvfqFHaENc8ScK4HL0xXwGCmXcN+Zj6KM3mvPpDubh7j4RLqdDO46cDUXJ65lwC/ns7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025268; c=relaxed/simple;
	bh=ROcBd8isQpLv4XnlpTsJYgrp88IQPEBgzzGLjsD0DuQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dxMpMyjYSZpKmyJxqaZ/EX2ZTsWhX3BRj91h2bz12SbeB64JgXRvf4o0my2peTpWdVBFbeIQPU2zVW+IYqKmyHAVyZowFVc2RR3c30Nr3sQSX/L9FQzbYpbMLe4u4zTF6hBhaClHYr8/NWyk7aN4v+M+naWN5OOAUazL/DOSUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X9IYAb1l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X9IYAb1l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=trtMh5tpUVzbQlNs5rAVXgjGUuISvp2FaLD2tKfE614=; b=X9IYAb1l3DHtrfU6q4Jf5Mccm+
	hUl50bp/AsB7tCOcikmul3bsRgwghUIrFrI3i5H0qcqWYwfpucvfgZ2SKe9XHkvNjOIAO/kllypUp
	W/vTcueRs3rm8XRc+h96OuPMmBthxzYQDwKYhnenb6gIxAsAzouV0ys9/6nDnkP34kwaBYtnuGH83
	5DX1HreGTnn/E4WN9rNdKft3TiOG+7/xI8fNAEgyJWmoXCNvNbMohPiJDKteumvvEyJI5mH4mlH1x
	ZkwOhizsLX7WzEOa3DOiNCgjzvd2yQqoGJ/k8VyzedCVnAuKs+wjlxFw/DgDbB7UjrEaSO0fRgEaq
	5Jk3q5bg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34184 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0d-000000006Mh-0qBS;
	Fri, 20 Mar 2026 16:47:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0b-0000000DfMD-2hrD;
	Fri, 20 Mar 2026 16:47:37 +0000
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
Subject: [PATCH net-next 6/6] net: stmmac: elminate tbs_desc in stmmac_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0b-0000000DfMD-2hrD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:37 +0000

There is no need to have a local variable for tbs_desc, we can do the
conversion when calling stmmac_set_desc_tbs().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a733249c3f9b..c01a10e982b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4685,7 +4685,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	int gso = skb_shinfo(skb)->gso_type;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_desc *desc, *first_desc;
-	struct dma_edesc *tbs_desc = NULL;
 	struct stmmac_tx_queue *tx_q;
 	int i, csum_insertion = 0;
 	int entry, first_tx;
@@ -4809,8 +4808,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (tx_q->tbs & STMMAC_TBS_EN) {
 		struct timespec64 ts = ns_to_timespec64(skb->tstamp);
 
-		tbs_desc = dma_desc_to_edesc(first_desc);
-		stmmac_set_desc_tbs(priv, tbs_desc, ts.tv_sec, ts.tv_nsec);
+		stmmac_set_desc_tbs(priv, dma_desc_to_edesc(first_desc),
+				    ts.tv_sec, ts.tv_nsec);
 	}
 
 	for (i = 0; i < nfrags; i++) {
-- 
2.47.3

