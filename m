Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA43C9891;
	Sun,  4 Oct 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132183; cv=none; b=PTqmJoPNAf/TIE7wqo7J7IAUtcehobelD8S55u/QnQcV97AH9Ck+K7+/8trx9HwSg5aTBiNFQmxJd4npfm8jrmprLjzq1QH4zTcBuvQgBVqTL1bF9pVLqUF+J44yfdR1ZR9mC1BzxUjqa1wB90H8TpdNPNyQ1wqFruFp3UoCq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132183; c=relaxed/simple;
	bh=03iHJzjnQfllFNTey4CXec5eXbG2fVTkWu0T1iWejEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfbIYcGl7LK9fEg1YyQGmqlEqHf9+TWD6ITFadziitCKcFLD2Pe/5/ukbLvJo+MTh6Dd2VBMqrC8lQ+4qiz2PDsfKNlQGM05oeWR2+SXHkOoIMGY6+aNgtpJjpk+Moojg9zyF6VqC3G8yVwKoxyUDoLXTPf+x9t/C/GD2XvaCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Ww0DdLUE; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Ww0DdLUE"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 23B1DE83537;
	Sun, 04 Oct 2026 18:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sstbnbl28ju9T3kaSxvQxq+rgISUMtbzICRgOFj/m6w=;
	b=Ww0DdLUEFhodSvrG1MitkxSkrnAOhjUfeUe+xKsPT4pghXhKRG3iyxMmaqqPqGbSsAlvKq
	Dz6LeBPdfXa/uypCS4T8YGWU/kpe8ZvZh1Kwoqyzgd0kaNk0KnngJ1+3xUEizYi7OTb48R
	vC7XJv4hHgBVPBjnBjJvJgT+RGgx+plI/PulB8Cjuc1JF/SSs/LRe0wrF2ow3wRDwDazlP
	bNS4MNRA91j9M1goCmZOUmFX46HPmpKPNsmwKC1e5CyI0eWmn2jZasqZOR5fFbgvOyR4hI
	P+zILEXNH1mco4TywU+WccYT+JYi9/Dujl2d41J4gHadtnhamjDS8bgVXpTepg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id s9tKcvLdFTh0; Sun,  4 Oct 2026 18:42:51 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:50 +0200 (CEST)
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
Subject: [PATCH net-next v8 5/7] net: pse-pd: check the PI vpwr supply before registering the controller
Date: Sun,  4 Oct 2026 18:42:17 +0200
Message-ID: <20261004164219.1161294-6-github@szelinsky.de>
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

Each PSE PI regulator is registered with a "vpwr" supply, which the
bindings expect the board to provide via vpwr-supply in the PI node.
The regulator core deliberately treats an unresolved supply at
registration time as non-fatal and lets registration succeed.

That leaves pse_controller_register() completing for a controller whose
PIs cannot be handed out: regulator_get_exclusive() in
pse_control_get_internal() resolves the supply itself and returns
-EPROBE_DEFER until the provider appears, so of_pse_control_get() keeps
failing for this PI even though the controller is registered. A
consumer that only retries when a controller registers - which is what
phylib becomes once it attaches from the PSE notifier - then never gets
its PI.

Check every PI's supply first, before any regulator of ours is
registered, so the error surfaces in the PSE driver's own probe and
deferred probe retries it there. The check skips exactly the PIs the
registration loop skips, so a controller with no pse-pis node - every
PI has a NULL np but still gets a regulator - is covered too, through
the controller device.

The check follows both stages regulator_resolve_supply() uses: the PI's
own node, then the controller device. A vpwr-supply written once on the
controller node is invisible from the PI node, while the core finds it
at stage two. pse_pi_check_supply() answers from the PI node and
returns 1 when it cannot; pse_controller_check_supply() is then asked
at the first PI that needs it and not again, since its answer is the
same for all of them. Asking it inside the loop keeps the order the
core resolves in, so the first PI to fail is the one reported, and a
later PI's hard error cannot replace an earlier PI's -EPROBE_DEFER.

The PI node is consulted only once its own vpwr-supply phandle
resolves. of_regulator_get_optional() falls back to
of_get_child_regulator() on the device node, which walks every
descendant of the controller, so a PI naming no supply of its own would
otherwise be answered from a sibling PI's before the controller node
was consulted. The core reaches that sibling walk only at its second
stage, after the controller's own vpwr-supply.

-EPERM is treated as resolved: it only means another consumer holds the
provider exclusively, which regulator_resolve_supply() never asks about.

It is not a full replica. The core also defers while the supply
provider's parent device is not yet bound, which regulator_get_optional()
does not check, so a PSE probe interleaving with the provider's own
probe can still pass, and nothing retries that PI until the next
PSE_REGISTERED or a phy re-registration. fw_devlink only prevents this
when vpwr-supply is on the controller node; one in a pse-pi node only
gives the controller a SYNC_STATE_ONLY proxy link, which does not hold
its probe back. Closing that would mean asking the core about
rdev->supply after registration, when the PI array can no longer be
released.

The checks run after setup_pi_matrix() and before the registration
loop. They cannot run earlier: a PI's vpwr-supply may name a regulator
the controller registers in setup_pi_matrix() - microchip,pd692x0.yaml
points its pse-pi nodes at the manager regulators
pd692x0_register_managers_regulator() creates - so an earlier check
would defer forever on a supply only this driver can provide. They
should not run inside the loop either: ti,tps23881.yaml puts pse-pi@0
on vpwr1 and pse-pi@1 on vpwr2, so "one PI resolves, the next defers"
is the ordinary case, and deferring after the first PI regulator exists
would leak the PI array on every retry.

