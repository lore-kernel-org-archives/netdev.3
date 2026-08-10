Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E302348C7D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357316; cv=none; b=HJtwOD/5kWHv6rdu+A4fBKb0SumLT+8YKoqGiTMZclV11SBU2Mv12GYxCdee7CIohXUWp0bxBJfFxXbu+5enuWOvkeGrfSVv+1DVyHG1102/+IZ5Ku4L6bcOcNQ7svPzBOkNBW71fxpDjS4Rm5MroV+qtWatkQZfjfR1RY4x5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357316; c=relaxed/simple;
	bh=N0a0VyfMDuAZFQ4HwZdfzk6ZPA98cYPKeprLlO+KLrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLma4Dd3IE+rrJKWKqBL0u09pWCpWJ0w61qaDLunYbvbgLAhIUtmPI9igx6o8BwlUDp9rUFOjHlaf1KV2dD/AII+CvL6FuByhJvibsdm3UOhfGlW5g/d1CWskggG4kmj8O/KzNpY1PgINYD701m/lJtkwVSAeB9I6z/AhaRGMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIxMKHTe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIxMKHTe"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1229735a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786357315; x=1786962115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a8TnDdD7JeBKEvlgDXkEdPPoGn4jr50a8UvM6DK5uhI=;
        b=MIxMKHTeioRFfOUA2N2UKplwfjzLeW8cSNGM1Lev+vAM6VwRzTiQ3AvSK8XymmntLl
         dpRuQb7SwKXn+bA97u09fy1mxyeso6fjSeAr90I8ayxnCrd8BJjzf0IBY3JYIWr8TLl+
         AVW8RzoK5zwRG6YtJrSLLV6jzhgO5ViahTQjORqC5zTwRiwpkOxK5ROMI7Qrf35sF0VK
         6czyxFjytYIHHqxAfiys1GHdnQc9xh8eTfGQNWt0lwisnkKiAq8INxQIagsExRYMmpOT
         qMX4uz7FQkT8opUAuXkg+uINjSQEYnSemat2VR8LcBUczbVYo8QXCeulru1MTjwuSB9x
         enMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357315; x=1786962115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8TnDdD7JeBKEvlgDXkEdPPoGn4jr50a8UvM6DK5uhI=;
        b=Cfs3BHlF0u+zcvLhZjzC+2VsWjddbhNtkeKg+WpwvI7itOV5HU37ZyjJW0thq5yNW7
         EInS16PrdSYESz3p+1EqbanJCHQElyRVRxgUWP/Um91UW+gx1cxCOSfb4yOyc98yAt/8
         hl3FeB3MHFAqxZyLsEY0r/56FxwQSeayCrgzs0piPsRJtOF26AZzY2j9QTlx64j1wYwC
         BwwtFxPJe61oZXqlYZoJ5QUwvZ4uyw1xcrSXqGKSQegZYz/q6hNUbXKv12c0pg/2rHI/
         g4LznvQtz4m9bn6RUSqhqgR6eS+N7stFj2cBqyiJOI27SjjjDFUeKz1PUuSjMmgUF/Zl
         qJ4g==
X-Gm-Message-State: AOJu0Yy2v0rclnuUQ/O4aM/lPxJ8HhZLvjx2etBQM7nC3YHk3GAIlxze
	idmEe7ikePq+4jSm1n0WhQY555/3J7J77FPSNma7SXllkwhE85K9/ys/v6GLKMRpYmgTyQ==
X-Gm-Gg: AR+sD12FAiteasT9zMYVOSasw2qFg6EGHvAE7qDCGCdxLbHo/88ptHra1QOGowujyx4
	YTNIFHfM/SY0EAGha7/iEtovh22faelN2ZL0R1jtm9fGztzxyHKjHysT5nrZ9JwGj4RpkZXU9Z5
	/rzLE30n/nEKTHgt/Xm4Bd7G5Kpnc8dCAXiczkK+4Z57YjFgTTgP3aZgCNsvzMyrfE5g6+DoEkj
	+OxhpLlL02AXn0uml51rOxxz5sD9+ynYzOUBsgTZCbQebyG8vrrRwT44dndGQ73FScQ8m309H1K
	VuIn+WX0nmbBEUaZklGLTsWSYpO4QWPFtMCZ1fLmJjGMvznhtVtSEDOs8umSV1YqP8/NUPlY8Ne
	5C+Lgq9bPEl02WggGzh4aMbKhCu0IHyzCPxMQZ/QRuPjTzbRNcfLr6dqLmNQmu8cKSP9lzMC45h
	1VzVhjV7ob8C4o2hT7ndxZhlt/c+i698CzVMc4vvr0OlMsw8ajtQqd82KgFsLUJ5Rorfw1EWRiH
	E3lZqL0HfvFwWOPTBSWw5wnJYc8NnpP+t0m3g==
