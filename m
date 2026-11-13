Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614344;
	b=LcN52C3B8bpSKhlHeo0DHPT9P/w/typGRcAI5EzOLPofKSGlJN6So/ZpHexJxfODiarA
	 U1QEpMD+IPanF5qsG0HoiJJbMftuH9MKzGttWdSGVzDrULOtzhNggtydyvomCVcnNyg0P
	 Wdf7fdooC22vGfv+QdoaDFg92Vtx43vMlCAYxYtbhfyl5vjvomesg1qa24iXBVdyoltG2
	 BplARfMCtn2Wfy5ZNXcF69a13HOv2v1BeBpn1ZeDv3k8hTgeGeX7aoZJyal1L4PstB2AL
	 re0z3m2K0k1essMxHkmY1Bq0kRWu8dDL6Ld34UaUYyTHC20OBvRKqAJCj6lHCq1OjUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=03cfRwW20HnLIQ4dPEfEnQV9npGpZQBZ+HSNkuXkdps=;
	b=PDUSY5fxmBfkNS+CbW0yo+tq3TCE5WOnnMDSNxsaX3xqMuj2FWg3n3pa6dROuIdo+Vh+
	 12jR4ZieVfY86EuXfOR/t0cxUpNNZYNPcQ7dnI91aKgDvJNCP39TVFFUDh23pYBPCsaA+
	 GfRz/q6OUYbwVz7GPacKAvW77u3ZKabNruzmE92K7OGoo2o/p8VMcSbciWaEFyETl6v1I
	 h0woqOSWZnwHt4XY/LxiD9aP8i7jtBxDIIbiHoTkbdFwuk/0OyuALMdoxhjTixhXw8d5g
	 6LvD2igt8ev1ZHx5ZiN6RVpyECEX/MYCcgP0MqADmIcy/q/QRSvKoWUIoTmfInSQORQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx+r7Da0;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212A606A8A4
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8212A606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx+r7Da0
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d30639709so276127766b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614337; x=1795219137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03cfRwW20HnLIQ4dPEfEnQV9npGpZQBZ+HSNkuXkdps=;
        b=Xx+r7Da0fTyvLK1Xbu14XQZMcmFDLgsAHCf5n+TPmyVa+EGiAC68h1pmwxiGt6rfG4
         ncjx5LwWrGAuQXeD6m9cwI3NbmgLy/BPkKPi7LsmPmJtfJQfpvn0UFU5r5zYGtidvjSG
         bAwrSPoKOsP03MeoSEDy42r+EUf94CNr/hLianDfGWmGYJdQlxU9utsLS/auSQ72HGqJ
         1b0WZsmW1MH2EJCyYKMVSyWu91b0TtXUoAax20ojiNCx9SawzhXyoSWxtFQ+p+b7vwKK
         zz2ZxQRHSwA3H7Mo6dU9PRMgAaANkPYKQm6egKhrtHZKkZ7ODge2svrVSi6gc59/LQe3
         Eirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614337; x=1795219137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=03cfRwW20HnLIQ4dPEfEnQV9npGpZQBZ+HSNkuXkdps=;
        b=ee5WGFhOLjwMOs4p2PNPmfLexOtYpTgOUkzOSFjwys6lGhixT/mjn5xMopGDpENuK7
         R0MxXW9Fwy2b3UrWBEL9+cdMweLjx0QMcfCBWcptakq1/nLPjvJJuap5BI2UhzCbOutV
         3/UM3anc/v5RUfILIyuocT0gnAHunkQEo4rsWfagvvEHdCj6GNbKciYWlni40ZLDQ5a0
         LtQIzUHwkLjAzIygujQVqRbtvBHV7gYqe7WDuJ1xHnwpNyRl2TkJ3/AwCzd5cR2I3Mvf
         3K+dqNZRN47RTL3dX9sW9SaFaGlDyEEGoD7T9foUYwDNkAUr0qiLDs7U+nywccbaBd82
         UVsA==
