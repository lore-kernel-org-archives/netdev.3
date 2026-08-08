Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE51194A6C
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204362; cv=none; b=YS+9/8IAlvtHA4BydBEgZ0fyxbdNJokhqudZfS4ZzmR2hag4iIwuojfQeIWP7WZqIwD6sbB7UbNQ3QfSYNLXN0k8NGY2ssf3EN3JNYPqeShPPw1YmOK4p4107DM2jfOKmzjiTDJGD4lKOrwy4CxIMhUYEnxESImfmMKJuBQEM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204362; c=relaxed/simple;
	bh=1x+QKnZ+Tx1x8hxU9VNtiPUQJKmrwfkaRTJ78IgHJOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBdudyr2TorOFCmHkWUoDQIeZ3L0CWoyzmwFOQ3OhFqC8RoHsY5BxfMbcviTXJDdvPruuDXthpsidDj3MubsUk5ya7dHbo2mvcKBGlQ4ex0CXz8ZtStw4Wnkqca51PuRf+hAAYAYC8Ot52GFNeIODYgSzbdelXtUQ5QURr+zfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qz1dZaTu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qz1dZaTu"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e6f2ee60bso43593997b3.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204360; x=1786809160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvCyYQCYRlqZH3S0eMiioxxIENMpPVZZc/qLXsbhSio=;
        b=qz1dZaTuCO3jbLETHX4OEvwuy3RrkV606AbzFF4RZjk5ezS0BdU+0y2CyU7fQk/0kc
         ZR2kR5EjE7Wm5gpHfPMyM5KWrh5nmxfOhRNjwC7gnXaxn7FT+D18w0t5tZUnBAXgeYdK
         Qat7oKQDW+Zo6QYj9f+qjLop00cfkf7NnPZwLIVTI9j+U6FOxtY5GZgB7/6lLkvHcrMT
         vkI3XMAJF+XNigLuAWlt3uV6JP6DqulfnAijzeCWea3FxlHmzo4V/eTweQIBo0G28BHr
         PcpwLI6AwoWuKM2+Pkdd2vZKBdcY0Hq2xOxpfQL7rOO5NJGUf70H7E7ii4hfje2j22QK
         7Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204360; x=1786809160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvCyYQCYRlqZH3S0eMiioxxIENMpPVZZc/qLXsbhSio=;
        b=InUUppasrV1TOQwgj5qXuhW/mf/idGoS/0kfAxuquzs7Z0yEi6DsKzOLG75AsG9dL8
         N7wSvMYRRuNeHfpXV1RkhW49wOmvbyMzCx1y4n4rBMW8ROs6HdAer+7/7Px0cwkmysYn
         pjfdp383nCGjep1jqq8LJKLvOHKn5ILV4I3TmEvotUDRiz5k9MQtYRVIm71blhDLbQC9
         8VUt4ufz2xYn7PPwyMKmHoPMZLWjIF84ZG4wFUmoWd6OMUDYkBpwIzNetxc/FRJU2ZbH
         QXX2/Ge5fLjWhrJtAhlC+arEe+o3pIb1RVI+vQRFGLotl3q2odGD+B1JCsKJ/2kabNIK
         oIEA==
X-Gm-Message-State: AOJu0YwoX1BlrU9ZDMLYXYHPeWKtFu9iMoiHtxKG85Y8VRVqF08tn4nf
	ulawSFH4LCdxZSJqUpi+Ch5HI/n+/1FR6Ox9GBzqHZncoNC5CUvqlWz7+KvY7A==
X-Gm-Gg: AR+sD11PmWtYj1rDpgLLCwQHMbF+TcXOjh48sEzY3NZ0RXeI9nHr9jC8ya1YEZJC8HJ
	u4iEOcLt82jG6U4wLUCf+erMqC/DRXInYEJrNJnzG355i0rTopPSmIwiy6RMDAZ+kbGKAbLy2ow
	4kyiByFGEHDbx95UAGnPQ9oJqZ2Y2MYIdxUG7RA/r9o0rQQe8Qy8TIQavglJxcGJCJsK7RiH4LC
	BnbNSMnCd8qX5dcDl20dGjpNjw/UaDCbbBzsmisPO1VVxTdcQSjVmGYiKReA27xAxvshwC6ytXb
	1l5nQMz0j5VOfYrkmj/VwMqU7SF0dFvk4lAbATFzF4I4+ByqlUuJjCRTzpRytXH0pODLu0HD6x2
	QQXZqQNORC3Mty114WCZaQ1ZBclmiRd8U+oT4pJvN70vnjP3/5dfeiMHmXQN4ak/UUkRvl4dMD3
	Sh3HGK/zchd/UE2wxWZp+GGgIK8nBVDtj5FMqLQmV01ys2TiFdvFJjZmc+goa//AH9PfVyLMieC
	6YwF6rLaCDljSnZKNKKjimKOo/8BhMsts8PfQQM1eWIQp42Dw6rKA1J2LM=
X-Received: by 2002:a05:690c:6989:b0:820:10f1:d501 with SMTP id 00721157ae682-825eb9cdff5mr39465857b3.6.1786204359847;
        Sat, 08 Aug 2026 08:52:39 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f79a6c6dsm27839747b3.48.2026.08.08.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:52:39 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 1/6] net: rtnetlink: add pacing_offload_horizon attribute to net_device
Date: Sat,  8 Aug 2026 11:51:39 -0400
Message-ID: <20260808155217.885299-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
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

The equivalent RTM_NEWLINK is absent, as a value may need to be
compared to a device maximum, which may be negotiated with the device
firmware, as is the case for the idpf driver in this series.

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
---
 Documentation/netlink/specs/rt-link.yaml      |  6 ++++++
 .../networking/net_cachelines/net_device.rst  |  3 ++-
 include/linux/netdevice.h                     |  4 +++-
 include/uapi/linux/if_link.h                  |  1 +
 net/core/rtnetlink.c                          | 21 +++++++++++++++++++
 5 files changed, 33 insertions(+), 2 deletions(-)

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
 
-- 
2.55.0.679.g6767b8d81c-goog

