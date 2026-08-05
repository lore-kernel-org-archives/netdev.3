Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24A426693
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947204; cv=none; b=dzFdDEQq8TXJ26lvP35rX+rfQdnR6MAMgAS16xUokLBfJ09avkpaUQTPI/jveEk04v8RkkdKl9kehoZJS9NRk1PIW5bLcMexWDCh3YQX8Y53y9bfJUddPGs5hNq6TVEpbrh1wfv+UW2bh2s7r6SHqjg1BugIVbjPfSJsBeZgCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947204; c=relaxed/simple;
	bh=q35q+LY150jSVHsFwjrnCG7oOAAXl4pRFS6xdakSuaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2OPUG/xraK30OyaYUMcZSiMS8wyzDq3QrP1E9usXlTCthrmWdfErvpEvfWdRMS4hSwVNvEGgFtXsGsgV7HRN0G30B8JfnRxThjh7phAywL1W0wT0NN5hIJk+923gZ7UyyIxloYLiE3Nr7M6cXa3ovGYu6ytzNQaJA2JyYFt8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkNabz+i; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkNabz+i"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1007043f8f.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785947201; x=1786552001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EABr6wCnu6l+kQ/YHeq0QtFK6yV81xCKsevivpwiuvQ=;
        b=SkNabz+idpLKorhsyXtVVbnmSYgkUmSu2vU35b96rIF3+Iv85eizVQ50G2p2f3Ie7N
         sseOqCpRajd34k8IjLFu3LOPRB0OPJJKpM/8Y4fkS9AbW+gGpjdi3jTW7/Fn4sA3W+ce
         XgL1cSg+Xvqby/zIOL/MqUjysiavPClhmMn56ONQi/LWG6QFGHG0Qi8SCj4Wr6R8tZ4Y
         kLVTMcUZni+79TrDbtrW6NpOVeIQ1QscQ0GIZY63HJZe6R/LdVRqaU9C8ZYxitR8t4P9
         tbk6uHdsRIc6IwwGg8eofuGMQ0TjbZDyTRQM63smIcKVzhB8Y5Ulrz0kERsdBjnTh7f1
         EKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947201; x=1786552001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EABr6wCnu6l+kQ/YHeq0QtFK6yV81xCKsevivpwiuvQ=;
        b=kCVuclbNawDBnkAbvavyJBBz7Z5eGmmcExD2Qg176Y1HvHdaf1fmNGU67zvSCAOy8X
         PcdtJwkhYlGX3qqjDN5n7fHPSWpc8khWKsi5q8pdz419oGLWCYmdUqn2dxCZ3R0zwBcw
         Rg0jgsR7hvAkvzEPl9Z6uiKGSxSUzqoSkVJUfoqw5K55zHqmf3g/p9JBfe3HtKxRTLW0
         lHDw52c0aC2cV7ayob0Ogxm/ACbv2gNy4LrzVWIxcW/BqrxLbE9eLEuJKHqMdI8g+EyC
         zLKc4IVDLeC22CQot5AWIBZj5qIUli9TUIrJOeYe3y72EFWwboGzqhD7LUNJOAj6upC4
         Xu9w==
X-Gm-Message-State: AOJu0YyO9+3IBtMU/WcNz4nj0EC9RHUFCFJg4roSzgqh17a4LwIWzD9X
	HkIhztIfD0oV3uoOWkKTJp7SJZq01/oDcu89xkmihL/IjNRzYIosm2fPrU7I8Bbrv1w=
X-Gm-Gg: AR+sD12hkX9gp/6+v/y6QUlFYQD+7+Ckr1ShX/OmyQvSynOJFF+GmiImDvnzJit9Doq
	zRYNI2WRLj6pFOETaPIyJpQU4jL2bcVl9puK5jF3bofBqSk/3LNcB3yt+lKt27kbiQA2Fo1WHxA
	7OZj58fagaoX/fp0+nUOhsb2Zkezr7p7QdWzYmUVEs6b8e99TEB0aU5eUp77r8sS3yb2XVFesDs
	e3K4zhsbQUv2fAG9YOukitThDicB51KZVGbAWG/QY+RJBGBMQRIEk/LaV56JghzuSx2EPT5KtDW
	xG0BahVFpO6KmA0mpsFHKOo51JHyaw3VEFgu6eA8bL0qHLQSlEWYFbi9itVb+lOzhz29ihpeHip
	8UosxrJAtCB9VYcal0Q+bODkHuaPU3dLZnm0HHQ0n64IBPdoyy9EOaKhfpQcH8zA7HS99LTz0mZ
	y5uVNC3ovaVAJo9R+lgpr/gkiOXCJkb4O1upRV9PNYzQP31DyfbtK6M5OK8+Nd0ku/MkyI2N+C1
	Sph+BiESfr8exL8ktnapg==
