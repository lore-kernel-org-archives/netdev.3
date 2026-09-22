Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFD545DB2;
	Tue, 22 Sep 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082413; cv=none; b=UAeXVAr1uLnUf5el4rGw8fg37EduJCxEn/72SvnyFJdpZq2WS6wAAeD6OxI4O3CZ6Xtli2UJ443z09hrd0VolxTxj1/KlxgoC7teOO0J1koDhm7UMdhn5dRPZjmDqu+orhPwJkWIYx/RKmlc5Dnh+9gihQeZJKBDG3jKKv+cjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082413; c=relaxed/simple;
	bh=Fp12wKxj5bmoEsYVOY9wTyPnTb70p49Xx6JchL3YLEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7hPUwQN0hIuISXwNPgoqlJ92HVCsWGLBb+yKpkY8p1hOAKtY6gC+mjLulDZMrXuCJmzIU6Znnvo7hRIBoAZhAn+JmGspppvWeAF8NwyNAZ+/JdTvdJ1sxJaUQ6+uNtsGmKEKQqoUFkewVlkmsEDp5Z5cmDAlt8jPPxjpv9GsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xqF4MIR+; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xqF4MIR+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF263A3A04;
	Tue, 22 Sep 2026 15:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790082407; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=QHHIsnZY8y7FeKU/zlnoGatJ0tWyYBSUhZIOvUfoQW0=;
	b=xqF4MIR+8Jw1qgbX/sLi1I8mfdMJKVpsbkQzqSsK0NnIGZvSrqhc/KCId+2Ps0/agEMAfd
	9+7oRXlb0Y7mG0ud2gz3eqv4AuYMyGH3Q79cOMPSq8XRh6zrN4Z+cgLcAPkB13TmPLwC9J
	4OIitJOvnFCL+rBddylHF223AQWJT8rHcNWCzdTbNHpdo4zlQnXfiRmr506gzJQ4OOyPCC
	U3mgXDNmulp0w6+aGvFG+WRETsa32FygDz43X/DW7UJTNdm1EBkKh9y8EjKMJzX796zWzK
	RCRBrO2DMSn0+8zrAQcwDJOXkm1CnoO6w3Q1SvVdVha516xeI8Tu0yp6Cj7BHA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: bcmgenet: stop Tx NAPI before disabling the queues
Date: Tue, 22 Sep 2026 15:06:38 +0200
Message-ID: <20260922130639.1660797-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_netif_stop() and the Wake-on-LAN branch of bcmgenet_suspend()
both disable the Tx queues first and stop Tx NAPI several steps later. A
completion in flight calls netif_tx_wake_queue() in between, and nothing
stops the queue again, so a transmit can reach the rings after they have
been freed.

Close is safe because dev_deactivate_many() stops the qdisc first.
bcmgenet_suspend() does not, so stop Tx NAPI before the queues on both
paths.

KASAN on a Raspberry Pi CM4, driven from an MTU change because suspend
freezes user space before the callback runs:

  BUG: KASAN: use-after-free in bcmgenet_xmit+0x17f8/0x2258
  Write of size 8 at addr ffffff8055844a68 by task ksoftirqd/0/14
   bcmgenet_xmit+0x17f8/0x2258
   dev_hard_start_xmit+0x13c/0x588
   sch_direct_xmit+0x108/0x340
   __dev_queue_xmit+0x1190/0x3848

Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Found this, while I was preparing my jumbo frame series for genet.
The MTU change in my test comes from that series and is not in tree
yet.

v1: https://lore.kernel.org/netdev/20260921124435.974581-1-nb@tipi-net.de/

v2: also reorder the Wake-on-LAN branch of bcmgenet_suspend() (Clashiko)

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b916080f4ff1..ca62041efecd 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3441,6 +3441,8 @@ static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
+	/* Stop completion polling before it can wake a stopped queue */
+	bcmgenet_disable_tx_napi(priv);
 	netif_tx_disable(dev);
 
 	/* Disable MAC receive */
@@ -3455,7 +3457,6 @@ static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	bcmgenet_disable_tx_napi(priv);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
@@ -4320,6 +4321,8 @@ static int bcmgenet_suspend(struct device *d)
 	netif_device_detach(dev);
 
 	if (device_may_wakeup(d) && priv->wolopts) {
+		/* Stop completion polling before it can wake a stopped queue */
+		bcmgenet_disable_tx_napi(priv);
 		netif_tx_disable(dev);
 
 		/* Suspend non-wake Rx data flows */
@@ -4348,7 +4351,6 @@ static int bcmgenet_suspend(struct device *d)
 			netdev_warn(priv->dev,
 				    "Timed out while disabling TX DMA\n");
 
-		bcmgenet_disable_tx_napi(priv);
 		bcmgenet_disable_rx_napi(priv);
 		disable_irq(priv->irq1);
 		bcmgenet_tx_reclaim_all(dev);
-- 
2.53.0

