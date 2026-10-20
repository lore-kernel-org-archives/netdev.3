Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516388;
	b=ChVvu5LDXfRXGDJbk6VIWbryeK90jb4k44PUC091h2sNBl1/u1KF1uCIy8fsv0uaDaOs
	 VkGB/2BWOF2DSPCajGFdQtV3RkNh4werPO2rBvjt2cYtY0WrGMFmMpV1MR+dDMscCc11w
	 b9aVzSx376Vuk2QUzTWKdOH6FbqPymb51y7WyRR70ZQOLDAgloB1hizAJ3JJcgwpAhnV/
	 KHjap2MNaK94rjWEemzjBKpI8iy9WIMICJVnOzI5JCZXyN/p8FPkyCGb3aoLTrYjStA4U
	 LLYV0zTNVt22RGBsmBDmj3Ip4cuakqQZN73zzJmwVZAuEGt+BGVWIUej1RGjJBEJncQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=yoGZEdpd5KxWW4t8I7AGYoavg6VSIUlABq18dwWdqTI=;
	b=oH8e5xrKFIyXH4KxsUst5W5Op+h1EoXXUSHXoTTWlkEfHTYjOLBdoQJJx8kOT0m17HSv
	 TdR/Crm6QRufh2twqGNG+9VSsUSL5Ii8a+0IzTaazFdveSZA6SypxuXDxzPg1rGGn0gVh
	 5xVkWP6zK7+LMeUlqXFig7/mNkRRmcsfvV4aIatP0ktyZtxYG9E5Vjzo6UVklTNwCGT4a
	 c1G3zRZ2CrjxAUmynVaF/NaQc4EU+2Pnbzxv4WKNH3xfCHSopFsQF3Vb5q1WarupHyH3w
	 sK9+48NDncXJpd66eUZ7F610DR6YxLdk2UZK+tofMb1sSg0OB7Cx309TGvSpCHFWlYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=CqhlsHPx;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888B60A263D;
	Tue, 20 Oct 2026 17:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3888B60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=CqhlsHPx
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C76C1E83402;
	Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoGZEdpd5KxWW4t8I7AGYoavg6VSIUlABq18dwWdqTI=;
	b=CqhlsHPxEJ9/WV39Ky6nIcK/y3lmmcTN4NvMh7Gm5tz0MZSyXDOpQnlA1YpYpseIVeKAgI
	0o5pG8Mvi3Yg1ekm5i8gTF7yD3/EZLjUKWl4WFUCWm0baX6kLVllJpWN5PWKnG5kY59FSG
	wpPGNE+LkWR0JwYwtSSsR0JR2B4XcbblegmXvrqEE/Vh1Cf6m8MWDNNIn+IE+jRryLvbnu
	HplF00OodcJe7AU6WI6XrlJ+A6yOOXDH9J/Ek4ESKTmGj5NBwTz8/mlfaYcTCbg/g5EfxG
	zpOnA0Utu0P2cdCvLfOBsTD4TlDs+8ab82WNFHvDoOuwaAEcHLMxlJRHaEEu+w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 0zvoYuqkk-oV; Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
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
Subject: [PATCH net v2 10/14] net: pse-pd: keep the PI data until the PI regulators are gone
Date: Tue, 20 Oct 2026 19:12:45 +0200
Message-ID: <20261020171249.853085-11-github@szelinsky.de>
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

pse_controller_unregister() frees the PI array, but the PI regulators
are only unregistered after it, by devres. Until then their ops still
run, for example on a read of the regulator's sysfs "state" or when a
consumer enables or disables the PI, and they read the freed array.

Free the PI array from a devm action that is added before the PI
regulators, so devres frees it after them. This also frees it when
registration fails, where it was leaked before.

While the controller goes away, the PSE core must not power a PI.
pse_controller_unregister() now first sets pcdev->unregistering under
pcdev->lock. After that, enabling a PI fails with -ENODEV, and so does
_pse_pi_delivery_power_sw_pw_ctrl(), which pse_isr(), a priority change
and the retry after a disable use to power a PI. Disabling a PI still
switches it off and frees its budget.

pse_flush_pw_ds() also switches off each PI that holds budget and gives
the budget back before it drops the power domain. Nothing controls such
a PI once its controller is gone, and before, its budget stayed
reserved on the supply. If a PI cannot be switched off, its budget
stays reserved, as the PI may still draw it.

Triggered in QEMU (arm64, KASAN) with a test-only PSE controller:
reading the PI regulators' sysfs "state" while the controller unbinds
gives

  BUG: KASAN: slab-use-after-free in pse_pi_is_enabled+0x294/0x2d4

