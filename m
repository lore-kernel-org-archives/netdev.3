Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583791;
	b=zmzeFjJJDzAhiFtgFK77nDH1sU1mvvJguKXKfqg/Z8SM8yfDNqMk2hj5WMy3/pZfA5QV
	 JKmEnSkgRswuIizU/pUV5oKGFbmBNCwb2u8MEaxBl3DyzW4EOEoj1QJ/FfRwfR/QQNvlw
	 SHg9eUbYy2gpZTUGzsxOzFCsE1NYLJTgwTcATPT/GvAVknWF0Kd/hxyu+pT/u56Q2hg4S
	 zXeEdPDYcDVhrHM5DR/BoSVia7CHS9UjulCq8tcFzuX8j26P9HXQlSmbZeoYbdIvP42nJ
	 sITbKX0bzECija2QDP21TNe8YGcY8DSri+cV7DgFJ38CT6PneGZGxXq0kLLaMfdMYrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h68ZztVXIwXeu2dhYSrMqGV7G4gu6LBCbF4OLbwBS+0=;
	b=EBfy2eha4FnTJvVb8Nfch5qTw3ycwLNxz6kgb9p8duNUt7HcrD6fOQ3iKGukl0IE03ye
	 755Xmq2yq7srfYjXxL13b0xARw4snJ6ry7wvp/MT77238zaqirgUiG0B2J4Gf8bj4rTDm
	 h66UUHIPZPyOuv+L3I/AdoQzGK47kcv7ruxGRO3+YN8Idh95C5hMyHlBZx5V8fC9YSKvN
	 NroBccexMlwEvvnZaIePYOVocopMsWeRKNDWe6nSXhHQaHJabCXqzMHqbaMfPzBEjG6em
	 iSg8aQd7huXxpCocDqnma3jn91tpFdCG9rOcVGtlaR5am/IwVgZuptIKjXW20EB52eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EhwJczN/";
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57206606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57206606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EhwJczN/
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so846185a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792583790; x=1793188590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h68ZztVXIwXeu2dhYSrMqGV7G4gu6LBCbF4OLbwBS+0=;
        b=EhwJczN/Ia1SFh4FZe3SLFA7gnPd8q/lUpPSidToCslyWjmPZMy1zTkuIkMc6AMuuF
         jlr+jAX47l/HRiB1+WgMrtkTT5i/A4wWlDl1EhIuBs/NpTUPYqJnt9QbErmFpMAz4zMT
         T5Yu1/inG9W+dgoom+GhE9K4RASGj6oxa9mWOV3+Ci6UVWlJ75TOCGja/t1xooNaN5ln
         sq/H5vaEcRkRh9xQZFZlGT1bB4kYi/ZgxDfP4P/JwjsE6tdche5AZXdOPUACFBIIonX2
         izhZYnn77275FPAMCONI6WcVJMhsIuMVLbou+sRro3P4qxdSqqTMH/pnz4P83NfkOnXp
         U6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792583790; x=1793188590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h68ZztVXIwXeu2dhYSrMqGV7G4gu6LBCbF4OLbwBS+0=;
        b=SKhYs2PFugKqCEE5UxLRnzL+0sBpG0JsLbqZWJSxPIZI2fGTlNJYf97pgC4u5wjqpb
         7rzdSuK8SMbS8E/+b88v4XdAu4m9ZORI475vPVuvC5KvemdGZjcoF724P6C2PL6rVZ6L
         ZKTzTCe5ZBbhoS/X7m13ZofIv4kpYoJRPbl5VKxghASXGeqmf9s3+d3xlFvkpIwCjz9s
         H3sazr2sTxXDXCfe+ITlZ3o0Mh22U/8tZ40k6gQHlhu51vk+VjTKAnGW9Lwqxg3JAIgm
         XOChECCQKL31G5F8u6iQ/XMY4edRxKv/H+i8mlGT9WBCOQwSwdHU1Y/D/v0wzTTGtwlf
         qjMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQzfDsNlxyyJIj9mxJy20BEFjo0IzP246nYt6Fn9Pfx0FS0fA/Q1kaO9/BOI3yiYIFfiH7YEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgzbMVU3g52rj4WBaCYixYIDjxOnuuy21zcRpVEfcI8/K5GL/P
	f+nTzDHmn9Hp5Ncs9KtwEyGv1OhQlRW3DK8Gu3tIr18JpfUCgJXRgYR6
