Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516389;
	b=x5DhHSKYc4qNnL+QetmI3ICZ80UIGmNRH+xB0+blWajPci6Z502GqyhDSDRgXBLher6s
	 ThmWPXRT3M1o4jKJFck1aCKhvJGVmCK3OcVAntW36CG1dsJ7lLSJYVeUPmA9yI0rA+Zqr
	 5olm5SIfCAW1neUpDcy5Dmicpp/TQdDBWrSIjf/5ukGCkXrtC5Zf3IPtoRCByYsoGfsGU
	 6orgnamE0UnsahsvSKWLbbBqG4mZDV2Ua4BTyG7QbcMDw9KNocThuukzSqb4gx1+ix1cj
	 lP4dZauLXk3fHHbwyifWkZ5ZB5Dj7MlzEn7zasMvh9R8eR8maBJuZ8jJKhPj1b3JeAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=nrsRYbRmbV72FFHEjmu8id91cfscbVysbyJojajg9QI=;
	b=HKGxzv/LANFGfaGmsS7GLUgrOR5f7yMg+fL59Ja7wlRx43txeQT6RA1YIs9Kvzg6uqPY
	 vdsH1jMj1TyLMGtf7jeOWCc4fgpz7VjTS1ShR45r2f4mx0T+6Wtl2XSLzWGMIcujLaR5p
	 9fAKh4XcJjtS+FKhXIsVz0Km99tBm32UKYYd6oFxpOxXaKOz/jZj+FIyoR5Oudk97tDB3
	 SsJgkEPW65s5XIiwjTLkpoumei82SdY7Ok/t2RQ4X7/Fs47jxB4kV9N/pMdN9pwoCnQL7
	 HXNzLHMSDcQIWOwKFjJOLViKtvEvRHbDBsaEfiUtVrUDZG1j90/HgmGsARxTkM6FF0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Dyr9Bus8;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114060A3823;
	Tue, 20 Oct 2026 17:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E114060A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Dyr9Bus8
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 74500E834D2;
	Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrsRYbRmbV72FFHEjmu8id91cfscbVysbyJojajg9QI=;
	b=Dyr9Bus8sZT18ZSmss8KHvI+Hx51bVaS2idq5r5IZu4D9iNgiaAqTqMqDgi60/Zb9m9sx8
	7ydJ50F/N8BS0AeVG/IYIJEI5WhBdS+Zp0kvLWYowx0XmWLkqehmM+dUkFWduh77VuEIWs
	UF6ISUTwRw+l4ePfw02Uy+uJQgHg7X2FY49Bp0R4gtBSB63ofa4lwuPwlQMUNAVYqcFP1q
	Koe4BSe74NRErz8PL8K6x3pAq07OI6uOqSR3n6UIFvAA83vhVBfdJKCxWyj4m8iBcg1jrR
	zbLsZ529fE0Ix82Pkwkn5/AHoWwQLw/DKoBPpQew+SgaP0FAj53JKFBMzjWGIQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Dlrs7dfzSs8z; Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
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
Subject: [PATCH net v2 12/14] net: pse-pd: use each PI's own supply handle for the power budget
Date: Tue, 20 Oct 2026 19:12:47 +0200
Message-ID: <20261020171249.853085-13-github@szelinsky.de>
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
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 61 ++++++++++++++++-------------------
 include/linux/pse-pd/pse.h    |  2 ++
 2 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 116ad2d1984a..15539dd75c08 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -45,16 +45,17 @@ struct pse_control {
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
@@ -442,7 +443,7 @@ static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
 	if (!pi->pw_d || !pi->pw_allocated_mW)
 		return;
 
-	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);
+	regulator_free_power_budget(pi->rdev->supply, pi->pw_allocated_mW);
 	pi->pw_allocated_mW = 0;
 }
 
@@ -555,7 +556,7 @@ pse_pi_allocate_pw_budget_static_prio(struct pse_controller_dev *pcdev, int id,
 	int ret, _prio;
 
 	_prio = pcdev->nr_lines;
-	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
+	while (regulator_request_power_budget(pi->rdev->supply, pw_req) == -ERANGE) {
 		if (_prio <= pi->prio) {
 			NL_SET_ERR_MSG_FMT(extack,
 					   "PI %d: not enough power budget available",
@@ -896,7 +897,6 @@ static void pse_pw_d_release_locked(struct kref *kref)
 						     struct pse_power_domain,
 						     refcnt);
 
-	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
 	kfree(pw_d);
 }
@@ -922,12 +922,6 @@ static void pse_pi_power_off(struct pse_controller_dev *pcdev, int id)
 	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
 }
 
-static void __pse_pw_d_release(struct kref *kref)
-{
-	pse_pw_d_release_locked(kref);
-	mutex_unlock(&pse_pw_d_mutex);
-}
-
 /* Switch off the PI, give back its budget and clear pi[id].pw_d before
  * the domain's reference is dropped. The PI regulator ops and pse_isr()
  * hold pcdev->lock while they use it.
@@ -946,6 +940,13 @@ pse_pi_take_pw_d(struct pse_controller_dev *pcdev, int id)
 	return pw_d;
 }
 
+/* Drop @pi from @pw_d, with pse_pw_d_mutex held */
+static void pse_pw_d_leave(struct pse_power_domain *pw_d, struct pse_pi *pi)
+{
+	list_del(&pi->pw_d_node);
+	kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
+}
+
 /**
  * pse_flush_pw_ds - flush all PSE power domains of a PSE
  * @pcdev: a pointer to the initialized PSE controller device
@@ -955,18 +956,13 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
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
@@ -1014,7 +1010,6 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		struct regulator_dev *rdev = pcdev->pi[i].rdev;
 		struct pse_power_domain *pw_d;
-		struct regulator *supply;
 		bool present = false;
 		unsigned long index;
 
@@ -1025,10 +1020,14 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
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
+			if (regulator_is_equal(pi->rdev->supply, rdev->supply)) {
 				present = true;
 				pcdev->pi[i].pw_d = pw_d;
 				break;
@@ -1036,6 +1035,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		}
 		if (present) {
 			kref_get(&pw_d->refcnt);
+			list_add_tail(&pcdev->pi[i].pw_d_node, &pw_d->pis);
 			continue;
 		}
 
@@ -1045,20 +1045,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
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
 
@@ -1068,7 +1061,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		struct pse_power_domain *pw_d = pse_pi_take_pw_d(pcdev, i);
 
 		if (pw_d)
-			kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
+			pse_pw_d_leave(pw_d, &pcdev->pi[i]);
 	}
 	mutex_unlock(&pse_pw_d_mutex);
 	return ret;
@@ -1962,7 +1955,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
 	if (!pw_diff) {
 		goto out;
 	} else if (pw_diff > 0) {
-		ret = regulator_request_power_budget(pi->pw_d->supply, pw_diff);
+		ret = regulator_request_power_budget(pi->rdev->supply, pw_diff);
 		if (ret) {
 			NL_SET_ERR_MSG_FMT(extack,
 					   "PI %d: not enough power budget available",
@@ -1971,7 +1964,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
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

