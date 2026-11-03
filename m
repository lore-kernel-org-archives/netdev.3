Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743366;
	b=UCKLWHMC5cVJw40/3zP5AcRLU1gyl+JqJ3qEyTIIpm5/eB6IINRL1U+vU8g5k121sb+N
	 ztU5C0agGTQ72ycTE78fXYXD2g/ymzZtqVWIB+fjTcG8MCjKbBeX2tx4i+Vg2rzfWlVIn
	 5Dgtu4Xdek96d1T1JsdLcM3pn+FgWEY+wg888q8keKaOWyeHZMqAc28KNdBKHlwTN6m8h
	 EO1Hx+WzE1TV6CFISQLIDi02tKDxOzkagwiTu1wP9X421lX6xHTVJdkrKhnHGw6ih4NRY
	 RvWVUDozVhMpPzz6gHgt8org5gAmbgpyjG12mNPzHOOEy1AQ3qL9+c62lr5epJlP+dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cRaTq2hFw3Z4v4AeMKn12lqCU+G3DjbwVq3sVZ4sZ34=;
	b=rZ6Ihaw/pDd1Kxkvq/lPh5RF4SyBCksT76pkzkzgPdZpWd7LJlcAEJahAER3VFWsf1Al
	 Qyce94NIczVS9YTd1h52vDt4M+GhjPhKoa94Vq3mPzGX1aI2IAvPhAKXKR9LfxHLqwI8w
	 IPncBOqx5LY2zTeY/K8RuKVu6uHY8GhzfKw5giYLlRlF5UJCJxRz5Y4y5O5olzq3uGBt3
	 GtSlrqtc8Mko0InIlHo2TnhQxg+ZamNE5k1xZXLRJlEIZsEpDjBwa6fUM3l8PLxHcipQ5
	 G8o7Ca7Bw9uLLBm419ZgsQpZq2zLL+Fmw394pKiB5QY/l7YOH1YRTlZ2BENlC6SvQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=XEpYn+NQ;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FE606A33A;
	Tue,  3 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F8FE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=XEpYn+NQ
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 12079E836C8;
	Tue, 03 Nov 2026 23:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRaTq2hFw3Z4v4AeMKn12lqCU+G3DjbwVq3sVZ4sZ34=;
	b=XEpYn+NQtSXTtD/DYti+c7SQINxnNgweD5lUqfjqMchjIu1ESZ/bouwKBi8IE1yvSoV8qW
	Kjzm4tzX25IRgIpei8dkAsli0wpnMm1/+xP1cB5iV5h1/DKqecRnofgvAP0xqt/OLuLnTX
	y8vPO8zkbxner98uvSG7BgIU/jpNmCH/xaHGqT2FzfnSUPFrxJbPHVwycRN7Pr+pMClo0U
	nzFP7aVbLrYv7E/89d7eCUUHN2iDBvEc9eUz0Pol3PUN+MH9nX5OI5pHYOcnLSV5g17wYx
	iP8tLrn5FTrg/Pds57G1Tekrcfk7H8d+GkRWixdjVGbCZhmZietGe2aComBmbA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id M4LEndXKvvYz; Tue,  3 Nov 2026 23:02:38 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:38 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 04/14] net: pse-pd: do not keep a failed IRQ in pcdev->irq
Date: Tue,  3 Nov 2026 23:02:07 +0100
Message-ID: <20261103220217.1131971-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103220217.1131971-1-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
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

devm_pse_irq_helper() keeps the IRQ number in pcdev->irq even when the
IRQ request failed. The failed probe then runs
pse_controller_unregister(), which calls disable_irq() on that line. If
another device owns it, that device stops getting interrupts.

Clear pcdev->irq when the request fails. It is now set before the
request, because pse_isr() can run as soon as the IRQ is enabled and
pse_pw_d_is_sw_pw_control() reads it.

Found by code inspection. Not reproduced.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index c6612232b820..eab7e25f2039 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1343,14 +1343,20 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
 	if (!h->notifs_mask)
 		return -ENOMEM;
 
+	/* pse_isr() can run as soon as the IRQ is enabled, and
+	 * pse_pw_d_is_sw_pw_control() reads pcdev->irq.
+	 */
+	pcdev->irq = irq;
 	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
 					IRQF_ONESHOT | irq_flags,
 					irq_name, h);
-	if (ret)
+	if (ret) {
+		pcdev->irq = 0;
 		dev_err(pcdev->dev, "Failed to request IRQ %d\n", irq);
+		return ret;
+	}
 
-	pcdev->irq = irq;
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devm_pse_irq_helper);
 
-- 
2.43.0

