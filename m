Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431883;
	b=SyMNBgfcoqRBeUp/9xFhTw0ZjhekAvRB/9/G9T9DgdTwdyT5tY0DoJ6VMJ2T1n5VshYS
	 FwvJzRbVqUoALPeDFscWbenXnzQpKjkHipDU4w/CLW2vG2HS7w4DzGG4bDpp5glwvt8UR
	 yf2WyT1Q1xf7S5HhDj7a21nPirpe3TExJZGNgQUlIRSOvIdeOc1zgyAD+H7SxMLeOFSP9
	 iEQ7FPlKRuJK6JVUGfscQX+iW47fGyqia2w09T2ZvslP/NvPokBvCauHAniomKugsV423
	 fQN86eaf0226Dgbwy2mcoO0o4560ETTj8y3C3qjDnMg9OEyPAwWtFgFVxo4KzpG3aQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=U/s9WpBgSFZmxHOtI1J+3lfhCl7kgEjOZgarv9f/rWY=;
	b=jcO80x5+nDJyjbRap3izpLi1odRPVPMTInHanYBT9mFExdQy4DP45OlITUZtXBjqSYmG
	 mt60TaBAvNXc46aOkPkHm/csJlJXgq8H8U3cALA+tGT8lDt9v6lSvmLr4zrhBfn0gWqX6
	 HitjAASqhJKAJCwvZcioA2vqzg3SlzeycIkn+sdd3xbxGbK0XjYVhop68MNxKpEFu7O9s
	 YLtr+wiL+adYXEb7x7+SqBcLoWOChCcPqua7vTELJbxACNfoUw7gsSYQsixJN8ZXVvXiD
	 7WOB8K6jw+zdjfDrvQ7JWPnWP9FgZQAVcZYTdNIvJNdjuXp4akeQLGVLrs0bm9rlG9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AR18vAgV;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C66606A33B;
	Wed, 11 Nov 2026 21:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C66606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AR18vAgV
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C3085E83243;
	Wed, 11 Nov 2026 22:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/s9WpBgSFZmxHOtI1J+3lfhCl7kgEjOZgarv9f/rWY=;
	b=AR18vAgVT5bICSBuZA2rQKhqFYpbBnvKTwdHBAn3IkhE57XBNA1MubZgLtGiwp7BxaBaHp
	4asoiCtHvHb5lRjWIdqMN0vCRrKhTpRlb+fD1jcVE+MDoM8YUe3eRzFfkmZvqNtJiTh2x3
	HL5lCx65Rmk2GiGEIyMeEi3yO0n+xTfRf+nNi6vjRcKHkGl7y995fP0UEai25Nh0Z457u4
	U6frujBjl9x58PnOEy0BChv4Y+UJOZ4Y/25vAXq0N5NFl0vAFHXsTjz86CRe6emOCiuCsy
	dI0mVCpLY6GbnhGVaab/WnVIrhcwyhIk18IO1VArovTPQdmCBulQwDrVtdyVFA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id nddaUO10EqFL; Wed, 11 Nov 2026 22:17:55 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:55 +0100 (CET)
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
Subject: [PATCH net v4 03/14] net: pse-pd: fix module refcount leak in pse_control_get_internal()
Date: Wed, 11 Nov 2026 22:17:20 +0100
Message-ID: <20261111211731.3193796-4-github@szelinsky.de>
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

pse_control_get_internal() takes a module reference, but when
pse_pi_is_hw_enabled() fails, it skips module_put(). This happens on
any I2C or UART error. Each time, one more reference leaks, and the
PSE driver can no longer be unloaded.

Send this error path to put_module, like the regulator_get_exclusive()
error path.

Found by code inspection. Not reproduced.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 03da633c6382..c6612232b820 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1426,7 +1426,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 	 */
 	ret = pse_pi_is_hw_enabled(pcdev, index);
 	if (ret < 0)
-		goto free_psec;
+		goto put_module;
 
 	pcdev->pi[index].admin_state_enabled = ret;
 	psec->ps = regulator_get_exclusive(pcdev->dev,
-- 
2.43.0

