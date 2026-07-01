Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5E4A2E2F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921592; cv=none; b=uSw8vUS4t5KRYGqLev1OoQDBo+v+3ir4i6oy7TK1MfqynmGR+enzxScrDxRWvJJHWNSR+m+ZJ28FEbRnVTaniLeWKY7eST3XioswhbYAiAsmR5dMcPGPcVs4OBveoWRZm6APwBbBja8VGDRF4S5FJuBKPzwXal3H+mCmSFucokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921592; c=relaxed/simple;
	bh=3/x57bg6uW8HO4o9Y7LYmZ8UVlNPNIW5ZZJTudltJ64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPoJfeo5dav/co5BV347VNcT5JvBfa02PtQOSiORJZekMzpXnrTYGm6chtkYrWs/0MQWdXW3a+P8Vrjfxi75cdfpJ7FV3wxHz0qrhGQ7B4JkwV2n116mIzgUY+1+5/pAfILLrLlaK/ZWuBZ/hwkT3s4Zx3W9FefrJZyHVx4Ukws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LxBEXP5X; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LxBEXP5X"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9B59D1A0DC0;
	Wed,  1 Jul 2026 15:59:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 662CB60288;
	Wed,  1 Jul 2026 15:59:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E044104C9682;
	Wed,  1 Jul 2026 17:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=01vGfzi28aGqI+kF4+SwC1BpZPX/QgkdYy1lWXmAF/I=;
	b=LxBEXP5X0sAjjCuElJMu8U0Q7L3ifuPqa42ynGvi4bavH1t40O1NcFSdx+PgVAzQDTjn00
	4MYdAWrdWxLLD2iIyjZ5lZ4wmiK6nVQn/chLIQ7vapxWOP9owwadnFfUS3z8ALtezkS3ad
	FpEcDhh6SSZXRiLCqyRAuQBT7/kCGSGxlq7aymE3OWMoiqO9YcA88B24MnZ+wAGLgRrm+W
	LC33sKJd7c5P0e7y3g3EGCPCGvn9xqI/UPQKwyBQdFA5z/43rLKDjsOZEg9SvtCYckTYyY
	3ETzuqgfKU1WlmicSPPU/0acmlYyiRBnPUqvLFBxpZJIkuFIVROVwY+3tHEt6w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:16 +0200
Subject: [PATCH net-next v3 13/15] net: macb: re-read ISR inside IRQ
 handler locked section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-13-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
In-Reply-To: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
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

If we tried grabbing bp->lock while already acquired, we might have
slept and the status might have been updated. Our most likely
competitor in this race (condition) is a swap operation, used in
change_mtu and set_ringparam. It is the only MACB codepath that resets
interrupts and HW inside a bp->lock critical section. Other codepaths
that clear HW IRQ status do so outside the bp->lock critical section.

We can only detect spurious interrupts before grabbing bp->lock if
MACB_CAPS_ISR_CLEAR_ON_WRITE. If we don't, then we only read ISR once.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7245c345c78f..5a32d5cb759e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2184,13 +2184,21 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct net_device *netdev = bp->netdev;
 	u32 status;
 
-	status = queue_readl(queue, ISR);
-
-	if (unlikely(!status))
-		return IRQ_NONE;
+	/* detect spurious interrupts without grabbing bp->lock */
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE) {
+		status = queue_readl(queue, ISR);
+		if (unlikely(!status))
+			return IRQ_NONE;
+	}
 
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

