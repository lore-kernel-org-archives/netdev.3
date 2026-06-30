Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AE3ED11B;
	Tue, 30 Jun 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810710; cv=none; b=VJBWb+vy11weeX+u8JqMB6o05kog3xsizzblOee0LmWSYC59dGl9mIp6mMelJXukDoBxeAUQM5mlhYgAYkCKt9eAVbqZ/nRyNyJdcCT5lLYFXbRm3GthXDMA8NHgz06xCycbmZ7Sn/mkhMj+OQST/dwFUKOoLJLLUeNYA4vcTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810710; c=relaxed/simple;
	bh=Xa/8+x3fbN/3+Jk52j6knMgpA06QVo/ahFSa00X/hN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5qilBdUY4tdPIlLvz/x6s77Ql4uDG5P/qS70KGWqaIXdbIzhZhBq/Yku1z0JYfQRPYkSKF/KCqLasyQcS2rZ1yKbj/SJskbDYgDTrVuPwbZvWeR0o7NtggvY6NWmlYrflte6PLdisHA4oK9x3P+J8ZxIm6DeRXxmnVWFdwSyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Voj/my/G; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Voj/my/G"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id E94CEE838E1;
	Tue, 30 Jun 2026 11:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782810701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8STXjNlKV0wvUn+1PYv95+ojGlTOJB8a3/kKnQWGP4=;
	b=Voj/my/GxRjwHkTglEAWrI01+QgHUKlySugH45hDlwzDDZ9AcXswhuOjhZ5YC9vVId+pLD
	XRYqPrUnFeeIyWv7KSJiEQ9u59zMdLaM0CTllLvQMo9sVTZiMdnnRix7gXinry/Q0C9Eg6
	Ya7y7QqQ3adYZqE2IxJrc3PFSROgAby155GJA0Q0exW7Inqs2JiDC9lPjgZJDqujbpXHnL
	pGha5mJq4oXy1e4Opjxq/GGfgqQqBND7ZacRL7Lahc5Acf4fzLmF1tBC3DPaeHlKRa1g2s
	pRd96CxjIxUPaij9++f+5/SFdHa+OAxUhUoU8ranQjWe9LS09p2J/c3ua8AlFg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id AvI9st0DCOLX; Tue, 30 Jun 2026 11:11:41 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 30 Jun 2026 11:11:41 +0200 (CEST)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v4 2/3] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Tue, 30 Jun 2026 11:11:24 +0200
Message-ID: <20260630091125.3162481-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630091125.3162481-1-github@szelinsky.de>
References: <20260630091125.3162481-1-github@szelinsky.de>
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
PSE_UNREGISTERED before the controller is removed from the list
(while it is still valid to dereference from a subscriber's
pse_control pointer targeting it).

With no subscribers yet, this is observably a no-op. A later change
wires the phy subsystem in as the first subscriber.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 3c4d09f1d6e4..0190fac33c78 100644
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
@@ -1148,6 +1151,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_UNREGISTERED, pcdev);
+
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	if (pcdev->irq)
-- 
2.43.0

