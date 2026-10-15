Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AD4F6499
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063565; cv=none; b=TMSBRmwaDJ6ETfH2uKPljRWEZihAZAnInFgBhmSu1S6pyyUYAEoH3A5/si6Qi3/V10bfs5ho+ej/GowdHTAzfXAUguStLMsBcoIlLxFlOalo6cjNocSX6l5cR8415/b8EwSDpoa2Fn6zjW1jLncJzhD8LQuomzuCgIw52txyWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063565; c=relaxed/simple;
	bh=UPraC2ZUHkoF8Nfx0n4t5W+A82QdxCAdg3zLQNG1j4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqsicKIpIgAz4B+kXWeVRtR8pGCnx8HcjUGBeJ0DxfIjmQQQc+TmINEm1kDhHeQD7yJCWmpc2Q63yko/UZCk0Jk9hHNvmRFtSxcz5RShCHBikYcR78MF4EKOKXdYHUatP0AAJnvQPLLhVq56stCElkkbgGOIVXXzcaaTwNdV1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hEWXsBzZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hEWXsBzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ir
	DLkuEmIxis+kWy0Pk+JokcZYIiUeB3kJUm7BL7l3I=; b=hEWXsBzZ9YeLLYo3JA
	9RK91C3v3/UsQK3sGqEylcLx/0UbbqtUYbSyLjZObJDeRAnfd+ZTsYltRPeSszNg
	IoJhEijWxiueOxfQJVYlg2erj11fUP6KSWCin7qUHcIgPTKvi8nsDkAZAOePbRTz
	S6bE1LGkClk2fjd1MOazqsl9Y=
Received: from caesarPC.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3X0vht9BqzMwBAQ--.38709S2;
	Thu, 15 Oct 2026 19:24:18 +0800 (CST)
From: Xiaochuan Li <chuanx2070@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Xiaochuan Li <chuanx2070@163.com>
Subject: [PATCH] net: stmmac: remove STMMAC_DOWN check to avoid irq storm
Date: Thu, 15 Oct 2026 19:24:15 +0800
Message-ID: <20261015112415.437900-1-chuanx2070@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0vht9BqzMwBAQ--.38709S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF43Cw1DtF45tFWfWFyxuFg_yoWrAFy8pF
	ZrAa90vrWvqrnrXa1DGr4UZryYya4Syay5W3Z7Jay7Ga1akryYqryrtFyjqF1fCFWUWw1S
	y3yYvr43u3W7Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxCzNUUUUU=
X-CM-SenderInfo: pfkxt0j0sqlii6rwjhhfrp/xtbC7QL012rQt+LyPwAA3u

The stmmac interrupt handlers return IRQ_HANDLED immediately when
STMMAC_DOWN is set, without reading or clearing any device status
register.

STMMAC_DOWN is set by stmmac_reset_subtask() before dev_close(). The
device interrupt is level triggered, so if it fires after STMMAC_DOWN
is set and before the IRQs are masked/freed in __stmmac_release(), the
pending status is never cleared, the line stays asserted and the handler
is re-entered forever. Since the handler returns IRQ_HANDLED,
note_interrupt() never flags the IRQ as spurious and never disables it,
resulting in an interrupt storm.

Signed-off-by: Xiaochuan Li <chuanx2070@163.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..520c1b8d736c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3091,6 +3091,13 @@ static bool stmmac_safety_feat_interrupt(struct stmmac_priv *priv)
 
 	ret = stmmac_safety_feat_irq_status(priv, priv->dev,
 			priv->ioaddr, priv->dma_cap.asp, &priv->sstats);
+
+	/* Status is read/cleared; do not escalate to a global error reset
+	 * while the interface is going down.
+	 */
+	if (test_bit(STMMAC_DOWN, &priv->state))
+		return false;
+
 	if (ret && (ret != -EINVAL)) {
 		stmmac_global_err(priv);
 		return true;
@@ -3113,6 +3120,12 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
 	rx_napi = rx_q->xsk_pool ? &ch->rxtx_napi : &ch->rx_napi;
 	tx_napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
 
+	/* Status was already read (and clear) above, so the irq line is
+	 * deasserted, Drop the event while the interface is going down.
+	 */
+	if (test_bit(STMMAC_DOWN, &priv->state))
+		return 0;
+
 	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
 		if (napi_schedule_prep(rx_napi)) {
 			spin_lock_irqsave(&ch->lock, flags);
@@ -6408,10 +6421,6 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	/* Check if adapter is up */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return IRQ_HANDLED;
-
 	/* Check ASP error if it isn't delivered via an individual IRQ */
 	if (priv->sfty_irq <= 0 && stmmac_safety_feat_interrupt(priv))
 		return IRQ_HANDLED;
@@ -6430,10 +6439,6 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	/* Check if adapter is up */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return IRQ_HANDLED;
-
 	/* To handle Common interrupts */
 	stmmac_common_interrupt(priv);
 
@@ -6445,10 +6450,6 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	/* Check if adapter is up */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return IRQ_HANDLED;
-
 	/* Check if a fatal error happened */
 	stmmac_safety_feat_interrupt(priv);
 
@@ -6466,10 +6467,6 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 	dma_conf = container_of(tx_q, struct stmmac_dma_conf, tx_queue[chan]);
 	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
 
-	/* Check if adapter is up */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return IRQ_HANDLED;
-
 	status = stmmac_napi_check(priv, chan, DMA_DIR_TX);
 
 	if (unlikely(status & tx_hard_error_bump_tc)) {
@@ -6492,10 +6489,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	dma_conf = container_of(rx_q, struct stmmac_dma_conf, rx_queue[chan]);
 	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
 
-	/* Check if adapter is up */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return IRQ_HANDLED;
-
 	stmmac_napi_check(priv, chan, DMA_DIR_RX);
 
 	return IRQ_HANDLED;
-- 
2.43.0

