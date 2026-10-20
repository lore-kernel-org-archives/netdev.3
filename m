Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516385;
	b=VWk7QhgS+YlQ33DS0pW3ve1zT+uO1kmEMZai9CZopRFHWNiXmUymRYoXsQN6V8l4WaFz
	 R56Ov+vBCEc2TbyyF1U6hQeXnzxHukPU/yRfZ7umMizeXsdFRHQPhC7smZoGfVwEMoFSe
	 K5OaD5K0qC0GZTKwmMSNnZw4YuuqzGg/0brprVCimp6QjKRR7jh5jzHVn6SuK0dcS9Ld8
	 wC3qQuJ/6wk7QQ3G0e6yXkc10ymAgHQGL0P4urhNFPKii0onF5AtzqvsVwlPoLNBnki2U
	 o7zq29g/EErMcSyN3HChNAZrpazMSvGALrVZIdW2lqsbgN7ZLOeXNZy7SivYXrFWamA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=WdBLK3gS9Xch5n1H73Pyc64cAIn7AFI4sBo8MGZaOA8=;
	b=yuuprqgSGRwtsuYdd3uN589y1QSzSpnh1yMcGdMo5SGfaXeJVZ/nS6FS/b9GxArzWacK
	 kogP0INTkp3mUdpCwW7rJRCenkOQuIiZmIEwy/YAyJG1mtmTH64ZKqhYa6FXBolwWabhk
	 FGI8+5dG85XftFLVmV+ADkdYOsCcMg+VrGkFaUMLZMQOqS1V2vBWronXtJg4DjMD7vZm5
	 cCSImhOXk9DeV3jdJFusqzwUNJSLjXuNFJDYwRlOWVr+ISMZ9GUeAkb7+Ska4RApIedbL
	 Gr2FKHE0Zn1hIb+Gnj+88bkZa+/nBX+AXgGIvbcT7Wg6+IV/n4iuKIllxc5PpXboYrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=gG1kytz4;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE5606A334;
	Tue, 20 Oct 2026 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59DE5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=gG1kytz4
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id DE7B0E8318E;
	Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdBLK3gS9Xch5n1H73Pyc64cAIn7AFI4sBo8MGZaOA8=;
	b=gG1kytz4/OJfX+65Zz2vJjXQc5AqaFwz3UJ3/TGDX+/fOr8JV/ofd4dWdfgBqJ+3fX5Nzk
	/1lKwg5aS2j0vwHiJh0PLhRKeqmRRc4nHI6xR2ilz2Q0kEN8VTVoiZrKNvndt7zII4EqZr
	XjTXko4D58Roq4A1oh5LmLC7DOhm/qkbU7TF3QUVKEEFeV6xMBikjYCNpf7sPGrdMnbBlc
	xjuS6xqys4FtLJdok/LBKX6/fP20LOvXzU5NW05uria7jF9v0i16HZbwYpSg7bhP7e0uBx
	fP8JfBIxJAbzbuMiHqBGuealHLgWGgcNEtj+l5HdkMPYVwcAKWXHvJmRiAY2QQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 5_3JjjIAFLBY; Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
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
Subject: [PATCH net v2 02/14] net: pse-pd: remove dead pi_get_admin_state() checks
Date: Tue, 20 Oct 2026 19:12:37 +0200
Message-ID: <20261020171249.853085-3-github@szelinsky.de>
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

pse_controller_register() already fails when a driver has no
pi_get_admin_state() callback. So the checks for it in
pse_pi_is_enabled() and pse_control_get_internal() are never true.
Remove them.

No functional change. It makes the next patch, which fixes an error
path in pse_control_get_internal(), smaller.

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

