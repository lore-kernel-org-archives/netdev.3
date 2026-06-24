Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF752FC00D;
	Wed, 24 Jun 2026 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271245; cv=none; b=nI8M5bWtUhNkboMdKpGjOAMOCRhpaQw4va88DL9uOswueMawxdxQga57UrQVRBN6C/+daWsFEQhy3vdqvwn5GNyyQA1epC1ERwGSeBwUQ/9NIbgEGK42dj3eq8e6o5077Sf8RloRtvnEAjHqunkuMZFSVD4o0EdHR7AtqVLcTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271245; c=relaxed/simple;
	bh=bVhvdsE7iJId1aAgK5ulMRBNVaslOEgIqNuG9XVudCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+7Wn5dzTqRgzlt+vkDEDIJ6Y5Ucjhbm5c5Kdim1nCsQJSFJ7uKnyx5nPwcldXZ9HobWYE9CAu6D1lxkPfH9Pz6BNb2BA8YgVEWUkwA93b9pxaR1QemhTRVbl5ea0/OFXWi5K50S2+nO4uCJpF8uI9dH/Tncz5v5HSRFbkEEQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYqvEJ6p; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PYqvEJ6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tr
	IvHLVddtpalXT2naJBvmxYt/zfHGKS5GqixP175wE=; b=PYqvEJ6pUX5QCxbQMs
	RceDVggtxRo7IqZcmS9vR10iIbv9eK1vTlDtQZT/+j4C1l1qvqbZ77P/Y/xoVx8V
	VyfsVMrzVB26JgjoTAT0AUVJrl2L0kyfcHIlmQLNDRBVSv0IRoUqoVQguGNnUKgp
	fONe8wODYMiUUIGGACZkfMlCI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3v5TMTDtqTwEsDQ--.65159S2;
	Wed, 24 Jun 2026 11:19:42 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] net: meth: Fix skb allocation failure handling in RX init
Date: Wed, 24 Jun 2026 11:19:40 +0800
Message-Id: <20260624031940.2690439-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3v5TMTDtqTwEsDQ--.65159S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43Jry7Xr4rKr4DArWrXwb_yoW8Ar4kpa
	yvy3sYkr97Ar17t3Z5A3W7AFn8ZayFgFyrWFyS9w4FvrnxA345G348KFyj9r43CrWkWF13
	Kw47Zw17CFs8WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyCJkUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7g6vHmo7TM6KPwAA33

meth_init_rx_ring() does not check the return value of alloc_skb().
If the allocation fails, the NULL skb is passed to skb_reserve() and
then dereferenced through skb->head.

Add check for alloc_skb() to prevent potential null pointer dereference.
And unwind the RX entries that were already allocated and DMA-mapped
before returning.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Add error handling to free the resources that were already allocated. Thanks, Pavan.
 - Drop the fixes tag. Thanks, Andrew.
---
 drivers/net/ethernet/sgi/meth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index f7c3a5a766b7..bf5f47692023 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -228,6 +228,9 @@ static int meth_init_rx_ring(struct meth_private *priv)
 
 	for (i = 0; i < RX_RING_ENTRIES; i++) {
 		priv->rx_skbs[i] = alloc_skb(METH_RX_BUFF_SIZE, 0);
+		if (!priv->rx_skbs[i])
+			goto err_free_skbs;
+
 		/* 8byte status vector + 3quad padding + 2byte padding,
 		 * to put data on 64bit aligned boundary */
 		skb_reserve(priv->rx_skbs[i],METH_RX_HEAD);
@@ -240,6 +243,17 @@ static int meth_init_rx_ring(struct meth_private *priv)
 	}
         priv->rx_write = 0;
 	return 0;
+
+err_free_skbs:
+	while (i--) {
+		dma_unmap_single(&priv->pdev->dev, priv->rx_ring_dmas[i],
+				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
+		priv->rx_ring[i] = 0;
+		priv->rx_ring_dmas[i] = 0;
+		kfree_skb(priv->rx_skbs[i]);
+		priv->rx_skbs[i] = NULL;
+	}
+	return -ENOMEM;
 }
 static void meth_free_tx_ring(struct meth_private *priv)
 {
-- 
2.25.1

