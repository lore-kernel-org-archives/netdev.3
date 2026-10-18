Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6574582C3;
	Sun, 18 Oct 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311824; cv=none; b=c+7uVWFWjL49raWO9NOTzcRbGqxv22lm7miuwsO40fDM2gEtiHc+iq3QikEh0HASlzqQkW5s5k42nfgX+Wqv2py2Skewmd5tqkJZyO+91u5HJiZFjo+DE3qncl7iA0ULNQK2mHMFHjDAfOWmV/aLAHuoFmqyfpPBd7laYAhwKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311824; c=relaxed/simple;
	bh=vYrlt8Pfa9b6vhzq1opcePujwXiO10HJgmWOzEtxVzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf/yxQ6NyukAI+T8BKUn/otNf2t+9O/zbYLYJB9fS2Vngl23g9cf+Jc9ZKS0PyJxnwalTN1/01P0+6ygun72hPn6+W5TdqqQTdO+nOJx9OTB5ZxF7gyqA2F6dpR7spMxu8kypa6B7HVPEEhxXy+gn3JtPLqEm/liV0JTLNVfF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=FWORB8Gb; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="FWORB8Gb"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 814E5E8395F;
	Sun, 18 Oct 2026 10:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XAHRwnMVdx/douJoIkk7xA5rpRdBHp7dpx2id1Ipqs=;
	b=FWORB8Gbf3v8PILU5DX77T7iC3cmjutKpwGL1ET9gmgK2eIt2pYe7ClS0ZjjIMI7BCI7/3
	LnKKSYSV7zxmgFoRU6V95DLUX+Sf1eTxlto4geU4SS2UqJkOQve6Rehiuy/NOmfsY4oT4o
	FFSEkTGszrM2WrnT159glXZ2GOybVdVrbrJZQmQR8kkmvK5s6wJonb3G++BjRpgZLhoqWL
	Xs+ODuak6CxIXFUoOmdTvxWBek/T6+SsyjdA2/pRf5uUTjyZQBL8mMnNCLkXXxEhWSDjiI
	U0lgA3xnSZwqR7Uh974SDpawPSSm4R3QqFVUdKDGvblSEfYTfT6qIVJgxZqM7g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id FD0CBDZ1geqH; Sun, 18 Oct 2026 10:23:32 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:31 +0200 (CEST)
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
Subject: [PATCH net 09/10] net: pse-pd: si3474: fix use-after-free in ancillary client error path
Date: Sun, 18 Oct 2026 10:23:12 +0200
Message-ID: <20261018082314.48950-10-github@szelinsky.de>
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

If devm_add_action_or_reset() fails, it has already unregistered the
ancillary I2C client, and the error message then reads that client's
device. It can only fail with -ENOMEM, which is already reported, so
drop the message.

Fixes: a2317231df4b ("net: pse-pd: Add Si3474 PSE controller driver")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/si3474.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
index 1845b9c51cf7..2f4f241a48af 100644
--- a/drivers/net/pse-pd/si3474.c
+++ b/drivers/net/pse-pd/si3474.c
@@ -516,10 +516,8 @@ static int si3474_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(priv->client[1]);
 
 	ret = devm_add_action_or_reset(dev, si3474_ancillary_i2c_remove, priv->client[1]);
-	if (ret < 0) {
-		dev_err(&priv->client[1]->dev, "Cannot register remove callback\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = i2c_smbus_read_byte_data(priv->client[1], VENDOR_IC_ID_REG);
 	if (ret < 0) {
-- 
2.43.0

