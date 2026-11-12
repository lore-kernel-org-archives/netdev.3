Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490270;
	b=erSmPbLx0jiPEw5bMS8ysN77R3BaYyCrQbr4iJHM6/+XXwo/f8Dpq2+CxSlZoiBECDL+
	 L8NGyb8zkQQwP8pRrEeDqjTeH8hQA4Il0P7h25pO10KIt2PGewHHMr1KjQ2u47/0wWvJz
	 wYS9HK9IbLrXvYlf+1UVtyv847zLZSgBy3XUTlYVn3/FOhPp5licH1j07NK/TZPSuicdM
	 V0E+le9swg33rCgvofp/Gd2BU6Kg9azKeW2DXcBP5985bPvcOkqxYK7YkfO8XVuDuBfe8
	 ijyM01jgidAIJ6HjKaH0uQvtcOhVrtFegzwJMr7g7GSRpmSo+6Kond1B2FOsRb+BbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490270;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=stWeNmOFxIgHe2Lsk2Jd+hY/Hny7hRBVyzbKd7me1rs=;
	b=Gm+F/gzkszWbFh7utZd/nyeBTBmE177ctnH77TVi+WZj9Dv5wIUnOdU+2G1L81Ncm/Hw
	 ELN7IqThWCXjKHGKziN+tHV76s1h4RaszaN2vl95GpODpXX78yM3fsVwm96p7yDrPSayx
	 iA6M6vfJ2aCW0Q0Rfa6OeH/AoXyCgswd7yZNJ9DdQyxXkH4ge7Ap+mSlTrQin5R/9JOce
	 h/9qOG7rZpj3uM6T2jABhMtBEp/k0OzaCQBUt5JdpL5tPwr6TVeMduCH2o+FiiaPvetT0
	 IHNQNwFrew+ZEuB/FSi9/gyuMMSglTvowaedQxWElM9TkXLgdPguSnVTpSWtkT8Jjsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/Y9Uv8Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABA606A899
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/Y9Uv8Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8831F00A09;
	Thu, 12 Nov 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490269;
	bh=stWeNmOFxIgHe2Lsk2Jd+hY/Hny7hRBVyzbKd7me1rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U/Y9Uv8ZeU8atuHJxvtKqJvAHialLZcgvHu3mIm/B4ueiC6OEj+KXqc2jALxPKhVS
	 UVlOM+TBHDiCOKp23FIqUsaxdlH2rzYkbq2flx3FBFEdmv5qQGHkD9cSSzdTVpwrDt
	 QsBoG2joOsRufCr45opLm7ZXL5Mex1oa4Pymr19EGa/zHIlc3sWJM6+Ma+zk5XC3HO
	 2vzn+uabdSYHpU5fv5YG66izpZqdbzspfuEFvgcV90M4VFeLr8wQJq+OQEDC/PqOh6
	 3vdm5uPiWx4wXB5c2WiY9PbMIsMYdl3wdUDWEYg4jHTs0cp9gQo1gRgHEz1GojRRzH
	 rfYk7ktJKw4Kg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:33 +0100
Subject: [PATCH net-next v8 18/19] net: ethernet: cortina: Reject TX rings
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-18-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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
index 24a66fc34738..899d96420b1b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -602,6 +602,20 @@ static int gmac_init(struct net_device *netdev)
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
@@ -616,6 +630,12 @@ static int gmac_setup_txqs(struct net_device *netdev)
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
@@ -2623,11 +2643,21 @@ static int gmac_set_ringparam(struct net_device *netdev,
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
@@ -2638,7 +2668,7 @@ static int gmac_set_ringparam(struct net_device *netdev,
 		}
 	}
 	if (rp->tx_pending) {
-		port->txq_order = min(15, ilog2(rp->tx_pending - 1) + 1);
+		port->txq_order = txq_order;
 		port->irq_every_tx_packets = 1 << (port->txq_order - 2);
 	}
 

-- 
2.56.0

