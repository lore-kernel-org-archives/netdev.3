Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593134E769
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846914; cv=none; b=ZlTBpXmcn6TyB0czCf/Y7AUtDYPXvVTK7OnzqJwE393vrRQHAsldoQ/BZuPgp47JmBMhBFaeNwYxqmNBH2gbDHYiYttkiNTesYljOMNjQ56G6DqJqCYfllrAE2/wy0WfZXD3xTXL1cuWvX3KLGZi0T0I2Rj5eDGdWwLB+UgKKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846914; c=relaxed/simple;
	bh=89S7RXLCdvV0VAu6qXIx0hL8TEZqfl3WoZi4VSo1XZ0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WZU/YvBKGhiN/j7C42u5sSleOSeuo889Nz/PJYbu//hO15MzvKO9i9f4dDCR3JlHoOCQ/3cCSKSBpvx10pE6UioVVA68k8jq0WxXSCofHTBwHSCRHEW2kDhDOSI3CPjRWw7AlxKBTxIN3SRAoGQGW1cyOLfsrPolcxJnV9f21bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=huenofak; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="huenofak"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OlklGKVHlcFAB5uyH7kRISqliehgzMx2P/pq4LHZAzw=; b=huenofak8dpnTr8zEus6V63xJQ
	3Njsd1gEi6OWqrqWW4/bNhpDjkJXSkQxmriaQybxhpMLeHSKDTw6g9L4W3Y8I30D60i+rcVLJfGUK
	7ZolMBRv80IW2k8W3lPg2eC3TsDuumu5WdaT2QUVSZpjpEXkxNHQYAeQaZPAOk2QSMsR8PWzKvsfr
	YRNKji9QFlmyn3faAW6QMdgDkGnGbIhZwva4FNnas/KA7bRn8iqDnyy0NgMaSE/fPqu2QABXMYJm5
	Ur1FsItAt67MBk5norP7SjJu/naWB2lclnnyhlEl7jjSKyZBhyUUJY0S0DusPVnCqlVz/QrYU7qQ6
	Ivuhb6Cg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51426 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuUJv-000000003zS-1iAA;
	Mon, 23 Feb 2026 11:41:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuUJu-0000000AfEO-2kPP;
	Mon, 23 Feb 2026 11:41:46 +0000
In-Reply-To: <aZw86hpjQ-3w3xqJ@shell.armlinux.org.uk>
References: <aZw86hpjQ-3w3xqJ@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/2] net: stmmac: use circ_buf helpers for
 descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuUJu-0000000AfEO-2kPP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Feb 2026 11:41:46 +0000

The stmmac descriptor queues are circular buffers, operated as far as
the hardware is concerned as either a ring, or a chain that loops back
on itself. From the software perspective, it forms a circular buffer.

We have a few places which calculate the number of in-use and free
entries in these circular buffers, for which we have macros for.
Use CIRC_CNT() and CIRC_SPACE() as appropriate to calculate these
values.

Validating, for stmmac_tx_avail(), which uses CIRC_SPACE():

  dirty_tx = 1, cur_tx = 0 -> 0
  dirty_tx = 0, cur_tx = 0 -> dma_tx_size - 1
  dirty_tx = 0, cur_tx = 1 -> dma_tx_size - 2

dirty_tx passed as end, reduced by one. cur_tx passed as start.
Output on sane computers is identical.

For stmmac_rx_dirty(), which uses CIRC_CNT():

  dirty_rx = 1, cur_rx = 0 -> dma_rx_size - 1
  dirty_rx = 0, cur_rx = 0 -> 0
  dirty_rx = 0, cur_rx = 1 -> 1

dirty_rx passed as start, cur_rx passed as end. Output is identical.

Same validation performed on the is_last_segment calculation, which
also gets converted to CIRC_CNT().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 ++++++-------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a2a0985e8c37..3277aecc5454 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -14,6 +14,7 @@
 	https://bugzilla.stlinux.com/
 *******************************************************************************/
 
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -355,14 +356,9 @@ static void print_pkt(unsigned char *buf, int len)
 static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
-	u32 avail;
 
-	if (tx_q->dirty_tx > tx_q->cur_tx)
-		avail = tx_q->dirty_tx - tx_q->cur_tx - 1;
-	else
-		avail = priv->dma_conf.dma_tx_size - tx_q->cur_tx + tx_q->dirty_tx - 1;
-
-	return avail;
+	return CIRC_SPACE(tx_q->cur_tx, tx_q->dirty_tx,
+			  priv->dma_conf.dma_tx_size);
 }
 
 /**
@@ -373,14 +369,9 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
-	u32 dirty;
-
-	if (rx_q->dirty_rx <= rx_q->cur_rx)
-		dirty = rx_q->cur_rx - rx_q->dirty_rx;
-	else
-		dirty = priv->dma_conf.dma_rx_size - rx_q->dirty_rx + rx_q->cur_rx;
 
-	return dirty;
+	return CIRC_CNT(rx_q->cur_rx, rx_q->dirty_rx,
+			priv->dma_conf.dma_rx_size);
 }
 
 static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
@@ -4571,8 +4562,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* If we only have one entry used, then the first entry is the last
 	 * segment.
 	 */
-	is_last_segment = ((tx_q->cur_tx - first_entry) &
-			   (priv->dma_conf.dma_tx_size - 1)) == 1;
+	is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry,,
+				   priv->dma_conf.dma_tx_size) == 1;
 
 	/* Complete the first descriptor before granting the DMA */
 	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
-- 
2.47.3

