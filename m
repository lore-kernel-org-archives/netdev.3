Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394051991C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060311; cv=none; b=MHK28brAAa1S1OX3CQ+MhVLJJAbp5ZYN4pX10EKMjZ0Vu2qHyyYsaNq1T9qmKhfRw0RoLw0ae75TQRpzuwEkyV4hOr3zWy2o6er2HA2sUyvGOlPXIYfd3/XXlR1ePacku6LSv9tN4j+UdALxI0WumHAPkRs2MGFgTPkqYmpN/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060311; c=relaxed/simple;
	bh=MJrX92x/5CAx9k53AqkgwszpNrcTejnt/ccVojkz/nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f48kaaSPQkWPUi1K8Vt5zJ6iMKjm/FQrVn0pcECeWy05UHycGr2o5nFACVphhbUtwEe+WDCcKanba/zRgSorhZRs4JrLD6q7WTVeAiWQR1ZLAkv0Es59ltSUWBd6NmSWlWTIXNyAzf1exmkNbSArLi/0MhnFISw7afyjZAtTV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnXUmnUu; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnXUmnUu"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66cf1f9965dso6464346d50.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060297; x=1789665097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ThLi4uXnbaBQEJh2NzLeFYlgsDlR7zgH11mbO8fXEU=;
        b=WnXUmnUu1amSoepXTtPruvDA5JI4llEglsLuQ6SBFrTPYgx3i9G5Y/Em330ENIogDc
         GTTesoeF51Yiuqkd8Tng+iUgflZPffeY2g+4e6+W7u09rCqsKvWr3hmrH9L2WMgMSW5U
         LGzmE5yP+4iYogmor+yd2bajZKsTbd7e252BKwcvjm2OJroo2gc1tZn/7XaLcbHG8wuH
         duvB29sQkFlIHPfsZQ+EJ+wiwW07igD1KGIcRHyCLqUsB+kFeyJ546M9eqdLpRFfD9VS
         ZsxoyuRQLjPJLoeONsmmDuJQnBrtvuuuzpJwXg+WNmAijOA7TMtNkrw79s2SzwroRetZ
         LfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060297; x=1789665097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ThLi4uXnbaBQEJh2NzLeFYlgsDlR7zgH11mbO8fXEU=;
        b=C9jHR8Lt827S3VzGOfFiwhPJtgwY08GQIFml3QV4OcTNPnBKIRv78Evr6MjUBZqlfd
         iz1w6wJZpwDzU/0W/pjxAdovVeMgxSP7JyF0JmHuGMZwzmznCbUPARTwYK8J5FcoDiSB
         si6wWBrq7XTV5esamgYp65GveFmhCyI31T5tMFHxwHebpPnJ4sSiMFeToz3UZUyDJ0XZ
         /VnxHwZv4/XpXfOuFxEcChdFDr6u6nF9nBtizf7V4DMoqRR6xYIQyX6ZjpZZRn6e16mr
         XUP4at8GapoEhvJf14nAw6zxcsecvlZ/PDnk+8lLO79SMF0h1mkuLnzvy6T+l9o/KxUD
         vRyg==
X-Gm-Message-State: AFuF++nikqkFPz6qMlAPKqzcNt/uGf+m4ssEX9DCOlh7M2EZSHmLaEGI
	actsccR9HvGOQvsr9cvC7ZM4co27prQK3w3QjTtETytJQwHeYvSG9hUdJ1eJiA==
X-Gm-Gg: AYBFou2bo+54S5QQ8FTcuX/dd+BxEhwGahRevbw5GStD9X+KKfwoqbQdoExpZdGLBch
	LnPCwcmU3etDNUhoDxWy40h5pfyREZ8gHbqvtN6ZnXVHwna2+3SaLLNLIzUw9F9puI1TQG0XGCW
	SBimPM82WLrwtWCScQBYT7P8GfbiWe16bQ1NwZ/55V+uLmpjc5P7i6LWSXA6Pk4FyS8OALNpcKn
	w3lkKKqIKjHOF7/g24Jm1Gz2R/dAAnnCPnNqR4CRBITK4WSs+pqX5Thd/RScFuqiJe9nnEbQqjd
	yaTtur0kemzwrCM6rN36DMijc230EPyC3Jom7ErtTmFUtyIiUG95X9mzHQJ3nWtTl8+Sn+yD7oc
	B/bfdnsQtCl8O3nlN9+gIy1xqYG+ZKdWgWlBvgfv+jQQu675R2sG+HAb6bnifwQWwThV85rK6wZ
	f0/rp6RAp/+kBYG5tJa6TfMEkZDz6ujmdBDjjJKVQG84tzhlstDOnnc4Dg7xwbGdh+Xh80qryv1
	Jw2G0rNNJj/Qfl+2tme87/SxY/iYpJwRitJrOz0auHYf//CFSLdRXz03R9UzH0gpU5U/c5eoIyU
	qfHJNk0FbQ==
