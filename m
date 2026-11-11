Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431885;
	b=yp/TYnRquSLbBEPFnAhbaFhQMeCE9VY8t4K3MvQi09XblObDH9PxkI40QiwXRyhqgqJw
	 Cv0MkaSG3euqdGvzThtfDeA2hV+I21M+P3Zo/bOK8e94r3ULWXcmVPMofdLuwwLznqnRl
	 Cb7ZqPSPL8F8dIyHT6EMo8ycU+Mv225VfZGTmCxZn3f6XZb/4BJufZXERJvdKT7fWjwP3
	 3gKt43n/OWmzTCpahS21BEx5f973fIwwoSGgoKqzK3fC6ov2n0Bu+SIUeNG3tGtD1LQH5
	 MmDMQR8K12Fyv6sAAeKyF8w7OBCtRq9NM72iiGJTArEnu3dReW0O2KVXWBvstd/7SjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=zHRqQWBPVFOeYlgrXxqVspkHnBcyGjpqZP6GTyVaKJ8=;
	b=5C0XZk++bmPPq8CnMUPUSYWRkwUIMMqumNJ4AfRPd1AyQzbhLie6xm1IYwzhtkX0SHyd
	 zkq9LKjcQAxUkJwhm/3WEMX/kEs7Hg9Rxzpx3iQEx6zYsB/uev1qt3IKlk99REp9nhEWT
	 IXk/YtwVT7xL+/1PHG9y5vIs2AdbsnHMRWgCjPP5/OfIvxPP26O3DgxZSB+Hk/4PCEtLp
	 xb2B/YaYDO8M8qm0i0z6zhoOPvAQkO4Fmh6XinnMEz0ja4aKh6w7DQuxhoSHuaLVgIsI9
	 qRIO7VLEcFfx8QbSoXqBOy24UIVDqfegx2MnwH+12x71KnET/HkTDXBtRSRDNy0PMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=HPH3Q2kW;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AA60A2614;
	Wed, 11 Nov 2026 21:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222AA60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=HPH3Q2kW
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 65254E83402;
	Wed, 11 Nov 2026 22:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHRqQWBPVFOeYlgrXxqVspkHnBcyGjpqZP6GTyVaKJ8=;
	b=HPH3Q2kWUr+Coeka8bURjhglrzvM7vQqJL3MK6A1hELjSdEZgpZqOqZmENSZap8Dtrb9lK
	2h+wjPeMDZTvu/RallJxt7IIdR0sr9JuYAArTv19b/sW6JA6TUGN5MwuwIW7IPtU+w3KE3
	jBxTIM1nGZSzahnlWtjAWM6bURoJC9BLaPLliGK5/2GEI9QdRhH2KXWubrNruSR0yyOswO
	uuFewNO1QBSvvRSCK9kuHWJC+StgOOg0FbrkP+XN/esQB4/sKNgncNQSBhrq97d6iJCRpm
	WJ3YeW4J7Az09l/EwrHPWBBR0af9ir6DNmbE6v2+YZjEMvGM7g1FB4wgMOu71g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id KhH9k5iy1zqP; Wed, 11 Nov 2026 22:18:03 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:18:01 +0100 (CET)
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
Subject: [PATCH net v4 11/14] net: pse-pd: free the notification kfifo when registration fails
Date: Wed, 11 Nov 2026 22:17:28 +0100
Message-ID: <20261111211731.3193796-12-github@szelinsky.de>
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

When pse_controller_register() fails after it allocated the
notification kfifo, it returns without freeing it.

Free the kfifo on every error path.

Found by code inspection and AI review.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index c13bbf126a9f..f5a44e17cbec 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1120,24 +1120,25 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
@@ -1154,26 +1155,33 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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

