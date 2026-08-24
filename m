Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F744E052
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586694; cv=none; b=TohFSlzp1Pd3EpM1ynuEc7NKroEjqtAWoVCcJaaJssSjTx3qEodwOPpDUpeTqV8Cei0072+x/XnJva7Bmyf7VHiMZVDQDj5Fsr1XjstlcPyghL9rbyNzI3g3xXCCAfI+Fz5YJfGov+ip4/9q/E2TUIQrsvp3aZUHaix9la6mu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586694; c=relaxed/simple;
	bh=zXB98oGFU5Gil7Rk9HFojNt2ZTBLvE1zLymx6VtnklY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bY17Rx0S13LWIw0OGNlURElzV906BAUN1WTu4wncO8vElNMOfD1f4r4wT2O70xU2HFk+43T7MU5wLsG6RyhhLAlV0cQ8hiM60LfQNLbSV2Vi4jKPqZEok52CYddQiIk5LQqBcSQDXnTjuVDX50YfBOvWUfCaQ5OIaM5U0CulVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9OT4rnD; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9OT4rnD"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fc6b670b4bso32809186d6.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787586692; x=1788191492; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AEBz1cefQGrzLTsdFlMZLzUk+Ij8Jfd1qZk6z9JQqNQ=;
        b=v9OT4rnD1VHD2nPrErL9sGlL7SH8L0HVGM91mW/oNhYgqPG5Qv3KTkCL/MWeQsS+qD
         Ot6XLCwD6zSEjIk8Nr36Rxs03x0GPE8EgiuKJVkJjC2UoUU/ht0nKbtubXI98C4FXZXw
         AbLP3UtCDFKPAnovW4/BbnT+9Hp8GZ6GUZGcNaInwchWXPS4e4v1+JwgMT50y3Li4NF5
         2FG2vWBX/uWVIjDpCppuKQArilfva1MGYlSn4jwetZVmmBU+9jteyaK/HeaAq1PHXc0p
         koceCPCckg8bWSHBCX5ndffpwyUiS6Xy3ELufaZH+I5KywtuvA/SIKR+O0kQckz7rL37
         1+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586692; x=1788191492;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEBz1cefQGrzLTsdFlMZLzUk+Ij8Jfd1qZk6z9JQqNQ=;
        b=nB6xLgwZX6Ns46Ml3mcAp8VKBIMSR460ASp4O3TjNPx7vqmhO9kuXrRNE/7qLbNDEr
         SeA/5dMWzMcrc3htunPqK7NO3lQIWrnyDVrqR/0Dl8N1DY5eb9s5PNPrgPJvGqhxjrL4
         VFcPU4KExm945YDv72DV7dtqLjC8o2L30XNlOWnK3h9TTkxT1X/h5JkYhccU5hhHvz3v
         gvHGH885XlW2eTx5RsyDuFTc4xCyXrj/6dHpJ97mUp/NQJCHw8oz5k4NTfsFmQJwAVag
         WeIir5k5w8zWpXmv3nRxGnFYXNvmNgCLpHAd6fqrfdXnlI9BVxSqW+/FJoNFqKEej9tc
         u1NA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7nmYvd4nyjzevGERR1R2WxDpVOmXR/q5wMZxHppt6D6h57Fiu/WEq/EfpK0NZSjRBdpRh2FM=@vger.kernel.org
X-Gm-Message-State: AFuF++kiWnukFxd5kCXBb20sxXQzOD7X04Frl40hWpVwhd4ANmcSbn/x
	v8jeD8J21xHU5PbSwGFQtjI4oOzqfl7mzXDPKxN3//iTIq50qeFKmQO2tmmB3PLGE3IHfittF5R
	eRpVkmrOGL3QLUA==
