Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E530F523
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366759; cv=none; b=B5QuzWF+o0otmchwLtt/yne3RIdiIlmre1n7hGeS2wrNWd3+EpCDQS0GsSUqWI6jmUZfB6sO+vSsCuAlICQmMDDfwvIf4vg9Po2s6j4rQtyhXbQHrUpHhMgoEs+EnmJ8KiaCHesrWz+wuguiiyH0cZVQ2L7LJr8xwmv/AlBkHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366759; c=relaxed/simple;
	bh=3ib5ApOgq7WvxdKHHcwpGa+OpYhAocskuigSw9bOvG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgvjPearNPH5mdn/K6zZPv56qzS1Yk7WjUfJtSXFMj7eXUbuGbOrcLlfBCfzeRlGLMxTIhpr3XY43RHSOqvdfhuGVtJ1zm0jc4rfue3rE/8Ax0MQSzgPgiT2+OWGn7RaiHOAr6CTExf9Y/F0IxcFKnPHlof9DXIpVCvsa28wRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utl6HnP3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utl6HnP3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845c92bc464so4934063b3a.2
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366757; x=1784971557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy5Q7DuXxlC24c9g8BgO/1BB4Q911W5wONAe5k+1hIA=;
        b=Utl6HnP394tw1DwumP2LJ8d5E+DaWr+ThDR2Paj2apLWuS9iu+iw2J+3m1to3Eb7Z5
         HTGsTCAR++zHByZrLhNR0bRWmrpkzyTUf58ekR17WB364yRyF9NXD77Uhgsx1PQxgHZL
         B/iEZZ1kZZdy/vQ+rJV2X5kpqACoSDu9VC5fdWY0aOxkADc5heaC/NQL1pb3RSeBDA7s
         /TNOkQgH3CgAOayzUYw15pCDHoyh2aoGBqx5nSaF9ZjzwHIiraF0cYBQM7E8li8KV9mY
         w3Kqu3UZpmrPzyhS6fRY7E3xZD6B8I0YvUMcBeE1Y6XDLoBjaQO+bW53gZ64y1d70v/q
         tPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366757; x=1784971557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jy5Q7DuXxlC24c9g8BgO/1BB4Q911W5wONAe5k+1hIA=;
        b=ObNCDuz6kgtE8ru7vLk1EcoiuQOyHRXh9PS2xpsnp0IgelQQKv/yBvyZt/T7AX2vD3
         MntgvCMwHqpW8Y8iGLLoTYS2XXI9zRsfL1c3U2w8EB0vbkX3nY2UrxoIk3aOwu++pYGU
         uVeO2BWWPbq8WozVgjxqHMaKBAe3uEa5qO5tX82NOoPArfcN0wp/7c1jYdv2spwG33y+
         2V9K18yAuEK3RTJiNbdk91SYDo/lXDCMtiWkLlT352lRsi8S+8wrkvX63zTV0LDoYJVY
         idEy8I/SG7LTLDApMdtAwAVa4MOScnuBA82oo9RL4xKu+xN6y7p+U7PBmFSrj7elAG1Y
         ApPg==
X-Forwarded-Encrypted: i=1; AHgh+RqKxtrBs+f2GiA78Bh2nhmqokTmNrbUjI4/RPTD1prIA2RMGZyge02sY4YQyKMGWuLJIMdRDrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1Mw0JhYeEr2I2oNAGL/rrkBhZ88c8vdBWmREhfs1xImr2Pjj
	8/fR3HmYgNu8kgfgX75R7fFMKicaqV+31Gu09Lsro9zARq2ZNoBGcy7d
X-Gm-Gg: AfdE7clOPR+dQ/012WrknmPa8/ZKD4AbpNFzR2xX01PZQRlsStgsJzgNWl4W8MK25JD
	w+jNYVDJFKfao9BmewyP1LI1TsLxqG2KBUzFt3qFj8o+r+WiPWSWS9fOpl7bDWyXWmNhsOqH6Rf
	3Z4dbFvg3Ys/31TVceHfsEybPCKrStm5AVtoybRWQQYrTmPeTjGgN6hpoB/jMQD3OmYLS+wDYtR
	H5gJD5+fqW+O83nq5Rf0LPCS+ggExMqFGtdZhGum0War80aH4egyn4H+OA4ki9dyelOre4MmsxC
	JLDjBTrTTn7T/1cmIBXTs1aeuYz67cpbY9d8YSrJjYTrZvXd+IZiHCbw7qBm1zdlHrDKykfZWk7
	AfVIwtShJVQBTTrS7xCncgKbTBgnXOy9CabpsFR+GB76OJgbBbIdn5P3KkPF6GLzv+tgLkgjHEv
	GQC5J1qb331Lee84uz2xdszIQ51ky0mP+qP2AMIgggnVR9Glbj
X-Received: by 2002:a05:6a00:1d96:b0:848:732b:6b1c with SMTP id d2e1a72fcca58-84c2954d6femr5838557b3a.60.1784366757493;
        Sat, 18 Jul 2026 02:25:57 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.84.186.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c30fb62fesm1950464b3a.29.2026.07.18.02.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:25:56 -0700 (PDT)
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
Subject: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sat, 18 Jul 2026 17:25:41 +0800
Message-ID: <20260718092544.785289-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718092544.785289-1-bestswngs@gmail.com>
References: <20260718092544.785289-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[The defer-to-workqueue approach is by Tung Nguyen. He posted it
 on the thread and asked us to test it, as the replacement for the
 item-less bulk approach. Since the RFC only exists as an inline
 diff in the thread, it is folded into this series so the fix is
 self-contained.]

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

