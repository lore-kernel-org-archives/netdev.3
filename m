Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8437BE6D;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789758; cv=none; b=IgpxTDXlh+MWp6W6B5Pacs2yWE65SIgPL+MMAR3U8oXGmxjCwE9GM5OmEvQOCRZYh0/dOCoNdeg7ROFxAxS2nGwLHmyrHV1xc0U45EIGZN4OOBfL44+PSZ7bYZWN/V54XXtDW8efRRbJr+Xaaq26Jy8w5vsSURybCHKRvg2JokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789758; c=relaxed/simple;
	bh=0RcirWFnD5iyZrPhnNB/VnV6Qssmlu8BRoJ8pYvx0oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IbdQcrODyafw/BblrRFHnyRXk9DvSDTaLdcp259EKzlG+x/y95qqpl+xqIfwhP98YM43ZvKq0oflUmMfIx1HgaKie8o77ED//rGAzxC3UZVkec0bb/ymHfUFwQo03vo48GMEjuU1im/MSlnzAGyAOOqi6G10ag3gKofvEMYcipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=clxchqmK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="clxchqmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789747;
	bh=otBDDLVlnZAz4UstKI+n9YipayVrv3ObUBb/PlkUe2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=clxchqmK1gyAYUNqZLmmqnM1fKLU2Mo7JIr+9I19wHVDIBYsqJEri7YVGxy/E2I7b
	 qgtiqoxSdHV3byIY43KXf0RVSZMQTQUtjM5L0Qj3uIjdtQpIsONGOdHzdZL0w7AxNY
	 B0qAy+ujybmsRfMhJdgbrEuV++lomruGCEK1Gl2dd5EmMr+h7atsvie/82apdytv7p
	 NybeS2aF+GaQMbVqnJOVZIlMO5xXXmjapTQRiy0i7oyI+R5ISW4yYL0oYKT2Fg6EI5
	 irNcv/EFS4PlCZyh4bMA8BjWfopE55CO5y3Eph1fSyAdaRZ3iAENAAXTvccEau+L1G
	 aatfUllBLfqFw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 39651660F1; Tue, 30 Jun 2026 11:22:27 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:26 +0800
Subject: [PATCH net-next 05/12] net: mctp: usb: Allow for multiple urb
 submissions from a packet tx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-5-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
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
 drivers/net/mctp/mctp-usb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 385350792dd4..b31599dfaa7e 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -37,9 +37,9 @@ struct mctp_usb {
 	struct delayed_work rx_retry_work;
 
 	struct mctp_usblib_tx tx;
-	/* protects tx_urb */
+	/* protects tx_anchor across submission / completion / cancellation */
 	spinlock_t tx_lock;
-	struct urb *tx_urb;
+	struct usb_anchor tx_anchor;
 };
 
 static void mctp_usb_out_complete(struct urb *urb)
@@ -52,7 +52,7 @@ static void mctp_usb_out_complete(struct urb *urb)
 	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
 
 	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
-	mctp_usb->tx_urb = NULL;
+	usb_unanchor_urb(urb);
 	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
 
 	usb_free_urb(urb);
@@ -81,7 +81,7 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 	if (!rc)
-		mctp_usb->tx_urb = urb;
+		usb_anchor_urb(urb, &mctp_usb->tx_anchor);
 	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
 
 	if (rc) {
@@ -212,10 +212,10 @@ static int mctp_usb_stop(struct net_device *dev)
 	flush_delayed_work(&mctp_usb->rx_retry_work);
 
 	usb_kill_urb(mctp_usb->rx_urb);
-
-	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
-	usb_kill_urb(mctp_usb->tx_urb);
-	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
+	/* we have stopped queues, the anchor's own lock will serialise
+	 * access from the urb completion.
+	 */
+	usb_kill_anchored_urbs(&mctp_usb->tx_anchor);
 
 	mctp_usblib_tx_cancel(&mctp_usb->tx, dev);
 
@@ -277,6 +277,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 
 	mctp_usblib_rx_init(&dev->rx);
 	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
+	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
 	dev->ep_out = ep_out->bEndpointAddress;

-- 
2.47.3

