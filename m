Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAD525A71
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868415; cv=none; b=l2tHm2Kf/fzwIO2mDOZG/TfUxlTzJ5DzyQfSV7XRWCVp7JV+WtFylxMheOsNdGq4QRfEqXOMsQiiB0BMSvmsN/UFZWASRGW1dBGbKjDPy2z9gEaDc4uCzEx1m8R1ZxqOLz7haSkKVBlWDiB5eSPL13oM/wRJLTbsxVjOHNDfxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868415; c=relaxed/simple;
	bh=3PMWEkr0DixYfksOluWTzAYqekN9Dx0HNHPDaeb80Xw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RoksW8Q0qp3/s3oex21VSKxLle0wkYKAyuZ/s/vW4hK54HODURDSoKngp7ejQXLP8QPPohn86SNKmW/OtsejoMMAz89LiAewOj7Lo4vozX42OrZMaRaiBJORA14ZPVAxdFZqgiqr3pLj1OhOExAIT4VIO238rSQgfhPL7df8OB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJ59J5Ze; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJ59J5Ze"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so28372115e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788868409; x=1789473209; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FYN9n2CmD6nUaZ2yLwa5to0L9gjk6ua8Q+vply1k9rs=;
        b=fJ59J5Zej2sIzYGTVt9HupfSBabCgBdFFnAfOLuy4EGBMdSe3/dSXuf6MXJiFTeCjr
         zKGco9F9eG3ZZjYYPydEjWkCrC1IVGHCCnJhNBWB+W/Skid68CFXprELi+wuaYCn8RAH
         Dj1so0L/FeFuxqmaYMujA1WeO1IldWnG7zn3u7gHrP8WiJ608dmdBB6AESvlwp+Pl8kP
         QW9+0NUq2MCZWF54wi5FDLGvoJqZHYPUOGQBqHAVn2cD4EL+KwC20QJn5BPbqCgMw8Vn
         oVr7Kd5g1efgdOTZziwGdXc6tjJoWrQ9wJuWWXPJtwgpClufk7P5FKIt5qElpj7wosE/
         7TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788868409; x=1789473209;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYN9n2CmD6nUaZ2yLwa5to0L9gjk6ua8Q+vply1k9rs=;
        b=lZdPkaHUr2sC1mTOKfvcRusAHhjnYEC2GqRlXGcnNtRPoPLsGeDu7nfJ9URBgBSDrQ
         yjrcj5SBAyHGnS0x2XEzCjyei+hgeV8lKVHCRugOoedebqUg0JvsUtIkbmre8ju0RQIs
         1G4ltOg7NMQyU0uZxTdJYz4chaDfxPd5dPWtyKhVkGe1QsJ7z6st8R9r4eeHxzfMOyAc
         nepcX9ITYz2X/5Hmn7twSHzZIVTH07kNq1rwkEZi9J/eCYtjvAlMoVGbNBtWibveX1pc
         hF/YQ93noPR3FQoqI80K8Qgn6/AJ8JfmlDSIe8OZPt430jCpwyKjon5cAykE+3omvjnh
         cB5A==
X-Forwarded-Encrypted: i=1; AKwUvBzC3qvGddgOr4hR9d1t4g5udTrHsLIW5ppFr+8cj6WxjvQQrMulp54dcRmsnzj4MFGnIG2gxRo=@vger.kernel.org
X-Gm-Message-State: AFuF++kJg2Ca9HOwrB1NQsjPBDeTcdMJVT6+IRjCCN9hjoVwvW/YOUfJ
	Bw7ZXDoHHTVTeV2PXkJOoiAXrYC28MR3QTYHYHsb5PSc/P1go7ggR90AGLQSLG0yv+xAhj9XlD1
	kVA==
X-Received: from wmco24.prod.google.com ([2002:a05:600c:a318:b0:49c:e349:ff6f])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3550:b0:49d:7fc:5dc5
 with SMTP id 5b1f17b1804b1-49d07fc61bdmr164144875e9.1.1788868408540; Tue, 08
 Sep 2026 04:53:28 -0700 (PDT)
Date: Tue,  8 Sep 2026 11:52:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260908115324.774166-1-elver@google.com>
Subject: [PATCH v3] rxrpc: Fix use-after-free in rxrpc_destroy_all_peers()
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
rxnet->peer_hash_lock. If concurrent activity drops the last reference to
a peer, __rxrpc_put_peer() unlinks the peer from rxnet->peer_hash under
rxnet->peer_hash_lock and frees it via kfree_rcu(). Without locking,
traversal can race with hash unlinking and RCU reclamation, triggering a
KASAN slab-use-after-free.

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

Fix the slab-use-after-free by acquiring rxnet->peer_hash_lock with
spin_lock_bh() while iterating over rxnet->peer_hash in
rxrpc_destroy_all_peers().

Fixes: 17226f124038 ("rxrpc: Fix leak of rxrpc_peer objects")
Reported-by: syzbot+c876adfab6362679008c@syzkaller.appspotmail.com
Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
Closes: https://syzkaller.appspot.com/bug?extid=c876adfab6362679008c
Link: https://syzkaller.appspot.com/ai_job?id=7fecbeb2-cd9b-4ca2-8149-48663e20b153
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* syzbot reported "INFO: task hung in rxrpc_destroy_all_calls" on v2:
  Drop .pre_exit split.  rxrpc_destroy_all_calls() blocks in
  wait_var_event() on RCU call freeing; executing this in .pre_exit
  under pernet_ops_rwsem deadlocks netns cleanup before
  synchronize_rcu() and device teardown can run.

v2:
* Split teardown and use .pre_exit instead of rcu_barrier() (Eric).
---
 net/rxrpc/peer_object.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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

