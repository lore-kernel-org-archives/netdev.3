Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560F3B9D84;
	Thu, 13 Aug 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651660; cv=none; b=tMMZW4BwgmSA+4poYgIbnZv1ggmamYMDCrh2D1kpUoXAcVhI1P6/bnop5R6UZ+J0TCqgg4uIIl3F5jf+TUkD5wv66T+4kmbkdDSxnMfTbV/z+rNTZuDqXq5B2ulJ2ksjLfagl7GyTbZEF6pX6tJAjofWuQfE+FTu7toOo2W7YWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651660; c=relaxed/simple;
	bh=u3DHlTGWFgLMcs5qL2Q0i8KW5kYHW+fkh9Rin14ilkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyfgkTOl7pz4KKNtJBlvEseQGtLtM6mt5voE3dDQGXsfRlsjBaK3CJ3oFcfmQq6mOyQ1Zpn0DnuT60o4hs3oYa2bF5q+ohFNMMdwclBPsFxVX2/Z29o/+XTM0OUpWZVTPsKl/9Fkq+ZV6wZQdLfQXnnQjZ0Mns6gA/R5IjNhU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=EvB23b45; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="EvB23b45"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id E090DE838AA;
	Thu, 13 Aug 2026 22:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1786651655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9QcBwbciSMvTrnsWEgUvHaIM82H7XImwoRXFWGpk/g=;
	b=EvB23b45kOAYnS3CBhWlQ7+BNR5Yvtvf14MqCxQcXHvPQ3VkUTrPEcK5GAqASD7zffeabP
	0rP3SjMAeseK0ZY/NAtO+L6UBZUdwjINP2U657ZheWLTR/XJDyxVRYxisFMaYiKn+MJMqV
	4a+dxKSilkDkIEnflM6f6iPSmLJXXngbxAV0kU5KkNHBcXea5I501mpGpxL26z4wy9R6f7
	Xnwh0gi5R/msqr+kB6KoRisA3J5uWgZvyAKqifh6y3YieLv1CQhG6fJQum+m5s8xDA18uM
	o0zlD5pGaln9tv5anndWG8zln2OzwmrCWX2Ym7NB4n7/3kEw+Mw+R4plUD0ytg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id BqzJARCgtNM4; Thu, 13 Aug 2026 22:07:35 +0200 (CEST)
Received: from p14sgen5.. (163.6.106.80.static.otenet.gr [80.106.6.163])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 13 Aug 2026 22:07:34 +0200 (CEST)
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
Subject: [PATCH net v3 1/3] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Thu, 13 Aug 2026 23:06:51 +0300
Message-ID: <20260813200653.980170-2-github@szelinsky.de>
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

pse_controller_unregister() frees resources that its own asynchronous
event sources are still using:

 * The PI array (pcdev->pi) is freed by pse_release_pis() while the
   threaded IRQ handler pse_isr() can still be running. pse_isr() walks
   pcdev->pi[] (via pse_set_config_isr() and
   regulator_notifier_call_chain() on pcdev->pi[i].rdev), so an interrupt
   arriving before disable_irq() dereferences freed memory.

 * pse_flush_pw_ds() runs before disable_irq() and drops the power domain
   references, which can free pw_d->supply via __pse_pw_d_release().
   A concurrent interrupt reaches that supply through
   _pse_pi_disable() -> pse_pw_d_retry_power_delivery() ->
   regulator_request_power_budget(pw_d->supply), another use-after-free.

 * cancel_work_sync(&pcdev->ntf_work) runs after pse_release_pis(), but
   the notification worker reaches pcdev->pi too: pse_send_ntf_worker()
   -> pse_control_put() -> __pse_control_release() dereferences
   psec->pcdev->pi[psec->id].admin_state_enabled. Draining the worker
   after the PI array is freed is therefore also a use-after-free.

Reorder teardown so every asynchronous accessor is stopped first:
disable the IRQ, drain the notification worker, and only then flush the
power domains and release the PI array.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..6045b6c399c2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1114,11 +1114,15 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* Stop the IRQ and notification worker before freeing what they
+	 * reach: both touch pcdev->pi, and the IRQ also uses pw_d->supply
+	 * that pse_flush_pw_ds() drops.
+	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
 	cancel_work_sync(&pcdev->ntf_work);
+	pse_flush_pw_ds(pcdev);
+	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
-- 
2.43.0

