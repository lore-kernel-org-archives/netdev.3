Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246B444707;
	Fri, 24 Jul 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907008; cv=none; b=Bw3yT9n2cmoA3Utgjy+uVrZ0ORMYye+la5jBnSqZGVY2izk5zpHlYx8YInvQ64AB8soix7O+AHWrPgPkT5xCya3nGVmZIb6RUbUBt10lfVAg5A3MjUEzZVMOjc8hq8L+LZToBKyn3a2ZpxVB7pNKAdLwdoe6CmwK6QqgCgk8rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907008; c=relaxed/simple;
	bh=KAT4a4mXTfDNX6D3fdD1B/thRuhSJdX18BjsgXOAewc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wy72Vj6JL3DZpCixc2zn0WdJjArvj4X8gtsxaPWC52y4HScDB2plAi3FslyNIILs+ctAbV9fKZfyrFE2qZ+AZuGal0xxw19IYg9VG2oqR/kTXmMyn1nH4u+VvPLtDyIwsTRrvn5fP7iuC5u9AlGANGJUugMsuv5nr3nNKBEoG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P0ft6gwv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P0ft6gwv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 59ED11A11F1;
	Fri, 24 Jul 2026 15:30:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E32360395;
	Fri, 24 Jul 2026 15:30:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF8B711C1276E;
	Fri, 24 Jul 2026 17:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784907004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WDljWmz/RlOY15I3cXIPsKQy0pIZpmUXlnyLPeZm6Cs=;
	b=P0ft6gwvwMzEvXmBMiT4gq86RsqTKAbZ3h59EO0FpiFWq/51e8OlIo4YyAiqd6vh7ldtNv
	FDVEyPeyTF2JwSkd970QYOVO6PuaYhU1y3pIiUU6sTAevvtH20csEwg7vbx42q/aT7MExT
	K5nVsVJd1gOk8xt6R6/X4nt5kLMnU02HBydivtMwOKIaYgmm30DmwQ8oRrw+Cw2Kpqgdce
	pGNE4imT4PLU+h4rc2+bx6cwdPeHpFo2Ti7lSWKPpzjvcWcZ9iljEeqwNK4lQMkmtiLdVy
	o+JrfPS+b7SIUEssuPU33LfwPHpPB2ITNUpuVo07ZEjB8Yw5DF3cOYKQbPLVeQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 24 Jul 2026 17:29:36 +0200
Subject: [PATCH net-next v5 13/15] net: macb: read ISR inside bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-macb-context-v5-13-569b1852bc7f@bootlin.com>
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
index 4c94c23d925a..c832b6c1b98c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2185,13 +2185,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
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

