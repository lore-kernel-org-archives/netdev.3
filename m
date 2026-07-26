Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871437C118
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097753; cv=none; b=qEhYAs8vQuF6Ca4LLEiQ81BX54+hxx+KaWwIwsLtTSGFmu8QGCkLaRsKAlEDnhNXXin5Wn5UAQjLx07TA2p5IvtgP+GL4zMKjot9tUzSrm6VgAx2gOqw0R7Al2gN2wG4hn5eljwQFmwHRCm7ldPhnID8YENFG0Gsmxz67bcBEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097753; c=relaxed/simple;
	bh=FIW+83FHEsmSjybWqkgUAIKtwxHVjNrejgVUkYOZg/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsigrvhrsTjk8wmPZUYprAhTlPwCRHbOVKnLpbDsAvFkO8Iqd/8tGAkkuSaOK5o1V56LFp5pLxc6KqG/bwjwZpKH8/tcF1VSHce4KiDUQ5CWpC+JOIwaHDbjHx3ZvjFRk63VV48kAZfWbDfkkB1y5okuzTYhwt7bNsLP7TLTIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXNSj+I0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXNSj+I0"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81eff3ddba4so24627137b3.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097750; x=1785702550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOplvL6askyTRu2yymzHMfRJvs6hm9pOLxvYugmtTpQ=;
        b=EXNSj+I05WAWpPTVeR8HWPU/PQhEG5bWLTZ3qpoFW2H0P3HabNiv8K2l9HjGwwn11J
         I+BDtReadbETA2V4EBe8chIX7jDyzNkrLJtsY2Ajb+MaQyA17JfOAI/P5l7xex5h8x9L
         6UmequBCqs57/xhhOXzEycHQjin+scoUvkNyWd2MgxkfB4ZvMQFrXYBQEtmXL14kbSsE
         C1mjrIXtkUlcnQT92cBf6GIZc5pMMnn9Pe5LDt2sYWKitZRKrGur+6qObQVrsCXqvnm2
         HeMvc7/bei/V3ML4Hq/2wMobd4cpMDdkikoifkoqzhXrB39RIpvaaNV22dWYLRCMOh8C
         ZoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097750; x=1785702550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOplvL6askyTRu2yymzHMfRJvs6hm9pOLxvYugmtTpQ=;
        b=DtNhIxqkS6C3lN9xAir57hlT3IF2yZ9uILRXFeCk5jW3P//S8hk+atRrKOHEsyb0RK
         WIEy5/dUMQCbGb0SYwdIgydwb5SYRYNg/AxHbtvv8JJbrOHyWemCSqrQWiaoj99zRuF1
         +oavcJdRcNlkh4UAtzrg2AB9JHwA09OJ1P+mPrandJ/nUEvKW4FTxXRKmRlZOCcVpSdA
         GUDjMcPEuUAlti7OI3ZxUvM2VLP3Zgjd7snmIV4ZH8Jn+hqTRtrtluCHj4/eQKpYAutg
         PnjgcmJtqTUHTs+lQBml4lPklWHxPFQT2sAu6hHXr2E5NyaqRvfT+roMfYW/Q8YjimZN
         dbQA==
X-Gm-Message-State: AOJu0Yy1FKg9p8GGl316dFHsXlEIQxvFujKbXlQ5U02tx3HUhxozORZa
	lXZfLL/AP+pyUL8VJXZryQUnr88dReubq8xHNaoFha+yeSOygi1BP0LELuExwfib
X-Gm-Gg: AR+sD13HDaTPJzsdTb5Sw4Z17Ut3ymo21Wm4kyUZcutFETAVUZn+uxCq7ZcKHlKPKKw
	oXlYAPLT3FEVqO1B0ZxoWplDXGbxTEVxhv75qyHcSetChQ/kdnDQsB5lNkzK2I+y6fDbTwziU5q
	tNe8wwnK5naSCQAmuV1GDm8CEzToLmwBJU1Uwu0oVE5H10WRoe3Cwhj4tfLRYuev9ubQm1lefUS
	Zv6JbgVPxsKSDB080w3nqK5/Dvr8I0CXHDjkJsHmqJYw8ceBTm81pnnBzvN04QhBlsW/VJgmrOq
	+nYLl9QMnfFOJReq/sYoSMNeVJzIWlCmnifn+ovMasKx6oRFBvB5f4Xv9IluKMR+q2LYvyyn3nf
	gFsRF6KF/km0THozdDfK60w32xTaXIXvsSNEseq69A1ZR0ZG75AXqQnY420jF0NUJoVmXI4rCuh
	M5KfrxHejQVpdbNb777AES5nMtwfrm2doG6KMvqfcwD+EhPbUz6XoO6v23v+LObaftJN1dRUiJ
