Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9044725C;
	Sun, 18 Oct 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311824; cv=none; b=jR4BAlC1SwRmTQitBcqKeSEIKuHsJ63tYoWGnK9OhgWDWY5aOHLzsJylJgBuA+eJfZ6v/10XS1626d3whysUm1CGX9hrj/LxE2QeOUL0LkjnOuMjl6r3yBGCJcYxLRoC0Kvkzc/WiPUp+kwckRcpOmVVDlulCmCtXRm1VhiMtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311824; c=relaxed/simple;
	bh=YUo/zN/3RZEs7nmaCZ22pOebYRAvR1+pC6BDiDQMusY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAvoXBl04O0mHWF6IwQP+ogG+mBuoNjCZLqIFx8l4nETNVswjvC8eoExfRh3mCDP9N55EoC7BW6RfF5WBPFgVDiYkggBJ4J56aH2E0JeK9uyBO9/3w8e1NvXhBSuj4ajRiLn3YLJ1UyKZsGynlHGzEUA9KvesYgWbQN60Dvk2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=P5xg3qkP; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="P5xg3qkP"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 2E149E837CF;
	Sun, 18 Oct 2026 10:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHkXiJI+eFRB1X6sL11TJZ03CAbGu/zpd/MQeN0TyPg=;
	b=P5xg3qkPE3d6M6j56NiarJkkvUuG+/EmoXoA30PlDaGFSTnt8M95WWnXla21KGfdEtdapv
	K30XJz5mijoMU1CzbR20cZtJMiab2xlDiGEvJpu+ZPL+ICm2iwzq75jxfpBO9yaI5d2c78
	hv8j6PiJaGZ/a8nwaSJRc/b5RZKMKVuLICa29457aZj9RNIwf9qqz9St4+25HPIW6qRIrt
	yHvapY4Do/LGMsL8Dou06qOdAwLKMbjAzzbmLtFReZlbvbvSVogbySPT/r7tkgj5t9JDJ6
	zlvV2xqTmTs0DrGsgF1HDLgqS/Bg5sLI8Hb55hDcfL/lEFxwNJ7eVkjgxCgOgQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id huykmYiMkR9m; Sun, 18 Oct 2026 10:23:30 +0200 (CEST)
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
Subject: [PATCH net 06/10] net: pse-pd: do not tie a shared power domain to its creator's devres
Date: Sun, 18 Oct 2026 10:23:09 +0200
Message-ID: <20261018082314.48950-7-github@szelinsky.de>
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

A power domain is shared by all controllers on the same supply and
counted with a kref, but it is devm memory of the controller that
created it. When that controller unbinds while another one still uses
the domain, devres frees it anyway, and the other controller and the
global map keep pointing at freed memory. The same happens when
pse_register_pw_ds() fails part way.

Allocate the domain with kzalloc() and free it on its last kref_put().
A domain left over from a failed pse_register_pw_ds() is now leaked
instead of freed while still in the map.

Because the domain can now be freed at the put, pse_flush_pw_ds() clears
pi[].pw_d under pcdev->lock before the put, and pse_ethtool_set_prio()
checks it under that lock. The PI regulator ops and pse_isr() use it
under the same lock.

Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 43 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index d5f863834179..0d1e5d5039f8 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -886,6 +886,7 @@ static void __pse_pw_d_release(struct kref *kref)
 	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
 	mutex_unlock(&pse_pw_d_mutex);
+	kfree(pw_d);
 }
 
 /**
@@ -898,10 +899,18 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 	int i;
 
 	for (i = 0; i < pcdev->nr_lines; i++) {
-		if (!pcdev->pi[i].pw_d)
+		/* Clear it before the put that may free the domain. The PI
+		 * regulator ops and pse_isr() hold pcdev->lock while they
+		 * use it.
+		 */
+		mutex_lock(&pcdev->lock);
+		pw_d = pcdev->pi[i].pw_d;
+		pcdev->pi[i].pw_d = NULL;
+		mutex_unlock(&pcdev->lock);
+		if (!pw_d)
 			continue;
 
-		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
+		pw_d = xa_load(&pse_pw_d_map, pw_d->id);
 		if (!pw_d)
 			continue;
 
@@ -911,24 +920,30 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 }
 
 /**
- * devm_pse_alloc_pw_d - allocate a new PSE power domain for a device
- * @dev: device that is registering this PSE power domain
+ * pse_alloc_pw_d - allocate a new PSE power domain
+ *
+ * A power domain is shared by every controller whose PIs sit on the same
+ * supply, so it must not be tied to the lifetime of the controller that
+ * happened to create it. It is freed by __pse_pw_d_release() on the last
+ * kref_put().
  *
  * Return: Pointer to the newly allocated PSE power domain or error pointers
  */
-static struct pse_power_domain *devm_pse_alloc_pw_d(struct device *dev)
+static struct pse_power_domain *pse_alloc_pw_d(void)
 {
 	struct pse_power_domain *pw_d;
 	int index, ret;
 
-	pw_d = devm_kzalloc(dev, sizeof(*pw_d), GFP_KERNEL);
+	pw_d = kzalloc_obj(*pw_d);
 	if (!pw_d)
 		return ERR_PTR(-ENOMEM);
 
 	ret = xa_alloc(&pse_pw_d_map, &index, pw_d, XA_LIMIT(1, PSE_PW_D_LIMIT),
 		       GFP_KERNEL);
-	if (ret)
+	if (ret) {
+		kfree(pw_d);
 		return ERR_PTR(ret);
+	}
 
 	kref_init(&pw_d->refcnt);
 	pw_d->id = index;
@@ -974,7 +989,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 			continue;
 		}
 
-		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
+		pw_d = pse_alloc_pw_d();
 		if (IS_ERR(pw_d)) {
 			ret = PTR_ERR(pw_d);
 			goto out;
@@ -983,6 +998,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		supply = regulator_get(&rdev->dev, rdev->supply_name);
 		if (IS_ERR(supply)) {
 			xa_erase(&pse_pw_d_map, pw_d->id);
+			kfree(pw_d);
 			ret = PTR_ERR(supply);
 			goto out;
 		}
@@ -1954,15 +1970,16 @@ int pse_ethtool_set_prio(struct pse_control *psec,
 	const struct pse_controller_ops *ops;
 	int ret = 0;
 
-	if (!pcdev->pi[psec->id].pw_d) {
-		NL_SET_ERR_MSG(extack, "no power domain attached");
-		return -EOPNOTSUPP;
-	}
-
 	/* We don't want priority change in the middle of an
 	 * enable/disable call or a priority mode change
 	 */
 	mutex_lock(&pcdev->lock);
+	if (!pcdev->pi[psec->id].pw_d) {
+		NL_SET_ERR_MSG(extack, "no power domain attached");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	switch (pcdev->pi[psec->id].pw_d->budget_eval_strategy) {
 	case PSE_BUDGET_EVAL_STRAT_STATIC:
 		if (prio >= pcdev->nr_lines) {
-- 
2.43.0

