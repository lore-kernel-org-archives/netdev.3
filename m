Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CF43991C;
	Sun, 27 Sep 2026 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536767; cv=none; b=ds3M5fY4o16BqSoLOT2NMTCmLMXZZHkWoJUKzbWpSvZt+DhGftZSSUPrnt4EBnUaVHSnEsxk/KXglyGj6T9J+ReXb2GdQsMbasWyeg4ksVyL5UfWy4k7g0ij+aFuyt0h+grdikrigRwaFMBlLjgWq9EeYrJop4o+R/IkDRie89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536767; c=relaxed/simple;
	bh=2uwFgZjuFvL46ZpC2r+ufO7PevUyQI6wdXIt9CWH7HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itfyswidwqrg703TalyhlsG6HGexGAKx2XIH0vyi0obow+ywRSR+QptJfoSnM3btaFKtVmwSlvq4HXNUIUUUUuzXg7kKqZFvsFO10YiN5UanvVE+v2tDwM+d6TjPgABLjDN5ZnesP22MHV+i+fTXliUtGtUJjIDqhEwClxbUF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=UHFBVwUN; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="UHFBVwUN"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 8E3AAE83586;
	Sun, 27 Sep 2026 21:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1790536762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xP2gr9cjgiwf9nb2d++u96DQ3+HkDCz0LrMy+ljtWmE=;
	b=UHFBVwUNiMPTpTvzEwiJ8WQJEqcUbyw3cI5sNtpcJPpCarpDkN6bz/ibgpX+JBztfGUCt7
	mzq3JGKUWMeMC+X9fbs3TNzTyy43SQVB88v/96QX3tbxlxvzEYZ/2EMvLwACiADunkdQKU
	8or3L9yHnsmh99BnvsOfkYOsEYmA+VcmGqeoI/NtACtL6HYdLIEgzLFfNvkK696+wjdNUt
	Wby+E42EksCIIxIbhjpOIX8gabBilLiEG8m314U40u3+lsPApklE1Xti4KC8LCkH0qVwPt
	PZTYlfl0DTl63VA1JfJjcvrpjExJKYj9B0jrlOiyVRdzusrp2OJjqwiJEicbQw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id slGRnpJoImd1; Sun, 27 Sep 2026 21:19:22 +0200 (CEST)
Received: from p14sgen5.. (ip-077-020-250-175.vkd66.pools.vodafone-ip.de [77.20.250.175])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 27 Sep 2026 21:19:21 +0200 (CEST)
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
Subject: [PATCH net-next v7 4/5] net: pse-pd: check the PI vpwr supply before registering the controller
Date: Sun, 27 Sep 2026 21:18:49 +0200
Message-ID: <20260927191850.1370515-5-github@szelinsky.de>
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

Each PSE PI regulator is registered with a "vpwr" supply, which the
bindings expect the board to provide via vpwr-supply in the PI node. The
regulator core deliberately treats an unresolved supply at registration
time as non-fatal: it logs, registers a bus device so the supply can be
picked up later, and lets registration succeed.

That leaves pse_controller_register() completing for a controller whose
PIs cannot be handed out. regulator_get_exclusive() in
pse_control_get_internal() resolves the supply itself and returns
-EPROBE_DEFER until the provider appears, so of_pse_control_get() keeps
failing for this PI even though the controller is registered and
discoverable. A consumer that only retries on controller registration -
as the phy layer does after the next patch - then never gets its PI.

Check every PI's supply first, before any regulator of ours is
registered, so the error surfaces in the PSE driver's own probe and
deferred probe retries it there. The check skips exactly the PIs the
registration loop skips, so a controller with no pse-pis node - where
every PI has a NULL np but a regulator is still created for it - is
covered too, through the controller device rather than a PI node.

The check follows both stages regulator_resolve_supply() uses: the PI's
own node, then the controller device. Both are needed. of_get_regulator()
reads the node it is handed and otherwise walks that device's children,
so a vpwr-supply written once on the controller node - covering every PI
- is invisible from the PI node, while the core finds it at stage two.
Checking only the PI node would let exactly the case this patch exists
to prevent slip through unreported.

