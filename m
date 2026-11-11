Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431884;
	b=UMOd2xWauub68WZG48EpTQVnI6KBJXpJr4SAWwoKJFJm/HUdTfWvBxbF4VUg1QIwWgqO
	 BO5VZbWV/DFkLfaXYuL+vOCK8hS0aU/nsCyKRZlUK2R0e2pfVhY40qeBEVrvEEmuVnzK2
	 JVEVDQrXPi8FIVxZibWeaGu92wA+AEHw52XBiMXEJp0z89Sq/AXbCClPh9uHJDKAL1Zhk
	 N9yyxjuRIXjbcGxcctYIvcYp2KvSX6lCFpwuxsfbyk23GFGF4nPpC2vp8tcxqSrCN1s6X
	 +FBVG6C8rKMPx1u21OUJ6hx8VAwOXk6Cm7o3iYS21UZXSMhPUc5sonlsGgouDsVpJCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=kiIIOB/1cnxR2EISEEwYz1B5ntZjxJ1bIPc1p1OkhcI=;
	b=lYBqtqDovP3inw0AQ21MEEqNrbro1ezXcZJGjK0GRXpwh0EaGWz6vJ+nQygLQpNpHi1m
	 npzq6dWISmPKVcz/waxbrNWEsdV4AAoBljWfyxRHZT7dme0ftHXsydUACdHlUl6HT+206
	 hAXNaG3tHoO21iOJibuL147rO2PUMQBd8pWJ11lP0RWdORGoWiFiusX/VoRMZ5qpUUbzn
	 EaN7h9MrKm/BEZ2BC1Hn8V40Ym6KDjVNDpi3ja63llH+MzRYn/qCVh4rpb60mEVimozJB
	 yiYKXpkYApYIunrS86kQVj/C5GKT5UtyoXukqoQXfFO6YZlgDrPPUIgtvxICw6paGiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=FR+9KxOW;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39985606A8A9;
	Wed, 11 Nov 2026 21:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39985606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=FR+9KxOW
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 35CA9E8338C;
	Wed, 11 Nov 2026 22:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiIIOB/1cnxR2EISEEwYz1B5ntZjxJ1bIPc1p1OkhcI=;
	b=FR+9KxOWBfQKcE9myBo8SSFd33xX7LaN1QFH5nk8wsIa90+F82EpsfmCtDgy2phH1tp6XZ
	nmWskeTWTXWMgY5sLKZi1+K7URkb2aM7I0cjKsgRZVTywMt9r32OTPx26ghrIdD3KbJg9N
	hpPKxFYav5bFQzDv3ZM8sa3VGE9kF0DBS6JW4SuIS8BksWANwNdoQOk5QBuXeU75+am02W
	aFGKz8FmuByUQVdQSpi9BcBYu03rrG9ilWwYPfyQM3Ibd+OBgfW9nP+mY2KbNb+FsK4L5y
	eYTFpy2utkp6aWAKGiRMFGuvorDmi3jnbn3Z3DE7N4RVGEqZmy1PB4U2/X22aQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id DmB7twBem-qh; Wed, 11 Nov 2026 22:17:58 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:57 +0100 (CET)
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
Subject: [PATCH net v4 06/14] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Wed, 11 Nov 2026 22:17:23 +0100
Message-ID: <20261111211731.3193796-7-github@szelinsky.de>
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

pse_ethtool_set_pw_limit() checks whether the PI is powered without
pcdev->lock. pse_isr() changes that state under the lock, so if the PD
disconnects in between, budget is reserved for a port that is no longer
powered.

Do the check in pse_pi_update_pw_budget() under the lock, and report
whether the budget was changed, so the rollback after a failed
regulator_set_current_limit() runs only then. This also rolls back a
budget that started from zero, which the old code skipped.

Found by code inspection. Not reproduced.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 39 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 44bc6d557965..7fffe7e16f75 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1815,22 +1815,35 @@ EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
  * @pcdev: a pointer to the PSE controller device
  * @id: index of the PSE PI
  * @pw_req: power requested
+ * @updated: set to true if the budget was changed
  * @extack: extack for reporting useful error messages
  *
- * Return: Previous power allocated on success and failure value on error
+ * Return: Power allocated before the update, or a negative error code.
+ *	   0 is also returned when the budget was not changed, so callers
+ *	   check @updated before they roll back.
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
+	/* Only a PI under software power control that is enabled and has a
+	 * PD detected gets a budget. Check this here, as pse_isr() changes
+	 * it under the same lock.
+	 */
+	if (!pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d) ||
+	    !pi->admin_state_enabled || !pi->isr_pd_detected)
+		goto out;
+
 	previous_pw_allocated = pi->pw_allocated_mW;
 	pw_diff = pw_req - previous_pw_allocated;
 	if (!pw_diff) {
@@ -1848,6 +1861,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
 	}
 	pi->pw_allocated_mW = pw_req;
+	*updated = true;
 	ret = previous_pw_allocated;
 
 out:
@@ -1868,6 +1882,7 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     const unsigned int pw_limit)
 {
 	int uV, uA, ret, previous_pw_allocated = 0;
+	bool updated;
 	s64 tmp_64;
 
 	if (pw_limit > MAX_PI_PW)
@@ -1894,21 +1909,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
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

