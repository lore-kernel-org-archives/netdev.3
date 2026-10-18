Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405E44AB86;
	Sun, 18 Oct 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311821; cv=none; b=gD4Fx++O/q5Gy+z2Yxj/fsAx/9AaqZN1E4e7XspHD3rlc1ZAG1BR2NVRviTk34tafnvMlNTZAw2HN1yn1o3+XkhyskFMSiqNGul0i1vha/SVXE0wEX6SbzzXgp7EaDyIFyyLvCXUcPdDVsh3naPQ2UPoBVr2FcnFSLLNUJdjpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311821; c=relaxed/simple;
	bh=nZB6Y9lG9Bc8NmGUsy2ytBekTmDK6Dk/LsB4AqpWN00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY5TRdm505RlYzI8D5mDGfK1xX1Mcrm88we4NJB4AmqjpO/Ru99oOiHw6s2cYBd6H/IGOcDfNH9SoQHABF9Txs2DGPKyz4nLM20AfQSJ6VuOEe2lryaQYJcc8IlKUqZBCnVhVTaEl9GM32WRyiGawk/6eASxdC4VBKZk2oP28lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=kXO3keWs; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="kXO3keWs"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D39F3E83954;
	Sun, 18 Oct 2026 10:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXdWggvi3IEEV6fLWYM+gwnO8jxdlys+8rSBqhiPczA=;
	b=kXO3keWsFzJk/6m3HK8tm/z6OgLWAbK02bTo326sA3ommZXIO9zXzYP2Ox4VSMMfpfKf7g
	ZLYnQ0RbdS2PCfEstS3n12LZQ359suqCe0ueaYYkmrJvZ5Z8sJTSyRFHNYvyD02M7fGQF7
	zvwerAYzxmN7MkbTQfv2s5SK1OgaWcdAYkqas9o/cSKgchRGpZKjX/3Z5xlw6vuiInZYzf
	UlAwwYXwSjkEKidR3wrkSiB2XJdIkRNWo/uEiRFq1tu1XSJuDehKmQUXiENZ7fqzh9U1SA
	lhIYROlLQMTf83/nrwK+oClCWGey03WFMOEBkDZztdRSRIeIjDYB2uMRRpoB8g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Sa7XTZ1SDBM6; Sun, 18 Oct 2026 10:23:30 +0200 (CEST)
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
Subject: [PATCH net 07/10] net: pse-pd: pd692x0: release the manager power budget through devres
Date: Sun, 18 Oct 2026 10:23:10 +0200
Message-ID: <20261018082314.48950-8-github@szelinsky.de>
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

pd692x0 reserves a power budget on each manager's supply in
setup_pi_matrix(), but gives it back only on that function's own errors
and in remove(). If probe fails later, or the request fails for one
manager after others succeeded, the budget stays reserved on vmain. Each
probe retry, e.g. after -EPROBE_DEFER, reserves it again until nothing
is left.

Release the budget from a devm action instead, and drop the explicit
release calls.

Fixes: 1c67f9c54cdc ("net: pse-pd: pd692x0: Fix power budget leak in manager setup error path")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pd692x0.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 209de9cec849..34f0dfbccd06 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1224,8 +1224,9 @@ static void pd692x0_of_put_managers(struct pd692x0_priv *priv,
 	}
 }
 
-static void pd692x0_managers_free_pw_budget(struct pd692x0_priv *priv)
+static void pd692x0_managers_free_pw_budget(void *data)
 {
+	struct pd692x0_priv *priv = data;
 	int i;
 
 	for (i = 0; i < PD692X0_MAX_MANAGERS; i++) {
@@ -1279,31 +1280,39 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	if (ret)
 		goto err_of_managers;
 
+	/* Frees whatever pd692x0_req_managers_pw_budget() manages to
+	 * request, on any later probe failure and on unbind. Added after
+	 * the manager regulators so that it runs before devres unregisters
+	 * them and their supply goes away.
+	 */
+	ret = devm_add_action_or_reset(&priv->client->dev,
+				       pd692x0_managers_free_pw_budget, priv);
+	if (ret)
+		goto err_of_managers;
+
 	ret = pd692x0_req_managers_pw_budget(priv);
 	if (ret)
 		goto err_of_managers;
 
 	ret = pd692x0_set_ports_matrix(priv, manager);
 	if (ret)
-		goto err_managers_req_pw;
+		goto err_of_managers;
 
 	/* Do not init the conf if it is already saved */
 	if (!priv->cfg_saved) {
 		ret = pd692x0_hw_conf_init(priv);
 		if (ret)
-			goto err_managers_req_pw;
+			goto err_of_managers;
 
 		ret = pd692x0_save_user_byte(priv);
 		if (ret)
-			goto err_managers_req_pw;
+			goto err_of_managers;
 	}
 
 	pd692x0_of_put_managers(priv, manager);
 	kfree(manager);
 	return 0;
 
-err_managers_req_pw:
-	pd692x0_managers_free_pw_budget(priv);
 err_of_managers:
 	pd692x0_of_put_managers(priv, manager);
 err_free_manager:
@@ -1855,7 +1864,6 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
 {
 	struct pd692x0_priv *priv = i2c_get_clientdata(client);
 
-	pd692x0_managers_free_pw_budget(priv);
 	firmware_upload_unregister(priv->fwl);
 }
 
-- 
2.43.0