X-Received: by 2002:a17:90b:33c6:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-392845e20b2mr8225931a91.1.1786357314667;
        Mon, 10 Aug 2026 03:21:54 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b1389e1fsm6423998a91.0.2026.08.10.03.21.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 03:21:54 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] tipc: read le->link under the node lock in tipc_node_link_down()
Date: Mon, 10 Aug 2026 18:21:38 +0800
Message-ID: <20260810102147.48191-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

tipc_node_link_down() caches the link pointer before taking n->lock:

	struct tipc_link *l = le->link;		/* unlocked */

	if (!l)
		return;
	tipc_node_write_lock(n);
	if (!tipc_link_is_establishing(l)) {	/* deref l */
	...
		tipc_link_reset(l);		/* write into l */
	if (delete) {
		kfree(l);
		le->link = NULL;

The delete=true caller frees that very object under n->lock, so the lock
does not protect the cached pointer against it:

 - CPU A, delete=false: tipc_rcv() on TIPC_LINK_DOWN_EVT, or the link
   supervision timer via tipc_node_timeout(), reads l unlocked and then
   dereferences it under n->lock;
 - CPU B, delete=true: netlink TIPC_NL_BEARER_DISABLE -> bearer_disable()
   -> tipc_node_delete_links() -> tipc_node_link_down(n, bearer_id, true)
   -> kfree(l).

The link is freed with plain kfree(), not kfree_rcu(), and for UDP bearers
disable_media() only schedules the asynchronous cleanup_bearer() work, so
its synchronize_net() runs after the links are already gone.  An in-flight
CPU A that has read l therefore dereferences freed memory once B frees it:
a use-after-free read in tipc_link_is_establishing(), and a use-after-free
write via tipc_link_reset() on the establishing branch.

The following trace was captured on 7.2.0-rc5-00284-gaf39eb111ce6:

  BUG: KASAN: slab-use-after-free in tipc_link_is_establishing (net/tipc/link.c:285)
  Read of size 4 at addr ffff88802e2aa068 by task swapper/2/0
   tipc_link_is_establishing (net/tipc/link.c:285)
   tipc_node_link_down (net/tipc/node.c:1076)
   tipc_node_timeout (net/tipc/node.c:843)
  Allocated by task 9549:
   tipc_link_create (net/tipc/link.c:490)
   tipc_node_check_dest (net/tipc/node.c:1279)
   tipc_disc_rcv (net/tipc/discover.c:252)
   tipc_udp_recv (net/tipc/udp_media.c:389)
  Freed by task 9549:
   tipc_node_link_down (net/tipc/node.c:1084)
   tipc_node_delete_links (net/tipc/node.c:1320)
   bearer_disable (net/tipc/bearer.c:414)
   __tipc_nl_bearer_disable (net/tipc/bearer.c:992)

Move the le->link read inside tipc_node_write_lock(), so it is serialised
against the kfree() in the delete path.  A racing teardown now either has
not run yet, and we see a valid link, or has already run, and we see NULL.

Fixes: 73f646cec354 ("tipc: delay ESTABLISH state event when link is established")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

v2:
 - Take &n->links[bearer_id] under tipc_node_write_lock() as well.
 - Use tipc_node_write_unlock_fast() on the NULL link path.
 - Decode the KASAN report with scripts/decode_stacktrace.sh, re-taken on
   7.2.0-rc5-00284-gaf39eb111ce6.

v1: https://lore.kernel.org/netdev/20260731102145.33622-1-juny24602@gmail.com/

 net/tipc/node.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..683a136e53ef 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1061,18 +1061,23 @@ static void __tipc_node_link_down(struct tipc_node *n, int *bearer_id,
 
 static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
 {
-	struct tipc_link_entry *le = &n->links[bearer_id];
 	struct tipc_media_addr *maddr = NULL;
-	struct tipc_link *l = le->link;
 	int old_bearer_id = bearer_id;
+	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
-
-	if (!l)
-		return;
+	struct tipc_link *l;
 
 	__skb_queue_head_init(&xmitq);
 
+	/* Synchronize the link lookup with bearer teardown. */
 	tipc_node_write_lock(n);
+	le = &n->links[bearer_id];
+	l = le->link;
+	if (!l) {
+		tipc_node_write_unlock_fast(n);
+		return;
+	}
+
 	if (!tipc_link_is_establishing(l)) {
 		__tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
 	} else {
-- 
2.55.0

