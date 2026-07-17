Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273EB3612EC;
	Fri, 17 Jul 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317727; cv=none; b=mhbWOprgDNJAfAZ51HWtRkKTKWVV0t0olnkaGseq9eizdPbIDIrKcAzxBcVhEAtO9tLVpqlQJy/Tu+1I4fCDrSIzRw8W1mzz5eK2khjHo7QJqbpJOBOPX+CHKgFSn+4iYQtvaYUBcaAW81G3Tyf59/ZqzPYJ0TDZA3jtSgUozas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317727; c=relaxed/simple;
	bh=pRpKa0I/+8Nkfs8kzlk/mlChs6uSzIIEN+tJ7kegSuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHb1g5xln0KpwvD9AxTyPeJSVUxFtf6Bp66jkNQQHdBh6ns3L8XH9qmxo2gFYcgf7VSYzEaRewT8Ezspo27HmnU7cIYI5n9QUXmZJdWhPTonEp9RqeCCqJq/1SzpMvFFLlbArMKBVIKm1+1SCkNP7+8jkCQBEsGMfy8EUcbyl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lZz7UQGV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lZz7UQGV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D2B4F4E40E24;
	Fri, 17 Jul 2026 19:48:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A658F60361;
	Fri, 17 Jul 2026 19:48:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5091111BD27C8;
	Fri, 17 Jul 2026 21:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784317719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=z0aTBD2m8FuQuftpSH3n57qm8gGGRqaUK+lFatsuQ4Y=;
	b=lZz7UQGVJ9gRcWeduEudHnhKqN894UoQy/qmdYSXOE+SlwIFXYQaXccXtkW7WRw3/j9jm1
	blpglVo50dWlNdmMTdoFq0hU9cspGskdqXhLe5VYkFLiUppQACzRIKwHKu3rFcJg9VOSei
	FCy3aZ3Z1o4J7sQtRTm3OOxJh1YBiA/LqHo/kRWKobzPaU3baW1MQycAZdzaWFX/54oOYu
	Ej23nqdWOWM0lBeM62Ce0KNQIiNP2+JbUZ4w7pIbYaG4wwqYydF7R0JaJUZP95IsNYLsZc
	9y6Auz4PqDguRMHyxqBHMr5Rz3FzLBlLw4UWGbaR4PHuhDjmibifXGHE+3mgDg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 17 Jul 2026 21:48:11 +0200
Subject: [PATCH net-next v4 08/15] net: macb: avoid
 macb_init_rx_buffer_size() modifying state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-macb-context-v4-8-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
In-Reply-To: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

macb_init_rx_buffer_size() takes the macb private data struct and
overrides its bp->ctx->rx_buffer_size. To make it usable with multiple
contexts, make it return its value.

Also, move the `bufsz` computation into it. The value is only used if
GEM, and for historical reason it currently lives in macb_open().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d50d8520231c..29bf3c497f2a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2615,25 +2615,26 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
+static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
-	if (!macb_is_gem(bp)) {
-		bp->ctx->rx_buffer_size = MACB_RX_BUFFER_SIZE;
-	} else {
-		bp->ctx->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
+	unsigned int size;
 
-		if (bp->ctx->rx_buffer_size % RX_BUFFER_MULTIPLE) {
+	if (!macb_is_gem(bp)) {
+		size = MACB_RX_BUFFER_SIZE;
+	} else {
+		size = mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
+		size = MIN(size, RX_BUFFER_MAX);
+
+		if (size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->netdev,
 				   "RX buffer must be multiple of %d bytes, expanding\n",
 				   RX_BUFFER_MULTIPLE);
-			bp->ctx->rx_buffer_size =
-				roundup(bp->ctx->rx_buffer_size,
-					RX_BUFFER_MULTIPLE);
+			size = roundup(size, RX_BUFFER_MULTIPLE);
 		}
 	}
 
-	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n",
-		   bp->netdev->mtu, bp->ctx->rx_buffer_size);
+	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n", mtu, size);
+	return size;
 }
 
 static void gem_free_rx_buffers(struct macb *bp)
@@ -3193,7 +3194,6 @@ static void macb_set_rx_mode(struct net_device *netdev)
 
 static int macb_open(struct net_device *netdev)
 {
-	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
@@ -3212,7 +3212,7 @@ static int macb_open(struct net_device *netdev)
 	}
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 

-- 
2.55.0

