Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922929;
	b=iHhiRN9pFkRd6u4VWpIWt3wD6jin5gz1vAnjEYbfxPs/y39N49tzQNju367MNvviqj/D
	 zyMw62sLmB9zzxp4G6hw2kmKAJW/DKFitlp9Qbwx5ang7V6RnjgzhnB4+pcg+5nG9Jbqu
	 EoBha1rGw+U6QBPHj8DHEh4kwSnYbrwmXwrRbGp6a0qeH6A+HoonCvXxbtAudrUia14Mz
	 HHN3usvILf75OWg5K5HD4y3TQ9vbPcKDMPmadgSWV51MF2MR2vqax9igrhT2qFzQzcN1c
	 11q0V2kwdrEdnJcNX+dbYo2OXHknJ+uqqyHikaxNsxD3h0NiXXFT4ttPMNn5diZHRhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922929;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OyUY9uNJwoHV4iwApdNFM3PeLlmsfhKj3ed2bSvE2TY=;
	b=BxIKoRQb4sPJ9cLh7rsagl3pd977LmndA5Se60w+pJ2DEP90v9kVd+D/xupM79bET8zf
	 7c8FupuJnPhGAR3W1qM2T7fNZB8cqRGKpJmdkIys/MqoCEoibDa6+roedDxl3G9PPhfQF
	 79yK4viXngPL7mEw15W2wqoUFMNH161m/r3YlpBFbVXc9aqHwMvBtJ5R7wkkAroXjrHDS
	 cw3eQgitIlqoSUmLtZ0K8dczAcwlLUoield1u6g7aFCQrOr34MpI7cMdlSgx/SDI0pk2/
	 gxzg3Ivx3rLmswJzKLGp5MrNEY32oK47uUNXX7Cvy9DOE2XerIU+gOULDel6/OZ5PLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="hHrcQd5/";
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA81606A31F;
	Sun, 25 Oct 2026 10:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA81606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hHrcQd5/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Oy
	UY9uNJwoHV4iwApdNFM3PeLlmsfhKj3ed2bSvE2TY=; b=hHrcQd5/laq1KlukWR
	M4UFMjNMZxEpoJuMpnJKhIe+I6PqJJ4rUzowx7dBJTh9JPujljRuDv40k91iWFbt
	RKMU1B8279Yfc880IN0/hzFVlo7t6uIV9CZ4K7iyo1WX+cOAKThdBfT4UD3nQhdE
	gg95+pDxebit22yFy6NUYnmfk=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_26u1N1q7fwbCQ--.3918S3;
	Sun, 25 Oct 2026 18:07:01 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
	liuxuanjun@lixiang.com,
	zhoujing3@lixiang.com,
	fujiahui@lixiang.com
Subject: [PATCH net v5 1/2] net: stmmac: honor allocation flags when initializing RX buffers
Date: Sun, 25 Oct 2026 18:06:35 +0800
Message-Id: <20261025100636.613670-2-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025100636.613670-1-dinghui1111@163.com>
References: <20261025100636.613670-1-dinghui1111@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_26u1N1q7fwbCQ--.3918S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4Dtw1rZrWxWr17CFyDWrg_yoW8Xrykpa
	9rAa409r1kXr1xJw4DGw4xZFW3Ka4UKrWUuw4xJFW3Za97KF90qryYqFy5Xr17urW8ZF4a
	qr1j93s8uF1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_4SrUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0gZ4pGrd1MaxaQAA31

From: Ding Hui <dinghui@lixiang.com>

stmmac_init_rx_buffers() accepts allocation flags but stopped using them
when RX buffers were converted to page_pool. As a result, callers passing
GFP_KERNEL still allocate with GFP_ATOMIC | __GFP_NOWARN and cannot use
reclaim to satisfy an allocation.

Use the supplied flags while retaining GFP_DMA32 for hardware without
64-bit DMA addressing. This also allows the resume path to allocate
missing RX pages with GFP_KERNEL.

Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")
Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
Changes in v5:
- Split this fix from the resume fix as requested.
- Add a Fixes tag for the page_pool conversion.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b20e5038eead..f5ae12208e85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1688,7 +1688,7 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
-	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+	gfp_t gfp = flags;
 
 	if (priv->dma_cap.host_dma_width <= 32)
 		gfp |= GFP_DMA32;
-- 
2.34.1

