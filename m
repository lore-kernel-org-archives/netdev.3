Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429357;
	b=xchkmZ0ZqVrDznuZNml4vq7/GQANLSQqBk+H3NCD5fxTQ1tGPRIBUndw9qSHrhqEuFn5
	 V5hk2N2sy4X0tOGDpfobbxgs71TZyXnqdBKh+Z78X7hMw2UnQ2wBj3Nqw022ZRFQDiq8L
	 m24AIf6I1wDYpwMGVW8WdrsOTFJX6J/b7Ri93+xkXcMmFfmiok0Lr9DsiFoehbIoB6XaJ
	 9kcnVnM+T4dkeFHX+TLFYE1Rbdvq/FErSTu4kxF0hDX4WVLHlhZZ7ZCtUMIHLsygX6v4A
	 Rg9agf2SPteYAzGzCQjLJrJjuAcBPpRD/c+rhDaMMZ7xyCjtEOokXK2k3XonBfumJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F45P4Gwx2Xhu7vkg2JA1MLPaW39/9SatqXVLFHFRMnI=;
	b=rup7tt5jbxK+fWWYiGt/bUtAZOT0uavZhnVeBfARD7PG5OTEiN4sY/wgbUtNVmcRlayH
	 oorVWWpGLXQOrjskNT/dA4lpdrXLGj6Bh3z9sjI/3oNyN4xoqbfBbUzv4l4uBOuLB3aFv
	 JHrxdnjSDOpoSicHc77lkz7SZBweCvVIediQX/C0z+srw18kiMLNvgItKdbrgWy4wau0T
	 pK3uaNEjZiMpp/YIPVVR3wOQJ7K+CPhZRwjNXccDMdrWuni2bSBnuAVzVv4rGle1B/WWo
	 KiZ04XdfTzb8z99ZY5UIPjedkaCNWwBf7U4ESuPyFyfmHXnCmuhwkRHSdYAVRBbBRNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fS2fmV20;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30ED60A263E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A30ED60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fS2fmV20
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so2706116a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429355; x=1793034155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F45P4Gwx2Xhu7vkg2JA1MLPaW39/9SatqXVLFHFRMnI=;
        b=fS2fmV20/ff2TG+qvivCKDqz4VFNy94wJNKDrNEVsBsed16N6FENeK/APJJaVzSOnS
         QSKrrx8+JGpwWSyU3FpaaG5LVJaA2341+cnBWB3NAzU9LgTw31/8RmC87rhdFVj1exPH
         eLgoBFwAJiRkWgg+rJdvSEQdDUxwtyg9RK61zC/fAJMdzSzFhDRa9VGekteZwbEA1s1h
         lu/1MYuS/zLx5tc73Ev4lj8JxPZY9laA6Hxvr0dp8/FxOS6Da6W6aeYds8w5DquaaS4u
         qfG0Eq8fXB0YtQGNyiZL6hnqZ9uF64aWxWKNgbegAumN0cRCtQSRj3WUhTVZ3sCgSGAd
         aeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429355; x=1793034155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F45P4Gwx2Xhu7vkg2JA1MLPaW39/9SatqXVLFHFRMnI=;
        b=r6V5cBKxv7r3cgZD9gO7xcvYFVVDneodi7L7/54N2UsJ7B9zlDEPXBP3rc5rKkVGBV
         aQJRoZMz91CFwa/EmAquIddr4MU7pbSxaXjjHi7xh8VYG8uY57rXHF07yENWV0TC3NQZ
         q6fzLvBk9FsAtSVYoVddVgZNQKS5CAUO3T267dQvsLzZRmj5N+KDPvEI/bTAcPUeTq+W
         btdnnrYwMuFk+XPVDXdO5dlQBwG0F67gRZm9dU5ezqYH8qeNHFLpuPXi+iHErceonXmJ
         0z2gp6OQ+jjz/PbO5fKQNWbBWrACkzDznEOTbH50KpFGesUQ84AgCjJmIZtx9kpAla1O
         VgtA==
X-Gm-Message-State: AFq9FYIA1BGhWbbIfKf6sJckane0FXJ2Zz3cr1q+xfV5D/cDpfcshKfT
	FKruYZ6eZ3TlbeD6ASJ+Uhgek3DTLdJ8Vrv4DyTzDrvLfrVGJPIN86BANeTPa6Hz0uJgUw==
X-Gm-Gg: AYBFou3z08dPfHlZXPF28B5ZPoggfp6BNjNNFjoOg3mnVEK2yZV8JnTFZw5DgO+2cSY
	vCNKmw6rgOqqAF1vTzG/0XBrLBa1thbskZHS4S9oYxoxGF2v16IoGA/+YGahMKFvCZ0mPd3J09a
	pL96v0NN0B2C/as5gk6EshbLtlKa0CZtF64Zh0zcpTIL/jufYlcDyjHkJNu5TdVder8bjIa/sWy
	hoGqX32BMAV/DFCVaILDLX2XfTuo2jFWUcAng15FGERAYIvTM4u6ucWLZYBAbRjvzrnystx1P2X
	ULwGqkU9p9K5KWWPjNrmrUe4e7z1ofHRpgr+Aas6l3d3x2rxGQGs6GBf37RTqCEpHIe7D/CDT5c
	ED0rlEtoOoAsF17C/qreVTR13GsEAvTQNf0HNGDiWbcyNYVxuqJ+4FMjF2hpHEVgINRMvrQUds0
	CoGKi/X11gE/KDS7vWRgsS6Ud0IN/WfTEHqzIyozsGPeKkBfXsdAmLcRh0KS3USchD
