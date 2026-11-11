Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431884;
	b=bFLwsSXO0dpgCYFc2HNaOqZWb+S3BQJU2Urh9No3+tuoGSiI4WFUDgnKtIPdhZm1zbV/
	 NyoQfMI5aWRjbQ0uN6P/hLNcxRvWL/qM/HSKOnWmEPuJZ3f9BQ1E2Ta1TOWm4me3YtAzb
	 4I5jP6wY/GWgECzZNeTLJnKdX3vhZOHSZsQhuJx7M7VI6oqO+wNCNXpKCd9Gi0mXmTh9q
	 Hx1rWp5Mu0G/0Iki3pLWLIPzv6DEU1TMR0+TkMoKN7sjKVrcO/PYfbRgkM0sFbI2BPvx7
	 lTktpfzh6a1EUNe3fy5RA+PSK/o5wrGCpKBplP9h/q7K7kh0xDmtEEKJB+0EEZhshBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=eGn8VcXNFRYeA3vfzpI8uTIU/SszF344kfI8OQXone0=;
	b=oXID67fxULeCN7/vR/Z8oADYZRKbUGaLIr6dm1SCekSg2XqxSLLtE0fP7ESjwT2szPYM
	 qFJIw04heCdjr2Y9Mq+f24bZXk+tKqMtBD1XThC04BJPWHJT6/aBOjy+KbpBotPrqpnTx
	 C4/l2KEULda8oWsiEQYWGDhHeWKx2ZqcK+5K8jhBCMjvTt/d/uCLRjUsmey1iX7ts/HOw
	 REEm01IBdpWD7i10AYG0vqnlS1jtrDJp2IHuMlc4EYgBSWtoSz7zXzmqI3mReBTzdp0xg
	 VEqcLCkETrUFESXwF47TgV7I38rkdU9KQ4TO3IVZOFZaH+naWPk3AHHJ5qV+ijJ677A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=JOcYVFUP;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624B606A8AF;
	Wed, 11 Nov 2026 21:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4624B606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=JOcYVFUP
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 416AAE833FB;
	Wed, 11 Nov 2026 22:18:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1794431881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGn8VcXNFRYeA3vfzpI8uTIU/SszF344kfI8OQXone0=;
	b=JOcYVFUPvbzrFtrtU/PWcB6wuWNhR4+FIhuWcEvOxh51eeOZmd6toC1Nq6zNW24V7ITd9I
	gHZausPLBNyUx47gQ1PHd0ivWAGvchpqqTwi692DnuoWXumAO2T6PWhLkVTSSf5PsaFQQl
	meCae5ik888Z82v+afrnARAUELdqBCPMLkjm9WKBm4yj89jLfCn450E8jBpDEXk7SqY0oG
	jT9DwcsytIORIMCysSw4uAo1qNesVKxQCE/7rRo/GlaUC2X+R+MZCgNEPLR867ctKukMVV
	tUetHQbari/mBQaAIo4BmQ2MyBc6MfOns/3eKRRoX4EuieDPS1Nt7hor16FsiA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id qc_mdTLLyAqH; Wed, 11 Nov 2026 22:18:01 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 11 Nov 2026 22:18:00 +0100 (CET)
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
Subject: [PATCH net v4 10/14] net: pse-pd: keep the PI data until the PI regulators are gone
Date: Wed, 11 Nov 2026 22:17:27 +0100
Message-ID: <20261111211731.3193796-11-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111211731.3193796-1-github@szelinsky.de>
References: <20261111211731.3193796-1-github@szelinsky.de>
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

pse_controller_unregister() frees the PI array, but the PI regulators
are only unregistered after it, by devres. Until then their ops still
run, for example on a read of the regulator's sysfs "state" or when a
consumer enables or disables the PI, and they read the freed array.

Free the PI array from a devm action that is added before the PI
regulators, so devres frees it after them. This also frees it when
registration fails, where it was leaked before.
A consumer that still holds the PI after the unbind is an older
problem that this patch does not fix, see the cover letter.

This needs "net: pse-pd: do not tie a shared power domain to its
creator's devres" and "net: pse-pd: stop async event sources before
freeing PI data in unregister". Without them, the regulator ops still
reach a freed power domain, or a kfifo and work item that are already
torn down.

Triggered in QEMU (arm64, KASAN) with a test-only PSE controller:
reading the PI regulators' sysfs "state" while the controller unbinds
gives

  BUG: KASAN: slab-use-after-free in pse_pi_is_enabled+0x294/0x2d4

With this patch it is gone.

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a7dfa7cdbe3a..c13bbf126a9f 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -149,6 +149,11 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 	kfree(pcdev->pi);
 }
 
+static void devm_pse_release_pis(void *data)
+{
+	pse_release_pis(data);
+}
+
 /**
  * of_load_pse_pis - load all the PSE PIs
  * @pcdev: a pointer to the PSE controller device
@@ -1122,6 +1127,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (ret)
 		return ret;
 
+	/* The PI regulator ops use pcdev->pi until devres unregisters the
+	 * regulators, so free it from devres too, after them.
+	 */
+	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
+	if (ret)
+		return ret;
+
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
@@ -1192,7 +1204,6 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	mutex_unlock(&pse_list_mutex);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
-- 
2.43.0

