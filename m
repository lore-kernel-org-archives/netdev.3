Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E441A794
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528813; cv=none; b=WEKRKd3hLg/wP+ez/FVB/qJ0DwY/nXRCe9IikNYZA+AYWd5EZDuYd7gfhpJ4gxRBuv4GxQqgbGWuQD8IjzZ34ahD100o16Wi3uYUe5p1N+uTvvm/CKcaG60fqk14ZXSEvPmhx43rSGVpCZ65ogL2QMBD6ZDWopIE+JNMYoGUNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528813; c=relaxed/simple;
	bh=48VkiM3yolupwQoGy3OxTEzQiEK6PAdUZubu0HK4igk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdUmIyAoOLG3mEUsmcRFbOfpS2j4bKc6pNsc3cBqIE9iMc8qh+qUC+yNbeW8Frv8bK9XX1ZX8e6dunnnOXgdKXLb1n7plObxNuV9WAJwbKl/XnvM4D5KeAnEjQSEHXmhi8lioKauypm105YNKQDSnV9bW58E6AA0Fx6gGQunyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz6Nbedc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz6Nbedc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf52d15d88so7881435ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786528810; x=1787133610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuKznr0xzckX77BLpbc5mS7QwOIR+PoaHZtK4gAI/n4=;
        b=Kz6NbedcO626ddnMVW9KxWeJrAaQvjuPJVFq3/WB7Da+Tz0vbhDxZF/Mj3bTrzy1jd
         1yH/ka67Yd3fEv9XV3mSt3x3Ww5JR7wtfOuT/gzmEUTPvv7JhmLtCXRGzvX1V8LmiLOq
         S4H9L/etqH6RUr1+Tf718eAxAl+FbOSROd7JZOr/7w7pXtDXuQ/nmKv4IyFzCdOhw9ZO
         0pii4EfW/xWxjzy9oDZ3KBfXCkR3/pTX3kQoEtZ8e+e6qaE3aJKo72OlIYSWZiYcj6D/
         kcGF2Dnd0izzixerOuczQrhXCMUhsl4SFyw+2zhU3/ggRrz/2f6J/qbDvvFNYZ/2B0g6
         V9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528810; x=1787133610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuKznr0xzckX77BLpbc5mS7QwOIR+PoaHZtK4gAI/n4=;
        b=R3njLXKMq57ORf9XOaLReZVSSAWbjxAZ4iHAWXFYDAAtwRHEWc3K/fCZ3ujAhJGx6I
         TQG0yj2/kdMOTJ7XkAp6/3YILAFdQLRV8XjNkH26K5W/LjBu4GZKWwAR/gI1LLoDe3ff
         6lFu4qW40udqudgOKLV2o5y+ChBrhFEKXfPzMNmMLcg4OiQb+UoejQc2BO+zDADuLuFF
         B5cUvjINr41zv++LnLMlY0eYg6jcvKSD8lb25XvISE291BmlIrtajvnAZB16s9QBnt5O
         N40r5UKXix1PPRzeDcIzSUOAHK+2uqnUMXos5KGGh6ppj27BNoR8ZwGLa5guJPc6PDqM
         +Ucw==
X-Forwarded-Encrypted: i=1; AHgh+RpQ+6z3uXMezAHu/fxVsi5iR347M8RK59+ABI/fq274puvL2a7F4tlfOEAbqg5IlyRWpmrM0KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOrI8jdkDImzyD7UKTSbl7CBDVZZsCIuXf1yoa8vgPcXkZrsn
	zg9ezF0Fo3OGipjd5LS1687ehBj0pCNpfI9wwajBf6OF/MSFuKvhEjwy