X-Received: by 2002:a05:690c:650e:b0:80c:8596:4656 with SMTP id 00721157ae682-81f69ebb0d4mr18274737b3.72.1785097750474;
        Sun, 26 Jul 2026 13:29:10 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm23339467b3.13.2026.07.26.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:29:09 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	mohsin.bashr@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 1/7] net: ethtool: add hardware pacing offload support to rings
Date: Sun, 26 Jul 2026 16:28:45 -0400
Message-ID: <20260726202902.760552-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Add two ethtool rings operations:

- get pacing offload horizon: active and max
- set pacing offload horizon: active

Replace u64 max_pacing_offload_horizon with u32 active and max fields.
This occupies the same original 8 bytes. Reduce precision from nsec to
usec, which is sufficient.

Update the FQ scheduler to test against the active limit instead of
max. It is the administrator responsibility to set the active limit
before installing FQ.

Ethtool updates to pacing_offload_horizon immediately take effect and
are non-disruptive.

Assisted-by: Gemini:gemini-3
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v2 -> v3
    - READ_ONCE/WRITE_ONCE annotate the new dev field accesses
    - add fields to &ring anchor used by rings-get and rings-set
    - add comment on non-disruptive update
  v2: https://lore.kernel.org/netdev/20260722204454.3234605-2-willemdebruijn.kernel@gmail.com/
  v1 -> v2
    - (minor) style: remove period from end of ethtool comments
    - (minor) style: fix missing space at end of HDS_THRESH comment
  v1: https://lore.kernel.org/netdev/20260706133433.3142805-2-willemdebruijn.kernel@gmail.com/
---
 Documentation/netlink/specs/ethtool.yaml      |  8 +++++
 .../networking/net_cachelines/net_device.rst  |  3 +-
 include/linux/ethtool.h                       |  6 ++++
 include/linux/netdevice.h                     |  6 ++--
 .../uapi/linux/ethtool_netlink_generated.h    |  2 ++
 net/core/rtnetlink.c                          |  2 +-
 net/ethtool/common.c                          |  4 +++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 33 +++++++++++++++++--
 net/sched/sch_fq.c                            |  4 ++-
 10 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..c780684ca1bc 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -448,6 +448,12 @@ attribute-sets:
       -
         name: hds-thresh-max
         type: u32
+      -
+        name: pacing-offload-horizon
+        type: u32
+      -
+        name: pacing-offload-horizon-max
+        type: u32
 
   -
     name: mm-stat
@@ -2168,6 +2174,8 @@ operations:
             - tx-push-buf-len-max
             - hds-thresh
             - hds-thresh-max
+            - pacing-offload-horizon
+            - pacing-offload-horizon-max
       dump: *ring-get-op
     -
       name: rings-set
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..3b9ce1c6e105 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,7 +183,8 @@ struct devlink_port*                devlink_port
 struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
