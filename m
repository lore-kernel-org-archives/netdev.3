Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513065;
	b=sfhGHf2zj1eQstoxppO5TkIiocPnZyg9LSZUE3b71sSGx4wD/tqrp7xIcFzh2vdyRrr6
	 ACh2vhRy7OiFZz8wAf6Bqd/2nPPFEMHJnQ9N1h8vTaYEwAhuWQbrQDmIst6+McdkBZJ1m
	 Ip7YPG5L1YK7OfOmGjIFE8EzRL4+JtItjyVlrODkHmKHHBpVYqhxBoSVbLrEDdf1XJOcV
	 3E3jrPiVgjLw4GzIjpxjJpKrYBvo/WV5QD6xj/o0hL9ZkVatfalOUDW2bHxlZ0rFiHdkg
	 ej9pdhRuVnD+UEHW5uydOx2oCcnnJnYaEi4IV2+vD+fxyWFEDlanVR+H8ykViX9yqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lHIWKtfmtBCOjxCfX2OCXtoPEhN9gzeNFaeY7u549Js=;
	b=mbeKVuN0TkRJG52aoU2Uoq2wtNXjwvLOtJeAVOL9SZ/zOcZ6PAIhd1VUdL39y4CcgTTG
	 w9WJouIszyARwLCIhkWRh+niDXFo2BASQoyrESdtyc2K/PU1K3XxCJrgaoMF0B+O9G/6N
	 uYxxYMF6p3b9GpXrMe6ltDOGFysrKIhIpVCELtc3bLwhtHLrtBzS6o4BgT6iL4fJq17u+
	 mtsIqAHAP6DdDGqEbJbCzxnW5bzWia1MfL12BI66fraiLhn5yOjmLCj2E8Ub2djwjgTc5
	 4nquQ5lnJTKSoJoBW+cAvsYiwvsvQKLM4LO1fd/RdHWvEk31WrvIbfO7XgdlSVjzL2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9fAf4LD;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD44606A896
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD44606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9fAf4LD
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c49c32650adso21671066b.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513063; x=1795117863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHIWKtfmtBCOjxCfX2OCXtoPEhN9gzeNFaeY7u549Js=;
        b=o9fAf4LDSUMdcFvQH7Dnhdh1Tx+tmHs5WZ9kxiJALp+sou7fcCnHuE+C+Rn9s3y9mR
         7B1u3h+ux4lsHoyVRpezTblFKwk5glCdgC7dYNii8qG8xkqTO471cG82ZXRrnITsXJgS
         Eum43606NOo0JwWFtQpLJBY8Yq9X2xJHi9cjJCklHRIXV3hrnHcT3XWZ9Jsc/zQNYFbt
         mFna6QXwHaZhWfLoXQ7ZWyCJwjYPRcf5HmYInSOlEN92Q6h259hKP5RmQzS7GnHV0ltp
         Dd2HvM4CO5AxJpGPs5WgjaN57HabFjrKdPAdYIfMC2loMTK+dMCJ2ZxnVXmHRtNndjFa
         z0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513063; x=1795117863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHIWKtfmtBCOjxCfX2OCXtoPEhN9gzeNFaeY7u549Js=;
        b=hYrut99+IyhEOkV1Z9BCnT8caPc/P/GwKXB4EeowznPQQZ9N1kCuPbXWLy+s+uJm1q
         OBMEcPLVlvBFIInaDw0zDXFzra77IEmnkvtc3U81MFaD/62IHLNpp/swH5c0ynwl62jC
         Gp2xNVNKqDYy2DdYA7x9v2zEYyKWaxYw7fNnu6mDuJ7IIb9SLakvdTYDVAV18dU7mvfQ
         0pKU057wM6FqNZrNRGfzpxSr9a3XKQCrjDILCgAneAAyNOR9Foob/rRZPLZM7q8/fvCM
         kHlJt+BRT3nOpElbas0nG9+T5Zpy2NWUP2QnV7larCRqLtQ6IgTlgHf3mdguq/Hj5/Rz
         tOPA==
