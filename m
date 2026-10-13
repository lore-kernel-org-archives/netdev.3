Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9293D9020;
	Tue, 13 Oct 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901246; cv=none; b=iwQ107DrzmAoAdxXIKRqyCz0YGxdZZFcHDl8h2yn5DgJHZ4D3N4TzbaaTWWX44KjVqhjJt98sJSfzQPMevPznjQHHwm1nNdOnQE1NF8/Uw90t+NyqKCiP9dQCc0pAHe42JTs6dpe9WcLQhEos9F8OLoryLKbvCkr9qkiOkq1kR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901246; c=relaxed/simple;
	bh=8xyGTVEkmxmfRvSSjdAU86YxykwJeMrd5wfBHVBPG3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAeypnDVBSbTXUp7nvQ4nvuitAjMxZXXTiH0GnomzhocP9W46u4vyJCRfMmWZfA2cht3UD43UHzN92koRjgYS0xk7hy8mITMMYedHZF5xNHRkFpSssC7PaOvS0J8fQyVbzPm1jpZcRiZYPGp+sgnQEMUMm5UVK8D7L/svgOzyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=b2pZer76; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="b2pZer76"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1D0FA1570;
	Tue, 13 Oct 2026 16:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791901243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dpFChvbEesnvDXRSkyeZBgJNwteHzQwyPWv2P28uGdA=;
	b=b2pZer76FcfwNSQJQ8F3wpm9s1477NG9mYQhBm2dfeXeVU6R6fSgFBdPwY3Zb5XscLQuAq
	XUNoIsOZV3dO0RDclUYMy7eTiHVUGGS+Edj3js5Db3XTR1mY9PsX4A0N5Fx0RHzInay7US
	4s0Eqt1ef8rzIYRWvlrAW0+hUx76J8e3dflGxAG5onec6sdN6iBE6dHrIJVsuIG0a3og9W
	1gQYrPtxZ3NCrFUPEi1Vxjv/wucURSWc6RvZW9ssxztHSA8weIRWOQR1X7WtWRifoaU5Gg
	QTXWS9G7hvyRH8fJ/jrTUQAwGO7TpseY8fC4AI0YkLda7B3UwNvjwIdvAjVtpw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 13 Oct 2026 16:20:31 +0200
Subject: [PATCH net-next v5 2/8] net: bcmgenet: let the caller decide
 whether to start the PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-nb-genet-mtu-nn-v2-v5-2-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_netif_stop() already takes stop_phy, bcmgenet_netif_start() does
not. The MTU change in a later patch leaves the PHY running while the
datapath goes down and comes back, and phy_start() expects a stopped PHY.

Add the same parameter to the start side.

No functional change.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 06ec8c211dd7..86c8f8f8fe15 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3355,7 +3355,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 	put_unaligned_be16(addr_tmp, &addr[4]);
 }
 
-static void bcmgenet_netif_start(struct net_device *dev)
+static void bcmgenet_netif_start(struct net_device *dev, bool start_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3372,7 +3372,8 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	/* Monitor link interrupts now */
 	bcmgenet_link_intr_enable(priv);
 
-	phy_start(dev->phydev);
+	if (start_phy)
+		phy_start(dev->phydev);
 }
 
 static int bcmgenet_open(struct net_device *dev)
@@ -3435,7 +3436,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_phy_pause_set(dev, priv->rx_pause, priv->tx_pause);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_tx_start_all_queues(dev);
 
@@ -4319,7 +4320,7 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_device_attach(dev);
 

-- 
2.53.0

