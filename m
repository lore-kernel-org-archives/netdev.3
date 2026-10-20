Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516313;
	b=dAC2rHfbkSE6pe1o9MFRbpw0rb1J3l9/scuncb/1ntXpG7XqNo3Ax1hWTT3Gt2XzJci+
	 zUHY1xW1Phgx/JRxMtS6I/UwNvrFzeD2CsySO0jHD/LBDiTFBJMjn8jlkLWayLj8F4GL9
	 fmflKP8VN5jpUINoSHb9rEfPVOM+q0nTyRlZhCL/Ou2iQ7RIJoukaOuBdn7sZLpI12142
	 MA+vLMEUmyUvCIoJ3krYN6DPOQ05XSf5JcePKcVTlmunpdvvp65UFvthu0B3MF+RyvnbI
	 dFPFm40sGY+LXyhqzSgA4ZgaAGdiKzpRNowe3ag7K5lKtGWvOckWqzCQMq4FvOMUFqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Z6+7ta3PxA+AvIXS7vZOE5AW2TBZlAj5tC2hz64zIhM=;
	b=Ri3v4NjOQYSuLVSILjqyCWoxHmWwdLtsY23+n0w3KYlwZeUQMdcygP+otxhLLSZ7VSb7
	 1nlqMehC6kiN97Dok4lXYzwscbgeHMrw7WJtfmAY5zfqdEZdipOLmcar/WD3f2zhpuCSE
	 /yBwrfj0rWFheiT/4+uqnoywgDc9HsAWnfElGEKni0Z9fiGw60KDC5XiU3JRHQbnz/5RH
	 Ij/kB4D9rhxaDBsM+KttvpIES0gMer3WG6rDT6u1Sb1VpfdarPOWrw6CPX/ApLiPJfLBL
	 21c8QVFuhcXck25tzay4TQg4bMSVB2n84XdtVDy3KDAWcBzdM7+M7MbmIPmMXVniOfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=e045SCJx;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B960A262E;
	Tue, 20 Oct 2026 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A00B960A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=e045SCJx
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 8FFF4E8318C;
	Tue, 20 Oct 2026 19:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6+7ta3PxA+AvIXS7vZOE5AW2TBZlAj5tC2hz64zIhM=;
	b=e045SCJxN2nb/ggRMuJyJ7LyNU0XsBgIFLXA0jz48Q9c/TQ3leKUbP1ajX5mHJ2ESy6dRo
	ewschgdKorlar5ZapuS0A20A7l3O6wgwwO7t7QyRUaxPZMhiaDIs4GYEobFWW8Cck3hCFg
	xyjGWejrUXMLmjU8aDLZwJEbo1dhdU+0deUqHtQzKljysQ9e9K98rz30pwjR8Mbu2FC/l2
	8zZMEAC512XPE9m6Aj9zE4wcLten20rOxVMf+MYLtvhMHxxKG8BVMtVro4X80SCy/v/LOD
	FY7Hm4c73J3Bee8I8M67SYZ12v7rzV5EOTG3/XdaeM6WBpKCyQF6dJMlyeUDTA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id JJHMPD-Fwl8f; Tue, 20 Oct 2026 19:11:50 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:11:50 +0200 (CEST)
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
Subject: [PATCH net-next v2 1/2] net: pse-pd: si3474: fix use-after-free in ancillary client error path
Date: Tue, 20 Oct 2026 19:11:32 +0200
Message-ID: <20261020171134.852878-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171134.852878-1-github@szelinsky.de>
References: <20261020171134.852878-1-github@szelinsky.de>
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

If devm_add_action_or_reset() fails, it has already unregistered the
ancillary I2C client, and the error message then reads that client's
device. It can only fail with -ENOMEM, which is already reported, so
drop the message.

Found by code inspection. Not reproduced.

Fixes: a2317231df4b ("net: pse-pd: Add Si3474 PSE controller driver")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
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