X-Gm-Gg: AR+sD13Wc8Lrw2VhmHzXopEusWPkaxkbUDtNGlW0wUhlrIP+Hdrxab8Mo7XZTXMKU8W
	rwaEalXCpLqo0CndwARN53jwL7GP8x1MtV9+4FEfXy2uzng1Oar8NuLvRIiLr3WKWz36D9YN0tl
	ql01rXz+PFP1eMnr6g/1ERf7ygIuPZE4Xb+6SEzHAAYbS6S62/dLY1A0Uv8UghnQM9OTL99aG5c
	NhaNTcJZy7wjcDt+FGVvkEJl6AMQQmB4JQT5hkRjqm02mkE0fYSK35LiIoTnQjN+euPQsCUvyUJ
	54W+zeyd3JhJG6U/pHEkM7e50dPkD8+SB3g2qURpkW/RqL1uPMvvq9UQPAnXMwetPO4vA9qyMW5
	NkSSv7gNPaLRsOE2MaiIHrI7uri8A17W0sUiSlGurk+RTqbOAoFAy5QOl49iVoLq+jKjotT6k5c
	htVb4uXffcSVlAV2SkEuM2aV61CHA8AMBsPwFcdyW77isdB7ezYOWkvdYFLbzK1nn8+Qkpms+VE
	/ATgNHvZxwvlmnScS2HHQ+9iUBVV7v3ELLvLGhZHXiVga5igA==
X-Received: by 2002:a17:903:3d0f:b0:2ca:6514:9201 with SMTP id d9443c01a7336-2d34562999dmr46634035ad.15.1786528809249;
        Wed, 12 Aug 2026 03:00:09 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.244.59.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3511510bfsm4069215ad.30.2026.08.12.03.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:00:08 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yi-Hung Wei <yihung.wei@gmail.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Nan Li <tonanli66@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net v6 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Wed, 12 Aug 2026 17:59:56 +0800
Message-ID: <a265fa4d69ec48176312f98381f8bb43347fcff1.1786506548.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786506548.git.xuyuqiabc@gmail.com>
References: <cover.1786506548.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet processing uses CT limit state under RCU, while netns teardown
frees that state under ovs_mutex. The CT limit pointer was neither removed
from readers nor protected by a grace period, allowing packet processing to
dereference the freed state.

An unprivileged user can trigger this bug from a user and network
namespace, causing a slab-use-after-free in ovs_ct_execute() when the
netns is torn down.

Publish the CT limit pointer through RCU, remove it before teardown, and
wait for readers before freeing its contents. Keep ovs_mutex around
individual CT limit updates, and use the RCU read-side lock while GET
traverses the RCU-protected limit lists.

The netlink command handlers do not need NULL checks because the userspace
netlink socket holds an active reference to its network namespace while a
request is processed. The per-netns exit path therefore cannot run
concurrently with SET, DEL, or GET for that socket's namespace.

The teardown path currently waits for the RCU grace period while holding
ovs_mutex. Moving synchronize_rcu() outside the mutex would require
restructuring the teardown path and is left for a separate change.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
Assisted-by: Codex:GPT-5.4
Co-developed-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
Changes in v6:

- Explain why netlink command handlers do not need NULL checks.
- Document that teardown currently waits for the RCU grace period while
  holding ovs_mutex, leaving lock-scope optimization for a separate change.
- v5 Link: https://lore.kernel.org/all/cover.1786441097.git.xuyuqiabc@gmail.com/

Changes in v5:

- Remove unreachable command-path NULL handling because netlink sockets
  keep their network namespaces alive while requests are processed.
- Restore the previous SET, DEL, and GET command semantics.
- Document the ct_limit_info RCU and ovs_mutex locking contract.
- v4 Link: https://lore.kernel.org/all/cover.1785908366.git.xuyuqiabc@gmail.com/

Changes in v4:

- Restore per-entry ovs_mutex locking for CT limit SET and DEL.
- Treat CT limit updates racing with netns teardown as successful no-ops.
- Free an uninstalled CT limit allocation and document GET helpers' RCU
  contract.
- v3 Link: https://lore.kernel.org/all/cover.1784866791.git.xuyuqiabc@gmail.com/

Changes in v3:

