Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028A3AD524;
	Wed, 12 Aug 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521863; cv=none; b=H8SUoSOkkRkI2/ppfvegrsOnu5RHFunfxKiRy60L4BnhDmIZugxLYXEuqIqe4YkewtpIMbcgxtYe660PMY6HKmAcChJ2buGVC4+g4Qp2NS7u85eachPpUB/xcaKjqKYBrY2wjNPYL4Q6zzmPUPlx3yXiJSYZYc5V5J2hIsIFc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521863; c=relaxed/simple;
	bh=joni9XzQwNuJPkn1ceF3z5m1XVPePQq5v9OQq8pIo1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGRYg1yhxCsggB73ap/vD3gqOqBTgSL3rcL70Kc6n5QFkVfTu6CSRKBu3jx45S/dts61TPGXD7QNwEWIRNmwxWLohGMPMNTMT/xQHIKuCSbFvkbM00ZJLPYpwEVFBqRa2Rd2yPlHD9BRyV8ZO4QuGZ7UAue+rtbldFn8w/IFejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BjN8eoEx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BjN8eoEx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E87681A1571;
	Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBF286045E;
	Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8FB111C4C94B;
	Wed, 12 Aug 2026 10:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521858; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HA6X4gblX3Ghg1RHXpshWd/MMZ6CrLk2WgmPgyBPVmk=;
	b=BjN8eoExvpOTRfNWQLvVKtHyvMDMjvAtle+4haiTZrmzauMuSREWvlS8CYGTh8Xk50uHq8
	SoiZkx5viiVkA2qnM6CLgxU2gorsE21mhTBLpILIvM067ed+wxT/pZq1PsZsPnNxF0w8r4
	FXKT1x5LTw/bg/UOhBePo+qq1GUl/LdGD0kvOkdi15zrexrhJyqj8AO95tye7fA1VhRFp1
	4jQC+QR91B9wS18wGAGNgI/nGfJELnMJrslP/EQ2MT7hZyxmmWoKS/QUINZDTt2taGDyig
	65cf5KG4WpHC5P1KxkbmZu9dR0JGnorVzy6ij+SlooL3UILc+JFdOBdUo8xa3w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 12 Aug 2026 10:03:29 +0200
Subject: [PATCH net-next v9 15/17] net: macb: read ISR inside bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-macb-context-v9-15-7ddbf5f715e0@bootlin.com>
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
index d23a0d08c276..6d79663e42bf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2190,13 +2190,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
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

