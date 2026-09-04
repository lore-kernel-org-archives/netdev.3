Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E31BC2A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482672; cv=none; b=K05nZjGKQjnBznpSBd2ZIfM64VwiNanRsBTdpy9O/ni5XbD7YnUiAUEB3n0Q/8UnJ8M/uZ0W+7i8AV3IAyKwFuztpcC2iwxCWKx6iZ7Q70LJAUXkvTl/IjEiJH8A2D/SX1ia9DLPF4pXpd4oWkEUFl5xCvIlhKUalKb2pyOTcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482672; c=relaxed/simple;
	bh=scSDE6U+ARfKkP3jrjDGqSU/J0JJjMI6jYdZTssdghs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NTIT7gb6is4gdyELGgSkk1IIuGAab3YzKU4P9CK3SUfvlDSpwttREyxYRB/rk7jtnmwOa/griIpmAtkqvFrhTeUka8krWQF8Y60l+3P5NYs0ACWLN+a9pNVLmLgRGx9UQOuHaqXmsJTg+KGqXRrVyKZGH3MYubB4iaEJ8fBh6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3iT03tX; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3iT03tX"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so80112985a.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482670; x=1789087470; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SyYwGGSxLplBTP4mKyue4XIrl9SDKcTjsAA86jRAHRk=;
        b=V3iT03tXPeaaJDPE2/pB5yShdiiDh8xs82CU9a44bd1TUq5reCiKt3oJtnJ8ktLvG8
         cRPa4HX4r8CS/MsEBeSNv5OL7Q2UKFtQkBgMJhzT9XUeNZOyf5HYAYo9qU7AYSjy/How
         uZ+7ByOIC/GixBvYa+rvnIl9MeOYWD62enjtek4elSGVhQn8mHOWI8JSVros8kn8ipgW
         juw1jqBVVPNyUAD4O+ZFsHwl+rf1RkeLv7xJMq6VLd9LMwVJP+gAujwNm6WJgLxFFaF4
         v89Mw4Oz9dr6bw/FAdpb9rGPhzDFQMx7121KxnfWxhOhyO0Z5tmAHEsgcgvjYPoRCwqZ
         +jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482670; x=1789087470;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyYwGGSxLplBTP4mKyue4XIrl9SDKcTjsAA86jRAHRk=;
        b=aXNIo7YK6kmrgOxR8WnCi6Bzya0n3Gr7gtOf9Bc2wGPZmFQpgarcVgFBsPRoxgn7N5
         Y1WA07myDPHW7ea4aMMgtT4k9G4+OOEZtZsJmyFxmn4UR0MrwIApEqC1yNFh0TfPf1oB
         j+CwsvseHdYZFna/A78/Z51YKb188t5+G74pKQ7CtiZJDGnziY3w2kkfUF9vdJPMDHZJ
         EA+VS2ucCZFrym3nFO5/u74+r/A1+E4RiJOZZ0q3kFvzLWykZWJTeBIC0z5lWL3TBfHx
         HoLvJG879VDD39Len0RuFx8utfxP7xbLEsUE0CNB3LpR/8OMFN4tyB9aClEnxg3QwJPJ
         eNiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxazNsnt7X9z/hzd9re6TrNPsYYWHfJG//SA0wYpWo++7GbbXQDRlLFce6BiTpdg13OyIlEiYc=@vger.kernel.org
X-Gm-Message-State: AFuF++l4yglB8sOxNcSWhk3OQFuMvvHEAs5+WOirwigqcivFwQRujjZA
	qAGMQ4ASbmLIt8trvUdb78OS5kWDrj1OdXPLsv4gOpUNkBFIGpairgy19IFyoidpAnMNsnuu08c
	XkwZE/hpGiArExg==
X-Received: from qkf24.prod.google.com ([2002:a05:620a:a218:b0:934:a97a:8f13])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3c13:b0:939:69a:4764 with SMTP id af79cd13be357-939804a4503mr183121885a.39.1788482669748;
 Thu, 03 Sep 2026 17:44:29 -0700 (PDT)
