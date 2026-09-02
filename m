Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599737BE70
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373076; cv=none; b=UG9Pkwo6ErjW5Ad12wc1nhDaRUnU948lQCl2Mpd2rayH9jLpeb86cNDtYTb6+rsRSHHmFG6nNgZqVMvQiGJVEBtqYNAwTaMNn6prGO5gXup/UM5ewleqEyxkgvlRJsM8zQZ/dpAh/Hp4qZLdU2cDSwQvhV8w5uDVW7UV3lNPPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373076; c=relaxed/simple;
	bh=ANkRrDsjFxe35X3tojr0gqDVuxXnIJ6wJaFgUUU/pto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o55/K1nwnJ4Cut77avtAZcX6c7LrIbGk7RKlD3IOHLESQAC7TAqF5PH9Z4MnT22rxuVm5FRVtB2zzf/IJHKVXLCdB6IX70LEK+AkHrns+ctTuZBa1qyQ4ilHCuOZaH6cf9DQVomdibUqcdfKhhY+cRH5dvBYbzp0KWjKgrCQKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV7lrwRI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV7lrwRI"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ed2a06b9eso21821077b3.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373074; x=1788977874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Oiv8IDnoSNR6JGseAEYXoUUuqdM6+u9iv+jRpo+kpU=;
        b=QV7lrwRIYRfBhwQtJ3XLZUmrt4YQNRAfGN43BXbfHkF3SyEOItfkkZ8vg9KJmPrxOB
         xLytEFBHA2c8j3S5tzkSOAwr+Xygg0VJfcJCNw99sflRZ6JzdJ9oxzcuGGuAjf9P/F1t
         h8R7jU+FVQm7XLDyf4NJ05ZxcQdqqgrNFAbsRxcf3f6G41Q954bU10GdsH5XnyIUbvGH
         tCIyTvPEzBxnI7C6FhTOD45jsopKC/JgzG0i1euuEeeXcDxtIaVWl3DNHJ/duN/a82Rz
         XuzF7iBsdpYS0pADgPNJ1kiDf34JfUHpfQUW27ziUhOFwtlTy7moM1jhUoGjZUyGwA6X
         IaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373074; x=1788977874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Oiv8IDnoSNR6JGseAEYXoUUuqdM6+u9iv+jRpo+kpU=;
        b=H3WBaai0IhG3AhVSf9ZJkXOa0fUY183kW0mDZZIf64RzVyT2YC7+5kXGqZwa3m2/Yp
         sFeenPk5HnR8QXDwCf7QvLlac7Xaau8uXcjzXYhGVMeFiesyIpdzgwl+V59PEp10mQ70
         jsickMf8yr14L7/6AvLdfcfh8ASAy4vVIJxOB1kiPyHyJ6GysA2cC2ux9+46CRIQ4Phs
         sH8rBMYqlGEeOxxI2ESvSvVcsqHhkt4JaOPRTk8ZpahF0jvvfp/pV1pSL8zhewygL+ET
         62kii5Bw27OvNXbUe3aM4b8iNpjXrshRQyeMYxcUN3kLtIPqeRIdchPHk3puxiD9AELv
         m3pg==
X-Gm-Message-State: AFuF++moEY1Ll4UHtZKPblMI9hLa2kCozTnpDG/dvO1mq9IxWO57owe+
	r9jLGHPzrt3lnqKNpn4BxuZXdcqDMCBIfuPW9iPxT3po4B26X2CK6ZAoMNRqeg==
X-Gm-Gg: AYBFou2nnRtUBOG+gX8iDfzcaK1gE01Qqz32o0iu4tAkWN5YvNAFExSkXfMCxBM1Hda
	N5odW3xWiNKAocfh7tRM+1ZQpU0Lq2yrtVbNqzQKkmKs8X6s5v+PhTtVPZH1iymXjWeHUJzJpfO
	MzexpjIdIjjIlIhOJumv1+lR4zD+bVOeFxM3q+0/AKCe8zoTIR6knnJ9R6ZXlal3QqJGALxJU8G
	1KAiRx69tREzOjy9+Xc8CQnY5HyNHA5LMySfwNWmZkDT5/Wj6XEk5yh21dTtjgM5bI3TiTy5byh
	AAboUap2GmUsG4hR8HcRRa4xyLBVTs6e1exzAmEY3v1pAi5L2oayEPQhyiwDFxgaos9dk2Tq5wA
	uTtKC4uxOVQipS0+YRi2TooNNy9b6hxmutUwtU1batcOV+HU5hniPDva3sD+YZDxI5Jf1pbLYHa
	BqoJn3QABGZYVnaKnvrJKjuUddtshfjIZxSVCziTEWYHPqUeg2yrP7h+uHhy3/JbgC8LP7+aKi8
	NVGC9z7IfaCPXuRzsC+1tjDquc0j0y/mBxtcR+ud+Yx/jvLFtZlVxnTT9b7e0uj
X-Received: by 2002:a05:690c:a68e:b0:825:c3fc:e63f with SMTP id 00721157ae682-86c4f56c0f0mr26939537b3.8.1788373074044;
        Wed, 02 Sep 2026 11:17:54 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1784192bsm23162297b3.30.2026.09.02.11.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:17:53 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 1/6] net: rtnetlink: add pacing_offload_horizon attribute to net_device
Date: Wed,  2 Sep 2026 14:17:11 -0400
Message-ID: <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
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
index 61ebb9a2bad5..2a2aad9a29c4 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1089,6 +1089,10 @@ attribute-sets:
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
@@ -2557,6 +2561,8 @@ operations:
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
2.55.0.970.g62bdec98f9-goog

