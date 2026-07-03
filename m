Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A523438BE;
	Fri,  3 Jul 2026 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057704; cv=none; b=V+Ti0kP0eumjW76vKT0ENVK1EzIU5VZKCg7N6pU7G8Ix6IrPIJ99a87w++tQXyzEmGTnWH4PITb2LCFBQuFVEtefoF25l7g0zBhhhSIFYaa17FGNQ9E9l1v7WNr94ZGXxlQxs/a3cp5dmJDyMsd6LsAjKYEP9MBoNUQ+V0y30NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057704; c=relaxed/simple;
	bh=NtrhcWohIWlXJ6At2k/Q/bRnv2ZDXq6yLRvVEeRHAUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrUukoHs0QOOdnkqVefaTgz9Kz17X2YhX/EhrTj7jNA/VyM0YqAadfsZXwn/AR3bLysIXT0l4T6J2cLnIhq+10HRzsUZbjNHFYDIjiNANCCDQkozI/QDbz3Q86Rm+ygupQq6pTeM4YVtsJnhRC8E4N3M/QqFIKiHsXKrYovQRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PsI7ZzcU; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PsI7ZzcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057671;
	bh=ctIJwdcmDl5qK+LKxSUjzEp3wWWAsR8nsw+cLXZEXOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PsI7ZzcUu5Q/GsnW5JF1N8V+6/iIa0ZQqyx1mXs02euXYs6saONdHTHRzOijR1xHI
	 1QWJHafG/9oCIzB8MQMKO0bgP++wIYB4u1/Bs4jlTsi6SBCOfB14yVWSy5XoNq98Ie
	 UhYDLQd3ahCiI7lHJdmm9m6J6LlZNNQnY3x3TkE1RIO6j3iktey1hQCUnOKME5WoCC
	 FYxwz62DeKY01aiBmqpKVxNo2R5PBxRgZqaCd9S2axuzmrrqcKoP10EPYGrWJxc6Z+
	 Y0fzseQavyVCPoCoTyQrDZ88XmjXACwVpstUryfemLvGaXKubj1Qpt1yf6hS8OSgOP
	 t4gmgHCqt8H8Q==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 42C636628E; Fri,  3 Jul 2026 13:47:51 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:25 +0800
Subject: [PATCH net-next v2 05/12] net: mctp: usb: Allow for multiple urb
 submissions from a packet tx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-5-60367b861b33@codeconstruct.com.au>
References: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
In-Reply-To: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

We currently assume that one packet tx (ie., a mctp_usblib_tx_push())
will result in zero or one calls to the ->send() op, and so zero or one
urb submissions.

However, in order to support multi-packet transfers in future (and later,
packet-spanning mode), we may have up to two: one flushing an existing
transmit (if we could not append to that), and one for the new packet
(if we are not expecting to add more packets to the new transfer).

Remove the assumption that we have a single tx urb in flight, by
tracking the tx urb with a usb_anchor rather than a single urb pointer.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v2:
 - adjust tx_anchor handling; the urb is unanchored before completion,
   so we don't need to unanchor explicitly. We can now rely on the
   anchor's own lock for serialisation
---
 drivers/net/mctp/mctp-usb.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 0eacad18cb73..e26ddeac9c73 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -37,9 +37,7 @@ struct mctp_usb {
 	struct delayed_work rx_retry_work;
 
 	struct mctp_usblib_tx tx;
-	/* protects tx_urb */
-	spinlock_t tx_lock;
-	struct urb *tx_urb;
+	struct usb_anchor tx_anchor;
 };
 
 static void mctp_usb_out_complete(struct urb *urb)
@@ -47,14 +45,9 @@ static void mctp_usb_out_complete(struct urb *urb)
 	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
 	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
 	struct net_device *netdev = mctp_usb->netdev;
-	unsigned long flags;
 
 	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
 
-	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
-	mctp_usb->tx_urb = NULL;
-	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
-
 	usb_free_urb(urb);
 
 	netif_wake_queue(netdev);
@@ -64,7 +57,6 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			    void *data, size_t len)
 {
 	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
-	unsigned long flags;
 	struct urb *urb;
 	int rc;
 
@@ -78,14 +70,12 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 
 	netif_stop_queue(mctp_usb->netdev);
 
-	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
-	rc = usb_submit_urb(urb, GFP_ATOMIC);
-	if (!rc)
-		mctp_usb->tx_urb = urb;
-	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
+	usb_anchor_urb(urb, &mctp_usb->tx_anchor);
 
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
 	if (rc) {
 		netdev_dbg(mctp_usb->netdev, "TX urb submit failed, %d\n", rc);
+		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
 		netif_start_queue(mctp_usb->netdev);
 	}
@@ -207,7 +197,6 @@ static int mctp_usb_open(struct net_device *dev)
 static int mctp_usb_stop(struct net_device *dev)
 {
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
-	struct urb *tx_urb = NULL;
 	unsigned long flags;
 
 	netif_stop_queue(dev);
@@ -222,11 +211,7 @@ static int mctp_usb_stop(struct net_device *dev)
 
 	usb_kill_urb(mctp_usb->rx_urb);
 
-	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
-	swap(mctp_usb->tx_urb, tx_urb);
-	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
-
-	usb_kill_urb(tx_urb);
+	usb_kill_anchored_urbs(&mctp_usb->tx_anchor);
 
 	mctp_usblib_tx_cancel(&mctp_usb->tx, dev, SKB_DROP_REASON_DEV_READY);
 
@@ -283,11 +268,11 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
 	spin_lock_init(&dev->rx_lock);
-	spin_lock_init(&dev->tx_lock);
 	usb_set_intfdata(intf, dev);
 
 	mctp_usblib_rx_init(&dev->rx);
 	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
+	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
 	dev->ep_out = ep_out->bEndpointAddress;

-- 
2.47.3