X-Received: from qvbpn9.prod.google.com ([2002:a05:6214:1309:b0:907:52b7:d39b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:508d:b0:8f2:747d:3027 with SMTP id 6a1803df08f44-90c80fbb548mr256612556d6.20.1787586691226;
 Mon, 24 Aug 2026 08:51:31 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:51:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824155129.676096-1-edumazet@google.com>
Subject: [PATCH] locking/lockdep: Invalidate stale class_cache entries for
 zapped classes
From: Eric Dumazet <edumazet@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, syzbot+2d770620059281e225a4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a lockdep splat hitting DEBUG_LOCKS_WARN_ON(1) in
hlock_class() due to an invalid class_idx:

  WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x382/0x2cf0 kernel/locking/lockdep.c:5203
  Workqueue: wg-crypt-wg0 wg_packet_tx_worker
  RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
  RIP: 0010:check_wait_context kernel/locking/lockdep.c:4870 [inline]
  RIP: 0010:__lock_acquire+0x389/0x2cf0 kernel/locking/lockdep.c:5203
  Call Trace:
   <IRQ>
   lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
   tcp_tsq_handler+0x29/0x200 net/ipv4/tcp_output.c:1291
   tcp_tsq_workfn+0x384/0x410 net/ipv4/tcp_output.c:1325
   ...

When a lock class is zapped (e.g. during module unload or key
unregistration), zap_class() clears the class's bit in
lock_classes_in_use and removes it from the class hash table.
However, existing lockdep_map instances embedded in data structures
may still retain a pointer to the zapped class in their class_cache[]
array.

When __lock_acquire() subsequently runs on such a lock, it finds
lock->class_cache[subclass] != NULL, skipping register_lock_class() and
assigning hlock->class_idx to the index of the zapped class. When
check_wait_context() or hlock_class() inspects the held_lock, it finds
!test_bit(class_idx, lock_classes_in_use) and warns. Furthermore, if
the zapped slot is subsequently re-allocated to an unrelated lock key,
the stale class_cache entry would erroneously match the unrelated class
(ABA issue).

Add lock_class_cache_is_valid() to validate that the cached class is
within lock_classes bounds, still allocated in lock_classes_in_use
(using uninstrumented arch_test_bit() in __always_inline context so it
is safe in noinstr contexts like match_held_lock()), and that class->key
matches the expected subkey (taking lockdep_set_subclass() overrides into
account). Also use READ_ONCE()/WRITE_ONCE() when accessing class_cache[].
If the entry is invalid or stale, fall back to register_lock_class() /
look_up_lock_class().

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Reported-by: syzbot+2d770620059281e225a4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a8c66dc.4d75e56a.c9a88.0050.GAE@google.com/T/#u
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/locking/lockdep.c | 50 +++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 25d77d4a1061..763f79806bd8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -963,6 +963,34 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	return NULL;
 }
 
+static __always_inline bool lock_class_cache_is_valid(const struct lockdep_map *lock,
+						      const struct lock_class *class,
+						      unsigned int subclass)
+{
+	unsigned int class_subclass;
+
+	if (!class)
+		return false;
+
+	if (unlikely(class < lock_classes || class >= lock_classes + MAX_LOCKDEP_KEYS))
+		return false;
+
+	if (unlikely(!arch_test_bit(class - lock_classes, lock_classes_in_use)))
+		return false;
+
+	if (unlikely(!lock->key))
+		return false;
+
+	class_subclass = subclass ? subclass : class->subclass;
+	if (unlikely(class_subclass >= MAX_LOCKDEP_SUBCLASSES))
+		return false;
+
+	if (unlikely(READ_ONCE(class->key) != lock->key->subkeys + class_subclass))
+		return false;
+
+	return true;
+}
+
 /*
  * Static locks do not have their class-keys yet - for them the key is
  * the lock object itself. If the lock is in the per cpu area, the
@@ -1395,9 +1423,9 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 
 out_set_class_cache:
 	if (!subclass || force)
-		lock->class_cache[0] = class;
+		WRITE_ONCE(lock->class_cache[0], class);
 	else if (subclass < NR_LOCKDEP_CACHING_CLASSES)
-		lock->class_cache[subclass] = class;
+		WRITE_ONCE(lock->class_cache[subclass], class);
 
 	/*
 	 * Hash collision, did we smoke some? We found a class with a matching
@@ -4957,7 +4985,7 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 	int i;
 
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
-		lock->class_cache[i] = NULL;
+		WRITE_ONCE(lock->class_cache[i], NULL);
 
 #ifdef CONFIG_LOCK_STAT
 	lock->cpu = raw_smp_processor_id();
@@ -5022,12 +5050,15 @@ EXPORT_SYMBOL_GPL(__lockdep_no_track__);
 void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
 			     lock_print_fn print_fn)
 {
-	struct lock_class *class = lock->class_cache[0];
+	struct lock_class *class = READ_ONCE(lock->class_cache[0]);
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
 	lockdep_recursion_inc();
 
+	if (!lock_class_cache_is_valid(lock, class, 0))
+		class = NULL;
+
 	if (!class)
 		class = register_lock_class(lock, 0, 0);
 
@@ -5119,8 +5150,11 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (DEBUG_LOCKS_WARN_ON(subclass >= MAX_LOCKDEP_SUBCLASSES))
 		return 0;
 
-	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
-		class = lock->class_cache[subclass];
+	if (subclass < NR_LOCKDEP_CACHING_CLASSES) {
+		class = READ_ONCE(lock->class_cache[subclass]);
+		if (!lock_class_cache_is_valid(lock, class, subclass))
+			class = NULL;
+	}
 	/*
 	 * Not cached?
 	 */
@@ -5323,9 +5357,9 @@ static noinstr int match_held_lock(const struct held_lock *hlock,
 		return 1;
 
 	if (hlock->references) {
-		const struct lock_class *class = lock->class_cache[0];
+		const struct lock_class *class = READ_ONCE(lock->class_cache[0]);
 
-		if (!class)
+		if (!lock_class_cache_is_valid(lock, class, 0))
 			class = look_up_lock_class(lock, 0);
 
 		/*

base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
-- 
2.55.0.766.g2966f0265a-goog