and unbinding it with budget reserved leaves that budget on the
supply. With this patch both are gone, the PIs are off after the
unbind, and a priority change during the unbind no longer powers a PI.
pse_isr() is not covered by the test, as the test controller has no
IRQ.

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 54 ++++++++++++++++++++++++++++++++++-
 include/linux/pse-pd/pse.h    |  3 ++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f266cc24f6a2..63217a4808e3 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -147,6 +147,11 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 	kfree(pcdev->pi);
 }
 
+static void devm_pse_release_pis(void *data)
+{
+	pse_release_pis(data);
+}
+
 /**
  * of_load_pse_pis - load all the PSE PIs
  * @pcdev: a pointer to the PSE controller device
@@ -612,6 +617,13 @@ static int _pse_pi_delivery_power_sw_pw_ctrl(struct pse_controller_dev *pcdev,
 	struct pse_pi *pi = &pcdev->pi[id];
 	int ret, pw_req;
 
+	/* pse_isr(), a priority change and the retry after a disable all
+	 * power a PI through here, so stop them here once unregistering
+	 * has started.
+	 */
+	if (pcdev->unregistering)
+		return -ENODEV;
+
 	if (!ops->pi_get_pw_req) {
 		/* No power allocation management */
 		ret = ops->pi_enable(pcdev, id);
@@ -668,6 +680,11 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	if (pcdev->unregistering) {
+		mutex_unlock(&pcdev->lock);
+		return -ENODEV;
+	}
+
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
 		/* Manage enabled status by software.
 		 * Real enable process will happen if a port is connected.
@@ -884,6 +901,27 @@ static void __pse_pw_d_release(struct kref *kref)
 	kfree(pw_d);
 }
 
+/* A PI that holds budget is under software power control, and nothing
+ * controls it once its controller is gone: switch it off, then give the
+ * budget back. If it cannot be switched off, keep the budget reserved,
+ * as the PI may still draw it.
+ */
+static void pse_pi_power_off(struct pse_controller_dev *pcdev, int id)
+{
+	int ret;
+
+	if (!pcdev->pi[id].pw_allocated_mW)
+		return;
+
+	ret = pcdev->ops->pi_disable ? pcdev->ops->pi_disable(pcdev, id) :
+				       -EOPNOTSUPP;
+	if (ret) {
+		dev_warn(pcdev->dev, "PI %d: cannot switch off: %d\n", id, ret);
+		return;
+	}
+	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
+}
+
 /**
  * pse_flush_pw_ds - flush all PSE power domains of a PSE
  * @pcdev: a pointer to the initialized PSE controller device
@@ -899,6 +937,7 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 		 * use it.
 		 */
 		mutex_lock(&pcdev->lock);
+		pse_pi_power_off(pcdev, i);
 		pw_d = pcdev->pi[i].pw_d;
 		pcdev->pi[i].pw_d = NULL;
 		mutex_unlock(&pcdev->lock);
@@ -1088,6 +1127,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (ret)
 		return ret;
 
+	/* The PI regulator ops use pcdev->pi until devres unregisters the
+	 * regulators, so free it from devres too, after them.
+	 */
+	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
+	if (ret)
+		return ret;
+
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
@@ -1137,6 +1183,13 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	/* The PI regulators stay until devres unregisters them: from now
+	 * on the PSE core must not power a PI.
+	 */
+	mutex_lock(&pcdev->lock);
+	pcdev->unregistering = true;
+	mutex_unlock(&pcdev->lock);
+
 	/* Stop the IRQ and the notification worker first: pse_isr() uses
 	 * pcdev->pi and the power domains that pse_flush_pw_ds() drops,
 	 * and the worker reads the kfifo that is freed below.
@@ -1152,7 +1205,6 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	mutex_unlock(&pse_list_mutex);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 4e5696cfade7..a917ac32dc0c 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -298,6 +298,8 @@ struct pse_ntf {
  * @ntf_work: workqueue for PSE notification management
  * @ntf_fifo: PSE notifications FIFO
  * @ntf_fifo_lock: protect @ntf_fifo writer
+ * @unregistering: set under @lock when unregistering starts; the PSE
+ *		   core switches no PI on after that
  */
 struct pse_controller_dev {
 	const struct pse_controller_ops *ops;
@@ -317,6 +319,7 @@ struct pse_controller_dev {
 	struct work_struct ntf_work;
 	DECLARE_KFIFO_PTR(ntf_fifo, struct pse_ntf);
 	spinlock_t ntf_fifo_lock; /* Protect @ntf_fifo writer */
+	bool unregistering;
 };
 
 /**
-- 
2.43.0

