Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7816132A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170339; cv=none; b=m31cUi726Id7MvM9Mp/DczVN07wA8JWJ3j9gOwnDGB1XUitSb+JWxl5hkA6lFqLU4jUdMQWuQ/pLwnmC+Tt6c/XAhYOiCqcnx8oRfmAWHUUD6p5Jr0lrAHmo73XNJtZ+VUQeoi7cDPyn+mq/dzdQQ+3Pg0Mp4EyHzZhrahDz8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170339; c=relaxed/simple;
	bh=Ckid0TLlQ/YCBTO91CpgzPK+LZ5TLB/nC+yylqar0gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBI4x4NKbgf4G1oPFc3b0qZwrXC/SkuyPLKRBQn/sQpG9bbm1XcQdLfSy/Pdtjjo2aUcLkxYAoNTDO2OJXJZhSMru85k3HUCosascoYcgIiX1H21Y8J9uYVGNtTwepZiRmrqR/GSqYcTQ6vOM+40EPtGZhwl7XSR5o4tUIfzasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrG+XkU5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrG+XkU5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so2424946a12.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784170337; x=1784775137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WScIMoaEDktxXY69MiviMLTptPBHtf7sDa7tNPt00hA=;
        b=ZrG+XkU5vn0C6ZORad3kAdCVmqxcxbY0V5lx8rKYv1wSioUn0Jh1GhABSjh0Gq/33c
         cP1Nu7doJvXUZFyK2AjBM18dGD7iDHdJVrC20HHdgapPLWHCXn/vBri9JSetDnn20Q7g
         GDmalTdN4Wv2gHVTHDA9OhBtqpBimDDGEuLQTbmuc+68FwgpynrE9dtppqpzYYs4Bsgr
         9pmYc76WsMRdyu9rkwPK0i1nVWEwJUP4XhE/xW7qM8/Jbykxzx/tasm2dLZL9ze3xZgD
         MYGR9OrKIWJbNFQyiuhXpEoF01Gv46ha++I0DoHmqe1VFI6Z8VouxGOYKSW0I2eg183H
         fLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170337; x=1784775137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WScIMoaEDktxXY69MiviMLTptPBHtf7sDa7tNPt00hA=;
        b=osus3uHzEw1Jn6uUJLTgoy9SyraOP1kuM0GWcXHOrArhuP0RwW+MAkfryS554rd481
         pVHAODnnQPb3monKtpNVUmgfi4ac1vd/AyzDtKJizUu2rJUBbK6r93aIabdmOq0Pofbm
         Gv6fMF1mpXk8W2CpZAndxMYDktfuvK9k8k7jnKflHUEfQ3klQ5sesXyx8YQiUEmoBFBk
         JsdsrCQEpS4urvayr/gow9sQ6bNO+FfxnaGUHb1RrZrrRb3/VOHhfC8wC4ovnsF9HwT/
         cEsMUyRXZI1Bum9wmTq/zMuN9Nq0MCls1jcX4n+Eijp7vKkJkS/LyHm18CxEoHZTU149
         Ab7g==
X-Gm-Message-State: AOJu0Yxp2fqdZENWDpXDKABTJocuPgpfcTMJVss7SJpYPliokIm6oFlV
	j1hLFiEIurrROs+8Ga/AQCIAiW5HGi9m4tSPkC/WAlQt0rBiWU3fZKl/
X-Gm-Gg: AfdE7ck4yhSyznB3vok+yKlhUmTc45EpT3P0CPkW4t5PkfKfEHXoQDM1esJ9OUpDSCm
	JuzWKAGQHbVfkpiOYRdEzxs3XVZyDKV2c0v+GGAoHVNAzwOkBIJnzuehd1xKA1VT+XrtRudDpjg
	Z2FDdCOdW9z4hZJVnLjEmq9D0+0ibU4QUa3rI8HgrejG7vkBFgXhx0e3bz/VUqgcqmql7H0Zg56
	2Mneih8PmwjRGWa+6qyqwKoX/LLLwhZERCwDxobc0gsRbHdLJ/r91jlpkDza2f5w4F4RhLatqUa
	ukVvjzdKLdcU3j5YkxkCD1vPhwmywGC+ARobPSnyRb3BEO/bFF2TTlfJjjfoRYaV17vIeCUSwPo
	j6+xAKGNZmMdIJMhbmUJcJZ4ROfkK40la4EwT5Oiy4ajMKsvNYyqFzmAjcLJ6au9nh07INp3Aw3
	+d/Bx7YEO3G6pPOeUs0Py6WAobE1vXZcQPpUwxg225qGmKaA8=
X-Received: by 2002:a05:6a21:7117:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3c389ced5b6mr1505035637.15.1784170337373;
        Wed, 15 Jul 2026 19:52:17 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e545bb7sm5070161eec.3.2026.07.15.19.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:52:16 -0700 (PDT)
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
Subject: [PATCH net v6] tipc: serialize udp bearer replicast list updates
Date: Wed, 15 Jul 2026 19:52:04 -0700
Message-ID: <20260716025203.9332-2-bestswngs@gmail.com>
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
v6:
 - Add the missing kernel-doc for udp_bearer::disabled to fix a W=1 build
   warning reported by the kernel test robot.
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

 net/tipc/udp_media.c | 56 +++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 62ae7f5b5..230645cc0 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -94,6 +94,8 @@ struct udp_replicast {
  * @ifindex:	local address scope
  * @work:	used to schedule deferred work on a bearer
  * @rcast:	associated udp_replicast container
+ * @rcast_lock:	serialize updates to @rcast.list against concurrent updaters
+ * @disabled:	bearer is being torn down; reject further @rcast.list additions
  */
 struct udp_bearer {
 	struct tipc_bearer __rcu *bearer;
@@ -101,6 +103,8 @@ struct udp_bearer {
 	u32 ifindex;
 	struct work_struct work;
 	struct udp_replicast rcast;
+	spinlock_t rcast_lock;
+	bool disabled;
 };
 
 static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr)
@@ -278,26 +282,6 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
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
@@ -308,16 +292,34 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
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
@@ -325,8 +327,6 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 	else if (ntohs(addr->proto) == ETH_P_IPV6)
 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
 #endif
-	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
-	list_add_rcu(&rcast->list, &ub->rcast.list);
 	return 0;
 }
 
@@ -361,9 +361,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (likely(tipc_udp_is_known_peer(b, &src)))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &src);
 }
 
@@ -644,9 +641,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr)
 		return -EINVAL;
 	}
 
-	if (tipc_udp_is_known_peer(b, &addr))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &addr);
 }
 
@@ -679,6 +673,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ub->rcast.list);
+	spin_lock_init(&ub->rcast_lock);
 
 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
 		goto err;
@@ -819,10 +814,13 @@ static void cleanup_bearer(struct work_struct *work)
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

