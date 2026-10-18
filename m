Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F773890E4;
	Sun, 18 Oct 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311809; cv=none; b=if6GxYacddnK2fl/nB7Cyq0oq9k8m6QFhQ7WSoFgYsAch+F3XQWviGgNgmtTru1aBhf2Ivo6/D75loVZitYEYMDFUFIXDvxJrobjoGyI9BEdXH4+7rlHkadhuh7k/hIrLiqwY6uPsYjK9T3PiNwKNZ0gAXz+1z/fQcfG2+2uy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311809; c=relaxed/simple;
	bh=jZjy7MP+X++TgxyZbCc3zYlAYy3azyNjA4hWr0ebSko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iniJbSIljbgzHAFT5WbP+fMwZeUTjQEfmugWSls+hM8VOLjUDyyjkM2gjpQod5cB7IRWZD2VoJeF1G8HudtX1oXMhlMUVyks6roAsst6+tdrHa+HsKqptTE8bm9as7AHppRgumaOwwEamyFdwnJmR+Ny2Lyxbqi7nfu/sP5lpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=N/85Yajg; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="N/85Yajg"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 00869E83954;
	Sun, 18 Oct 2026 10:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cj5pew1QzIjStau02ALT5vVygaMQHZVgSfjDGRNXyLc=;
	b=N/85YajgJHqBgPUw6+XHH06u9yBzQYHb6mrd/1TnZVQaJBQaRDiBiy1Re/5Fjbf/ISGUrV
	Z1P9XobzHQX2YletcIjj772xH3oGnSNJDeR3u5z72Am8wUjAbo1at655PVwmL696CERhkE
	tmi8/S9gvZ1zCa37TA8SoRDqebnZzxdvoTLhavj0Z/WzACrdVRZ2z301TaCyHujt668/4v
	Fi4OvmcDXkBn4BCed78hzjEf7vja3jjzBYHZov0QOV34q3YEjFGFpOBznGiIovAOv1INaU
	nY0nKGM4JzrubWg5+kVPAPFwjf5GP/krKrbGWL7FvaxT9k9PsbHAxCKiTMGxfA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id ZsYNU7HkpKWY; Sun, 18 Oct 2026 10:23:25 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:25 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 01/10] net: pse-pd: size the notification kfifo after defaulting nr_lines
Date: Sun, 18 Oct 2026 10:23:04 +0200
Message-ID: <20261018082314.48950-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018082314.48950-1-github@szelinsky.de>
References: <20261018082314.48950-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_register() allocates the notification kfifo before it
turns nr_lines == 0 into 1, and kfifo_alloc() fails for a size below 2.
So a controller with nr_lines 0 or 1 cannot register. pse_regulator
(podl-pse-regulator) never sets nr_lines, so its probe has failed with
-EINVAL ever since the kfifo was added.

Apply the default first, and allocate at least two entries.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..c0573cbbba5b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1044,16 +1044,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
 	spin_lock_init(&pcdev->ntf_fifo_lock);
-	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
+
+	if (!pcdev->nr_lines)
+		pcdev->nr_lines = 1;
+
+	/* kfifo_alloc() rejects a size that rounds up to less than 2 */
+	ret = kfifo_alloc(&pcdev->ntf_fifo, max(pcdev->nr_lines, 2U),
+			  GFP_KERNEL);
 	if (ret) {
 		dev_err(pcdev->dev, "failed to allocate kfifo notifications\n");
 		return ret;
 	}
 	INIT_WORK(&pcdev->ntf_work, pse_send_ntf_worker);
 
-	if (!pcdev->nr_lines)
-		pcdev->nr_lines = 1;
-
 	if (!pcdev->ops->pi_get_admin_state ||
 	    !pcdev->ops->pi_get_pw_status) {
 		dev_err(pcdev->dev,
-- 
2.43.0

