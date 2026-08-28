Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0E3A875F
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955656; cv=none; b=AI5c9MRLU71JybPFrpyxCr2R+XPifE6/ODm6qqq2Zfr0f8QnhZ2rjKMEKPTWAO+aSu6UJrS6OulmWbX5/BirMLtRGxsf9itnMogQTQqJt4FAYbK9jYNlJTGWr4xiAZgN6FPQAq5qTO1pipa7IfGm9OoHIHP0/hTrY7gRkaCzKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955656; c=relaxed/simple;
	bh=E/W+ksdADl9ywTHJd2TuA2lVsVD11eIiuEkKnDyCD/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKL18UyOzli2LlJUrsJpXltz7t9MPERLS3XKxCQ0QqZNkw4735lcxgSqJx10ThB9ujh3a7cy1NWrcMI4+yj4v9LA+l5J3dgc9rGVPk2CwBSKK7M3cb0mqPTBwZvNhJbICtIVFPs8f6bFHSGQMxqCrFPsNFzxfTCSbV9r+xIDOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOVFq+AK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOVFq+AK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cace91f112so12133965ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787955654; x=1788560454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkzPOJyjg522oMEaLV0n0OoyZNgVtknUfEY52R/omSs=;
        b=HOVFq+AKdaOJrHxLRfkVQa8W2PFT5pa31HhlZNcIhBTITrtkwbvvQj478nkrFwO6jE
         kE6RcbUqfXt+SaNC1Ib/dNzYctLrp6xg0RUB4z70z3ebprUyo8pxIa8slGBB4OKMj1TO
         bpVMyalbRleXe5udEDckqn4+as/bf1aidPL5fB1zu/L59uuAPHoos9JyeM/yS/SONkZm
         9xb9uFjj2iIg7lujZqiXjBRA3ofxzEz0WEZz0ZDeEFbnAJmMGW+R23HxPfntrDhtgD4E
         A0Kg7+ODSxUoIXo1ySssQErBVvmN9SI0h2J9XHii/oN9xHp+/q7qB1rFkAzzRgYFl0Hb
         1sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955654; x=1788560454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkzPOJyjg522oMEaLV0n0OoyZNgVtknUfEY52R/omSs=;
        b=EVm6y8VxNCBOYhN6mGmUYlelXuNXTGn6UGh4ZjRzYVd3/XX5vJ0KBJv/Kgzg1ZJtTI
         1PX1e+TStyTwM4aUQ1QaDB3pk9cLszqoo/XA5XQyD9Jpwy+yuQiY3MO/Y8W+ffZSArwH
         5mv0wvyMRZph4xLi+/9SzEoIa7eqgN7uIEh5jyxdJILQYtc9peHF37a+lBalhgT0DUHp
         +DphDM5FoX/m5JbJVmCs841LN2VmFzmeu1jlIAHXsuFeQbt2mkB9qQLO3YCIjxL6t9Kc
         TEvRu6CLG8WcFZepj9qLacBUGdlI/Ul9i3RF/sf67aUjm8HZlY47qSx4x44PDOVPEjcU
         C1ZA==
X-Gm-Message-State: AFuF++nxdDVy/MTbw3hnLKCyNeVKw4Nam9+2w3Upz6iJ8Bf3vZSPOqrU
	srG9ycTXIFJV4AQ2IBAmtPGtSJfXhMbaIeIfC6OKZX+HzZ+RgIk5DVl+XGm1DQ==
X-Gm-Gg: AYBFou0OyRp8cksYHGFOm+n7VPFLBMUpTF7QxL64WqsPs7vxq5WsWuY2vc4esimZYhB
	kzRAhWNgsydF2FyGPxhhyvXj14kgEjhCTIvQ2wruiQw8++SLR+J6HV6ZilpqFysBAwmWiYhWC31
	Caxe4NqS8Um4ajUSz7KgrNo0m3aMtglI6woycIdEhYzX3pJBGewPcKEL2kCZweeICi94UXICRxr
	0rWCwEIQ4dd2lukUN5/Yy4f5HvExgM1kKLpxFGORLnt5oH8sm5UUsS5Fhkd5whaSJj2WQ4zB1iE
	EUo0qIiD2m4Sdu5dpM8D5ouoJtIVlTYDJjX/fmf05G/IbbRLROzgcp39nP2vr+KdFbzfsDJmTiv
	Z3dQ9sihKuz+Wc65lyLFUnGvZI7Wu5Lv/bNH8aE54+Lg7qgNnyOTKQiMam5CF+S1x1o9SvDIJmJ
	OY6oVUrSlGki2WjDscHzZ/lm7QjCCWND1Ee6AJ2UiZg0Z8rqs6E0h4YMCKHJoV9j7f2MJQ0VH6y
	7XMlGvauqNZMaKXcybbp7SNwBAUoSLr7feD1+Mqz4M1eX6CX56C6IMIcYK9Co001RJrThmSWqiF
	DRLx+oMOQP+2ycxHwHA6JUpQ4TOpkEgs7GJSOX0oEEV2fS/o
