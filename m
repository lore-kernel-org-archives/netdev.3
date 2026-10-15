Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EB387375;
	Thu, 15 Oct 2026 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037734; cv=none; b=S8TjK1Er/Ls5U4/+uc5y1OdNdkjcfElmJvEQ95E1qDMclpo+V+qYSM+FfF97bo+pVW40/eEw9t6ryZkh7PbptrfhqwJDm1bcnxi37ctQ0HNtL73l7FiZlFsIz6fuMKtmS7DbXkQ/86f6sqp/ndFXKDmvSYNbgGp92/Ni4E3FeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037734; c=relaxed/simple;
	bh=XvfbHulgW7ti4Hv83+xhax/k+0K29kyiTtzQmOFEovQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ebob4XXrZsD8RMcdHEQbfAUvvVpVmsbVrtk5C3omQS+F18aYizvQ1lnYEky/sUhVGjwvYD9jGjwmXEv5QmA+G+pgLDR6+ARH65kaXrHA/abBTUsGQclU3v/frYpi9BAxegPHgTRYNdb7nYzomVPK1Vbi/eF+3YtRNfMgd6uYvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TcXhPcv1; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TcXhPcv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+3
	LWM48CSKuAAPnaNv8RlHrubR3A4bG/gaVhOMXwVHc=; b=TcXhPcv1RlpVRhUVTM
	/Jwx1yabFcaYGA5xM4viZITnyh4AnX9j/SWxTlfkKbk4jvRUQPC1VZXrxpB+gzJB
	n9tl9H/qJ52l6EKjKjFUZbbMtg1WUDGeGc+OoOLhQZN2BfNSAKPUHlOy4+U0dpWL
	sAq2Mk7b8/ZI9n4KYbE47bM5w=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3PxgtU9BqXkqoAA--.9027S2;
	Thu, 15 Oct 2026 12:14:38 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v1] tipc: fix use-after-free of broadcast reception link at node release
Date: Thu, 15 Oct 2026 12:14:35 +0800
Message-ID: <20261015041435.33561-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PxgtU9BqXkqoAA--.9027S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1fCr18ZFyUtr13GFy8Krg_yoW5Kw4UpF
	W3W39Iyr4DXr4F9r4kt3yxGa409F43XFW3G3409FsrArs8tr4Iqrn2gFy2gF9YkFs29FWU
	tF4UK347CFs8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U01v-UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+w6ukmrQUy7PsAAA3x

When the last reference to a tipc_node is dropped, the node itself is
deferred to the RCU callback tipc_node_free(), but the nested broadcast
reception link, n->bc_entry.link, is kfree()d synchronously in
tipc_node_kref_release(), before call_rcu(), and the pointer is never
cleared.  Readers that obtained the node from node_list and then
dereference bc_entry.link deep into the link (tipc_link_name() in
tipc_nl_node_reset_link_stats(), bcl->name/stats in
tipc_nl_add_bc_link() on the link dump path) therefore touch freed
memory although the enclosing node stays alive for a full grace period.
The sibling per-bearer links get "kfree + NULL" under the node write
lock in tipc_node_clear_links(); the broadcast entry was missed.

The race is reachable through the node cleanup timer: once a peer has
been unreachable for NODE_CLEANUP_AFTER (300 s), tipc_node_timeout() ->
tipc_node_cleanup() unlinks the node under the write lock, and the
final tipc_node_put() at the caller runs outside node_list_lock, so the
kfree executes in timer softirq context, concurrently with genl dump/
reset walkers that hold only rcu_read_lock().  (A netlink "peer remove"
cannot race those walkers itself: tipc_genl_family has no parallel_ops,
so all doit/dumpit calls serialize on the global genl lock.)

Reproduced in a QEMU/KVM guest running v7.3.0 with KASAN and
PREEMPT(full): 10 TIPC peer namespaces on veth bearers, bearer removal
staggered so the 300 s node cleanup timers expire while other tasks
loop link dumps with the broadcast filter and reset-link-stats lookups.
KASAN hit within two cleanup cycles:

  BUG: KASAN: slab-use-after-free in strlen+0x85/0xa0
  Read of size 1 at addr ffff88800b54a004 by task poc_eth/371
   strlen+0x85/0xa0
   tipc_nl_add_bc_link+0x2f9/0xd40
   __tipc_nl_add_node_links+0x10c/0x140
   tipc_nl_node_dump_link+0x8d5/0xd50
  Freed by task 0:
   kfree+0x121/0x380
   tipc_node_timeout+0xa33/0xcf0
   run_timer_softirq+0x144/0x250
   sysvec_apic_timer_interrupt

with the freed object being the kmalloc-1k tipc_link allocated by
tipc_link_bc_create() during peer discovery.  The same defect fires in
strcmp() called from tipc_nl_node_reset_link_stats().

Move the kfree of n->bc_entry.link into the tipc_node_free() RCU
callback so the broadcast link lives exactly as long as the enclosing
node.  All readers are covered: the netlink walkers are inside
rcu_read_lock(), and the packet reception path reaches the node via
tipc_node_find(), whose kref defers kref_release itself.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: d25a01257e42 ("tipc: fix crash during node removal")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/tipc/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..fdc679fe2d91 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -303,6 +303,7 @@ static void tipc_node_free(struct rcu_head *rp)
 #ifdef CONFIG_TIPC_CRYPTO
 	tipc_crypto_stop(&n->crypto_rx);
 #endif
+	kfree(n->bc_entry.link);
 	kfree(n);
 }
 
@@ -310,7 +311,6 @@ static void tipc_node_kref_release(struct kref *kref)
 {
 	struct tipc_node *n = container_of(kref, struct tipc_node, kref);
 
-	kfree(n->bc_entry.link);
 	call_rcu(&n->rcu, tipc_node_free);
 }
 
-- 
2.43.0

