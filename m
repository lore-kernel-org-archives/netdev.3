Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613C2D12EC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819823; cv=none; b=fxqSvFCrEaq4/dJAzza1guEMKqa/7wFhXOZOd10Ay3pU9/6C4aJOxLtN/pKklN+svTBDszCec593XKEs2FBsxKVHRFyq6WFe7tRL/M/jmf2udmf0GmJmCUZI0GYVE/t/EDsg3/nOLmPJaUPLqXCWxlWkIvqnOtvLB8yctke4LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819823; c=relaxed/simple;
	bh=8Y7JZ/9KeV+f5YzC1zDml+qR+atE8hzkYH3mXgwAZLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VI87kKwP5ZEVxciS+UiwLGc6uqdR2C0S8biuO0O4sjojBknR5TzegIRaFST3Eppmy60f6NFP4pl1fugqo75RdlYEpvm/vVIQvFmbh2N5NNI/cyQeA/rH2M7fMgQqr2vXfPnyN6AkkrvRv3D4uw5m+5nR79MqoqDzy+UjpwU25vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukL8U+I6; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukL8U+I6"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so29212375e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788819819; x=1789424619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zCQLPwejd9kneAE29OCqj++bBUuNyPXeUmci722Ghtw=;
        b=ukL8U+I60IU3XshPrhcTojuwYqiJ67+SeTvIstWmo7enwRPyVcEwOTGXBvwOw3IewB
         mnzyDN3/Fu1LhrYL3teAgCGHTqOnQKRtSTozZUzMrbj7QMZz6bjqeQz/5fWkOhBui2QW
         VDdB/DNZtvbESHE0Z/gJGZ/QAqnRwCSIK8Ue2axW3vNizBE2Dy+3E414yk6cFczA6ZjT
         c37TAKv9MwWS2lVPGehvfI387/bpeCowBdCIrVSUn1t/EcvISavlDFpcj6OYGorIZVQu
         IcvtIIw9oPb+en4w7LbYlHL3IsMSOuNLmFTqnNiJ9A937Z22DgTwxFIhMyQqCkT0Q7f1
         82xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819819; x=1789424619;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCQLPwejd9kneAE29OCqj++bBUuNyPXeUmci722Ghtw=;
        b=T9T2nsqkAFUWR39OvPRZTn2hZ2WcJ4srjEIrCxkOxA4PlE9I+Bj0ePcaM8I/P3Lfi7
         7qPoGqbA0sERQqgQ5MHiGxdFsj2d/rEFlT9vw33QXEPlBlhdW62G+Sh6kbFnrpIVuDBR
         dPgAsTN6EgZqwTy6aDY8C51XWEC1LRjYdL1pPOoH4cXqzlQWi8p1g8QLA21vHxq5sSuk
         BgKTQ5Tf4o1TMO44J2wjAR4i4PdKlF3sT+7K53NQLoGHyFT5Kv0sQX0YKwV2TVYum2C0
         zaopIUvoJnwrCzpzVgYwoMTkOUn2mEiD+lbTz2HKa5jMu11Eu36bF0orx3iz3xb0MaEs
         yClA==
X-Forwarded-Encrypted: i=1; AKwUvBwN4gjIFA93vnG2c621cumdz2Q9IHVNs95Hx/Rm4MXpU8SFa9VRnKtzNxpaUxctg5RY0yqU5+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lmwWD+itsjjqGwvSaUcT2k0b9VnKClWmILt1T/f0Ydgjt1nZ4I
	50YgwnH6AFELYK45Q39FoLffMxxk1Iqp7LVAuTzbj1zEcXYpYOpeG6zp89COJFpL0su/5nc0rOO
	qYA==
X-Received: from wmbhh15.prod.google.com ([2002:a05:600c:530f:b0:49c:cf3b:c30f])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f83:b0:49d:91:274
 with SMTP id 5b1f17b1804b1-49d00910374mr172516735e9.10.1788819819179; Mon, 07
 Sep 2026 15:23:39 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:21:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907222242.3361174-2-elver@google.com>
Subject: [PATCH v2] rxrpc: Fix use-after-free in rxrpc_destroy_all_peers()
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+c876adfab6362679008c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

