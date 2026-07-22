Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D042124E
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753106; cv=none; b=D2SVdMYxDwyXImiinG9BHaL2Dm48DddTKIKnwvvPNrklfbh0e16nUppBRhw7r+lEeVIXxQ5GSAfhQ6J6chIP2tPf6XW7CtIvFTL/IHba53T7PnvNNpWQ0HVt9NQzr7dbYzH2swZfn0VIUUFC2CWO9keJ+NMePm7TjwE8b6Sx/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753106; c=relaxed/simple;
	bh=kZkrlurKC3ATp7jmN0OipneTGKlS8kKQGiwbQ3TSuWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8GvJHhRSJ/6c7HhF6zaW7nqM7g9DDxcssyMEnsx20K0F8AjggeKZEiZuSQYvz8o+RpHzfViwe53NG7NRXaTvtSKdfH5KANrGbDrZAV/5w+XL9bvd6NYlnVfrh/yuFVVVPszKCj3lV61X17tp4AAitJkuyUxcpcvVyoJtLD+yd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwhp2UKY; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwhp2UKY"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81eef95653fso52957237b3.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753103; x=1785357903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9T3sTpL1arvGHuEEuqthjJctlEnTeySAvwW8sitPsZ0=;
        b=qwhp2UKYh5mrwFDyCoL8IXbklC5eLRQ+6tiWTHzguMZaDN2F8JtHcOE+qS90rlVzOz
         eCsl8rxDk05mj/zrGXUrSHuMaDbh1tcVTYf6cxuEf9GsFpdHb+D1+6N3EAZnutKi3dlN
         DxBBYUhPJkghi66znv3TURe4PG/IlIJtHGXXgWacNDDQKjgLRYbM2ym+cY8Kp86L+hk8
         t3z3YDFqp1zynydq0/3DkWUY7izoJCxcKYP2rtUNnvh/Hx+FHoZ2zipX6cpeo9nCHlEc
         c0ttwttB7bdcb6ruylzcO2ubeBp+x+JUSmxU2J5rPwhIG83/GQkbwFXq4n6qenLNZwp/
         /Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753103; x=1785357903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9T3sTpL1arvGHuEEuqthjJctlEnTeySAvwW8sitPsZ0=;
        b=pmvzfNTb4sivQleko0WIbygq4P/FzZLN9YBA2gi8iFf5fiiIR+Fi3lch7Itv9S0SRz
         U5nTy5pMtoPZpsKbQ24HY5dTYA66Gd4EBtjpY6xPO/oOog7Oy0tyuJlY3DPUPyXWTNZw
         LhU8emEI8Cyw0L2ue9E2A83OrVE7SHAzm0YoSDlJpeMROQ1SivyzrXmUK6jTVmn9oZBj
         HD9f0mMxw2na8jIC9hfryyaMqcM9l680hlyGz+qFcNVunt3DTNo/Zq7xr2ZmoJmC/RZD
         xguAoWzJQ+zVsQ0Bo0/qW26N2JrBUf9KK79VSVXcTmOPTjZAocsDDIomIegX1h+roPla
         dUIw==
X-Gm-Message-State: AOJu0YyjlcaQbZtUUiSeN3jNNoSQr6Q5TV/EIYkRsMNSFMFvU21Qrldt
	Gv/T2JaJTBdb17GUv41NBMsgio4dgbuaSV1XeSNimIXgAh7TxlTdBPyVMlDef4W0
X-Gm-Gg: AR+sD12BhkoSsqTL2b7C+HCEfYaUg/veIrlTOg+97pyuN+6F/qWYCD1tm/ne0NCF+z1
	t1GfL6ojpoO72OoffoHPf/1wLzTbCfsfbAnRDEA5MZPIXJ/qnFTmGop9Q4znSAPQWTcn8PJ6eVy
	WzVgdB0Co742e7ZAVlYACFREpAolPe9duc462Q25xV6NQG/qoo6XK7ReG3wT3bOGJjJ+lIJgeFQ
	7+9qXBIixhnqtZXNhKVbVfqlU0gV/BH4jEOB01oTehhyewq9hhchyIUNs782y08tw7ccdAKasIF
	2kqQzU6cd+s0DDp44BaZm1XCHCfMehzThjBaH0VFYc/zTY7Z7tZjBer22Es7hRb+2KLz4DmUM7V
	TLwJ5A4zo46Pzw+tSXN2Ja9ANSrKbmvXklPgohx+ipAJubHhqgpcfa/BmHibPs+FkTJisC7t44e
	ldyeQc+e2rO1Jb30oB6XdTd2AKFPRoiYLSDRFr1/7eutRp+MCyI05DJ8nnpwHWJWnWVxdimELBr
	T3OiQ==
