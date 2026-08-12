Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6C3AFB12;
	Wed, 12 Aug 2026 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521852; cv=none; b=VyBXbjQMUiJMcxGlk5oMSzXmAioINh6VOetZHcLd0OhYXCGjjOdk5FU/nP8wWcPUE3E10SvnTIo2Cw7Kz0xjmq/RAm+ZnOB89oDFYBo1qPdwpVnHrpaSOuJKuN3R1X8q8B4UOPi1uzvI7aY+roe0sh4/+G1U7p3dIGKKcB9K+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521852; c=relaxed/simple;
	bh=WJCYNYzGCm+ESB02dwaM3IlceuLZb+u/qIh3VVcf7o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElG64R1CCYtPoopGXg/r0BdSwIJzBdLxB+/4tLfhql5WP0jWdMB3y1UngHg4dc/zGpC/peJTJphK4PYKF65gb7pvehM4+Ph/Wo0fGrWfOv/IeKA8gIapRx4q3KXFWOS6poP7z8//knVvENrwFhY44Tfvk9ybUIxp8AIiRolTljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OjayLRC6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OjayLRC6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A5EA81A1571;
	Wed, 12 Aug 2026 08:04:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A6E76045E;
	Wed, 12 Aug 2026 08:04:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B765711C4C947;
	Wed, 12 Aug 2026 10:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+Uht2c5qOy0jdHB6xucA5WgK3h+XfE0KTUb/0HjPbV8=;
	b=OjayLRC6+BhNPet1mPNH1YKqr9G8dR7rpu/f/d/sgJAD7J0eQqnrbTLSumvxN/KxA5KfJV
	6xDjiXCCHCt3iOXylYsSjP4+2trUp9OipzgCQk39lg4RVi7jDZeD5KCPgNAxhrW3pL0zIV
	8gW0dkXTiINHj+LD6uKRKPOwJrbTp3LpvqmIiiqWSj/GHBKSF3MPczc+f4WLpmwhkpAWL3
	egbjENY9ud7Q4wFdtfrMsXEh34Go69tKAxr4khjDXw9ubAZhmRvtW9Jxgc/2Uf7T44lCrv
	kInVZ2FIVIXCSDd+Dv2BoPSsnBjbUHSlZWlqGixN+I0TLcPWJXoVsbHJS0S2wQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 12 Aug 2026 10:03:23 +0200
Subject: [PATCH net-next v9 09/17] net: macb: avoid
 macb_init_rx_buffer_size() modifying state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-macb-context-v9-9-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
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

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 380ee72e26ac..d2acf44bb6ae 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2617,25 +2617,26 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
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
@@ -3195,7 +3196,6 @@ static void macb_set_rx_mode(struct net_device *netdev)
 
 static int macb_open(struct net_device *netdev)
 {
-	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
@@ -3214,7 +3214,7 @@ static int macb_open(struct net_device *netdev)
 	}
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 

-- 
2.55.0

