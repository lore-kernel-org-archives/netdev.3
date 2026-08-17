Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF112F7F05
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937549; cv=none; b=Cdky1q4bXLlh2HDF/InLhlDpa5ZBxheH4qL4H28VPztr1UYcUXuhLsnXqcbekviifRwdiZ91bT2pitX5C7n3uLjfKJjEV7U4L6iH2oT3614VXOBzQNPHn8y3mmCSs0dqIkoqIQk67zOg04uxAWsngnJ7cWk8YIXNT1CySe2qHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937549; c=relaxed/simple;
	bh=466Op85rczPf9COjoVInqKurUH3hdBGawpD7ke0COi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4VMrZ/80C27U+9M2JZYSxavTc4551b+684xbOV+GSsNJuou/uLw5kLJmT7y89/0+GVAvCMj3svZlFtZvVi4zW6/MlSiCjRaVKWpSYYkTrX+rwKFhUAqz0zfS93B3BTbJxtTA6JhBAasruCUXc3VcnPSj3VXXRs4VY0vEnFuDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO6ooRjj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO6ooRjj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2040125a91.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786937547; x=1787542347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHeDQlZjVrN67Yk/UE516fExdUaXOo/TJOXMsAJ55b4=;
        b=WO6ooRjj1J+c1HmE/w4phdUb/XopLQR6hnguUDWlZAOF7C5MFeQjlfN9EnsKUaEwCB
         nNP9RvAz/OqBs9dmW/3Xzf/1MwuMyLf12+SPh4Nr+iyhu8Jxr+kO1YeT+T3pprb/egmu
         v3zrjewGo3QFk7H66uOPf5Udq1CzdtD5yL04s4h166ZNr4A+dKiaz1RDTt1ovbjEBi4M
         CsZjoWZeBjQ7nE6xv6PIIqn945E2mmktJ4tkq8R0VNvnaIhfs25Wdsozk6u47WKRqhVN
         UzAq8hghFQLvjVr5zzdoqnDWZGtH/JFFJumzjeNzZBT1SeMhQOthatKNvbwnzIZsGxOy
         JFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786937547; x=1787542347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHeDQlZjVrN67Yk/UE516fExdUaXOo/TJOXMsAJ55b4=;
        b=TZBCgClNfLtslXe2q4GGvFpQDuzIdQLrxIlmXs3YTMVEr9/5b4D4/CBGKlljCTetVI
         ceDb8UigsjxDPPmNp/QVbTPDkya/hVguSsgm5u2uSd7o/EkrD8+wcVPzGvC8DgFS5zu0
         +IWumS8WlnzS+QBte7/JuAWrXcNDd5uP6aYJrP1beUVn0mKX8/Oh9IP2PTi/X7ydUtHl
         i9b1gioCe7PSlYFOUqCAnT81spwGDLHVt/wMPaCpL5P/UYBg7RHJHQmXvkIyphjBECxC
         TFZLUKm45V3uYSJgC8d5DbNqZjl8X3BZB3CA+jwDhHfIqdLDwEDuA2hIa/ybqbZBGePf
         LvTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOIVyqOZCdi3JVJykHTRpBOX/sGHHw/TF4S4Z1rwzcY0penZ0jDGRFU3fm3cY8fBlTdupRH0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqquZEtOMrDWHAs+ToAmKi67V2Vmn6LugDUSvYwl6S0Isowktb
	+Rz9ywiDRlwc1jsRVUgchmFo2ovnuaZlLIYLWpClGV1Ibwpz8EohaPjjt8wL9StG
X-Gm-Gg: AR+sD10GMBMQPFLDgxEeZaQvN3B6oqihCf/YghsWUGTmKx7MrOx1lUM1hy2M8iWSFPZ
	3ap1cMD7vvZjtkMCBiH2tGH1mIQ50wKNQC99EG6nqM9492xSII+ERRMP+SQZBpGgaid/j5wUv/V
	breDbpkeVUOsjANAVLtq9HDImPZWmLeCmJlkNsTxqKMCQxWyYZmQni4UYLqT2nwUrnMFCRA25Uz
	l49eXqrTBWn//jLyXDlxYLVBXm87pvUcl+UWUhdGQ0PNKGmDti1YhcgOp7M3l8FL820nDP2sX0D
	QAxKvk8TxLSPnSk077Vu49ZNb7apsLBL1JDn2HQao1uUSLSJyollKRikAzI58r+1Oxw6hvPJI62
	NPWLRE3iY+T+k4ZRef56503S///Hftji/VxKvuHX4mNQljld1j6mmjr6uRqdu6yfAMxPPfv9PEV
	pqr/gOY/+t4bHYhDu7SLm9CXsvoB+iSW70oMU6AxZojof+KVq9FyPPqc+VTTsE7Mhyyt/TYHJs5
	sICPqUqLSZ/+xVx/OQvORF+brtQmZJV8qw7X2O9NqV/pN0Y+A==
