Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743367;
	b=Am8tc5WLDThuB7cuOlObTuuGxyVqh3Z0abt6hFHc90r9nmODQlidsGGF7cCvP9GP5RiS
	 QXWi2agcmDSUib+VsrQvhe+jfx8JK6urUjp2JZ9+QN2M0GlxHYCKvVEypvwxsbAJL2Njj
	 5lH473on+N+QPz2LjgemLF30KpGWeDSh47qPWtQlhqU6VWPHSecF+kxKGbCe9O9nTEJfp
	 vYeFa59VO9yHK565mCvxngtiq5BdXGq5aE20cykAsLve1KtHx/ju74d3255Dxn0QTaZHB
	 VECWZM8SUuJoQosZGkQgjMKOjo460ikjUn/Dsy94snt/PiDjA6oGgQejR/B2m4lObKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=K8nnQd6yc/ynjL6D7uGFEPbt3eAae8GtqCIdodwndIQ=;
	b=YcKY4FPrHsTEfOzjsh3itJtKpKKq6SxObq9W7XY0sv6veuf72c95inj9Rfiq2Ntl5Z3F
	 D8ZzFjgCJShRCJGotyRAKTJe/u5F+Hh4zbvlTYDnu+u+FIQdb4LQb9TZaHO+/OG07b5Ly
	 8PUGDnxdzNEDm70JoEsrhcWVonNcsmaziWfBW+QIa+vqyt3NTkm/dl+5e4Q1M4JyJjW2y
	 XRLPpXK+PMGue55ZnI7s3+9QwXGGFMuMOuIMDfSVAQf+aAedD56bl6319iQgmXKPQm2OA
	 +CuHgSkzmiRV+3UqMXtDEIb3hgjzZwBDk3GY/dC8lgtzWV6WWkbVp4+a3zQ0UpYjmMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=TgLstCbH;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA6606D802;
	Tue,  3 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BA6606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=TgLstCbH
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 981CFE836CE;
	Tue, 03 Nov 2026 23:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8nnQd6yc/ynjL6D7uGFEPbt3eAae8GtqCIdodwndIQ=;
	b=TgLstCbHU/apbNXYkc/yd0G+/CWN7XMLDPge30UV2iFOcFC0a1EmtT5fIZEjj98Zct2t19
	tXGTA0u0U0Z/abtlusHrMk8d8pO+qDPUDkytpUOd5MU2+WUzbYS10aPvtt8cgr0D67fptt
	aawWJDnpEPbNIe6d3poDniVldmc3/fAHo62kiZa8HAjRyLbPfe/YV0fA1rGOpeX6Pzh+VV
	QFjoDl10h27lN5nhKMLs+WSUvvADSxvSXsfZxpg5J7DycqJoycCbisMlhlfl4vSkXZVi74
	Se9/rDICBYMkgDXlamVmCxhAc/ruSsTwR2p1a0bOTqDWmsX1zmZTPXftOcQvjA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id MmUrAImQI6RV; Tue,  3 Nov 2026 23:02:42 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:41 +0100 (CET)
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
Subject: [PATCH net v3 08/14] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Tue,  3 Nov 2026 23:02:11 +0100
Message-ID: <20261103220217.1131971-9-github@szelinsky.de>
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

pse_controller_unregister() flushes the power domains and frees the PI
array before it disables the IRQ, while pse_isr() uses both. No in-tree
driver hits this: tps23881, the only user of devm_pse_irq_helper(),
requests its IRQ after it registers the controller, so devres frees
the IRQ before unregister runs. A driver that keeps its IRQ across
unregister would read freed memory.

Disable the IRQ and drain the notification worker first, and only then
flush the power domains and release the PI array.

The worker can also be queued again after the drain. With the static
budget strategy, powering a PI can switch off a PI of lower priority
through pse_disable_pi_pol(), which queues the worker. A PI is powered
from pse_isr(), from a priority change, from the retry after a disable,
and when a consumer enables it. All of these go through pse_pi_enable()
or _pse_pi_delivery_power_sw_pw_ctrl().

So pse_controller_unregister() now first sets pcdev->unregistering
under pcdev->lock. After that, both functions return -ENODEV.
Disabling a PI still works.

The next patches in this series build on this order.

Found by code inspection and AI review.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 27 +++++++++++++++++++++++++--
 include/linux/pse-pd/pse.h    |  3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 113a34b09386..36f8e4e7d191 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -612,6 +612,13 @@ static int _pse_pi_delivery_power_sw_pw_ctrl(struct pse_controller_dev *pcdev,
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
@@ -668,6 +675,11 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
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
@@ -1160,11 +1172,22 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* From now on the PSE core must not power a PI, so nothing queues
+	 * a new notification once the worker is drained below.
+	 */
+	mutex_lock(&pcdev->lock);
+	pcdev->unregistering = true;
+	mutex_unlock(&pcdev->lock);
+
+	/* Stop the IRQ and the notification worker first: pse_isr() uses
+	 * pcdev->pi and the power domains that pse_flush_pw_ds() drops,
+	 * and the worker reads the kfifo that is freed below.
+	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
 	cancel_work_sync(&pcdev->ntf_work);
+	pse_flush_pw_ds(pcdev);
+	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
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

