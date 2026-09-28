Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2A3B27DF;
	Mon, 28 Sep 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597707; cv=none; b=OHVJ9H8uWY/nZJG5g/AEz0iJ5vmGIobab/kRhdQMKOJrd437w117UwfrTtRBelkrebMOyZr3aMQFdJnfL2XGGWXB8qU/jaq+48ZWEq+WfYB9RJcCU97+i9dBUhZJ1SFn9mYnEmj7r1pKrJoA7Jr3RDH6ZbkXsoI4jte/AN7AS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597707; c=relaxed/simple;
	bh=JJxve8IZANbNmSkWyQJsKHDbkxJjp0IsPfvZUGx055E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3+yyQVzuTaMyBq1OXIGk0fHGdtUZyLJ4Lyb/qr9yl/Ats09F8R2xKYF2rQtyiaNhRhKI7BpRvYYhXP9UuBlesPphMaTLPjbL+SX5tEUE8d8nsnAOmQFQDFPix/tNoXFS44tGA8jdOj0WmqbfuYCJ5JS56vvkuDikCwGLGyxXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=j2H9comc; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="j2H9comc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31EEAA4AC6;
	Mon, 28 Sep 2026 14:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790597699; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=nGkIEvLD5Uu22Pp9o2HCTsh1EV9ZYMz+bgrMILvbLJg=;
	b=j2H9comcZaCxE9QJoXT4Fp4JS3gDhZGYJ2Am5MckXCY1qkxkWOfY5cs8PJE86GMr7z6kw1
	2cXea8GLpaxd9Wzm+sRsfqfn6qyPyCWTyh02ZyWivaA7XwVYEfZipR/yaNNt0Z4+Jd4dYo
	x0tfJlx5Ybi6rzptK1YmIBDGqvt1huML2oFrngXqAikoar47jYVBaHLVoRuOr7mSfDfFBu
	zwmGbeIl51VY6rB9RmgNDHcyiUGTBncyUf/GKzUxnATv/qXnUlax4h7vgQSN1yh4IJCdoC
	gb6xyGjdSRwlaRVUDcumBUcydzxpF8WL0YcKfJrQ+TT7If4vg9rh0DkQjsyDgw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: bcmgenet: complete Tx NAPI after one reclaim pass
Date: Mon, 28 Sep 2026 14:14:50 +0200
Message-ID: <20260928121454.901306-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

After reclaiming, the Tx poll asks to be polled again. That extra poll
finds nothing to do and does not reduce the interrupt rate.

Complete the NAPI and unmask the ring interrupt right after the reclaim.

On a CM4 this raises 60 byte pktgen Tx from about 187k to 224k pps and
saves about 5% of one core at TCP line rate.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 21668e41b696..f17ad20b4b9c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2020,25 +2020,20 @@ static int bcmgenet_tx_poll(struct napi_struct *napi, int budget)
 {
 	struct bcmgenet_tx_ring *ring =
 		container_of(napi, struct bcmgenet_tx_ring, napi);
-	unsigned int work_done = 0;
 	struct netdev_queue *txq;
 
 	spin_lock(&ring->lock);
-	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
+	__bcmgenet_tx_reclaim(ring->priv->dev, ring);
 	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
 		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
 		netif_tx_wake_queue(txq);
 	}
 	spin_unlock(&ring->lock);
 
-	if (work_done == 0) {
-		napi_complete(napi);
+	if (budget && napi_complete_done(napi, 0))
 		bcmgenet_tx_ring_int_enable(ring);
 
-		return 0;
-	}
-
-	return budget;
+	return 0;
 }
 
 static void bcmgenet_tx_reclaim_all(struct net_device *dev)
-- 
2.53.0

