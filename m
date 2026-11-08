Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172553;
	b=peQxNroTYlkHRHcJqVNfZKAl7aM8AVbTuoZJN+D1H31gnTIS//NZuEkE3VK7Eb8DpYif
	 rIodETS64fRt7X6JMKBbAj0BD5kmMdk/ZlHQ02imSYSpUa7jQaxkZFeoRsXMTUoEn0hI/
	 Y7ZoteTmebVd//SniKiN3y2DBDjmfrpRAM4HMuAJZ8H66mpyp7gQGzpjJ4rF8yUIgkUNt
	 IWHOtI9LXTCwDhU/9r7vHTrdf2KIVh7SCfmzIHIkqBSl6oAt4vGQVNIa7LtkcHW40K23r
	 gsVYr5Kqyzo8sCiHoIKtycT4duHOCLvt46t79dhDHBnk+ekc8M7qdcAwuOAkb/Ag8aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172553;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zJIdsI9GQClsRIIG1G+ICuk2dQgUV+nU+vebLgHoSJM=;
	b=PnjmgSCT0EZdMmOtgTRkrgusKp4rNSS2u0NUu6nG8mGNpIX0wh0KNW/Dstfm/YHIttqI
	 gg2eKJSbQ3njx8a1QU0iI8I3BTR3vwAZTL8d7m5daZnXnAOXdfoSKjkB7WLo4lAAL60HK
	 MHSI+xudW3RLqUKnPawiwWEWLl3QcQf4Wwj5l9MFMQKxqLOg4ePX2HfuCDpabLA8bhzB7
	 JCq/H+sGLwYV4SbRMeaxVMQV2JakZhQpAHnhTOFvJCF6flUpJX4E8Z3PzdXNlWjb8NYJo
	 O6d6EOaj3lq8LWhuBSLPc7CK4UvPeKvh6jL2xsF2KYcKQdVtg6H4epzUzq9SsYxGu5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=WNo9O6Or;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E99606A326;
	Sun,  8 Nov 2026 21:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E99606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=WNo9O6Or
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794172536; bh=zJIdsI9GQClsRIIG1G+ICuk2dQgUV+nU+vebLgHoSJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WNo9O6Or91J3mkC8W5nuerD6BmPr9ZcbTvoGwd1PfpF0T1HI2f/zUmU0/XtosL3Zs
	 Pia5iOwDY14Mp75ONZa3bpSNtcQ1kvCvafjnA0qsHf6PkjS2TqCo57f2z5wzP5PoJe
	 T6xYK4I69BKUdRr8Pp2NwNQbTJInYg4dNl9MgDNHkG/PqnjmeH9o4NpsD+m5oXoF6C
	 vZ8tt4UpMlWe0xc4fU0qaCt+O4u4wsqOtCX6nC+XMUgxcrIiav8+FmHkvjntk2aHxk
	 fl2FtBUtxFhncCvMEUzgRowbL0ODG8p93vqamuNhSV6ZlENm04zgCrHfyTefjtdf9A
	 0/3xLK+1uHL0w==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id D383727A3595;
	Sun, 08 Nov 2026 23:15:36 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net: ethernet: mtk_eth_soc: skip page_pool
Date: Sun, 8 Nov 2026 22:37:59 +0200
Message-Id: <patch-e9b81d2fdf3b2d4b11048e6a642bcfcc@loljews.com>
In-Reply-To: <patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com>
References: <patch-aad4cfa8d9522d1f7dbc9893ea12e813@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

page_pool hands out order-0 pages and the pool is created with
MTK_PP_MAX_BUF_SIZE as the maximum DMA length, so it can only back a ring
whose descriptor length (ring->buf_size) fits in that.

Gate the pool on ring->buf_size instead of ring->frag_size: frag_size is
computed with the netdev_alloc_frag() layout, whose headroom and
skb_shared_info footprint differ from the pool's, so a ring can pass a
frag_size <= PAGE_SIZE test while its descriptor length is already larger
than the pool can map.

This is preparation for the 9K support in the next patch.  Today every
ring is smaller than the pool's limit and the new condition is always
true, so there is no functional change; once the normal ring follows a
jumbo MTU it grows past the limit and takes the netdev_alloc_frag()/
mtk_max_lro_buf_alloc() path that is already there.

Link: https://github.com/mediatek/mtk-openwrt-feeds
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index ad0fdc413..f2b2fb113 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2819,7 +2819,15 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	/* page_pool hands out order-0 pages and caps the DMA mapping at
+	 * MTK_PP_MAX_BUF_SIZE, so it can only back a ring whose descriptor
+	 * length fits that.  Today every ring does; this is the preparation
+	 * for the 9K support in the next patch, where the normal ring grows
+	 * past the pool's limit and takes the netdev_alloc_frag()/
+	 * mtk_max_lro_buf_alloc() path below instead.
+	 */
+	if (mtk_page_pool_enabled(eth) &&
+	    ring->buf_size <= MTK_PP_MAX_BUF_SIZE) {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
-- 
2.53.0

