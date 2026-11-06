Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974232;
	b=LZLVl1P2FqA0YY2orXY2GvCHgQi0rGimZ/lw2RYSQSsLCzDvR8Hk1xp5bgjsyBfydJ3o
	 ABSPhjxs3hjqHW9VFetodTIVsrm4NVQz+Ve1lNijI2hYwUBkHVPDk+e7HdtdqvI3IQWoq
	 8Lda5tQXGxFuaVd5jhOPVKhTVjSXh7p9xFIWJMFuz7z4YBc2UxxLkgY+0FrI9AzTc/9bX
	 g8ialMnIbvtpPKlKqzKtAoW0sybDXzJhF5NfhQ02hIDnmXICAjnq9PjhMt9C2fQRGdYor
	 xG5RAGJROT3g6yf2mTpIw7mksbrubXXSMcZuSwHzT4ZZL9Dwt6YyJerWOeQBYA+99Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974232;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=b/cEUCLQXzPxV9G+iZB5C+37LxfrcLwhmYVvdlt5C/Q=;
	b=y+FOuVTlJqZUeamog4uo0SvJAoashpvQu0Xosc0ap+0683bFgubH+B44DK1erIR+ZtCO
	 WbVDsF+1/SGV4MkbePe7Rc39XG63C2LjnW/g+AX8eB8GoFPdcSGMIF95p0c4WnUJU2zbM
	 sPPNzRyh4yN0qGUXAam3DQBP39v/NhtIov/ODhAs0OT9rlOm7U/5bqubrYbFyAPwhREgm
	 cpxiIMDq7cd7xUE0ivUTA5SDz3ERSOCTgYJLI1lYfBc3ZTsraR50AOB0EHY5rb/NJOgaE
	 h9LV/xWptdBPmLlFEy1O2Suc+t6NzXUb3BL11/9AhwitD4RP+6VK01UN4Ppijzl0Vzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=nDfjqpBp;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12771606A333;
	Fri,  6 Nov 2026 14:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12771606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=nDfjqpBp
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5F1DA05A5;
	Fri, 06 Nov 2026 15:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793974228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=b/cEUCLQXzPxV9G+iZB5C+37LxfrcLwhmYVvdlt5C/Q=;
	b=nDfjqpBpERelMXmqVMyHtKYwd6qPIOENe43ukwRPzEOLFUbOdfr7ar1aCfcQeaQlzCJyxP
	2+nhegvKvrNkYkoCPaQZIO2LdHOmHQCPv+kI7Zwf52CHIOrHpKMDif2vAEvQs8bTcDQrLp
	rakaeGVSz4MzALlMeU10gOSHZIf1uq8FTW0SzgVlF5P7Hn1XgGHapvDfrRd2ocU2ndjnCh
	hPlg/zQM4Ro3DIZ3ufrEc/OK9jgK3nfo7EnX5dpy+maO4Dma6jRzDHskPGX52geTjmSb+9
	QVXLb+paI0KA0pqsJy/UpLj8IeXw/H7bZGVqAWYq+k6uTKYpGBrCBcECRxocjw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 06 Nov 2026 15:10:18 +0100
Subject: [PATCH net] net: bcmgenet: cap the Tx queue threshold at the ring
 size
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
Message-Id: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xss5e0pzbEXzE+AD3giKnaFkJC+
 HeLPs5mZzYkiSoJt2pDlEWTvkIBe6rQjU0YhNQXBht21hpHoaVBgmTK64fy+PR0gJjaXXo+Xz0
 zivuO0uv6695RDnj8xzS3k3T5KGLfvxre38F+AAAA
X-Change-ID: 20261106-nb-genet-txq-thld-net-e0864f235d22
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A Tx queue stops when MAX_SKB_FRAGS + 1 or fewer descriptors are free and
wakes once there are more. Queues 1 to 4 hold 32 descriptors, so with
CONFIG_MAX_SKB_FRAGS at 31 they would need 33 to wake. As a result the
first packet stops the queue and it stays stopped:

  eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 3 timed out 2004 ms
  eth0: NETDEV WATCHDOG: CPU: 1: transmit queue 4 timed out 2004 ms

On a Raspberry Pi CM4 only queue 0 carried traffic afterwards. The other
four counted an error on nearly every packet.

Fix this and cap the threshold at what the ring can free.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Found this while fixing the clashiko findings on v6 of my MTU series. After
those fixes this bug would be easier to hit. At the moment it needs a
larger CONFIG_MAX_SKB_FRAGS than the default.

Everything was tested on a Raspberry Pi CM4 (BCM2711, genet v5).
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4d2be2a21ed1b..186d17781b890 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2030,7 +2030,7 @@ static int bcmgenet_tx_poll(struct napi_struct *napi, int budget)
 
 	spin_lock(&ring->lock);
 	__bcmgenet_tx_reclaim(ring->priv->dev, ring);
-	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
+	if (ring->free_bds > ring->stop_thld) {
 		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
 		netif_tx_wake_queue(txq);
 	}
@@ -2235,7 +2235,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(txq, GENET_CB(skb)->bytes_sent);
 
-	if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
+	if (ring->free_bds <= ring->stop_thld)
 		netif_tx_stop_queue(txq);
 
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
@@ -2742,6 +2742,8 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	ring->index = index;
 	ring->cbs = priv->tx_cbs + start_ptr;
 	ring->size = size;
+	/* A ring smaller than that would never wake */
+	ring->stop_thld = min_t(unsigned int, MAX_SKB_FRAGS + 1, size - 1);
 	ring->clean_ptr = start_ptr;
 	ring->c_index = 0;
 	ring->free_bds = size;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index e48ce39d3e7c8..6ab3f73475550 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -546,6 +546,7 @@ struct bcmgenet_tx_ring {
 	unsigned int	index;		/* ring index */
 	struct enet_cb	*cbs;		/* tx ring buffer control block*/
 	unsigned int	size;		/* size of each tx ring */
+	unsigned int	stop_thld;	/* queue stops at this many free bds or fewer */
 	unsigned int    clean_ptr;      /* Tx ring clean pointer */
 	unsigned int	c_index;	/* last consumer index of each ring*/
 	unsigned int	free_bds;	/* # of free bds for each ring */

---
base-commit: 19a227903e65c7a9c179156485660a4e017575fe
change-id: 20261106-nb-genet-txq-thld-net-e0864f235d22

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

