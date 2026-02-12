Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08732A3CA
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932519; cv=none; b=CCejnBIQd1Pp3WiAFypEmiH+tHEnM7q9lOIGVx4i9K87Yicx+VCGl3zApeOUPdZqTYuH4idU3HS/Tcvf1zTxAJMMnPz4PRx5y9JI5XIsTEm8l7MtSDnN/OAbl2t/tdgt6qYO5CKPwN5wW3weUXCiEHx/+SV4gim0s0RBAwDiGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932519; c=relaxed/simple;
	bh=0IYVgRHd6TZ2pI2ZFTsmGN2BGGlg3CLyrtR2RDlfs9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XkQ7DJ7MvV4o1QkkYhcRUx1zMIr0zlaYrRapcK6mSpOzktbC9Bq8+sgwC2yqEO2EPBlOk2OG5cq+JNgytjWYF/Y3CxjX8BIu1AUOcEf3yhcc5Rjc8LFc1ibS8mpwJkRZIRVeVTyTwOeivH33ZDcdkLZxGZ5kHFFuTxbQJ23DV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=NJp9S3ZA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="NJp9S3ZA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3a8494c5so34566985a.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770932517; x=1771537317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBNWNtgJkDT4c7Jvgggf4qsijVRD2mBYjYmT91hYIoQ=;
        b=NJp9S3ZA0X2ffNGovgYwZMO5u+0VjJUF5iNZrDcTcuhzI8QXINswxPynJMKEIOSD3r
         1Cy/PfSUCs2AbN6al3CYOTZ7P9pb0ShAWGaVR1jC9EtpwWh+fpidumbMSvX3IMWgm5gO
         VjLqeOV4Wuue+ZW9d/Nf8X1oydxUEACtfbAcnOhxZwSa+KliiM7o6eMcGn1ncFX38I96
         iwITs28bZ+kb1abfOK/FgqVcT5kYYNTgyr/c8iknKe25HDfkhOvgog9v8On1aSR9uBpz
         +1/wp2/Tw+K9c5V+12+yOfaIK7KOU2ocAnl77hM3aJdb5X/+loj8oFArHfDmZsfgX/1+
         61Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932517; x=1771537317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBNWNtgJkDT4c7Jvgggf4qsijVRD2mBYjYmT91hYIoQ=;
        b=ChwD986DlTy1J5x+KTgOEW+ENbI1PUeNERIn994WvX9voE//mBjHDkfpEsgshpS8kJ
         P4Lcq3zUlCjee6yTlQLlzrOGdpgxdqLRx1ajq3EqIcgj5jSgRryMuidx5j7hp3yINQ8O
         B4A/qpqouR8rFC/75XVoqtOyLNbsNrQIYRBM22h8ycdxPbyKI6V2uGxs6kGtURkvY0Sh
         o1rnPHwvjsBO1vG/NyigdvIRZ0c0z6/B9pZ14hDAGaZcnr7vO40lrCVp4sV2B4XSp2no
         LyxEheuxzYE93PoeyPFUpnawhu918AvNcJZzuqgOhdJiAXW0TDnWTaNno/EcpmIveUii
         vnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU83sE+ABQVIGP5KzQSmGGuoj4u4hyekohpH+652+m71HgFA44CzFnyXI9uaOUlkDM0JFC/pxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPiPRmfwKKAroPnoboENaw2XQ85y8gE5X6Bm9js+82bcBatel
	yXw5tYtRkQosUv94qfHChjR3PejR2Qbn9YUwukprdvPLALSyiO20SBS2VLU7HTb9SCw=
X-Gm-Gg: AZuq6aLt7xtRIRKOKKMTkY/Tfc3r8pPMOm3Kcy8dLXMF64W5Ud186ljdwBsBYRPgRbI
	6Od7/tW2HYdHkJX44SAb2MICFD6MYbV5DmDdDCX9eyLanPLtZ3+pZ3Y+VA4sioAkxY4KbqY72eL
	hJUcS9e5Gg7r26odonCPAICHti7TwSkpRYTVt8ryDZUWAezNyhG1wRMD7c/kaABpspAMzrmNgut
	N3No+ITAP+wE67ERbfaX9KMtiIFgk6bn36hhEsffAYUk9mXzdtuhK1NyND3WPAXBP+waxJdVqGQ
	kHJQV3J0RgMjkVDyNi+qOgirWiHeoqLhhH7DJWaclNqpKPT7oRlQHYvhQzC4W2HW7U+YeeoGqt7
	5gtSuQA6H8jW5BRTfkEw+5S43phOaQPNnrgQDJ4B13rzb9egaEpSy2PnBMmlZ3LGagI6AwpxAWs
	mXCnrIWlQYJ0hDYNVS+hIdP/Da6YpmaCz5Ome1H/NuPGzlxZ9G1dCUQT8Swob5I9HnXldmbdtGF
	OjL+cQ1wgiyEXPgw4NE3OfuLAFH0FdfbvZ3UVxCk6Q=
