Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8938E11A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208268; cv=none; b=qHetZg1IIMdH9v5lykQfbpI3uRH98judHE+JX0s/1+/qFNLYdzT/5NorZowvvvFmiGbkkIOk9aYXW9eyxjM907dXt+mSEqeQVTdbhH1Ra7/ZlxBOzl+lkiwEYd6pOleJgOv9bFrB4Sh1IqGxLw7HgE+HmjbXSk5GWbjUJRKpql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208268; c=relaxed/simple;
	bh=nMRPhuGFkFLmIP849hxdJsTzN087jM+7bAJ4YB45i7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ua/EDxyZVH5GbZYiy980WEJVksxsG32DEeGdyS3YhppgrTlUFv4/2PRA5+9DzKuDjjFcAeGGDZH/RbY16tmBtPPMnc4175tCltkFtZV+1+mwdFwFXJXxhADBU2+5X0ksFQo+2y/EXvL6qQSgn8UsNAudbd+d1n4Y1lRrkEI3jfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CjucVWas; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjucVWas"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso5203216a91.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208267; x=1788813067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PJ7fafUlBPjfr1KwszEslsPjbtrF6UKljnaxbzPgF8k=;
        b=CjucVWasTawkrBilHIXye83g67NbSGM5/U4m6dliz7UjX2ERHFLAOyJZCp+1I4t+tn
         eCLL9gNJXsIzBAjMbA0zELboJFf+sFKEb2YuqoRy1Tv74p6QoVJAzdOzg1LyRv7OPUia
         OwIj4/S84auKJJH02KMav9fKSoQR3bfUHfUyKZY9DGiC9sA3048qRU9TpXJ7Xu2ICmLc
         CLZYC8ZxjxADRcQBWfZwrPF69U9ebZPb3OKBgH1gBAjhTqcqu5CEEC74aioXGa5ZAAfs
         ITqpTqSDm6wSAh/hxyl/DGEdAbblSaLojX5gixmfBGiYVwR8lpyxHb6G3s0+cLusqEWj
         bMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208267; x=1788813067;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJ7fafUlBPjfr1KwszEslsPjbtrF6UKljnaxbzPgF8k=;
        b=UjhoJTA/VGRDXzc9Qa0/yR4GREkcnYh0WMP3BcjS0NaFlTiz+6UhnyiBz5Om4hmAa/
         May4rmGXSZVIW9BzJWqHKMHxbJwGoLCJjbHalAXsLrDWn5E89C0ZNQWam6/8fUnLYodY
         NuAF/ddrFwvXrJEX96Z8ohSV3AKZG/EluuPNV4DTEsDsTAXJx7T/T/UMSloscE1Z12q0
         gBMkOeGvtRXwsr9TSZ3PtA8TnKiD3Lzw4t5Dnp85uxSXgDv9VRDw+VcfwBwfDMER5nAA
         3/62371Q1E8/TvtT/IneTKE4VybHj/b3yywKnDYEUH2brJWjrA0b5aQKGsuFXywTIaej
         WgQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqU6+Lqo5VEy21L/2w/qnz1zIETYZ8sRhQBZdY1v/Q0H/ieOv0q3pWderzK6RJGQADnqkPKyM=@vger.kernel.org
X-Gm-Message-State: AFuF++ktkd20sYlguWR32lPLWobZhLGc+JS0UvVBVX5egrxlzuwlFF1Q
	SbHISjYSDWyizU/hec8whFmmds1HxpMJTRcWXQfcf5l/+qkomQLC2gG77zQhU9GtzEPtl8dB8In
	XoRS2Ww==
X-Received: from dlboy1.prod.google.com ([2002:a05:7022:1281:b0:141:5392:d9c1])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d446:b0:398:9be6:f998
 with SMTP id 98e67ed59e1d1-39907e15804mr4310486a91.23.1788208266284; Mon, 31
 Aug 2026 13:31:06 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:30:53 -0700
In-Reply-To: <20260831203056.838265-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831203056.838265-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260831203056.838265-3-surenb@google.com>
Subject: [PATCH v7 2/5] binder: Make shrinker rely solely on per-VMA lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Dave Hansen <dave.hansen@linux.intel.com>

tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
it and mmap_read_trylock().

Long Version:

=3D=3D Background =3D=3D

Historically, binder used an mmap_read_trylock() in its shrinker code.
This ensures that reclaim is not blocked on an mmap_lock. Commit
95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
support for the per-VMA lock, but left mmap_read_trylock() as a
fallback.

This was presumably because the per-VMA locking can fail for several
reasons and most (all?) lock_vma_under_rcu() callers have a fallback
to mmap_read_trylock().

=3D=3D Problem =3D=3D

