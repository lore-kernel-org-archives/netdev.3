Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA543BDBF;
	Mon,  3 Aug 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787767; cv=none; b=CMIOukfGCjSt2baqmA0r4r6X3GfFw8OvqTi219kt635cR8tPMPTc+7qEhPZtBsheUHpq9JUz/B3T52PhnGKqsEVWK/KoRkurEKMr6rWBWH8eIl4YSrVCR+bye1IL19WrrDNnoU9hsu+tWcZshMhmP6zDNwhf2Y7ZYK+4dXmiTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787767; c=relaxed/simple;
	bh=gF12L4f5JljY/O8R7bUQGZdMGjciO6Pip4e42yh/6V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmQ6ddZKWmr7UtrrdhxPmEhfOpbGcY25/cUfjduVJwIlAFVq7I5n/lAV7mDUM3KuPBSbFnaqCog/xFUSDLLOG4VBnavK2LqcZpEE6gQWcE8vTZXik3YNjM1xZ1C+MEk2z2Rgm1xlBuOJpFFuuvJxDwLT8kIn7CitTY/YBDlH8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YwxJaYjJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YwxJaYjJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD01E1A13E1;
	Mon,  3 Aug 2026 20:09:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BFD16029B;
	Mon,  3 Aug 2026 20:09:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25CB811C3185B;
	Mon,  3 Aug 2026 22:09:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785787763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h4mdMinUW91EWIb+YIwUVnkls1t2NQ3ZXEs4N3ePlM8=;
	b=YwxJaYjJoGlb4GUTEffOmsZw8s2Bras3kmCLjvk5R3aRVn8MU4ONpOu4SFwt9qpUXrE7qK
	rQ8fKOFSi+lmVNAuzQAqaxGLuULgOGwKrJH+1H2YTQ91PbSm9rA7qM7o0zrF+bnfknvA+1
	1tpKdpoq0hDDJM52yJc9o2+GzvtDeD5Jlq/s1aTwIX0JaZC3RhKYzc1Gye66YwrATeWGt7
	iFFPAnXLCjVhfu/sQYBZ8zzupL0AcbJppT92txxtsUuWR8YMP+NKeOtUMEUXWUAfLQgQpb
	WRzGG/OZby6PWr44wcp8x3BDgFO3wWFON0IAm5lt12NPx2lyBBMCfKA7/5cGGA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 03 Aug 2026 22:08:22 +0200
Subject: [PATCH net-next v7 15/17] net: macb: read ISR inside bp->lock
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-macb-context-v7-15-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
In-Reply-To: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
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
index 7e77c24da8a6..0778ce9b3223 100644
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

