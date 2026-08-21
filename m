Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDF276041
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282409; cv=none; b=dk3p2wqqHuM7xd8fnJlSrXTjg27xbPym7YtLkYvu25yG28HYSXRqBmuhORo6XEdCB3d4Gj2VkYBDmPpoWi9PLfTxgFcGF3o3vDgxXutr2aM6hysVN6apqaGPygmumXoTctI82MWKyG7TDfXisGxvCGO7mzOFDhkABQZ3EFsrpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282409; c=relaxed/simple;
	bh=K2KN2+Rkt/Avnjvn09W3iMwba2fB4SD7v9ESXrjQaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c12QSS80XJqm1MksPNA249NfX0Qi/jK67F8Kmf8Xu9oxB+G894M9pQFK6H94ujSwvCSZe8PxbkaZYZ7G4ERqIQHtYTwSKekyE9dZ9LAApMJGL1HgrdbC4NmesLyLzAR0pCFSswMrAR9pFt/QrXfB8XbMhPch5GEbtOGUcU/V60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgICP9P7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgICP9P7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso9793965ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282400; x=1787887200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wF/bI2dZiYsfHHNtfnyaFsuLqCjEQGZrGyym3Ffi7o0=;
        b=LgICP9P70WaEge4O6dZ1/EU3GvVYjWpm+Bmqn3e/5lsA5mKQzYFaBa/OrfeXO0+LmO
         lkpbUvadDio3BL7P7oxMPxLfhUcTt7tbfaIDmBoZPwHTuKA5J+sv9bZQ981mzh7dN3IA
         qsow5FjAwP2JG7rzdnHabFsPVku2SBxSHCYcY8KTzaqkVhIeknwLiVJdqP6ouf2VAPas
         W4mDSxZ0FUxUI8qmBwd5YJUJFYzGlp5obCN36oNeSkQNuPP8pIJYQ66ojwxBDbP6qYdH
         QPDkPJP+MKaIqBLs6rOveiFlfrn90cxlbFrRje72D2/JWoQooo/b418pO1NJ/kPLT4hR
         qH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282400; x=1787887200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wF/bI2dZiYsfHHNtfnyaFsuLqCjEQGZrGyym3Ffi7o0=;
        b=Og0Ta17tJJN6mWBAw7MEddkQ7iErrJgJSMRXfea3oe24irbGG2k1xF0gQm8q1tqcxF
         zS757MLyy8vvCjzJhLM/JgZ+tav35Ey7Yw98ABVIFHfZv6A2zbQHxNAk5ja4IISddm/e
         a05q07+HP4sj3VEPX0kTlecYiZzc4tiJJ6N7HZBWH0HrpqM5uo6a3ZZgEzBDWg9is9vr
         lRmr4rfdGKsjbOT0SsVGWfttrCwGXpeHvX0PrKCPsKa5bjdXaV/C0CgQyT2X4PJt9lM8
         cSbC3baJBydN2tmkGjX5VAzq+80oJmJuSFdtnNgUEomPbUM82jSMJMxHhH2h7q18lk9G
         dNaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rph1WBAZ0Nrq9oKDuU/WaZjEPE/EGeXS4WlV+UdaHy6ArAjECRvAgVLuXY2SPpQwksTQN0NCF0=@vger.kernel.org
X-Gm-Message-State: AFuF++lJyhRxfh4Cy8R9anqXThQ0IV6LsLbCOgDYyTZKn3laSMsdUqxL
	1LgyLdAJX63U2m8BzddJ6eaQ2tNVr0YEwcHOZN8hOfF2pA1d9GH1exji
