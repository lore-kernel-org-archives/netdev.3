Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574836;
	b=beVIHoNJrLHxbs9BXDmj8bJKllnKEXAH01uQKS3dnWHQikem8L1m6WSYiobK8ZoPUBYW
	 R1Tuv7LUUK8nLQjpVrqCG3fA+OAd9OCioq2eD7dypW0Pc7jd5mUhhU8Dzeuy+3ahb+1dm
	 Cfg2E3y+j0OecSPEnbvRhlwihoX8p3xfiSY+cxM3pHSBMy3mRpv9FGk4134V+Y8kSLyYl
	 WoFD/sOrkZcLPSOzag4LFDLLQLhnUeFNITmJe+S8a0F1WWeL80K5HVTKZW0g4ftW/oVzJ
	 hNmjRHYb0byeVAFDH+QXuP/nYo+r6VZ8W8ya9iva3dAUKON3AzSMyae3hlmMZh1nkNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574836;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JN0y3VQ1WrVXHoyBFtd++KydZPQZbOZ7hLIlnr0gNm4=;
	b=UnYj/OuWU7pc3n/bD+PAES41pVVDTHbUAiPgnq6N2mjH8dNcl80P6hVNScS7tLVv//m/
	 7D/qX0xNyftU9mTWHv5oWGRLfEGwUx9o/3bJ2dnwMEw+IiMBTFWVw6UlzaIGUNXW8FjAh
	 iLQIN+9lrJxKY66Mp4rTBsRVvo8lnGiSHRRT7Km3666EYLhtrqfP09xJplVTT0bb0isGR
	 morNL0xU1LonsDZl1EgT5s6GTTB28InndtyWio3cCDNQnN+5kD1Hzt1M9iJACHMkyy4p5
	 GkArbBkj2h3bU8IcXdEUHCpcs/KcxnSlFiwP0AZ3c8dFMmsg4FHx8iGBRVZ7wG2BL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=fIKf6OYZ;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF15606A327;
	Sun,  1 Nov 2026 23:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF15606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=fIKf6OYZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1793574824; bh=JN0y3VQ1WrVXHoyBFtd++KydZPQZbOZ7hLIlnr0gNm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fIKf6OYZVFJvWjJd5hFTiiOgBmWz+mHfDNwxT4XV8zjmNYq8NXDRpH2UOxHXDAtQW
	 S/faza78M6VBC7tlkWzg1u4Ez6b4GynuoWYrNAwXmuBpFQAEbtI5xiBtjd5LrsOHE6
	 /IESmXM6VVaDE9yGaZcLYedAN3AZJIg/DWGc1yS/62tdkELbgLfBvOc8eT7yMieiv5
	 PY8BwR4F3P+3NBN6zxVULxY6QClcCny4apmAt8J3lJTafzR0lXeBfi6dsfD3DbRKiN
	 AUlS2Unscsl6yVsN0nT1d7C4fJ5SyU/g0jK9n3p/VFEd3pfc8wKeR9uqO+Q/+t3zos
	 xaBvHypwj+YUA==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 6DCC127A3908;
	Mon, 02 Nov 2026 01:13:44 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ethernet: mtk_eth_soc: skip page_pool for
Date: Mon, 2 Nov 2026 00:48:46 +0200
Message-Id: <patch-fdfc120d5c46c3e5d484cbff30f63316@loljews.com>
In-Reply-To: <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
References: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com> <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
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

page_pool allocates order-0 pages and the pool is created with
MTK_PP_MAX_BUF_SIZE.  Rings that need larger buffers (9K jumbo or the
HW-LRO rings) cannot use it.  Only create/use a page_pool when
ring->frag_size fits in a page; the large-buffer path already uses
mtk_max_buf_alloc().

This is required by the 9K support in the previous patch; the
large-buffer path it relies on comes from the MediaTek downstream
series.

Link: https://github.com/mediatek/mtk-openwrt-feeds
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b5f7b2a78..0f0e6bc74 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2825,7 +2825,10 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	/* page_pool uses order-0 pages; rings that need larger buffers
+	 * (jumbo or HW-LRO) use the mtk_max_buf_alloc() path instead.
+	 */
+	if (mtk_page_pool_enabled(eth) && ring->frag_size <= PAGE_SIZE) {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
-- 
2.53.0

