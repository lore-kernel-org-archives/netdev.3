Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7074582C6;
	Sun, 18 Oct 2026 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311821; cv=none; b=TgRDD6gOPrCjCQjgGT55tpEk61jX3uHfHoCyhtKYnIn78SdM16fudppb1Kaofll8zVNYqKWGwWUix6V9QbEiAmMRzRKK/VpLDHLU93Zec9ANsr+munSqb9FrVHg5KjftUgQiYK5Aa8fV/zKC/IZATj5BLledVsa4Q7iarfAXVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311821; c=relaxed/simple;
	bh=+w5aNejbjtRsYH9Ipya8XfTC5BCQ/cz2BhfHBAYHzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2u4yPo4lPzY9+uEdARECQ+txk9W9uIfkgvnBFG5h3vy1Lm8t+8KIsK7uWB1ugXk2QNqxuv87cWiMJHvdVWzRf5WSr24Xld3XZESzfjg6A39kkggNQbFoAQ0sM5y39wXhQ+CEwnZlHunYjD8I/iziAF+Kl0jZudZL0obfFzhixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=MtKqd2At; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="MtKqd2At"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 80B90E8392B;
	Sun, 18 Oct 2026 10:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SdxoOY8sAmMVfkgFyWBu6MoHB/U6OvWpWiIiY/xeVU=;
	b=MtKqd2AtrUB2nA81EhnUt41A1JNNrh9cc/xTWdByIKV6MazwyexX1drKZ9Iil9sIducNvG
	zdiIMtTs2rP0cXwh3J455Fl9Vaoo9Io2wSBH3UnCnTydHLzeCuSBbDuHSnaEo/IGBihNk2
	ml7V16Xlz+j3CZGFwhHaHQeAenhEcFIbdbQyfiO3IwcIbj1VzahOkSEVD6XxBt534KbfYg
	oNA4JdYmQJ1zlVoKR4BU33gEK0ecA/K/I/jLQoG9jbdIWNw1JSLi8/GxWNs5qQd517gAES
	35D9j+kH84nk3hM5Y8tawFoDg4WUlOSHtL9zOv5C/gzTa7rZWJCOh3MOtjV5wg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id YfQAjP_99Tx7; Sun, 18 Oct 2026 10:23:31 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:30 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 08/10] net: pse-pd: pd692x0: defer probe while a manager supply is unresolved
Date: Sun, 18 Oct 2026 10:23:11 +0200
Message-ID: <20261018082314.48950-9-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018082314.48950-1-github@szelinsky.de>
References: <20261018082314.48950-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pd692x0_req_managers_pw_budget() uses each manager regulator's supply
without a NULL check. The supply is NULL while the vmain regulator is
described but not registered yet, because regulator_register() does not
wait for its supply. Probe then crashes.

Return -EPROBE_DEFER in that case. On net, each retry also leaks the
notification kfifo and the PI array until vmain appears; the fix for
that is in the PSE core fixes for net-next.

Fixes: 359754013e6a ("net: pse-pd: pd692x0: Add support for PSE PI priority feature")
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

