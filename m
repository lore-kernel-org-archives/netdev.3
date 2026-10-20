Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516318;
	b=libW4iX1be9MLAN4HJJv0KniQyZYDpkJWedIxqgd4WTHQLzX/oPOkD7Ils/41BzIiFak
	 YFyC204T8djuuA5AUptjeSOW23GZ6ALyz8cwixWGMMpD+LNxu5EuHxN4RRWfYCbLQdlCw
	 P/oyhB7rdZynouft+NGfUckuE0pJAcbRybYk/naSMwcBwvxdeoYTa2hsHPOFfa5Vi2/7N
	 MV4nvdWx94ZnsTYKIUVi9DQAHk2D5AWzI6mkcHflMO0o0TebH6QDnGOFCmgQYsdzVHg+q
	 kWEJ05FhEW1Xk6nu9ap6xd7MCdTxh1q0rgUsFBts5ZicqTs6C5fizSm1btYxVwq9xEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bJZpnR9YUuUTeUUGFEiY7wtArspbHQ7F5JlLZ9CdhPY=;
	b=ozZqNv49IwWbDVG92YEuCYDh6khAaRS59g4Kl7mv6EZXS87Ydx9cOio8aqAAHO8islgb
	 3dNxvGK8NzX+Xi5MDvgxYGYkllulkKIBUGpZzH8D+IU97ym0eyjis2Y8ZO1RFvczkJa1u
	 Wmx6O6oufjd2bGuIJQC6LpuDo7Bo2kgVemuQNZpOudKO0Wk7Py9gxl8u61T+lXpmqOJQ5
	 eeJ4PtF7AYyc/KKsWh5p3XPiV0LLHKESH/EJ5kOLNciDfcA948SFD/Jun2QUiw5N0Y1IC
	 7ax4SDRFIyvT5lQXNtu7g/5NPqoWcsdrDPz5k6hYG8aQ2QCrlwgZI8TSJKYDCXzbiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Qyftm2l6;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC164606A32D;
	Tue, 20 Oct 2026 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC164606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Qyftm2l6
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 2DE63E8318E;
	Tue, 20 Oct 2026 19:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJZpnR9YUuUTeUUGFEiY7wtArspbHQ7F5JlLZ9CdhPY=;
	b=Qyftm2l6m0luVr+mLoCMaPFQop6RJ2viR5gepzQplIHxWCJrhFM0mrSR70QMpxmSfUKxCx
	bFtbhy45kbyp+BiEuoUp/uxvYBNG6oGYxYurU0VTKnw3OvsrepMoPyiqnfF9xci923mvhl
	ReYeRqEFMiwnv+EUF8J77t/MOHY9SdNLk1rWB55x8A4Icz3ADoSL6IpLhRlzNo31kihp5p
	FKXuPKNSCU4/cRwR7+URVVh78BDUiOAKi8s5BjmEw1ehquvRkSKpkxyhydiDEmvicePm3Q
	zZG9J99FATnR4GWBEjpxxWesltqQVC4+sKVKS4+Wejmy226RAqpzuYn64sJNgg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id u8rrxHaJDjD0; Tue, 20 Oct 2026 19:11:51 +0200 (CEST)
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
Subject: [PATCH net-next v2 2/2] net: pse-pd: si3474: use dev_err_probe() for controller registration
Date: Tue, 20 Oct 2026 19:11:33 +0200
Message-ID: <20261020171134.852878-3-github@szelinsky.de>
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

si3474 prints the error of a failed controller registration as a hex
number, such as 0xfffffff4 for -ENOMEM. Use dev_err_probe(), as
pd692x0 and tps23881 already do. It prints the error by name, and if
the registration ever returns -EPROBE_DEFER, it does not log that as
an error.

Only the log message changes.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/si3474.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
index 2f4f241a48af..efb0af041599 100644
--- a/drivers/net/pse-pd/si3474.c
+++ b/drivers/net/pse-pd/si3474.c
@@ -539,10 +539,9 @@ static int si3474_i2c_probe(struct i2c_client *client)
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

