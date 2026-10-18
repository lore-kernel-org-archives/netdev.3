Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67975455182;
	Sun, 18 Oct 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311813; cv=none; b=l8lnIKcRwbS8Gm6xh26zePlVk/HQZSd88WdKVkKRapXrU7ae7AJxQN4t8CMcBZz0UC8HnScOkOTyC3r8Ou4fowMomR7VOFY8LQvmmrZUBOniE7JqsUvgGdkXpUiG9K21RCbSYv+iuq9pFQwDPfXD5moKh8QiKZiQuAeJRHZn+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311813; c=relaxed/simple;
	bh=QOII+y85ixHBCVoY/RuBEKLnZzzHYTRfPpQAu2NE6TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ5cXhVTjICk2WfCubJsRvvHExmf9+6sWYgGSxQ8uNhAVaO8D9XsyM6zXPOKWGSSmXWuwLLJxYJ9RT0p1dSF1hF4WuUtd2PNZnzm7UBWSWkjfZuzx6NK4usK8pfG7/efRXbFv55xhGcjKoqGyuWHiaW2iEo5MTUcfpq68Pd/r94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=TsY7wPP2; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="TsY7wPP2"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 8E45DE83969;
	Sun, 18 Oct 2026 10:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ9hY9K1REuLJZqLsBtNJlIn/SEiHET4Vc/YADNGixg=;
	b=TsY7wPP26e4ssxE7TvJTWFgfmBcM+0O1gLstp1EmGTD7LN0+spPgqX7ekwKqaTbdGg+JwD
	A3XvHCDkbk1A1bEdUflN7Zte/4BouPSLzeFqfJ426CSeh5eIYMNcCCAa5NctI4CtCDPrMH
	hozITfQZjdKyZJqv27iZlX0DhmTPZNyLBZ2GU5xLfjdPunduXlHgIzoM79TUZo23GLakvf
	7YTZxzLbQwGVVl7LkNobw6kI2+XRvOk1pTAHNr0rNNDdE0Q3VZ7Svr6pK5lK+tlNl8GgwP
	2B2Ko0/xzHVzPirBm1BsHvS4ZejOmyMyMmAelbWJc/N58j8qRPjYUsQmcOV6Ig==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id S88pM3RqlEbN; Sun, 18 Oct 2026 10:23:29 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:29 +0200 (CEST)
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
Subject: [PATCH net 05/10] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Sun, 18 Oct 2026 10:23:08 +0200
Message-ID: <20261018082314.48950-6-github@szelinsky.de>
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

pse_ethtool_set_pw_limit() checks whether the PI is powered without
pcdev->lock. pse_isr() changes that state under the lock, so if the PD
disconnects in between, budget is reserved for a port that is no longer
powered.

Do the check in pse_pi_update_pw_budget() under the lock, and report
whether the budget was changed, so the rollback after a failed
regulator_set_current_limit() runs only then. This also rolls back a
budget that started from zero, which the old code skipped.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 336f00d82b5f..d5f863834179 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1829,22 +1829,32 @@ EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
  * @pcdev: a pointer to the PSE controller device
  * @id: index of the PSE PI
  * @pw_req: power requested
+ * @updated: set to true if the budget was changed
  * @extack: extack for reporting useful error messages
  *
  * Return: Previous power allocated on success and failure value on error
  */
 static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
-				   const unsigned int pw_req,
+				   const unsigned int pw_req, bool *updated,
 				   struct netlink_ext_ack *extack)
 {
 	struct pse_pi *pi = &pcdev->pi[id];
 	int previous_pw_allocated;
 	int pw_diff, ret = 0;
 
+	*updated = false;
+
 	/* We don't want pw_allocated_mW value change in the middle of an
 	 * power budget update
 	 */
 	mutex_lock(&pcdev->lock);
+	/* Only a powered PI under software power control holds a budget.
+	 * Check it here, as pse_isr() changes it under the same lock.
+	 */
+	if (!pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d) ||
+	    !pi->admin_state_enabled || !pi->isr_pd_detected)
+		goto out;
+
 	previous_pw_allocated = pi->pw_allocated_mW;
 	pw_diff = pw_req - previous_pw_allocated;
 	if (!pw_diff) {
@@ -1862,6 +1872,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
 	}
 	pi->pw_allocated_mW = pw_req;
+	*updated = true;
 	ret = previous_pw_allocated;
 
 out:
@@ -1882,6 +1893,7 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     const unsigned int pw_limit)
 {
 	int uV, uA, ret, previous_pw_allocated = 0;
+	bool updated;
 	s64 tmp_64;
 
 	if (pw_limit > MAX_PI_PW)
@@ -1908,21 +1920,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	/* Update power budget only in software power control case and
 	 * if a Power Device is powered.
 	 */
-	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
-				      psec->pcdev->pi[psec->id].pw_d) &&
-	    psec->pcdev->pi[psec->id].admin_state_enabled &&
-	    psec->pcdev->pi[psec->id].isr_pd_detected) {
-		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
-					      pw_limit, extack);
-		if (ret < 0)
-			return ret;
-		previous_pw_allocated = ret;
-	}
+	ret = pse_pi_update_pw_budget(psec->pcdev, psec->id, pw_limit,
+				      &updated, extack);
+	if (ret < 0)
+		return ret;
+	previous_pw_allocated = ret;
 
 	ret = regulator_set_current_limit(psec->ps, 0, uA);
-	if (ret < 0 && previous_pw_allocated) {
+	if (ret < 0 && updated) {
 		pse_pi_update_pw_budget(psec->pcdev, psec->id,
-					previous_pw_allocated, extack);
+					previous_pw_allocated, &updated,
+					extack);
 	}
 
 	return ret;
-- 
2.43.0