What this placement does not recover is anything setup_pi_matrix() has
already claimed. pd692x0 requests a power budget on its manager
supplies there and frees it only from that function's own error labels
or from remove(). That is true of every existing failure after
setup_pi_matrix() too, and the new deferral does not hit it with the
documented binding, since a pd692x0 PI's supplies are the managers it
has just registered. A board pointing a pd692x0 PI at an external
provider would; that cleanup belongs in the driver.

This widens what a missing provider costs: before, only the PI on that
supply failed, and only when a consumer asked for it; now the whole
controller defers until every provider has appeared. That is the normal
contract for a regulator consumer, and the alternative - a controller
that advertises PIs it cannot hand out - is the bug being fixed.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 126 ++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index eeefbf25e671..e560833ad034 100644
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
@@ -860,6 +861,98 @@ static const struct regulator_ops pse_pi_ops = {
 	.set_current_limit = pse_pi_set_current_limit,
 };
 
+/* The regulator core treats an unresolved "vpwr" supply as non-fatal and
+ * retries it on its own later, which would leave this controller able to
+ * register while of_pse_control_get() still fails with -EPROBE_DEFER for
+ * this PI. A consumer that is not itself retried by deferred probe -
+ * phylib, once it attaches from the PSE notifier - would never get it.
+ * Check the supply up front so the PSE driver's own probe defers instead.
+ *
+ * This is the first of the two stages the core uses, the PI's own node.
+ * pse_controller_check_supply() is the second, the controller device.
+ * Neither get falls back to the dummy regulator, so a PI that names no supply
+ * anywhere still reports -ENODEV and keeps its existing behaviour - the
+ * core resolves it to the dummy when the PI regulator is registered.
+ *
+ * The PI node is consulted only once its own phandle is known to resolve.
+ * of_regulator_get_optional() falls back to of_get_child_regulator() on
+ * the *device* node, which walks every descendant of the controller, so a
+ * PI that does not name a supply itself would otherwise be answered from
+ * a sibling PI's and pass before the controller node is ever consulted.
+ * The core reaches the same sibling walk, but only at its second stage
+ * and only after the controller's own vpwr-supply has had its turn - so
+ * the gate is what keeps a controller-level supply from being masked.
+ *
+ * Return: 0 if this PI needs nothing more, 1 if the controller device has
+ *	   to answer for it, or a negative error.
+ */
+static int pse_pi_check_supply(struct pse_controller_dev *pcdev, int id)
+{
+	struct device_node *np;
+	struct regulator *supply;
+	int ret;
+
+	/* Skip exactly the PIs the registration loop below skips, so every
+	 * regulator that will be created is covered.
+	 */
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
+	/* -EPERM only says someone holds this provider exclusively, which
+	 * the core's own resolution never asks about. The provider is
+	 * there, so this PI is fine.
+	 */
+	if (ret == -EPERM)
+		return 0;
+	/* Only -ENODEV moves on to the second stage; a provider that has
+	 * not registered yet gives -EPROBE_DEFER, which is the case worth
+	 * catching here.
+	 */
+	if (ret == -ENODEV)
+		return 1;
+
+	return dev_err_probe(pcdev->dev, ret,
+			     "PI %d: failed to get vpwr supply\n", id);
+}
+
+/* Second stage of pse_pi_check_supply(). A vpwr-supply on the controller
+ * node covers every PI, and is where a PI without a node of its own
+ * resolves too, so the answer is the same for all of them - ask it once,
+ * and only if some PI needs it.
+ */
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
+	if (ret == -ENODEV || ret == -EPERM)
+		return 0;
+
+	return dev_err_probe(pcdev->dev, ret,
+			     "failed to get vpwr supply\n");
+}
+
 static int
 devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 			       char *name, int id)
@@ -1082,6 +1175,7 @@ static void pse_send_ntf_worker(struct work_struct *work)
  */
 int pse_controller_register(struct pse_controller_dev *pcdev)
 {
+	bool ctrl_supply_ok = false;
 	size_t reg_name_len;
 	int ret, i;
 
@@ -1116,6 +1210,38 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			goto release_pis;
 	}
 
+	/* Check every PI supply before any regulator of ours is registered:
+	 * a provider that has not probed yet is the ordinary -EPROBE_DEFER
+	 * case, and unwinding it must still be able to release the PI array,
+	 * which it cannot once a PI regulator exists.
+	 *
+	 * This has to stay after setup_pi_matrix(). A PI's vpwr-supply can
+	 * name a regulator the controller itself creates there - pd692x0's
+	 * pse-pi nodes point at its manager regulators - so checking any
+	 * earlier would defer on a supply that only this driver can bring
+	 * up, and it would never probe.
+	 */
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		ret = pse_pi_check_supply(pcdev, i);
+		if (ret < 0)
+			goto release_pis;
+
+		/* The controller device answers for every PI that its own
+		 * node cannot, so it is asked at the first such PI and not
+		 * again. Asking it here rather than after the loop keeps
+		 * the order the core resolves in, so the first PI to fail
+		 * is still the one reported.
+		 */
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

