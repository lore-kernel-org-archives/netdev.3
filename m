Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348852;
	b=II5Tt0Ksjy49IpthWH/5ESrD8t6bV8XofegPe+6lJ3xohL7VHSDHn9PG4iLhV8LwjXcB
	 Nm6CxPnIOI9EBNAtvH1k29ONrW510tcPjef2I+tMXWjpVgT/saHyvUequwbgAWidxWSfp
	 sceG+0uhMAw2EuXThfyZK/e2dAU7eo3F27sEoiBBKfd7WpZC2SSvgJu2KktYz/TJynMfF
	 BvzERWIJvLopWJ4rQWzIpo4NlmaVLIxZOuJ65zohUpJr8bYE5WrJZMaVg4ybilUE59BO/
	 od9TeM0CMhLiEwBRb7ou24/EjA212exwO7SS0XrrRAQ3h1bR6qqhFwFjaUdkMWAwTiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348852;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=x2Biz/QSq1Thnmhj13BpC0QVQ9o5AUZsCC4SkkmL3pA=;
	b=fnhB2VWDKWutUTSKs1iksVIREKq+0O+BUpTo0I3uZ0JIDcEYqs70sF3xoGdSKnkNmviI
	 D0fqT3gjOg6hR71RDnDAnRtU+QRF2a2lBo6MOMTIMtieORMPvk0ZAr7VQbalb00+d/qj0
	 qd14qLro/po4GnDsWLMQNkX2IqMFpgUk9gseFf6BMaqE/q8JzJ60fBGuftRacPC8tvjt9
	 jCvVn2rBsdq3fc0nD5e2L5RiBkonYLnL7BRTX8Myso9JR3whLcGI747lPefIQepY/1e2Y
	 iOvjuWUN9wkKZSExhTM1NJbRc6KshLxe5sFmF5y6frY1RrMawQtObyrTasuE+hMP3ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SihU+DUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01784606A32E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SihU+DUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434C21F008BC;
	Tue, 10 Nov 2026 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348851;
	bh=x2Biz/QSq1Thnmhj13BpC0QVQ9o5AUZsCC4SkkmL3pA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SihU+DUSbJdde/E/Jp+OF3MMiEho+HLSXv6FOqrjmMQtZXuddYhHelcRpNfEtGP/Q
	 hVQTzbXOcLaIne/jrSqiG+r+XoS5y2rsnzduLdxI4n01lLX2+vekK3sRr10CgRLDfl
	 +gSdENZ2DgodcJa0KvmffeE7KHTTBJft7d2wuix2XnEKnVcIvF0Qr3z6ORBXcL/VLJ
	 4OyK0XXoLdwgX+hiimswPFwXNQLBNy1Vnwnl6ITEgrU26zjaJ6mrtYzwWsN3owNZtp
	 gEBlCEAIQ8lwIp/Ym8JqvnHNnGO1IunSVUC4h0P3KPvY3Y4KYnJPMZ/T4U88NkQmam
	 gWrUqite60aZw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:32 +0100
Subject: [PATCH net-next v7 17/18] net: ethernet: cortina: Reject TX rings
 smaller than retained pointers
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-17-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The hardware-owned TX read pointers can retain their positions when the
queues are rebuilt. After shrinking the TX ring with ethtool -G while
the interface is down, gmac_setup_txqs() copies those pointers into the
write and clean pointers without checking the new ring size. A retained
pointer outside the smaller ring can then index past both the skb table
and the coherent descriptor allocation.

Reject a TX ring size that cannot contain every retained read pointer,
before applying any RX ring changes in the same ethtool request. Check
again before allocating and programming the TX rings on open, including
for pointer state inherited from firmware. DMA is stopped at both checks.
Do not just mask the software pointers, which would leave the hardware
read pointer outside the new ring.

Found during Sashiko review and confirmed with a pointer arithmetic
model: a retained pointer of 200 with 16 entries reports 15 free entries
and permits the first TX write at index 200. Checked all 16-bit pointer
values against queue orders 0 through 15 and cross-built the driver for
ARM.

Tested on the D-Link DIR-685 with intense transfers and ping storms.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 58d6ed81a59c..1007fd54cb05 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -568,6 +568,20 @@ static int gmac_init(struct net_device *netdev)
 	return 0;
 }
 
+static bool gmac_txq_size_valid(struct net_device *netdev, unsigned int entries)
+{
+	struct gemini_ethernet_port *port = netdev_priv(netdev);
+	unsigned int i;
+
+	/* DMA is stopped, so the hardware read pointers cannot advance. */
+	for (i = 0; i < netdev->num_tx_queues; i++)
+		if (GET_RPTR(port->dma_base + GMAC_SW_TX_QUEUE_PTR_REG(i)) >=
+		    entries)
+			return false;
+
+	return true;
+}
+
 static int gmac_setup_txqs(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
@@ -582,6 +596,12 @@ static int gmac_setup_txqs(struct net_device *netdev)
 	unsigned int r;
 	int i;
 
+	if (!gmac_txq_size_valid(netdev, entries)) {
+		netdev_err(netdev,
+			   "TX ring is too small for the retained read pointer\n");
+		return -EINVAL;
+	}
+
 	rwptr_reg = port->dma_base + GMAC_SW_TX_QUEUE0_PTR_REG;
 
 	skb_tab = kzalloc_objs(*skb_tab, len);
@@ -2581,11 +2601,21 @@ static int gmac_set_ringparam(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned int old_rxq_order;
+	unsigned int txq_order = port->txq_order;
 	int err = 0;
 
 	if (netif_running(netdev))
 		return -EBUSY;
 
+	if (rp->tx_pending) {
+		txq_order = min(15, ilog2(rp->tx_pending - 1) + 1);
+		if (!gmac_txq_size_valid(netdev, BIT(txq_order))) {
+			NL_SET_ERR_MSG(extack,
+				       "TX ring is too small for the retained read pointer");
+			return -EINVAL;
+		}
+	}
+
 	if (rp->rx_pending) {
 		old_rxq_order = port->rxq_order;
 		port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
@@ -2596,7 +2626,7 @@ static int gmac_set_ringparam(struct net_device *netdev,
 		}
 	}
 	if (rp->tx_pending) {
-		port->txq_order = min(15, ilog2(rp->tx_pending - 1) + 1);
+		port->txq_order = txq_order;
 		port->irq_every_tx_packets = 1 << (port->txq_order - 2);
 	}
 

-- 
2.56.0

