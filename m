Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CD40D592
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493348; cv=none; b=EYXGPwMNg7qr99r06bK0ktuWIKSJjLsb6MqefQCTBMc8ryNtqC2HKYgEUXrGErDdbl7heT7vajMr2etpRvZsSf3RLFOppCl/g5X2Y2y5T6DFgDvSfBgmSoFbYVmsEDW4+kBUyFjUsCovJHWRo6t0WrX7W6ScuJJ98HcklYOsToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493348; c=relaxed/simple;
	bh=4VcKVUvyWU1HN+BHXSPwtW/RIhweQaUqjTDSxbgd9kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nP56Er5L4Z+yEZeDmjhJbLJSB4BqyxHjMDso9tO6kEXWS6JM2D62PjVxFtuxDNfDmDGXa+AiGdtrc+twX4lf51K6wY1Z28Ph3+RFN4ymyZ5G7TAyKs7Rit/Bp1Y7ax5KOOUMMHI9oNODhhDSXkT1BcwsLCNHKnUo7pqDqrQJctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeMl+8G4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeMl+8G4"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84830c774a0so864605b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785493334; x=1786098134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zamWU58jYttudwlzY04AXQugAWUn6boGIsckkOCHePs=;
        b=XeMl+8G4DG5osSRdqkbfOUX0OZAoJqJAYs+qOsS0oD0vF8p7sNMiLUUySymECYM6OJ
         tsaUeK/FtLBxNuzrWTpUmVxKLaAOP8StaOUAFJjfGn0wka1oq5Ilqr61bV0EGugK5vV/
         CEExu4Ss7+JBK+lqFZRPyhVXjDTdCBzxy/1Ij37t6JSgIwpXNoAfeyovrV855a0CpjUw
         m12N2R6vKOGCA0c2C6d623++0c7mgxjvyM+0fGSi1bJsxDBbC9ZVgEg4ZUWc8QiNjgZJ
         6HQeJsATGQlT3Ph4fF44SY8TAjOvkFwCcJ/njTHxIZwhPZKPkrDm1cTLmC0zDSLOkJ/a
         /vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785493334; x=1786098134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zamWU58jYttudwlzY04AXQugAWUn6boGIsckkOCHePs=;
        b=UfETl/vteDKbd+22aZhCEU/A/OqsZJZmCuTsosBQVa2uKnLOXxe18kECkJgcBNRW1W
         1OheuFRVkw9mRdVQKhcGh6ax8BGMn6xFIG3FtpVMl4cnNFurC/BV1LRN2Z3XxB6MgoZf
         LKIi5IFKsF0bbzyPBJysXXZzmSw1vTERcWltrJ+ncWlLEqzm615Bk7JtzXqxRM01iVqd
         GMF/gU4iT4wcBMWA0HFBT+DK0eIsAProDBNJzBYHDffVcpY2uKxUlhYmFtue5MtOEb/S
         1DxMBo9HqFhcUdD069Plvsk9FSdYmt4aPppP/riQrt09zV4n4tvl4BcgOMl7FWSMaBJ5
         FpPg==
X-Gm-Message-State: AOJu0Yw4Je29j937hwuQh8jqfrQ201dypiWAN+XVcB3OcLcUVo5Tcvzg
	c2Fb8m1S8KxhtIbLzSSOTbumH0vVcVLQEqbQiPUe1zBmwArohyex7Z/3e1gFftqR83XlrfAh
X-Gm-Gg: AR+sD12X9kkDnmd3iYLq6RXyZqaGvmhTJOTQvj6RH1UJfAFJAoRzDwlzfvdh3HRrwB9
	ijf0QaqwvuybZeQP4tWb8JsPLpRfes6y8QrfusJ4AyQOT1ZTHJs9Rb6DLJMAFWM9Vf6yoweeKQf
	PNjrE7xz/zG/o2Zs0VrMHuM5cOY0+zDGZ5FJM8zhEK7vFps1gOVH2V37U+n+Bu+qwixptk6fOjD
	LRTmUVUFWNRlQtpg3/ynvTYVfHbAzEt3CDvaUvTOXBXIFptG5BHX2BktmbZ1fk2GdJaJafkCbYb
	4BwA5u0T+D6FazGSOYAyyXqvdSp/fv1199ovx7nOCiNsaoCdfQVI+K+yXbALRmgiN6C5s0GcL8B
	V+i4stwF7oXXudyd/YWv4iRon0uya7ES+VnmCcU0P+PZU4P45szQVMRdFrrXoxtns3x72wksmI5
	mULx/X22JFbg5fn9dHRwMzRp0mCeQZtx8UXpa7Qcbcat6L0E6CSloxmfyPBbidpULMofQk/rMcu
	SZ2tPM3gv8X2CoYTecJYTbta5w=
X-Received: by 2002:a05:6a00:2d9d:b0:848:4fd9:9a8d with SMTP id d2e1a72fcca58-84ed6f1e5d3mr1251126b3a.59.1785493333569;
        Fri, 31 Jul 2026 03:22:13 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d45afsm265024b3a.41.2026.07.31.03.22.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 03:22:13 -0700 (PDT)
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
Subject: [PATCH net] tipc: read le->link under the node lock in tipc_node_link_down()
Date: Fri, 31 Jul 2026 18:20:58 +0800
Message-ID: <20260731102145.33622-1-juny24602@gmail.com>
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

  BUG: KASAN: slab-use-after-free in tipc_link_is_establishing+0x3f/0x50
  Read of size 4 at addr ffff888111f90868 by task swapper/3/0
   tipc_link_is_establishing+0x3f/0x50
   tipc_node_link_down+0x1a0/0x450
   tipc_node_timeout+0x63d/0xca0
  Allocated by task 7903:
   tipc_link_create+0x17e/0xf20
   tipc_node_check_dest+0x98b/0x1150
   tipc_disc_rcv+0x9f3/0x10c0
   tipc_udp_recv+0x42a/0x7e0
  Freed by task 7903:
   tipc_node_link_down+0x301/0x450
   tipc_node_delete_links+0xf5/0x240
   bearer_disable+0xc0/0x240
   __tipc_nl_bearer_disable+0x21f/0x380

Move the le->link read inside tipc_node_write_lock(), so it is serialised
against the kfree() in the delete path.  A racing teardown now either has
not run yet, and we see a valid link, or has already run, and we see NULL.

Fixes: 73f646cec354 ("tipc: delay ESTABLISH state event when link is established")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/tipc/node.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..918e59362d07 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1063,16 +1063,23 @@ static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
 {
 	struct tipc_link_entry *le = &n->links[bearer_id];
 	struct tipc_media_addr *maddr = NULL;
-	struct tipc_link *l = le->link;
 	int old_bearer_id = bearer_id;
 	struct sk_buff_head xmitq;
-
-	if (!l)
-		return;
+	struct tipc_link *l;
 
 	__skb_queue_head_init(&xmitq);
 
+	/* Read le->link under n->lock: the delete path below kfree()s it while
+	 * holding the same lock, so an unlocked read here could be raced by a
+	 * concurrent bearer teardown and leave us with a freed pointer.
+	 */
 	tipc_node_write_lock(n);
+	l = le->link;
+	if (!l) {
+		tipc_node_write_unlock(n);
+		return;
+	}
+
 	if (!tipc_link_is_establishing(l)) {
 		__tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
 	} else {
-- 
2.55.0