X-Gm-Gg: AYBFou14A3lZ89fyFRht6R5x7nCddSQdgtcXz0fO3l2b6UnxQrDkOMlQmqMrdDVc8Q6
	mbxcl+ylnJLCKAhIzazwmywrXDtMqriR006u5LaQA9TAd9N6rmyY98YzrwyBo7Ll3+nbYB8Fmcn
	VN5VhyPm//QRtDR3ArpvRF23bKkXuPEDzSkfbxnaLGUrYU/xQNsCO82NPtoIIBk7obmxml4Jdl4
	VIPNIlp0qlO86Kp95kN52ouTcVdmE0MlNfgVcAbsmCMdH597zD9MxWsExDOMaT16WYE5PlD8U+J
	DvLLzJGoY3V82VWg2b5cf6grcpWZX1XHj5gcezbg0QWufk3rR8aHhhst0RnWDvlEEZQzd5OuxpO
	E2fHLA6hR+rHE2pSaEu/lFa3ZDTxYjEL5EE1xlqjpoFjw6Hj8wWhsEwxNLZdOMXxHO/Bv+v0cO0
	YGTu0nb2sgWpGOywah6yEyQfkSfwVXUJ6UAXpkFcYepiqm2Fiu3/lPBvCYK4TUMTQgiOT2ByFxl
	FAqSMdJBWr421UgReT8uWqKwvjhwBW2kfZmFpln7sQDODWKRQ==
X-Received: by 2002:a05:6402:46cc:b0:6b3:f05e:fd79 with SMTP id 4fb4d7f45d1cf-6b408eb88fbmr989551a12.21.1792583789265;
        Wed, 21 Oct 2026 04:56:29 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:43::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b40317024asm752675a12.37.2026.10.21.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:56:27 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] lockdep: Keep dynamic key hash nodes in lockdep-owned storage
Date: Wed, 21 Oct 2026 04:56:21 -0700
Message-ID: <20261021115621.3194947-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep_register_key() links the hlist_node embedded in the caller's
lock_class_key into lock_keys_hash[], and is_dynamic_key() walks that
list under rcu_read_lock(). So lockdep_unregister_key() must wait for an
RCU grace period before the caller may free the key, and it does,
with synchronize_rcu_expedited() since commit 7a3cedafccf8 ("lockdep:
Speed up lockdep_unregister_key() with expedited RCU synchronization").
Users that unregister many keys pay for one grace period each: replacing
an mq root qdisc on a multi-queue NIC waits for one per TX queue, under
RTNL.

Keep the hash nodes in a static array instead, like the other lockdep
tables, with an in-use bitmap sized by CONFIG_LOCKDEP_DYNAMIC_KEYS_BITS.
A node records the key's address; is_dynamic_key() compares addresses
and never dereferences caller memory. Unregistering unhashes the node
and hands it to the existing delayed_free machinery, so the slot is
reused only after a grace period, and lockdep_unregister_key() no
longer waits or sleeps. Running out of nodes turns lockdep off with
"BUG: MAX_LOCKDEP_DYNAMIC_KEYS too low!", like the other tables.

This follows Eric Dumazet's suggestion (quoted in the first link) to keep
the RCU-protected memory out of the caller's key, but keeps the key
embedded and uses a static pool rather than a separate allocation freed
with kfree_rcu().

With the node gone from struct lock_class_key, the key shrinks from 16
to 8 bytes on 64-bit.

Keys freed while still registered used to be caught by KASAN when a
hash walk read their embedded node. To keep catching them,
lockdep_register_key() and lockdep_unregister_key() run
kasan_check_byte() on each key they pass under the graph lock, where
every hashed node is a live registration.

On an x86_64 KASAN + PROVE_LOCKING kernel (64 vCPU KVM guest, mq on a
64-queue netdevsim device, 214K lock chains), three rebuilds of an mq
root with an fq child per TX queue wait for 198 instead of 780
expedited grace periods, and a qdisc destroy drops from 24.2 ms to
16.7 ms. The guest's vCPUs are idle; on busy machines each of those
grace periods also IPIs every non-idle CPU.

Link: https://lore.kernel.org/all/0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop/
Link: https://lore.kernel.org/all/atehw5Cn5Ev7Z68i@tardis.local/
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
RFC: this is the alternative Boqun asked to explore in the discussion of
the net-next series that added lockdep_unregister_key_nosync() for
qdiscs [1]. If this approach is acceptable, that series is no longer
needed: no caller has to wait, and there is no new API to misuse.

Open questions:
 - The cap. CONFIG_LOCKDEP_DYNAMIC_KEYS_BITS defaults to 14 (16K nodes,
   ~384KB; 1K with LOCKDEP_SMALL). The number of registered keys used
   to be unbounded, and now keys whose locks are never taken count too:
   an unprivileged user with a network namespace can create more than
   16K qdiscs and turn lockdep off. Lock classes already have the same
   exposure (8K, and every qdisc that carries traffic uses one, see
   a90f6dcefca6d), so this may be acceptable. If not, keys registered
   after the pool fills could fall back to the old embedded node and the
   old wait, at the cost of keeping the 16-byte key.
 - is_dynamic_key() still returns true when debug_locks is off. That
   used to avoid a use-after-free; it is kept only to preserve the
   behaviour.

Notes:
 - Keys freed while still registered are still caught under KASAN, by
   the register and unregister walks; the lockless is_dynamic_key() walk
   no longer checks, since a correctly unregistered key may already be
   freed there. Freeing a registered key and then registering 16K others
   gets a KASAN slab-use-after-free report from lockdep_register_key().
 - The comment above blk_mq_hctx_set_fq_lock_class() in
   block/blk-flush.c says lockdep_unregister_key() waits for a grace
   period; that becomes stale. I left it out of the RFC and will update
   it in the non-RFC version.
 - This conflicts textually with Nilay Shroff's pending "lockdep: Fix
   subclass resource leak in lockdep_unregister_key()" [3] (the same
   __lockdep_free_key_range() call); either needs a trivial rebase.

