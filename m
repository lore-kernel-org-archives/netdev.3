Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743367;
	b=ZsBQhg58ZYbfHri91v/IU8exQL/LZlT06ApKdoPYuv6AHj3/HJIEHcGUaj3HM1a5J6Nn
	 DeJy/yO8mKBABxXmDeBOBOZxnpoCqxOwoXlse5Dy3xjNCyF8EHSrtFe4sbSbaLyu/dgqE
	 YZw2OfKjyDy/qHt7AG46zGDE4tSJS6wuA67zwkO+FGGLRP/kAtB8Indjq40Twt3JFZdXR
	 EWIQvauklOuUDU7O5UxjrCKZQ8CHrXtl76W+PhC6bJby43trBTkLIOFHBaAKaKb0ndVJL
	 +YLXdoB1FD2UIQ5sOYnlreTSZDGXtW1w0gbwMpWm3XEbDOHOE57grm3ibC3h49YSVDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=u3TP6C2/VQ2llfYunw2C9o9UImrt1NKRcdTXyKESpy8=;
	b=BYYroJpYD+SAtbHWvIMR0uZGi4q49AHsZdplUjKIM8YvulSGDvvkgtX9Lo87hb+6EO4W
	 esVGNZc5DD3486hrnrI6Y8egT8sCSnm2at26jO2HplGnSLtFomAhT4PKnxNMJ4X57FQAp
	 YA7TQM0RxUz+8S/D46ZJHqQYltA8L43RbdHDxM/gwWhZ8VDrTw99xeqAGQFw+8j+aQYTH
	 MnkLAkM19FGPfp9iEAEvmaQ8vhubN+7EDMayj9qQS7TbWaefkdp4nPYdLZ7YL0TEVCwjL
	 DNRZaywJ4Ku/E7bG8t8fgcVye1PfbAWHB5twUWUMAIX9af02OkZv7K84ibUfcYn2drw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=XyufvOX2;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E17606D801;
	Tue,  3 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E17606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=XyufvOX2
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 9053AE836CD;
	Tue, 03 Nov 2026 23:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3TP6C2/VQ2llfYunw2C9o9UImrt1NKRcdTXyKESpy8=;
	b=XyufvOX2Ia6UI8akHW7HMnLup67alJYsnKpzwgT5r6TvGcE+8uZb5rwza+ZGkBF1I7gitH
	abgPc8SN2lPNFfRiwECRhdh4d2zwcvfMsEwduDPWNgWjuNyuNlE2Em/sUp98xqHWrf39ab
	CNKWjK3G+uWhmsMiuqQuOo0l+3i2x9duQXfXWgPK2LWKz3q1U2NGNdoAKc3Tx4Xxp6L58M
	ZmzjdTp5e84Omg8u9HZ2Sh/H2jHF42RePjDxhkVUVXy4p/tNIxEYgD/k56Ar0xtQmJM2Qy
	ql1I2ftzJG1hirnwunXWSrPtQGjXyOkGVLVIkyfei6EH2bNr6EXDm0e1DCTlSA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id IYKe3htW0UQV; Tue,  3 Nov 2026 23:02:41 +0100 (CET)
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
Subject: [PATCH net v3 07/14] net: pse-pd: do not tie a shared power domain to its creator's devres
Date: Tue,  3 Nov 2026 23:02:10 +0100
Message-ID: <20261103220217.1131971-8-github@szelinsky.de>
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

A power domain is shared by all controllers on the same supply and
counted with a kref, but it is devm memory of the controller that
created it. When that controller unbinds while another one still uses
the domain, devres frees it anyway, and the other controller and the
global map keep pointing at freed memory. The same happens when
pse_register_pw_ds() fails part way: the domains it already set up stay
in the map, and devres frees them.

Allocate the domain with kzalloc() and free it on its last kref_put().
If pse_register_pw_ds() fails, it now gives back every domain it took
while it still holds pse_pw_d_mutex, so no other controller can pick one
up first.

Because the domain can now be freed at the put, pse_flush_pw_ds() clears
pi[].pw_d under pcdev->lock before the put, and pse_ethtool_set_prio()
checks it under that lock. The PI regulator ops and pse_isr() use it
under the same lock.

Triggered in QEMU (arm64, KASAN) with two test-only PSE controllers
on one supply: after the one that created the domain unbinds, binding
it again gives

  BUG: KASAN: slab-use-after-free in pse_controller_register+0xb98/0x1274

With this patch it is gone.

Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 68 +++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 36f7dba8190a..113a34b09386 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -872,17 +872,41 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	return 0;
 }
 
-static void __pse_pw_d_release(struct kref *kref)
+/* Release for a put made with pse_pw_d_mutex already held. */
+static void pse_pw_d_release_locked(struct kref *kref)
 {
 	struct pse_power_domain *pw_d = container_of(kref,
 						     struct pse_power_domain,
 						     refcnt);
 
+	lockdep_assert_held(&pse_pw_d_mutex);
 	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
+	kfree(pw_d);
+}
+
+static void __pse_pw_d_release(struct kref *kref)
+{
+	pse_pw_d_release_locked(kref);
 	mutex_unlock(&pse_pw_d_mutex);
 }
 
+/* Clear pi[id].pw_d before the domain's reference is dropped. The PI
+ * regulator ops and pse_isr() hold pcdev->lock while they use it.
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
@@ -893,10 +917,11 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
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
 
@@ -906,24 +931,30 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 }
 
 /**
- * devm_pse_alloc_pw_d - allocate a new PSE power domain for a device
- * @dev: device that is registering this PSE power domain
+ * pse_alloc_pw_d - allocate a new PSE power domain
+ *
+ * A power domain is shared by every controller whose PIs sit on the same
+ * supply, so it must not be tied to the lifetime of the controller that
+ * happened to create it. It is freed by pse_pw_d_release_locked() on the
+ * last kref_put().
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
@@ -969,7 +1000,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 			continue;
 		}
 
-		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
+		pw_d = pse_alloc_pw_d();
 		if (IS_ERR(pw_d)) {
 			ret = PTR_ERR(pw_d);
 			goto out;
@@ -978,6 +1009,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		supply = regulator_get(&rdev->dev, rdev->supply_name);
 		if (IS_ERR(supply)) {
 			xa_erase(&pse_pw_d_map, pw_d->id);
+			kfree(pw_d);
 			ret = PTR_ERR(supply);
 			goto out;
 		}
@@ -992,6 +1024,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 	}
 
 out:
+	/* Undo this call's domains before another controller can find them */
+	while (ret && i--) {
+		struct pse_power_domain *pw_d = pse_pi_take_pw_d(pcdev, i);
+
+		if (pw_d)
+			kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
+	}
 	mutex_unlock(&pse_pw_d_mutex);
 	return ret;
 }
@@ -1949,15 +1988,16 @@ int pse_ethtool_set_prio(struct pse_control *psec,
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

