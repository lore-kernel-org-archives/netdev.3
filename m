Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000114;
	b=YV956nHT2iGf4LvOmiihJJa1nN122qaHSZ3u35T57VFUV0KiwAc85RE79JLf9AlxWSMV
	 ubeExpTuSvz7b05jEloI1w96HPDcvMh50Di8PAyZbsZoow9+TsMoRh7o0AFO52ySiaffY
	 pRrJK3GASVQV03PPnJX7nrtpnsU6IOeM1GqKhaWcdvwtwgiwxp6nre4qGxyS3xa11ejqh
	 ljSh45EI4QR6uSJWub+D0dR3BDCQPtaTBkNSJCq1HSlAKmy7pdnnt0Rry1C+EQRMrfBdA
	 ddx1GtCbm6rqyxhrwqxswVhzM6Aq9XuTzA/LTWko6DPtEdc5Bf9F+wqmAjewTF1S6KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000114;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8xWSLA/fsW2tTCUYRlTcmqVsUQK2KH+jJMYEsJnsOT4=;
	b=a6eJxmo6T26ISO1OIjOLzZTAfXuJVsw/Z2i1oKD8WCO2xZCWZvgaRkdlAdu5eoboinak
	 lSW38qUQ0XFtUZwRUMcYSFajPlbZlWJbKlic7v/4VqJtadJzhWI/c6AhOgcTMG3r2LrtW
	 xPmzn22wskriBoKiqlqPkWpyTVC6lbtKfLr1NHS7sUXmje73K4cioVudHaxa4VzCvUeJt
	 KzvV3DST0q7f1k8d4phjwmdS6bjhcO+SJ5N2s9nUXoci59y7ELxSoMgVR+T9jjGApL/P7
	 YK2N/DfX+TYO/HWeeKKeESfP4oTIuH4oVNUraeBb9LBBatPZXPlYulAbww0wVQ8HRyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=AX+4j+S+;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE59606A32F;
	Fri,  6 Nov 2026 21:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE59606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=AX+4j+S+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794000101; bh=8xWSLA/fsW2tTCUYRlTcmqVsUQK2KH+jJMYEsJnsOT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AX+4j+S+gR+IT6nplef+Bd087gbbkNSiZjTvNBxf+QejEadbN1QWEiSklRBfrai+u
	 nxRbtD9cWueiappYSeZDg8TUlviN/1CxrJBNEMeBKEFQBHps5kFg9RgZ2T1oMlUnY3
	 gQGhCjgugphKZxQVuNLCJv6F8G8dI2obV5XZIMpZ6JCB5EqOi2pcnSH5khq2gl5hR6
	 CViz2BZ1rlNvLx5YcvrNslOf0x/vyXW5/5egnBDV0Xia23BpeigAM0dpK0NBLeCAe3
	 cX6juke0UmXVbtUnk00w/YGBBIVF/3G5D3NGMRRMGuLbsm1TjBBKNdU7WZK0TuPXbq
	 8PTicgI3TG3lA==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id D616527A389D;
	Fri, 06 Nov 2026 23:21:41 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: skip page_pool
Date: Fri, 6 Nov 2026 01:52:12 +0200
Message-Id: <patch-79206c12217411fcdbff905b65eecfb2@loljews.com>
In-Reply-To: <patch-2793186c653124c4c0b3d463bde2ea3a@loljews.com>
References: <patch-2793186c653124c4c0b3d463bde2ea3a@loljews.com>
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

On NETSYS v2 and later every RX ring gets a page_pool.  The pool is
created with order-0 pages and MTK_PP_MAX_BUF_SIZE (PAGE_SIZE minus the
headroom), so it can only serve rings whose buffers fit in one page.
The HW-LRO ring already needs 12K buffers, and 9K jumbo adds more such
rings; for those the descriptor length is larger than a page, so the
pool cannot back them.

Only create the pool when ring->frag_size fits in a page.  The other
rings fall back to the netdev_alloc_frag()/mtk_max_lro_buf_alloc() path
that is already there.

Link: https://github.com/mediatek/mtk-openwrt-feeds
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index ad0fdc413..29370376f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2819,7 +2819,12 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	/* page_pool hands out order-0 pages and the pool is created with
+	 * MTK_PP_MAX_BUF_SIZE, so only rings whose buffers fit in a page can
+	 * use it.  The larger rings (HW-LRO, and 9K jumbo once enabled) take
+	 * the netdev_alloc_frag()/mtk_max_lro_buf_alloc() path below.
+	 */
+	if (mtk_page_pool_enabled(eth) && ring->frag_size <= PAGE_SIZE) {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
-- 
2.53.0

