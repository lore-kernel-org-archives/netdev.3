Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516389;
	b=CZjsxVpeoe+c9synonfPdRqwAWGTfSNA8GK24DXsj92FLjG8L2/9fde0hCrYEQnQFv3s
	 5+2hhTpgcfTlnrEdkhp/lfO+0tCWjgDrFEbVTKPyu36W08LBVdmUk/Jc14VJOlYDywZKy
	 wQ5S2rt5XX0xsV7zUz+FF/tz4TKTzSjWau1ZTcLWUQIhRdo1GTP7R/qzHUTb+IyUaFba7
	 r6iVaok75AkGL76GrUBgYvvEiMfAM/WOvQMEc/ZjOo61+OSEdIilLw8jsrx8vcIqWM4Zx
	 kKl1VKEPcjBrzSNBe1k2sQya2vhI+SsBt74ztgjttkMrGGoXMtCnwPv9Pp5NZtlBL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=euoK0BaQVuSiWOTngh9LsysjB5f7AtkG7sX8OIudhdg=;
	b=rm+cEKMRNyro9NloXoFpgM1+h5/hms9TEsRg9nofZId+wB0YCamW3SzZU9la6I10lKEx
	 olcw+c97UBCO1bY8BVsgRGgPnbT5Hr/6DWnfQuD3iUXQsFKZGaNPw25S0ODLIUt6gVhBs
	 /Ac9JuxeIvLp2hJ0tyl3Ha+zUg6QVbFxtpP8Y7rjInZxijqUTAOXh7avIsuMvYeM2U2OJ
	 rkSUW5Sbch2cwpn7v2k6m2ZvdUNweS+s6WtyAAikULa3ADKFtUSu7J1gazl8mhRidiKL2
	 mQl8jkHEzWrutIGGSDUnO7TpVHHxZvZ+sgA0jFv5wPcGVL7/xp3oVGONahyJM/K7lNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Kkq6gXar;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4360A3813;
	Tue, 20 Oct 2026 17:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A4360A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Kkq6gXar
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 21D60E83495;
	Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euoK0BaQVuSiWOTngh9LsysjB5f7AtkG7sX8OIudhdg=;
	b=Kkq6gXar9TNZmkXM8ZzqofoYYuMFuEb5mloOEbHAwb0V0hetuTOw2WIPFe/2I8UMq1O6A8
	vmm+ZPEgW5OJNGxnG2CZgbeNoblOqPT+zdS+SYwJCfppLaIwJW9c7XyB4FsqtlrGbw/+G+
	8cmyS77g0FUO2IC04NDloTKxs6xZj0EYSv17mgxrEuOmk4kj+WJVCcRUcx5BNOqJZm/PRe
	0C0pxKpEmJReVANAbqRe6hBna2lp9Ob9gJGTJ//6lspHrpJDa141ne5Ys4Q1dShZivGzQ+
	0X4iiBwlaaFbxTCXHnbCWhCcU1edgZ/HL5zYod+dFqefMKOKVgi0cmrjSZwuWA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id wXOfgk9vHAXd; Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
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
Subject: [PATCH net v2 11/14] net: pse-pd: unwind allocations when controller registration fails
Date: Tue, 20 Oct 2026 19:12:46 +0200
Message-ID: <20261020171249.853085-12-github@szelinsky.de>
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

When pse_controller_register() fails, it does not free the
notification kfifo. Worse, if pse_register_pw_ds() fails part way, the
power domains it already set up stay in the global map. Their supply
handle belongs to a PI regulator that devres then frees, so the next
user of the map reads freed memory.

Free the kfifo on every error path, and let pse_register_pw_ds() undo
its own power domains while it still holds pse_pw_d_mutex, so no other
controller can pick one up first. The PI array is already freed by
devres.

Found by code inspection and AI review. Triggered in QEMU (arm64,
KASAN) with a test-only PSE controller and an injected failure in
pse_register_pw_ds() at the third PI: reading the regulator summary in
debugfs then gives

  BUG: KASAN: slab-use-after-free in regulator_summary_show_subtree+0x770/0x9c4

With this patch the failure is undone, and kmemleak reports nothing.

Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 73 +++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 63217a4808e3..116ad2d1984a 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -889,7 +889,8 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	return 0;
 }
 
-static void __pse_pw_d_release(struct kref *kref)
+/* Release for a put made with pse_pw_d_mutex already held. */
+static void pse_pw_d_release_locked(struct kref *kref)
 {
 	struct pse_power_domain *pw_d = container_of(kref,
 						     struct pse_power_domain,
@@ -897,7 +898,6 @@ static void __pse_pw_d_release(struct kref *kref)
 
 	regulator_put(pw_d->supply);
 	xa_erase(&pse_pw_d_map, pw_d->id);
-	mutex_unlock(&pse_pw_d_mutex);
 	kfree(pw_d);
 }
 
@@ -922,6 +922,30 @@ static void pse_pi_power_off(struct pse_controller_dev *pcdev, int id)
 	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
 }
 
+static void __pse_pw_d_release(struct kref *kref)
+{
+	pse_pw_d_release_locked(kref);
+	mutex_unlock(&pse_pw_d_mutex);
+}
+
+/* Switch off the PI, give back its budget and clear pi[id].pw_d before
+ * the domain's reference is dropped. The PI regulator ops and pse_isr()
+ * hold pcdev->lock while they use it.
+ */
+static struct pse_power_domain *
+pse_pi_take_pw_d(struct pse_controller_dev *pcdev, int id)
+{
+	struct pse_power_domain *pw_d;
+
+	mutex_lock(&pcdev->lock);
+	pse_pi_power_off(pcdev, id);
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
@@ -932,15 +956,7 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 	int i;
 
 	for (i = 0; i < pcdev->nr_lines; i++) {
-		/* Clear it before the put that may free the domain. The PI
-		 * regulator ops and pse_isr() hold pcdev->lock while they
-		 * use it.
-		 */
-		mutex_lock(&pcdev->lock);
-		pse_pi_power_off(pcdev, i);
-		pw_d = pcdev->pi[i].pw_d;
-		pcdev->pi[i].pw_d = NULL;
-		mutex_unlock(&pcdev->lock);
+		pw_d = pse_pi_take_pw_d(pcdev, i);
 		if (!pw_d)
 			continue;
 
@@ -958,8 +974,8 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
  *
  * A power domain is shared by every controller whose PIs sit on the same
  * supply, so it must not be tied to the lifetime of the controller that
- * happened to create it. It is freed by __pse_pw_d_release() on the last
- * kref_put().
+ * happened to create it. It is freed by pse_pw_d_release_locked() on the
+ * last kref_put().
  *
  * Return: Pointer to the newly allocated PSE power domain or error pointers
  */
@@ -1047,6 +1063,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
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
@@ -1120,24 +1143,25 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
 
 	/* The PI regulator ops use pcdev->pi until devres unregisters the
 	 * regulators, so free it from devres too, after them.
 	 */
 	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
 	if (ret)
-		return ret;
+		goto free_kfifo;
 
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
-			return ret;
+			goto free_kfifo;
 	}
 
 	/* Each regulator name len is pcdev dev name + 7 char +
@@ -1154,26 +1178,33 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
+free_kfifo:
+	cancel_work_sync(&pcdev->ntf_work);
+	kfifo_free(&pcdev->ntf_fifo);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
-- 
2.43.0

