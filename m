Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096117;
	b=pNMHtIjUqA2GJt0xK2p/gqZh3tKc6gntK0fENkBAvQMZ6jWGI02Ou3/vAVcPDkIJ136y
	 YZ6n93OFRJlIPKa5dUalHWPGCJ78XewxN1d4dWnTcV4XV6weka9f8YlG8c61SyP1GRAiA
	 skIZS2LsDzSm4kszONOY67dbWqy81hWJCMewppz93EyylMVHsnC7l7OJwuL26R83lrBP6
	 B44qMT9tNkBtprR9npjM8tTwehHP1T1yWCEQFQtFUquDwsQXkn6BRgd83dX51tupM1AsR
	 g6lJ7mTtVfueODNp7pcvLeHu6JjJ6BrdnkO+ieOY5v1SNG43qYnENEw/fHuC431BUkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
	b=pJfbhyN/oF9o9DtCbWJ6LvvKhmBplFr+Ew/y823We2OIasNY3AV2yp/m7GADHMC+3vst
	 NZAuA+PrAOe5sRLc3iVghHeEwWg/Lgy1iium9fLFG89Z3ROxw542h2aek4l6jmjG/1XtU
	 CD+Y5PsgEP+/iFuJIc7m+SCEJOGu1E8GafdhBmkCG9fdz+83PsPmIrWgcABaUmRadsNkz
	 ZYS6toQziarMijeb+8PBphiwkzGjb8qd77mbvtGTEXuvcawZPKQKu5IHZo9TDUWfbdmMZ
	 YNJ9fjn2V9AcrCPG01nOq220PoyR/NYXeIwqVRkDJAgNw8ayxE0/+F9llALiSfNIT6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhqYwLJ1;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B76606A330
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 00:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B76606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lhqYwLJ1
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so974015e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794096115; x=1794700915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
        b=lhqYwLJ1O8TH6RKDMfUkDP6mkNSAEiwpdiDwDIrol/sYROkRqTD/8j2b/HYfXEgLn9
         tKwlzpwf/cEsm9MfY6nqHWLqB2XVzNQWtgzjWGtyCkjkCklTZS9Dar5kYA0WeuVdO6Qn
         DYL4I0t7a8e0sARjvO6ovpP8kt+usM7FrTDy1BM6VXfz/ULPtAgowoPBaExyMha5VdU8
         u4gXCWAxgEllzavJzXKCia15534bVYssQX9hKjy5mBY4ZcfLTIGXFxSAoaBK2QqUJVGF
         gDcWDFhh0LsNxe2IF9HZ749Zb/pB9y8mF9wCVLAovjssHPrkaiG020c1jTz7eBhXSfwI
         sVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794096115; x=1794700915;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HK+RKClxKHeBKDMXh9KyH2csGqniK+X/yXULXh9jPPA=;
        b=ywmlneKwWqiXCSEweDWSl/WAXdqXIjzMsvcK1BY83uevxpum0ih13SzCx1l4WeyR0v
         DNmbFbbY2tJ3cbhvImFlLYskluMxjg6g4bsErmg6KAwCYIA2sWEbZw31HvRJXkpY2m4Q
         5YamEM4OUBkvDMgo3I96Md+uHieuv+oExvzqwWc8HrqyaaSOu4uEtwl1nlhZftAvDcmN
         bcNDcRoDtMCeRqOpUrjQ62voF7tgwdTCImKA8s1HS7dlYJ0DZwefQ2QISYCic8F7UYRx
         8mcv605K6PHGasRTyCqGYa2qiNK+74l/O/qdMx+l5LB4zZzmQzEzOQruFEVA+QUNO+3O
         q3sw==
X-Forwarded-Encrypted: i=1; AKwUvByShI74H4uYK2S0mJGSmEGODARkVSdSq5JRqEKTonNjXom1RGjyrFLtJDdZicaZkyW5supxgq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ihIQgjJ1Pil2DNk3HIeCHkOatcEl5vloCpfp2DHdcMkwt1QmY
	XuZjaPwT2+cUYaneOkUQfyBsC2ahlNmorOUCvtT8WvHn/Nrxf0C+pspY
