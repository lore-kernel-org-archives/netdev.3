Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98C363C5A;
	Sun,  6 Sep 2026 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709183; cv=none; b=OFDnyp6JQpgOKgm+Ry1q0rhy0ZAnXkraKT8aeNnIcgHxLI/oMqV8Ui8ueLxyIv4Djb+cwCVvyKv1udWDzWBIKxXhr3WjXVOddC3J0CHy1Q9gAs9XmkwMYQPe4pHNNOK+TiNCDVeDfIvTOYeiJc+fbMd/sCwmEQK7JeQLnkqNvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709183; c=relaxed/simple;
	bh=Xa/8+x3fbN/3+Jk52j6knMgpA06QVo/ahFSa00X/hN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJFMDBU7lBr8M4K2Wlxh9VDEfTCBP7E5JQRx/0ibw8lA7Ktiaet/0SoxhOK67OhfbB8QU9yT0KSnYbEKwhc/XhgzzUw136x76viFr5312Ds3UnLKVRAY6A4daBqrhjvx6WAkPrzOBfN8IIqiiogytxp7kUlHT5Y2FzG5Y2/NLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=knzWzB8b; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="knzWzB8b"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 81F8DE8393B;
	Sun, 06 Sep 2026 17:31:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1788708703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8STXjNlKV0wvUn+1PYv95+ojGlTOJB8a3/kKnQWGP4=;
	b=knzWzB8bZRbrXBnRJD24n8OvzycjNOrKWW4ebduPEsWAfaFuu52QK+UHjqpmELHUCXmoKB
	51ylqXnNLqILlsimNRWKqRqwAErs7KVgefTY0FsMTDTteKtwgShD2asNyfJ/Zj+pbTNlpe
	HogkyDYCV0kaUU4sK9cX00JAnxYI/gpQDE8FPDnoP1yJ9qINxYpNMV5ejFuf6R4PIjP2iC
	/WT1oPh2qnAc+OJsEsG2N29rlCSeYc4Xzmzv3eZhyozgl1XIu0rWd9ky42Z9wknexzayif
	qhHJmq/5PbEpj2qxkbpCP7e+ViiCG26SbQZ2MJk5fhsNDqc1Ores7a9wZacwgw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Exu2nY8tdKaB; Sun,  6 Sep 2026 17:31:43 +0200 (CEST)
Received: from p14sgen5.lan (p578611d6.dip0.t-ipconnect.de [87.134.17.214])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 06 Sep 2026 17:31:42 +0200 (CEST)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v6 2/5] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Sun,  6 Sep 2026 17:30:59 +0200
Message-ID: <20260906153102.959217-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906153102.959217-1-github@szelinsky.de>
References: <20260906153102.959217-1-github@szelinsky.de>
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

