Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F1473C8D;
	Mon, 12 Oct 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795663; cv=none; b=OwUmKeuygkL6wA82ZSTQOkt1WTGa7foO/bGiCkRqlQQlqA/RnJcvlKNXtUpQY1P7Ap4+roZ35iX8YOa1Tvfq7IXIMFuV1W3id8yuFrl3xGlLOUlw1B5QtA7uEYzcEtpMCgWJzfZbJiDnjCW221OoBJOMuVb6X3nuQG1xK4f2DlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795663; c=relaxed/simple;
	bh=3UGiT8vfID69aSPRnpGzaBu4Fe1jVfUdgliOlbi+G1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lv5cSXQLWqt0GmWEwc0bX8zjTbLAmWYWnmoVfjtfaPEeyU9dYtdBTCjru/qJWoUYN7d+w+ioHvF4ItrvFtIHpE6qTd9t3YaOyQCsP6hWa+1TX334aZp8oM6U5YBd7BesLoC1qEbJOxSEaQ8EEfOAqV4XJAP24MF0hKRE9HceS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=frJblxUF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="frJblxUF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0333CA1587;
	Mon, 12 Oct 2026 11:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791795656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BlTzfrrjU3+JZ6dj/4XJf/Amt/9d56b47b3asdMR3e4=;
	b=frJblxUFMiq+G/NGiODmJfUgv3Fu38k5q6YrNJ056dU9GdDmlBXt62CogWamjO10ijPvj1
	PUmKvYZov4IQJVbO4cqn5pmGk0ZRLTixLwqVnsEi3VmhkbCWSLBb6QuAMQZmwK1XRNBhyM
	wrUzIya93alxRbNIAFPgDX3DbnvnaEtHw/usNLVGJOlhi9i2yV/GIPcOOLie8W14UN75a+
	A9/qDIMrHVW/2FVac8TLEnVf9IkD2DsUJOZ1YBH1dbNva3jMopmzUvYTaRqVAzDGv4ox29
	NGOF1KSL35TrfxSz6b8G0wyhwGU4AlOkjpr6PzM8tr8SXHdKyXHf1m3uCjhBZQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 12 Oct 2026 11:00:42 +0200
Subject: [PATCH net-next v4 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nb-genet-mtu-nn-v2-v4-6-2e2e3bfaf8cc@tipi-net.de>
References: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A frame that ends a few bytes past the transmit packet ready threshold
stops the transmitter as soon as a shorter frame follows. Tx DMA then
refuses to halt, so every later bcmgenet_init_dma() fails and the interface
cannot be opened again. IP fragmentation generates that pattern on every
datagram, full frames and a short tail.

The window starts one byte past the threshold and widens with it. On a v5
it ends 28, 32 and 46 bytes past thresholds of 2560, 3584 and 3840. Link
speed makes no difference. Pad frames landing in it to 64 bytes past the
threshold, rounded up from the widest window seen. The threshold goes by
skb->len, it does not count the 64 byte status block the driver prepends
later, measured at 0x80 and 0xf0.

Padding must not push a frame past what the peer accepts. Linux does not
bound how many VLAN tags a frame carries, so measure against the longest
frame the MAC has to accept rather than a tag count. For the MTUs where
such a frame would land in the window, lower the threshold instead. All
other MTUs keep the register maximum, and at or below ETH_DATA_LEN the
reset value stays, so an unchanged MTU keeps the threshold it always had.
Nothing reaches either path until a later patch raises dev->max_mtu.

The MAC inserts a checksum only into a frame it holds in full. A frame
longer than the threshold gets its checksum computed in software.
ether_setup() leaves IFF_TX_SKB_SHARING set, so unshare before either path
writes to the frame.

The padding is appended to the frame, so a protocol that locates data from
the end of it, such as a DSA tail tag or a PRP trailer, sees the zeros
instead. Nothing below an MTU of 3809 is affected, since no frame reaches
the window there. Above it the alternatives are dropping the frame or
leaving the transmitter stalled.

Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 66 ++++++++++++++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 9b9ce33f081a..e00661b2414b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -59,6 +59,11 @@
 #define ENET_THLD_DEFAULT	0x80
 #define ENET_THLD_MAX		0xf0
 
+/* A frame ending just past the transmit threshold stops the transmitter once
+ * a shorter frame follows, so pad frames that land there this far past it.
+ */
+#define ENET_TX_SAFE_MARGIN	64
+
 /* Page pool RX buffer layout:
  * RSB(64) + pad(2) | frame data | skb_shared_info
  * The HW writes the 64B RSB before every descriptor of a frame. Only the
@@ -2176,6 +2181,42 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
+	/* Both paths below write to the frame, which ether_setup() lets the
+	 * stack share. Match their conditions so nothing else is copied.
+	 */
+	if (unlikely(skb->len > priv->tx_thld_len &&
+		     (skb->ip_summed == CHECKSUM_PARTIAL ||
+		      skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN))) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb) {
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			goto drop;
+		}
+	}
+
+	/* The MAC only inserts a checksum into a frame it holds in full, and
+	 * silently drops a longer one, so fall back to software.
+	 */
+	if (unlikely(skb->len > priv->tx_thld_len) &&
+	    skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (skb_checksum_help(skb)) {
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			dev_kfree_skb_any(skb);
+			goto drop;
+		}
+	}
+
+	/* Keep the frame out of the window just past the threshold */
+	if (unlikely(skb->len > priv->tx_thld_len &&
+		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
+		if (skb_put_padto(skb, priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			goto drop;
+		}
+	}
+
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
 	/* Retain how many bytes will be sent on the wire, without TSB inserted
 	 * by transmit checksum offload
 	 */
@@ -2662,6 +2703,27 @@ static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
 		       ENET_THLD_MAX_LEN / ENET_THLD_UNIT);
 }
 
