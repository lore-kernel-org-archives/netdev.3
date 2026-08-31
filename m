Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A73A2E25
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211950; cv=none; b=XUD7QT2ZfIJI4mB7q1I+xUndyoHYKbkqwsh2X5914peEiEBFDyk6G2uiuBCdbsR8+/Ahsqq6p9egWtaCFaYogigvv1CMM0HEPy0SO6u0IZ6qFPZCapcu3oFR+2II942ZyBbB017iNTsIij4aiYjnMencROHjp8mLAnYWXX/tsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211950; c=relaxed/simple;
	bh=fOk9Cfvlm7B8qV2YeWLtW1N1LzwRqR3w4zT7TdJ3Co0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKQlQA7VGXCZjZlh/tlaXw+WF623M7n+wMZUfaPGGnprIYs1Lag7/zNe6oHdAl/wljeer2wzOtRDzQ3930/yGPY5oq6i5MjzymKZC+9piWzf2KV4ysH2c7yRK6uc+ndFLMCirtD6sC6ChFgHOMW68MVgix37yjSZDjZP0WwejRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpFwEoul; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpFwEoul"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8200b55dc47so38394637b3.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211947; x=1788816747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4iXE7z/d/P6n+vFLMFXlXYW6564eEoH53MrKDY4dDs=;
        b=ZpFwEoulfzl9ant4ERYQcbyCqM5sbP+hFx3S6zdsAddWKH715/Sq3ba7vEK8zsLZr3
         iZbnCR7rtALoM5XPhwHIVciOK7JNALploH34m4IWVpuiVAB8wqDMI4Nz15r6dD1+veb2
         7elrHSp3jIJ348dQ1m+AR4sSSGFRJBTRzttuATSFqGk7TeqClZiUJXOVm+U9R6cPnwil
         Q7X+n295oM92nSdzMXqDRjpbeIHZkuT0vBrtw2d6f9GephM4m7uS9Ive3/eaC0qD6YIh
         57qZP1BhQXU8NBxkB9u/PItb+Ly074tnoEZMuFSw35rSYa7GZD7H2IaXYJGarEZv3F+d
         2u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211947; x=1788816747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i4iXE7z/d/P6n+vFLMFXlXYW6564eEoH53MrKDY4dDs=;
        b=gkoFSmwCaTz/EmTi7sHq6HMvrjJp4JCYi+qxv5EtWKczD01arx0UHlJgSzUOc0AP2g
         XEst/norV4i6H8r26soHAOTcgAIYVBgCf4JvaxG6YXvQrBHV3eVtVN5co0GlOqoWbG+Q
         y/ss4egJaKyVamumOptBd43k7W0X3u1fgtaqqK9zyku61wPalAdyHzaKH5+d18DpgGpv
         bu/QJuiVPIJmuiOXJAD7P7MRqR5wkEs5ppNWX5WS8wdFdmzWQTcVOizTlQl/D9rOsf/S
         kPv6iTaKFJ4yN5Rex31R0PuaCkA1QSgc6eQLGhgX7BiJSNBmPD/aGiKdta44mfCFgF4t
         dEQQ==
X-Gm-Message-State: AFuF++llSNHegNG5Cs7xEvjMIMgYbGxlQ/ZfWTCT6uJcn94cMhBH8OIR
	hf3Y2P2XVwrgHI1PgBBmvoGgGORT2PzV9icHKxpxnkfwXzLjdUv/41D6rPHPuQ==
X-Gm-Gg: AYBFou3E1wo9+WmZz+ITkw37ziEJ//NXiYxxppQDnCMzafUU4vt1wMMZK3JN/N4DtdD
	mmOP+OwpY6kHWgcA3pX1tsq8xq41T1xMPNV3fPgCd/eLIAZO3cq01WSo+klSyNdT6owh5D+BoNF
	ZoIO1NCD2sZ35SQPcVyv0ZVhW+pRimz7qcrw13Nm+GxFQNVmCQPtqAztuDVTKswZAiBkG58I4mi
	auurjVEYFF9G5z9DqmjM3ah65ZBKkYaN7qROHeSMy+ocy99WDxJBsXixh5ww6QXhotqzhB8PyiS
	40XxmcXOh1nmOVTh6QNI32bomSfRFRE21ql3qqKTODpJlsL0NiSUJ4+ApJHLFQUEFACRF7skXbU
	iTolarghSp/vXVZkhLoEkXysJDQSxEzrXEsWIirMwI0nsrGucxvWb2kagkJ95Wla1GtvUJJabaf
	ZNUo9jI+KdhStNC7496tlWo8ZMnnTiLmnsQcuosWR6CpZ9+0iAqJYLYeS+LwD1AfJ3/jf4qjcJS
	FE/CMKgwBVL0ktcN7A+/U2d2ujmhwRndCJZpeMLsU45V6okEwZjFBeA9lEHIf5M
X-Received: by 2002:a05:690c:7003:b0:85b:f1ba:b076 with SMTP id 00721157ae682-85d6a7c5a18mr108400387b3.9.1788211947216;
        Mon, 31 Aug 2026 14:32:27 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8616243a833sm45474307b3.13.2026.08.31.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:32:26 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 1/6] net: rtnetlink: add pacing_offload_horizon attribute to net_device
Date: Mon, 31 Aug 2026 17:26:10 -0400
Message-ID: <20260831213221.1370774-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The 'max_pacing_offload_horizon' field of 'struct net_device' represents
the maximum pacing offload horizon supported by the device.

