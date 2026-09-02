Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5524AA56E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381469; cv=none; b=oxwELAjy1iyYUtjMLvYrpD5f5XIDOgID4vRTg2DzHvqxMC+YL92+aUnp11Pnb3v8rfi/gCcTpPHyYfwlS3uhTwi5Ke+fbnxdSk42Ki6J08Uu7tcdArq34wMvyxIIgxqwAozvc9C/HBzsR7jHKPLJFQ9OfDce5aDzcq2dpzUOq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381469; c=relaxed/simple;
	bh=UJ5ur2JTtuY9xb3LiZc48X+Co5xGTB5xNq9eLeWZ4yE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKZgpQC2kIXuVNCzgs1tJJ0h/ntRzgAYQbhVvas/aiJ3Z9mnp8w+4mM7T3OgBEuaMpAfQVInaex6M1EXe4UT6Iwg2S3cq/wBR0gHqaqfkh1OYBWFTD/Duzrm/tFJEfGhzHZqmOCHXiHKtMkAqYwjeKwHa4OF4kMVgwEQKA9DbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAw1TsMy; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAw1TsMy"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85722fc5a21so2167168b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381467; x=1788986267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VwUpRHIOVy7rK66sC6hD7OpiTO3xoElSpjeGQHYedY=;
        b=KAw1TsMyG+4V14FEJnLx8EMS9IemGDIMmnjqea1oUTYrBiOMYgVfsFJxvmpCWD0RTR
         0usTGifZalYZAHcmdleRC7jqfRMRDu19s6iN9FqGkqCfS7d2oaKQpu//bMYfDu33LpXh
         UoMWJWxvhETrfmk1bc/wbe4AEOiVwKoCp9JzK+yXQqqv7p4ZVWdCaWrDfDwo/t5u5fl4
         Z1/AtwPMuZLYoZOpC3G2qcogpbW5k1+EYYZW/SyqkuVgIEJoa+mq66U8odMxfwzmbCtG
         dQ7xwg/ZQSkfjlPOHmsW4qEy+VfAE0pH5DwWda5YJZhKPL+rDGvw6/RdzMRcix4cFFTb
         tflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381467; x=1788986267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VwUpRHIOVy7rK66sC6hD7OpiTO3xoElSpjeGQHYedY=;
        b=ZL9XdS40Sfa0uQReWsDgyNcY5EQnJ8mVT6v69SyQG3QyalqwbMicTv4Hoo0pgq/O7F
         hUxiS5aVsmpfmXnHPO3QOS2K6onC9dw6/GIguRmMi/8HMn8MGYiIuf8fGHYXa/mELZpI
         lvviiGqMsmI1bvu+uBVLAZ7DRU8C+koyLh9dz4BTgvkc9ZL0dapRqYAbH1rtzxiEZjHi
         nxu/r9kBvNz1DO0WCWejr1ZYe2qtVkjF0H1QVHTbUiMZwYAq5TIsSEuCxMS/E7gNXrq7
         /wB2A8sIh4fTjq5LE7X9YEPKBwf5DtYzGQldc44xDsrLRZuWLsAHX8aOijMgZWVhQ+B7
         I3Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxi3huwLqfNeUQwWxDZDll+RFslUXNG+IeqzKzYwONJvcN52WYe+jp+ZMR0GcatxdtBHcJm7GE=@vger.kernel.org
X-Gm-Message-State: AFuF++m8kjQasTr+tIEouLcv7uGRd8Y5+yeWAqXRxU5YhicWQyrpTfhD
	VdtTFx4oZuYmLcFVA3JM2nOkr4TMBkSjOGRYRNo2pF+pCaGb9MMryegJo1G+NcdDbSElj5azTw3
	HsD+mBQ==
