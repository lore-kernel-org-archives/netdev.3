Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D103B52E2
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778260; cv=none; b=qBEj2F6P0CNM/iKxLXM7AGlMOSYH3a46thBkcr3d2bL1wOYcl4sE7rTiqkAQb735fgDYazxI2ra6/b6hoO8RlasXPqOB9VFn1Cij8tWOVzQ11Ev1AWktPpvmC1y9SGzV/9YxBk6io9SM3xdVWFeSWavfl3tbUj1B5hjk772LeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778260; c=relaxed/simple;
	bh=aF7wyQt0xdXNeKiToSDk+JQMQ8BTD5ZjcF5LddZcGhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO78ilzYSlEWe/glAP4K9/U9lOWhEszP6CWkB+PpxemgUgyybSMYqq1AlCIvP+GmtqRX9OBz/oqgAV9CoPVQgx2p64o+4B0K/HNqbBBU5+yyY6KDx4LNGd3RbNkz2a7sHQgDhibSflSQU3S3qqDBNlVyr48EZucaZGCdacMY6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDhRdevt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDhRdevt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cca0c5799eso31410875ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778258; x=1786383058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCkoEnsQPuntZvPWdFuw9KB3OTvk0BSYjQi0gV5MKjI=;
        b=ZDhRdevtPdjaYsFAbuNfNeTVN0MjjoMShn+1sA9B1TC+/Q1PxZyssiu3mKs9UgG1S7
         BkTOJ7DBPnxEHtmzoN0SO/9+SaIKaDPAY26DLBfMHQLhsOT2teLOcQjucwFWhhkMurul
         jTUWQxogfGBnfkrKfzZvc2kmbgeLyu4zuZoSpirlzhADtM5lWhSBjyOaD56L9+RwvKD7
         7Fa/PHfAqQftXjVUN7wSfY2PEaRnHHpLsXlANo3IAVc1MWtYQw/9z8Br6A7TqchxJ3Gq
         ncWpnnNyjoTDxpsyoX0k4xTUv2DMrKVI9mSCu/XwTnX3ArziK0/0LCntTnj+LJZF6T0H
         u/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778258; x=1786383058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCkoEnsQPuntZvPWdFuw9KB3OTvk0BSYjQi0gV5MKjI=;
        b=X/vQyGN/+IglAp4M7wsOYjEdzNfuAj9VTZnWJ7xTCePjBGcDrOLvZN6vRBQqdg/e15
         1ZaVTBs6nXRW5Kcr6PtQMcB0W5XiBsN38TqWTVsWHjcrnN6eqjjQoobCazYmYlrOPWqX
         cXihy206tKozVOx0ifZXHOFAnLXE0/V1DJF7eMuS2rs4znE+8Ys63+zLfLTeyd2YmqjP
         sr1MlUlDGHOoFMjcEryL82pc3vpwe5wTCUmyBUp/3GhtlgpR0Cj/t7Ym3QQqD4D0n6bU
         OQ5L1wcz+x5DOfxUwaPg8nt2djwMWSrmBXf6atgmSfW8SQlLpMIQzWChPE0BqFpnXFa+
         cRgg==
X-Gm-Message-State: AOJu0YxONOPFm3lwR9NFp7CBNxQFipm6W85C7rHlPcMgKff2CA44sEWs
	LLgQzhFyHr/cPjrWljmI9FPk7HXplehoCXn1vbVyO1YfNHd1XzfstYXmNmqLFjGI8jA=
X-Gm-Gg: AR+sD13KW2e1v4Z0dlX7x8+Hz/tBZVSWk4ZHhIhFcYlNhBj2pJ5MfauvY+npAGOZJDe
	fW1aKyL71SNdkjyMIl+fDHGI/fKalS+AnSQ4Xm5VN+bwdYaMxa153e28OUn+yGpt9hGD9DJ2SuI
	t6Cwp6RNZ0uul+OmciZWl4KnCf6jkJufKYS73ZzDUsAwvTC/SwHv2FyEtDI+aq41qWxiDTAErSd
	dBBkbVNe0DiktkpgFTRfMa/w9b8H2wdntdkAHfLWZoYmLAe5kCM1K5PQ8Z0m7RetoH/tEAWHuRd
	VDJHZuxWyt08A4ca+S1j/fNUkHemYfN7vvzNDT51+N+uDH/qZ1ZTJtgNeZpnIYQIzlEhPCZG0pt
	WEbxQXSnYZWfqo0nrTqmsVs7IHCZof0Ju6xQrre4NqJ6JjjCSIMPpeCw5qY+lsaiJAUsuN6AYOM
	nDTbqIqqzRNJsgmwcBpiIEcV9m50IGY6KvshsIAUSkBXyUUdTtt74fmbe3I2vG6A+UNiUFNwQSH
	dnslvXlbnOkZCFZzIiTCVp+LZ0=
