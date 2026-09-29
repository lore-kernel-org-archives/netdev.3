Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DC4F85D7;
	Tue, 29 Sep 2026 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685022; cv=none; b=CvPYnDqb6oeOQRRkmvN6++q8zo8w9hPBcBibZYjif6Y/PGB/T5pGQtrkrrm/hqcJ6Tc+BWw0cRmM6Hx5WWHI6h65UnzSOFt3c5Hd55xWuCDG0tvf1bcdfcBl/WMhWA0bMmP+J0+ZHaWcCU51GK+QkLGNYqeUx45bFZLfTxC7TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685022; c=relaxed/simple;
	bh=byrhGlL7jx/3ozk8ssV0pA7c4mj60o5DBeHZ/0z78rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfVRFoygnl7CTQ8zy4XqdByR1SDqYkoesHYImYi4okxp34xEu7JUzF88TFHLKCE9rukkIMrYy/6U4nXNAjNbPzhd+c0pXs9eYlp/+DK7Gt+uC+9Ymf+8gWfCPLc3ikUp8kNyICHyksCJdTfn98b8NuHwTvTVuA59FTg2gJSBurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICPG7vJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICPG7vJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DEB1F000FF;
	Tue, 29 Sep 2026 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685020;
	bh=QVSxnwIJqZkRreJjQfIbbsxCcEJwuhlGaTzg7HTiWVo=;
	h=From:To:Cc:Subject:Date;
	b=ICPG7vJnAzgTQM2w+rZppwMb+SCGx+5MYluqDgDo7PyScOsCn4Rr/0zi+A14DkDJf
	 BR+q9nX5vKv7YBXjFb7KQShAOujypriP/jyGlj7H0jMoLA1aA5y0/x5O/RFdicgu6M
	 wzFRCEgYfxCj14u0bTMTERETJUWIq2dikDw2O7IGNRdm1jRWMNTwDjFH35SELcfBXw
	 jh9SSsQZdozVlPUsFPEkUH/P4Q79ZpSKAjt5IpXiNVo2LRHKo+zAfoYpgzhimNHdbJ
	 bwopsB+IAvgauJa/ALSnSOd8s5w6DKCU2rkoBdn+mIohsKdPDx9OpLabR+OeFV5TNO
	 //DNVUdkT/77A==
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
Subject: [PATCH] net: stmmac: Disable checksum insertion for XDP frame TX
Date: Tue, 29 Sep 2026 20:10:25 +0800
Message-ID: <20260929121025.20821-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac enables TX checksum insertion for XDP frames whenever the queue
supports it. XDP frames carry no TX checksum offload request, so this
can overwrite a checksum already present in the packet.

Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
so that the packet is sent with its checksum fields unchanged.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Fixes: 8b278a5b69a2 ("net: stmmac: Add support for XDP_REDIRECT action")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24656b35350b..8fe75b00974f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5184,7 +5184,6 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 {
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
-	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	unsigned int entry = tx_q->cur_tx;
 	enum stmmac_txbuf_type buf_type;
 	struct dma_desc *tx_desc;
@@ -5229,7 +5228,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
 
 	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       csum, priv->descriptor_mode, true, true,
+			       false, priv->descriptor_mode, true, true,
 			       xdpf->len);
 
 	tx_q->tx_count_frames++;
-- 
2.53.0

