Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516388;
	b=kJKZHdzfQRgoZ+rX1f/k1FineGbiO3HJwrBZn2csvamJ/8NGPfD0PmWNraaZl32cwI+a
	 A3omeK8AQ6xVwSEjCzwnt2sIUR4r7lxyWhgCTu8wydT4bUNrFfuToiFo4PDV8rMOrEA2n
	 x17SXcjJNRgGV28PHPq1aqk3A7tqleSx89rmf57mlv05HaSddSBUSMlS8nn+dEGVANnmG
	 Ml8lWsUT/mtFArrBRm/QsY9A6xMqt9GfG4GhcZ1XI7pMdlc6a+qAP2402IBlQCeL1/9L5
	 Sm5nrdnhVG9CGz+/AdJHhXLAtIVHyoHSssaige6uqlv1oCdNrOD3m+z1SVFKMVSr/sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=o8UylnWS6dT7eSF9GT83tjHNVxw0e3TWpC3Agv4wuNY=;
	b=vHNMCUP/oQpfR6Iv0spXDWZ5WecdSe32JEiEFakWQTrkCsWYhEqIkFnjf574U11Cyvmn
	 0w0+tl+EqhhZlBCepxu8GukPqdpj/NPplFRnqMHgeUMjFru88vqQrvJg2R7Xl2ZJ0o6VG
	 XGne/uvgfcJw1cQ4pTtkY8RBRyAjmu16/9LATquSzVRGHcK/pJ1VUSCUalMzLspNpfv17
	 JyN/j7wPDiQWYrl4a5fUkWT5Z9TkSeF7lVGEOTL7Ujwv8UA2x6e329aBy0eukBbTok5hn
	 0k452qCPMmlvyiuIkS3VaNTbDThbL2LQ/aDu1zCrYt56sGzd/r9gsCAAiZL0dafe0Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b="Laoe/Ly4";
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA960A2621;
	Tue, 20 Oct 2026 17:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DA960A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Laoe/Ly4
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 2730BE833C1;
	Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8UylnWS6dT7eSF9GT83tjHNVxw0e3TWpC3Agv4wuNY=;
	b=Laoe/Ly4oIBieyZhx55nGm6/1Cnw/DSCy70r16syAH+dGJdmubOJ20d5jMPXYxHOqnWju7
	MTRYYyxSAVPx4U4Ukp4PDs+FCOz50OrDv7jx9RxuW8IKh3vuQpZ8xs08WBHDCGwq0y8H5K
	3v0pr+hoD1tTPV7HHuVF9AhXsNn3dD9jcfo1ot15g8JToliMg2tyONUlBsyknvXNmgrrmy
	5jLtMXUSyQsyVy8cPaKGo2/UBaPWPXA9u6thPYhwN3rzvQ9oMhr2AWiGyE/e1e9AnqQs1h
	K6k63Fluux2WKt5YXj4IOu+En7RCiM0egGXWWzuq6f82p+vndm6PVOPLvivP6g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id C7kO12ChtbQ9; Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:05 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 08/14] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Tue, 20 Oct 2026 19:12:43 +0200
Message-ID: <20261020171249.853085-9-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171249.853085-1-github@szelinsky.de>
References: <20261020171249.853085-1-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_unregister() flushes the power domains and frees the PI
array before it disables the IRQ, while pse_isr() uses both. No in-tree
driver hits this: tps23881, the only user of devm_pse_irq_helper(),
requests its IRQ after it registers the controller, so devres frees
the IRQ before unregister runs. A driver that keeps its IRQ across
unregister would read freed memory.

Disable the IRQ and drain the notification worker first, and only then
flush the power domains and release the PI array. The next patches in
this series build on this order.

Found by code inspection. Not reproduced.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 13d6bd29525f..21280479312e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1137,11 +1137,15 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* Stop the IRQ and the notification worker first: pse_isr() uses
+	 * pcdev->pi and the power domains that pse_flush_pw_ds() drops,
+	 * and the worker reads the kfifo that is freed below.
+	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
 	cancel_work_sync(&pcdev->ntf_work);
+	pse_flush_pw_ds(pcdev);
+	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
-- 
2.43.0

