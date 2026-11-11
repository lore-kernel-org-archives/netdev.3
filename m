Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431886;
	b=ascZ95uxN8qywymfQtAHROtTq0axu0erGiRgh2wYuMz/VsV7x1+DMcVOFhUm0WDgG5z9
	 W51SGM9JPNrgIwpYNscN+ELmTeb/VvfkkIth76faXd4VSZfHQhjX+zPOoKAd94a2wrR4Y
	 bdtRccj16rOKd8z3toV85V3ix/2w8PIZREozQrSzOUeZC0/jmk1ciBrHSDqrxfwXexsAp
	 Y2PB3+FHGD98aV91o04t4ulihZoGWcqw8kZALucFHDqgpeWCQ8Uhe66rzH13WUyhFeMzr
	 XPPIa6ObYny+F/IbP3E3V7tBqcvd8IYMOgG6mAidTLTA+Lso/VCjzb/KTuDUOKS8qwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=wBLeHhcB3+2fe6YlLegPD97cbtXOEzul4qQVaNB5N1o=;
	b=bJGK2ZuCAw/AbmV+n6ZZTZDie8OeRNaj3hxJtMqw1i3mdNOq9W7WSUfr/mgFJs2URKKX
	 Yj1VLmt+1HbL+LWxesTaVW0Pdg+nkwkYwDbJ+DMZE+PeqkKsd/vm1+NJ9idk+KH0MEW5f
	 8grySCamTcVEnL9nlOh7YzPmJ/auIgA7Tw+heCw6F3kUJZcQnqyY52zgt5OWnTYkJpHug
	 8j8CkW245k1q1eRZP+0FLZ7BUMPedG/RJm9dDYhsUljyTlCNT4JPw5Vyam+01xqY8nAOB
	 cwxTT8PNsCvScj79ZbhUDJauz9BeRv3GE9wavFPeVW1y6dU1s7Wg9BN0f+i18DfaIlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b="ZV2/Plbe";
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0A60A3806;
	Wed, 11 Nov 2026 21:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD0A60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ZV2/Plbe
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 21C1CE83237;
	Wed, 11 Nov 2026 22:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBLeHhcB3+2fe6YlLegPD97cbtXOEzul4qQVaNB5N1o=;
	b=ZV2/Plbeu12dqraNq39GKnqkiAz0zUC4465ynC1UhB3KnGGkObtMyj8IFzG6LQuue1KB+M
	lnQrZ79XKw9xt4F6RnWajzuRrSEBj/j9p43dvN1Gr6e5yjGIgxFLb9IrP4G8hfIjyAqs+Y
	Df2O2etvQTQHPDX4KZLzfvyIV2WjiAZ9xh2yorkQlQEtS6jWfPIuYxWMjMKA5xm8bT/uXB
	9bDDJlR4+aMtHek0R5Aw4+SXOeqQq10XzYiXM8HVRCDjent4taqYmBjR4mXqids1maDung
	yp++lqD4AeSTkoox2qQnc2/HUSaRFZa/Oe0qjNL028TqjtCHig/Jy3VCd9IZ4w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 7nP_UB0WbOin; Wed, 11 Nov 2026 22:18:04 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:18:03 +0100 (CET)
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
Subject: [PATCH net v4 12/14] net: pse-pd: use each PI's own supply handle for the power budget
Date: Wed, 11 Nov 2026 22:17:29 +0100
Message-ID: <20261111211731.3193796-13-github@szelinsky.de>
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

A power domain shared by several controllers holds one supply handle.
Its consumer device is a PI regulator of the controller that created
the domain. When that controller unbinds, devres frees the regulator,
but the other controllers still use the domain and its handle, which
now points at a freed device. Reading the regulator summary in debugfs
then reads freed memory.

The domain does not need a handle of its own. The budget is counted in
the supply's regulator_dev, and each PI regulator already holds a
handle to that supply, which lives as long as the PI regulator. Use
that handle for the budget, and drop the domain's handle.
pse_flush_pw_ds() clears a PI's pw_d before devres unregisters the PI
regulator, so the budget is never used through a handle that is gone.

To find the domain of a new PI, compare its supply with the supply of a
PI already in the domain. For this, keep a list of the PIs of each
domain under pse_pw_d_mutex, which pse_flush_pw_ds() now holds for its
whole loop.

