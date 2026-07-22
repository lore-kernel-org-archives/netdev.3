Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38611466B1D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738496; cv=none; b=F5x/QfqByPKCrbbMcNG31ZGuUFTihFqEPQJ3Y4BAHPXgaYgrnqwL6KPkrlEVNX7/CEq8EeU+L8ftqbNYAThc8c4FlDxsS9OaAY8MSzN1GQfU9gKcxByQHjuTX+MlQflKLjXgZk5WKQ6TT8U1Ox4bP7Fm5WLAfd2dzsUNMDjuG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738496; c=relaxed/simple;
	bh=9UIMoxSj72JS/MD0MUrAtAHT1CcuF7HopngW+TcncXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU7Y7HvkfgwXKbBk3JEN4QNZk5XJPfUbDD8Mk79Mll6z7DtbgT66CS+zMW+kn+HaiURjan1ouM3k0GMRjfbwcuqh63Ta12Ge5YHsHqyeSQLsAd8r9phH87XVXeeNemfxFF7YdxZ46gO9FMzRv8naWJFdt/M+cxLFIcXrm7MAT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goHT5lLd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goHT5lLd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so139961855ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738484; x=1785343284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ym5/89LZn/4UdP8gy+eHFYUUUELyQ/gN4XujH1Zwcew=;
        b=goHT5lLdjqnPvdu9XGcoP2lL9MAN2G7+EG4mMG2MzkM5D/EIBrilZKbwLQeTqEbPBP
         ZcsfZapP9OS1k9YUGknOkzTokg5KJDxPa7acFzfFskoPvGV1DuEvaSz7nGqVLz07dCyO
         y4Ueqqw32VzeChH4MTzdS4lMtmpt0zwIUtMbD4wo3JzaNeAFDpH02JloWSc74KfkIDTT
         KTljLOxQ4Y5csXGyJXipn0lWjxSu4XEGtDB26Docilmg0gE5WNRcSl1ufPkmLXkMBTi/
         T08qhVKq38B0fMCvEhjRHqEVSlovRL+nwN2vhCxsly2sPttLajbfIJgv6WOA1UzW5LHz
         U26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738484; x=1785343284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ym5/89LZn/4UdP8gy+eHFYUUUELyQ/gN4XujH1Zwcew=;
        b=XUvSdSJ777BmFbkc10XT7cfiR8X01f2FeDWLkRKa+x521qim5EUR5/3HQvjSl7Fhm8
         ml0yImgDkaSYCUxImKYiBpaWoudTJ9dnmB/4JJUz9cIl4m3WxukoMpjuS/76GOl0VbW1
         q9m0753SuAChfM//ElcN0Kj/nimqD1Rb3wAvx9PGnxncSddsFERo6mm3zXg9QCmdkK1x
         VHPir8mgKWTy3qFZ6OrBLsg4v63QpN8h7pxUZapEDzTaT53ePqjkD4BtBDYptSn0Cb2c
         uGId8Hidfta6h6eaEwbXh+/PUycdUFKZcnajmRzZRoDHHYLf+HR0TmmXguY+sMsb3PE5
         CPcw==
X-Gm-Message-State: AOJu0Yx4HlHT+JjvuQLn6N/ZmzS2C04rAe4D5KDvpVH/L8krjCUP3JIF
	XLvLoAQ3sWBjaGhTzl6fxbJby1FfBpBGwx8y0EBapJZzZAkSPdVsssQybxIVG/4Jwj0=
X-Gm-Gg: AR+sD13mJ1onP7VSJscmnN6E9zim/fi/IHgNtjqx2rbQAQD9Ws2c/vYuvk5yOBZG4my
	1OSdNfZr6+IfwsV+fngVWgEFErx9JrLxtMV99D3NQCyyqw2phSQqBhWXo4lCFjVvzJSBZrvWGvb
	XnPMgPblWTe0zEGn9wPvg509M9hhGElQRDVNT3QKFjICjk2Vb8uDlhOMup1QoyCh3ODY83aIsFg
	F25do7obDBEFGVaCEOU3ReO1DIutDjMMhY+uaVr/DkiZ4vZlJIIkdiqC+XG10BcCM8FhRHA1Kt/
	gXB4jN45JnkITEKUJ90SeEhnL4A5NrLWnWPBTrrSX2Q1Tq2TfE51wCokq9EkEF9nrf05mm+O4+8
	6rfTTQnsXX/RKOGqDbq5vkQF78Us4KoofX0q/pWnpMMLxruGs6ho4AlSb4FGnDTfUrSSdl8P+qY
	zMrTnB8xNbLe5o2TEzYPpA
X-Received: by 2002:a17:903:3c44:b0:2c9:e69f:edce with SMTP id d9443c01a7336-2cf34a04ed1mr256000525ad.44.1784738484462;
        Wed, 22 Jul 2026 09:41:24 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd8a9csm18205125ad.30.2026.07.22.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:41:24 -0700 (PDT)
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
	yihung.wei@gmail.com,
	pshelar@ovn.org,
	vega@nebusec.ai,
	tonanli66@gmail.com,
	xuyuqiabc@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Thu, 23 Jul 2026 00:40:55 +0800
Message-ID: <20260722164120.2064541-1-enjou1224z@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784711445.git.xuyuqiabc@gmail.com>
References: <cover.1784711445.git.xuyuqiabc@gmail.com>
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
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
changes in v2:
  - Sort local declarations modified by this patch in reverse
    Christmas-tree order.
  - v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/

 net/openvswitch/conntrack.c | 79 +++++++++++++++++++++++--------------
 net/openvswitch/datapath.h  |  2 +-
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e6..5c9a607d27a7 100644
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
@@ -1850,7 +1853,7 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
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
@@ -1884,7 +1893,7 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
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
@@ -1918,7 +1933,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
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
