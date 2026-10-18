Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7B44AB8A;
	Sun, 18 Oct 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311564; cv=none; b=VHpVx89z8L1TWcDTuZjt2atwhaqcb9GpAT7cC6bcLrDo20qnDDn5rNakwZrbsqFUqbqDyq9r6hgJb/faPJN3xh+skRS2vGqPq+CzXEFoVgHMXsgyaBXBOlnJsxy1ZautNCFS8SwRft3nfgV2er+PhBOU9cRwluaRgvUMreLHJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311564; c=relaxed/simple;
	bh=3Ri2rKxKhwjQFCh52zUmWx47uY/7Fxn1fubW3ozYVZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbXIZz5u4pDaMGEHvSVT2hgH7dKF4kczzFpqdT//BTNS6EXjaylYhmTjqjZ/NVUTfqJlm4U5XTVecXUh5m3zA5OuUcsTrsoqP/O+SzPtHMK9y9kzpp/rFZjDDEWdnR8vQ5QkC2/mVkgaDXhVT1HYdHQ/6HAE0o98bGhnUPOl54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=C3M4A/6/; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="C3M4A/6/"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 72A20E83954;
	Sun, 18 Oct 2026 10:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42rf5e/wDlK3lddkIXnUVGbpxOPnk8rNMnb7i3WBUT4=;
	b=C3M4A/6/iT+AKtjxKqCJJ4mAIB5ye3gttoOfck7+VRxpCp2oo5WCIGnO/v4y6nrQVgFIk6
	VLXTONTBbVaH4YU1/T3kN4QAuiUaOkeQ0Qci1+vy9WptgPlVLoqcdMkNywPd/qHBy0av9S
	H7diTOWmCf0DNB25Sfhm7Gt1r/AGBOzsmj3LXEyaBsMFmynrm9hYPiZ4Szaoh9v+EUl3GM
	2gsj7EmqHS0Bmqph5t5U+bsLhRd09ScsJbySIdO6JvNG4TcDs94HHOYX9FO9domEE5yKDC
	huNgVDmBLVmdRBTy6ImJ0G1p7xHlkH9frvCXtmzE8KySVSasJDGJaYlNDl6A2w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id EBdZ3I1GGTjz; Sun, 18 Oct 2026 10:19:18 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:19:17 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Corey Leavitt <corey@leavitt.info>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next 2/4] net: pse-pd: unwind allocations when controller registration fails
Date: Sun, 18 Oct 2026 10:18:51 +0200
Message-ID: <20261018081853.47484-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
References: <20261018081853.47484-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pse_controller_register() fails, it leaks the notification kfifo,
the PI array and the OF node references. Worse, if pse_register_pw_ds()
fails part way, the power domains it created stay in the global map
while devres frees them, so the next controller that registers reads
freed memory. A later patch makes -EPROBE_DEFER a normal result here,
so this will happen more often.

Free what was allocated on each error path. The PI array is still
leaked once the PI regulators are registered, because their ops use it
until devres unregisters them.

pse_register_pw_ds() now undoes its own power domains while it still
holds pse_pw_d_mutex, so no other controller can pick one up just
before it is freed. pi[].pw_d is cleared under pcdev->lock before its
reference is dropped, and pse_ethtool_set_prio() and
pse_pi_update_pw_budget() now check it under that lock.

A power domain shared by two controllers is still devm memory of the
controller that created it; that is fixed separately on net.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---

Notes:
    Merging with the net fixes:
    - "net: pse-pd: do not tie a shared power domain to its creator's
      devres": move its kfree(pw_d) to the end of
      pse_pw_d_release_locked(), and name that function in its
      pse_alloc_pw_d() comment. In pse_flush_pw_ds(), keep this patch's
      pse_pi_take_pw_d() call.
    - "net: pse-pd: check the PI state under the lock when setting a power
      limit": in pse_pi_update_pw_budget(), keep the net fix's check.

 drivers/net/pse-pd/pse_core.c | 82 ++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 364acc025097..05b02d736931 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -878,7 +878,8 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	return 0;
 }
 
