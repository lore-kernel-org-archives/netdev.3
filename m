Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513063;
	b=PtPd6BXzS1FofdLBlB0f1xWRs2VLomTDsKX4cRKPbbQOXV/k1R+x/M3Vhnq2bvdPEQ42
	 el+zJJJ/ldfakkl+v2dxnbVvpA0CfAX58jVVNBfYsB+Y0mGqDmVzO0mInJQ4CcIw34m47
	 maD3iPcZk3fEvrE764P/xjD/6cIp7nE7AZR7GIlDxrZ6orF7os4RR/mKQHI8DoNMTgcp+
	 76q315PBL+vaN1gAnXOtgNY2AtFTJ/CQmrqyn5S4hD8FFNTQoLCWjT5j+oRO3lXa+dwWQ
	 +7L2r0tq9bgGfUEDiur/svYernQqfviKkvu2n0VdGeOLuUT56ZsnNtLlGKwWV5DEcvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AzRpwjaszZTbUcrQoza8qo0is9jked+4hTDlPEiWvOI=;
	b=sPYcg3JfnKf1UKSunQ37xBCAyA/tVoLhRCDoLVblrLsVjsUA3kHngQop8wzUUEYlf6d8
	 ZHLkpaRr5YcO1UuJHfDH3KrPLap3G81Nts2+q5cRoA5BRaCFyaBKmf0JttrpP75bj5FfI
	 HBsDkckkN6OWhVI2R9q3FjrF95f1dlEsn+agUDx+jFIyz04lIgewoIdvXc5X7kKFYL6mm
	 4JWqxBhqDbl0PRqdxCkrVtgpr8O9k1vU8UacDsUkJe8TNSxjzRgsktaaLh8Wz2OPA+702
	 TmmEvKrES8Jb0GI5UiiKJxeU1lTKt+Mj5Y5YZVwYGu/kVh6HGywhm3BqGdAYFENnr/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNcnUQNc;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC9606A32E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67BC9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNcnUQNc
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso213077a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513062; x=1795117862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzRpwjaszZTbUcrQoza8qo0is9jked+4hTDlPEiWvOI=;
        b=eNcnUQNc9dU2CE5tD0V1E9hLTv2rWhr0k31Th/8cReRIi8miMIExn9cz8+PhEiF0Sw
         EVReGjDt3Ypei84d918W76eh9PU2XSukfB7HzrbJcgB3uwj3m2LEf6emsxppLP2JdGoB
         oPFkYOXnJdlCHUn18lsTBUO7neWyEEANF8CvygmX5maIBND1Qqk+JOz7aweR/A6PjQF4
         2aUG+sYvCAOsZyeNIEM/qp/W9JWTPxR21v82IAwUPYKvPNy7CQ+MD5Qq8ySRduqfOa8L
         Mn/4nWHSY9D19BWwRkstYv6yjah6HGzRsURYyMrEUfXBHmevorMjQXlw4FXOkM9KAavg
         khfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513062; x=1795117862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AzRpwjaszZTbUcrQoza8qo0is9jked+4hTDlPEiWvOI=;
        b=vlKa8RaorpDKqvD4oxNLGEYPfGBSZBx++dgbmGsHrkbs79pkQynH2Uf3fNs2h4VgnY
         srw22QSS/THoZiE/ddpsn1U5UX6XqexYFu9YQAsOac7783bEIHPve5V9ZG2dxowKATUf
         VUV8fz3EeHOfrXA5eUHf7HComdX6TFdo04dAoUlo+P38bdt+qFPFGa0jqWeFoqLCCo98
         eKQUfRMsiUqIctf0Ftz75NcEzTHABcTPMVx35L4yW3migOC409s5naSbreD1QXv5PnSF
         Qt+E4UcMw6Fu62uytIJj3n7cfiLSkCfi+HeyodP05gp6jlSMEyOvTCQ0VHVHTIGQn1oH
         QtEQ==
X-Gm-Message-State: APuU4Z/9jpsEZNCOwMtd2O/XN/dt1sTffZeAFQF4kWZsTLcqngWUOfWp
	7aeRxxvrtwypftBs1ZELrDeaySSyvv+7p1XySYYr333FJDc62JvVJE+SVPTxAvls
X-Gm-Gg: AYBFou127ZzEUMWj4n6SLt/Lp5Bh6G4xe5hbhszbd8umc+kjvhiaMmiBQ/EhqsEH853
	rqYnZ8QAqNt/7yG0oVapUv1MjgU8T9Fg6p00AIOK1s80t0cLsOT2FTEy6m0eciKB++vTjo5MZy5
	69OxQeahqMYZMTHKoIN2EdQOd8lA+eisqdZVL6K3dbt1ShFxC6PCSYMluT4BtKye6TkGRCG+k5P
	rMt30L3bLqz0ppliSCw5eo4kd6Dc/Uk2jlNAldPXxmDMkKO2IzV4oyXQc5SXOqJDjvJ5VHKgVoC
	bP3F8SC31KrhCNVz1oZd59/4d0MbLA3+kP39WEdrkBNDAwue1MvHO70TzLgmyCiG1nbG1OAGF1d
	2jvwgxAMD+oQxfn5qvx1rMvgbiy/VTAL2cA1OiPfIOgw0y7M/DG2n0T78Qygt8T2ANPG/LXTY+I
	J5X1iwOvUKQJ0oQcn20xiwnk4o4u799sRjs4gbR+2LBJdfhfkUnT9BNROUsRouMwCx5ijGPdPZ1
	8azPJpqAhBVhruzqB+Ggfipj9CzAgcANyNtpJR0A+Sgstbvkt3SqKFRnAdpNMK3Eoq8Wcd8tvZz
	pMwAg6cQgS56Sq1umtZSSCmaMmK2Wn52LAirD+xn
X-Received: by 2002:a17:907:7b8d:b0:c46:9d50:8af0 with SMTP id a640c23a62f3a-c50963bc7ffmr29194966b.36.1794513061703;
        Thu, 12 Nov 2026 11:51:01 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:01 -0800 (PST)
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
Subject: [PATCH net v2 1/6] net: bcm4908_enet: fix the TX ring wrap
Date: Thu, 12 Nov 2026 20:50:46 +0100
Message-ID: <20261112195051.597102-2-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112195051.597102-1-kudzo51@gmail.com>
References: <20261112195051.597102-1-kudzo51@gmail.com>
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
2.56.0

