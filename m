Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261194;
	b=1Nbhg6krWU3VvPo1CSC30q1ByIym8WF4fd6f8DSSfRLBo2GA6yzkEf2d61ij5rN3yd77
	 orcsz6+u+hMZnfLCKgCpyrdEBQR1DrtG2OCASS5+HkYzneDZ1zjlxbq5Jfl+VE78KTJn9
	 BKJhXCnSy8wTapa4MpsLthIIubEUZ8HiJRlOCnaaZcMmGR+2kfUimOQ3tKM6OoVP8MfKT
	 HXkyijo+dVaYLIKHJRzxivwbJ4AVX7IBnkcZVUK0e06si0ZzFcXTO6SDg2x3J3meqo0Vn
	 6RKyrM7gXVOudwK7ba7olBiqKO/zVvIoE3SA7BxekSWxEaP5l4dXbSEOAUfLCQABl8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261194;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=+OjU5cpDd0WZsZbOTFKQfY0byW87CeplqtKe+Oidk0k=;
	b=0c1iNpgWDww/Vmdorb/jsR3Jlu5eTkxRwWylZGQf5ZKVrflM4GTf2oi5k8GLP1L/7H//
	 5nEfe240YS1oSe2mp4wBZBpxR5YwqEgXnfZz44/ejmvtyqq0/6NO+5XD9OVRm2ZaZN9Od
	 VIhqAe8hy+TjWhnTBYoz8GX4BD2PYcvdoUxK9nPDekFQpYk/5l2TVgddrFM6l7qngsvbI
	 tSn01ILUWYECfjqpEXT1htUi3aAe65DfPSkTXfVZ3kRVbpDnI2iajmEX9J2bC/metGL8a
	 Yi5D1zOc8/BdygUhzwAAjFP8MLOJV/e3k4kJ9Med/irRRIRdYAe55/pIiV1+6zcjBfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=SZ0JMSJF;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837D606A325;
	Mon,  9 Nov 2026 21:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D837D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=SZ0JMSJF
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC7C8A1609;
	Mon, 09 Nov 2026 22:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794261191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+OjU5cpDd0WZsZbOTFKQfY0byW87CeplqtKe+Oidk0k=;
	b=SZ0JMSJFDut+1am+/Kvra7d4mFjStNGpw1Q26lIMP6XSF8NbjUmUlTqr0DFiR7d7udcD68
	E2LG8O8tKSBr2ORsRXzOPUBRENykRPfzkYIWZgahWyh60OE6aExA5TYJN2UfWNZQ33VYRL
	Kwsr2VW3SDUEO15KPY5PdFNDIQQxZ1/v4g9wHf7m0Od3AwD3+LCSUEduFN4lVtai5VoGwD
	n13mgWvIidlqxF16wRvl0ocX93gaAgg1b3yhTNIX4ymj3thHdDbcsmsspVSRYrXiTy+Fl+
	NKnzg9MeCoBbFbxcM5DBcTHD/n9vZ7Uem6q8ErDjJs9bfjqN85Lcm1kxj4VX6g==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 09 Nov 2026 22:53:01 +0100
Subject: [PATCH net v2 1/2] net: bcmgenet: cap the Tx queue threshold at
 the ring size
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
Message-Id: <20261109-nb-genet-txq-thld-net-v2-1-efd8f4be96f2@tipi-net.de>
References: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
In-Reply-To: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4d2be2a21ed1b..9049822012d13 100644
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
+	/* An empty ring must be able to wake the queue */
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

-- 
2.53.0

