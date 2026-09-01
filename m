Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B149DBA6
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287617; cv=none; b=LrztKl9EURtdwwOy25AwZB2V6XTCCSXl6zmSg3/33lbt/PWjK0mHoq1e/hU4wf1yRXVE1ScKtt8PQiJbZ6Lv1Pk5Gl5QC0uQSpYTRsunRpToT8lq2UFtcf6NOzi5B65sU+xvMjjAvZinZvnBOupOUSXssWXuofJOoBZRvbtDrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287617; c=relaxed/simple;
	bh=eKL9TAfiyoT29CTLYRcW1lyER7IBpevHEOOiVRLUFSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qx1mP6671nSs9eG0FBg0P+3c0YLfoCwh7qnKkdJwgiZNOamrVq4BQzOAg+SKXBkPvkWTqkP16cSFz+VgXrIcol5J3AQkpJXKy+dalMWmqeiOTVxdZelZovXfxsaPghgx16ilKQlxfXqYVYuTlQRgDcNsVnyWzE9GUyBnYJon9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pwt8Owbz; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pwt8Owbz"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d54187d8b0so2581095ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287615; x=1788892415; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v49+Jy77DXsmATZM0cSmh97Vq57ysQv90bCegqjW9ZY=;
        b=Pwt8OwbzJKvdPyH9uXxOezkeDDhgcjHNUi/oS5VdGUhMXVkV6Nw9N5JTnnKvsZgMnN
         snYH3FRd2HPasDut66tRlbw3zORJkv97Y9IW7CGyL96deDg0HAeyGpBwe8iubpsEcbFT
         P5DjcoPxYByZiSOEQzdFy4Fvr3oFO1UOSkcqeCS8qV3oM5+4F5ZWiRSgB/Fvlc5BLu+Y
         NYn4G+poEmmof51AMmONglRb2gHZbLIlhrxxNbYGEbDvo3UqGNhjTCQ18Ah1bWnmGiqg
         JfzsCJpv7yqXgCTGBW33Vsr4BzXR7fqrkqbVwPeNRE56PgZAuDbGFdRvjYa7To+4Nhxe
         8DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287615; x=1788892415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v49+Jy77DXsmATZM0cSmh97Vq57ysQv90bCegqjW9ZY=;
        b=WS+P/UJbfErqo0bYbHRqjm+r/zr+EjSY5R5JSkBaQZ5X8hJn+hbI6RiCLPyVV+iZ+O
         joGrMh4mBxu8mV4gB+zynKvKhTuWymanX14tpyF5ee65Q8DSbHROh0mWNM3Na4ZwTu30
         os2sFg6lYDDIEbHFYLRsivdsl78SLOKLtqiOceB5NPVGXb2kx7m3Amu9E//KNwWJK+bN
         nY9dj1U2YWgYSRKOwWRo4UygpxnGmLOXvr30PPtzpBkMt3GMdzQ5i1IPCWNbVlCG159V
         3Y8Ld5UbQiajJEnTsAL6MYS/UJ6KrOVMl1O0oki5CiuSdxNCJ/v9jLtwLuzRAFEfq0YU
         UXDQ==
X-Forwarded-Encrypted: i=1; AKwUvBy02zGSbw57gLPyg9cYBpCcY4y6sGVqw4VcA0nWB7MqDHBCo8XL7pxWFO8HF8v/jESqQ/3/alI=@vger.kernel.org
X-Gm-Message-State: AFuF++k6s3OJ7IXLxNppwdWuqYYr4ImalX/qRNsLKjm6EpiHbhYHiJO4
	oyoMfZQ323vkDqlw5eufCNiyScI7seNLyRyBlfI6R6PwwXOnAEfTBeJBG+NQcA6cRgFPIOWrSaL
	+4Cktxg==
X-Received: from pleq1.prod.google.com ([2002:a17:902:f341:b0:2ce:9b92:ec60])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b06:b0:2bf:dd0:c8b1
 with SMTP id d9443c01a7336-2d74ce16d3bmr543049755ad.0.1788287614580; Tue, 01
 Sep 2026 11:33:34 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:55 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-7-kuniyu@google.com>
Subject: [PATCH v5 net-next 06/15] neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
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
2.55.0.966.g6673acef38-goog