X-Gm-Gg: AYBFou3NcHjlB/lFbjrKwtxqfykAnHtBX/XsQ1JzZ74rdzAPB3LLOZwz8DdG+00OECa
	EX2uzUYrCayg6i16wHNdwpuTU48cRi2CtGY6/mZtPe+ns24BPlpkC1ifkayFWLck6TaXdglsBez
	1HIH1oTtVdsJaM7tgnlhW8yB7/3L0/eVc+0JI5XolBXZ2Pdn/oyH7tuxb0NMl29ZIKbpy0QzgJh
	S6RsS7kTqLAXYfBkpDMHxAtf4zDYzsEaDHDgFRMwiQ0XasUsYxzrkt1vqRK+fmk04D8l1xe53uv
	kg29Mm2rd8hE/0xh+xSlhZ09hP9zBcepHZKZW3SD3caREwS/jdoP2t+eD3qwNy6ubsJSW+i9be/
	RETDS9L3r+4XuOnZGiStPkeqkwACdeEiLAJo3m96EM3J3axVjQQfHB7QIhhCbcpKIlroorwGwco
	vYgwo/i5GkzhyPPEeOUg51RbEocwXnj18suARuS1/2M60qyaNrJjFE+T7uVXMiUjA13NMaYc/ML
	QmAQ8IZNAqJEFE1qXbO3hhqz/R3mbzxJT5uPu9zbq0/0pR3JT0xwJAn/Dup/ew5coP0HHkgGly8
	mWrJei6Mo+I9YXix0Fekwt02Rg==
X-Received: by 2002:a05:600c:4e05:b0:4b2:4b5e:8141 with SMTP id 5b1f17b1804b1-4b963c662f4mr4462525e9.9.1794096114831;
        Sat, 07 Nov 2026 16:01:54 -0800 (PST)
Received: from metepc ([46.197.185.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee247e9sm17430835e9.6.2026.11.07.16.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:01:54 -0800 (PST)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: sven@narfation.org,
	marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH batadv-next v3] batman-adv: tt: batch BH re-enable during TT hash walks
Date: Sun,  8 Nov 2026 03:01:11 +0300
Message-ID: <20261108000137.822325-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Each spin_unlock_bh() re-enables bottom halves and, when softirqs are
pending, processes them inline before returning. During a 1024-bucket
TT hash walk under network load, the purge worker can be repeatedly
interrupted by inline softirq processing at every bucket boundary.

Replace per-bucket spin_lock_bh()/spin_unlock_bh() with an outer
local_bh_disable(), inner spin_lock()/spin_unlock(), and periodic
re-enable points via batadv_hash_bh_resched(). The helper re-enables
BH and calls cond_resched() every BATADV_HASH_BH_BUDGET (64) buckets.
The total softirq work is unchanged, but BH state transitions drop
from 1024 to ~16 per walk, reducing how often the purge loop is
interrupted.

The cond_resched() provides a voluntary preemption point on
non-PREEMPT kernels. Functions called under a spinlock or from
non-sleepable contexts cannot yield; these use the outer
local_bh_disable()/local_bh_enable() conversion without
batadv_hash_bh_resched().

The five converted hash-walking functions are:

  batadv_tt_local_purge():
    Accepts a new @may_sleep parameter. From workqueue context
    (batadv_tt_purge), may_sleep=true allows periodic yielding.
    From batadv_tt_local_resize_to_mtu(), may_sleep=false because
    the caller holds tt.commit_lock.

  batadv_tt_global_del_orig():
    Called from multiple contexts including under spinlocks
    (batadv_purge_orig_ref). Cannot yield. Converts to outer
    local_bh_disable()/local_bh_enable() with inner spin_lock()/
    spin_unlock() but does not use batadv_hash_bh_resched().

  batadv_tt_global_purge():
    Called from workqueue context; yields every 64 buckets.

  batadv_tt_local_transition_new():
  batadv_tt_local_purge_pending_clients():
    Called under tt.commit_lock. Convert to outer local_bh_disable()/
    local_bh_enable() with inner spin_lock()/spin_unlock() but do
    not use batadv_hash_bh_resched().

On PREEMPT_RT, local_bh_disable() maps to migrate_disable() and
softirqs run in dedicated kthreads, so the batching has no effect
on softirq latency but the reduced BH transition overhead still
applies.

Reported-by: syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61b202fdc410840f0198
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Changes in v3:
  - Remove batadv_hash_bh_resched() from batadv_tt_global_del_orig():
    called under spinlocks (e.g. batadv_purge_orig_ref).
    Convert to outer local_bh_disable()/local_bh_enable() with
    inner spin_lock()/spin_unlock() only, like the commit_lock paths.
  - Fix reverse christmas tree ordering in batadv_tt_global_purge()
  - Fix Closes: URL (remove backslash escaping)

 net/batman-adv/hash.h              | 30 +++++++++++++++++++
 net/batman-adv/translation-table.c | 48 ++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 5d9a5ab..cf3ef70 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -10,10 +10,12 @@
 #include "main.h"

 #include <linux/atomic.h>
+#include <linux/bottom_half.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/rculist.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -167,4 +169,32 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 	return data_save;
 }

