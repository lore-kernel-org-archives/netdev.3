Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD743F4D3
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608181; cv=none; b=tAZvWbJw4UroRxzdaRBdo6h6TqjtNhP/63/eQxpW/pFQX7SG/kMwnFIzRyvGh0nrttiYB0tGKNwJcw7BaS9HM4ZYM738lV62yTl5aOIvBdaZlK5ZM6kVL4Hxtwl3IWnNCcmECWsMp6oWlR/tDO4Se6R7k87NNYdNJGlb1exK9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608181; c=relaxed/simple;
	bh=g2tPwz1YQWuTdt1skjzt3nPB+Myw23/YCFhnlUHHYSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3+EWrmbalH3oiy+6U9/HgNMszGiRHsDlQ862j49cJuYsf2/E4R/MPKf4AkKE0R8NjYOXyTVANjuuUpCs43G8F0DEUlK4EPnGgwVmgndS9wKpPptueQl2UE4bZVE2gdvh86qEybeerh7wdg4UJrvhGvNA/zIN3bJ1yWI+SCfqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DosDAm8B; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DosDAm8B"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e01a62d99so2231867b3a.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608175; x=1787212975; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7uchpUC9kXQnPYFpmz2OuPnY+7DneU8mNeGtI+bIew=;
        b=DosDAm8BOUuvRWGXV6IUTnYbCCVhEnqWJn9Ct5qaUCZuH4IZTSva9TkkLFE98DaNjL
         OGLrpIoOaFRbc73XBC4EUYep78RJ248pvjIf1gWcK3QFEoBwxmHsqp/JtYYdT26Nl0Bd
         7zXiOhF9nISv2R+3jzHSIzmO4L1PpA7yReWoVHLYszwByE45x9mjwS9kfvsisSHPoNJ7
         bOl99FGsXzbkLGhdT+WLdjocViSJb9Wo9toNzLYBT1XDxYjcAvChD+F6zAf13sYPvplo
         /DT/iSDF56l/zaaDmuEvd2+fRuO5ewzZiZHy+r0H/HjEunz4XRJsdSQzsRS9irxPdHf2
         XrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608175; x=1787212975;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t7uchpUC9kXQnPYFpmz2OuPnY+7DneU8mNeGtI+bIew=;
        b=jd76b3idysfgnDiBpC9GC3XDzANIywRnU+f6eropYgaQTSMU9UcwIRPvBi8kWhRvBz
         fbXM2YnyztHU0BWB5FaINQ42/H5fcPFhjq9xYn+AtLEtKU7geyY49f5rVXisq4+vsuiK
         vG3mRbWmGAVqMefjfOER4ALrvZgARrvMIZaPj5MWslIpr41zQzN/qA7Fsl9N92vpVTN1
         mOk8RZ3uz5OPJB9UAWrsKiXXlHWzQI//j6hq06XxtQHZ31uR49+8XxqnvN5QEn2dzM/i
         wq/icAw3HPABx0LzlWN8wrkAd8tq4QBrwVRd3W36IORFTsTXrF90jH7R2rUjj+a2ScJn
         pKgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpoio73udGPl/zgeUWJ7HzB/+0LoZbQ54dV4rB016i7Ws92XTt5uDZrkURBc+kwQuEbchl+Y6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcURQlOTvzwpLjeCr5BQ1gnkUUkCaTxCAza3Wy29Fox3+64cEB
	od/Fr1T23AssYyS6JqFtN6IcVLb9cXdc7Gjb2L/1fR5yQjToCHekGPfqqwAxd8/76X03JoOhJba
	ax3YcFQ==
X-Received: from pgie22.prod.google.com ([2002:a63:ee16:0:b0:c82:a5b0:d9f0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da5:b0:842:708f:39be
 with SMTP id d2e1a72fcca58-84fc744db5emr3997878b3a.5.1786608175048; Thu, 13
 Aug 2026 01:02:55 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:20 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-7-kuniyu@google.com>
Subject: [PATCH v4 net-next 06/15] neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
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

proc_create_net() is guarded with CONFIG_PROC_FS because it
returns NULL when =n and setup_net() fails and panic()s.  Also
a later patch moves neigh_sysctl_register() under the guard.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
index 2ceb655c4229..7af1ba5084bd 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1972,12 +1972,16 @@ static int __net_init ndisc_net_init(struct net *net)
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
@@ -1988,11 +1992,17 @@ static int __net_init ndisc_net_init(struct net *net)
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
2.55.0.691.gc56d675ccc-goog

