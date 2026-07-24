Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CC36B920;
	Fri, 24 Jul 2026 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870161; cv=none; b=BQwmmvf2UAT1v2UISsAzCmynw0/K9VusM/YbxdaLkS5kuPVBziSv5KbpyvEgOZxw/Rv00uibul7svgruJxvMnNC9lbq8p3I/+m9GxYHOC8QU1wUjfYIQVOtaQrDHWXqdJOFz9Aet7zWtkt62ueri7iNG3Lf4W+Cf0FdPcSuGQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870161; c=relaxed/simple;
	bh=8QNE4Jg9czPrMfSdZDBYbvsG9uLL8b402gsiedUfdDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwiJ0i7UTcd6RFPND5iwp1y9417JavVbSK7NEp1NHMvee/EHPA8PAHxQLjiI8A8+OpIekwfqo8pVHxgTSQjtDPHrNONxCsbNuMjzLbBF+YpFSqd/Q78UUl9m45rxOBtXPJ0RdBRf11HTMBRBtgz+XYNQ3u/IULYl8o+LWbWUE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=e3zZ2z/Q; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="e3zZ2z/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784870143;
	bh=zQA/lAdWT1G2TPowypQluYQTGVIVqEckouEduuRgadg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e3zZ2z/Q34zxc/tJF5dDni8+1StCmvgMr+Jf8Zg0Cw1E9fyyue6KbBPPf+HTLDPSo
	 XS/6N2s7oahq5YUaIYiPJRGkWJyjFD/4NUeNxBf094roOAltT7Wt1W1BBJUE9d1nLT
	 S8CXfRsks3/uqtXgd09G9KUDZzeUo3HlxiQG3jqewoDUNw10cX3aoBqbgt60CnjIra
	 VMCTVJK8Kk3FtYwgEHsiap2FoPCMckUIQ/BnhWu+aShyBCE5k/MEK0kU23jRGphvCL
	 I9c6tE7VSWqgj6C9akGjklg3xIj16Wos55G5vS2jQkKxHQGx05a+6Vo8+RH8tGnsNH
	 Q2NlfOgqIKRzw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A5B0B66F41; Fri, 24 Jul 2026 13:15:43 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Jul 2026 13:15:30 +0800
Subject: [PATCH net-next v5 09/12] net: mctp: usblib: Implement
 transmit-side packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-dev-mctp-usb-1-1-v5-9-e66bbba0dbdc@codeconstruct.com.au>
References: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
In-Reply-To: <20260724-dev-mctp-usb-1-1-v5-0-e66bbba0dbdc@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev

Add support for packet spanning as defined in DSP0283 v1.1.

With the existing v1.0 implementation of multi-packet transfers, all we
need here is to adjust the buffer sizes to suit v1.1.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c    |  2 +-
 drivers/net/mctp/mctp-usblib.c | 28 +++++++++++++++++++---------
 include/linux/usb/mctp-usb.h   |  4 +++-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 439e92722a0a..2240c81cc6e7 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -344,7 +344,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 				 false);
 	if (rc)
 		goto err_free_netdev;
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index 2304e33193b5..816a86b26a11 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -248,7 +248,7 @@ EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
 struct mctp_usblib_tx_ctx {
 	struct mctp_usblib_tx *tx;
 	struct sk_buff_head skbs;
-	unsigned int len;
+	unsigned int buf_len, len;
 	enum mctp_usblib_tx_buf_type {
 		TX_SINGLE,
 		TX_FLAT,
@@ -258,18 +258,19 @@ struct mctp_usblib_tx_ctx {
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
 			 const struct mctp_usblib_tx_ops *ops,
-			 void *priv)
+			 void *priv, bool span)
 {
 	memset(tx, 0, sizeof(*tx));
 	tx->ops = *ops;
 	tx->priv = priv;
+	tx->span = span;
 	spin_lock_init(&tx->lock);
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_init);
 
 static int mctp_usblib_tx_avail(struct mctp_usblib_tx_ctx *ctx)
 {
-	return ctx->buf_type == TX_SINGLE ? 0 : MCTP_USB_1_0_XFER_SIZE - ctx->len;
+	return ctx->buf_type == TX_SINGLE ? 0 : ctx->buf_len - ctx->len;
 }
 
 static bool mctp_usblib_tx_should_send(struct mctp_usblib_tx_ctx *ctx)
@@ -358,6 +359,12 @@ void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx)
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_fini);
 
+/* Max size of a spanned TX. Since we allocate a separate span buffer, limit
+ * the tx-time allocations to 4k. Larger packets will be sent as single
+ * transfers.
+ */
+static const unsigned int TX_SPAN_MAX = 4096 - sizeof(struct mctp_usblib_tx_ctx);
+
 static struct mctp_usblib_tx_ctx *
 mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 			  bool single)
@@ -366,11 +373,11 @@ mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 	struct mctp_usblib_tx_ctx *ctx;
 	size_t sz = 0;
 
-	if (single) {
+	if (single || skb->len > TX_SPAN_MAX) {
 		type = TX_SINGLE;
 	} else {
 		type = TX_FLAT;
-		sz = MCTP_USB_1_0_XFER_SIZE;
+		sz = tx->span ? TX_SPAN_MAX : MCTP_USB_1_0_XFER_SIZE;
 	}
 
 	ctx = kzalloc_flex(*ctx, buf, sz, GFP_ATOMIC);
@@ -379,6 +386,7 @@ mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 
 	ctx->tx = tx;
 	ctx->buf_type = type;
+	ctx->buf_len = sz;
 	ctx->len = skb->len;
 	skb_queue_head_init(&ctx->skbs);
 	__skb_queue_tail(&ctx->skbs, skb);
@@ -443,15 +451,17 @@ EXPORT_SYMBOL_GPL(mctp_usblib_tx_send_complete);
  *
  * On error, populates @reason.
  */
-static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
+static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb, bool span,
 				      enum skb_drop_reason *reason)
 {
+	unsigned long plen, max_len;
 	struct mctp_usb_hdr *hdr;
-	unsigned long plen;
 	int rc;
 
+	max_len = span ? MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_PKTLEN_MAX;
+
 	plen = skb->len;
-	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX) {
+	if (plen + sizeof(*hdr) > max_len) {
 		*reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		return -EMSGSIZE;
 	}
@@ -490,7 +500,7 @@ int mctp_usblib_tx_push(struct net_device *dev,
 	unsigned long flags;
 	int try = 1, rc;
 
-	rc = mctp_usblib_tx_skb_prepare(skb, &reason);
+	rc = mctp_usblib_tx_skb_prepare(skb, tx->span, &reason);
 	if (rc) {
 		mctp_usblib_tx_stats_single_drop(dev);
 		kfree_skb_reason(skb, reason);
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 2979ddaa4dab..4bb04a371105 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -81,6 +81,7 @@ struct mctp_usblib_tx_ops {
 struct mctp_usblib_tx {
 	struct mctp_usblib_tx_ops ops;
 	void *priv;
+	bool span;
 	/* protects access to cur_ctx */
 	spinlock_t lock;
 	/* context to which we are adding packets, cleared on send */
@@ -88,7 +89,8 @@ struct mctp_usblib_tx {
 };
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
-			 const struct mctp_usblib_tx_ops *ops, void *priv);
+			 const struct mctp_usblib_tx_ops *ops, void *priv,
+			 bool span);
 void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx);
 
 void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx);

-- 
2.47.3

