Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3244499A4;
	Sun, 18 Oct 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311561; cv=none; b=au/umyTGplyfcdfUrlHZQvE/41+R7tH7dUfyqv2mMckBnllPTjhmwOnbjruZa77kID3Vs7HvxMhGB0ZhTmFGCGx5CG1yH7zIvG5HYObjuJ+XHdNp8l24ly/gU+tiLQSdgyZxlptyGSRHzfXoqIJvWm/hLsn3/DSUMmXbcuxSk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311561; c=relaxed/simple;
	bh=82Pk5DrSgjQFbdEOH1hzPi6x+5rLQhPf6ejBMUb+9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFaKD1sosNw4XArZ7YGjhJU6TRl71gOzeG456hL/94EaO+DNXuUMPr8qhHPvolojfvC2wLshjLQ8kxAH+8efUPcwtyYltZxX5b+m3ASaHctbxYPGirZIVDXrx175Pw4RL8H0IkDSYIpB67UttnBZWecG4xCQttEWnCUd2cyEPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=GV+WAMCY; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="GV+WAMCY"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C796FE8392B;
	Sun, 18 Oct 2026 10:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkrT5xyWGkoi5cJcKe5Ef8dp2X+VGkc1/2gcCl/kCJc=;
	b=GV+WAMCYg+hzGLU2dMSFJHW1WQi6uydcd+bKvaXLPv+rcDZ91xoAq1vTHK7YSQY+/yJi37
	sMECFHMVmtk5PVJTS8NMJAwR5S4mMW/cMtVTg87UEKGYg4OAoh7jE0zoeRUnTZSWfwVRTm
	7tcWyPvJppHlm97P8Ee6a483vauK/fcpnqiew/FMhH5DOsp72ubVL/98MrpOd1FQTyrEE4
	9ZywsRczF5iDtMupRWVMpQCb9LOE/kPA/+OXC7ZdJuJVajb32TIG7UqgMwRHwNNzpAzweb
	nzIhZ0MWtUg6/DBDtj0Y6TeNK+MqjqR4EplhUGxsn35Y2qFCzZI+pgv7rCz4kw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 5oVvWvFSAIT9; Sun, 18 Oct 2026 10:19:17 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:19:17 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Corey Leavitt <corey@leavitt.info>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next 1/4] net: pse-pd: unlink the controller before freeing its PI data
Date: Sun, 18 Oct 2026 10:18:50 +0200
Message-ID: <20261018081853.47484-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
References: <20261018081853.47484-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_unregister() frees the PI array before it takes the
controller off pse_controller_list. In that window of_pse_control_get()
can still find the controller and read the freed array, and so can
pse_isr() and the notification worker.

Disable the IRQ, take the controller off the list and stop the worker
first. Only then free the PI data.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..364acc025097 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1114,15 +1114,19 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
-	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
+	/* Stop the IRQ, new lookups and the worker before freeing pcdev->pi. */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
-	cancel_work_sync(&pcdev->ntf_work);
-	kfifo_free(&pcdev->ntf_fifo);
+
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
+
+	cancel_work_sync(&pcdev->ntf_work);
+
+	pse_flush_pw_ds(pcdev);
+	pse_release_pis(pcdev);
+	kfifo_free(&pcdev->ntf_fifo);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
 
-- 
2.43.0

