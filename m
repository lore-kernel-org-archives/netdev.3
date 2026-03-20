Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD9382379
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025239; cv=none; b=F7u7H0172VMJq81BKxW+d5qPX6pga7V/yFzAgvxnmCXSTHqVr9hh6YSuaoKMvY4+6C23ui1Kc9Ffd0O2/kKr3QwOCcqn47MeqqZL9JCS80JF95/edtKKnK1CLSt4x13GeB/zRMLZ/wCGMwqiEtbRPiQgUJtF96io2sTqDq/zrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025239; c=relaxed/simple;
	bh=vz+YvwfCQXQhTzqpYlszLvhZOiNTDaXtSf4jH/nCXMU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=X4JGmhYmqxOnoqEwN1x3DA8Pq1livX49Zyb23O7JT5oFBDyl3SrFzh5cFrmfltBSPTKNHe2/kJkJMJy4IIWTRnqqC5I6T+EOvBinNmTTMq/HFKsgi9eOXVzQa8yH26zyfJ3m6JDUl1zEF2nVc+iw7isRmDOPoWpfkuWa09WxuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YWjHKvrh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YWjHKvrh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Az6gClnSnQ8RxIwpwc72dRxBvEVtZ9+6YP9Xv0iblKI=; b=YWjHKvrhkkOBk4yQEyCntMOlFU
	2Kf5FC6Go90A3Kdex5kZX7lwckqHksaMQMFME4XRxZDu0U3Ma1v1bKbbQw/s2rgO6TPWnb0PT+b7s
	w5mKjUZ/s+vq+QBWZLMjV9C+OwKN2tM083JKNRt3EXTNjGJR5nhjYJ15KgNhWXDsxO5q1zFt8cU5Y
	7vu9ZcjITmuWLSbggVSBVhGVkFif3jxGXfHKIFLQqG08UnaCP4xo8Jdn5HO92WQPBEYe/Zlj7sqW0
	g04K4qwZ+cHD6lKN1QTpNQYildx8FIMTXCJIw8T9028QPHB6WGoFNXDAteX4E0TLuQweYmhSOz7BJ
	dmwJ4ZlA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36256 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0C-000000006LG-3Eu3;
	Fri, 20 Mar 2026 16:47:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0C-0000000DfLj-0BLb;
	Fri, 20 Mar 2026 16:47:12 +0000
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
Subject: [PATCH net-next 1/6] net: stmmac: move stmmac_xmit() skb head
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0C-0000000DfLj-0BLb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:12 +0000

The skb head buffer handling is delayed in stmmac_xmit() until after
the skb fragments have been populated into the descriptors. The reason
is this code used to set the OWN bit on the first descriptor, which
then allows the TX DMA to process the first and subsequent descriptors.
However, as of commit 579a25a854d4 ("net: stmmac: Initial support for
TBS") this is now separated, but the comments weren't updated.

Move the code populating the first descriptor along side the jumbo code
which also populates the first descriptor. This gives a consistent
location where we populate the descriptor(s) for the SKB head.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 63 +++++++++----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5062537f79e9..0586ab13cc48 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4770,6 +4770,33 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		entry = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
 		if (unlikely(entry < 0) && (entry != -EINVAL))
 			goto dma_map_err;
+	} else {
+		bool last_segment = (nfrags == 0);
+
+		dma_addr = dma_map_single(priv->device, skb->data,
+					  nopaged_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(priv->device, dma_addr))
+			goto dma_map_err;
+
+		stmmac_set_tx_skb_dma_entry(tx_q, first_entry, dma_addr,
+					    nopaged_len, false);
+
+		stmmac_set_desc_addr(priv, first_desc, dma_addr);
+
+		if (last_segment)
+			stmmac_set_tx_dma_last_segment(tx_q, first_entry);
+
+		if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+			     priv->hwts_tx_en)) {
+			/* declare that device is doing timestamping */
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			stmmac_enable_tx_timestamp(priv, first_desc);
+		}
+
+		/* Prepare the first descriptor without setting the OWN bit */
+		stmmac_prepare_tx_desc(priv, first_desc, 1, nopaged_len,
+				       csum_insertion, priv->descriptor_mode,
+				       0, last_segment, skb->len);
 	}
 
 	for (i = 0; i < nfrags; i++) {
@@ -4861,39 +4888,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first_desc, priv->sarc_type);
 
-	/* Ready to fill the first descriptor and set the OWN bit w/o any
-	 * problems because all the descriptors are actually ready to be
-	 * passed to the DMA engine.
-	 */
-	if (likely(!is_jumbo)) {
-		bool last_segment = (nfrags == 0);
-
-		dma_addr = dma_map_single(priv->device, skb->data,
-					  nopaged_len, DMA_TO_DEVICE);
-		if (dma_mapping_error(priv->device, dma_addr))
-			goto dma_map_err;
-
-		stmmac_set_tx_skb_dma_entry(tx_q, first_entry, dma_addr,
-					    nopaged_len, false);
-
-		stmmac_set_desc_addr(priv, first_desc, dma_addr);
-
-		if (last_segment)
-			stmmac_set_tx_dma_last_segment(tx_q, first_entry);
-
-		if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-			     priv->hwts_tx_en)) {
-			/* declare that device is doing timestamping */
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			stmmac_enable_tx_timestamp(priv, first_desc);
-		}
-
-		/* Prepare the first descriptor setting the OWN bit too */
-		stmmac_prepare_tx_desc(priv, first_desc, 1, nopaged_len,
-				       csum_insertion, priv->descriptor_mode,
-				       0, last_segment, skb->len);
-	}
-
 	if (tx_q->tbs & STMMAC_TBS_EN) {
 		struct timespec64 ts = ns_to_timespec64(skb->tstamp);
 
@@ -4901,6 +4895,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_set_desc_tbs(priv, tbs_desc, ts.tv_sec, ts.tv_nsec);
 	}
 
+	/* Set the OWN bit on the first descriptor now that all descriptors
+	 * for this skb are populated.
+	 */
 	stmmac_set_tx_owner(priv, first_desc);
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
-- 
2.47.3