X-Gm-Gg: AR+sD13lvzLVUKxAqCIQwA0r/9NpjztcWsDYVOzyzTjcAhXzPpSIeeoBbAIZpa+od32
	8F3kEkLaPYqbdDGk9w/z5M4LQS9RJVv7lK1glCVLk7pBvIQhvD30qM/pUQBpaDzOOuzHm3ljHPj
	/dYdwNi1o0tJN0s8RC7t786SX2qSIPOJBFqpoLCwFduxtmnGE0XrZf4bouJmtgUsId/AtYpFmX3
	j30oR/4jFPKJ1BeV3bUztgeMHwFiHWTcz/Wf8DcpvE2XOYSdlB8gUQlEOPGrM6z5xbYD9bqpraN
	TeXLVGtwL0deya3tI9c52N9ZTt9bozvFB4zutZjau11vASEXLEqstoG8c0RPtR9wkShUJtPkPTu
	e/yjDKhtjnihSW1MpA5z32TtULJFBm4fYisqAWSfJRADSHlMXsq9SRtFYmJBzSz2L5b1KtXaE8M
	hismdLdn1RII8IbYTTKPQZRJQRkudfTVQzvDyX2nRKnn0+dKNTIrQpKThrDveVnvd0h7bIQ0kdT
	xt5hk9owq4uOpliY1ArwrUe2JUZTG7/xMPzQOyl91SiUuyg0Ut+
