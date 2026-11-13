Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615607;
	b=IZ29oKyInpcBSm8WA8e5d+Fl/JBa5lGmocdCMdzKd5ymLd/QjtCfixQSMwqtpNgQTPvX
	 Nuk3ZLS/h2ZCjAeYCEpYjB0OEMODlq13Seb/qi9QU8UzKpJQo86yh/YqGFFLDv0v/Ky54
	 76mmmvCaS+DJfWjfDIy4jkFOkUsg2TUcBsEtOTQVXA3/VUVEPf5hV96gqX2sxWOLYe+HA
	 YguohcdaGfNUfQaoD6t2yJwVLPL4/XQTOG8Q00Ocywj2rkUe6ZuN/wjIPKW35Va/OY5aC
	 THRdDTsVSN24DUCwN48+b6JnSaaZtoMSWRYgfCtl19MhnyiPae3kbIwqSo9IJKCmuQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615607;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hK8aCGgzYfT7wVf+5NVjQORxmxgjTle6uk6kBmLZTK4=;
	b=htb1cvP4IE4qaHGuVZc5RKwrsmdOZdte2CZKl3wD9R3cLmZmVgnA+kggmvZQI3Brr139
	 TwzIo62rOvqh7UgyZMyP0x8u6mNIo27g1oIeiKQ/LDwxZxGmUT6YFuY7TJ/Vnxx90cAIa
	 cKcQ4HfZbKmeU7M9okoFdL2/Fln0Vbb8hjM1lXRU7QCU6bv52heb7LYI5MFmCwP6j8zAF
	 i+vKEu3C3oKQepanDp2/6VPXoe7SNdMOfiHcXni20rS4LQYF+X9pPHOqOc2EN8h8KMihg
	 jzuimNXuXq7MXJvs37yTmMUsJXHgG4Bu4NtuIPaVA4kNfIiBBKE3sDSGuskamvjK+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=ZEqj0aMY;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0232606A335;
	Sat, 14 Nov 2026 00:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0232606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=ZEqj0aMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794615596; bh=hK8aCGgzYfT7wVf+5NVjQORxmxgjTle6uk6kBmLZTK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEqj0aMYVWDwPyN+xANHeTzHoTBYqVtH4VVfZTLi5ZIuZqIVPv2SGMyjDdqBUVDd2
	 uEoweN3gTv6k4r5WupUA/gA79rLVfwe6Ct/GHbO0XEBZadpHQTy5UoyGYMYGs5GRLX
	 icv6n59SRrd4b8juuFo0pzrcn9ucOVHJBgmzVQQmf9qYU/7xtWlaLuGhFXnu6kchNq
	 0e7pbg4/pmWvpcItdPztGUq+Mv0h7W/EClCaJ+qJ6y8I5b/G/wVkAFC7qogtqddZ02
	 XlojWw2LUIf5o/KgXxw7bacRyJcyDD3rqXknKTS2lfOo4LS4A9aUacaQncCtqdxOXF
	 f+EPhnDEvHbwg==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 77CD927A66F9;
	Sat, 14 Nov 2026 02:19:56 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/3] net: ethernet: mtk_eth_soc: fix the RX
Date: Sat, 14 Nov 2026 00:34:14 +0200
Message-Id: <patch-c279f68b0cd14ae5779a591e8241dc6c@loljews.com>
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
index ad0fdc4133..a46cf54411 100644
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