It is still not a full replica. The core also falls back to a dummy
under have_full_constraints(), which does not matter here because it
bails on an explicit -EPROBE_DEFER first, and it defers when the
provider's parent is not yet bound, which regulator_get_optional() does
not check. So a PSE probe interleaving with the provider's own probe can
still pass the check and resolve late. That window is narrower than the
one being closed - a provider that has not registered at all - and
closing it properly means asking the core about rdev->supply after
registration, which the unwind constraints above do not allow.

Doing all the checks before the registration loop also keeps the common
deferral on the unwind path that can release the PI array: a controller
can describe its PIs on different providers - ti,tps23881.yaml puts
pse-pi@0 on vpwr1 and pse-pi@1 on vpwr2 - so "one PI resolves, the next
defers" is the ordinary case, and checking inside the registration loop
would leave registered regulators behind on every retry.

This widens what a missing provider costs. Before, only the PI on that
supply failed, and only when a consumer asked for it; now the controller
itself defers, so a board whose PIs sit on different providers loses PSE
on all of them until the last one appears. That is the normal contract
for a regulator consumer, and the alternative - a controller that
advertises PIs it cannot hand out - is the bug being fixed. A provider
that never appears leaves the controller unbound rather than half
working, which deferred probe reports in the usual way.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 16d75b4babf3..457eef5784f8 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
+#include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/rtnetlink.h>
@@ -860,6 +861,67 @@ static const struct regulator_ops pse_pi_ops = {
 	.set_current_limit = pse_pi_set_current_limit,
 };
 
+/* The regulator core treats an unresolved "vpwr" supply as non-fatal and
+ * retries it on its own later, which would leave this controller able to
+ * register while of_pse_control_get() still fails with -EPROBE_DEFER for
+ * this PI, and nothing to retry the consumer's attach. Check the supply
+ * up front so the PSE driver's own probe defers instead.
+ *
+ * of_regulator_get_optional() reports a PI with no vpwr-supply described
+ * as -ENODEV rather than falling back to the dummy regulator, and has a
+ * stub for CONFIG_OF=n. Those PIs keep their existing behaviour: the
+ * regulator core resolves them to the dummy when the PI regulator is
+ * registered.
+ */
+static int pse_pi_check_supply(struct pse_controller_dev *pcdev, int id)
+{
+	struct regulator *supply;
+	int ret;
+
+	/* Skip exactly the PIs the registration loop below skips, so every
+	 * regulator that will be created is covered.
+	 */
+	if (!pcdev->no_of_pse_pi && !pcdev->pi[id].np)
+		return 0;
+
+	/* Follow both stages regulator_resolve_supply() will use for the
+	 * regulator about to be registered: the PI's own node first, then
+	 * the controller device. Only -ENODEV moves on to the second stage;
+	 * a provider that has not registered yet gives -EPROBE_DEFER, which
+	 * is the case worth catching here.
+	 */
+	if (pcdev->pi[id].np) {
+		supply = of_regulator_get_optional(pcdev->dev,
+						   pcdev->pi[id].np, "vpwr");
+		if (!IS_ERR(supply)) {
+			regulator_put(supply);
+			return 0;
+		}
+
+		ret = PTR_ERR(supply);
+		if (ret != -ENODEV)
+			return dev_err_probe(pcdev->dev, ret,
+					     "PI %d: failed to get vpwr supply\n",
+					     id);
+	}
+
+	/* A vpwr-supply on the controller node covers every PI, and is
+	 * where a PI without a node of its own resolves too.
+	 */
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
+			     "PI %d: failed to get vpwr supply\n", id);
+}
+
 static int
 devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 			       char *name, int id)
@@ -1111,6 +1173,16 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	 */
 	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
 
+	/* Check every PI supply before registering any regulator: a provider
+	 * that has not probed yet is the ordinary -EPROBE_DEFER case, and
+	 * unwinding it must not leave PI regulators behind.
+	 */
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		ret = pse_pi_check_supply(pcdev, i);
+		if (ret)
+			goto release_pis;
+	}
+
 	/* Register PI regulators. Once one of these exists, pse_pi_ops index
 	 * pcdev->pi[] and nothing here can unregister it again, so the array
 	 * must outlive this function. Failures below therefore unwind to
-- 
2.43.0

