Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268632;
	b=gO+kiL5/cXOVwKICmtPYGNuZzRahwsjul641c+4uJzqbqSsWqxJlXop8efLG0IHERjyD
	 2ZIksM5KU6YFtjUv8kfVGqh0VG2xqD0MyMJDqHfs2ATGT+BMXVFeRSN3NSaWzu2Pc2/wR
	 iWhDQohNQM97E90sd8NWDQx3J+lvKjHi4jgchpEfiJz0VN8a/M/prfwbN/+fXQnPTNTfd
	 QIoktFZDxoJ1/Vl8XkLPRS0e6cUq4VFlMvj7tDYkSDGcfYfppUcuxzDBmc+KdqM22ZRok
	 lFeGpmavHRQqvkJB4+jaW55NTkeW3Y+s62wGQ7uCvd+V73kpneUIHXMbzjJ/izQEXVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ncaad3j/dxgibE3927tLBSEquBTsdAGZ7shltnhjFtY=;
	b=2CtMEPjdfqOPlOwi7vr56u9tmqLb1+B+DaXe0kXwXPWk4K7PhrRetZW3UP1n5NhRriZ+
	 EoRxkuxkjCaGmDMS2M1z2mazAforL3PRbcxwL92LviT4dGVJZInlsfR5rQl77rcxAwwWV
	 p6KNTu3glGNRmIWBKdj/l2mSnP2Dxe+Eo0iLgdpWUsUpKr5ozCKgJrKjOgX6LvtYJEYNG
	 WVBV/rlZA0c+u2M+cm2FfwjcsbuggT4gjK/e0XLGI36ZRR8PPoix6SZxpx2/gleAj5KZM
	 TXGc/yuRuVQYRsJ5sUwvGOCCHSvL5EBt4Ttp7mAVip8znHDOMDSlVjPBETR0uuU9J3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JciWTFuw;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C1606A33D
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965C1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JciWTFuw
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40e30c26a4so214988166b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268630; x=1794873430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ncaad3j/dxgibE3927tLBSEquBTsdAGZ7shltnhjFtY=;
        b=JciWTFuwNRvXqnYoL5ENEGUB5QBsSjsowHfjUTawSpm4aGcCsueJkINjZPNwMiXONZ
         O/GjVrYxOQN/il1bI4x9hQP1yHPvmkXkDUYu3vl0VUvzmtovMpJhU5Rx/46WHJAfCWgQ
         wKlNxKsPMH7ISr2KSjnriMgnKiLGwFNdNVBi+0Y1Ctge2dze9pAm9Rl+yFt442rOwlAB
         JcI4xcOI6asAMO9/iNLv3ldXDRxHUZhiQRQUmzVqmmNwnEEBHXHjaRT3q24trFFk7ayg
         4kIISoitUXm8I/ybuK53YQgLLfGUiynJp0eXT3t2YjQq46iGZMBRqwcSsiptiRsvmecb
         WgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268630; x=1794873430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ncaad3j/dxgibE3927tLBSEquBTsdAGZ7shltnhjFtY=;
        b=eo9t7B03sFxIPmyQfTJIK2V8xyygUNPFLg/XZcaECEL+TC/CFJEs1oze8XjalY8oKo
         BseMNoM1d+21hnZm+sfNdV3yPxgpEy8C6H8dAzLEuCq/8iuJ94lbMDV9ZuuCmwBy52Pw
         HmqHj+rl2dxSRWK9Sp8CdH/9W/4soFMwF53Yu6ZvhGyJM0mXjhcKhw2SGeEMA2xnsX91
         455UQNxTf6Aa2sw/FHRR01OZI4ZhgXAi7ogcAxLJ0iKVpj8rDLDwY6VRwEJQ65dcJLpv
         hkkNtq/2tO3KNIchTUJPsXSR9dnbjvk3bi50NnbVYzYs7wfiy7k5/rpDjT4hi1iUYMjG
         1okQ==
X-Gm-Message-State: APuU4Z+UXROyGy5sEL0aeVaCPv4mlpagH2jgg/GPdF5YhlMfM3HaNeMc
	nZMXqe1ebki54Lc4/GiolrQ34dY3+U+WgnVj1rZJH0P9EAS1DTWAfb5TAFg3i8SB
X-Gm-Gg: AYBFou3Cd5aO8x3utCuUGvpjh1Hp+9pwm/0A+Ij9B+O2m2rrDzOmctZOoQRiTvL64Tr
	m7rByPfbZev/9j2o5ML2kKieGT51DWLuQO3vrCnidYMz2lbFnEkxFVop9md2NSLLKMsyu8xM9I5
	OOBKmadUqJqrDb52phuZ786ZsHYUxVkyoyiYHNBWbWa3HGqxzjTAQ1ixlYYjz5/qnVAqZw1ppsS
	EHhsF3rqfZwkGxE6OSS6XnoDW2XsJfgRNo7W2tkzjT8+FRTx6UlLVsBvQ4Fe6dqreR6xzAy62Yy
	ua9YwgpYIWhai2YelPmVw0ITbjb+dX7kEwcmagLyBxCIKpwEEB4ik9IDsfYvoeVlnaa5KzSJvF6
	2fTBjaGCJePnUVvaObSeonyiG3xOhFDCRiwmE/CMCv8UW4l+RYrAzVZ/+R91zRVBJp3czeLRMKh
	mydF9G5sjRkhewVKDRJaCgyU/hfHcqlfwe+WuR+xDp3Y0bl4tRSgKw3C412SbtVnbjTFkXGi5p4
	VCJWZh4XbPnB3KDYYy8tIaDplJ0tkHeHpCBillpQkQ2L9LbQ3rJc+nkPe6eWhuefuqJHnpTuraz
	pSrft0aOHN2tJNy3D92/7tdPbuyHfv3XRpDSS0y/XiNfLEZf9Br0wYTU
