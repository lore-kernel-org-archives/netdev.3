Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743367;
	b=bdri7qRCnMzXttAf7fzRXgbiBHV+gOkiQNuURYd8mad6SGKtCR3HP+8GGnFfpMdZjb22
	 nDmvOuWeXLt4IkJopKHXZ95sdc+BA9bltrPqNJVgXNfpg6Ouc2z+iXG+yJr2rYUA8mHW2
	 nHvaFVGsOr5m1Ly3AX2PtaiXmzHmy9zF27oi/arHrkmUhyVj31OCwT7xrNmIFWzhvDQeY
	 uIz+P7dAyVsqpUm6rFDnkKCbgf5EcKnzWLzFTitokF1JPlWFHEzdn362DOBmUBWalDXM4
	 wybNaIQrCOgSgx6E8dpH0Ga5Eara+zuKHKPd+y4pyeTpHbrJPxOrBVzwm4yp60w+QoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2kfmdaXcSuOz7RwfaYopIcZepxe7U504MJR/bucejts=;
	b=Xqche9UnHPfHjHposZr7XP+tiHxNIaDbAWZsQchiDEKq1qoAa12Ef1+PCzjOh9YJu3my
	 jKOeJDPb0vVzNOGX+YUdShI58li04s52x9lDimuF+SbkpsIg/dHEfICtzHMZZ3IrzUA4H
	 y1XSgYZqaiJEaIg4aa8YU3PTCloHVPUZhF66PUclQYuKAdlg/O1wCPnAy5O0N5Yo25lJu
	 Sw8vH1KQCqLs//ughNlcCc5rcYGldwdBpX0aLy77jMLpzV100Cm1p402gkG/nPajFA5xQ
	 W7r1Ghw84iBb1dSfcp5CIYI0tyWB4/XNdlDpoaSD0B3KbyaA+DEwcvzfiymx8RJBFzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=PeNt7mCo;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52505606A32C;
	Tue,  3 Nov 2026 22:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52505606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=PeNt7mCo
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 50924E836CF;
	Tue, 03 Nov 2026 23:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kfmdaXcSuOz7RwfaYopIcZepxe7U504MJR/bucejts=;
	b=PeNt7mCo6zmzOiD+62uuk7FTqUqAUxTwgPXyWCNSVsnk9kUmOHOSt1c/XSO8r2zP2XUcZ5
	r8NP7sSyDct3YAniRPMC3mfhhwUcn69F645G0dHzL1KsyNwckrst2Iwgol0JxGidNx5QFt
	D4hoi+J1PX9MxzCfkz7OCZXZHbLSn2iPmQgYB2Ed3GJh7Q2rDj1jQEY+bmKywAONdgWbmb
	0o1FOBXEYn+oEgNFgQ4mptFccddSbeIfT4iOu6lRwRUoS0aocyPPEPd82IUyQ+zb1z9RDz
	JthfwqG6xmUxUW3lDUrB7+mRO/v/HNurvyECgNbPa2FBwplAgTLMSJjYaXem1Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id JCJ0Bja0Hk2J; Tue,  3 Nov 2026 23:02:43 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:42 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 09/14] net: pse-pd: unregister from the controller list before freeing PI data
Date: Tue,  3 Nov 2026 23:02:12 +0100
Message-ID: <20261103220217.1131971-10-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103220217.1131971-1-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_unregister() frees the PI array while the controller is
still on pse_controller_list, and only removes it from the list
afterwards. of_pse_control_get() walks that list under pse_list_mutex
and reads pcdev->pi[i].np in of_pse_match_pi(). A consumer that probes
at that moment can read the freed PI array.

Remove the controller from the list first, before the worker is
drained, the power domains are flushed and the PI array is freed. Both
sides take pse_list_mutex, so once the controller is off the list, no
new lookup can find it, and a lookup that is already running finishes
before the PI array is freed.

Found by code inspection. Not reproduced.

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 36f8e4e7d191..43f6e304fe5e 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1185,13 +1185,17 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
+	/* Unlink before tearing down: of_pse_control_get() walks the list
+	 * and reads pcdev->pi[], and must not hand out a new control for a
+	 * controller that is going away.
+	 */
+	mutex_lock(&pse_list_mutex);
+	list_del(&pcdev->list);
+	mutex_unlock(&pse_list_mutex);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
-	mutex_lock(&pse_list_mutex);
-	list_del(&pcdev->list);
-	mutex_unlock(&pse_list_mutex);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
 
-- 
2.43.0

