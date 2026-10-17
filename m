Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BB2EEE8C
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200075; cv=none; b=sbvICuTqqV1SUrOjq3ChWAPx4411uhHScDpeI/OTjZxnLAnGsTj2ERPs/UV0qZ3x3BiSRoRdTWWs4ql2+IonBASS1F32Y0jPkOcStZQnqfzB9v1jN36dqEYz1I66y2+LaFaLujt3DX4r2SH2eUOlVQb7+UMIvb8QNFUhzDvS+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200075; c=relaxed/simple;
	bh=8OJMvAA+dMrdbRbb0nwk/n3WT8wUSydojqhKaUFjjh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiU67MXh326AMEn9vwLgL/r7GOEj9jdYRDs2EibgK+84RjS5PutVeLFLQ1Iilnj1xplvLQbAheTthXJo3f16r37Cq4yitFg2K4LjK7u3aI2Yvx/LKpnNaDXQf/gY1uD0D10+0p3XZdBmqnJ+wPjBy2jHNUyxZTFd8PQoo0WtgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlnvwCj0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlnvwCj0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso465951a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200073; x=1792804873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fBMoxBE26VqgxenoC2y2JHXlxXwVDO4reB28zK9D9c=;
        b=YlnvwCj00UmPEadDDqKgPdjl/SK/hhwDidoVxEJI1Oalpju4FIrUn6fmM6K/yWk9zT
         uiULKu0RLnwrUlNSGxRkUdBLQ7cKzApB2GLJk/VMDVDFn78GYKMl7Lytcqhe8x3IV9oP
         vXHrun5N0jeS52LLtGuBMYtALId9pd+Wa86Kp0eXSMGRFuTomR86rxJHUYoPR9lkbkg0
         exDem/NyX/brL1WX2XH0tEi1oapxuSGq0WCHgHIFbpuKYwW5jte2ezmOgjSJyILrRC6K
         Ku3cX68vVtjMhamqd2Q9WTTNq+27twu+i1qJJ1mMtSBLSu+qCOBhKNnnZ5YhQq38spOw
         5eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200073; x=1792804873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fBMoxBE26VqgxenoC2y2JHXlxXwVDO4reB28zK9D9c=;
        b=UnD19SO+PtT6khLMrGFdwXNlTeDLw4tWV+RR0UslYP13x35xDJtoZeAr5jOnh4S0R+
         4DhqCQycUu5h30YjqX1j8JHFlCuOkFTw+Czu8JrBQVvuEkaqik2xb2p9w0FebtH9p6FN
         T0i2NqsDlt4/LHbvGBs03psW76aZmMQz7uVHMm4UtgrW5XnsdHRzXaP84vSpnuk2LL/z
         7u17w1agoiovQa6dNaN3Mzml39TeRkVrUgDkrExVGkhWuFbppDlSz3kuB2mHdNWKEFmL
         2oXrSzn5+BSO3xzyCiSIJezNLKOPCE2UwyqyIOQqt7hDfnMVyQBMORuXLW5hcyw3XUrL
         0ewA==
X-Forwarded-Encrypted: i=1; AKwUvBxp6GMDa6IJlpYJBAjYEEaHfUachrMZOOP5zJIu/R01jqkGwzoqNn3jWDwhctUQuQHxqVldrbg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk2A0HlGjc875Zj/yXqAt2OPV6Lbjx0QmjZ1PC695OwOzVTm4g
	VlbmHvL2cQt9h9a2ODL6ARNuS9ee7s7X58BPmdoY0i8j/AvSVVc24K0mFYG09gsc
X-Gm-Gg: AYBFou0Qay+8/0UZ52TpXi/N9NjCakl/SZP7DptGuunk4Ju0nVEOK0z3QSOkW057vR6
	Tq/AfBivO/VaREKhk9K6fbOsokoIRXBHEORiqC1mCxq/ihXY05Hn6WJjfADQjENhmoUDakLaGeK
	2bX7VUMpjL6UNIaTPJVLf88hisMGjMkldyuuKKmFwUK55K0PpxOh3f525bYWH7FLC72o9i8EBRP
	dGJEGy6GG5RtZGNd/FF1pTff5p3ifC7WTx346XefCg6eePLaG5Lut3c6bIgfC5WVIpMbK9qQ+JP
	qUfaSdaIAEr7QfikzqGNdaQtlLZIhfmgtzH6aTY3ebkU/ems55LZh0aM6AtGxdLOhtsuHTHskmb
	15Gn7hmpIkJ75mtQydb8vTkv00mWEi+mTf4qoj/wX11iiOj6ia6M3/FVZPydLQS6eo/bfeDvEHF
	EfFDyauIQ8x4cWAv1oTkoz6o8aa6v7waXg86gUP8P6zquXZGVVf71RHs9mfPH+vrvIhFCLwrfbv
	F/khOOn+0C1DF9w2eloMs8B7KRTytujwu3yJzg7PKsXAtjb+vfOPoGRJbib/sJbunetyu3L3Pj1
	49Dv/99ncEgoCnQxy6htGm7hU3VuG8E6NU+U72AFOv4=
