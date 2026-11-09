Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279101;
	b=JRIIwpGqbdbfcERrgQnUTkb4HJjzdnvG1nfqVLOmvtwjVTK6Glv4utNsu8kW4DQbw7eZ
	 0OqXjGPkapSAXUQ6YFgTd3JPr80zkPOpHAUHHPnIL7cMogFUFJx6J4DMIAda2A1114aZs
	 0KZAd5bLcUuzI0avNf39xwJAqPxHgjUcAa/dbXm44rRhLt1CmMdEka+o3sd7t1YQcAqsj
	 OUfM1/AR5ls0Pwnj9BcOtaY5BbYxTcZ3FUHvc8UOZrFTFWAD6AHvPgOV4ngZw6SkvUNeN
	 BvYHdzD8/hb9bM21/dd9GxOUKTPsuQyKSFkaREfymVTZLGE3aWkked473ARGRTr38SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279101;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2eFNXlY6W+51J4Vi0p7pWkSSrWL85S3MWScldrTCxjo=;
	b=uHrO7erSWuAhLQHsoCT4q4QJiCETDBRkA7Iq1DBaGk2SCbMLeZMKnGAE7hrw2s0KkvSX
	 znO/isRi0V3e9uxKzqK/1ouWcjRsKPvfH6h8gcSKCksctOw0Lo9wp7DxNTL9MYCjZj8JR
	 /uO9maKcyO5eLj8brwalOm65/KaYydcJprbvLRdJzU2ShvYnBl76wQ6Ec2XKTRxtrHehv
	 pZkTE7BD9o2A6FBccxWjGZhswKaO2KbRc6+zqt5bMGlwhRgkYYjrhI263xrQZTjUXkBds
	 C3XJtJyIxjvfO5yWseXkJzSV6y8yUUMKHNIT4KXGXCw4i6NgwTsJzyTOvAQGl8mJTVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=SBjv8p+5;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AD606A321;
	Tue, 10 Nov 2026 02:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 151AD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=SBjv8p+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794279090; bh=2eFNXlY6W+51J4Vi0p7pWkSSrWL85S3MWScldrTCxjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SBjv8p+53S0cs6PP0WUj5J/HcN2WNl8TEQCKFmXiM7ioSgkacId16MS5F/wc+pamH
	 O8x+GXOF6yRCYJXOvQTHWLGWIh8Ftrnw+G5lEU+VBOhP4lJkgq27DgQNkGdl6Mx5df
	 YltIc9mq8LXGz//xtsiuhQ3KsvuEBqxmAitr2WqXP4aWkdpc0QMfeTY5pKg2bYhPTG
	 9C1bh1wvQZLXoXGBhbjRas8rTFi+E8Nrig1sNx5qQwKQyNdcNvPT9SDpy3UZfOdK46
	 sraAVh5+haRhFKfcKBJyP2r4bFx0uEnBPszPD0Zh2Bh1oIjCkCU92ykU8aYjJu8qjJ
	 +zN7wCDj8ycag==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 21FB527A3595;
	Tue, 10 Nov 2026 04:51:30 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/3] net: ethernet: mtk_eth_soc: reset RX DMA
Date: Tue, 10 Nov 2026 01:46:17 +0200
Message-Id: <patch-6b45cf654903652eb4ed98e2e7514f5c@loljews.com>
In-Reply-To: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
References: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
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

mtk_poll_rx() keeps a single dma_addr_t across the whole loop and only
refreshes it when a replacement buffer was mapped for the descriptor
being processed.  The paths that jump straight to release_desc (no
netdev for the source port, MTK_RESETTING set, or a refill allocation
failure) then hand the descriptor back with the high address bits of the
buffer mapped for the previous descriptor, while the low bits in rxd1
still belong to the buffer the descriptor actually holds.

With MTK_36BIT_DMA and DRAM above 4 GiB the hardware then DMAs the next
frame to an address that is neither buffer, and the driver passes the
stale contents of the untouched buffer up the stack.

Reset dma_addr to DMA_MAPPING_ERROR at the start of every iteration, so
a descriptor that is released without a new mapping keeps its own high
address bits.

Fixes: 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988")
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index ad0fdc413..a46cf5441 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2210,7 +2210,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 	u8 *data, *new_data;
 	struct mtk_rx_dma_v2 *rxd, trxd;
 	int done = 0, bytes = 0;
-	dma_addr_t dma_addr = DMA_MAPPING_ERROR;
+	dma_addr_t dma_addr;
 	int ppe_idx = 0;
 
 	while (done < budget) {
@@ -2219,6 +2219,12 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		u32 hash, reason;
 		int mac = 0;
 
+		/* The release paths below hand the descriptor back with the
+		 * buffer it still holds, so only overwrite its address when
+		 * a new buffer was actually mapped for it.
+		 */
+		dma_addr = DMA_MAPPING_ERROR;
+
 		ring = mtk_get_rx_ring(eth);
 		if (unlikely(!ring))
 			goto rx_done;
-- 
2.53.0

