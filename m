Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268633;
	b=PGc7vhrlZCDkibnpKR0sjN0XFqeaiUV92Nx4x8hgm47J2sikbdlIByhKCfYm/pQQoGg1
	 VhGi/E2t3D6tq89VPxcA2tgJGMwXQCQy9eI9EUBF3rbhlPcvb9UXHFGL0z8pyDouuhmev
	 kJorgKXns2LguDObqoFrWml7cAFLQKApes5Syu0ZRLvDDqOOhtoXIUGfabv1R8REgDSAG
	 UZgymDxIk+qbV+0YE8DHaLLfvP5Av+9oDgRXAYPpuHotrMDAMzHs49nHSJqBqIMWIvKPu
	 ziTWakHgWgKusVzGoXUtBX3lsPnkNYkt2zDYs5Boet2gl6le96Q84g/MpcaX7/0Qb1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O8eQPRbmSM0PxKcsSe9CO6QxZj9GQ3yxigAUlLTkIWA=;
	b=UlUyubOhkBe5Skrif0qpfDIw8xCAPpzKevQ+9jYWRC9JdAZmV994x0Ugh2DxHaRzqt9v
	 rQI8QOMvqrpPyEKl5tyhqSNXU3HTpEIBCU3vpk5EWkKZeGkzMYr1YjBPsvJNDNktRHq+3
	 S77GOZPnF13skajYyuP6yAoL/ym1axlzPvtVn8mK+e9O4aR69+0K7OpoW1sAgXjYK4rJ0
	 JJfAGgl59nlAU44HA/MKMmEKvWCEhnwDuUtxPOFZeR9E43jrFpp2B674uxihCuEek81cZ
	 QWo3Qs0JT1vF0CMaMMOfvhwOgfHfajyQSab20Vdg4FQH/PS77L1GQYXk6JK2ywJVk/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="At/u6aRN";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545B60A261E
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D545B60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At/u6aRN
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c504bfd7393so27270266b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268631; x=1794873431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8eQPRbmSM0PxKcsSe9CO6QxZj9GQ3yxigAUlLTkIWA=;
        b=At/u6aRNyBVweiy0zcEZwIIjIwwRPUKr7TZTlhF3hR/w6ck5wyxNzvcf0y6+Q6CMpT
         xGPHXBQKyv1NG/g94tG7dSS8v2pn62qVUMLZN5U1mHQSSZW3UkW4wTvciQG/qSf9c2HF
         Gb/XUFNbnEqSY0whRhrU2A1YnXSdzHT1WcMhnMwuUbmT5ZyfAqVA5EMY9GSSobU+/Z+4
         /3YXWVTz9VA3x4eu6gT/m/7dodNNNgKuZJkKpTKWBi3GXQihbMwLinydfE6VDUnWIcpC
         2alfIvukef/cqDoL7FDKWYsPC9ZoWJWOJJfVWNNWxBn47E0cJ/wI2lht2lxW2Qhp2TyL
         eYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268631; x=1794873431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8eQPRbmSM0PxKcsSe9CO6QxZj9GQ3yxigAUlLTkIWA=;
        b=c1H8n2gOWCu7eOWnPbYScHeV6KHPOs51cPnyImSCCLn132jbTwI40223cHAnwjUZ4w
         DeATi/ctUb6H0tFXPAVmDvRHFiq+nTO8MZL8zFmQ7RlmVXxQA0IDfTJDrxPjHAgNaL7e
         ANKDgaa/rRl8apMfKzm8AI0+VdnS+TOCgYj7Mg7UEsmlbj4W7/kaqhPkFwj8hKjnxY5g
         ZegyHE1qa+f0LsrEJXv+ZFjMSzOsuRoXAlJkc4dwn54IxZPIUC+MBNxXU8aPrMMeSebL
         Wb4R7tCUhpxB6E4wRgMXluSZPms6A1oSEac/5V9MhRYzE9mOrtzHqFWPH1Ve2j69N2MN
         hLNw==
X-Gm-Message-State: APuU4Z8mVd6wC82476cdBDDhILAtNfOzY0MjKbTwB2OVUOalPc85QAIz
	Wj07N0SRSfk2u9PgwOvv1weD99kGdQ5nPHQa9PY1qFB+nt2niaWu7ZORdtSdg8K/