X-Received: by 2002:a17:902:ef4d:b0:2cf:ca89:499d with SMTP id d9443c01a7336-2d052188ccdmr110218335ad.7.1785778257876;
        Mon, 03 Aug 2026 10:30:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1222easm41362875ad.68.2026.08.03.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:30:57 -0700 (PDT)
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
	pshelar@ovn.org,
	yihung.wei@gmail.com,
	vega@nebusec.ai,
	tonanli66@gmail.com,
	xuyuqiabc@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net v3 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Tue,  4 Aug 2026 01:30:40 +0800
Message-ID: <8cf84ef117b917c4ca3a264af4df4cc1e293435a.1784866791.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784866791.git.xuyuqiabc@gmail.com>
References: <cover.1784866791.git.xuyuqiabc@gmail.com>
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

Replace the pointer before freeing the CT limit state, and wait for RCU
readers before freeing its contents. Keep ovs_mutex only around CT limit
updates, while GET uses the RCU read-side lock for the lifetime of the
lookup.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Co-developed-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
Changes in v3:

- Use RCU dereference and a NULL check for CT limit GET requests.
- Limit ovs_mutex to CT limit updates; do not hold it while preparing replies.
- Use ovsl_dereference() for update paths and clarify the RCU grace-period comment.
- v2 Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com

Changes in v2:

- Sort local declarations modified by this patch in reverse Christmas-tree order.
- v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/

 net/openvswitch/conntrack.c | 109 +++++++++++++++++++++---------------
 net/openvswitch/datapath.h  |   2 +-
 2 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e6..aa71a254fe24 100644
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
@@ -1665,22 +1676,28 @@ static bool check_zone_id(int zone_id, u16 *pzone)
 	return false;
 }
 
-static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
-				       struct ovs_ct_limit_info *info)
+static int ovs_ct_limit_set_zone_limit(struct ovs_net *ovs_net,
+				       struct nlattr *nla_zone_limit)
 {
+	struct ovs_ct_limit_info *info;
 	struct ovs_zone_limit *zone_limit;
 	int rem;
 	u16 zone;
 
+	ovs_lock();
+	info = ovsl_dereference(ovs_net->ct_limit_info);
+	if (!info) {
+		ovs_unlock();
+		return -ENOENT;
+	}
+
 	rem = NLA_ALIGN(nla_len(nla_zone_limit));
 	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
 
 	while (rem >= sizeof(*zone_limit)) {
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
-			ovs_lock();
 			info->default_limit = zone_limit->limit;
-			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
 				zone_limit->zone_id, &zone))) {
 			OVS_NLERR(true, "zone id is out of range");
@@ -1688,15 +1705,15 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			struct ovs_ct_limit *ct_limit;
 
 			ct_limit = kmalloc_obj(*ct_limit, GFP_KERNEL_ACCOUNT);
-			if (!ct_limit)
+			if (!ct_limit) {
+				ovs_unlock();
 				return -ENOMEM;
+			}
 
 			ct_limit->zone = zone;
 			ct_limit->limit = zone_limit->limit;
 
-			ovs_lock();
 			ct_limit_set(info, ct_limit);
-			ovs_unlock();
 		}
 		rem -= NLA_ALIGN(sizeof(*zone_limit));
 		zone_limit = (struct ovs_zone_limit *)((u8 *)zone_limit +
@@ -1706,32 +1723,37 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 	if (rem)
 		OVS_NLERR(true, "set zone limit has %d unknown bytes", rem);
 
+	ovs_unlock();
 	return 0;
 }
 
-static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
-				       struct ovs_ct_limit_info *info)
+static int ovs_ct_limit_del_zone_limit(struct ovs_net *ovs_net,
+				       struct nlattr *nla_zone_limit)
 {
+	struct ovs_ct_limit_info *info;
 	struct ovs_zone_limit *zone_limit;
 	int rem;
 	u16 zone;
 
+	ovs_lock();
+	info = ovsl_dereference(ovs_net->ct_limit_info);
+	if (!info) {
+		ovs_unlock();
+		return -ENOENT;
+	}
+
 	rem = NLA_ALIGN(nla_len(nla_zone_limit));
 	zone_limit = (struct ovs_zone_limit *)nla_data(nla_zone_limit);
 
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
@@ -1741,6 +1763,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 	if (rem)
 		OVS_NLERR(true, "del zone limit has %d unknown bytes", rem);
 
+	ovs_unlock();
 	return 0;
 }
 
@@ -1796,12 +1819,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
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
@@ -1828,19 +1849,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,
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
 
@@ -1850,7 +1868,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -1863,8 +1880,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_set_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1884,7 +1901,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -1897,8 +1913,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_del_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1918,7 +1934,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -1932,18 +1948,21 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
