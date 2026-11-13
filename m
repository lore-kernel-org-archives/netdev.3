Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614341;
	b=c3+y3FtQeQykCLbLbZ6ubrEG4EOjfQ+A4baZ95+3MmhDKkWhilHOKK9JlGWkt4xeXJBr
	 3xVUiuV9sAykt9LTr1mpbeVlZMELDR4XgzPqb3yo6LOv790SO6sBRSPYj4IQDLUlHKhOT
	 UWgLXKCHqjJ+se8VAqcBChtzkTNdheQkPh1CnLh/pvOdNbakGlr/7mPOF6rjVNpycnWEM
	 ENQRlHlI094xDu3V4rUAbZTBaKc0YO+bx3PvVKh64KzyyXlzpMHlc37F0RUIqIzm7uCW1
	 Uh/5YNUKgXEW/Kfyd/FvLlNZkqH8WrTmQY8k2foF+oOqB8dn+KlKjCpSP9bm2hFXtzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+yLvyz+fMxvHJOFwimgm8CGOOpPaAc/+bETgw10dI8o=;
	b=RdaxHXfQCqQgKGlgDayP9Dav4oaHil9S+rdjxs+VaRTa0ewwjXlC07m5LlTGuovfpL0O
	 8lKqGKlXwL1NAbU/mLxB/jsqSqsEbfYPEuNhCOvW9LiI0HIk6Z1PWGOt02c4GG5RpJfQG
	 CUry1J10T6W7v9dkPgHbTMA+JqcXtDy97yYQcjmuVqpsoEhsVjdIoxlticI7TU1tV4IgM
	 f3QwDrihs9T4y60csDaiymyQ2Fcs3yLbGLZTKIzN/CwF+KPbrvHOJG7knDCBwE1/v0k7I
	 Owlw0ZjxTpQsDh26AWoG9KyEvb+CCKP2oOjIy1a7bhQGZDyzn8UdOmqob6lAWMcdvPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sY9AHi2c;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3E606A8B0
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBF3E606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sY9AHi2c
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cdc606b47so331699766b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614336; x=1795219136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+yLvyz+fMxvHJOFwimgm8CGOOpPaAc/+bETgw10dI8o=;
        b=sY9AHi2cTJKQDOiGtco3GaLZADrsghwOX8ZoP9wtjgDEopGsOPJG8F5RwCl1PdKbXO
         E3juuH7xS3uOaXDr416OLEovsMHMVhx7KRG+1xlqpxoMZpxJ3EDFmAnRoFQ2S3GBopuz
         hIfjkDUHNfoMJSI0fNbmBo+N/FMMkxIbHTKVGFUht7Kedp3iF4IQOZ+MnRwBjz85rzbW
         bX1e6ISgmWtjA5m2opESzIFgJkvxfaVk9tqbnobJT5Ct6otrMA5rQ6aD5YU7oPJWaCP8
         c6ahtURSiY3jHYJYGghmF+wi8yGKMDMtOS98q9pnEEWcSrzE6o1nOx1seX7jLGdLRLar
         sVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614336; x=1795219136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+yLvyz+fMxvHJOFwimgm8CGOOpPaAc/+bETgw10dI8o=;
        b=DV7FP1fqSI5Q12wvzxtLlxtP3deXr8A8UB2B9EJW65Axkep4168cm6ugcXRLk0Cwv4
         8GdNum160hCJCIj+K4q5AwWaccQqdA1Xn5/ibBS4JnwXbQPqqKkCJLIxSz2VgKsv7dwI
         bpH+Cj16MoAcSzA6mbfC5v2MwIUnx9gBrZNLsUJIJtdnwggZW1K0UvtdzVSTdXVFBEOd
         cHBR7rQcFnWOKDhErUw2x1pa2lmSJwe6xHkOZAfyk/IWrsS13m2IZt+i9reTPo0EKUx2
         HTLskndgboMeMdcQ6s49Ax4TjceGi4f5m8ypeftG0H83ZnMLsmfe2ZpaRTY3r1ibL7xQ
         fWhg==
X-Gm-Message-State: APuU4Z9xONdQ+5pAFRpOA8EuvO9hx/gpWAiIxPEW7u8ZyVw3xgdIxUxo
	GIJghF7/lOpKfa1bvqwCP80fg/QTzIkNbHwh4Xv3W+fJ9r7GIdoROtWPSxY3MWHK
