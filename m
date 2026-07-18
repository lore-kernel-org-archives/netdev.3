Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFB385D70
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365797; cv=none; b=rX8NJDvdPALTbrIrTCwC4T9yzaX/UZRGt347CJ1M2lEH5u9gqf1gK8ZB7TowKW/x2ijBd3gcWjp9bnhN9k7xxz7aWn86JVokBoqtjYD2sa9fuCZg9rZxvaOYr8D0W/4IVulMT8Ne0J64OzxogAtB9vr9bVFMsB/8zFDqVt1Bz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365797; c=relaxed/simple;
	bh=cOiHqROlaX3iAExcJmInGX51hn++nDNac7E4yH5eTYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/De9U5XTtfEe1+xP46fyH6BAZ3RJy64oF2W7pRD0v4X/HT9lC36FmZIjtGYjEzy27wh2oBUgZ25XvwYiB1NWSbtvgB8VVWV4vRmRCPd2VEmJ6/ri7EadQ8MH0xLIJLRJ2gArxWVIvBbYiJdaYIvV5KBB+Tcws5HnDiK5ELS9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZh82k8Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZh82k8Q"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso57784025ad.2
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784365795; x=1784970595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MeDAcowrYv39eI3MVM07Rji0GvDqjfJecP+ZC7wQxRY=;
        b=PZh82k8QJrDK47lrjtR4gXpD3T283oXbKn+PlEXh32bo0douJ/A8OoD3bBjpt4Jn19
         Q6MXUWKGQA7GY7j/xlCzibwv6+dwT5bXCEBY5QAW0mYAnnvx4S/X+1/GTRDy0qRY/eYt
         lTvgH7N0j8Nv9olPhMsBjMyse4MGltJFpoLasP2Toawg/zIDnunPtSCFjkFBfJPnH0NB
         GWfXiB2oas1YKZ9M2fJzdKZTo4G1pFQPgYpdhD41Cevyi4vCH/kklaadb0beu51fLX2I
         lmdXtqaXD/KmKYH3X984cG0c0Z5Aa8ADgUUy4J8sO5fvwkulTJHbeQbLFY5DGdVGiIwd
         ivpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365795; x=1784970595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MeDAcowrYv39eI3MVM07Rji0GvDqjfJecP+ZC7wQxRY=;
        b=I/sw1BeIxvqW88mPHiCcvWlBDFpvlFv8Jg9kgOEzcBqyZTpnDC0M61K3ggYRUxooUn
         rbqYW4MLFmfkV4RglO1M1ic2nW+x4YcS7jYsetakyieKbi17NxZYwaM1c9ZkdwiCciMK
         +fBwcsPqwWNdtuJlAGK9RzMTH4AaOEYBCeKIi/Ap44nMvB4OpKCkc/qEwNlSFmyySzz3
         VNQJT7OHR8hYOIIC622eBx0DtXOooSk1iv5LOGBtOJJOYB/9RS4+tfCsLYWMhW2kwk98
         MQnHMaUKVBRJ2/jvQfySW2gQiIMWh3Kaz7PJkZZ0x3j4nsFUKt/XZ9aTAgLVSV/msz7R
         SZPw==
X-Forwarded-Encrypted: i=1; AHgh+Rrl4DdeJhbg3h37dJ1tlD6HVoeUq+mMAHd+LBh78f5mvpuICm4RXV9TBzLt3guY+zJ6i0mVeOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QLS73X827z64T8CXTYb/h7ly2b/W49W/97A+aTdJAZNfNh7F
	y69TM4ILCuIBwBwje9yowPBq7LyKkrJJTI5wHKosCAkhjgzrjQ4kQEhK
