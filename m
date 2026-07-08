Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5A341AC7;
	Wed,  8 Jul 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504762; cv=none; b=S1u0BEPxbcp0y9G0hdsGU/q+M2d6yZVquNnAbSLvBe/ZHMuLP0Ic6ly/X31nxFw2wDqzTjgbnlompvhtP7U/KySa/mgNOQQ9KIy2xrOegvugznXH8Xg+U5eTyoJlW3a+AIwtg+mIg3NBk9qFvbMxP+YLG79zY+kM0ilnrGbwqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504762; c=relaxed/simple;
	bh=hnh15JcTWaEbSip5EIuE2qzJPqLbEkKy/LD3Ed3f9Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJKC8aBy5ymaf1+kX56ty4oddYLPlVtayXYDWxcGpRC2pFMOBo8jKpaaZTHry7utNBLHLOTOJ7rQlfOaEnQPMTA4INtgqyqScdqU3jO7dWqEmXVRanl5VlmtHm4iqcEwCT8jUb7kmvs6RaUnKvqQ8bHXl8kiWdPW/mDkXMOqDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TY/lyqnP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TY/lyqnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504758;
	bh=E65fqHQy68421j/KgYpFmq61B96FDf9FkipkVQkhbuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TY/lyqnPep0bcnclszRzbYNRl7uHycezgWHjMwTXxokltEx8xSmFsqnQR1P51KlE/
	 SQ5P9JBHz3ge9VcHSDup5SvhbdkRl1no/laYO5AEJlw25zmokcVwZYSU6eYimO73NT
	 OdaRHvKhEHKwsDpComc+rWe9nGPYF4/2BI9IuASnGQdmTlClxyM9ztZR65JE2KAcbN
	 ZMKYorAY4Qdmh6OzaF1nTE3aQrvhNT7IeZkCx04UXQ9gm7WBpBuL82yCk62dE7/928
	 IKgPdIogqeQJ26IT+tj23Fv9ZovLs7qUy05al+8/z3Q50wgbXdA2TYGG5b6Ob1ZVrv
	 FOQVskcAZZv3Q==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id EAD2366526; Wed,  8 Jul 2026 17:59:18 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:35 +0800
Subject: [PATCH net-next v3 04/12] net: mctp: usb: Improve IN endpoint
 status handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-4-9e710155cdbf@codeconstruct.com.au>
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

Currently, we give-up on all non-zero status values on our IN/rx urb,
and do not re-queue the urb. This will stall the driver, and prevent
any further receive.

Instead, attempt a re-queue on transient errors, with a max of ten
successive failures. Handle EPIPE specially, by scheduling a
usb_clear_halt() in non-atomic context.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v3:
 - improved IN urb status handling was introduced in v2, but now split
   to a separate change, via sashiko feedback
 - now with usb_clear_halt on EPIPE.
---
 drivers/net/mctp/mctp-usb.c | 70 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 9e5c64e76e4a..82de4d5967db 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -32,6 +32,9 @@ struct mctp_usb {
 
 	struct urb *tx_urb;
 	struct urb *rx_urb;
+	int in_err_count;
+	int in_err_orig;
+	bool clear_halt;
 
 	/* enforces atomic access to rx_stopped and requeuing the retry work */
 	spinlock_t rx_lock;
@@ -158,27 +161,66 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	return 0;
 }
 
+static const unsigned int rx_err_max = 10;
+
 static void mctp_usb_in_complete(struct urb *urb)
 {
 	struct mctp_usb *mctp_usb = urb->context;
 	struct net_device *netdev = mctp_usb->netdev;
+	unsigned long flags;
 	int status;
 
 	status = urb->status;
 
 	switch (status) {
-	default:
-		netdev_dbg(netdev, "unexpected rx urb status: %d\n", status);
-		fallthrough;
 	case -ENOENT:
 	case -ECONNRESET:
 	case -ESHUTDOWN:
-	case -EPROTO:
+		/* device shutdown, don't resubmit */
 		mctp_usblib_rx_cancel(&mctp_usb->rx);
 		return;
+
+	case -EPIPE:
+		/* endpoint stall: clear halt, which will cause a resubmit */
+
+		if (!mctp_usb->in_err_count++)
+			mctp_usb->in_err_orig = status;
+		if (mctp_usb->in_err_count >= rx_err_max) {
+			netdev_err(netdev, "excessive stalls from IN EP\n");
+			return;
+		}
+
+		mctp_usb->clear_halt = true;
+		spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+		if (!mctp_usb->rx_stopped)
+			schedule_delayed_work(&mctp_usb->rx_retry_work,
+					      RX_RETRY_DELAY);
+		spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
+		mctp_usblib_rx_cancel(&mctp_usb->rx);
+		return;
+
+	default:
+		netdev_dbg(netdev, "unexpected rx urb status: %d\n", status);
+		fallthrough;
+	case -ETIME:
+	case -EPROTO:
+	case -EILSEQ:
+	case -EOVERFLOW:
+		/* possibly transient; record first failure, resubmit */
+		mctp_usblib_rx_cancel(&mctp_usb->rx);
+		if (!mctp_usb->in_err_count++)
+			mctp_usb->in_err_orig = status;
+		if (mctp_usb->in_err_count >= rx_err_max) {
+			netdev_err(netdev,
+				   "excessive errors from IN EP, first: %d\n",
+				   mctp_usb->in_err_orig);
+			return;
+		}
+		break;
+
 	case 0:
-		mctp_usblib_rx_complete(netdev, &mctp_usb->rx,
-					urb->actual_length);
+		mctp_usblib_rx_complete(netdev, &mctp_usb->rx, urb->actual_length);
+		mctp_usb->in_err_count = 0;
 		break;
 	}
 
@@ -189,6 +231,20 @@ static void mctp_usb_rx_retry_work(struct work_struct *work)
 {
 	struct mctp_usb *mctp_usb = container_of(work, struct mctp_usb,
 						 rx_retry_work.work);
+	int rc;
+
+	/* We are only called when rx completions are suspended */
+	if (mctp_usb->clear_halt) {
+		int pipe = usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in);
+
+		rc = usb_clear_halt(mctp_usb->usbdev, pipe);
+		if (rc) {
+			netdev_err(mctp_usb->netdev,
+				   "can't clear IN EP halt: %d\n", rc);
+			return;
+		}
+		mctp_usb->clear_halt = false;
+	}
 
 	mctp_usb_rx_queue(mctp_usb, GFP_KERNEL);
 }
@@ -198,6 +254,8 @@ static int mctp_usb_open(struct net_device *dev)
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
 
 	WRITE_ONCE(mctp_usb->rx_stopped, false);
+	mctp_usb->clear_halt = false;
+	mctp_usb->in_err_count = 0;
 
 	netif_start_queue(dev);
 

-- 
2.47.3