X-Received: by 2002:a17:906:ae8b:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c50496a9c15mr52726066b.18.1794268629784;
        Mon, 09 Nov 2026 15:57:09 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:09 -0800 (PST)
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
Subject: [PATCH net 1/7] net: bcm4908_enet: fix the TX ring wrap
Date: Tue, 10 Nov 2026 00:56:54 +0100
Message-ID: <20261109235700.2586821-2-kudzo51@gmail.com>
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

start_xmit() wraps write_idx at length - 1 and sets WRAP on the
descriptor at length - 2, while poll_tx() wraps read_idx at length,
and the free descriptor count is taken from length. With read_idx at 0
and write_idx at length - 2 the count comes out as 2, the frame is
queued and write_idx wraps to 0 == read_idx: a full ring looks empty.
The following frames overwrite slots whose skbs were never unmapped
or freed, their bytes stay in BQL, and the queue stops for good with
nothing left to wake it.

On a TP-Link Archer AX6000 this stopped all wired traffic under
sustained TX load (about 1.4 Gbit/s through the switch's CPU port):
tx_packets froze, nothing was logged, and BQL showed about 185 KB in
flight against a limit of about 10 KB.

Use every descriptor, with WRAP on the last one, wrap both indexes at
length and keep one descriptor free, so that read_idx == write_idx can
only mean an empty ring. Stop the queue as soon as the ring is full
and wake it from poll_tx() once there is room again, with the usual
barrier pairing.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 52 +++++++++++++-------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index fd2715f84..01a3e1d01 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -518,6 +518,16 @@ static int bcm4908_enet_stop(struct net_device *netdev)
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
 	struct bcm4908_enet *enet = netdev_priv(netdev);
@@ -525,20 +535,14 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	struct bcm4908_enet_dma_ring_slot *slot;
 	struct device *dev = enet->dev;
 	struct bcm4908_enet_dma_ring_bd *buf_desc;
-	int free_buf_descs;
 	u32 tmp;
 
 	/* Free transmitted skbs */
 	if (enet->irq_tx < 0 &&
-	    !(le32_to_cpu(ring->buf_desc[ring->read_idx].ctl) & DMA_CTL_STATUS_OWN))
+	    !(le32_to_cpu(ring->buf_desc[READ_ONCE(ring->read_idx)].ctl) & DMA_CTL_STATUS_OWN))
 		napi_schedule(&enet->tx_ring.napi);
 
-	/* Don't use the last empty buf descriptor */
-	if (ring->read_idx <= ring->write_idx)
-		free_buf_descs = ring->read_idx - ring->write_idx + ring->length;
-	else
-		free_buf_descs = ring->read_idx - ring->write_idx;
-	if (free_buf_descs < 2) {
+	if (unlikely(bcm4908_enet_tx_free_descs(ring) < 1)) {
 		netif_stop_queue(netdev);
 		return NETDEV_TX_BUSY;
 	}
@@ -562,7 +566,7 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	tmp |= DMA_CTL_STATUS_SOP;
 	tmp |= DMA_CTL_STATUS_EOP;
 	tmp |= DMA_CTL_STATUS_APPEND_CRC;
-	if (ring->write_idx + 1 == ring->length - 1)
+	if (ring->write_idx == ring->length - 1)
 		tmp |= DMA_CTL_STATUS_WRAP;
 
 	netdev_sent_queue(enet->netdev, skb->len);
@@ -572,8 +576,17 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 
 	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
 
-	if (++ring->write_idx == ring->length - 1)
-		ring->write_idx = 0;
+	WRITE_ONCE(ring->write_idx,
+		   ring->write_idx == ring->length - 1 ? 0 : ring->write_idx + 1);
+
+	/* Stop while the ring is full; poll_tx() wakes the queue once there is room */
+	if (unlikely(bcm4908_enet_tx_free_descs(ring) < 1)) {
+		netif_stop_queue(netdev);
+		/* Pairs with smp_mb() in poll_tx(), which may have freed descriptors meanwhile */
+		smp_mb();
+		if (bcm4908_enet_tx_free_descs(ring) >= 1)
+			netif_start_queue(netdev);
+	}
 
 	return NETDEV_TX_OK;
 }
@@ -655,14 +668,15 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
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
@@ -670,9 +684,10 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 		handled++;
 		bytes += slot->len;
 
-		if (++tx_ring->read_idx == tx_ring->length)
-			tx_ring->read_idx = 0;
+		if (++read_idx == tx_ring->length)
+			read_idx = 0;
 	}
+	WRITE_ONCE(tx_ring->read_idx, read_idx);
 
 	netdev_completed_queue(enet->netdev, handled, bytes);
 	enet->netdev->stats.tx_packets += handled;
@@ -683,7 +698,10 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
 		bcm4908_enet_dma_ring_intrs_on(enet, tx_ring);
 	}
 
-	if (netif_queue_stopped(enet->netdev))
+	/* Pairs with smp_mb() in start_xmit() after it stopped the queue */
+	smp_mb();
+	if (netif_queue_stopped(enet->netdev) &&
+	    bcm4908_enet_tx_free_descs(tx_ring) >= 1)
 		netif_wake_queue(enet->netdev);
 
 	return handled;
-- 
2.56.0

