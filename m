Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68B1A6811;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789758; cv=none; b=m3r5+1lzGeDKH74Ga4B9eZsjgcD0BSH8H0ZMob4ZFQBozSCMPYJ/1hFHEr4wCwH23vM0LRuMgh9gK0I17FbEO7rx4VzXsLdmMJoyD3/BEW9ritzr9E9UA+FmcuBmJfPSCnPRCqaT708POTH40carA+pm6qyKYTatER3Wnv1kelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789758; c=relaxed/simple;
	bh=hK1IoMClSYpsZLnVNjIpeep0ljmHaKUwqTPWLiYbGBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3/OhoOXpXzTelsrYk7JtghTpypl17v29wbAVNBx+WZvkH6OxIE9DpXp/3fkYL0bZzgUft3HevJfNnCaoSs8YwjbKfnqWn4xOM2qjTbHo0SKRoyO7DziVWHJlGsPGOwxsF3Cjf80cohgQ3P5rFVlo4Lnh7jtvD1hgawyX1Au9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mh6NqzeK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mh6NqzeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789749;
	bh=qkEvysaR0ZUNRY/2uVfP9UzYbtEm405WRqEpHVXaDgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mh6NqzeKvXeyvHlXjGyuLVyaZf1wsxAGx8XRgrHTyLkLJTjT/HNSkq5tqXuLw+Yx9
	 pIo/N0ZmTMoBflJuYcQNwnmPlwIPiJFRoUTKWZ3ukWRrF75rhN/MDaWcl9yYY73Zlx
	 nmtS2Jg/UCtAArOgZdPI9qZhwP5po0mKFkHAUS0tAOAOABeSodTyvKPoe5T0Ep0jVA
	 E76wQuSPqP0kDoK/34ee1nRIfjepdkYC43o/o//jGJBEfGa3Rn4zqgSngOlCgn23mI
	 +Vh9bUFHl06uazUmGZbYAH3+kBiGQHi1kURKcAahx9z/d2IBEGKnijr/ti2kY0Q79Q
	 ZvoHNkHQCdfKg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 3F1BF660F8; Tue, 30 Jun 2026 11:22:29 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:33 +0800
Subject: [PATCH net-next 12/12] net: mctp: usb: Allow multiple urbs in
 flight
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-12-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
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
 drivers/net/mctp/mctp-usb.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 5739c87da109..28aeb5b25872 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -38,9 +38,12 @@ struct mctp_usb {
 	struct delayed_work rx_retry_work;
 
 	struct mctp_usblib_tx tx;
-	/* protects tx_anchor across submission / completion / cancellation */
+	/* protects tx_anchor & tx_qmem across submission / completion /
+	 * cancellation
+	 */
 	spinlock_t tx_lock;
 	struct usb_anchor tx_anchor;
+	unsigned int tx_qmem;
 };
 
 enum {
@@ -48,22 +51,38 @@ enum {
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
 	struct net_device *netdev = mctp_usb->netdev;
 	unsigned long flags;
+	bool wake = false;
 
 	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
 
 	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
+	mctp_usb->tx_qmem -= urb->transfer_buffer_length;
+	if (mctp_usb->tx_qmem < TX_QMEM_MAX)
+		wake = true;
 	usb_unanchor_urb(urb);
 	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
 
 	usb_free_urb(urb);
 
-	netif_wake_queue(netdev);
+	if (wake)
+		netif_wake_queue(netdev);
 }
 
 static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
@@ -85,18 +104,19 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 	if (mctp_usb->span)
 		urb->transfer_flags |= URB_ZERO_PACKET;
 
-	netif_stop_queue(mctp_usb->netdev);
-
 	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
-	if (!rc)
+	if (!rc) {
 		usb_anchor_urb(urb, &mctp_usb->tx_anchor);
+		mctp_usb->tx_qmem += len;
+		if (mctp_usb->tx_qmem >= TX_QMEM_MAX)
+			netif_stop_queue(mctp_usb->netdev);
+	}
 	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
 
 	if (rc) {
 		netdev_dbg(mctp_usb->netdev, "TX urb submit failed, %d\n", rc);
 		usb_free_urb(urb);
-		netif_start_queue(mctp_usb->netdev);
 	}
 
 	return rc;
@@ -221,12 +241,15 @@ static int mctp_usb_stop(struct net_device *dev)
 	flush_delayed_work(&mctp_usb->rx_retry_work);
 
 	usb_kill_urb(mctp_usb->rx_urb);
-	/* we have stopped queues, the anchor's own lock will serialise
-	 * access from the urb completion.
+
+	/* We have stopped queues, the anchor's own lock will serialise
+	 * access from the urb completion. We are then guaranteed that no
+	 * further completions can occur, so can clear tx_qmem without locking.
 	 */
 	usb_kill_anchored_urbs(&mctp_usb->tx_anchor);
 
 	mctp_usblib_tx_cancel(&mctp_usb->tx, dev);
+	mctp_usb->tx_qmem = 0;
 
 	return 0;
 }

-- 
2.47.3