X-Received: by 2002:a05:690e:484b:b0:66f:9cdc:2b09 with SMTP id 956f58d0204a3-67124679827mr109967d50.47.1789060297389;
        Thu, 10 Sep 2026 10:11:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:11:36 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v9 1/7] net: rtnetlink: add pacing_offload attribute to net_device
Date: Thu, 10 Sep 2026 13:10:20 -0400
Message-ID: <20260910171131.2532487-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Add a new flag to administratively control pacing offload.

The feature is disabled by default. That does not cause regressions, as no
driver advertises max_pacing_offload_horizon yet.

Also add NLA_REJECT for max_pacing_offload_horizon, in line with
other such read-only members of link-attrs.

Both fields can be read with

    ynl --family rt-link --do getlink \
        --json '{"ifname": "eth0"}' | grep pacing

And pacing offload enabled with

    ynl --family rt-link --do setlink \
        --json '{"ifname": "eth0", "pacing-offload": 1}'

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v8 -> v9
    - rename pacing_offload_horizon to pacing_offload and make it boolean
    - leave max_pacing_offload_horizon as is (u64)
    - (minor) update ynl instructions
  v6 -> v7
    - commit-msg: update ynl invocation to installed version
  v5 -> v6
    - bring back fq_change update
    - commit-msg: reword absense of RTM_NEWLINK -> omitted from newlink
---
 Documentation/netlink/specs/rt-link.yaml      |  5 +++++
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  2 ++
 include/uapi/linux/if_link.h                  |  1 +
 net/core/rtnetlink.c                          | 22 +++++++++++++++++++
 5 files changed, 31 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 61ebb9a2bad5..d0559293b3b3 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1089,6 +1089,10 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+      -
+        name: pacing-offload
+        type: u32
+        doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).
   -
     name: prop-list-link-attrs
     subset-of: link-attrs
@@ -2557,6 +2561,7 @@ operations:
             - devlink-port
             - gso-ipv4-max-size
             - gro-ipv4-max-size
+            - pacing-offload
       dump:
         request:
           value: 18
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..8eceaa80b686 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -11,6 +11,7 @@ Type                                Name                        fastpath_tx_acce
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
 unsigned_long:2                     netmem_tx:2;                read_mostly
+unsigned_long:1                     pacing_offload              read_mostly                             sch_fq
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 707b2e51c2b9..1f0710eef185 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1840,6 +1840,7 @@ enum netdev_reg_state {
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
  *	@netmem_tx:	device netmem TX mode
+ *	@pacing_offload: enable EDT pacing offload.
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2170,6 +2171,7 @@ struct net_device {
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
 		unsigned long		netmem_tx:2;
+		unsigned long		pacing_offload:1;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 43cecca49f01..245b36204525 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -381,6 +381,7 @@ enum {
 	IFLA_NETNS_IMMUTABLE,
 	IFLA_HEADROOM,
 	IFLA_TAILROOM,
+	IFLA_PACING_OFFLOAD,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 81c5a6104dea..aeccfa814f40 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1396,6 +1396,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size()
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
+	       + nla_total_size(4)  /* IFLA_PACING_OFFLOAD */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + rtnl_dev_parent_size(dev)
@@ -2176,6 +2177,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			READ_ONCE(dev->tso_max_segs)) ||
 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
 			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
+	    nla_put_u32(skb, IFLA_PACING_OFFLOAD,
+			dev->pacing_offload) ||
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
+	[IFLA_PACING_OFFLOAD]	= NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
@@ -2820,6 +2825,14 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD]) {
+		if (nla_get_u32(tb[IFLA_PACING_OFFLOAD]) &&
+		    !dev->max_pacing_offload_horizon) {
+			NL_SET_ERR_MSG(extack, "pacing offload not supported by device");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	if (tb[IFLA_AF_SPEC]) {
 		struct nlattr *af;
 		int rem, err;
@@ -3337,6 +3350,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
+	if (tb[IFLA_PACING_OFFLOAD]) {
+		bool val = nla_get_u32(tb[IFLA_PACING_OFFLOAD]);
+
+		if (dev->pacing_offload != val) {
+			dev->pacing_offload = val;
+			status |= DO_SETLINK_MODIFIED;
+		}
+	}
+
 	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
 
-- 
2.55.0.1007.g17ff1f9808-goog

