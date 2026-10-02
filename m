Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0374E36E6;
	Fri,  2 Oct 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953416; cv=none; b=HOC67ufLxd9Cx6SJbOtGKYsrn6fefFg6BMCL17aJ/0KcfXRwV0hAP/I17rZGSNxR8phw6pcrOsYqxbDCWwoy2vOOSVgkEqZAvSIhe6xh0Ej9Ztho1JZjyMbkc+Rnk13i33Y2QkTjV/U+b7Ox4umPue6mqTEyDOgFKPSJ1SgNbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953416; c=relaxed/simple;
	bh=ZRoZbnHfq6/EXTO+Gb48aX090aGg+3JLtr6hgVGiulo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJvl920ID0EWnLwS+8aWmpR+htkUmVZwPMzpdT5AViZRNkNMSQsCuY2BCbN/3kbzJcpbgJpwoRK18jZYmfYO+lZWQeL+HB2LBnzXhVtl+VI7DHn2o82ghL5RY9M3L7TSWjBs/VTk3x872mLVJJ3LB/MSt0sUXVrT5PczkmgCHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=dni4ts8O; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="dni4ts8O"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADC38A4AC9;
	Fri,  2 Oct 2026 17:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Lcp/bad4iGTvWpUWfC/svreJIkGD4jsCNk2o3jygtZ0=;
	b=dni4ts8OZtj56RSgW9fmoLpq8GBWLnAWWRE6eejnBA7SPIzstckpjAoe4oADAwqbvlFanp
	cozlooXfChWyEV2J0N/fcrADTL/6jpXIey9iQ9Fjho1hBHS4O038D6Ce5Wf5kbx9wXU+sR
	qj5iTf8IkLHZ4GG1KgkeGLW6cVQogfyCly3O4FMJI9mzo3QoALIheyVIOLDWBLkjcsBjkp
	SJKGNoOqAMb18G8LcC4iujY7qeotI52HDPiHu7I7kk6gH/KWA5I+Jt+fqjZHKQour/XGVq
	I8mWG0k43HUnxkV147qKMRIqMKU6lbDEL1askdbGitkR6iDufRmjxcP2ofC2jw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 02 Oct 2026 17:03:24 +0200
Subject: [PATCH net-next 6/7] net: bcmgenet: pad transmit frames out of the
 packet ready window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-nb-genet-mtu-nn-v2-v1-6-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

A frame that ends a few bytes past the transmit packet ready threshold
stops the transmitter as soon as a shorter frame follows. Tx DMA then
refuses to halt, so every later bcmgenet_init_dma() fails and the interface
cannot be opened again. IP fragmentation generates that pattern on every
datagram, full frames and a short tail.

The window starts one byte past the threshold and widens with it. On a CM4
it ends 28, 32 and 46 bytes past thresholds of 2560, 3584 and 3840. Link
speed makes no difference. Pad frames landing in it to 64 bytes past the
threshold.

Padding must not push a frame past what the peer accepts. Linux does not
bound how many VLAN tags a frame carries, so measure against the longest
frame the MAC has to accept rather than a tag count. For the MTUs where
such a frame would land in the window, lower the threshold instead. All
other MTUs keep the register maximum.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 39 ++++++++++++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4634b6521ab8..0cd56ec1c5cc 100644
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
  * The HW writes the 64B RSB + 2B alignment padding before the frame.
@@ -2171,6 +2176,18 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
+	/* Keep the frame out of the window just past the threshold */
+	if (unlikely(skb->len > priv->tx_thld_len &&
+		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
+		if (skb_put_padto(skb, priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			ret = NETDEV_TX_OK;
+			goto out;
+		}
+	}
+
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
 	/* Retain how many bytes will be sent on the wire, without TSB inserted
 	 * by transmit checksum offload
 	 */
@@ -2659,6 +2676,23 @@ static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
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
@@ -2669,8 +2703,10 @@ static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
 /* Program the MTU dependent registers. Call with the MAC disabled. */
 static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 {
+	u32 tx_thld = bcmgenet_tx_pkt_rdy_thld(mtu);
 	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
 
+	priv->tx_thld_len = tx_thld * ENET_THLD_UNIT;
 	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);
 
 	/* GENET v1 maps other registers at these offsets */
@@ -2678,8 +2714,7 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 		return;
 
 	bcmgenet_rbuf_writel(priv, thld, RBUF_PKT_RDY_THLD);
-	bcmgenet_writel(ENET_THLD_MAX,
-			priv->base + priv->hw_params->tbuf_offset +
+	bcmgenet_writel(tx_thld, priv->base + priv->hw_params->tbuf_offset +
 			TBUF_PKT_RDY_THLD);
 }
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index f535490547cf..eb00cff0e732 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -618,6 +618,7 @@ struct bcmgenet_priv {
 	struct enet_cb *rx_cbs;
 	unsigned int num_rx_bds;
 	unsigned int rx_buf_len;
+	unsigned int tx_thld_len;
 	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
 	struct list_head rxnfc_list;
 

-- 
2.53.0

