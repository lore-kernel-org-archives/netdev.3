Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCE2E7BD3
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532506; cv=none; b=UNg+TsI6Bhp4p8e6eq7z0amhVAQx1067LkBzUb6Jcljd0tF8cnlYlwU3/jgWkS6t54gZR0d6ajNtA5BMhgUtp75tVH91f2yo2IMVIq/mjlweB4gVU/gf+UfmaaWdNxwkenREg4aAPOP5g6tNPD/zWVo8Z78l+wnURE+dKwTFJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532506; c=relaxed/simple;
	bh=VnksSJKPRCXI/vrcndYbIPt3bVkviDrdnJUbyS4gv74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRF8A8k3+RccMmhT7yNwhdsyLQ2guekTVhmt3IZC4qWDCkhREnwVBSdO2Beo6m3nf5ZaEzPwNrWUyPtoShqcrtmawXYIWXNaTX1pnGEDRjwS7ShKMJmyq/gfQN0rSenJ6MNZQByQpGwsLuCxGIs2s1xv5ewanKBijBIIYcjM0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8Q1zjYq; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Q1zjYq"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14521fc1d76so28835c88.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790532504; x=1791137304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PcQ0jxT47qaNp7QTdGykUGwrxjWzMt3AH/vKw1fjhoY=;
        b=L8Q1zjYqtvY+lHWn4dbMYt63GmYplYEcS57EeM4zRh+O/ibFaEV1QPo7XLR1QbVxfR
         tvqiJBDJ+XhJkd9CrDUzRMm3L9lPp+szth4BzDoaok8n9G5MRYLZjQthW2cp3/J29pkc
         Vb2pDtpDOtwX6pexnc4I2dl35hCrucq77Yma+DT8BILbMuCoeMU/8xmW8DmQe3oRoA2h
         abwOdJiwoNWDnxO3U+MQO50L3y2Rhpr34fBCqDDrJticczvGRgsCOU5wkYdPpLyG/UU9
         L2tjsle74PoPEvCGBVvycpWcwWLcGYZXQNoAUXycUqTEKOOa37/PvpROeCD4uAhfLFrv
         vORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790532504; x=1791137304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcQ0jxT47qaNp7QTdGykUGwrxjWzMt3AH/vKw1fjhoY=;
        b=2Fr3RRiYpyXFRuZotatLXEqBeWILY4gUqE0esIl3/b3tMRizb1s0StR2dDqY97l4w+
         SKKESYwHmh8CDxafMwqPhKKA308MTblbezI/xdLGRmUb3R5Yx6rrK6HWwl46oQuGDBZV
         mbwhEu2pzMsL/T0eZZMsSH192fxrwvt/mkOQnlT5uY/W0aK/Vdh812weSiT2HedQ1Bpc
         kb3K+kACCO0+231qO0gE8Jpn8e5trrCOlWePmyX6T61uicMnBagOgMOVSNcuDxO5Y6VL
         ipmM4WEdGNDKl1XScgRnZngLaryle9Q1ooXr03ynRyRdirwISXcg5Fj8wyb9zb8zw7vx
         VjmA==
X-Forwarded-Encrypted: i=1; AKwUvBxHFUFQvg4b5+YCPiEWbGydWPFPqIySnjRjZbXkTnz3gFqsW6/t2lb3r0MnsWs5eSF4NT0RTrc=@vger.kernel.org
X-Gm-Message-State: AFuF++lDsLZPGITidGNMmuWAtneRMNe49zFBctLZnFR4Q5LemaNrWhPx
	t0ES95voZwNnbc1RMjUef9WZk19M2rt7fzOI4DxunNr/g4utmpdEPAbE
X-Gm-Gg: AYBFou1nAwh0TZS5nT6O+fxEYfq/p7Jq8F1nFv50TUBMFD7STqAGIntkttPzNzCaUqK
	z+KDf9aJi6FNZg06jixDG6eoZ6l71QNppSqV4NAtv99hGfPHaDSN6H+HjdZQ+GdsbU+t2Whxllv
	KgmHT2J7KigOKCvf9jpnsG9rjjAjLIYakXgQcRpymF0uw7yHScy33krsGdp4LTfS0Ts5TKmnt6S
	6rszvcabXqqGhxmuAUMjisgKxx6nz7/+R4lXkxTPHFZZHAZxyTaOIeHOlP3WVzzVZ/GEPbDtm8z
	eRu6ffai1p+F6GsWtVyqvVINJfBrIdrYvgLHpSUKKxfQHQNwRvWogSnyXnfb96zyhyaqeBROOKQ
	6Och2glTnxVxK9iK0262P19CkJ5ypv43QRsvS6n/29ZCOxMMKn+oA5wMdA9XyrktiLZRF9J2N7V
	55IWMXgz/4YFw1y90SSFaM9zCnpR+NKCcZfXgROeSgkkct9SGmvcptId+LVP54KuIOINOogpm3X
	ebj/VSYPPVj4/d7a/kJ4mUfeV1CpOeKEhUSQS5Rm877NcMiw33tL+RVkENlNnd9laNwIzI=
