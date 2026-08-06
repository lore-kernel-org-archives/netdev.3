Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4323B4EB6
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978721; cv=none; b=tWTjpkHPkayU6g3P7UTcgLaiK3/KMkvyapxeHB0XjAxmkc9lEbGRoWX2x8Mw0UmlgOE0sdTxAD6jwOfFVokh06XbS3IXMIrRYmW1xtPhiWDueMttxk04x1S5gWzHeas1XBRjDejvEwwdpYK+wDG91FMQaFQd3kVO3j5SdvfSfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978721; c=relaxed/simple;
	bh=Zq20uHO0wgg3wuW1xQYHHvVHVfDr4CpcbuPcUJRLehY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DqfWI7wWtt408VgH/PNfVHG2ZumqK7VpwED2Iec28omh4gFMlc+nojr+IVDEfHujT78IS1ztnqxSNFxAJIdkml1oApMofta4zlqCF43pRH06ktl2fsdapHrMacV1Sce1vkvRkkhx/CCkBNTUD5D/qm4zPPNfsxHoCRusddsNxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvnlVPcD; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvnlVPcD"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so2559701a91.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978719; x=1786583519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vn4ZBLsfGjJIKtuLPvGFWv5OShskIqzUcRBFaUadLI=;
        b=pvnlVPcDQwuOO5dH2hxkip7Y9g/ha4931CIMUacsOHrH4RrV89cEKMj/KFGHY1ho9O
         0FIPRrDKGg77xLdGD2dPzLp3VqxgCocRcGlSCvJqI185rbZAN5+qQuKMKUJynnMp2Txq
         kxBDq5xos1EXggwpmta2IsbGQHi1GKLpq3ZVSMuNfAZWPAFlSofWk1kl8lRuVzYvLPIO
         eOFJWraTpG0pfRoivtTRq56p8Av/bx+lZx5nDN6++58xpA3IM4tUQDUHZHWHEF4TnRDI
         JUnD+8cFhF7Z9quXhcyM57zfqMp2pvJcLF+16KA8Inrmi/aC7vjOo++YRo0Xvj9VjWLN
         XxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978719; x=1786583519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9vn4ZBLsfGjJIKtuLPvGFWv5OShskIqzUcRBFaUadLI=;
        b=XgKkWmQuZMCvZx1YADzFThNEGPi/hpMI+hojVv0MPofxs/uoBV0T5QWVnn7LoNYIke
         QzGD8C+Hv24HKaoFV2O+6Yn0tISCDh2Vnc2tbq6N1B7ixJLGq+G21tJOUeUkGrnacenA
         M3uqodtNdXW6Ni+QC8ayPEDMPJS6BwgetJ9Ia5TzKxmpGuKR1t3rEUkSYaCriMsFY7NR
         Ramu+RJlC+a7EKw8wfolWbxLsVltw4UKidB3bhvzQFlutaUIjhQqmDRMZFwIxaN1L5j9
         XBjSX9lrxh33E5bDnptvvty3ml0SJW8Sh3tbzdGXl6+wKjiJzQy6didisrvST2mWXjW0
         v01A==
X-Forwarded-Encrypted: i=1; AHgh+Ro1qqsea4OKXM7Nru4khMRuaKJo6JNVP1jA+rWGrgPh7RzaM5vIxhiXnimkJwWafnhkyUxgv68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrS5vx+8zaKpMtLfDbet5qCIdku2NVIYxcj7adq4WQuYesknvk
	lmtar7soN5Q6ywtkOnN+TUBrdMyMZEXZn5PtVaQiObn5SO8CoO1a2UpFCyBrk65TUVqQgNBQ3mM
	cMU5abQ==
X-Received: from pjbgi2.prod.google.com ([2002:a17:90b:1102:b0:383:a728:1316])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c84:b0:38f:1e1a:515e
 with SMTP id 98e67ed59e1d1-3903c5b1688mr10253932a91.14.1785978718596; Wed, 05
 Aug 2026 18:11:58 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:27 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/11] neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
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

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/arp.h           |  6 +++++-
 include/net/ndisc.h         |  9 +++++++++
 include/net/neighbour.h     |  2 ++
 include/net/net_namespace.h |  4 ++++
 net/core/neighbour.c        | 12 ++++++++++++
 net/ipv4/arp.c              | 20 ++++++++++++++++++--
 net/ipv6/ndisc.c            | 12 +++++++++++-
 7 files changed, 61 insertions(+), 4 deletions(-)

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
index 3da1a6f8d3f9..84dba1376f98 100644
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
index 501af1999fe8..f96a390ae536 100644
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
index 66063dd00aaa..bad17d5aeafc 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1495,18 +1495,34 @@ static const struct seq_operations arp_seq_ops = {
 
 static int __net_init arp_net_init(struct net *net)
 {
+	int err;
+
+	err = neigh_table_register(net, &arp_tbl, NEIGH_ARP_TABLE);
+	if (err)
+		goto err;
+
 #ifdef CONFIG_PROC_FS
 	if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
-			sizeof(struct neigh_seq_state)))
-		return -ENOMEM;
+			     sizeof(struct neigh_seq_state))) {
+		err = -ENOMEM;
+		goto err_proc_create;
+	}
 #endif
 
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
index fe36b3f51285..951c0f484ae7 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1971,12 +1971,16 @@ static int __net_init ndisc_net_init(struct net *net)
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
@@ -1987,11 +1991,17 @@ static int __net_init ndisc_net_init(struct net *net)
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
2.55.0.679.g6767b8d81c-goog