Tested on tip/locking/core with KASAN + PROVE_LOCKING:
 - lockdep selftests: 395/395;
 - 60s stress: ~700K register/unregister/immediate-kfree() cycles
   against ~840M concurrent is_dynamic_key() walks, no KASAN report;
 - exhaustion with CONFIG_LOCKDEP_DYNAMIC_KEYS_BITS=10: one
   "BUG: MAX_LOCKDEP_DYNAMIC_KEYS too low!", lockdep off, no crash;
 - W=1 with gcc and clang, PROVE_LOCKING=y and LOCKDEP=y PROVE_LOCKING=n.

It is independent of "lockdep: Walk only in-use lock chains in
zap_class()" [2], which makes the remaining zap_class() part cheaper.

[1] https://lore.kernel.org/all/20261019170225.729789-1-vlad.wing@gmail.com/
[2] https://lore.kernel.org/all/20261019170601.805087-1-vlad.wing@gmail.com/
[3] https://lore.kernel.org/all/20260727182312.3750145-1-nilay@linux.ibm.com/

 include/linux/lockdep_types.h      |  10 +--
 kernel/locking/lockdep.c           | 107 +++++++++++++++++++++--------
 kernel/locking/lockdep_internals.h |   3 +
 kernel/locking/lockdep_proc.c      |   4 +-
 lib/Kconfig.debug                  |  10 +++
 5 files changed, 98 insertions(+), 36 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 55c4b152fedf7..c3f318a4e48f5 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -71,12 +71,12 @@ struct lockdep_subclass_key {
 	char __one_byte;
 } __attribute__ ((__packed__));
 
-/* hash_entry is used to keep track of dynamically allocated keys. */
+/*
+ * Only the address of a key matters; lockdep tracks dynamically allocated keys
+ * in its own hash table nodes.
+ */
 struct lock_class_key {
-	union {
-		struct hlist_node		hash_entry;
-		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
-	};
+	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 };
 
 extern struct lock_class_key __lockdep_no_validate__;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c3dc84a7cef26..ba7aa4d4068b0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -217,6 +217,34 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
 #define KEYHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
 #define KEYHASH_SIZE		(1UL << KEYHASH_BITS)
 static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
+
+/*
+ * Hash table nodes for dynamically allocated keys. They live here rather than
+ * in the keys so that is_dynamic_key() never dereferences memory owned by the
+ * caller, and the caller may free a key as soon as lockdep_unregister_key()
+ * returns. Like lock chains, a freed node is only reused after an RCU grace
+ * period.
+ */
+struct lock_key_node {
+	struct hlist_node		hash_entry;
+	const struct lock_class_key	*key;
+};
+
+static struct lock_key_node lock_key_nodes[MAX_LOCKDEP_DYNAMIC_KEYS];
+static DECLARE_BITMAP(lock_key_nodes_in_use, MAX_LOCKDEP_DYNAMIC_KEYS);
+
+/*
+ * A key must stay valid until it is unregistered. lockdep no longer reads the
+ * keys it tracks, so let KASAN check the ones that lockdep_register_key() and
+ * lockdep_unregister_key() walk past under the graph lock. That is how keys
+ * freed while still registered have been caught. Must be called with the
+ * graph lock held: only then is every hashed node a live registration.
+ */
+static inline void check_key_node_alive(const struct lock_key_node *node)
+{
+	/* lockdep.c is not instrumented, see lock_acquire(). */
+	kasan_check_byte(node->key);
+}
 unsigned long nr_lock_classes;
 unsigned long nr_zapped_classes;
 unsigned long nr_dynamic_keys;
