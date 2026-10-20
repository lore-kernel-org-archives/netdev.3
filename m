Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516387;
	b=3y4uru8OvzPpwT3o4/11lzZz2CeHy9fEW0tCkcYJTTSfau2GLr29LcD6x0tyqhazPsHa
	 3HN7w9GLmqSEin3xvZWFBWxeGla+INIYdwhjSDM/NXsZLMzkQ3Nc1h8WVKuIz7E2OHLe+
	 6G95DhQpdH8WPv7D0aqy7kmHt1qoh4CoVwg0/i8Bw98eoRziw6YXo14XUw0SXX08efVSV
	 lwJSAca8ukoqm4/mbUt8Xg2WKoB2PG3Qqu/4vhTTTE7u4uT3hvT3VcKGfvuiIJpjAvuck
	 DObwtnA0ipy9PWCElFeh/V2FLAfmHCIxhd9k/aVRerdgoW1QldZCAo4Zt6X4JS6C2nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=96/wQf5+BkxG3hEpfXNPQepn/kV8t1CBHlLhylrW2Fo=;
	b=xl5HYC9ZCEuAKO2RumyXEdt+/oqaMHUx7/pOjRdBFZ2QZKG3VMSvYbU+FtL1aLt9I0J7
	 tYEpiCzyIJteCqOA1tqGLiSScvFpYhQ2PCwmmTqgengXq8FhFEVm5dXigu+YjxeHqFoqA
	 ubbVt5/wOunsqTcGALuSm9TagSonhCAJzPxt/uq6XQ+HGG0a6TCXfOMmBowVzqJrtDn01
	 rLUqgxIuohDm0JK/EnvlLbGArcbAJ0l5k6pZMH7x4rTFUVygV/XF5BGJeu4662KM+NRqU
	 DOaQPGWyo3yqVxnInwanC8VRvAnN6QQYIPCIwBxba1neW4eeNZeF/oTm1hCmhE/m7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=c5OQpLQl;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1B606A31E;
	Tue, 20 Oct 2026 17:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F1B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=c5OQpLQl
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id CE78AE82FDA;
	Tue, 20 Oct 2026 19:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96/wQf5+BkxG3hEpfXNPQepn/kV8t1CBHlLhylrW2Fo=;
	b=c5OQpLQl0kQt/S4AvG5+HEsmbFVHzWSJWLLX20OlKdmwpiMDyc9twTtZki8dswZsBjkxlR
	0baD54yizMtBCrnbaYUI6RwRDEySYI54/swpNezyOgtA1DxVizH6bAIFGMnfiYWwg28ckc
	Dlr8p9sxog4HHgxqo3LNEfjs1AY9jUuTIhflI0x4MVasS+0WVUnHbg/B+Ez7BK8DNw1iqX
	2b6rw8T1aVoSXcQKsyKE6HkmpwaALhp004Pfl9EuBbzBXTNsfnGgidtjbiOihE7ld9kdBZ
	gtYWP3co/0IP9NHEKG34ZF5uLcapN2yslBzubjwseR+IIG/Hi1z27v1kfVOCcQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 8QIOrh6ioTUP; Tue, 20 Oct 2026 19:13:05 +0200 (CEST)
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
Subject: [PATCH net v2 07/14] net: pse-pd: do not tie a shared power domain to its creator's devres
Date: Tue, 20 Oct 2026 19:12:42 +0200
Message-ID: <20261020171249.853085-8-github@szelinsky.de>
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

Triggered in QEMU (arm64, KASAN) with two test-only PSE controllers
on one supply: after the one that created the domain unbinds, binding
it again gives

  BUG: KASAN: slab-use-after-free in pse_controller_register+0xb98/0x1274

With this patch it is gone.

Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 43 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 36f7dba8190a..13d6bd29525f 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -881,6 +881,7 @@ static void __pse_pw_d_release(struct kref *kref)
 	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
 	mutex_unlock(&pse_pw_d_mutex);
+	kfree(pw_d);
 }
 
 /**
@@ -893,10 +894,18 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
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
 
@@ -906,24 +915,30 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
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
@@ -969,7 +984,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 			continue;
 		}
 
-		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
+		pw_d = pse_alloc_pw_d();
 		if (IS_ERR(pw_d)) {
 			ret = PTR_ERR(pw_d);
 			goto out;
@@ -978,6 +993,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
 		supply = regulator_get(&rdev->dev, rdev->supply_name);
 		if (IS_ERR(supply)) {
 			xa_erase(&pse_pw_d_map, pw_d->id);
+			kfree(pw_d);
 			ret = PTR_ERR(supply);
 			goto out;
 		}
@@ -1949,15 +1965,16 @@ int pse_ethtool_set_prio(struct pse_control *psec,
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