X-Gm-Gg: AYBFou1wT4/VRaUB+N59VnaFUnc07Avs3gjlhrF2Ov87KLTG6isieiOaX2G7QQiijD1
	5WgLYC7XbR/0xDgWjfGPR+jjamihOVyVSitz0ZPpu+gNbKUAgiObpXcP9Tk7RjiiDKBRa7oEzbr
	2TVbRRx/5B0blxZ/eNj6HjPpVTI9tk91qXW0LQf5JR9Ha5Te7VzCaZte16MtLa5sxPxAiJ/bcOS
	b+iEzjTD4u/VYR8MHwQUTARyDHLHFBeHFDM8xg2FQdyGg0q1woAliDhDPeDFhe7x6EVlMR51jBQ
	dolDmeGzzSzhrCYTFtXirASbBwIBx6sOV7NjPApiHHYZ0oC1VWe44W4UyNbA/7UHT49mCYfCXuk
	wxQAB4v3NQ9Va1N4jW+38D/V0jxyXOMMAYgFMfWulVJEauqYrpbLEUXnYDyH/lSlzAT3S7djee0
	oQfN19BsfhU2ptrZGVoKcFnRKgtBQz3kph4eulI0rF+IpCqnN2w4jBNojAjSw33dnOyOjhfLqzF
	KyMH3ejBfkaCit73GntMtgHOupHAdlObJ4YPJMapi3sDXYORBCWua4B/XycBsiAE4AxsLft9BCS
	UDxPEQmzRmdEvc1LNPCmI7PxWs8W7Iv9IyiwCMHu
X-Received: by 2002:a17:906:478b:b0:c31:9a1c:de76 with SMTP id a640c23a62f3a-c5096372196mr356722866b.14.1794614336200;
        Fri, 13 Nov 2026 15:58:56 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:58:55 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/7] net: bcm4908_enet: fix the TX ring wrap
Date: Sat, 14 Nov 2026 00:58:41 +0100
Message-ID: <20261113235847.517308-2-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113235847.517308-1-kudzo51@gmail.com>
References: <20261113235847.517308-1-kudzo51@gmail.com>
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

start_xmit() wraps write_idx at length - 1 and sets WRAP on the
descriptor at length - 2, while poll_tx() wraps read_idx at length,
and the free descriptor count is taken from length. With read_idx at 0
and write_idx at length - 2 the count comes out as 2, the frame is
queued and write_idx wraps to 0 == read_idx: a full ring looks empty.
The following frames overwrite slots whose skbs were never unmapped
or freed, their bytes stay in BQL, and the queue stops for good with
nothing left to wake it.

On a TP-Link Archer AX6000 this stopped everything the CPU sent to the
switch under sustained TX load (about 1.3 Gbit/s through the switch's
CPU port): tx_packets froze, nothing was logged, and BQL showed about
185 KB in flight against a limit of about 10 KB.

The same mismatch also lets poll_tx() step onto slot length - 1, which
start_xmit() never fills: once per lap it completes that slot,
unmapping address 0 with length 0 and counting a packet that was never
sent. That one is from reading the code.

Use every descriptor, with WRAP on the last one, wrap both indexes at
length and keep one descriptor free, so that read_idx == write_idx can
only mean an empty ring. Stop and wake the queue with the
netdev_queues.h helpers: start_xmit() stops it when the ring is full,
also when it finds the ring full on entry, and poll_tx() wakes it once
there is room again.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 57 ++++++++++++--------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index fd2715f84..60f711e8c 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <net/netdev_queues.h>
 
 #include "bcm4908_enet.h"
 #include "unimac.h"
@@ -518,30 +519,34 @@ static int bcm4908_enet_stop(struct net_device *netdev)
 	return 0;
 }
 
+/* One descriptor always stays unused, so read_idx == write_idx can only
+ * mean an empty ring
+ */
+static int bcm4908_enet_tx_free_descs(struct bcm4908_enet_dma_ring *ring)
+{
+	int free = READ_ONCE(ring->read_idx) - READ_ONCE(ring->write_idx) - 1;
+
+	return free < 0 ? free + ring->length : free;
+}
+
 static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
+	struct netdev_queue *txq = netdev_get_tx_queue(netdev, 0);
 	struct bcm4908_enet *enet = netdev_priv(netdev);
 	struct bcm4908_enet_dma_ring *ring = &enet->tx_ring;
 	struct bcm4908_enet_dma_ring_slot *slot;
 	struct device *dev = enet->dev;
 	struct bcm4908_enet_dma_ring_bd *buf_desc;
