Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962336A02F;
	Fri, 24 Jul 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870145; cv=none; b=sGqDLHnTOfdTXeey75zw17PHdUNf0hweE/1GtDI6EedxFREczJmF9tAL1S67oN7GH/igtsdxJafi3jX9H8OAspE2+5gx9O6EXipkJ30tM3zEcGvf0mw087Z9Xyd0IFyaJYqFIJMwxC0bF7WzFz7GV5J8R9+zWTHq9vkw3vk4wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870145; c=relaxed/simple;
	bh=/2Ier6FRdzjPO3Emli1gXM2xVhA3IkF3e6eshK4zg2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCAdhpGWX3NCM5vyEYNImoeuI1Kr5voJ9bv5Xq1+w315oAKkiWE1gQ9h4OveYzQjX+FHl6R8GbnUXRkN8js7Nawh7kZS62KrzYAMcYVepnFI9tVm82D3S7nlhLcqbx4CrfZJPkwvbauLlAz+doAEDCaK+OMLNNsHyc1SyrImNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jC8OjDTV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jC8OjDTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784870141;
	bh=bjKgiEdKsT7lRbJrX1xrLVJ5yD4EUl26YxZG1ln3Jpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jC8OjDTVTRDJABNDtP5NVQ2/QtDO+zqRK16qVP6M75pla4o6CFoUSZDgrfMbmh/fl
	 j1kAAnQaAFJs5GMgBNtNkqcBpYbs2N6nxFghFPBdHRbNzbhCZWYGlev4GRhrFhj6aU
	 /LjI33WUk3tsY1znjZTJQB/DBObGPpyH7XCF/6wJeLzaLTb5YRfe0H45EuiAnqMcxx
	 BgnsqDPZP3QP+rsrEjjt5mT7IeSX9vi23gStnfOJcAubrSSyqBEKTEa1JhQJQkuJuQ
	 0RHXWSTVX4VC5120ftf6TRBXfNoQchy61yukRI8VyjkdZ4eeq2FZysWI8/V9ZAQ2f7
	 sMhDoneUKe1Xg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 59E7566F39; Fri, 24 Jul 2026 13:15:41 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Jul 2026 13:15:22 +0800
Subject: [PATCH net-next v5 01/12] net: mctp: usb: Include version
 indicator in max packet size defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-dev-mctp-usb-1-1-v5-1-e66bbba0dbdc@codeconstruct.com.au>
References: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
In-Reply-To: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
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