X-Gm-Gg: AYBFou2Wj98SIVHvtJUVtO8tLL49OoSkA8Ijpyoa2RK97Vta/W3+IZVUTQJ7VfhYlnH
	Xvs/ylEwY9yj8KgRPHP+iig/i4y4GMHX9ebX3WwYgg5VUuPUYUqdD4J5F+H/9Z0Nox8TjO6fXP3
	i/VmTiAsacmH6gQznXG5TxXKWBySZyNJLX4VptcSUBcvOnzldoRpguegFPUsEpod9js8NloSX5j
	KoehPvP8hSO34h4Bw+e4G5A9TpFOvBoMqOdx4th5JUzjtinHIl1cD27vzB7le9Lobm44Rt5el/R
	uh++fv3p2D6YTh1vA65vjYFw2NETEC7L4CXfQo0a9lBBuVhz+969Bu6V+m2czbC4l6Yz9rOeXJx
	LoBzYPqD8n3kTkrNqm7SeXHrPBmcqg3qq+n/+fNU9i/mJhJ8wMML7cZnyCmmStVo7IIJHaOdRfW
	ynxwH0qHZPvrbncTUFLupH9IN4UTQCzFp2vZx5CDn9C7edVaOdJgGqDKzV0mvnCLWvpk4mY8dBi
	p+El/uLIjdFcToJe9Km13ZiTfZyQNmNhgBh+95Na4B4BFnYCgqykCjgZSrO1dpNne/69fB09dAx
	GjYy72hqp9sSx6KHu8Ahhj9ricNYCjKkShFphTYyepKwC6MmR9tmizaOQIYrjPLvI5XP01nP+LH
	p
X-Received: by 2002:a17:906:3db:b0:c3f:c878:7c1d with SMTP id a640c23a62f3a-c50494f374emr55535466b.9.1794268631110;
        Mon, 09 Nov 2026 15:57:11 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:10 -0800 (PST)
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
Subject: [PATCH net 3/7] net: bcm4908_enet: release the TX ring on stop
Date: Tue, 10 Nov 2026 00:56:56 +0100
Message-ID: <20261109235700.2586821-4-kudzo51@gmail.com>
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

bcm4908_enet_stop() disables the TX DMA but leaves the ring as it is:
the skbs of frames not completed yet stay mapped and are never freed,
and their descriptors keep DMA_CTL_STATUS_OWN. The next open starts
the indexes from 0 again over those descriptors, so the DMA can send
from a buffer that has been freed, and start_xmit() finds OWN set on a
slot it is about to use.

Unmap and free the skbs left in the TX ring on stop, clear slot->skb
once poll_tx() has freed it, and clear the TX descriptors when the ring
is initialised.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 727ad1e96..8008b44a4 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -312,6 +312,10 @@ static void bcm4908_enet_dma_ring_init(struct bcm4908_enet *enet,
 	enet_write(enet, ring->st_ram_block + ENET_DMA_CH_STATE_RAM_BASE_DESC_PTR,
 		   (uint32_t)ring->dma_addr);
 
+	/* A descriptor the stopped DMA never completed still carries OWN */
+	if (ring->is_tx)
+		memset(ring->cpu_addr, 0, ring->length * sizeof(*ring->buf_desc));
+
 	ring->read_idx = 0;
 	ring->write_idx = 0;
 }
@@ -495,6 +499,23 @@ static int bcm4908_enet_open(struct net_device *netdev)
 	return 0;
 }
 
+static void bcm4908_enet_tx_ring_clean(struct bcm4908_enet *enet)
+{
+	struct bcm4908_enet_dma_ring *tx_ring = &enet->tx_ring;
+	struct device *dev = enet->dev;
+	int i;
+
+	for (i = 0; i < tx_ring->length; i++) {
+		struct bcm4908_enet_dma_ring_slot *slot = &tx_ring->slots[i];
+
+		if (!slot->skb)
+			continue;
+		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
+		dev_kfree_skb_any(slot->skb);
+		slot->skb = NULL;
+	}
+}
+
 static int bcm4908_enet_stop(struct net_device *netdev)
 {
 	struct bcm4908_enet *enet = netdev_priv(netdev);
@@ -510,6 +531,7 @@ static int bcm4908_enet_stop(struct net_device *netdev)
 	bcm4908_enet_dma_rx_ring_disable(enet, &enet->rx_ring);
 	bcm4908_enet_dma_tx_ring_disable(enet, &enet->tx_ring);
 
+	bcm4908_enet_tx_ring_clean(enet);
 	bcm4908_enet_dma_uninit(enet);
 
 	free_irq(enet->irq_tx, enet);
@@ -686,6 +708,7 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 
 		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
 		dev_kfree_skb(slot->skb);
+		slot->skb = NULL;
 
 		handled++;
 		bytes += slot->len;
-- 
2.56.0

