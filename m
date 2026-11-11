Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431884;
	b=CZqnPmBiSmHuOIXe8EJnALy0fiwu1+2e5cHTmge35n84auISXrIWQei+5uirFWg7Cx89
	 kNu1k0Q/OTPj1SMuLK/0bJeAMPPxSPv3MByX1PEmj/uLXWJiETeMrJEufdp/3NJ/u7G2Q
	 PG+pQZqUvKLj/NP5hWeJFtGCQeaN1sdfZcMygBg1KRcKb8Bqdfap7OmFO0qkWqhGxb4mL
	 IVkXWShbfoHiB8cHA35DbyQKYro6qpvTQ1kO+w4NiDEN64uUgwaXX21mGubRJMIMrw70Y
	 xb8cXsIwI9JBPwwi4ErTff/fz03MPyiWypUYcnFLDZpADGlD7upCv4jrBIalglf361Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=GAZgvf0AaAxY9EmIpJ7kcYFCP5LNDn0zRxyCu4GnH/U=;
	b=nJ20Pfrf8ITsKTpHHwteWgivcPRinrZojFxUdAv8Q/+0FAaPCS8j9UzeVQOAtSv61+6e
	 MM/QnHhNnRpyv/rgxtbqKNLozpfg6x+Ym0+oWh/aigEbJ+SgeqwYEY5bMs+Lty5HvJ4do
	 ltRvWI9AJvjclXheI3xW9iDZ7Ul/IK0eNmDP5gXJyVeUKAD8pRh1pYIFO6227f4dIx+jg
	 prNY7mfwGX0HUYSccDtRwEEc7sC2TplUCwL9c6m7MM1c/AxbxAtA2aiRcnUrPt9ENY1GS
	 Hj0DVaIS2Ld4ulQGu6XlzrwuDgwPBbNtZWEZm8eJaeo7UJi98sixyYcwEA1TjIwne7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=d8fYF66I;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F0606A8A8;
	Wed, 11 Nov 2026 21:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398F0606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=d8fYF66I
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 89832E833E8;
	Wed, 11 Nov 2026 22:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAZgvf0AaAxY9EmIpJ7kcYFCP5LNDn0zRxyCu4GnH/U=;
	b=d8fYF66IQveHURNzMsXJSO0JP+TAaY0GkCaaYdFntY+ixMRyOOqMvj9HOpf68U2D9b4iD9
	x2g2mYdLMaZxWKvnKYJ3z9iH9SCo/dvymHoG0ZC7RfJkhKE735SBmAD+mywTv2WIjARsan
	IPMWpj7MMuSPTpJF0GGfe+nTcJZ04Roco4cYrQNwaPSRWycqAsGyWqTY5FkuQNp9GOHtjP
	Ejr2EtFTlzmXKt4jaDzizbKk4vFzphYLWHJmth/PwDXHW4iWEf51dqmSWDKvL9hcV+YC4Z
	DtRmKhamRGEKmwNQBI7tOzEjZ/C0fvWBEz4JHnqXfkFvsH7VPSgFiuktE31HAg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id b4gJ3rdzZz5S; Wed, 11 Nov 2026 22:17:59 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:17:58 +0100 (CET)
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
Subject: [PATCH net v4 08/14] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Wed, 11 Nov 2026 22:17:25 +0100
Message-ID: <20261111211731.3193796-9-github@szelinsky.de>
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
under pcdev->lock. After that, both functions return -ENODEV, and
pse_isr() does not try to power a PI, so it does not report a false
power control error. Disabling a PI still works.

The next patches in this series build on this order.

Found by code inspection and AI review.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 31 ++++++++++++++++++++++++++++---
 include/linux/pse-pd/pse.h    |  3 +++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a1cd033ba744..2dce1f1c4d16 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -616,6 +616,13 @@ static int _pse_pi_delivery_power_sw_pw_ctrl(struct pse_controller_dev *pcdev,
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
@@ -672,6 +679,11 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
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
@@ -1159,11 +1171,22 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
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
@@ -1267,7 +1290,9 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
 		struct netlink_ext_ack extack;
 
 		pcdev->pi[id].isr_pd_detected = true;
-		if (pcdev->pi[id].admin_state_enabled) {
+		/* Powering a PI fails once unregister started, do not try */
+		if (pcdev->pi[id].admin_state_enabled &&
+		    !pcdev->unregistering) {
 			ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, id,
 								&extack);
 			if (ret == -ERANGE)
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

