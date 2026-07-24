Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449B36B92E;
	Fri, 24 Jul 2026 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870157; cv=none; b=PhROHtCUBh4bmgK7M0O2SYvaOHbMDXz4qeoFPnXX9qbyJ6DaSPbb76k+966VKWMJ9GrnfArqb8YJD6Pcwkmo4FkCEwaunP93ht7ovx9zUp+nhtPly8KmT4UuvZqfmMTec8Cgbj0Q6C7NN8gKvJLg+6per8X3GOSYSiCcyqIMfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870157; c=relaxed/simple;
	bh=Cli13G9IKW4Dff6myIWV3LwjY3eshCafV53tg2AkeQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTJwanGohorRWVgBc7U6DEGz9+AFYBXjI/G493rMbMoxDAS8MWJ1A7wqMI5oQcvLyMDJ2Aapv66KjmKzUhNCRyMFcrsQT+LCpKwzjhxi3BanhZ90eTUE6RN2LzHt3aYdEsbWt8SCwnwdJ5/zybh+osGvw0TduWdqjTebrP+Mfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dJje+9lj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dJje+9lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784870144;
	bh=E9KduNopUU7o42w5V/SgV7pJB8duUv1aiWHNggLpbRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dJje+9ljXSdlFaOFOI37MQywwEJCL86FWWPsxqVr/HzsLPLoLmVDEVMbdsmR4Ejay
	 7Cq3yGovGDMr3AJW/3M2HbaQp7KIo7INcL5TX6oup9RcO7QbHZFhrEhGRk7pLKwo0f
	 LaovIR6KQCuoRSlfb1CkU02btMZLJsUEjE/XBXF46lBOL63HQPIJXHP2eZWh6MFp/K
	 quxclEYiUDS0BzZ422RXppSc+a6vO4BCcL5AT965BCVUB0ZOfN+jDZ9vS0I3X/wC5a
	 wDfRcS/aA3jSUdyiZtDjHUBLy1Mx4MqrA4CFD0URj5bpxrB+RvNds1MeheeBMDTHY0
	 iX2j9/EsMA/xA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 36CD866F43; Fri, 24 Jul 2026 13:15:44 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Jul 2026 13:15:32 +0800
Subject: [PATCH net-next v5 11/12] net: mctp: usb: enable v1.1 packet
 spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-dev-mctp-usb-1-1-v5-11-e66bbba0dbdc@codeconstruct.com.au>
References: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
In-Reply-To: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
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
 drivers/net/mctp/mctp-usb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 2240c81cc6e7..c4ff9e91a768 100644
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
@@ -316,6 +325,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	struct usb_host_interface *iface_desc;
 	struct net_device *netdev;
 	struct mctp_usb *dev;
+	bool span;
 	int rc;
 
 	/* only one alternate */
@@ -327,6 +337,8 @@ static int mctp_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	span = iface_desc->desc.bInterfaceSubClass == MCTP_USB_SUBCLASS_SPAN;
+
 	netdev = alloc_netdev(sizeof(*dev), "mctpusb%d", NET_NAME_ENUM,
 			      mctp_usb_netdev_setup);
 	if (!netdev)
@@ -334,17 +346,20 @@ static int mctp_usb_probe(struct usb_interface *intf,
 
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
 
 	rc = mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),
-				 false);
+				 dev->span);
 	if (rc)
 		goto err_free_netdev;
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, dev->span);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
@@ -386,7 +401,8 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 }
 
 static const struct usb_device_id mctp_usb_devices[] = {
-	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, 0x0, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_BASE, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_SPAN, 0x1) },
 	{ 0 },
 };
 

-- 
2.47.3

