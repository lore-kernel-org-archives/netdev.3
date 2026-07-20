Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82F23ED5B
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513692; cv=none; b=JnX1KJx6qLto2QdBAORtTlE5mJbHGKI1OzeR6CXtiRqKXlfb8tPrHohbr0Cc5t7CI+PCb8j42akY8/qZDOZ+s/zfDiRa6v0Tc1b0XeLB3ewSF1kxl+iqDOK4gF/bmtqM0987vAE8mbmpk+F6Y7e+6UWIOgzYsUiwQdrPrQkAKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513692; c=relaxed/simple;
	bh=ZuZksV0V0PWzVpQCCxfoO9j4j0XTp3brRaQBrBzi05c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eltAfjjD2BeTKjSAXxFkyEnvWjS08uQrQowTqwcFKgImBdT5z8RMRE0rWhnFXgKhD9yEOi7sNa1wYLPV1bhSNxrKav4swhixSj4bm1Z/nc0ZJyeCvLULykMiSE5YwdYDhc7b+d2kwxiJE9pTco1cxc9jTUt7CBKtt2ZhQ3cXfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efkjCokg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efkjCokg"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485ef63b68so9264342b3a.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 19:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784513690; x=1785118490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xuin/4iIlomllwvZ3BgFvtTQzDMeT1x4DbC0nERGOUo=;
        b=efkjCokgGOeqa1glfh0msZM6JxRzzBxnac6t5QJWhfhvHyN3OXkpgBlwPpXNdoexdr
         IedGmAC0wWggz0jesQRZYu5rH02e0XbdBOk02qPJCf3ChjNrgt3RTR9hI9K+cssn1v8f
         aBFNORYeX261ncmaTUjo/wzh4vq+280Qe/17U1wWVl7Qx964fwksSl2gNcRUi6YIGLT5
         le9DQ5JsfS7NIO0OayV4mf+YBbqOS3CutrxTsRuntWOSyohtfQ10Dly85ldfpOrWGEcD
         mdIdcBLiVbimg2CE8tfI9IjrZK9ltpIpSKvMeiUVoh0hlY3yC80fLYpAzQcL4xBuEmcw
         +ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784513690; x=1785118490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xuin/4iIlomllwvZ3BgFvtTQzDMeT1x4DbC0nERGOUo=;
        b=ZdHTb4EObsWPTHUhQHRrUkAmuHOH+/V7LDcAQ5aiDqpvwUgUZuo6JeHF5sd6wsfY+s
         C8ClD8ljzpddbQUZHjjALfavxUA3QYasyKYOnZRwR+cXObmyy/zmqvKc3P+aU4fWwhy4
         auuxAbHZRpBvSJPz5QRI0PZWPBkufGFLRQtidf1zzu6GT+Z2I67VOF3HzVsXPpA4fSnW
         Rl3g2R7yTzOUCI/xKOMtKgvcDCjG00mpTip35U+y+030aIt9dC2JOjFYvUNyFPC2z6XS
         eIJnvB6iQ/nGxitfmUgnNi38UPQCzIcxtVkwt/RDKn4+jtAae6So7P+r07SnuizMN3Jj
         gxhA==
X-Gm-Message-State: AOJu0YwiKIHtgHtxPiWY7QXFluuNkudvLUQUoEGY5FO88sgfj2NjyYsN
	rCzJTztSCQJismmIrQDqvBSMWOmkvMHfWZmw7IiZBThIX51VSdKE3ibS9xoIg8pI
X-Gm-Gg: AfdE7cn5loqFEJekHV6i/oAcLUT0ZttVnM1vqy+9hSQmr+RcTQbWm745yFJ2CnGH2va
	vIewqTEGEP0QHsQW7xOqGTo7JTF4jj8OdKGlVFYVuI7n24aWMo7lfvo4Z21lKDB1yXarRPLTGuY
	7g9iouAXYVZN2+Ri1AkD43eN8PaCCyEt7FqR+A0qfdU5akx5JDxrq/O9i4xvZFDsoGbSBz0S/5l
	kdVdGaIFWjaNS23RmzpgxpqDgPFzpf0aVskJqZI30qTyT55mbXD13SmQ93kthkQvM0y+yVk9lua
	f5o/BurWxxlRaC4iUadnYAyX/pocfFh71BUloIwLSHdo6wIrczMtEue4d5qn6a9pPQZahqNw9Z3
	YLwWdhq8TtXee2NgF2kty8VBIJBxaplNfMWOSp6niKRwhFMLPQTQSG15n1KshV2tk7OgeH4p5nv
	3d4n2ljXbn0lpIJyK0GOEb
