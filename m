Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEC43B6FD;
	Sun, 27 Sep 2026 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536762; cv=none; b=darTCKN2gM0w9HtGD09JI0GFGCIOHK7iaFmveyrU9hP8YeyE3UTX/pbZysHzVbCCAD8R0zvH3hEIY9ZlBJwo4LSdnjN+92g7ast0yg2ivP6kYmlfL3Ams7mPkzLtXlAoKkAilZ+g20q45RpduRbegOWS6IfWSjhSWCD2HJFtcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536762; c=relaxed/simple;
	bh=If139doT5clqVyafGpGmr/yBWngWYBLdtSsE6FWjLyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGxsE0w9qDTrTYv1DEDj7CTAjL6emSAAXiAviJ421jp+xuaUxtBbYhFFjOKhL9o/7Jtn+Xkb4xHGNVu6humFXWlI87Lsjut/B2uV/mpZpkR7F3I/JZrq4SWjqsg94UWJQDwmgjYW0DaF93/pBBL/uQK4kEoLT/CdZLRNXZDw9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Li16SJQc; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Li16SJQc"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 564D1E839CF;
	Sun, 27 Sep 2026 21:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1790536758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WExJJAg0voqE6fTmjdSr9UiouOHjDudvmw6mNcFY1R4=;
	b=Li16SJQcCUwziHRKllCMbD8gvBVEuoEYwowo2MthLCwRPL6WVjhbxq3JQpQ1oUZqGbWkhh
	/tllsP31dfRku3T5MTTlTlz8+2V3UGX6XHF9ljZ34kDuwYap6gEuCcimESl4ONjfGrME/f
	/19jmZY8++MJnKeLJxIvPzVWvVZSEGxYxaf/mcJar+ZD4GUS91dm8V+/mfB582wOLq4jdV
	GXyoOgdeeVtWcdhanqAVkvCPqQA1iw7H2FTuMT0uHnu1UDu8oac/jUVJIqeTcDy0uCSjPJ
	XmN0RFJOJVy/LF5vxQwA04Rh92cLCKr5v5h35YxG5vhiE8Epz0yxaM7ujGrrFw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id po01nNYubsXE; Sun, 27 Sep 2026 21:19:17 +0200 (CEST)
Received: from p14sgen5.. (ip-077-020-250-175.vkd66.pools.vodafone-ip.de [77.20.250.175])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 27 Sep 2026 21:19:16 +0200 (CEST)
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
Subject: [PATCH net-next v7 2/5] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Sun, 27 Sep 2026 21:18:47 +0200
Message-ID: <20260927191850.1370515-3-github@szelinsky.de>
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

From: Corey Leavitt <corey@leavitt.info>

Hook the newly-introduced pse_controller_notifier chain so that
pse_controller_register() fires PSE_REGISTERED after the controller
has been added to pse_controller_list (i.e. is now resolvable by
of_pse_control_get()), and pse_controller_unregister() fires
PSE_UNREGISTERED once it has been taken back off, while pcdev and
everything a subscriber's pse_control points at are still valid to
dereference.

No subscriber exists yet, so the event itself does nothing; a later
change wires the phy subsystem in as the first one. The reordering below
is not a no-op, though - it closes a teardown race that is reachable
today, with no subscriber involved.

Unregistration is reordered around that event, because a subscriber runs
arbitrary teardown inside it.

The controller is unlinked first. of_pse_control_get() walks
pse_controller_list and dereferences pcdev->pi[] through
of_pse_match_pi(), so a lookup racing the teardown could otherwise reach
an array that pse_release_pis() has already freed. Subscribers are handed
pcdev as the event data and do not need it on the list, so taking it off
first costs nothing and closes that race for every caller, not just the
ones this series adds.

disable_irq() moves up for the same reason: pse_isr() queues
notifications and reaches pcdev->pi, and nothing after it re-enables the
interrupt.

cancel_work_sync() moves up, above the frees, but stays below the event.
A subscriber dropping the last pse_control reference reaches
__pse_control_release(), which calls regulator_disable() if the PI is
still on. With the static budget strategy that retries any port on the
same power domain waiting for power, and if the domain is still over
budget it sheds a lower priority port through pse_disable_pi_pol(),
which queues a notification and calls schedule_work(). Draining the
worker before the walk would therefore leave work queued behind it,
racing the kfifo_free() below.

That retry does more than queue work: _pse_pi_delivery_power_sw_pw_ctrl()
calls ops->pi_enable(), so a port on the controller being torn down can
be energised from inside the event. The driver is still bound at that
point - the walk runs before pse_release_pis() and before devres
unwinds the PI regulators - so the call is legal, but it is worth
naming rather than leaving to be discovered.

Draining after the walk also keeps the worker's own transient
pse_control reference - taken by pse_control_find_by_id() - from becoming
the last one after pse_release_pis() has freed the array.

The frees move the other way. pse_flush_pw_ds() and pse_release_pis()
are the first two statements today, ahead of disable_irq() and
cancel_work_sync(); they end up last here. That ordering is what the
race fix consists of: until now pse_isr() and the worker could both
reach pcdev->pi[] after pse_release_pis() had freed it. They also have
to stay below the event, because the release path it runs reads
pcdev->pi[] and pi->pw_d->supply.

The series at

  https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

makes a related reordering for net, independently of any subscriber, and
the two will conflict when it back-merges. The order there is not
identical: it leaves the unlink below cancel_work_sync() and
pse_flush_pw_ds(), having no event to place. The merged function wants
the order here, which contains that fix.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/pse-pd/pse_core.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 84c734ed4553..56cecf60c5c4 100644
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
@@ -1148,15 +1151,36 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* Stop the interrupt first: pse_isr() queues notifications and
+	 * reaches pcdev->pi, and nothing below re-enables it.
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

