Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52883A962E;
	Sat, 11 Jul 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772744; cv=none; b=b8/ElCsx7JufED694pNfSjQNSu7ki5/cbNp80nlMZ3Ku+f+kmwqM0LC5Ia4bL8qxcWi6FVrmMjb8hX2OtrC05FwHjsVqdYfB2282YwcFyGiDlyCGSW63THGdMnpZv2H/s7PAw5J2NRabJreacQqAZe4x/R6cu0agGwhaFEEgu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772744; c=relaxed/simple;
	bh=1BYD95BQFWbcP4zPI/9XEVAOO2onxu53BCOR+yYThpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4wVhpR28VV6fJz25cURZua/x5v1TmDKMMxwEacpnc+wayT9Iu5JE3gNaMRYJbw7rN3S7X0/FW8wmLIQzJiQMD/1sMTl+uWLPP4mhi2ElQzx8RzSD/XymmXcsL0XmwVltAesUeuvP0VVWdLLjt0nhOlvysN5bw/HOXHeYnz0m0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=DTwS0Wzl; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="DTwS0Wzl"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id DF63AE83199;
	Sat, 11 Jul 2026 14:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1783772193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNGAV1bh7U8vqoPyuUhn5plMCzTy13ZH6hhnjNoPJyQ=;
	b=DTwS0WzlusgC+uQHijmG82+3/gRlJ6SvX5R4NELycHK/JP++J0dGzJTDZBx8olk8aQ1SwG
	16EM9WOpfCVRl+r4jfzKJr3uIhnr7bVBOlu9KO408qIxlvbbC9jvCgadgLW3TPPTOMav+S
	jLj+DKxtTO4gWMvUnDG2YhixB3FoGNnrjmb1D6c1zjgpz4LaB+UfdQZUB3Nukdj/bh8sLK
	brDburN0nw3TjrdgE42U86W3ZTvPjxp6Z7sx9A09rleCVjHPNPl5PKDs5sfGWUn7mueAPE
	w6yNjyvlOvHon4mAj7D9S1EWZXTHkwBqn5qGJiCK6kwb6g5g9xQmpahECsIVOg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 5a25KwGhOgok; Sat, 11 Jul 2026 14:16:33 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 11 Jul 2026 14:16:33 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against freed PI data during unregister
Date: Sat, 11 Jul 2026 14:16:11 +0200
Message-ID: <20260711121611.1639086-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260711121611.1639086-1-github@szelinsky.de>
References: <20260711121611.1639086-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PSE PI regulators are devm-registered inside pse_controller_register(),
which runs before devres_add() arms the controller's own release in
devm_pse_controller_register(). On driver detach devres unwinds in LIFO
order, so pse_controller_unregister() runs first and frees pcdev->pi via
pse_release_pis(); the regulators are torn down afterwards.

When regulator_unregister() flushes a pending disable, the regulator core
invokes pse_pi_disable(), which dereferences pcdev->pi[id] (directly and
via _pse_pi_disable() -> pse_pi_deallocate_pw_budget()). At that point the
PI array is already freed, so this is a use-after-free. pse_pi_enable()
and pse_pi_is_enabled() dereference pcdev->pi[id] the same way and are
reachable by any regulator consumer that keeps a handle across the
teardown window.

Clear pcdev->pi after freeing it and bail out of the three regulator ops
that dereference it when it is NULL. Perform the kfree() and NULL store in
pse_release_pis() under pcdev->lock, and read pcdev->pi under the same lock
in the ops, so the NULL an op observes is authoritative even when the free
runs concurrently on another CPU: the op either sees the live array or
returns without touching freed memory.

The other three regulator ops (pse_pi_get_voltage(),
pse_pi_get_current_limit(), pse_pi_set_current_limit()) do not dereference
pcdev->pi and need no guard.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 6045b6c399c2..21ccb5146616 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -144,7 +144,13 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 		of_node_put(pcdev->pi[i].pairset[1].np);
 		of_node_put(pcdev->pi[i].np);
 	}
+	/* Free under the lock so the NULL store is authoritative against
+	 * the regulator ops that read pcdev->pi under pcdev->lock.
+	 */
+	mutex_lock(&pcdev->lock);
 	kfree(pcdev->pi);
+	pcdev->pi = NULL;
+	mutex_unlock(&pcdev->lock);
 }
 
 /**
@@ -421,6 +427,11 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	/* Controller may be unregistered (pcdev->pi freed) mid-teardown. */
+	if (!pcdev->pi) {
+		ret = -ENODEV;
+		goto out;
+	}
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
 		ret = pcdev->pi[id].admin_state_enabled;
 		goto out;
@@ -674,6 +685,11 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	/* Controller may be unregistered (pcdev->pi freed) mid-teardown. */
+	if (!pcdev->pi) {
+		mutex_unlock(&pcdev->lock);
+		return -ENODEV;
+	}
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
 		/* Manage enabled status by software.
 		 * Real enable process will happen if a port is connected.
@@ -702,15 +718,20 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 static int pse_pi_disable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	struct pse_pi *pi;
 	int id, ret;
 
 	id = rdev_get_id(rdev);
-	pi = &pcdev->pi[id];
 	mutex_lock(&pcdev->lock);
+	/* Reached via the regulator core's deferred-disable flush after
+	 * pcdev->pi is freed on unregister.
+	 */
+	if (!pcdev->pi) {
+		mutex_unlock(&pcdev->lock);
+		return 0;
+	}
 	ret = _pse_pi_disable(pcdev, id);
 	if (!ret)
-		pi->admin_state_enabled = 0;
+		pcdev->pi[id].admin_state_enabled = 0;
 
 	mutex_unlock(&pcdev->lock);
 	return 0;
-- 
2.43.0

