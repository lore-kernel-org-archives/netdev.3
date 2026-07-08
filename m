Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197C367F31;
	Wed,  8 Jul 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504741; cv=none; b=cNttmC/tEuBim7fVVM7ZlI7GIfbcxp5FwjWxV/S/90AAaPtPZa5NKKYwC0mXynPrE8VoomcwPlzGmA3iJDsfGhdYg0ZDP8fw0q+8a4vFLFWzzihK8BLnaQeTzNCukW0ILJGLj8Hkx9lKNDyB9jgc98xmr40qYrIjJXs5yVOum6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504741; c=relaxed/simple;
	bh=LQZc4rIna5P6w5GjBtRUSMmbad/eKzzcgHBBcPUi+a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBN3ZaikJVIzcoJfleGBOunzz3uD0kxX/wmSJdN1QOsegAylftdBblWHY8tm4vx+2eIbjNWnv63z82gL1NuYoSl4YKQ+al6au6XMNADY9vsAzcXW/QiaM0e5NexUyb5DK4ONENzKYg01JyJXgvI606FhDVmX1t5hQeQYOtu3P34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bP5OfdRE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bP5OfdRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504738;
	bh=3vAgljkxOZKzaYntzYofEQoz0xcOMVn5Ns3RtQoLP38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bP5OfdREy498gJZvRxI1+e5hyYgp28OuTHk7PlXW8sJoYjxpL9VJsSNYMZdVkigUD
	 ae4+yeBEpGxlEGmwMp/fxyELEgxX9sUZiiGCcvblXfrHerQIg9EIS+u69hpfQV/5ge
	 9aDFLaKMbFzaSZwyEE3Sh4sNGELoRZ+MDKB3YgGAprcpABBU1x88YY7LMhJ/oUyQJA
	 z9AE30kH7R3uy3YeYDzCM8+TYCY/P8iQsrcJ90Na9+/Z2okUiNKsGnmENKTsOXsEYh
	 XIAJqP17gS8NSE2BFk3cKJRpFxH29uHnKyfZ6yvusQ/biZvccJQW02bc0glyDVXW92
	 ZDATRbxQDOZiA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A0CFB66526; Wed,  8 Jul 2026 17:58:58 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:33 +0800
Subject: [PATCH net-next v3 02/12] net: mctp: usb: Use packet-length max
 for maximum packet-size check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-2-9e710155cdbf@codeconstruct.com.au>
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

The max packet size is smaller than the max transfer size, as we only
have a u8 length field in the transport header.

Add a define for the maximum representable length, and use that for our
check. Use this for the MTU maximum calculation too.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c  | 2 +-
 include/linux/usb/mctp-usb.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 545eff06322c..c6e36b63e87a 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -76,7 +76,7 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
 
 	plen = skb->len;
 
-	if (plen + sizeof(*hdr) > MCTP_USB_1_0_XFER_SIZE)
+	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX)
 		goto err_drop;
 
 	rc = skb_cow_head(skb, sizeof(*hdr));
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 47e2e3931d63..2bece8afd1c7 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -25,7 +25,8 @@ struct mctp_usb_hdr {
 #define MCTP_USB_1_0_XFER_SIZE	512
 #define MCTP_USB_BTU		68
 #define MCTP_USB_MTU_MIN	MCTP_USB_BTU
-#define MCTP_USB_1_0_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
+#define MCTP_USB_1_0_PKTLEN_MAX	U8_MAX
+#define MCTP_USB_1_0_MTU_MAX	(MCTP_USB_1_0_PKTLEN_MAX - sizeof(struct mctp_usb_hdr))
 #define MCTP_USB_DMTF_ID	0x1ab4
 
 #endif /*  __LINUX_USB_MCTP_USB_H */

-- 
2.47.3

