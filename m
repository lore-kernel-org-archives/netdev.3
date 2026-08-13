Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B5283FD4
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586751; cv=none; b=E09SOSwEMu7qwQ/roVZ/JRhW3xLfLjCqgDl3GbQrVbyO6S5JtThuTN0UjT1g6L2wSJiDUW1GaoXWVM4ehumkvQI/Yxhg27KBpDXtkIUoeXfpth79qNHhxOFdeh4YALR5DW1yoLdqqAtMbi5i4mkk9IiMoj5fkzBdMBV6Qd3CuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586751; c=relaxed/simple;
	bh=NoPPj/k0yECCRKXLnFs4jx/Bik3Ai3QGy+N2adexgMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOX/zPu2K5lphpWytPfmB/6sfpbg8+73pGpQ9wJwPJRd6bgVWW27kZFdc7iHY/IJgQVcjwuU0u7tw2jwwaLypezxWOjywEiLiZgBjrMsBBiujUSi6Cke1xZlSvBeXdMNBSAckc+O8z98OCJcTf2QXymKfjRSeZci9A1TJvT4z9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4Daw2PT; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Daw2PT"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6688a2dceb8so1327386d50.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586749; x=1787191549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5YS55MiGQgBtBAdGNTcMzlj9MAhTrxnG2CrzEUU4Dw=;
        b=C4Daw2PTKLLXFNCf/q4S+3HYtepi4irYJFo054NEojE3F4iyhMC9tYf5mxJ1gBXFOC
         UCEIiSoVqghQNCj/BUapePM5OqrJyG9Qv3OuvG3JKSkf7ae92UR/2agYeykWIvAJqaQP
         gME25drOe6Xd5+nrzOQfdllTv03reJJMhRltVWNIj/0sY/TYDTrNXNQxkBuDGC4zMbf+
         QUPQVV6yyG7sH5csZ0sVDrGGIVFaydBP/QzOwrk5Y0GDiFxx5O/2DpD3pqQFAsRm5zLl
         NkBh5OLN35T6Z3r9Up0nVxMArPCCwQtYaIGXyvcgL3OSAE2Z4LNgSUu5bK8iMFk5xOgz
         tnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586749; x=1787191549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5YS55MiGQgBtBAdGNTcMzlj9MAhTrxnG2CrzEUU4Dw=;
        b=QSXq+PAOgYbh7Gb1w7r7dvUIpGFPnKQJ+KKFDH2wP5IA7i82Xs02YJmeYH1onYrK81
         QedbQI4Jh7ifMUDfkDmUZZch7zNT/MPefS/H3Qq2YwJDc6LZ5LpFJSMRmzcmeYNLV3WI
         ijGT//vwFg7i8OXeMcrDmtNKlRLchKYb+wdQhRmpavVY6Lco+k62ilfQz0P51M3NPyx9
         3QfqNG29LfxEFfDWhpHAIa0LTP45mW5/RRAHuHkW7GBtcQXWejCq7ahG4drrK5UWcehG
         1opNQaQLUbzS5UHMsDL2YlKcUAeGgkEZc6a5Fif3xmJMbRagP/6CCqWUuf7q0GzyxnNX
         Pc1A==
X-Gm-Message-State: AOJu0Yy+VpcbPnycQq0AZmJeSbqamOrKoWC1TVg3VhisJYvMKq/fxVhC
	h11lhw7pFvrcSzb88azPcnUr/vNg6yzyyho6BGW8+F/zJalO81iJxS45Sf6NGQ==
X-Gm-Gg: AR+sD10pdOzKQGN9XR7H5mxlfD5o+w/8WAOoyjcuse3EyuX9rp+eobmnjcB3N8C0fUU
	5fcWyxMK1OIBNh7IuerfATgT5fO7f9R6rWJA9ekNt1LEEzybJJEKfRUCBxy1+eWdVVcfEDIyxga
	V2eny4oegLmVrCXUOU2W2SYvvDwY+HDuWeuhqjLXA4g3lcMkNKO4ME3eowiLVWBXyN9iL0boOis
	xRIs2Xu7R/hxeEOkQb4p5uvsiMYmE//Rwyeq6wmuW7f+IZgIdNNVtrotQODNaU8QmW0fyehYmcA
	MJB/ae8BkW4+S8tuibZK+rseB8cbIta8Ps2SCC+Bz2R4nOKncanjiDaIGwmvRzvYbXyEPCwQHUi
	ZojxNlyntqVEmwm5zZZbyNKkedTabskf7Pn46gU8cQpunvbqI0B7som8J3p4u0ITuAKdBGBmupm
	EsePklCjoAljDjmeh7LsgMYSBYUtKosathQD3BZm/P04jR+1s5wXxARGInQFO+lof9ljK/jAu5y
	V/1R4+ouhXZCI06HatF1AioZH8o0haEey69qSCrYzxZthJJQBGpAfQ1pzo=
X-Received: by 2002:a05:690e:440c:b0:667:debe:48fe with SMTP id 956f58d0204a3-66c5181942amr859971d50.45.1786586748366;
        Wed, 12 Aug 2026 19:05:48 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:47 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 1/6] net: rtnetlink: add pacing_offload_horizon attribute to net_device
Date: Wed, 12 Aug 2026 22:03:56 -0400
Message-ID: <20260813020529.3506539-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
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

    python3 tools/net/ynl/pyynl/cli.py \
        --spec Documentation/netlink/specs/rt-link.yaml \
        --do getlink \
        --json '{"ifname": "eth0"}' | grep pacing

And the active horizon set with

    python3 tools/net/ynl/pyynl/cli.py \
        --spec Documentation/netlink/specs/rt-link.yaml \
        --do setlink \
        --json '{"ifname": "eth0", "pacing-offload-horizon": 50000000}'

Signed-off-by: Willem de Bruijn <willemb@google.com>

----

Changes
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
index db9dce7f0aa6..6155ee8a0f34 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2133,6 +2133,7 @@ enum netdev_reg_state {
  *		   where the clock is recovered.
  *
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@pacing_offload_horizon: EDT offload horizon setting in nsec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
  *	@num_napi_configs:	number of allocated NAPI config structs,
@@ -2555,7 +2556,8 @@ struct net_device {
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
index 7cae082a9847..e0f2cd99e3b7 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1179,7 +1179,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		u64 offload_horizon = (u64)NSEC_PER_USEC *
 				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+		if (offload_horizon <=
+		    READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
 			WRITE_ONCE(q->offload_horizon, offload_horizon);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
-- 
2.55.0.691.gc56d675ccc-goog

