Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268635;
	b=V91Ei49IDgwzgFXbClNs9hJocAuIvtgr9L20+pX1bnQQXykYSe6ROwoDjO6ZB0gEnTuq
	 3DoFX41PXaSn2CTtxvxG+AXAS92W+i/i5nIZo7Y19D41Ji4Edu7AUbBbRqB+UbeBGlKvw
	 oqOTvLSShmWZl7OgAkSv0XkxPIOvqNy79Xx++YiigBdnebXZupoD4dp+6ZfmwZ7ItWZ13
	 LoMQpZ56V7SxfvemjRxlpPqQqA6xqLzRThPDMgcrHysH6z1z9pI92nwmo8NqrkYGXZ7o1
	 y7CIL+MWYCSkQuYlJZTY+1kFGjt40+8JsWagHTtay4VTjn6YjVp4Q4hmbcof0JTdhwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5RsYyZ4jmwX1lHRNizw1tgGoKzSfWeMKs257DsMG7TE=;
	b=KfIafLPLMSVlufv8STjHE+Z0BK0H1e8DVk/s1alaZCBwZlMHJEWrQYUHWKkhzefvnvTQ
	 EQvdvvd9LD6Ssma5GzRUuf+eJyrdxelOlAwM5FQDLq2VD4ydBZGQRJTZqA8VnWHN3nCPW
	 tUeJNZE+8tHpLJZTOEHxU0RT3GTecTfkkXiyX6oXW/UmtpV8X5FkLSMiwQJVLOeCp68LW
	 Z/d1MELoJHjtNWr3W8gYApTCCNg2pPXScyZOU/zqWLh9TrJYhLzh+Ss81utFmAV9T2msd
	 LrCwr4/frcEP6EVUyqSXgLCnxFUcB+bwQxq2ZYEnkqKR/cZ99189gQynnIWSWTg+TEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URxookT3;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A560A3818
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED7A560A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URxookT3
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c504bfd7393so27274966b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268633; x=1794873433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RsYyZ4jmwX1lHRNizw1tgGoKzSfWeMKs257DsMG7TE=;
        b=URxookT3xe9D0e9ytmspZKxDkUi62bNIyWnkkarfEClufFS8VehB0rADHBlNF3mthO
         FAL5LnYDmIyS3vrMJ4qF5OBkpWm5/M3MwxXm3PlXJPSZsanrNZI6NNhA1rTBiOavBVYr
         r/2+gFwCSEdX6Ns91D0EQdnrjuS2ynTjtMHYzO4/JOSgq5fOqDjS0vyDzQGf5ahi2eXB
         e5CkG+JeZqqS4u5TiJ3Theg61zdxW0QT26eu/ygaBh/zkotG4EBglPSVTIPkhFuV3otU
         D06J85MlHc7ZkvON1RQDGJhMGD8N7iCDqCmrI5S9+tJNqg7OcUUsTZlcDSHGW7Uqx4WB
         14hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268633; x=1794873433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5RsYyZ4jmwX1lHRNizw1tgGoKzSfWeMKs257DsMG7TE=;
        b=WO1L/qNWgGrNvXHXQ1lnUT6ds1niZOw6X4/o0LHBOP//4ab9iL7Vnb/V0sIOXacZAq
         tuKSWHa/w/o4G50fkuVIZtCeor89rsqZ2WHE9RXMa0hcw+XvEUgoamHTI7HwzVgXNtlv
         OFL7CRgKIkA5klEYGtcZ+Aw+wAzJRh4iGxKPV1T+DXkYEhhgoMMYtQK5uL00s7RV+Nrj
         5ah35aW7FG7zM/w7VqRfwJPa3a123n9QvTmQwppJJYpLjNNC4gk00rhlK1Jx/M5JCRUs
         y4yFpwMQ1kJHzmf6PpKxFbpyOMvQMnhZuGRzaYom9PZcKHUn8wxGj1crJYqItVbeyTAe
         NSMQ==
X-Gm-Message-State: APuU4Z+qOJrwG6r6C1c269jzLskqkAs5ClG196vgOy/QAVhkKTBESUJj
	/YeGpKD4+IYdQtFkRlEdraK1pGTlxo61wnvvED9cZyFVt185p+CVujbileKnwo+l
