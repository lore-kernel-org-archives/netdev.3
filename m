Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6F36F90F;
	Mon,  5 Oct 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239104; cv=none; b=Vy/SU2lBRFD6u0euIM/h1rJrIZZ9MWCmD6gtMRCIi7LutjYdLcXeZWpiwrK0x86Mt3A++OWs8XdNzwtuOded+Y4zRGYuqUGEEpXfXW8DDfF1/+2HUwfkTWjmNsq4JlkvJIu6nmhzMGPVNAalqvyV1y/rj2Nz/QEqFPCP1NpBJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239104; c=relaxed/simple;
	bh=6hz3kuguRa8clNqqJ7qL2suvrpD9DAQeias9Lpn++Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Psr31FurwbG5qZbbQwOZHyJQJsvC19evdzFxh7J5bslR557amVcxFNuy4gCxf/VWFjrRINtcpc4vC7FmMYNy2Bb4d/PqjZi81nLXhyD9pbeynWE2pMNim/ppniByX8w3F7gMP+IsP717Og1Ci/UMPSiq0rzAimA1oPqBmqsBlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Kuss+5H3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Kuss+5H3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A9FAA0E33;
	Tue,  6 Oct 2026 00:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791239099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y72vG2wnD8eFFqzbDZVSVjMG9HD9FVK1LFD4c3Yk0ec=;
	b=Kuss+5H3qDz395GwXrmmej4V6pdDPDVt+9sIF2Gkjiwyxu8wg46J0lvwewmVKwoljKOsIN
	xYgqdqLY431QLQYvWZbh0HIZcrgSaTujQYojaZ7eRGXcpdx2F2Rhu7pNgSEGYyfAsq0ZnV
	weJA+QtbIbQ75TPzUTuctpj0frJpufBg/7WiyWuoAOoyAEaxI3Mv/PoH78CmueeJBfc1B4
	gRxB0jzlyOtTINohzhzo7pRCT0wrVsPsEX6z1O4ZCN0Cxx/lJ4AaWE5Mr2ymBXVXFeohPX
	dXrj4hTS8PuLR6TV2OZgBw2BpDnq/zDPTt0bQneWGgOPz6LD0zD2KCLr623MQA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 00:24:40 +0200
Subject: [PATCH net-next v2 1/7] net: bcmgenet: let the caller decide
 whether to start the PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-genet-mtu-nn-v2-v2-1-c4be21151912@tipi-net.de>
References: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
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
index 4c9db2f9fc25..a82579879f4b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3348,7 +3348,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 	put_unaligned_be16(addr_tmp, &addr[4]);
 }
 
-static void bcmgenet_netif_start(struct net_device *dev)
+static void bcmgenet_netif_start(struct net_device *dev, bool start_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3365,7 +3365,8 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	/* Monitor link interrupts now */
 	bcmgenet_link_intr_enable(priv);
 
-	phy_start(dev->phydev);
+	if (start_phy)
+		phy_start(dev->phydev);
 }
 
 static int bcmgenet_open(struct net_device *dev)
@@ -3428,7 +3429,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_phy_pause_set(dev, priv->rx_pause, priv->tx_pause);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_tx_start_all_queues(dev);
 
@@ -4312,7 +4313,7 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_device_attach(dev);
 

-- 
2.53.0

