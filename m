Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431888;
	b=yBlEdBmlMl87DmW8NTIQMmBmFGL7UPInEFE/OTWGZ5bonS9exOn7Tk2kah1QR8Uta/Q+
	 G/vAAm+YW5JIWxwpodJ4YLGtp31WEivPFPCymfputiAN5M0UkDZ6u67/1y8uLh8xlgDps
	 5YWoUNaKcmhfrH2uRDKHLpL+vjmIcCNJDpUJYYZ8xg1jyarlair2ckLMYUnJmCIqw3kXL
	 fSHGWPvTFVRsB8SfXzJ7H+4xdtouzlBxOEcm8ZCOnDynXnkuvYxLMtnVOwlPr7hLOL4oZ
	 ZUYbxN0p5cyghIIM6eTHGAHk1sMvBW3KxNkIN3am+B7g09OZHtDLDtEbBeawm89cnlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TMTD8ylMz6V8M3Yk1dT1clZMvxV/CbkFKd6fldeMADY=;
	b=CXnInfTHFK4kgXPOuZPockvoOpd4rF6NZ+7kY+Y3u7nYM60bBLEc8H4Rw7rPpRCscf9T
	 YKI+jWlSw92Q3hb2XIH0aDk6I2v5zdTKjmznbc14T/wDou74XMzTkR+NAynhOrWcmhFhI
	 oTU9vQjxFa27ZK1v8B2nmrUQLMrmuYssEEoGZ1OzVdV+l0WOfgZU4dv7FMV+FlwX32O0y
	 Hrrsp9s60/3mOimL3V+ZUZpSoS/gvGfXouBCSbrHl0kp/fZehAeyYOLehvN9pLbHMMd4w
	 0LEWpc3h1wZdEziVlVAVgRd2AFgg/3HS+3LkSuvvuiegqbiHjrfBQs36TZmc3KgVjeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=T8T3iq03;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD760A5BE9;
	Wed, 11 Nov 2026 21:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BD760A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=T8T3iq03
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 61FF2E83236;
	Wed, 11 Nov 2026 22:18:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMTD8ylMz6V8M3Yk1dT1clZMvxV/CbkFKd6fldeMADY=;
	b=T8T3iq03YKYEhKOCVoxCICi8dx7shpJjqmBCi3a2o+dDtXjFu05lPmg0sQwhsS2NEGAMYO
	Lk4ry/rG2/SxUZcMX6PEpYPHfm03SXK9BUtu48aOISnEozXYd0yIR3yqv+md/CZGMFp0Au
	1Cp00StrUuSGIA5UZQLjZISDA9rLMohV4ZvVAZibWadqXdZD9EpNzBQCX1m139q7zFauYx
	8VTI/Rd+i2H1M/fx+ICV+0ziTFuoLO+VtmxFjETBYcwNyONxY2GV1l2eFEDsErCh+dhPjw
	b2a5qzTfkCG6u26sLUC46VWcIOZ3qtwcCDrXGy8LX47K4FPZPf8ejYcKZt5fRw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id EXaSzsp49B3R; Wed, 11 Nov 2026 22:18:06 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:18:05 +0100 (CET)
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
Subject: [PATCH net v4 14/14] net: pse-pd: pd692x0: defer probe while a manager supply is unresolved
Date: Wed, 11 Nov 2026 22:17:31 +0100
Message-ID: <20261111211731.3193796-15-github@szelinsky.de>
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

