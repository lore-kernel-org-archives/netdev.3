Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F632B13E;
	Sun, 18 Oct 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311575; cv=none; b=fnlpGLklQS4s828thXv0bRrbTfVSy/NyBOtFPsiGTDuWAH6PXGkOMPWuLDF1DwwcM6gbSuzTt2LLhE+m6MrLBZkBcG4t0RTLxWZBdm1AZ69+YnGIwZ/CO6nKw0di4ZLtwgPUNy5aNwZZ21TDykOZrC/MXqt4utlrj23ftlS909I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311575; c=relaxed/simple;
	bh=tsEJGH9nZX0u3Y0+7CztkLLt1zE29nTwAgd5k3xZWgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmB6weGSB2inql5nMZCyUpFdso3I6gdTyyrAtJ9DMxXYbINeCnhyDktt2mjPgD5JgP4mi+RJXyOHYhpINKeipxCvxTQJwDiq5zFhf+kp6EFK7c0cTQSB/Lk6hRifhPWxHBq0pZ79Zi6izLIGK6sBZ0bDTXBvgJspNGVaZJfR/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=DnXYogla; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="DnXYogla"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 40590E8395F;
	Sun, 18 Oct 2026 10:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVXimte+aMOpCnVol9Z8YNDfZRmIUcB728mxAFEq3VY=;
	b=DnXYogla9xGDpSKJxSroQekIXf9Mkfr189DO1CrtrbBdHIMGrZLroaos9621V3tf+XQIOj
	wVU5xRg7bNoIngN8QIRYh2geEwmLHaVA9VWIy4/mABAZXAuAPicOAZ4rUJmKR2Snq9Pt5h
	v5pI0c+LPLllCeI6G68gjF+FQGfqv4FGO0JbuCvPqoswcNo94SAvZ7Te56i3b+R19VsEiL
	MrBpXCQ7ehTsqPP0Q5q92515eD3uNoB0a7+RxJxcdP2avFh9cZJXGsmnQ/RHVfimnBG7Za
	+NPqCH++ju/Rtyjh/641tYEimG4qTnBXCON9IpOgIaZeAJtccN9dVqWxTiZnkQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id GWbWoew0KMTA; Sun, 18 Oct 2026 10:19:20 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:19:19 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Corey Leavitt <corey@leavitt.info>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next 4/4] net: pse-pd: check the PI vpwr supply before registering the controller
Date: Sun, 18 Oct 2026 10:18:53 +0200
Message-ID: <20261018081853.47484-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
References: <20261018081853.47484-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A regulator registers even when its supply is not there yet. So a PSE
controller registers while its vpwr supply is missing, and every PI
lookup returns -EPROBE_DEFER until the supply appears. Today the MDIO
bus owner keeps deferring until then, but a consumer that only looks a
PI up when a controller registers, as phylib will with the PSE
notifier, would never get it.

Check every PI's vpwr supply before the PI regulators are registered,
and defer the PSE driver's probe if one is missing. The check runs
after setup_pi_matrix(), because pd692x0 registers the supply
regulators there.

The check is simpler than the regulator core's: a supply that is
registered, but whose device is not bound yet, still passes, and that
PI then gets no power domain. On the other hand, a PI whose supply
appears late now gets a power domain; before, pse_register_pw_ds()
skipped it.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 05b02d736931..44986749600e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
+#include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/rtnetlink.h>
@@ -826,6 +827,65 @@ static const struct regulator_ops pse_pi_ops = {
 	.set_current_limit = pse_pi_set_current_limit,
 };
 
+/* Look up PI @id's vpwr supply on its own node, as the regulator core
+ * will. Only if the PI node has a vpwr-supply phandle: otherwise the
+ * lookup falls back to of_get_child_regulator() on the controller node,
+ * which can return a sibling PI's supply.
+ *
+ * Return: 0 if this PI needs nothing more, 1 if the controller node has
+ *	   to answer for it, or a negative error such as -EPROBE_DEFER.
+ */
+static int pse_pi_check_supply(struct pse_controller_dev *pcdev, int id)
+{
+	struct device_node *np;
+	struct regulator *supply;
+	int ret;
+
+	/* The PIs the registration loop skips. */
+	if (!pcdev->no_of_pse_pi && !pcdev->pi[id].np)
+		return 0;
+
+	np = pcdev->pi[id].np ?
+	     of_parse_phandle(pcdev->pi[id].np, "vpwr-supply", 0) : NULL;
+	if (!np)
+		return 1;
+
+	of_node_put(np);
+	supply = of_regulator_get_optional(pcdev->dev, pcdev->pi[id].np,
+					   "vpwr");
+	if (!IS_ERR(supply)) {
+		regulator_put(supply);
+		return 0;
+	}
+
+	ret = PTR_ERR(supply);
+	if (ret == -ENODEV)
+		return 1;
+
+	return dev_err_probe(pcdev->dev, ret,
+			     "PI %d: failed to get vpwr supply\n", id);
+}
+
+/* The core's fallback: a vpwr-supply on the controller node. */
+static int pse_controller_check_supply(struct pse_controller_dev *pcdev)
+{
+	struct regulator *supply;
+	int ret;
+
+	supply = regulator_get_optional(pcdev->dev, "vpwr");
+	if (!IS_ERR(supply)) {
+		regulator_put(supply);
+		return 0;
+	}
+
+	ret = PTR_ERR(supply);
+	if (ret == -ENODEV)
+		return 0;
+
+	return dev_err_probe(pcdev->dev, ret,
+			     "failed to get vpwr supply\n");
+}
+
 static int
 devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 			       char *name, int id)
@@ -1068,6 +1128,7 @@ static void pse_send_ntf_worker(struct work_struct *work)
  */
 int pse_controller_register(struct pse_controller_dev *pcdev)
 {
+	bool ctrl_supply_ok = false;
 	size_t reg_name_len;
 	int ret, i;
 
@@ -1102,6 +1163,26 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			goto release_pis;
 	}
 
+	/* Check vpwr supplies while pcdev->pi can still be freed. Not before
+	 * setup_pi_matrix(): pd692x0 registers the regulators its PIs name
+	 * there.
+	 */
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		ret = pse_pi_check_supply(pcdev, i);
+		if (ret < 0)
+			goto release_pis;
+
+		/* Same answer for every PI: ask once. */
+		if (!ret || ctrl_supply_ok)
+			continue;
+
+		ret = pse_controller_check_supply(pcdev);
+		if (ret)
+			goto release_pis;
+
+		ctrl_supply_ok = true;
+	}
+
 	/* Each regulator name len is pcdev dev name + 7 char +
 	 * int max digit number (10) + 1
 	 */
-- 
2.43.0

