Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB63C09F2;
	Sun,  4 Oct 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132169; cv=none; b=g9cr5IdRBCS8IA0TgstiybMY8NwwK3TrQtE6fa6KpMXX4dhrq9VPBL6mjkwAQJdPDc30AHrCibj2MUY4ZCm4/YnWGVBEjMzkZHxNKNF/wh8/J+f/BKMCg3Q0Oiofkljmn0l5VryhUUL8AkdPWN8ol8U6icaiXlViMw8ab75hMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132169; c=relaxed/simple;
	bh=ywwJAoqcdFpD+K6FkslI+8k+cy+ATZiLDl9OpChncSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBeBFyLS94vRpY8vvgXJEL2/6Jq6alBPU0e71TUCmhHEYHdTOVyEe4VUSBTmY2AHD9QGYr3byqyWrYyIQHkYoJzdfPEd1UPphyPxiBOEr70G50DtWfZghpsJ/dKX1aTYpBLjHSOASpX0xocjuj5Lh8P+/MSUZx2S3RlWAcE3zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Sj/uQcF3; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Sj/uQcF3"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 25B2AE8387F;
	Sun, 04 Oct 2026 18:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1791132165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pw2Q3ir/47+Zdw3sDAThQbrLxu/ZhqhjETOKk8+EyTM=;
	b=Sj/uQcF3YOYA2vSv2jLeEC9DkxJDrTzjrH6TTIUZt2JEbYgZQyuICJCMB/DMxSfb6ODPTr
	YyL9/J1tUh2P+8rrveWzCo0+5508xsQTh356xnNhYkKO8/i/WRJmd1XwM70tvdRh3Q3CA7
	rx/wKxKYW1SxvwuvQBEUvHCR8f+bhFQdLEFMitOawmrztN5Y1BI+ArDni6zYq4IcWcn03y
	H9K8iNxAgbfWVz8AQ+2JHuDyk4i7UJAWRi6ZduNj6PLrXxi+eIGaUAtHsuovMWVHDrRe1P
	atjSS5NtM1Ap3eHyWepaZvXgyFCzYUcF+VVMtenPSC72y55BARL29Z+JvTTZEA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id nbYlLZMwolsK; Sun,  4 Oct 2026 18:42:44 +0200 (CEST)
Received: from p14sgen5.lan (86-103-67-55.ip.tng.de [86.103.67.55])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 04 Oct 2026 18:42:43 +0200 (CEST)
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
Subject: [PATCH net-next v8 2/7] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Sun,  4 Oct 2026 18:42:14 +0200
Message-ID: <20261004164219.1161294-3-github@szelinsky.de>
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

From: Corey Leavitt <corey@leavitt.info>

Hook the pse_controller_notifier chain so that pse_controller_register()
fires PSE_REGISTERED after the controller has been added to
pse_controller_list (i.e. is now resolvable by of_pse_control_get()),
and pse_controller_unregister() fires PSE_UNREGISTERED once it has been
taken back off, while pcdev and everything a subscriber's pse_control
points at are still valid to dereference.

No subscriber exists yet, so the event itself does nothing. The
reordering of pse_controller_unregister() around it is not a no-op,
though: it closes a teardown race that is reachable today, with no
subscriber involved.

The frees move to the bottom. pse_flush_pw_ds() and pse_release_pis()
are currently the first two statements, ahead of disable_irq() and
cancel_work_sync(), so a concurrent of_pse_control_get() and the
notification worker can reach pcdev->pi[] after pse_release_pis() has
freed it, and so can pse_isr() for a driver that requests its irq
before registering. They also have to stay below the event, because the
release path a subscriber runs reads pcdev->pi[] and pi->pw_d->supply.

The controller is unlinked before the event and before anything is
freed. of_pse_control_get() walks pse_controller_list and dereferences
pcdev->pi[] through of_pse_match_pi(). Subscribers are handed pcdev as
the event data and do not need it on the list, so taking it off first
costs nothing and closes that race for every caller.

disable_irq() moves up for the same reason: pse_isr() queues
notifications and reaches pcdev->pi, and nothing after it re-enables
the interrupt. On tps23881, the only in-tree user of
devm_pse_irq_helper(), the irq is requested after
devm_pse_controller_register(), so devres has already run free_irq()
by the time this runs. The move is what makes the ordering hold for a
driver that requests its irq earlier.

cancel_work_sync() moves above the frees but stays below the event. A
subscriber dropping the last pse_control reference reaches
__pse_control_release(), which calls regulator_disable() if the PI is
still on. With the static budget strategy that retries any port on the
same power domain waiting for power, and if the domain is still over
budget it sheds a lower priority port through pse_disable_pi_pol(),
which queues a notification and calls schedule_work(). Draining the
worker before the event would leave work queued behind it, racing the
kfifo_free() below. Draining after it also keeps the worker's own
transient reference, taken by pse_control_find_by_id(), from becoming
the last one after pse_release_pis() has freed the array.

That retry can also call ops->pi_enable() through
_pse_pi_delivery_power_sw_pw_ctrl(), so a port on the controller being
torn down can be energised from inside the event. The driver is still
attached at that point - the event runs before pse_release_pis() and
before devres unwinds the PI regulators - so the call is legal.

The drain is not yet final on its own. A pse_control holder that does
not subscribe - every phy today, since fwnode_mdio hands out handles
that only phy_device_remove() releases - can still reach
pse_disable_pi_pol() from the ethtool path and queue work after it.
That is how the tree behaves today and this does not widen it; it is
closed once phylib releases its handles in the event under a common
lock.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
Co-developed-by: Carlo Szelinsky <github@szelinsky.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---

Notes:
    This conflicts in pse_controller_unregister() with the net series at
    https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/
    which reorders the same function without an event to place. The
    resolution should take the order here, which already includes that
    reordering; the cover letter has the merged function.

 drivers/net/pse-pd/pse_core.c | 37 +++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 84c734ed4553..dc261beb6170 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1138,6 +1138,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
 
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_REGISTERED, pcdev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
@@ -1148,15 +1151,41 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* Raise the interrupt's disable depth before anything is freed.
+	 * pse_isr() queues notifications and reaches pcdev->pi, and nothing
+	 * below re-enables it. For a driver that requests its irq after
+	 * devm_pse_controller_register(), devres has already run free_irq()
+	 * by the time we get here and this only bumps the depth - the
+	 * ordering does not rely on that, so a driver requesting the irq
+	 * earlier is covered too.
+	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
-	cancel_work_sync(&pcdev->ntf_work);
-	kfifo_free(&pcdev->ntf_fifo);
+
+	/* Unlink before the event: of_pse_control_get() walks
+	 * pse_controller_list and dereferences pcdev->pi[] through
+	 * of_pse_match_pi(), so no lookup may still reach this controller
+	 * once its teardown starts. Subscribers are handed pcdev as the
+	 * event data, so the notifier does not need it on the list.
+	 */
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
+
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_UNREGISTERED, pcdev);
+
+	/* After the event, not before. A subscriber dropping the last
+	 * pse_control reference reaches __pse_control_release() ->
+	 * regulator_disable() -> _pse_pi_disable(), which can end up in
+	 * pse_disable_pi_pol() and queue a notification of its own, so a
+	 * cancel_work_sync() placed above the walk would not stay drained.
+	 */
+	cancel_work_sync(&pcdev->ntf_work);
+
+	pse_flush_pw_ds(pcdev);
+	pse_release_pis(pcdev);
+	kfifo_free(&pcdev->ntf_fifo);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
 
-- 
2.43.0