X-Gm-Message-State: APuU4Z9rHamuKXg1DG6VFm1f8Nl0LTV8/limOd1Jup3HKndu5DUfD/JA
	mcx16qE8I7sgWZ9KbfqCgXtc3be7ofNwkSsBi7pL/dHCcYDqzwPbPtnucm4cMXcy
X-Gm-Gg: AYBFou3REHOGdJmzpVaq2oBYgGE+iA5y5ieAyrJaK1iHQh7Ehth67bba5IG4anIHXDA
	knj+cddzT9V8LEbeROGZ70JnoRS6oUsh8XxGeHZ/QXgfOu+kZdVRE+ddDcjN16ERjtkekvcUxoL
	EGmM8fr/5s/rW6XIyGy4oHebjG4yQDwpjbUAKr1XalpTDXU0y1FqUC+Q4ENDerGb7MUrF8s+RWG
	GtKke5H9ugocwzAKP920SUpsFcQjd1ElRoBBa7fs3ZYPa5G/gwxzQqgQuaJNToC3ldzL7V+KHfO
	Q0lseiHEoheyWHOsBLKnHrqFY5BKhgKk0lwFealgfA36eBMRaFFJvL1D/zzxiIMBHar4bD6m/E8
	yIXLT1Jz6OTprJU95Onxlw35TkPjQqwGJTF3d5gw0u4qW4Kbc9iCKW0oDlr78QfBpIj77WmOqkw
	eUeWbkwKKm1e05+NY+zsYo27ZojNv8cbosKtU5KHXRtbC9Dg7fn5iP5w5UlfAI2cU1PS8wq3Vxj
	1Os0jAtk1hkYEUYXo4e/wZKHGcCBRRsEeqcBMkhtqTagPfXLs4hXgOrbWkXOqjOZ0I8HZFyOEOj
	3TvIOS7uG4k8d0EeJiudUSFfzKYc6zqDNWYdQxyd
X-Received: by 2002:a17:907:c13:b0:c29:f5d5:5a97 with SMTP id a640c23a62f3a-c5096442d6bmr25370966b.33.1794513063267;
        Thu, 12 Nov 2026 11:51:03 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:02 -0800 (PST)
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
Subject: [PATCH net v2 3/6] net: bcm4908_enet: release the TX ring on stop
Date: Thu, 12 Nov 2026 20:50:48 +0100
Message-ID: <20261112195051.597102-4-kudzo51@gmail.com>
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

bcm4908_enet_stop() disables the TX DMA but leaves the ring as it is:
the skbs that poll_tx() has not freed yet stay mapped and are never
freed, and the descriptors the DMA has not sent yet keep
DMA_CTL_STATUS_OWN. The skbs, the socket memory they hold and their
mappings leak. The next open starts the indexes from 0 again over
those descriptors, so the DMA may send stale frames from before the
stop, and if the first descriptor still has OWN, start_xmit() stops
the queue before it enables the DMA, with nothing left to wake it.

Wait for the TX DMA channel to stop, as is already done for RX, then
unmap and free the skbs between read_idx and write_idx, and clear the
TX descriptors when the ring is initialised. A descriptor that
start_xmit() is about to use then never carries OWN, so drop the check
that stopped the queue on one. The RX helper's timeout warning said
TX; make it say RX.

Found by reading the code; I have not seen these on the hardware.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 46 ++++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index b1738d954..a28adef03 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -313,6 +313,11 @@ static void bcm4908_enet_dma_ring_init(struct bcm4908_enet *enet,
 	enet_write(enet, ring->st_ram_block + ENET_DMA_CH_STATE_RAM_BASE_DESC_PTR,
 		   (uint32_t)ring->dma_addr);
 
+	/* A descriptor the stopped DMA never completed still carries OWN */
+	if (ring->is_tx)
+		memset(ring->buf_desc, 0,
+		       ring->length * sizeof(*ring->buf_desc));
+
 	ring->read_idx = 0;
 	ring->write_idx = 0;
 }
