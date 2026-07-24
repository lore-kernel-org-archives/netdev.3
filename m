Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F736B07C;
	Fri, 24 Jul 2026 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870154; cv=none; b=O6n19iBSV9RXdUNfKI0AKuXhx2Z5hIbkIJBpbxOUfWyJlxABCV03s8ckK0OzD2LTFmamKjqtU0hSAnj0Y4nYZgdOO7TQ0R0LAeGAT+HEzpLzndpGOhxY2Fsuqa4xMIsZm76XZMHn2fv+WcXf32Ryo+y9f/IedtEj82rUxez9v/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870154; c=relaxed/simple;
	bh=8izF8EWwKiywdcOM88mXbZgQP4QqmABqLMHDY3bTMbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTJxZRJHqX9xllZtdC4prqoZmTM1ygT2SakZ0HZu8V7rnRlcz4+x5v/wwLeKOlDjNw9Xru/lN62lmEeMDOxXvoYUOiiJH4HFlARvXrybEtaLAB9IFXGbfRxuU22Wt+L3rWhk0dbiXXNk4PbUnIRitrp5SkqKC9tGiy3RnTtu5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Vz90aLIJ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Vz90aLIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784870144;
	bh=Bxe8TPAuqCK2ffdFgI1Id/rUKAIgHVzoeWxtI2bwP5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vz90aLIJhdktDVYydysK5hbsgBWxbmU7H4AdHwAO2VNZNcf6f+PGWSuYV8VDq77t+
	 5DX9K3aI+Q3bB7233+WszQ8L3jMmUkOYnoghi4MUfVLe2fgQ+xN915cQvfN1fjOZE7
	 fNBv4aSeXtraplB4lFPiYjpxxjhdCda1nYHidBfMtvEgxKx4BtjmZx55JYd31zMjuX
	 FUZzqtTZ8qLJdVKvolTB3WgILz0GmD680Xu/s18e9SEFwHmvyaNkz4XR2mpUFf5YQ8
	 ahnQTx9AXACyJcaKd6eTopm5UcY+V0yPoV7qk0imvRc76tfDEXzYArAokNlwGl84EK
	 Xp744yFibPJXw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7927266F4C; Fri, 24 Jul 2026 13:15:44 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Jul 2026 13:15:33 +0800
Subject: [PATCH net-next v5 12/12] net: mctp: usb: Allow multiple urbs in
 flight
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-dev-mctp-usb-1-1-v5-12-e66bbba0dbdc@codeconstruct.com.au>
References: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
In-Reply-To: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

Currently, we stop tx queues when we have one urb submitted. This means
we will immediately hit dev_hard_start_xmit's tx-queues-off ->
NETDEV_TX_BUSY case, and revert to the requeue -> gso_skb single-dequeue
path, and no longer be able to pack skbs without an xmit_more
indication.

Instead, allow a few urbs to be in-flight, with a limit of 16kB of data
outstanding (after which we will disable queues). With this, the tx path
will cause fewer requeues (and therefore non-packed transfers) under
normal loads.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v2:
 - rework tx_qmem locking, prevent race between completion and
   submission for stopping/waking the tx queues; perform the wake while
   locked
 - only wake if netif_running()
---
 drivers/net/mctp/mctp-usb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index c4ff9e91a768..542a570c76cc 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -42,6 +42,9 @@ struct mctp_usb {
 
 	struct mctp_usblib_tx tx;
 	struct usb_anchor tx_anchor;
+	/* serialises tx_qmem updates to netdev queue states */
+	spinlock_t tx_qmem_lock;
+	int tx_qmem;
 };
 
 enum {
@@ -49,23 +52,41 @@ enum {
 	MCTP_USB_SUBCLASS_SPAN = 0x02,
 };
 
+/* We use a total-size limit for outstanding URBs, as the transfer counts
+ * may vary a lot between spanning- and non-spanning modes. In spanning mode,
+ * this will allow for a couple of max-sized transfers to be in flight. In
+ * non-spanning mode, 32.
+ *
+ * We want to avoid disabling the tx queue if possible; doing so will end up
+ * requeueing to gso_skb, and we only dequeue from that one skb at a time,
+ * so can no longer perform transfer packing.
+ */
+static const unsigned int TX_QMEM_MAX = 16384;
+
 static void mctp_usb_out_complete(struct urb *urb)
 {
 	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
 	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned int len = urb->transfer_buffer_length;
 	struct net_device *netdev = mctp_usb->netdev;
+	unsigned long flags;
 
 	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
 
 	usb_free_urb(urb);
 
-	netif_wake_queue(netdev);
+	spin_lock_irqsave(&mctp_usb->tx_qmem_lock, flags);
+	mctp_usb->tx_qmem -= len;
+	if (mctp_usb->tx_qmem < TX_QMEM_MAX && netif_running(netdev))
+		netif_wake_queue(netdev);
+	spin_unlock_irqrestore(&mctp_usb->tx_qmem_lock, flags);
 }
 
 static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			    void *data, size_t len)
 {
 	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned long flags;
 	struct urb *urb;
 	int rc;
 
@@ -80,8 +101,6 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 	if (mctp_usb->span)
 		urb->transfer_flags |= URB_ZERO_PACKET;
 
-	netif_stop_queue(mctp_usb->netdev);
-
 	usb_anchor_urb(urb, &mctp_usb->tx_anchor);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
@@ -89,7 +108,12 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 		netdev_dbg(mctp_usb->netdev, "TX urb submit failed, %d\n", rc);
 		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
-		netif_start_queue(mctp_usb->netdev);
+	} else {
+		spin_lock_irqsave(&mctp_usb->tx_qmem_lock, flags);
+		mctp_usb->tx_qmem += len;
+		if (mctp_usb->tx_qmem >= TX_QMEM_MAX)
+			netif_stop_queue(mctp_usb->netdev);
+		spin_unlock_irqrestore(&mctp_usb->tx_qmem_lock, flags);
 	}
 
 	return rc;
@@ -353,6 +377,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->rx_lock);
 	if (dev->span)
 		netdev->max_mtu = MCTP_USB_1_1_MTU_MAX;
+	spin_lock_init(&dev->tx_qmem_lock);
 	usb_set_intfdata(intf, dev);
 
 	rc = mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),

-- 
2.47.3

