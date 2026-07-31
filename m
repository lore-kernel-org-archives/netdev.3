Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C2477980;
	Fri, 31 Jul 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515721; cv=none; b=rchjR/8SmFYex3qWKZ6CqUONo4STzflgZG890c43iWGl1GWcQRn/NT6sSulcG849s6bKIZh99cbnxkbDTq+oF1mDxkF+4B2XKvd/jxzFczLUEYlTxYH6R1GiR2gqxtz09umlm8NEr0H/Q94TsVDR8xr6Nhcq9spS+GszEGB6aik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515721; c=relaxed/simple;
	bh=ZQPAB2EdjNCkDojRo31G/l7ighbYZDeO9SvXGz7V4JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAfh/ah1E8jFw7y8rwCJf+mJoX1lCwzfGGnGnhzvMyNHyPkbW3ggDKMcqtL8vKfVZOi4YOG/AClC5GxZWZ0LxpAYTIPxrtxB1xSssFe4oijzEZx9m67UEi8EFEIc2DV8GvIKkFhUNoMa2cxHAWkXedjPIf6qWN9ZSJvV8HNVKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sp5u7iyc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sp5u7iyc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1AB004E41058;
	Fri, 31 Jul 2026 16:35:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3C0C6039A;
	Fri, 31 Jul 2026 16:35:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3218911C16AF1;
	Fri, 31 Jul 2026 18:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785515717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yHa0chImL6KqY4UK3B6qPkA9jIkL823FI0WvOrRJRgY=;
	b=Sp5u7iycY1vfEOHPBIUpVbpIWsZuhE5SiMWDCMOpN/tFviKVq6rOUxSvzMpzturUqSGBq5
	G444yxvpBrrJ90gP4GiR1jV1zqJFoXCcPYzkMLN9VdPXpbq82t9EnRxJF2Dd5jKoWa/jzw
	ASaJpPAA6hmcO0P9P9KgoWOymxAVaF6lMnKceG/W35SsH6SbIsdBKea2J85U/1hDyUsl8r
	agcMgNeiCvrDHWEsf7eejo5T3aQ5LQKib4oZXp8CLH0434PD1JpUNeWb17j0oBtJ3RoZYO
	TSGgLowhl1Lqz4vgJYB7D+B1TUNagLuz7dxbfY0WelAQwNp9HDuxu9EvvJ9XvQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 31 Jul 2026 18:34:24 +0200
Subject: [PATCH net-next v6 14/16] net: macb: read ISR inside bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-macb-context-v6-14-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-0-49d5a1439d48@bootlin.com>
In-Reply-To: <20260731-macb-context-v6-0-49d5a1439d48@bootlin.com>
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

The IRQ handler reads ISR register into the `status` stack variable.
If empty, it early returns. Else, it grabs bp->lock and iterates on
the status bits.

We risk a race on spinlock acquire; status might have changed.
Move the readl(ISR) inside the bp->lock critical section.

One risk remains with spurious interrupts that would, in addition to
taking excessive CPU time, also create lock contention. How bad is it?
Probably not too bad.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 65d5ff8a5e23..27824e468888 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2190,13 +2190,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct net_device *netdev = bp->netdev;
 	u32 status;
 
-	status = queue_readl(queue, ISR);
-
-	if (unlikely(!status))
-		return IRQ_NONE;
-
 	spin_lock(&bp->lock);
 
+	status = queue_readl(queue, ISR);
+	if (unlikely(!status)) {
+		spin_unlock(&bp->lock);
+		return IRQ_NONE;
+	}
+
 	while (status) {
 		/* close possible race with dev_close */
 		if (unlikely(!netif_running(netdev))) {

-- 
2.55.0

