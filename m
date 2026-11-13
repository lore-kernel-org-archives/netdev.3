Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616248;
	b=OCGiukN2ALbAEo7R3f4UsBs3hD+ehYewjADbEkCmUbF5R4FgbJznDnoWe/Sh8uR/ZX6w
	 Dwi12ohbfE5SXKI4Tz6EasS8gDaAzFIth36UMAyDKYk63b2Qra2rn4rdpezTmevI4mPS6
	 4BhZmJ9v6DGwFYK4zwr6yu9FwGxigH+x2iu0BUss/LElMI+o7VNXR1UBA/0uZKku+if4q
	 igkQHgLenDvJkW2/HzA8MJ5cJZ9Q688kG71Io1Aq2lhfHDcxK8V26wbwKMg5QiN5bACf7
	 AP2yehkr2jmeu+BNcTSZkuhbO3hLWGAEcu9/e7UiUficp7+Rx9HMXH4PQ9HY1OwpaHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616248;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hVoGq3aYEb+ZU0tKqXjIcoSedSxKS1tJC3Q0UDo6l7Q=;
	b=KGzymVZMeGWhawY8EAo1iCvwhu/ujIybH6oNzrSFPTEec0iH2Q431a/PGIfaowIlOnx8
	 K+RnE7T1jSc5yTiKkqiV/MqK1V8hs73gi/x4xRDF0cjT549rcpYqcWzmOkBuOHg2qjXo2
	 5TXHC3loaaW7U27u92SzsxlxhaUsIhLH8CWu1CnwkoIVITmqQG9EDE1V4xHo7Co0H4/qb
	 W0dBiCx1DM9KPXFkMuuxPfXg2xazB7vadmInmck6p2zGI8F99A+dY5PQ22aO5qrN2nC2J
	 Hi/C3i02KZsCCObb63l/n1i9oaTMw9VBAGOcu6v9A/3RnLoaNT8y8WlnrIt1c+pFjPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=J82iMrUt;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C6606A32D;
	Sat, 14 Nov 2026 00:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307C6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=J82iMrUt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794616243; bh=hVoGq3aYEb+ZU0tKqXjIcoSedSxKS1tJC3Q0UDo6l7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J82iMrUtNw2ISubs8iBRK+w6FivU2hCAH0g1LvIoqLETyu5FVi0CYtaP3XZwbuv47
	 avtt9DRLcU14kzORr2KHAV0BgsjcUA6wKQck64bRABn0mcVfOxf04t4j5pf8+TNJjS
	 YbiHKPI2N+0Rfzz5CP4r4UG9vJBYJbyGkKkPs418q0t8IcrdmId8v9m5o0mdELmiza
	 lyI+htcwMBxXbFot6v3Ajf/P3oPy6jt4H+PWC6Rk/YzZM1S5tWsuRCACe6c5WIygn4
	 x0LHREWJDInDZ66lufMDXbohqYg5vQadke+OEELcQObsz6j9feumJC/718DD/lNL1m
	 oU6MOK99g5b2w==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 7A43B27A66FD;
	Sat, 14 Nov 2026 02:30:43 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 2/3] net: ethernet: mtk_eth_soc: skip page_pool
Date: Sat, 14 Nov 2026 00:34:31 +0200
Message-Id: <patch-2a89212e66b84e37783e0d2ebdaa0a75@loljews.com>
In-Reply-To: <patch-9e765e74d06edbba3fd85a0cd49c4bb5@loljews.com>
References: <patch-9e765e74d06edbba3fd85a0cd49c4bb5@loljews.com>
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
index 6c8b039fad..16c3e41570 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2824,7 +2824,13 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
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

