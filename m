Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743368;
	b=y3in89Rxixh0lOOXPCM/9xoLf0WQmCZd9Xmsid8GbH1vhMuKXVKLzzQzrYnJeOVoGVxQ
	 VGXDxWij/3SeBgDkv2HWhycbz28LU0JNfKVSLuSD0EAyixVHGknLZEZBwrkqnu4dSzpZf
	 JqeD//iU9AU63aESPfBcPlaPdvpPsj/Mt2R5tONp1tP5ftwpdki47joVN8ffvn2qyf02p
	 GZ7/Um9QTY+S57VBN+jSlcOLl4tRkfLYKp41amx7uBzagCQhy9OzOJJnBA2pBK/yRLqAG
	 cBTp2pJS8XcHY83GHCjCO1/J2D7SpAU3THm5lZm5/73qCh9r/cIaxAz+vPeRyU7lAyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Ir7GEA7N2poi53eGqiMiktrttYvJkUhJld2BaFhT0g8=;
	b=OdK+VqhE8Z0ESNeyVzKg6pdOQMT37h0PBBJHQm+lRYLVgMf6R4RKQHVxJ84xBDl0aUbN
	 ZysQCKgTbkXp87rNys/K6Hww91bvFKNxOthyMNwHnvNIiWDhhWxBgrFjNtJBCXZf55UUQ
	 hAdScYpG+VJImOlz7q4rxJyDSDWa09ICHu8+uV0MPqAA9ZZHL0Nh+Oo+n+FXClURPxe9T
	 7tkLYOHrrB60GwP7jRSUymmMzf7ZLn7XezpNFZUi98WJ0bpn32zVxArKTOl5+uXq5JhBI
	 d1kboTyJZ+BKKlGbpAGGvHhXTygqCt3fp+Ok0HwZUDqEB5eyUxuDydSKh+/juQKJksw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=LrpvhT1q;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E4606D811;
	Tue,  3 Nov 2026 22:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6E4606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=LrpvhT1q
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id F1839E836F4;
	Tue, 03 Nov 2026 23:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ir7GEA7N2poi53eGqiMiktrttYvJkUhJld2BaFhT0g8=;
	b=LrpvhT1qPyvzRH+cZRLeNgwvFIL1M2lBZDQgxyDAcoIEwT9Pvq9r3yNIDr3fjIGRugMOI6
	Ndgtx6Y1/s/luMUfeURtRtlnjLCBdxUmjZHmJBUCeZvVvJP3V9fT3y0ERI5jxDnv2/aPg4
	1R+XtuhCV22wX1wKn0ezPmSfVtK6uAvHXD6y5VdokQdT3AIPNqOrgJn76Wf25XaKWm1fed
	5wR3U2NBk9hK4QetDovT6TjOCBMYZPtQg0KgJOfodnhwkCimchgoRu+a/nLP5dFDCgufWZ
	H4D2Vf1BrZ8yOMmCFM3qw8Try6CSiliMt0n2nVtcfzt1RQWUx0gi2HkyQ1kjmw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id vCOHt05uRzqx; Tue,  3 Nov 2026 23:02:44 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:44 +0100 (CET)
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
Subject: [PATCH net v3 11/14] net: pse-pd: free the notification kfifo when registration fails
Date: Tue,  3 Nov 2026 23:02:14 +0100
Message-ID: <20261103220217.1131971-12-github@szelinsky.de>
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

When pse_controller_register() fails after it allocated the
notification kfifo, it returns without freeing it.

Free the kfifo on every error path.

Found by code inspection and AI review.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index eccbdb3acbee..137570fe0da2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1121,24 +1121,25 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	    !pcdev->ops->pi_get_pw_status) {
 		dev_err(pcdev->dev,
 			"Mandatory status report callbacks are missing");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_kfifo;
 	}
 
 	ret = of_load_pse_pis(pcdev);
 	if (ret)
-		return ret;
+		goto free_kfifo;
 
 	/* The PI regulator ops use pcdev->pi until devres unregisters the
 	 * regulators, so free it from devres too, after them.
 	 */
 	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
 	if (ret)
-		return ret;
+		goto free_kfifo;
 
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
-			return ret;
+			goto free_kfifo;
 	}
 
 	/* Each regulator name len is pcdev dev name + 7 char +
@@ -1155,26 +1156,33 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			continue;
 
 		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
-		if (!reg_name)
-			return -ENOMEM;
+		if (!reg_name) {
+			ret = -ENOMEM;
+			goto free_kfifo;
+		}
 
 		snprintf(reg_name, reg_name_len, "pse-%s_pi%d",
 			 dev_name(pcdev->dev), i);
 
 		ret = devm_pse_pi_regulator_register(pcdev, reg_name, i);
 		if (ret)
-			return ret;
+			goto free_kfifo;
 	}
 
 	ret = pse_register_pw_ds(pcdev);
 	if (ret)
-		return ret;
+		goto free_kfifo;
 
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
 
 	return 0;
+
+free_kfifo:
+	cancel_work_sync(&pcdev->ntf_work);
+	kfifo_free(&pcdev->ntf_fifo);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
-- 
2.43.0

