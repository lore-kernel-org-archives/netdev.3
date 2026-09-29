Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD834F3912;
	Tue, 29 Sep 2026 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685029; cv=none; b=bRz9n8+uI9ZDz5I1MDx2TbEK9zE1FEhgmkVk/yGbapk1zQrTywrcA0+pLdIAwvrQWCv+uZ7zHMjkcEk5RELVJMYwFmVVgjNF9odlJYyQy6BzS6uxAol1euKzb/srjoKezXD6uB0REGgdCtM3UsmjEp3djRxVR2/C571SiLyHdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685029; c=relaxed/simple;
	bh=Aq/tmaEKqwRFEfxw28bga1z9wMlgj3PNCZGYQOXUyO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JInZqC/T9MqBNuLUGbpdgOB/nTWsB+WWmIxRkCGrH2CRvBwunwN5uGXbyIp+ClJObHucccEa2Y0h3q3gXJYw9Gxn9Qeu01CsjjtKFnkc8FtV3FF6ZeDh9UmRDzqtPsGjoDpmV5M5cjs0GqwiHtVwUgugg7BX/F7lXpG0kTVb0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqBJnEEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqBJnEEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C231F000FF;
	Tue, 29 Sep 2026 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685028;
	bh=OdWMiN2jy8drBuF4VcdQsXqyjFoMik5zdyy8hzyUDhs=;
	h=From:To:Cc:Subject:Date;
	b=XqBJnEEbUt3oKV0abXmH2olHDmY+UxSrhGgS48apvMIfxMxajtovtT1nl8H3oacX4
	 Wxf8KGySXgKIMW6IlIfbfYBb9+yRU7EIYGZFMzJY5ynMgFtNlwodTCM4XlEIwuznNz
	 o9OcT8LSA5u7H2JuXdlSbikTAIY1LquP8XR8j64Gcxrl1L31EEFpLShB/fCHF/gFek
	 G+E+hSI0Xop/7Z4MnIvFRn+u6wFCDlsH/OQYvBUu4brLeep0G+7D0jCVuXfzqvSgRy
	 hWXEQiUlJINKA+FlIaDmxgYJGMJo93bjcBRcPxjh5mHhb9nRgg6y+hhCoxaNXAqnQp
	 YhGjNrTvQY4jA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Disable unsolicited checksum insertion for AF_XDP TX
Date: Tue, 29 Sep 2026 20:10:32 +0800
Message-ID: <20260929121032.20835-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac enables TX checksum insertion for every AF_XDP packet on queues
that support it. The driver does not implement tmo_request_checksum(), so
it enables the offload regardless of whether the application requested it
and ignores the requested checksum offsets.

Disable checksum insertion in the AF_XDP TX path. Applications must supply
complete checksums until the driver can honor AF_XDP checksum metadata.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8fe75b00974f..2db862f5abdb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2683,7 +2683,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
-	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	struct xsk_buff_pool *pool = tx_q->xsk_pool;
 	unsigned int entry = tx_q->cur_tx;
 	struct dma_desc *tx_desc = NULL;
@@ -2762,7 +2761,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		}
 
 		stmmac_prepare_tx_desc(priv, tx_desc, 1, xdp_desc.len,
-				       csum, priv->descriptor_mode, true, true,
+				       false, priv->descriptor_mode, true, true,
 				       xdp_desc.len);
 
 		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
-- 
2.53.0