X-Received: by 2002:a17:903:1b07:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d74df29e26mr215740625ad.14.1787955653649;
        Fri, 28 Aug 2026 15:20:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869aeesm9563725ad.46.2026.08.28.15.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:20:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: gianfar: handle startup_gfar failure and fix double free
Date: Fri, 28 Aug 2026 15:20:51 -0700
Message-ID: <20260828222051.77604-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reset_gfar() ignores the return value of startup_gfar(), so a reset
that fails to reallocate resources (e.g. -ENOMEM) leaves the interface
logically UP with stale descriptor-ring pointers. If the device is
closed afterwards, gfar_close() -> stop_gfar() -> free_skb_resources()
frees the same coherent DMA ring a second time, causing a double free
of the TX/RX buffer descriptors.

Make reset_gfar() and gfar_change_mtu() propagate the startup_gfar()
error instead of silently continuing. Make free_skb_resources() idempotent
by NULLing the descriptor-ring base pointers after freeing them, so a
second free cannot operate on a stale pointer regardless of which error
path is taken.

Fixes: 0851133bb5ad ("gianfar: Fix device reset races (oops) for Tx")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 42 +++++++++++++++++-------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index cf636fc5aafa..d0ac8a958696 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1140,11 +1140,24 @@ static void free_skb_resources(struct gfar_private *priv)
 			free_skb_rx_queue(rx_queue);
 	}
 
-	dma_free_coherent(priv->dev,
-			  sizeof(struct txbd8) * priv->total_tx_ring_size +
-			  sizeof(struct rxbd8) * priv->total_rx_ring_size,
-			  priv->tx_queue[0]->tx_bd_base,
-			  priv->tx_queue[0]->tx_bd_dma_base);
+	if (priv->tx_queue[0]->tx_bd_base) {
+		dma_free_coherent(priv->dev,
+				  sizeof(struct txbd8) *
+				  priv->total_tx_ring_size +
+				  sizeof(struct rxbd8) *
+				  priv->total_rx_ring_size,
+				  priv->tx_queue[0]->tx_bd_base,
+				  priv->tx_queue[0]->tx_bd_dma_base);
+
+		for (i = 0; i < priv->num_tx_queues; i++) {
+			priv->tx_queue[i]->tx_bd_base = NULL;
+			priv->tx_queue[i]->tx_bd_dma_base = 0;
+		}
+		for (i = 0; i < priv->num_rx_queues; i++) {
+			priv->rx_queue[i]->rx_bd_base = NULL;
+			priv->rx_queue[i]->rx_bd_dma_base = 0;
+		}
+	}
 }
 
 void stop_gfar(struct net_device *dev)
@@ -2003,6 +2016,7 @@ static int gfar_set_mac_address(struct net_device *dev)
 static int gfar_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct gfar_private *priv = netdev_priv(dev);
+	int err = 0;
 
 	while (test_and_set_bit_lock(GFAR_RESETTING, &priv->state))
 		cpu_relax();
@@ -2013,24 +2027,27 @@ static int gfar_change_mtu(struct net_device *dev, int new_mtu)
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	if (dev->flags & IFF_UP)
-		startup_gfar(dev);
+		err = startup_gfar(dev);
 
 	clear_bit_unlock(GFAR_RESETTING, &priv->state);
 
-	return 0;
+	return err;
 }
 
-static void reset_gfar(struct net_device *ndev)
+static int reset_gfar(struct net_device *ndev)
 {
 	struct gfar_private *priv = netdev_priv(ndev);
+	int ret;
 
 	while (test_and_set_bit_lock(GFAR_RESETTING, &priv->state))
 		cpu_relax();
 
 	stop_gfar(ndev);
-	startup_gfar(ndev);
+	ret = startup_gfar(ndev);
 
 	clear_bit_unlock(GFAR_RESETTING, &priv->state);
+
+	return ret;
 }
 
 /* gfar_reset_task gets scheduled when a packet has not been
@@ -2058,6 +2075,7 @@ static int gfar_hwtstamp_set(struct net_device *netdev,
 			     struct netlink_ext_ack *extack)
 {
 	struct gfar_private *priv = netdev_priv(netdev);
+	int ret = 0;
 
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
@@ -2076,7 +2094,7 @@ static int gfar_hwtstamp_set(struct net_device *netdev,
 	case HWTSTAMP_FILTER_NONE:
 		if (priv->hwts_rx_en) {
 			priv->hwts_rx_en = 0;
-			reset_gfar(netdev);
+			ret = reset_gfar(netdev);
 		}
 		break;
 	default:
@@ -2084,13 +2102,13 @@ static int gfar_hwtstamp_set(struct net_device *netdev,
 			return -ERANGE;
 		if (!priv->hwts_rx_en) {
 			priv->hwts_rx_en = 1;
-			reset_gfar(netdev);
+			ret = reset_gfar(netdev);
 		}
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int gfar_hwtstamp_get(struct net_device *netdev,
-- 
2.55.0

