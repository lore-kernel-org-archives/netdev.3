Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616248;
	b=Xx6MrbzZnSLfmfCXnNhZNHhs1ITKlU4/D6PTfPVMPcq2XUXDm2LGzSkNFKHycMs4WZk1
	 Ivzz0A2DF/K46FczxjZzuB/KWjVCYiXdNlpzksmgrEqnpDwQy/1Mps9tUqjyHAE1I3n3G
	 jAqSXmy2iKFODAAWOM9OgbiKzfZIjXbUkjRbgtk3tgL2W5748PSo8bzA+OGg2ZZaF8pnL
	 v5c+az3x7x0CHE5bnjrnxU6VJoNs8jSHM/pXdAu1sZ6cSj0KiRSh3EwAoMB292iz7gaDd
	 y1lM9Wg8XwgbC7CvXOxFxxktrkPFPPmgo8XGr7XTJnCfcRHAJgJ9+3HqqEQXlaWVRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616248;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jT5AA4fH/fUrpiMbqTK77bzcToBq/eOTA9L2fbmIQCE=;
	b=dc0gaQUpZUdvjKOzix9wQ7SktJX/lPCyDPxRpn2aBvcPEuJtur4hI+J0ZKDMB/kpG/NW
	 lmaiq/zqkYrAp6cN9IJiKHsEV0C/13If3S0Weu+/YVmNZGwmZEew24fpCJGh2b8zvXmbi
	 CyYCZ7B9tokX2HsJRzkJ/W/VtRH9uUOcZihaDmanQxvyZms5pqdslTSIl4u9Q6T6L0BK1
	 pxcwOwlboOZpr/YQL2EG/lxw85i+XZFfcjXR+MtijwqEvYhbENwwN/PDxXjE0Auw9wN6i
	 WafY2udVr1cIQIcyPPtTWzwHQcbrzHH+k1Ln9BwX0WRQ8s7LW9C85nzr2YT5Uyh99oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=uBCufPzX;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30982606A333;
	Sat, 14 Nov 2026 00:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30982606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=uBCufPzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794616243; bh=jT5AA4fH/fUrpiMbqTK77bzcToBq/eOTA9L2fbmIQCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uBCufPzXKj0a7/M5I7EEEl7C14Z430QRJ5o6xkEBzvSu5QH2lDExdSbu3jHlusDsj
	 RgTB/mHcQwzvzGuFoDnOOCcrFYlIHa1IZrazPdf22+5F2Z5k72AbyGKKqCnBjOuhts
	 /baLVdKz3Kr4/kvsLhjjmhWc1MhB8O4tIsForX3Ehdh0mvz7SCcXYCzm9lvDYF8kRc
	 cOq9l6WwxhgVKGLES5UHoTezaru3EuTnEVwEBKX6FhzhEjDu9p7zuiwwcgW56QrDiB
	 tBs+82OL7fky4upj9YBrUgO7HijwJDz8DqHoZg0x3KZL6PNbXOkR3qjn2mwnfZeEkP
	 v8NAcxFEjkHPg==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 5184C27A66F9;
	Sat, 14 Nov 2026 02:30:43 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/3] net: ethernet: mtk_eth_soc: fix the RX
Date: Sat, 14 Nov 2026 00:34:14 +0200
Message-Id: <patch-4b4c5003bcf028fafd094e719c5e910b@loljews.com>
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

mtk_poll_rx() keeps one dma_addr_t across the whole poll loop and only
refreshes it when a replacement buffer was mapped for the descriptor
being processed.  The paths that jump straight to release_desc (no
netdev for the source port, MTK_RESETTING set, or a refill allocation
failure) re-arm the descriptor with the buffer it still holds.  The
address written back must therefore come from the descriptor's own
rxd2, and the release path relies on dma_addr being DMA_MAPPING_ERROR
to select those bits.

That protection was added by commit 6e0490fc36cd ("net: ethernet:
mtk_eth_soc: fix SER panic with 4GB+ RAM") for the MTK_RESETTING path,
but commit e10a35abb3da ("net: ethernet: mtk_eth_soc: fix
uninitialized variable") moved the DMA_MAPPING_ERROR initialisation
out of the loop, so it only holds for the first iteration.  From the
second iteration on, the previous descriptor's high address bits are
combined with the current descriptor's low bits in rxd1.  With
MTK_36BIT_DMA and DRAM above 4 GiB the hardware then DMAs the next
frame to an address that is neither buffer, and the driver passes the
stale contents of the untouched buffer up the stack.  mtk_rx_clean()
unmaps the same mismatched address during a SER, which is the panic
commit 6e0490fc36cd ("net: ethernet: mtk_eth_soc: fix SER panic with
4GB+ RAM") was fixing.

Reset dma_addr to DMA_MAPPING_ERROR at the start of every iteration,
so a descriptor that is released without a new mapping keeps its own
address bits.

Fixes: 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988")
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 21abeccfe0..6c8b039fad 100644
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

