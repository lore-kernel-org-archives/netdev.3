Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F023B63E;
	Sat, 20 Jun 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954728; cv=none; b=QuSEdpvu0zOM9b6QICreweFPG63BVM2nfKrO6laxuRT8OiJ+Lvli5AAYwwT8x1/0uyJajA7uaIEA4aH31se4NK5WflWhDvhKMHqt/OjTZa8mOIFh7Zscjy8/5nuJINWYmPMgnI9TI3xeaHbCmp5EpXqkJZakRBwoYgyUqrqCXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954728; c=relaxed/simple;
	bh=xC2c6x46nwoyHLo3yv4J3V+7eoNDWuxhiMLafw8euBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck+8ZRPrPOU13cynVJjmnP4wf6sFBSm/f/1i9tkCgrwW6fupBrqnDrVY8q4hJFskOgQB/3DlKctVhX6VIDl3LT/gJiAfB/fTbgxfr3KPZ3NN0N4AHlcW2RvhrmiRzz5GDm9zfGgv3rocDsYncadl5Qhpe4eRn43bCck8HGKS9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=QdUfuPh8; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="QdUfuPh8"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 6D438E8376F;
	Sat, 20 Jun 2026 13:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781954725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFI5fM5V2kWhCfbQgXoItwJOnglnpa8KAfRrVLMZTU4=;
	b=QdUfuPh8CP57toXk/7U0ViUGkjj5wqBx9c5eHF+YpTTB2o8Z+bEVxx9qHjs00vEFcIQ7Y9
	Nx7YygaiRIP/pN0MCkj9Y6Wt8dhiPLrFfi7i+zX9RqXXevdu7CrE9eYFVMct2NCrejTQvW
	Hq2bS4Sp5yWgmfI9/0pCMmBDjkqWEeaQnjKYJJllAuRrOfCPZ5dB+lLsFPHdkP/X39Kq7Q
	8IuW4BZOKHcR9QUvHTL93ST5zYgf8ceKabmuNeLAZ74u2vjYaHoiUuipSY6vSErF/TTZCc
	oJDjio60+d7s3naeE5ZpMezISER+W0fDubSQeNjJYwbAqddVetC/x87abosLQQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id iLQrpipqxuiy; Sat, 20 Jun 2026 13:25:25 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-002-205-089-174.002.205.pools.vodafone-ip.de [2.205.89.174])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 20 Jun 2026 13:25:24 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v2 1/4] net: pse-pd: scope pse_control regulator handle to kref lifetime
Date: Sat, 20 Jun 2026 13:24:37 +0200
Message-ID: <20260620112440.1734404-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620112440.1734404-1-github@szelinsky.de>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
 <20260620112440.1734404-1-github@szelinsky.de>
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
-- 
2.43.0

