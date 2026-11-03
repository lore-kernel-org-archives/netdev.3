Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743366;
	b=lBFFn94//Y8Rk1XMdheexg1HmYy4Nm4fDanhzbOjV6POtciWKmIxbyQHJQB2s7LOXnpj
	 mUjOWJI/z40Ruf8nUa8RRBukb/cy6xT+eC2mwqkscSYE0lFXuUmgZTDKIa332CXAm8HGf
	 cXLEL+OchLsUaO7Dcg8NfdiWsf+B4fS+ayoKtTNiugm38osP5dgDvg3rGBpsmoBUypMwE
	 idLLJq4tUv7wDzuH+d3eMvMWBtz0fIDjneVZqpA/p/DzhULXCKvhVXO59q0GDKupFRxYJ
	 G12WNSIrtGbkm9wzbfe6UrYbX7KiRqBTX+CsC+QC1HAO6/QeFyZOpBq0w2VCjY3UhfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=U/s9WpBgSFZmxHOtI1J+3lfhCl7kgEjOZgarv9f/rWY=;
	b=3k5h2tgg/oFx6Gs7S7JdZkOmGdCzJes7RleSQhB+OHlQo/9COs5cv0qmTpoOIdMpH9Gu
	 qmYYGkjvRPE7CExf91yxdl7HxOvxlB+1e88gXTXnwWIj8LrgA5sw7nUtjNC16OvT3cRo8
	 JXRpH69lCNboXZdMH4MKuTwcGyA4BhFQ3auZYoiC8Kf8xfhAzfA3m4i7W8d+yjLTBpHFh
	 C74OnZcRx7+xe/XIq+WKi7Wjzxv4UWb3W0LGZ4xfKcroDnT79KbJkzHWk5rC7DvXU9nKV
	 j7B+6dgVKCKw3Nh/FCUtOZ8DB3Nwln9PhtTefQ8cY15YWqRwANVTRgApZ+FfjYyJeuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=eQtPyY1y;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95C606A331;
	Tue,  3 Nov 2026 22:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E95C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=eQtPyY1y
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 5A3B3E836C6;
	Tue, 03 Nov 2026 23:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/s9WpBgSFZmxHOtI1J+3lfhCl7kgEjOZgarv9f/rWY=;
	b=eQtPyY1yQQhSB69+LsQaRoqz5pHB6y4sKXlRWlNDc6t2uwVOXsd/L3N7R5/+2i5sNdOwxT
	FN+sPq6WY1VxGc941Ku6OAQzdw6J8LMY2QoLaEhAlxOuIeNrgQCt+n8bnpJuP1vHxPq+XA
	9JH3PC1ks6ueoa4ugpGSKwrYW1qVJVBJBhDUgF9iNuSJFeQ2ndgAFMxhvO8H/UPrc2DeCk
	6col8HtWaDuvzR2GyeZUdvneAq5txYhenYqFTHBsJx1YhO3Kc1QpJllyOQiwvGCwh85RVc
	HYYsegvCBr7YcwRhMqDyaaIyI1vp+0+iupdQbcAe+NfkAZzinB4e/8uvSnGXTw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id cbFrVMf9u6l3; Tue,  3 Nov 2026 23:02:38 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:37 +0100 (CET)
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
Subject: [PATCH net v3 03/14] net: pse-pd: fix module refcount leak in pse_control_get_internal()
Date: Tue,  3 Nov 2026 23:02:06 +0100
Message-ID: <20261103220217.1131971-4-github@szelinsky.de>
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

pse_control_get_internal() takes a module reference, but when
pse_pi_is_hw_enabled() fails, it skips module_put(). This happens on
any I2C or UART error. Each time, one more reference leaks, and the
PSE driver can no longer be unloaded.

Send this error path to put_module, like the regulator_get_exclusive()
error path.

Found by code inspection. Not reproduced.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 03da633c6382..c6612232b820 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1426,7 +1426,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 	 */
 	ret = pse_pi_is_hw_enabled(pcdev, index);
 	if (ret < 0)
-		goto free_psec;
+		goto put_module;
 
 	pcdev->pi[index].admin_state_enabled = ret;
 	psec->ps = regulator_get_exclusive(pcdev->dev,
-- 
2.43.0