Add a new field 'pacing_offload_horizon' to store the active pacing
offload horizon.

The new attribute is initialized to 0 (disabled) and can be set from
userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
new default off behavior does not cause regressions, as no driver yet
advertises max_pacing_offload_horizon.

The attribute is omitted from the newlink request spec, because the
value may need to be bound by a device maximum that first needs to be
negotiated with firmware, as is the case for the idpf driver in this
series.

Make both fields u32, to maintain net_device cacheline layout. This
expresses up to 4s of pacing offload, which is sufficient.

Update the YNL specification ('rt-link.yaml') to add the
'pacing-offload-horizon' attribute and include it in link-all-attrs.

Both fields can be read with

    ynl --spec /usr/local/share/ynl/specs/rt-link.yaml \
        --do getlink \
        --json '{"ifname": "eth0"}' | grep pacing

And the active horizon set with

    ynl --spec /usr/local/share/ynl/specs/rt-link.yaml \
        --do setlink \
        --json '{"ifname": "eth0", "pacing-offload-horizon": 50000000}'

Signed-off-by: Willem de Bruijn <willemb@google.com>

----

Changes
  v6 -> v7
    - commit-msg: update ynl invocation to installed version
  v5 -> v6
    - bring back fq_change update
    - commit-msg: reword absense of RTM_NEWLINK -> omitted from newlink
---
 Documentation/netlink/specs/rt-link.yaml      |  6 ++++++
 .../networking/net_cachelines/net_device.rst  |  3 ++-
 include/linux/netdevice.h                     |  4 +++-
 include/uapi/linux/if_link.h                  |  1 +
 net/core/rtnetlink.c                          | 21 +++++++++++++++++++
 net/sched/sch_fq.c                            |  3 ++-
 6 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b80c2ac3ac31..292878ba7e15 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1085,6 +1085,10 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+      -
+        name: pacing-offload-horizon
+        type: uint
+        doc: EDT offload horizon setting for the device (in nsec).
   -
     name: prop-list-link-attrs
     subset-of: link-attrs
@@ -2553,6 +2557,8 @@ operations:
             - devlink-port
             - gso-ipv4-max-size
             - gro-ipv4-max-size
+            - max-pacing-offload-horizon
+            - pacing-offload-horizon
       dump:
         request:
           value: 18
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..90e257e815b1 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,7 +183,8 @@ struct devlink_port*                devlink_port
 struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
-u64                                 max_pacing_offload_horizon
+u32                                 max_pacing_offload_horizon
+u32                                 pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e..82a74ad284a1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2139,6 +2139,7 @@ enum netdev_reg_state {
  *		   where the clock is recovered.
  *
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@pacing_offload_horizon: EDT offload horizon setting in nsec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
  *	@num_napi_configs:	number of allocated NAPI config structs,
@@ -2561,7 +2562,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
-	u64			max_pacing_offload_horizon;
+	u32			max_pacing_offload_horizon;
+	u32			pacing_offload_horizon;
 	struct napi_config	*napi_config;
 	u32			num_napi_configs;
 	u32			napi_defer_hard_irqs;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 43cecca49f01..7c1d7754a670 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -381,6 +381,7 @@ enum {
 	IFLA_NETNS_IMMUTABLE,
 	IFLA_HEADROOM,
 	IFLA_TAILROOM,
+	IFLA_PACING_OFFLOAD_HORIZON,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 81c5a6104dea..eeaf953b397f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1396,6 +1396,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size()
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
+	       + nla_total_size(8)  /* IFLA_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + rtnl_dev_parent_size(dev)
@@ -2176,6 +2177,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			READ_ONCE(dev->tso_max_segs)) ||
 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
 			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
+	    nla_put_uint(skb, IFLA_PACING_OFFLOAD_HORIZON,
+			 READ_ONCE(dev->pacing_offload_horizon)) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
@@ -2344,9 +2347,11 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_MAX_PACING_OFFLOAD_HORIZON] = { .type = NLA_REJECT },
 	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
 	[IFLA_HEADROOM]		= { .type = NLA_REJECT },
 	[IFLA_TAILROOM]		= { .type = NLA_REJECT },
+	[IFLA_PACING_OFFLOAD_HORIZON] = { .type = NLA_UINT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
@@ -2820,6 +2825,13 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD_HORIZON] &&
+	    nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]) >
+	    dev->max_pacing_offload_horizon) {
+		NL_SET_ERR_MSG(extack, "too big pacing_offload_horizon");
+		return -EINVAL;
+	}
+
 	if (tb[IFLA_AF_SPEC]) {
 		struct nlattr *af;
 		int rem, err;
@@ -3337,6 +3349,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD_HORIZON]) {
+		u64 horizon = nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]);
+
+		if (dev->pacing_offload_horizon ^ horizon) {
+			WRITE_ONCE(dev->pacing_offload_horizon, horizon);
+			status |= DO_SETLINK_MODIFIED;
+		}
+	}
+
 	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 6144b5686f13..7cf7afda699f 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1183,7 +1183,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		u64 offload_horizon = (u64)NSEC_PER_USEC *
 				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+		if (offload_horizon <=
+		    READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
 			WRITE_ONCE(q->offload_horizon, offload_horizon);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
-- 
2.55.0.897.gb25b4bd76c-goog