- Use RCU dereference and a NULL check for CT limit GET requests.
- Limit ovs_mutex to CT limit updates; do not hold it while preparing replies.
- Use ovsl_dereference() for update paths and clarify the RCU grace-period
  comment.
- v2 Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com

Changes in v2:

- Sort local declarations modified by this patch in reverse
  Christmas-tree order.
- v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/

 net/openvswitch/conntrack.c | 87 +++++++++++++++++++++----------------
 net/openvswitch/datapath.h  |  6 ++-
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e6..cc6ea4014c16 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -933,10 +933,14 @@ static int ovs_ct_check_limit(struct net *net,
 			      const struct ovs_conntrack_info *info)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	const struct ovs_ct_limit_info *ct_limit_info;
 	u32 per_zone_limit, connections;
 	u32 conncount_key;
 
+	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
+	if (!ct_limit_info)
+		return 0;
+
 	conncount_key = info->zone.id;
 
 	per_zone_limit = ct_limit_get(ct_limit_info, info->zone.id);
@@ -1585,40 +1589,47 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 static int ovs_ct_limit_init(struct net *net, struct ovs_net *ovs_net)
 {
+	struct ovs_ct_limit_info *info;
 	int i, err;
 
-	ovs_net->ct_limit_info = kmalloc_obj(*ovs_net->ct_limit_info);
-	if (!ovs_net->ct_limit_info)
+	info = kmalloc_obj(*info);
+	if (!info)
 		return -ENOMEM;
 
-	ovs_net->ct_limit_info->default_limit = OVS_CT_LIMIT_DEFAULT;
-	ovs_net->ct_limit_info->limits =
+	info->default_limit = OVS_CT_LIMIT_DEFAULT;
+	info->limits =
 		kmalloc_objs(struct hlist_head, CT_LIMIT_HASH_BUCKETS);
-	if (!ovs_net->ct_limit_info->limits) {
-		kfree(ovs_net->ct_limit_info);
+	if (!info->limits) {
+		kfree(info);
 		return -ENOMEM;
 	}
 
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; i++)
-		INIT_HLIST_HEAD(&ovs_net->ct_limit_info->limits[i]);
+		INIT_HLIST_HEAD(&info->limits[i]);
 
-	ovs_net->ct_limit_info->data = nf_conncount_init(net, sizeof(u32));
+	info->data = nf_conncount_init(net, sizeof(u32));
 
-	if (IS_ERR(ovs_net->ct_limit_info->data)) {
-		err = PTR_ERR(ovs_net->ct_limit_info->data);
-		kfree(ovs_net->ct_limit_info->limits);
-		kfree(ovs_net->ct_limit_info);
+	if (IS_ERR(info->data)) {
+		err = PTR_ERR(info->data);
+		kfree(info->limits);
+		kfree(info);
 		pr_err("openvswitch: failed to init nf_conncount %d\n", err);
 		return err;
 	}
+	rcu_assign_pointer(ovs_net->ct_limit_info, info);
 	return 0;
 }
 
 static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 {
-	const struct ovs_ct_limit_info *info = ovs_net->ct_limit_info;
+	const struct ovs_ct_limit_info *info;
 	int i;
 
+	info = rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
+				   lockdep_ovsl_is_held());
+	/* Wait for RCU readers to stop using the CT limits. */
+	synchronize_rcu();
+
 	nf_conncount_destroy(net, info->data);
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
@@ -1665,12 +1676,13 @@ static bool check_zone_id(int zone_id, u16 *pzone)
 	return false;
 }
 
-static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
-				       struct ovs_ct_limit_info *info)
+static int ovs_ct_limit_set_zone_limit(struct ovs_net *ovs_net,
+				       struct nlattr *nla_zone_limit)
 {
 	struct ovs_zone_limit *zone_limit;
-	int rem;
+	struct ovs_ct_limit_info *info;
 	u16 zone;
+	int rem;
 
 	rem = NLA_ALIGN(nla_len(nla_zone_limit));
 	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
@@ -1679,6 +1691,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = zone_limit->limit;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1695,6 +1708,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->limit = zone_limit->limit;
 
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_set(info, ct_limit);
 			ovs_unlock();
 		}
