Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19E38F63D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951846; cv=none; b=r9nIBqDa7zFXdVMvwHrFDh0j15FfC5k5pa3qmQfTldoNHfk7EQkclxwZFQ3FwS9lh+mFzbfTdO/tZgM7dpul0we4QSuDlrY0NpXMmJKbpI8RKECGcfTZsJbW23QYmfQNj1cVH1GwE1MPnk5zGJrdl/UtJCqqE95MoK+bIlA5crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951846; c=relaxed/simple;
	bh=8UWpnnLNlMTuBb1RjtrUw213V6LMdmF5GUmRYg9Y6AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAzFcyuBbqbQuneaSHiBoAplSmqDUOYTPWq94S2VSe/n3Hr5TrqkHjrR8v1GwdNJbF3DY5gIJ1gWhES/URrM9Q0nV1PeHL2rV0Z91kih/P/EdxEtDPas0MmFJSmyF01adGyCP8XY4yrIDkUtI6TlRhu+nkPY54sp1+GBViirsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JRkM1rBT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JRkM1rBT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9E3F31A1445;
	Wed,  5 Aug 2026 17:44:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71918602AB;
	Wed,  5 Aug 2026 17:44:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A956D11C35095;
	Wed,  5 Aug 2026 19:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785951842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4IA4IRSLI69Af07xdFz7rSO8dFETuWxVSuFIVuAkZD0=;
	b=JRkM1rBT9fGjeLqmOgo06C6Di0Xbvw9g69dC7AW2YBuKmm7wKJCXrQHkUB6tBsP5sdGjiy
	QiLJom1jgiZ5nRAYImybKOgaV4Vn1pZy4lJa2D/wgISa68eK/8rEIMblG2O+pDUSG51WdW
	d9ikTX2kA5CM5gYxI/ErYnQKCMggl/rUjISx2nbdyoEVoV1Bh9+i3ZplT1Uxm5S8xVtsiV
	reGXelMhHML9pcaQi9gp0Ry8vpceZpvIys0LahmcyFurmjXvr7Oa/Ax7VGYU8rmqcluIfH
	AkhBdS5jniAyFrvh7jQ8dVSTbouJEOyNcejPAQjTm4O8Y/EFgxOJaBbluTe7XQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 05 Aug 2026 19:42:46 +0200
Subject: [PATCH net-next v8 17/17] net: macb: use context swapping in
 .ndo_change_mtu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-macb-context-v8-17-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-0-bc302ffd1174@bootlin.com>
In-Reply-To: <20260805-macb-context-v8-0-bc302ffd1174@bootlin.com>
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
index 4e004a5345b3..b3d84a65078f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3533,11 +3533,29 @@ static int macb_close(struct net_device *netdev)
 
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

