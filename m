Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED64477E4
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907013; cv=none; b=laHgu0VxBHkMI/aqkWJd3iV99FW/xDiLcvaiePVGWt2Pp3NsAt6OI8Wprt1aXbbLsjt0Nw+G0THbUrgfoD09C0wf+Mst0OhXt8yqKAuYL+s6WXtssY7kcSpQ2OUlLWmuRNviU/SJa9tuQM0j44XoAm/2TDacKxc/H+WYlqX5yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907013; c=relaxed/simple;
	bh=xgFR56cEctPnU44NbQkSctNHHyx3Gwq+iWPsz++MoMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uaFlEH6LvUj/0UY1PwIEFclIua8RuesxlFNXT6O3seKHBcvXpOx5faLP+KetwmkZCVLPW2zvtMj7oj52rB3Dxu72Mf8YYLwV07gsurBzRnZXWUGbO10K8V2huNu8iWtBDEtfrysttQ24ZImU000ZQ+6I7SS/od2iS9fi0v7sgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AaIn8OJM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AaIn8OJM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B5C491A11F0;
	Fri, 24 Jul 2026 15:30:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 841CD60395;
	Fri, 24 Jul 2026 15:30:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 795FA11C12774;
	Fri, 24 Jul 2026 17:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784907008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LI/gBoJUzxVw+q/G3NTA5i4qc4nmYI+KxQRJoi43voE=;
	b=AaIn8OJM7lHnT3WOwMk3s8LEUANhn+3RgU9jYB3lNPJFiwlflPKMvD/G7m52Q55Cn81HNr
	vRGYaa0jTGVv6eEtaz2kv94WKUWhDfaQrdT4SY7s0e5ystLvev27FPDxiQBdi7MQDjKL1C
	oAJjpSgGaVkaYoakAY497f66PQ3viqb4lnklrG8APQxMdTu7X2AopJzWRfanJGqCeUDjyl
	RcYZZ6IjaBtlZMPY/1CrwwpQzgWLj1iUMv6w/QZBEs4dGuYvCz+L6uNhUSd+Of1E1I25K1
	gFXC7YZ+0Chzbj1+YWvlFU7t+v+jyAz1FE42AIE/3u3h3csyT697JqdBF53xHw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 24 Jul 2026 17:29:38 +0200
Subject: [PATCH net-next v5 15/15] net: macb: use context swapping in
 .ndo_change_mtu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-macb-context-v5-15-569b1852bc7f@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
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
and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
context swapping for them.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d6ca957e25ca..a138c9d8301c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3496,11 +3496,29 @@ static int macb_close(struct net_device *netdev)
 
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