X-Received: by 2002:a17:90b:1b41:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-395c39f97e8mr4620362a91.16.1787282399585;
        Thu, 20 Aug 2026 20:19:59 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.30.235.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4570e63sm1299091a91.4.2026.08.20.20.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:19:59 -0700 (PDT)
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
Subject: [PATCH net v9 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Fri, 21 Aug 2026 11:19:38 +0800
Message-ID: <288fbd5459d92b9dd0dcc6faf625f04819161ff3.1787280296.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1787280296.git.xuyuqiabc@gmail.com>
References: <cover.1787280296.git.xuyuqiabc@gmail.com>
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

Netns teardown detaches the RCU-protected CT limit state in the pernet
.pre_exit callback while holding ovs_mutex.  The pernet core guarantees an
RCU grace period between the .pre_exit and .exit callbacks, so the .exit
callback completes the teardown without adding any extra synchronization.

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

Changes in v9:

- Rebase onto net/main.
- Drop the data parameter from ovs_ct_exit_finish() and read the detached
  state from ovs_net directly, fixing the build with
  CONFIG_NETFILTER_CONNCOUNT disabled.
- Rename ct_exit_data to ct_limit_exit_data and stop moving declarations
  around in ovs_exit_net().
- v8 Link: https://lore.kernel.org/all/cover.1787129643.git.xuyuqiabc@gmail.com/


Changes in v8:

- Rebase onto net/main, which now contains the adjacent nf_connlabels
  leak fix.
- Move the CT limit detach to the pernet .pre_exit callback and complete
  the teardown in .exit, relying on the RCU grace period that the pernet
  core guarantees between the two. Drop the extra synchronize_rcu() and
  use plain kfree() in the teardown path.
- v7 Link: https://lore.kernel.org/all/cover.1786936669.git.xuyuqiabc@gmail.com/


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

 net/openvswitch/conntrack.c | 120 ++++++++++++++++++++++++------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |  10 ++-
 net/openvswitch/datapath.h  |   8 ++-
 4 files changed, 98 insertions(+), 46 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 49eb2b0d234d..27115967e5d9 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -932,10 +932,14 @@ static int ovs_ct_check_limit(struct net *net,
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
@@ -1579,40 +1583,55 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
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
+{
+	return rcu_replace_pointer(ovs_net->ct_limit_info, NULL,
+				   lockdep_ovsl_is_held());
+}
+
+/* The CT limit state must be detached by ovs_ct_limit_exit_start() and an
+ * RCU grace period must elapse before this function runs.  The pernet core
+ * guarantees the grace period between the .pre_exit and .exit callbacks.
+ */
+static void ovs_ct_limit_exit_finish(struct net *net, void *data)
 {
-	const struct ovs_ct_limit_info *info = ovs_net->ct_limit_info;
+	const struct ovs_ct_limit_info *info = data;
 	int i;
 
+	if (!info)
+		return;
+
 	nf_conncount_destroy(net, info->data);
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
@@ -1620,7 +1639,7 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 		struct hlist_node *next;
 
 		hlist_for_each_entry_safe(ct_limit, next, head, hlist_node)
-			kfree_rcu(ct_limit, rcu);
+			kfree(ct_limit);
 	}
 	kfree(info->limits);
 	kfree(info);
@@ -1659,12 +1678,13 @@ static bool check_zone_id(int zone_id, u16 *pzone)
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
@@ -1673,6 +1693,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = zone_limit->limit;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1689,6 +1710,7 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
 			ct_limit->limit = zone_limit->limit;
 
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_set(info, ct_limit);
 			ovs_unlock();
 		}
@@ -1703,12 +1725,13 @@ static int ovs_ct_limit_set_zone_limit(struct nlattr *nla_zone_limit,
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
@@ -1717,6 +1740,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 		if (unlikely(zone_limit->zone_id ==
 				OVS_ZONE_LIMIT_DEFAULT_ZONE)) {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			info->default_limit = OVS_CT_LIMIT_DEFAULT;
 			ovs_unlock();
 		} else if (unlikely(!check_zone_id(
@@ -1724,6 +1748,7 @@ static int ovs_ct_limit_del_zone_limit(struct nlattr *nla_zone_limit,
 			OVS_NLERR(true, "zone id is out of range");
 		} else {
 			ovs_lock();
+			info = ovsl_dereference(ovs_net->ct_limit_info);
 			ct_limit_del(info, zone);
 			ovs_unlock();
 		}
@@ -1767,6 +1792,7 @@ static int __ovs_ct_limit_get_zone_limit(struct net *net,
 	return nla_put_nohdr(reply, sizeof(zone_limit), &zone_limit);
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_zone_limit(struct net *net,
 				       struct nlattr *nla_zone_limit,
 				       struct ovs_ct_limit_info *info,
@@ -1790,12 +1816,10 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
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
@@ -1810,6 +1834,7 @@ static int ovs_ct_limit_get_zone_limit(struct net *net,
 	return 0;
 }
 
+/* Called with RCU read lock held. */
 static int ovs_ct_limit_get_all_zone_limit(struct net *net,
 					   struct ovs_ct_limit_info *info,
 					   struct sk_buff *reply)
@@ -1822,19 +1847,16 @@ static int ovs_ct_limit_get_all_zone_limit(struct net *net,
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
 
@@ -1844,7 +1866,6 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_SET,
@@ -1857,8 +1878,8 @@ static int ovs_ct_limit_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_set_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_set_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1878,7 +1899,6 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *reply;
 	struct ovs_header *ovs_reply_header;
 	struct ovs_net *ovs_net = net_generic(sock_net(skb->sk), ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_DEL,
@@ -1891,8 +1911,8 @@ static int ovs_ct_limit_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		goto exit_err;
 	}
 
-	err = ovs_ct_limit_del_zone_limit(a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT],
-					  ct_limit_info);
+	err = ovs_ct_limit_del_zone_limit(ovs_net,
+					  a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]);
 	if (err)
 		goto exit_err;
 
@@ -1912,7 +1932,7 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct ovs_header *ovs_reply_header;
 	struct net *net = sock_net(skb->sk);
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
-	struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_info;
 	int err;
 
 	reply = ovs_ct_limit_cmd_reply_start(info, OVS_CT_LIMIT_CMD_GET,
@@ -1926,18 +1946,19 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
@@ -2012,12 +2033,29 @@ int ovs_ct_init(struct net *net)
 	return err;
 }
 
-void ovs_ct_exit(struct net *net)
+/* Must be called with ovs_mutex held.  Detaches the RCU-protected
+ * ct_limit_info and stores it in ovs_net->ct_limit_exit_data for
+ * ovs_ct_exit_finish() to complete the teardown after an RCU grace period.
+ */
+void ovs_ct_exit_start(struct net *net __maybe_unused)
+{
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
+	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
+
+	ovs_net->ct_limit_exit_data = ovs_ct_limit_exit_start(ovs_net);
+#endif
+}
+
+/* Completes the CT limit teardown.  The pernet core guarantees an RCU
+ * grace period between detaching the state in ovs_ct_exit_start() and
+ * this call, so no RCU readers remain.
+ */
+void ovs_ct_exit_finish(struct net *net)
 {
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
 
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	ovs_ct_limit_exit(net, ovs_net);
+	ovs_ct_limit_exit_finish(net, ovs_net->ct_limit_exit_data);
 #endif
 
 	if (ovs_net->xt_label)
diff --git a/net/openvswitch/conntrack.h b/net/openvswitch/conntrack.h
index 317e525c8a11..ab21d032fde3 100644
--- a/net/openvswitch/conntrack.h
+++ b/net/openvswitch/conntrack.h
@@ -14,7 +14,8 @@ enum ovs_key_attr;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 int ovs_ct_init(struct net *);
-void ovs_ct_exit(struct net *);
+void ovs_ct_exit_start(struct net *net);
+void ovs_ct_exit_finish(struct net *net);
 bool ovs_ct_verify(struct net *, enum ovs_key_attr attr);
 int ovs_ct_copy_action(struct net *, const struct nlattr *,
 		       const struct sw_flow_key *, struct sw_flow_actions **,
@@ -40,7 +41,8 @@ void ovs_ct_free_action(const struct nlattr *a);
 
 static inline int ovs_ct_init(struct net *net) { return 0; }
 
-static inline void ovs_ct_exit(struct net *net) { }
+static inline void ovs_ct_exit_start(struct net *net) { }
+static inline void ovs_ct_exit_finish(struct net *net) { }
 
 static inline bool ovs_ct_verify(struct net *net, int attr)
 {
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index f2d5b5ab38de..100a2ce4d74d 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2742,6 +2742,13 @@ static void __net_exit list_vports_from_net(struct net *net, struct net *dnet,
 	}
 }
 
+static void __net_exit ovs_pre_exit_net(struct net *dnet)
+{
+	ovs_lock();
+	ovs_ct_exit_start(dnet);
+	ovs_unlock();
+}
+
 static void __net_exit ovs_exit_net(struct net *dnet)
 {
 	struct datapath *dp, *dp_next;
@@ -2752,7 +2759,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 	ovs_lock();
 
-	ovs_ct_exit(dnet);
+	ovs_ct_exit_finish(dnet);
 
 	list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
 		__dp_destroy(dp);
@@ -2776,6 +2783,7 @@ static void __net_exit ovs_exit_net(struct net *dnet)
 
 static struct pernet_operations ovs_net_ops = {
 	.init = ovs_init_net,
+	.pre_exit = ovs_pre_exit_net,
 	.exit = ovs_exit_net,
 	.id   = &ovs_net_id,
 	.size = sizeof(struct ovs_net),
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 696640e88fa7..b2c2b8da12d4 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -164,7 +164,10 @@ struct dp_upcall_info {
  * Protected by genl_mutex.
  * @dp_notify_work: A work notifier to handle port unregistering.
  * @masks_rebalance: A work to periodically optimize flow table caches.
- * @ct_limit_info: A hash table of conntrack zone connection limits.
+ * @ct_limit_info: Hash table of conntrack zone connection limits. Protected
+ * by RCU; updates and teardown are serialized by ovs_mutex. May be NULL during
+ * netns teardown.
+ * @ct_limit_exit_data: CT limit state detached at .pre_exit, freed at .exit.
  * @xt_label: Whether connlables are configured for the network or not.
  */
 struct ovs_net {
@@ -172,7 +175,8 @@ struct ovs_net {
 	struct work_struct dp_notify_work;
 	struct delayed_work masks_rebalance;
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	struct ovs_ct_limit_info *ct_limit_info;
+	struct ovs_ct_limit_info __rcu *ct_limit_info;
+	struct ovs_ct_limit_info *ct_limit_exit_data;
 #endif
 	bool xt_label;
 };

