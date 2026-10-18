Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4A43F0B9;
	Sun, 18 Oct 2026 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311565; cv=none; b=s0XWqMC5GqWzaVcgzZX/06lSA3aDQ0WqkBEQxyQDDpW4KllJYy1Q6TweYEP9lgvlhc7dGUU1BAYhmkAZkuccEa23fgHmaFNmniTg4CC63MsNtxIw5QGflmQ1kr5v+czU3+ejComIi0urXCuzVw+ZXl7iRZcno8Xu6sVHfwdMMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311565; c=relaxed/simple;
	bh=fYeYwfNeoIzXF2xtLHqh+pPzduULFP9d+GDfFDoD8UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeMZxySZR3Ff8xAWkz0D02yN5ZUrJg7+RlfyoYC11UHjvGcsXOwWVt2xdcIgYoUY3euN0vclo0QoFcOgvsq4y6JWbcGq+aP0HSZiN+veM/eZ9W91pea8UOUQFiDqMnA3yOWKZZkwT+tlnkwXujkErtWZ+E/4pT404wqwJJxOx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=dFI2vtSj; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="dFI2vtSj"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 1C5BEE8395D;
	Sun, 18 Oct 2026 10:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gt4srk+sNOFf6ClKqVdNZYYDBbviBKsCmkwkb8pVxOU=;
	b=dFI2vtSjbdt2mKB73ZOkncsOEMmpj0Q/YITaTazus/kDuelAaCWewD0VWU0xCaeBSzEVKf
	sDVDRzKDv4irvQgm+99QYCgoKbzZKBmJVK/7w3+HHH1OdWmQoHkDsht0AJOUC0i0CJOZ/0
	dz5ABrQY/TtIvvLDpmxSwStEMoKbJj9d17vl4eld6mMP4b/NeFT1NzEhz3ou54niWPlqDj
	LLldBnI1637eUMbdqsNk0yRtF1w5T3S1N/KYMuHmqchdWdR12VxUmItCXkDvk3LDVEfErX
	wsAUrmiVmyMXxrbw2Vis3/NZHMGJ+GTk7UCOHlOELlcw2VyXtVpKXPWVXEqfBQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Hqk83dWNGdkQ; Sun, 18 Oct 2026 10:19:19 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:19:18 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Corey Leavitt <corey@leavitt.info>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next 3/4] net: pse-pd: si3474: use dev_err_probe() for controller registration
Date: Sun, 18 Oct 2026 10:18:52 +0200
Message-ID: <20261018081853.47484-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
References: <20261018081853.47484-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch makes devm_pse_controller_register() return
-EPROBE_DEFER until a PI's vpwr supply is there. Use dev_err_probe(), as
pd692x0 and tps23881 already do, so a deferral is not logged as an error
on every retry.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/si3474.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
index 1845b9c51cf7..91800f39971f 100644
--- a/drivers/net/pse-pd/si3474.c
+++ b/drivers/net/pse-pd/si3474.c
@@ -541,10 +541,9 @@ static int si3474_i2c_probe(struct i2c_client *client)
 	priv->pcdev.nr_lines = SI3474_MAX_CHANS;
 
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
-	if (ret) {
-		dev_err(dev, "Failed to register PSE controller: 0x%x\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register PSE controller\n");
 
 	return 0;
 }
-- 
2.43.0