@@ -378,10 +406,15 @@ static LIST_HEAD(free_lock_classes);
  * @zapped: Head of a list with struct lock_class elements.
  * @lock_chains_being_freed: Bitmap that indicates which lock_chains[] elements
  *	are about to be freed.
+ * @key_nodes_being_freed: Bitmap that indicates which lock_key_nodes[]
+ *	elements are being freed.
+ * @nr_key_nodes_being_freed: Number of bits set in @key_nodes_being_freed.
  */
 struct pending_free {
 	struct list_head zapped;
 	DECLARE_BITMAP(lock_chains_being_freed, MAX_LOCKDEP_CHAINS);
+	DECLARE_BITMAP(key_nodes_being_freed, MAX_LOCKDEP_DYNAMIC_KEYS);
+	unsigned int nr_key_nodes_being_freed;
 };
 
 /**
@@ -1265,8 +1298,8 @@ static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
 void lockdep_register_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head;
-	struct lock_class_key *k;
-	unsigned long flags;
+	struct lock_key_node *node;
+	unsigned long flags, idx;
 
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
@@ -1275,11 +1308,27 @@ void lockdep_register_key(struct lock_class_key *key)
 	raw_local_irq_save(flags);
 	if (!graph_lock())
 		goto restore_irqs;
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (WARN_ON_ONCE(k == key))
+	hlist_for_each_entry_rcu(node, hash_head, hash_entry) {
+		check_key_node_alive(node);
+		if (WARN_ON_ONCE(node->key == key))
 			goto out_unlock;
 	}
-	hlist_add_head_rcu(&key->hash_entry, hash_head);
+	idx = find_first_zero_bit(lock_key_nodes_in_use,
+				  ARRAY_SIZE(lock_key_nodes));
+	if (unlikely(idx >= ARRAY_SIZE(lock_key_nodes))) {
+		if (!debug_locks_off_graph_unlock())
+			goto restore_irqs;
+
+		nbcon_cpu_emergency_enter();
+		print_lockdep_off("BUG: MAX_LOCKDEP_DYNAMIC_KEYS too low!");
+		dump_stack();
+		nbcon_cpu_emergency_exit();
+		goto restore_irqs;
+	}
+	__set_bit(idx, lock_key_nodes_in_use);
+	node = lock_key_nodes + idx;
+	node->key = key;
+	hlist_add_head_rcu(&node->hash_entry, hash_head);
 	nr_dynamic_keys++;
 out_unlock:
 	graph_unlock();
@@ -1292,16 +1341,15 @@ EXPORT_SYMBOL_GPL(lockdep_register_key);
 static bool is_dynamic_key(const struct lock_class_key *key)
 {
 	struct hlist_head *hash_head;
-	struct lock_class_key *k;
+	struct lock_key_node *node;
 	bool found = false;
 
 	if (WARN_ON_ONCE(static_obj(key)))
 		return false;
 
 	/*
-	 * If lock debugging is disabled lock_keys_hash[] may contain
-	 * pointers to memory that has already been freed. Avoid triggering
-	 * a use-after-free in that case by returning early.
+	 * If lock debugging is disabled, lockdep_register_key() no longer adds
+	 * keys to lock_keys_hash[], so treat every key as registered.
 	 */
 	if (!debug_locks)
 		return true;