-static void __pse_pw_d_release(struct kref *kref)
+/* Release for a put made with pse_pw_d_mutex already held. */
+static void pse_pw_d_release_locked(struct kref *kref)
 {
 	struct pse_power_domain *pw_d = container_of(kref,
 						     struct pse_power_domain,
@@ -886,9 +887,30 @@ static void __pse_pw_d_release(struct kref *kref)
 
 	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
+}
+
+static void __pse_pw_d_release(struct kref *kref)
+{
+	pse_pw_d_release_locked(kref);
 	mutex_unlock(&pse_pw_d_mutex);
 }
 
+/* Clear pi[id].pw_d before its reference is dropped. The PI regulator
+ * ops hold pcdev->lock while they use it.
+ */
+static struct pse_power_domain *
+pse_pi_take_pw_d(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_power_domain *pw_d;
+
+	mutex_lock(&pcdev->lock);
+	pw_d = pcdev->pi[id].pw_d;
+	pcdev->pi[id].pw_d = NULL;
+	mutex_unlock(&pcdev->lock);
+
+	return pw_d;
+}
+
 /**
  * pse_flush_pw_ds - flush all PSE power domains of a PSE
  * @pcdev: a pointer to the initialized PSE controller device
@@ -899,10 +921,11 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 	int i;
 
 	for (i = 0; i < pcdev->nr_lines; i++) {
-		if (!pcdev->pi[i].pw_d)
+		pw_d = pse_pi_take_pw_d(pcdev, i);
+		if (!pw_d)
 			continue;
 
-		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
+		pw_d = xa_load(&pse_pw_d_map, pw_d->id);
 		if (!pw_d)
 			continue;
 
@@ -998,6 +1021,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 	}
 
 out:
+	/* Undo this call's domains before another controller can find them. */
+	while (ret && i--) {
+		struct pse_power_domain *pw_d = pse_pi_take_pw_d(pcdev, i);
+
+		if (pw_d)
+			kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
+	}
 	mutex_unlock(&pse_pw_d_mutex);
 	return ret;
 }
@@ -1058,17 +1088,18 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	    !pcdev->ops->pi_get_pw_status) {
 		dev_err(pcdev->dev,
 			"Mandatory status report callbacks are missing");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_kfifo;
 	}
 
 	ret = of_load_pse_pis(pcdev);
 	if (ret)
-		return ret;
+		goto free_kfifo;
 
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
-			return ret;
+			goto release_pis;
 	}
 
 	/* Each regulator name len is pcdev dev name + 7 char +
@@ -1076,7 +1107,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	 */
 	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
 
-	/* Register PI regulators */
+	/* Register PI regulators. Their ops index pcdev->pi[] until devres
+	 * unregisters them, so failures from here on must not free it.
+	 */
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		char *reg_name;
 
@@ -1085,26 +1118,38 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			continue;
 
 		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
-		if (!reg_name)
-			return -ENOMEM;
+		if (!reg_name) {
+			ret = -ENOMEM;
+			goto free_kfifo;
+		}
 
 		snprintf(reg_name, reg_name_len, "pse-%s_pi%d",
 			 dev_name(pcdev->dev), i);
 
 		ret = devm_pse_pi_regulator_register(pcdev, reg_name, i);
 		if (ret)
-			return ret;
+			goto free_kfifo;
 	}
 
 	ret = pse_register_pw_ds(pcdev);
 	if (ret)
-		return ret;
+		goto free_kfifo;
 
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
 
 	return 0;
+
+release_pis:
+	pse_release_pis(pcdev);
+	pcdev->pi = NULL;
+
+free_kfifo:
+	cancel_work_sync(&pcdev->ntf_work);
+	kfifo_free(&pcdev->ntf_fifo);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
@@ -1820,6 +1865,10 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 	 * power budget update
 	 */
 	mutex_lock(&pcdev->lock);
+	/* pi->pw_d may have been cleared since the caller looked. */
+	if (!pi->pw_d)
+		goto out;
+
 	previous_pw_allocated = pi->pw_allocated_mW;
 	pw_diff = pw_req - previous_pw_allocated;
 	if (!pw_diff) {
@@ -1921,15 +1970,16 @@ int pse_ethtool_set_prio(struct pse_control *psec,
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

