Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700329;
	b=UQ1iQOHoGkNGfSGgfdjStIaQaql60loeD5AxAx2Xr9B5/tGhmTY+hiyLHQCXiLDYM4Xi
	 UQb/Ovb2un34eGWgJSxVy4pmkqqcSgrjT0GndWmaMVwwq1eacUsVJ0Q/KNmxV5v65Gxar
	 Qr4pyDT+Rzc4mDxixjncXCpS10ypf8b9ARnKwCO6OnHghxIbsZDmp0OjGlS1fkiDTGLNQ
	 zeDDXg5qRQ8I5k/MIeLK88qzptkAIEkkobz4EbboHe9Q7AXOaZL75Bl9Du9lIRS7rnl9u
	 OnjbtCNMx6OwvcVyr8pDwWaWoKijL3UJOBMGdP5RvfWXXWi4CINysu4DnNdmMf2+wbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700329;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=EH6JpSgGDXBr8/oXh3P2IsoFFMPzZqzgjTRZpHrhex4=;
	b=M0abwTe1erlDeC2LQSMRzffjER3yMUZ2qQQ+09y9yR/yS9nBnpnqbKvYFtmu3w2ibnKC
	 YxZkfu2mc9UjuWhcg/mo1KDZuenh5Z/nDTWwt3Edx9fuvr+RllPoV8qHzEM0jqYsu438c
	 bS2jdAP6Qc8j/DubiDARwoVlkSHp7mepgVYdLP4pD18p8zWF+OwiAue9z/XL9tSLYTCNs
	 o70KqvNbJwph7vY3cgRQruud73Gd6Lf+n1Ikf4pE3phq/CGnvtuo9XiRQXDPLX1Nmsl8n
	 XDAOKbwDdGgjYGAQ8YjTIIWyJBqbXMgWfRKjWAB1f1/XTZ3Gdj3/+7J3UpkeuscJ0Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ii52fmhG;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B9606EE8D;
	Tue,  3 Nov 2026 10:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742B9606EE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ii52fmhG
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 274EDA164B;
	Tue, 03 Nov 2026 11:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EH6JpSgGDXBr8/oXh3P2IsoFFMPzZqzgjTRZpHrhex4=;
	b=ii52fmhGSNa/j1032VrLfvmJ4QL8jnv3eiPnliHEmMynKIIAOTGJ5IozJDXQ/h2eVD4uAR
	4uU579eohlQOeYEBp54jLzKFUixGmO5kUwbVydOxMVPcFl2FbaLqDbNmVVtLoN39teQ/9y
	nLo2YkcFz6OaNpyn8qw9CbP5be2bkCZQLDnqTq6b2oMbqdi/mMl4IiGUD4w48Zt7sQ1Ygh
	rGRDdMRz9ioyrVGGyhVciycgLgp7UdRDDmo81jduOe3D0v+0spiQcGmDFfXxPgaO0Vqvze
	YPfWYYFFmqFnw57FV+uPLC+pFZx9KN9ApQ0KPdcBh9dFRLVyeTix+DlBalHM4g==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:04:56 +0100
Subject: [PATCH net-next v6 2/9] net: bcmgenet: let the caller decide
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
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-2-61d5631676e5@tipi-net.de>
References: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
In-Reply-To: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
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
index f28b32f62a7c6..bed94f9a79450 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3374,7 +3374,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 	put_unaligned_be16(addr_tmp, &addr[4]);
 }
 
-static void bcmgenet_netif_start(struct net_device *dev)
+static void bcmgenet_netif_start(struct net_device *dev, bool start_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
@@ -3391,7 +3391,8 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	/* Monitor link interrupts now */
 	bcmgenet_link_intr_enable(priv);
 
-	phy_start(dev->phydev);
+	if (start_phy)
+		phy_start(dev->phydev);
 }
 
 static int bcmgenet_open(struct net_device *dev)
@@ -3454,7 +3455,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_phy_pause_set(dev, priv->rx_pause, priv->tx_pause);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_tx_start_all_queues(dev);
 
@@ -4353,7 +4354,7 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	bcmgenet_netif_start(dev);
+	bcmgenet_netif_start(dev, true);
 
 	netif_device_attach(dev);
 

-- 
2.53.0

