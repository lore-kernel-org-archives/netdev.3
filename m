Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF823B7B8B;
	Fri, 10 Apr 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850766; cv=none; b=QZfTS9+Lxp7C8U6IsJqgBYxsA7cFBpbJ+zeomLXkmZ+yM9riYyh4M9qMGBIRff1nJJ7Y9stRgHsZ1qxAIRgP0eljGXmkqvbZWGkrUIGWq7NAMZHe3AJ/+lJOG5jOJTji7rARchjs5nyf9tEtUxQ92aLwNeIrwinM1oGIqHXiQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850766; c=relaxed/simple;
	bh=EzIdHHz4fypbJePDCerf2X/mA86Qr2ZoIbroVCbcFUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEDu4qqUhfltNSQBuSwbX01IirriaLAgUPkqn4sVggtVoo5D+ffHGaKCf1HwVTdbgWTV3lwVt0Ijt9EQsyjpfvM2nHAA2HDne08K8nQs70WwyEi1Od0YXQrwzx0mwT9XRpSNd8v/Z2b5bgduNLcQhPRa9c3DxlFvWX6T3fGXpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GedK4CKr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GedK4CKr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54EA0C5C1A7;
	Fri, 10 Apr 2026 19:53:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CFFD603F0;
	Fri, 10 Apr 2026 19:52:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE82410450094;
	Fri, 10 Apr 2026 21:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wlicsiiNi7K7h1hDQH51jqu2etfLUYke8K7iRJiJCvs=;
	b=GedK4CKrh3ZPOzQ+J91x/Sjt9/aBvypoPqzgdqVcDtWu+zm0ixfc7012ht2mXI/sLr9WIg
	hWWZVJwnAEeBU8oWdIPPgD1thKfX54BeBMxZGkM1/hgDfOQDtynyKy+jYLrY27kBVRYwFC
	gcWQmrnVuHSzk34QHM42p+CJGlyJB5nXHzROmlmsFM+3xb8aIVHv15r05Lexp4BSXRkIom
	6LaY3xu7zrS0esxLZH2NyxzQBtGBdLAi7sX0NSdLE6xKWLz8kQFHB6dTGJOSU69VKy7tZ5
	0oFo0RK7lYr4FaK+TT/Azpkrvri4PUFwQukmX/GDQA/xunaampwp+m8sTqpVrw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:52:02 +0200
Subject: [PATCH net-next v2 14/14] net: macb: use context swapping in
 .ndo_change_mtu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-14-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3

Use newly introduced context buffer management to implement
.ndo_change_mtu() as a context swap: allocate new context ->
reconfigure HW -> free old context.

This resists memory pressure well by failing without closing the
interface and it is much faster by avoiding PHY reinit.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 340ae7d881c6..fbc5feaed4df 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3430,11 +3430,25 @@ static int macb_close(struct net_device *netdev)
 
 static int macb_change_mtu(struct net_device *netdev, int new_mtu)
 {
-	if (netif_running(netdev))
-		return -EBUSY;
+	struct macb *bp = netdev_priv(netdev);
+	bool running = netif_running(netdev);
+	struct macb_context *new_ctx;
+
+	if (running) {
+		new_ctx = macb_context_alloc(bp, new_mtu,
+					     bp->configured_rx_ring_size,
+					     bp->configured_tx_ring_size);
+		if (IS_ERR(new_ctx))
+			return PTR_ERR(new_ctx);
+
+		macb_context_swap_start(bp);
+	}
 
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
+	if (running)
+		macb_context_swap_end(bp, new_ctx);
+
 	return 0;
 }
 

-- 
2.53.0