X-Gm-Message-State: APuU4Z/KJeRFMvTT9rinwGlx6jMafGZIxV29w6B6OqUzEdeRlBUhPSay
	ITN0EMvet4i7Zxx3tZr9R2akY7GDtxVpt3/ytLHqSN+pOZ15Tkvwy+YAUGu+j/PJ
X-Gm-Gg: AYBFou2R08udEjJjU0s26tFhjbuD2gZVQ4fAZ2GpiAIGoD/JKA8bMctqlffJLW6JLY/
	f2Ou6Vclvc876kBICAAeeGkARYvTr9LfwprxZPG0Ke0R6AoJgcrvcdBXOQpWnqt+vkSPbLTXjgH
	4vspgZxpY9ymRoiGGc/aD0KV0tuZtYqw2lQjOhn0mA6WqAc/KuJ7vxl5FaWw1eZ38mg5RvaymwW
	+Y+ULXJegsPs91Zn9wpGSUb7oFkUle+zuyJeRBZwzxD+ko4BVN+d08VsbN++H48eaF6xd8vtGSz
	oO072tskJPznPXOgnQPYsSJu76MmFSWVs7DhsVwvnkQ9/TgeRnCxmrpdLf2Ad1CxCnJxU7+TIhu
	E5OnoCuHcsupaj2UKYr4Hio3r/o2aqCwqYIalb+15hbvsZFLchVLsyZaYyJiGBexoGLi91Pny2I
	mzCUmBeBDv4d1LqRjVg9snWz/tp37+x6YCVmjpVAq3Vp7P1O/hJvykjJurCJrQdYpPyYKzDuHmQ
	8hIYMfYQUFv+hkF+H7hMITeuskUPTTlrSRvi8TpJhW5z6NBA1QiRwhnNTdNGzcUJWcL85VG9afA
	0J8VixT65lkVLqthmw/vPWHsikAigNTpVbVIab49
X-Received: by 2002:a17:907:2d9e:b0:c31:e9b7:f10b with SMTP id a640c23a62f3a-c509664589fmr345497666b.42.1794614336882;
        Fri, 13 Nov 2026 15:58:56 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:58:56 -0800 (PST)
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
Subject: [PATCH net v3 2/7] net: bcm4908_enet: drop a TX frame whose DMA mapping failed
Date: Sat, 14 Nov 2026 00:58:42 +0100
Message-ID: <20261113235847.517308-3-kudzo51@gmail.com>
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

When dma_map_single() fails, start_xmit() returns NETDEV_TX_BUSY with
the queue still running, after it has already stored the skb in the
slot. Documentation/networking/driver.rst treats NETDEV_TX_BUSY under
normal circumstances as a hard error, and a driver that returns it must
not keep any reference to the skb. Here the stack requeues the frame
and retries it while the slot still points at it. Drop the frame
instead: free the skb, count it as dropped and return NETDEV_TX_OK.
Map the buffer before the slot is touched.

Found by reading the code.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 60f711e8c..b1738d954 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -537,6 +537,7 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	struct bcm4908_enet_dma_ring_slot *slot;
 	struct device *dev = enet->dev;
 	struct bcm4908_enet_dma_ring_bd *buf_desc;
+	dma_addr_t dma_addr;
 	u32 tmp;
 
 	/* Free transmitted skbs */
@@ -555,12 +556,17 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 		return NETDEV_TX_BUSY;
 	}
 
+	dma_addr = dma_map_single(dev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, dma_addr))) {
+		dev_kfree_skb_any(skb);
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
 	slot = &ring->slots[ring->write_idx];
 	slot->skb = skb;
 	slot->len = skb->len;
-	slot->dma_addr = dma_map_single(dev, skb->data, skb->len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, slot->dma_addr)))
-		return NETDEV_TX_BUSY;
+	slot->dma_addr = dma_addr;
 
 	tmp = skb->len << DMA_CTL_LEN_DESC_BUFLENGTH_SHIFT;
 	tmp |= DMA_CTL_STATUS_OWN;
-- 
2.56.1

