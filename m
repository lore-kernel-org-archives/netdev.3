Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615607;
	b=Jkr5rOdha7v96qe6hgB2NsjJ8wV0rKW27ruEO2rmYiJWzM1AqoV0kip05Ir+AF6kA2Fx
	 02LEaDno3s0gmuatZHBIyjfPh0dvASlIlLxJ6L2l/vjxJ/500E15DfxpLFy0EYc0JKlpg
	 c98ZWyIB6ZivssjWe8XYZ1+IFMf7+8QwWtL/ip9ZPh44GhL+o6vz83UcL14bBqY7Cv44E
	 dHD6tnTukrUFLOETjg7zsSDMbc+9emVc9cOMoxmTXyMCMLxleRSUpXajXqOpkP9BHupRH
	 4BWaoa1NMesEOZokExy2WKg30KX3BxfR7U/qx/MFR3nOp5gKWerB4cpwILAfE0hvp0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615607;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XV9do77su4poLHOSxdbPm3s5wWjPH2t0IduyWFfv3m8=;
	b=cHobqg+jEyDmIcVANMinxzfTYwze+Ajh/7CXEXXQEbBqzK+tocA3FLBCr3qh6oiS3IYj
	 zb2rsGW99jau2fXuJyz7Bic8wh63TztSa3zjytDyW9AFbKl9K+DuA5+cxACUkw040zf8w
	 FBZdn1ND4SL6lRndca+PmWyFwcCMPxkTxXXC0dSrNu4hEbniaI7jURO1DsICRfpEzNf+K
	 U+P0jbyzAKEcA9RNxSnjH7Co6OLYlYyak+IfRIM0eGxH7QJK+MYOYxf27LyIo/uXwLCZi
	 1jMCLT6Glm3ifNzhjAhY34xuWSiOWVML1QfbUuIzUa0A4uLpDIGZLTtE9Qhg9qoCG5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=auh2m1WQ;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EB606A333;
	Sat, 14 Nov 2026 00:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01EB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=auh2m1WQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794615596; bh=XV9do77su4poLHOSxdbPm3s5wWjPH2t0IduyWFfv3m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auh2m1WQHMEXNLZ2ByvSDVK0kcR6EbY2YmqSCSVTUrZijhRmr2xPfpBz+zLzL25U0
	 BpRCAw0jFiyRH/jS4hl+M0WVyE7OXBV8OagfcjRROcLs6MRz8gU9DjoKJnzeO4EiXM
	 2S4kxSsvRIKCZG54CSc1ATgqxVVMCG/hutjyWevKypBHbwtZdZNGGNAPfrIXOf3Ywn
	 CQj6s5d1wf7dIJUUk1vgXCMfBXiQAsFmchfsKioCYDxffti5rWMFzXEpoya7gq42EK
	 NDc3viZoYer4KKEv5W+e8vAEqbKblADxw6Hph5IA/c49lZRLdUkexb5n3AzeXhdIQq
	 5THA/uyafQqwA==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id A0A5F27A66FD;
	Sat, 14 Nov 2026 02:19:56 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/3] net: ethernet: mtk_eth_soc: skip page_pool
Date: Sat, 14 Nov 2026 00:34:31 +0200
Message-Id: <patch-14fe14f8d845a12e954f19d3ec34ca9d@loljews.com>
In-Reply-To: <patch-f1e62a87eb0f914e1ea52a395f465998@loljews.com>
References: <patch-f1e62a87eb0f914e1ea52a395f465998@loljews.com>
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

The page_pool is created with order-0 pages and MTK_PP_MAX_BUF_SIZE as
the maximum DMA length, so it can only back a ring whose descriptor
length fits in that.

Gate the pool on ring->buf_size <= MTK_PP_MAX_BUF_SIZE and let larger
rings use the netdev_alloc_frag()/mtk_max_buf_alloc() path that already
exists.  ring->frag_size cannot serve as the limit: it follows the
netdev_alloc_frag() layout, whose headroom and skb_shared_info footprint
differ from the pool's, so a ring can have frag_size <= PAGE_SIZE while
its descriptor length is already larger than the pool can map.

With the current MTU limits every ring fits and the gate always passes;
it becomes active with the 9K jumbo support that follows, when the
shared rings grow past the limit.

Link: https://github.com/mediatek/mtk-openwrt-feeds
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a46cf54411..6768ab8ebe 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2825,7 +2825,13 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	/* A page_pool hands out order-0 pages and is created with
+	 * MTK_PP_MAX_BUF_SIZE, so it can only back a ring whose descriptor
+	 * length fits.  Larger rings use the netdev_alloc_frag()/
+	 * mtk_max_buf_alloc() path below instead.
+	 */
+	if (mtk_page_pool_enabled(eth) &&
+	    ring->buf_size <= MTK_PP_MAX_BUF_SIZE) {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
-- 
2.53.0