@@ -1709,12 +1723,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 	return 0;
 }
 
-static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
-				       struct ovs_ct_limit_info *info)
+static int ovs_ct_limit_del_zone_limit(struct ovs_net *ovs_net,
+				       struct nlattr *nla_zone_limit)
 {
 	struct ovs_zone_limit *zone_limit;
-	int rem;
+	struct ovs_ct_limit_info *info;
 	u16 zone;
+	int rem;
 
 	rem = NLA_ALIGN(nla_len(nla_zone_limit));
 	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
@@ -1723,6 +1738,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = OVS_CT_LIMIT_DEFAULT;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1730,6 +1746,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_del(info, zone);
 			ovs_unlock();
 		}
@@ -1773,6 +1790,7 @@ static int __ovs_ct_limit_get_zone_limit(struct net *net,
 	return nla_put_nohdr(reply, sizeof(zone_limit), &zone_limit);
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_zone_limit(struct net *net,
 				       struct nlattr *nla_zone_limit,
 				       struct ovs_ct_limit_info *info,
@@ -1796,12 +1814,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 							&zone))) {
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
-			rcu_read_lock();
 			limit = ct_limit_get(info, zone);
 
 			err = __ovs_ct_limit_get_zone_limit(
 				net, info->data, zone, limit, reply);
-			rcu_read_unlock();
 			if (err)
 				return err;
 		}
@@ -1816,6 +1832,7 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 	return 0;
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 					   struct ovs_ct_limit_info *info,
 					   struct sk_buff *reply)
@@ -1828,19 +1845,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 	if (err)
 		return err;
 
-	rcu_read_lock();
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		head = &info->limits[i];
 		hlist_for_each_entry_rcu(ct_limit, head, hlist_node) {
 			err = __ovs_ct_limit_get_zone_limit(net, info->data,
 				ct_limit->zone, ct_limit->limit, reply);
 			if (err)
-				goto exit_err;
+				return err;
 		}
 	}
 
-exit_err:
-	rcu_read_unlock();
 	return err;
 }
 
@@ -1850,7 +1864,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -1863,8 +1876,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_set_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1884,7 +1897,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -1897,8 +1909,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_del_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1918,7 +1930,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -1932,18 +1944,19 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
+	rcu_read_lock();
+	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
 	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
 		err = ovs_ct_limit_get_zone_limit(
 			net, a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT], ct_limit_info,
 			reply);
-		if (err)
-			goto exit_err;
 	} else {
 		err = ovs_ct_limit_get_all_zone_limit(net, ct_limit_info,
 						      reply);
-		if (err)
-			goto exit_err;
 	}
+	rcu_read_unlock();
+	if (err)
+		goto exit_err;
 
 	nla_nest_end(reply, nla_reply);
 	genlmsg_end(reply, ovs_reply_header);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 696640e88fa7..06c6956fb1dc 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -164,7 +164,9 @@ struct dp_upcall_info {
  * Protected by genl_mutex.
  * @dp_notify_work: A work notifier to handle port unregistering.
  * @masks_rebalance: A work to periodically optimize flow table caches.
- * @ct_limit_info: A hash table of conntrack zone connection limits.
+ * @ct_limit_info: Hash table of conntrack zone connection limits. Protected
+ * by RCU; updates and teardown are serialized by ovs_mutex. May be NULL during
+ * netns teardown.
  * @xt_label: Whether connlables are configured for the network or not.
  */
 struct ovs_net {
@@ -172,7 +174,7 @@ struct ovs_net {
 	struct work_struct dp_notify_work;
 	struct delayed_work masks_rebalance;
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	struct ovs_ct_limit_info *ct_limit_info;
+	struct ovs_ct_limit_info __rcu *ct_limit_info;
 #endif
 	bool xt_label;
 };
-- 
2.54.0