X-Received: by 2002:a5d:48c9:0:b0:47f:8f8f:db74 with SMTP id ffacd0b85a97d-47fec4fc37fmr10713241f8f.12.1785947200770;
        Wed, 05 Aug 2026 09:26:40 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([194.156.154.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23ede6sm11051703f8f.30.2026.08.05.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:26:40 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yihung.wei@gmail.com,
	pshelar@ovn.org,
	vega@nebusec.ai,
	tonanli66@gmail.com,
	xuyuqiabc@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net v4 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Thu,  6 Aug 2026 00:26:13 +0800
Message-ID: <07a1967fb56f2b38465cc5b611343827d636f77b.1785908366.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785908366.git.xuyuqiabc@gmail.com>
References: <cover.1785908366.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuqi Xu <xuyuqiabc@gmail.com>

Packet processing uses CT limit state under RCU, while netns teardown
frees that state under ovs_mutex. The CT limit pointer was neither removed
from readers nor protected by a grace period, allowing packet processing to
dereference the freed state.

An unprivileged user can trigger this bug from a user and network
namespace, causing a slab-use-after-free in ovs_ct_execute() when the
netns is torn down.

Replace the pointer before freeing the CT limit state, and wait for RCU
readers before freeing its contents. Keep ovs_mutex only around individual
CT limit updates, while GET uses the RCU read-side lock for the lifetime of
the lookup.

When netns teardown has already removed the CT limit state, SET and DEL
complete successfully without changing it. SET frees an allocation that
could not be installed because teardown won the race.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Co-developed-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
Changes in v4:

- Restore per-entry ovs_mutex locking for CT limit SET and DEL.
- Treat CT limit updates racing with netns teardown as successful no-ops.
- Free an uninstalled CT limit allocation and document GET helpers' RCU contract.
- v3 Link: https://lore.kernel.org/all/cover.1784866791.git.xuyuqiabc@gmail.com/

Changes in v3:

- Use RCU dereference and a NULL check for CT limit GET requests.
- Limit ovs_mutex to CT limit updates; do not hold it while preparing replies.
- Use ovsl_dereference() for update paths and clarify the RCU grace-period comment.
- v2 Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com

Changes in v2:

- Sort local declarations modified by this patch in reverse
  Christmas-tree order.
- v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/

 net/openvswitch/conntrack.c | 106 ++++++++++++++++++++++--------------
 net/openvswitch/datapath.h  |   2 +-
 2 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e6..5fe64bff254a 100644
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
@@ -1679,7 +1691,9 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
-			info->default_limit = zone_limit->limit;
+			info = ovsl_dereference(ovs_net->ct_limit_info);
+			if (likely(info))
+				info->default_limit = zone_limit->limit;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
 				zone_limit->zone_id, &zone))) {
@@ -1695,8 +1709,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->limit = zone_limit->limit;
 
 			ovs_lock();
-			ct_limit_set(info, ct_limit);
+			info = ovsl_dereference(ovs_net->ct_limit_info);
+			if (likely(info))
+				ct_limit_set(info, ct_limit);
 			ovs_unlock();
+
+			if (unlikely(!info))
+				kfree(ct_limit);
 		}
 		rem -= NLA_ALIGN(sizeof(*zone_limit));
 		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
@@ -1709,12 +1728,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
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
@@ -1723,14 +1743,18 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
-			info->default_limit = OVS_CT_LIMIT_DEFAULT;
+			info = ovsl_dereference(ovs_net->ct_limit_info);
+			if (likely(info))
+				info->default_limit = OVS_CT_LIMIT_DEFAULT;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
 				zone_limit->zone_id, &zone))) {
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
 			ovs_lock();
-			ct_limit_del(info, zone);
+			info = ovsl_dereference(ovs_net->ct_limit_info);
+			if (likely(info))
+				ct_limit_del(info, zone);
 			ovs_unlock();
 		}
 		rem -= NLA_ALIGN(sizeof(*zone_limit));
@@ -1773,6 +1797,7 @@ static int __ovs_ct_limit_get_zone_limit(struct net *net,
 	return nla_put_nohdr(reply, sizeof(zone_limit), &zone_limit);
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_zone_limit(struct net *net,
 				       struct nlattr *nla_zone_limit,
 				       struct ovs_ct_limit_info *info,
@@ -1796,12 +1821,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
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
@@ -1816,6 +1839,7 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 	return 0;
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 					   struct ovs_ct_limit_info *info,
 					   struct sk_buff *reply)
@@ -1828,19 +1852,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,
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
 
@@ -1850,7 +1871,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -1863,8 +1883,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_set_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1884,7 +1904,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -1897,8 +1916,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_del_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1918,7 +1937,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -1932,18 +1951,21 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
+	rcu_read_lock();
+	ct_limit_info = rcu_dereference(ovs_net->ct_limit_info);
+	if (!ct_limit_info) {
+		err = -ENOENT;
+	} else if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
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
index 696640e88fa7..93e11e468d17 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -172,7 +172,7 @@ struct ovs_net {
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