X-Gm-Gg: AfdE7clz/3yb1t+db2vutmvmk5c8qJwSgGB79lEQeldc6yXbb4QK6E8J5HZ+UKoz9Ec
	QBVQ1qfIr6QPBJ7MlxEDUYAsbsUjr53sLxVZcJbgK3i5Y0lB2S82roRTa5l32qk0osbfFky7zLy
	PHCWgRvIRk22A4mCY7T85LPclt9MoP5rFaCfIY4EGfqzcRtpi6i3G0m+kMTy7GKbv6BZ+QDdu1W
	bnqgouuVtkINVvav5DNl2215qMiSHIosqNPNqMgfS3kKnYUqQHyS09flj4APy0EViOyR4TJhYhO
	HKf1gjsuAaz79eeajQP+gGlOSu2OG4ARUNk/ptm3nKuGq49t7VglF/UggFaZKJjuQDr0pmqA48/
	HWb9NjI+pb8OBXVR0S3EID89rujKdgTcCSATQZt7Qn0FCmbvNNaOmRbhXI9qKC9+EFWJcxCHMHn
	u9upJMOijWvTTsDV9NfHIXYp/2jB9QluBOfVvCcXJy+0HngHvvKA==
X-Received: by 2002:a17:902:f681:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2cf34a35445mr66641645ad.44.1784365794988;
        Sat, 18 Jul 2026 02:09:54 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm24285495ad.80.2026.07.18.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:09:54 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v7 1/3] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 17:09:28 +0800
Message-ID: <20260718090931.724303-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718090931.724303-1-bestswngs@gmail.com>
References: <20260718090931.724303-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[The defer-to-workqueue approach is by Tung Nguyen, suggested by
 Jon Maloy on the thread as the replacement for the item-less bulk
 approach. Since the RFC only exists as an inline diff in the thread,
 it is folded into this series so the fix is self-contained.]

named_distribute() stamps the last_bulk flag on the tail skb of the
publication list. When the list is empty no skb is enqueued and the
tail access dereferences NULL. tipc_named_node_up() hits this on an
empty cluster_scope, which happens with a node-id configuration where
cluster_scope is populated only later by tipc_net_finalize(). It is
reachable by an unprivileged user over a UDP bearer in a user+net
namespace. The reported crash:

 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_udp_recv (net/tipc/udp_media.c:392)
 Kernel panic - not syncing: Fatal exception in interrupt

When cluster_scope is empty at node-up, defer the bulk distribution
to a workqueue and wait for tipc_net_finalize() to publish the
node-state name, so named_distribute() always runs on a non-empty
list. On allocation failure, purge the partially built queue and
bring the link down so the bulk distribution restarts when the link
comes up again.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607180730.TwVgASDI-lkp@intel.com/
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/core.c       |  1 +
 net/tipc/core.h       |  2 ++
 net/tipc/name_distr.c | 48 +++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_distr.h |  3 ++-
 net/tipc/net.c        |  2 ++
 net/tipc/node.c       | 34 ++++++++++++++++++++++++++++--
 6 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 434e70eabe08..ce164509d9e2 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -60,6 +60,7 @@ static int __net_init tipc_init_net(struct net *net)
 	tn->trial_addr = 0;
 	tn->addr_trial_end = 0;
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
+	atomic_set(&tn->finalized, 0);
 	INIT_WORK(&tn->work, tipc_net_finalize_work);
 	memset(tn->node_id, 0, sizeof(tn->node_id));
 	memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..76768844c808 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,8 @@ struct tipc_net {
 	struct work_struct work;
 	/* The numbers of work queues in schedule */
 	atomic_t wq_count;
+	/* flag to indicate work has finished */
+	atomic_t finalized;
 };
 
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 190b49c5cbc3..b764274df758 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -147,7 +147,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
+static int named_distribute(struct net *net, struct sk_buff_head *list,
 			     u32 dnode, struct list_head *pls, u16 seqno)
 {
 	struct publication *publ;
@@ -164,8 +164,9 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 			skb = named_prepare_buf(net, PUBLICATION, msg_rem,
 						dnode);
 			if (!skb) {
+				__skb_queue_purge(list);
 				pr_warn("Bulk publication failure\n");
-				return;
+				return 1;
 			}
 			hdr = buf_msg(skb);
 			msg_set_bc_ack_invalid(hdr, true);
@@ -195,6 +196,8 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
+
+	return 0;
 }
 
 /**
@@ -203,7 +206,7 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
  * @dnode: destination node
  * @capabilities: peer node's capabilities
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
@@ -218,9 +221,46 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
+	/* tipc_net_finalize_work() has not finished inserting self address to
+	 * name table yet.
+	 */
+	if (unlikely(list_empty(&nt->cluster_scope))) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return 1;
+	}
+
+	if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno)) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return -ENOBUFS;
+	}
+
 	tipc_node_xmit(net, &head, dnode, 0);
 	read_unlock_bh(&nt->cluster_scope_lock);
