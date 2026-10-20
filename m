Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516388;
	b=UVnDAVDXcibqyCTPrhb5ZLb7+Uis+uqPZ+VKBNG+P3gldSylw4LH/cxC/ScGKH/x/Lgm
	 028f46jmdOnXUgjQucRBVfYZQO8zoAy3CfLB/a8Mvg/GBcbpqFH1nkckTPdqmvbsD0+bX
	 7SEunaAkrQukDhfxwsuW33c44pAViyJvANPQyUZWR6adlRpHfKbarP90stAVvX6sNKJk8
	 lbMM41ZQglrTC2y+hamt1938QNi2eO/wpHBbhP7ByEvllHc3bWNwW99hU7JQBfHO7k5RE
	 R1Z7huFwhEA++fEb0+Wqzcd+6tUNBl10mS3MgONpRIG9VuYvrkRfJRziHbZ8y98eBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=3ffs6eo0/3Kek5SyN+dE668wPtVHDhz7rqyaGmIhPu8=;
	b=2dsZtK3sK3WYVPS/N5l9Rl3VDR2ul+PfhwlCZAr/NJvdoF8MoxWJlUyaMNsSq/gIqObH
	 n7KCxtwg3RvJ8k5j+4KzYbT/vVuVIE1Xl1DYBbtBFZTWMp18EGWW9CpxPMLz5+8VJfBBe
	 LX/xvoROgMBFiHlMe1K59BxwKjHKlsfU9/TIW86w2M+UGi/f79/AKZE8sI3dy2Pq9loLA
	 DCQUF+tLcA5J/H7US0a9kXgiBi3Z8EZyPIlcIbVeWPQTbzkDPuKCbXzhZtTSEpzlj1+jT
	 fmKOJVR/R1/S/POwTLHzTv97UVRch/XpleqdXlCqTnq6CUT+Dp55YY51658IOD4Ccrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=RvaeO2uh;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A560A2617;
	Tue, 20 Oct 2026 17:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 067A560A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=RvaeO2uh
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 86D64E833AD;
	Tue, 20 Oct 2026 19:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ffs6eo0/3Kek5SyN+dE668wPtVHDhz7rqyaGmIhPu8=;
	b=RvaeO2uh4ohEYxgsFAuwbUN+TdqtS8LpQn3e+4EYUbdOjNZAML7azJ4JzWlXgYZCTOMXEj
	m4R7PmmY/6pQGq7QN5PvmCrOV0e+dCJAk8TT907sUwqKZ7WpC1cCwDTPrUTHzSlcH8sJC0
	ioDMo2RC0zLly8/MugFuyLHlewwIf44UbLo2QX/JBuluj3whXaMmO+Cvoya7wJAGqak2dd
	d+vOPmFzP/eiM5kwUedXwnJjhvQMK+mlFWMHXXErZczO4A7Y6noA9vBngjeC7Is0IqstW5
	O2S6N/2dR58z0S8UXCiK2FlZqZon5NkyL5QzMlUErEh5+tD+ZIafcqe6svok6Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id bN9nTzKlq4aJ; Tue, 20 Oct 2026 19:13:05 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:05 +0200 (CEST)
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
Subject: [PATCH net v2 06/14] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Tue, 20 Oct 2026 19:12:41 +0200
Message-ID: <20261020171249.853085-7-github@szelinsky.de>
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

