Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB3253951;
	Sun, 30 Aug 2026 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788062877; cv=none; b=u2/80R2nwlIozP21JYJe8UZMzYL4GD54PuhorIAmMoK329YLT3PzuzFsM10fdSFzGgU9VQ7uWCPFEv1gm8tZz4dc0nzUGrb1oN3kikDkfgikDqDb5D9l7PYy+5biWCxJMJOcgDFz4OnjSfF/4gMgCc6G4uBjpFtWB0cp8fcYask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788062877; c=relaxed/simple;
	bh=Og9AA8JvfHofV9UpuikqXPWM3acwnevOvqG4xcvy6tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A3VcT7fhN/N2MRyMSxKxeD+eJ/sboX8f+ahEczf+EOSgQZaZqkWVNAnmgoLh4yF/bHCZS0SFEH1yc5RTjO6iqZFpQCvhGF35MtxF7uZJWfQjkX86P2cH99cjX17vW24EC4Esn9iR6ijCW6YyDhsm5bpF7rqthyL3ee5+owVe1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BFRHuCU6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BFRHuCU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=C1
	+JnvyqaVA+UAjiMQvWP+cLjPrU80LwmL6ro4MPd+8=; b=BFRHuCU6EfZoRw4NLw
	zm7V24/mCcsuoeGXPVWFqIdA+zkXcY9yuHXKCyuAUZ8t9YBbPWh/fJmGZTUbdeI3
	szwyGukcrNpTUVpzmq4d9hfWihImq1Pf4z69dD4o7ckZL0hTwIejRCV03Y3QDk8F
	anWVoh/CO+b/sNWMDzypC0MXU=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHZPI1rJNqKOTDNg--.46715S2;
	Sun, 30 Aug 2026 12:06:26 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH] net: stmmac: fix NULL pointer dereference in tx/rx resource cleanup
Date: Sun, 30 Aug 2026 12:06:08 +0800
Message-Id: <20260830040610.1156008-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHZPI1rJNqKOTDNg--.46715S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1xAry3JF4fAF4DWw1xKrg_yoW5Kw47pr
	ZFk3yjy34Utr13Ga1DJw48Xa45Ja95tr43WayIgwnxZF4ayryvgF4jvryjkr95CrykZa4x
	KrZ8CF9xCr18JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2UDJUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0QK65mqTrELcIAAA3k

From: Ding Hui <dinghui@lixiang.com>

The DMA descriptor ring allocation in __init_dma_rx_desc_rings() and
__alloc_dma_tx_desc_resources() is split into multiple steps, each of
which may fail and return early while the per-queue cleanup paths still
call the free helpers for the partially-initialized queue.

When an intermediate allocation fails, several ring buffers may never
have been allocated and their pointers remain NULL:

  - rx_q->buf_pool can be NULL if its kzalloc_objs() failed, yet
    dma_free_rx_skbufs()/dma_free_rx_xskbufs() dereference
    rx_q->buf_pool[i] via stmmac_free_rx_buffer().

  - tx_q->tx_skbuff_dma can be NULL if its kzalloc_objs() failed, yet
    dma_free_tx_skbufs() dereferences tx_q->tx_skbuff_dma[i] via
    stmmac_free_tx_buffer().

  - tx_q->tx_skbuff (aliased with tx_q->xdpf through a union) can be
    NULL if its allocation failed while tx_skbuff_dma succeeded; in that
    case dma_free_tx_skbufs() does not bail out and
    stmmac_free_tx_buffer() dereferences tx_q->xdpf[i] / tx_skbuff[i].

Guard all of these accesses with NULL checks so the cleanup paths are
safe to run on a queue whose allocations failed part-way through.

Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")
Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")

Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2fc89176654..71c6a941fb91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1728,7 +1728,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 					 DMA_TO_DEVICE);
 	}
 
-	if (tx_q->xdpf[i] &&
+	if (tx_q->xdpf && tx_q->xdpf[i] &&
 	    (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX ||
 	     tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_NDO)) {
 		xdp_return_frame(tx_q->xdpf[i]);
@@ -1738,7 +1738,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX)
 		tx_q->xsk_frames_done++;
 
-	if (tx_q->tx_skbuff[i] &&
+	if (tx_q->tx_skbuff && tx_q->tx_skbuff[i] &&
 	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
 		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
 		tx_q->tx_skbuff[i] = NULL;
@@ -1761,6 +1761,10 @@ static void dma_free_rx_skbufs(struct stmmac_priv *priv,
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	int i;
 
+	/* buf_pool may not be allocated if alloc failed early */
+	if (!rx_q->buf_pool)
+		return;
+
 	for (i = 0; i < dma_conf->dma_rx_size; i++)
 		stmmac_free_rx_buffer(priv, rx_q, i);
 }
@@ -1802,6 +1806,10 @@ static void dma_free_rx_xskbufs(struct stmmac_priv *priv,
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	int i;
 
+	/* buf_pool may not be allocated if alloc failed early */
+	if (!rx_q->buf_pool)
+		return;
+
 	for (i = 0; i < dma_conf->dma_rx_size; i++) {
 		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
 
@@ -2097,6 +2105,10 @@ static void dma_free_tx_skbufs(struct stmmac_priv *priv,
 	struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[queue];
 	int i;
 
+	/* tx_skbuff_dma may not be allocated if alloc failed early */
+	if (!tx_q->tx_skbuff_dma)
+		return;
+
 	tx_q->xsk_frames_done = 0;
 
 	for (i = 0; i < dma_conf->dma_tx_size; i++)
-- 
2.34.1

