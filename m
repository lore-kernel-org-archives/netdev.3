Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE33AA9F4;
	Thu, 13 Aug 2026 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651662; cv=none; b=A0Nau4FDFwAjxiDHjv/9gPDAIBqywGw59+cMt/Lut9YEVDHP74FmePOyVkbpZZi4f38/UCahrq/Ln5tNck0DlfGG4QfvQOxB9UP4jIs8v7y/XhzxOtFHSxETiXOHGlrXK2hr9D9StB3hy3GUpskmqgUQurDXY1941XhhKW1DPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651662; c=relaxed/simple;
	bh=r2FzH+6sCsBe+vKb1AIjYlLVN30TTpHRYLC41l9NMZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrgQXR2JAbIrKOviZ8G7pqMULCQba+MmVLAzozBlxBUPXvt4kQzA0qwWyH/2mbbOUK5JZTvwRj6seAZ60ZsVhnnW3pF5JCsxMlk3gRfcLngraVZd820BETLLbvWfdK+9o/CJ/i8badtAu9YPoYRBWA2fbs6ncqP2XTlodEM8Jlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Iby07OJg; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Iby07OJg"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 91C88E838AC;
	Thu, 13 Aug 2026 22:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1786651658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXGNcgZRCvdWf27PIdvHS2QeS6Dxk20cF/pUf4vglEo=;
	b=Iby07OJghCEFlq3VXoRZ5bWkyl0EIrlvpw/YAsEX5uHtDrCn++9ZVMRTYkkQojBfRn30mg
	skMvUzI4I/J6iPEMcKJXCf8KrveRmAaSf3036YRHesTPmhd8Pf4foJGOupLaZzFJHRUXGi
	thlMHnpVuN3L6trPfheINCb9cImgiimUy/RxUez+yKbjxIjNQpWwfT9U6XlnORCFX/w+8i
	ZrT5EwOH6CdOHxCISsZlILcOiblR+ihUdXOpIOXydAyODDl/+dedx4ZfRd9PPvzvl3kM5A
	cvRmVnvPcYxYtdIJ3WIR63J8ZPDhGsXSm+tyFI7n4XfZRkVydd4vkYts2Cwzbw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id anJEhpy2HcKf; Thu, 13 Aug 2026 22:07:38 +0200 (CEST)
Received: from p14sgen5.. (163.6.106.80.static.otenet.gr [80.106.6.163])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 13 Aug 2026 22:07:37 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 2/3] net: pse-pd: guard regulator ops against freed PI data during unregister
Date: Thu, 13 Aug 2026 23:06:52 +0300
Message-ID: <20260813200653.980170-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813200653.980170-1-github@szelinsky.de>
References: <20260813200653.980170-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PSE PI regulators are devm-registered inside pse_controller_register(),
which runs before devres_add() arms the controller's own release in
devm_pse_controller_register(). On driver detach devres unwinds in LIFO
order, so pse_controller_unregister() runs first and frees pcdev->pi via
pse_release_pis(); the regulators are torn down afterwards.

When regulator_unregister() flushes a pending disable, the regulator core
invokes pse_pi_disable(), which dereferences pcdev->pi[id] (directly and
via _pse_pi_disable() -> pse_pi_deallocate_pw_budget()). At that point the
PI array is already freed, so this is a use-after-free. pse_pi_enable()
and pse_pi_is_enabled() dereference pcdev->pi[id] the same way and are
reachable by any regulator consumer that keeps a handle across the
teardown window.

Clear pcdev->pi after freeing it and bail out of the three regulator ops
that dereference it when it is NULL. Perform the kfree() and NULL store in
pse_release_pis() under pcdev->lock, and read pcdev->pi under the same lock
in the ops, so the NULL an op observes is authoritative even when the free
runs concurrently on another CPU: the op either sees the live array or
returns without touching freed memory.

The other three regulator ops (pse_pi_get_voltage(),
pse_pi_get_current_limit(), pse_pi_set_current_limit()) do not dereference
pcdev->pi and need no guard.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 6045b6c399c2..21ccb5146616 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -144,7 +144,13 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 		of_node_put(pcdev->pi[i].pairset[1].np);
 		of_node_put(pcdev->pi[i].np);
 	}
+	/* Free under the lock so the NULL store is authoritative against
+	 * the regulator ops that read pcdev->pi under pcdev->lock.
+	 */
+	mutex_lock(&pcdev->lock);
 	kfree(pcdev->pi);
+	pcdev->pi = NULL;
+	mutex_unlock(&pcdev->lock);
 }
 
 /**
@@ -421,6 +427,11 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	/* Controller may be unregistered (pcdev->pi freed) mid-teardown. */
+	if (!pcdev->pi) {
+		ret = -ENODEV;
+		goto out;
+	}
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
 		ret = pcdev->pi[id].admin_state_enabled;
 		goto out;
@@ -674,6 +685,11 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+	/* Controller may be unregistered (pcdev->pi freed) mid-teardown. */
+	if (!pcdev->pi) {
+		mutex_unlock(&pcdev->lock);
+		return -ENODEV;
+	}
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
 		/* Manage enabled status by software.
 		 * Real enable process will happen if a port is connected.
@@ -702,15 +718,20 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 static int pse_pi_disable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	struct pse_pi *pi;
 	int id, ret;
 
 	id = rdev_get_id(rdev);
-	pi = &pcdev->pi[id];
 	mutex_lock(&pcdev->lock);
+	/* Reached via the regulator core's deferred-disable flush after
+	 * pcdev->pi is freed on unregister.
+	 */
+	if (!pcdev->pi) {
+		mutex_unlock(&pcdev->lock);
+		return 0;
+	}
 	ret = _pse_pi_disable(pcdev, id);
 	if (!ret)
-		pi->admin_state_enabled = 0;
+		pcdev->pi[id].admin_state_enabled = 0;
 
 	mutex_unlock(&pcdev->lock);
 	return 0;
-- 
2.43.0

