Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF743C056;
	Sun, 27 Sep 2026 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536765; cv=none; b=jZW9r1T9VtnBGuw3epL3NU5a8bmW1IqLBCtzfpg9C+G6N0M5CvKavERDJ8m92ra9FggbA9zvoA+UU2JC+6QzOgWfLwFNOHdO1X+AuLK9WBnrhXwFVrF5etP4HPCAdK8wF1pi0Zn7yDonfUBHkukFfcxf/QIalwQbKD1zCuBOEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536765; c=relaxed/simple;
	bh=ryKRyfOUnRCGCXRH1G23/G0mNTHH5jxmhoopmVkBQWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0Mjv7y9BbUxXxq9iTqE84XlFIWvFDTNhFjjvXIn92q77ViOWOSmI+wdeltPUgfqt/N5XTYaHnYQoWPF/hRqwNrURpV/AjT7fOAi5x2Xsy+GGNS118Be0QESgxtuRby9dhd+/BVmk1M3uj+t/MapiE+SJ1/Zvl+1HprnT+AwAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=GkcZBFgt; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="GkcZBFgt"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id B63CAE8388F;
	Sun, 27 Sep 2026 21:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1790536760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXUCWAqJd6Zh9W7aDYO4JBJHsT/sIWsJdX4+11+kpSw=;
	b=GkcZBFgtYHPnQ/UsiFwdKXLxCOV+q7PcQf032bes8iFryIyBelIR3EqiWBF84myKZkTA0t
	Tkd3K/d2N/QVEd06b+wpvMXs2Cm9LEJeFvDkwn3r55ms36RSuRfnIxT+fvT6lr5+tUf3bo
	nFTFfh6Fs4vgIebIuHK/uH/J65KSVhCVwxRQBlmCzZdvmBGZ70vyKd2xRI0S/7DdJ6ns65
	pj3E/BM52JYnh8Z+5Q4MPmcq4TOFbBh/BD288KNu+9nekBLYXY1VSO8BGZV/RsOfuFVsuJ
	Jc00SunUCHIo/SPt68za1ZThsV7fzWOtIAvoPuHGfK8dgZzLR8oODd4pU0bV/Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id xuCGimgy84z8; Sun, 27 Sep 2026 21:19:20 +0200 (CEST)
Received: from p14sgen5.. (ip-077-020-250-175.vkd66.pools.vodafone-ip.de [77.20.250.175])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 27 Sep 2026 21:19:19 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v7 3/5] net: pse-pd: unwind allocations when controller registration fails
Date: Sun, 27 Sep 2026 21:18:48 +0200
Message-ID: <20260927191850.1370515-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927191850.1370515-1-github@szelinsky.de>
References: <20260927191850.1370515-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_register() allocates the notification kfifo and, through
of_load_pse_pis(), the PI array plus an OF reference per described PI.
Every failure after that point simply returns: none of it is freed.
kfifo_free() and pse_release_pis() only run from
pse_controller_unregister(), which a failed registration never reaches,
and devm_pse_controller_register() drops only its own devres cookie.
pcdev->pi is a plain allocation, so nothing else will ever free it, and
all five in-tree controller drivers keep pse_controller_dev inside their
private data, whose last pointer goes away with the failed probe.

A partial pse_register_pw_ds() is worse than a leak. The power domains it
already created are devm-allocated but live in the global pse_pw_d_map,
so the failed probe frees them while that xarray still points at them,
and the next controller to register walks into freed memory in
regulator_is_equal().

Unwind at two depths, because the PI array cannot always be freed here.
pse_pi_ops.is_enabled(), .enable() and .disable() all index pcdev->pi[],
and the PI regulators are devm-registered on pcdev->dev, so from the
first successful devm_pse_pi_regulator_register() until devres unwinds
the failed probe there are live regulators whose ops would follow a freed
pointer. regulator_late_cleanup() and the "state" class attribute both
reach those ops. So the array is released on the failures that happen
while it exists and before the first PI regulator does: setup_pi_matrix()
and the supply check. A driver's setup_pi_matrix() may well have
registered devm regulators of its own by the time it fails - pd692x0
registers its managers there - but those do not index pcdev->pi[], so
they do not constrain this. Earlier than that there is nothing to release -
pcdev->pi is still NULL, or of_load_pse_pis() has already freed it - and
from the registration loop onwards the array has to stay, so those
failures only free the kfifo and flush the power domains, leaving it
leaked exactly as it is today rather than handing those regulators a
dangling pointer. An allocation failure in the loop's first iteration
leaks it too, where releasing would still have been safe, but the rule
stays simple enough to read. Freeing it safely needs the NULL-and-guard
treatment the pending net teardown fix adds to the regulator ops, which
is not in net-next.

of_load_pse_pis() already releases the PI array on its own failures, so
that path only needs the kfifo.

pcdev->pi is cleared at the release_pis label and deliberately not
inside pse_release_pis() itself. The label is the one place the array
is freed while no PI regulator exists. pse_controller_unregister()
calls the same helper with every PI regulator still registered - the
devres node for devm_pse_controller_register() is added after them, so
it is released first - and pse_pi_is_enabled() indexes pcdev->pi[]
unguarded behind the regulator "state" attribute. Clearing the pointer
in the helper would turn that pre-existing read of freed memory into a
NULL dereference.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 56cecf60c5c4..16d75b4babf3 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1092,17 +1092,18 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
@@ -1110,7 +1111,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
 
@@ -1119,20 +1125,22 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
+		goto flush_pw_ds;
 
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
@@ -1142,6 +1150,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 				     PSE_REGISTERED, pcdev);
 
 	return 0;
+
+flush_pw_ds:
+	pse_flush_pw_ds(pcdev);
+	goto free_kfifo;
+
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

