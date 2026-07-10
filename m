Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857803DB310
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674439; cv=none; b=mYvm53vmO+U7UMi2uLPXKerqvz0th91OC5d8tNO7+dphrnb3nn8jkRykLfCED1dioj0gD3INtGVAovUiSQ4VuE4yT47uMFFvHwGdFwcisxpTly1PR8gMcMdXV/almhE1UMUBsY0Xm0YDcdKnciXg7ad2w6m0iNIeBlh1mb/XLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674439; c=relaxed/simple;
	bh=jHmMQll1ae+qhtp0WSZs4AaXAT0OmttERPZUaIEX7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRlhr7juhAYtvK/EYLJq1mH2uznlx+MVzptNz1A0STNGfguJbA7w8sVJWHprW5K+VR+qCz0HTanmzowTcfmXzZRV1frhELzRk0qhJnQSDZ+SZWvSNd7ugaHim9veTyms8NeqTuSwYzPOPtYhDFuhEZxFjeSFfDQSsoaLftObPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xsSEjR12; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xsSEjR12"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783674435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXP2s9du0gXWzN+9G9A/aXarqaLKl1ksW2pNWjl9v/E=;
	b=xsSEjR12R3IRD07Zjk/jDFreAGmdxN3wrXTDR3M5+KgG3GTZLarVoWQVnwInBIS4NlpNzC
	KPDO4nGRTYVDZmujBS3gU4EXcRxvj1awW0bXauPygKHulywdWIwTJhPXXKpKv3HOl1ZGS3
	oU6HthHGxxo73mC/VZK/4d/+egiW/5A=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v1 1/3] bna: fix use-after-free on DMA mapping failure
Date: Fri, 10 Jul 2026 17:05:22 +0800
Message-ID: <20260710090527.58354-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
References: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

If dma_map_single() fails in bnad_start_xmit(), the skb is freed, but
head_unmap->skb was set before the mapping attempt and is not cleared. The
producer index is not advanced, so later transmissions normally overwrite
the entry.

However, if the interface is brought down first, bnad_txq_cleanup() scans
the entire unmap queue, finds the stale pointer, and calls
bnad_tx_buff_unmap() on it. That function dereferences the freed skb in
skb_headlen(). Its zero nvecs count is decremented to -1, causing its
while (nvecs) loop to repeatedly unmap entries around the TX ring and
potentially hang cleanup.

Set head_unmap->skb after the first DMA mapping succeeds. This prevents the
stale entry from reaching bnad_tx_buff_unmap().

Fixes: ba5ca7848be0 ("bna: check for dma mapping errors")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4-pro[1m]
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 8e19add764db2..8b75004ba7c9d 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -3006,7 +3006,6 @@ bnad_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	txqent->hdr.wi.reserved = 0;
 	txqent->hdr.wi.num_vectors = vectors;
 
-	head_unmap->skb = skb;
 	head_unmap->nvecs = 0;
 
 	/* Program the vectors */
@@ -3018,6 +3017,7 @@ bnad_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BNAD_UPDATE_CTR(bnad, tx_skb_map_failed);
 		return NETDEV_TX_OK;
 	}
+	head_unmap->skb = skb;
 	BNA_SET_DMA_ADDR(dma_addr, &txqent->vector[0].host_addr);
 	txqent->vector[0].length = htons(len);
 	dma_unmap_addr_set(&unmap->vectors[0], dma_addr, dma_addr);
-- 
2.43.0
