Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762D3BCD14
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524887; cv=none; b=qdEKSdFlwNbdKPRjAUJoxipXvHzK/+CGSdylhotvCyN2Ez2SQc+OQ4Ti+b0+8k+CaWKfBB+HB7pT+jfwIG8UDRqmUZjXeXHO7lew/KXvFN+gDxcIQ1xGS56cDHjCkQ7nY/ggHgwYEmqVIYnk8FlWTU6r1CE5KW9Co4pD4yYDgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524887; c=relaxed/simple;
	bh=JdAnbuRWiJKz7fmCSIu+WVRgOZ24gGUWN6DgPGNmdFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p18fPugyNdtkvzCp6Wz+/AZTLUcOdJ+KS/LfOAdxj6+Cv8C2W6Z4NDsERRKybz8c+53QA2EYJLebNd4p01NHsJgezEPNlC6LB+okqzbu/sPEq1YPA6INtTUlwC1C6lyiJDlGoKI9MoN7PypyCsxV7JXq+aOv3tfB/OYPIH3oo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJfWGHGB; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJfWGHGB"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso12643191cf.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786524884; x=1787129684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jz9U2iP/pMyrc8QeDRMAJy4FNgdpFwGcW9pOJSIx/Qo=;
        b=GJfWGHGBra07ThyJLqym70BR6mKWqiXc+NiDmaCB7VOPlmN01IfhuW4g6HXzJim2IR
         Isvht3SNtrxODU3A7NJKZKDztQyxlXNvn3BWOgDStB1D3oDdyaSK+Mt6rkC7HOUoCqRl
         yEcJ0+/thzjZOv40YFFhQ2avhkdLL7B2GUoTsQ22HwwWc3fVl1yN49zQHyabvMpZCf6y
         MX+GudMdsECQ5jiKtHOviJHxkVyJJcQZdlvKgoKdvJVZe9gc23Gy+2ow4w6kUYqMQGuo
         1Px/Uvc8DYHS4l5tlAs0oKDAURMqlfOsABnZF8VeKd8weAz80DwJzBbJ6PIk4O7xAXy2
         FGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524884; x=1787129684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jz9U2iP/pMyrc8QeDRMAJy4FNgdpFwGcW9pOJSIx/Qo=;
        b=N5EIX7khtv9A0lnvBKBH3/piJCgshtmbvXqm4skOg5gYpeWusxgtQLT0oiF7arhIfG
         Upvm4W6od8orgoE92a00Cx5ce9CEOpnDhOQJlD3wZPAF5yrzSb0TAP9WClkbokKHhGWP
         ywpxNCMmqDBmxe98NW86IAYz2IpvljqXzqImJ0cn9NpTbhbq8mRI080pvdkk30gsZm/6
         XcBZnyhIzzXN+cW/gy0eAQDKmD+6r6VGrN/eWQIa7hJc3oYCQd+O5dbJNMaKaW8IumMG
         LHoWYgfljI9th0cD1Hz7gJ7WbnGTIHBLGRqhKIjO6gLg84g65QejnHx/AmSVtUa/+o2z
         Z2uA==
X-Forwarded-Encrypted: i=1; AHgh+RrQwQq5cIxVj/g+c4d0j/ONg6TOYldFQ7JyelFUq1I/Ci3GufQ6q/CDZfqtYxr5oSaXViiqvsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54yFN7AeUptbgN/w83er4QtWClImtVq8cYcqRNfjaTgQEpg7e
	Mer4ZpSPmgCq6NrztGv12VygNeuvN9WOv0Npt8u/zcMSWYNnnVed1DV9WM8KC4MFl/oB+6qGaPa
	Xn5StIHJNyhe83w==
