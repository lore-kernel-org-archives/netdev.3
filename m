Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F5391E76;
	Sun, 18 Oct 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311810; cv=none; b=lZ6q4rkhnhgdO4fxAlMk4nBkYw/lDUrq6h9q01bY173brXBs1Pcn0vnpvo9po2lgu6tEY7PzQqJ9ylVqTE1nv6TS3kVwVe7i9lWo9uqN2UauXU5XJE7EPjrXzmCdoR9bZ8RZylArsw0SiwIloUEhsSGYuugJtesGYxZ+TMuyIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311810; c=relaxed/simple;
	bh=yqPMDkG3aNYWItUFpXxxxkuDuloPFxpapzj109dIjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KarSfenVC9k9JXg+WVBn8pripr+JP9P0Dm7w5MqzP2q27PdaltPzw0gmDhaEj9FOQr4w2rKhoUtz8U/cgp/3AsdZPOOJEnGGqaBVPYBfPasz1cgawqm4Dnb8qFiJ2qe+gMNNtVd45EBzzm9l5baYaejS8h94QPJuoDtn9OhjvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Li6qyXwZ; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Li6qyXwZ"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 9A31AE8395F;
	Sun, 18 Oct 2026 10:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KTYLrBcB9iR8tnOftkRTYErbG26Vzf0vS3eD/kmqsM=;
	b=Li6qyXwZPq3QK4ViodJp5Px08isKV1+Zg2IoJ4PIRQsFrmQVvo0pwyJidC97GBMomZ8ZrJ
	xvId6OXcs8WO/qrAL9cbzWJJ09L1MtRMZM+Wx6BE0GrSdJsHBTis6KSVJtAgV8J4by6ooD
	Q/qD8Fx577GrBlTaklnwEkQqR3K16O19b9loLLlXy+ZVgI9xKhEfKS1+dYhMwRZeyfp4uA
	eZTLmTOYqORGX9JPaU5gtN/G/fvUaTixDDaQ2uFPcLYTLP+5GIHW28Q1GdGtNEblg2ILke
	FhWvhxZlTuA5VgWSMzHItY8m1jgD9YmXku7xOBQtyCD5/Ia0RwQ+fKhN8GIv4g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id h-ijD_-7CR6H; Sun, 18 Oct 2026 10:23:27 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:27 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 03/10] net: pse-pd: do not keep a failed IRQ in pcdev->irq
Date: Sun, 18 Oct 2026 10:23:06 +0200
Message-ID: <20261018082314.48950-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018082314.48950-1-github@szelinsky.de>
References: <20261018082314.48950-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_pse_irq_helper() keeps the IRQ number in pcdev->irq even when the
IRQ request failed. The failed probe then runs
pse_controller_unregister(), which calls disable_irq() on that line. If
another device owns it, that device stops getting interrupts.

Clear pcdev->irq when the request fails. It is now set before the
request, because pse_isr() can run as soon as the IRQ is enabled and
pse_pw_d_is_sw_pw_control() reads it.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 1710f9bb7d27..65a41c517b35 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1348,14 +1348,20 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
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

