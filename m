Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743372;
	b=om4/v2eGshanhKp+swxdN0I7K1M+gKe3CTznkFQDt2LNMctIwifxRD4QHxOop977OI+8
	 fsBXfi9cW5JLFXJEFFY9asCjfo5h10ryCp7gFdEb5aRACXpA4w+ARO41uADC5Fo44y/8D
	 hSyl6C2NyDfJ/0G8lxBMYx6e5PskbS++jdqMvYT5p2TuMzFBrKawUThBkdQwyuMayAe3/
	 O6QBcGheC6Z1ofXqveiGMdrilAs2CsEBhJsValEMMLQJakdQ5r5v+gA90CCpQGx9kq8p5
	 0XppuMrYq510DrOmSLn1UkYPL+5D4YBtFbGzGDesej+BWdsQCyIg5Hy9Wkjr27RVzyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SGtFkREWxsGryEssSbCgHHjdQsaiEiHWLSBK1KX+6rg=;
	b=BymxMhd2gtQ8jQlKlbr/qh9FvYC5I6Wd8Zwn3XsiyetTt4anjmQlfmtNlfTRzn8hhruN
	 U59W2vKPFVVMOo0qVZOJktzCtZ/QTb4QWY0pleo+hHp58R2WrnvW0U380kf2UHiATtg02
	 HU8+GPQbhk/3ZZ0mYmNCfSKaevtEKtzfei66hkFh9b0YZMNM0h2YECWv+inn9aqlRzV9J
	 mlG9xaqIVGhnxrF4gGQHUGg5CVr76F1xbmSVwHeHIFwG1740lpJhTFfzVaQVhtu4CRiT/
	 cRns3LK/yye+rJPTW39r1clzTkiHg57cul7l/QzjQTd4PDoPy+oORrv+E3KSIOU481w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=bqPYCimX;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43910606A33C;
	Tue,  3 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43910606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=bqPYCimX
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D50AEE836CC;
	Tue, 03 Nov 2026 23:02:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGtFkREWxsGryEssSbCgHHjdQsaiEiHWLSBK1KX+6rg=;
	b=bqPYCimX6xNmyaBluJx/DTzj3PsQ6/cMSi1rcr+MZqIFyObQ8tJf0MzXM3d7XvB1zSjcT8
	Iz1Ir3H38fUqkkfIgkEi/FbUKxCkTqT8wzrZMrMdwzQLe/Qk57bl9n9nYUny+oMxh7SmrP
	Kq0NEQZBj17Hvj4GCv8VZAY8zs8QYzVPfXri3Kc2JMQyg3xjQjx+96yRiftN0ezMHiENds
	jM4N8uysikHhvsMuXv3NUJEQvCM2LiReNtKPEORRhUs3pk8CNVaqMvoPvXYeC9m0bdGWUm
	5ZCp4YhA2pjt3TyoHwxUJWF1XrYKxrKDLhcrnJV+y9Wli1N/zPlbPEpYP8gQKw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 9Ck90SICAXAz; Tue,  3 Nov 2026 23:02:40 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:40 +0100 (CET)
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
Subject: [PATCH net v3 06/14] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Tue,  3 Nov 2026 23:02:09 +0100
Message-ID: <20261103220217.1131971-7-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103220217.1131971-1-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
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
index af9eb2979270..36f7dba8190a 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1821,22 +1821,35 @@ EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
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
@@ -1854,6 +1867,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
 	}
 	pi->pw_allocated_mW = pw_req;
+	*updated = true;
 	ret = previous_pw_allocated;
 
 out:
@@ -1874,6 +1888,7 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     const unsigned int pw_limit)
 {
 	int uV, uA, ret, previous_pw_allocated = 0;
+	bool updated;
 	s64 tmp_64;
 
 	if (pw_limit > MAX_PI_PW)
@@ -1900,21 +1915,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
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

