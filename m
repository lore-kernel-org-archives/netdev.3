Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103C48035F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808868; cv=none; b=nekZcs5bmV5ekegUOQoU8BZJG5OtR5ftPs+P2GzQLhE6saLkohAlLByl9l4WCOrRiyIDiUiDGBNWBErZxFKO/k2cc3oPs2PJfN2dSm6Umiwz64CzKMs2c5GA+mGSuxQbEGqiIP7KaEHYpmRMThd2GvKXNhvHaY55p8eV10aSkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808868; c=relaxed/simple;
	bh=Pa7q5dbLTitCHiy1Q1hdZvYOASdG0sKeH1yu1l+oOiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6sFSBPRJDJI4m0ODF/8vEsm8uTly+QWazIGF5wouZD2qy2zSkKDQqSuxmqVX4ZepIgkDhFnC6KG25QLBK5fyfzGpUA2wpWXrcMY+53WblxaALLDeyQvZw6X0eo2iULjb9Cv5IFZ3otyTfS5hjvIiIwQiNCn2QFNw60Lld+4nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WHDFziIT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WHDFziIT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B28D61A1074;
	Wed, 30 Sep 2026 22:54:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8809E60749;
	Wed, 30 Sep 2026 22:54:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0374D1032A65A;
	Thu,  1 Oct 2026 00:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790808856; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f7pD9PjCcBFYCKRyplLMTcZQuHOpWI4bNICLIyVr35E=;
	b=WHDFziITb+e1Djc8ZxB6RhgWc+IRTRvJxwfjeJ0YRHB/J45SfusvT7YCuhktHlP+CBlmvE
	zuYmSzsAwEHjn/WS7erCUVuOWNHAT1Bm3lizA7WVeCAnpGSP0+4KDc8H8fcMmQ/KWTtLks
	qgLUjlHPbRlsJjmjRmJCz9GSIPfpsxUPeTPwNU4ugq6abEplK1WQx+pMt5qSNzMUvJExD4
	lxdQ5rnnNRaWp+yuyTawn7QeBTCacRkZ4SRer/rkWIBYGJQddPFBfkb+0/dDQNzQ3jvfGm
	i0n6n00uii/A4r+oax4DBjcBUlcJb2pDOyD+ZmX0oZIfpK9+tPmeoZUWMEst5w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 01 Oct 2026 00:53:52 +0200
Subject: [PATCH net-next v10 8/8] net: macb: use context swapping in
 .ndo_change_mtu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-macb-context-v10-8-beb541bbb7df@bootlin.com>
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

Use newly introduced context buffer management to implement
.ndo_change_mtu() as a context swap: allocate new context ->
reconfigure HW -> free old context.

This resists memory pressure well by failing without closing the
interface and it is much faster by avoiding PHY reinit.

AT91 EMAC is handled differently as their buffer management is separate
and they don't do NAPI. They cannot land in macb_change_mtu as they use
a different ndo struct. We still defensively protect against it in code.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 93049b399d78..4b03f8a51372 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3624,11 +3624,29 @@ static int macb_close(struct net_device *netdev)
 
 static int macb_change_mtu(struct net_device *netdev, int new_mtu)
 {
-	if (netif_running(netdev))
-		return -EBUSY;
+	struct macb *bp = netdev_priv(netdev);
+	bool running = netif_running(netdev);
+	struct macb_context *new_ctx;
+
+	if (running) {
+		/* Context swapping is not supported for AT91. */
+		if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
+			return -EBUSY;
+
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
2.55.0

