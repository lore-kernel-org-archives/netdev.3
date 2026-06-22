Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556D3368B7;
	Mon, 22 Jun 2026 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156561; cv=none; b=r7khj2aGNSPMZSuq+u++hPMQ6h/s5UzMi994z+JwdnuLiK1ArjRJqrq0klSdOKO9TWG+l3e8U4/yAzPEZJoUW3eAvAqXBCpb3QY0UNKCEzz4LQ/XV7PEcORVxcRagKPCTXPjWFa3Ikw8sGh/SJITRHIv0Bg6VlKips/A8tEb5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156561; c=relaxed/simple;
	bh=IlF0pz2gsMAwVai5+zxwXHPKGEW7c6AnprhfYwzDTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j50wHXjBTZpbemkXGere6pb/8Z+VH+GvOzE51Gp7fkkMSC5XnM92JVEYl//Y5H8U/sePhesFfC6lj3UoeSyRXRytoCx19+t0GeyZ4tSZfgXR58/Z0s5U/3UoyfdF2Pg3A+DCrtmaeHZ9540fCdbzGA4K6VOsbcibdvtxSha8DOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=PYQcu3s1; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="PYQcu3s1"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 0850BE83606;
	Mon, 22 Jun 2026 21:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782156552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=698GqI9iPEQP2DVBf2DNCaRc1+wpNuobwHaVUvlw7f4=;
	b=PYQcu3s1mJXYowjkdKo1379740IjX4vUj4ObfGnSMoL2EMT8cQaYrkkY5DjwcE27QVXqav
	FuowM7fZrRHOgv6ixVghKCZjtzLHO4UxTSw4MDtvpWT4aB1nKosPiyF0JcXwzA7oy0CdL0
	L1sgVlxwzb7rzdd5xSM4CsNfDVWI70rMco/s42ApkQPaTVEgc5pERiMGduprCuput7qL59
	VWOasLM9VJOx+HizND+vnpZ95GQNn4bl1Bq3UkvMaXljA0n2TDL5Ut3e5TrzpAa9IQuNyw
	KkRd/FLD3m26U/CTyidihZR1I4WMyXWofLxabtYLYojFYqoLOD34wFR/Z8/6Qw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 6IqdyJcRPQvs; Mon, 22 Jun 2026 21:29:11 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 22 Jun 2026 21:29:11 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net] net: pse-pd: scope pse_control regulator handle to kref lifetime
Date: Mon, 22 Jun 2026 21:28:39 +0200
Message-ID: <20260622192839.2508733-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Corey Leavitt <corey@leavitt.info>

__pse_control_release() drops psec->ps via devm_regulator_put(), which
only succeeds if the devres entry added by the matching
devm_regulator_get_exclusive() is still present on pcdev->dev at the
time the pse_control's kref hits zero.

In practice that assumption does not hold when the controller is
unbound while any pse_control still has consumers: pcdev->dev's
devres list is released LIFO, so every per-attach regulator-GET
devres runs (and regulator_put()s the underlying regulator) before
pse_controller_unregister() itself is invoked. Any later
pse_control_put() from that unbind path then reads psec->ps as a
dangling pointer inside devm_regulator_put() and WARNs at
drivers/regulator/devres.c:232 (devres_release() fails to find the
already-released match).

The pse_control's consumer handle is logically scoped to the
pse_control's refcount, not to pcdev->dev's devres lifetime. Switch
to the plain regulator_get_exclusive() / regulator_put() pair so
__pse_control_release() does the right put regardless of whether
the controller's devres has already been unwound.

No change to the regulator-framework-visible refcount or lifetime of
the underlying regulator: a single get paired with a single put. The
existing devm_regulator_register() for the per-PI rails is unchanged
(those ARE correctly scoped to the controller's lifetime).

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Signed-off-by: Corey Leavitt <corey@leavitt.info>
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
This was patch 1 of the "decouple controller lookup from MDIO probe"
series [1]. Reposting it standalone for net as suggested, since it is a
self-contained fix. The rest of the series targets net-next and will be
resent once net-next reopens.

[1] https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
---
 drivers/net/pse-pd/pse_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 69dbdbde9d71..a5e6d7b26b9f 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1367,7 +1367,7 @@ static void __pse_control_release(struct kref *kref)
 
 	if (psec->pcdev->pi[psec->id].admin_state_enabled)
 		regulator_disable(psec->ps);
-	devm_regulator_put(psec->ps);
+	regulator_put(psec->ps);
 
 	module_put(psec->pcdev->owner);
 
@@ -1436,8 +1436,8 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 
 	pcdev->pi[index].admin_state_enabled = ret;
-	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
-						rdev_get_name(pcdev->pi[index].rdev));
+	psec->ps = regulator_get_exclusive(pcdev->dev,
+					   rdev_get_name(pcdev->pi[index].rdev));
 	if (IS_ERR(psec->ps)) {
 		ret = PTR_ERR(psec->ps);
 		goto put_module;

base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
-- 
2.43.0

