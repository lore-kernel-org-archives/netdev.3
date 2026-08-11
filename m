Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0E42AFA2
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442173; cv=none; b=CcD3t5iNw3UyLwN1YHhl47orBv5w5J5pwhyTL7DPPfdXoiiWT7FCobFvEU/pwEX2MK2RttM0bxqCn06TAcS1WBHkoQI3hpzLlbm2JVoBqmL02qMsbgvoX9WQGWzQZTJp/mHjG57+3MMLed+K7Ha7g/+C2RjslMVkLIKGi0O5kRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442173; c=relaxed/simple;
	bh=zggKtK5yYWVgYA5DZzx+kUTS+RZEO7vI5YePeb1QVmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjM5eDKm44/n7ZvqHE94lvnECVqaB49hOnVgOqwPbrvhyaWgHu8jEjjCwQ9XzR3+FG+42IXwyCFPi10GVwkZXaHFFPqSS9S/zzoVgU2ZJ35HCTgRpYUJiH4RJCvROXs5Rvk/5FFCaqlia6qGqof7TZTNzE8cvRd7D0N3NZPG6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFzL1sv9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFzL1sv9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso9612325ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786442171; x=1787046971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwPl40+42wgB3C4y/wXWrILqHaDz1e/NIBkiDJbFEVA=;
        b=CFzL1sv9BN0hwycIUFtkPputH1j8V2DnIMrDhwSy8VdBBl21ow64sUhTU64HtIpdYs
         YpW7SRxyc/jiLu69J08nJ9HZq8PsrKJiLPKGqQu1jhGcUtw84TNxHCH869mdJFelxgmu
         64RJUlBXoeBFvWCVmcL1GNsXlWLfOgjyD4EZ2v9323ZcLfNs0w1hkYDxlg9rAieY+ZTL
         nL+2AwVnMS1q/T8bB9dPpucGy9S4KDvFZbAjq7Wit3ylzYnnIHx7yXriY7s3tNR64t3s
         bNZEXRsvkVvHmDDqxs2JTIWoFLu4xjNTBBY42haDODDetyYGi1iJAJskEdGykmaFtrjb
         Lhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786442171; x=1787046971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwPl40+42wgB3C4y/wXWrILqHaDz1e/NIBkiDJbFEVA=;
        b=Nnp/4xNH7Q8EVj1Ob+ogGWrRxluXmj/0S6a5v9Tpof18fJ2MR/XT0E1S7/ZzQsTKR0
         K1xur9fbIm21gC8KZOv135ppm6ALvtWXwS+vqa/E5bzENKVxAUaDwJBJ6luZN8qbdnNl
         yuyQjYwBQqzSeucI2ywwh7ZpgFrKLTDVjAzvU4oUhLfijILYJ7IQOpbXq4e4LCEEBTeR
         wqWckeGd4jUVZH95DC5EiKvC/YJp2G/xDAeHFtTbOSRT4LeLPUfm3avCi8KkjQLBSC/h
         k3o9OrFcWj1NeKzRVnnhNF/4ud8Eig5TpfQyUiHtldpNxSWKlyPNJzT5xdagYojIkY7W
         S0Gw==
X-Forwarded-Encrypted: i=1; AHgh+RoJSmnqXmKu3OJSrweCHYpef41edBx/qBUM6gQMMCXdjTCIk+VqX/KOkB91KlpP+6ntzM60aGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ij2x2Hka1Inl26L5GIHfkfvXPVEO7ndsZ2uoZchc/a9qbEmk
	Soow9KitzHTiYPldm5+VPcen0d5W6oXicETpLgvcy32aLd37REDML2Jj
X-Gm-Gg: AR+sD11Bxn8Bt2T1qqU2MGoHdavUjSh/VX5z/q1l5B3mMVTMghpphFlEzqjUpdlh2G9
	qerc0KrQLso27P/2D0wPhw7YSSnOhshzf6Kmb22WKzMX4t44O2xyFwVDA56z6T03BsDndrC/KZt
	yjvdfRMCrfMAVd+K+bEcfM+rtNVOhsS9vvYyh/chTIJSHRVmHpJ7xQOGdOAYJFPzFHOM5v3BZcS
	v82FUHQk1GA/AKnz+0vzvJfUIVf0drc6BVDPUtCsA8NqGOWOSk/RlL0YrDy7PdKRUIPegQRw7Et
	9SJZvWY17S5dmwltLg5tIHpOKzMFuH6P+fPieSJIzYH0l4a19B3U9OUcteRe+u72/bgeMObqUi9
	dKytKZxdUCtByPycL3EnnyPP6e3XhK0nK+pje3Gu+6gKmTcVtKdaDaZGYbO+hDHijHhfqMHl/lg
	TgJPXEOVIP+wwtwRnA5aff0NwCK89+khxDvQAlcLCLwNadijeAepnqnk4ehhk3pZnYAQS6oP2sY
	8pf2ccPsdj/Zd43ska4zZpGPdQJTU6oXsVzVo+Ptrbhh/cvq9D7fKM=
X-Received: by 2002:a17:902:d58e:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2d319142b8dmr9091855ad.10.1786442170910;
        Tue, 11 Aug 2026 02:56:10 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.244.59.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3160f3573sm4927545ad.60.2026.08.11.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:56:10 -0700 (PDT)
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
Subject: [PATCH net v5 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Tue, 11 Aug 2026 17:55:57 +0800
Message-ID: <3085b885bb348a9245c5c84364fea903d9942863.1786441097.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786441097.git.xuyuqiabc@gmail.com>
References: <cover.1786441097.git.xuyuqiabc@gmail.com>
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

