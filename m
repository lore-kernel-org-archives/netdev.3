Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D22514764;
	Tue, 13 Oct 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897426; cv=none; b=dm6wAeHc60F5snL2EwBVHFDJ6qVpOid3Xi88BkMQ0aGUPbdPgHaVmKgxTq0Aca4dJ+oWBYRrasWPf8x7aFf2A3F4HPLHIjN/wjXI/UlmDxt+XJozoR1RVK0d29fSfKV7i3XPR1pkmw0VstxHLySbPsvz9A0Q0KxOoPi2g1LdRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897426; c=relaxed/simple;
	bh=1snf4fpmi0B71IKgS9ucddkhaZQt9Hq5VcaTWkAj77E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVkK6Xh1FKaeWHEpTrPU0Sr7qtH08X3PXhtIqnBjDs6F0cCYDDVCKqI77n2rkcbwnis5sxvzSalFMo8gw32QsB/NNKkm233IW2qaw6/ViZX21kBp/6XVitlYMw/H+9w/9TBhBg4eDxq5TJec8ASz/Xag262r4jEghBjLL6OzfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H7geelwm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H7geelwm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 99F0A1A120C;
	Tue, 13 Oct 2026 13:17:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6301360362;
	Tue, 13 Oct 2026 13:17:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CD0D11D713D8;
	Tue, 13 Oct 2026 15:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QvtvKqHlDNZ/wVNOxE6lTQB+2t0bRlf71CJkAF46Q4k=;
	b=H7geelwm7TN/hXxMTUU/vgzMAKM5o0BQeKYQI13parc8a3COIBEyPA4PyMHfzvzizTAMFy
	EL0diTKPvxyJE+Wwum536UwzJvYMEYFWyu5EzuPQ0QAwxMgqAjZL2FvjB5076madPnzWTa
	QVYP49qLiNU2wSkudLynR7Dh6CQ/E9HNrkmITvpSVNn5KZRIC68kWe1abNrm+FxTv3g+8w
	zZmmxvdXFokSNi8umEkrLroCYKnUhElpHc1cZOg6Tm54P6YsRsWOhQM93MgSKbd4A53S9S
	w6C66QWyFvGdymxrYwAlUJNDU0/wzn6GS3Fok/+q1sowNtBfjC+9OD0LvsU4mA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 13 Oct 2026 15:16:41 +0200
Subject: [PATCH net-next v11 3/9] net: macb: avoid
 macb_init_rx_buffer_size() modifying state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-macb-context-v11-3-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

macb_init_rx_buffer_size() takes the macb private data struct and
overrides its bp->ctx->rx_buffer_size. To make it usable with multiple
contexts, make it return its value.

Also, move the `bufsz` computation into it. The value is only used if
GEM, and for historical reason it currently lives in macb_open().

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9db03b0f082e..537fa570846f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2743,25 +2743,26 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
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
@@ -3346,7 +3347,6 @@ static void macb_set_rx_mode(struct net_device *netdev)
 
 static int macb_open(struct net_device *netdev)
 {
-	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
 	int err;
 
@@ -3364,7 +3364,7 @@ static int macb_open(struct net_device *netdev)
 	}
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 

-- 
2.56.0