X-Received: by 2002:a05:690c:c509:b0:812:a680:e10d with SMTP id 00721157ae682-81f4c144f21mr624777b3.12.1784753103017;
        Wed, 22 Jul 2026 13:45:03 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm19506797b3.6.2026.07.22.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:45:02 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/7] net: ethtool: add hardware pacing offload support to rings
Date: Wed, 22 Jul 2026 16:43:47 -0400
Message-ID: <20260722204454.3234605-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
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

Assisted-by: Gemini:gemini-3
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v1 -> v2
    - (minor) style: remove period from end of ethtool comments
    - (minor) style: fix missing space at end of HDS_THRESH comment
  v1: https://lore.kernel.org/netdev/20260706133433.3142805-2-willemdebruijn.kernel@gmail.com/
---
 Documentation/netlink/specs/ethtool.yaml      |  6 ++++
 .../networking/net_cachelines/net_device.rst  |  3 +-
 include/linux/ethtool.h                       |  6 ++++
 include/linux/netdevice.h                     |  6 ++--
 .../uapi/linux/ethtool_netlink_generated.h    |  2 ++
 net/core/rtnetlink.c                          |  2 +-
 net/ethtool/common.c                          |  3 ++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 30 +++++++++++++++++--
 net/sched/sch_fq.c                            |  3 +-
 10 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..48f43dda2e6e 100644
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
index 23db40618fed..5c2323aaa02b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -954,6 +954,9 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
 	kparam->hds_thresh = dev->cfg->hds_thresh;
+
+	kparam->pacing_offload_horizon = dev->pacing_offload_horizon;
+	kparam->max_pacing_offload_horizon = dev->max_pacing_offload_horizon;
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
index 9054c89c5d7b..52158572fe10 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -42,6 +42,8 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
+	data->kernel_ringparam.pacing_offload_horizon = dev->pacing_offload_horizon;
+	data->kernel_ringparam.max_pacing_offload_horizon = dev->max_pacing_offload_horizon;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
 					&data->kernel_ringparam, info->extack);
@@ -69,7 +71,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */
-	       nla_total_size(sizeof(u32));	/* _RINGS_HDS_THRESH_MAX*/
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_PACING_OFFLOAD_HORIZON */
+	       nla_total_size(sizeof(u32));	/* _RINGS_PACING_OFFLOAD_HORIZON_MAX */
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -121,7 +125,12 @@ static int rings_fill_reply(struct sk_buff *skb,
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
@@ -144,6 +153,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_HDS_THRESH]		= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON]	= { .type = NLA_U32 },
 };
 
 static int
@@ -177,6 +187,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
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
@@ -246,6 +264,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
 	ethnl_update_u32(&kernel_ringparam.hds_thresh,
 			 tb[ETHTOOL_A_RINGS_HDS_THRESH], &mod);
+	ethnl_update_u32(&kernel_ringparam.pacing_offload_horizon,
+			 tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON], &mod);
 	if (!mod)
 		return 0;
 
@@ -281,6 +301,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		err_attr = tb[ETHTOOL_A_RINGS_TX];
 	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
 		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
+	else if (kernel_ringparam.pacing_offload_horizon >
+		 kernel_ringparam.max_pacing_offload_horizon)
+		err_attr = tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON];
 	else
 		err_attr = NULL;
 	if (err_attr) {
@@ -302,6 +325,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
+	if (!ret)
+		dev->pacing_offload_horizon = kernel_ringparam.pacing_offload_horizon;
+
 	return ret < 0 ? ret : 1;
 }
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..d4cc8bc9fa06 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1179,7 +1179,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		u64 offload_horizon = (u64)NSEC_PER_USEC *
 				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+		if (offload_horizon <=
+		    (u64)qdisc_dev(sch)->pacing_offload_horizon * NSEC_PER_USEC) {
 			WRITE_ONCE(q->offload_horizon, offload_horizon);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
-- 
2.55.0.229.g6434b31f56-goog

