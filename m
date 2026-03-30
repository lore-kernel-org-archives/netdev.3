Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FE2749EA;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867036; cv=none; b=s05bE+0B94Jb6+hQ4sEXWFU6v2jpz8MPJlSzHd06ictQFRa9ObkopI2XVvUprxzWcxe9JqhqORYT1FULjr/0tHl+oDHwWGfdkCiwooI7odQDKYnt8ELYqZtAuhaGSb11aBpB4TzSctYuCEej4Zq/7qDjnbuZQIEq3zg5ZA2Q3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867036; c=relaxed/simple;
	bh=oMwbOvekEJLq5SWnvcRHTW8y++ihCP2psVy2WWx82ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUcCa352tcIWbCeG29QsKOu4QtSMB/Hdbzi+F2pHqLRe5L4d3DV0iiFWpyXwrDvuWwdgtriqcW5Ta8epJckVSYRB+GXRV/DCyofMq9S9gPQHfTo+Ee+HQFvBA+lLJ0jUHaY1kYmHphaHu3bFH1ReuwHQVFzBBALZNiKVo/ff4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4zgJAot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4zgJAot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBFEC2BC9E;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774867036;
	bh=oMwbOvekEJLq5SWnvcRHTW8y++ihCP2psVy2WWx82ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4zgJAot4NpPX7qtWkNar85h4ipj56p6iLi4w+feOXBVh0zp6Aie8l75QHlVpRPZ3
	 78gmFJaCnAZiQozK5u3E5VG/CTxvPpC3x9zQJ+/11LfqQuyKgYaDD/oma3Tnz5W+CO
	 xouL3OAmxc+G7flz1MhsqiP20dwBhpQxRlbMC3lRqauSupAa1RSm+zA/MdbKt0MtzT
	 tDckSaYiip/V+y1toBAV7i91bzjnZGnKSV/4dK3HJ7kd5XXtmhP8E3SDkyqZ+u7h57
	 dhIX1eRzaaWwTAOiyxGbnVuyVBNZfdGbBL1a300yG19RHFvNjFdY4XgKQ63Cc7/C+/
	 JLccavImZNZbw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79ze-0000000713Z-08W7;
	Mon, 30 Mar 2026 12:37:14 +0200
From: Johan Hovold <johan@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] nfc: port100: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:36:55 +0200
Message-ID: <20260330103655.1672331-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330103655.1672331-1-johan@kernel.org>
References: <20260330103655.1672331-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining endpoint numbers) instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/port100.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 09dcc6f4c4f3..5ae61d7ebcfe 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1489,15 +1489,11 @@ MODULE_DEVICE_TABLE(usb, port100_table);
 static int port100_probe(struct usb_interface *interface,
 			 const struct usb_device_id *id)
 {
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct port100 *dev;
 	int rc;
-	struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *endpoint;
-	int in_endpoint;
-	int out_endpoint;
 	u16 fw_version;
 	u64 cmd_type_mask;
-	int i;
 
 	dev = devm_kzalloc(&interface->dev, sizeof(struct port100), GFP_KERNEL);
 	if (!dev)
@@ -1508,22 +1504,11 @@ static int port100_probe(struct usb_interface *interface,
 	dev->interface = interface;
 	usb_set_intfdata(interface, dev);
 
-	in_endpoint = out_endpoint = 0;
-	iface_desc = interface->cur_altsetting;
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		endpoint = &iface_desc->endpoint[i].desc;
-
-		if (!in_endpoint && usb_endpoint_is_bulk_in(endpoint))
-			in_endpoint = endpoint->bEndpointAddress;
-
-		if (!out_endpoint && usb_endpoint_is_bulk_out(endpoint))
-			out_endpoint = endpoint->bEndpointAddress;
-	}
-
-	if (!in_endpoint || !out_endpoint) {
+	rc = usb_find_common_endpoints(interface->cur_altsetting, &ep_in,
+				       &ep_out, NULL, NULL);
+	if (rc) {
 		nfc_err(&interface->dev,
 			"Could not find bulk-in or bulk-out endpoint\n");
-		rc = -ENODEV;
 		goto error;
 	}
 
@@ -1537,10 +1522,10 @@ static int port100_probe(struct usb_interface *interface,
 	}
 
 	usb_fill_bulk_urb(dev->in_urb, dev->udev,
-			  usb_rcvbulkpipe(dev->udev, in_endpoint),
+			  usb_rcvbulkpipe(dev->udev, usb_endpoint_num(ep_in)),
 			  NULL, 0, NULL, dev);
 	usb_fill_bulk_urb(dev->out_urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, out_endpoint),
+			  usb_sndbulkpipe(dev->udev, usb_endpoint_num(ep_out)),
 			  NULL, 0, port100_send_complete, dev);
 	dev->out_urb->transfer_flags = URB_ZERO_PACKET;
 
-- 
2.52.0

