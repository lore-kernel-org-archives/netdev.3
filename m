Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431883;
	b=kC+IdoQXpLpnFvS9fnnkrDTc8GHVZVOIbYn/rZ0CR/rij8hGEnKb8Z0k6r+2sVi6TKXI
	 jT+iIv2dUmk5MBFyycBJSrqS4wSO/2/z1l0tXI6gJTjVJWhrRJfebnSgB0y3WEXIexYD3
	 ssJixQgWlvsE1xmpMNR/9cRGm7hacDj96Q2+8zmEyrrtYr3jC1vuKCOZceTSbdU+Ke2t0
	 pGSXLN4aWi0Uwrb+mTiuHtSxG5nhvnShG2e1T3wK2W2lFntAiNSlwG9NjNjteSptZj1n+
	 3u/Vlf+Ihi5T5pWZGcgOVxhv1fPLmvdMKqmcdLf86zPyPQA3+Qy8FoWq0qvp5HH7X7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cRaTq2hFw3Z4v4AeMKn12lqCU+G3DjbwVq3sVZ4sZ34=;
	b=2iXOHm0Im0mDSp7vL5lZ2jahxaLxfD3mmiOBo0RE6amPRQ3eNGVI21thW7GM17K5NEJ+
	 sx5Svda8//esUaa6+1VwPeEC+9nGsTBldm+O7FYJKDXNkpqeTZyeVGKI4mkDCk5z/NekG
	 vJPujJel4QD0HPcLUzSMH4WnxfH9QoK5BzdXmQKNV/eizz4/o58O3+JvUGbeL8GhH70E4
	 kyqUiRvSo3OFiHdo1bzI0uykZ3yD9J8D9lCBU4ZB6AjZSq3KmaZWoYEupGJmStWkFSs8e
	 e4zZRi467wKOM62yFq9BDn7zTJTlkdyRMe3ZNKaWKwtO5XK7ZYje7BtYmzkBh75YTUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Pq1YS+AR;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4C606A88B;
	Wed, 11 Nov 2026 21:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C4C606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Pq1YS+AR
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 779DEE832B9;
	Wed, 11 Nov 2026 22:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRaTq2hFw3Z4v4AeMKn12lqCU+G3DjbwVq3sVZ4sZ34=;
	b=Pq1YS+AR+XfXRnc5pmyKu+fXXUFvd5WTpmJ3Sd+t4ZFRwYBpaWheIOB5wtM3alzH6wP2Xx
	FgrqtBUZNirXxhEZ/buVPgneu5WrYxuNy9CcoPekjlH81kkoMvHqd7+TvLAm5hqZprBDae
	EUhZaike0B0dFTrenr9XByZ4fXQw4xLjnxEOW8pLllHoQiAkdMXDttuyC+FSx5UqNdxjCi
	2mhCg4iwC8iGpYlAUjTYLOl9EmL0suU9prEBM4OtN5DrH4d9bhNrVNbRb1TrsnjRa5ADOu
	xXNSCmZIpPYfBDz2eQZCUJHQccmMLJ75mDTjLduqp4mt8zl8q2nyjMFxhddgYw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 9dQ-JLZ-ewwS; Wed, 11 Nov 2026 22:17:56 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:55 +0100 (CET)
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
Subject: [PATCH net v4 04/14] net: pse-pd: do not keep a failed IRQ in pcdev->irq
Date: Wed, 11 Nov 2026 22:17:21 +0100
Message-ID: <20261111211731.3193796-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111211731.3193796-1-github@szelinsky.de>
References: <20261111211731.3193796-1-github@szelinsky.de>
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

