Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BBA377EC5;
	Wed,  8 Jul 2026 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504794; cv=none; b=F6Y1ZcyzxJ0nYIs/8FQuDFYkea0aBjnv3lHHvlNwB36t1n2qCj8vg6CIzhOiWKRAE+aSRngeFX+1Dfal92EBYxnZahEyVGW5SzK43EHMHL5KwCbBqD8MwQuLZgpXFzFsa+T1T/FTi12muAQybqw9ujMd3g+9FNCcaz2lIOOEJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504794; c=relaxed/simple;
	bh=gYbb/ePz0mZybCD8+fQkwvdwQTWGoR+yhFQn5KgJS08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtlclHC3CjhprlyUssR58TPMFGu6GFcHPLacplwQLwFNa7xtSQdF3/pj3hWgz9WooUVKGLz8v1bC/MDeeIg99HEdp9ypKo78QM7KvqeR5MYKwXcwc8k8DgBX1h8YdpxhUieMSJ5i9KXZoAwlPCUmagY+TGeqhU4/DEkxIQ499Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=A/ETSNI4; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="A/ETSNI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504791;
	bh=jV8EKQqFqcqyZIqqPDMwD6FlUxs6fygoNHEc01ucx50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A/ETSNI4zMNEAV//tYI32tL3Wsz33SJIljPA2tumfed4vu+OijJOnul7ymesHtrec
	 tWMocXUZgToDhEdAk15Fb+jXzYf/T4JK9hK1W3ZgHzpLppV7i4WChWyunMSZRDPMMt
	 hAQjA8pKBdjUvLVzmk5npGWXkg2AIseW37pSgfpKmamtDFeqKvEl6V3LMoMPBFtWPq
	 +Iw3wf3qme1+tyoJZY31jUGHUgpck9KpVM5FKD3gGFIStQk96LMMMBy3xIExDqf9Vy
	 Wqq9Flab6S7Ec9aH+Z2UwuEmL7g8zJ7mpFlGSbxYQSxrzc/813fhIuTj//w80f29vQ
	 VHsEFFDTtlnEA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 405B266592; Wed,  8 Jul 2026 17:59:51 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:42 +0800
Subject: [PATCH net-next v3 11/12] net: mctp: usb: enable v1.1 packet
 spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-11-9e710155cdbf@codeconstruct.com.au>
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

Now that mctp-usblib supports DSP0283 v1.1 packet spanning, enable it in
our host-side transport driver.

Add a match for the new device subclass (0x02), and indicating spanning
mode to the usblib rx/tx implementation.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 0507307c875f..8e29be9ebd1d 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -3,9 +3,9 @@
  * mctp-usb.c - MCTP-over-USB (DMTF DSP0283) transport binding driver.
  *
  * DSP0283 is available at:
- * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.1.0.pdf
  *
- * Copyright (C) 2024-2025 Code Construct Pty Ltd
+ * Copyright (C) 2024-2026 Code Construct Pty Ltd
  */
 
 #include <linux/module.h>
@@ -22,6 +22,7 @@
 struct mctp_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
+	bool span;
 
 	struct net_device *netdev;
 
@@ -43,6 +44,11 @@ struct mctp_usb {
 	struct usb_anchor tx_anchor;
 };
 
+enum {
+	MCTP_USB_SUBCLASS_BASE = 0x00,
+	MCTP_USB_SUBCLASS_SPAN = 0x02,
+};
+
 static void mctp_usb_out_complete(struct urb *urb)
 {
 	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
@@ -71,6 +77,9 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			  usb_sndbulkpipe(mctp_usb->usbdev, mctp_usb->ep_out),
 			  data, len, mctp_usb_out_complete, tx_ctx);
 
+	if (mctp_usb->span)
+		urb->transfer_flags |= URB_ZERO_PACKET;
+
 	netif_stop_queue(mctp_usb->netdev);
 
 	usb_anchor_urb(urb, &mctp_usb->tx_anchor);
@@ -296,6 +305,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	struct usb_host_interface *iface_desc;
 	struct net_device *netdev;
 	struct mctp_usb *dev;
+	bool span;
 	int rc;
 
 	/* only one alternate */
@@ -307,6 +317,8 @@ static int mctp_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	span = iface_desc->desc.bInterfaceSubClass == MCTP_USB_SUBCLASS_SPAN;
+
 	netdev = alloc_netdev(sizeof(*dev), "mctpusb%d", NET_NAME_ENUM,
 			      mctp_usb_netdev_setup);
 	if (!netdev)
@@ -314,14 +326,18 @@ static int mctp_usb_probe(struct usb_interface *intf,
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	dev = netdev_priv(netdev);
+	dev->span = span;
 	dev->netdev = netdev;
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
 	spin_lock_init(&dev->rx_lock);
+	if (dev->span)
+		netdev->max_mtu = MCTP_USB_1_1_MTU_MAX;
 	usb_set_intfdata(intf, dev);
 
-	mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize), false);
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
+	mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),
+			    dev->span);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, dev->span);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
@@ -362,7 +378,8 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 }
 
 static const struct usb_device_id mctp_usb_devices[] = {
-	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, 0x0, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_BASE, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_SPAN, 0x1) },
 	{ 0 },
 };
 

-- 
2.47.3