@@ -365,7 +370,22 @@ static void bcm4908_enet_dma_tx_ring_enable(struct bcm4908_enet *enet,
 static void bcm4908_enet_dma_tx_ring_disable(struct bcm4908_enet *enet,
 					     struct bcm4908_enet_dma_ring *ring)
 {
+	unsigned long deadline;
+	u32 tmp;
+
 	enet_write(enet, ring->cfg_block + ENET_DMA_CH_CFG, 0);
+
+	/* Wait for the channel to stop, as for RX, before freeing buffers */
+	deadline = jiffies + usecs_to_jiffies(2000);
+	do {
+		tmp = enet_read(enet, ring->cfg_block + ENET_DMA_CH_CFG);
+		if (!(tmp & ENET_DMA_CH_CFG_ENABLE))
+			return;
+		enet_write(enet, ring->cfg_block + ENET_DMA_CH_CFG, 0);
+		usleep_range(10, 30);
+	} while (!time_after_eq(jiffies, deadline));
+
+	dev_warn(enet->dev, "Timeout waiting for DMA TX stop\n");
 }
 
 static void bcm4908_enet_dma_rx_ring_enable(struct bcm4908_enet *enet,
@@ -391,7 +411,7 @@ static void bcm4908_enet_dma_rx_ring_disable(struct bcm4908_enet *enet,
 		usleep_range(10, 30);
 	} while (!time_after_eq(jiffies, deadline));
 
-	dev_warn(enet->dev, "Timeout waiting for DMA TX stop\n");
+	dev_warn(enet->dev, "Timeout waiting for DMA RX stop\n");
 }
 
 /***
@@ -496,6 +516,21 @@ static int bcm4908_enet_open(struct net_device *netdev)
 	return 0;
 }
 
+static void bcm4908_enet_tx_ring_clean(struct bcm4908_enet *enet)
+{
+	struct bcm4908_enet_dma_ring *tx_ring = &enet->tx_ring;
+	struct device *dev = enet->dev;
+	int i;
+
+	for (i = tx_ring->read_idx; i != tx_ring->write_idx;
+	     i = i == tx_ring->length - 1 ? 0 : i + 1) {
+		struct bcm4908_enet_dma_ring_slot *slot = &tx_ring->slots[i];
+
+		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
+		dev_kfree_skb_any(slot->skb);
+	}
+}
+
 static int bcm4908_enet_stop(struct net_device *netdev)
 {
 	struct bcm4908_enet *enet = netdev_priv(netdev);
@@ -511,6 +546,7 @@ static int bcm4908_enet_stop(struct net_device *netdev)
 	bcm4908_enet_dma_rx_ring_disable(enet, &enet->rx_ring);
 	bcm4908_enet_dma_tx_ring_disable(enet, &enet->tx_ring);
 
+	bcm4908_enet_tx_ring_clean(enet);
 	bcm4908_enet_dma_uninit(enet);
 
 	free_irq(enet->irq_tx, enet);
@@ -549,13 +585,6 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	if (!netif_txq_maybe_stop(txq, bcm4908_enet_tx_free_descs(ring), 1, 1))
 		return NETDEV_TX_BUSY;
 
-	/* Hardware removes OWN bit after sending data */
-	buf_desc = &ring->buf_desc[ring->write_idx];
-	if (unlikely(le32_to_cpu(buf_desc->ctl) & DMA_CTL_STATUS_OWN)) {
-		netif_stop_queue(netdev);
-		return NETDEV_TX_BUSY;
-	}
-
 	dma_addr = dma_map_single(dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(dev, dma_addr))) {
 		dev_kfree_skb_any(skb);
@@ -563,6 +592,7 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 		return NETDEV_TX_OK;
 	}
 
+	buf_desc = &ring->buf_desc[ring->write_idx];
 	slot = &ring->slots[ring->write_idx];
 	slot->skb = skb;
 	slot->len = skb->len;
-- 
2.56.0

