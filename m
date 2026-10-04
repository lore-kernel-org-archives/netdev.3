Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AD3C552B;
	Sun,  4 Oct 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132174; cv=none; b=jpnC42Sw0GmZf96A0iS1BVxBsbS4mn8F2aX8cmcHZtXlW2xZ8kP2xzaDsoUgAeKLsP+ndqxtsadT3n1OvClUb/VcrOKymqVvrtwPYuDcKhDUYYdJMWStNpQiahY5LmlBOEJA6SzSeOqyFql6t/a65jQS6XIWCNeBRXmrQS329R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132174; c=relaxed/simple;
	bh=wry6opSJpZh1oRQjyIBh8lkWysTLv2qPE1E4UQlFQh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koF0BtccEtoEnNarZuV4StgT25KJDcYDFFOZiFNcvih8QguzLEQ9ZpUcfTpy5Ytey9TBmlQmtglAoaDrwHeweGguVKT+aE7bc0xNho+pHFCadGnMVitGucodrBV2de/8HOXbEvUv63rcOzPL8DIBbZC4qriZ1OFf+GYOK44NovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=kGmdoVJu; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="kGmdoVJu"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 272A5E83882;
	Sun, 04 Oct 2026 18:42:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUMSZykPh+NauFa+TohmtA2/HKcJdhv8MYKFz/B8koQ=;
	b=kGmdoVJuBY3vjs5/UzHqhmbFeG8N8YwbOShQvRM01MmRLHObc5L2wKHpiS30lZ8kCUhjbX
	1Dl9CpG8Wv9+ITwRVDqsEQ3ZOtyJir1WOkoCSLbYYam7xijAcAVuumXnuk0EQ5YDDZQgvq
	+UhwYoIvPgWM8cKPJipYDDElCHCFhyNA+STZvWuV631jm3pc0FdbN7gL9DQup9Me5iHWb6
	IH3HAPijdCiIdrT/sWEbkrQhvLXVDguzTqC3nzqeKnzhpIQTYFHpiSGUGdTSckZso865MZ
	7z6VSlNHV3n1Vd7Hw4KJ1u7RZIjJUZR+UloQtyvuvPwsxRqPR3NlbrhEsFSUyQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id RMJBTQ0oTMOC; Sun,  4 Oct 2026 18:42:47 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:46 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v8 3/7] net: pse-pd: unwind allocations when controller registration fails
Date: Sun,  4 Oct 2026 18:42:15 +0200
Message-ID: <20261004164219.1161294-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004164219.1161294-1-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_register() allocates the notification kfifo and, through
of_load_pse_pis(), the PI array plus OF references on each described PI
node and its pairset nodes. Every failure after that point simply
returns and none of it is freed. of_load_pse_pis() cleans up after
itself, but past that point kfifo_free() and pse_release_pis() only run
from pse_controller_unregister(), which a failed registration never
reaches, and devm_pse_controller_register() drops only its own devres
cookie. pcdev->pi is a plain allocation, so nothing else will ever free
it.

A partial pse_register_pw_ds() is worse than a leak. The power domains
it already created are devm-allocated but live in the global
pse_pw_d_map, so the failed probe frees them while that xarray still
points at them, and the next controller to register walks into freed
memory in pse_register_pw_ds(), reading pw_d->supply for
regulator_is_equal().

Unwind at two depths, because the PI array cannot always be freed here.
pse_pi_ops.is_enabled(), .enable() and .disable() all index pcdev->pi[],
and the PI regulators are devm-registered on pcdev->dev, so from the
first successful devm_pse_pi_regulator_register() until devres unwinds
the failed probe there are live regulators whose ops would follow a
freed pointer; regulator_late_cleanup() and the "state" class attribute
both reach them. So:

 - failures before of_load_pse_pis() succeeds free only the kfifo;
 - failures after it and before the PI regulator loop (today
   setup_pi_matrix()) also release the PI array and its OF references;
 - failures from the loop onwards free the kfifo, and the
   pse_register_pw_ds() one also flushes the power domains, but leave
   the PI array and its OF references leaked exactly as today rather
   than hand live regulators a dangling pointer.

A driver's setup_pi_matrix() may have registered devm regulators of its
own by the time it fails - pd692x0 registers its managers there - but
those do not index pcdev->pi[]. Freeing the array safely past the loop
would need the regulator ops to tolerate a NULL pcdev->pi, which they do
not today.

pcdev->pi is cleared at the release_pis label and deliberately not
inside pse_release_pis(): pse_controller_unregister() calls that helper
with every PI regulator still registered, and pse_pi_is_enabled()
indexes pcdev->pi[] unguarded behind the "state" attribute, so clearing
it there would turn that pre-existing read of freed memory into a NULL
dereference.

pse_flush_pw_ds() now also clears pi[].pw_d. The domain is devm memory
of whichever controller created it, so it can go as soon as that probe
unwinds, and pse_pi_is_enabled() still reaches pi[].pw_d from the
"state" attribute until the PI regulators are unregistered.

This does not fix a shared power domain. The reference counting is
sound - pse_register_pw_ds() takes its kref_get() under pse_pw_d_mutex
and kref_put_mutex() takes that mutex for the final put - but if
another controller on the same supply holds a reference, the flush only
goes 2->1 and devres frees the creator's pw_d underneath it anyway.
Unregistering a controller whose domain is shared has the same problem
today. Fixing it means moving the domain out of devm memory so that
only the last put frees it.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 56 ++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index dc261beb6170..eeefbf25e671 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -937,11 +937,21 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
 			continue;
 
 		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
-		if (!pw_d)
+		if (!pw_d) {
+			pcdev->pi[i].pw_d = NULL;
 			continue;
+		}
 
 		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
 			       &pse_pw_d_mutex);
+		/* The pw_d is devm memory of whichever controller created
+		 * it, so it can go away as soon as that probe unwinds.
+		 * Nothing may be left pointing at it: pse_pi_is_enabled()
+		 * reaches pi[].pw_d from the regulator "state" attribute,
+		 * which stays readable until the PI regulators are
+		 * unregistered after us.
+		 */
+		pcdev->pi[i].pw_d = NULL;
 	}
 }
 
@@ -1092,17 +1102,18 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
@@ -1110,7 +1121,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	 */
 	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
 
-	/* Register PI regulators */
+	/* Register PI regulators. Once one of these exists, pse_pi_ops index
+	 * pcdev->pi[] and nothing here can unregister it again, so the array
+	 * must outlive this function. Failures below therefore unwind to
+	 * free_kfifo and deliberately leak it, as they already do today,
+	 * rather than hand the live regulators a freed pointer.
+	 */
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		char *reg_name;
 
@@ -1119,20 +1135,27 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
-	if (ret)
-		return ret;
+	if (ret) {
+		/* Deliberately not release_pis: the PI regulators registered
+		 * above index pcdev->pi[] and outlive this function.
+		 */
+		pse_flush_pw_ds(pcdev);
+		goto free_kfifo;
+	}
 
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
@@ -1142,6 +1165,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 				     PSE_REGISTERED, pcdev);
 
 	return 0;
+
+	/* Only for failures above the PI regulator loop, where no regulator
+	 * indexes pcdev->pi[] yet. Anything below it has to go straight to
+	 * free_kfifo instead.
+	 */
+release_pis:
+	pse_release_pis(pcdev);
+	pcdev->pi = NULL;
+
+free_kfifo:
+	kfifo_free(&pcdev->ntf_fifo);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
 
-- 
2.43.0