X-Received: by 2002:a17:90b:4d85:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3933b8b5de6mr21646611a91.15.1786937546444;
        Sun, 16 Aug 2026 20:32:26 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.244.59.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e3184bsm3119496a91.1.2026.08.16.20.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 20:32:26 -0700 (PDT)
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
Subject: [PATCH net v7 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Mon, 17 Aug 2026 11:32:14 +0800
Message-ID: <6cb36cfa28844b05919ca7c45c6c2bc812d3dc2e.1786936669.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786936669.git.xuyuqiabc@gmail.com>
References: <cover.1786936669.git.xuyuqiabc@gmail.com>
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

Netns teardown detaches the RCU-protected CT limit state while holding
ovs_mutex, then completes the teardown - waiting for the RCU grace period
and freeing the state - after the mutex is released. This keeps the grace
period wait out of ovs_mutex so that it does not stall concurrent OVS
users.

The netlink command handlers do not need NULL checks because the userspace
netlink socket holds an active reference to its network namespace while a
request is processed. The per-netns exit path therefore cannot run
concurrently with SET, DEL, or GET for that socket's namespace.

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

Changes in v7:

- Split CT limit teardown into a start/finish pair so that the RCU grace
  period wait happens after ovs_mutex is released, keeping the lock from
  blocking other ovs_mutex users during the wait.
- v6 Link: https://lore.kernel.org/all/cover.1786506548.git.xuyuqiabc@gmail.com/


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

 net/openvswitch/conntrack.c | 115 +++++++++++++++++++++++-------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |   7 ++-
 net/openvswitch/datapath.h  |   6 +-
 4 files changed, 88 insertions(+), 46 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e6..0c1308fc23b4 100644
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
@@ -1585,40 +1589,54 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
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
 
-static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
+static void *ovs_ct_limit_exit_start(struct ovs_net *ovs_net)
 {
-	const struct ovs_ct_limit_info *info = ovs_net->ct_limit_info;
+	return rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
+				   lockdep_ovsl_is_held());
+}
+
+static void ovs_ct_limit_exit_finish(struct net *net, void *data)
+{
+	const struct ovs_ct_limit_info *info = data;
 	int i;
 
+	if (!info)
+		return;
+
+	/* Wait for RCU readers to stop using the CT limits. */
+	synchronize_rcu();
+
 	nf_conncount_destroy(net, info->data);
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
@@ -1665,12 +1683,13 @@ static bool check_zone_id(int zone_id, u16 *pzone)
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
@@ -1679,6 +1698,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = zone_limit->limit;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1695,6 +1715,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->limit = zone_limit->limit;
 
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_set(info, ct_limit);
 			ovs_unlock();
 		}
@@ -1709,12 +1730,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
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
@@ -1723,6 +1745,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = OVS_CT_LIMIT_DEFAULT;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1730,6 +1753,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_del(info, zone);
 			ovs_unlock();
 		}
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
@@ -1932,18 +1951,19 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
@@ -2016,12 +2036,27 @@ int ovs_ct_init(struct net *net)
 #endif
 }
 
-void ovs_ct_exit(struct net *net)
+/* Must be called with ovs_mutex held.  Detaches RCU-protected ct_limit_info
+ * and returns an opaque handle for ovs_ct_exit_finish() to complete teardown
+ * after the mutex is released.
+ */
+void *ovs_ct_exit_start(struct net *net __maybe_unused)
+{
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
+	return ovs_ct_limit_exit_start(net_generic(net, ovs_net_id));
+#endif
+	return NULL;
+}
+
+/* Must be called without ovs_mutex held.  @data must be the opaque pointer
+ * returned by ovs_ct_exit_start().
+ */
+void ovs_ct_exit_finish(struct net *net, void *data __maybe_unused)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	ovs_ct_limit_exit(net, ovs_net);
+	ovs_ct_limit_exit_finish(net, data);
 #endif
 
 	if (ovs_net->xt_label)
diff --git a/net/openvswitch/conntrack.h b/net/openvswitch/conntrack.h
index 317e525c8a11..2363ce56d7ec 100644
--- a/net/openvswitch/conntrack.h
+++ b/net/openvswitch/conntrack.h
@@ -14,7 +14,8 @@ enum ovs_key_attr;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 int ovs_ct_init(struct net *);
-void ovs_ct_exit(struct net *);
+void *ovs_ct_exit_start(struct net *net);
+void ovs_ct_exit_finish(struct net *net, void *data);
 bool ovs_ct_verify(struct net *, enum ovs_key_attr attr);
 int ovs_ct_copy_action(struct net *, const struct nlattr *,
 		       const struct sw_flow_key *, struct sw_flow_actions **,
@@ -40,7 +41,8 @@ void ovs_ct_free_action(const struct nlattr *a);
 
 static inline int ovs_ct_init(struct net *net) { return 0; }
 
-static inline void ovs_ct_exit(struct net *net) { }
+static inline void *ovs_ct_exit_start(struct net *net) { return NULL; }
+static inline void ovs_ct_exit_finish(struct net *net, void *data) { }
 
 static inline bool ovs_ct_verify(struct net *net, int attr)
 {
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index ae69b2cabab9..c18dafa920b7 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2758,15 +2758,16 @@ static void __net_exit list_vports_from_net(struct net *net, struct net *dnet,
 
 static void __net_exit ovs_exit_net(struct net *dnet)
 {
-	struct datapath *dp, *dp_next;
 	struct ovs_net *ovs_net = net_generic(dnet, ovs_net_id);
 	struct vport *vport, *vport_next;
+	struct datapath *dp, *dp_next;
+	void *ct_exit_data;
 	struct net *net;
 	LIST_HEAD(head);
 
 	ovs_lock();
 
-	ovs_ct_exit(dnet);
+	ct_exit_data = ovs_ct_exit_start(dnet);
 
 	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
 		__dp_destroy(dp);
@@ -2784,6 +2785,8 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 	ovs_unlock();
 
+	ovs_ct_exit_finish(dnet, ct_exit_data);
+
 	cancel_delayed_work_sync(&ovs_net->masks_rebalance);
 	cancel_work_sync(&ovs_net->dp_notify_work);
 }
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

