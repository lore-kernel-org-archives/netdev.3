Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AD3D413C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025248; cv=none; b=lCST2Aej/CA3TOn8UI+vLDOkQlCx9+Z5xTglx3wqeUp6VcW6cjJE/gpvIDMjM8qv1bO7yMrpJmGJCgdJLomc8WXnx3wyStl+trjSVnnRQwaCRRfbKF3DhmGSm5KVhAUqd320MyCKcdmHpC4fTYzWnB3q0kZMGQCeeSFiVgzC6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025248; c=relaxed/simple;
	bh=twtQLpkDBFXnd0j5SCZ0Xw6QuCTVC6wROENiFSqmfws=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bHHJAzls7Dr87u0PLDJUz6DwAGEiP3DWtoDTBjooZ3yHVPzzc1BjQNzmoqRjsA8ylnnusvxITAPUEpDoqyVdRRJW5vvCmSapeFjP347IMY8oFyUPdTwwc2u4THOP7U+rtVYqK3P+2nSYE9j+ah9A8K/WDY3k3SBfjU5tAxu0Zy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wPNEA45K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wPNEA45K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aFMbYLcQ88OLBsB+fu1da0z95QDjjdhj0Q3/2+x4dgQ=; b=wPNEA45KAB8qFb0nJDQLWPYTc5
	ZrTF8jacEhT3/4fQCcECpP+bIlYDzSRgfYTJG6YnZm/sEJiWXoYpJZHtUIo9JlWGeMJVWRCoskEdQ
	9Ew4cLa/PtMtOahkL6R/+F2kd+HR7iKU7FKt228/Gf77f2Jjn3qMfzm6FOr/4u3GgSm1u28ccVUKz
	dfVUyJNO9sORQWrYbhr2BiTosoCbbbqhB1OSRZvQNv0TqyDDNerpjevnI+ja7mzyG943KcleCXba6
	84TpMNct+cgWixtwmzSaBus4Pqry46m6HsaGghpP3WncNtAI8LR/4QAVm36aZoNIqLRdZeH0OKUl/
	tw+vZO/g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36260 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0H-000000006LT-40Ly;
	Fri, 20 Mar 2026 16:47:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0H-0000000DfLp-0gIx;
	Fri, 20 Mar 2026 16:47:17 +0000
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
Subject: [PATCH net-next 2/6] net: stmmac: move first xmit descriptor SARC and
 TBS config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0H-0000000DfLp-0gIx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:17 +0000

Move the first transmit descriptor's SARC and TBS configuration
alongside the code which populates the first descriptor, which helps
to keep all the code specific to that descriptor together.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0586ab13cc48..3d94f632fca6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4799,6 +4799,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 				       0, last_segment, skb->len);
 	}
 
+	if (priv->sarc_type)
+		stmmac_set_desc_sarc(priv, first_desc, priv->sarc_type);
+
+	if (tx_q->tbs & STMMAC_TBS_EN) {
+		struct timespec64 ts = ns_to_timespec64(skb->tstamp);
+
+		tbs_desc = &tx_q->dma_entx[first_entry];
+		stmmac_set_desc_tbs(priv, tbs_desc, ts.tv_sec, ts.tv_nsec);
+	}
+
 	for (i = 0; i < nfrags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		unsigned int frag_size = skb_frag_size(frag);
@@ -4885,16 +4895,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
 	u64_stats_update_end(&txq_stats->q_syncp);
 
-	if (priv->sarc_type)
-		stmmac_set_desc_sarc(priv, first_desc, priv->sarc_type);
-
-	if (tx_q->tbs & STMMAC_TBS_EN) {
-		struct timespec64 ts = ns_to_timespec64(skb->tstamp);
-
-		tbs_desc = &tx_q->dma_entx[first_entry];
-		stmmac_set_desc_tbs(priv, tbs_desc, ts.tv_sec, ts.tv_nsec);
-	}
-
 	/* Set the OWN bit on the first descriptor now that all descriptors
 	 * for this skb are populated.
 	 */
-- 
2.47.3

