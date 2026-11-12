Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480328;
	b=TZe5PT+DeVCd5O36MnZQZ0tU7Vs9JDel4ooab11sIAl2NhXVsQrgrNsBaYtusRNpqn6E
	 MXsdD+75XSw6BhQt8Xb5REYA0GVlHUnVbBFcXeApMCAigJvoUbrpgv3lpYFBC+A0UmCKx
	 SrLGdNFdahLTMBHAMzxtnhMIAQBFylpjieITvtv5+a8mnmbyNCmH1F/txFS8Mwn8mGs1Y
	 bH606cH3SDdGciCrHr0ku+PiLlXAM50ar2Lh3BCTVG7Z7CJd/ZA4jsLCNHmBNlpJpcfG+
	 454yPx8vYW7SenJTlJObkTYFSR/mGm/2EVE+eMLjX6rHNu+XIJ25Q9NiJkpai6dsSlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480328;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=JCN+UEs5b6GJ7BxS94RKXGY969E9xoQTwL9kNU+PKI8=;
	b=vSZB6STNnzEVlTjMmHpUuJNU0BCdplVMnaFY6TV2LyovSjB9mFk74GgYMgv+VPY51yem
	 eBAGskfF4NNMobUKjimaWo/DXr0rV9/tzGeMccH0zpM4hWMXecLZ6jBq7eIFcPPK9/gN4
	 XdeL+4ad4zENiWCyVNSJ5PR3dQRZjJYmLA6Sq4I8OAxJPb9iiwYBI/HkUcHcZNLy/29eg
	 5iqfjo9fgQCU5yjQTN5u1LIycQJGbZNlk0RSzbZgYQKAKY0wjIiHOTY6BTmlLwttBALus
	 dmVZlSSKL6y+mGVL4adjsUuEcOBzZb/wIFYupZn2JXTWw/7gMNTux5dF/0O1X8bjGIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=PtA1La66;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B87606A88F;
	Thu, 12 Nov 2026 10:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B87606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=PtA1La66
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4BB4A50B4;
	Thu, 12 Nov 2026 11:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794480326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JCN+UEs5b6GJ7BxS94RKXGY969E9xoQTwL9kNU+PKI8=;
	b=PtA1La66w5Ok+cMKTzgFq6XuU2VTGcMvomDDM/UbqAw+yID8lLqxhLWzEt0PdgRowfAN7/
	BQs/Mf14lNqoS/nMivX7xtNUp8dsnwCzdMRthcedlnCewENIAd1Sqxgona5CkEnPtYh4GS
	+v5VizP3Bx3KCTCU8U3VTmC11W/bEmcw4gOQnND2w2dqdbBHjhAWs1jtOjEEqcaUXt+r7c
	XJbHzQuW2X2v36NFXc1+NuWHa2Le3M2qy90P+kkC8vP2/tH0q3c42QV5EDqoHTYtX6FV7l
	yxE5tUn5oi5Mdt/K5NexFUhdsVK0+oGhfM96x/1bKtXttmAQB3MVUY11yv0gUQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 11:45:16 +0100
Subject: [PATCH net-next v7 2/9] net: bcmgenet: let the caller decide
 whether to start the PHY
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-nb-genet-mtu-nn-v2-v7-2-43a5d90b3256@tipi-net.de>
References: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
In-Reply-To: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
index 1114fe46d2f73..4c2a38eaab108 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3390,7 +3390,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 	put_unaligned_be16(addr_tmp, &addr[4]);
 }
 
-static void bcmgenet_netif_start(struct net_device *dev)
+static void bcmgenet_netif_start(struct net_device *dev, bool start_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3407,7 +3407,8 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	/* Monitor link interrupts now */
 	bcmgenet_link_intr_enable(priv);
 
-	phy_start(dev->phydev);
+	if (start_phy)
+		phy_start(dev->phydev);
 }
 
 static int bcmgenet_open(struct net_device *dev)
@@ -3470,7 +3471,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_phy_pause_set(dev, priv->rx_pause, priv->tx_pause);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_tx_start_all_queues(dev);
 
@@ -4369,7 +4370,7 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_device_attach(dev);
 

-- 
2.53.0