Triggered in QEMU (arm64, KASAN) with two test-only PSE controllers on
one supply: after the one that created the domain unbinds, reading
/sys/kernel/debug/regulator/regulator_summary gives

  BUG: KASAN: slab-use-after-free in regulator_summary_show_subtree+0x770/0x9c4

With this patch the report is gone. A second test, where one controller
changes its power limit in a loop while the other one unbinds, is clean
too.

Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 70 +++++++++++++++++------------------
 include/linux/pse-pd/pse.h    |  2 +
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f5a44e17cbec..9a222d469da5 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -47,16 +47,17 @@ struct pse_control {
 /**
  * struct pse_power_domain - a PSE power domain
  * @id: ID of the power domain
- * @supply: Power supply the Power Domain
  * @refcnt: Number of gets of this pse_power_domain
  * @budget_eval_strategy: Current power budget evaluation strategy of the
  *			  power domain
+ * @pis: PIs that use the power domain, under pse_pw_d_mutex. The supply
+ *	 handles of their regulators all point at the same supply.
  */
 struct pse_power_domain {
 	int id;
-	struct regulator *supply;
 	struct kref refcnt;
 	u32 budget_eval_strategy;
+	struct list_head pis;
 };
 
 static int of_load_single_pse_pi_pairset(struct device_node *node,
@@ -446,7 +447,7 @@ static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
 	if (!pi->pw_d || !pi->pw_allocated_mW)
 		return;
 
-	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);
+	regulator_free_power_budget(pi->rdev->supply, pi->pw_allocated_mW);
 	pi->pw_allocated_mW = 0;
 }
 
