Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8F3B19CF
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255259; cv=none; b=WM/5tiYWBJBa+NntUChEaJ82RiLxeBczI4Xd6KihpNiLlBAh6vU3wmiXBs/S9Nxta3C5Dkqi+B2AOTfq3R5JK9/y/rgYisGSP9OlDmSa6EJiCUchDLQ/GOrHRVwWq+sn6VGJ7wKcK8q5/rF86ePQoicTCu5PFNGE1eEhZv4Nl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255259; c=relaxed/simple;
	bh=tVebYQBo13EQ2O3Gvs2ZTfIjAAPRN0sHCqiVqm+XXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/zJaDRo/f3mfyOYroIdITW+qc0bp7rWJ/aZFq9EknAPb0xU+tA72TQs1OrtY2GkrikyQWeRIh+E9+YfmdQMwDsPEr1eb6Xe28O62qMNedwtwCtkcH5XxYV5zPKf4lmo52TwYecirbU0i62ho4scCIN1XB24A9R+VqQFQYcTUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzjUqhEs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzjUqhEs"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so862498a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255257; x=1792860057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=El+IaNdVm/ero8clsRDipFgBKClaQ+LjM1AqU65Djmw=;
        b=dzjUqhEsEXCF/lN3yAcH3i5BWMftusZd+hk9KbJzanrEgfU1tCyGreaO/lkwMUvSRv
         ORdBL42cKuPVIIZ0sn7EP5hWUSRKh9cRXEVWWyIG3Zbwmktptg4r5k0oUuGfZYvlUmjk
         /74iUShJ2kHqDuW8HBCG2m695x2e4n+4iDJ5Ray4FBVi0enf6TsVBftz2SxpnoqIH4Py
         O+CXzTBxKLV2yWoUBLl8C4u1wVAh93szlt2HWuHva6Jgy4ROvMq32rFZjHcAWE2UxqyV
         D0CK3JFfOpRULD+DzM3DeiGZ0grR9B65GcCpAlI04dZL8tUZGOjruK1NjkUVHbGu8pc+
         YMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255257; x=1792860057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=El+IaNdVm/ero8clsRDipFgBKClaQ+LjM1AqU65Djmw=;
        b=LNNReL5jyA3xF2CM02ceMK5hXr/lgmCBHl7E1u3OExXhyeeEAe7rX8YSVKnO/x/xSE
         nFYUnHcfJJTE2QX8F5BHQJGnrbfpGw7rccHX7DWnNN7+wrzO6pOAK1pv4sK7eMJHWxkw
         CvOn4frhnddTzIm6FWh6qmC9lgpd41DeNm4emj4DCTlsl/Y5O5+MjsjnCjQQdpfQDSnQ
         lVMC+fYYFv94xrDX/Ts4dJvwNRsCSb/9+o0VV0ybkqw2LOZy3BcQRWAXI/iiWEi2G4xV
         89NJSkCHMJ07GwSjPXkSxpWgjva0cDd6cKJV3aCVb7ryPi7wDsT7xLZp4ncaKNxEQOII
         NRWw==
X-Forwarded-Encrypted: i=1; AKwUvBxH6icK3E5xgFrRqeBlvz4UZW7g7PTnkLNAknWiM1UVDXXuORXZan4Zm5ON7OfO5zga9CIIhsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl9W/ZT4hOZsMfUwdIz/kRswczDbIaj3hcROWU/DgWNqqQ4lkI
	WmWZqZaxVLYKECcQBys9T6VviFw6nCz2p0lKFly6S8d2qUjoH10qSxNomt8azw==
X-Gm-Gg: AYBFou0PNmqunE11wKIfqtWGS7hXULvQ7H6iTAzesqDKu2HTLhsrSrft6/HRnj3u46l
	fPuTQZnIEMBVFrYCF3FoQ+yAdK5NfctYQejFCvRSzWIskFi6M52DGR8Qcb0MmZjSDQMrfI0px6O
	PCVPUuJ4EdWtpoz3Qn8/fKFSDYEtrM7rBNNL34oYkZWZfTHqFfyOo+gmrusu/D5lVQXRg+1lrGz
	VsiWiRvLvRo6uY9XXz5FQCTgt7gYXc//sNRyJCaJIdCm/NRxCE8lSQFcmXlNjgHvJ+TmBJf2+mR
	LxNv0z1wkJ0nGBOmj08gmD9Gj+ihpRKhisnu7fAJD8K3tbc79hQw53UhDpufnVTRn44Vk7Ps4Jk
	48F3UvzVg3nHFobMCnibw8dn0A+XDr2a++5lwjNqjotxY3/UGt/p97dD3DubLpiKjwFS+dFQlOv
	7MwFTD6GIyN3dzv3eMMwUk+WA8MsyADd7AzUlGV7J5w1oFC18tZIjZSNHnOty7JS1E7Sh9DtHZx
	2cnyE2vKcGen/SHomwNC4gX6HL8/Nwtblqr0vGnxUHcd3Jx5/D5yzvrSHk6sqUBPfiG99hhrVZI
	3MHyqQ99iHc4uaOAXhWmtYb7PslXQELTEE34zlLGi1A=
X-Received: by 2002:a17:90b:5745:b0:3ac:9f24:44e0 with SMTP id 98e67ed59e1d1-3acee277125mr2849331a91.4.1792255257476;
        Sat, 17 Oct 2026 09:40:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487cccdsm8704132a91.8.2026.10.17.09.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 31/43] bpf: Keep values of a dead owner for sleepable programs
