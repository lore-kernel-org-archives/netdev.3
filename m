Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F733FF1A5;
	Tue, 13 Oct 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901250; cv=none; b=Td/gLJSMFjN7Gx9qQ7MVHoJpn/a/mpJ9OJxiaAZuW5Y31yyWEDhqBiksurM/Fn67xRxU8AZlhz4VPdni5BcX377YvzxT3U+KA3BdEsJJq3C9XrxyCqbDR5zmlx3GZjfu9N1lu8ybu6jV44fb9Us4ntMbG4Yral1Rd5RqI6uYptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901250; c=relaxed/simple;
	bh=qTLtYsxYhpvXPdtZfvRfx8S912Qlyx9IKWotSp/BmHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlkTLNp3ahWZdElCoGlVgbBySY35YvdpEj8VXjDfxG124ENHx265FySYKeJH3Z7FmM0J5ML7VSu+snBRUoCZjNmXrMU01fy9LVa32WNMibKp5GvvinNmw86nTxwthiqvoH8u79byQln5MCeLhGRzfftjuWg39O79FT18lbxB8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=M4LShXz0; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="M4LShXz0"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2239EA154E;
	Tue, 13 Oct 2026 16:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791901246; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cG9wFAfv80Iu/mPDHQ55V+Qb0uKfCGeGX7EivfvWG0g=;
	b=M4LShXz0U4Tm7LsiznxsjJY0tvDHfScreW6R6NCkZFUG1yo8LsLLqgX1LvwIjBH61Dkr0C
	KfFoHfXlv8SkChSMj2Y1QnDdei95N+k6DquYwHc0UoR6pB3co5rkvekT2TmyY53wbGdGzC
	kt3j/k6a+XOreE+U7gw9oZAnUVYmzCk0Fod4rKYNVeKUldbXPwM9ZImQrTE7vNhSFShSyC
	YY9pRgqvS4UJDTYVmhpAR+jK5gvi1xHqOgFgzFRmcShwQdYPmEU5fqvybW4drtv92u2lmp
	/b99hPh6z4Jy56dtt5TLAK5bcd82Lu0LjwSYAeRyNiymglgZPWnD4pC4aBNq3A==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 13 Oct 2026 16:20:35 +0200
Subject: [PATCH net-next v5 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
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
index 28395cb72fb6..0f28497998dd 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -616,6 +616,7 @@ struct bcmgenet_priv {
 	void __iomem *tx_bds;
 	struct enet_cb *tx_cbs;
 	unsigned int num_tx_bds;
+	unsigned int tx_thld_len;
 
 	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
 

-- 
2.53.0