X-Gm-Gg: AYBFou1Cbgg6ltYEywQzdOvhx2zDB/BS/IMMZQHpTXtSCjs5d//2CxJV2JdVupr9zfr
	K9+xXLv4jR3magPPAlAk+LE3O194vzm2K4zKxfByQq7D6D5dbkMtSASQWNOpSaPEvsSj+SNbgn2
	vSeIwrj8c+dPan8H/QcUITky5aJokyZYTbeDc6OqeBjvN19QyaziaLd77z8YWVAG19JOGqRRzI0
	cORYDMP639p4u8OcCjjp7S18Qsnbfh4j/XkF+QNkoUU4a17f9HMLLqn3Ev0e3Kqha7KrMUdzMnz
	UrJO6cqN5CHwkmmodvlRyt0sLaAgNOIVeRpIoNCXKyL2dK2pHF79GKomxStnnnAklZhyy/sFq1U
	02CxlxuMyEmpLGvf+XBlik7NeQ+uAZqgVKMZyXYajRTFOq9R/op8pMpOLovNgA2Sh82vTFElXgu
	3jBeocKd0qUu9SxIYEZOrc2wqHk2TkJE6qsRy4vixqFIRiYp9W9y9HEM23TLOnlhvg27APEx81W
	LnHPnDCMY8Lv4hUMkzJICbxjlqd3TOXYLo/kxSNzCs9ySgL4Pq13l0TjYB2UH4hGPCmHji9NvYg
	RMu9/yrs7nyaB6wb6ALtoMq5N+Eq7V2Z1QWlK0BPKxocXHBfcfcWg6iqHZArFVmiy2XHk20qS1/
	a
X-Received: by 2002:a17:906:f587:b0:c4d:28c9:b90d with SMTP id a640c23a62f3a-c50494f324emr73812666b.17.1794268633325;
        Mon, 09 Nov 2026 15:57:13 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:12 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 6/7] net: bcm4908_enet: publish the buffer address before OWN
Date: Tue, 10 Nov 2026 00:56:59 +0100
Message-ID: <20261109235700.2586821-7-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109235700.2586821-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm4908_enet_dma_alloc_rx_buf() hands a descriptor to the DMA by
writing its control word, with DMA_CTL_STATUS_OWN, first and the new
buffer address second. The refill runs on the descriptor that has just
been completed, which is where the DMA waits once the ring is full: if
it picks the descriptor up between the two stores, it writes the next
frame into the old buffer, which poll_rx() is turning into an skb.
start_xmit() writes the address first, but nothing orders the two
stores, and the descriptors live in coherent memory, where arm64 may
make them visible in either order.

Write the address first on both paths and order it before the control
word with dma_wmb(). In poll_rx(), read what the DMA wrote only after
seeing OWN clear (dma_rmb()).

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index c0aca6801..ea4a9eb98 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -289,8 +289,13 @@ static int bcm4908_enet_dma_alloc_rx_buf(struct bcm4908_enet *enet, unsigned int
 	tmp |= DMA_CTL_STATUS_OWN;
 	if (idx == enet->rx_ring.length - 1)
 		tmp |= DMA_CTL_STATUS_WRAP;
-	buf_desc->ctl = cpu_to_le32(tmp);
+	/* The DMA must not see OWN before the new buffer address: with a full
+	 * ring it waits on this very descriptor and would fill the old buffer,
+	 * which is on its way up the stack as an skb.
+	 */
 	buf_desc->addr = cpu_to_le32(slot->dma_addr);
+	dma_wmb();
+	buf_desc->ctl = cpu_to_le32(tmp);
 
 	return 0;
 }
@@ -600,6 +605,8 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	netdev_sent_queue(enet->netdev, skb->len);
 
 	buf_desc->addr = cpu_to_le32((uint32_t)slot->dma_addr);
+	/* The DMA must not see OWN before the buffer address */
+	dma_wmb();
 	buf_desc->ctl = cpu_to_le32(tmp);
 
 	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
@@ -638,6 +645,8 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 		ctl = le32_to_cpu(buf_desc->ctl);
 		if (ctl & DMA_CTL_STATUS_OWN)
 			break;
+		/* Nothing the DMA wrote may be read before it gave the descriptor back */
+		dma_rmb();
 
 		slot = enet->rx_ring.slots[enet->rx_ring.read_idx];
 
-- 
2.56.0

