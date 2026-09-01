Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927849DBB2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287616; cv=none; b=enAG/qZl213lM3wl/mSGvjk3CnjGIFZOWnS/n6JGBe+0s1GUmlQvDXSqPTOLnrjEZ87MSiMZQggjO/TUYVcv3xR3ZKmv33oOKGRcBlzSY17KV+d/bRPuRzmFCyGZ6Jn5vTBYQyuD0XtKup2UWu8MyWJLpnWEhDPgNB8NLzaHQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287616; c=relaxed/simple;
	bh=iWJMU2I/f09oFy4Gp6S+jgiiSz2/t7z1O87PJxTLGJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rxi4oj7FW6ma0y4AzfLXATuweirp76bnqKPE+Dy/hJhqPttpCsL4fixq0viMNAyOgRnfHCvDicaoV9/yPycizMFbdfhhr8lYo9ZJ8zc7zoH+Y2MYPlRp8wyyqc+8k7ZWx6dkBUkYhQ2FDqI/Vr4RX6VocAwNN7iynGFqgkMO1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbFO90aX; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbFO90aX"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94f086fedso1134455ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287614; x=1788892414; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEfdGjw/1aa9ZTTdyFUya5DJnPZr/RQCuW+figmbAwM=;
        b=YbFO90aXgOxFX5o5R52XNC6qGuybTqRCiD3Y+YWusZh1U2RYw61xC7j/rQynQQHXix
         2cnLKVLUq3j1Kbi4rufi2ivZVTc16NqDfPmlsIFzx/pw6WsWnhLKsx+HepiIdDT+yU7k
         DYc/NXBjcCrTocnBndmBoopx4oAbs0uMzy5jlVtlNTwcejjbbjI35ils1ADZyaZUQO/C
         Gh48Q6vw0BcZ7J9rER5upLljB0ej5f+g2KTIawZZBiccnhhTF0806gQndgXynIYVgdYf
         MuBEw8OSe0ctDi+JCaILHhhGF91l6oUCdU8BgJjs7ccj7ydsuE6d6xEt3TTSWcrrNTsB
         JuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287614; x=1788892414;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FEfdGjw/1aa9ZTTdyFUya5DJnPZr/RQCuW+figmbAwM=;
        b=gJIivfNgiz68f8dbDf0vmM87F6VJfEPqhq7BEW5FQ3PRUMPOrOTD8Q4SXkPnhqTR9h
         8FlUj70h2j/doX8BBnxTNcKEGhWpNxDo0NvkygfAWG1Fp9XLHY6lStrmsCeFQLwwwwjk
         jBX5rnOuURTkinuGor+gbWrUYhRyC6W9oNff4xSqstl1KCfr2UTfy8CfXrVlc6RvtmGB
         TtTNr+WLGaG7hnCuHwjN4C5xoYuPo02Ae27DF2/wVFO/VVB4pWosHtC+nZZZHvMcmhbk
         aOUjsMXbCIcekgw/r/Dru9/Tr19LDX0ZyQIwLkI6aoJiUHTvkQt0mU6yI5qx370KhTwz
         Sbwg==
X-Forwarded-Encrypted: i=1; AKwUvBx25h085TQs2/Iu78zyHETeasBuV7R3GcJPeKr5zXwefFyQvoPnVBkRRB0JFgJQg+DHzkPav8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lXQfuSDQs0gkqmsoRYns2FnMl0G88p72+qT5gy6pRA1pHj2h9u
	BD1eS/C+Ye+mBIOqViLhC7YgzrUFUaP8zD6/AAVHAkAq78MLEcNpt5IncOq6hdNt+z4b4YNiwEJ
	TDEiT2g==
X-Received: from plbll14.prod.google.com ([2002:a17:903:90e:b0:2cc:61be:8bbb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a518:b0:2cf:b68a:340
 with SMTP id d9443c01a7336-2d74e0b1e52mr370702585ad.10.1788287613813; Tue, 01
 Sep 2026 11:33:33 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:54 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-6-kuniyu@google.com>
Subject: [PATCH v5 net-next 05/15] neighbour: Remove __rcu from neigh_tables[].
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

Since commit 1bf20cc62a54 ("neighbour: remove obsolete
EXPORT_SYMBOL()") unexported neigh_table_init(), neigh_table
cannot be registered dynamically.

Let's remove RCU protection for neigh_tables[].

Note that neightbl_set() no longer needs RCU because it holds
spin_lock_bh(&tbl->lock).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/core/neighbour.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6fda0052027b..caa52bf64a2d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1807,7 +1807,7 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
+static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
 
 void neigh_table_init(int index, struct neigh_table *tbl)
 {
@@ -1864,7 +1864,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
 
-	rcu_assign_pointer(neigh_tables[index], tbl);
+	neigh_tables[index] = tbl;
 }
 
 /*
@@ -1873,8 +1873,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
  */
 int neigh_table_clear(int index, struct neigh_table *tbl)
 {
-	RCU_INIT_POINTER(neigh_tables[index], NULL);
-	synchronize_rcu();
+	neigh_tables[index] = NULL;
 
 	/* It is not clean... Fix it to unload IPv6 module safely */
 	cancel_delayed_work_sync(&tbl->managed_work);
@@ -1906,10 +1905,10 @@ static struct neigh_table *neigh_find_table(int family)
 
 	switch (family) {
 	case AF_INET:
-		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ARP_TABLE]);
+		tbl = neigh_tables[NEIGH_ARP_TABLE];
 		break;
 	case AF_INET6:
-		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ND_TABLE]);
+		tbl = neigh_tables[NEIGH_ND_TABLE];
 		break;
 	}
 
@@ -2391,10 +2390,8 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	ndtmsg = nlmsg_data(nlh);
 
-	rcu_read_lock();
-
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = rcu_dereference(neigh_tables[tidx]);
+		tbl = neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2408,7 +2405,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (!found) {
-		rcu_read_unlock();
 		err = -ENOENT;
 		goto errout;
 	}
@@ -2537,7 +2533,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_tbl_lock:
 	spin_unlock_bh(&tbl->lock);
-	rcu_read_unlock();
 errout:
 	return err;
 }
@@ -2589,7 +2584,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = rcu_dereference(neigh_tables[tidx]);
+		tbl = neigh_tables[tidx];
 		if (!tbl)
 			continue;
 
@@ -2949,7 +2944,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	for (t = 0; t < NEIGH_NR_TABLES; t++) {
-		tbl = rcu_dereference(neigh_tables[t]);
+		tbl = neigh_tables[t];
 
 		if (!tbl)
 			continue;
@@ -3162,7 +3157,7 @@ int neigh_xmit(int index, struct net_device *dev,
 		struct neighbour *neigh;
 
 		rcu_read_lock();
-		tbl = rcu_dereference(neigh_tables[index]);
+		tbl = neigh_tables[index];
 		if (!tbl) {
 			rcu_read_unlock();
 			goto out_kfree_skb;
-- 
2.55.0.966.g6673acef38-goog