@@ -559,7 +560,8 @@ pse_pi_allocate_pw_budget_static_prio(struct pse_controller_dev *pcdev, int id,
 	int ret, _prio;
 
 	_prio = pcdev->nr_lines;
-	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
+	while (regulator_request_power_budget(pi->rdev->supply, pw_req) ==
+	       -ERANGE) {
 		if (_prio <= pi->prio) {
 			NL_SET_ERR_MSG_FMT(extack,
 					   "PI %d: not enough power budget available",
@@ -894,24 +896,17 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 }
 
 /* Release for a put made with pse_pw_d_mutex already held. */
-static void pse_pw_d_release_locked(struct kref *kref)
+static void pse_pw_d_release(struct kref *kref)
 {
 	struct pse_power_domain *pw_d = container_of(kref,
 						     struct pse_power_domain,
 						     refcnt);
 
 	lockdep_assert_held(&pse_pw_d_mutex);
-	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
 	kfree(pw_d);
 }
 
-static void __pse_pw_d_release(struct kref *kref)
-{
-	pse_pw_d_release_locked(kref);
-	mutex_unlock(&pse_pw_d_mutex);
-}
-
 /* Clear pi[id].pw_d before the domain's reference is dropped. The PI
  * regulator ops and pse_isr() hold pcdev->lock while they use it.
  */
@@ -928,6 +923,14 @@ pse_pi_take_pw_d(struct pse_controller_dev *pcdev, int id)
 	return pw_d;
 }
 
+/* Drop @pi from @pw_d, with pse_pw_d_mutex held */
+static void pse_pw_d_leave(struct pse_power_domain *pw_d, struct pse_pi *pi)
+{
+	lockdep_assert_held(&pse_pw_d_mutex);
+	list_del(&pi->pw_d_node);
+	kref_put(&pw_d->refcnt, pse_pw_d_release);
+}
+
 /**
  * pse_flush_pw_ds - flush all PSE power domains of a PSE
  * @pcdev: a pointer to the initialized PSE controller device
@@ -937,18 +940,13 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 	struct pse_power_domain *pw_d;
 	int i;
 
+	mutex_lock(&pse_pw_d_mutex);
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		pw_d = pse_pi_take_pw_d(pcdev, i);
-		if (!pw_d)
-			continue;
-
-		pw_d = xa_load(&pse_pw_d_map, pw_d->id);
-		if (!pw_d)
-			continue;
-
-		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
-			       &pse_pw_d_mutex);
+		if (pw_d)
+			pse_pw_d_leave(pw_d, &pcdev->pi[i]);
 	}
+	mutex_unlock(&pse_pw_d_mutex);
 }
 
 /**
@@ -956,8 +954,8 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
  *
  * A power domain is shared by every controller whose PIs sit on the same
  * supply, so it must not be tied to the lifetime of the controller that
- * happened to create it. It is freed by pse_pw_d_release_locked() on the
- * last kref_put().
+ * happened to create it. It is freed by pse_pw_d_release() on the last
+ * kref_put().
  *
  * Return: Pointer to the newly allocated PSE power domain or error pointers
  */
@@ -996,7 +994,6 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		struct regulator_dev *rdev = pcdev->pi[i].rdev;
 		struct pse_power_domain *pw_d;
-		struct regulator *supply;
 		bool present = false;
 		unsigned long index;
 
@@ -1007,10 +1004,15 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 			continue;
 
 		xa_for_each(&pse_pw_d_map, index, pw_d) {
+			struct pse_pi *pi = list_first_entry(&pw_d->pis,
+							     struct pse_pi,
+							     pw_d_node);
+
 			/* Power supply already registered as a PSE power
 			 * domain.
 			 */
-			if (regulator_is_equal(pw_d->supply, rdev->supply)) {
+			if (regulator_is_equal(pi->rdev->supply,
+					       rdev->supply)) {
 				present = true;
 				pcdev->pi[i].pw_d = pw_d;
 				break;
@@ -1018,6 +1020,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		}
 		if (present) {
 			kref_get(&pw_d->refcnt);
+			list_add_tail(&pcdev->pi[i].pw_d_node, &pw_d->pis);
 			continue;
 		}
 
@@ -1027,20 +1030,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 			goto out;
 		}
 
-		supply = regulator_get(&rdev->dev, rdev->supply_name);
-		if (IS_ERR(supply)) {
-			xa_erase(&pse_pw_d_map, pw_d->id);
-			kfree(pw_d);
-			ret = PTR_ERR(supply);
-			goto out;
-		}
-
-		pw_d->supply = supply;
 		if (pcdev->supp_budget_eval_strategies)
 			pw_d->budget_eval_strategy = pcdev->supp_budget_eval_strategies;
 		else
 			pw_d->budget_eval_strategy = PSE_BUDGET_EVAL_STRAT_DISABLED;
 		kref_init(&pw_d->refcnt);
+		INIT_LIST_HEAD(&pw_d->pis);
+		list_add_tail(&pcdev->pi[i].pw_d_node, &pw_d->pis);
 		pcdev->pi[i].pw_d = pw_d;
 	}
 
@@ -1050,7 +1046,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		struct pse_power_domain *pw_d = pse_pi_take_pw_d(pcdev, i);
 
 		if (pw_d)
-			kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
+			pse_pw_d_leave(pw_d, &pcdev->pi[i]);
 	}
 	mutex_unlock(&pse_pw_d_mutex);
 	return ret;
@@ -1935,7 +1931,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 	if (!pw_diff) {
 		goto out;
 	} else if (pw_diff > 0) {
-		ret = regulator_request_power_budget(pi->pw_d->supply, pw_diff);
+		ret = regulator_request_power_budget(pi->rdev->supply, pw_diff);
 		if (ret) {
 			NL_SET_ERR_MSG_FMT(extack,
 					   "PI %d: not enough power budget available",
@@ -1944,7 +1940,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 		}
 
 	} else {
-		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
+		regulator_free_power_budget(pi->rdev->supply, -pw_diff);
 	}
 	pi->pw_allocated_mW = pw_req;
 	*updated = true;
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index a917ac32dc0c..17738ffcd224 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -247,6 +247,7 @@ struct pse_pi_pairset {
  * @rdev: regulator represented by the PSE PI
  * @admin_state_enabled: PI enabled state
  * @pw_d: Power domain of the PSE PI
+ * @pw_d_node: entry in the list of PIs that use @pw_d
  * @prio: Priority of the PSE PI. Used in static budget evaluation strategy
  * @isr_pd_detected: PSE PI detection status managed by the interruption
  *		     handler. This variable is relevant when the power enabled
@@ -261,6 +262,7 @@ struct pse_pi {
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
 	struct pse_power_domain *pw_d;
+	struct list_head pw_d_node;
 	int prio;
 	bool isr_pd_detected;
 	int pw_allocated_mW;
-- 
2.43.0

