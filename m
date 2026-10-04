Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA43BADA3;
	Sun,  4 Oct 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132174; cv=none; b=nIgbcx1yc3yLYfrwIHLiHrc49ANmGT3Mr6aAOfBw4HqWWpTYQanIYbIDAErwYI9r0ZOYHj/5+kD4r48bx1qk0G0W9RzWx1DSJAGV0VDIkU4rW3Vg9Dx1DzLyYcgAHWB77iAJ6HmtIjjyaaelz3NviGFFulJRFBz4COLEDzPFHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132174; c=relaxed/simple;
	bh=u4sPlWwCIPtRQdz4kStYhKvjrZDek3cjmPs7XGxY32U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6E08JQUmDcBuau5YmjnnXXs9+zurMsuPsPH+GY3U+dHSkZcUGdRl3UIbAe5+ybH9kzAwJ0BKxERgX6cL7Yr7WsD/bz5EUQAS46v7woGMCNCpHLeW7DiDPNpxaoHC+fv9x5pkEIwW5ldfJYss3QiNfz/jKaziL+lIKlyhgBLxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Y/KJzRl8; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Y/KJzRl8"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 11748E8388F;
	Sun, 04 Oct 2026 18:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb8BwCz9Thj9f/YjD0aAOxo9p9KcuLUQ+y42IMpHivc=;
	b=Y/KJzRl82L4DAgIjlRnLT9IDme4bX1/6Dcg51ske+6oWwdXlHHimQK8yfdco/e4zHap5EO
	oSucTQOPosT6uPkei+BQNmA03CkgiSjOSE5Ogd+984FitngfhSlIFLlrek/MM0wzWdyhjj
	9ysWmqOgLtFZtqfmJPsBbpzXyUIsSnYPO/QyhDHOyWNDxCNFl4+D2dkKUyQNe4lyPFDlJX
	Y6pBDoOdDzsrYPVFiskX4qdz4E4HjxTGFB5NZxQ26SLmvnPqPZdqHFecSPdEPFgD8pgbVS
	wuR9+cnJjWYoNXIrzMQm8SQq0+o91yMRV2BgxBc24n6o+T0ai4nTEd7B1Cxa7w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id wsWcwEYK11Dh; Sun,  4 Oct 2026 18:42:49 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:48 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v8 4/7] net: pse-pd: si3474: use dev_err_probe() for controller registration
Date: Sun,  4 Oct 2026 18:42:16 +0200
Message-ID: <20261004164219.1161294-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004164219.1161294-1-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

si3474_i2c_probe() reports a failed devm_pse_controller_register() with
dev_err() and returns the error. That is fine as long as registration
only fails for real, but a follow-up change makes it return
-EPROBE_DEFER while a PI's vpwr supply provider has not registered yet.

skyworks,si3474.yaml puts vpwr-supply in the pse-pi nodes. A supply
named from a child node only gives the controller a SYNC_STATE_ONLY
proxy link in fw_devlink, which does not hold its probe back, so si3474
can probe before that regulator and would then log an error on every
deferred probe retry until it appears.

Use dev_err_probe(), which stays quiet for -EPROBE_DEFER and records the
reason for devices_deferred instead, and prints the error symbolically
rather than as a raw hex value.

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

