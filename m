Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B761374A1E;
	Fri, 24 Jul 2026 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870155; cv=none; b=fQ8/oZvj9TM87iQ0unAgawwHmAAFAo0+9yOsc3alrSTLQedLV1krDHucFK/xCG6oYKWqkMXM9lVNj+kfal7ZZTqrTFqm4HaRfqYTy5tCLW+qIzKbEE0J5XOzcPapLlo68g+FYPl6+BFNGCz9LmtFh5A+Emj3XXCf/9SQVgphczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870155; c=relaxed/simple;
	bh=KKtcR/+m4QN5F8ll5/kMMHagRDQ7KeNz9Wo+ucTMTzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qI853yVUW43KgXXuGQPz8H7V4qImAm0EXaBNQ0YoS7nKYvSX+Rx2lfXYCqG4ErtRJwMYkcgwiZ1mXGgNesBu3NzPiv+E074iEOhG+2aGKUXJfe8SQdXI5/Y8jgmuDtClkzI7NFlKPF8Tzmj0/Lapj2mSUOkvdvLmzVHTiROj6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OYxPXr7N; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OYxPXr7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784870143;
	bh=KhBfWwuMYMkpiuzjTYQnaD8wQ0aG+68CnnMiZzh6YwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OYxPXr7NhE2uoHZsqZCBXVPc3mdgj4CT1YYoD9G9G4LsSZdhLtucE0OnjCZ6eZ7N3
	 MIaXJyYLQWr3IwETvN8oEOiTLfFQpZYx7c73TiD2BxWMhhNcghVP8WfGPlIzbErUnY
	 AuA89FyxRmUgVaYkmrwvVulP5SmItIXbm4nQl20a2WR5FtTpkE/IP0sJ//xOCTBnk5
	 NMFNd1Pq1QrNwGFA+qt6BX7Ef1ZinMOhI+ZI4e8uA2luu+0LvYz8KklMziBbZh4eDf
	 A48rZiyPJ5KKzp4rL6Lg/kpmpSeB5B8GEnb33CZJvCCgIoQF7gDDldX3UXIMsW1uZw
	 LlcQh74/2W1tA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 121C666F3F; Fri, 24 Jul 2026 13:15:43 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Jul 2026 13:15:28 +0800
Subject: [PATCH net-next v5 07/12] net: mctp: usb: Accommodate DSP0283 v1.1
 header format
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-dev-mctp-usb-1-1-v5-7-e66bbba0dbdc@codeconstruct.com.au>
References: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
In-Reply-To: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

In the v1.1 update to DSP0283, we have a larger header field, of 13 bits
rather than 8.

In order to accommodate this, in preparation for proper v1.1 support,
expand our struct mctp_usb_hdr's len field to a u16, and endian-convert
when necessary. Because we don't yet support spanning mode, we will
never receive or transmit with the top 5 bits set, so we always mask
out anyway.

This allows for a future change where we allow spanning mode with
>512-byte transfers.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - fix short packet (hdr) debug message: use endian-converted value
---
 drivers/net/mctp/mctp-usblib.c | 14 ++++++++------
 include/linux/usb/mctp-usb.h   | 11 ++++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index 2e464254353e..d58178f47c06 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -99,6 +99,7 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 	while (skb) {
 		struct sk_buff *skb2 = NULL;
 		struct mctp_usb_hdr *hdr;
+		u16 hdr_len;
 		/* length of MCTP packet, no USB header */
 		u8 pkt_len;
 
@@ -116,21 +117,23 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 			break;
 		}
 
-		if (hdr->len <
+		hdr_len = be16_to_cpu(hdr->len) & MCTP_USB_1_0_PKTLEN_MAX;
+
+		if (hdr_len <
 		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
 			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
-				   hdr->len);
+				   hdr_len);
 			rc = -EPROTO;
 			break;
 		}
 
 		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
-		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
+		pkt_len = hdr_len - sizeof(struct mctp_usb_hdr);
 		if (pkt_len > skb->len) {
 			rc = -EPROTO;
 			netdev_dbg(netdev,
 				   "rx: short packet (xfer) %d, actual %d\n",
-				   hdr->len, skb->len);
+				   hdr_len, skb->len);
 			break;
 		}
 
@@ -399,8 +402,7 @@ static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
 	}
 
 	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
-	hdr->rsvd = 0;
-	hdr->len = plen + sizeof(*hdr);
+	hdr->len = cpu_to_be16(plen + sizeof(*hdr));
 
 	return 0;
 }
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 2e1cde6a6745..1a5e795b4ec1 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -2,7 +2,7 @@
 /*
  * mctp-usb.h - MCTP USB transport binding: common definitions,
  * based on DMTF0283 specification:
- * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.1.0.pdf
  *
  * These are protocol-level definitions, that may be shared between host
  * and gadget drivers.
@@ -17,10 +17,15 @@
 #include <linux/skbuff.h>
 #include <linux/types.h>
 
+/*
+ * MCTP-over-USB transport header. DSP0283 v1.0 has an 8-bit length field
+ * (preceded by 8 reserved bits), v1.1 has a 13-bit length field (preceded by
+ * 3 reserved bits). We use a be16 for our length to handle the larger v1.1
+ * representation, and mask as appropriate.
+ */
 struct mctp_usb_hdr {
 	__be16	id;
-	u8	rsvd;
-	u8	len;
+	__be16	len;
 } __packed;
 
 /* max transfer size for DSP0283 v1.0 */

-- 
2.47.3

