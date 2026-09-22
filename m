Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1249EC64;
	Tue, 22 Sep 2026 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119498; cv=none; b=tU5OwgONXbR5r2/jn0gUbtOo8+mxu0GaHTSy0T6keXw/dit45O7Pzb1xut9g9YhAUh+0no7vlq48JNmU1t3CXmtUZ2Ahcdfah5rtH0GIvoI3TnEjLRv0hNgJFpmo4DL+tZPAU1ksjGqs5olV8RUNc/6WA4l2+fefw8NRmWPkMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119498; c=relaxed/simple;
	bh=UXlcG+J6U4N8HN8tG9oXX0awGaMqUPlcMAq+wcucFZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTKLRGKSRI/R5p1uLxCsuNjEt+rXL0OGrq7BMXX9ruHksLTDOQ0nx9std8awxfWokRqjrYau+iRJc43tbzl1z/xeYJeWHNqDc5XVWAiG5uupGgnuH0XR6+tb4yQ3WPjd/TjgSRHktHc3DzsVH5Cc9CSzYPW1sWIkZDTRj/OM+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GwxzyJde; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GwxzyJde"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B2235C0003C7;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B2235C0003C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119486;
	bh=UXlcG+J6U4N8HN8tG9oXX0awGaMqUPlcMAq+wcucFZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwxzyJde1HpLprVrsU6wYNjpdF2PXPi7aCc6Aj7+oNqgIl4rKGNVPjDLeZzmxcNtc
	 +TwcrpFEaUQ6RVTW5ouyauwKkOTE1Rvqw8yie+C/8ZQpKaae4voCktd0h3HwJvd626
	 LfMuxMY7Cxg/X4hv8TIO6DypR1F+1L7mT8hJJcl0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 5B7F3B06;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
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
Subject: [PATCH net v2 07/10] net: systemport: Fix out-of-bounds array accesses in DSA queue mapping
Date: Tue, 22 Sep 2026 16:24:37 -0700
Message-Id: <20260922232440.598918-8-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
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
index ed4337af58da..4efcefd33b78 100644
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