X-Received: from pfob18.prod.google.com ([2002:aa7:8712:0:b0:84b:62d1:9fe3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e83:b0:852:6588:4b7e
 with SMTP id d2e1a72fcca58-85ed8018787mr10294905b3a.12.1788381467024; Wed, 02
 Sep 2026 13:37:47 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:47 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-7-kuniyu@google.com>
Subject: [PATCH v6 net-next 06/15] neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

We will remove RTNL for neigh_add() and neigh_delete(), but they
are still serialised by per-protocol neigh_table.lock.

We can avoid contention by converting neigh_tables[] to per-netns,
but arp_tbl and nd_tbl are directly used in many places.

As a prep, let's store &arp_tbl and &nd_tbl in net->neigh_tables[].

We will replace such users with arp_table(net) and nd_table(net)
and then allocate per-netns neigh_table.

Note that nd_table() still returns &nd_tbl in case disable_ipv6_mod
is 1 because some buggy drivers use nd_tbl without checking it.

proc_create_net() is guarded with CONFIG_PROC_FS because it
returns NULL when =n and setup_net() fails and panic()s.  Also
a later patch moves neigh_sysctl_register() under the guard.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v4: Add note about CONFIG_PROC_FS
---
 include/net/arp.h           |  6 +++++-
 include/net/ndisc.h         |  9 +++++++++
 include/net/neighbour.h     |  2 ++
 include/net/net_namespace.h |  4 ++++
 net/core/neighbour.c        | 12 ++++++++++++
 net/ipv4/arp.c              | 23 +++++++++++++++++++++--
 net/ipv6/ndisc.c            | 12 +++++++++++-
 7 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/net/arp.h b/include/net/arp.h
index e8747e0713c7..f8d18b1f8b28 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -7,9 +7,13 @@
 #include <linux/hash.h>
 #include <net/neighbour.h>
 
-
 extern struct neigh_table arp_tbl;
 
+static inline struct neigh_table *arp_table(struct net *net)
+{
+	return net->neigh_tables[NEIGH_ARP_TABLE];
+}
+
 static inline u32 arp_hashfn(const void *pkey, const struct net_device *dev, u32 *hash_rnd)
 {
 	u32 key = *(const u32 *)pkey;
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 9e5379ad2d8e..8516c7ff6e92 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -67,6 +67,15 @@ struct prefix_info;
 
 extern struct neigh_table nd_tbl;
 
+static inline struct neigh_table *nd_table(struct net *net)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (disable_ipv6_mod)
+		return &nd_tbl;
+#endif
+	return net->neigh_tables[NEIGH_ND_TABLE];
+}
+
 struct nd_msg {
         struct icmp6hdr	icmph;
         struct in6_addr	target;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 7847c29496ae..700d62605fab 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -339,6 +339,8 @@ static inline void neigh_confirm(struct neighbour *n)
 	}
 }
 
+int neigh_table_register(struct net *net, struct neigh_table *tbl, int index);
+void neigh_table_unregister(struct net *net, int index);
 void neigh_table_init(int index, struct neigh_table *tbl);
 int neigh_table_clear(int index, struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e5ee673b9fcf..46b4c67e2966 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -39,6 +39,7 @@
 #include <net/netns/mctp.h>
 #include <net/netns/vsock.h>
 #include <net/net_trackers.h>
+#include <net/neighbour_tables.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 #include <linux/skbuff.h>
@@ -47,6 +48,7 @@
 
 struct user_namespace;
 struct proc_dir_entry;
+struct neigh_table;
 struct net_device;
 struct sock;
 struct ctl_table_header;
@@ -103,6 +105,8 @@ struct net {
 	struct proc_dir_entry 	*proc_net;
 	struct proc_dir_entry 	*proc_net_stat;
 
+	struct neigh_table	*neigh_tables[NEIGH_NR_TABLES];
+
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_set	sysctls;
 #endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index caa52bf64a2d..286acb7cd504 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1899,6 +1899,18 @@ int neigh_table_clear(int index, struct neigh_table *tbl)
 	return 0;
 }
 
+int neigh_table_register(struct net *net, struct neigh_table *tbl, int index)
+{
+	net->neigh_tables[index] = tbl;
+
+	return 0;
+}
+
+void neigh_table_unregister(struct net *net, int index)
+{
+	net->neigh_tables[index] = NULL;
+}
+
 static struct neigh_table *neigh_find_table(int family)
 {
 	struct neigh_table *tbl = NULL;
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index d409f606aec0..bad17d5aeafc 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1495,15 +1495,34 @@ static const struct seq_operations arp_seq_ops = {
 
 static int __net_init arp_net_init(struct net *net)
 {
+	int err;
+
+	err = neigh_table_register(net, &arp_tbl, NEIGH_ARP_TABLE);
+	if (err)
+		goto err;
+
+#ifdef CONFIG_PROC_FS
 	if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
-			sizeof(struct neigh_seq_state)))
-		return -ENOMEM;
+			     sizeof(struct neigh_seq_state))) {
+		err = -ENOMEM;
+		goto err_proc_create;
+	}
+#endif
+
 	return 0;
+
+#ifdef CONFIG_PROC_FS
+err_proc_create:
+	neigh_table_unregister(net, NEIGH_ARP_TABLE);
+#endif
+err:
+	return err;
 }
 
 static void __net_exit arp_net_exit(struct net *net)
 {
 	remove_proc_entry("arp", net->proc_net);
+	neigh_table_unregister(net, NEIGH_ARP_TABLE);
 }
 
 static struct pernet_operations arp_net_ops = {
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 75515fd99383..dc4c083fe27a 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1974,12 +1974,16 @@ static int __net_init ndisc_net_init(struct net *net)
 	struct sock *sk;
 	int err;
 
+	err = neigh_table_register(net, &nd_tbl, NEIGH_ND_TABLE);
+	if (err)
+		goto err;
+
 	err = inet_ctl_sock_create(&sk, PF_INET6,
 				   SOCK_RAW, IPPROTO_ICMPV6, net);
 	if (err < 0) {
 		net_err_ratelimited("NDISC: Failed to initialize the control socket (err %d)\n",
 				    err);
-		return err;
+		goto err_sock_create;
 	}
 
 	net->ipv6.ndisc_sk = sk;
@@ -1990,11 +1994,17 @@ static int __net_init ndisc_net_init(struct net *net)
 	inet6_clear_bit(MC6_LOOP, sk);
 
 	return 0;
+
+err_sock_create:
+	neigh_table_unregister(net, NEIGH_ND_TABLE);
+err:
+	return err;
 }
 
 static void __net_exit ndisc_net_exit(struct net *net)
 {
 	inet_ctl_sock_destroy(net->ipv6.ndisc_sk);
+	neigh_table_unregister(net, NEIGH_ND_TABLE);
 }
 
 static struct pernet_operations ndisc_net_ops = {
-- 
2.55.0.970.g62bdec98f9-goog