Date: Sat, 17 Oct 2026 16:37:33 +0000
Message-ID: <20261017163745.3341787-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_local_storage_destroy() frees the elements of an owner behind a plain
RCU grace period, on the ground that no program can refer to an owner that
goes away.  But the pointer that bpf_task_storage_get() and its like
return stays valid for the verifier after the program has released the
owner, or has left the bpf_rcu_read_lock() section it had the owner from.
A sleepable program is in no RCU read side critical section, so it can
write to the value after the owner has died and the element was freed:

  BUG: KASAN: slab-use-after-free in _copy_from_user+0x42/0xa0
  Write of size 8 at addr ffff8880074404a8 by task lsuaf/55

Free the element behind an RCU Tasks Trace grace period if sleepable code
may use the map.  A program that a map is bound to was loaded, and counted
in map->sleepable_refcnt, before it got a value from the live owner, and
stays counted until a grace period behind its last run.

A program can also get at a storage map by a lookup in an outer map.  Then
only the outer map is counted, its programs can come after the inner map
was put into it, and can hold on to the inner map after it was taken out.
So note in a map that it has been an inner map, and treat it like one with
sleepable users from then on.

The same goes for what the special fields of the value hold.  The page of
a uptr has to stay pinned, and a kptr which the program stores after the
owner has died has to be released.  Leave the fields, and the smap that it
takes to free them, to bpf_selem_free_trace_rcu(), as bpf_selem_unlink()
does.  bpf_local_storage_map_free() waits for that callback.

Elements of such maps now wait for sleepable programs that are running
when their owner dies.  Other maps are freed as before.

Fixes: dcf456c9a095 ("bpf: Fix usage of trace RCU in local storage.")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |  1 +
 kernel/bpf/bpf_local_storage.c | 30 ++++++++++++++++++++++++------
 kernel/bpf/map_in_map.c        |  7 +++++--
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 22947fa192e4..a10af47978a4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -341,6 +341,7 @@ struct bpf_map {
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
 	bool free_after_rcu_gp;
+	bool was_inner_map;
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 	u64 cookie; /* write-once */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 49ea00c99390..699430f97178 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -352,7 +352,8 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 				    struct bpf_local_storage_map_bucket *b)
 {
-	bool in_map_free = !!b, free_storage = false;
+	bool in_map_free = !!b, free_storage = false, sleepable_users = false;
+	bool keep_fields = false;
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	unsigned long flags;
@@ -362,17 +363,26 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
 	if (smap) {
+		/* A map that is freed, or NULL here, has no program left. */
+		sleepable_users = !in_map_free &&
+				  (atomic64_read(&smap->map.sleepable_refcnt) ||
+				   READ_ONCE(smap->map.was_inner_map));
 		b = b ? : select_bucket(smap, local_storage);
 		err = raw_res_spin_lock_irqsave(&b->lock, flags);
 		if (!err) {
 			/*
 			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
 			 * exactly once for an selem. Safe to free special fields immediately
-			 * as no BPF program should be referencing the selem.
+			 * as no BPF program should be referencing the selem, unless it
+			 * is sleepable: see below.
 			 */
 			if (likely(selem_linked_to_map(selem))) {
 				hlist_del_init_rcu(&selem->map_node);
-				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+				if (sleepable_users)
+					keep_fields = true;
+				else
+					bpf_obj_free_fields(smap->map.record,
+							    SDATA(selem)->data);
 				unlink++;
 			}
 			raw_res_spin_unlock_irqrestore(&b->lock, flags);
@@ -387,7 +397,14 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
 		 */
 		WARN_ON_ONCE(err && in_map_free);
-		if (!err || in_map_free)
+		/*
+		 * A sleepable program can still use, and fill, the fields of a value
+		 * that it got before it let go of the owner. As for bpf_selem_unlink(),
+		 * bpf_selem_free_trace_rcu() frees them, and takes smap for that:
+		 * map_free() waits for this RCU read side critical section and then
+		 * for the callback.
+		 */
+		if ((!err && !keep_fields) || in_map_free)
 			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
 	}
 
@@ -434,11 +451,12 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 	 *
 	 * The owner that map_free() takes an selem from is alive: sleepable code, which
 	 * is in no RCU read side critical section, may be walking its list for another
-	 * map.
+	 * map.  And it can still use a value that it got before it let go of an owner
+	 * that destroy() is called for.
 	 */
 	if (unlink == 2 ||
 	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
-		bpf_selem_free(selem, !in_map_free);
+		bpf_selem_free(selem, !in_map_free && !sleepable_users);
 
 	if (free_storage)
 		bpf_local_storage_free(local_storage, !in_map_free);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 5ee8aae7435b..0fa3f2ac0f99 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -110,10 +110,13 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 		return ERR_PTR(-ENOTSUPP);
 
 	inner_map_meta = map->inner_map_meta;
-	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map))
+	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
 		bpf_map_inc(inner_map);
-	else
+		/* Its users are those of the outer maps from now on */
+		WRITE_ONCE(inner_map->was_inner_map, true);
+	} else {
 		inner_map = ERR_PTR(-EINVAL);
+	}
 
 	return inner_map;
 }
-- 
2.55.0