X-Received: by 2002:a17:90b:55c4:b0:3aa:6b5d:a02e with SMTP id 98e67ed59e1d1-3acef5b0d70mr1232642a91.54.1792200073488;
        Fri, 16 Oct 2026 18:21:13 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947dfa00sm11233950a91.17.2026.10.16.18.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 04/38] bpf: don't hand out a linked element as extra element
Date: Sat, 17 Oct 2026 01:20:24 +0000
Message-ID: <20261017012058.355787-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When htab_map_update_elem() replaces an element of a preallocated map,
alloc_htab_elem() takes the spare element of this cpu and puts the old
element into the per-cpu slot right away, long before the old element is
unlinked from its bucket.  The bucket lock disables interrupts, but it
does not keep out an NMI, or a tracing program on the return of
alloc_htab_elem().  bpf_prog_active only helps if both programs are
kprobe, tracepoint or perf_event programs.  A program that updates an
existing key in another bucket of the same map gets to use the slot:

  htab_map_update_elem(k1)              tc, xdp, fentry, raw_tp, ...
    alloc_htab_elem()
      l_new = *pl_new
      *pl_new = l_old                   still linked in bucket 1
      <NMI>
        htab_map_update_elem(k2)        perf_event program
          l_new = *pl_new               the l_old of the outer update
          hlist_nulls_add_head_rcu(l_new, bucket 2)
          hlist_nulls_del_rcu(k2's old element)
      </NMI>
    hlist_nulls_add_head_rcu(l_new, bucket 1)
    hlist_nulls_del_rcu(l_old)

If l_old was the first element of bucket 1, the outer add points its pprev
at l_new, and the delete takes it out of bucket 1 only.  l_new->next now
leads into bucket 2, where l_old stays with a poisoned pprev, on which a
delete of k2 crashes.  If it was not the first, the delete takes it out of
bucket 2: k2 is gone from the map, and the chain of bucket 1 still contains
l_old, whose next pointer leads into bucket 2.

Either way a walk of bucket 1 ends on the nulls value of bucket 2.
lookup_nulls_elem_raw() restarts whenever that happens, so every lookup in
bucket 1 which does not find its key spins forever:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
   __htab_map_lookup_elem+0x354/0x4d0

  BUG: KASAN: wild-memory-access in htab_map_delete_elem+0x30c/0x670
  Write of size 8 at addr dead000000000122 by task extra/102

An NMI between the load and the store of the slot makes both updates use
the same element, with much the same result.

Empty the slot when the spare element is taken, in a way that is atomic
on this cpu, and put the old element in only after it has been unlinked.
A nested update that finds the slot empty, which is the case that
corrupted the map, fails with -EBUSY.

Fixes: 8c290e60fa2a ("bpf: fix hashmap extra_elems logic")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9d4791ee1741..923fec694747 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1279,11 +1279,17 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	if (prealloc) {
 		if (old_elem) {
 			/* if we're updating the existing element,
-			 * use per-cpu extra elems to avoid freelist_pop/push
+			 * use per-cpu extra elems to avoid freelist_pop/push.
+			 * The caller puts old_elem into the slot once it is
+			 * unlinked. Until then the slot is empty for an NMI
+			 * or a kprobe that updates this map on this cpu.
 			 */
 			pl_new = this_cpu_ptr(htab->extra_elems);
-			l_new = *pl_new;
-			*pl_new = old_elem;
+			l_new = READ_ONCE(*pl_new);
+			do {
+				if (!l_new)
+					return ERR_PTR(-EBUSY);
+			} while (!try_cmpxchg_local(pl_new, &l_new, NULL));
 		} else {
 			struct pcpu_freelist_node *l;
 
@@ -1459,11 +1465,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (l_old) {
 		hlist_nulls_del_rcu(&l_old->hash_node);
 
-		/* l_old has already been stashed in htab->extra_elems, cancel
-		 * its reusable special fields before it is available for reuse.
+		/* l_old replaces the extra element that alloc_htab_elem() took,
+		 * cancel its reusable special fields before the next update on
+		 * this cpu reuses it.
 		 */
-		if (htab_is_prealloc(htab))
+		if (htab_is_prealloc(htab)) {
+			WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old);
 			check_and_cancel_fields(htab, l_old);
+		}
 	}
 	htab_unlock_bucket(b, flags);
 	if (l_old && !htab_is_prealloc(htab))
-- 
2.55.0