-	int free_buf_descs;
 	u32 tmp;
 
 	/* Free transmitted skbs */
 	if (enet->irq_tx < 0 &&
-	    !(le32_to_cpu(ring->buf_desc[ring->read_idx].ctl) & DMA_CTL_STATUS_OWN))
+	    !(le32_to_cpu(ring->buf_desc[READ_ONCE(ring->read_idx)].ctl) &
+	      DMA_CTL_STATUS_OWN))
 		napi_schedule(&enet->tx_ring.napi);
 
-	/* Don't use the last empty buf descriptor */
-	if (ring->read_idx <= ring->write_idx)
-		free_buf_descs = ring->read_idx - ring->write_idx + ring->length;
-	else
-		free_buf_descs = ring->read_idx - ring->write_idx;
-	if (free_buf_descs < 2) {
-		netif_stop_queue(netdev);
+	if (!netif_txq_maybe_stop(txq, bcm4908_enet_tx_free_descs(ring), 1, 1))
 		return NETDEV_TX_BUSY;
-	}
 
 	/* Hardware removes OWN bit after sending data */
 	buf_desc = &ring->buf_desc[ring->write_idx];
@@ -562,7 +567,7 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	tmp |= DMA_CTL_STATUS_SOP;
 	tmp |= DMA_CTL_STATUS_EOP;
 	tmp |= DMA_CTL_STATUS_APPEND_CRC;
-	if (ring->write_idx + 1 == ring->length - 1)
+	if (ring->write_idx == ring->length - 1)
 		tmp |= DMA_CTL_STATUS_WRAP;
 
 	netdev_sent_queue(enet->netdev, skb->len);
@@ -572,8 +577,13 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 
 	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
 
-	if (++ring->write_idx == ring->length - 1)
-		ring->write_idx = 0;
+	if (ring->write_idx == ring->length - 1)
+		WRITE_ONCE(ring->write_idx, 0);
+	else
+		WRITE_ONCE(ring->write_idx, ring->write_idx + 1);
+
+	/* poll_tx() wakes the queue once there is room again */
+	netif_txq_maybe_stop(txq, bcm4908_enet_tx_free_descs(ring), 1, 1);
 
 	return NETDEV_TX_OK;
 }
@@ -652,17 +662,19 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 {
 	struct bcm4908_enet_dma_ring *tx_ring = container_of(napi, struct bcm4908_enet_dma_ring, napi);
 	struct bcm4908_enet *enet = container_of(tx_ring, struct bcm4908_enet, tx_ring);
+	struct netdev_queue *txq = netdev_get_tx_queue(enet->netdev, 0);
 	struct bcm4908_enet_dma_ring_bd *buf_desc;
 	struct bcm4908_enet_dma_ring_slot *slot;
 	struct device *dev = enet->dev;
+	int read_idx = tx_ring->read_idx;
 	unsigned int bytes = 0;
 	int handled = 0;
 
-	while (handled < weight && tx_ring->read_idx != tx_ring->write_idx) {
-		buf_desc = &tx_ring->buf_desc[tx_ring->read_idx];
+	while (handled < weight && read_idx != READ_ONCE(tx_ring->write_idx)) {
+		buf_desc = &tx_ring->buf_desc[read_idx];
 		if (le32_to_cpu(buf_desc->ctl) & DMA_CTL_STATUS_OWN)
 			break;
-		slot = &tx_ring->slots[tx_ring->read_idx];
+		slot = &tx_ring->slots[read_idx];
 
 		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
 		dev_kfree_skb(slot->skb);
@@ -670,22 +682,23 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 		handled++;
 		bytes += slot->len;
 
-		if (++tx_ring->read_idx == tx_ring->length)
-			tx_ring->read_idx = 0;
+		if (++read_idx == tx_ring->length)
+			read_idx = 0;
 	}
+	WRITE_ONCE(tx_ring->read_idx, read_idx);
 
-	netdev_completed_queue(enet->netdev, handled, bytes);
 	enet->netdev->stats.tx_packets += handled;
 	enet->netdev->stats.tx_bytes += bytes;
 
+	/* Reports to BQL, and wakes the queue if start_xmit() stopped it */
+	netif_txq_completed_wake(txq, handled, bytes,
+				 bcm4908_enet_tx_free_descs(tx_ring), 1);
+
 	if (handled < weight) {
 		napi_complete_done(napi, handled);
 		bcm4908_enet_dma_ring_intrs_on(enet, tx_ring);
 	}
 
-	if (netif_queue_stopped(enet->netdev))
-		netif_wake_queue(enet->netdev);
-
 	return handled;
 }
 
-- 
2.56.1