+/* Transmit threshold in register units. Frames landing in the window just
+ * past it are padded clear of it, so pick a threshold that leaves room for
+ * that padding inside the frame the MTU allows. Size the window against the
+ * longest frame the MAC has to accept, since the tag count is not bounded.
+ */
+static unsigned int bcmgenet_tx_pkt_rdy_thld(unsigned int mtu)
+{
+	unsigned int thld = ENET_THLD_MAX;
+
+	/* Keep the reset value while the MTU has no use for more */
+	if (mtu <= ETH_DATA_LEN)
+		return ENET_THLD_DEFAULT;
+
+	while (thld > ENET_THLD_DEFAULT &&
+	       ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN > thld * ENET_THLD_UNIT &&
+	       thld * ENET_THLD_UNIT + ENET_TX_SAFE_MARGIN > mtu + ETH_HLEN)
+		thld -= ENET_THLD_BURST / ENET_THLD_UNIT;
+
+	return thld;
+}
+
 /* A buffer has to hold everything the threshold lets the hardware deliver */
 static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
 {
@@ -2672,8 +2734,10 @@ static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
 /* Program the MTU dependent registers. Call with the MAC disabled. */
 static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 {
+	u32 tx_thld = bcmgenet_tx_pkt_rdy_thld(mtu);
 	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
 
+	priv->tx_thld_len = tx_thld * ENET_THLD_UNIT;
 	bcmgenet_umac_writel(priv, ENET_MAC_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);
 
 	/* GENET v1 maps other registers at these offsets */
@@ -2681,6 +2745,8 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 		return;
 
 	bcmgenet_rbuf_writel(priv, thld, RBUF_PKT_RDY_THLD);
+	bcmgenet_writel(tx_thld, priv->base + priv->hw_params->tbuf_offset +
+			TBUF_PKT_RDY_THLD);
 }
 
 static void init_umac(struct bcmgenet_priv *priv)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 28395cb72fb6..7703e1fb73b6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -624,6 +624,7 @@ struct bcmgenet_priv {
 	struct enet_cb *rx_cbs;
 	unsigned int num_rx_bds;
 	unsigned int rx_buf_len;
+	unsigned int tx_thld_len;
 	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
 	struct list_head rxnfc_list;
 

-- 
2.53.0