Date: Fri,  4 Sep 2026 00:44:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904004428.1933068-1-edumazet@google.com>
Subject: [PATCH net] net: bridge: dynamically allocate frame_type instances
 for CFM and MRP
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

struct br_frame_type contains an embedded struct hlist_node list, which
is linked into a bridge's per-instance br->frame_type_list via
br_add_frame(br, ft).

Both cfm_frame_type and mrp_frame_type were declared as static global
variables. When multiple bridge devices enable CFM MEPs or MRP instances
concurrently (e.g. across different network namespaces), they share
the same static global br_frame_type node.

Calling br_add_frame() on a second bridge links the same hlist_node into
the second bridge's frame_type_list, corrupting the first bridge's list.
Later, when br_del_frame() deletes the node from one bridge and poisons
its list pointers, a subsequent teardown on another bridge walks its
frame_type_list and dereferences the poisoned pointer in hlist_del_rcu(),
triggering a general protection fault.

Furthermore, sharing or embedding fixed br_frame_type instances leads to
RCU node reuse violations: if MEPs or MRP instances are repeatedly added
and deleted, hlist_del_rcu() unlinks the node without waiting for an RCU
grace period, and a subsequent addition immediately re-inserts and modifies
the node while concurrent lockless readers in br_handle_frame() /
br_process_frame_type() may still be traversing it.

Fix this by dynamically allocating struct br_frame_type upon registration
in br_add_frame() and freeing it with kfree_rcu() in br_del_frame(). Also
ensure all registered frame types are cleaned up during bridge deletion via
br_del_frame_all().

Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Reported-by: syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a9a137f.9266084e.bf0d7.02e3.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
--
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_cfm.c     | 17 +++++++++--------
 net/bridge/br_if.c      |  2 ++
 net/bridge/br_input.c   | 40 +++++++++++++++++++++++++++++++++++-----
 net/bridge/br_mrp.c     | 16 +++++++---------
 net/bridge/br_private.h |  8 ++++++--
 5 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index dea56fffa1c19fab589bc5ec799cdea5d35dd791..579024858829886a2f22001a51c1740eb23b27d9 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 	return 1;
 }
 
-static struct br_frame_type cfm_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_CFM),
-	.frame_handler = br_cfm_frame_rx,
-};
-
 int br_cfm_mep_create(struct net_bridge *br,
 		      const u32 instance,
 		      struct br_cfm_mep_create *const create,
@@ -501,6 +496,7 @@ int br_cfm_mep_create(struct net_bridge *br,
 {
 	struct net_bridge_port *p;
 	struct br_cfm_mep *mep;
+	int err;
 
 	ASSERT_RTNL();
 
@@ -558,8 +554,13 @@ int br_cfm_mep_create(struct net_bridge *br,
 	INIT_HLIST_HEAD(&mep->peer_mep_list);
 	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
 
-	if (hlist_empty(&br->mep_list))
-		br_add_frame(br, &cfm_frame_type);
+	if (hlist_empty(&br->mep_list)) {
+		err = br_add_frame(br, cpu_to_be16(ETH_P_CFM), br_cfm_frame_rx);
+		if (err) {
+			kfree(mep);
+			return err;
+		}
+	}
 
 	hlist_add_tail_rcu(&mep->head, &br->mep_list);
 
@@ -588,7 +589,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 	kfree_rcu(mep, rcu);
 
 	if (hlist_empty(&br->mep_list))
-		br_del_frame(br, &cfm_frame_type);
+		br_del_frame(br, cpu_to_be16(ETH_P_CFM));
 }
 
 int br_cfm_mep_delete(struct net_bridge *br,
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f886cbe832e499195d40f0a16908870..fe8e9a47e1ac106dd611eb96a25a216d0b5bc2d5 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -397,6 +397,8 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 	timer_shutdown_sync(&br->tcn_timer);
 	cancel_delayed_work_sync(&br->gc_work);
 
+	br_del_frame_all(br);
+
 	br_sysfs_delbr(br->dev);
 	unregister_netdevice_queue(br->dev, head);
 }
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index d87a5f9fa92b70d06d0f47cb884c72baf253ed0e..07efd0fbcf9cd5357a83de22338c3dca94623ee1 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -468,18 +468,48 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 	return br_handle_frame;
 }
 
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft)
+int br_add_frame(struct net_bridge *br, __be16 type,
+		 int (*frame_handler)(struct net_bridge_port *port,
+				      struct sk_buff *skb))
 {
+	struct br_frame_type *ft;
+
+	hlist_for_each_entry(ft, &br->frame_type_list, list) {
+		if (ft->type == type)
+			return -EEXIST;
+	}
+
+	ft = kmalloc_obj(*ft);
+	if (!ft)
+		return -ENOMEM;
+
+	ft->type = type;
+	ft->frame_handler = frame_handler;
 	hlist_add_head_rcu(&ft->list, &br->frame_type_list);
+
+	return 0;
 }
 
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft)
+void br_del_frame(struct net_bridge *br, __be16 type)
 {
-	struct br_frame_type *tmp;
+	struct br_frame_type *ft;
 
-	hlist_for_each_entry(tmp, &br->frame_type_list, list)
-		if (ft == tmp) {
+	hlist_for_each_entry(ft, &br->frame_type_list, list) {
+		if (ft->type == type) {
 			hlist_del_rcu(&ft->list);
+			kfree_rcu(ft, rcu);
 			return;
 		}
+	}
+}
+
+void br_del_frame_all(struct net_bridge *br)
+{
+	struct br_frame_type *ft;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(ft, n, &br->frame_type_list, list) {
+		hlist_del_rcu(&ft->list);
+		kfree_rcu(ft, rcu);
+	}
 }
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index ef16d07039241a76dde0a0923030024bba2c1c33..511ae8af3d03395beac450f74def5e908feaa4c7 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -8,11 +8,6 @@ static const u8 mrp_in_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 };
 
 static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
 
