Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431882;
	b=V08Mum5R/96LA0wTZfj2Yj7WnQ3N9Q4wFqSSNbeD2WeCkHqFxj64zHfF6RH60ExXQNJ3
	 45ice1GuGHOYJMiIpxGZfYW7ooxuDxhZVjxIg2VoXu8KhMefaFZy8mNeCspVz1IQSQ9l9
	 JDM/3Xqiv6VSI60CELS2Rg7K6yK3Pl46sP622sR+UOtFaBRjYqP5YEQGnnxYhISwMnxDv
	 OaYgBNeOpVaS9PiWi6zogH5A6rE4H14tgyhqoKAgI4bxAMWbKSScDgGx76Psgz3138apE
	 N5dLGfq4649HChqtmEmLsAfn3B48a5HTEtmMqy2Oa6po05VJtbOX6Yiwy8wPZTSV+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=z/q8nC597hu8836h81SCpvWl55oBE53QmYZCedUM4Q4=;
	b=ocZKmAsS4og5jqduZQQEyCBRLmC4/jx9QS58QoMrvWj1aW/UlvufpfcRO3IsJF+NPxys
	 ADINucPghOF7zbrRZjgIhIhe3e0sgOY5SumYB3Fz9dlFyzcRl4XaNmDeSv7NPZpsgCQYr
	 +E/qwdi15DGcozIBiZaIfW3VkCyEoWwK5pEYNqHuVmcNjWMql96D9Q1fcqojn41/XqZa7
	 x4xJo13idyWm11w0WHsUfprAA3sSVGXEpujLV+qQugnY01M2bbffC5bHAAQlieHJMy+7d
	 x58qSwbIRTprzAnSHiF+4xErilNXVzZrCKuYZkyC37u8xNIV1cB8Db/noHRIKkqUbyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=TvWMTB2G;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEECC606A33A;
	Wed, 11 Nov 2026 21:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEECC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=TvWMTB2G
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 32915E83236;
	Wed, 11 Nov 2026 22:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/q8nC597hu8836h81SCpvWl55oBE53QmYZCedUM4Q4=;
	b=TvWMTB2GYDsQA3DRIeoJOveEZ/0ialWkjGTmlj9OznHSjaCrs+ixXmrbKsuZrEXPMdhQgP
	E22DSmw8ym4Rl0CVQyfUHHxWa/5F5VHDKAtado5ClXS5TANI+ciOYDZmbVUxL8amYuIiOp
	nx6IiTnIPeg2xipo/5kpIPt5I+oIyJ7AjGY5XI8Qrn7H9HJz5UImm6XRff9JiNMrrx5U7/
	6fbuDjQJ8/cuJdiQJyuso2Ikjwkdy0Xan6h6xoC3lZbed+R6ar5g5na3kQ/U+hp6NSsJ4O
	JuqFX/MfO2cv8yRhGXNIQdGa1G5eP5Gs6dJI/GUiQEIq3WgyhXBgWDMGdPNjLQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id yIx6UUx4ugfY; Wed, 11 Nov 2026 22:17:54 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:53 +0100 (CET)
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
Subject: [PATCH net v4 01/14] net: pse-pd: size the notification kfifo after defaulting nr_lines
Date: Wed, 11 Nov 2026 22:17:18 +0100
Message-ID: <20261111211731.3193796-2-github@szelinsky.de>
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