The fallback is not worth the complexity here. lock_vma_under_rcu() is
essentially already a non-blocking trylock. The main reason it fails
is also the reason mmap_read_trylock() fails: something is holding
mmap_write_lock().

The only remedy for a collision with mmap_write_lock() is to wait,
which this code can not do. So the "fallback" after
lock_vma_under_rcu() failure is not really a fallback: it is really
likely to just be retrying in vain. That retry in an of itself isn't
horrible. But it adds complexity.

=3D=3D Solution =3D=3D

Now that per-VMA locks are universally available, lock_vma_under_rcu()
will not persistently fail. Rely on it alone and simplify the code.
The removal of the fallback does not affect NOMMU case because binder
driver depends on CONFIG_MMU.

While at it we also make the handling of the cases where the original
binder VMA is gone consistent. There are two cases to consider when
Binder VMA is gone:
1. there is no VMA at that location anymore.
2. there is now another unrelated VMA at that location.

Before this change we handle case 1 by having the shrinker proceed to
free the page, and just skip the zap_vma_range() call. And we handle
case 2 by having the shrinker return LRU_SKIP. While either behavior
is acceptable, we need to handle them in a consistent way. Handle both
cases by freeing the page without touching the VMA (skipping the
zap_vma_range()).

Full disclosure: I originally tried to do this with
lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
trylock semantics. Claude caught this in a review and suggested the
approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
I guess.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 46 ++++++++++++++++------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index e4488ad86a65..fcb744088e77 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct list_he=
ad *item,
 	struct vm_area_struct *vma;
 	struct page *page_to_free;
 	unsigned long page_addr;
-	int mm_locked =3D 0;
 	size_t index;
=20
 	if (!mmget_not_zero(mm))
@@ -1151,27 +1150,25 @@ enum lru_status binder_alloc_free_page(struct list_=
head *item,
 	index =3D mdata->page_index;
 	page_addr =3D alloc->vm_start + index * PAGE_SIZE;
=20
-	/* attempt per-vma lock first */
+	/*
+	 * Attempt per-vma lock. This is essentially a
+	 * "trylock". It can fail even if the VMA exists
+	 * for 'page_addr'.
+	 */
 	vma =3D lock_vma_under_rcu(mm, page_addr);
 	if (!vma) {
-		/* fall back to mmap_lock */
-		if (!mmap_read_trylock(mm))
-			goto err_mmap_read_lock_failed;
-		mm_locked =3D 1;
-		vma =3D vma_lookup(mm, page_addr);
+		/*
+		 * If the vma exists, we can't continue because we cannot
+		 * remove the page from the vma. However, if the vma was
+		 * unmapped, it's okay to continue.
+		 */
+		if (binder_alloc_is_mapped(alloc))
+			goto err_vma_lock_failed;
 	}
=20
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;
=20
-	/*
-	 * Since a binder_alloc can only be mapped once, we ensure
-	 * the vma corresponds to this mapping by checking whether
-	 * the binder_alloc is still mapped.
-	 */
-	if (vma && !binder_alloc_is_mapped(alloc))
-		goto err_invalid_vma;
-
 	trace_binder_unmap_kernel_start(alloc, index);
=20
 	page_to_free =3D alloc->pages[index];
@@ -1182,7 +1179,12 @@ enum lru_status binder_alloc_free_page(struct list_h=
ead *item,
 	list_lru_isolate(lru, item);
 	spin_unlock(&lru->lock);
=20
-	if (vma) {
+	/*
+	 * Since a binder_alloc can only be mapped once, we ensure
+	 * the vma corresponds to this mapping by checking whether
+	 * the binder_alloc is still mapped.
+	 */
+	if (vma && binder_alloc_is_mapped(alloc)) {
 		trace_binder_unmap_user_start(alloc, index);
=20
 		zap_vma_range(vma, page_addr, PAGE_SIZE);
@@ -1191,23 +1193,17 @@ enum lru_status binder_alloc_free_page(struct list_=
head *item,
 	}
=20
 	mutex_unlock(&alloc->mutex);
-	if (mm_locked)
-		mmap_read_unlock(mm);
-	else
+	if (vma)
 		vma_end_read(vma);
 	mmput_async(mm);
 	binder_free_page(page_to_free);
=20
 	return LRU_REMOVED_RETRY;
=20
-err_invalid_vma:
-	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
-	if (mm_locked)
-		mmap_read_unlock(mm);
-	else
+	if (vma)
 		vma_end_read(vma);
-err_mmap_read_lock_failed:
+err_vma_lock_failed:
 	mmput_async(mm);
 err_mmget:
 	return LRU_SKIP;
--=20
2.55.0.966.g6673acef38-goog