X-Received: by 2002:a05:620a:44c3:b0:8b2:7558:406d with SMTP id af79cd13be357-8cb408f24f8mr52997085a.61.1770932516736;
        Thu, 12 Feb 2026 13:41:56 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc823a4sm45245976d6.8.2026.02.12.13.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:41:56 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH net v2] net: usb: catc: enable basic endpoint checking
Date: Thu, 12 Feb 2026 21:41:54 +0000
Message-Id: <20260212214154.3609844-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

catc_probe() fills three URBs with hardcoded endpoint pipes without
verifying the endpoint descriptors:

  - usb_sndbulkpipe(usbdev, 1) and usb_rcvbulkpipe(usbdev, 1) for TX/RX
  - usb_rcvintpipe(usbdev, 2) for interrupt status

A malformed USB device can present these endpoints with transfer types
that differ from what the driver assumes.

Add a catc_usb_ep enum for endpoint numbers, replacing magic constants
throughout. Add usb_check_bulk_endpoints() and usb_check_int_endpoints()
calls after usb_set_interface() to verify endpoint types before use,
rejecting devices with mismatched descriptors at probe time.

Similar to
- commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
which fixed the issue in rtl8150.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
v2:
 - Use an enum instead of the magic numbers

 drivers/net/usb/catc.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 6759388692f8..632e27ee9101 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -64,6 +64,16 @@ static const char driver_name[] = "catc";
 #define CTRL_QUEUE		16	/* Max control requests in flight (power of two) */
 #define RX_PKT_SZ		1600	/* Max size of receive packet for F5U011 */
 
+/*
+ * USB endpoints.
+ */
+
+enum catc_usb_ep {
+	CATC_USB_EP_CONTROL	= 0,
+	CATC_USB_EP_BULK	= 1,
+	CATC_USB_EP_INT_IN	= 2,
+};
+
 /*
  * Control requests.
  */
@@ -772,6 +782,13 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	u8 broadcast[ETH_ALEN];
 	u8 *macbuf;
 	int pktsz, ret = -ENOMEM;
+	static const u8 bulk_ep_addr[] = {
+		CATC_USB_EP_BULK | USB_DIR_OUT,
+		CATC_USB_EP_BULK | USB_DIR_IN,
+		0};
+	static const u8 int_ep_addr[] = {
+		CATC_USB_EP_INT_IN | USB_DIR_IN,
+		0};
 
 	macbuf = kmalloc(ETH_ALEN, GFP_KERNEL);
 	if (!macbuf)
@@ -784,6 +801,14 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto fail_mem;
 	}
 
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(dev, "Missing or invalid endpoints\n");
+		ret = -ENODEV;
+		goto fail_mem;
+	}
+
 	netdev = alloc_etherdev(sizeof(struct catc));
 	if (!netdev)
 		goto fail_mem;
@@ -828,14 +853,14 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
 	usb_fill_control_urb(catc->ctrl_urb, usbdev, usb_sndctrlpipe(usbdev, 0),
 		NULL, NULL, 0, catc_ctrl_done, catc);
 
-	usb_fill_bulk_urb(catc->tx_urb, usbdev, usb_sndbulkpipe(usbdev, 1),
-		NULL, 0, catc_tx_done, catc);
+	usb_fill_bulk_urb(catc->tx_urb, usbdev, usb_sndbulkpipe(usbdev, CATC_USB_EP_BULK),
+			  NULL, 0, catc_tx_done, catc);
 
-	usb_fill_bulk_urb(catc->rx_urb, usbdev, usb_rcvbulkpipe(usbdev, 1),
-		catc->rx_buf, pktsz, catc_rx_done, catc);
+	usb_fill_bulk_urb(catc->rx_urb, usbdev, usb_rcvbulkpipe(usbdev, CATC_USB_EP_BULK),
+			  catc->rx_buf, pktsz, catc_rx_done, catc);
 
-	usb_fill_int_urb(catc->irq_urb, usbdev, usb_rcvintpipe(usbdev, 2),
-                catc->irq_buf, 2, catc_irq_done, catc, 1);
+	usb_fill_int_urb(catc->irq_urb, usbdev, usb_rcvintpipe(usbdev, CATC_USB_EP_INT_IN),
+			 catc->irq_buf, 2, catc_irq_done, catc, 1);
 
 	if (!catc->is_f5u011) {
 		u32 *buf;
-- 
2.34.1

