Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87192931F6
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056911; cv=none; b=qPoQblT3zIxxI1a4mm1bYU9DKmEY4ktwBLx1cTsE8CJPh/VsgKpQLkxKn4x1o3fzpIxa5mspPM2hQUN8ssYqRYemyaprAsQeWugMNn6/GpXj8d4UVT+yf+pmG05XyH55Bsf7O0UiNwnhFf/k0izNRp4Q0gnog3j4/w3xx0YCDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056911; c=relaxed/simple;
	bh=iLkneIeq1AxlDdZvRKZ8gQbxgA9ZMIn/4T9ymg5qw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sv/cq51/6VPoqeXplIpIRnK3MX03FJiIRWEq+3lfxwC/40SGgAcvdpk8y65/2GEfDk6AWBgS5Y96Tmdn3Z4iSxDjLOGaBorvqlDc+oyFh5lXZZBk9RC5C0BC0zGsVZ/F2YXyxfBMZAkYDmUqrp0q/remXdAfrF2BCaRR3dvcH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjngudTZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjngudTZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so4329160a91.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056909; x=1784661709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAASN6U6OOVv//Mz02/nbnb9WdAqWVBqrwWeCSiCGQw=;
        b=RjngudTZKnDHDv315QzTCnxtrrODcedvmsfMviE2bwkQBpMdB4a16luTlbFb24HQr8
         /l1CYl9jh4vy61AcZYB/xNbojmHPzB8yQjhjHjQ6QaQJRW8OZ8627LbBmWyJjApGVQ2L
         HgzIRQk8Ij0POiG6S0q2A4YipJh/QuOHimCyMZuGBiFWiVzJdgQfeFasbLQFTeDUS/S6
         hIJL+H1+YtyRGKR1Sv5Ip1IzEsn9Rdwj1UcF678e9F6C5T5is0TTlh5g8n1P8xrppu7k
         8eskqLrEAxnrBt9EpNkjPuO6/SP3+E9mmm0woE913/GeGRUD94Ykh5kEC8WKrVbKSOxW
         eHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056909; x=1784661709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAASN6U6OOVv//Mz02/nbnb9WdAqWVBqrwWeCSiCGQw=;
        b=rqsC+s1B2OjTp41DjnioFGSI4HbdBAJk2LYDu55Vi0Lex6lqOIi40koSdJ+Qp1UY0Y
         QUmMWV9HLKpDGxHehRoCl3rI9HgU2vG0f0h82fFZ0jQuUt9YeW2Le0s6t4BrvH0pbyZ8
         eW9lNbPGSa52Uzpqw52GGPiqw9Ce0wRziGqb/3axT7oIWE0iKMcA71djlMEGY9H7Rne4
         3bEcoHGbdPufcQcVoXS0l183/ZijBx4kZgIIdb2LWesB+xFgK7E4A+awB+ROfEfHSGgm
         f8tpLuSMs5dZEVa9pTAh4WYgTHQnoSwkieVTDf9EH1opsZn1ILlpX3XjtQqCYoJ4EPyt
         GOZg==
X-Gm-Message-State: AOJu0YxoEJSy0NXvpDSnl/9VMCcVZYVnm0Y81kkNVp4Ml7WQUZUV86Qi
	7dj8zF0FMJYGUS24i/7kbyykrEPbrKfDdDYDEilDkmKb0fkv3ZmzH2fG
X-Gm-Gg: AfdE7cnHa/oTK33t/p9g7dZOTtI12aUDczRAomIKYBEdOZ76Mm52VfcYo4aCUW9eLAA
	rbWxuO+q4U1Ac/3vi5ln+YKpyoTtJAOuo8nTizBkmDe/OzaSgfRNrE142rDj5Z4hSLqjwm4lTl2
	ojsjVYT5fl+oMICEFIzkaEkKRYqVDtus3CxLEeKNbfQNLhKkAUDN5DU+iNdITbZHoYwtdp3JfzB
	yjjbVrV4bTMTd0Pu1ksu0PsN95pyP6Yx46+UC2Wt9qqRLmwgVl0LCcbkLtvYuUZalE9MBXgJqEO
	ZFc9eM+3T2JDgtDygUU/CxNPOSHCB6ODW9TQ8muaHT4SjZMs/DfM69GTVSCYhR4iGUJzRyIZ4x1
	52R8F8FuLB6t8vUjvtAFCYD4gKwDOKvAWMlg1CUE+44ZSLwkTpG99U0+hkZGQbzFJyzYkjT3+kn
	0gsyg42RjOoPYhaF0S11N81I9hWuPmPp5S30GmUn0gPp/sx5T6gi6TQvnwbg==
X-Received: by 2002:a17:90b:3510:b0:368:ed26:15b2 with SMTP id 98e67ed59e1d1-38e29ff969fmr37149a91.8.1784056909019;
        Tue, 14 Jul 2026 12:21:49 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119d5cf176sm56727770eec.12.2026.07.14.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:21:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5] tipc: serialize udp bearer replicast list updates