X-Received: by 2002:a05:7022:ed0e:b0:149:c766:2965 with SMTP id a92af1059eb24-149c7662eb8mr440548c88.2.1790532503606;
        Sun, 27 Sep 2026 11:08:23 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145adcc5b00sm19502616c88.15.2026.09.27.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:08:23 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net] tipc: serialize publication purging with name table updates
Date: Mon, 28 Sep 2026 02:08:06 +0800
Message-ID: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_publ_notify() walks a failed node's publication list after the node
lock has been released. Its list iterator is not protected by the name
table lock, which is only acquired inside tipc_publ_purge().

CPU A can save the next publication before entering tipc_publ_purge().
CPU B then takes nametbl_lock in tipc_named_rcv(), processes a WITHDRAWAL
for that publication, unlinks it with list_del_init(), and queues it for
freeing with kfree_rcu(). CPU A advances to the removed publication and
loops on its self-linked binding_node, stalling the CPU.

The kernel reported:

  rcu: INFO: rcu_sched self-detected stall on CPU
  Call Trace:
   tipc_publ_notify+0x3b5/0x650
   tipc_node_write_unlock+0x49d/0x5d0
   tipc_node_link_down+0x15c/0x4a0
   tipc_node_delete_links+0xfc/0x190
   bearer_disable+0x111/0x270
   __tipc_nl_bearer_disable+0x1db/0x2f0
   tipc_nl_bearer_disable+0x1c/0x30

Locking the entire traversal would also prevent the race, but would hold
nametbl_lock with bottom halves disabled while purging every publication.
A node with many publications could therefore cause excessive lock hold
times and delay other name-table operations.

Move the failed node's publications to a private list under nametbl_lock,
then select and unlink its first entry under the same lock before purging
it. Concurrent withdrawals can still unlink entries from this private
list, while publications arriving after node recovery stay on the node's
live list. No publication pointer is carried across an unlocked interval.

Unlink before the table lookup to make progress even if the lookup fails,
and acquire and release the lock for each publication. Check the private
list under the lock on every iteration, since concurrent withdrawals can
still remove entries. Keep withdrawal notifications and the final
rc_dests update in their existing order.

Remove the failed-node address argument from tipc_publ_notify() and its
purge helper since unlinking no longer needs a node lookup.

Fixes: 9db9fdd1983e ("tipc: avoid to asynchronously notify subscriptions")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/tipc/name_distr.c | 34 +++++++++++++++++++++++-----------
 net/tipc/name_distr.h |  2 +-
 net/tipc/node.c       |  2 +-
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..34867b69044c 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -227,38 +227,50 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
  * tipc_publ_purge - remove publication associated with a failed node
  * @net: the associated network namespace
  * @p: the publication to remove
- * @addr: failed node's address
  *
  * Invoked for each publication issued by a newly failed node.
  * Removes publication structure from name table & deletes it.
+ * The caller must hold nametbl_lock and unlink the node subscription.
  */
-static void tipc_publ_purge(struct net *net, struct publication *p, u32 addr)
+static void tipc_publ_purge(struct net *net, struct publication *p)
 {
-	struct tipc_net *tn = tipc_net(net);
 	struct publication *_p;
 	struct tipc_uaddr ua;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, p->scope, p->sr.type,
 		   p->sr.lower, p->sr.upper);
-	spin_lock_bh(&tn->nametbl_lock);
 	_p = tipc_nametbl_remove_publ(net, &ua, &p->sk, p->key);
-	if (_p)
-		tipc_node_unsubscribe(net, &_p->binding_node, addr);
-	spin_unlock_bh(&tn->nametbl_lock);
 	if (_p)
 		kfree_rcu(_p, rcu);
 }
 
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
-		      u32 addr, u16 capabilities)
+		      u16 capabilities)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
 
-	struct publication *publ, *tmp;
+	struct publication *publ;
+	LIST_HEAD(purge_list);
+
+	spin_lock_bh(&tn->nametbl_lock);
+	/* Leave new publications on the node's list during the purge. */
+	list_splice_init(nsub_list, &purge_list);
+	spin_unlock_bh(&tn->nametbl_lock);
+
+	for (;;) {
+		spin_lock_bh(&tn->nametbl_lock);
+		if (list_empty(&purge_list)) {
+			spin_unlock_bh(&tn->nametbl_lock);
+			break;
+		}
+		publ = list_first_entry(&purge_list, struct publication,
+					binding_node);
+		list_del_init(&publ->binding_node);
+		tipc_publ_purge(net, publ);
+		spin_unlock_bh(&tn->nametbl_lock);
+	}
 
-	list_for_each_entry_safe(publ, tmp, nsub_list, binding_node)
-		tipc_publ_purge(net, publ, addr);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests--;
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..8debe23469b2 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -74,6 +74,6 @@ void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
-		      u32 addr, u16 capabilities);
+		      u16 capabilities);
 
 #endif
diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..9a218d137c45 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -422,7 +422,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	write_unlock_bh(&n->lock);
 
 	if (flags & TIPC_NOTIFY_NODE_DOWN)
-		tipc_publ_notify(net, publ_list, node, n->capabilities);
+		tipc_publ_notify(net, publ_list, n->capabilities);
 
 	if (flags & TIPC_NOTIFY_NODE_UP)
 		tipc_named_node_up(net, node, n->capabilities);
-- 
2.43.0