X-Received: from qtnc13.prod.google.com ([2002:ac8:518d:0:b0:51c:91db:e7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a9b:b0:51b:fe3c:6c1 with SMTP id d75a77b69052e-52d647f3112mr24975071cf.27.1786524883460;
 Wed, 12 Aug 2026 01:54:43 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:54:38 +0000
In-Reply-To: <20260812085440.3917924-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812085440.3917924-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812085440.3917924-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: prevent torn reads in netdev_tc_txq
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_set_tc_queue() (and related helpers/drivers such as
netdev_bind_sb_channel_queue(), netdev_reset_tc(), and
netdev_unbind_sb_channel()) perform separate 16-bit writes to
dev->tc_to_txq[tc].count and dev->tc_to_txq[tc].offset.

Furthermore, memset() in netdev_reset_tc() and
netdev_unbind_sb_channel() provides no guarantee of performing
full 32-bit word stores.

Concurrent lockless readers (e.g. skb_tx_hash(), netdev_txq_to_tc(),
ixgbe_select_queue(), taprio, mqprio, FPE drivers) can observe torn
values where offset and count belong to inconsistent configurations.

Redefine struct netdev_tc_txq to embed count and offset inside a union
with a u32 combined field, allowing atomic manipulation via
READ_ONCE() and WRITE_ONCE().

Update all lockless readers and writers across the kernel to use
READ_ONCE() and WRITE_ONCE() on the combined field.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c      |  6 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  7 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 drivers/net/ethernet/sfc/falcon/tx.c          |  8 +++-
 drivers/net/ethernet/sfc/siena/tx.c           |  8 +++-
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 14 ++++--
 include/linux/netdevice.h                     |  9 +++-
 net/core/dev.c                                | 46 +++++++++++++------
 net/sched/sch_mqprio.c                        |  4 +-
 net/sched/sch_mqprio_lib.c                    |  7 ++-
 net/sched/sch_taprio.c                        | 26 ++++++-----
 11 files changed, 94 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 52de2bcbadbec7a4443e8754eb914fe8b892c71d..0c08650d3bb2d95f63529e9a950d6a00cd7d6eca 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -183,13 +183,15 @@ static u32 igc_fpe_map_preempt_tc_to_queue(const struct igc_adapter *adapter,
 	u32 i, queue = 0;
 
 	for (i = 0; i < dev->num_tc; i++) {
+		struct netdev_tc_txq res;
 		u32 offset, count;
 
 		if (!(preemptible_tcs & BIT(i)))
 			continue;
 
-		offset = dev->tc_to_txq[i].offset;
-		count = dev->tc_to_txq[i].count;
+		res.combined = READ_ONCE(dev->tc_to_txq[i].combined);
+		offset = res.offset;
+		count = res.count;
 		queue |= GENMASK(offset + count - 1, offset);
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8873a8cc4a1851fc108cbf8d603f8b3e7ecc29a9..f91856498eb2d9e0e4173153c8c00bc2248bb708 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9273,10 +9273,11 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 	if (sb_dev) {
 		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
 		struct net_device *vdev = sb_dev;
+		struct netdev_tc_txq res;
 
-		txq = vdev->tc_to_txq[tc].offset;
-		txq += reciprocal_scale(skb_get_hash(skb),
-					vdev->tc_to_txq[tc].count);
+		res.combined = READ_ONCE(vdev->tc_to_txq[tc].combined);
+		txq = res.offset;
+		txq += reciprocal_scale(skb_get_hash(skb), res.count);
 
 		return txq;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ca3d7c6b5210e4b057ffb0becf6775a8f559247d..8a877891e690d4250ac0e610553d65a686a3ed4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3247,7 +3247,7 @@ static int mlx5e_update_tc_and_tx_queues(struct mlx5e_priv *priv)
 	old_num_txqs = netdev->real_num_tx_queues;
 	old_ntc = netdev->num_tc ? : 1;
 	for (i = 0; i < ARRAY_SIZE(old_tc_to_txq); i++)
-		old_tc_to_txq[i] = netdev->tc_to_txq[i];
+		old_tc_to_txq[i].combined = READ_ONCE(netdev->tc_to_txq[i].combined);
 
 	nch = priv->channels.params.num_channels;
 	ntc = priv->channels.params.mqprio.num_tc;
diff --git a/drivers/net/ethernet/sfc/falcon/tx.c b/drivers/net/ethernet/sfc/falcon/tx.c
index 9e18aaf44baddeab3e933eb8cad0b07ecb134b16..e4d47d26a87a09ada5c1b85da099ff9147a25fe6 100644
--- a/drivers/net/ethernet/sfc/falcon/tx.c
+++ b/drivers/net/ethernet/sfc/falcon/tx.c
@@ -439,8 +439,12 @@ int ef4_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 		return 0;
 
 	for (tc = 0; tc < num_tc; tc++) {
-		net_dev->tc_to_txq[tc].offset = tc * efx->n_tx_channels;
-		net_dev->tc_to_txq[tc].count = efx->n_tx_channels;
+		struct netdev_tc_txq res = {
+			.offset = tc * efx->n_tx_channels,
+			.count = efx->n_tx_channels,
+		};
+
+		WRITE_ONCE(net_dev->tc_to_txq[tc].combined, res.combined);
 	}
 
 	if (num_tc > net_dev->num_tc) {
diff --git a/drivers/net/ethernet/sfc/siena/tx.c b/drivers/net/ethernet/sfc/siena/tx.c
index 91e87594ed1eac18e8dbec04c9b29161a3ef0b54..1ce98f8fdaf81cffc0ff7d25e4cf3bb1f12acae3 100644
--- a/drivers/net/ethernet/sfc/siena/tx.c
+++ b/drivers/net/ethernet/sfc/siena/tx.c
@@ -380,8 +380,12 @@ int efx_siena_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 		return 0;
 
 	for (tc = 0; tc < num_tc; tc++) {
-		net_dev->tc_to_txq[tc].offset = tc * efx->n_tx_channels;
-		net_dev->tc_to_txq[tc].count = efx->n_tx_channels;
+		struct netdev_tc_txq res = {
+			.offset = tc * efx->n_tx_channels,
+			.count = efx->n_tx_channels,
+		};
+
+		WRITE_ONCE(net_dev->tc_to_txq[tc].combined, res.combined);
 	}
 
 	net_dev->num_tc = num_tc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c54c702243517d502c1e14641cf859b35f508681..c889204a7aa5d2e74f7834ed1a22252e6c51ca36 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -217,8 +217,11 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 	 * and is direct one-to-one mapping."
 	 */
 	for (u32 tc = 0; tc < num_tc; tc++) {
-		count = ndev->tc_to_txq[tc].count;
-		offset = ndev->tc_to_txq[tc].offset;
+		struct netdev_tc_txq res;
+
+		res.combined = READ_ONCE(ndev->tc_to_txq[tc].combined);
+		count = res.count;
+		offset = res.offset;
 
 		if (pclass & BIT(tc))
 			preemptible_txqs |= GENMASK(offset + count - 1, offset);
@@ -275,8 +278,11 @@ int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
 	 * any of the scheduling algorithms."
 	 */
 	for (u32 tc = 0; tc < num_tc; tc++) {
-		count = ndev->tc_to_txq[tc].count;
-		offset = ndev->tc_to_txq[tc].offset;
+		struct netdev_tc_txq res;
+
+		res.combined = READ_ONCE(ndev->tc_to_txq[tc].combined);
+		count = res.count;
+		offset = res.offset;
 
 		if (pclass & BIT(tc))
 			preemptible_txqs |= GENMASK(offset + count - 1, offset);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index db9dce7f0aa65fbd3056425a8a3a4e26659d43b9..ccb3da375f193251fa177b8dbdb0073e8e906735 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -832,8 +832,13 @@ struct xps_dev_maps {
 #define TC_BITMASK	15
 /* HW offloaded queuing disciplines txq count and offset maps */
 struct netdev_tc_txq {
-	u16 count;
-	u16 offset;
+	union {
+		struct {
+			u16 count;
+			u16 offset;
+		};
+		u32 combined;
+	};
 };
 
 #if defined(CONFIG_FCOE) || defined(CONFIG_FCOE_MODULE)
diff --git a/net/core/dev.c b/net/core/dev.c
index fd0b445f5d38c2a2087318f029c86ffdab38aad4..6fab5f3046f9a64573121796bf4889d8611f49ff 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2656,11 +2656,13 @@ EXPORT_SYMBOL_GPL(dev_queue_xmit_nit);
  */
 static void netif_setup_tc(struct net_device *dev, unsigned int txq)
 {
+	struct netdev_tc_txq res;
 	int i;
-	struct netdev_tc_txq *tc = &dev->tc_to_txq[0];
+
+	res.combined = READ_ONCE(dev->tc_to_txq[0].combined);
 
 	/* If TC0 is invalidated disable TC mapping */
-	if (tc->offset + tc->count > txq) {
+	if (res.offset + res.count > txq) {
 		netdev_warn(dev, "Number of in use tx queues changed invalidating tc mappings. Priority traffic classification disabled!\n");
 		dev->num_tc = 0;
 		return;
@@ -2670,8 +2672,8 @@ static void netif_setup_tc(struct net_device *dev, unsigned int txq)
 	for (i = 1; i < TC_BITMASK + 1; i++) {
 		int q = netdev_get_prio_tc_map(dev, i);
 
-		tc = &dev->tc_to_txq[q];
-		if (tc->offset + tc->count > txq) {
+		res.combined = READ_ONCE(dev->tc_to_txq[q].combined);
+		if (res.offset + res.count > txq) {
 			netdev_warn(dev, "Number of in use tx queues changed. Priority %i to tc mapping %i is no longer valid. Setting map to 0\n",
 				    i, q);
 			netdev_set_prio_tc_map(dev, i, 0);
@@ -2687,7 +2689,10 @@ int netdev_txq_to_tc(struct net_device *dev, unsigned int txq)
 
 		/* walk through the TCs and see if it falls into any of them */
 		for (i = 0; i < TC_MAX_QUEUE; i++, tc++) {
-			if ((txq - tc->offset) < tc->count)
+			struct netdev_tc_txq res;
+
+			res.combined = READ_ONCE(tc->combined);
+			if ((txq - res.offset) < res.count)
 				return i;
 		}
 
@@ -3107,6 +3112,8 @@ static void netdev_unbind_all_sb_channels(struct net_device *dev)
 
 void netdev_reset_tc(struct net_device *dev)
 {
+	int i;
+
 #ifdef CONFIG_XPS
 	netif_reset_xps_queues_gt(dev, 0);
 #endif
@@ -3114,21 +3121,26 @@ void netdev_reset_tc(struct net_device *dev)
 
 	/* Reset TC configuration of device */
 	dev->num_tc = 0;
-	memset(dev->tc_to_txq, 0, sizeof(dev->tc_to_txq));
+	for (i = 0; i < TC_MAX_QUEUE; i++)
+		WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
 	memset(dev->prio_tc_map, 0, sizeof(dev->prio_tc_map));
 }
 EXPORT_SYMBOL(netdev_reset_tc);
 
 int netdev_set_tc_queue(struct net_device *dev, u8 tc, u16 count, u16 offset)
 {
+	struct netdev_tc_txq res = {
+		.count = count,
+		.offset = offset,
+	};
+
 	if (tc >= dev->num_tc)
 		return -EINVAL;
 
 #ifdef CONFIG_XPS
 	netif_reset_xps_queues(dev, offset, count);
 #endif
-	dev->tc_to_txq[tc].count = count;
-	dev->tc_to_txq[tc].offset = offset;
+	WRITE_ONCE(dev->tc_to_txq[tc].combined, res.combined);
 	return 0;
 }
 EXPORT_SYMBOL(netdev_set_tc_queue);
@@ -3152,11 +3164,13 @@ void netdev_unbind_sb_channel(struct net_device *dev,
 			      struct net_device *sb_dev)
 {
 	struct netdev_queue *txq = &dev->_tx[dev->num_tx_queues];
+	int i;
 
 #ifdef CONFIG_XPS
 	netif_reset_xps_queues_gt(sb_dev, 0);
 #endif
-	memset(sb_dev->tc_to_txq, 0, sizeof(sb_dev->tc_to_txq));
+	for (i = 0; i < TC_MAX_QUEUE; i++)
+		WRITE_ONCE(sb_dev->tc_to_txq[i].combined, 0);
 	memset(sb_dev->prio_tc_map, 0, sizeof(sb_dev->prio_tc_map));
 
 	while (txq-- != &dev->_tx[0]) {
@@ -3179,8 +3193,12 @@ int netdev_bind_sb_channel_queue(struct net_device *dev,
 		return -EINVAL;
 
 	/* Record the mapping */
-	sb_dev->tc_to_txq[tc].count = count;
-	sb_dev->tc_to_txq[tc].offset = offset;
+	struct netdev_tc_txq res = {
+		.count = count,
+		.offset = offset,
+	};
+
+	WRITE_ONCE(sb_dev->tc_to_txq[tc].combined, res.combined);
 
 	/* Provide a way for Tx queue to find the tc_to_txq map or
 	 * XPS map for itself.
@@ -3546,9 +3564,11 @@ static u16 skb_tx_hash(const struct net_device *dev,
 
 	if (dev->num_tc) {
 		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
+		struct netdev_tc_txq res;
 
-		qoffset = sb_dev->tc_to_txq[tc].offset;
-		qcount = sb_dev->tc_to_txq[tc].count;
+		res.combined = READ_ONCE(sb_dev->tc_to_txq[tc].combined);
+		qoffset = res.offset;
+		qcount = res.count;
 		if (unlikely(!qcount)) {
 			net_warn_ratelimited("%s: invalid qcount, qoffset %u for tc %u\n",
 					     sb_dev->name, qoffset, tc);
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index ae991fc25b43f24efb3b53fce6f6b53718a9b774..6ced7008ef5c8413c76c3122c9d1d4b824702e99 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -679,12 +679,14 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	rcu_read_lock();
 	if (cl >= TC_H_MIN_PRIORITY) {
 		struct net_device *dev = qdisc_dev(sch);
-		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
+		struct netdev_tc_txq tc;
 		struct gnet_stats_queue qstats = {0};
 		struct gnet_stats_basic_sync bstats;
 		u32 qlen = 0;
 		int i;
 
+		tc.combined = READ_ONCE(dev->tc_to_txq[cl & TC_BITMASK].combined);
+
 		gnet_stats_basic_sync_init(&bstats);
 
 		for (i = tc.offset; i < tc.offset + tc.count; i++) {
diff --git a/net/sched/sch_mqprio_lib.c b/net/sched/sch_mqprio_lib.c
index b3a5572c167b719f96e2947fa4267f1f93077814..b60e130c70781479eed0ea5a02d01197f03f4895 100644
--- a/net/sched/sch_mqprio_lib.c
+++ b/net/sched/sch_mqprio_lib.c
@@ -108,8 +108,11 @@ void mqprio_qopt_reconstruct(struct net_device *dev, struct tc_mqprio_qopt *qopt
 	memcpy(qopt->prio_tc_map, dev->prio_tc_map, sizeof(qopt->prio_tc_map));
 
 	for (tc = 0; tc < num_tc; tc++) {
-		qopt->count[tc] = dev->tc_to_txq[tc].count;
-		qopt->offset[tc] = dev->tc_to_txq[tc].offset;
+		struct netdev_tc_txq res;
+
+		res.combined = READ_ONCE(dev->tc_to_txq[tc].combined);
+		qopt->count[tc] = res.count;
+		qopt->offset[tc] = res.offset;
 	}
 }
 EXPORT_SYMBOL_GPL(mqprio_qopt_reconstruct);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 299234a5f0fe60589ef9594a8e685bb8cf751e2d..7d5fe93a4c12434cc1c35594ea6de0e88ac67260 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -762,12 +762,13 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 
 static void taprio_next_tc_txq(struct net_device *dev, int tc, int *txq)
 {
-	int offset = dev->tc_to_txq[tc].offset;
-	int count = dev->tc_to_txq[tc].count;
+	struct netdev_tc_txq res;
+
+	res.combined = READ_ONCE(dev->tc_to_txq[tc].combined);
 
 	(*txq)++;
-	if (*txq == offset + count)
-		*txq = offset;
+	if (*txq == res.offset + res.count)
+		*txq = res.offset;
 }
 
 /* Prioritize higher traffic classes, and select among TXQs belonging to the
@@ -1441,15 +1442,14 @@ static u32 tc_map_to_queue_mask(struct net_device *dev, u32 tc_mask)
 	u32 i, queue_mask = 0;
 
 	for (i = 0; i < dev->num_tc; i++) {
-		u32 offset, count;
+		struct netdev_tc_txq res;
 
 		if (!(tc_mask & BIT(i)))
 			continue;
 
-		offset = dev->tc_to_txq[i].offset;
-		count = dev->tc_to_txq[i].count;
+		res.combined = READ_ONCE(dev->tc_to_txq[i].combined);
 
-		queue_mask |= GENMASK(offset + count - 1, offset);
+		queue_mask |= GENMASK(res.offset + res.count - 1, res.offset);
 	}
 
 	return queue_mask;
@@ -1802,10 +1802,14 @@ static int taprio_mqprio_cmp(const struct net_device *dev,
 	if (!mqprio || mqprio->num_tc != dev->num_tc)
 		return -1;
 
-	for (i = 0; i < mqprio->num_tc; i++)
-		if (dev->tc_to_txq[i].count != mqprio->count[i] ||
-		    dev->tc_to_txq[i].offset != mqprio->offset[i])
+	for (i = 0; i < mqprio->num_tc; i++) {
+		struct netdev_tc_txq res;
+
+		res.combined = READ_ONCE(dev->tc_to_txq[i].combined);
+		if (res.count != mqprio->count[i] ||
+		    res.offset != mqprio->offset[i])
 			return -1;
+	}
 
 	for (i = 0; i <= TC_BITMASK; i++)
 		if (dev->prio_tc_map[i] != mqprio->prio_tc_map[i])
-- 
2.55.0.679.g6767b8d81c-goog

