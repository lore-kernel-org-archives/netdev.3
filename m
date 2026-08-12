Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91E352027
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524888; cv=none; b=kfVU84eFjjjrotXXDQVpQkBd/CM8jILY+iq4Ny9dSc/l2ktun1l+GkrCs/Lo1lIHiZ7/4GDWWX2F8ISRMqP+H7o1heHQgEx1Rsevxt9Rw/gbhco8OKhkM4vdxR/5GwLo+Veirx952d8piP3eAysJcJSaUEazhQ6YmAY26tgtcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524888; c=relaxed/simple;
	bh=g5+9E0vrsCsob6onbmp89Tt+JUQLodcipLtm+3H0dLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bzmh+uDRek63AhhjxjULPGHFCfLNXS/uUd7Ls3qWVkvwaF8q3ub7Tns82Vw2ShrBveQ2Vbb7g9znwSodOwhPOtp1Up590XXX37gpLVE+Q2imQOFlscXX0TFjLn45KEag7T/s3cIWJkxzHlbacbilR57uwkHwdAhdOa+reupumfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFpnfwS/; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFpnfwS/"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso13401841cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786524885; x=1787129685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56XmAaFcej+vXbwh5X/HnCYeyvnoKdMWUEo6mlL1ayw=;
        b=EFpnfwS/xacao/YVfHMYG3CyJ2Ipmk7kZzIWHmyuDqAU682aoD9LUGwQLaHj0CWrBA
         s8Ncpi4k0Xu14WT5SxpBxxtDJRlSdE9EwOaHaoTyKY4jbR4Mg/Md92AwPTlXbFbAwlka
         nirmS7IMXf3FU8BWHuSkMZDrGqrGDIHzxW+jDZh1pyRRzXHbidEbHpqK/KZfAVTOMOI0
         ndlpLaiw9VK2rjM67YzmpypVBD5pxrYGc3gS/VVp8AyDeel6VQ5TJoXezgHppqKbgtDy
         F9DEYgbTT/ZbSZZGFu9M2gJ/yrXV7h+wjoiQlU9CRlKGmv/0RGW0v50UleMH/3a8BLVe
         I8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524885; x=1787129685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56XmAaFcej+vXbwh5X/HnCYeyvnoKdMWUEo6mlL1ayw=;
        b=NVTQqookRybIPEI+iCaQXTwBEdeRC5wGMu3buibT5xT3oEB177mrKQ/RygLz7l+6+L
         umyxPGrkXIUnZJatYnUM4l4WCsfCqF2I+81tU/R65A5GHgaJBwARFOIMF5uawitkxu+C
         KH1OnvLCkxCs8QqNNz260DuglIwBm5JODeo2uGZEXsiKXevthFxpC1z1QWkTq0BZiTTM
         MgywG+MxXTbqwTb4OOuyf8kyLrZbvZKbGn0TCl1ybWY9DY3CU1ZZ7Q9rYqgCDBaJSly4
         MOBnHfXOHwHRlDtv5F6JG7XhD8Pnv5PYBM2f7bf0+2kVn3bSlK7dQwFPic/UG6SkLyEi
         nJAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrekLB3Qx+K3Filg6QJtott/Ug4gSerx3ZMMBRg2nG92cltDDE+K0bVn/1upZdVofUJjXPGhTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswPdrQXHT7xftqVJfsiNo5DAAuGbW7+enxkkVksT17mrHRvFe
	+HW9NiQUzu5yYn4MLBJZl6QYF7GjOysql65Fvzuwv5nSR/0WSIqt7K1dbfjvYIaMV3Aar9gVCLe
	HLiKMwIExtDOrTA==
