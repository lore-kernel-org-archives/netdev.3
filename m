Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431882;
	b=gAEeA12w6MGadQ43x/7sgUqPJd1Sce7K3waoeFf25eFMWhiCRe//aRQ2yYmkcrWDi0Qg
	 1rvQEl8A9njE+4oh9vwdvja4c00h5TjVQgI1wESMbh3LROl7YED7JUf434rpjmU/83h3J
	 7vVw6Xpn1v12hfGYAaLfTu8SSgUx8cCt10CL5lMz6jdZGDLMg0IGR9nMvsqwOUIbHKfz9
	 JekzCeJzLo4aqjyQvv20gxUvQ5kdpQ1ZDb827rPi4UkK1J3qpaHdP98Wfrpeorvk44EJH
	 plH3PsT2EAcGLHI3ediLjIPkiCBDKtk6VqoEbz3BF3en2qpZuMQdWlMK+3m2yr+Hl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=mTZ3n4hPRr7Kz1May8TS8750xOr2Mb5d4jqbgGBsLJA=;
	b=ncW3aZQkYc6HzIAMXBke9kX+wL4o+DzwMbNvwftuRTF4kKqfS7AFB4cOCzwB2AAdmAeo
	 8Iuvxh2aMfHeKAWyh5AX4+HzU9MvAhEpCNMypD0e84B3nUEKSwXRBAgQFgLtNE4k8kAT8
	 d21u8bHhwcX2rd2NXVtatd7xgHwj82YY8v9mCokMCzayWvMZbK88r72glf7QUfnnz5tgj
	 sc8RVIwPXhN5dCsprjRc50iekQoMJuk4HMrnA6HTQW6DRRGVcZU5LaOtGKoObj9hN8icD
	 7TpMIH4wmpQpKqgAyJP+xc3nQYYlzAWlOdpa/5VycWyCmMTpgCPmxaIEwFA0yCSHBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=fTpSy0nT;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D620606A880;
	Wed, 11 Nov 2026 21:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D620606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=fTpSy0nT
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 20479E83237;
	Wed, 11 Nov 2026 22:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTZ3n4hPRr7Kz1May8TS8750xOr2Mb5d4jqbgGBsLJA=;
	b=fTpSy0nT1h3oa9YKp0zDmDUDgwSksniFhGquCvg7hA90eAhW+ewzliTPiuklPiGOyV6wi/
	35JqtlaVL08QiO1iTOdfgLzli1s0lUhZuAdVNURHtVVx19VW3KVmwOpkh8DjW7SG5hMcGg
	DQZs87Le+OcUSb1bDrVhKA762+4eGjtRcBYyOqEf4HFZZ0uY1eGyyrzaDe+bO2v0jKmnse
	SYvs07gHw6B8pHKe5Cv/0srvGk7WfP1qzuW7YhWzKR/S0T0jbjelrI8YoHSXaJwABDEENA
	fWqVANjYL7vBNSLudk/e7T1yyOtusEteqTyGexaFmCr6VCNyJV4d1Li/n4TaTQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id CXUs1gPFJfAv; Wed, 11 Nov 2026 22:17:55 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:54 +0100 (CET)
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
Subject: [PATCH net v4 02/14] net: pse-pd: remove dead pi_get_admin_state() checks
Date: Wed, 11 Nov 2026 22:17:19 +0100
Message-ID: <20261111211731.3193796-3-github@szelinsky.de>
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

pse_controller_register() already fails when a driver has no
pi_get_admin_state() callback. So the checks for it in
pse_pi_is_enabled() and pse_control_get_internal() are never true.
Remove them.

No functional change. It makes the next patch, which fixes an error
path in pse_control_get_internal(), smaller.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index c0573cbbba5b..03da633c6382 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -412,13 +412,8 @@ static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	const struct pse_controller_ops *ops;
 	int id, ret;
 
-	ops = pcdev->ops;
-	if (!ops->pi_get_admin_state)
-		return -EOPNOTSUPP;
-
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
@@ -1425,11 +1420,6 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 	}
 
-	if (!pcdev->ops->pi_get_admin_state) {
-		ret = -EOPNOTSUPP;
-		goto free_psec;
-	}
-
 	/* Initialize admin_state_enabled before the regulator_get. This
 	 * aims to have the right value reported in the first is_enabled
 	 * call in case of control managed by software.
-- 
2.43.0

