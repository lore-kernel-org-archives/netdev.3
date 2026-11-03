Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743365;
	b=NpU5t9IIsIG9hEY8RcDn+qB4FYAJW1tBwO+FIhbYR3IHTtL2dzndMSSe5l3651UMUyc1
	 6nQUIWPz0J0cs801jU3Ztk+Sc4rIf+rVLSdbFtQxUVxD0IJ1FhULNufusrV8Strhn1API
	 hCN88LmTzDzKpAcNpxl2Ug9d7HyCin11k6fWGMjGZgkyNtfozKKqKLZDmL3GyoeTejbf4
	 PbIvXLaxDVTny9oLvw/3jCY81FvzNMOvBZeys2HABRxVCgbBjnkzKXVhRbPmciCAkrv9R
	 KLKk3pUR3u4NZA4bBCJk272Z1RvfZnUuRi17hiNlCHIxzjD7/QJGIt0nZ5O5g53+0Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=z/q8nC597hu8836h81SCpvWl55oBE53QmYZCedUM4Q4=;
	b=3G4VuALquoGe9pIcreUnBQuNMzFzPQDZctvmC79ggZQPt9/JVSkJtaWZG23PpUdLYiAz
	 3OZdtyY9dH8+ZtZY7H6qNo8pysI0azCQBxS34unTk+6kCdbcgwksQsrsHMLgD5IuvqZp8
	 O4I59QSHsBod5Zi9mEK/lCCQSV3XY61IKeFdrH7FFSMmcyl7OZY1l1vr4FsOJO9T8jrHg
	 SnKU3VV7X1zd32Zbh/n97Ee739IulaAdxZfVqGsfQlcWBch8G/AupPXo2GYsTUcxalBxK
	 pR6UEEvt/w/xoEUstaLZxUj8VihCd/2UeTJAx/ucMpZDImWZDaMsU1i9fLhpGHcW2qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AgyxMlSq;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB94606A326;
	Tue,  3 Nov 2026 22:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AgyxMlSq
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 90C47E83450;
	Tue, 03 Nov 2026 23:02:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/q8nC597hu8836h81SCpvWl55oBE53QmYZCedUM4Q4=;
	b=AgyxMlSqCrblI+Su5J2uv4OrD9cf1gmVkwqvJ975brWtNle4KCrURFtaYWQBjqqMpS+/X4
	ZN7egsR0CSe/jEIVR1CkZdAukWwxP/i+d+BHE6f5zZYMqF7MYoE6KeWLZhG4pyRbr8+x7H
	tEAj2KTLWVbDe4OZesjh43CpoK3oW84d/lNqE7O5NuweLHCnO16oltldEmwFsSp8iqsCe2
	HaMebmPFPVlKKOaOl/LxTqYBQ5sSEwxJxrqGFUDbyzqrnOYdJmbvzHasB3e8W54pVmld4o
	v2q0o5rkJKoRSi7y6qm9vZMScmd0TWHa2uzvU56zfPFh0KI1QqjDdS3urFMF6Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id CMXQ6-PCgq9q; Tue,  3 Nov 2026 23:02:36 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:35 +0100 (CET)
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
Subject: [PATCH net v3 01/14] net: pse-pd: size the notification kfifo after defaulting nr_lines
Date: Tue,  3 Nov 2026 23:02:04 +0100
Message-ID: <20261103220217.1131971-2-github@szelinsky.de>
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

pse_controller_register() allocates the notification kfifo before it
turns nr_lines == 0 into 1, and kfifo_alloc() fails for a size below 2.
So a controller with nr_lines 0 or 1 cannot register. pse_regulator
(podl-pse-regulator) never sets nr_lines, so its probe has failed with
-EINVAL ever since the kfifo was added.

Apply the default first, and allocate at least two entries.

Triggered in QEMU (arm64) with a test-only PSE controller with
nr_lines 0: its probe failed with "failed to allocate kfifo
notifications". With this patch it registers.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..c0573cbbba5b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1044,16 +1044,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
 	spin_lock_init(&pcdev->ntf_fifo_lock);
-	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
+
+	if (!pcdev->nr_lines)
+		pcdev->nr_lines = 1;
+
+	/* kfifo_alloc() rejects a size that rounds up to less than 2 */
+	ret = kfifo_alloc(&pcdev->ntf_fifo, max(pcdev->nr_lines, 2U),
+			  GFP_KERNEL);
 	if (ret) {
 		dev_err(pcdev->dev, "failed to allocate kfifo notifications\n");
 		return ret;
 	}
 	INIT_WORK(&pcdev->ntf_work, pse_send_ntf_worker);
 
-	if (!pcdev->nr_lines)
-		pcdev->nr_lines = 1;
-
 	if (!pcdev->ops->pi_get_admin_state ||
 	    !pcdev->ops->pi_get_pw_status) {
 		dev_err(pcdev->dev,
-- 
2.43.0