Date: Tue, 14 Jul 2026 12:21:40 -0700
Message-ID: <20260714192140.1810202-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs
from the encap receive softirq (via tipc_udp_rcast_disc()) without
rtnl_lock(), so it can race the cleanup delete and corrupt the list:

  list_del corruption. prev->next should be ffff8880298d7ab8,
    but was ffff88802449ad38. (prev=ffff888027e3ec98)
  kernel BUG at lib/list_debug.c:62!
  RIP: __list_del_entry_valid_or_report+0x17a/0x200
  Workqueue: events cleanup_bearer
  Call Trace:
   cleanup_bearer (net/tipc/udp_media.c:811)
   process_one_work (kernel/workqueue.c:3302)
   worker_thread (kernel/workqueue.c:3466)

The bearer can be enabled from an unprivileged user namespace, as the
TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.

Add a spinlock to struct udp_bearer and take it around the list_add_rcu()
in tipc_udp_rcast_add() and the list_del_rcu() loop in cleanup_bearer() so
the two writers can no longer corrupt the list.

Reject a duplicate peer under the same lock before allocating, and remove
tipc_udp_is_known_peer(). The old lockless pre-check in
tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer
could both find it absent and add it twice.

cleanup_bearer() runs from a workqueue after tipc_udp_disable() clears the
bearer's up bit, so an encap softirq can still reach tipc_udp_rcast_add()
and add a peer after cleanup_bearer() has already emptied the list, leaking
that entry when the bearer is freed. Mark the bearer disabled under
rcast_lock once the list is emptied and refuse further additions.

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v5: (per Tung's review)
 - Mark the bearer disabled under rcast_lock in cleanup_bearer() and reject
   further tipc_udp_rcast_add() so an encap softirq can't add a peer after
   the list has been emptied, which would leak it.
v4:
 - Reject a duplicate under rcast_lock before allocating rcast.
v3:
 - Do the duplicate check in tipc_udp_rcast_add() under rcast_lock and
   remove tipc_udp_is_known_peer().
v2:
 - Narrow the lock to the list mutation.

 net/tipc/udp_media.c | 55 +++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 62ae7f5b5..1844dea01 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -94,6 +94,7 @@ struct udp_replicast {
  * @ifindex:	local address scope
  * @work:	used to schedule deferred work on a bearer
  * @rcast:	associated udp_replicast container
+ * @rcast_lock:	serialize updates to @rcast.list against concurrent updaters
  */
 struct udp_bearer {
 	struct tipc_bearer __rcu *bearer;
@@ -101,6 +102,8 @@ struct udp_bearer {
 	u32 ifindex;
 	struct work_struct work;
 	struct udp_replicast rcast;
+	spinlock_t rcast_lock;
+	bool disabled;
 };
 
 static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr)
@@ -278,26 +281,6 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
 	return err;
 }
 
-static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
-				   struct udp_media_addr *addr)
-{
-	struct udp_replicast *rcast, *tmp;
-	struct udp_bearer *ub;
-
-	ub = rcu_dereference_rtnl(b->media_ptr);
-	if (!ub) {
-		pr_err_ratelimited("UDP bearer instance not found\n");
-		return false;
-	}
-
-	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
-		if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media_addr)))
-			return true;
-	}
-
-	return false;
-}
-
 static int tipc_udp_rcast_add(struct tipc_bearer *b,
 			      struct udp_media_addr *addr)
 {
@@ -308,16 +291,34 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 	if (!ub)
 		return -ENODEV;
 
+	spin_lock_bh(&ub->rcast_lock);
+	if (ub->disabled) {
+		spin_unlock_bh(&ub->rcast_lock);
+		return 0;
+	}
+	list_for_each_entry(rcast, &ub->rcast.list, list) {
+		if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
+			spin_unlock_bh(&ub->rcast_lock);
+			return 0;
+		}
+	}
+
 	rcast = kmalloc_obj(*rcast, GFP_ATOMIC);
-	if (!rcast)
+	if (!rcast) {
+		spin_unlock_bh(&ub->rcast_lock);
 		return -ENOMEM;
+	}
 
 	if (dst_cache_init(&rcast->dst_cache, GFP_ATOMIC)) {
+		spin_unlock_bh(&ub->rcast_lock);
 		kfree(rcast);
 		return -ENOMEM;
 	}
 
 	memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
+	list_add_rcu(&rcast->list, &ub->rcast.list);
+	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
+	spin_unlock_bh(&ub->rcast_lock);
 
 	if (ntohs(addr->proto) == ETH_P_IP)
 		pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);
@@ -325,8 +326,6 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 	else if (ntohs(addr->proto) == ETH_P_IPV6)
 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
 #endif
-	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
-	list_add_rcu(&rcast->list, &ub->rcast.list);
 	return 0;
 }
 
@@ -361,9 +360,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (likely(tipc_udp_is_known_peer(b, &src)))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &src);
 }
 
@@ -644,9 +640,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr)
 		return -EINVAL;
 	}
 
-	if (tipc_udp_is_known_peer(b, &addr))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &addr);
 }
 
@@ -679,6 +672,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ub->rcast.list);
+	spin_lock_init(&ub->rcast_lock);
 
 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
 		goto err;
@@ -819,10 +813,13 @@ static void cleanup_bearer(struct work_struct *work)
 	struct udp_replicast *rcast, *tmp;
 	struct tipc_net *tn;
 
+	spin_lock_bh(&ub->rcast_lock);
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
 		list_del_rcu(&rcast->list);
 		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
 	}
+	ub->disabled = true;
+	spin_unlock_bh(&ub->rcast_lock);
 
 	tn = tipc_net(sock_net(ub->sk));
 
-- 
2.43.0

