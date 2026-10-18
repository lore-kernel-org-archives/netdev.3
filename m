Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9338D40F;
	Sun, 18 Oct 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311810; cv=none; b=fm84/xvvSMN51MG71nBZFwHdp/LN3JJwkPWEBKca12w1ZwNd/s22BMQ1PmEuSVRzm7/pwG6r5D/AH4HrhDOQWUvSK013c8oSuNixJQjztsMDHQlJRo63UhTh9RFXOIPbBT/VjpIE96wMkhmvybuSLoXzlj9qqXOFIR3OUCvHecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311810; c=relaxed/simple;
	bh=upRlFcUj4D+yK/lJSlEFPM4nYDuA7zdcb6cvyKnPnYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXXQoBj/tS7Hm91/QSMTxs12cVlW/3l5pts6fyS2cQVDLzZ8yqCQ34LtYi4uBfdjKf0AixYrYdY6PSXQLeuK+1ZgBgswHV0sBtFZATbEr9z87SOwpMmR4567TQQZnbGRYjaJim+aXCw0jZKhIndYSKKVPe3HzT8dI2K4b+N2TsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=jjxI8Czt; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="jjxI8Czt"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id F354CE8395D;
	Sun, 18 Oct 2026 10:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbcoaKJaC2EYr6FVsBAgfkVecg+8HayMHgn2Wl3RZ0M=;
	b=jjxI8CztNx5qTNy6U1ARNdnp8yq9gpMvvzQ/9CO9VPrwYbBJnvn8IfBYmiQqC86KXxXXxZ
	M9mRZp9GEWhGy6s3KYaunseU1odLFadEWv5gftMRGpK9R6HCd3p/juJiYRgcHdJmX6eQfi
	RdjJq0s0tXE4BOUjysmcGpAsPGwaWvCOilhG/YhUUsQmL4hFSADsiLlX0lCFEjFcz+UiXK
	rPP8N2R5SM/khtLkWtcjSrU5eSRD5Lvs/VKTXDEeUeb72wlj48JUpL0Mh1HDEBt3px6uEp
	niqXiHZ2PcaljWgdf1S6ZLLBeuoROuStlTXrEWiSURPbvYUUwglqePB5Lo1Fag==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id CH4g_Z7jvGBQ; Sun, 18 Oct 2026 10:23:26 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:26 +0200 (CEST)
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
Subject: [PATCH net 02/10] net: pse-pd: fix module refcount leak in pse_control_get_internal()
Date: Sun, 18 Oct 2026 10:23:05 +0200
Message-ID: <20261018082314.48950-3-github@szelinsky.de>
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

pse_control_get_internal() takes a module reference and then has two
error paths that skip module_put(): a controller without
pi_get_admin_state(), and a failing pse_pi_is_hw_enabled(). The second
one happens on any I2C or UART error. Each time, one more reference
leaks, and the PSE driver can no longer be unloaded.

Send both to put_module, like the regulator_get_exclusive() error path.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index c0573cbbba5b..1710f9bb7d27 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1427,7 +1427,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 
 	if (!pcdev->ops->pi_get_admin_state) {
 		ret = -EOPNOTSUPP;
-		goto free_psec;
+		goto put_module;
 	}
 
 	/* Initialize admin_state_enabled before the regulator_get. This
@@ -1436,7 +1436,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 	 */
 	ret = pse_pi_is_hw_enabled(pcdev, index);
 	if (ret < 0)
-		goto free_psec;
+		goto put_module;
 
 	pcdev->pi[index].admin_state_enabled = ret;
 	psec->ps = regulator_get_exclusive(pcdev->dev,
-- 
2.43.0