+/* work which can be done in a hash walk before BH gets re-enabled */
+#define BATADV_HASH_BH_BUDGET 64
+
+/**
+ * batadv_hash_bh_resched() - re-enable BH after the work budget is used up
+ * @buckets_done: buckets processed since BH was disabled, reset when BH is
+ *  re-enabled
+ *
+ * A walk over all buckets of a hash disables BH only once instead of
+ * re-enabling it after each bucket. Otherwise, pending softirqs would be
+ * processed inline after each bucket. When @buckets_done reached
+ * BATADV_HASH_BH_BUDGET, BH is re-enabled to run the pending softirqs and to
+ * give other tasks a chance to run.
+ *
+ * Must be called with BH disabled, without any spinlock held and from a
+ * context which is allowed to sleep.
+ */
+static inline void batadv_hash_bh_resched(u32 *buckets_done)
+{
+	if (*buckets_done < BATADV_HASH_BH_BUDGET)
+		return;
+
+	local_bh_enable();
+	cond_resched();
+	local_bh_disable();
+	*buckets_done = 0;
+}
+
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b9407ad..ebeb486 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -36,6 +36,7 @@
 #include <linux/overflow.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/sched.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -1892,23 +1893,32 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @timeout: parameter deciding whether a given tt local entry is considered
  *  inactive or not
+ * @may_sleep: if true, periodically re-enable softirqs and yield the CPU.
+ *  Must be false when called with spinlocks held.
  */
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
-				  int timeout)
+				  int timeout, bool may_sleep)
 {
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
+	u32 buckets_done = 0;
 	u32 i;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		batadv_tt_local_purge_list(bat_priv, head, timeout);
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
+		buckets_done++;
+
+		if (may_sleep)
+			batadv_hash_bh_resched(&buckets_done);
 	}
+	local_bh_enable();
 }

 /**
@@ -2887,11 +2897,12 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, safe,
 					  head, hash_entry) {
 			/* remove only matching entries */
@@ -2916,8 +2927,9 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 				batadv_tt_global_entry_put(tt_global);
 			}
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }

@@ -2969,14 +2981,16 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
+	u32 buckets_done = 0;
 	char *msg = NULL;
 	u32 i;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
 			tt_global = container_of(tt_common,
@@ -2996,8 +3010,12 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)

 			batadv_tt_global_entry_put(tt_global);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
+		buckets_done++;
+
+		batadv_hash_bh_resched(&buckets_done);
 	}
+	local_bh_enable();
 }

 /**
@@ -4402,7 +4420,7 @@ static void batadv_tt_purge(struct work_struct *work)
 	priv_tt = container_of(delayed_work, struct batadv_priv_tt, work);
 	bat_priv = container_of(priv_tt, struct batadv_priv, tt);

-	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT);
+	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT, true);
 	batadv_tt_global_purge(bat_priv);
 	batadv_tt_req_purge(bat_priv);
 	batadv_tt_roam_purge(bat_priv);
@@ -4449,11 +4467,12 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry(tt_common_entry, head, hash_entry) {
 			bool cont = false;

@@ -4472,8 +4491,9 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->key.vid);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 }

 /**
@@ -4497,11 +4517,12 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;

+	local_bh_disable();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];

-		spin_lock_bh(list_lock);
+		spin_lock(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
 			bool cont = false;
@@ -4536,8 +4557,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)

 			batadv_tt_local_entry_put(tt_local);
 		}
-		spin_unlock_bh(list_lock);
+		spin_unlock(list_lock);
 	}
+	local_bh_enable();
 }

 /**
@@ -4839,7 +4861,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 		if (size_max >= table_size)
 			break;

-		batadv_tt_local_purge(bat_priv, timeout);
+		batadv_tt_local_purge(bat_priv, timeout, false);
 		batadv_tt_local_purge_pending_clients(bat_priv);

 		timeout /= 2;
--
2.56.0