-static struct br_frame_type mrp_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_MRP),
-	.frame_handler = br_mrp_process,
-};
-
 static bool br_mrp_is_ring_port(struct net_bridge_port *p_port,
 				struct net_bridge_port *s_port,
 				struct net_bridge_port *port)
@@ -486,7 +481,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 	kfree_rcu(mrp, rcu);
 
 	if (hlist_empty(&br->mrp_list))
-		br_del_frame(br, &mrp_frame_type);
+		br_del_frame(br, cpu_to_be16(ETH_P_MRP));
 }
 
 /* Adds a new MRP instance.
@@ -535,13 +530,16 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	spin_unlock_bh(&br->lock);
 	rcu_assign_pointer(mrp->s_port, p);
 
-	if (hlist_empty(&br->mrp_list))
-		br_add_frame(br, &mrp_frame_type);
-
 	INIT_DELAYED_WORK(&mrp->test_work, br_mrp_test_work_expired);
 	INIT_DELAYED_WORK(&mrp->in_test_work, br_mrp_in_test_work_expired);
 	hlist_add_tail_rcu(&mrp->list, &br->mrp_list);
 
+	if (hlist_is_singular_node(&mrp->list, &br->mrp_list)) {
+		err = br_add_frame(br, cpu_to_be16(ETH_P_MRP), br_mrp_process);
+		if (err)
+			goto delete_mrp;
+	}
+
 	err = br_mrp_switchdev_add(br, mrp);
 	if (err)
 		goto delete_mrp;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980d0682ceb33ed5d4554b9991b65d4..5163017feb74deed059c592128f6fdb8d2469bf8 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -937,10 +937,14 @@ struct br_frame_type {
 	int			(*frame_handler)(struct net_bridge_port *port,
 						 struct sk_buff *skb);
 	struct hlist_node	list;
+	struct rcu_head		rcu;
 };
 
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
+int br_add_frame(struct net_bridge *br, __be16 type,
+		 int (*frame_handler)(struct net_bridge_port *port,
+				      struct sk_buff *skb));
+void br_del_frame(struct net_bridge *br, __be16 type);
+void br_del_frame_all(struct net_bridge *br);
 
 static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
 {
-- 
2.55.0.979.g7e5102b832-goog

