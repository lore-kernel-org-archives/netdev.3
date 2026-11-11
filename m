Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431884;
	b=q/UMz9RJ4EAqfco5zlgMzO/LWwxSI/9J7vmIES9VOYkw70UoanmbjjiR5fuyuLdrBmMH
	 AJ/oPAmT5CN7SyGINMpTxV3fLB5rXgNLVfxODIDWAwYeoRUTwML9tmfcDmNNiWKPNJ/Mh
	 odMtuD2emOBbZ4gJ+WA1/g/s8dqMKzyY1eru5+E4TDnVVwAQc+FF4i6pgoSopGiWGvzLp
	 ujSM4/pRIb2WOjL9XEuiTpzIiGiVbkMLVouYmdaYdRNQXzDYV6MOmgWq/oUH6Ghc3ZR6O
	 qHRDHHw5XkdcVdbpeBGb8YOp4DnCUMFNPX9UKyu+KdirNa1NZUr7FCjkCcuvOifApmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2/gONtfzKptaHiDQO9JDU8Wk8oT4VtTq3SGNWP2F4M0=;
	b=YAOwkTZzs2/g+eviqlLetCU5rgsopaskc26fwj/I6zLTnIMnJH7L4BFev5fD2xFNMzTk
	 mJM4ZhLX29m11lMnQmXRddVH8ipNLVlIyBZgOutPiFLruKhyIXKo5ImUCMfwbieU9Ilm5
	 QxUqey1C0AV01peDtG0vvoyjlLKx7PcFhNgrP0w7gh9021Aj4paBtVaKOjc7Y1dw2hjxG
	 qZ/ZV2VIZC/Pl2TY3+Xt4yMnxp9aRPdhp+txwOBC3axoH4IXEdJlCFZAiGKKO3d4X60oG
	 x653DmSL5q4aQKmNgXreQZXcC/fik+/s8C22e/UzWEHask5j0lcMpJD/JHY82eK6g2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AO5kFlfj;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010B606A8B0;
	Wed, 11 Nov 2026 21:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5010B606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AO5kFlfj
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 843E2E833F0;
	Wed, 11 Nov 2026 22:18:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/gONtfzKptaHiDQO9JDU8Wk8oT4VtTq3SGNWP2F4M0=;
	b=AO5kFlfjOKdzC0+CZ/iLm+1ImwclcUfxbTV3F/nMkCFse3tt/6Wr/uwiMaD+CGtfOXWxiN
	NPmHvffVmN6nJAH/RztXPL+ibUrRfA+Ql9F1hQgjp/vSF+WgZ/XNvHsrnduy5Ou1F2QOob
	rLSkROaBjA20Gqj0/RC26plAGonHNo1nwmyB40P/6b3mFgtEUY7NgIjPDIsol18Jqtmbf1
	HQ0HXb9YetUEDkEXKXzOXIbKi3c6VDMAP1+bsY9Sg5JZBSS5ZSzW2flWiLeoQzWxOrC7/7
	Ioik1UjK/OVBbU4vgooo9dzztjmMcTyZBsj/rMcD05xhtIjTOXV5kCRs41iiWw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id OiPhBc-El6Yd; Wed, 11 Nov 2026 22:18:00 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:59 +0100 (CET)
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
Subject: [PATCH net v4 09/14] net: pse-pd: unregister from the controller list before freeing PI data
Date: Wed, 11 Nov 2026 22:17:26 +0100
Message-ID: <20261111211731.3193796-10-github@szelinsky.de>
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

pse_controller_unregister() frees the PI array while the controller is
still on pse_controller_list, and only removes it from the list
afterwards. of_pse_control_get() walks that list under pse_list_mutex
and reads pcdev->pi[i].np in of_pse_match_pi(). A consumer that probes
at that moment can read the freed PI array.

Remove the controller from the list first, before the worker is
drained, the power domains are flushed and the PI array is freed. Both
sides take pse_list_mutex, so once the controller is off the list, no
new lookup can find it, and a lookup that is already running finishes
before the PI array is freed.

Found by code inspection. Not reproduced.

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 2dce1f1c4d16..a7dfa7cdbe3a 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1184,13 +1184,16 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
+	/* Unlink before the PI array is freed: of_pse_control_get() walks
+	 * the list and reads pcdev->pi[].
+	 */
+	mutex_lock(&pse_list_mutex);
+	list_del(&pcdev->list);
+	mutex_unlock(&pse_list_mutex);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
-	mutex_lock(&pse_list_mutex);
-	list_del(&pcdev->list);
-	mutex_unlock(&pse_list_mutex);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
 
-- 
2.43.0

