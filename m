Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA84429CE6
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359828; cv=none; b=DGkVcM/TnzRWowwZZHDKGB9uwWE5hrdkk1bhDkAzxqrA19VlSzEpdwVy6yr7kPF7f9B64EzClqgHQDWO5vk1VtCaYaJyZDtxGmdznJRPlIpuqcOJT5T/tnLXuHUOgHoncC9lsKlOO5Xf3bITmwC8jdKUnw1qYAv+I66xWroUkzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359828; c=relaxed/simple;
	bh=7auDdSSyjkM8QFaFISfuAn/uxV25wF385XVoTV6y2GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCAxUy1Xp55J0ewrI5Z1L2CmG/G5MLiWh3eIbS7MhprNUioR5JkgmoPwO8lj0s+x+pFdOE3BvY67/+S043QHgPuwguLl37xglk9Dv1AFjVk0rDXt+AdBkP5X8tGf2MAXBYytwAdiosFhj5fWn85y/ZAmPEHDMxMmSQiGjloYnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs7JC9t6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs7JC9t6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28341F0089B;
	Wed,  7 Oct 2026 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359815;
	bh=LrmP4mHEy+uoxyVkNy3FvcZeLaFze0cfqYd+D6SOe2c=;
	h=From:To:Cc:Subject:Date;
	b=Fs7JC9t6JNj1mxQF6p5Pth6qgon+I63EnZExeYNSFkIM4KjgqI6Xyv9UF2/BEy9cF
	 HoOUQLmlgpBovyg8axMfC2KmQDeTXaONu4VLh7XF7jHQP3haeBBiy7OfCXV03FZ0Md
	 DOVvkTgerfmQ9XGHOoB1ar4ZRWfViSoAJDQN6+UFVQAhkAMLCidiXHFocHN9jpjGbn
	 maaw0snG4OaiDgwJV8GzMUt2+ysnVAsxobvcI1pVIVnh2xzfKtJOFvHX7mzTq9MALb
	 XhP53nNMjoprJBdYmR8g3ibi499JnJ0Ok8qlwUCLz1Z+ZD+qbGgZPE9AxiTBZVKeRu
	 f3F8sQ6jT8FrQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net] bng_en: pad short frames before sampling nr_frags
Date: Wed,  7 Oct 2026 09:56:49 +0200
Message-ID: <20261007075649.468033-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnge_start_xmit() samples skb_shinfo(skb)->nr_frags into last_frag,
and stores it in tx_buf->nr_frags, before calling eth_skb_pad().

If a nonlinear skb is shorter than ETH_ZLEN, __skb_pad() calls
skb_linearize(), which pulls the frags into the linear part,
releases the frag pages and sets nr_frags to zero.

bnge_start_xmit() then uses the stale last_frag to fill TX_BD_CNT()
and to walk skb_shinfo(skb)->frags[], DMA-mapping pages the skb
no longer holds a reference on, and sending their content twice.

Fix this by calling eth_skb_pad() before nr_frags is sampled.

Found by Sashiko while reviewing the similar bnxt_en fix.

Fixes: bd5ad9c052c8 ("bng_en: Add TX support")
Link: https://lore.kernel.org/netdev/179134695789.434549.53526916334276884@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 7d45e057f2e82069b3b54936a02e4c955b2787c8..472b02cc43b3c1174e061906b730c0edf9478846 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1490,6 +1490,9 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	if (eth_skb_pad(skb))
+		goto tx_kick_pending;
+
 	last_frag = skb_shinfo(skb)->nr_frags;
 
 	txbd = &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
@@ -1513,9 +1516,6 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(skb->no_fcs))
 		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
 
-	if (eth_skb_pad(skb))
-		goto tx_kick_pending;
-
 	len = skb_headlen(skb);
 
 	mapping = dma_map_single(bd->dev, skb->data, len, DMA_TO_DEVICE);
-- 
2.53.0