X-Received: from qtbay30.prod.google.com ([2002:a05:622a:229e:b0:51c:acfe:2d6e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5916:b0:51c:a2ea:64d3 with SMTP id d75a77b69052e-52d6482dd01mr26103781cf.35.1786524884988;
 Wed, 12 Aug 2026 01:54:44 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:54:39 +0000
In-Reply-To: <20260812085440.3917924-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812085440.3917924-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812085440.3917924-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: add READ_ONCE()/WRITE_ONCE() annotations
 for dev->num_tc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Several fast-path and control-path lockless readers access dev->num_tc
(e.g., skb_tx_hash(), netdev_txq_to_tc(), netdev_get_num_tc(), and
qdisc/driver lookups) while concurrent writers update dev->num_tc
during TC setup, device reset, or channel configuration.

Add READ_ONCE() and WRITE_ONCE() annotations to prevent compiler
reordering and load/store tearing when accessing dev->num_tc.

Update inline helpers in netdevice.h (netdev_get_num_tc(),
netdev_set_prio_tc_map(), and netdev_get_sb_channel()) as well as
writers and lockless readers in core networking code and drivers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 12 +++++----
 drivers/net/ethernet/intel/igc/igc_tsn.c      |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 drivers/net/ethernet/sfc/falcon/net_driver.h  |  2 +-
 drivers/net/ethernet/sfc/falcon/tx.c          |  8 +++---
 drivers/net/ethernet/sfc/siena/tx.c           |  4 +--
 drivers/net/ethernet/ti/cpsw_priv.c           |  2 +-
 include/linux/netdevice.h                     |  8 +++---
 net/core/dev.c                                | 25 ++++++++++---------
 net/core/net-sysfs.c                          |  2 +-
 net/sched/sch_taprio.c                        |  7 +++---
 12 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 9e2c2fa16d7a50ed91667a9e8173262317e0184b..1ced6df6eac8c219220e5834476921739307be0a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1163,7 +1163,7 @@ static u16 cxgb_select_queue(struct net_device *dev, struct sk_buff *skb,
 	}
 #endif /* CONFIG_CHELSIO_T4_DCB */
 
-	if (dev->num_tc) {
+	if (netdev_get_num_tc(dev)) {
 		struct port_info *pi = netdev2pinfo(dev);
 		u8 ver, proto;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 764d2a09668f566c937979752ccde8b1eaee6248..6f1046c9cc5157f51c4f2c6d0245591c7cdc788f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1403,10 +1403,10 @@ static netdev_tx_t __dpaa2_eth_tx(struct sk_buff *skb,
 	struct dpaa2_eth_fq *fq;
 	struct netdev_queue *nq;
 	struct dpaa2_fd *fd;
+	int err, i, num_tc;
 	u16 queue_mapping;
 	void *swa = NULL;
 	u8 prio = 0;
-	int err, i;
 	u32 fd_len;
 
 	percpu_stats = this_cpu_ptr(priv->percpu_stats);
@@ -1468,12 +1468,14 @@ static netdev_tx_t __dpaa2_eth_tx(struct sk_buff *skb,
 	 */
 	queue_mapping = skb_get_queue_mapping(skb);
 
-	if (net_dev->num_tc) {
+	num_tc = netdev_get_num_tc(net_dev);
+
+	if (num_tc) {
 		prio = netdev_txq_to_tc(net_dev, queue_mapping);
 		/* Hardware interprets priority level 0 as being the highest,
 		 * so we need to do a reverse mapping to the netdev tc index
 		 */
-		prio = net_dev->num_tc - prio - 1;
+		prio = num_tc - prio - 1;
 		/* We have only one FQ array entry for all Tx hardware queues
 		 * with the same flow id (but different priority levels)
 		 */
@@ -2913,7 +2915,7 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 		return -ENOMEM;
 
 	num_queues = dpaa2_eth_queue_count(priv);
-	netdev_queues = (net_dev->num_tc ? : 1) * num_queues;
+	netdev_queues = (netdev_get_num_tc(net_dev) ? : 1) * num_queues;
 
 	/* The first <num_queues> entries in priv->fq array are Tx/Tx conf
 	 * queues, so only process those
@@ -2946,7 +2948,7 @@ static int dpaa2_eth_setup_mqprio(struct net_device *net_dev,
 	num_queues = dpaa2_eth_queue_count(priv);
 	num_tc = mqprio->num_tc;
 
-	if (num_tc == net_dev->num_tc)
+	if (num_tc == netdev_get_num_tc(net_dev))
 		return 0;
 
 	if (num_tc  > dpaa2_eth_tc_count(priv)) {
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 0c08650d3bb2d95f63529e9a950d6a00cd7d6eca..d23a45a34fa3c9d95af1639e44155df28038bf46 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -182,7 +182,7 @@ static u32 igc_fpe_map_preempt_tc_to_queue(const struct igc_adapter *adapter,
 	struct net_device *dev = adapter->netdev;
 	u32 i, queue = 0;
 
-	for (i = 0; i < dev->num_tc; i++) {
+	for (i = 0; i < netdev_get_num_tc(dev); i++) {
 		struct netdev_tc_txq res;
 		u32 offset, count;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8a877891e690d4250ac0e610553d65a686a3ed4d..fc110a7d16e8da994a0847dab868bf1da402d64e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3245,7 +3245,7 @@ static int mlx5e_update_tc_and_tx_queues(struct mlx5e_priv *priv)
 	int i;
 
 	old_num_txqs = netdev->real_num_tx_queues;
-	old_ntc = netdev->num_tc ? : 1;
+	old_ntc = netdev_get_num_tc(netdev) ? : 1;
 	for (i = 0; i < ARRAY_SIZE(old_tc_to_txq); i++)
 		old_tc_to_txq[i].combined = READ_ONCE(netdev->tc_to_txq[i].combined);
 
diff --git a/drivers/net/ethernet/sfc/falcon/net_driver.h b/drivers/net/ethernet/sfc/falcon/net_driver.h
index 7ab0db44720da7c4cd8e8190ad100698ad32ccee..63016bbae115b9d141e540c779528243c2fec2e2 100644
--- a/drivers/net/ethernet/sfc/falcon/net_driver.h
+++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
@@ -1208,7 +1208,7 @@ ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned type)
 
 static inline bool ef4_tx_queue_used(struct ef4_tx_queue *tx_queue)
 {
-	return !(tx_queue->efx->net_dev->num_tc < 2 &&
+	return !(netdev_get_num_tc(tx_queue->efx->net_dev) < 2 &&
 		 tx_queue->queue & EF4_TXQ_TYPE_HIGHPRI);
 }
 
diff --git a/drivers/net/ethernet/sfc/falcon/tx.c b/drivers/net/ethernet/sfc/falcon/tx.c
index e4d47d26a87a09ada5c1b85da099ff9147a25fe6..2103b6fdf9683daca84246bcb9d218827029fccb 100644
--- a/drivers/net/ethernet/sfc/falcon/tx.c
+++ b/drivers/net/ethernet/sfc/falcon/tx.c
@@ -435,7 +435,7 @@ int ef4_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 
 	mqprio->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
 
-	if (num_tc == net_dev->num_tc)
+	if (num_tc == netdev_get_num_tc(net_dev))
 		return 0;
 
 	for (tc = 0; tc < num_tc; tc++) {
@@ -447,7 +447,7 @@ int ef4_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 		WRITE_ONCE(net_dev->tc_to_txq[tc].combined, res.combined);
 	}
 
-	if (num_tc > net_dev->num_tc) {
+	if (num_tc > netdev_get_num_tc(net_dev)) {
 		/* Initialise high-priority queues as necessary */
 		ef4_for_each_channel(channel, efx) {
 			ef4_for_each_possible_channel_tx_queue(tx_queue,
@@ -466,7 +466,7 @@ int ef4_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 		}
 	} else {
 		/* Reduce number of classes before number of queues */
-		net_dev->num_tc = num_tc;
+		WRITE_ONCE(net_dev->num_tc, num_tc);
 	}
 
 	rc = netif_set_real_num_tx_queues(net_dev,
@@ -481,7 +481,7 @@ int ef4_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 	 * it to ef4_fini_channels().
 	 */
 
-	net_dev->num_tc = num_tc;
+	WRITE_ONCE(net_dev->num_tc, num_tc);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/sfc/siena/tx.c b/drivers/net/ethernet/sfc/siena/tx.c
index 1ce98f8fdaf81cffc0ff7d25e4cf3bb1f12acae3..67c77d67d98439f54bc5c1020c77461b6b97570f 100644
--- a/drivers/net/ethernet/sfc/siena/tx.c
+++ b/drivers/net/ethernet/sfc/siena/tx.c
@@ -376,7 +376,7 @@ int efx_siena_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 
 	mqprio->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
 
-	if (num_tc == net_dev->num_tc)
+	if (num_tc == netdev_get_num_tc(net_dev))
 		return 0;
 
 	for (tc = 0; tc < num_tc; tc++) {
@@ -388,7 +388,7 @@ int efx_siena_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
 		WRITE_ONCE(net_dev->tc_to_txq[tc].combined, res.combined);
 	}
 
-	net_dev->num_tc = num_tc;
+	WRITE_ONCE(net_dev->num_tc, num_tc);
 
 	return netif_set_real_num_tx_queues(net_dev,
 					    max_t(int, num_tc, 1) *
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 1f6f374551cb6e1db589d7bc235446429f13c095..0580a7885d3394cbd3e50d6669f3a4d1f0a361c4 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -949,7 +949,7 @@ static int cpsw_set_cbs(struct net_device *ndev,
 	 * limited first and for compliance with CPDMA rate limited channels
 	 * that also used in bacward order. FIFO0 cannot be rate limited.
 	 */
-	fifo = cpsw_tc_to_fifo(tc, ndev->num_tc);
+	fifo = cpsw_tc_to_fifo(tc, netdev_get_num_tc(ndev));
 	if (!fifo) {
 		dev_err(priv->dev, "Last tc%d can't be rate limited", tc);
 		return -EINVAL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ccb3da375f193251fa177b8dbdb0073e8e906735..db0002bd68f90fa4dd087edabc11549bc8ee0f66 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2677,7 +2677,7 @@ int netdev_get_prio_tc_map(const struct net_device *dev, u32 prio)
 static inline
 int netdev_set_prio_tc_map(struct net_device *dev, u8 prio, u8 tc)
 {
-	if (tc >= dev->num_tc)
+	if (tc >= READ_ONCE(dev->num_tc))
 		return -EINVAL;
 
 	dev->prio_tc_map[prio & TC_BITMASK] = tc & TC_BITMASK;
@@ -2690,9 +2690,9 @@ int netdev_set_tc_queue(struct net_device *dev, u8 tc, u16 count, u16 offset);
 int netdev_set_num_tc(struct net_device *dev, u8 num_tc);
 
 static inline
-int netdev_get_num_tc(struct net_device *dev)
+int netdev_get_num_tc(const struct net_device *dev)
 {
-	return dev->num_tc;
+	return READ_ONCE(dev->num_tc);
 }
 
 static inline void net_prefetch(void *p)
@@ -2719,7 +2719,7 @@ int netdev_bind_sb_channel_queue(struct net_device *dev,
 int netdev_set_sb_channel(struct net_device *dev, u16 channel);
 static inline int netdev_get_sb_channel(struct net_device *dev)
 {
-	return max_t(int, -dev->num_tc, 0);
+	return max_t(int, -READ_ONCE(dev->num_tc), 0);
 }
 
 static inline
diff --git a/net/core/dev.c b/net/core/dev.c
index 6fab5f3046f9a64573121796bf4889d8611f49ff..8ffae11d272e979bab5b64f4d912d3d97f738d48 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2664,7 +2664,7 @@ static void netif_setup_tc(struct net_device *dev, unsigned int txq)
 	/* If TC0 is invalidated disable TC mapping */
 	if (res.offset + res.count > txq) {
 		netdev_warn(dev, "Number of in use tx queues changed invalidating tc mappings. Priority traffic classification disabled!\n");
-		dev->num_tc = 0;
+		WRITE_ONCE(dev->num_tc, 0);
 		return;
 	}
 
@@ -2683,7 +2683,7 @@ static void netif_setup_tc(struct net_device *dev, unsigned int txq)
 
 int netdev_txq_to_tc(struct net_device *dev, unsigned int txq)
 {
-	if (dev->num_tc) {
+	if (READ_ONCE(dev->num_tc)) {
 		struct netdev_tc_txq *tc = &dev->tc_to_txq[0];
 		int i;
 
@@ -2885,18 +2885,19 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 			  u16 index, enum xps_map_type type)
 {
 	struct xps_dev_maps *dev_maps, *new_dev_maps = NULL, *old_dev_maps = NULL;
+	int maps_sz, num_tc = 1, tc = 0, dev_num_tc;
 	const unsigned long *online_mask = NULL;
 	bool active = false, copy = false;
 	int i, j, tci, numa_node_id = -2;
-	int maps_sz, num_tc = 1, tc = 0;
 	struct xps_map *map, *new_map;
 	unsigned int nr_ids;
 
 	WARN_ON_ONCE(index >= dev->num_tx_queues);
 
-	if (dev->num_tc) {
+	dev_num_tc = READ_ONCE(dev->num_tc);
+	if (dev_num_tc) {
 		/* Do not allow XPS on subordinate device directly */
-		num_tc = dev->num_tc;
+		num_tc = dev_num_tc;
 		if (num_tc < 0)
 			return -EINVAL;
 
@@ -3120,7 +3121,7 @@ void netdev_reset_tc(struct net_device *dev)
 	netdev_unbind_all_sb_channels(dev);
 
 	/* Reset TC configuration of device */
-	dev->num_tc = 0;
+	WRITE_ONCE(dev->num_tc, 0);
 	for (i = 0; i < TC_MAX_QUEUE; i++)
 		WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
 	memset(dev->prio_tc_map, 0, sizeof(dev->prio_tc_map));
@@ -3134,7 +3135,7 @@ int netdev_set_tc_queue(struct net_device *dev, u8 tc, u16 count, u16 offset)
 		.offset = offset,
 	};
 
-	if (tc >= dev->num_tc)
+	if (tc >= READ_ONCE(dev->num_tc))
 		return -EINVAL;
 
 #ifdef CONFIG_XPS
@@ -3155,7 +3156,7 @@ int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
 #endif
 	netdev_unbind_all_sb_channels(dev);
 
-	dev->num_tc = num_tc;
+	WRITE_ONCE(dev->num_tc, num_tc);
 	return 0;
 }
 EXPORT_SYMBOL(netdev_set_num_tc);
@@ -3185,7 +3186,7 @@ int netdev_bind_sb_channel_queue(struct net_device *dev,
 				 u8 tc, u16 count, u16 offset)
 {
 	/* Make certain the sb_dev and dev are already configured */
-	if (sb_dev->num_tc >= 0 || tc >= dev->num_tc)
+	if (READ_ONCE(sb_dev->num_tc) >= 0 || tc >= READ_ONCE(dev->num_tc))
 		return -EINVAL;
 
 	/* We cannot hand out queues we don't have */
@@ -3224,7 +3225,7 @@ int netdev_set_sb_channel(struct net_device *dev, u16 channel)
 	if (channel > S16_MAX)
 		return -EINVAL;
 
-	dev->num_tc = -channel;
+	WRITE_ONCE(dev->num_tc, -channel);
 
 	return 0;
 }
@@ -3253,7 +3254,7 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 		if (rc)
 			return rc;
 
-		if (dev->num_tc)
+		if (READ_ONCE(dev->num_tc))
 			netif_setup_tc(dev, txq);
 
 		net_shaper_set_real_num_tx_queues(dev, txq);
@@ -3562,7 +3563,7 @@ static u16 skb_tx_hash(const struct net_device *dev,
 	u16 qoffset = 0;
 	u16 qcount = dev->real_num_tx_queues;
 
-	if (dev->num_tc) {
+	if (READ_ONCE(dev->num_tc)) {
 		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
 		struct netdev_tc_txq res;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 25546deacec8024eb6b05c4a926c1c4c64ccb266..352173df757850af75641501dfa1a91585515a5e 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1432,7 +1432,7 @@ static ssize_t traffic_class_show(struct kobject *kobj, struct attribute *attr,
 	/* If queue belongs to subordinate dev use its TC mapping */
 	dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
 
-	num_tc = dev->num_tc;
+	num_tc = READ_ONCE(dev->num_tc);
 	tc = netdev_txq_to_tc(dev, index);
 
 	rtnl_unlock();
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 7d5fe93a4c12434cc1c35594ea6de0e88ac67260..18fcb4e78456a2f74fa5d3465175d100a39575b4 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1185,7 +1185,7 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
 	bool allow_overlapping_txqs = TXTIME_ASSIST_IS_ENABLED(taprio_flags);
 
 	if (!qopt) {
-		if (!dev->num_tc) {
+		if (!netdev_get_num_tc(dev)) {
 			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
 			return -EINVAL;
 		}
@@ -1439,9 +1439,10 @@ static void taprio_offload_config_changed(struct taprio_sched *q)
 
 static u32 tc_map_to_queue_mask(struct net_device *dev, u32 tc_mask)
 {
+	int num_tc = netdev_get_num_tc(dev);
 	u32 i, queue_mask = 0;
 
-	for (i = 0; i < dev->num_tc; i++) {
+	for (i = 0; i < num_tc; i++) {
 		struct netdev_tc_txq res;
 
 		if (!(tc_mask & BIT(i)))
@@ -1799,7 +1800,7 @@ static int taprio_mqprio_cmp(const struct net_device *dev,
 {
 	int i;
 
-	if (!mqprio || mqprio->num_tc != dev->num_tc)
+	if (!mqprio || mqprio->num_tc != netdev_get_num_tc(dev))
 		return -1;
 
 	for (i = 0; i < mqprio->num_tc; i++) {
-- 
2.55.0.679.g6767b8d81c-goog

