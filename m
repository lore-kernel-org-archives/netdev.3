Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BD47A891
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808853; cv=none; b=YFpaPW0v5bwlWtqn85V2iNH9uDwrShU+5E3rww9QWa2CiIOphcXgVPqpeD0DvhcGGa/fsejGGMPvNqLHceMJad6NniVAyp7rf96xKckZPqGMkm7hLSQL+H0L+w2vEO5NmC9QQNzIurqCxCz9wjjIwarcFoXKqmmxP8EwquqxOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808853; c=relaxed/simple;
	bh=OtRxmIAWoYrLWaffIrMDhYmR+2v5UXkzRZH6Uqz5Xz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKSEDPN+mgJ1+YtIC2szcJ0Y4zy9ji4p+8kpnQbEHUnH8yPB9iubLxzKzQ7fzDthJQmUdlcjRbmYGrkOj2pLNILcl6IRpgbXAc+mFjoFfRdq/0djqXIXINM8EsIrbAGfxOpQvTne2+N/nayp36jWuM2zc2OJl7mIBh8a9utysZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iHFCxKTQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iHFCxKTQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9AFFE1A1074;
	Wed, 30 Sep 2026 22:54:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68F6E60749;
	Wed, 30 Sep 2026 22:54:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89652103298BA;
	Thu,  1 Oct 2026 00:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790808843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6ShewIqApJlumDeRUvbZKEA2VNqov73/Ztx1JvEFPoQ=;
	b=iHFCxKTQP0JqvCHqPCUEUgHHKci1FlkSntZjAwkE4qIMkdRZlkHAWNaeP9GOq3Foqkr0Ha
	Y1Uch30VMaaRMIkBogFMaqvujp1VhKt9wY5UJv9b2vwuVDqjUgrOdYfLTf71wxqJxASsps
	JP9wH7OQZ2X8KJJ6xWBQYJG8w5PazlPbEfQ762u/Q2ZceYhAQRTF0M8/+qf/HYrM3Ttizk
	3rBF+VoTd6PLBPX/CHFveYbMB/lF2ghfL7/BlBEvHsuEMY5lroQfU3Wzyd3JV9GMzWOqqa
	21wUunTkVW64wcKKteNzuAv4cWbrKd5lCaVhv0qi39CgcS9lYagkRk5Sn0P1SQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 01 Oct 2026 00:53:46 +0200
Subject: [PATCH net-next v10 2/8] net: macb: avoid
 macb_init_rx_buffer_size() modifying state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-macb-context-v10-2-beb541bbb7df@bootlin.com>
References: <20261001-macb-context-v10-0-beb541bbb7df@bootlin.com>
In-Reply-To: <20261001-macb-context-v10-0-beb541bbb7df@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
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
index 73ee650e0906..228ae4e58880 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2709,25 +2709,26 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
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
@@ -3312,7 +3313,6 @@ static void macb_set_rx_mode(struct net_device *netdev)
 
 static int macb_open(struct net_device *netdev)
 {
-	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
 	int err;
 
@@ -3330,7 +3330,7 @@ static int macb_open(struct net_device *netdev)
 	}
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 

-- 
2.55.0

