Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E362265629;
	Mon, 13 Jul 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953192; cv=none; b=qRlLcO9lMZP77GZMHj8wdxyCNPocYI9GZcXfa1Ke/3h+MVtjmKqH4JbJfJQiB0AweH+y57Lt4Rzd+qkijTOEq6PNoSuzxS8LiTghjrqLUoM7ZB01omxtCs6aUdf7LqBy/58eFjB5nZ++ZZB2uOcB01Lu/T21N6YUmLNiq4M6gW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953192; c=relaxed/simple;
	bh=/2Ier6FRdzjPO3Emli1gXM2xVhA3IkF3e6eshK4zg2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+RgVgV1y4N/2MsF2UM9BIKRBGjJSxgYKK8l2mEvoronl0jZXwBbmVBQ/8lll8v6zOiJ5a7KPjvoZDAy5V6jt5aLH3ztPQYAvinrrt/oO5OhImLW4DP9w8q83vp060FadgKoHII7jHdCuqCzChUUigPb/qROQp2VF2oAEovbh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=O0k9r/UJ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="O0k9r/UJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783953181;
	bh=bjKgiEdKsT7lRbJrX1xrLVJ5yD4EUl26YxZG1ln3Jpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O0k9r/UJ8xXRXrJh6gRJcj7xs9HEqjMy6cffQO+sM6X83OQWyZsphdyW6oKi5PBEZ
	 fBDKYGrFhBDFuA4FX6emHSyz1KojBgoO5R43Q2FxE3mJBfZiRwtVHyLGLY+Vj37lC6
	 og5neBHBM86kL6dqkn9WWjrq0s+qOTe77a9y1KbotVF08xL8gxJhLB2ncDKMdM7KhZ
	 rZN2sS/oXA2Cdbigqc2At1ffXQ7cQS1VpFP6yuY2MdRuARBbxQduRxZO7ig64yb/z0
	 PqJn1iG1sQUwm6tmIvU6r5VbViSl7ZYURo4OQRinp5VZS4voovJ/47U/Nsuea+0wyF
	 XPjtrR0k5dmlQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 4A1B965614; Mon, 13 Jul 2026 22:33:01 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Jul 2026 22:32:54 +0800
Subject: [PATCH net-next v4 01/12] net: mctp: usb: Include version
 indicator in max packet size defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-dev-mctp-usb-1-1-v4-1-4ae8de764a01@codeconstruct.com.au>
References: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
In-Reply-To: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

DSP0283 v1.1.0 will introduce larger maximum packet sizes. In
preparation, indicate that the current maxima are specific to v1.0.x.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c  | 8 ++++----
 include/linux/usb/mctp-usb.h | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index fade65f2f269..545eff06322c 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -76,7 +76,7 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
 
 	plen = skb->len;
 
-	if (plen + sizeof(*hdr) > MCTP_USB_XFER_SIZE)
+	if (plen + sizeof(*hdr) > MCTP_USB_1_0_XFER_SIZE)
 		goto err_drop;
 
 	rc = skb_cow_head(skb, sizeof(*hdr));
@@ -128,7 +128,7 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	struct sk_buff *skb;
 	int rc;
 
-	skb = __netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_XFER_SIZE, gfp);
+	skb = __netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_1_0_XFER_SIZE, gfp);
 	if (!skb) {
 		rc = -ENOMEM;
 		goto err_retry;
@@ -136,7 +136,7 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 
 	usb_fill_bulk_urb(mctp_usb->rx_urb, mctp_usb->usbdev,
 			  usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in),
-			  skb->data, MCTP_USB_XFER_SIZE,
+			  skb->data, MCTP_USB_1_0_XFER_SIZE,
 			  mctp_usb_in_complete, skb);
 
 	rc = usb_submit_urb(mctp_usb->rx_urb, gfp);
@@ -301,7 +301,7 @@ static void mctp_usb_netdev_setup(struct net_device *dev)
 
 	dev->mtu = MCTP_USB_MTU_MIN;
 	dev->min_mtu = MCTP_USB_MTU_MIN;
-	dev->max_mtu = MCTP_USB_MTU_MAX;
+	dev->max_mtu = MCTP_USB_1_0_MTU_MAX;
 
 	dev->hard_header_len = sizeof(struct mctp_usb_hdr);
 	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index a2f6f1e04efb..47e2e3931d63 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -21,10 +21,11 @@ struct mctp_usb_hdr {
 	u8	len;
 } __packed;
 
-#define MCTP_USB_XFER_SIZE	512
+/* max transfer size for DSP0283 v1.0 */
+#define MCTP_USB_1_0_XFER_SIZE	512
 #define MCTP_USB_BTU		68
 #define MCTP_USB_MTU_MIN	MCTP_USB_BTU
-#define MCTP_USB_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
+#define MCTP_USB_1_0_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
 #define MCTP_USB_DMTF_ID	0x1ab4
 
 #endif /*  __LINUX_USB_MCTP_USB_H */

-- 
2.47.3

