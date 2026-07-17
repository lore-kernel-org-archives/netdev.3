Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924EE5B21A;
	Fri, 17 Jul 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317739; cv=none; b=Q/5t8NGyzZio38OKbRBY5MZ/kC6VmDgIVh2ObrKlcRvRew5zlRifyxl1Osr0QpnrCiRTLprZc6OIZqbFHfpCQJ6rjEXfN2RZ+6lMR7n694fkyM6nmswQKrFtv6NLV4RhfvQ9yzPDKoN0YZJwNe5BpEefrEpBEDb9YP9gXby/w6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317739; c=relaxed/simple;
	bh=JVwxpZC9LOLSVDgzBiXh1r0KDkuIpXYw0kPwuBw8Rtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrN//OruyKSgy7vFLXSJk0p2+30r2XBysmcpSOGY2SR1Nq3TSXZWlFSaVXjGJ6KDf9MG2ECRsPoIPxpC0S2Te8cfpUodFIRzdoIi+4uJLfp3Cm0RPJkdDTZtimtqF5q0Ilhjxw4cSu4T+s0gcuMkXGfq0dxCAGeoZJdBft/bzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0KSUkY9s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0KSUkY9s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2153B4E40E26;
	Fri, 17 Jul 2026 19:48:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8B1760361;
	Fri, 17 Jul 2026 19:48:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7582C11BD04D0;
	Fri, 17 Jul 2026 21:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784317734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yZfUNWDc1xAhIlI6Y8j4tRPuWhPGubcCvJSZmQ2Yj4Q=;
	b=0KSUkY9svs8UlGb6KjITeT4cxC3MQeZrn2IYVp3R/YF7XEx+YZBv1lGUBCQUF8OuEV2Tt1
	KkMofz2nRRY0mVJANlSfm9L8+LJr8JLM+tcIxyzyHOHywAUTgQKyW2nijXpxGfzD6RP5rw
	n4sIslKJlLuASwsgQfKuKW3twOcNMLdBBTbu0zH9qAQn7iWw0YyXAYF0fTkVbsfgXvBoCP
	ztGTiN3AQQRMbQOxpGkGIzLUylxva7z+qbcByz2z0YJA8MZH8ai3vg0FJiNaQETEP37fmy
	WUw++9xh5T0XiDbLwZ2T2+70mVQCp6PmVtwJkjh9MDOgyVDv0/nFnGMUmJCrSA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 17 Jul 2026 21:48:16 +0200
Subject: [PATCH net-next v4 13/15] net: macb: read ISR inside bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-macb-context-v4-13-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
In-Reply-To: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
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

