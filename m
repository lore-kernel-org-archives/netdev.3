Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516390;
	b=yJxyBvzhgY/PYw9UQFRMIESaHhnoxLLBUoGX9yyYhoEBgAwTOrtHFc3OJvp10jCZxQ4q
	 vyw9m+x87iM01zfl4nLBOgPpWffzLGvlSMMKYx4sWrzty4sFK2KslBlXIJvPuP7r0aZR6
	 gO8oNHTgU071d8yyMCyt1PwaUwhS+ElwOboINgoYM/ZbvfdwQ6riTRvlKRIxvrJ64JrQe
	 8+Rs7iap9c1fntVcc6ycagcVrIDet78fjd6KqJJz3lOCMbZcNVllOPsOnNHV5qIkzU/gp
	 1K1YT+ZX3Hj+p4ffppHgw3oTLSn4VrPhwIWHSOIDQbXiPNQHWAnL0I/VjoG5XyaYSlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TMTD8ylMz6V8M3Yk1dT1clZMvxV/CbkFKd6fldeMADY=;
	b=z5n0yAtjBnP43KXBxD+arTdYHyMOi3sO4Y8qFNtHOVMIGlcL3UzKPYemf20bgiwwOv1v
	 R7t0Q7oDMG7nHp4/49k6zZ9jSaRDAfEqlN8Xr/K9TuCp00JPtwawTyscnJWGsc9gx8UPc
	 10Ilt6IDPa08/RZlNwu1lhQc8Aej3a1IkYxH7XnfpVuEcxVtudfmcyYe5PtfUjT1X4O72
	 xHGTgMIanMLOak8H7GWTEfynZFi0XO5VToL306cYvpBImtLYL7g1mlgrCbO5RuMjjLEEa
	 XIqfo7hV9nSpCJ7PjmSj4fWLQ0JMh4gkRDWg2yQFVyovQ2WuaF99SKqCFwD/G6oRBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b="cwyRo+5/";
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B060A3838;
	Tue, 20 Oct 2026 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C48B060A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=cwyRo+5/
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 1EB87E83563;
	Tue, 20 Oct 2026 19:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMTD8ylMz6V8M3Yk1dT1clZMvxV/CbkFKd6fldeMADY=;
	b=cwyRo+5/6YZkraY1Bc4XiEkqp+tUVxO+hOV9iua8opyOGZdC/QFCKNJWR84YlgVYQiUlF1
	+JmZPfrJY+jY8B7LQ9JtCykO+DyEJNk3hXHuI2ipIvO+hLI+Fp3mmn65T891MX9YkvNMT/
	dMrPBjGAYDVtT6QvjSOrL/uymPVfzdCmg7Uj/Y9FA67rC/sMyHf0EnjcsraYRHjd/cT396
	XvHe867ZtOxatOy7pqNxoWAzv05igkZh7+cEJBFb9ackAahlwXedIjyhfUDJtLKnuYlE8h
	+Xy9X0cu7w7LnHIc4ZOrUtjYsqBOY+/qwmGfxDuT8/EiL+GrwYWOY4mG/M5qIg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id ynaAqxxSIVUR; Tue, 20 Oct 2026 19:13:08 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
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
Subject: [PATCH net v2 14/14] net: pse-pd: pd692x0: defer probe while a manager supply is unresolved
Date: Tue, 20 Oct 2026 19:12:49 +0200
Message-ID: <20261020171249.853085-15-github@szelinsky.de>
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

pd692x0_req_managers_pw_budget() uses each manager regulator's supply
without a NULL check. The supply is NULL while the vmain regulator is
described but not registered yet, because regulator_register() does not
wait for its supply. Probe then crashes.

Return -EPROBE_DEFER in that case.

Found by code inspection. Not reproduced.

Fixes: 359754013e6a ("net: pse-pd: pd692x0: Add support for PSE PI priority feature")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pd692x0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 34f0dfbccd06..568789bd912f 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1056,6 +1056,15 @@ pd692x0_req_managers_pw_budget(struct pd692x0_priv *priv)
 		struct regulator *supply = priv->manager_reg[i]->supply;
 		int pw_budget;
 
+		/* The regulator core registers the manager regulator even
+		 * when its vmain supply cannot be resolved yet and retries
+		 * later, leaving ->supply NULL until then.
+		 */
+		if (!supply)
+			return dev_err_probe(&priv->client->dev, -EPROBE_DEFER,
+					     "manager %d: vmain supply not resolved\n",
+					     i);
+
 		pw_budget = regulator_get_unclaimed_power_budget(supply);
 		if (!pw_budget)
 			/* Do nothing if no power budget */
-- 
2.43.0