@@ -1309,8 +1357,8 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 	hash_head = keyhashentry(key);
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (k == key) {
+	hlist_for_each_entry_rcu(node, hash_head, hash_entry) {
+		if (node->key == key) {
 			found = true;
 			break;
 		}
@@ -6417,7 +6465,7 @@ static bool prepare_call_rcu_zapped(struct pending_free *pf)
 {
 	WARN_ON_ONCE(inside_selftest());
 
-	if (list_empty(&pf->zapped))
+	if (list_empty(&pf->zapped) && !pf->nr_key_nodes_being_freed)
 		return false;
 
 	if (delayed_free.scheduled)
@@ -6443,6 +6491,11 @@ static void __free_zapped_classes(struct pending_free *pf)
 
 	list_splice_init(&pf->zapped, &free_lock_classes);
 
+	bitmap_andnot(lock_key_nodes_in_use, lock_key_nodes_in_use,
+		      pf->key_nodes_being_freed, ARRAY_SIZE(lock_key_nodes));
+	bitmap_clear(pf->key_nodes_being_freed, 0, ARRAY_SIZE(lock_key_nodes));
+	pf->nr_key_nodes_being_freed = 0;
+
 #ifdef CONFIG_PROVE_LOCKING
 	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
 		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
@@ -6674,27 +6727,30 @@ void lockdep_reset_lock(struct lockdep_map *lock)
  * Unlike lockdep_register_key(), a search is always done to find a matching
  * key irrespective of debug_locks to avoid potential invalid access to freed
  * memory in lock_class entry.
+ *
+ * The memory holding @key may be freed as soon as this returns: lockdep keeps
+ * its own hash table nodes and only ever compares key addresses. Does not
+ * sleep.
  */
 void lockdep_unregister_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head = keyhashentry(key);
-	struct lock_class_key *k;
+	struct lock_key_node *node;
 	struct pending_free *pf;
 	unsigned long flags;
 	bool found = false;
 	bool need_callback = false;
 
-	might_sleep();
-
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
 
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (k == key) {
-			hlist_del_rcu(&k->hash_entry);
+	hlist_for_each_entry_rcu(node, hash_head, hash_entry) {
+		check_key_node_alive(node);
+		if (node->key == key) {
+			hlist_del_rcu(&node->hash_entry);
 			found = true;
 			break;
 		}
@@ -6702,6 +6758,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found && debug_locks);
 	if (found) {
 		pf = get_pending_free();
+		__set_bit(node - lock_key_nodes, pf->key_nodes_being_freed);
+		pf->nr_key_nodes_being_freed++;
 		__lockdep_free_key_range(pf, key, 1);
 		need_callback = prepare_call_rcu_zapped(pf);
 		nr_dynamic_keys--;
@@ -6711,17 +6769,6 @@ void lockdep_unregister_key(struct lock_class_key *key)
 
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
-
-	/*
-	 * Wait until is_dynamic_key() has finished accessing k->hash_entry.
-	 *
-	 * Some operations like __qdisc_destroy() will call this in a debug
-	 * kernel, and the network traffic is disabled while waiting, hence
-	 * the delay of the wait matters in debugging cases. Currently use a
-	 * synchronize_rcu_expedited() to speed up the wait at the cost of
-	 * system IPIs. TODO: Replace RCU with hazptr for this.
-	 */
-	synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
@@ -6741,6 +6788,8 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(lock_classes_in_use) +
 		sizeof(classhash_table) +
+		sizeof(lock_key_nodes) +
+		sizeof(lock_key_nodes_in_use) +
 		sizeof(list_entries) +
 		sizeof(list_entries_in_use) +
 		sizeof(chainhash_table) +
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 0e5e6ffe91a3f..f214bbdd9dcfa 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -98,6 +98,7 @@ enum {
  */
 #define MAX_LOCKDEP_ENTRIES	16384UL
 #define MAX_LOCKDEP_CHAINS_BITS	15
+#define MAX_LOCKDEP_DYNAMIC_KEYS	1024UL
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
 #else
@@ -105,6 +106,8 @@ enum {
 
 #define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
 
+#define MAX_LOCKDEP_DYNAMIC_KEYS	(1UL << CONFIG_LOCKDEP_DYNAMIC_KEYS_BITS)
+
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 1916db9aa46b6..cab78d91a241a 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -286,8 +286,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #endif
 	seq_printf(m, " lock-classes:                  %11lu [max: %lu]\n",
 			nr_lock_classes, MAX_LOCKDEP_KEYS);
-	seq_printf(m, " dynamic-keys:                  %11lu\n",
-			nr_dynamic_keys);
+	seq_printf(m, " dynamic-keys:                  %11lu [max: %lu]\n",
+			nr_dynamic_keys, MAX_LOCKDEP_DYNAMIC_KEYS);
 	seq_printf(m, " direct dependencies:           %11lu [max: %lu]\n",
 			nr_list_entries, MAX_LOCKDEP_ENTRIES);
 	seq_printf(m, " indirect dependencies:         %11lu\n",
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625e..993a9c24ffcc0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1571,6 +1571,16 @@ config LOCKDEP_CHAINS_BITS
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
 
+config LOCKDEP_DYNAMIC_KEYS_BITS
+	int "Size for MAX_LOCKDEP_DYNAMIC_KEYS (as Nth power of 2)"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 20
+	default 14
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_DYNAMIC_KEYS too low!" message.
+	  The message can also mean that keys are freed without calling
+	  lockdep_unregister_key(), which leaks their slots.
+
 config LOCKDEP_STACK_TRACE_BITS
 	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-- 
2.53.0-Meta