X-Received: by 2002:a05:6a00:2304:b0:848:2cb2:cd97 with SMTP id d2e1a72fcca58-84c294f822amr11896594b3a.52.1784513690384;
        Sun, 19 Jul 2026 19:14:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc33easm4884919b3a.13.2026.07.19.19.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:14:49 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	pshelar@ovn.org,
	yihung.wei@gmail.com,
	vega@nebusec.ai,
	tonanli66@gmail.com,
	xuyuqiabc@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Mon, 20 Jul 2026 10:14:16 +0800
Message-ID: <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784355642.git.xuyuqiabc@gmail.com>
References: <cover.1784355642.git.xuyuqiabc@gmail.com>
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

Replace the pointer before freeing the CT limit state. Wait for in-flight
RCU readers before freeing its contents. Serialize CT limit netlink
operations with teardown for the full lifetime of their state accesses.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Co-developed-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/openvswitch/conntrack.c | 79 +++++++++++++++++++++++--------------
 net/openvswitch/datapath.h  |  2 +-
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e1..d5c47127a 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -932,11 +932,15 @@ static int ovs_ct_check_limit(struct net *net,
 			      const struct sk_buff *skb,
 			      const struct ovs_conntrack_info *info)
 {
+	const struct ovs_ct_limit_info *ct_limit_info;
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
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
+	/* ovs_ct_check_limit() accesses the info under the datapath RCU lock. */
+	synchronize_rcu();
+
 	nf_conncount_destroy(net, info->data);
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
@@ -1678,9 +1689,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 	while (rem >= sizeof(*zone_limit)) {
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
-			ovs_lock();
 			info->default_limit = zone_limit->limit;
-			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
 				zone_limit->zone_id, &zone))) {
 			OVS_NLERR(true, "zone id is out of range");
@@ -1694,9 +1703,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->zone = zone;
 			ct_limit->limit = zone_limit->limit;
 
-			ovs_lock();
 			ct_limit_set(info, ct_limit);
-			ovs_unlock();
 		}
 		rem -= NLA_ALIGN(sizeof(*zone_limit));
 		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
@@ -1722,16 +1729,12 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 	while (rem >= sizeof(*zone_limit)) {
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
-			ovs_lock();
 			info->default_limit = OVS_CT_LIMIT_DEFAULT;
-			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
 				zone_limit->zone_id, &zone))) {
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
-			ovs_lock();
 			ct_limit_del(info, zone);
-			ovs_unlock();
 		}
 		rem -= NLA_ALIGN(sizeof(*zone_limit));
 		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
@@ -1849,8 +1852,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
+	struct ovs_ct_limit_info *ct_limit_info;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -1863,16 +1866,22 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
+	ovs_lock();
+	ct_limit_info = rcu_dereference_protected(ovs_net->ct_limit_info,
+						  lockdep_ovsl_is_held());
 	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
 					  ct_limit_info);
 	if (err)
-		goto exit_err;
+		goto exit_unlock;
 
 	static_branch_enable(&ovs_ct_limit_enabled);
 
 	genlmsg_end(reply, ovs_reply_header);
+	ovs_unlock();
 	return genlmsg_reply(reply, info);
 
+exit_unlock:
+	ovs_unlock();
 exit_err:
 	nlmsg_free(reply);
 	return err;
@@ -1883,8 +1892,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
+	struct ovs_ct_limit_info *ct_limit_info;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -1897,14 +1906,20 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
+	ovs_lock();
+	ct_limit_info = rcu_dereference_protected(ovs_net->ct_limit_info,
+						  lockdep_ovsl_is_held());
 	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
 					  ct_limit_info);
 	if (err)
-		goto exit_err;
+		goto exit_unlock;
 
 	genlmsg_end(reply, ovs_reply_header);
+	ovs_unlock();
 	return genlmsg_reply(reply, info);
 
+exit_unlock:
+	ovs_unlock();
 exit_err:
 	nlmsg_free(reply);
 	return err;
@@ -1917,8 +1932,8 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
+	struct ovs_ct_limit_info *ct_limit_info;
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -1932,23 +1947,29 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
+	ovs_lock();
+	ct_limit_info = rcu_dereference_protected(ovs_net->ct_limit_info,
+						  lockdep_ovsl_is_held());
 	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
 		err = ovs_ct_limit_get_zone_limit(
 			net, a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT], ct_limit_info,
 			reply);
 		if (err)
-			goto exit_err;
+			goto exit_unlock;
 	} else {
 		err = ovs_ct_limit_get_all_zone_limit(net, ct_limit_info,
 						      reply);
 		if (err)
-			goto exit_err;
+			goto exit_unlock;
 	}
 
 	nla_nest_end(reply, nla_reply);
 	genlmsg_end(reply, ovs_reply_header);
+	ovs_unlock();
 	return genlmsg_reply(reply, info);
 
+exit_unlock:
+	ovs_unlock();
 exit_err:
 	nlmsg_free(reply);
 	return err;
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index db0c3e69d..355adf78b 100644
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
