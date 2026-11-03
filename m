Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743369;
	b=sIIWKAh7gTszYPrHkNaxhKTeo6ZEeMO2MYdQ5lMj9cZIynQSacvT616iX/3zG+Dlt9k5
	 QZsGXPp62iAYX53dFLMdt2NW7E9oIODG5zS6OZchPBEWIZtoRNBZLFTFs1C1Ea9DV/jCb
	 /YBsjhBikIiFz1VYuXHKz2Lozz9IicWPN9DxWkDfcV/39gCHoSs3q8p2GM/RhcBqyRWyk
	 zdynLIgXyYZEpbeQdSCft8CNAmCbj/bDitwPzDwWWnjeJKAg0VxvK4OLO0ksczAFxVfhm
	 XFqn49Fhv6AD1c0Pd7C2qOV94hJ2xEEUQUbqJPo8+5xVnwpqYWDdl7LBdXQLO11dmpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TMTD8ylMz6V8M3Yk1dT1clZMvxV/CbkFKd6fldeMADY=;
	b=aEIVUogjfzy7ghcA6bPqHVz5Rve5sCzjSiiyjRFY6Mb/htlBfu+Df0f5RI3kz57rSK3B
	 jIKDdIZ/jDlbHw6w+GCqmsy/3/NzT4SoFQiQAm2c/HTaW8/LlgNrRw27N425JSIpDw5Oo
	 n6BL/qSTSyVCZzRLDhY/h25vLUAUMooDh1a1OZUJG8ukOA9k4QoVnA6wkvjl/1tchTaV+
	 rOoharZrvffgoedfnYgk+lcHqJAJ4yZs8EzU6LDUCgtbEaPuI5uGWMBjE5OVwkakh1M+z
	 oNmFjsj8kHkovXyd1y1Zt1VCcqj+K2sSIOuNfb4NoVPTl/8x6keV69/Dr4qpvMDexhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=adwIjxqC;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4507606A337;
	Tue,  3 Nov 2026 22:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4507606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=adwIjxqC
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 2DB82E8337A;
	Tue, 03 Nov 2026 23:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMTD8ylMz6V8M3Yk1dT1clZMvxV/CbkFKd6fldeMADY=;
	b=adwIjxqCvi+Pxo9ZgBZ/WFZiv5scrhp9eGpI6xtAaKMCtokhFDLc6ao4D5Js8caBMAFOvs
	z4u5PE8yhGnCgKfJQS5c10kIvUKknjkIwCOxZ6QR7qBQGdSwvROPNTaky2s1VVxo2+lcPq
	CPFOLw7VKsyudeI/UmoEXzYzTaBBT1wyYdSCgzbhyS1tz7AYRZp3POk2rQMQeNulN7YGan
	vVSk5KjpCxli64wgwphvo1ya3nSTHlPNCNoQcVb9p/9+jzpWyT09AYeJBJsy+9CuK7SPsi
	h1W4GzqR6tL34OU62ivH8ESA65mWuUaNrN15PI3T6zz2VUw1sn/GSuKEgsZNWQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id LJOGhyoqj5wE; Tue,  3 Nov 2026 23:02:47 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:46 +0100 (CET)
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
Subject: [PATCH net v3 14/14] net: pse-pd: pd692x0: defer probe while a manager supply is unresolved
Date: Tue,  3 Nov 2026 23:02:17 +0100
Message-ID: <20261103220217.1131971-15-github@szelinsky.de>
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

