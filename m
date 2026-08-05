Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95164772AB;
	Wed,  5 Aug 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951842; cv=none; b=oWAIMFpqgd85hX6+Y/kLgU6wrhaczQ4OBuDvQSAxJq6RlnPxmeKCJB3X5zecNdQb0MFqb05MBg1NJ8C+GV24w3u9tpXvSl8DSWC1xrJ0OBFIeW3QeS3PFpvxucoXGKCI42y0UHgYwgYgtQg3t9LDJ97Qf90ZXrDSoCyv3knYQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951842; c=relaxed/simple;
	bh=DHHEIaCxhlCy4AmCEd/cLwIwxkfQPWL5yOcJP5IQWEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1uOsDiplVZcLGRYYnY2ygZt6+ogCQAtD8ia3K++LAqe+mrFE4F72A+qJ2tNvZ72XsvgNPql4dJF4+BIMXxROksd9+ugP+0yQNsWEEOWpAyurBNb8NiUvatI33TGooWqPwpfg1/xkDqCaJkAgdjJL61tCTRMy4fO+VdxjFr8HUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LDyWx8wg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LDyWx8wg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5A9B41A1445;
	Wed,  5 Aug 2026 17:43:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F34D602AB;
	Wed,  5 Aug 2026 17:43:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2508611C35090;
	Wed,  5 Aug 2026 19:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785951837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tjkUKHuyq+gyC9RyRpkwMIOtaqVq3yK4Mv8j4SWqMgA=;
	b=LDyWx8wgLal7WT+970P624RxOAfGks1S3n1CtKxYJnUVmsqBrQUIwK9NvVLdbkPLYJdum2
	aO6NPhZhWmVL/8blO3rpQbezEks5BHPrJ3+tycGnO9R8xgA8q2kqX4HxeK3T9Pxb8GmX6x
	YtPFp65NsLVqbkZNoeczL6gjjrrkCSviZ0FYoA9/8w2g+KRdSxLixrc6kWKZJ2w81XodS0
	AE6DmFeJ22S+5qfXHVd1FuleVXh6GG4U7ZWMUnFJHKN6TALxv3BXjVJh0Jk/BWPrcwqcPd
	2yV5GbcDqz8bwrww5riV6EKHb+BeLqf7zWFYTiusuVPGy6t31YqFVJJMbjxLrw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 05 Aug 2026 19:42:44 +0200
Subject: [PATCH net-next v8 15/17] net: macb: read ISR inside bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-macb-context-v8-15-bc302ffd1174@bootlin.com>
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

The IRQ handler reads ISR register into the `status` stack variable.
If empty, it early returns. Else, it grabs bp->lock and iterates on
the status bits.

We risk a race on spinlock acquire; status might have changed.
Move the readl(ISR) inside the bp->lock critical section.

In practice, we protect ourselves from interpreting the same ISR status
twice. To understand issues, read macb_interrupt() body and imagine
each codepath being performed twice:
 - Two napi_schedule_irqoff() are idempotent *if fast enough*.
 - Two schedule_work(tx_error_task) are idempotent *if fast enough*.
 - Double increment of rx_overruns.
 - Two queue_work(hresp_err_bh_work) are idempotent *if fast enough*.
 - Two pm_wakeup_event() is safe.

One risk remains with spurious interrupts that would, in addition to
taking excessive CPU time, also create lock contention. How bad is it?
Probably not too bad.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4bf55994420f..100159662336 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2193,13 +2193,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	bool hresp_err = false;
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