-u64                                 max_pacing_offload_horizon
+u32                                 pacing_offload_horizon
+u32                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5d491a98265e..adeebbf53dad 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -85,6 +85,8 @@ enum {
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
  * @hds_thresh: Packet size threshold for header data split (HDS)
  * @hds_thresh_max: Maximum supported setting for @hds_threshold
+ * @pacing_offload_horizon: pacing offload horizon value in usec
+ * @max_pacing_offload_horizon: max pacing offload horizon value in usec
  *
  */
 struct kernel_ethtool_ringparam {
@@ -97,6 +99,8 @@ struct kernel_ethtool_ringparam {
 	u32	tx_push_buf_max_len;
 	u32	hds_thresh;
 	u32	hds_thresh_max;
+	u32	pacing_offload_horizon;
+	u32	max_pacing_offload_horizon;
 };
 
 /**
@@ -108,6 +112,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
  * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-thresh
+ * @ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON: capture for setting pacing offload horizon
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -117,6 +122,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
 	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
 	ETHTOOL_RING_USE_HDS_THRS		= BIT(6),
+	ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON	= BIT(7),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8db25b79573e..3c2ed45b55dc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2129,7 +2129,8 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
- *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@pacing_offload_horizon: active pacing offload horizon in usec.
+ *	@max_pacing_offload_horizon: max pacing offload horizon in usec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
  *	@num_napi_configs:	number of allocated NAPI config structs,
@@ -2552,7 +2553,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
-	u64			max_pacing_offload_horizon;
+	u32			pacing_offload_horizon;
+	u32			max_pacing_offload_horizon;
 	struct napi_config	*napi_config;
 	u32			num_napi_configs;
 	u32			napi_defer_hard_irqs;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..6f1a2fa36157 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -193,6 +193,8 @@ enum {
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 	ETHTOOL_A_RINGS_HDS_THRESH,
 	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+	ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON,
+	ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON_MAX,
 
 	__ETHTOOL_A_RINGS_CNT,
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31c65a545a10..2c7a245c5ffc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2155,7 +2155,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
 			READ_ONCE(dev->tso_max_segs)) ||
 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
-			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
+			 (u64)READ_ONCE(dev->max_pacing_offload_horizon) * NSEC_PER_USEC) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 23db40618fed..9ca6980f2291 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -954,6 +954,10 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
 	kparam->hds_thresh = dev->cfg->hds_thresh;
+
+	kparam->pacing_offload_horizon = READ_ONCE(dev->pacing_offload_horizon);
+	kparam->max_pacing_offload_horizon =
+		READ_ONCE(dev->max_pacing_offload_horizon);
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 3e969a070f9f..ae7b651c658f 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -494,7 +494,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
 extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
 extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_HDS_THRESH_MAX + 1];
+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON_MAX + 1];
 extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
 extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 9054c89c5d7b..5cc20d581c46 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -42,6 +42,10 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
+	data->kernel_ringparam.pacing_offload_horizon =
+		READ_ONCE(dev->pacing_offload_horizon);
+	data->kernel_ringparam.max_pacing_offload_horizon =
+		READ_ONCE(dev->max_pacing_offload_horizon);
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
 					&data->kernel_ringparam, info->extack);
@@ -69,7 +73,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */
-	       nla_total_size(sizeof(u32));	/* _RINGS_HDS_THRESH_MAX*/
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_PACING_OFFLOAD_HORIZON */
+	       nla_total_size(sizeof(u32));	/* _RINGS_PACING_OFFLOAD_HORIZON_MAX */
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -121,7 +127,12 @@ static int rings_fill_reply(struct sk_buff *skb,
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_HDS_THRESH,
 			  kr->hds_thresh) ||
 	      nla_put_u32(skb, ETHTOOL_A_RINGS_HDS_THRESH_MAX,
-			  kr->hds_thresh_max))))
+			  kr->hds_thresh_max))) ||
+	    ((supported_ring_params & ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON) &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON,
+			  kr->pacing_offload_horizon) ||
+	      nla_put_u32(skb, ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON_MAX,
+			  kr->max_pacing_offload_horizon))))
 		return -EMSGSIZE;
 
 	return 0;
@@ -144,6 +155,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_HDS_THRESH]		= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON]	= { .type = NLA_U32 },
 };
 
 static int
@@ -177,6 +189,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON],
+				    "setting pacing offload horizon is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -246,6 +266,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
 	ethnl_update_u32(&kernel_ringparam.hds_thresh,
 			 tb[ETHTOOL_A_RINGS_HDS_THRESH], &mod);
+	ethnl_update_u32(&kernel_ringparam.pacing_offload_horizon,
+			 tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON], &mod);
 	if (!mod)
 		return 0;
 
@@ -281,6 +303,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		err_attr = tb[ETHTOOL_A_RINGS_TX];
 	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
 		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
+	else if (kernel_ringparam.pacing_offload_horizon >
+		 kernel_ringparam.max_pacing_offload_horizon)
+		err_attr = tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON];
 	else
 		err_attr = NULL;
 	if (err_attr) {
@@ -302,6 +327,10 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
+	if (!ret)
+		WRITE_ONCE(dev->pacing_offload_horizon,
+			   kernel_ringparam.pacing_offload_horizon);
+
 	return ret < 0 ? ret : 1;
 }
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..0746e8da078a 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1179,7 +1179,9 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		u64 offload_horizon = (u64)NSEC_PER_USEC *
 				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+		if (offload_horizon <=
+		    (u64)READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon) *
+		    NSEC_PER_USEC) {
 			WRITE_ONCE(q->offload_horizon, offload_horizon);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
-- 
2.55.0.229.g6434b31f56-goog