X-Received: by 2002:a05:6402:4582:b0:6b1:b97b:74f with SMTP id 4fb4d7f45d1cf-6b3a8191599mr5429579a12.31.1792429354819;
        Mon, 19 Oct 2026 10:02:34 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:42::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b14besm3998320a12.6.2026.10.19.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:02:33 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] lockdep: Introduce lockdep_unregister_key_nosync()
Date: Mon, 19 Oct 2026 10:02:24 -0700
Message-ID: <20261019170225.729789-2-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170225.729789-1-vlad.wing@gmail.com>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
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

From: Bart Van Assche <bvanassche@acm.org>

Add a variant of lockdep_unregister_key() that neither sleeps nor waits
for an RCU grace period. Instead the caller must make sure that a grace
period elapses after the call before the memory holding the key is
freed or reused.

That lets callers that already free the key's memory with call_rcu() or
kfree_rcu() avoid waiting for a second grace period. The qdisc code is
such a caller: all qdiscs except ingress, clsact and noqueue embed a
dynamic lockdep key and are freed with call_rcu(), and replacing an mq
root on a multi-queue NIC destroys one qdisc per TX queue under RTNL,
each currently waiting for its own expedited grace period.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun@kernel.org>
Link: https://lore.kernel.org/all/20250203175939.3133477-2-bvanassche@acm.org/
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
[vlad: rebase onto synchronize_rcu_expedited(), spell out the grace
 period requirement in the comments and changelog, describe the qdisc
 use case]
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 include/linux/lockdep.h  |  5 +++++
 kernel/locking/lockdep.c | 36 +++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a6451ecbbe9a0..80b27973b7f72 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -117,6 +117,7 @@ do {							\
 } while (0)
 
 extern void lockdep_register_key(struct lock_class_key *key);
+extern void lockdep_unregister_key_nosync(struct lock_class_key *key);
 extern void lockdep_unregister_key(struct lock_class_key *key);
 
 /*
@@ -375,6 +376,10 @@ static inline void lockdep_register_key(struct lock_class_key *key)
 {
 }
 
+static inline void lockdep_unregister_key_nosync(struct lock_class_key *key)
+{
+}
+
 static inline void lockdep_unregister_key(struct lock_class_key *key)
 {
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c3dc84a7cef26..16c8480e282e3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6669,13 +6669,19 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 }
 
 /*
- * Unregister a dynamically allocated key.
+ * Unregister a dynamically allocated key without waiting for RCU readers.
  *
  * Unlike lockdep_register_key(), a search is always done to find a matching
  * key irrespective of debug_locks to avoid potential invalid access to freed
  * memory in lock_class entry.
+ *
+ * is_dynamic_key() may still be walking past @key under RCU when this
+ * returns. The memory holding @key must not be freed or reused, including by
+ * registering @key again, until an RCU grace period that starts after this
+ * call has elapsed, e.g. by freeing it with call_rcu() or kfree_rcu() queued
+ * after this call. Does not sleep.
  */
-void lockdep_unregister_key(struct lock_class_key *key)
+void lockdep_unregister_key_nosync(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head = keyhashentry(key);
 	struct lock_class_key *k;
@@ -6684,8 +6690,6 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	bool found = false;
 	bool need_callback = false;
 
-	might_sleep();
-
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 
@@ -6711,15 +6715,25 @@ void lockdep_unregister_key(struct lock_class_key *key)
 
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+}
+EXPORT_SYMBOL_GPL(lockdep_unregister_key_nosync);
+
+/*
+ * Unregister a dynamically allocated key and wait for is_dynamic_key()
+ * readers, so that the memory holding @key may be freed as soon as this
+ * returns. May sleep.
+ */
+void lockdep_unregister_key(struct lock_class_key *key)
+{
+	might_sleep();
+
+	lockdep_unregister_key_nosync(key);
 
 	/*
-	 * Wait until is_dynamic_key() has finished accessing k->hash_entry.
-	 *
-	 * Some operations like __qdisc_destroy() will call this in a debug
-	 * kernel, and the network traffic is disabled while waiting, hence
-	 * the delay of the wait matters in debugging cases. Currently use a
-	 * synchronize_rcu_expedited() to speed up the wait at the cost of
-	 * system IPIs. TODO: Replace RCU with hazptr for this.
+	 * Expedited to keep the wait short, at the cost of IPIs. Callers that
+	 * free @key after a grace period anyway should use
+	 * lockdep_unregister_key_nosync() instead.
+	 * TODO: Replace RCU with hazptr for this.
 	 */
 	synchronize_rcu_expedited();
 }
-- 
2.53.0-Meta