+	return 0;
+}
+
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+	struct sk_buff_head head;
+	u16 seqno;
+
+	__skb_queue_head_init(&head);
+	wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
+	spin_lock_bh(&tn->nametbl_lock);
+	seqno = nt->snd_nxt;
+	spin_unlock_bh(&tn->nametbl_lock);
+
+	read_lock_bh(&nt->cluster_scope_lock);
+	if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno)) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return -ENOBUFS;
+	}
+	tipc_node_xmit(net, &head, dnode, 0);
+	read_unlock_bh(&nt->cluster_scope_lock);
+
+	return 0;
 }
 
 /**
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..cadf4e8c3e66 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,7 +69,8 @@ struct distr_item {
 
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..4c144e720ac1 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -139,6 +139,8 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
 	tipc_nametbl_publish(net, &ua, &sk, addr);
+	atomic_inc(&tn->finalized);
+	wake_up_var(&tn->finalized);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..f757722d15be 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -111,6 +111,7 @@ struct tipc_bclink_entry {
  * @peer_net: peer's net namespace
  * @peer_hash_mix: hash for this peer (FIXME)
  * @crypto_rx: RX crypto handler
+ * @work: work item for bulk distribution of cluster scope publications
  */
 struct tipc_node {
 	u32 addr;
@@ -145,6 +146,7 @@ struct tipc_node {
 #ifdef CONFIG_TIPC_CRYPTO
 	struct tipc_crypto *crypto_rx;
 #endif
+	struct work_struct work;
 };
 
 /* Node FSM states and events:
@@ -303,6 +305,7 @@ static void tipc_node_free(struct rcu_head *rp)
 #ifdef CONFIG_TIPC_CRYPTO
 	tipc_crypto_stop(&n->crypto_rx);
 #endif
+	cancel_work_sync(&n->work);
 	kfree(n);
 }
 
@@ -393,6 +396,19 @@ static void tipc_node_write_unlock_fast(struct tipc_node *n)
 	write_unlock_bh(&n->lock);
 }
 
+static void tipc_node_dist_bulk(struct work_struct *work)
+{
+	struct tipc_node *node = container_of(work, struct tipc_node, work);
+
+	if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0) {
+		u32 bearer_id = node->link_id & 0xffff;
+
+		tipc_node_link_down(node, bearer_id, false);
+	}
+
+	tipc_node_put(node);
+}
+
 static void tipc_node_write_unlock(struct tipc_node *n)
 	__releases(n->lock)
 {
@@ -424,8 +440,21 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	if (flags & TIPC_NOTIFY_NODE_DOWN)
 		tipc_publ_notify(net, publ_list, node, n->capabilities);
 
-	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
+	if (flags & TIPC_NOTIFY_NODE_UP) {
+		int rc = 0;
+
+		rc = tipc_named_node_up(net, node, n->capabilities);
+		/* Defer bulk distribution to work queue */
+		if (rc > 0) {
+			tipc_node_get(n);
+			schedule_work(&n->work);
+		} else if (rc < 0) {
+			/* Bring the link down to start over bulk distribution
+			 * when the link is up again.
+			 */
+			tipc_node_link_down(n, bearer_id, false);
+		}
+	}
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
@@ -564,6 +593,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	INIT_WORK(&n->work, tipc_node_dist_bulk);
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
-- 
2.43.0

