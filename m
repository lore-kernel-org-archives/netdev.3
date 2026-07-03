Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E3364925;
	Fri,  3 Jul 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057698; cv=none; b=rXv2BhQ2zifvNci9nzX3HQyFb5IXu5nTzxFjtQZqitViYU9XYFb2j+8IYPMy8c2SsdOXPPTKvCsAsmQ/pJhx8F63N/3B2a++N2p4ORvhqSsYAQKVbUYIUwxowjElRLqfc6eBbFlLeyY/oATj/WAPJuZon2ggBihnR0qGQ8aJPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057698; c=relaxed/simple;
	bh=/2Ier6FRdzjPO3Emli1gXM2xVhA3IkF3e6eshK4zg2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peFhdb+0uP82iaH07U70xHvSryB6erLDge9MVOmzvgmrV7s2rCFrH6Q9VDQUwt/08H2CE39fFsPoUGgVDsqQBMtw1TwCWfSJJK76h48r5RM4JPxCCcN5RFeYLrM0N3mP58V360kHchLv3ey7tP/xPeKJWzc1ovtnqIlm5VVC9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=G5o/JtfK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="G5o/JtfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057670;
	bh=bjKgiEdKsT7lRbJrX1xrLVJ5yD4EUl26YxZG1ln3Jpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G5o/JtfKput8AP98Noldv5U2+Vd8CjCj/v/h6XcpiHxoCgUT1FxCjhDDIcJJUZkhv
	 VB4HyPY9yhUH1f4FA4CqDE/NMLN4v5SJ7ZfQEWuWo4Pv6aJB6tCPAEupwVEJR1z7aa
	 FFPMwxlaUeu4sObDKheHhG6ar7pXwh8mA3R/WTCBvyGUEEvRHsbX7Qou9wrDiOd/kY
	 /UaV9SUe/quF/40IeuHU2BbBkF3mLKc3Aq3Ughj5HWIFfXUWCj9fsF2qlbySQnhV8B
	 TGbZusYroF+SOj8afomlt/DgdIIlvyhOSE13FJk9yOufWrmf4ciX56ge5VFSsCO3J5
	 080kPdNhrfvYQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 1146C66288; Fri,  3 Jul 2026 13:47:50 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:21 +0800
Subject: [PATCH net-next v2 01/12] net: mctp: usb: Include version
 indicator in max packet size defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-1-60367b861b33@codeconstruct.com.au>
References: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
In-Reply-To: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
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

