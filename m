Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2D47A879;
	Mon, 21 Sep 2026 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032486; cv=none; b=tXLCx8JQBC4jhIjlMoRtIIAXSrKFVW8Npn5b4aFOHRDOUwFu4FcgFBIANTab7Qm71G7s95poDHBlq2UWF7CgVeP0wEzgK27LF/H9hm2DweEThbAX9EyVLya3P6c7O/paCteZjhH9J9cgHEROXVD96/MDo5njKT/b4sA09YL/MOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032486; c=relaxed/simple;
	bh=vDKmTzkGtP1cB2iH4f7hWZnc1WPsAD1Ft2ktBtCfJDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbuyhcPyWFJoD3JZqOYlQ2YglvIc4/ROnB9qZTortYKRivQ7/9p/W9HMm22zunftwSJtx1sfqBpK5T9arFP7OUdXCWlEvE0vc8uHuyDuefdrmXd8fYWNzAtDGkP6mL4fALOBBg8995TjjVhoCHvyffDOsu0csL3ue+oCKsEUTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=jw85u2Cd; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="jw85u2Cd"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D2DB5C000D86;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D2DB5C000D86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032473;
	bh=vDKmTzkGtP1cB2iH4f7hWZnc1WPsAD1Ft2ktBtCfJDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jw85u2CdtvTxqdIbLnT6CbdzXx76eYWZkOpc9m1dxMKlUgvQvAYgMQ6fU4Rsr3XH8
	 0TH0kMMOgsDH2BxiV2XgYr4QGtMHzat0hw3FjK+RbwY5vRh1FPgzbb0npOevbOAqI7
	 zEBs88VFC9N3LSNzhPThl69j3WTJ2Qq+fh9noGfI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 810ABAE0;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 08/12] net: systemport: Fix out-of-bounds array accesses in DSA queue mapping
Date: Mon, 21 Sep 2026 16:13:01 -0700
Message-Id: <20260921231305.394773-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The priv->ring_map array has a fixed size of (DSA_MAX_PORTS * 8). In
bcm_sysport_select_queue(), bcm_sysport_map_queues(), and
bcm_sysport_unmap_queues(), indices calculated as
(qp + port * num_tx_queues) were accessed without checking against
ARRAY_SIZE(priv->ring_map). If unusual port or queue configurations are
encountered, this could lead to out-of-bounds array accesses.

Additionally, on SYSTEMPORT Lite, netif_set_real_num_tx_queues() was
called with slave_dev->num_tx_queues / 2, which could evaluate to 0 if
slave_dev->num_tx_queues is 1, causing netif_set_real_num_tx_queues() to
fail with -EINVAL.

Fix these by clamping the real number of queues to at least 1 and adding
bounds checks on priv->ring_map.

Fixes: d156576362c0 ("net: systemport: Establish lower/upper queue mapping")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 95cead1df160..130545cce045 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2273,7 +2273,7 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	u16 queue = skb_get_queue_mapping(skb);
 	struct bcm_sysport_tx_ring *tx_ring;
-	unsigned int q, port;
+	unsigned int q, port, index;
 
 	if (!netdev_uses_dsa(dev))
 		return netdev_pick_tx(dev, skb, NULL);
@@ -2281,8 +2281,11 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
 	/* DSA tagging layer will have configured the correct queue */
 	q = BRCM_TAG_GET_QUEUE(queue);
 	port = BRCM_TAG_GET_PORT(queue);
-	tx_ring = priv->ring_map[q + port * priv->per_port_num_tx_queues];
+	index = q + port * priv->per_port_num_tx_queues;
+	if (unlikely(index >= ARRAY_SIZE(priv->ring_map)))
+		return netdev_pick_tx(dev, skb, NULL);
 
+	tx_ring = priv->ring_map[index];
 	if (unlikely(!tx_ring))
 		return netdev_pick_tx(dev, skb, NULL);
 
@@ -2329,7 +2332,8 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 	 */
 	if (priv->is_lite)
 		netif_set_real_num_tx_queues(slave_dev,
-					     slave_dev->num_tx_queues / 2);
+					     max_t(unsigned int, 1,
+						   slave_dev->num_tx_queues / 2));
 
 	num_tx_queues = slave_dev->real_num_tx_queues;
 
@@ -2352,7 +2356,8 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 		ring->switch_queue = qp;
 		ring->switch_port = port;
 		ring->inspect = true;
-		priv->ring_map[qp + port * num_tx_queues] = ring;
+		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
+			priv->ring_map[qp + port * num_tx_queues] = ring;
 		qp++;
 	}
 
@@ -2383,7 +2388,8 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
 
 		ring->inspect = false;
 		qp = ring->switch_queue;
-		priv->ring_map[qp + port * num_tx_queues] = NULL;
+		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
+			priv->ring_map[qp + port * num_tx_queues] = NULL;
 	}
 
 	return 0;
-- 
2.34.1

