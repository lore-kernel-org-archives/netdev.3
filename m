Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672247A870;
	Mon, 21 Sep 2026 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032486; cv=none; b=Hnf6HSwXZbXfG/HXZF8t0W8GA+BraoiDXpNu1YTBZY0nk8ATMY/sCrCEFN1TKDGgmCD7JcAHRt5VB/WJNXfiknatnbdCKydk2VEwQ4UuFRdUBZJzlXX9xab0tc/cVOwh3ULeBr0e9jaJJQArMcqXujIN60Fz/buXGNIErebM4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032486; c=relaxed/simple;
	bh=q4Uo6HFLYZhQH5JVbpR9AmQqLAKZ7CUr8XnwIDEo5xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B19wxyW4HYtYPT3DD/acWp2UxZ5OHp2dH2Q23z08MkhUMuC0m5nS1kgcEw1KUmZgyYeaVJtdPvAJd9V2FAwYp/G6I9DSxX4bOAQvxRJZeySpSeJbfQBeLK6S2aJJJO5L8FKDRB1UTuknHog3u5lmsrsRbHVavPFy8ICxiM6HGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=nJ/CihrJ; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="nJ/CihrJ"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2F537C000D89;
	Mon, 21 Sep 2026 16:14:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2F537C000D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032474;
	bh=q4Uo6HFLYZhQH5JVbpR9AmQqLAKZ7CUr8XnwIDEo5xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJ/CihrJ44l/OKEKJ7kNYiqveC2X9I3xtnpAjYEHJqLFQzUGyf5mAryPfzcUJSwj/
	 Ycb6EqRRKpfPQf3jMGwQmuP6wJVpgT3b2MCmqTUfye1GI5ECrNTRRS9hqRsG22axz+
	 BlGrQmSKK9ZK2aaZJ+mVbLmsk17/FkgySZ+0xO1A=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 0CF2CAE4;
	Mon, 21 Sep 2026 16:14:34 -0700 (PDT)
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
Subject: [PATCH net 11/12] net: systemport: Update TDMA queue mapping dynamically on changeupper
Date: Mon, 21 Sep 2026 16:13:04 -0700
Message-Id: <20260921231305.394773-12-florian.fainelli@broadcom.com>
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

When DSA upper devices are dynamically attached or detached while the
master SYSTEMPORT interface is already up and running (netif_running()),
bcm_sysport_map_queues() and bcm_sysport_unmap_queues() updated the
internal software mappings but did not update the TDMA_DESC_RING_MAPPING
hardware registers, because programming was previously deferred until
bcm_sysport_init_tx_ring().

Update TDMA_DESC_RING_MAPPING registers immediately if netif_running()
is true during map_queues and unmap_queues.

Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index dd5a7c9dd90f..e5bb7fa84fda 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2315,6 +2315,7 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 	struct bcm_sysport_tx_ring *ring;
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
+	u32 reg;
 
 	/* We can't be setting up queue inspection for non directly attached
 	 * switches
@@ -2350,14 +2351,21 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 		if (ring->inspect)
 			continue;
 
-		/* Just remember the mapping actual programming done
-		 * during bcm_sysport_init_tx_ring
-		 */
 		ring->switch_queue = qp;
 		ring->switch_port = port;
 		ring->inspect = true;
 		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
 			priv->ring_map[qp + port * num_tx_queues] = ring;
+
+		if (netif_running(dev)) {
+			reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(q));
+			reg &= ~(RING_QID_MASK |
+				 RING_PORT_ID_MASK << RING_PORT_ID_SHIFT |
+				 RING_IGNORE_STATUS);
+			reg |= (qp & RING_QID_MASK);
+			reg |= (port << RING_PORT_ID_SHIFT);
+			tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(q));
+		}
 		qp++;
 	}
 
@@ -2372,6 +2380,7 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
 	struct bcm_sysport_tx_ring *ring;
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
+	u32 reg;
 
 	port = dp->index;
 
@@ -2390,6 +2399,14 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
 		qp = ring->switch_queue;
 		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
 			priv->ring_map[qp + port * num_tx_queues] = NULL;
+
+		if (netif_running(dev)) {
+			reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(q));
+			reg &= ~(RING_QID_MASK |
+				 RING_PORT_ID_MASK << RING_PORT_ID_SHIFT);
+			reg |= RING_IGNORE_STATUS;
+			tdma_writel(priv, reg, TDMA_DESC_RING_MAPPING(q));
+		}
 	}
 
 	return 0;
-- 
2.34.1