During network namespace teardown, rxrpc_destroy_all_peers() iterates over
the rxnet->peer_hash table to print leaked peers without holding
rxnet->peer_hash_lock. If concurrent activity or asynchronous teardown
drops the last reference to a peer, __rxrpc_put_peer() unlinks the peer
from rxnet->peer_hash and frees it via kfree_rcu(). Without locking,
traversal can follow an unlinked peer or race with RCU reclamation,
triggering a KASAN slab-use-after-free.

BUG: KASAN: slab-use-after-free in rxrpc_destroy_all_peers+0xcc/0x150
net/rxrpc/peer_object.c:461
Read of size 8 at addr ffff88811089e420 by task kworker/u8:1/13
Call Trace:
 <TASK>
 rxrpc_destroy_all_peers+0xcc/0x150 net/rxrpc/peer_object.c:461
 rxrpc_exit_net+0x7f/0xc0 net/rxrpc/net_ns.c:114
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:252
 cleanup_net+0x572/0x810 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0x92d/0xe10 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

To fix the slab-use-after-free, acquire rxnet->peer_hash_lock with
spin_lock_bh() while iterating over rxnet->peer_hash in
rxrpc_destroy_all_peers().

Additionally, split netns teardown by implementing .pre_exit in
rxrpc_net_ops to clean up calls, connections, and keepalive work. This
ensures in-flight references are released before cleanup_net() executes
its intermediate synchronize_rcu(), so that peer and local endpoint leak
checks in rxrpc_exit_net() run only after deferred RCU releases complete,
avoiding spurious leak warnings.

Fixes: 17226f124038 ("rxrpc: Fix leak of rxrpc_peer objects")
Reported-by: syzbot+c876adfab6362679008c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c876adfab6362679008c
Link: https://syzkaller.appspot.com/ai_job?id=7fecbeb2-cd9b-4ca2-8149-48663e20b153
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Split teardown and use .pre_exit instead of rcu_barrier() (Eric).
---
 net/rxrpc/net_ns.c      | 23 +++++++++++++++--------
 net/rxrpc/peer_object.c |  8 ++++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index 9a9834145e81..169116735366 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -97,10 +97,7 @@ static __net_init int rxrpc_init_net(struct net *net)
 	return ret;
 }
 
-/*
- * Clean up a per-network namespace record.
- */
-static __net_exit void rxrpc_exit_net(struct net *net)
+static __net_exit void rxrpc_pre_exit_net(struct net *net)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(net);
 
@@ -111,14 +108,24 @@ static __net_exit void rxrpc_exit_net(struct net *net)
 	timer_delete_sync(&rxnet->peer_keepalive_timer);
 	rxrpc_destroy_all_calls(rxnet);
 	rxrpc_destroy_all_connections(rxnet);
+}
+
+/*
+ * Clean up a per-network namespace record.
+ */
+static __net_exit void rxrpc_exit_net(struct net *net)
+{
+	struct rxrpc_net *rxnet = rxrpc_net(net);
+
 	rxrpc_destroy_all_peers(rxnet);
 	rxrpc_destroy_all_locals(rxnet);
 	proc_remove(rxnet->proc_net);
 }
 
 struct pernet_operations rxrpc_net_ops = {
-	.init	= rxrpc_init_net,
-	.exit	= rxrpc_exit_net,
-	.id	= &rxrpc_net_id,
-	.size	= sizeof(struct rxrpc_net),
+	.init		= rxrpc_init_net,
+	.pre_exit	= rxrpc_pre_exit_net,
+	.exit		= rxrpc_exit_net,
+	.id		= &rxrpc_net_id,
+	.size		= sizeof(struct rxrpc_net),
 };
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index fa9a406e1168..faa2983638b2 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -454,6 +454,12 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
 	struct rxrpc_peer *peer;
 	int i;
 
+	/*
+	 * Prevent use-after-free if a peer is concurrently unlinked from the
+	 * hash table and freed via RCU during iteration.
+	 */
+	spin_lock_bh(&rxnet->peer_hash_lock);
+
 	for (i = 0; i < HASH_SIZE(rxnet->peer_hash); i++) {
 		if (hlist_empty(&rxnet->peer_hash[i]))
 			continue;
@@ -465,6 +471,8 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
 			       &peer->srx.transport);
 		}
 	}
+
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 
 /**
-- 
2.55.0.1003.g10538fe699-goog

